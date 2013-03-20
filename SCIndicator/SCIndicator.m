/*
 Copyright (c) 2013 stcui
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "SCIndicator.h"
#import <QuartzCore/QuartzCore.h>
#define SWImageCache UIImage

@implementation SCIndicator
{
    CALayer *_contentLayer;
    CALayer *_indicatorLayer;
    CALayer *_maskLayer;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.emptyColor = [UIColor grayColor];
        self.image = image;
        _maskLayer = [CALayer layer];
        _maskLayer.frame = self.bounds;
        _maskLayer.contents = (id)image.CGImage;
        
        _indicatorLayer = [CALayer layer];
        _indicatorLayer.frame = self.bounds;
        _indicatorLayer.backgroundColor = self.emptyColor.CGColor;
        [_indicatorLayer setMask:_maskLayer];
        
        [self.layer addSublayer:_indicatorLayer];
    }
    return self;
}
- (void)setImageMask:(UIImage *)mask
{
    _maskLayer.contents = (id)mask.CGImage;
    _maskLayer.frame = _indicatorLayer.frame;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return self.image.size;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    CGFloat offset = roundf(CGRectGetHeight(self.bounds) * progress);
    CGRect frame = self.bounds;

    frame.size.height = CGRectGetHeight(frame) - offset;
    frame.origin.y = 0;//CGRectGetHeight(self.bounds) - offset;

    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    _indicatorLayer.frame = frame;
    [CATransaction commit];
}

- (void)setEmptyColor:(UIColor *)emptyColor
{
    _emptyColor = emptyColor;
    _indicatorLayer.backgroundColor = emptyColor.CGColor;
}

@end
