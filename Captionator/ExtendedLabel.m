#import "ExtendedLabel.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExtendedLabel
@synthesize gradientColors, strokeColor;

- (void)dealloc
{
   [gradientColors release];
   [strokeColor release];
   
   [super dealloc];
}

- (void)resetGradient
{
   if (CGRectEqualToRect(self.frame, CGRectZero))
   {
      return;
   }
   
   if ( [self.gradientColors count] == 0 )
   {
      self.textColor = [UIColor blackColor];
      return;
   }
   if ( [self.text length] == 0 )
   {
      return;
   }
   
   UIGraphicsBeginImageContext(CGSizeMake(1, self.frame.size.height));
   CGContextRef context = UIGraphicsGetCurrentContext();
   UIGraphicsPushContext(context);
   
   int const colorStops = [self.gradientColors count];
   CGSize lineSize = [self.text sizeWithFont:self.font]; 
   CGSize textSize = [self.text sizeWithFont:self.font constrainedToSize:self.bounds.size lineBreakMode:self.lineBreakMode];
   CGFloat topOffset = (self.bounds.size.height - textSize.height) / 2.0f;
   CGFloat lines =  textSize.height / lineSize.height;
   
   size_t num_locations = colorStops * lines + 2;
   CGFloat locations[num_locations];
   CGFloat components[num_locations * 4];
   locations[0] = 0.0f;
   [[gradientColors objectAtIndex:0] getRed:&(components[0]) green:&(components[1]) blue:&(components[2]) alpha:&(components[3])];
   locations[num_locations - 1] = 1.0f;
   [[gradientColors lastObject] getRed:&(components[(num_locations-1) * 4]) green:&(components[(num_locations-1) * 4 + 1]) blue:&(components[(num_locations-1) * 4 + 2]) alpha:&(components[(num_locations-1) * 4 + 3])];
   for ( int l = 0; l < lines; ++l )
   {
      for ( int i = 0; i < colorStops; ++i )
      {
         int index = 1 + l * colorStops + i;
         locations[index] = ( topOffset + l * lineSize.height + lineSize.height * (CGFloat)i / (CGFloat)(colorStops - 1) ) / self.frame.size.height;
         
         UIColor *color = [gradientColors objectAtIndex:i];
         [color getRed:&(components[4*index+0]) green:&(components[4*index+1]) blue:&(components[4*index+2]) alpha:&(components[4*index+3])];
      }
      
      // Add a little bit to the first stop so that it won't render into the last line of pixels at the previous line of text.
      locations[1 + l * colorStops] += 0.01f;
   }
   
   CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
   CGGradientRef gradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
   CGPoint topCenter = CGPointMake(0, 0);
   CGPoint bottomCenter = CGPointMake(0, self.frame.size.height);
   CGContextDrawLinearGradient(context, gradient, topCenter, bottomCenter, 0);
   
   CGGradientRelease(gradient);
   CGColorSpaceRelease(rgbColorspace);
   
   UIGraphicsPopContext();
   self.textColor = [UIColor colorWithPatternImage:UIGraphicsGetImageFromCurrentImageContext()];
   UIGraphicsEndImageContext();
}

- (void)setShadowWithColor:(UIColor *)color Offset:(CGSize)offset Radius:(CGFloat)radius 
{
   shadowOffset = offset;
   shadowBlur = radius;
   [color retain];
   [shadowColor release];
   shadowColor = color;
   
   [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
   [super setText:text];
   isGradientValid = NO;
}

- (void)setFont:(UIFont *)font
{
   [super setFont:font];
   isGradientValid = NO;
}

- (void)setFrame:(CGRect)aFrame
{
   [super setFrame:aFrame];
   
   isGradientValid = NO;
}

- (CGRect)textRectForBounds:(CGRect)rect
{
   return CGRectMake(rect.origin.x + MAX(0, shadowBlur - shadowOffset.width), rect.origin.y + MAX(0, shadowBlur - shadowOffset.height), rect.size.width - ABS(shadowOffset.width) - shadowBlur, rect.size.height - ABS(shadowOffset.height) - shadowBlur);
}

- (void)drawTextInRect:(CGRect)rect
{
   if ( isGradientValid == NO )
   {
      isGradientValid = YES;
      [self resetGradient];
   }
   
   CGContextRef context = UIGraphicsGetCurrentContext();
   
   //draw stroke
   if (self.strokeColor != nil)
   {
      CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
      CGContextSetTextDrawingMode(context, kCGTextFillStroke);
   }
   
   
   
   // Note: Setting shadow on the context is much faster than setting shadow on the CALayer.
   if ( shadowColor != nil )
   {
      // We take the radius times two to have the same result as settings the CALayers shadow radius.
      // CALayer seems to take a true radius where CGContext seems to take amount of pixels (so 2 would
      // be one pixel in each direction or something like that).
      CGContextSetShadowWithColor(context, shadowOffset, shadowBlur * 2.0f, [shadowColor CGColor]);
   }
   
   [super drawTextInRect:rect];
}

@end