

#import "PersonalInfoSubmitVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIButton+WebCache.h>
#import "MainTabBarViewController.h"
@interface PersonalInfoSubmitVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UIView *viewContent;
@property (nonatomic, weak) IBOutlet UIButton *btnIDPhoto;
@property (nonatomic, weak) IBOutlet UIButton *btnWorkPhoto;
@property (nonatomic, weak) IBOutlet UIButton *btnOturlPhoto;
@property (nonatomic, weak) IBOutlet UIButton *btnSubmit;

@end

@implementation PersonalInfoSubmitVC
{
    NSString *_strIdPhoto;
    NSString *_strWorkPhoto;
    NSString *_strOturlPhoto;
    NSString *_strIdPName;
    NSString *_strWorkPName;
    NSString *_strOturlPName;
    NSString *_type;//是否审核通过
    
    BOOL _isChooseIDPhoto;
    BOOL _isChooseWorkPhoto;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MainTabBarViewController *tabVC=(MainTabBarViewController*)self.tabBarController;
    [tabVC appearTabbarView];
    //
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"认证资料"];
    [self.view setBackgroundColor:RGBACOLOR(236, 234, 234, 1)];
    
    [_viewContent.layer setCornerRadius:4.0f];
    [self.btnSubmit.layer setCornerRadius:4.0f];
    [self.btnSubmit setBackgroundColor:SystemGreenColor];
    
    [self.btnIDPhoto addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnWorkPhoto addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnOturlPhoto addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSubmit addTarget:self action:@selector(clickFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //获取已上传图片
    [self obtainInfo];
    
}

- (void)clickFunc:(UIButton *)sender
{
    _isChooseIDPhoto = NO;
    _isChooseWorkPhoto = NO;
    
    switch (sender.tag) {
        case 1:
            //身份证照片
        {
            _isChooseIDPhoto = YES;
        }
            break;
        case 2:
            //从业资格照片
        {
            _isChooseWorkPhoto = YES;
        }
            break;
        case 3:
            //其他证书
        {
        }
            break;
        case 4:
            //提交
        {
            [self clickSubmit];
        }
        default:
            break;
    }
    
    if (sender.tag != 4) {
        UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        [action showInView:self.view];
    }
}

- (void)obtainInfo
{
    NSUserDefaults *userDefa = [NSUserDefaults standardUserDefaults];
    _type = [userDefa valueForKey:@"_type"]==nil?@"":[userDefa valueForKey:@"_type"];
    _strOturlPhoto = [userDefa valueForKey:@"PersonOturlPhoto"]==nil?@"":[userDefa valueForKey:@"PersonOturlPhoto"];
    _strWorkPhoto = [userDefa valueForKey:@"PersonWorkPhoto"]==nil?@"":[userDefa valueForKey:@"PersonWorkPhoto"];
    _strIdPhoto = [userDefa valueForKey:@"PersonIdPhoto"]==nil?@"":[userDefa valueForKey:@"PersonIdPhoto"];
    
    
    if (_strIdPhoto.length > 0) {
        [self.btnIDPhoto sd_setBackgroundImageWithURL:[NSURL URLWithString:_strIdPhoto] forState:UIControlStateNormal];
    }
    if(_strWorkPhoto.length > 0){
        [self.btnWorkPhoto sd_setBackgroundImageWithURL:[NSURL URLWithString:_strWorkPhoto] forState:UIControlStateNormal];
    }
    if(_strOturlPhoto.length > 0){
        [self.btnOturlPhoto sd_setBackgroundImageWithURL:[NSURL URLWithString:_strOturlPhoto] forState:UIControlStateNormal];
    }
    //审核成功
    if (![_type  isEqual: @"0"]) {
        [self.btnSubmit setTitle:@"审核通过" forState:UIControlStateNormal];
        [self.btnSubmit setUserInteractionEnabled:NO];
        [self.btnIDPhoto setUserInteractionEnabled:NO];
        [self.btnWorkPhoto setUserInteractionEnabled:NO];
        [self.btnOturlPhoto setUserInteractionEnabled:NO];
    }
}

- (void)clickSubmit
{
    
    if (_strWorkPName.length == 0 ) {
        MBE(@"必须上传从业资格证")
        return;
    }
    if ( _strIdPName.length == 0) {
        MBE(@"必须上传身份证")
        return;
    }
    if( _strOturlPName == nil){
        _strOturlPName = @"";
    }
    MBShow
    [HTTPRequest httpWithPost:@"/cus/validate" Param:@{@"idurl": _strIdPName, @"ceurl": _strWorkPName, @"oturl": _strOturlPName} Success:^(id obj) {
        if (SUCCESS) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:_strIdPhoto forKey:@"PersonIdPhoto"];
            [defaults setValue:_strWorkPhoto forKey:@"PersonWorkPhoto"];
            [defaults setValue:_strOturlPhoto forKey:@"PersonOturlPhoto"];
            MBHide
            MBS(@"照片已提交")
        }
        else {
            MBHide
            MESSAGE
        }
    } Fail:^(NSString *errorMsg) {
        MBHide
        MBE(@"上传失败")
    }];
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
    if (_isChooseIDPhoto) {
        [self.btnIDPhoto setBackgroundImage:imageChoose forState:UIControlStateNormal];
    }
    else if (_isChooseWorkPhoto) {
        [self.btnWorkPhoto setBackgroundImage:imageChoose forState:UIControlStateNormal];
    }
    else {
        [self.btnOturlPhoto setBackgroundImage:imageChoose forState:UIControlStateNormal];
    }
    
    NSData *imageData;
    if (UIImagePNGRepresentation(imageChoose)) {
        imageData = UIImagePNGRepresentation(imageChoose);
    }
    else {
        imageData = UIImageJPEGRepresentation(imageChoose, 1.0);
    }
    
    if (imageData) {
        MBShow
        [HTTPRequest httpWithUploadPhoto:imageData Success:^(id obj) {
            if (!SUCCESS) {
                MBHide
                MBE(@"上传失败")
            }
            else {
                MBHide
                MBE(@"上传成功")
                if (_isChooseIDPhoto) {
                    _strIdPhoto = [[obj valueForKey:@"data"] valueForKey:@"path"];
                    _strIdPName = [[obj valueForKey:@"data"] valueForKey:@"name"];
                }
                else if (_isChooseWorkPhoto) {
                    _strWorkPhoto = [[obj valueForKey:@"data"] valueForKey:@"path"];
                    _strWorkPName = [[obj valueForKey:@"data"] valueForKey:@"name"];
                }
                else {
                    _strOturlPhoto = [[obj valueForKey:@"data"] valueForKey:@"path"];
                    _strOturlPName = [[obj valueForKey:@"data"] valueForKey:@"name"];
                }
            }
        } Fail:^(NSString *errorMsg) {
            MBHide
            MBE_Sys
        }];
    }
}



@end
