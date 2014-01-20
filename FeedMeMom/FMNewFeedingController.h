#import <Foundation/Foundation.h>


@interface FMNewFeedingController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblRightRunning;
@property (weak, nonatomic) IBOutlet UILabel *lblRight;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftRunning;
@property (weak, nonatomic) IBOutlet UILabel *lblLeft;

@property (nonatomic) BOOL isLeft;
@end