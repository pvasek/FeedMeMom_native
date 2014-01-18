#import <Foundation/Foundation.h>


@interface FMLengthSelectorController : UITableViewController

@property(nonatomic, copy) void (^done)();
@property (weak, nonatomic) IBOutlet UIPickerView *pickupSelector;
@property (nonatomic) NSInteger  value;

@property(nonatomic, copy) void (^prepare)();
@end