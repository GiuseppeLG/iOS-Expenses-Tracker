
#import "IRAppDelegate.h"
#import "IRApplicationController.h"
#import "IRCommon.h"
#import "IRMenuTableViewController.h"
#import "SWRevealViewController.h"
#import "IRHistoryViewController.h"
#import "IRMainViewController.h"
#import "IRAddExpenseViewController.h"

@implementation IRAppDelegate
{
    UIViewController *securityNavController;

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
#if TARGET_IPHONE_SIMULATOR
    // where are you?
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
#endif
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"currency"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"EUR" forKey:@"currency"];
    }
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"color"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"color"];
    }
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"applyThemeForIcons"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:0] forKey:@"applyThemeForIcons"];
    }
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"grouping"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:1] forKey:@"grouping"];
    }
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"trackMode"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInt:1] forKey:@"trackMode"];
    }
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:19];
    
    [[IRApplicationController sharedInstance]showAlertForDailyReminder];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [IRCommon updateAppUsagePointsWithValue:5];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if ([shortcutItem.localizedTitle isEqualToString:@"History"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        IRHistoryViewController *historyViewController = (IRHistoryViewController*)[storyboard instantiateViewControllerWithIdentifier:@"HistoryViewController"];
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
        IRMenuTableViewController *rearViewController = (IRMenuTableViewController*)[storyboard instantiateViewControllerWithIdentifier: @"Menu"];
        
        SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]  init];
        
        mainRevealController.rearViewController = rearViewController;
        mainRevealController.frontViewController= frontNavigationController;
        
        self.window.rootViewController = mainRevealController;
    }
    else if ([shortcutItem.localizedTitle isEqualToString:@"Overview"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        IRMainViewController *mainViewController = (IRMainViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        IRMenuTableViewController *rearViewController = (IRMenuTableViewController*)[storyboard instantiateViewControllerWithIdentifier: @"Menu"];
        
        SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]  init];
        
        mainRevealController.rearViewController = rearViewController;
        mainRevealController.frontViewController= frontNavigationController;
        
        self.window.rootViewController = mainRevealController;
    }
    else if ([shortcutItem.localizedTitle isEqualToString:@"Add Expense"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        IRMainViewController *mainViewController = (IRMainViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        IRMenuTableViewController *rearViewController = (IRMenuTableViewController*)[storyboard instantiateViewControllerWithIdentifier: @"Menu"];
        
        SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]  init];
        
        mainRevealController.rearViewController = rearViewController;
        mainRevealController.frontViewController= frontNavigationController;
        
        self.window.rootViewController = mainRevealController;
        
        IRAddExpenseViewController *addExpenseViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddExpenseViewController"];
        addExpenseViewController.type = EMAdd;
        [frontNavigationController pushViewController:addExpenseViewController animated:YES];
    }
}



@end
