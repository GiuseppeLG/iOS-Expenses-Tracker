

#import <UIKit/UIKit.h>
#import "TSQCalendarCell.h"
#import "TSQCalendarMonthHeaderCell.h"
#import "TSQCalendarRowCell.h"
#import "TSQCalendarView.h"




@protocol IRCalenderViewDelegate <NSObject>

- (void)didSelectDate:(NSDate *)date;

@end

@interface IRCalenderViewController : UIViewController<TSQCalendarViewDelegate>

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) id<IRCalenderViewDelegate> delegate;

@end
