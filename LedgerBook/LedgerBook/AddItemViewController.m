//
//  SecondViewController.m
//  LedgerBook
//
//  Created by nju on 15/12/1.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *typePicker;

@property (weak, nonatomic) IBOutlet UITextField *type;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type.delegate=self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTypeFieldKeyboard{
    UIPickerView *picker=[[UIPickerView alloc]init];
    self.typePicker=picker;
    picker.dataSource=self;
    picker.delegate=self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;//TODO:modify later
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==self.type){
        [self pickerView:self.typePicker didSelectRow:0 inComponent:0];
    }
}

@end
