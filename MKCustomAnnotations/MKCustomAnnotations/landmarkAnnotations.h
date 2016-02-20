//
//  landmarkAnnotations.h
//  MKCustomAnnotations
//
//  Created by Himanshu Khatri on 2/18/16.
//  Copyright © 2016 bdAppManiac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface landmarkAnnotations : NSObject <MKAnnotation>
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;

-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location;
-(MKAnnotationView *)annotationView;
@end
