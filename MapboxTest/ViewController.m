//
//  ViewController.m
//  MapboxTest
//
//  Created by Jesse Crocker on 11/8/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import "ViewController.h"

@import Mapbox;

@interface ViewController ()

@property (nonatomic, strong) MGLMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:self.mapView];
}


@end
