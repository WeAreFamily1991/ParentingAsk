//
//  ChangeCell.h
//  ParentingAsk
//
//  Created by 丁瑞 on 16/4/13.
//  Copyright © 2016年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UITextField *textDesc;

+ (ChangeCell *)cellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;
@end
