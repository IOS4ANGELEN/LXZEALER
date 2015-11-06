//
//  AboutZealerViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "AboutZealerViewController.h"
#import "copyRightViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface AboutZealerViewController ()

@end

@implementation AboutZealerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 650);
    [self initContentView];
}


- (void)initContentView{
    UIImageView *aboutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 530)];
    aboutImageView.image = [UIImage imageNamed:@"bg_about"];
    aboutImageView.contentMode = UIViewContentModeScaleToFill;
    [self.scrollView addSubview:aboutImageView];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [copyButton setTitle:@"《免责声明及隐私政策》" forState:UIControlStateNormal];
    [copyButton addTarget:self action:@selector(copyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    copyButton.frame = CGRectMake(0, 530, 200, 44);
    [self.scrollView addSubview:copyButton];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(20, 574, SCREEN_WIDTH - 40, 44);
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    logoutButton.backgroundColor = [UIColor colorWithRed:0.145 green:0.153 blue:0.176 alpha:1.000];
    [self.scrollView addSubview:logoutButton];
}

- (void)copyButtonAction{
    copyRightViewController *copyVC = [[copyRightViewController alloc] init];
    [self.navigationController pushViewController:copyVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.tabBarController.tabBar.hidden = YES;
}

@end
