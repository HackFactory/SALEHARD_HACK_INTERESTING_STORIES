//
//  RouteMapViewViewController.h
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface RouteMapViewViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *MapView;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (nonatomic) CLLocation *targetLocation;
@property (strong, nonatomic) NSString *Addr;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic ) NSTimer * _Nullable updateTimer;
@end

NS_ASSUME_NONNULL_END
