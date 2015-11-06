//
//  MyViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "MyViewController.h"
#import "MyCollectionViewCell.h"
#import "AboutZealerViewController.h"
#import <UIImageView+WebCache.h>

#define CELL_WIDTH self.view.bounds.size.width / 3
#define SCREEN_WIDTH self.view.bounds.size.width

@implementation MyViewController

- (UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 2;
        flowLayout.itemSize = CGSizeMake(CELL_WIDTH -1 , CELL_WIDTH -1);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headBackgroundImage.frame.size.height , SCREEN_WIDTH, SCREEN_WIDTH) collectionViewLayout:flowLayout];
        [_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setImageForCellWithIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AboutZealerViewController *aboutZealerVC = [[AboutZealerViewController alloc] init];
    [self.navigationController pushViewController:aboutZealerVC animated:YES];
}

#pragma mark - life circle
- (void)viewDidLoad{
    [super viewDidLoad];
    UITabBarItem *item = self.tabBarController.tabBar.items[2];
    [item setSelectedImage:[UIImage imageNamed:@"tab_me_pre"]];
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserinfo:) name:@"WBAuthorSuccessfulNotification" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 更新授权后的个人信息
- (void)updateUserinfo:(NSNotification*)notification{
    //修改登录状态
    isLogin = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.userNameLabel.text = notification.userInfo[@"screen_name"];
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:notification.userInfo[@"avatar_large"]]];
    });
}

#pragma mark - 点击个人头像后相应的操作
- (IBAction)loginButtonAction:(id)sender {
    if (!isLogin) {
        [self performSegueWithIdentifier:@"isLogin" sender:self];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WBAuthorSuccessfulNotification" object:nil];
}

@end
