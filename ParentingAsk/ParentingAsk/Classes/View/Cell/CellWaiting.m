

#import "CellWaiting.h"
#import "Msg_Waiting.h"
#import "WaitingDetailVC.h"
@interface CellWaiting ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *consTimeWidth;

@end
@implementation CellWaiting

+ (CellWaiting *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellWaiting";
    CellWaiting *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellWaiting" owner:nil options:nil] lastObject];
    }
    [cell.imageAvatar.layer setCornerRadius:18.0];
    [cell.imageAvatar setClipsToBounds:YES];
//    [cell.GrabBtn.layer setCornerRadius:30.0];
    cell.GrabIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"抢"]];
   cell.GrabIMG.frame =CGRectMake(ScreenWidth-ScreenWidth/4, ScreenHeight/16-ScreenWidth/12, ScreenWidth/6, ScreenWidth/6);
    cell.GrabIMG.layer.cornerRadius = ScreenWidth/12;
//    cell.GrabIMG.layer.masksToBounds = ScreenWidth/12;
    
    
   
//    cell.GrabIMG.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:187.0/255.0 blue:242.0/255.0 alpha:1.00];
    //[cell.GrabBtn addTarget:self action:@selector(GrabBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:cell.GrabIMG];

    [cell.labUnRead.layer setCornerRadius:12.5];
    [cell.labUnRead setClipsToBounds:YES];
    
    return cell;
}

//-(void)GrabBtnClick
//{
////    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
////    WaitingDetailVC *waitingDetail = [story instantiateViewControllerWithIdentifier:@"StoryIDWaitingDetail"];
////    
////    [self.navigationController pushViewController:waitingDetail animated:YES];
////    
//
//}
- (void)setMsg_Waiting:(Msg_Waiting *)msg_Waiting
{
    _msg_Waiting = msg_Waiting;
    
    [self.labName setText:_msg_Waiting.nickname];
    [self.labDesc setText:_msg_Waiting.desc];
    [self.labTime setText:[NSString stringReturnFromTime:_msg_Waiting.time]];
    HTTPImgView(self.imageAvatar, _msg_Waiting.headurl)
}

@end
