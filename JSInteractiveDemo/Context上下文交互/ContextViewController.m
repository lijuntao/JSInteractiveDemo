//
//  ContextViewController.m
//  JSInteractiveDemo
//
//  Created by 李俊涛 on 17/4/14.
//  Copyright © 2017年 myhexin. All rights reserved.
//

#import "ContextViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface ContextViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *homeWebView;
@property (strong, nonatomic) JSContext *context;
@end

@implementation ContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBtnView];
    [self loadHTML];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)callJSBtnAction:(id)sender {
    NSLog(@"开始调用JS函数,有返回值");
    //第一种
//    NSString *returnStr = [self.homeWebView stringByEvaluatingJavaScriptFromString:@"objcCallJS()"];
//    NSLog(@"返回值为:%@",returnStr);
    
    //第二种
//    NSString *js = @"objcCallJS()";
//    JSValue *value = [self.context evaluateScript:js];
//    NSLog(@"%@",[value toString]);
    
    //第三种
    JSValue *valueFuc = self.context[@"objcCallJS"];
    JSValue *value = [valueFuc callWithArguments:nil];
    NSLog(@"%@",[value toString]);
}

- (void)callJSBtnNoreturnAction:(id)sender {
    NSLog(@"开始调用JS函数,没有返回值");
    
    //第一种
//    [self.homeWebView stringByEvaluatingJavaScriptFromString:@"objcCallJSNoReturn()"];
    
    //第二种
//    NSString *js = @"objcCallJSNoReturn()";
//    JSValue *value = [self.context evaluateScript:js];
//    NSLog(@"%@",[value toString]);
    
    //第三种
    JSValue *valueFuc = self.context[@"objcCallJSNoReturn"];
    JSValue *value = [valueFuc callWithArguments:nil];
    NSLog(@"%@",[value toString]);
}

- (void)callJSBtnParamAction:(id)sender {
    NSLog(@"开始调用JS函数,带有参数");
    
    //第一种
//    [self.homeWebView stringByEvaluatingJavaScriptFromString:@"objcCallJSParam('ljt','ths')"];
    
    //第二种
//    NSString *js = @"objcCallJSParam('ljt','ths')";
//    JSValue *value = [self.context evaluateScript:js];
//    NSLog(@"%@",[value toString]);
    
    //第三种
    JSValue *valueFuc = self.context[@"objcCallJSParam"];
    JSValue *value = [valueFuc callWithArguments:@[@"ljt",@"ths"]];
    NSLog(@"%@",[value toString]);
}

#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.context == nil) {
        self.context = [self.homeWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        NSLog(@"self.contex=%@",self.context);
    }
    //有参数
    __weak typeof(self) weakSelf = self;
    self.context[@"JSCallObjcParam"] = (id)^(NSString *param1, NSString *param2) {
        NSLog(@"有参，无返回值");
        NSString *message = [NSString stringWithFormat:@"%@:%@",param1,param2];
        UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"objc弹框" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alterVC addAction:okAction];
        [weakSelf presentViewController:alterVC animated:YES completion:nil];
    };
    
    self.context[@"JSCallObjc"] = ^(){
        NSLog(@"无参，无返回值");
    };
    self.context[@"JSCallObjcReturn"] = ^(){
        NSLog(@"无参，有返回值");
        return @"ljt";
    };
}

#pragma makr 私有函数
- (void)loadHTML {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"ContextAPI" ofType:@"html"];
    NSLog(@"%@",htmlPath);
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.homeWebView loadRequest:urlRequest];
}

- (void)addBtnView {
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(50, 300, 300, 300)];
    btnView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btnView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, 30)];
    titleLabel.text = @"非web控件区域";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnView addSubview:titleLabel];
    
    UIButton *callJSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callJSBtn setFrame:CGRectMake(0, 50, 300, 30)];
    [callJSBtn setTitle:@"调用JS函数,有返回值" forState:UIControlStateNormal];
    [callJSBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [callJSBtn addTarget:self action:@selector(callJSBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:callJSBtn];
    
    UIButton *callJSBtnNoReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callJSBtnNoReturn setFrame:CGRectMake(0, 100, 300, 30)];
    [callJSBtnNoReturn setTitle:@"调用JS函数，没有返回值" forState:UIControlStateNormal];
    [callJSBtnNoReturn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [callJSBtnNoReturn addTarget:self action:@selector(callJSBtnNoreturnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:callJSBtnNoReturn];
    
    UIButton *callJSBtnParam = [UIButton buttonWithType:UIButtonTypeCustom];
    [callJSBtnParam setFrame:CGRectMake(0, 150, 300, 30)];
    [callJSBtnParam setTitle:@"调用JS函数，带有参数" forState:UIControlStateNormal];
    [callJSBtnParam setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [callJSBtnParam addTarget:self action:@selector(callJSBtnParamAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:callJSBtnParam];
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
