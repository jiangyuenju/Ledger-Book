//
//  SecondViewController.h
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ledger.h"

@interface AddItemViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property Ledger* ledger;
@property NSString *detail;
@property NSString *money;
@property Boolean jump;

@end

