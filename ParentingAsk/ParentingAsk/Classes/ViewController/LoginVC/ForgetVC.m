//
//  ForgetVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/9.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "ForgetVC.h"
#import "UINavigationItem+ItemCustom.h"

#import "LoginVC.h"
@interface ForgetVC ()<UITextFieldDelegate>

{
    UIButton *button;
     NSInteger _count;
    UIButton *showBtn;
}

@property (strong,nonatomic) UITextField *textFiled3;
@property (strong,nonatomic) UITextField *textFiled;
@property (strong,nonatomic) UITextField *textFiled2;

@property (strong,nonatomic) UIImageView *smallImg2;
@property (strong,nonatomic) UIImageView *smallImg;
@property (strong,nonatomic) UIImageView *smallImg3;

@end

@implementation ForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self GreatView];
}
-(void)GreatView
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, ScreenHeight/4 +ScreenHeight/15-ScreenHeight/20, ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView.image = [UIImage imageNamed:@"kuang.png"];
    [self.view addSubview:imgView];
    
    self.smallImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg.image = [UIImage imageNamed:@"phone-gray.png"];
    [imgView addSubview:self.smallImg];
    self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, ScreenHeight/4, ScreenWidth-ScreenHeight/5, ScreenHeight/15)];
     [self.textFiled setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled.placeholder = @"手机号";
    self.textFiled.tag = 1;
    self.textFiled.delegate = self;
    self.textFiled.font = [UIFont systemFontOfSize:15];
//    textFiled.backgroundColor = SystemGreenColor;
    [self.view addSubview:self.textFiled];
    
    
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, ScreenHeight/4 +ScreenHeight/10+ScreenHeight/15-ScreenHeight/20, ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView2.image = [UIImage imageNamed:@"kuang.png"];
    [self.view addSubview:imgView2];
    
   self.smallImg2= [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg2.image = [UIImage imageNamed:@"yanzhengma-gray.png"];
    [imgView2 addSubview:self.smallImg2];

    self.textFiled2 = [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, ScreenHeight/4 +ScreenHeight/10, ScreenWidth-ScreenHeight/3, ScreenHeight/15)];
     [self.textFiled2 setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled2.placeholder = @"验证码";
    self.textFiled2.secureTextEntry = YES;
    self.textFiled2.delegate = self;
    self.textFiled2.tag =2;
    self.textFiled2.font = [UIFont systemFontOfSize:15];
//    textFiled2.backgroundColor = SystemGreenColor;
    [self.view addSubview:self.textFiled2];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenHeight/7.5 + ScreenWidth-ScreenHeight/3, ScreenHeight/4 +ScreenHeight/8.5, ScreenHeight/3 - ScreenHeight/5, ScreenHeight/20);
    [button setTitle:@"验证码" forState:UIControlStateNormal];
    button.backgroundColor = SystemGreenColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, ScreenHeight/4 +ScreenHeight/15-ScreenHeight/20 +ScreenHeight/5, ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView3.image = [UIImage imageNamed:@"kuang.png"];
    [self.view addSubview:imgView3];
    
    self.smallImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
     self.smallImg3.image = [UIImage imageNamed:@"mima-gray.png"];
    [imgView3 addSubview: self.smallImg3];

   self.textFiled3 = [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, ScreenHeight/4 +ScreenHeight/5, ScreenWidth-ScreenHeight/5-ScreenHeight/15, ScreenHeight/15)];
//    [self.textFiled3 setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled3.placeholder = @"新密码";
    self.textFiled3.tag = 3;
    self.textFiled3.delegate = self;
    self.textFiled3.font = [UIFont systemFontOfSize:15];
    self.textFiled3.secureTextEntry = YES;
//    self.textFiled3.backgroundColor = SystemGreenColor;
    [self.view addSubview:self.textFiled3];
    
   showBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn.frame = CGRectMake(ScreenWidth-ScreenHeight/5+ScreenHeight/15 , ScreenHeight/4 +ScreenHeight/5  +ScreenHeight/30-ScreenHeight/60 , ScreenHeight/30 , ScreenHeight/30);
    [showBtn setImage:[UIImage imageNamed:@"eye-gray"] forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];

    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(ScreenHeight/15, ScreenHeight/1.8, ScreenWidth-ScreenHeight/7.5, ScreenHeight/15);
    [pushBtn setTitle:@"完成" forState:UIControlStateNormal];
    pushBtn.backgroundColor = SystemGreenColor;
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [pushBtn addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];

    
    
}
-(void)pushBtnClick
{
    if (self.textFiled.text.length ==!11)
    {
        MBE(@"请输入正确的手机格式")
    }
else if (self.textFiled2.text.length < 6)
{
    MBE(@"请输入正确的验证码")
}
    else if (self.textFiled3.text.length<6)
    {
    MBE(@"密码需超过六位")
    }
    else
    {
       
        MBShow
        NSString *strPhoneNum = self.textFiled.text;
        NSString *strPassN = self.textFiled3.text;
        NSString *strCode = self.textFiled2.text;
         int verCode = [strCode intValue];
        [HTTPRequest httpWithPost:@"/cus/forgetPwd" Param:@{@"phone": strPhoneNum, @"password": strPassN, @"captcha": [NSNumber numberWithInt:verCode]} Success:^(id obj)
        {
            if (SUCCESS)
            {
                NSLog(@"obj = %@",obj);
                MBHide
               MBE(@"修改成功")
                 [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
                
            }
            else
            {
                MBHide
                NSString *errorInfo = obj[@"desc"];
                MBE(errorInfo)
//                NSLog(@"obj==%@",obj[@"desc"]);
            }
           
           
        } Fail:^(NSString *errorMsg)
        {
            MBHide
            MBE_Sys
        }];
    }

}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnClick

{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)showBtnClick
{
    
    self.textFiled3.secureTextEntry =  !self.textFiled3.secureTextEntry ;

    if (!self.textFiled3.secureTextEntry)
    {
        [showBtn setImage:[UIImage imageNamed:@"eye-green"] forState:UIControlStateNormal];
    }
    else
    {
        [showBtn setImage:[UIImage imageNamed:@"eye-gray"] forState:UIControlStateNormal];
    }
    

}


-(void)codeBtnClick
{
  
    
    
        
        if (self.textFiled.text.length > 0) {
            MBShow
            [HTTPRequest httpWithPost:@"/cus/captcha" Param:@{@"phone": self.textFiled.text} Success:^(id obj) {
                if (SUCCESS) {
                    MBHide
                    MBS(@"验证码已发送")
                }
                else {
                    MBHide
                    MBE([obj valueForKey:@"desc"])
                }
            } Fail:^(NSString *errorMsg) {
                MBHide
                MBE_Sys
            }];
        }
    

}
-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [button setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateDisabled];
    }
    else
    {
        [timer invalidate];
        button.enabled = YES;
        [button setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
     NSLog(@"textFieldDidBeginEditing");
    if (textField ==self.textFiled)
    {
        self.smallImg.image = [UIImage imageNamed:@"phone-green"];
    }
    else if (textField == self.textFiled2)
    {
        self.smallImg2.image = [UIImage imageNamed:@"yanzhengma-green"];
        
    }
    else if (textField == self.textFiled3)
        
    {
        self.smallImg3.image = [UIImage imageNamed:@"mima-green"];
    }
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
