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
@property (nonatomic, strong) UILabel *zoomLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
  [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(43.5, -100) zoomLevel:0 animated:NO];
  [self.mapView setStyleURL:[NSURL URLWithString:@"https://static.gaiagps.com/mapboxglstyles/tribal-lands.json"]];
  [self.view addSubview:self.mapView];
  self.zoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
  self.zoomLabel.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.zoomLabel];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    for(int i = 0; i <= 24; i++) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(43.6539, -100.9361) zoomLevel:i animated:NO];
        self.zoomLabel.text = [NSString stringWithFormat:@"Zoom: %i", i];
        NSLog(@"Zoom: %i", i);
      });
      sleep(3);
    }
  });
}

@end
