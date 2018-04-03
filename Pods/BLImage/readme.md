pod "BLImage"

使用本地图片：

```
UIImageView *imageView = [[UIImageView alloc] init];
imageView.image = [BLImage imageNamed:@"webpimagename"];
```

使用远程图片

```
UIImageView *imageView = [[UIImageView alloc] init];
[imageView bl_setImageWithUrl:[NSURL URLWithString:@"https://casatwy.com/webp.webp"] animated:YES];
```

![screenshot](screenshot/screenshot.gif)
