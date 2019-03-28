

#import "IRNotification.h"

@implementation IRNotification

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.localNotification = [[UILocalNotification alloc]init];
    }
    return self;
}

- (void)showNotification:(IRNotification *)notifcationParams
{
    self.localNotification.alertBody = notifcationParams.notificationAlertBody;
    if (notifcationParams.notificationFireDate) {
        self.localNotification.fireDate = notifcationParams.notificationFireDate;
    }
    if (notifcationParams.notificationRepeatInterval) {
        self.localNotification.repeatInterval = notifcationParams.notificationRepeatInterval;
    }
    [[UIApplication sharedApplication]scheduleLocalNotification:self.localNotification];
}

- (void)cancelNotification:(IRNotification *)notifcationParams
{
    [[UIApplication sharedApplication]cancelLocalNotification:notifcationParams.localNotification];
}

- (void)cancelAllNotifications
{
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
}

@end
