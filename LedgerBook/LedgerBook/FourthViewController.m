//
//  FourthViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image4 = [[UIImage imageNamed:@"image4.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image4_2 = [[UIImage imageNamed:@"image4_2.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    (void)[self.FourthItem initWithTitle:@"扫一扫" image:image4 selectedImage:image4_2];
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
