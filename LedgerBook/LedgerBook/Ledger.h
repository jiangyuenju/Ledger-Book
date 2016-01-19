//
//  Ledger.h
//  LedgerBook
//
//  Created by nju on 15/12/9.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ledger : NSObject <NSCoding>

@property NSString *ledgerType;
@property NSNumber* balance;
@property NSString* inOrOut;
@property NSString *PS;
@property NSString *date;

@end
