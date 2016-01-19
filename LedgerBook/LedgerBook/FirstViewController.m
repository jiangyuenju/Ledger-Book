//
//  FirstViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "FirstViewController.h"
#import "KxMenu.h"
#import "AddItemViewController.h"
#import "TimeLineViewControl.h"
#import "WXApi.h"
#import "Masonry.h"
#import "MASViewAttribute.h"

@interface FirstViewController ()

@property TimeLineViewControl *timeline;
@property NSMutableArray *times;
@property NSMutableArray *descriptions;
@property NSMutableArray *types;

@property UILabel *myLabel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setButton];
    self.times = [[NSMutableArray alloc]init];
    self.descriptions=[[NSMutableArray alloc]init];
    self.types =[[NSMutableArray alloc]init];
    
//    [self.times addObject:@"2016年1月16日"];
    NSString *startDate;
    if([self isFirstRun]){
        NSDate *myDate=[NSDate date];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
        startDate=[dateFormatter stringFromDate:myDate];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:startDate];//archive:把对象变成Data
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"startDate"];
    }
    else{
        NSData* data=(NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"startDate"];
        startDate=(NSString*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    [self.times addObject:startDate];
    [self.descriptions addObject:@"您开始使用LedgerBook"];
    [self.types addObject:@"开始"];
    
    if(self.ledgerArray == nil){
        NSData* data=(NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"allLedgers"];
        if(data!=nil){
            self.ledgerArray=(NSMutableArray*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            if(self.ledgerArray !=nil){
                
                for(Ledger *obj in self.ledgerArray){
                    [self.times addObject:obj.date];
                    [self.types addObject:obj.ledgerType];
                    [self.descriptions addObject:[NSString stringWithFormat:@"%@%@元 %@",obj.inOrOut,obj.balance.stringValue,obj.ledgerType]];
                }
                
                [self setTimeline];
                
                [self setScrollView];
                
                self.timeline.center = self.view.center;
                [self.view addSubview:self.timeline];
                
                return;
            }
        }
        self.ledgerArray=[[NSMutableArray alloc]init];
    }
    
    [self setTimeline];
    
    [self setScrollView];
    
//    self.timeline.center = self.myScrollView.center;
//    [self.myScrollView addSubview:self.timeline];
    
}

- (BOOL) isFirstRun

{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL  hasRunBefore = [defaults boolForKey:@"runIdentifier"];
    
    if(!hasRunBefore )
    
    {
        
        NSLog(@"这是第一次运行");
        
        [defaults setBool:YES forKey:@"runIdentifier"];
        
        return YES;
        
    }
    
    return NO;
    
}

- (void) setButton{
    self.myButton=[UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.myButton addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.myButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.myLabel=[[UILabel alloc]init];
    self.myLabel.text=@"您的账本";
    self.myLabel.font=[UIFont systemFontOfSize:24];
    self.myLabel.textColor=[UIColor darkGrayColor];
    self.myLabel.textAlignment=NSTextAlignmentCenter;
}

- (void) setScrollView{
    self.myScrollView =[[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    self.myScrollView.contentSize=CGSizeMake([[UIScreen mainScreen] applicationFrame].size.width, self.timeline.viewheight+280);
    self.myScrollView.backgroundColor=[UIColor whiteColor];

    __weak typeof(self) weakSelf = self;
    
    self.view=self.myScrollView;
    
    
    [self.myScrollView addSubview:self.myButton];
    
    [self.myButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(40, 40));
        make.top.equalTo(weakSelf.myScrollView.top).with.offset(30);
        make.left.equalTo(weakSelf.myScrollView.left).with.offset(20);
        
    }];
    
    [self.myScrollView addSubview:self.myLabel];
    
    [self.myLabel makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(150, 50));
        make.top.equalTo(60);
        //make.left.equalTo(110);
        make.centerX.equalTo(weakSelf.myScrollView);
        
    }];
    
    
    self.timeline.center = self.myScrollView.center;
    NSLog(@"%f,%f",self.myScrollView.center.x,self.myScrollView.center.y);
    [self.myScrollView addSubview:self.timeline];
    [self.timeline makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(130);
 //       make.centerX.equalTo(weakSelf.view);
        make.left.equalTo(20);
    }];
}

