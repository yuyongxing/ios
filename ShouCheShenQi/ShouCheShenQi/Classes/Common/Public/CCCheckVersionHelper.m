//
//  CCCheckVersionHelper.m
//  ShouCheShenQi
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "CCCheckVersionHelper.h"
#import "CCCustomAlertView.h"

static NSString *_trackViewUrl;

@implementation CCCheckVersionHelper

#pragma mark - Initialization

+(CCCheckVersionHelper *)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


-(void)checkVersion{
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", APPKey];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:storeURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if ([data length] > 0 && !error) { // Success
                                                    [self parseResults:data];
                                                }
                                            }];
    [task resume];
}

- (void)parseResults:(NSData *)data {
    NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // All versions that have been uploaded to the AppStore
        NSArray *versionsInAppStore = [appData valueForKey:@"results"];
        
        if (versionsInAppStore.count==0) {
            return ;
        }
        
        
        NSDictionary *infoDic = [versionsInAppStore objectAtIndex:0];
        NSString* currentVersion = [infoDic objectForKey:@"version"];
        _trackViewUrl = [infoDic objectForKey:@"trackViewUrl"];
        //        trackName = [infoDic objectForKey:@"trackName"];
        NSString *releaseNotes = [infoDic objectForKey:@"releaseNotes"];
        
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *latestVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
        
        // Check what version the update is, major, minor or a patch
        NSArray *latestVersionComponents = [latestVersion componentsSeparatedByString:@"."];
        NSArray *currentVersionComponents = [currentVersion componentsSeparatedByString: @"."];
        
        BOOL oldVersionComponentIsProperFormat = (2 <= [latestVersionComponents count] && [latestVersionComponents count] <= 4);
        BOOL newVersionComponentIsProperFormat = (2 <= [currentVersionComponents count] && [currentVersionComponents count] <= 4);
        
        if (oldVersionComponentIsProperFormat && newVersionComponentIsProperFormat) {
            if ([currentVersionComponents[0] integerValue] > [latestVersionComponents[0] integerValue]) {
                // A.b.c.d
                [self showAlertWithVersion:currentVersion Notes:releaseNotes];
            } else if ([currentVersionComponents[1] integerValue] > [latestVersionComponents[1] integerValue]) {
                // a.B.c.d
                [self showAlertWithVersion:currentVersion Notes:releaseNotes];
            } else if ((currentVersionComponents.count > 2) && (latestVersionComponents.count <= 2 || ([currentVersionComponents[2] integerValue] > [latestVersionComponents[2] integerValue]))) {
                // a.b.C.d
                [self showAlertWithVersion:currentVersion Notes:releaseNotes];
            } else if ((currentVersionComponents.count > 3) && (latestVersionComponents.count <= 3 || ([currentVersionComponents[3] integerValue] > [latestVersionComponents[3] integerValue]))) {
                // a.b.c.D
                [self showAlertWithVersion:currentVersion Notes:releaseNotes];
            }
        }
    });
}

-(void)showAlertWithVersion:(NSString *)version Notes:(NSString *)notes{
    CCCustomAlertView *alert = [[CCCustomAlertView alloc]initWithTitle:@"更新提示" contentText:[NSString stringWithFormat:@"发现新版本v%@, 更新内容：\n%@",version,notes] cancel:nil sure:@"确定"];
    [alert showInView:nil];
    
    [alert setupSureBlock:^BOOL{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_trackViewUrl]];
        return YES;
    }];
}


@end
