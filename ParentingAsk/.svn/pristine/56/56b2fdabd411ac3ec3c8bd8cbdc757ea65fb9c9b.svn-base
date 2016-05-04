
#import "CellComment.h"

@interface CellComment ()<UITextViewDelegate>

@end
@implementation CellComment

+ (CellComment *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identi = @"identiCellComment";
    CellComment *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[CellComment alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutCell];
    }
    return self;
}

- (void)layoutCell
{
    CGFloat width = 280.0;
    if (iPhone6) {
        width = 325.0;
    }
    else if (iPhone6P) {
        width = 370.0;
    }
    
    UIView *viewComment = [[UIView alloc] initWithFrame:CGRectMake(0, 10, width, 80.0)];
    [viewComment.layer setCornerRadius:8.0f];
    [viewComment.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [viewComment.layer setBorderWidth:0.8f];
    [self.contentView addSubview:viewComment];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 80.0)];
    [self.textView setReturnKeyType:UIReturnKeyDone];
    [self.textView setDelegate:self];
    self.labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 24)];
    [self.labTitle setFont:[UIFont systemFontOfSize:16.0]];
    [self.labTitle setTextColor:[UIColor blackColor]];
    [self.textView addSubview:self.labTitle];
    [viewComment addSubview:self.textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        return [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.labTitle removeFromSuperview];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ( textView.text.length > 0) {
        if (self.CellCommentBlock) {
            self.CellCommentBlock(textView.text);
        }
    }
}

@end
