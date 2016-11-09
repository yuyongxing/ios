
//
//  CCCustomAlertView.m
//  testProject
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 淵 Zhuge. All rights reserved.
//

#import "CCCustomAlertView.h"
#import "FXBlurView.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"

@interface CCCustomAlertView ()
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) UIButton *sureBtn;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *cancel;
@property (nonatomic, copy) NSString *sure;
@property (nonatomic, copy) BOOL(^touchBlock)();
@property (nonatomic, copy) BOOL(^cancelBlock)();
@property (nonatomic, weak) UIView *btnLine;
@property (nonatomic, weak) UILabel *tipL;
@end

@implementation CCCustomAlertView

- (instancetype)initWithTitle:(NSString *)title contentText:(NSString *)content cancel:(NSString *)cancel sure:(NSString *)sure {
    if (self = [super init]) {
        _title = title;
        _content = content;
        _cancel = cancel;
        _sure = sure;
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    _blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _blurView.tintColor = [UIColor clearColor];
    
    
    UILabel *tip = [[UILabel alloc] init];
    [self.contentView addSubview:tip];
    _tipL = tip;
    tip.text = self.title;
    tip.textAlignment = NSTextAlignmentCenter;
    tip.font = [UIFont systemFontOfSize:SCREEN_WIDTH > 320 ? 16 : 15];
    tip.textColor = [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.content.length ? self.content : @""];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[[UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f] colorWithAlphaComponent:0.8] range:NSMakeRange(0, attributedText.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SCREEN_WIDTH > 320 ? 15 : 14] range:NSMakeRange(0, attributedText.length)];
    contentLabel.attributedText = attributedText;
    
    [self.contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.textColor = [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f];
    contentLabel.numberOfLines = 0;
    
    UIButton *cancel = [[UIButton alloc] init];
    [cancel setTitle:self.cancel.length ? self.cancel : @"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancel addTarget:self action:@selector(cancelTouch) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f] forState:UIControlStateNormal];
    [cancel setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]] forState:UIControlStateNormal];
    [cancel setBackgroundImage:[UIImage imageWithColor:[[UIColor lightTextColor] colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
    
    [self.contentView addSubview:cancel];
    _cancelBtn = cancel;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(234,237,240);
    [self.contentView addSubview:line];
    _line = line;
    
    UIButton *sure = [[UIButton alloc] init];
    [ sure setTitle:self.sure.length ? self.sure : @"确定" forState:UIControlStateNormal];
    sure.titleLabel.font = [UIFont systemFontOfSize:15];
    [sure addTarget:self action:@selector(sureTouch) forControlEvents:UIControlEventTouchUpInside];
    [sure setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sure setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]] forState:UIControlStateNormal];
    [sure setBackgroundImage:[UIImage imageWithColor:[[UIColor lightTextColor] colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
    
    [self.contentView addSubview:sure];
    _sureBtn = sure;
    
    UIView *btnLine = [[UIView alloc] init];
    [self.contentView addSubview:btnLine];
    _btnLine = btnLine;
    btnLine.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:_contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.7, 150)];
    
    self.tipL.frame = CGRectMake(0, 20, self.contentView.width, 13);
    
    NSAttributedString *string = self.contentLabel.attributedText;
    CGFloat labelH = [string boundingRectWithSize:CGSizeMake(self.contentView.width - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 3;
    
    self.contentLabel.frame = CGRectMake(20, self.tipL.bottom + 25, self.contentView.width - 40, labelH);
    
    self.line.frame = CGRectMake(0, self.contentLabel.bottom + 25, self.contentView.width, 0.5);
    if (self.cancel.length == 0 && self.sure.length != 0) {
        
        self.sureBtn.frame = CGRectMake(0, self.line.bottom, self.contentView.width , 50);
        [self.cancelBtn removeFromSuperview];
        [self.btnLine removeFromSuperview];
    } else if (self.cancel.length != 0 && self.sure.length == 0) {
        
        self.cancelBtn.frame = CGRectMake(0, self.line.bottom, self.contentView.width, 50);
        [self.sureBtn removeFromSuperview];
        [self.btnLine removeFromSuperview];
        
    } else if (self.cancel.length != 0 && self.sure.length != 0) {
        
        
        self.cancelBtn.frame = CGRectMake(0, self.line.bottom, self.contentView.width / 2.0f, 50);
        self.btnLine.frame = CGRectMake(self.cancelBtn.right, self.line.bottom + 10, 1 / [UIScreen mainScreen].scale, 30);
        self.sureBtn.frame = CGRectMake(self.cancelBtn.right, self.line.bottom, self.contentView.width /2.0f, 50);
    }
    self.contentView.height = (self.line.bottom + 50);
    self.contentView.center = self.center;
}

// 取消
- (void)cancelTouch {
    if (!self.cancelBlock) {
        [self removeFromSuperview];
        [_blurView clearImage];
        [_blurView removeFromSuperview];
    } else {
        [_blurView clearImage];
        [_blurView removeFromSuperview];
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    
}

// 确定
- (void)sureTouch {
    if (self.touchBlock) {
        [self removeFromSuperview];
        [_blurView clearImage];
        [_blurView removeFromSuperview];
        if (self.touchBlock) {
            self.touchBlock();
        }
    } else {
        [self removeFromSuperview];
        [_blurView clearImage];
        [_blurView removeFromSuperview];
    }
}

- (void)setupCancelBlock:(BOOL (^)())cancelBlock {
    _cancelBlock = cancelBlock;
}

- (void)setupSureBlock:(BOOL (^)())touchBlock {
    _touchBlock = touchBlock;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        _contentView = contentView;
        contentView.layer.cornerRadius = 4.0f;
        contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (void)showInView:(UIView *)view {
    
    UIView *content = view ? view  : [UIApplication sharedApplication].keyWindow;
    _blurView.blurRadius = 0;
    self.frame = content.bounds;
    //循序不能反了
    [content addSubview:_blurView];
    [content addSubview:self];
    
    //    [NHAnimationManager addTransformAnimationForView:self.contentView];
    [self performPresentationAnimation];
    [UIView animateWithDuration:0.35 animations:^{
        _blurView.blurRadius = 12.0f;
    } completion:^(BOOL finished) {
        _blurView.dynamic = NO;
        [FXBlurView setUpdatesDisabled];
    }];
}

- (void)performPresentationAnimation{
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.3;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.8],
                              [NSNumber numberWithFloat:1.05],
                              [NSNumber numberWithFloat:0.98],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    
    [self.contentView.layer addAnimation:bounceAnimation forKey:@"transform.scale"];

}

@end
