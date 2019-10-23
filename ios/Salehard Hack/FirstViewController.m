//
//  FirstViewController.m
//  Salehard Hack
//
//  Created by Vladislav Shakhray on 22.10.2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FirstViewController.h"
#import "RouteView.h"
#import "TimelineTableViewController.h"

@interface FirstViewController ()

@property NSMutableArray<RouteView *> *routes;
@property (nonatomic) MKPolyline *line;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bool opt = 1;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"polzunki"]) {
        opt = [[[NSUserDefaults standardUserDefaults] objectForKey:@"polzunki"] intValue];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:opt == 1 ? 2 : 1] forKey:@"polzunki"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:@"polzunki"];
    }
    
    _routesDists = opt == 1 ?
    @[
    @[
    @"5", @"3", @"5.0"
    ], @[
    @"7", @"3.5", @"4.7"
    ], @[
    @"4", @"2.5", @"4.4"
    ]
    ] :
    @[
    @[
    @"8", @"4.5", @"4.9"
    ], @[
    @"8", @"4", @"5.0"
    ]
    ];
    
    _routesNames = opt == 1?
    @[
    @"Впервые в Салехарде", @"Белые Ходоки", @"Северное сияние"
    ] : @[
    @"Мамонт Салехарда", @"Поверь, тебе понравится"
    ];
    
    _pageControl.numberOfPages =_routesNames.count;
    _routesSeq = opt ==1 ?
    @[
    @[
    @0, @3, @4, @6
    ], @[
    @4, @10, @2
    ], @[
    @6, @11, @12, @1
    ]
    ] :
    @[
    @[
    @7, @8, @3, @9, @5
    ], @[
    @10, @9, @0, @7, @2
    ]
    ];
    
    _names =
    @[
    @"Обдорский острог (Город мастеров)", @"Ямало-Ненецкий окружной музейно-выставочный комплекс им. И.С.Шемановского", @"Окржной дом ремесел", @"Памятник Мамонту", @"Стела 66 параллель", @"Стела «Полярная звезда»", @"Скульптура Северный олень", @"Скульптура Чернобурая лиса", @"Национальная библиотека ЯНАО", @"Центральная библиотека Салехарда", @"Парк Победы", @"Парк-музей авиатехники", @"ТЦ Дары Ямала"
    ];
    
    _locs =
    @[
    @[
    @66.522479, @66.588848
    ], @[
    @66.536093, @66.607117
    ], @[
    @66.532647, @66.611795
    ], @[
    @66.527646, @66.635682
    ], @[
    @66.550914, @66.626306
    ], @[
    @66.584953, @66.569863
    ], @[
    @66.535499, @66.600286
    ], @[
    @66.530297, @66.613521
    ], @[
    @66.535556, @66.60455
    ], @[
    @66.527807, @66.628226
    ], @[
    @66.545101, @66.607129
    ], @[
    @66.585434, @66.570303
    ], @[
    @66.535176, @66.606651
    ]
    ];

    _descs = opt == 1 ?
    @[
    @"Для тех, кто хочет познакомится с главными достопримечательностями Салехарда.", @"Маршрут для путешественников, которые прилетели в Салехард в поисках приключений.", @"Для тех, кто хочет ощущить романтику севера в полной красе."
    ] :
    @[
    @"Места этого маршрута удивят даже коренных жителей Салехарда.", @"Поверь, понравится!"
    ];
    
    _routeCount = _routesNames.count;
    
    _addresses = @[
    @"ул. Республики, 1, Салехард, Ямало-Ненецкий автономный округ, 629008, Россия", @"ул. Чубынина, д. 38, Салехард, Ямало-Ненецкий автономный округ, 629008, Россия", @"ул. Чубынина, 24, Салехард, Ямало-Ненецкий автономный округ, 629008, Россия", @"ул. Салехард-Лабытнанги-Харп, 1, Салехард, Ямало-Ненецкий автономный округ, 629008, Россия", @"ул. Броднева, Салехард, Ямало-Ненецкий автономный округ, 629008, Россия", @"ул. Салехард-Лабытнанги-Харп, Салехард, Ямало-Ненецкий автономный округ, 629004, Россия", @"ул. Чубынина, Салехард, Ямало-Ненецкий автономный округ, 629003, Россия", @"ул. Свердлова, 48, Салехард, Ямало-Ненецкий автономный округ, 629008, Россия", @"ул. Чубынина, 36, Салехард, Ямало-Ненецкий автономный округ, 629007, Россия", @"ул. Комсомольская, 17а, Салехард, Ямало-Ненецкий автономный округ, 629008, Россия", @"ул. 4-яСадовая, 7, Дзержинец Снт, Ямало-Ненецкий автономный округ, 629008, Россия", @"ул. Авиационная, Салехард, Ямало-Ненецкий автономный округ, 629004, Россия", @"ул. Чубынина, 34, Салехард, Ямало-Ненецкий автономный округ, 629008, Россия"
    ];
