//
//
#import "RegistVC.h"
#import "CellRegist.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ProtocolVC.h"
#import "STPickerArea.h"
#import "ChooseCityVC.h"
#import "User.h"
#import "UINavigationItem+ItemCustom.h"
@interface RegistVC ()<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation RegistVC
{
    UIButton *showBtn;
    NSString *_strCityCode;
    NSString *_CityCodeStr;
    NSString *_imagePath;
    //验证码
    NSString *_strVerCode;
    UITextField *_dataTextFile;
    UITextField *_textFSelected;
    //判断手机号码是否已经被注册
    BOOL _isRegisted;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.navigationItem navigationBackWithDelegate:self Action:@selector(btnClick)];
    [self.navigationController.navigationBar setBarTintColor:SYSNAVGETION_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellRegist *cell = [CellRegist cellWithTableView:tableView IndexPath:indexPath];
    
    [cell.textDesc setDelegate:self];
    _dataTextFile = cell.textDesc;
//    [cell.textDesc setReturnKeyType:UIReturnKeyDone];
    [cell.textDesc setTag:(indexPath.row + 1)];
    [cell.btnSubmit addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnIsAgree addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnCamera addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnGetCode addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnRegulation addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
   
    if (iPhone6) {
        [cell.labProtocolTemp setFont:[UIFont systemFontOfSize:11.0]];
    }
    else if (iPhone6P) {
        [cell.labProtocolTemp setFont:[UIFont systemFontOfSize:12.0]];
    }
    else {
        [cell.labProtocolTemp setFont:[UIFont systemFontOfSize:10.0]];
    }
    
    if (indexPath.row ==1)
    {
        [cell.textDesc setKeyboardType:UIKeyboardTypeNumberPad];
        self.imageLeft = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/7, ScreenWidth/21, 20, 20)];
    
        self.imageLeft.tag = 1;
        cell.textDesc.secureTextEntry =NO;
        self.imageLeft.image =[UIImage imageNamed:@"phone-green.png"];
       
        [cell.contentView addSubview:self.imageLeft];

    }
    else if  (indexPath.row ==2)
    {
         [cell.textDesc setKeyboardType:UIKeyboardTypeNumberPad];
        self.imageLeft2 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/7, ScreenWidth/21, 20, 20)];
     
         self.imageLeft2.tag = 2;
        self.imageLeft2.image =[UIImage imageNamed:@"yanzhengma-green"];
        
        [cell.contentView addSubview:self.imageLeft2];
        
    }
    else if  (indexPath.row ==3)
    {
         CellRegist *cell3 = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        self.imageLeft3 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/7, ScreenWidth/21, 20, 20)];
         self.imageLeft3.tag = 3;
        self.imageLeft3.image =[UIImage imageNamed:@"mima-green"];
        
        [cell.contentView addSubview:self.imageLeft3];
       showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showBtn.frame = CGRectMake(ScreenWidth-ScreenHeight/5+ScreenHeight/20 ,15, ScreenHeight/30 , ScreenHeight/30);
        [showBtn setImage:[UIImage imageNamed:@"eye-gray"] forState:UIControlStateNormal];
        [showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell3.textDesc.secureTextEntry = YES;
        [showBtn addTarget:self action:@selector(showBtnClick_reg) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:showBtn];
    }

    else if  (indexPath.row ==4)
    {
        
        [cell.getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.imageLeft4 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/7, ScreenWidth/21, 20, 20)];
         self.imageLeft4.tag = 4;
        self.imageLeft4.image =[UIImage imageNamed:@"dingwei-green"];
        
        [cell.contentView addSubview:self.imageLeft4];
        
    }
    else if  (indexPath.row ==5)
    {
        cell.textDesc.secureTextEntry = NO;
        self.imageLeft5 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/7, ScreenWidth/21, 20, 20)];
         self.imageLeft5.tag = 5;
        self.imageLeft5.image =[UIImage imageNamed:@"danwei-green"];
        
        [cell.contentView addSubview:self.imageLeft5];
        
    }

    else if  (indexPath.row ==6)
    {
        cell.textDesc.secureTextEntry = NO;
        self.imageLeft6 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/7, ScreenWidth/21, 20, 20)];
         self.imageLeft6.tag = 6;
        self.imageLeft6.image =[UIImage imageNamed:@"keshi-green"];
        
        [cell.contentView addSubview:self.imageLeft6];
        
    }
    else if  (indexPath.row ==7)
    {
        cell.textDesc.secureTextEntry = NO;
        self.imageLeft7 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/7, ScreenWidth/21, 20, 20)];
         self.imageLeft7.tag = 7;
        self.imageLeft7.image =[UIImage imageNamed:@"yaoqingma-green"];
        [cell.contentView addSubview:self.imageLeft7];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenHeight/5+ScreenHeight/15, 0, 50, 50)];
        label.text = @"选填";
        label.textColor = [UIColor colorWithRed:199.0/255.0 green:131.0/255.0 blue:31.0/255.0 alpha:1.00];
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
        
    }

    
    return cell;
}

