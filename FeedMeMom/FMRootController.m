#import "FMRootController.h"
#import "UIViewController+JASidePanel.h"

@implementation FMRootController {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"sideMenuController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"rootController"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sidePanelController showCenterPanelAnimated:YES];
}

@end