//    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.title = @"Выбор Маршрута";
    
    CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:66.529633 longitude:66.613270];
    [self goToView:centerLocation];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 200;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.MapView.delegate = self;
    
//    CGRect frame = _continueButton.frame;
//    frame.origin.y = 10000;
//    _continueButton.frame = frame;
//    _continueButton.hidden = YES;
    
    _continueButton.backgroundColor = [UIColor colorWithRed:54./255 green:134./255 blue:231./255 alpha:1.0];
//        _continueButton.layer.cornerRadius = 8;
//        _continueButton.layer.borderWidth = 2;
    //    _continueButton.layer.borderColor = [UIColor colorWithRed:55./255 green:147/255. blue:232/255. alpha:1].CGColor;
        [_continueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_continueButton.layer setCornerRadius:8.0f];

    // border
    [_continueButton.layer setBorderColor:[UIColor clearColor].CGColor];
//        [_continueButton.layer setBorderWidth:1.5f];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"star.fill"] style:UIBarButtonItemStylePlain target:self action:@selector(achiv)];
    
    // drop shadow
    [_continueButton.layer setShadowColor:[UIColor colorWithWhite:0.2 alpha:1.0].CGColor];
    [_continueButton.layer setShadowOpacity:0.15];
    [_continueButton.layer setShadowRadius:8.0];
    [_continueButton.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [_continueButton addTarget:self action:@selector(contin:) forControlEvents:UIControlEventTouchUpInside];
    
    int numItems = _routeCount;
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 200;
    _scrollView.contentSize = CGSizeMake(w * numItems, h);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
        
//    _MapView.layer.cornerRadius = 12;
    
    _routes = [NSMutableArray new];
    for (int i = 0; i < numItems; i++) {
        RouteView *vv = [[RouteView alloc] initWithFrame:CGRectMake(w * i, 0, w, h)];
        
        UIView *v = vv.mainView;
        
        [v.layer setCornerRadius:16.0f];

        // border
        [v.layer setBorderColor:[UIColor clearColor].CGColor];
//        [v.layer setBorderWidth:1.5f];

        // drop shadow
        [v.layer setShadowColor:[UIColor colorWithWhite:0.2 alpha:1.0].CGColor];
        [v.layer setShadowOpacity:0.15];
        [v.layer setShadowRadius:8.0];
        [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        
        [_routes addObject:vv];
        
        vv.desc.text = _descs[i];
        vv.title.text = _routesNames[i];
        vv.descLabel.text = @"";
        vv.length.text = [NSString stringWithFormat:@"%@км", _routesDists[i][0]];
        vv.rating.text = [NSString stringWithFormat:@"%@", _routesDists[i][2]];
        vv.timing.text = [NSString stringWithFormat:@"%@ч", _routesDists[i][0]];
        
        UIButton *b = [[UIButton alloc] initWithFrame:vv.frame];
        b.tag = i;
        [b addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:vv];
        [_scrollView addSubview:b];
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _MapView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:1.0 alpha:1.0].CGColor, (id)[UIColor clearColor].CGColor, nil];
    gradientLayer.startPoint = CGPointMake(0.0f, 0.7f);
    gradientLayer.endPoint = CGPointMake(0.0f, 1.0f);
    _MapView.layer.mask = gradientLayer;
    
    // Do any additional setup after loading the view.
}

- (void)achiv {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"MainMax" bundle:nil] instantiateViewControllerWithIdentifier:@"huy2"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)goToView:(CLLocation*)location {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [self.MapView setRegion:region];
}

- (void)contin:(UIButton *)button {
#warning TODo
    
//    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as UIViewController
//    // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
//
//    self.presentViewController(viewController, animated: false, completion: nil)
//
    
    TimelineTableViewController *vc = [[UIStoryboard storyboardWithName:@"MainMax" bundle:nil] instantiateViewControllerWithIdentifier:@"huy"];
    vc.mindex = self.mindex;
    [self presentViewController:vc animated:YES completion:nil];
    
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
    static int i = 0;
    NSString* identifier = [NSString stringWithFormat:@"%d", i++];
    MKAnnotationView *annotationView = [self.MapView dequeueReusableAnnotationViewWithIdentifier:identifier];

    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = true;
    } else {
        annotationView.annotation = annotation;
    }
    return annotationView;
}

- (void)buttonTapped:(id)sender {
    return;
    int index = ((UIButton *)sender).tag;
    
    _continueButton.hidden = NO;
//    if (_tapped) {
//        _routes[_indexTapped].mainView.layer.borderColor = [UIColor clearColor].CGColor;
//        _routes[_indexTapped].mainView.layer.borderWidth = 0.0;
//    }
//
//    if (!_tapped) {
////        CGRect frame = _continueButton.frame;
////        CGRect frame2 = frame;
////        frame2.origin.y = self.view.frame.size.height;
////        frame.origin.y = _pageControl.frame.origin.y + 60;
////        [self moveView:_continueButton fromOrigin:frame2.origin toPlace:frame.origin alphaBegin:1. alphaEnd:1. time:0.5 completion:nil];
//    }
    
    _tapped = TRUE;
    _indexTapped = index;
    _routes[_indexTapped].mainView.layer.borderColor = [UIColor blueColor].CGColor;
    _routes[_indexTapped].mainView.layer.borderWidth = 4.0;
}

