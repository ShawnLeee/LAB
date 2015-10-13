//
//  SXQVenderView.m
//  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQVenderView.h"
@interface SXQVenderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation SXQVenderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[NSBundle mainBundle] loadNibNamed:@"SXQVenderView" owner:self options:nil];
        self.view.frame = self.view.bounds;
        [self addSubview:self.view];
    }
    return self;
}
- (void)awakeFromNib
{
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
}
- (void)setupViewWithImage:(NSString *)image title:(NSString *)title delegate:(id<SXQVenderViewDelegate>)delegate tag:(NSUInteger)tag
{
    [_iconImageView setImage:[UIImage imageNamed:image]];
    _titleLabel.text = title;
    _delegate = delegate;
    self.tag = tag;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(clickedVenderView:)]) {
        [self.delegate clickedVenderView:self];
    }
}
@end
