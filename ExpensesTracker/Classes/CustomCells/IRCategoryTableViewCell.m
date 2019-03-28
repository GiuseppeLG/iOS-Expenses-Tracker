

#import "IRCategoryTableViewCell.h"

@implementation IRCategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapOnCalenderButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapCalenderButton)]) {
        [self.delegate didTapCalenderButton];
    }
}
@end
