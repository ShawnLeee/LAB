//
//  SXQReagentCountView.m
//  实验助手
//
//  Created by sxq on 15/10/19.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQReagentCountView.h"
#import "SXQExpReagent.h"

#define kPerWidth  (([UIScreen mainScreen].bounds.size.width - 20)/5.0)
#define kItemFont [UIFont systemFontOfSize:15]
@interface SXQReagentCountView ()
@property (nonatomic,weak) UILabel *reagentName;
@property (nonatomic,weak) UILabel *reagentCount;
@property (nonatomic,weak) UITextField *sampleCount;
@property (nonatomic,weak) UITextField *repeatCount;
@property (nonatomic,weak) UILabel *totalCount;
@end
@implementation SXQReagentCountView
- (instancetype)init
{
    if (self = [super init]) {
//        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addCostomViews];
        [self layoutCustomView];
        
    }
    return self;
}
- (void)addCostomViews
{
    UILabel *reagentName = [[UILabel alloc] init];
    reagentName.font = kItemFont;
    reagentName.numberOfLines = 0;
    _reagentName = reagentName;
    [self addSubview:_reagentName];
    
    UILabel *reagentCount = [[UILabel alloc] init];
    reagentCount.font = kItemFont;
    reagentCount.textAlignment = NSTextAlignmentCenter;
    _reagentCount = reagentCount;
    [self addSubview:reagentCount];
    
    UITextField *sampleCount = [[UITextField alloc] init];
    sampleCount.borderStyle = UITextBorderStyleRoundedRect;
    sampleCount.keyboardType = UIKeyboardTypeDecimalPad;
    _sampleCount = sampleCount;
    [self addSubview:sampleCount];
    
    UITextField *repeatCount = [[UITextField alloc] init];
    repeatCount.keyboardType = UIKeyboardTypeDecimalPad;
    repeatCount.borderStyle = UITextBorderStyleRoundedRect;
    _repeatCount = repeatCount;
    [self addSubview:_repeatCount];
    
    UILabel *totalCount = [[UILabel alloc] init];
    totalCount.font = kItemFont;
    totalCount.textAlignment = NSTextAlignmentLeft;
    _totalCount = totalCount;
    [self addSubview:totalCount];
}
- (void)setReagent:(SXQExpReagent *)reagent
{
    _reagent = reagent;
    self.reagentName.text = reagent.reagentName;
    self.reagentCount.text =[NSString stringWithFormat:@"%d",reagent.useAmount];
    [self bindingModel];
}
- (void)bindingModel
{
    RAC(self.reagent,totalCount) = [self userAmountSignal];
    [RACObserve(self.reagent, totalCount)
     subscribeNext:^(NSNumber *amount) {
        self.totalCount.text = [NSString stringWithFormat:@"%@",amount];
    }];
}

- (RACSignal *)userAmountSignal
{
    RACSignal *sampleCountSignal = self.sampleCount.rac_textSignal;
    RACSignal *repeatCountSignal = self.repeatCount.rac_textSignal;
    RACSignal *userAmountSignal = [RACSignal combineLatest:@[sampleCountSignal,repeatCountSignal]
                                   reduce:^id(NSString *sampleCount,NSString *repeatCount){
                                       return @([sampleCount doubleValue] * [repeatCount doubleValue] * _reagent.useAmount);
                                   }];
    return userAmountSignal;
}
- (void)layoutCustomView
{
    self.reagentName.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[self.reagentName.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0]];
    [self addConstraint:[self.reagentName.topAnchor constraintEqualToAnchor:self.topAnchor constant:0]];
    [self addConstraint:[self.reagentName.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0]];
    [self.reagentName addConstraint:[self.reagentName.widthAnchor constraintEqualToAnchor:nil constant:kPerWidth]];
    
    self.reagentCount.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[self.reagentCount.leadingAnchor constraintEqualToAnchor:self.reagentName.trailingAnchor constant:0]];
    [self addConstraint:[self.reagentCount.topAnchor constraintEqualToAnchor:self.topAnchor constant:0]];
    [self addConstraint:[self.reagentCount.lastBaselineAnchor constraintEqualToAnchor:self.reagentName.lastBaselineAnchor constant:0]];
    [self.reagentCount addConstraint:[self.reagentCount.widthAnchor constraintEqualToAnchor:nil constant:kPerWidth]];

    self.sampleCount.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[self.sampleCount.leadingAnchor constraintEqualToAnchor:self.reagentCount.trailingAnchor constant:0]];
//    [self addConstraint:[self.sampleCount.topAnchor constraintEqualToAnchor:self.topAnchor constant:0]];
    [self addConstraint:[self.sampleCount.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0]];
    [self.sampleCount addConstraint:[self.sampleCount.widthAnchor constraintEqualToAnchor:nil constant:kPerWidth - 10]];

    self.repeatCount.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[self.repeatCount.leadingAnchor constraintEqualToAnchor:self.sampleCount.trailingAnchor constant:10]];
//    [self addConstraint:[self.repeatCount.topAnchor constraintEqualToAnchor:self.topAnchor constant:0]];
    [self addConstraint:[self.repeatCount.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0]];
    [self.repeatCount addConstraint:[self.repeatCount.widthAnchor constraintEqualToAnchor:nil constant:kPerWidth - 10]];
    
    self.totalCount.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[self.totalCount.leadingAnchor constraintEqualToAnchor:self.repeatCount.trailingAnchor constant:10]];
    [self addConstraint:[self.totalCount.topAnchor constraintEqualToAnchor:self.topAnchor constant:0]];
    [self addConstraint:[self.totalCount.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0]];
    [self.totalCount addConstraint:[self.totalCount.widthAnchor constraintEqualToAnchor:nil constant:kPerWidth]];
    
    [self layoutIfNeeded];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
  
}
@end
