//
//  JHNViewController.m
//  JHN_CurveForm
//
//  Created by cn.wz.jingzhi on 14-7-30.
//  Copyright (c) 2014年 cn.wenzhou. All rights reserved.
//

#import "JHNViewController.h"
#import "jhnBtn.h"
@interface JHNViewController ()
{
    NSArray *_fistArray;
    NSArray *_twoArray;
    JHN_CurveForm_View *_jhn;
}
@end

@implementation JHNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _fistArray = @[[NSNumber numberWithInt:0],[NSNumber numberWithInt:32],[NSNumber numberWithInt:22],[NSNumber numberWithInt:-12],[NSNumber numberWithInt:32]];
    _twoArray = @[[NSNumber numberWithInt:20],[NSNumber numberWithInt:42],[NSNumber numberWithInt:25],[NSNumber numberWithInt:10],[NSNumber numberWithInt:32]];
    _jhn = [[JHN_CurveForm_View alloc]init];
    _jhn.delegate = self;
    [_jhn setFrame:CGRectMake(10, 50, 300, 200)];
    
    
    [self.view addSubview:_jhn];
	// Do any additional setup after loading the view, typically from a nib.
}

-(UIButton *)CurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View ButtonForLineId:(int)indexLine WithButtonId:(int)indexBtn
{
     jhnBtn *btn   = [jhnBtn buttonWithType:UIButtonTypeCustom];
    if (indexLine == 0) {
       
        btn.indexLine = 0;
        btn.indexBtn = indexBtn;
      
    }else{
        btn.indexLine = 1;
        btn.indexBtn = indexBtn;
       
        
    }
    [btn setBackgroundImage:[UIImage imageNamed:@"sb.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
   
}
-(void)btnChick:(UIButton *)sender
{
    jhnBtn *btn = (jhnBtn *)sender;
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"代表月亮消灭你" message:[NSString stringWithFormat:@"我是%d号线的%d号按钮我得位置在x:%f,y:%f",btn.indexLine,btn.indexBtn,btn.frame.origin.x,btn.frame.origin.y ] delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [aler show];
}
//返回y轴数据起始点例如车辆第-数组的销量是20万则返回200000;若是温度范围在-20到+20且第一数组为-10度则返回10,0度则返回20,10度则返回30;
-(double)YStartForCurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View
{
    return 50;
}
//返回y轴数据范围例如车辆销量是以0到50万则返回500000;若是温度范围在-20到+20则返回40;
-(double)YScopeForCurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View
{
    return 100;
}
//返回x轴每组数据间距;
-(double)XlongForCurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View
{
    return 300/(_fistArray.count-1);
}
//返回数组
-(NSArray *)CurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View ArrayForInt:(int)index{
    if (index == 0) {
        
        return _fistArray;
    }else{
        
        return _twoArray;
    }
    
}
//返回曲线颜色
-(UIColor *)CurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View ColorForInt:(int)index
{
    if (index==0) {
        return [UIColor redColor];
    }else{
        return [UIColor blueColor];
    }
    
}
-(NSInteger )numberOfLinesInCurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View
{
    return 2;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
