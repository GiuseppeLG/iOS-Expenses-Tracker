


#import "SBStackedBarChart.h"

@implementation SBBarSegment
@synthesize value, color;

- (id)initWithValue:(float)_value {
    self = [super init];
    if (self) {
        self.value = _value;
    }
    return self;
}

+ (id)barComponentWithValue:(float)_value {
    return [[super alloc] initWithValue:_value];
}

@end

@implementation SBBarChart
@synthesize segments;
@synthesize horizontal;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setContentMode:UIViewContentModeRedraw];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    float total = 0;
    
    for (SBBarSegment *segment in segments) {
        total += segment.value;
    }
    
    float offset = 0;
    
    for (SBBarSegment *segment in segments) {
        
        float dimension = ((horizontal ? self.frame.size.width : self.frame.size.height) * segment.value) / total;
        
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(horizontal ? offset : 0,
                                                                                  horizontal ? 0 : offset,
                                                                                  horizontal ? dimension : self.frame.size.width,
                                                                                  horizontal ? self.frame.size.height : dimension)];
        [segment.color setFill];
        [rectanglePath fill];
        
        offset += horizontal ? (horizontal ? dimension : self.frame.size.width) : (horizontal ? self.frame.size.height : dimension);
    }
}

@end
