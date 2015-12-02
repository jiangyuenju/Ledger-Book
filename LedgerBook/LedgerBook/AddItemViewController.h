//
//  SecondViewController.h
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddItemViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITabBarItem *SecondItem;

@end

