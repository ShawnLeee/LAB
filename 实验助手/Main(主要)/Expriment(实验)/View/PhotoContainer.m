//
//  PhotoContainer.m
//  Photo
//
//  Created by SXQ on 15/10/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10
#import "PhotoContainer.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define photoW (([UIScreen mainScreen].bounds.size.width - 2 * 8 - 2 *IWPhotoMargin)/3)
static NSUInteger CountOfImageView = 9;
static CGFloat kPadding = 10;
static NSUInteger numberOfColumns = 3;
@interface PhotoContainer ()
@property (nonatomic,strong) NSMutableArray *imageViews;
@property (nonatomic,assign) CGFloat imageWidth;
@end
@implementation PhotoContainer
@synthesize myImages = _myImages;
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setupSelf];
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self setupSelf];
    }
    return self;
}
- (NSMutableArray *)myImages
{
    if (_myImages == nil) {
        _myImages = [NSMutableArray array];
    }
    return _myImages;
}
- (void)setupSelf
{
    self.backgroundColor = [UIColor whiteColor];
        _imageViews = [@[] mutableCopy];
    CGRect rect = [UIScreen mainScreen].bounds;
        _imageWidth = ([UIScreen mainScreen].bounds.size.width - (numberOfColumns + 1) * kPadding)/(CGFloat)numberOfColumns;
        //创建9个imageview
        for (int i = 0; i < CountOfImageView; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)]];
            [_imageViews addObject:imageView];
            [self addSubview:imageView];
        }
}
- (void)photoTapped:(UITapGestureRecognizer *)tapGesture
{
    NSUInteger count = _myImages.count;
    // 1.封装图片数据
    NSMutableArray *mymyImages = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
//        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        mjphoto.image = _myImages[i];
        mjphoto.srcImageView = self.imageViews[i]; // 来源于哪个UIImageView

        [mymyImages addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tapGesture.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = mymyImages; // 设置所有的图片
    [browser show];
}

- (void)setMyImages:(NSMutableArray *)myImages
{
    _myImages = myImages;
    for (int i = 0; i < self.imageViews.count; i++) {
        UIImageView *imageView = self.imageViews[i];
        if (i < myImages.count) {
            imageView.hidden = NO;
            imageView.image = myImages[i];
            
            // 设置子控件的frame
            int maxColumns = (myImages.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (photoW + IWPhotoMargin);
            CGFloat photoY = row * (photoW + IWPhotoMargin);
            imageView.frame = CGRectMake(photoX, photoY, photoW, photoW);
            
            if (myImages.count == 1) {
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.clipsToBounds = NO;
            } else {
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds = YES;
            }
        }else
        {
            imageView.hidden = YES;
        }
        
    }
}
+ (CGSize)photosViewSizeWithPhotosCount:(NSUInteger)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * photoW + (rows - 1) * IWPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * photoW + (cols - 1) * IWPhotoMargin;
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * 8, photosH);
    
}
@end









