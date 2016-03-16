//
//  PPViewController.m
//  FreeTravel
//
//  Created by Admin on 16/3/3.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "PPViewController.h"
#import "FSDropDownMenu.h"

@interface PPViewController () < FSDropDownMenuDataSource, FSDropDownMenuDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    
    __weak IBOutlet UIButton *firstButton_;
    __weak IBOutlet UIButton *secondButton_;
    __weak IBOutlet UIButton *thirdButton_;
    __weak IBOutlet UITableView *popTableView_;
    
    UISearchBar *searchBar;
}

@property (nonatomic,strong) NSArray *cityArr;
@property (nonatomic,strong) NSArray *areaArr;
@property (nonatomic,strong) NSArray *currentAreaArr;

@end

@implementation PPViewController

#pragma mark SystemMethods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去白带
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UINib *nib = [UINib nibWithNibName:@"PopCell" bundle:nil];
    [popTableView_ registerNib:nib forCellReuseIdentifier:@"popCell"];
    popTableView_.separatorColor = [UIColor lightGrayColor];
    [self initView];
}

#pragma mark SelfMethods

- (void)initView {
    
    
    _cityArr = @[@"附近",@"上海",@"北京",@"同城"];
    _areaArr = @[
                 @[@"附近",@"500米",@"1000米",@"2000米",@"5000米"],
                 @[@"徐家汇",@"人民广场",@"陆家嘴"],
                 @[@"三里屯",@"亚运村",@"朝阳公园"],
                 @[@"同城"],
                 ];
    
    _currentAreaArr = _areaArr[0];
    
    [self buttonInit:firstButton_];
    [self buttonInit:secondButton_];
    
    
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 28)];
//    searchBar.backgroundImage = [UIImage imageNamed:@"nav_back1.jpg"];
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:searchButton];
    
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped)];
    [self.view addGestureRecognizer:gesture];
}

- (void)buttonInit: (id)sender {
    
    UIButton *btn = sender;
    FSDropDownMenu *menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 104) andHeight:300];
    
    if (btn == firstButton_) {
        menu.tag = 1001;
        [btn setTitle:@"附近" forState:UIControlStateNormal];
    } else {
        menu.tag = 1002;
        [btn setTitle:@"金福" forState:UIControlStateNormal];
    }
    menu.dataSource = self;
    menu.delegate = self;

    menu.transformView = btn.imageView;
    [self.view addSubview:menu];
    [btn setImage:[UIImage imageNamed:@"expandableImage"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(11, 82, 11, 0);
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)resetItemSizeBy: (NSString *)str button: (id)sender {
    
    UIButton *btn = sender;
    [btn setTitle:str forState:UIControlStateNormal];
    NSDictionary *dict = @{NSFontAttributeName:firstButton_.titleLabel.font};
    CGSize size = [str boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    btn.backgroundColor = [UIColor whiteColor];
    btn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width + 52, 11, 0);
}

#pragma mark Actions

- (void)backgroundTapped{
    [searchBar resignFirstResponder];
}

static BOOL isFirstButton;
- (void)btnPressed: (id)sender {
    
    FSDropDownMenu *menu;
    if (sender == firstButton_) {
        menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
        isFirstButton = YES;
    } else {
        menu = (FSDropDownMenu*)[self.view viewWithTag:1002];
        isFirstButton = NO;
    }
    [UIView animateWithDuration:0.2 animations:^{
        
    } completion:^(BOOL finished) {
        [menu menuTapped];
    }];
}

#pragma mark FSDropDownMenuDataSource & FSDropDownMenuDelegate

- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == menu.rightTableView) {
        return _cityArr.count;
    }else{
        return _currentAreaArr.count;
    }
}
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == menu.rightTableView) {
        
        return _cityArr[indexPath.row];
    }else{
        return _currentAreaArr[indexPath.row];
    }
}


- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == menu.rightTableView){
        _currentAreaArr = _areaArr[indexPath.row];
        [menu.leftTableView reloadData];
    }else{
        if (isFirstButton) {
            [self resetItemSizeBy:_currentAreaArr[indexPath.row] button:firstButton_];
        } else {
            [self resetItemSizeBy:_currentAreaArr[indexPath.row] button:secondButton_];
        }
    }
    
}



#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popCell" forIndexPath:indexPath];
    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = @"123";
    
    return cell;
}


@end
