//
//  ZYZoomLineChartEchartsView.m
//  DrawEChartDemo
//
//  Created by 郑奕 on 2018/8/17.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYZoomLineChartEchartsView.h"
#import <iOS-Echarts/iOS-Echarts.h>
#import "RMMapper.h"


// 虽然轻松了很多，但是很多限制，功能太多无法完全体现，也不能满足千变万化的需求，所以，还是乖乖用js吧～

@interface ZYZoomLineChartEchartsView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PYZoomEchartsView *zEchartView;

@end

@implementation ZYZoomLineChartEchartsView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createEchart];
    }
    return self;
}

- (void)createEchart {
    // 初始化-图表选项
    PYOption *option = [[PYOption alloc] init];
    option.backgroundColor = [PYColor colorWithHexString:@"#FF4683"];
    option.calculable = NO;
    option.color = @[@"#20BCFC", @"#ff6347"];
    
    // 提示框
    PYTooltip *toolTip = [[PYTooltip alloc] init];
    //  触发类型默认数据触发
    toolTip.trigger = @"axis";
    // 竖线宽度
    toolTip.axisPointer.lineStyle.width = @1;
    //提示框 文字样式
    toolTip.textStyle = [[PYTextStyle alloc] init];
    toolTip.textStyle.fontSize = @12;
    option.tooltip = toolTip;
    //图例
    PYLegend *legend = [[PYLegend alloc] init];
    //设置数据
    legend.data = @[@"挂牌价",@"成交价"];
    option.legend = legend; //添加到图表选择中
    
    // 直角坐标系内绘制网格
    PYGrid *grid = [[PYGrid alloc] init];
    // 左上角位置
    grid.x = @(45);
    grid.y = @(20);
    
    // 右下角位置
    grid.x2 = @(20);
    grid.y2 = @(30);
    grid.borderWidth = @(0);
    
    //添加到图标选择中
    option.grid = grid;
    
    //Y 轴设置
    PYAxis *xAxis = [[PYAxis alloc] init];
    //横轴默认为类目型
    xAxis.type = @"category";
    // 起始和结束两端空白
    xAxis.splitLine.show = YES;
    // 坐标轴线
    xAxis.axisLine.show = NO;
    // X 轴坐标数据
    [xAxis.data addObjectsFromArray:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",@"13月",@"14月",@"15月"]];
    
    //坐标轴小标记
    xAxis.axisTick = [[PYAxisTick alloc] init];
    xAxis.axisTick.show = YES;
    
    //添加到图标选择中
    option.xAxis = [[NSMutableArray alloc] initWithObjects:xAxis, nil];
    
    // Y轴
    PYAxis *yAxis = [[PYAxis alloc] init];
    yAxis.axisLine.show =NO;
    // 纵轴默认为数值型
    yAxis.type = @"value";
    // 分割段数，默认为5
    yAxis.splitNumber = @20;

    // 添加到图标选择中 (y 轴更多设置，自行查看官方文档)
    option.yAxis = [[NSMutableArray alloc] initWithObjects:yAxis, nil];
    
    // 定义坐标点数组
    NSMutableArray *seriesArray = [NSMutableArray array];
    
    // 折线设置
    PYCartesianSeries *series1 = [[PYCartesianSeries alloc] init];
    series1.name = @"折线1";
    series1.smooth = YES;
    PYItemStyleProp *prop = [[PYItemStyleProp alloc]init];
    prop.borderColor = [PYColor colorWithHexString:@"#FFBE14"];
    PYItemStyle *itemStyle = [[PYItemStyle alloc] init];
    itemStyle.normal =prop;
    series1.itemStyle =itemStyle;
    series1.type = PYSeriesTypeLine;
    series1.symbolSize = @(1.5);
    series1.itemStyle = [[PYItemStyle alloc] init];
    series1.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series1.itemStyle.normal.lineStyle = [[PYLineStyle alloc] init];
    series1.itemStyle.normal.lineStyle.width = @(1.5);
    series1.data = @[@"234",@"2344",@"2314",@"534",@"734",@"1234",@"2349",@"2324",@"324",@"24",@"1324",@"6324"];
    [seriesArray addObject:series1];
    
    [option setSeries:[seriesArray copy]
     ];
    
    PYDataZoom *dataZoom = [[PYDataZoom alloc] init];
    dataZoom.show = YES;
    dataZoom.orient = PYOrientHorizontal;
    dataZoom.handleSize = @(10);
    dataZoom.start = @(0);
    dataZoom.end = @(10);
    dataZoom.showDetail = YES;
    dataZoom.zoomLock = YES;
    dataZoom.realtime = YES;
    
//    dataZoom.yAxisIndex = @(0);
    option.dataZoom = dataZoom;
   
    //初始化图表
    self.zEchartView = [[PYZoomEchartsView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//    [self.scrollView addSubview:self.zEchartView];
    [self.zEchartView setOption:option];

    [self addSubview:self.zEchartView];
    [self.zEchartView loadEcharts];
}


#pragma mark - Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width*2, self.bounds.size.height)];
        [self addSubview:_scrollView];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*2, CGRectGetHeight(self.frame));
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}


@end
