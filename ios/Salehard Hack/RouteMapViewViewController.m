//
//  RouteMapViewViewController.m
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import "RouteMapViewViewController.h"
@import CoreLocation;

@interface RouteMapViewViewController ()
@property (nonatomic) MKPolyline *line;

@end

@implementation RouteMapViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:66.529633 longitude:66.613270];
    [self goToView:centerLocation];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 200;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.MapView.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
    target:self
    selector:@selector(update)
    userInfo:nil
    repeats:YES];
}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) update {
    [self drawRoute];
}

- (void)goToView:(CLLocation*)location {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [self.MapView setRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Failed with error %@", error); 
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"Did change auth %d", status);
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"locations updated %@", locations);
}

- (MKOverlayRenderer*) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.strokeColor = [UIColor blueColor];
        renderer.lineWidth = 4.0;
        return renderer;
    }
    return nil;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSString* identifier = @"Annotation";
    MKAnnotationView *annotationView = [self.MapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = true;
    } else {
        annotationView.annotation = annotation;
    }

    return annotationView;
    
}
- (void) drawRoute {
    
    CLLocation *loc1 = [[self.MapView userLocation] location];
    CLLocation *loc2 = self.targetLocation;
    
    CLLocationCoordinate2D coords[2];
    coords[0] = [loc1 coordinate];
    coords[1] = [loc2 coordinate];
    
    MKPlacemark *from = [[MKPlacemark alloc] initWithCoordinate:[loc1 coordinate]];
    MKPlacemark *to = [[MKPlacemark alloc] initWithCoordinate:[loc2 coordinate]];
    
    MKMapItem *fmi = [[MKMapItem alloc] initWithPlacemark:from];
    MKMapItem *tmi = [[MKMapItem alloc] initWithPlacemark:to];
    
    //MKPointAnnotation *fpa = [[MKPointAnnotation alloc] initWithCoordinate:[[from location] coordinate]];
    MKPointAnnotation *tpa = [[MKPointAnnotation alloc] initWithCoordinate:[[to location] coordinate] title:self.Title subtitle:self.Addr];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = fmi;
    request.destination = tmi;
    request.transportType = MKDirectionsTransportTypeAutomobile;
    
    MKDirections *dirs = [[MKDirections alloc] initWithRequest:request];
    
    [dirs calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"ERROR DIRECTIONS %@", error);
        } else {
            MKRoute *route = [response.routes objectAtIndex:0];
            [self.MapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
            MKMapRect rect = route.polyline.boundingMapRect;
            if (self.line != nil) {
                [self.MapView removeOverlay:self.line];
            } else {
                [self.MapView addAnnotation:tpa];
                [self.MapView setRegion:MKCoordinateRegionForMapRect(rect) animated:YES];
            }
            self.line = route.polyline;
            
        }
        
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
