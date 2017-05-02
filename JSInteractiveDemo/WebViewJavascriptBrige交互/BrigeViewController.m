//
//  BrigeViewController.m
//  JSInteractiveDemo
//
//  Created by 李俊涛 on 17/4/14.
//  Copyright © 2017年 myhexin. All rights reserved.
//

#import "BrigeViewController.h"
#import "WebViewJavascriptBridge.h"

@interface BrigeViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *homeWebView;
@property (strong, nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation BrigeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.homeWebView];
    [self.bridge setWebViewDelegate:self];
    [self addBtnView];
    [self loadHTML];
    
    //注册js调用函数，并设定回调。js中可以调用JSCallObjc的函数
    [self.bridge registerHandler:@"JSCallObjc" handler:^(id data, WVJBResponseCallback responseCallback){
        NSString *paramStr = [data objectForKey:@"key"];
        UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"objc弹框" message:paramStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alterVC addAction:okAction];
        [self presentViewController:alterVC animated:YES completion:nil];
        responseCallback(@"Response from testObjcCallback");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callJSBtnAction:(id)sender {
    NSLog(@"调用JS函数");
    //callHandler有几种形式
    //- (void)callHandler:(NSString *)handlerName 只调用函数
    //- (void)callHandler:(NSString *)handlerName data:(id)data 调用的同时携带数据
    //- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback 不但调用和携带数据，而且设置回调函数处理所需的数据(如果需要处理结果数据)
//    [self.bridge callHandler:@"objcCallJS" data:@{@"key":@"value"} responseCallback:^(id responseData){
//        NSLog(@"%@",responseData);
//    }];
//    [self.bridge callHandler:@"objcCallJS"];
    [self.bridge callHandler:@"objcCallJS" data:@{@"key":@"value"}];
    
}

#pragma makr 私有函数
- (void)loadHTML {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"BrigeAPI" ofType:@"html"];
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
    [callJSBtn setTitle:@"调用JS函数" forState:UIControlStateNormal];
    [callJSBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [callJSBtn addTarget:self action:@selector(callJSBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:callJSBtn];
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
