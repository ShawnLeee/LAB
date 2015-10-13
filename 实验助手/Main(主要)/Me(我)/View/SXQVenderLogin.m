//
//  SXQVenderLogin.m
//  实验助手
//
//  Created by sxq on 15/9/10.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQVenderLogin.h"
#import "SXQVenderView.h"
@interface SXQVenderLogin ()<SXQVenderViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1Const;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2Const;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3Const;
@property (weak, nonatomic) IBOutlet SXQVenderView *view1;
@property (weak, nonatomic) IBOutlet SXQVenderView *view2;
@property (weak, nonatomic) IBOutlet SXQVenderView *view3;
@end
@implementation SXQVenderLogin
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self setup];
        [self setupView];
    }
    return self;
}
- (void)awakeFromNib
{
        self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
}
- (void)setupView
{
    [_view1 setupViewWithImage:@"ZHProfileViewSinaWeiboIcon" title:@"微博" delegate:self tag:0];
    [_view2 setupViewWithImage:@"ZHProfileViewSinaWeiboIcon" title:@"微信" delegate:self tag:1];
    [_view3 setupViewWithImage:@"Night_ZHProfileListCellQQ_iOS7" title:@"QQ" delegate:self tag:2];
}
- (void)setup
{
    [[NSBundle mainBundle] loadNibNamed:@"SXQVenderLogin" owner:self options:nil];
    self.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.view];
}

- (void)updateMyConstraints
{
    CGFloat width =  _widthConstraint.constant;
    NSArray *constArr = @[_view1Const,_view2Const,_view3Const];
    CGFloat padding = (self.view.bounds.size.width - constArr.count * width) / (constArr.count + 1);
    [constArr enumerateObjectsUsingBlock:^(NSLayoutConstraint *con, NSUInteger idx, BOOL *stop) {
        con.constant = padding;
    }];
    [self layoutIfNeeded];
}
#pragma mark - SXQVenderView delegate
- (void)clickedVenderView:(SXQVenderView *)view
{
    if ([self.delegate respondsToSelector:@selector(venderLogin:clickedButtonAtIndex:)]) {
        [self.delegate venderLogin:self clickedButtonAtIndex:view.tag];
    }
}

@end
