

#import "JHN_CurveForm_View.h"
#import <QuartzCore/QuartzCore.h>

@interface JHN_CurveForm_View ()
{
    
    NSMutableDictionary *_BtnDict;
}
@end
@implementation JHN_CurveForm_View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.LineType = LineFormType;
        _BtnDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    double YScope = [_delegate YScopeForCurveFormView:self];
    double YStart = [_delegate YStartForCurveFormView:self];
    double distanceNextYline = [_delegate XlongForCurveFormView:self];
    NSInteger index;
    if (_delegate&&[_delegate respondsToSelector:@selector(numberOfLinesInCurveFormView:)]) {
        index = [_delegate numberOfLinesInCurveFormView:self];
            }else{
        index = 1;
    }
    for (int num = 0; num<index; num++) {
        NSArray *_LineArray = [_delegate CurveFormView:self ArrayForInt:num];
    
        NSMutableArray *_btnArr = [[NSMutableArray alloc]init];
        NSString *key = [NSString stringWithFormat:@"%d",num];
      
      

     
        double coefficient = (self.frame.size.height)/YScope;
   
        double downToXline =self.frame.size.height - self.frame.size.height*(YStart/YScope);
        CGContextRef context = UIGraphicsGetCurrentContext();

        
        double bizieLineAligm = distanceNextYline/2;
        
        double nextX = 0;//初始点的x值
        double corectPointer1 = downToXline - [[_LineArray objectAtIndex:0] doubleValue]*coefficient;
        CGMutablePathRef spadePath = CGPathCreateMutable();
        CGPathMoveToPoint(spadePath, NULL, nextX, downToXline - [[_LineArray objectAtIndex:0] doubleValue]*coefficient);
        if (_delegate&&[_delegate respondsToSelector:@selector(CurveFormView:ButtonForLineId:WithButtonId:)]) {
            UIButton *btn0 = [_delegate CurveFormView:self ButtonForLineId:num WithButtonId:0];
            if (btn0) {
                btn0.frame = CGRectMake(nextX-7, downToXline - [[_LineArray objectAtIndex:0] doubleValue]*coefficient-7, 15, 15);
                [self addSubview:btn0];
                [_btnArr addObject:btn0];
            }
            
        }
        
       
        
        
        
        
        for (int i = 1; i < [_LineArray count]; i++) {
            
            if (_delegate&&[_delegate respondsToSelector:@selector(CurveFormView:ButtonForLineId:WithButtonId:)]) {
                UIButton *btn = [_delegate CurveFormView:self ButtonForLineId:num WithButtonId:i];
                if (btn) {
                    btn.frame = CGRectMake(nextX+distanceNextYline-7,downToXline - [[_LineArray objectAtIndex:i] doubleValue]*coefficient-7, 15, 15);
                    [self addSubview:btn];
                    [_btnArr addObject:btn];
                }
                
            }
          
            switch (_LineType) {
                case LineFormType:
                {
                    CGPathAddLineToPoint(spadePath,NULL,nextX+distanceNextYline,downToXline - [[_LineArray objectAtIndex:i] doubleValue]*coefficient);
                
                }
                    break;
                case CurveFormType:
                {
                     CGPathAddCurveToPoint(spadePath, NULL, nextX+bizieLineAligm, corectPointer1, nextX+distanceNextYline-bizieLineAligm, downToXline - [[_LineArray objectAtIndex:i] doubleValue]*coefficient, nextX+distanceNextYline, downToXline - [[_LineArray objectAtIndex:i] doubleValue]*coefficient);
                    
                }
                    break;
                default:
                    break;
            }
            
            
            
            
           
            nextX +=distanceNextYline;
            corectPointer1 = downToXline - [[_LineArray objectAtIndex:i] doubleValue]*coefficient;
        }
        [_BtnDict setValue:_btnArr forKey:key];
        UIColor *color;
        if (_delegate&&[_delegate respondsToSelector:@selector(CurveFormView:ColorForInt:)]) {

            color = [_delegate CurveFormView:self ColorForInt:num];
        }else{
            color = [UIColor blackColor];
        }
        
        [color set];
        CGContextSetLineWidth(context, 2);
        
        CGContextAddPath(context, spadePath);
        
        CGContextStrokePath(context);
       
    }
    
    
    
    
}
-(UIButton *)buttonForLineIndex:(int)LineIndex BtnIndex:(int)BtnIndex
{
    NSArray *arr = [_BtnDict objectForKey:[NSString stringWithFormat:@"%d",LineIndex]];
    UIButton *btn = (UIButton *)[arr objectAtIndex:BtnIndex];
    return btn;
}

@end
