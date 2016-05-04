

#import "JudgeVC.h"
#import "CellStar.h"
#import "CellJudgeStatus.h"
#import "CellComment.h"

@interface JudgeVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation JudgeVC
{
    UITableView *_tableView;
    NSArray *_arrayJudgeTitle;
    UIButton *_btnSubmit;
    UIButton *_btnCancel;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"我要评价"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 0, (ScreenWidth - 40), ScreenHeight)];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
    _arrayJudgeTitle = @[@"相应时间", @"服务态度", @"专业水平"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row < 3) {
            CellStar *cellStar = [CellStar cellWithTableView:tableView];
            [cellStar.labTitle setText:_arrayJudgeTitle[indexPath.row]];
            return cellStar;
        }
        CellJudgeStatus *cellStatus = [CellJudgeStatus cellWithTableView:tableView];
        [cellStatus.labTitle setText:@"综合评价"];
        return cellStatus;
    }
    else if (indexPath.section == 1 || indexPath.section == 2) {
        CellComment *cellComment = [CellComment cellWithTableView:tableView];
        if (indexPath.section == 1) {
            [cellComment.labTitle setText:@"我要说两句"];
        }
        else {
            [cellComment.labTitle setText:@"我要投诉"];
        }
        return cellComment;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identiCellChoose"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmit setFrame:CGRectMake((ScreenWidth * 0.5 - 110), 20, 90, 40)];
        [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
        [_btnSubmit setBackgroundColor:[UIColor greenColor]];
        [cell.contentView addSubview:_btnSubmit];
        
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCancel setFrame:CGRectMake((ScreenWidth * 0.5 + 10), 20, 90, 40)];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        [_btnCancel setBackgroundColor:[UIColor greenColor]];
        [cell.contentView addSubview:_btnCancel];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44.0;
    }
    return 100.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)clickSubmit
{
    
}
- (void)clickCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
