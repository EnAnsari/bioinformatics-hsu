# Hint page
### تنظیم دایرکتوری و خواندن دیتا
دستورات زیر `worked directory` ما را تنظیم میکند. بدیهی است که باید در `()setwd` آدرسی که پوشه فایل `r` در آن قرار دارد را بنویسید. توجه کنید که از اسلش `/` به جای بک اسلش `\` استفاده کنید.
```r
setwd("C:/DATA/uni/bio/bioinformatics-hsu/presentation/r")
isch <- read.delim("./isch.txt")
```
بعد از اجرای درستورات بالا باید دستورات زیر به خوبی کار کنند.
<details>
    <summary>
        <strong>دستورات تست کردن دیتا</strong>
    </summary>
خواندن 5 سطر اول

<div dir='ltr'>

```r
head(isch)
```
</div>

خواندن 5 سطر آخر

<div dir='ltr'>

```r
tail(isch)
```
</div>

خلاصه‌ای از آمار دیتا

<div dir='ltr'>

```r
summary(isch)
```
</div>

تعداد سطرها

<div dir='ltr'>

```r
dim(isch)
```
</div>

تعداد سطرهای بدون NA

<div dir='ltr'>

```r
dim(na.omit(isch))
```
</div>
</details>

### حذف سطرهای اضافه توضیحات
باید دستورات زیر را وارد کنیم:
<div dir='ltr'>

```r
colnames(isch)
isch <- isch[, c(1:5, 8, 9)]
summary(isch)
```
</div>
