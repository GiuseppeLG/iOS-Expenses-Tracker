
#import <Foundation/Foundation.h>

@interface IRGamification : NSObject

+ (IRGamification *)sharedInstance;
- (NSArray *)getArrayOfOverViewText;
- (NSArray *)getArrayOfOverViewTextForExpenseOnly;

@end
