

#import "PersonalEditVC.h"
#import "CellPersonInfoEdit.h"
#import "EditPasswordVC.h"
#import "User.h"
#import "CellPersonInfo.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ChooseCityVC.h"
#import "CellPersonInfoTemp.h"
#import "ChooseCityVC.h"
#import "MainTabBarViewController.h"
@interface PersonalEditVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation PersonalEditVC
{
    
    NSString*_nonameStr;
    NSString*_nocomanyStr;
    NSString *_nodepartStr;
    
    NSString*_nameStr;
    NSString*_comanyStr;
    NSString *_departStr;
    NSString *_strCityCode;
    NSData *_imageData;
    BOOL _isLayout;
    UITextField *_textFSelected;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //travel
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC hiddenTabbarView];
    
    [HTTPRequest httpWithGet:@"/cus/detail" Param:@{} Success:^(id obj)
    {
        if (SUCCESS)
        {
            
        }
        
        else
        {
            MBHide
            MESSAGE
        }
     } Fail:^(NSString *errorMsg) {
         MBHide
         MBE(@"数据LOSE")
     }];

    //
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //注册通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"edit" object:nil];
    [self setTitle:@"编辑资料"];
//    [self.view setBackgroundColor:SystemGrayColor];
}
- (void)tongzhi:(NSNotification *)text
{
    _nonameStr =text.userInfo[@"name"];
    _nocomanyStr =text.userInfo[@"comany"];
    _nodepartStr = text.userInfo[@"department"];
    
    NSLog(@"%@",text.userInfo[@"name"]);
    
    NSLog(@"－－－－－接收到通知------");
    
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardBounds = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyboardBounds.size.height - 20, 0);
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, 0, 0);
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
//    else if (section == 1) {
//        if (_isLayout) {
//            return 3;
//        }
//        return 0;
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CellPersonInfoEdit *cell = [CellPersonInfoEdit cellWithTableView:tableView IndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.textDesc setDelegate:self];
        [cell.textViewDesc setDelegate:self];
       
        
        [cell.btnAvatar sd_setBackgroundImageWithURL:[NSURL URLWithString:_user.headurl] forState:UIControlStateNormal];
        [cell.textDesc setTag:indexPath.row];
        
        [cell.btnAvatar addTarget:self action:@selector(clickAvatar) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnChooseCity addTarget:self action:@selector(clickChoose) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnChooseCity setTitle:_user.locationName forState:UIControlStateNormal];
        
       
        if (indexPath.row==3)
        {
            cell.textDesc.text=_user.company;
            NSLog(@"公司==%@",_user.company);
           
        }
        else if (indexPath.row==1)
        {
            cell.textDesc.text = _user.nickname;
            [cell.textDesc setEnabled:NO];
            NSLog(@"_nonameStr=%@",_nonameStr);
            
        }
        else if (indexPath.row==4)
        {
            cell.textDesc.text=_user.department;
            
            NSLog(@"科室==%@",_user.department);
        }
        return cell;
    }
//    else if (indexPath.section == 1) {
//        CellPersonInfoTemp *cell = [CellPersonInfoTemp cellWithTableView:tableView];
//        [cell.textDesc setTextAlignment:NSTextAlignmentLeft];
//        [cell.textDesc setReturnKeyType:UIReturnKeyDone];
//        [cell.textDesc setDelegate:self];
//        switch (indexPath.row) {
//            case 0:
//            {
//                [cell.labTitle setText:@"姓名"];
//                [cell.textDesc setText:_user.card_name];
//                [cell.textDesc setEnabled:NO];
//            }
//                break;
//            case 1:
//            {
//                [cell.labTitle setText:@"银行卡账号"];
//                [cell.textDesc setText:_user.card_no];
//            }
//                break;
//            case 2:
//            {
//                [cell.labTitle setText:@"开户行"];
//                [cell.textDesc setText:_user.card_account];
//            }
//                break;
//            default:
//                break;
//        }
//        [cell.textDesc setTag:((indexPath.section + 1)* 100 +(indexPath.row))];
//        return cell;
//    }
    else
    {
        CellPersonInfo *cell = [CellPersonInfo cellWithTableView:tableView Index:indexPath.row];
        [cell.textViewDesc setText:_user.memo];
       
        CGRect descFrame = cell.textViewDesc.frame;
        descFrame.size.height = 100.0;
        [cell.textViewDesc setFrame:descFrame];
        [cell.textViewDesc setDelegate:self];
        [cell.textViewDesc setReturnKeyType:UIReturnKeyDone];
        [cell.btnExit addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnExit setTitle:@"完成" forState:UIControlStateNormal];
        if (indexPath.row == 1) {
            [cell setUserInteractionEnabled:YES];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.textViewDesc setTag:((indexPath.section + 1)* 100 +(indexPath.row))];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        CellPersonInfoTemp *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.textDesc becomeFirstResponder];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self clickAvatar];
    }
