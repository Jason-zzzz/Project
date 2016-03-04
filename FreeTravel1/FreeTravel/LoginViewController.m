//
//  LoginViewController.m
//  FreeTravel
//
//  Created by Admin on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+Draw.h"

@interface LoginViewController () <UITextFieldDelegate> {
    UITextField *userField_, *keyField_;
    UITextField *curTextField_;
    UILabel *userLabel_ , *keyLabel_;
    UIImageView *logoImage_;
    UIButton *loadButton_;
    UIImageView *backImage_;
    UIButton *cancel_;
    UILabel *titleLabel_;
    UIButton *registerBtn_;
}

@end

@implementation LoginViewController


static NSInteger middleX = 0;
static NSInteger middleY = 0;

- (void)loadView{
    //获取屏幕中间值x,y
    middleX = [UIScreen mainScreen].bounds.size.width / 2;
    middleY = [UIScreen mainScreen].bounds.size.height / 2;
    
    //自己创建UIControl添加事件
    UIControl *view = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view addTarget:self action:@selector(resignResponder:) forControlEvents:UIControlEventTouchDown];
    view.backgroundColor = [UIColor clearColor];
    self.view = view;
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backImage];
    [self.view addSubview:self.loadButton];
    [self.view addSubview:self.userLabel];
    [self.view addSubview:self.keyLabel];
    [self.view addSubview:self.keyField];
    [self.view addSubview:self.userField];
    [self.view addSubview:self.logoImage];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.cancel];
    [self.view addSubview:self.registerBtn];
    
    //添加观察者,监听键盘弹出，隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Views

- (UIButton *)cancel {
    if (!cancel_) {
        cancel_ = [UIButton buttonWithType:UIButtonTypeSystem];
        cancel_.frame = CGRectMake(15, 40, 20, 20);
        cancel_.center = CGPointMake(25, 55);
        [cancel_ setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        cancel_.tintColor = [UIColor whiteColor];
        [cancel_ addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return cancel_;
}

- (UILabel *)titleLabel {
    if (!titleLabel_) {
        titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        titleLabel_.center = CGPointMake(middleX, 55);
        titleLabel_.textColor = [UIColor whiteColor];
        titleLabel_.text = @"登录";
        [titleLabel_ setFont:[UIFont systemFontOfSize:18]];
    }
    return titleLabel_;
}

- (UIButton *)registerBtn{
    if (!registerBtn_) {
        registerBtn_ = [UIButton buttonWithType:UIButtonTypeSystem];
        registerBtn_.frame = CGRectMake(0, 0, 50, 22);
        registerBtn_.center = CGPointMake(330, 55);
        registerBtn_.tintColor = [UIColor whiteColor];
        [registerBtn_ setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn_.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [registerBtn_ roundedRectWithDefaultValue];
    }
    return registerBtn_;
}

- (UIImageView *)backImage{
    if (!backImage_) {
        backImage_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 3)];
        backImage_.image = [UIImage imageNamed:@"pic-background.png"];
//        backImage_.backgroundColor = [UIColor redColor];
    }
    return backImage_;
}

//LOGO图
- (UIImageView *)logoImage{
    
    if (!logoImage_) {
        logoImage_ = [[UIImageView alloc] init];
        logoImage_.frame = CGRectMake(0, 0, 170, 80);
        logoImage_.center = CGPointMake(middleX, middleY / 2);
        logoImage_.backgroundColor = [UIColor grayColor];
        
        UIImage *image1 = [UIImage imageNamed:@"imag_08.jpg"];
        logoImage_ .image = image1;
        
    }
    return logoImage_;
}

//用户名输入提示
- (UILabel *)userLabel{
    
    if (!userLabel_) {
        userLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(20, middleY - 50, 55, 30)];
        userLabel_.text = @"用户:";
        //        userLabel_.backgroundColor = [UIColor grayColor];
        //    userLabel_ setFont:
        userLabel_.textColor = [UIColor whiteColor];
    }
    return userLabel_;
}

//密码输入提示
- (UILabel *)keyLabel{
    
    if (!keyLabel_) {
        keyLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(20, middleY + 20, 55, 30)];
        keyLabel_.text = @"密码:";
        keyLabel_.textColor = [UIColor whiteColor];
        //    userLabel_ setFont:;
    }
    return keyLabel_;
}

