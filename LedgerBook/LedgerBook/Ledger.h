//
//  Ledger.h
//  LedgerBook
//
//  Created by nju on 15/12/9.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ledger : NSObject

@property NSString *ledgerType;
@property float balance;
@property bool isOutcome;
@property NSString *PS;

@end
