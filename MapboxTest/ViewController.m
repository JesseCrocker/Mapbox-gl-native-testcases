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
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addMapView];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:5
                                               repeats:YES
                                                 block:^(NSTimer * _Nonnull timer) {
                                                   [self removeMapView];
                                                   [self addMapView];
                                                 }];
}

- (void)removeMapView {
  [self.mapView removeFromSuperview];
  self.mapView = nil;
}

- (void)addMapView {
  self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:self.mapView];
}


@end
