#import <Foundation/Foundation.h>


@interface FMDateSelectorController : UITableViewController

@property (nonatomic,strong) NSDate* date;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateSelector;

@property(nonatomic, copy) void (^done)(FMDateSelectorController *controller);

@end