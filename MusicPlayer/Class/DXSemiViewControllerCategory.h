//
//  DXSemiViewControllerCategory.h
//  DXSemiSideDemo
//

//

#import <UIKit/UIKit.h>

@class DXSemiViewController;
//#import "DXSemiViewController.h"

@interface UIViewController (SemiViewController)

@property (nonatomic, strong) DXSemiViewController *leftSemiViewController;
@property (nonatomic, strong) DXSemiViewController *rightSemiViewController;


@end
