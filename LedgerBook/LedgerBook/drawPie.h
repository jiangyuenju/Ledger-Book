//
//  drawPie.h
//  LedgerBook
//
//  Created by nju on 16/1/16.
//  Copyright © 2016年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ledger.h"

@interface drawPie : UIView{
    
@private int inArray[9];
@private int outArray[12];
    
@private int sumOut,sumIn;
}
-(void) setChoice:(int) choice;
@property int segChoice;
@property NSMutableArray* ledgerArray;
@end
