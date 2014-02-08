#import "FMColors.h"
#import "FMAppDelegate.h"

FMAction _callback;

@implementation FMColors {

}

- (UIColor *)activeButtonColor {
    return _baseColor;
}

- (UIColor *)inactiveButtonColor {
    return _inactiveColor;
}


- (UIColor *)navigationBarColor {
    return _baseColor;
}

+ (void)notifyMeAboutChange:(FMAction)callback {
    _callback = callback;
}

+ (void)switchColorScheme {
    if (Colors.type == FMColorTypeLight) {
        Colors = DarkColors;
    } else {
        Colors = LightColors;
    }
    if (_callback != nil) {
        _callback();
    }
}

+ (FMColors *)createLightSchema {

    FMColors *result = [[FMColors alloc] init];
    result.type = FMColorTypeLight;
    result.background = [UIColor whiteColor];
    result.baseColor = [[UIColor alloc] initWithRed:176/256.0 green:33/256.0 blue:87/256.0 alpha:1];
    result.inactiveColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3];
    result.panelsColor = [[UIColor alloc] initWithRed:234/256.0 green:234/256.0 blue:234/256.0 alpha:1];
    return result;
}

+ (FMColors *)createDarkSchema {

    FMColors *result = [[FMColors alloc] init];
    result.type = FMColorTypeDark;
    result.baseColor = [self hexColor:0x333333];
    result.background = [self hexColor:0x444444];
    result.inactiveColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3];
    result.panelsColor = [self hexColor:0x555555];
    return result;
}

+ (UIColor*)hexColor:(int)hexaRgbColor {
    int b = hexaRgbColor & 0xff;
    hexaRgbColor = hexaRgbColor >> 8;
    int g = hexaRgbColor & 0xff;
    hexaRgbColor = hexaRgbColor >> 8;
    int r = hexaRgbColor & 0xff;
    return [[UIColor alloc] initWithRed:r /256.0 green:g /256.0 blue:b /256.0 alpha:1];
}

@end