

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SBBarSegment : NSObject {
    float value;
    UIColor *color;
}

@property (nonatomic, assign) float value;
@property (nonatomic, retain) UIColor *color;
+ (id)barComponentWithValue:(float)_value;
@end

@interface SBBarChart : UIView {
    NSMutableArray *segments;
}
@property (nonatomic, retain) NSMutableArray *segments;
@property (nonatomic, assign) BOOL horizontal;
@end
