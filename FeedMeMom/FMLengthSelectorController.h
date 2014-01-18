#import <Foundation/Foundation.h>


@interface FMLengthSelectorController : UITableViewController

@property(nonatomic, copy) void (^done)(FMLengthSelectorController *controller);
@property (weak, nonatomic) IBOutlet UIPickerView *pickupSelector;
@property (nonatomic) NSInteger  value;

@property(nonatomic, copy) void (^prepare)(FMLengthSelectorController *controller);
@end