//
//  ViewController.m
//  ScrollAnimationTest
//
//  Created by Rocky Duan on 4/14/15.
//  Copyright (c) 2015 Sellegit. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>

@interface ViewController ()

@property (nonatomic, strong) TableDelegate *delegate;
@property (nonatomic, strong) TableSource *source;
@end

@implementation ViewController

@synthesize currentDiscount;
@synthesize rowHeight;
@synthesize delegate;
@synthesize source;
@synthesize positionMapping;

- (id) init {
    self = [super init];
    if (self) {
        self.currentDiscount = 0;
        self.rowHeight = 60;
        [self setPositionMapping:[[NSMutableDictionary alloc] init]];
    }
    return self;
}

- (void)loadView {
//    [super loadView];
    UITableView* tableView = [[UITableView alloc] init];
    [tableView setBackgroundColor:[UIColor whiteColor]];
    [tableView setRowHeight:self.rowHeight];
    self.topInset = [UIScreen mainScreen].bounds.size.height / 2 - self.rowHeight / 2;
    [tableView setContentInset:UIEdgeInsetsMake(self.topInset, 0, 0, 0)];
    [tableView setContentOffset:CGPointMake(0, -self.topInset)];
    
    self.delegate = [[TableDelegate alloc] initWithController:self];
    self.source = [[TableSource alloc] initWithController:self];
    
    [tableView setDelegate:self.delegate];
    [tableView setDataSource:self.source];
    [tableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [self setView:tableView];
    
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@interface TableDelegate ()

@property (nonatomic, weak) ViewController *controller;


@end

@implementation TableDelegate

@synthesize controller;

- (id) initWithController:(ViewController*)controllerArg {
    self = [super init];
    if (self) {
        self.controller = controllerArg;
    }
    return self;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableView* tableView = (UITableView*) scrollView;
    float scrollTop = tableView.contentOffset.y;
    NSInteger row = (NSInteger) ((scrollTop + controller.topInset) / controller.rowHeight);
    controller.currentDiscount = row;
    
    NSArray* cells = tableView.visibleCells;
    for (int i = 0; i < cells.count; ++i) {
        UITableViewCell* cell = [cells objectAtIndex:i];
        NSInteger position = cell.tag;
        UIView* view = [cell.subviews objectAtIndex:0];
        if (position == row) {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
                [view setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
            } completion:^(BOOL finished) {
                
            }];
        } else {
            [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
                [view setTransform:CGAffineTransformMakeScale(0.7f, 0.7f)];
            } completion:^(BOOL finished) {
                
            }];

        }
    }
    
}

@end

@interface TableSource ()

@property (nonatomic, weak) ViewController *controller;

@end

@implementation TableSource

@synthesize controller;

- (id) initWithController:(ViewController*)controllerArg {
    self = [super init];
    if (self) {
        self.controller = controllerArg;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"TableCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        NSArray* subviews = [cell subviews];
        for (int i = 0; i < subviews.count; ++i) {
            [[subviews objectAtIndex:i] removeFromSuperview];
        }
        UIView* box = [[UIView alloc] init];
        [box setBackgroundColor:[UIColor redColor]];
        [box setFrame:CGRectMake(0, 0, tableView.frame.size.width, self.controller.rowHeight)];
//        box.userInteractionEnabled = NO;
        [cell addSubview:box];
    }
    UIView* view = [[cell subviews] objectAtIndex:0];
    NSInteger row = indexPath.row;
    if (row == controller.currentDiscount) {
        [view setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
    } else {
        [view setTransform:CGAffineTransformMakeScale(0.7f, 0.7f)];
    }
//    NSInteger* key = [NSInteger alloc] init
    
    [cell setTag:row];
//    [self.controller.positionMapping setObject:[NSNumber numberWithInteger:row] forKey:[cell mutableCopy]];
    
    return cell;
}

@end