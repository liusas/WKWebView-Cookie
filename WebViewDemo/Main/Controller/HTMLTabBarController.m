//
//  HongKongTabBarController.m
//  HKChinaUnicom
//
//  Created by 刘峰 on 2019/4/4.
//  Copyright © 2018年 Liufeng. All rights reserved.
//

#import "HTMLTabBarController.h"
#import "HTMLFiveWebViewController.h"
#import "AppDelegate.h"

//@"http://shangcheng.ssbfenqi.com/index.php/mobile/Index/index.html"
//@"http://shangcheng.ssbfenqi.com/index.php/mobile/Goods/categoryList.html"
//@"http://shangcheng.ssbfenqi.com/index.php/mobile/Cart/index.html"
//@"http://shangcheng.ssbfenqi.com/index.php/mobile/User/index.html"

@interface HTMLTabBarController ()

@property (nonatomic, copy) NSString *region;

@end

@implementation HTMLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];//初始化
}

/**
 * 抽取成一个方法
 * 传入控制器、标题、正常状态下图片、选中状态下图片
 * 直接调用这个方法就可以了
 */
- (void)controller:(UIViewController *)controller Title:(NSString *)title tabBarItemImage:(NSString *)image tabBarItemSelectedImage:(NSString *)selectedImage
{
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
    UIImage *imageHome = [UIImage imageNamed:selectedImage];
    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setSelectedImage:imageHome];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
}

- (void)initData {
    HTMLFiveWebViewController *html1 = [HTMLFiveWebViewController new];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:html1];
    html1.htmlUrl = @"http://www.baidu.com";
    html1.tabName = @"tab1";
    [self controller:nav1 Title:@"tab1" tabBarItemImage:@"shouye" tabBarItemSelectedImage:@"shouye-2"];
    
    HTMLFiveWebViewController *html2 = [HTMLFiveWebViewController new];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:html2];
    html2.htmlUrl = @"http://www.baidu.com";
    html2.tabName = @"tab2";
    [self controller:nav2 Title:@"tab2" tabBarItemImage:@"fenlei" tabBarItemSelectedImage:@"fenlei-2"];
    
    HTMLFiveWebViewController *html3 = [HTMLFiveWebViewController new];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:html3];
    html3.htmlUrl = @"http://www.baidu.com";
    html3.tabName = @"tab3";
    [self controller:nav3 Title:@"tab3" tabBarItemImage:@"gouwuche" tabBarItemSelectedImage:@"gouwuche-2"];
    
    HTMLFiveWebViewController *html4 = [HTMLFiveWebViewController new];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:html4];
    html4.htmlUrl = @"http://www.baidu.com";
    html4.tabName = @"tab4";
    [self controller:nav4 Title:@"tab4" tabBarItemImage:@"wode" tabBarItemSelectedImage:@"wode-2"];
    
    self.viewControllers = @[nav1, nav2, nav3, nav4];
    self.selectedIndex = 0;
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:bgView atIndex:0];
    self.view.opaque = YES;
//    self.tabBar.tintColor = RGBCOLOR(74, 144, 226);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
