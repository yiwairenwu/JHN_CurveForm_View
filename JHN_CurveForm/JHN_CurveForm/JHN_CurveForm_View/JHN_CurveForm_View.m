

#import "JHN_CurveForm_View.h"
#import <QuartzCore/QuartzCore.h>

@interface JHN_CurveForm_View ()
{
    NSMutableArray *_Array;
}
@end
@implementation JHN_CurveForm_View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    NSInteger index;
    if (_delegate&&[_delegate respondsToSelector:@selector(numberOfLinesInCurveFormView:)]) {
        index=  (NSInteger)[_delegate performSelector:@selector(numberOfLinesInCurveFormView:) withObject:self];
    }else{
        index = 1;
    }
    for (int num = 0; num<index; num++) {
        NSArray *_LineArray = [_delegate CurveFormView:self ArrayForInt:num];
    
    
      
      

        double YScope = [_delegate YScopeForCurveFormView:self];
        double YStart = [_delegate YStartForCurveFormView:self];
        double coefficient = (self.frame.size.height)/YScope;
   
        double downToXline =self.frame.size.height - self.frame.size.height*(YStart/YScope);
        CGContextRef context = UIGraphicsGetCurrentContext();

        double distanceNextYline = [_delegate XlongForCurveFormView:self];
        double bizieLineAligm = distanceNextYline/2;
        
        double nextX = 0;//初始点的x值
        double corectPointer1 = downToXline - [[_LineArray objectAtIndex:0] doubleValue]*coefficient;
        CGMutablePathRef spadePath = CGPathCreateMutable();
        CGPathMoveToPoint(spadePath, NULL, nextX, downToXline - [[_LineArray objectAtIndex:0] doubleValue]*coefficient);
        for (int i = 1; i < [_LineArray count]; i++) {
            CGPathAddCurveToPoint(spadePath, NULL, nextX+bizieLineAligm, corectPointer1, nextX+distanceNextYline-bizieLineAligm, downToXline - [[_LineArray objectAtIndex:i] doubleValue]*coefficient, nextX+distanceNextYline, downToXline - [[_LineArray objectAtIndex:i] doubleValue]*coefficient);
            nextX +=distanceNextYline;
            corectPointer1 = downToXline - [[_LineArray objectAtIndex:i] doubleValue]*coefficient;
        }
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


@end
