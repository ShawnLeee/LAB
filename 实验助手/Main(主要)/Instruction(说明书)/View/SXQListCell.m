//
//  SXQListCell.m
//  实验助手
//
//  Created by sxq on 15/9/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQListCell.h"
#import "SXQExpInstruction.h"
#import "SXQInstructionManager.h"
#import "SXQInstructionManager.h"
@interface SXQListCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *supplierLabel;
@property (weak, nonatomic) IBOutlet UILabel *supplierIDLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (nonatomic,strong) SXQExpInstruction *instruction;
@end
@implementation SXQListCell
- (instancetype)init
{
    if (self = [super init]) {
//        _downloaded = NO;
    }
    return self;
}
- (void)configureCellWithItem:(SXQExpInstruction *)item
{
    _instruction = item;
    _nameLabel.text = item.experimentName;
    _supplierLabel.text = [NSString stringWithFormat:@"厂商:%@",item.supplierName];
    _supplierIDLabel.text  = [NSString stringWithFormat:@"货号:%@",item.supplierID];
    [_downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [_downloadBtn setTitle:@"已下载" forState:UIControlStateDisabled];
    _downloadBtn.enabled = !_instruction.isDownloaded;
    [item addObserver:self forKeyPath:@"downloaded" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    _downloadBtn.enabled = !_instruction.isDownloaded;
}
- (void)dealloc
{
    [_instruction removeObserver:self forKeyPath:@"downloaded"];
}
- (IBAction)download:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(listCell:clickedDownloadBtn:)]) {
        [self.delegate listCell:self clickedDownloadBtn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
