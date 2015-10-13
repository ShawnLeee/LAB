// //  PhotoContainer.h
//  Photo
//
//  Created by SXQ on 15/10/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface PhotoContainer : UIView
@property (nonatomic,strong) NSMutableArray *myImages;
- (CGFloat)heightOfPhotoContainer;
- (void)addPhoto:(UIImage *)image updatesConstraintBlk:(void (^)(BOOL success,CGFloat photoHeight))completion;
@end

