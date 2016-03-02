//
//  PopViewController.m
//  FreeTravel
//
//  Created by Jason_zzzz on 16/3/1.
//  Copyright © 2016年 Jason_zzzz. All rights reserved.
//

#import "PopViewController.h"
#import "FSDropDownMenu.h"
#import "FSDropDownMenu2.h"

@interface PopViewController () <FSDropDownMenuDataSource, FSDropDownMenuDelegate,FSDropDownMenu2DataSource, FSDropDownMenu2Delegate, UITableViewDelegate, UITableViewDataSource>{
    
    __weak IBOutlet UIButton *firstButton_;
    __weak IBOutlet UIButton *secondButton_;
    
}

@property(nonatomic,strong) NSArray *cityArr;
@property(nonatomic,strong) NSArray *areaArr;
@property(nonatomic,strong) NSArray *currentAreaArr;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
}

#pragma mark Actions

- (IBAction)dissMiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)popMenu:(id)sender {
    
    UITableView *tabV = [[UITableView alloc] initWithFrame:CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 200) style:UITableViewStylePlain];
    
    tabV.delegate = self;
    tabV.dataSource = self;
    
//    UIView *tabV = [[UIView alloc] initWithFrame:CGRectMake(0, -400, 375, 446)];
    tabV.backgroundColor = [UIColor blackColor];
    [self.view addSubview:tabV];
    
    [UIView animateWithDuration:0.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        tabV.frame = CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, 200);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
//            tabV.center = CGPointMake(-200, -200);
        }];
    }];
}

#pragma mark Methods

- (void)buttonInit:(id)sender {
    
    UIButton *btn = sender;
    
    if (btn == firstButton_) {
        FSDropDownMenu *menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 104) andHeight:300];
        menu.tag = 1001;
        menu.dataSource = self;
        menu.delegate = self;
        
        menu.transformView = btn.imageView;
        [self.view addSubview:menu];
        
        [btn setTitle:@"附近" forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"expandableImage"] forState:UIControlStateNormal];
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(11, 82, 11, 0);
        
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        FSDropDownMenu2 *menu = [[FSDropDownMenu2 alloc] initWithOrigin:CGPointMake(0, 104) andHeight:300];
        menu.tag = 1001;
        menu.dataSource = self;
        menu.delegate = self;
        
        menu.transformView = btn.imageView;
        [self.view addSubview:menu];
        
        [btn setTitle:@"呵呵" forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"expandableImage"] forState:UIControlStateNormal];
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(11, 82, 11, 0);
        
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
}

static BOOL isFirstButton;

-(void)btnPressed:(id)sender{
    if (sender == firstButton_) {
        isFirstButton = YES;
        FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
        [UIView animateWithDuration:0.2 animations:^{
         
        } completion:^(BOOL finished) {
            [menu menuTapped];
        }];
    } else {
        isFirstButton = NO;
        FSDropDownMenu2 *menu = (FSDropDownMenu2*)[self.view viewWithTag:1001];
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            [menu menuTapped];
        }];
    }
}


#pragma mark - reset button size

-(void)resetItemSizeBy:(NSString*)str{
    if (isFirstButton) {
        
        [firstButton_ setTitle:str forState:UIControlStateNormal];
        NSDictionary *dict = @{NSFontAttributeName:firstButton_.titleLabel.font};
        CGSize size = [str boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    //    btn.frame = CGRectMake(0, 0,size.width+33, 30);
        firstButton_.backgroundColor = [UIColor whiteColor];
        firstButton_.imageEdgeInsets = UIEdgeInsetsMake(11, size.width + 52, 11, 0);
        
    }else{
        [secondButton_ setTitle:str forState:UIControlStateNormal];
        NSDictionary *dict = @{NSFontAttributeName:secondButton_.titleLabel.font};
        CGSize size = [str boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        //    btn.frame = CGRectMake(0, 0,size.width+33, 30);
        secondButton_.backgroundColor = [UIColor whiteColor];
        secondButton_.imageEdgeInsets = UIEdgeInsetsMake(11, size.width + 52, 11, 0);
    }
}

#pragma mark - FSDropDown datasource & delegate

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
        [self resetItemSizeBy:_currentAreaArr[indexPath.row]];
    }
    
}

#pragma mark UITableViewDelegate

#pragma mark UITableViewDataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    
    cell.textLabel.text = @"123";
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
