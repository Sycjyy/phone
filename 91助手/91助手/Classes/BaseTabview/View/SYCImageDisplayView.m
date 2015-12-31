//
//  SYCImageDisplayView.m
//  91助手
//
//  Created by sycjyy on 15/12/3.
//  Copyright (c) 2015年 sycjyy. All rights reserved.
//
#define viewW self.frame.size.width
#define viewH self.frame.size.height

#import "SYCImageDisplayView.h"

#import "UIImageView+WebCache.h"

@implementation SYCImageDisplayView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.pagingEnabled = YES;
        self.bounces = NO;
    }
    return self;
}

- (void)setImages:(NSArray *)images{
    _images = images;
    NSInteger num = (images.count + 1) / 2;
    
    self.contentSize = CGSizeMake(viewW * num, viewH);
    
    [self setUpImageViews];
    
}

- (void)setUpImageViews{
    CGFloat margin = 5;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = (viewW - margin) / 2;
    CGFloat imageH = viewH;
    NSInteger num = _images.count;
    UIImage *image = [UIImage imageNamed:@"detail_image_default"];
    
    if (num % 2 == 1)num = num + 1;
        
    for (int i = 0; i < num; i++) {
        if (i % 2) {
            imageX = (i / 2) * viewW + imageW + margin;
        }else{
            imageX = (i / 2) * viewW;
        }
        CGRect imageRect = CGRectMake(imageX, imageY, imageW, imageH);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
        imageView.backgroundColor = [UIColor yellowColor];
        //加载图片的过程也需要判断下
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            if (_images.count % 2) {
//                if (i == (_images.count - 1) || i == _images.count) {
//                    [imageView sd_setImageWithURL:[NSURL URLWithString:_images[i-1]] placeholderImage:image];
//                }else{
//                    [imageView sd_setImageWithURL:[NSURL URLWithString:_images[i]] placeholderImage:image];
//                }
//            }else{
//                [imageView sd_setImageWithURL:[NSURL URLWithString:_images[i]] placeholderImage:image];
//            }
//  
//        });
        if (_images.count % 2) {
            if (i == (_images.count - 1) || i == _images.count) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:_images[i-1]] placeholderImage:image];
            }else{
                [imageView sd_setImageWithURL:[NSURL URLWithString:_images[i]] placeholderImage:image];
            }
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:_images[i]] placeholderImage:image];
        }
                [self addSubview:imageView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
