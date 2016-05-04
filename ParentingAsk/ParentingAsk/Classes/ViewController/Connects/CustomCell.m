//
//  CustomCell.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/21.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import "CustomCell.h"
#import "Msg_Waiting.h"
@interface CustomCell ()
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *consTimeWidth;

@end
@implementation CustomCell

+ (CustomCell *)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *identi = @"customCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil] lastObject];
    }
    [cell.imageAvatar.layer setCornerRadius:22.0];
    [cell.imageAvatar setClipsToBounds:YES];
    
    cell.labUnRead = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 16, 16)];
    cell.labUnRead.textColor = [UIColor whiteColor];
    cell.labUnRead.backgroundColor =[UIColor redColor];
    cell.labUnRead.layer.masksToBounds =8;
    cell.labUnRead.textAlignment = NSTextAlignmentCenter;
    cell.labUnRead.layer.cornerRadius = 8;
    cell.labUnRead.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:cell.labUnRead];
    [cell.badgeView.layer setCornerRadius:8.0];
    [cell.labUnRead.layer setCornerRadius:8];
    cell.labUnRead.font = [UIFont systemFontOfSize:10];
    [cell.labUnRead setClipsToBounds:YES];
    
    return cell;
}
//- (void)setMsg_Waiting:(Msg_Waiting *)msg_Waiting
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
//}

//- (void)tongzhi:(NSNotification *)text
//{
//   
//
//    
//    self.labName= text.userInfo[@"nickName"];
//    self.labDesc = text.userInfo[@"desc"];
//    _headerStr =text.userInfo[@"headIMG"];
////    self.labTime = text.userInfo[@"time"];
//    
//    [self.labTime setText:[NSString stringReturnFromTime: text.userInfo[@"time"]]];
//    HTTPImgView(self.imageAvatar, _headerStr);
//    NSLog(@"%@",text.userInfo[@"nickName"]);
//    NSLog(@"%@",text.userInfo[@"desc"]);
//    NSLog(@"%@",text.userInfo[@"time"]);
//    NSLog(@"%@",text.userInfo[@"headIMG"]);
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
