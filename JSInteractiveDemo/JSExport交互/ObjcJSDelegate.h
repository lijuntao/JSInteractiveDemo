//
//  ObjcJSDelegate.h
//  JSInteractiveDemo
//
//  Created by 李俊涛 on 17/4/17.
//  Copyright © 2017年 myhexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjcJSDelegate <JSExport>

//有参数
- (void)JSCallObjcParam:(NSString *)param1 with:(NSString *)param2;
//无参数
- (void)JSCallObjc;
//有返回值
- (NSString *)JSCallObjcReturn;
@end
