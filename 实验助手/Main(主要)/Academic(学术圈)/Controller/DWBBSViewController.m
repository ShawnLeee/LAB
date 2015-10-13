//
//  DWBBSViewController.m
//  DWContainerViewController
//
//  Created by sxq on 15/9/17.
//  Copyright (c) 2015年 sxq. All rights reserved.
//

#import "DWBBSViewController.h"

@interface DWBBSViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation DWBBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
