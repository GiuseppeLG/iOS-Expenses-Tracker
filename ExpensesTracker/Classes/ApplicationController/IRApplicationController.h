
#import <Foundation/Foundation.h>

@interface IRApplicationController : NSObject

+ (IRApplicationController *)sharedInstance;
- (void)showAlertForDailyReminder;

@end