//    else if (indexPath.section == 0 && indexPath.row == 3) {
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        EditPasswordVC *editPassword = [story instantiateViewControllerWithIdentifier:@"StoryIDEditPassword"];
//        [self.navigationController pushViewController:editPassword animated:YES];
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50.0;
        }
        return 41.0;
    }
    else
    {
        if (indexPath.row == 0)
        {
            return 150.0;
        }
        return 70.0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 1) {
//        return 44.0;
//    }
    return .0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    NSLog(@"*******%ld",(long)textField.tag);
////    if (_textFSelected && ![_textFSelected isEqual:textField]) {
//        [self textFieldShouldReturn:_textFSelected];
////    }
//    _textFSelected = textField;
//}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    switch (textField.tag) {
//            case 3:
//            _user.company = textField.text;
//             NSLog(@"_user.nickname=%@",_user.company);
//            break;
//        case 104:
//            _user.department = textField.text;
//             NSLog(@"_user.nickname=%@",_user.company);
//            break;
//        default:
//            break;
//    }
//    return [textField resignFirstResponder];
//}

//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    CGFloat heightTemp = 0.0;
//    if (iPhone6) {
//        heightTemp = ScreenHeight - 220;
//    }
//    else if (iPhone6P) {
//        heightTemp = ScreenHeight - 240;
//    }
//    else if (iPhone5) {
//        heightTemp = ScreenHeight - 150;
//    }
//    else if (iPhone4) {
//        heightTemp = ScreenHeight - 50;
//    }
//    
//    if (_isLayout) {
//        heightTemp += 120;
//    }
//    
//    [self.tableView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, heightTemp) animated:YES];
//}

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if (_textFSelected) {
//        [self textFieldShouldReturn:_textFSelected];
//    }
//    _user.memo = textView.text;
//    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 0, 0) animated:NO];
//}
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        return [textView resignFirstResponder];
//    }
//    return YES;
//}


- (void)clickAvatar
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    [action showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    switch (buttonIndex) {
        case 0: //相机
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1: //相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            return;
            break;
    }
    [self openCamara:sourceType];
}

-(void)openCamara:(UIImagePickerControllerSourceType)sourceType
{
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    BOOL canTakePicture = NO;
    for (NSString* mediaType in availableMediaTypes) {
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    if (!canTakePicture&&sourceType == UIImagePickerControllerSourceTypeCamera) {
        NSLog(@"sorry, taking picture is not supported.");
        return;
    }
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil] ;
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:image];
    }];
}

- (void)useImage:(UIImage *)imageChoose
{
    CellPersonInfoEdit *cell = (CellPersonInfoEdit *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.btnAvatar setBackgroundImage:imageChoose forState:UIControlStateNormal];
    
    NSData *imageData;
    if (UIImagePNGRepresentation(imageChoose)) {
        imageData = UIImagePNGRepresentation(imageChoose);
    }
    else {
        imageData = UIImageJPEGRepresentation(imageChoose, 1.0);
    }
    _imageData = imageData;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)clickChoose
{
    CellPersonInfoEdit *cell = (CellPersonInfoEdit *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    ChooseCityVC *chooseCity = [[ChooseCityVC alloc] init];
    //zou
    chooseCity.isForDocList = NO;
    
    if (!chooseCity.ChooseCityBlock) {
        chooseCity.ChooseCityBlock = ^(NSString *strName, NSString *strCode) {
            [cell.btnChooseCity setTitle:strName forState:UIControlStateNormal];
            _strCityCode = strCode;
        };
        
    }
    [self.navigationController pushViewController:chooseCity animated:YES];
}

- (void)clickSave
{
    MBShow
    if (_imageData) {
        [HTTPRequest httpWithUploadPhoto:_imageData Success:^(id obj) {
            if (!SUCCESS) {
                MBHide
                MBE(@"上传头像失败")
            }
            else {
                MBHide
                [self clickSaveOther:[[obj valueForKey:@"data"] valueForKey:@"name"]];
            }
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE_Sys
        }];
    }
    else {
        [self clickSaveOther:@""];
    }
    
}

- (void)clickSaveOther:(NSString *)headerUrl
{
    
    
    CellPersonInfoEdit *cellcomany = (CellPersonInfoEdit *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString *strcomany = cellcomany.textDesc.text;
    
    CellPersonInfoEdit *cellDepart = (CellPersonInfoEdit *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    NSString *strDepart = cellDepart.textDesc.text;
    CellPersonInfo *cellMemo = (CellPersonInfo *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSString *strMemo = cellMemo.textViewDesc.text;
    NSString *strCityCode = (_strCityCode.length > 0)?_strCityCode:_user.location;
   
    NSLog(@"strcomany=%@,strDepart=%@,strMemo=%@",strcomany,strDepart,strMemo);
    NSDictionary *dic = @{ @"location": strCityCode, @"company": strcomany, @"department": strDepart, @"memo": strMemo};
    if (headerUrl.length > 0) {
        dic = @{@"headurl": headerUrl, @"location": strCityCode, @"company": strcomany, @"department":strDepart, @"memo": strMemo};
    }
       MBShow
    [HTTPRequest httpWithPost:@"/cus/detail" Param:dic Success:^(id obj) {
        if (SUCCESS)
        {
            NSLog(@"obj=%@",obj);
            _nameStr = [obj valueForKey:@"data"];
            
            if (self.PersonalEditSusBlock)
            {
                self.PersonalEditSusBlock();
            }
             MBS(@"修改成功")
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
           
        }
        MBHide
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE(@"保存失败")
    }];
}


- (void)timerFireMethod:(NSTimer*)theTimer
{
   
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;    
    
}
//- (BOOL)textViewShouldReturn:(UITextView *)textView
//{
//     return [textView resignFirstResponder];
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
