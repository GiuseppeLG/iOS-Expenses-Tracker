
#import "IRPointsTableViewCell.h"

@implementation IRPointsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)shareScoreSwitchChanged:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchTapped:)]) {
        [self.delegate switchTapped:sender];
    }
}
@end
