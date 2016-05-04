//
//  RegistViewController.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/4/23.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#define height_img  ScreenHeight/5 +ScreenHeight/15 +ScreenHeight/11
#import "UINavigationItem+ItemCustom.h"
#import "RegistViewController.h"
#import "ChooseCityVC.h"
#import "STPickerArea.h"
#import "ProtocolVC.h"
@interface RegistViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIButton *button;
    NSInteger _count;
    UIButton *showBtn;
    UIButton *CityBtn;
    NSString *_strCityCode;
    NSString *_CityCodeStr;
    UIButton *rightBtn;
    BOOL _isRegisted;
    UILabel *btnLab;

}
@property(nonatomic,strong)UIScrollView *scrollView;
@property (strong,nonatomic) UITextField *textFiled3,*textFiled4,*textFiled5,*textFiled6,*textFiled7;
@property (strong,nonatomic) UITextField *textFiled;
@property (strong,nonatomic) UITextField *textFiled2;

@property (strong,nonatomic) UIImageView *smallImg2,*smallImg4,*smallImg5,*smallImg6,*smallImg7;
@property (strong,nonatomic) UIImageView *smallImg;
@property (strong,nonatomic) UIImageView *smallImg3;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
    
    [self greatView];
    
    
}
-(void)btnClick

{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)greatView
{
    
     self.scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight*1.5);
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, ScreenHeight/15, ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView.image = [UIImage imageNamed:@"kuang.png"];
    [self.scrollView addSubview:imgView];
    
    self.smallImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg.image = [UIImage imageNamed:@"phone-green.png"];
    [imgView addSubview:self.smallImg];
    self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, ScreenHeight/16, ScreenWidth-ScreenHeight/5, ScreenHeight/20)];
    [self.textFiled setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled.placeholder = @"手机号";
    self.textFiled.tag = 1;
    [self.textFiled setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled.delegate = self;
    self.textFiled.font = [UIFont systemFontOfSize:15];
    //    textFiled.backgroundColor = SystemGreenColor;
    [self.scrollView addSubview:self.textFiled];
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, ScreenHeight/15+ScreenHeight/10, ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView2.image = [UIImage imageNamed:@"kuang.png"];
    [self.scrollView addSubview:imgView2];
    
    self.smallImg2= [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg2.image = [UIImage imageNamed:@"yanzhengma-green.png"];
    [imgView2 addSubview:self.smallImg2];
    
    self.textFiled2 = [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, ScreenHeight/17 +ScreenHeight/10, ScreenWidth-ScreenHeight/3, ScreenHeight/15)];
    [self.textFiled2 setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled2.placeholder = @"验证码";
    self.textFiled2.secureTextEntry = YES;
    self.textFiled2.delegate = self;
     [self.textFiled2 setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled2.tag =2;
    self.textFiled2.font = [UIFont systemFontOfSize:15];
    //    textFiled2.backgroundColor = SystemGreenColor;
    [self.scrollView addSubview:self.textFiled2];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenHeight/7.5 + ScreenWidth-ScreenHeight/3, ScreenHeight/6, ScreenHeight/3 - ScreenHeight/5, ScreenHeight/20);
    [button setTitle:@"验证码" forState:UIControlStateNormal];
    button.backgroundColor = SystemGreenColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(codeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    
    
    UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, ScreenHeight/5 +ScreenHeight/15 , ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView3.image = [UIImage imageNamed:@"kuang.png"];
    [self.scrollView addSubview:imgView3];
    
    self.smallImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg3.image = [UIImage imageNamed:@"mima-green.png"];
    [imgView3 addSubview: self.smallImg3];
    
    self.textFiled3 = [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, ScreenHeight/5 +ScreenHeight/17 , ScreenWidth-ScreenHeight/5-ScreenHeight/15, ScreenHeight/15)];
    //    [self.textFiled3 setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled3.placeholder = @"密码";
    self.textFiled3.tag = 3;
    self.textFiled3.delegate = self;
    self.textFiled3.font = [UIFont systemFontOfSize:15];
    self.textFiled3.secureTextEntry = YES;
    //    self.textFiled3.backgroundColor = SystemGreenColor;
    [self.scrollView addSubview:self.textFiled3];
    
    showBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn.frame = CGRectMake(ScreenWidth-ScreenHeight/5+ScreenHeight/15 , ScreenHeight/5 +ScreenHeight/13, ScreenHeight/30 , ScreenHeight/30);
    [showBtn setImage:[UIImage imageNamed:@"eye-gray"] forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:showBtn];
    
   
   
    
    
    
    UIImageView *imgView4 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, ScreenHeight/5 +ScreenHeight/15 +ScreenHeight/11 , ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView4.image = [UIImage imageNamed:@"kuang.png"];
    [self.scrollView addSubview:imgView4];
    
    self.smallImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg4.image = [UIImage imageNamed:@"dingwei-green"];
    [imgView4 addSubview: self.smallImg4];
    
    
     CityBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    CityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    CityBtn.frame = CGRectMake(ScreenHeight/7, ScreenHeight/5 +ScreenHeight/15 +ScreenHeight/11,ScreenWidth-ScreenHeight/5,ScreenHeight/20 );
    [CityBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [self.scrollView addSubview:CityBtn];
    btnLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, ScreenWidth/4, ScreenHeight/20)];
    btnLab.text =@"地区";
    btnLab.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.00];
    btnLab.font = [UIFont systemFontOfSize:15];
    btnLab.textAlignment = NSTextAlignmentLeft;
    [CityBtn addSubview:btnLab];
    
    
    
    UIImageView *imgView5 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, height_img+ScreenHeight/11 , ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView5.image = [UIImage imageNamed:@"kuang.png"];
    [self.scrollView addSubview:imgView5];
    
    self.smallImg5 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg5.image = [UIImage imageNamed:@"danwei-green.png"];
    [imgView5 addSubview: self.smallImg5];
    
    self.textFiled5= [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, height_img+ScreenHeight/12 , ScreenWidth-ScreenHeight/5-ScreenHeight/15, ScreenHeight/15)];
    
    self.textFiled5.placeholder = @"单位";

    self.textFiled5.secureTextEntry = NO;
    self.textFiled5.delegate = self;
    self.textFiled5.font = [UIFont systemFontOfSize:15];
