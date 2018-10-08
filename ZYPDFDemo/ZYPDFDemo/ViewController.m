//
//  ViewController.m
//  ZYPDFDemo
//
//  Created by 郑奕 on 2018/9/25.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIWebView *secondWebView;

@property (nonatomic, copy) NSMutableString *htmlString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self createHTMLFileWithTitle:@"历史记录"];
    [self getImageForWebView];
    [self.webView loadHTMLString:self.htmlString  baseURL:[[NSBundle mainBundle] bundleURL]];
    self.webView.delegate = self;
    [self.webView reload];
    
    NSBundle *echartsBundle = [NSBundle mainBundle];
    NSString *urlString = [echartsBundle pathForResource:@"ICLineTemperatureChart" ofType:@"html"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *loadRequest = [[NSURLRequest alloc] initWithURL:url];
//    self.secondWebView.multipleTouchEnabled = NO;
//    self.secondWebView.userInteractionEnabled = NO;
    self.secondWebView.delegate = self;
    [self.secondWebView loadRequest:loadRequest];
    [self.secondWebView reload];
    
}

#pragma mark - Custom Method
- (void)createHTMLFileWithTitle:(NSString *)title {
 
    [self.htmlString appendString:[NSString stringWithFormat:@"<br /><p>\
                                   <br />\
                                   <br />\
                                   </p>\
                                   <h2 style=\"text-align:center;\">\
                                   %@\
                                   </h2>\
                                   <p>\
                                   </p>\
                                   ",title]];
    
    
}

- (void)getImageForWebView {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"nav_user_avator"] ofType:@"png"];
    [self.htmlString appendFormat:@"<p style=\"text-align:center;\">\
     历史分析\
     </p>\
     <p>\
     <table style=\"width:100\%%;\" cellpadding=\"1\" cellspacing=\"0\" border=\"0\" bordercolor=\"#000000\">\
    <tbody>\
    <tr>\
    <td style=\"text-align:left;\">\
     昵称:\
     </td>\
     <td>\
     性别:\
     </td>\
     <td>\
     年龄:\
     </td>\
     </tr>\
     <tr>\
     <td>\
     身高\
     </td>\
     <td>\
     体重\
     </td>\
     <td>\
     血型\
     </td>\
     </tr>\
     </tbody>\
     </table>\
     <br />\
     <p style=\"text-align:center;\">\
     检测时间 2018-09-13 11:34:56 - 2018-09-13 12:34:11\
     </p>\
     <p>\
     <table style=\"width:100\%%;\" cellpadding=\"2\" cellspacing=\"0\" border=\"1\" bordercolor=\"#000000\">\
     <tbody>\
     <tr>\
     <td style=\"text-align:center;\">\
     是否发烧\
     </td>\
     <td style=\"text-align:center;\">\
     最低温度\
     </td>\
     <td style=\"text-align:center;\">\
     最高温度\
     </td>\
     </tr>\
     <tr>\
     <td style=\"text-align:center;\">\
     否\
     </td>\
     <td style=\"text-align:center;\">\
     28\
     </td>\
     <td style=\"text-align:center;\">\
     23<br />\
     </td>\
     </tr>\
     </tbody>\
     </table>\
     <br />\
     <img src=\"%@\" border = \"0\" width = \"60\" height = \"60\" alt=\"\"/>\
     </p>\
     </p>",imagePath];
    
}

-(void)addJavaScript {
    [self.webView stringByEvaluatingJavaScriptFromString:@" \
     var data = [];\
     function pushData(tempDate, tempValue) {\
         data.shift();\
         data.push(\
                   {  name:tempDate,\
                   value:[\
                          [tempDate],\
                          tempValue\
                          ]\
                   }\
                   );\
     }\
     function setNewValue(tempDate, tempValue) {\
         return {  name:tempDate,\
         value:[\
                [tempDate],\
                tempValue\
                ]\
         }\
     }\
     var myChart = echarts.init(document.getElementById('main'));\
     function lineChartOption (){\
         return {\
         tooltip: {\
         trigger: 'axis'\
         },\
         grid: {\
         left: '5%',\
         right: '5%',\
         bottom: '5%',\
         containLabel: true\
         },\
         toolbox: {\
         feature: {\
         saveAsImage: {}\
         }\
         },\
         xAxis: {\
         type: 'category',\
         boundaryGap:[0, '100%'],\
         splitNumber:10,\
         },\
         yAxis: {\
         show:true,\
         type: 'value',\
         axisLabel: {\
         formatter: '{value} °C'\
         },\
         boundaryGap: [0, '100%']\
         },\
         dataZoom: [{\
         type: 'inside',\
         start: 0,\
         end:100\
         },{\
         type:'slider',\
         start:\
             0,\
         end:100,\
         dataBackground:{\
         areaStyle:{\
         color:'#3CB371'\
         }\
         },\
         handleIcon: \\'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z\',\
         handleSize: '60%',\
         handleStyle: {\
         color: \'#fff\',\
         shadowBlur: 3,\
         shadowColor: 'rgba(0, 0, 0, 0.6)',\
         shadowOffsetX: 2,\
         shadowOffsetY: 2\
         }\
         }\
                    ],\
         series: [\
                  {\
                  name:'温度',\
                  type:'line',\
                  stack: '总量',\
                  data:data\
                  }\
                  ]\
         };\
     }\
     data.shift();\
     data.push(setNewValue('准备检测1',0));\
     data.push(setNewValue('准备检测2',0));\
     myChart.setOption(lineChartOption());"];
    
}

// 创建表格
-(void)createTableWithSegList:(NSArray<NSString *>*)titles andContentList:(NSArray <NSArray <NSDictionary *> *> *)contentList {
    

}

// 参考的https://blog.csdn.net/u013936810/article/details/20627897
- (NSString *)createFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *saveDirectory = [paths objectAtIndex:0];
    NSString *saveFileName = @"zhengyiTest.pdf";
    NSString *newFilePath = [saveDirectory stringByAppendingPathComponent:saveFileName];
    NSLog(@"newFilePath = %@", newFilePath);
    return newFilePath;
}
// 给Echart赋值
#pragma mark - Event
- (IBAction)createPDFFile:(UIButton *)sender {
    
    
    
//    [self addJavaScript];
    
//    sleep(2);
    
    UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
    render.headerHeight = 50;
    render.footerHeight = 50;
    [render addPrintFormatter:[self.webView viewPrintFormatter] startingAtPageAtIndex:0];
    
    CGRect page;
    page.origin.x = 0;
    page.origin.y = 0;
    page.size.width = 600;
    page.size.height = 612;
    
    CGRect printbale = CGRectInset(page, 0, 0);
    [render setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
    [render setValue:[NSValue valueWithCGRect:printbale] forKey:@"printableRect"];
    
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, CGRectZero, nil);
    for (NSInteger i = 0; i < [render numberOfPages]; i++) {
        UIGraphicsBeginPDFPage();
        CGRect bounds = UIGraphicsGetPDFContextBounds();
        [render drawPageAtIndex:i inRect:bounds];
    }
    // 图片
    UIGraphicsEndPDFContext();
    [pdfData writeToFile:[self createFilePath] atomically:YES];
    // 判断是否已经写入文件
    

}




- (IBAction)sharePDFFile:(UIButton *)sender {
    
}

#pragma mark - Delegate
#pragma mark UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
   
}


#pragma mark - Getter
- (NSMutableString *)htmlString {
    if (!_htmlString) {
        _htmlString = [[NSMutableString alloc] init];
    }
    return _htmlString;
}





@end
