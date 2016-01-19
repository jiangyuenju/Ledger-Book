# Ledger-Book
一个用来记账的iOS应用<br>
## 功能
    本应用实现了记账的功能。
    应用共有四个界面：
    第一个界面显示用户的整体收支状况；
    第二个界面实现让用户增加一笔账单，包括金额、类型等；
    第三个界面是以饼状图的形式将用户的收支按类别显示出来；
    第四个界面是可以扫描条形码或二维码，自动加入账单，请在网络环境下使用，并只有50次试用机会
    使用LedgerBook.xcworkspace文件启动项目
    
##进展
    实现了包含有四个界面的Tab Controller
    实现了第二个界面的金额输入和类型选择
    实现了将第一个界面截图并保存到相册的功能
    实现了用自定义图片替换tab bar item
    实现了文本框输入结束后隐藏键盘的功能
    实现了用segmented control控制界面变换的功能
    实现第一个界面以时间轴显示已有的账单，并改进截图功能，将整个scrollview截图
    实现第一个界面中的微信分享功能
    第二个界面功能完全实现
    实现第三个界面将收支情况按饼图显示
    第四个界面的扫一扫可以扫描二维码和条形码，二维码输出码内连接，条形码的处理使用聚合数据的条码SDK，SDK库中若有该条形码，自动跳到第二个界面并填充金额和备注
    
## 截图
界面一以时间轴形式展示用户的收支情况，点击左上角按钮可以截图或分享到微信<br>
![](https://github.com/jiangyuenju/Ledger-Book/blob/master/LedgerBook/image/screenshot1.jpg)<br>
界面三以饼状图的形式将用户的收支按类别显示出来；<br>
![](https://github.com/jiangyuenju/Ledger-Book/blob/master/LedgerBook/image/screenshot2.jpg)<br>
界面四可以扫描条形码，并自动识别，将商品信息加入到账单中<br>
![](https://github.com/jiangyuenju/Ledger-Book/blob/master/LedgerBook/image/screenshot4.jpg)<br>
![](https://github.com/jiangyuenju/Ledger-Book/blob/master/LedgerBook/image/screenshot5.jpg)<br>
界面四也可扫描二维码，只显示网址<br>
![](https://github.com/jiangyuenju/Ledger-Book/blob/master/LedgerBook/image/screenshot3.jpg)<br>

    
##负责人
    潘秋红：131220151
    江悦：131220142
