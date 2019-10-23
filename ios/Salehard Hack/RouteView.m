//
//  RouteView.m
//  Salehard Hack
//
//  Created by Vladislav Shakhray on 22.10.2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import "RouteView.h"

@implementation RouteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

- (void) customInit {
    [[NSBundle mainBundle]loadNibNamed:@"RouteView" owner:self options:nil];
    
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}

@end
