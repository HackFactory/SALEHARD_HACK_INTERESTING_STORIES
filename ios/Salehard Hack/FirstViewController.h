//
//  FirstViewController.h
//  Salehard Hack
//
//  Created by Vladislav Shakhray on 22.10.2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@import CoreLocation;

@interface FirstViewController : UIViewController <UIScrollViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@property int routeCount;

@property NSMutableArray<NSString *> *routesNames;
@property NSMutableArray<NSMutableArray<NSNumber *> *> *routesSeq;
@property NSMutableArray<NSString *> *names;
@property NSMutableArray<NSString *> *types;
@property NSMutableArray<NSMutableArray<NSNumber *> *> *locs;
@property NSMutableArray<NSString *> *addresses;
@property NSMutableArray<NSString *> *descs;
@property NSMutableArray<NSMutableArray<NSString *> *> *routesDists;

@property (strong, nonatomic) CLLocationManager * locationManager;
@property (nonatomic) CLLocation *targetLocation;
@property (strong, nonatomic) NSString *Addr;
@property (strong, nonatomic) NSString *Title;

@property BOOL tapped;
@property int indexTapped;

@property (weak, nonatomic) IBOutlet MKMapView *MapView;

@property (nonatomic) NSInteger mindex;
@end

