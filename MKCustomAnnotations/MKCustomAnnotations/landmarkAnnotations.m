//
//  landmarkAnnotations.m
//  MKCustomAnnotations
//
//  Created by Himanshu Khatri on 2/18/16.
//  Copyright © 2016 bdAppManiac. All rights reserved.
//

#import "landmarkAnnotations.h"

@implementation landmarkAnnotations 
-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location{
    self = [super init];
    if (self) {
        _title = newTitle;
        _coordinate = location;
    }
    return self;
}
-(MKAnnotationView *)annotationView{
    MKAnnotationView *annotaion = [[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"landMark"];
    annotaion.enabled = YES;
    annotaion.canShowCallout =YES;
    annotaion.image =[UIImage imageNamed:@"pick-location"];
    annotaion.centerOffset=CGPointMake(0, -20); // offset to make the bottom pointer
    annotaion.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    return  annotaion;
}

@end
