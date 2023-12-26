# Hint page
در این صفحه آموزشی در رابطه با فایل `r` موجود در ارائه خواهیم دید.<br><br>
## تنظیم دایرکتوری و خواندن دیتا
دستورات زیر `worked directory` ما را تنظیم میکند. بدیهی است که باید در `()setwd` آدرسی که پوشه فایل `r` در آن قرار دارد را بنویسید. توجه کنید که از اسلش `/` به جای بک اسلش `\` استفاده کنید.
```r
setwd("C:/DATA/uni/bio/bioinformatics-hsu/presentation/r")
isch <- read.delim("./isch.txt")
```
بعد از اجرای درستورات بالا باید دستورات زیر به خوبی کار کنند.
<details dir='rtl'>
    <summary>
        <strong>دستورات تست کردن دیتا</strong>
    </summary>
    <br>
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
<div dir='rtl'>

## حذف سطرهای اضافه
با استفاده از دستور زیر سطرهای اضافی را پاک میکنیم:
<div dir='ltr'>

```r
isch <- na.omit(isch)
```
</div>

## حذف ستون‌های اضافه
با استفاده از دستور زیر نام ستون‌ها را می‌بینیم:
<div dir='ltr'>

```r
colnames(isch)
```
</div>

با استفاده از دستور زیر ستون‌های اضافی را پاک میکنیم (ستون‌های حذف شده دستی تولید شده بودند):
<div dir='ltr'>

```r
isch <- isch[, c(1:5, 8, 9)]
```
</div>

## ویژوالایز داده‌ها
برای ویژوالایز کردن میتوانیم از هیستوگرام استفاده کنیم. برای اینکار از تابع `hist` استفاده می‌کنیم. درون این تابع ابتدا نام دیتا را می‌نویسیم و بعد از `$` نام ستونی که هیستوگرام آن را میخواهیم را مینویسیم.
<div dir='ltr'>

```r
hist(isch$E)
```
</div>

البته اگر هیستوگرام `a` را بگیریم، متوجه خواهیم شد که داده پرت در این دیتا وجود دارد. با کد زیر متوجه خواهیم شد که چند داده بالای 10 وجود دارد.
<div dir='ltr'>

```r
sum(isch$a > 10)
```
</div>

با استفاده از دستور زیر داده‌هایی که `a` ی بالاتر از 0.2 دارند از داده‌ها حذف می‌شوند.
<div dir='ltr'>

```r
isch <- subset(isch, a < 0.2)
```
</div>
پس از این دستور داده تقریبا داده خوبی از لحاظ نمایش خواهد شد.

## نمایش بهتر داده‌ها
برای این بخش ما تنها نیاز به ۴ ستون از این داده داریم.

<div dir='ltr'>

```r
x <- isch[, 4:7]
```
</div>
اکنون نیاز داریم تا دو تا پکیج را به پروژه add کنیم، برای اینکار این دو خط را به ابتدای کد اضافه می‌کنیم:
<div dir='ltr'>

```r
library(ggplot2)
library(reshape2)
```
</div>
<strong>اگر از کد خود ران بگیریم میبینیم که ggplot2 به طور پیشفرض در RStudio وجود ندارد و باید بعد از پیام ارور گزینه install را بزنیم.</strong><br><br>

حالا باید دیتای خود را ذوب یا همان `melt` کنیم.
<div dir='ltr'>

```r
x.m <- melt(x)
```
</div>
در نهایت با دستور زیر یک نمایش باکس پلات از دیتای خود خواهیم داشت:
<div dir='ltr'>

```r
ggplot(x.m, aes(variable, value)) + geom_boxplot()
```
</div>

اگر نوع `geom_plot` را به `geom_violin` تغییر بدهیم میتوانیم فراوانی‌ها را در نمودار دقیق‌تر ببینیم
<div dir='ltr'>

```r
ggplot(x.m, aes(variable, value)) + geom_violin()
```
<div align='center'><img src='https://github.com/EnAnsari/bioinformatics-hsu/assets/109433485/7690c079-5749-4573-8eff-ba19f4dbcec4' alt='chart' width=500 align="center"></div>
</div><br>
اگر کد بالا را به صورت زیر تغییر دهیم نمودار قشنگ‌تری خواهیم داشت:
<div dir='ltr'>

```r
ggplot(x.m, aes(variable, value)) + geom_violin(width=1, aes(fill=variable)) + geom_boxplot(width=.05)
```
<div align='center'><img src='https://github.com/EnAnsari/bioinformatics-hsu/assets/109433485/d0a3359e-ad5d-4bd1-9c41-ac3c9131f46d' alt='chart' width=500 align="center"></div>
</div><br>
در انتها می‌خواهیم ویژوالایز را پس از اینکه به خوبی دیتا را شناختیم به سمتی ببریم که برای کلاسیفای مفید باشد
<br>
در اینجا ما می‌خواهیم کلاسیفای را بر اساس داده‌های ستون‌های A و E انجام دهیم:
<div dir='ltr'>

```r
ggplot(isch, aes(A, E, color=Ischemia)) + geom_point() + theme_bw()
```
</div>
<div align='center'><img src='https://github.com/EnAnsari/bioinformatics-hsu/assets/109433485/511b9b51-556d-459d-80e6-9441f2ad7f61' alt='chart' width=500 align="center"></div>

## کلاسیفای
در این بخش میخواهیم کلاسیفیکیشن را انجام دهیم. (یعنی نقاط قرمز و آبی یا همان ایسکمی مثبت و منفی را از هم جدا کنیم)
<br>
برای این کار ما از یک تابع خطی `y = (1.5)x - 0.5` استفاده کرده‌ایم.

<div dir='ltr'>

```r
classify <- function(x, y) if(1.5 * x - 0.3 > y) return("POS") else return("NEG")
```
</div>
حالا برای استفاده از این تابع تنها کافی است که آن را فرابخوانیم:
<div dir='ltr'>

```r
classify(1, 0.4)
```
</div>

جواب تست بالا `POS` خواهد بود
<hr>
اگر بخواهیم تابع ورودی وکتور هم دریافت کند باید به صورت زیر بازنویسی شود:
<div dir='ltr'>

```r
classify <- function(x, y) ifelse (1.5 * x - 0.3 > y ,"POS", "NEG")
```
</div>

جواب تست بالا `"POS" "NEG"` خواهد بود
<br><br>
حالا با استفاده از کد زیر کل نتیجه مثبت یا منفی بودن تمامی رکوردها را در یک ستون جدا به نام `pred` داریم:
<div dir='ltr'>

```r
isch$pred <- classify(isch$A, isch$E)
```
</div><hr><br>

حالا میخواهیم `Accuracy‍‍` را حساب کنیم. خروجی کد پایین `0.7695391` است که به معنای همان 76 درصد است.
<div dir='ltr'>

```r
sum(isch$Ischemia == isch$pred) / nrow(isch)
```
</div><hr><br>

برای محاسبه `sensitivity` کد زیر را داریم. خروجی `0.7589286` خواهد بود که به معنای 75 درصد است. `sensitivity` یعنی چند درصد از اونایی مثبت حدس زدیم واقعا مثبت بودند.
<div dir='ltr'>

```r
sum(isch$Ischemia == "POS" & isch$pred == "POS") / sum(isch$Ischemia == "POS")
```
</div><hr><br>

برای محاسبه `specifity` کد زیر را داریم (دقیقا به جای `POS` قرار می‌دهیم `NEG`). خروجی `0.7726098` خواهد بود که به معنای 77 درصد است. `specifity` یعنی چند درصد از اونایی منفی حدس زدیم واقعا منفی بودند.
<div dir='ltr'>

```r
sum(isch$Ischemia == "NEG" & isch$pred == "NEG") / sum(isch$Ischemia == "NEG")
```
</div>

## نمودار ROC
یکی از معیارهای خوب بودن learn ما نمودار ROC یا همان Receiver operating characteristic است. این نمودار وقتی به کار می‌آید که بخواهیم بر اساس مقادیر مختلف هایپر پارامتر رفتار سیستم را ارزیابی کنیم.
<br><br>
برای اینکار ابتدا دو تابع زیر را تعریف می‌کنیم. (دو خط آخر کد قبل را باید حذف کنیم)
<div dir='ltr'>

```r
classify <- function(x, y, Intercept) ifelse (1.5 * x - Intercept > y ,"POS", "NEG")

