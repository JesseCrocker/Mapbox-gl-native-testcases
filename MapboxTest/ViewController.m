//
//  ViewController.m
//  MapboxTest
//
//  Created by Jesse Crocker on 11/8/16.
//  Copyright © 2016 Trailbehind inc. All rights reserved.
//

#import "ViewController.h"

@import Mapbox;

@interface ViewController () <MGLMapViewDelegate>

@property (nonatomic, strong) MGLMapView *mapView;
@property (nonatomic, strong) MGLShapeSource *source;
@property (nonatomic, strong) MGLFillStyleLayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
  self.mapView.delegate = self;
  [self.view addSubview:self.mapView];
  UIButton *addLayerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  addLayerButton.frame = CGRectMake(0, 100, 100, 40);
  [addLayerButton setTitle:@"change style" forState:UIControlStateNormal];
  [addLayerButton addTarget:self
                     action:@selector(changeStyle)
           forControlEvents:UIControlEventTouchUpInside];
  addLayerButton.backgroundColor = [UIColor greenColor];
  [self.view addSubview:addLayerButton];

  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(handleSingleTapGesture:)];
  for(UIGestureRecognizer *r in self.mapView.gestureRecognizers) {
    [tapGestureRecognizer requireGestureRecognizerToFail:r];
  }
  [self.mapView addGestureRecognizer:tapGestureRecognizer];

}

#pragma mark - layers
- (void)mapView:(MGLMapView *)mapView didFinishLoadingStyle:(MGLStyle *)style {
  [self addShapeLayer:style];
}

- (void)addShapeLayer:(MGLStyle*)style {
  if(!self.source && !self.layer) {
    NSLog(@"Creating shape layer");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ne_110m_admin_1_states_provinces_shp"
                                                     ofType:@"geojson"];
    NSError *error;
    MGLShapeCollection *featureCollection = (MGLShapeCollection*)[MGLShape shapeWithData:[NSData dataWithContentsOfFile:path]
                                                                                encoding:NSUTF8StringEncoding
                                                                                   error:nil];
    if(error) {
      NSLog(@"Error decoding json:%@", error);
    }
    
    self.source = [[MGLShapeSource alloc] initWithIdentifier:@"states"
                                                       shape:featureCollection
                                                     options:@{}];
    self.layer = [[MGLFillStyleLayer alloc] initWithIdentifier:@"states.fill"
                                                        source:self.source];
    self.layer.fillOpacity = [MGLStyleValue valueWithRawValue:@(0.5)];
    self.layer.fillColor = [MGLStyleValue valueWithRawValue:[UIColor redColor]];
  }
  
  NSLog(@"Adding shape layer to style");
  [style addSource:self.source];
  [style addLayer:self.layer];
}


- (void)removeShapeLayer {
  MGLStyle *style = self.mapView.style;
  [style removeSource:self.source];
  [style removeLayer:self.layer];
}


#pragma mark - test
- (void)changeStyle {
  [self removeShapeLayer];
  [self.mapView setStyleURL:[MGLStyle satelliteStyleURLWithVersion:8]];
}

- (void)handleSingleTapGesture:(UITapGestureRecognizer*)sender {
  CGPoint point = [sender locationInView:self.mapView];

  //This Crashes
  NSArray <id <MGLFeature>> * featuresAtPoint = [self.mapView visibleFeaturesAtPoint:point
                                                 inStyleLayersWithIdentifiers:[NSSet setWithObject:self.layer.identifier]];
  NSLog(@"tapped %lu features at point %@", (unsigned long)featuresAtPoint.count, NSStringFromCGPoint(point));
 }


@end
