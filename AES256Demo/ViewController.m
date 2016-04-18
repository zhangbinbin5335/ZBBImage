//
//  ViewController.m
//  AES256Demo
//
//  Created by zhangbinbin on 16/4/11.
//  Copyright © 2016年 zhangbinbin. All rights reserved.
//

#import "ViewController.h"
#import "NSData+AES256.h"
#import "TestView.h"
#import "UIImage+Round.h"

#define Emoji_Key @"20160411zbbYinnut@#$!*#&@^"
#define Max_Scale(width,height) MAX(width / 60 * 1., height / 60 * 1.)

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
//    
//    NSFileManager* fm = [NSFileManager defaultManager];
//    NSArray* arr = [fm contentsOfDirectoryAtURL:[NSURL URLWithString:@"/Users/zhangbinbin/Library/Developer/CoreSimulator/Devices/DBB8C65C-6A71-4377-9B79-CCCDF29785B0/data/Containers/Data/Application/59622987-9035-40F1-8A72-E6829E34CE94/Documents/defaultEmoji/Activity"] includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
//    
//    NSLog(@"%@",arr[0]);
//    
//    NSURL* url = arr[0];
//    NSData* data = [NSData dataWithContentsOfURL:url];
//    self.imageView.image = [UIImage imageWithData:data];
    
    self.imageView.image = [UIImage createRoundedRectImage:[UIImage imageNamed:@"0"] size:CGSizeMake(40, 40) radius:10];
    self.imageView2.image = [UIImage createRoundedRectImage:[UIImage imageNamed:@"0"] size:CGSizeMake(186, 186) radius:10 margin:10];
    self.imageView.image = [self combineImage:[UIImage imageNamed:@"DGAJIQTLLIQROVFAWTXWGHYOHCNLDUTT"]
                                  secondImage:[UIImage imageNamed:@"PCMKYHCOMNZORSPELVXMRAAMMZSMTGVC.JPG"]
                                   thirdImage:[UIImage imageNamed:@"PFGKHKYSSLHPPVSVJTCXSUZNQYTMPFNHZPYSACRJBEXBBLGFHSXKQIESXLHXHJNV.JPG"]];
}

- (IBAction)write:(id)sender
{
    NSData* jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"config" ofType:@"json"]];//表情信息文件
    
    NSData* aesData = [jsonData AES256EncryptWithKey:Emoji_Key];
    
    [aesData writeToFile:[NSString stringWithFormat:@"%@/emojiGroup.json",@"/Users/zhangbinbin/Desktop"] atomically:YES];
}
- (IBAction)read:(id)sender
{
    NSData* aesData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/emojiGroup.json",@"/Users/zhangbinbin/Desktop"]];
    
    NSData* jsonData = [aesData AES256DecryptWithKey:Emoji_Key];//表情信息文件
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"dic = %@",dic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)combineImage:(UIImage*)image secondImage:(UIImage*)secondImage thirdImage:(UIImage*)thirdImage
{
    UIImage *tmp = image;
    //
    //  //TODO: 不可配置，需要重写
    CGSize singleSize;
    singleSize.height = 60;
    singleSize.width =  60;
    
    CGFloat first_scale = Max_Scale(image.size.width,image.size.height);
    CGFloat sec_scale = Max_Scale(secondImage.size.width, secondImage.size.height);
    CGFloat thir_scale = Max_Scale(thirdImage.size.width, thirdImage.size.height);
    
    CGFloat scale = MAX(MAX(first_scale, sec_scale),thir_scale);
    
    UIGraphicsBeginImageContextWithOptions(singleSize, YES, scale);
//    UIGraphicsBeginImageContext(singleSize);
    {
        CGFloat leftWidth = (60 - 1) * 2 / 3. ;
        CGFloat rightWidth = (60 - 1) * 1 / 3. ;
        
        CGRect firstRect = CGRectMake(0, 0, leftWidth, 60);
        [[self scaleToFixSize:image size:firstRect.size]  drawInRect:firstRect];
        
        CGRect secondRect = CGRectMake(CGRectGetMaxX(firstRect) + 1, 0, rightWidth, (60 - 1) / 2.);
        [[self scaleToFixSize:secondImage size:firstRect.size] drawInRect:secondRect];
        
        CGRect thirdRect = CGRectMake(secondRect.origin.x, CGRectGetMaxY(secondRect) + 1, secondRect.size.width, secondRect.size.height);
        [[self scaleToFixSize:thirdImage size:firstRect.size] drawInRect:thirdRect];
        tmp = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return tmp;
}

-(UIImage *)scaleToFixSize:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, YES, MAX(img.size.width / size.width * 1., img.size.height / size.height * 1.));
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end
