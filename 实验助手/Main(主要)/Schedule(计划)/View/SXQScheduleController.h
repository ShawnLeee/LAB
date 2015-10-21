//
//  SXQScheduleController.h
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "NSDate+FSExtension.h"
@interface SXQScheduleController : UIViewController <FSCalendarDataSource,FSCalendarDelegate>
@property (weak, nonatomic) FSCalendar *calendar;
@end
