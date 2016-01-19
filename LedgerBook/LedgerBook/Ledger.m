//
//  Ledger.m
//  LedgerBook
//
//  Created by nju on 15/12/9.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "Ledger.h"

@implementation Ledger

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.ledgerType forKey:@"ledgerType"];
    [aCoder encodeObject:self.balance forKey:@"balance"];
    [aCoder encodeObject:self.inOrOut forKey:@"inOrOut"];
    [aCoder encodeObject:self.PS forKey:@"PS"];
    [aCoder encodeObject:self.date forKey:@"date"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.ledgerType=[aDecoder decodeObjectForKey:@"ledgerType"];
        self.balance=[aDecoder decodeObjectForKey:@"balance"];
        self.inOrOut=[aDecoder decodeObjectForKey:@"inOrOut"];
        self.PS=[aDecoder decodeObjectForKey:@"PS"];
        self.date=[aDecoder decodeObjectForKey:@"date"];
    }
    return self;
}

@end
