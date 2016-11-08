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

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
  self.mapView.delegate = self;
  [self.view addSubview:self.mapView];
}

- (void)runRasterSourceTest:(MGLStyle*)style {
  MGLTileSet *tileset =  [[MGLTileSet alloc] initWithTileURLTemplates:@[@"http://tile.openstreetmap.org/{z}/{x}/{y}.png"]
                                         minimumZoomLevel:0
                                         maximumZoomLevel:16];
  MGLRasterSource *source = [[MGLRasterSource alloc] initWithIdentifier:@"openstreetmap"
                                                                tileSet:tileset
                                                               tileSize:256];
  MGLRasterStyleLayer *layerStyle = [[MGLRasterStyleLayer alloc] initWithIdentifier:@"osm"
                                                                             source:source];
  [style addSource:source];
  [style addLayer:layerStyle];
  
  [self removeAndReAddSource:source toStyle:style];
}


- (void)runVectorSourceTest:(MGLStyle*)style {
  MGLTileSet *tileset =  [[MGLTileSet alloc] initWithTileURLTemplates:@[@"https://tile.mapzen.com/mapzen/vector/v1/buildings/{z}/{x}/{y}.mvt"]
                                                     minimumZoomLevel:0
                                                     maximumZoomLevel:16];
  MGLVectorSource *source = [[MGLVectorSource alloc] initWithIdentifier:@"mapzen"
                                                                tileSet:tileset];
  
  MGLFillStyleLayer *fillLayer = [[MGLFillStyleLayer alloc] initWithIdentifier:@"buildings" source:source];
  fillLayer.fillColor = [MGLStyleValue valueWithRawValue:[UIColor magentaColor]];
  
  [style addSource:source];
  [style addLayer:fillLayer];
  
  [self removeAndReAddSource:source toStyle:style];
}


- (void)removeAndReAddSource:(MGLSource*)source toStyle:(MGLStyle*)style {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSLog(@"removing source");
    [style removeSource:source];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      NSLog(@"adding source");
      [style addSource:source];
    });
  });
}

- (void)mapView:(MGLMapView *)mapView didFinishLoadingStyle:(MGLStyle *)style {
  [self runRasterSourceTest:style];
//  [self runVectorSourceTest:style];
}

@end
