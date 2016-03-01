//
//  AppDelegate.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/20.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FindViewController.h"
#import "ShopViewController.h"
#import "UserViewController.h"

@interface AppDelegate ()<NSURLSessionDelegate>{
    ViewController *homeViewController_;
    FindViewController *findViewController_;
    ShopViewController *shopViewController_;
    UserViewController *userViewController_;
}

@property (strong, nonatomic) UIView *lunchView;

@end

@implementation AppDelegate

@synthesize lunchView = lunchView_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    // 等待画面
//    lunchView_ = [[NSBundle mainBundle ]loadNibNamed:@"LaunchScreen" owner:nil options:nil][0];
//    lunchView_.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
//    [self.window addSubview:lunchView_];
//    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:lunchView_.frame];
//    
//    imageV.image = [UIImage imageNamed:@"res/circle.jpg"];
//    [lunchView_ addSubview:imageV];
//    
//    [self.window bringSubviewToFront:lunchView_];
//    
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
    
    // 设置栏目底色
    [self setColor];
    
    homeViewController_ = [[ViewController alloc] init];
    findViewController_ = [[FindViewController alloc] init];
    shopViewController_ = [[ShopViewController alloc] init];
    userViewController_ = [[UserViewController alloc] init];
    
    homeViewController_.title = @"牛逼购物";
    findViewController_.title = @"牛逼购物";
    shopViewController_.title = @"购物车";
    userViewController_.title = @"个人中心";
    
    findViewController_.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"res/DefaultTheme/SearchIcon_red"] style:UIBarButtonItemStylePlain target:self action:nil];
    findViewController_.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"res/Root/QR_code"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    shopViewController_.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:nil];
    shopViewController_.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:nil];
    userViewController_.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    userViewController_.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeViewController_];
    UINavigationController *findNavController = [[UINavigationController alloc] initWithRootViewController:findViewController_];
    UINavigationController *userNavController = [[UINavigationController alloc] initWithRootViewController:userViewController_];
    UINavigationController *shopNavController = [[UINavigationController alloc] initWithRootViewController:shopViewController_];
    
    UIImage *homeImage = [[UIImage imageNamed:@"res/DefaultTheme/Home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeImageSelect = [[UIImage imageNamed:@"res/DefaultTheme/Home_Clicked.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *findImage = [[UIImage imageNamed:@"res/DefaultTheme/Find.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *findImageSelect = [[UIImage imageNamed:@"res/DefaultTheme/Find_Clicked.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *shopImage = [[UIImage imageNamed:@"res/DefaultTheme/ShoppingCart.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *shopImageSelect = [[UIImage imageNamed:@"res/DefaultTheme/ShoppingCart_Clicked.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *userImage = [[UIImage imageNamed:@"res/DefaultTheme/UserCenter.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *userImageSelect = [[UIImage imageNamed:@"res/DefaultTheme/UserCenter_Clicked.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:homeImage selectedImage:homeImageSelect];
    UITabBarItem *findItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:findImage selectedImage:findImageSelect];
    UITabBarItem *shopItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:shopImage selectedImage:shopImageSelect];
    UITabBarItem *userItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:userImage selectedImage:userImageSelect];
    
    homeNavController.tabBarItem = homeItem;
    findNavController.tabBarItem = findItem;
    userNavController.tabBarItem = userItem;
    shopNavController.tabBarItem = shopItem;
    
    UITabBarController *tbController = [[UITabBarController alloc] init];
    
    tbController.viewControllers = @[homeNavController,findNavController,shopNavController,userNavController];
    
    self.window.rootViewController = tbController;
    
    return YES;
}

-(void)removeLun{
    [lunchView_ removeFromSuperview];
    NSLog(@"----------------------");
}

- (void)setColor{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"res/DefaultTheme/NavBar.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithWhite:0.287 alpha:1.000], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor colorWithRed:0.867 green:0.000 blue:0.267 alpha:1.000];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

@end
