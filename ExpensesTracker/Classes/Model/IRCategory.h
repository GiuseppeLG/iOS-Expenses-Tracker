
#import <Foundation/Foundation.h>

@class CategoryGroup;

@interface IRCategory : NSObject

@property (strong, nonatomic) NSString *categoryName;
@property (assign, nonatomic) int colorCode;
@property (assign, nonatomic) BOOL isExpense;
@property (assign, nonatomic) int categoryID;


- (IRCategory *)readFromEntity:(CategoryGroup *)category;

@end
