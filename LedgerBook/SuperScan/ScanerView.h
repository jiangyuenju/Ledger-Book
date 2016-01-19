//
//  ScanerView.h
//  SuperScanner
//
//  Created by Jeans Huang on 10/19/15.
//  Copyright © 2015 gzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanerView : UIView

//! 扫描区域边长
@property (nonatomic, assign) CGFloat   scanAreaEdgeLength;

//! 扫描区域，用作修正扫描
@property (nonatomic, assign, readonly) CGRect scanAreaRect;

@end
