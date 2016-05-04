//
//  BackVC.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/4/13.
//  Copyright © 2016年 Jerry. All rights reserved.
//
typedef NS_ENUM(NSInteger, PhotoType)
{
    PhotoTypeRectangle0,
    PhotoTypeRectangle1,
    PhotoTypeRectangle2,
    PhotoTypeRectangle3,
    PhotoTypeRectangle4
};
#define HEIGHT_LINE HEIGHT+ScreenHeight/20 +ScreenHeight/20+ ScreenHeight/20
#define HEIGHT  ScreenHeight/10 +ScreenHeight/11+ScreenHeight/15 + ScreenHeight/20 +64
#import "UINavigationItem+ItemCustom.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"
#import "BackVC.h"

@interface BackVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, STPhotoKitDelegate>
{
    NSString *reasonStr;
    NSString *imgCode,*imgCode2,*imgCode3,*imgCode4,*imgCode5;
    NSString *imgName1,*imgName2,*imgName3,*imgName4,*imgName5;
}
@property(strong,nonatomic)UILabel *nameLab ,*identityLab,* doctorLab;
@property(strong,nonatomic)UITextField *nameTF,*identifyTF,*LOCATF;
@property(strong,nonatomic)UIImageView *headIMG, *identifyIMG,*doctorIMG,*dcoTWOIMG,*otherIMG;
@property(strong,nonatomic)UIImage *upLoadIMG1, *upLoadIMG2,*upLoadIMG3,*upLoadIMG4,*upLoadIMG5;
@property (nonatomic, assign) PhotoType type;
@end

@implementation BackVC


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self httpREQUEST];
    
    
}
-(void)httpREQUEST
{
    [HTTPRequest httpWithGet:@"/cus/detail" Param:@{} Success:^(id obj) {
        if (SUCCESS) {
            
            NSLog(@"得到obj =%@",obj);
            if ([[[obj valueForKey:@"data"] valueForKey:@"validateStatus"] isEqual:[NSNumber numberWithInt:2]])
            {
                
                
                NSString *nameStr  =[[obj valueForKey:@"data"] valueForKey:@"card_name"];
                NSString *identStr =[[obj valueForKey:@"data"] valueForKey:@"card_num"];
                NSString *doctorStr =[[obj valueForKey:@"data"] valueForKey:@"cer_no"];
                if (![nameStr isEqual:[NSNull null]])
                {
                    self.nameTF.text = nameStr;
                }
                
                if (![identStr isEqual:[NSNull null]])
                {
                    self.identifyTF.text = identStr;
                }
                if (![doctorStr isEqual:[NSNull null]])
                {
                    self.LOCATF.text = doctorStr;
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
                NSString *img1Str  =[[obj valueForKey:@"data"] valueForKey:@"headurl_name"];
                NSString *img2Str =[[obj valueForKey:@"data"] valueForKey:@"cardurl_name"];
                NSString *img3Str =[[obj valueForKey:@"data"] valueForKey:@"cerurl_front_name"];
                NSString *img4Str =[[obj valueForKey:@"data"] valueForKey:@"cerurl_back_name"];
                NSString *img5Str =[[obj valueForKey:@"data"] valueForKey:@"othurl_name"];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self httpREQUEST];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    [self GreatView];
    self.title = @"资格审核";
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedRectangle0)];
    [self.headIMG addGestureRecognizer:tap0];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedRectangle1)];
    [self.identifyIMG addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedRectangle2)];
    [self.doctorIMG addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedRectangle3)];
    [self.dcoTWOIMG addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedRectangle4)];
    [self.otherIMG addGestureRecognizer:tap4];
    
}
-(void)selectedRectangle0
{
    self.type =PhotoTypeRectangle0;
    [self editImageSelected];
}

-(void)selectedRectangle1
{
    self.type =PhotoTypeRectangle1;
    [self editImageSelected];
}

