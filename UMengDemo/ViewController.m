//
//  ViewController.m
//  UMengDemo
//
//  Created by wangdemin on 16/9/19.
//  Copyright © 2016年 Demin. All rights reserved.
//
/**
 * 1.找到TARGETS下的Build Settings；
 * 2.搜索Bitcode,设置为NO；
 */
#import "ViewController.h"
#import "UMSocialControllerService.h"
#import "UMSocial.h"

@interface ViewController () <UMSocialUIDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)clickBtn
{
    //分享图片、视频、网址、音乐只能同时设定一个
    //分享URL图片
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];
    //分享URL视频
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeVideo url:@""];

    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    
    //代码中配置的URL为点击分享内容后的跳转链接
    //1.分享到微信好友内容
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
    
    //2.分享到微信朋友圈内容
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57df4c83e0f55ae90800105c"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                       delegate:self];
    //注意当URL图片和UIImage同时存在时，只有URL图片生效
}

//实现回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

@end