//获取地理位置按钮点击事件
-(void)getCodeBtnClick
{
 
    CellRegist *cell = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    ChooseCityVC *chooseCity = [[ChooseCityVC alloc] init];
    //zou
    chooseCity.isForDocList = NO;
    
    
    if (!chooseCity.ChooseCityBlock) {
        chooseCity.ChooseCityBlock = ^(NSString *strName, NSString *strCode1) {
            [cell.getCodeBtn setTitle:strName forState:UIControlStateNormal];
            _CityCodeStr = strName;
            _strCityCode = strCode1;
        };
        
    }
    [self.navigationController pushViewController:chooseCity animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
-(void)showBtnClick
{
    CellRegist *cell3 = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    cell3.textDesc.secureTextEntry =  !cell3.textDesc.secureTextEntry;
     [showBtn setImage:[UIImage imageNamed:@"eye-green"] forState:UIControlStateNormal];
}

-(void)showBtnClick_reg
{
   CellRegist *cell3 = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell3.textDesc.secureTextEntry = !cell3.textDesc.secureTextEntry;
    if (!cell3.textDesc.secureTextEntry)
    {
         [showBtn setImage:[UIImage imageNamed:@"eye-green"] forState:UIControlStateNormal];
    }
    else
    {
         [showBtn setImage:[UIImage imageNamed:@"eye-gray"] forState:UIControlStateNormal];
    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50.0;
    }
    else if (indexPath.row == 5) {
        return 50.0;
    }
    if (indexPath.row == 2) {
        return 60.0;
    }
    return 50.0;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textFSelected = textField;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    _textFSelected = textField;
//
//     CellRegist *cell1 = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//    [cell1.textDesc setReturnKeyType:UIReturnKeyDone];
//    [cell1.textDesc setKeyboardType:UIKeyboardTypeNumberPad];
//     CellRegist *cell2 = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//     [cell2.textDesc setReturnKeyType:UIReturnKeyDone];
//     [cell2.textDesc setKeyboardType:UIKeyboardTypeNumberPad];
//     if (cell1.textDesc.text.length>11)
//    {
//        MBS(@"手机号码不能超过11位")
//    }
//
//    
//}
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    CellRegist *cell4 = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    cell4.textDesc.secureTextEntry = NO;
    cell4.textDesc.text = text;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_textFSelected.text.length > 2 && _textFSelected.tag == 2)
    {
        [_textFSelected resignFirstResponder];
        MBShow
        [HTTPRequest httpWithPost:@"/cus/exist" Param:@{@"phone": _textFSelected.text} Success:^(id obj) {
            if (SUCCESS) {
                MBHide
                _isRegisted = NO;
                if ([[obj valueForKey:@"data"] integerValue]== 1) {
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


- (void)clickFunc:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            //头像拍照
        {
//            UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
//            [action showInView:self.view];
        }
            break;
        case 2:
            //获取验证码
        {
            [self getCode];
        }
            break;
        case 3:
            //是否阅读协议
        {
            [self clickIsAgree:sender];
        }
            break;
        case 4:
            //协议
        {
            [self clickProtocol];
        }
            break;
        case 5:
            //提交
        {
             [self.view endEditing:YES];
            [self clickRegist];
        }
            break;
        default:
            break;
    }
}

//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    switch (buttonIndex) {
//        case 0: //相机
//            sourceType = UIImagePickerControllerSourceTypeCamera;
//            break;
//        case 1: //相册
//            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            break;
//        default:
//            return;
//            break;
//    }
//    [self openCamara:sourceType];
//}
//
//-(void)openCamara:(UIImagePickerControllerSourceType)sourceType
//{
//    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    BOOL canTakePicture = NO;
//    for (NSString* mediaType in availableMediaTypes) {
//        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
//            //支持拍照
//            canTakePicture = YES;
//            break;
//        }
//    }
//    if (!canTakePicture&&sourceType == UIImagePickerControllerSourceTypeCamera) {
//        NSLog(@"sorry, taking picture is not supported.");
//        return;
//    }
//    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.sourceType = sourceType;
//    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil] ;
//    imagePickerController.allowsEditing = YES;
//    imagePickerController.delegate = self;
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:image];
//    }];
//}
//
//- (void)useImage:(UIImage *)imageChoose
//{
//    CellRegist *cell = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    [cell.btnCamera setBackgroundImage:imageChoose forState:UIControlStateNormal];
//
//    NSData *imageData;
//    if (UIImagePNGRepresentation(imageChoose)) {
//        imageData = UIImagePNGRepresentation(imageChoose);
//    }
//    else {
//        imageData = UIImageJPEGRepresentation(imageChoose, 1.0);
//    }
//
//    if (imageData) {
//        [HTTPRequest httpWithUploadPhoto:imageData Success:^(id obj) {
//            if (!SUCCESS) {
//                MBE(@"上传头像失败")
//            }
//        } Fail:^(NSString *errorMsg) {
//            MBE_Sys
//        }];
//    }
//}

#pragma mark - function

- (void)getCode
{
    if (_isRegisted) {
        MBE(@"手机号码已被注册")
//        return;
    }
    
    CellRegist *cellPhone = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *strPhoneNum = cellPhone.textDesc.text;
    
    if (strPhoneNum.length > 0) {
        MBShow
        [HTTPRequest httpWithPost:@"/cus/captcha" Param:@{@"phone": strPhoneNum} Success:^(id obj) {
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

- (void)clickIsAgree:(UIButton *)sender
{
    CellRegist *cell = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    if (!sender.selected) {
        [cell.imageIsAgree setImage:[UIImage imageWithFile:@"btn-noagree.png"]];
    }
    else {
        [cell.imageIsAgree setImage:[UIImage imageWithFile:@"choice.png"]];
    }
    sender.selected = !sender.selected;
}

- (void)clickRegist
{
    if (_isRegisted)
    {
        MBE(@"手机号码已被注册")
//        return;
    }
    
    CellRegist *cellPhone = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *strPhoneNum = cellPhone.textDesc.text;
    
    CellRegist *cellCode = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *strCode = cellCode.textDesc.text;
    
    CellRegist *cellPass = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString *strPass = cellPass.textDesc.text;
      NSString *strCityCode = _strCityCode;
    
    CellRegist *cellUnit = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
     NSString *strUnit = cellUnit.textDesc.text;
    
    CellRegist *cellAdirme = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
  NSString *strAdirme = cellAdirme.textDesc.text;
    
    CellRegist *cellWeco = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
 NSString *strWeco = cellWeco.textDesc.text;
    CellRegist *cellIsAgree = (CellRegist *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
     NSLog(@"222strPhoneNum.length=%@,strCode.length=%@,strPass.length=%@,strArea=%@,strUnit.length=%@,strAdirme.length=%@",strPhoneNum,strCode,strPass,strCityCode,strUnit,strAdirme);
    if (!strPhoneNum.length)
    {
        MBS(@"请输入正确的手机号码格式")
    }
    else if (strPhoneNum.length>11)
        
    {
        MBS(@"请输入正确的手机号码格式")
    }
    else if (!strCode.length)
    {
        MBS(@"请输入正确的六位数验证码")
    }
    else if (strPass.length<6)
    {
        MBS(@"密码需超过六位")
    }
     else if (!strCityCode.length)
    {
        MBS(@"请选择城市")
    }
     else if (!strUnit.length)
    {
        MBS(@"请输入单位名称")
    }
     else if (!strAdirme.length)
     {
        MBS(@"请输入部门名称")
    }
     else if (cellIsAgree.btnIsAgree.selected)
     {
         MBE(@"请先阅读相关协议")
     }
    
    else {
        MBShow
        int verCode = [strCode intValue];
        NSMutableDictionary *mutabDic = [@{@"phone": strPhoneNum, @"password": strPass, @"captcha": [NSNumber numberWithInt:verCode],@"location":strCityCode,@"company":strUnit,@"department":strAdirme}mutableCopy];
        if (strWeco.length>0)
        {
            [mutabDic setObject:strWeco forKey:@"invite_code"];
        }

       
        [HTTPRequest httpWithPost:@"/cus/reg4new" Param:mutabDic Success:^(id obj)
        {
            if (SUCCESS) {
                MBHide
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:strPhoneNum forKey:@"PAUserName"];
                [defaults setObject:strPass forKey:@"PAPassword"];
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

- (void)clickProtocol
{
    [self.navigationController pushViewController:[[ProtocolVC alloc] init] animated:YES];
}
@end





