//
//  CustomHeaderCell.h
//  ParentingAsk
//
//  Created by 丁瑞 on 16/3/22.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeaderCell : UITableViewCell
@property(nonatomic ,strong)UIButton *headBtn,*moneyBtn,*iglBtn;
@property(nonatomic ,strong)UIImageView *headIMG,*moneyIMG,*iglIMG ,*authIMG ,*crownIMG;
@property(nonatomic ,strong)UILabel *nameLab,*countLab ,*HcountLab,*presentLab,*loveLab,*loveCountLab,*HpresentLab,*secLab ,*HsecLab,*authLab,*lineLab,*HlineLab,*rightLab;
@end
