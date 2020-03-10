#import "SBCRootListController.h"

@implementation SBCAppearanceSettings

-(UIColor *)tintColor {
    return [UIColor colorWithRed:0.64 green:0.67 blue:1.00 alpha:1.0];;
}

-(UIColor *)statusBarTintColor {
    return [UIColor whiteColor];
}

-(UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

-(UIColor *)navigationBarTintColor {
    return [UIColor whiteColor];
}

-(UIColor *)tableViewCellSeparatorColor {
    return [UIColor colorWithWhite:0 alpha:0];
}

-(UIColor *)navigationBarBackgroundColor {
    return [UIColor colorWithRed:0.64 green:0.67 blue:1.00 alpha:1.0];;
}

-(BOOL)translucentNavigationBar {
    return NO;
}

@end