#import "FMColors.h"


@implementation FMColors {

}

- (UIColor *)activeButtonColor {
    return _baseColor;
}

- (UIColor *)inactiveButtonColor {
    return _inactiveColor;
}


+ (FMColors *)createBasicSchema {

    FMColors *result = [[FMColors alloc] init];
    result.baseColor = [[UIColor alloc] initWithRed:176/256.0 green:33/256.0 blue:87/256.0 alpha:1];
    result.inactiveColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3];
    return result;
}

@end