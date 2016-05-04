//
//  CustomButton.m
//  OrderBao
//
//  Created by User on 3/3/15.
//  Copyright (c) 2015 User. All rights reserved.
//

#import "CustomButton.h"
#import "UIViewExt.h"

@implementation CustomButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame withIcon:(NSString *)icon withName:(NSString *)name withIsShowNum:(BOOL)isShowNum {
    self = [self initWithFrame:frame];
    if (self) {
        _iconView.image = [UIImage imageNamed:icon];
        _nameLabel.text = name;
        self.isShowNumView = isShowNum;
        if (self.isShowNumView) {
            [_numView setHidden:NO];
        }else{
            [_numView setHidden:YES];
        }
    }
    return self;
}

//初始化所有的子view
- (void)_initView {
    //    [super _initView];
    self.userInteractionEnabled = YES;
    
    _iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:_iconView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font = [UIFont systemFontOfSize:13.0f];
    _nameLabel.textColor = [UIColor blackColor];
    [self addSubview:_nameLabel];
    
    _numView = [[UILabel alloc] initWithFrame:CGRectZero];
    _numView.font = [UIFont boldSystemFontOfSize:14.0f];
    //_numView.text = @"12";
    _numView.hidden = YES;
    _numView.layer.masksToBounds = YES;
    _numView.layer.cornerRadius = 20/2;
    _numView.textAlignment = NSTextAlignmentCenter;
    _numView.textColor = [UIColor whiteColor];
    _numView.backgroundColor = [UIColor colorWithRed:253.0/255 green:117.0/255 blue:73.0/255 alpha:1];
    
    [self addSubview:_numView];
    
    [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
}

//设置布局
- (void)layoutSubviews {
    [super layoutSubviews];
   [_iconView sizeToFit];
    [_nameLabel sizeToFit];
    [_numView sizeToFit];
    
    _iconView.userInteractionEnabled = NO;
    _nameLabel.userInteractionEnabled = NO;
    _numView.userInteractionEnabled = NO;
    
    
    float textHeight = [_nameLabel.text sizeWithFont:_nameLabel.font constrainedToSize:CGSizeMake(320, 100)].height;
    
    
   _iconView.frame = CGRectMake(self.width/2-_iconView.width/2 , self.height/2 - (_iconView.height+_nameLabel.height)/2 , _iconView.width , _iconView.height );
    
    _nameLabel.frame = CGRectMake(self.width/2-_nameLabel.width/2 , _iconView.bottom,_nameLabel.width, textHeight);
    
    
    _numView.frame = CGRectMake(_iconView.right , _iconView.top , 20, 20);

    
}

- (void)setShowTitle:(NSString *)str {
    _nameLabel.text = str;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
