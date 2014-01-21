#import <Foundation/Foundation.h>


@interface FMNewFeedingController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblRightRunning;
@property (weak, nonatomic) IBOutlet UILabel *lblRight;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftRunning;
@property (weak, nonatomic) IBOutlet UILabel *lblLeft;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftTime;
@property (weak, nonatomic) IBOutlet UILabel *lblRightTime;
@property (weak, nonatomic) IBOutlet UIButton *btnSwitchSides;

@property (nonatomic) BOOL isLeft;
@end