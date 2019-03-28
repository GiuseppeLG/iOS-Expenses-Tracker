

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface IRExpenseListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSString *categoryName;
@property (assign, nonatomic) float categoryExpense;
@property (assign, nonatomic) BOOL isExpense;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
