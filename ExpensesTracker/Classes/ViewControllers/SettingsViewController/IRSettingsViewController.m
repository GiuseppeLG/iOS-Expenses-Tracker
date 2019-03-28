

#import "IRSettingsViewController.h"
#import "SWRevealViewController.h"
#import "IRCurrencyViewController.h"
#import "IRThemeViewController.h"
#import "IRCommon.h"
#import "IRCategoryViewController.h"
#import "IRCoreDataController.h"
#import "IRExpense.h"

@interface IRSettingsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) MFMailComposeViewController *mailComposeViewController;
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@end

@implementation IRSettingsViewController

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [IRCommon updateAppUsagePointsWithValue:1];
    self.navigationItem.title = [IRCommon localizeText:@"Settings"];
    [_menuButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.settingsTableView reloadData];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - UITableView Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
            
        case 1:
            return 2;
            break;

        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
    }
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [IRCommon getDefaultFontForSize:15.0f isBold:NO];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                
            case 0:
                cell.textLabel.text = [IRCommon localizeText:@"Currency"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            case 1:
                cell.textLabel.text = [IRCommon localizeText:@"Theme"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                break;
        }

    } else if (indexPath.section == 1) {
        switch (indexPath.row) {

            //case 0:
              //  cell.textLabel.text = [IRCommon localizeText:@"Export Data"];
               // break;
            case 0:
                cell.textLabel.text = [IRCommon localizeText:@"Reset All Data"];
                break;
//            case 2:
//                cell.textLabel.text =[IRCommon localizeText:@"Restore Data Data"];
//                break;
    
            default:
                break;
        }

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - UITableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        IRCurrencyViewController *currencyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrencyViewController"];
        IRThemeViewController *themeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThemeViewController"];
        switch (indexPath.row) {

            case 0:
                [self.navigationController pushViewController:currencyViewController animated:YES];
                break;
            case 1:
            
                [self.navigationController pushViewController:themeViewController animated:YES];

                break;
                
            default:
                break;
        }

    } else if (indexPath.section == 1) {
        UIAlertView *resetDataAlert = [[UIAlertView alloc]initWithTitle:@"Caution!" message:[IRCommon localizeText:@"This will delete all data from your app. Do you wish to continue?"] delegate:self cancelButtonTitle:[IRCommon localizeText:[IRCommon localizeText:@"Cancel"]] otherButtonTitles:[IRCommon localizeText:@"OK"], nil];
        
        switch (indexPath.row) {
            //case 0:
              //  [IRCommon updateAppUsagePointsWithValue:1];
                //[self createCSVFile];
                //break;
            case 0:
                [IRCommon updateAppUsagePointsWithValue:1];
                resetDataAlert.tag = 6766;
                [resetDataAlert show];
                break;
                
            default:
                break;
        }
        
    }
}


#pragma mark - UIAlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 6766) {
        if (buttonIndex == 1) {
            if ([[IRCoreDataController sharedInstance]deleteAllExpenseData] &&
                [[IRCoreDataController sharedInstance]deleteAllCategories]) {
                [IRCommon showAlertWithTitle:APPLICATION_NAME message:[IRCommon localizeText:@"Your data has been reset."] dismissButtonText:[IRCommon localizeText:@"OK"]];
            } else {
                [IRCommon showAlertWithTitle:APPLICATION_NAME message:[IRCommon localizeText:@"An error has occured!. Please try again."] dismissButtonText:[IRCommon localizeText:@"OK"]];
            }
        }
    }
}

#pragma mark - Private Methods

- (void)createCSVFile
{
    NSArray *expenseArray = [[IRCoreDataController sharedInstance]fetchExpenseData:YES];
    NSArray *incomeArray = [[IRCoreDataController sharedInstance]fetchExpenseData:YES];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        [[NSFileManager defaultManager]removeItemAtPath:[self dataFilePath] error:nil];
    }
    [[NSFileManager defaultManager] createFileAtPath: [self dataFilePath] contents:nil attributes:nil];
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    [writeString appendString:@"\nExpense\n"];
    [writeString appendString:@"Date, Category, Amount, Note \n"];
    for (IRExpense *expense in expenseArray) {
        [writeString appendString:[NSString stringWithFormat:@"%@, %@, %@, %@\n",[IRCommon getDate:expense.date inFormat:@"dd-MM-yy hh:mm aa"],expense.category,[NSString stringWithFormat:@"%@ %f",[IRCommon getCurrencySymbolFromCode:[[NSUserDefaults standardUserDefaults]objectForKey:@"currency"]],expense.amount],expense.note]];
    }
    [writeString appendString:@"\nIncome\n"];
    [writeString appendString:@"Date, Category, Amount, Note \n"];
    for (IRExpense *expense in incomeArray) {
        [writeString appendString:[NSString stringWithFormat:@"%@, %@, %@, %@\n",[IRCommon getDate:expense.date inFormat:@"dd-MM-yy hh:mm aa"],expense.category,[NSString stringWithFormat:@"%@ %f",[IRCommon getCurrencySymbolFromCode:[[NSUserDefaults standardUserDefaults]objectForKey:@"currency"]],expense.amount],expense.note]];
    }
    NSFileHandle *handle;
    handle = [NSFileHandle fileHandleForWritingAtPath: [self dataFilePath] ];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"ExpenseMobile.csv"];
}

- (void)exportSpreadsheet
{
    self.mailComposeViewController = [[MFMailComposeViewController alloc]init];
    self.mailComposeViewController.mailComposeDelegate = self;
    [self.mailComposeViewController setSubject:@"Expense Mobile Data Backup"];
    NSData *data = [NSData dataWithContentsOfFile:[self dataFilePath]];
    [self.mailComposeViewController addAttachmentData:data mimeType:@"text/csv" fileName:@"Expense Mobile"];
    if (self.mailComposeViewController) {
        [self.navigationController presentViewController:self.mailComposeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            [IRCommon showAlertWithTitle:APPLICATION_NAME message:[IRCommon localizeText:@"Your mail has been sent."] dismissButtonText:[IRCommon localizeText:OK_TEXT]];
            break;
        case MFMailComposeResultFailed:
            [IRCommon showAlertWithTitle:APPLICATION_NAME message:[IRCommon localizeText:@"Sorry, Your mail cannot be send. Please try again."] dismissButtonText:[IRCommon localizeText:OK_TEXT]];
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
