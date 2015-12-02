//
//  ThirdViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image3 = [[UIImage imageNamed:@"image3.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image3_2 = [[UIImage imageNamed:@"image3_2.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    (void)[self.ThirdItem initWithTitle:@"报表" image:image3 selectedImage:image3_2];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
