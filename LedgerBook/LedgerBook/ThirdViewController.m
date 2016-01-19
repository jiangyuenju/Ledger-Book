//
//  ThirdViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "ThirdViewController.h"
#define PI 3.14159265358979323846

@interface ThirdViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (strong, nonatomic) IBOutlet UIImageView *MyImageView;
@property (strong, nonatomic) IBOutlet drawPie *PieView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _PieView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_PieView];
    [self.MyImageView setImage:[UIImage imageNamed:@"shouru.png"]];
    [self.segControl setSelectedSegmentIndex:0];
    _PieView.hidden=NO;
    [_PieView setNeedsDisplay];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [_PieView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleControl:(id)sender {
    if([self.segControl selectedSegmentIndex]==0){
        [self.PieView setChoice:0];
        [self.MyImageView setImage:[UIImage imageNamed:@"shouru.png"]];
        [_PieView setNeedsDisplay];
    }
    else{
        [self.PieView setChoice:1];
        [self.MyImageView setImage:[UIImage imageNamed:@"zhichu.png"]];
        [_PieView setNeedsDisplay];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
