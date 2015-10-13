//
//  DWInstructionChildController.m
//  实验助手
//
//  Created by sxq on 15/9/16.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "SXQExpCategory.h"
#import "ArrayDataSource+CollectionView.h"
#import "DWInstructionChildController.h"
#import "SXQInstructionCell.h"
#import "SXQExpSubCategory.h"
#import "SXQColor.h"
#import "InstructionTool.h"
@interface DWInstructionChildController ()
@property (nonatomic,strong) ArrayDataSource *collectionViewDataSource;
@property (nonatomic,strong) NSArray *instructions;
@end

@implementation DWInstructionChildController
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.collectionView.backgroundColor = MenuCellSelectedBgColor;
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}
- (NSArray *)instructions
{
    if (_instructions == nil) {
        _instructions = @[];
    }
    return _instructions;
}
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SXQInstructionCell" bundle:nil] forCellWithReuseIdentifier:@"SXQInstructionCell"];
    _collectionViewDataSource = [[ArrayDataSource alloc] initWithItems:self.instructions cellIdentifier:@"SXQInstructionCell" cellConfigureBlock:^(SXQInstructionCell *cell, SXQExpSubCategory *item) {
        [cell configureCellWithItem:item];
    }];
    self.collectionView.dataSource = _collectionViewDataSource;

}
#pragma mark - MenuController Delegate Method
- (void)menuViewController:(SXQMenuViewController *)vc selectedItem:(SXQExpCategory *)item
{
    [InstructionTool fetchSubCategoryWithCategoryId:item.expCategoryID success:^(ExpSubCategoryResult *result) {
                _instructions = result.data;
                _collectionViewDataSource.items = result.data;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - CollectionView Delegate Method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExpSubCategory *item = _instructions[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(instructionController:SelectedItem:)]) {
        [self.delegate instructionController:self SelectedItem:item];
    }
}

@end
