//
//  GlobalFont.h
//  GlobalFontDemo
//
//  Created by Dragon Sun on 16/2/20.
//  Copyright © 2016年 Dragon Sun. All rights reserved.
//

/*
    设置全局字体的例子
    
    使用方法：
        在Info.plist中新建键值对：
            GlobalFontName(String)  字体名称
            GlobalFontSize(Number)  字体大小
        如果有GlobalFontName，有GlobalFontSize，则按照设置显示字体
        如果有GlobalFontName，无GlobalFontSize，则只修改字体名称，不修改大小
        如果无GlobalFontName，有GlobalFontSize，则不修改字体名称，只修改大小
 
    实现方式：
        利用了Method Swizzling来实现
        * 如果指定类型的视图要支持全局字体，则必须仿照本例实现对应的类别
        * 本例目前仅实现了对UILabel、UIButton、UITextField的支持
 */

#import <UIKit/UIKit.h>

@interface UILabel (GlobalFont)

@end


@interface UIButton (GlobalFont)

@end


@interface UITextField (GlobalFont)

@end


@interface UITableViewCell (GlobalFont)

@end
