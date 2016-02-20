//
//  ViewController.m
//  MKCustomAnnotations
//
//  Created by Himanshu Khatri on 2/18/16.
//  Copyright © 2016 bdAppManiac. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "landmarkAnnotations.h"
@interface ViewController ()<MKMapViewDelegate>{
    
    IBOutlet MKMapView *INMapView;
    CLLocationManager *locationManager;
    
//    MKOverlay *routeLine;
}

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = (id) self;
        // Use one or the other, not both. Depending on what you put in info.plist
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];

    
    INMapView.showsUserLocation = YES;
    [INMapView setMapType:MKMapTypeStandard];
    [INMapView setZoomEnabled:YES];
    [INMapView setScrollEnabled:YES];
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = locationManager.location.coordinate.latitude;
    region.center.longitude = locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [INMapView setRegion:region animated:YES];
    
    CLLocationCoordinate2D staticLocation=CLLocationCoordinate2DMake(26.28, 73.02);
    
    NSMutableArray *arrayOfAnnotations = [NSMutableArray new];
    
    NSMutableArray *cordinates =[NSMutableArray new];
    for (int i= 0 ; i<10; i ++) {
        
        NSString *tit = [NSString stringWithFormat:@"title of place %d",i];
        if (i % 2) {
                    staticLocation=CLLocationCoordinate2DMake(staticLocation.latitude+.001, staticLocation.longitude+.002);
        }else{
                    staticLocation=CLLocationCoordinate2DMake(staticLocation.latitude+.001, staticLocation.longitude-.002);
        }


        
        landmarkAnnotations *landAnnotation = [[landmarkAnnotations alloc]initWithTitle:tit Location:staticLocation];
        [arrayOfAnnotations addObject:landAnnotation];
        
        
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:staticLocation radius:20];
        [INMapView addOverlay:circle];
        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:staticLocation.latitude longitude:staticLocation.longitude];
        [cordinates addObject:location];
    }
    
    [INMapView addAnnotations:arrayOfAnnotations];
    [self drawRoute:cordinates];
    //after adding the annotation at "coordinate", add the circle...

    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    CLLocationCoordinate2D coord = mapView.userLocation.location.coordinate;
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000.0, 10000.0);
//    [mapView setRegion:region animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[landmarkAnnotations class]]) {
        landmarkAnnotations *landAnno = (landmarkAnnotations *)annotation;
        MKAnnotationView *annotationView =[mapView dequeueReusableAnnotationViewWithIdentifier:@"landMark"];
        
        
        if (annotationView == nil) {
            annotationView = landAnno.annotationView;
            
        }else{
            annotationView.annotation = annotation;
        }
        return  annotationView;
    }else{
        return nil;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"%@",view.annotation.title);
}



- (void) drawRoute:(NSArray *) path
{
    NSInteger numberOfSteps = path.count;
    
    CLLocationCoordinate2D coordinates[numberOfSteps];
    
    for (NSInteger index = 0; index < numberOfSteps; index++) {
        
        CLLocation *location = [path objectAtIndex:index];
        
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        coordinates[index] = coordinate;
    }
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [INMapView addOverlay:polyLine];
    
    
}



-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
   
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer *polylineView = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        polylineView.strokeColor = [[UIColor orangeColor]colorWithAlphaComponent:0.5];
        polylineView.lineWidth = 3.0;
        
        return polylineView;
        
    }else{
        
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithCircle:overlay];
        circleView.strokeColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth= 2.0;
        circleView.fillColor = [[UIColor orangeColor]colorWithAlphaComponent:0.5];
        
        
        return circleView;
    }

}

@end
