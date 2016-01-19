//
//  ScanerView.m
//  SuperScanner
//
//  Created by Jeans Huang on 10/19/15.
//  Copyright © 2015 gzhu. All rights reserved.
//

#import "ScanerView.h"

@interface ScanerView()

//! 扫描条
@property (nonatomic, strong) UIImageView *qrLine;

//! 扫描区域
@property (nonatomic, assign, readwrite) CGRect scanAreaRect;

@end

@implementation ScanerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder])
        [self customInit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
        [self customInit];
    return self;
}

- (void)customInit{
    self.backgroundColor = [UIColor clearColor];
}

- (CGRect)scanAreaRect{
    //居中
    _scanAreaRect = CGRectMake(CGRectGetWidth(self.frame) / 2 - self.scanAreaEdgeLength / 2,
                               CGRectGetHeight(self.frame) / 2 - self.scanAreaEdgeLength / 2,
                               self.scanAreaEdgeLength,
                               self.scanAreaEdgeLength);
    return _scanAreaRect;
}

- (void)startMoveLine{
    if (self.qrLine)
        [self.qrLine removeFromSuperview];
    self.qrLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ff_QRCodeScanLine"]];
    self.qrLine.frame = CGRectMake(0,
                                   0,
                                   CGRectGetWidth(self.frame),
                                   12.0f);
    [self addSubview:self.qrLine];
    
    //扫描条动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.fromValue = @(self.scanAreaRect.origin.y);
    animation.toValue = @(self.scanAreaRect.origin.y + self.scanAreaRect.size.height - 12);
    animation.repeatCount = NSIntegerMax;
    animation.autoreverses = YES;//动画是否倒回移动
    animation.duration = 1;
    [self.qrLine.layer addAnimation:animation forKey:nil];
}

#pragma mark - 绘制边框
- (void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //绘制扫描背景
    [self addScreenFillRect:ctx rect:self.bounds];
    
    //绘制扫描区域
    [self addCenterClearRect:ctx rect:self.scanAreaRect];
    
    //绘制边
    [self addWhiteRect:ctx rect:self.scanAreaRect];
    
    //绘制角
    [self addCornerLineWithContext:ctx rect:self.scanAreaRect];
    
    [self startMoveLine];
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextSetRGBFillColor(ctx, 40 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
}

- (void)addCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    
    //画四个边角
    CGContextSetLineWidth(ctx, 2);
    //边角颜色
    CGContextSetRGBStrokeColor(ctx, 1 /255.0, 255/255.0, 1/255.0, 1);
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.7, rect.origin.y),
        CGPointMake(rect.origin.x+0.7 , rect.origin.y + 15)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.7),CGPointMake(rect.origin.x + 15, rect.origin.y+0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.7) ,CGPointMake(rect.origin.x+0.7 +15, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.7,rect.origin.y + 15 +0.7 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}


@end
