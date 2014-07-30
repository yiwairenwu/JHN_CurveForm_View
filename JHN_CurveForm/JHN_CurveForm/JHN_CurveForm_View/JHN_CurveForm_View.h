

#import <UIKit/UIKit.h>
@class JHN_CurveForm_View;
typedef enum {
    LineFormType = 0,
    CurveFormType
} LineType;
@protocol JHNCurveFormDelegate<NSObject>
//必需实现的方法
//返回数组数据
-(NSArray *)CurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View ArrayForInt:(int)index;
//返回y轴数据起始点例如车辆第-数组的销量是20万则返回200000;若是温度范围在-20到+20且第一数组为-10度则返回10,0度则返回20,10度则返回30;
-(double)YStartForCurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View;
//返回y轴数据范围例如车辆销量是以0到50万则返回500000;若是温度范围在-20到+20则返回40;
-(double)YScopeForCurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View;
//返回x轴每组数据间距;
-(double)XlongForCurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View;
@optional
//这个用了就有按钮
-(UIButton *)CurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View ButtonForLineId:(int)indexLine WithButtonId:(int)indexBtn;
//非必写回调
//返回同一页面内需要的曲线数量用于多曲线比较
//默认为1条
-(NSInteger )numberOfLinesInCurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View;
//返回线的颜色
//默认为黑色
-(UIColor *)CurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View ColorForInt:(int)index;
//-(NSString *)CurveFormView:(JHN_CurveForm_View *)JHN_CurveForm_View YTitleForInt:(int)index;
@end

@interface JHN_CurveForm_View : UIView
@property(nonatomic,assign)id<JHNCurveFormDelegate> delegate;
@property(assign,nonatomic)LineType LineType;//你要直的还是弯的

-(UIButton *)buttonForLineIndex:(int)LineIndex BtnIndex:(int)BtnIndex;
@end
