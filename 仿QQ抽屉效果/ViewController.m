//
//  ViewController.m
//  仿QQ抽屉效果
//
//  Created by 刘晓亮 
//  Copyright © 2016年 刘晓亮. All rights reserved.
//

#import "ViewController.h"
#import "LIUSetListVC.h"

#define offsetNumber 300

@interface ViewController ()


@property(nonatomic,weak)UIButton * backButton;

// 声明一个属性用来持有根控制器
@property(nonatomic,weak)LIUSetListVC * listVC;

@end

@implementation ViewController

-(LIUSetListVC *)listVC{
    
    if (nil == _listVC) {
        _listVC = (LIUSetListVC *)[UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _listVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem * butn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(movie)];
    
    self.navigationItem.leftBarButtonItem = butn;
    
    // 添加左边手势
    UIScreenEdgePanGestureRecognizer * pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panWith:)];

    pan.edges = UIRectEdgeLeft;
    
    [self.view addGestureRecognizer:pan];
    
    // 创建一个返回的按钮
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - offsetNumber, self.view.frame.size.height)];
    
    [button addTarget:self action:@selector(movie) forControlEvents:UIControlEventTouchUpInside];
    
    self.backButton = button;
    button.hidden = YES;
    
    [self.navigationController.view addSubview:button];
    
    // 给按钮添加手势
    UIPanGestureRecognizer * backPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backPan:)];
    
    [button addGestureRecognizer:backPan];
    
    // 设置阴影效果
    self.tabBarController.view.layer.shadowColor = [UIColor grayColor].CGColor;
    self.tabBarController.view.layer.shadowOffset = CGSizeMake(-5, 0);
    self.tabBarController.view.layer.shadowOpacity = 0.7;
    self.tabBarController.view.layer.shadowRadius = 5;
}


/**
 *  处理返回的手势
 *
 *  @param pan 传入的手势
 */
-(void)backPan:(UIPanGestureRecognizer *)pan {
    
    CGFloat point = offsetNumber + [pan translationInView:self.backButton].x;
    
    // 当手势结束时会调用
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self startAnimate];
        return;
    }
    
    // 防止向右划动
    if (point > offsetNumber || point < 0) {
        return;
    }
    
    // 修改控件的位置
    self.tabBarController.view.transform = CGAffineTransformMakeTranslation(point, 0);
    
    // 个性根控制器的view
    self.listVC.tableview.transform = CGAffineTransformMakeTranslation((point - offsetNumber) / 3.0, 0);
}


/**
 *  处理手势的方法
 *
 *  @param pan 传进来的手势
 */
-(void)panWith:(UIPanGestureRecognizer *)pan{
    
    // 当手势结束时会调用
    if (pan.state == UIGestureRecognizerStateEnded) {
        // 执行动画效果
        [self startAnimate];
        return;
    }
    
    // 获取根视图控制器
    UIViewController * vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    // 获取手势的点
    CGPoint lastPoint = [pan translationInView:vc.view];
    
    // 修改控件的位置
    self.tabBarController.view.transform = CGAffineTransformMakeTranslation(ABS(lastPoint.x), 0);
    // 个性根控制器的view
    self.listVC.tableview.transform = CGAffineTransformMakeTranslation((lastPoint.x - offsetNumber) / 3.0, 0);
}

/**
 *  开始执行动画
 */
-(void)startAnimate{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (self.tabBarController.view.frame.origin.x > offsetNumber * 0.5) {
            self.tabBarController.view.transform = CGAffineTransformMakeTranslation(offsetNumber, 0);
            
            self.listVC.tableview.transform = CGAffineTransformIdentity;
        } else {
            self.tabBarController.view.transform = CGAffineTransformIdentity;
            
            self.listVC.tableview.transform = CGAffineTransformMakeTranslation(- offsetNumber / 3.0, 0);
        }
    } completion:^(BOOL finished) {
        if (self.tabBarController.view.frame.origin.x > 0) {
            self.backButton.hidden = NO;
        } else {
            self.backButton.hidden = YES;
        }
    }];
}

/**
 *  执行动画的抽屉效果
 */
-(void)movie{
    
    [UIView animateWithDuration:0.25 animations:^{
        // 根据现在的位置来判断做什么动画
        if (self.tabBarController.view.frame.origin.x > 0) {
            self.tabBarController.view.transform = CGAffineTransformIdentity;
            self.listVC.tableview.transform = CGAffineTransformMakeTranslation(- offsetNumber / 3.0, 0);
            
        } else {
            
            self.tabBarController.view.transform = CGAffineTransformMakeTranslation(offsetNumber, 0);
            
            self.listVC.tableview.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        // 动画完成后判断要不要隐藏按钮
        if (self.tabBarController.view.frame.origin.x > 0) {
            self.backButton.hidden = NO;
        } else {
            self.backButton.hidden = YES;
        }
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
