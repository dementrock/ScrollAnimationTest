//
//  ViewController.h
//  ScrollAnimationTest
//
//  Created by Rocky Duan on 4/14/15.
//  Copyright (c) 2015 Sellegit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewController : UIViewController
@property NSInteger currentDiscount;
@property float topInset;
@property float rowHeight;
@property NSMutableDictionary* positionMapping;
@end

@interface TableDelegate : NSObject<UITableViewDelegate>

- (id) initWithController:(ViewController*)controllerArg;

@end

@interface TableSource : NSObject<UITableViewDataSource>
- (id) initWithController:(ViewController*)controllerArg;
@end