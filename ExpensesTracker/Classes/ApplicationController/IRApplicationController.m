
#import "IRApplicationController.h"
#import "IRNotification.h"

static IRApplicationController *sharedInstance = nil;

@implementation IRApplicationController

+ (IRApplicationController *)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[self alloc]init];
    }
    return sharedInstance;
}

- (void)showAlertForDailyReminder
{
    
    }


@end