- (void) setTimeline {
    self.timeline = [[TimeLineViewControl alloc] initWithTimeArray:self.times
                                           andTimeDescriptionArray:self.descriptions andTypeArray:self.types
                                                  andCurrentStatus:2
                                                          andFrame:CGRectMake(50, 120, self.view.frame.size.width-30, 200)];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) addReturn{
    UITabBarController *tabBar=(UITabBarController*)self.tabBarController;
    NSArray *viewControllersArray = tabBar.viewControllers;
    AddItemViewController *addItemVC=[viewControllersArray objectAtIndex:1];
    Ledger *obj=addItemVC.ledger;
    
    [self.ledgerArray addObject:obj];
    [self.types addObject:obj.ledgerType];
    [self.descriptions addObject:[NSString stringWithFormat:@"%@%@元 %@",obj.inOrOut,obj.balance.stringValue,obj.ledgerType]];
    [self.times addObject:addItemVC.ledger.date];
    [self.timeline removeFromSuperview];
    
    [self setTimeline];
    self.myScrollView.contentSize=CGSizeMake([[UIScreen mainScreen] applicationFrame].size.width, self.timeline.viewheight+280);
    self.timeline.center = self.myScrollView.center;
    [self.myScrollView addSubview:self.timeline];
    
    
    tabBar.selectedIndex=0;
    
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:self.ledgerArray];//archive:把对象变成Data
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"allLedgers"];
    
    addItemVC.ledger=[[Ledger alloc]init];
}

-(IBAction)clickAdd{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"截图"
                     image:nil
                    target:self
                    action:@selector(screenShot)],
      
      [KxMenuItem menuItem:@"分享"
                     image:nil
                    target:self
                    action:@selector(WXshare)],
      
      ];
    
    [KxMenu showMenuInView:self.view
                  fromRect:self.myButton.frame
                 menuItems:menuItems];
}

- (void)screenShot{
    UIImage *viewImage=nil;
    UIGraphicsBeginImageContextWithOptions(self.myScrollView.contentSize,NO,0.0);
    {
        CGPoint savedContentOffset = self.myScrollView.contentOffset;
        CGRect savedFrame = self.myScrollView.frame;
        
        self.myScrollView.contentOffset = CGPointZero;
        self.myScrollView.frame = CGRectMake(0, 0, self.myScrollView.contentSize.width, self.myScrollView.contentSize.height);
        UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.myScrollView.contentSize.width, self.myScrollView.contentSize.height)];
        
        UIView *tempSuperView=self.myScrollView.superview;
        
        [self.myScrollView removeFromSuperview];
        [tempView addSubview:self.myScrollView];
        [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [tempView.subviews[0] removeFromSuperview];
        [tempSuperView addSubview:self.myScrollView];
        
        self.myScrollView.contentOffset = savedContentOffset;
        self.myScrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
}

- (void)WXshare{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
        
        UIImage *viewImage=nil;
        UIGraphicsBeginImageContext(self.myScrollView.contentSize);
        {
            CGPoint savedContentOffset = self.myScrollView.contentOffset;
            CGRect savedFrame = self.myScrollView.frame;
            
            self.myScrollView.contentOffset = CGPointZero;
            self.myScrollView.frame = CGRectMake(0, 0, self.myScrollView.contentSize.width, self.myScrollView.contentSize.height);
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.myScrollView.contentSize.width, self.myScrollView.contentSize.height)];
            
            UIView *tempSuperView=self.myScrollView.superview;
            
            [self.myScrollView removeFromSuperview];
            [tempView addSubview:self.myScrollView];
            [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            viewImage = UIGraphicsGetImageFromCurrentImageContext();
            
            [tempView.subviews[0] removeFromSuperview];
            [tempSuperView addSubview:self.myScrollView];
            
            self.myScrollView.contentOffset = savedContentOffset;
            self.myScrollView.frame = savedFrame;
        }
        
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:viewImage];
        
        WXImageObject *ext = [WXImageObject object];
        ext.imageData = UIImagePNGRepresentation(viewImage);
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        
        [WXApi sendReq:req];
    }
    else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"您的设备上还没有安装微信,无法使用此功能，使用微信可以方便的把你喜欢的作品分享给好友。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        [alView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{   //跳转到Appstore安装微信
    if (buttonIndex == 1) {
        NSString *weiXinLink = @"itms-apps://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weiXinLink]];
    }
}

@end
