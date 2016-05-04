
#import "SlideSwitchView.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kFontSizeOfTabButton = 17.0f;

@implementation SlideSwitchView
{
    //文字宽度（由于是等长，所以同意声明）
    CGFloat _textLabelWidth;
}

- (void)initValues
{
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, kHeightOfTopScrollView)];
    [_topScrollView setDelegate:self];
    [_topScrollView setBackgroundColor:[UIColor whiteColor]];
    [_topScrollView setPagingEnabled:NO];
    [_topScrollView setShowsHorizontalScrollIndicator:NO];
    [_topScrollView setShowsVerticalScrollIndicator:NO];
    [_topScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_topScrollView];
    _userSelectedChannelID = 100;
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, ViewWidth, (ViewHeight - kHeightOfTopScrollView))];
    [_rootScrollView setDelegate:self];
    [_rootScrollView setPagingEnabled:YES];
    [_rootScrollView setUserInteractionEnabled:YES];
    [_rootScrollView setBounces:NO];
    [_rootScrollView setShowsVerticalScrollIndicator:NO];
    [_rootScrollView setShowsHorizontalScrollIndicator:NO];
    [_rootScrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    _viewArray = [[NSMutableArray alloc] init];
    _isBuildUI = NO;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initValues];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initValues];
    }
    return self;
}

#pragma mark 创建控件
//当横屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //更新主视图的总宽度
        [_rootScrollView setContentSize:CGSizeMake(ViewWidth * _viewArray.count, 0)];
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < _viewArray.count; i ++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(_rootScrollView.bounds.size.width * i, 0, _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)* ViewWidth, 0) animated:NO];
    }
}

#pragma mark 创建子视图UI
- (void)buildUI
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    
    //wrw slideview加到subview
    for (int i = 0; i < number; i ++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self ViewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
    }
    [self createNameButtons];
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:(_userSelectedChannelID - 100)];
    }
    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsDisplay];
}

#pragma mark 初始化顶部tab的各个按钮
- (void)createNameButtons
{
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:_shadowImage];
    [_topScrollView addSubview:_shadowImageView];
    
    CGFloat topScrollViewContentWidth = ViewWidth;
    CGFloat xOffset = 0;
    for (int i = 0; i < _viewArray.count; i ++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize textSize = [NSString stringReturnSizeWithText:vc.title Size:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView) FontSize:kFontSizeOfTabButton];

        //设置按钮尺寸
        [button setFrame:CGRectMake(xOffset, 0, (ViewWidth / 3), kHeightOfTopScrollView)];
        
        xOffset += ViewWidth / 3;
        [button setTag:(i + 100)];
        
        if (i == 0) {
            CGFloat shadowX = (ViewWidth / 3 - textSize.width - 20)/ 2;
            [_shadowImageView setFrame:CGRectMake(shadowX, 0, (textSize.width + 20), _shadowImage.size.height)];
            [button setSelected:YES];
            
            _textLabelWidth = textSize.width;
        }
        
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:kFontSizeOfTabButton]];
        [button setTitleColor:_tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:_tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:_tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:_tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
    }
    
    //设置顶部滚动视图的内容尺寸
    [_topScrollView setContentSize:CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView)];
}


#pragma mark 顶部滚动视图逻辑方法
- (void)selectNameButton:(UIButton *)sender
{
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        UIButton *lastBtn = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastBtn.selected = NO;
        
        _userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat shadowX = (ViewWidth / 3 - _textLabelWidth - 20)/ 2 + sender.frame.origin.x;
            [_shadowImageView setFrame:CGRectMake(shadowX, 0, (_textLabelWidth + 20), _shadowImage.size.height)];
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((sender.tag - 100)* ViewWidth, 0) animated:YES];
                }
                _isRootScroll = NO;
                
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:(_userSelectedChannelID - 100)];
                }
            }
        }];
    }
}
#pragma mark 主视图逻辑方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        
        CGFloat currectX = scrollView.contentOffset.x;
        
        if (currectX > 100) {
            //向右滑动
            if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchDirection:)]) {
                [self.slideSwitchViewDelegate slideSwitchDirection:2];
            }
        }
        else if (currectX < 100)
        {
            //向左滑动
            if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchDirection:)]) {
                [self.slideSwitchViewDelegate slideSwitchDirection:0];
            }
        }
        
        
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x / ViewWidth + 100;
        UIButton *btn = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:btn];
    }
}

#pragma mark 传递滑动事件给下一层
- (void)scrollHandlePan:(UIPanGestureRecognizer *)panParam
{
//    当滑动左边界时，传递滑动事件给代理
    if (_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:PanLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self PanLeftEdge:panParam];
        }
    }
    else if (_rootScrollView.contentOffset.x >= (_rootScrollView.contentSize.width - _rootScrollView.bounds.size.width)) {
        if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:PanRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self PanRightEdge:panParam];
        }
    }
}

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

@end
