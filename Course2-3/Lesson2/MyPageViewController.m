//
//  MyPageViewController.m
//  Lesson2
//
//  Created by Ри on 24.02.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "MyPageViewController.h"

@interface MyPageViewController ()

@end

@implementation MyPageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dataSource = self;
    numberOfViewController=1;
    [self setViewControllers:@[self.presentViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}
static int numberOfViewController = 1;

-(UIViewController *)presentViewController{
    return [self.storyboard instantiateViewControllerWithIdentifier:@"FirstVC"];
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if (numberOfViewController == 1) {
        numberOfViewController++;
        return [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    }
    if (numberOfViewController == 2) {
        numberOfViewController++;
        return [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdVC"];
    }
    if (numberOfViewController==3) {
        
        numberOfViewController =1;
        return [self.storyboard instantiateViewControllerWithIdentifier:@"FirstVC"];
        
    }
    return nil;
}


-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (numberOfViewController == 2) {
        numberOfViewController=1;
        return [self.storyboard instantiateViewControllerWithIdentifier:@"FirstVC"];
    }
    if (numberOfViewController == 3) {
        numberOfViewController=2;
        return [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    }
    if(numberOfViewController==1){
        numberOfViewController=3;
        return [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdVC"];
    }
    return nil;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 3;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return numberOfViewController++;
}


@end
