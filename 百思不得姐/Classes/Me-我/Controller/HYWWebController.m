
//
//  HYWWebController.m
//  百思不得姐
//
//  Created by heew on 15/8/4.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWWebController.h"
#import "HYWSquare.h"

@interface HYWWebController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation HYWWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
    self.webView.delegate = self;
    self.navigationItem.title = self.square.name;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)reFresh:(id)sender {
    [self.webView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
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