sen.spec <- function(Intercept) {
  pred = classify(isch$A, isch$E, Intercept)
  sen <- sum(isch$Ischemia == "POS" & pred == "POS") / sum(isch$Ischemia == "POS")
  spe <- sum(isch$Ischemia == "NEG" & pred == "NEG") / sum(isch$Ischemia == "NEG")
  c(sen, spe)
}
```
</div>
حالا به صورت زیر از آن استفاده می‌کنیم:
<div dir='ltr'>

```r
res <- sapply(seq(-2, 2, by=.01), sen.spec)
```
</div>

اگر `dim(res)` بگیریم، میبینیم که خروجی `2 401` خواهد بود. یعنی 2 سطر و 401 ستون. پس باید آن را بچرخانیم. با استفاده از کد زیر هم آن را میچرخانیم هم به دیتافریم تبدیل می‌کنیم:
<div dir='ltr'>

```r
res <- data.frame(t(res))
```
</div>
در نهایت با کد زیر نمودار آن را رسم می‌کنیم:
<div dir='ltr'>

```r
colnames(res) <- c("Sen", "Spe")
ggplot(res, aes(1 - Spe, Sen)) + geom_point()
```
</div>
<strong>هدف ما ماکسیمم کردن مساحت زیر نمودار یا همان دقت ما خواهد بود. آن را هم می‌توان ,حساب کرد.</strong>
</div>
