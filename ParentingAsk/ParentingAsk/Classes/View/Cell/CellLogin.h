//
//  CellLogin.h
//  ParentingAsk
//
//  Created by Jerry on 15/9/7.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellLogin : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageIcon;
@property (nonatomic, weak) IBOutlet UITextField *textUsername;
@property (nonatomic, weak) IBOutlet UITextField *textPassword;
@property (nonatomic, weak) IBOutlet UIButton *btnRemember;
@property (nonatomic, weak) IBOutlet UIImageView *imageRemeber;
@property (nonatomic, weak) IBOutlet UIButton *btnLogin;
@property (nonatomic, weak) IBOutlet UIButton *btnRegist;


+ (CellLogin *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

@end
