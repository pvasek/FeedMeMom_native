#import "FMLengthSelectorController.h"
#import "FMLengthDataSource.h"
#import "FMAppDelegate.h"
#import "FMColors.h"


@implementation FMLengthSelectorController {
    FMLengthDataSource* _dataSource;
}


@synthesize done = _done;

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[FMLengthDataSource alloc] init];
    _pickupSelector.dataSource = _dataSource;
    _pickupSelector.delegate = _dataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_prepare != nil) {
        _prepare(self);
    }

    self.view.backgroundColor = Colors.background;
}

- (NSInteger)value {
    return [_pickupSelector selectedRowInComponent:0];
}

- (void)setValue:(NSInteger)value {
    [_pickupSelector reloadAllComponents];
    [_pickupSelector selectRow:value inComponent:0 animated:false];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_done != nil) {
        _done(self);
    }

}


@end