-(void)selectedRectangle2
{
    self.type =PhotoTypeRectangle2;
    [self editImageSelected];
}

-(void)selectedRectangle3
{
    self.type =PhotoTypeRectangle3;
    [self editImageSelected];
}

-(void)selectedRectangle4
{
    self.type =PhotoTypeRectangle4;
    [self editImageSelected];
}
#pragma mark - --- delegate 视图委托 ---

#pragma mark - 1.STPhotoKitDelegate的委托

- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
    
    switch (self.type) {
        case PhotoTypeRectangle0:
            self.upLoadIMG1 = resultImage;
            NSLog(@" self.upLoadIMG1.image=%@", self.upLoadIMG1);
            [self uploadHeadImg];
            
            
            break;
        case PhotoTypeRectangle1:
            self.upLoadIMG2 = resultImage;
            [self uploadHeadImg1];
            break;
        case PhotoTypeRectangle2:
            self.upLoadIMG3 = resultImage;
            [self uploadHeadImg2];
            break;
        case PhotoTypeRectangle3:
            self.upLoadIMG4 = resultImage;
            [self uploadHeadImg3];
            break;
        case PhotoTypeRectangle4:
            self.upLoadIMG5 = resultImage;
            [self uploadHeadImg4];
            break;
        default:
            break;
    }
}

//
-(void)uploadHeadImg
{
    NSData *imageData;
    if (UIImagePNGRepresentation(self.upLoadIMG1) == nil) {
        
        imageData = UIImageJPEGRepresentation(self.upLoadIMG1, 1);
        
    } else {
        
        imageData = UIImagePNGRepresentation(self.upLoadIMG1);
    }
    NSLog(@"self.upLoadIMG1.image=%@",self.upLoadIMG1);
    if (imageData) {
        NSLog(@"imageData=%@",imageData);
        [HTTPRequest httpWithUploadPhoto:imageData Success:^(id obj) {
            if (!SUCCESS) {
                MBE(@"上传头像失败")
            }
            else if (SUCCESS)
            {
                NSLog(@"imageData=%@",obj);
                //                imageData = [[obj valueForKey:@"data"] valueForKey:@"path"];
                //              self.headIMG.image = [[obj valueForKey:@"data"] valueForKey:@"name"];
                
                MBHide
                self.headIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"path"]]]];
                imgCode = [obj valueForKey:@"code"];
                //PhotoTypeRectangle0 = imageData;
                imgName1 =[[obj valueForKey:@"data"]valueForKey:@"name"];
            }
        } Fail:^(NSString *errorMsg) {
            MBE_Sys
        }];
    }
    
}

-(void)uploadHeadImg1
{
    NSData *imageData;
    if (UIImagePNGRepresentation(self.upLoadIMG2) == nil) {
        
        imageData = UIImageJPEGRepresentation(self.upLoadIMG2, 1);
        
    } else {
        
        imageData = UIImagePNGRepresentation(self.upLoadIMG2);
    }
    NSLog(@"self.upLoadIMG1.image=%@",self.upLoadIMG2);
    if (imageData) {
        NSLog(@"imageData=%@",imageData);
        [HTTPRequest httpWithUploadPhoto:imageData Success:^(id obj) {
            if (!SUCCESS) {
                MBE(@"上传头像失败")
            }
            else if (SUCCESS)
            {
                NSLog(@"imageData=%@",obj);
                //                imageData = [[obj valueForKey:@"data"] valueForKey:@"path"];
                //              self.headIMG.image = [[obj valueForKey:@"data"] valueForKey:@"name"];
                
                MBHide
                self.identifyIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"path"]]]];
                imgCode2 = [obj valueForKey:@"code"];
                imgName2 =[[obj valueForKey:@"data"]valueForKey:@"name"];
                //PhotoTypeRectangle0 = imageData;
                
            }
        } Fail:^(NSString *errorMsg) {
            MBE_Sys
        }];
    }
    
}



