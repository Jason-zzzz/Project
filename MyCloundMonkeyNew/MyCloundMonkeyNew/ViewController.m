//
//  ViewController.m
//  MyCloundMonkeyNew
//
//  Created by Admin on 16/1/20.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import "ViewController.h"
#import "HomeTableView.h"
#import "HomeTableViewCell.h"
#import "HomeTableViewSecondCell.h"
#import "HomeTableViewThirdCell.h"
#import "TableViewGoodCell.h"
#import "DataModel.h"
#import "AdDataModel.h"
#import "GetInternetData.h"
#import "SearchViewController.h"
#import "ProductsViewController.h"
#import "ScanningViewController.h"

#define subFieldUrl @"http://global.api.yunhou.com/yunhou-global-api/service?method=bubugao.mobile.global.sysParamAndLoading.get&version=1.4.1&eCode=225bff88a45918a&mChannel=App Store&params={'sourceType':'2'}&phoneModel=iPhone&source=ios&systemVersion=IOS9.2&uCode=195858116e65781&version=1.4.1&versionCode=28"
#define URL_FIRSTCELL @"http://global.api.yunhou.com/yunhou-global-api/service?method=bubugao.mobile.global.index.recommend.get&version=1.4.1"
#define URL_FIRST_REQUEST @"params="

@interface ViewController ()<QHNavSliderMenuDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    // 分栏与分栏数
    int menuCount;
    NSMutableArray *titles_;
    QHNavSliderMenu *navSliderMenu;
    
    // 广告栏
    UIScrollView *contentScrollView;
    
    // tableview视图控制器
    HomeTableView *homeTableView_;
    HomeTableViewSecondCell *homeTableViewSecondCell_;
    HomeTableViewCell *firstCell_;
    HomeTableViewThirdCell *thirdCell_;
    
    // 数据模型与数据获取
    DataModel *dataModel_;
    GetInternetData *getInternetData_;
    
    // 创建点击弹出窗口
    SearchViewController *searchViewController_;
    
    ProductsViewController *productsViewController_;
    
    NSTimer *timer_;
}

@end

//extern DataModel *dataModel;

@implementation ViewController

@synthesize arr = arr_;

- (id)init{
    if (self = [super init]) {
        
        NSLog(@"沙盒路径:%@", NSHomeDirectory());
        
        arr_ = [NSMutableArray array];
        
        searchViewController_ = [[SearchViewController alloc] init];
        
        // 初始化数据模型
        dataModel_ = [[DataModel alloc] init];
        
        // 初始化数据请求接口
        getInternetData_ = [[GetInternetData alloc] init];
        [getInternetData_ getSubField:subFieldUrl];
        [getInternetData_ getDataForUrl:URL_FIRSTCELL urlRequest:URL_FIRST_REQUEST];
        
        // 判断数据是否加载完成
        while (!getInternetData_.finish) {
            if (getInternetData_.finish) {
                break;
            }
        }
        
        // 处理分栏数据
        [dataModel_ getSubFieldArray:getInternetData_.subField];
        // 处理首页数据
        [dataModel_ getHomeImage:getInternetData_.totalData];
        NSLog(@"%@",getInternetData_.totalData);
        //        // 处理secondCell数据
        //        [dataModel_ getSecondImage:getInternetData_.totalData];
        
        while (!dataModel_.finish) {
            if (dataModel_.finish) {
                break;
            }
        }
        
        // 异步处理信息:秒杀栏数据
        [dataModel_ getGoodCellData:getInternetData_.totalData];
        
        self.arr = dataModel_.cmSubfield;
        self.imagesArray = dataModel_.firstCellImages;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"res/DefaultTheme/SearchIcon_red"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"res/Root/QR_code"] style:UIBarButtonItemStyleDone target:self action:@selector(scanAction:)];
    }
    return self;
}