//用户名输入框
- (UITextField *)userField{
    
    if (!userField_) {
        userField_ = [[UITextField alloc] initWithFrame:CGRectMake(userLabel_.center.x + 22.5, middleY - 50, middleX * 2 - 90, 30)];
        userField_.placeholder = @"请输入用户";
        userField_.clearButtonMode = UITextFieldViewModeAlways;
        [userField_ roundedRectWithDefaultValue];//圆角
        userField_.returnKeyType = UIReturnKeyNext;//改变键盘，右下角位NEXT键
        userField_.delegate = self;//遵循协议,响应键盘弹出,隐藏事件,NEXT键功能
        userField_ .textColor = [UIColor whiteColor];
        [userField_ setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [userField_ setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    return userField_;
}

//密码输入框
- (UITextField *)keyField{
    
    if (!keyField_) {
        keyField_ = [[UITextField alloc] initWithFrame:CGRectMake(userLabel_.center.x + 22.5, middleY + 20, middleX * 2 - 90, 30)];
        keyField_.placeholder = @"请输入密码";
        keyField_.clearButtonMode = UITextFieldViewModeAlways;
        [keyField_ roundedRectWithDefaultValue]; //圆角
        //        [keyField_ addTarget:self action:@selector(keyboardShow:) forControlEvents:UIControlEventTouchUpInside]; //添加事件
        keyField_.returnKeyType = UIReturnKeyDone;//改变键盘为DONE键
        keyField_.secureTextEntry = YES; //密码输入模式
        keyField_.delegate = self; //遵循协议,响应键盘弹出,隐藏事件,DONE键功能
        keyField_.textColor = [UIColor whiteColor];
        [keyField_ setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [keyField_ setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    }
    return keyField_;
}

//登陆按钮
- (UIButton *)loadButton{
    
    if (!loadButton_) {
        loadButton_ = [UIButton buttonWithType:UIButtonTypeSystem];
        loadButton_.frame = CGRectMake(middleX - 40, middleY + 90, 80, 30);
        [loadButton_ setTitle:@"登陆" forState:UIControlStateNormal];
        [loadButton_ roundedRectWithDefaultValue];//圆角
        [loadButton_ addTarget:self action:@selector(loadAction:) forControlEvents:UIControlEventTouchUpInside];
        loadButton_.tintColor = [UIColor whiteColor];
    }
    return loadButton_;
}

#pragma mark Actions

- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//移除响应者
- (IBAction)resignResponder:(id)sender{
    
    [userField_ resignFirstResponder];
    [keyField_ resignFirstResponder];
}

//键盘弹出时不产生遮挡关系的设置
- (void)keyboardShow:(NSNotification *)notify{
    
    //    NSLog(@"出来了");
    NSValue *value = [notify.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGFloat keyboardHeight = value.CGRectValue.size.height;
    //    NSLog(@"%f",keyboardHeight);
    
    //获取当前输入框的y值，高度值及屏幕高度
    CGFloat y = curTextField_.frame.origin.y;
    CGFloat h = curTextField_.frame.size.height;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    //    NSLog(@"%f %f %f",screenHeight , h, y);
    
    //获取屏幕与控件高度差
    CGFloat deltaH = screenHeight - (y + h + keyboardHeight + self.view.frame.origin.y) - 80;
    //    NSLog(@"%f",deltaH);
    
    //如果屏幕不够高
    if (deltaH < 0) {
        CGRect frame = self.view.frame;
        frame = CGRectMake(frame.origin.x, frame.origin.y + deltaH , frame.size.width, frame.size.height);
        self.view.frame = frame;
    }
}

//登陆功能
- (IBAction)loadAction:(id)sender{
    
    if ([userField_.text isEqualToString:@""]) {
        NSLog(@"请重新输入用户名");
        [userField_ becomeFirstResponder];
        [keyField_ resignFirstResponder];
    }else if([keyField_.text isEqualToString:@""]){
        NSLog(@"请重新输入密码:");
        [userField_ resignFirstResponder];
        [keyField_ becomeFirstResponder];
    }else{
        NSLog(@"登陆中...");
    }
}

//键盘隐藏
- (void)keyboardHide:(NSNotification *)notify{
    
    //    NSLog(@"回去了");
    CGRect frame = self.view.frame;
    frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
    self.view.frame = frame;
}

//点击键盘下一项
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //    [userField_ resignFirstResponder];
    [keyField_ becomeFirstResponder];
    return YES;
}

//textField开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    curTextField_ = textField;
}

@end