-(void)uploadHeadImg2
{
    NSData *imageData;
    if (UIImagePNGRepresentation(self.upLoadIMG3) == nil) {
        
        imageData = UIImageJPEGRepresentation(self.upLoadIMG3, 1);
        
    } else {
        
        imageData = UIImagePNGRepresentation(self.upLoadIMG3);
    }
    NSLog(@"self.upLoadIMG1.image=%@",self.upLoadIMG3);
    if (imageData) {
        NSLog(@"imageData=%@",imageData);
        [HTTPRequest httpWithUploadPhoto:imageData Success:^(id obj) {
            if (!SUCCESS) {
                MBE(@"上传头像失败")
            }
            else if (SUCCESS)
            {
                NSLog(@"imageData=%@",obj);
                //                imageData = [[obj valueForKey:@"data"] valueForKey:@"path"];
                //              self.headIMG.image = [[obj valueForKey:@"data"] valueForKey:@"name"];
                
                MBHide
                self.doctorIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"path"]]]];
                imgCode3 = [obj valueForKey:@"code"];
                imgName3 =[[obj valueForKey:@"data"]valueForKey:@"name"];
                //PhotoTypeRectangle0 = imageData;
                
            }
        } Fail:^(NSString *errorMsg) {
            MBE_Sys
        }];
    }
    
}



-(void)uploadHeadImg3
{
    NSData *imageData;
    if (UIImagePNGRepresentation(self.upLoadIMG4) == nil) {
        
        imageData = UIImageJPEGRepresentation(self.upLoadIMG4, 1);
        
    } else {
        
        imageData = UIImagePNGRepresentation(self.upLoadIMG4);
    }
    NSLog(@"self.upLoadIMG1.image=%@",self.upLoadIMG4);
    if (imageData) {
        NSLog(@"imageData=%@",imageData);
        [HTTPRequest httpWithUploadPhoto:imageData Success:^(id obj) {
            if (!SUCCESS) {
                MBE(@"上传头像失败")
            }
            else if (SUCCESS)
            {
                NSLog(@"imageData=%@",obj);
                //                imageData = [[obj valueForKey:@"data"] valueForKey:@"path"];
                //              self.headIMG.image = [[obj valueForKey:@"data"] valueForKey:@"name"];
                
                MBHide
                self.dcoTWOIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"path"]]]];
                imgCode4 = [obj valueForKey:@"code"];
                imgName4 =[[obj valueForKey:@"data"]valueForKey:@"name"];
                //PhotoTypeRectangle0 = imageData;
                
            }
        } Fail:^(NSString *errorMsg) {
            MBE_Sys
        }];
    }
    
}


-(void)uploadHeadImg4
{
    NSData *imageData;
    if (UIImagePNGRepresentation(self.upLoadIMG5) == nil) {
        
        imageData = UIImageJPEGRepresentation(self.upLoadIMG5, 1);
        
    } else {
        
        imageData = UIImagePNGRepresentation(self.upLoadIMG5);
    }
    NSLog(@"self.upLoadIMG1.image=%@",self.upLoadIMG5);
    if (imageData) {
        NSLog(@"imageData=%@",imageData);
        [HTTPRequest httpWithUploadPhoto:imageData Success:^(id obj) {
            if (!SUCCESS) {
                MBE(@"上传头像失败")
            }
            else if (SUCCESS)
            {
                NSLog(@"imageData=%@",obj);
                //                imageData = [[obj valueForKey:@"data"] valueForKey:@"path"];
                //              self.headIMG.image = [[obj valueForKey:@"data"] valueForKey:@"name"];
                
                MBHide
                self.otherIMG.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[obj valueForKey:@"data"] valueForKey:@"path"]]]];
                imgCode5 = [obj valueForKey:@"code"];
                imgName5 =[[obj valueForKey:@"data"] valueForKey:@"name"];
                //PhotoTypeRectangle0 = imageData;
                
            }
        } Fail:^(NSString *errorMsg) {
            MBE_Sys
        }];
    }
    
}

