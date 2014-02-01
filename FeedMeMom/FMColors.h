#import <Foundation/Foundation.h>


@interface FMColors : NSObject

@property (nonatomic,strong) UIColor *baseColor;
@property(nonatomic, strong) UIColor *inactiveColor;

@property (nonatomic, readonly) UIColor *activeButtonColor;
@property (nonatomic, readonly) UIColor *inactiveButtonColor;


+(FMColors*) createBasicSchema;
@end