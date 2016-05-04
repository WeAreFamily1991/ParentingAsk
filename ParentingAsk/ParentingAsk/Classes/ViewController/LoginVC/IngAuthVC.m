//
//  IngAuthVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/4/13.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "IngAuthVC.h"
#import "UINavigationItem+ItemCustom.h"
#define HEIGHT_LINE HEIGHT+ScreenHeight/20 +ScreenHeight/20+ ScreenHeight/20
#define HEIGHT ScreenHeight/15+64+ScreenHeight/6
@interface IngAuthVC ()
{
    NSString *imgName1,*imgName2,*imgName3,*imgName4,*imgName5;
}
@property(strong,nonatomic)UIImageView *headIMG, *identifyIMG,*doctorIMG,*dcoTWOIMG,*otherIMG;
@property(strong,nonatomic)UILabel *nameLab ,*identityLab,* doctorLab;
@end

@implementation IngAuthVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self HTTPPOST];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self HTTPPOST];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"资格审核";
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    [self GreatView];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    
}

-(void)HTTPPOST
{
    [HTTPRequest httpWithGet:@"/cus/detail" Param:@{} Success:^(id obj) {
        if (SUCCESS) {
            
            
            
            
            
            if ([[[obj valueForKey:@"data"] valueForKey:@"validateStatus"] isEqual:[NSNumber numberWithInt:0]])
            {
                NSLog(@"得到obj =%@",obj);
                
                NSString *nameStr  =[[obj valueForKey:@"data"] valueForKey:@"card_name"];
                NSString *identStr =[[obj valueForKey:@"data"] valueForKey:@"card_num"];
                NSString *doctorStr =[[obj valueForKey:@"data"] valueForKey:@"cer_no"];
                if (![nameStr isEqual:[NSNull null]])
                {
                    self.nameLab.text = nameStr;
                }
                
                if (![identStr isEqual:[NSNull null]])
                {
                    self.identityLab.text = identStr;
                }
                if (![doctorStr isEqual:[NSNull null]])
                {
                    self.doctorLab.text = doctorStr;
                }
                NSString *headStr =[[obj valueForKey:@"data"] valueForKey:@"headurl"];
                if (![headStr isEqual:[NSNull null]])
                {
                    self.headIMG.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headStr]]];
                }
                NSString *cardStr =[[obj valueForKey:@"data"] valueForKey:@"cardurl"];
                if (![cardStr isEqual:[NSNull null]])
                {
                    self.identifyIMG.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cardStr]]];
                }
                
                NSString *cerurlStr =[[obj valueForKey:@"data"] valueForKey:@"cerurl_front"];
                if (![cerurlStr isEqual:[NSNull null]])
                {
                    self.doctorIMG.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cerurlStr]]];
                }
                
                NSString *cerurlBackStr =[[obj valueForKey:@"data"] valueForKey:@"cerurl_back"];
                if (![cerurlBackStr isEqual:[NSNull null]])
                {
                    self.dcoTWOIMG.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cerurlBackStr]]];
                }
                NSString *othStr =[[obj valueForKey:@"data"] valueForKey:@"othurl"];
                if (![othStr isEqual:[NSNull null]])
                {
                    self.otherIMG.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:othStr]]];
                }
                NSString *img1Str  =[[obj valueForKey:@"data"] valueForKey:@"headurl"];
                NSString *img2Str =[[obj valueForKey:@"data"] valueForKey:@"cardurl"];
                NSString *img3Str =[[obj valueForKey:@"data"] valueForKey:@"cerurl_front"];
                
                NSString *img4Str =[[obj valueForKey:@"data"] valueForKey:@"cerurl_back"];
                
                NSString *img5Str =[[obj valueForKey:@"data"] valueForKey:@"othurl"];
                if (![img1Str isEqual:[NSNull null]])
                {
                    imgName1 = img1Str;
                }
                if (![img2Str isEqual:[NSNull null]])
                {
                    imgName2 = img2Str;
                }
                if (![img3Str isEqual:[NSNull null]])
                {
                    imgName3 = img3Str;
                }
                if (![img4Str isEqual:[NSNull null]])
                {
                    imgName4 = img4Str;
                }
                if (![img5Str isEqual:[NSNull null]])
                {
                    imgName5 = img5Str;
                }
                
                
                //            self.identityLab.text=[[obj valueForKey:@"data"] valueForKey:@"card_num"];
                //            self.doctorLab.text = [[obj valueForKey:@"data"] valueForKey:@"cer_no"];
                //
                //            self.headIMG.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"headurl"]]]];
                //            imgName1 =[[obj valueForKey:@"data"] valueForKey:@"headurl"];
                //            self.identifyIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"cardurl"]]]];
                //            imgName2 =[[obj valueForKey:@"data"] valueForKey:@"cardurl"];
                //            self.doctorIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"cerurl_front"]]]];
                //            imgName3 =[[obj valueForKey:@"data"] valueForKey:@"cerurl_front"];
                //            self.dcoTWOIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"cerurl_back"]]]];
                //            imgName4 =[[obj valueForKey:@"data"] valueForKey:@"cerurl_back"];
                //            self.otherIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"othurl"]]]];
                //            imgName5 =[[obj valueForKey:@"data"] valueForKey:@"othurl"];
                //
                
                MBHide
                
            }
            
        }
        else {
            MBHide
            MESSAGE
        }
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE(@"数据LOSE")
    }];
    
}
#pragma mark 按钮返回点击事件
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 创建控件
-(void)GreatView
{
    //lab1
    UILabel *topLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 1)];
    topLab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:topLab];
    //审核状态
    UILabel *authLAB = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4, 64, ScreenWidth/4, ScreenHeight/15)];
    ;
    authLAB.text =@"审核状态:";
    authLAB.textColor = [UIColor blackColor];
    authLAB.font = [UIFont systemFontOfSize:15];
    authLAB.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:authLAB];
    
    UILabel *authLAB1 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 64, ScreenWidth/2, ScreenHeight/15)];
    
    authLAB1.text =@"正在审核";
    authLAB1.textColor = SystemGreenColor;
    authLAB1.font = [UIFont systemFontOfSize:14];
    authLAB1.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:authLAB1];
    
    
    UILabel *med4Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/15 +64, ScreenWidth, 1)];
    med4Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med4Lab];
    
    
    self.headIMG= [[UIImageView alloc]init];
    
    [self.headIMG setUserInteractionEnabled:YES];
    self.headIMG.frame =CGRectMake(ScreenWidth/3, ScreenHeight/100+ScreenHeight/15 +64, ScreenHeight/9, ScreenHeight/9);
    [self.view addSubview:self.headIMG];
    
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/15 +64, ScreenWidth/4, ScreenHeight/6)];
    leftLab.text =@"头像";
    //    leftLab.numberOfLines = 0;
    leftLab.textColor = SystemGrayColor;
    leftLab.font = [UIFont systemFontOfSize:14];
    leftLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:leftLab];
    
    //lab5
    UILabel *med5Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT, ScreenWidth, 1)];
    med5Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med5Lab];
    
    UILabel *leftLab5 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT, ScreenWidth/4, ScreenHeight/20)];
    leftLab5.text =@"姓名";
    //    leftLab.numberOfLines = 0;
    leftLab5.textColor = SystemGrayColor;
    leftLab5.font = [UIFont systemFontOfSize:14];
    leftLab5.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:leftLab5];
    
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, HEIGHT, ScreenWidth/2, ScreenHeight/20)];
    //    self.nameLab.text =@"姓名";
    //    leftLab.numberOfLines = 0;
    self.nameLab.textColor = SystemGrayColor;
    self.nameLab.font = [UIFont systemFontOfSize:14];
    self.nameLab.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:self.nameLab];
    
    
    //lab6
    UILabel *med6Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT+ScreenHeight/20, ScreenWidth, 1)];
    med6Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med6Lab];
    
    UILabel *leftLab6 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT+ScreenHeight/20, ScreenWidth/4, ScreenHeight/20)];
    leftLab6.text =@"身份证";
    //    leftLab.numberOfLines = 0;
    leftLab6.textColor = SystemGrayColor;
    leftLab6.font = [UIFont systemFontOfSize:14];
    leftLab6.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:leftLab6];
    
    
    self.identityLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, HEIGHT+ScreenHeight/20, ScreenWidth/2, ScreenHeight/20)];
    //    self.nameLab.text =@"姓名";
    //    leftLab.numberOfLines = 0;
    self.identityLab.textColor = SystemGrayColor;
    self.identityLab.font = [UIFont systemFontOfSize:14];
    self.identityLab.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:self.identityLab];
    
    
    
    
    //lab7
    UILabel *med7Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT+ScreenHeight/20 +ScreenHeight/20, ScreenWidth, 1)];
    med7Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med7Lab];
    
    UILabel *leftLab7 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT+ScreenHeight/20 +ScreenHeight/20, ScreenWidth/4, ScreenHeight/20)];
    leftLab7.text =@"从业资格证";
    //    leftLab.numberOfLines = 0;
    leftLab7.textColor = SystemGrayColor;
    leftLab7.font = [UIFont systemFontOfSize:14];
    leftLab7.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:leftLab7];
    
    
    
    self.doctorLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3, HEIGHT+ScreenHeight/20 +ScreenHeight/20, ScreenWidth/2, ScreenHeight/20)];
    //    self.nameLab.text =@"姓名";
    //    leftLab.numberOfLines = 0;
    self.doctorLab.textColor = SystemGrayColor;
    self.doctorLab.font = [UIFont systemFontOfSize:14];
    self.doctorLab.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:self.doctorLab];
    
    //lab8
    UILabel *med8Lab = [[UILabel alloc]initWithFrame:CGRectMake(0,HEIGHT_LINE,ScreenWidth,1)];
    med8Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med8Lab];
    
    UILabel *leftLab8 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT_LINE, ScreenWidth/4, ScreenHeight/6)];
    leftLab8.text =@"证件照片";
    //    leftLab.numberOfLines = 0;
    leftLab8.textColor = SystemGrayColor;
    leftLab8.font = [UIFont systemFontOfSize:14];
    leftLab8.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:leftLab8];
    //身份证按钮
    self.identifyIMG = [[UIImageView alloc]init];
    [self.identifyIMG setUserInteractionEnabled:YES];
    
    self.identifyIMG.frame =CGRectMake(ScreenWidth/3, HEIGHT_LINE +ScreenHeight/100, ScreenHeight/9, ScreenHeight/9);
    [self.view addSubview: self.identifyIMG];
    
    //身份证lab
    UILabel *identLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3.2,  HEIGHT_LINE +ScreenHeight/100 + ScreenHeight/9, ScreenWidth/4, ScreenHeight/20)];
    identLab.text =@"身份证";
    identLab.textColor = SystemGrayColor;
    identLab.font = [UIFont systemFontOfSize:12];
    identLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:identLab];
    //执业医师证按钮
    self.doctorIMG = [[UIImageView alloc]init];
    [self.doctorIMG setUserInteractionEnabled:YES];
    self.doctorIMG.frame =CGRectMake( 2* ScreenWidth/3, HEIGHT_LINE +ScreenHeight/100, ScreenHeight/9, ScreenHeight/9);
    [self.view addSubview:self.doctorIMG];
    
    
    UILabel *doctorLab = [[UILabel alloc]initWithFrame:CGRectMake( ScreenWidth/1.9,  HEIGHT_LINE +ScreenHeight/100 + ScreenHeight/9, ScreenWidth/2, ScreenHeight/20)];
    doctorLab.text =@"执业医师证(照片页)";
    doctorLab.textColor = SystemGrayColor;
    doctorLab.font = [UIFont systemFontOfSize:12];
    doctorLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:doctorLab];
    //lab9
    UILabel *med9Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT_LINE +ScreenHeight/6, ScreenWidth, 1)];
    med9Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med9Lab];
    UILabel *leftLab9 = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT_LINE +ScreenHeight/6, ScreenWidth/4, ScreenHeight/6)];
    leftLab9.text =@"证件照片";
    //    leftLab.numberOfLines = 0;
    leftLab9.textColor = SystemGrayColor;
    leftLab9.font = [UIFont systemFontOfSize:14];
    leftLab9.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:leftLab9];
    
    //执业医师证（2）
    self.dcoTWOIMG = [[UIImageView alloc]init];
    [self.dcoTWOIMG setUserInteractionEnabled:YES];
    self.dcoTWOIMG.frame =CGRectMake(ScreenWidth/3, HEIGHT_LINE +ScreenHeight/6 +ScreenHeight/100, ScreenHeight/9, ScreenHeight/9);
    [self.view addSubview:self.dcoTWOIMG];
    UILabel *doctor2Lab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4.9,  HEIGHT_LINE +ScreenHeight/6 +ScreenHeight/100 + ScreenHeight/9, ScreenWidth/2, ScreenHeight/20)];
    doctor2Lab.text =@"执业医师证(姓名页)";
    doctor2Lab.textColor = SystemGrayColor;
    doctor2Lab.font = [UIFont systemFontOfSize:12];
    doctor2Lab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:doctor2Lab];
    //其他证书
    self.otherIMG = [[UIImageView alloc]init];
    [self.otherIMG setUserInteractionEnabled:YES];
    self.otherIMG.frame =CGRectMake( 2*ScreenWidth/3, HEIGHT_LINE +ScreenHeight/6 +ScreenHeight/100, ScreenHeight/9, ScreenHeight/9);
    [self.view addSubview:self.otherIMG];
    
    UILabel *otherLab = [[UILabel alloc]initWithFrame:CGRectMake(2 * ScreenWidth/3.1,  HEIGHT_LINE +ScreenHeight/6 +ScreenHeight/100 + ScreenHeight/9, ScreenWidth/4, ScreenHeight/20)];
    otherLab.text =@"其他证件证书";
    otherLab.textColor = SystemGrayColor;
    otherLab.font = [UIFont systemFontOfSize:12];
    otherLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:otherLab];
    //LAB10
    UILabel *med10Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT_LINE +ScreenHeight/6 +ScreenHeight/6, ScreenWidth, 1)];
    med10Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med10Lab];
    
    //lab11
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4, 64 +ScreenHeight/15, 1, HEIGHT_LINE +ScreenHeight/6 +ScreenHeight/6 -64 -ScreenHeight/15)];
    lineLab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:lineLab];
    
    
    
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