[self.textFiled5 setReturnKeyType:UIReturnKeyDone];
    
    [self.scrollView addSubview:self.textFiled5];

    
    
    UIImageView *imgView6 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15, height_img+ScreenHeight/11+ScreenHeight/11, ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView6.image = [UIImage imageNamed:@"kuang.png"];
    [self.scrollView addSubview:imgView6];
    
    self.smallImg6 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg6.image = [UIImage imageNamed:@"keshi-green.png"];
    [imgView6 addSubview: self.smallImg6];
    
    self.textFiled6 = [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, height_img+ScreenHeight/12+ScreenHeight/12 , ScreenWidth-ScreenHeight/5-ScreenHeight/15, ScreenHeight/15)];
    //    [self.textFiled3 setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled6.placeholder = @"科室";
    self.textFiled6.tag = 3;
    self.textFiled6.delegate = self;
    self.textFiled6.secureTextEntry = NO;
    self.textFiled6.font = [UIFont systemFontOfSize:15];
   [self.textFiled6 setReturnKeyType:UIReturnKeyDone];
    //    self.textFiled3.backgroundColor = SystemGreenColor;
    [self.scrollView addSubview:self.textFiled6];

    UIImageView *imgView7 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenHeight/15,height_img+ScreenHeight/11+ScreenHeight/11+ScreenHeight/11 , ScreenWidth-ScreenHeight/7.5, ScreenHeight/20)];
    imgView7.image = [UIImage imageNamed:@"kuang.png"];
    [self.scrollView addSubview:imgView7];
    
    self.smallImg7 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/13.8-10, 5, 20, 20)];
    self.smallImg7.image = [UIImage imageNamed:@"yaoqingma-green.png"];
    [imgView7 addSubview: self.smallImg7];
    
    self.textFiled7 = [[UITextField alloc]initWithFrame:CGRectMake(ScreenHeight/5.5, height_img+ScreenHeight/12+ScreenHeight/11+ScreenHeight/11 , ScreenWidth-ScreenHeight/5-ScreenHeight/15, ScreenHeight/15)];
    //    [self.textFiled3 setKeyboardType:UIKeyboardTypeNumberPad];
    self.textFiled7.placeholder = @"邀请码";
    self.textFiled7.tag = 3;
    self.textFiled7.secureTextEntry = NO;
    self.textFiled7.delegate = self;
    self.textFiled7.font = [UIFont systemFontOfSize:15];
    [self.textFiled7 setReturnKeyType:UIReturnKeyDone];
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenHeight/5+ScreenHeight/15,  height_img+ScreenHeight/12+ScreenHeight/11+ScreenHeight/11, 50, 50)];
    label7.text = @"选填";
    label7.textColor = [UIColor colorWithRed:199.0/255.0 green:131.0/255.0 blue:31.0/255.0 alpha:1.00];
    label7.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:label7];
   
    //    self.textFiled3.backgroundColor = SystemGreenColor;
    [self.scrollView addSubview:self.textFiled7];

    UIButton *regiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regiBtn.frame = CGRectMake(ScreenWidth/4, ScreenHeight-ScreenHeight/3.2, ScreenWidth/3, ScreenHeight/20);
    [regiBtn setTitle:@"《注册协议》" forState:UIControlStateNormal];
   
    [regiBtn setTitleColor:SystemGreenColor forState:UIControlStateNormal];
    regiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [regiBtn addTarget:self action:@selector(regiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:regiBtn];
    rightBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    _isRegisted = YES;
    [rightBtn setImage:[UIImage imageNamed:@"choice.png"] forState:UIControlStateNormal];
   
    
    rightBtn.frame = CGRectMake(ScreenHeight/15,ScreenHeight-ScreenHeight/3.3, ScreenWidth/20, ScreenWidth/20);
    [rightBtn addTarget:self action:@selector(rightBrnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:rightBtn];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenHeight/15 +ScreenWidth/20, ScreenHeight-ScreenHeight/3.2, ScreenWidth/8, ScreenHeight/20)];
    label.text = @"同意";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    [self.scrollView addSubview:label];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenHeight/15, ScreenHeight-ScreenHeight/3.2 +ScreenHeight/20, ScreenWidth-ScreenHeight/15, ScreenHeight/20)];
    titleLabel.text = @"点击“注册协议“即代表本人已经点击阅读并同意全部内容";
    titleLabel.textColor = SystemGrayColor;
    titleLabel.font = [UIFont systemFontOfSize:10];
    [self.scrollView addSubview:titleLabel];

    
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(ScreenHeight/15, ScreenHeight-ScreenHeight/6, ScreenWidth-ScreenHeight/7.5, ScreenHeight/15);
    [pushBtn setTitle:@"注册" forState:UIControlStateNormal];
    pushBtn.backgroundColor = SystemGreenColor;
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [pushBtn addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:pushBtn];
    
  
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.textFiled.text.length==11 && self.textFiled.tag == 1)
    {
        [self.textFiled resignFirstResponder];
        MBShow
        [HTTPRequest httpWithPost:@"/cus/exist" Param:@{@"phone": self.textFiled.text} Success:^(id obj) {
            if (SUCCESS) {
                MBHide
                _isRegisted=NO;
                if ([[obj valueForKey:@"data"] integerValue]== 1)
                {
                    MBE(@"手机号码已被注册")
                    _isRegisted = YES;
                }
            }
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE_Sys
        }];
    }
    
    [self.view endEditing:YES];
}

