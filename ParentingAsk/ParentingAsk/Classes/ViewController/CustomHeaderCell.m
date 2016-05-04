//
//  CustomHeaderCell.m
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/22.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#define HEIGHT 3*ScreenHeight/20+ScreenHeight/25
#define COLOR_SYS  [UIColor whiteColor]
#import "CustomHeaderCell.h"

@implementation CustomHeaderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, -ScreenHeight/16, ScreenWidth, ScreenHeight/3)];
        headView.backgroundColor = SYSNAVGETION_COLOR;
//        UIView *smallView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/60)];
//        smallView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
//        [headView addSubview:smallView];
        
        self.headIMG = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-ScreenWidth/10, ScreenWidth/10, ScreenWidth/5, ScreenWidth/5)];
        self.headIMG.image = [UIImage imageNamed:@"head"];
        self.headIMG.layer.cornerRadius = ScreenWidth/10;
        self.headIMG.layer.masksToBounds=ScreenWidth/10;
       
        [headView addSubview:self.headIMG];
//       self.headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//         self.headBtn.frame = CGRectMake(ScreenWidth/20, ScreenWidth/20, ScreenWidth/5, ScreenWidth/5);
//         self.headBtn.backgroundColor = [UIColor whiteColor];
        //    HTTPImgView, _user.headurl);
        
//        [ self.headBtn setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
        
//        [button addTarget:self action:@selector(headerBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.nameLab= [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth/5-ScreenHeight/40, ScreenWidth/2-ScreenWidth/7, ScreenHeight/20)];
        
        self.nameLab.textColor =[UIColor whiteColor];
        self.nameLab.font = [UIFont systemFontOfSize:20];
        self.nameLab.textAlignment=NSTextAlignmentRight;
        [headView addSubview:self.nameLab];
        
        
        
        self.authIMG = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2+ScreenWidth/7, ScreenWidth/5-ScreenHeight/60, ScreenWidth/4, ScreenHeight/30)];
        self.authIMG.image = [UIImage imageNamed:@"crown-rectangle"];
        [headView addSubview:self.authIMG];
        
        
        self.crownIMG = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/50, ScreenHeight/60-ScreenWidth/54, ScreenWidth/25, ScreenWidth/27)];
        self.crownIMG.image = [UIImage imageNamed:@"crown"];
        [self.authIMG addSubview:self.crownIMG];
        
        
        self.authLab= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/15, 0, ScreenWidth/3.5-ScreenHeight/20, ScreenHeight/30)];
        self.authLab.font = [UIFont systemFontOfSize:10];
//        self.authLab.text = @"一类 已认证";
        self.authLab.textColor = [UIColor whiteColor];
        [self.authIMG addSubview:self.authLab];
        //
        //    UILabel *Lab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4.5 +ScreenWidth/20, ScreenWidth/30 +ScreenHeight/20, ScreenWidth-ScreenWidth/5,1)];
        //    Lab.backgroundColor = [UIColor blackColor];
        //    [headView addSubview:Lab];
        //
        
        self.countLab = [[UILabel alloc]initWithFrame:CGRectMake(0,3*ScreenHeight/20+ScreenHeight/40, ScreenWidth/4, ScreenHeight/20)];
