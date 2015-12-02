//
//  FirstViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image1 = [[UIImage imageNamed:@"image1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image1_2 = [[UIImage imageNamed:@"image1_2.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    (void)[self.FirstItem initWithTitle:@"明细" image:image1 selectedImage:image1_2];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
