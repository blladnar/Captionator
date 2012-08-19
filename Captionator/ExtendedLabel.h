#import <UIKit/UIKit.h>

@interface ExtendedLabel : UILabel
{
   NSArray *gradientColors;
   UIColor *strokeColor;
   
   CGFloat shadowBlur;
   CGSize shadowOffset;
   UIColor * shadowColor;
   BOOL isGradientValid;
}

@property (retain) NSArray *gradientColors;
@property (retain) UIColor *strokeColor;

- (void)setShadowWithColor:(UIColor *)color Offset:(CGSize)offset Radius:(CGFloat)radius;

@end