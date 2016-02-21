//
//  GlobalFont.m
//  GlobalFontDemo
//
//  Created by Dragon Sun on 16/2/20.
//  Copyright © 2016年 Dragon Sun. All rights reserved.
//

#import "GlobalFont.h"
#import <objc/runtime.h>


#define GlobalFontNameKey @"GlobalFontName"
#define GlobalFontSizeKey @"GlobalFontSize"

#define exchangeMethod                                                                          \
    static dispatch_once_t predicate;                                                           \
    dispatch_once(&predicate, ^{                                                                \
        Method srcImp1 = class_getInstanceMethod([self class], @selector(initWithFrame:));      \
        Method desImp1 = class_getInstanceMethod([self class], @selector(desInitWithFrame:));   \
        method_exchangeImplementations(srcImp1, desImp1);                                       \
        Method srcImp2 = class_getInstanceMethod([self class], @selector(initWithCoder:));      \
        Method desImp2 = class_getInstanceMethod([self class], @selector(desInitWithCoder:));   \
        method_exchangeImplementations(srcImp2, desImp2);                                       \
    })                                                                                          \

#define initFrameMethod(objectFont)                                                             \
    [self desInitWithFrame:frame];                                                              \
    if (self)                                                                                   \
        objectFont = globalFont(objectFont);                                                    \
    return self                                                                                 

#define initCoderMethod(objectFont)                                                             \
    [self desInitWithCoder:aDecoder];                                                           \
    if (self)                                                                                   \
        objectFont = globalFont(objectFont);                                                    \
    return self

UIFont *globalFont(UIFont *ObjectFont) {
    NSString *globalFontName = [[NSBundle mainBundle] objectForInfoDictionaryKey:GlobalFontNameKey];
    NSNumber *globalFontSize = [[NSBundle mainBundle] objectForInfoDictionaryKey:GlobalFontSizeKey];
    
    CGFloat fontSize = globalFontSize ? globalFontSize.doubleValue : ObjectFont.pointSize;
    if (globalFontName) {
        return [UIFont fontWithName:globalFontName size:fontSize];
    } else {
        return [UIFont fontWithName:ObjectFont.fontName size:fontSize];
    }
}

@implementation UITableViewCell (GlobalFont)

+ (void)load {
    exchangeMethod;
}

- (id)desInitWithFrame:(CGRect)frame {
    initFrameMethod(self.textLabel.font);
}

- (id)desInitWithCoder:(NSCoder *)aDecoder {
    initCoderMethod(self.textLabel.font);
}

@end

@implementation UILabel (GlobalFont)

+ (void)load {
    exchangeMethod;
}

- (id)desInitWithFrame:(CGRect)frame {
    initFrameMethod(self.font);
}

- (id)desInitWithCoder:(NSCoder *)aDecoder {
    initCoderMethod(self.font);
}

@end


@implementation UIButton (GlobalFont)

+ (void)load {
    exchangeMethod;
}

- (id)desInitWithFrame:(CGRect)frame {
    initFrameMethod(self.titleLabel.font);
}

- (id)desInitWithCoder:(NSCoder *)aDecoder {
    initCoderMethod(self.titleLabel.font);
}

@end


@implementation UITextField (GlobalFont)

+ (void)load {
    exchangeMethod;
}

- (id)desInitWithFrame:(CGRect)frame {
    initFrameMethod(self.font);
}

- (id)desInitWithCoder:(NSCoder *)aDecoder {
    initCoderMethod(self.font);
}

@end
