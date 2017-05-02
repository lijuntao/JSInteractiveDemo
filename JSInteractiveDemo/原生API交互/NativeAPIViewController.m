//
//  NativeAPIViewController.m
//  JSInteractiveDemo
//
//  Created by 李俊涛 on 17/4/14.
//  Copyright © 2017年 myhexin. All rights reserved.
//

#import "NativeAPIViewController.h"

@interface NativeAPIViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *homeWebView;

@end

@implementation NativeAPIViewController

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
    NSString *returnStr = [self.homeWebView stringByEvaluatingJavaScriptFromString:@"objcCallJS()"];
    NSLog(@"返回值为:%@",returnStr);
}

- (void)callJSBtnNoreturnAction:(id)sender {
    NSLog(@"开始调用JS函数,没有返回值");
    [self.homeWebView stringByEvaluatingJavaScriptFromString:@"objcCallJSNoReturn()"];
}

- (void)callJSBtnParamAction:(id)sender {
    NSLog(@"开始调用JS函数,带有参数");
    [self.homeWebView stringByEvaluatingJavaScriptFromString:@"objcCallJSParam('ljt','ths')"];
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"将要开始加载页面");
    NSString *urlStr = [[request URL] absoluteString];
    if ([urlStr containsString:@"param"]) {
        NSRange range = [urlStr rangeOfString:@"param="];
        NSString *paramStr = [urlStr substringFromIndex:range.location + range.length];
        NSLog(@"param=%@",paramStr);
        UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"objc弹框" message:paramStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alterVC addAction:okAction];
        [self presentViewController:alterVC animated:YES completion:nil];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载页面");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"页面加载完成");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"页面加载失败");
}

#pragma makr 私有函数
- (void)loadHTML {
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"NativeAPI" ofType:@"html"];
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