- (void)setArr:(NSMutableArray *)arr{
    arr_ = arr;
    
    titles_ = [[NSMutableArray alloc] initWithCapacity:self.arr.count];
    
    [self initView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuType = [@(QHNavSliderMenuTypeTitleOnly) integerValue];
    self.view.backgroundColor =[UIColor whiteColor];
    menuCount = (int)self.arr.count;
}

- (void)initView {
    
    ///第一个子视图为scrollView或者其子类的时候 会自动设置 inset为64 这样navSliderMenu会被下移 所以最好设置automaticallyAdjustsScrollViewInsets为no 或者[self.view addSubview:[UIView new]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    QHNavSliderMenuStyleModel *model = [QHNavSliderMenuStyleModel new];
    
    [titles_ addObjectsFromArray:arr_];
    
    model.menuTitles = [titles_ copy];
    model.titleLableFont = defaultFont(13);
    navSliderMenu = [[QHNavSliderMenu alloc] initWithFrame:(CGRect){0,64,screenWidth,39} andStyleModel:model andDelegate:self showType:self.menuType];
    
    [self.view addSubview:navSliderMenu];
    
    ///如果只需要一个菜单 下面这些都可以不要  以下是个添加page视图的例子
    
    //example 用于滑动的滚动视图
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navSliderMenu.bottom, screenWidth, screenHeight-navSliderMenu.bottom)];
    contentScrollView.contentSize = (CGSize){screenWidth*menuCount,contentScrollView.contentSize.height};
    contentScrollView.backgroundColor = [UIColor whiteColor];
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate      = self;
    contentScrollView.scrollsToTop  = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    
    
    [self addHomeTableView];
    [self.view addSubview:contentScrollView];
    
}

#pragma mark -QHNavSliderMenuDelegate
- (void)navSliderMenuDidSelectAtRow:(NSInteger)row {
    //让scrollview滚到相应的位置
    [contentScrollView setContentOffset:CGPointMake(row*screenWidth, contentScrollView.contentOffset.y)  animated:NO];
}

#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //用scrollView的滑动大小与屏幕宽度取整数 得到滑动的页数
    [navSliderMenu selectAtRow:(int)((scrollView.contentOffset.x+screenWidth/2.f)/screenWidth) andDelegate:NO];
    //根据页数添加相应的视图
    
}

#pragma mark MyMethods

- (void)addHomeTableView{
    //    for (NSInteger i = 0; i < 8; i++) {
    CGRect frame = CGRectMake(0, 0, screenWidth, screenHeight - 152);
    homeTableView_ = [[HomeTableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [homeTableView_ registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"firstCell"];
    //    [homeTableView_ registerClass:[HomeTableViewSecondCell class] forCellReuseIdentifier:@"secondCell"];
    [homeTableView_ registerClass:[HomeTableViewThirdCell class] forCellReuseIdentifier:@"thirdCell"];
    [homeTableView_ registerClass:[TableViewGoodCell class] forCellReuseIdentifier:@"goodCell"];
    
    homeTableView_.separatorStyle = UITableViewCellSeparatorStyleNone;
    homeTableView_.delegate = self;
    homeTableView_.dataSource = self;
    
    [contentScrollView addSubview:homeTableView_];
    //    }
}

#pragma mark UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if(section == 2 || section == 4){
        return 1;
    }else if (section == 3){
        return dataModel_.secondGetData.count;
    }
    return 2;
}

