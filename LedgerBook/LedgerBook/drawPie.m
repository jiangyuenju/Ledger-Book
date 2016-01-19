//
//  drawPie.m
//  LedgerBook
//
//  Created by nju on 16/1/16.
//  Copyright © 2016年 nju. All rights reserved.
//

#import "drawPie.h"
#define PI 3.14159265358979323846
@implementation drawPie

-(void) setChoice:(int) choice{
    self.segChoice = choice;
}

-(float) radians:(double) degrees{
    return degrees * PI * 2;
}

void drawArc(CGContextRef ctx, CGPoint point, float angle_start, float angle_end, UIColor* color) {
    CGContextMoveToPoint(ctx, point.x-32, point.y-100);
    CGContextSetFillColor(ctx, CGColorGetComponents( [color CGColor]));
    CGContextAddArc(ctx, point.x-32, point.y-100, 100,  angle_start, angle_end, 0);
    //CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

-(void)drawRect:(CGRect)rect{
    NSArray *array = [[NSArray alloc] initWithObjects:[NSArray arrayWithObjects:@"255",@"255",@"153",nil],[NSArray arrayWithObjects:@"255",@"204",@"204",nil],[NSArray arrayWithObjects:@"255",@"204",@"102",nil],[NSArray arrayWithObjects:@"255",@"153",@"204",nil],[NSArray arrayWithObjects:@"255",@"153",@"102",nil],[NSArray arrayWithObjects:@"204",@"255",@"255",nil],[NSArray arrayWithObjects:@"102",@"153",@"255",nil],[NSArray arrayWithObjects:@"204",@"255",@"153",nil],[NSArray arrayWithObjects:@"104",@"204",@"153",nil],[NSArray arrayWithObjects:@"204",@"204",@"255",nil],[NSArray arrayWithObjects:@"204",@"102",@"255",nil],[NSArray arrayWithObjects:@"204",@"204",@"204",nil],nil];

    //NSLog(@"%@",[[array objectAtIndex:1] objectAtIndex:2]);
    //rect=CGRectMake(50, 100, 200, 200);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //CGContextClearRect(ctx, rect);
    self.backgroundColor=[UIColor whiteColor];
    for(int i=0;i<9;i++) inArray[i]=0;
    for(int i=0;i<12;i++) outArray[i]=0;
    float angle_start=0.0;
    float angle_end=0.0;
    //if(self.ledgerArray == nil){
        sumOut=0;sumIn=0;
        NSData* data=(NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"allLedgers"];
        if(data!=nil){
            self.ledgerArray=(NSMutableArray*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            if(self.ledgerArray !=nil){
                for(Ledger *obj in self.ledgerArray){
                    if([obj.inOrOut isEqual:@"支出"]){
                        if([obj.ledgerType isEqual:@"餐饮"]){
                            outArray[0]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"交通"]){
                            outArray[1]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"居家"]){
                            outArray[2]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"手机通讯"]){
                            outArray[3]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"娱乐"]){
                            outArray[4]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"书籍"]){
                            outArray[5]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"借出"]){
                            outArray[6]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"人情礼物"]){
                            outArray[7]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"医疗"]){
                            outArray[8]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"教育"]){
                            outArray[9]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"美容运动"]){
                            outArray[10]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"其他"]){
                            outArray[11]+=obj.balance.intValue;
                            sumOut+=obj.balance.intValue;}
                    }
                    else if([obj.inOrOut isEqual:@"收入"]){
                        if([obj.ledgerType isEqual:@"工资"]){
                            inArray[0]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"奖金"]){
                            inArray[1]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"外快兼职"]){
                            inArray[2]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"借入"]){
                            inArray[3]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"投资收入"]){
                            inArray[4]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"红包"]){
                            inArray[5]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"零花钱"]){
                            inArray[6]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"生活费"]){
                            inArray[7]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                        else if([obj.ledgerType isEqual:@"其他"]){
                            inArray[8]+=obj.balance.intValue;
                            sumIn+=obj.balance.intValue;}
                    }
                }
            }
        }
    //}
        if(self.segChoice==0){
            if(sumIn!=0){
                for (int i=0; i<9; i++) {
                    if(inArray[i]!=0){
                    angle_start = angle_end;
                    angle_end += [self radians:(double)inArray[i]/sumIn];
                    drawArc(ctx, self.center, angle_start, angle_end, [UIColor colorWithRed:[[[array objectAtIndex:i] objectAtIndex:0] floatValue]/255  green:[[[array objectAtIndex:i] objectAtIndex:1] floatValue]/255 blue:[[[array objectAtIndex:i] objectAtIndex:2] floatValue]/255 alpha:1]);

                    }
                }
            }}
        else if(self.segChoice==1){
            if(sumOut!=0){
                for (int i=0; i<12; i++) {
                    if(outArray[i]!=0){
                    angle_start = angle_end;
                    angle_end += [self radians:(double)outArray[i]/sumOut];
                    drawArc(ctx, self.center, angle_start, angle_end, [UIColor colorWithRed:[[[array objectAtIndex:i] objectAtIndex:0] floatValue]/255  green:[[[array objectAtIndex:i] objectAtIndex:1] floatValue]/255 blue:[[[array objectAtIndex:i] objectAtIndex:2] floatValue]/255 alpha:1]);
                    }
                }
            }
        }
}

@end

