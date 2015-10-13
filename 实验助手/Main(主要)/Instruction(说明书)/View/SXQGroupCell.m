//
//  SXQGroupCell.m
//  实验助手
//
//  Created by SXQ on 15/8/30.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQGroupCell.h"
#import "SXQInstrutionCell.h"
#import "ArrayDataSource+CollectionView.h"

static NSString *CollectionViewIdentier = @"Instrution Cell";

@interface SXQGroupCell ()<UICollectionViewDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) ArrayDataSource *collectionViewDataSource;
@end
@implementation SXQGroupCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.itemSize = CGSizeMake(80, 120);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
        self.collectionView.delegate = self;
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"SXQInstrutionCell" bundle:nil] forCellWithReuseIdentifier:CollectionViewIdentier];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
}
- (void)setItems:(NSArray *)items
{
    _items = items;
    self.collectionViewDataSource = [[ArrayDataSource alloc] initWithItems:items cellIdentifier:CollectionViewIdentier cellConfigureBlock:^(SXQInstrutionCell *cell,id item) {
        cell.instructionTitle.text = item;
    }];
    
    self.collectionView.dataSource = self.collectionViewDataSource;
}
#pragma mark - collectionView delegate method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(groupCell:selectedItem:)]) {
        [self.delegate groupCell:self selectedItem:self.items[indexPath.row]];
    }
}
@end