// 声明剩余时间
static NSInteger restTime = 0;
// 声明一个图片数组
static NSMutableArray *imageArr = nil;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        firstCell_ = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        firstCell_.images = _imagesArray;
        return firstCell_;
    }else if(indexPath.section == 1){
        UINib *nib = [UINib nibWithNibName:@"HomeTableViewSecondCell" bundle:nil];
        [homeTableView_ registerNib:nib forCellReuseIdentifier:@"homeTableViewSecondCell"];
        homeTableViewSecondCell_ = [tableView dequeueReusableCellWithIdentifier:@"homeTableViewSecondCell" forIndexPath:indexPath];
        return homeTableViewSecondCell_;
    }else if(indexPath.section == 2 || indexPath.section == 4){
            thirdCell_ = [tableView dequeueReusableCellWithIdentifier:@"thirdCell" forIndexPath:indexPath];
            return thirdCell_;
    }else if(indexPath.section == 3){
        TableViewGoodCell *goodCell = [tableView dequeueReusableCellWithIdentifier:@"goodCell" forIndexPath:indexPath];
        
        
        NSDictionary *dic = dataModel_.secondGetData[indexPath.row];
        goodCell.goodImageView.image = nil;
//        goodCell.urlString = [dic objectForKey:@"imageUrl"];
        goodCell.goodIntroduce.text = [dic objectForKey:@"productName"];
        
        if (!imageArr) {
            imageArr = [NSMutableArray array];
            NSLog(@"%@=============",imageArr);
            for (int i = 0; i < dataModel_.secondGetData.count; i++) {
                [imageArr addObject:@"1"];
            }
        }
        if ([imageArr[indexPath.row] isKindOfClass:[UIImage class]]){
            goodCell.goodImageView.image = imageArr[indexPath.row];
        }else{
            // 异步下载
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                // 1.下载globle
                NSURL *url = [NSURL URLWithString:[dic objectForKey:@"imageUrl"]];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:data];
                
                imageArr[indexPath.row] = image;
                // 2.回到主线程显示图片
                dispatch_async(dispatch_get_main_queue(), ^{
                    goodCell.goodImageView.image =  imageArr[indexPath.row];
                });
            });
        }
        
        // 创建一个NSTimer记录剩余时间
        if (!timer_) {
            restTime = ([[dic objectForKey:@"endTime"] integerValue] - [[dic objectForKey:@"sysDate"] integerValue]);
            timer_ = [[NSTimer alloc] initWithFireDate:[NSDate distantPast] interval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:timer_ forMode:NSRunLoopCommonModes];
        }
        goodCell.remianTimeNumber = restTime;
        goodCell.goodNowPrice.text = [NSString stringWithFormat:@"¥%ld.00",[[dic objectForKey:@"payPrice"] integerValue] / 100];
//        goodCell.goodAbondonPrice.text = [NSString stringWithFormat:@"¥%ld.00",[[dic objectForKey:@"mkPrice"] integerValue] / 100];
        
        // 画删除线
        NSString *goodAbondonPrice = [NSString stringWithFormat:@"¥%ld.00",[[dic objectForKey:@"mkPrice"] integerValue] / 100];
        NSUInteger length = [goodAbondonPrice length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:goodAbondonPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, length)];
        
        [goodCell.goodAbondonPrice setAttributedText:attri];
        return goodCell;
    }{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (!cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        }
        return cell;
    }
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        productsViewController_ = [[ProductsViewController alloc] init];
        productsViewController_.view.backgroundColor = [UIColor whiteColor];
        productsViewController_.title = @"商品详情";
        UINavigationController *productsNavController = [[UINavigationController alloc] initWithRootViewController:productsViewController_];
        [productsNavController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [productsNavController.navigationBar setTintColor:[UIColor whiteColor]];
        [productsNavController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,nil]];
        [self presentViewController:productsNavController animated:YES completion:^{
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 155;
    }else if(indexPath.section == 1){
        return 84.5;
    }else if (indexPath.section == 2 || indexPath.section == 4){
        return 40;
    }else if(indexPath.section == 3){
        return 135;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if(section == 1){
        return 3;
    }else if(section == 2){
        return 0.001;
    }else if(section == 3){
        return 1;
    }else if(section == 4){
        return 0.01;
    }else{
        return 3.5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if(section == 1){
        return 3;
    }else if(section == 3){
        return 0.01;
    }else if(section == 4){
        return 0.01;
    }else{
        return 3.5;
    }
}

#pragma mark MyAction

- (IBAction)refreshAction:(id)sender{
    
}

- (IBAction)searchAction:(id)sender{
    searchViewController_.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:searchViewController_ animated:YES completion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)scanAction:(id)sender{
    ScanningViewController * sVC = [[ScanningViewController alloc]init];
//    sVC.hidesBottomBarWhenPushed=YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sVC];
    sVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"res/cancel.png"] style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    sVC.title = @"二维码扫描";
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)timerAction:(id)sender{
    restTime -= 1000;
}

@end
