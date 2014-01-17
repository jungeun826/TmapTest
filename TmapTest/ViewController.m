//
//  ViewController.m
//  TmapTest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#define APP_KEY @"436686fb-a4ea-3149-b8b1-7b1af6226827"
#define TOOLBAR_HIGHT 72
@interface ViewController ()
@property (strong, nonatomic) TMapView *mapView;
@end

@implementation ViewController
#pragma mark T-MAP DELEGATE
-(void)onCLick:(TMapPoint *)point{
    NSLog(@"Tapped Point : %@", point);
}
-(void)onLongCLick:(TMapPoint *)point{
    NSLog(@"Long Click Point : %@", point);
}
-(void)onCalloutRightbuttonClick:(TMapMarkerItem *)markerItem{
    NSLog(@"Maket ID : %@", [markerItem getID]);
    if([@"T-ACADEMY" isEqualToString:[markerItem getID]]){
        DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        detailVC.urlStr = @"https://oic.skplanet.com/frontMain.action";
        //[self.navigationController pushViewController:detailVC animated:YES];
        [self presentViewController:detailVC animated:YES completion:nil];
    }
}
-(void)onCustomObjectClick:(TMapObject *)obj{
    if([obj isKindOfClass:[TMapMarkerItem class]]){
        TMapMarkerItem *marker = (TMapMarkerItem *)obj;
        NSLog(@"Marker Clicked..%@", [marker getID]);
    }
}
- (IBAction)addOverlay:(id)sender {
    CLLocationCoordinate2D coord[5] = {
        CLLocationCoordinate2DMake(37.446178, 126.958220),
        CLLocationCoordinate2DMake(37.446178, 126.965220),
        CLLocationCoordinate2DMake(37.443178, 126.965220),
        CLLocationCoordinate2DMake(37.441178, 126.963220),
        CLLocationCoordinate2DMake(37.442178, 126.958220)
    };
    
    
    TMapPolygon *polygon = [[TMapPolygon alloc]init];
    [polygon setLineColor:[UIColor blueColor]];
    
    [polygon setPolygonAlpha:0];
    [polygon setLineWidth:8.0];
    for(int index = 0 ; index<5 ; index++)
        [polygon addPolygonPoint:[TMapPoint mapPointWithCoordinate:coord[index]]];
    
    [self.mapView addTMapPolygonID:@"관악산" Polygon:polygon];
}
- (IBAction)addMarker:(id)sender {
    NSString *itemID = @"T-ACADEMY";
    
    TMapPoint *point= [[TMapPoint alloc]initWithLon:126.96 Lat:37.466];
    [self.mapView setCenterPoint:point];
    TMapMarkerItem *marker = [[TMapMarkerItem alloc]initWithTMapPoint:point];
    [marker setIcon:[UIImage imageNamed:@"토끼.jpg"]];
    
    [marker setCanShowCallout:YES];
    [marker setCalloutTitle:@"티 아카데미"];
    [marker setCalloutRightButtonImage:[UIImage imageNamed:@"_Right"]];
     
     [self.mapView addTMapMarkerItemID:itemID Marker:marker];
}

-(IBAction)moveToNTower:(id)sender{
    TMapPoint *centerPoint = [[TMapPoint alloc] initWithLon:126.961220 Lat:37.443178];
    [self.mapView setCenterPoint:centerPoint];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, TOOLBAR_HIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HIGHT);
    
    self.mapView = [[TMapView alloc]initWithFrame:rect];
    [self.mapView setSKPMapApiKey:APP_KEY];
   // self.mapView.zoomLevel = 12;
    
    self.mapView.delegate = self;
    
    
    [self.view addSubview:self.mapView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
