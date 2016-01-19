//
//  FirstViewController.h
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ledger.h"

@interface FirstViewController : UIViewController<UIScrollViewDelegate>

@property UIButton *myButton;
@property NSMutableArray* ledgerArray;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;


-(IBAction)clickAdd;
-(void) addReturn;
@end

