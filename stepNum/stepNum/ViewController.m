//
//  ViewController.m
//  stepNum
//
//  Created by baidu on 2018/9/17.
//  Copyright © 2018年 mahp. All rights reserved.
//

#import "ViewController.h"
#import <HealthKit/HealthKit.h>
@interface ViewController ()
@property (nonatomic,strong) HKHealthStore *healthStore;
@end

@implementation ViewController

#pragma mark -lazy
- (HKHealthStore *)healthStore{
    if (!_healthStore) {
        _healthStore = [[HKHealthStore alloc]init];
    }
    return _healthStore;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //获取权限
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *writeDataTypes = [NSSet setWithObjects:stepCountType, nil];
    [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:nil completion:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            //修改步数
            HKQuantityType * quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
            HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:30000.0f];
            HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
            
            [self.healthStore saveObject:temperatureSample withCompletion:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"添加成功");
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"添加失败");
                    });
                }
            }];
        }
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
