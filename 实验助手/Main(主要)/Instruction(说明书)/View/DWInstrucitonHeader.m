//
//  DWInstrucitonHeader.m
//  实验助手
//
//  Created by sxq on 15/9/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpInstruction.h"
#import "DWInstrucitonHeader.h"
@interface DWInstrucitonHeader ()
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *supplierLabel;
@property (weak, nonatomic) IBOutlet UILabel *supplierIDLabel;
@end
@implementation DWInstrucitonHeader
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupSelf];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSelf];
    }
    return self;
}
- (void)setupSelf
{
    [[NSBundle mainBundle] loadNibNamed:@"DWInstrucitonHeader" owner:self options:nil];
    _view.frame = self.bounds;
    [self addSubview:_view];
}
- (void)configureHeaderWithInstruction:(SXQExpInstruction *)instruction
{
    _instructionLabel.text = instruction.experimentName;
    _supplierLabel.text = instruction.supplierName;
    _supplierIDLabel.text = instruction.supplierID;
}
@end
