//
//  SecondViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *doneToolBar;
@property (weak, nonatomic) IBOutlet UIPickerView *typePicker;
@property (strong, nonatomic) NSMutableArray *types;
@property (weak, nonatomic) IBOutlet UITextField *typefield;

@end

@implementation AddItemViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.typePicker=[[UIPickerView alloc]init];
    self.typePicker.dataSource=self;
    self.typePicker.delegate=self;
    self.typePicker.hidden=YES;
    self.doneToolBar.hidden=YES;
    
    self.types=[NSMutableArray arrayWithObjects:@"餐饮",@"娱乐",@"书籍", nil];
    
    self.typefield.delegate=self;
    self.typefield.inputView= self.typePicker;
//  self.typefield.inputAccessoryView=self.doneToolBar;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.types count];
}

//- (IBAction)doneButtonTypePicker:(id)sender {
//    [self.typefield endEditing:YES];
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==self.typefield){
        [self.typefield resignFirstResponder];
        self.doneToolBar.hidden=NO;
        self.typePicker.hidden=NO;
        [self pickerView:self.typePicker didSelectRow:0 inComponent:0];
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.types objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *typeName = [self types][row];
    self.typefield.text = typeName;
}

- (IBAction)doneButtonTypePicker:(id)sender {
    self.typePicker.hidden=YES;
    self.doneToolBar.hidden=YES;
}

@end
