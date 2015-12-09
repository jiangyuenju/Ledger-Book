//
//  FirstViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "FirstViewController.h"
#import "KxMenu.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickAdd{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"截图"
                     image:nil
                    target:self
                    action:@selector(screenShot)],
      
      [KxMenuItem menuItem:@"分享"
                     image:nil
                    target:self
                    action:@selector(screenShot)],
      
      ];
    
    [KxMenu showMenuInView:self.view
                  fromRect:self.myButton.frame
                 menuItems:menuItems];
}

- (void)screenShot{
    UIGraphicsBeginImageContext(self.view.bounds.size);     //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
}

@end
