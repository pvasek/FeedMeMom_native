#import <Foundation/Foundation.h>
#import "JASidePanelController.h"

@interface FMLastFeedingController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTotalLength;
@property (weak, nonatomic) IBOutlet UILabel *lblAgo;
@property (weak, nonatomic) IBOutlet UILabel *lblRecommendedRight;
@property (weak, nonatomic) IBOutlet UILabel *lblRecommendedLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnStartRight;
@property (weak, nonatomic) IBOutlet UIButton *btnStartLeft;
@property (weak, nonatomic) IBOutlet UILabel *lblSide;
@property (weak, nonatomic) IBOutlet UILabel *lblAgoTime;

@end