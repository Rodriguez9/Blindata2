//
//  SLiderMenuViewController.m
//  Blindata
//
//  Created by YZH on 2018/3/17.
//  Copyright © 2018年 YZH. All rights reserved.
//

#import "SLiderMenuViewController.h"
#import "UtilsMacro.h"
#import <Masonry.h>
@interface SLiderMenuViewController ()

@property(nonatomic,weak)IBOutlet UIView *manuContainer;
@property(nonatomic,weak)IBOutlet UIView *contantContainer;

@property(nonatomic,strong)IBOutlet UIButton *maskButton;
@property(nonatomic,assign) BOOL folder;
@property(nonatomic,assign) CGPoint originalPoint;
@property(nonatomic,assign) CGFloat scaleFactor;
@property(nonatomic,assign) CGFloat offsetX;
@property(nonatomic,assign) CGFloat originalX;
@property(nonatomic,assign) CGFloat deltaScaleFactor;
@property(nonatomic,assign) CGFloat deltaAlphaFactor;
@property(nonatomic,assign) CGFloat miniumOffestX;
@end

@implementation SLiderMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchController{
    _folder=!_folder;
    if (_folder) {
        [self showContantViewController];
    }else{
        [self showMenuViewController];
    }
}
- (IBAction)panned:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.view];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _originalPoint=point;
            [self setShadowVisible:YES];
            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat tx = point.x-self.originalPoint.x+self.originalX;
            tx=tx < 0 ? 0 : tx;
            
            CGFloat s =1-tx*self.deltaScaleFactor;
            s=s< 0 ? 0 : s;
            
            CGAffineTransform transform = CGAffineTransformMakeTranslation(tx, 0);
            transform = CGAffineTransformScale(transform, s, s);
            _contantContainer.transform=transform;
            
            CGFloat alpha = tx*self.deltaAlphaFactor;
            alpha=alpha > 1 ? 1 : alpha;
            _manuContainer.alpha=alpha;
        }break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            CGAffineTransform transform = _contantContainer.transform;
            if (transform.tx >= self.miniumOffestX) {
                self.folder = NO;
                [self showMenuViewController];
            }else{
                self.folder=YES;
                 [self showContantViewController];
            }
        }break;
        default:
            NSLog(@"other");
            break;
    }
}

-(CGFloat)originalX{
    return (_folder? 0 : _offsetX);
}

#pragma MARK - Private

-(void)initParams{
    //默认折叠
    _folder = YES;
    //
    _scaleFactor=0.95;
    //最终偏移量
    _offsetX = self.view.frame.size.width/2+30;
    //滑动透明度的变化
    _deltaAlphaFactor=1/_offsetX;
    //最小滑动偏移量
    _miniumOffestX=_offsetX/2;
    _deltaScaleFactor=(1-_scaleFactor)/_offsetX;
}

-(void)showMenuViewController{
    [self setShadowVisible:YES];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(_offsetX, 0);
    transform=CGAffineTransformScale(transform, _scaleFactor, _scaleFactor);
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.manuContainer.alpha=1;
        self.contantContainer.transform=transform;
    } completion:^(BOOL finished){
        [self setMaskButtonVisible:YES];
    }];
}

-(void)showContantViewController{
    [self setShadowVisible:NO];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.manuContainer.alpha=0;
        self.contantContainer.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        [self setMaskButtonVisible:NO];
    }];
}

//设置阴影
-(void)setShadowVisible:(BOOL)visible{

    if (visible) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:_contantContainer.layer.bounds];
        _contantContainer.layer.shadowPath=path.CGPath;
        _contantContainer.layer.shadowColor= [UIColor blackColor].CGColor;
        _contantContainer.layer.shadowOffset=CGSizeZero;
        _contantContainer.layer.shadowOpacity=0.4;
        _contantContainer.layer.shadowRadius=4.5;
    }else{
        _contantContainer.layer.shadowRadius=0;
    }
}

//
-(void)setMaskButtonVisible:(BOOL)visible{
    if (_maskButton==nil) {
        self.maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_maskButton addTarget:self action:@selector(maskButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_contantContainer addSubview:_maskButton];
        [_maskButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(_contantContainer).insets(UIEdgeInsetsZero);
        }];
    }
    _maskButton.hidden=!visible;
}

-(void)maskButtonPressed{
    _folder=!_folder;
    [self showContantViewController];
}

@end
