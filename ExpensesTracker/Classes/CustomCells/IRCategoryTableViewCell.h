

#import <UIKit/UIKit.h>

@protocol CategoryCellDelegate <NSObject>

- (void)didTapCalenderButton;

@end

@interface IRCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UITextField *additionalInfoTextField;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UIButton *calenderButton;
@property (assign, nonatomic) id<CategoryCellDelegate> delegate;

@end