#pragma mark - 2.UIImagePickerController的委托

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        STPhotoKitController *photoVC = [STPhotoKitController new];
        [photoVC setDelegate:self];
        [photoVC setImageOriginal:imageOriginal];
        switch (self.type) {
            case PhotoTypeRectangle0:
                [photoVC setSizeClip:CGSizeMake(self.headIMG.width*2, self.headIMG.height*2)];
                break;
            case PhotoTypeRectangle1:
                [photoVC setSizeClip:CGSizeMake(self.identifyIMG.width*2, self.identifyIMG.height*2)];
                break;
            case PhotoTypeRectangle2:
                [photoVC setSizeClip:CGSizeMake(self.doctorIMG.width*2, self.doctorIMG.height*2)];
                break;
            case PhotoTypeRectangle3:
                [photoVC setSizeClip:CGSizeMake(self.dcoTWOIMG.width*2, self.dcoTWOIMG.height*2)];
                break;
            case PhotoTypeRectangle4:
                [photoVC setSizeClip:CGSizeMake(self.otherIMG.width*2, self.otherIMG.height*2)];
                break;
            default:
                break;
        }
        
        
        [self presentViewController:photoVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - --- event response 事件相应 ---
- (void)editImageSelected
{
    UIAlertController *alertController = [[UIAlertController alloc]init];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        
        if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
            [controller setDelegate:self];
            [self presentViewController:controller animated:YES completion:nil];
        }else {
            NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
        }
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [controller setDelegate:self];
        if ([controller isAvailablePhotoLibrary]) {
            [self presentViewController:controller animated:YES completion:nil];
        }    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 创建界面
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
    
    authLAB1.text =@"审核未通过";
    authLAB1.textColor = SystemGreenColor;
    authLAB1.font = [UIFont systemFontOfSize:14];
    authLAB1.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:authLAB1];
    
    
    //lab2
    UILabel *medLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/15 +64, ScreenWidth, 1)];
    medLab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:medLab];
    
    UILabel *resonLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/15 +64, ScreenWidth/4, ScreenHeight/11)];
    resonLab.text =@"原因";
    resonLab.textColor = SystemGrayColor;
    resonLab.font = [UIFont systemFontOfSize:14];
    resonLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:resonLab];
    
    
    
    UILabel *resonRigLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4, ScreenHeight/15 +64, ScreenWidth-ScreenWidth/4, ScreenHeight/11)];
    resonRigLab.text =self.reasonStr;
    resonRigLab.numberOfLines = 0;
    resonRigLab.textColor = SystemGrayColor;
    resonRigLab.font = [UIFont systemFontOfSize:13];
    resonRigLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:resonRigLab];
    
    
    //lab3
    UILabel *med3Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/15 +ScreenHeight/11 +64, ScreenWidth, 1)];
    med3Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med3Lab];
    
    
    
    
    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4, ScreenHeight/15 +64+ScreenHeight/11, ScreenWidth/2, ScreenHeight/20)];
    titLab.text =@"您可以重新上传认证资料:";
    titLab.textColor = [UIColor blackColor];
    titLab.font = [UIFont systemFontOfSize:13];
    titLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titLab];
    
    UIButton *titBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titBtn.backgroundColor =SystemGreenColor;
    [titBtn setTitle:@"认证说明" forState:UIControlStateNormal];
    titBtn.layer.cornerRadius = ScreenWidth/80;
    titBtn.layer.masksToBounds = ScreenWidth/80;
    titBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [titBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titBtn.frame =CGRectMake(3 * ScreenWidth/4, ScreenHeight/15 +64+ScreenHeight/10, ScreenWidth/5, ScreenHeight/30);
    [self.view addSubview:titBtn];
    //lab4
    UILabel *med4Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/20 +ScreenHeight/11+ScreenHeight/15 +64, ScreenWidth, 1)];
    med4Lab.backgroundColor =SYSCOLOR_LINE;
    [self.view addSubview:med4Lab];
    
    
    self.headIMG= [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"headsquare"]];
    
    [self.headIMG setUserInteractionEnabled:YES];
    self.headIMG.frame =CGRectMake(ScreenWidth/3.5, ScreenHeight/20 +ScreenHeight/10.5+ScreenHeight/15 +64, ScreenHeight/11, ScreenHeight/11);
    [self.view addSubview:self.headIMG];
    
    
    UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/20 +ScreenHeight/10.5+ScreenHeight/15 +64, ScreenWidth/4, ScreenHeight/11)];
    leftLab.text =@"头像";
    //    leftLab.numberOfLines = 0;
    leftLab.textColor = SystemGrayColor;
    leftLab.font = [UIFont systemFontOfSize:14];
    leftLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:leftLab];
    
    UILabel *RigLab = [[UILabel alloc]initWithFrame:CGRectMake( 2*ScreenWidth/3, ScreenHeight/20 +ScreenHeight/10.5+ScreenHeight/15 +64, ScreenWidth/20, ScreenHeight/11)];
    RigLab.text =@"示例";
    RigLab.numberOfLines = 0;
    RigLab.textColor = SystemGrayColor;
    RigLab.font = [UIFont systemFontOfSize:12];
    RigLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:RigLab];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shili"]];
    img.frame = CGRectMake(2*ScreenWidth/3 +ScreenWidth/20, ScreenHeight/20 +ScreenHeight/10.5+ScreenHeight/15 +64, ScreenHeight/11, ScreenHeight/11);
    [self.view addSubview:img];
    
    
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
    
    
    
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/3.7, HEIGHT, ScreenWidth/2, ScreenHeight/20)];
    self.nameTF.placeholder = @"请输入姓名";
    self.nameTF.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.nameTF];
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
    
    self.identifyTF = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/3.7, HEIGHT +ScreenHeight/20, ScreenWidth/2, ScreenHeight/20)];
    self.identifyTF.placeholder = @"请输入身份证号码";
    [self.identifyTF setKeyboardType:UIKeyboardTypeNumberPad];
    self.identifyTF.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.identifyTF];
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
    
    self.LOCATF = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth/3.7, HEIGHT+ScreenHeight/20 +ScreenHeight/20, ScreenWidth/2, ScreenHeight/20)];
    self.LOCATF.placeholder = @"请输入从业资格证号码";
    self.LOCATF.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.LOCATF];
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
    self.identifyIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headsquare"]];
    [self.identifyIMG setUserInteractionEnabled:YES];
    
    self.identifyIMG.frame =CGRectMake(ScreenWidth/3, HEIGHT_LINE +ScreenHeight/100, ScreenHeight/9, ScreenHeight/9);
    [self.view addSubview: self.identifyIMG];
    
    //身份证lab
    UILabel *identLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/3.5,  HEIGHT_LINE +ScreenHeight/100 + ScreenHeight/9, ScreenWidth/4, ScreenHeight/20)];
    identLab.text =@"身份证";
    identLab.textColor = SystemGrayColor;
    identLab.font = [UIFont systemFontOfSize:12];
    identLab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:identLab];
    //执业医师证按钮
    self.doctorIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headsquare"]];
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
    self.dcoTWOIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headsquare"]];
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
    self.otherIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headsquare"]];
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
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame =CGRectMake(ScreenWidth/10, ScreenHeight-ScreenHeight/12, ScreenWidth/3, ScreenHeight/20);
    [saveBtn setTitle:@"保存资料" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    saveBtn.layer.cornerRadius = ScreenWidth/80;
    saveBtn.layer.masksToBounds = ScreenWidth/80;
    [saveBtn setBackgroundColor:SystemGreenColor];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    
    UIButton *authBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    authBtn.frame =CGRectMake(ScreenWidth/2 +ScreenWidth/18, ScreenHeight-ScreenHeight/12, ScreenWidth/3, ScreenHeight/20);
    [authBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    authBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    authBtn.layer.cornerRadius = ScreenWidth/80;
    authBtn.layer.masksToBounds = ScreenWidth/80;
    [authBtn setBackgroundColor:SystemGreenColor];
    [authBtn addTarget:self action:@selector(authBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [authBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:authBtn];
    
    
}
//保存按钮
-(void)saveBtnClick
{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    if (self.nameTF.text.length>0)
    {
        [mutableDic setObject:self.nameTF.text forKey:@"card_name"];
    }
    if (self.identifyTF.text.length>0)
    {
        [mutableDic setObject:self.identifyTF.text forKey:@"card_num"];
    }
    if (self.LOCATF.text.length>0)
    {
        [mutableDic setObject:self.LOCATF.text forKey:@"cer_no"];
    }
    if (imgName1.length>0)
    {
        [mutableDic setObject:imgName1 forKey:@"headurl"];
    }
    if (imgName2.length>0)
    {
        [mutableDic setObject:imgName2 forKey:@"cardurl"];
    }
    if (imgName3.length>0)
    {
        [mutableDic setObject:imgName3 forKey:@"cerurl_front"];
    }
    if (imgName4.length>0)
    {
        [mutableDic setObject:imgName4 forKey:@"cerurl_back"];
    }
    if (imgName5.length>0)
    {
        [mutableDic setObject:imgName5 forKey:@"othurl"];
    }
    
    
    
    [HTTPRequest httpWithPost:@"/cus/saveInfo" Param:mutableDic Success:^(id obj) {
        if (SUCCESS) {
            
            NSLog(@"保存obj =%@",obj);
            
            MBHide
            MBS(@"保存成功")
        }
        else {
            MBHide
            MESSAGE
        }
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE(@"保存失败")
    }];
    
    
    
    
}
//提交审核按钮
-(void)authBtnClick
{
    //    if ([imgCode isEqual:@"0"]||[imgCode2 isEqual:@"0"]||[imgCode3 isEqual:@"0"])
    //    {
    
    //    if (self.nameTF.text.length==0||self.identifyTF.text.length==0||self.LOCATF.text.length==0||imgName1.length ==0||imgName2.length ==0||imgName3.length ==0)
    //    {
    //        MBS(@"请完善相关资料")
    //    }
    if (imgName1.length ==0)
    {
        MBS(@"请上传头像")
    }
    else if (self.nameTF.text.length==0)
    {
        MBS(@"请填写用户名")
    }
    else if (self.identifyTF.text.length==0)
    {
        MBS(@"请填写身份号码")
    }
    else if (self.LOCATF.text.length==0)
    {
        MBS(@"请填写医生从业资格证编号")
    }
    
    
    else if (imgName2.length ==0)
    {
        MBS(@"请上传身份证照片")
    }
    else if (imgName3.length ==0)
    {
        MBS(@"请上传医生从业资格证照片")
    }
    
    else
        
    {
        
        NSMutableDictionary *mutabDic = [@{@"card_name": self.nameTF.text, @"card_num": self.identifyTF.text, @"cer_no": self.LOCATF.text,@"headurl": imgName1,@"cardurl": imgName2,@"cerurl_front": imgName3}mutableCopy];
        
        if (imgName4.length>0)
        {
            [mutabDic setObject:imgName4 forKey:@"cerurl_back"];
        }
        if (imgName5.length>0) {
            [mutabDic setObject:imgName5 forKey:@"othurl"];
        }
        [HTTPRequest httpWithPost:@"/cus/validate" Param:mutabDic Success:^(id obj) {
            if (SUCCESS) {
                
                NSLog(@"提交obj =%@",obj);
                
                MBHide
                MBS(@"提交成功")
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
                
            }
            else {
                MBHide
                MESSAGE
            }
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE(@"提交失败")
        }];
    }
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
