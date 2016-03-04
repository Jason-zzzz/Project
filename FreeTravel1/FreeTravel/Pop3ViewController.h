//
//  Pop3ViewController.h
//  FreeTravel
//
//  Created by Admin on 16/3/4.
//  Copyright © 2016年 Miko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pop3ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *pop3Web;

@property (nonatomic, copy) NSString *requestString;

@end
