
/*
 This is heavily inspired by the following post on Stack Overflow
 http://stackoverflow.com/questions/13205160/how-do-i-retrieve-keystrokes-from-a-custom-keyboard-on-an-ios-app
 */

#import <UIKit/UIKit.h>

@protocol NumberPadDelegate <NSObject>

- (void)didTapCancelButton:(NSString *)number;
- (void)didTapOkButton:(NSString *)number;

@end

@interface FPNumberPadView : UIView

@property (nonatomic, assign) UITextField *textField;
@property (nonatomic, assign) id<NumberPadDelegate> delegate;

@end