-(void)rightBrnClick:(UIButton *)sender
{
    if (!sender.selected)
    {
        [rightBtn setImage:[UIImage imageNamed:@"btn-noagree.png"] forState:UIControlStateNormal];
    }
    else
    {
        [rightBtn setImage:[UIImage imageNamed:@"choice.png"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
    
}
-(void)regiBtnClick
{
    [self.navigationController pushViewController:[[ProtocolVC alloc] init] animated:YES];
}


-(void)getCodeBtnClick
{
    
    [btnLab removeFromSuperview];
    ChooseCityVC *chooseCity = [[ChooseCityVC alloc] init];
    //zou
    chooseCity.isForDocList = NO;
    
    
    if (!chooseCity.ChooseCityBlock) {
        chooseCity.ChooseCityBlock = ^(NSString *strName, NSString *strCode1) {
            [CityBtn setTitle:strName forState:UIControlStateNormal];
            [CityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            CityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            _CityCodeStr = strName;
            _strCityCode = strCode1;
        };
        
    }
    [self.navigationController pushViewController:chooseCity animated:YES];
}

-(void)pushBtnClick
{
    
    if (_isRegisted)
    {
        MBE(@"手机号码已被注册")
               return;
    }
    
    if (!self.textFiled.text.length)
    {
        MBS(@"手机号码为空")
    }
    else if (self.textFiled.text.length>11)
        
    {
        MBS(@"请输入正确的手机号码格式")
    }
    else if (!self.textFiled2.text.length)
    {
        MBS(@"请输入正确的六位数验证码")
    }
    else if (self.textFiled3.text.length<6)
    {
        MBS(@"密码需超过六位")
    }
    else if (!_CityCodeStr.length)
    {
        MBS(@"请选择城市")
    }
    else if (!self.textFiled5.text.length)
    {
        MBS(@"请输入单位名称")
    }
    else if (!self.textFiled6.text.length)
    {
        MBS(@"请输入部门名称")
    }
    else if (rightBtn.selected)
    {
        MBS(@"请勾选注册协议")
    }
    
    
    else {
        MBShow
        NSString *strCode=self.textFiled2.text;
        int verCode = [strCode intValue];
        
        NSLog(@"1=%@2=%@3=%@4=%@5=%@6=%@7=%@",self.textFiled.text,self.textFiled2.text,self.textFiled3.text,self.textFiled5.text,self.textFiled6.text,self.textFiled7.text,_strCityCode);
        NSMutableDictionary *mutabDic = [@{@"phone": self.textFiled.text, @"password": self.textFiled3.text, @"captcha": [NSNumber numberWithInt:verCode],@"location":_strCityCode,@"company":self.textFiled5.text,@"department":self.textFiled6.text}mutableCopy];
        if (self.textFiled7.text.length>0)
        {
            [mutabDic setObject:self.textFiled7.text forKey:@"invite_code"];
        }
        
        
        [HTTPRequest httpWithPost:@"/cus/reg4new" Param:mutabDic Success:^(id obj)
         {
             if (SUCCESS) {
                 MBHide
                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                 [defaults setObject:self.textFiled.text forKey:@"PAUserName"];
                 [defaults setObject:self.textFiled3.text forKey:@"PAPassword"];
                 NSLog(@"self.textFiled.text=%@,self.textFiled.text=%@",self.textFiled.text,self.textFiled3.text);
                 MBS(@"注册成功")
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self.navigationController popViewControllerAnimated:YES];
                 });
             }
             else if ([[obj valueForKey:@"code"] intValue]== 1) {
                 MBHide
                 if ([obj valueForKey:@"desc"]) {
                     MBE([obj valueForKey:@"desc"])
                 }
             }
             else {
                 MBHide
             }
         } Fail:^(NSString *errorMsg) {
             
             NSLog(@"errorMsg=%@",errorMsg);
             MBHide
             MBE_Sys
         }];
    }
    
}


- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
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
    
    
    NSString *strPhoneNum = self.textFiled.text;
    if (strPhoneNum.length==11) {
        MBShow
        [HTTPRequest httpWithPost:@"/cus/captcha" Param:@{@"phone": strPhoneNum} Success:^(id obj) {
            if (SUCCESS) {
                MBHide
                MBS(@"验证码已发送")
                button.enabled = NO;
                _count = 60;
                [button setTitle:@"60秒" forState:UIControlStateDisabled];
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
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



//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self. endEditing:YES];
//    
//}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    NSLog(@"textFieldDidBeginEditing");
//    if (textField ==self.textFiled)
//    {
//        self.smallImg.image = [UIImage imageNamed:@"phone-green"];
//    }
//    else if (textField == self.textFiled2)
//    {
//        self.smallImg2.image = [UIImage imageNamed:@"yanzhengma-green"];
//        
//    }
//    else if (textField == self.textFiled3)
//        
//    {
//        self.smallImg3.image = [UIImage imageNamed:@"mima-green"];
//    }
//    return YES;
//}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    if (textField==self.textFiled)
//    {
//        [self.textFiled resignFirstResponder];
//    }
//    else if (textField==self.textFiled2)
//        
//    {
//        [self.textFiled2 resignFirstResponder];
//    }
//    else if (textField==self.textFiled3)
//        
//    {
//        [self.textFiled3 resignFirstResponder];
//    }
//
//    else if (textField==self.textFiled4)
//        
//    {
//        [self.textFiled4 resignFirstResponder];
//    }
//
//    else if (textField==self.textFiled5)
//        
//    {
//        [self.textFiled5 resignFirstResponder];
//    }
//
//    else if (textField==self.textFiled6)
//        
//    {
//        [self.textFiled6 resignFirstResponder];
//        
//    }
//    else if (textField==self.textFiled7)
//        
//    {
//        [self.textFiled7 resignFirstResponder];
//    }

    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textFiled resignFirstResponder];
    [self.textFiled2 resignFirstResponder];
    [self.textFiled3 resignFirstResponder];
    [self.textFiled4 resignFirstResponder];
    [self.textFiled5 resignFirstResponder];
    [self.textFiled6 resignFirstResponder];
    [self.textFiled7 resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
