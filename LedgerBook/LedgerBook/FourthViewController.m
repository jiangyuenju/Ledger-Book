//
//  FourthViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@property Boolean jump;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jump=NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    if(self.jump){
        UITabBarController *tab=(UITabBarController*)self.tabBarController;
        tab.selectedIndex=1;
        
        self.jump=NO;
    }
}

- (void) setJumpToAddItemVC {
    self.jump=YES;
}
@end
