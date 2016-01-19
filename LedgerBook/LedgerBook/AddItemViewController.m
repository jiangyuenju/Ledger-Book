
//
//  SecondViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "AddItemViewController.h"
#import "Ledger.h"
#import "FirstViewController.h"

@interface AddItemViewController ()<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UIPickerView *outcomeTypePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *incomeTypePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (weak, nonatomic) IBOutlet UIToolbar *doneToolBar;

@property (strong, nonatomic) NSMutableArray *outcomeTypes;
@property (strong, nonatomic) NSMutableArray *incomeTypes;
@property (strong, nonatomic) NSMutableArray *myTypes;

@property (weak, nonatomic) IBOutlet UITextField *moneyField;


@property (weak, nonatomic) IBOutlet UITextField *typefield;
@property (weak, nonatomic) IBOutlet UITextView *psTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;


@end

@implementation AddItemViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.outcomeTypePicker.dataSource=self;
    self.outcomeTypePicker.delegate=self;
    [self.view addSubview:self.outcomeTypePicker];
    self.outcomeTypePicker.hidden=YES;
    self.doneToolBar.hidden=YES;
    
    self.incomeTypePicker.dataSource=self;
    self.incomeTypePicker.delegate=self;
    [self.view addSubview:self.incomeTypePicker];
    self.incomeTypePicker.hidden=YES;
    self.myPickerView=self.outcomeTypePicker;
    
    self.outcomeTypes=[NSMutableArray arrayWithObjects:@"餐饮",@"交通",@"居家", @"手机通讯",@"娱乐",@"书籍",@"借出",@"人情礼物",@"医疗",@"教育",@"美容运动",@"其他", nil];
    self.incomeTypes=[NSMutableArray arrayWithObjects:@"工资",@"奖金",@"外快兼职",@"借入",@"投资收入",@"红包",@"零花钱",@"生活费",@"其他", nil];
    self.myTypes=self.outcomeTypes;
    
    self.typefield.delegate=self;
    self.typefield.inputView= self.myPickerView;
    self.typefield.inputAccessoryView=self.doneToolBar;
    self.moneyField.delegate=self;
    self.psTextView.delegate=self;
    
    self.psTextView.layer.borderColor=[[UIColor grayColor] CGColor];
    self.psTextView.layer.borderWidth=1;
    self.psTextView.layer.cornerRadius=5.0;
    self.doneBtn.layer.cornerRadius=5.0;
    
    self.ledger=[[Ledger alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated{
    if(self.jump){
        self.psTextView.text=self.detail;
        self.moneyField.text=self.money;
        self.jump=NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView ==self.outcomeTypePicker){
        return [self.outcomeTypes count];
    }
    else{
        return [self.incomeTypes count];
    }
//    return [self.myTypes count];
}

- (IBAction)textFieldDidReturn:(id)sender {//点击return隐藏键盘
    [sender resignFirstResponder];
}

-(IBAction)backgroundTap:(id)sender{
    [self.typefield resignFirstResponder];
    [self.psTextView resignFirstResponder];
    [self.moneyField resignFirstResponder];
    self.outcomeTypePicker.hidden=YES;
    self.incomeTypePicker.hidden=YES;
    self.doneToolBar.hidden=YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==self.typefield){
        [self.moneyField resignFirstResponder];
        [self.psTextView resignFirstResponder];
        [self.typefield resignFirstResponder];
        self.doneToolBar.hidden=NO;
        self.myPickerView.hidden=NO;
    }
    else if(textField==self.moneyField){
        [self.psTextView resignFirstResponder];
        [self.typefield resignFirstResponder];
        self.doneToolBar.hidden=YES;
        self.myPickerView.hidden=YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==self.moneyField){
        self.ledger.balance=[NSNumber numberWithDouble:[self.moneyField.text doubleValue]];
    }
    else if(textField==self.typefield){
        self.ledger.ledgerType=self.typefield.text;
    }
}


-(void) textViewDidBeginEditing:(UITextView *)textView{
    [self.moneyField resignFirstResponder];
    [self.typefield resignFirstResponder];
    self.doneToolBar.hidden=YES;
    self.myPickerView.hidden=YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.ledger.PS=self.psTextView.text;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView==self.outcomeTypePicker){
        self.ledger.inOrOut=@"支出";
        return [self.outcomeTypes objectAtIndex:row];
    }
    else{
        self.ledger.inOrOut=@"收入";
        return [self.incomeTypes objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *typeName;
    if(pickerView==self.outcomeTypePicker){
        typeName = [self.outcomeTypes objectAtIndex:row];
    }
    else{
        typeName = [self.incomeTypes objectAtIndex:row];
    }
    self.typefield.text = typeName;
}

- (IBAction)doneButtonTypePicker:(id)sender {
    [self.typefield resignFirstResponder];
    self.outcomeTypePicker.hidden=YES;
    self.incomeTypePicker.hidden=YES;
    self.doneToolBar.hidden=YES;
    self.ledger.ledgerType=self.typefield.text;
}

- (IBAction)toggleControl:(id)sender {
    if([self.segControl selectedSegmentIndex]==0){
        self.myPickerView=self.incomeTypePicker;
        self.myTypes=self.incomeTypes;
        self.ledger.inOrOut=@"支出";
    }
    else{
        self.myPickerView=self.outcomeTypePicker;
        self.myTypes=self.outcomeTypes;
        self.ledger.inOrOut=@"收入";
    }
}
- (IBAction)didNewLedger:(id)sender {
    self.ledger =[[Ledger alloc]init];
    self.ledger.balance=[NSNumber numberWithDouble:[self.moneyField.text doubleValue]];
    if([self.moneyField.text isEqualToString:@""]){
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@""
                                                    message:@"金额不能为空"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [av show];
        return;
    }
    self.ledger.inOrOut=[self.segControl selectedSegmentIndex]==0?@"收入":@"支出";
    self.ledger.ledgerType=self.typefield.text;
    if([self.typefield.text isEqualToString:@""]){
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@""
                                                    message:@"类型不能为空"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [av show];
        return;
    }
    
    self.ledger.PS=self.psTextView.text;
    
    NSDate * mydate=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    self.ledger.date=[dateFormatter stringFromDate:mydate];
    
    UITabBarController *tabBar=(UITabBarController*)self.tabBarController;
    NSArray *viewControllersArray = tabBar.viewControllers;
    FirstViewController *firstVC=[viewControllersArray objectAtIndex:0];
    [firstVC addReturn];
    
    self.moneyField.text=@"";
    self.typefield.text=@"";
    self.psTextView.text=@"";
}

@end
