
#import <UIKit/UIKit.h>

@protocol PointTableDelegate <NSObject>

- (void)switchTapped:(id)sender;

@end

@interface IRPointsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *shareSwitch;
@property (assign, nonatomic) id<PointTableDelegate> delegate;

@end