//        self.countLab.text = @"15";
        self.countLab.textAlignment = NSTextAlignmentCenter;
        self.countLab.font = [UIFont systemFontOfSize:14];
        self.countLab.textColor =[UIColor whiteColor];
        [headView addSubview:self.countLab];
        
        
       self.HcountLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 3*ScreenHeight/20+ScreenHeight/20, ScreenWidth/4 , ScreenHeight/20)];
  
        self.HcountLab.text = @"接单数";
        self.HcountLab.font = [UIFont systemFontOfSize:12];
        self.HcountLab.textAlignment = NSTextAlignmentCenter;
        self.HcountLab.textColor = [UIColor whiteColor];
        [headView addSubview:self.HcountLab];
        
        self.presentLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4, 3*ScreenHeight/20+ScreenHeight/40, ScreenWidth/4, ScreenHeight/20)];
        self.presentLab.text = @"100%";
        self.presentLab.textAlignment =NSTextAlignmentCenter;
        self.presentLab.textColor=[UIColor whiteColor];
        self.presentLab.font = [UIFont systemFontOfSize:14];
        [headView addSubview:self.presentLab];
        
        
        
        self.HpresentLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4, 3*ScreenHeight/20+ScreenHeight/20, ScreenWidth/4, ScreenHeight/20)];
        self.HpresentLab .text = @"好评率";
        self.HpresentLab .textColor = [UIColor whiteColor];
        self.HpresentLab.textAlignment = NSTextAlignmentCenter;
        self.HpresentLab .font = [UIFont systemFontOfSize:12];
        [headView addSubview:self.HpresentLab ];
        
        self.loveCountLab = [[UILabel alloc]initWithFrame:CGRectMake( ScreenWidth/2, 3*ScreenHeight/20+ScreenHeight/40, ScreenWidth/4, ScreenHeight/20)];
        self.loveCountLab.text = @"10";
        self.loveCountLab.textColor=[UIColor whiteColor];
        self.loveCountLab.textAlignment =NSTextAlignmentCenter;
        self.loveCountLab.font = [UIFont systemFontOfSize:14];
        [headView addSubview:self.loveCountLab];
        
        self.loveLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2, 3*ScreenHeight/20+ScreenHeight/20, ScreenWidth/4, ScreenHeight/20)];
        self.loveLab.text = @"爱心";
        self.loveLab.textAlignment =NSTextAlignmentCenter;
        self.loveLab.textColor = [UIColor whiteColor];
        self.loveLab.font = [UIFont systemFontOfSize:12];
        [headView addSubview:self.loveLab];

        self.secLab = [[UILabel alloc]initWithFrame:CGRectMake(3* ScreenWidth/4, 3*ScreenHeight/20+ScreenHeight/40, ScreenWidth/4, ScreenHeight/20)];
        self.secLab.text = @"5s";
        self.secLab.textColor=[UIColor whiteColor];
        self.secLab.textAlignment =NSTextAlignmentCenter;
        self.secLab.font = [UIFont systemFontOfSize:14];
        [headView addSubview:self.secLab];
        
       self.HsecLab = [[UILabel alloc]initWithFrame:CGRectMake(3* ScreenWidth/4, 3*ScreenHeight/20+ScreenHeight/20, ScreenWidth/4, ScreenHeight/20)];
        self.HsecLab.text = @"平均响应时间";
        self.HsecLab.textAlignment =NSTextAlignmentCenter;
        self.HsecLab.textColor = [UIColor whiteColor];
        self.HsecLab.font = [UIFont systemFontOfSize:12];
        [headView addSubview:self.HsecLab];
        
        
        
        self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/4,3*ScreenHeight/20+ScreenHeight/25, 0.5, ScreenHeight/20)];
        
        //        self.lineLab.font = [UIFont systemFontOfSize:14];
        self.lineLab.backgroundColor = COLOR_SYS;
        
        //        self.titLab.textColor = sysDGrayColor;
        self.lineLab.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:self.lineLab];

        self.rightLab = [[UILabel alloc]initWithFrame:CGRectMake(3*ScreenWidth/4,3*ScreenHeight/20+ScreenHeight/25, 0.5, ScreenHeight/20)];
        
        //        self.lineLab.font = [UIFont systemFontOfSize:14];
        self.rightLab.backgroundColor = COLOR_SYS;
        
        //        self.titLab.textColor = sysDGrayColor;
        self.rightLab.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:self.rightLab];

        
        self.HlineLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2,3*ScreenHeight/20+ScreenHeight/25, 0.5, ScreenHeight/20)];
        
        //        self.lineLab.font = [UIFont systemFontOfSize:14];
        self.HlineLab.backgroundColor = COLOR_SYS;
        
        //        self.titLab.textColor = sysDGrayColor;
        self.HlineLab.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:self.HlineLab];
        
        self.moneyIMG = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/10, ScreenHeight/3-ScreenHeight/18, ScreenHeight/22, ScreenHeight/22)];
        self.moneyIMG.image = [UIImage imageNamed:@"money"];
        [headView addSubview:self.moneyIMG];
        
        self.moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         self.moneyBtn.frame = CGRectMake(ScreenWidth/20 +ScreenHeight/30, ScreenHeight/3-ScreenHeight/18, ScreenWidth/3, ScreenHeight/22);
         self.moneyBtn.titleLabel.font = [UIFont systemFontOfSize:22];
        [ self.moneyBtn setTitle:@"111" forState:UIControlStateNormal];
        [ self.moneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [ self.moneyBtn addTarget:self action:@selector(monBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview: self.moneyBtn];
        
        
        self.iglIMG = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/10 +ScreenWidth/2, ScreenHeight/3-ScreenHeight/18, ScreenHeight/22, ScreenHeight/22)];
         self.iglIMG.image = [UIImage imageNamed:@"integral"];
        [headView addSubview: self.iglIMG];
        
        self.iglBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.iglBtn.frame = CGRectMake(ScreenWidth/20 +ScreenWidth/2+ScreenHeight/30, ScreenHeight/3-ScreenHeight/18, ScreenWidth/3, ScreenHeight/22);
        self.iglBtn.titleLabel.font = [UIFont systemFontOfSize:22];
        [self.iglBtn setTitle:@"1202" forState:UIControlStateNormal];
        [self.iglBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.iglBtn addTarget:self action:@selector(iglBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:self.iglBtn];
        [self.contentView addSubview:headView];
        
        UILabel *STLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2,ScreenHeight/3-ScreenHeight/18, 0.5, ScreenHeight/20)];
        
        //        self.lineLab.font = [UIFont systemFontOfSize:14];
        STLab.backgroundColor = COLOR_SYS;
        
        //        self.titLab.textColor = sysDGrayColor;
        STLab.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:STLab];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
