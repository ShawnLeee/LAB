//
//  DWSignUpController.h
//  实验助手
//
//  Created by sxq on 15/10/20.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWSignUpController : UITableViewController
@property (nonatomic,weak) IBOutlet UITextField *userName;
@property (nonatomic,weak) IBOutlet UITextField *email;
@property (nonatomic,weak) IBOutlet UITextField *password;
@property (nonatomic,weak) IBOutlet UITextField *repassword;

@property (nonatomic,weak) IBOutlet UIButton *locaiton;
@property (nonatomic,weak) IBOutlet UIButton *school;
@property (nonatomic,weak) IBOutlet UITextField *labratory;
@property (nonatomic,weak) IBOutlet UIButton *profession;
@property (nonatomic,weak) IBOutlet UIButton *degree;
@property (nonatomic,weak) IBOutlet UIButton *identity;
@property (nonatomic,weak) IBOutlet UITextField *telPhone;

@property (nonatomic,weak) UIButton *confirmBtn;
@end
