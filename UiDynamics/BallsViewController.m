//
//  BallsViewController.m
//  UiDynamics
//
//  Created by Sunayna Jain on 1/29/14.
//  Copyright (c) 2014 LittleAuk. All rights reserved.
//

#import "BallsViewController.h"

@interface BallsViewController ()

@property UIDynamicAnimator *animator;
@property UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collision;
@property NSInteger ballXcoordinate;
@property BOOL firstContact;

@end

@implementation BallsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.firstContact = NO;
    self.ballXcoordinate = 30;

    UIView *circle = [[UIView alloc]initWithFrame:CGRectMake(160, 5, 40, 40)];
    circle.layer.cornerRadius = 20;
    circle.backgroundColor = [UIColor redColor];
    [self.view addSubview:circle];
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc]initWithItems:@[circle]];
    [self.animator addBehavior:self.gravity];
    
    self.collision = [[UICollisionBehavior alloc]initWithItems:@[circle]];
    [self.collision setTranslatesReferenceBoundsIntoBoundary:YES];
    self.collision.collisionDelegate = self;
    [self.animator addBehavior:self.collision];
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[circle]];
    itemBehavior.elasticity = 1;
    [self.animator addBehavior:itemBehavior];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark- UICollisionBehavior Delegate methods

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{
    
    UIView *view = (UIView*)item;
    if (view.backgroundColor ==[UIColor redColor]){
        view.backgroundColor = [UIColor yellowColor];
    } else {
        view.backgroundColor = [UIColor redColor];
    }
    
    if (!self.firstContact){
        
        self.firstContact = YES;
        
        if (self.ballXcoordinate<300){
            
            UIView *addCircle = [[UIView alloc]initWithFrame:CGRectMake(self.ballXcoordinate, 5, 40, 40)];
            addCircle.layer.cornerRadius = 20;
            addCircle.backgroundColor = [UIColor redColor];
            [self.view addSubview:addCircle];
            
            [self.gravity addItem:addCircle];
            [self.collision addItem:addCircle];
            
            UIDynamicItemBehavior *itemBehaviour = [[UIDynamicItemBehavior alloc]initWithItems:@[addCircle]];
            itemBehaviour.elasticity = 0.8;
            [self.animator addBehavior:itemBehaviour];
            self.ballXcoordinate +=40;
        }
        
    }
    
    self.firstContact = NO;
}












@end
