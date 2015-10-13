//
//  SXQInstructionHeader.m
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQInstructionHeader.h"

#pragma mark - groupLabel's width and height
static CGFloat groupLabelWidth = 80;
static CGFloat groupLabelheight = 21;
#pragma mark - moreLabel's wight and height
static CGFloat moreLabelWidth = 80;
static CGFloat moreLabelheight = 21;
#pragma mark - accessoryView's width and height
static CGFloat accessoryWidth = 21;
static CGFloat accessoryHeight = 22.7;

@interface SXQInstructionHeader ()
@property (nonatomic,weak) UILabel *groupLabel;
@property (nonatomic,weak) UILabel *moreLabel;
@end
@implementation SXQInstructionHeader
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundTextures"]];
        self.backgroundView = backgroundView;
        [self p_addCustomViews];
    }
    return  self;
}
- (void)setGroupTitle:(NSString *)groupTitle
{
    _groupLabel.text = groupTitle;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(didSelectedInstructionHeader:)]) {
        [_delegate didSelectedInstructionHeader:self];
    }
}
#pragma mark - Public Method

#pragma mark - Private Method
- (void)p_addCustomViews
{
    UILabel *groupLabel = [UILabel new];
    
    groupLabel.font = [UIFont systemFontOfSize:16];
    groupLabel.textAlignment = NSTextAlignmentLeft;
    groupLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:groupLabel];
    _groupLabel = groupLabel;
    
    UILabel *moreLabel = [UILabel new];
    
    moreLabel.text = @"查看更多";
    moreLabel.font = [UIFont systemFontOfSize:14];
    moreLabel.textAlignment = NSTextAlignmentRight;
    moreLabel.textColor = [UIColor lightGrayColor];
    
    moreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:moreLabel];
    _moreLabel = moreLabel;
    
    UIImage *accessImage = [UIImage imageNamed:@"chevron-icon-black"];
    UIImageView *accessoryView = [[UIImageView alloc] initWithImage:accessImage];
    accessoryView.contentMode = UIViewContentModeCenter;
    accessoryView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:accessoryView];
    
    //Layout this two labels
    //groupLabel's X position
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_groupLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10]];
    
    //groupLabel's Y position
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_groupLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    //groupLabel's width
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_groupLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:groupLabelWidth]];
    
    //groupLabel's height
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_groupLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:groupLabelheight]];
    
    //moreLabel's X position
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:accessoryView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    
    //moreLabel's Y position
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    //moreLabel's width
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:moreLabelWidth]];
    //moreLabel's height
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:moreLabelheight]];
    
    //accessoryView's X
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:accessoryView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    //accessoryView's Y
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:accessoryView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    //accessoryView's width
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:accessoryView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:accessoryWidth]];
    //accessoryView's height
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:accessoryView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:accessoryHeight]];
}

@end
