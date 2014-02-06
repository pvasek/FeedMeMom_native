#import <Foundation/Foundation.h>


typedef void(^FMAction)();

typedef enum {
    FMColorTypeLight,
    FMColorTypeDark
} FMColorType;

@interface FMColors : NSObject

@property (nonatomic) FMColorType type;
@property (nonatomic,strong) UIColor *background;
@property (nonatomic,strong) UIColor *baseColor;
@property(nonatomic, strong) UIColor *inactiveColor;

@property (nonatomic, readonly) UIColor *activeButtonColor;
@property (nonatomic, readonly) UIColor *inactiveButtonColor;
@property (nonatomic, readonly) UIColor *navigationBarColor;


+ (void)notifyMeAboutChange:(FMAction)callback;

+ (void)switchColorScheme;

+(FMColors*)createLightSchema;

+ (FMColors *)createDarkSchema;
@end