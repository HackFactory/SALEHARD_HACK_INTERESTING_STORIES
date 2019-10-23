//
//  SecondViewController.m
//  Salehard Hack
//
//  Created by Vladislav Shakhray on 22.10.2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

int vcCount = 4;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (_index) {
        case 0: {
            _variants = @[@"Ни разу", @"Один раз", @"Более двух раз"];
            _question.text = @"Сколько раз ты был на Ямале?";
            break;
        }
        case 1:
            _variants = @[@"Очень быстро", @"Быстро", @"Средне", @"Долго", @"Очень долго"];
            _question.text = @"Время маршрута";
            break;
        case 2:
            _variants = @[@"Ночь", @"Полярная ночь"];
            _question.text = @"Предпочтительное время суток";
            break;
        case 3:
            _variants = @[@"Умиротворенное", @"Умеренное", @"Активное"];
            _question.text = @"Ваше настроение";
            break;
        default: 
            break;
    }
    _slider.minimumValue = 0.;
    _slider.maximumValue = (float)_variants.count - 1;
    _slider.continuous = YES;
    _slider.value = 0.;
    [self sliderValueChanged:nil];
//    _answer.text = _variants[0];
    
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:(_index == vcCount - 1) ? @"Done" : @"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextOne)];
    
    
    // Do any additional setup after loading the view.
}

- (void)sliderValueChanged:(UISlider *)slider {
    float val = slider.value + 0.5;
    int img = MIN((int)val, _variants.count);
    _slider.value = img;
    _answer.text = _variants[img];
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"p_%d_%d", _index, img]];
}

- (void) nextOne {
    if (_index == vcCount - 1) {
        FirstViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"fuck2"];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        SecondViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"fuck"];
        vc.index = _index + 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