- (void)moveView:(UIView *)view fromOrigin:(CGPoint)origin toPlace:(CGPoint)destination alphaBegin:(CGFloat)alphaBegin alphaEnd:(CGFloat)alphaEnd time:(CGFloat)seconds completion:(void(^)(BOOL finished))completion
{
    view.alpha = alphaBegin;
    CGRect frame = view.frame;
    frame.origin = origin;
    view.frame = frame;
    
    [UIView animateWithDuration:seconds animations:^{
        CGRect frame = view.frame;
        frame.origin = destination;
        view.frame = frame;
        view.alpha = alphaEnd;
    } completion:completion];
}


- (void) update {
    int index = _pageControl.currentPage;
    
//    CGFloat x=10000, y=10000;
//    CGFloat w=0, h=0;
//
    [self.MapView removeOverlays:self.MapView.overlays];
    [self.MapView removeAnnotations:self.MapView.annotations];
    NSMutableArray<NSNumber *> *arr = _routesSeq[index];
//    for (int i = 0; i < arr.count - 1; i++) {
//        int cur = i;
//        int next = cur + 1;
//
//        NSMutableArray<NSNumber *> *loc1 = _locs[cur];
//        NSMutableArray<NSNumber *> *loc2 = _locs[next];
//
//        x = MIN(x, loc1[0].floatValue);
//        y = MIN(y, loc1[0].floatValue);
//    }
    
//
    
    for (int j = 0; j < arr.count - 1; j++) {
        
        int cur = arr[j].intValue;
        int next = arr[j + 1].intValue;
        
        NSMutableArray<NSNumber *> *loc1 = _locs[cur];
        NSMutableArray<NSNumber *> *loc2 = _locs[next];
        
        [self drawRoute:[[CLLocation alloc] initWithLatitude:[loc1[0] floatValue] longitude:[loc1[1] floatValue]] loc:[[CLLocation alloc] initWithLatitude:[loc2[0] floatValue] longitude:[loc2[1] floatValue]] inclAnnFrom:(j == 0) t1:_names[cur] t2:_addresses[cur] t3:_names[next] t4:_addresses[next]];

    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self update];
}

- (void) drawRoute:(CLLocation *)loc1 loc:(CLLocation *)loc2 inclAnnFrom:(BOOL)incl t1:(NSString *)t1 t2:(NSString *) t2 t3:(NSString *)t3 t4:(NSString *)t4 {
    NSLog(@"%f %f %f %f", loc1.coordinate.latitude, loc1.coordinate.longitude, loc2.coordinate.latitude, loc2
          .coordinate.longitude);
    
    CLLocationCoordinate2D coords[2];
    coords[0] = [loc1 coordinate];
    coords[1] = [loc2 coordinate];
    
    MKPlacemark *from = [[MKPlacemark alloc] initWithCoordinate:[loc1 coordinate]];
    MKPlacemark *to = [[MKPlacemark alloc] initWithCoordinate:[loc2 coordinate]];
    
    MKMapItem *fmi = [[MKMapItem alloc] initWithPlacemark:from];
    MKMapItem *tmi = [[MKMapItem alloc] initWithPlacemark:to];
    
    //MKPointAnnotation *fpa = [[MKPointAnnotation alloc] initWithCoordinate:[[from location] coordinate]];
    
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
            MKMapRect rect = MKMapRectMake(183866119.574057, 66980367.389133, 71777.437512, 215677.203286);
//            NSLog(@"####%f %f % f %f", rect.origin.x, rect.origin.y, rect.origin.x + rect.size.width, rect.origi/n.y);
            if (self.line != nil) {
//                [self.MapView removeOverlay:self.line];
            } else {
                MKPointAnnotation *tpa = [[MKPointAnnotation alloc] initWithCoordinate:[[to location] coordinate] title:t1 subtitle:t2];
                [self.MapView addAnnotation:tpa];
                if (incl) {
                    MKPointAnnotation *tpa2 = [[MKPointAnnotation alloc] initWithCoordinate:[[from location] coordinate] title:t3 subtitle:t4];
                    [self.MapView addAnnotation:tpa2];
                }
                [self.MapView setRegion:MKCoordinateRegionForMapRect(rect) animated:YES];
            }
            //self.line = route.polyline;
            
        }
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat w = self.view.frame.size.width;
    int currentPage = MIN((int)((MAX(scrollView.contentOffset.x, 0) + w / 2) / w), _pageControl.numberOfPages);
    if (currentPage != _pageControl.currentPage) {
        _pageControl.currentPage = currentPage;
        [self update];
    }
    self.mindex = currentPage;
}

@end
