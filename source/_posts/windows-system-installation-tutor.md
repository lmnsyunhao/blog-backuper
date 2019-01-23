---
title: Windows10 系统安装教程 UEFI模式 Legacy模式
tags: [系统安装, Windows, UEFI, Legacy]
categories: [系统安装]
comments: true
mathjax: false
date: 2018-07-13 19:15:52
---
更换了SSD需要装windows系统？Windows10出问题了怎么办？总是蓝屏，重启电脑也解决不了，这种时候多半是系统某些地方坏了。如果自己不能够排查出来的话，就用某弛一句话，重装系统多半能解决问题。那么如何重装windows10呢？上维修点让别人给装？还得花不少钱，还不如自己装。本文教你如何装windows10系统。  

<!-- more -->

# 章节概述
如果不懂UEFI和Legacy的话，那么看设置UEFI模式、设置SATA Mode、安装Windows系统几节就OK。  
如果想要了解Legacy安装windows10的话，那么请看UEFI与Legacy区别，设置Legacy模式，安装windows系统几节。  

# 设置UEFI模式
如果你不懂UEFI和Legacy的话，那么就选用UEFI模式安装就好了。现在的电脑都支持UEFI，除非你的电脑很老很老。  
本文选用电脑Lenovo-Y50-70做为例子，其他的电脑装机都是大同小异，如果你不是这个电脑的话，也不要慌，本文会针对一般的电脑进行说明。  
首先需要准备windows系统盘一个，如何刻录系统盘？[刻录 Windows10 系统盘 UltraISO刻录法 与 官方工具法](/2018/07/11/burn-windows-installation-disk/)  
首先要百度你的电脑的BIOS如何进入，还有选择启动项界面如何进入。BIOS一般都是F2，选择启动项一般都是F12。对于不同的电脑，可能有的是按Fn+F2，Fn+F12，或是ESC，Enter键等等。这些请自行百度。具体电脑可能会有所不同。  
确保你的电脑正常关闭，并完成了备份。  
开机，狂按F2(或者是你查到的进入BIOS的按键)，进入BIOS。如果怎么也进入不了BIOS？[Windows10 PC 无法进入选择启动项界面 无法进入BIOS界面](/2018/05/23/windows-pc-cannot-select-boot-device/)  
下面就是进入了BIOS，电脑的BIOS一般都不一样。有的可能是这种底色的，还有的是别的底色的，还有更高级的BIOS等等。不过他们有的功能是类似的。界面上会有提示告诉你怎么移动菜单。找到如下这种`Boot Mode`类似的可以选择启动模式的地方，选项是UEFI、Lagacy等。然后选择UEFI模式，如果没有这种`Boot Mode`类似的，那么就找什么UEFI Enable，UEFI Mode，Launch CSM什么之类的，然后把UEFI打开。  
![BIOS#postpic/pica/windows-system-installation-tutor/1.png]()

# 设置SATA Mode
找到SATA Mode这个东西，选项一般有AHCI、RAID、Compatible等。  
![SATA Mode#postpic/pica/windows-system-installation-tutor/20.png]()
从图中右侧可以看到，一共有两种，一种是AHCI模式，一种是Compatible模式，Compatible模式中又叫IDE模式。实际上还有一种模式是RAID模式。  
这三种模式都是什么呢？来分别介绍一下。  
* IDE Mode就是让硬盘模拟老式的接口方式运行，这样可以对Windows XP兼容。  
* AHCI Mode是Serial ATA Advanced Host Controller Interface，串行ATA高级主控接口。这个模式能够稍微提高硬盘的性能。  
* RAID Mode是Redundant Array of Independent Disk，独立磁盘冗余阵列。学过操作系统的同学都知道这是个啥。最少两块硬盘才能组建RAID。  

装Windows10的时候，SATA Mode要设置为AHCI就行。  
有些工作站默认的SATA Mode设置为RAID，这样可能会出现Windows10安装完毕之后，容易导致进系统找不到引导，或是经常蓝屏什么的。我猜测是因为Windows10没有默认集成RAID的驱动程序。所以我在此强调一下。  
注意！！！如果已经成功安装了Windows10不要贸然更改这些设置。否则，系统容易崩。  
之后，保存设置并退出，这个也一般会有提示的，比如上图中，右下角，F10是保存并退出，如果没找到这种，找到Exit菜单，然后看看类似Exit and Save，Exit Saving Changes等等就行。  
保存并退出了BIOS之后，关机。如果能正常关机，就正常关机，如果不能正常关机就强制关机。重装系统过程中有些时候避免不了强制关机几次，不用太担心，硬件没那么脆弱。强制关机就是长按电源键直到关机。  

# 安装Windows系统
插入windows系统盘，选U盘做windows系统盘的时候别选太垃圾的U盘，容易出问题。质量得过得去。插入系统盘之后，开机。然后狂按F12，或者是别的能够进入选择启动项界面的按键。  
下面就是选择启动项界面，这个界面如果不相同也很正常，有的更优雅一些。一般这个界面都和BIOS的界面是配套的界面。第一个Windwos Boot Manager这个是我电脑里面现存的Windows的启动选项，后边括号里面那个是硬盘的编号。第二个，EFI USB Device(SanDisk)这个就是我们的系统盘的启动项。如果不一样的话，那么就找这几个关键词，带EFI，USB，然后括号里面的一般是U盘的品牌。然后还有一些别的启动项，比如图上这些，还有的有什么什么LAN等，那些都不是我们需要的。我们选择U盘的启动项，然后Enter进入。  
![选择启动项#postpic/pica/windows-system-installation-tutor/2.png]()
然后等一会儿，就会进入到我们的安装系统界面，界面很人性化，根据提示就能安装，我就简要说一下。下面这个界面一般都直接点下一步，默认的都对。点下一步  
![安装程序#postpic/pica/windows-system-installation-tutor/3.png]()
然后能看到下面这个界面，点击现在安装。  
![安装程序#postpic/pica/windows-system-installation-tutor/4.png]()
等一会儿，如下图：  
![安装程序正在启动#postpic/pica/windows-system-installation-tutor/5.png]()
出现下图，点击我没有产品密钥，
![激活Windows#postpic/pica/windows-system-installation-tutor/6.png]()
出现下图，让选择Windows安装版本。开发人员一般的装专业版就行，专业版有组策略，家庭版没有。如果只是用windows办公的话，家庭版就行。家庭单语言版，跟教育版我没用过，不敢尝试。有兴趣大家可以尝试一下。然后点击下一步  
![选择安装的版本#postpic/pica/windows-system-installation-tutor/7.png]()
然后点击接受协议，点击下一步。  
![接受协议#postpic/pica/windows-system-installation-tutor/8.png]()
然后出现下面，我一般选择自定义，点击自定义  
![自定义#postpic/pica/windows-system-installation-tutor/9.png]()
点击自定义，以后会看到这个分区界面。  
如果你是给电脑新换了SSD，然后重装系统。这个时候应该能看到SSD的盘，从驱动器数量和驱动器的大小可以看出，如果看不到SSD的盘。那么是安装程序不认SSD，这里给出两种方法，第一，关闭电脑，使用PE，将SSD格式化一下。然后再重新装系统。详见本文PE格式化磁盘一节。这种方法我自己试过；第二，网上说找不到SSD驱动器，是因为安装程序里面没有驱动程序，需要将驱动程序下载好，拷贝到U盘中，然后点击图中对话框左下角那个加载驱动程序，将驱动程序加载进来就好了。这种方法我没有试过  
下边的主分区就分别是C盘，D盘等等。上面的恢复分区是windows存储恢复程序。系统分区是efi分区，存储启动程序的。MSR分区是微软预留分区。  
![分区#postpic/pica/windows-system-installation-tutor/10.png]()
现在要删除分区。如果你某个盘里面的东西不想删的话，那么就留着那个分区不删除就好了。反正我觉得，装一次系统挺不容易的，所以我一般所有分区都删除，然后重新分区。所以讲这个表儿里面的所有的都删除，选中某一个分区，然后点击下边儿删除，然后确定删除。全都删除之后，会变成一个`未分配的空间`。  
![删除分区#postpic/pica/windows-system-installation-tutor/11.png]()
这个时候就可以重新分区了，先分C盘，我一般都分120个G以上，因为C盘会越用越小，所以习惯分大一点儿，如果不想太大，最小得60个G吧，要不然就太小了。注意如果磁盘多余一个的话，别分错了磁盘。点击未分配的空间，然后点击新建，然后输入大小，1024M=1G，然后点击应用。  
![分区#postpic/pica/windows-system-installation-tutor/12.png]()
这个时候应该会弹框提示，然后点击确定。如下：  
![提示#postpic/pica/windows-system-installation-tutor/13.png]()
点击确定之后，等一会儿，会出现下面这样，会自动建立恢复分区，系统分区，和保留分区。  
![分好之后#postpic/pica/windows-system-installation-tutor/14.png]()
然后，可以继续按照上面的分区方式，将剩下的未分配空间分配。再继续新建的时候，就不会产生恢复分区，系统分区，保留分区了。这三个只有在没有的时候出现。当然，如果你这个时候不想继续分配的话，也可以安装完系统之后再分配。详见[Windows10 磁盘管理工具 分区管理 创建分区](/2018/07/13/windows-disk-manager-partition/)  
等重新分区之后，鼠标点击你想要将系统装入的分区。然后再点下一步，也就是说你需要将C盘选中，然后点击下一步，如下图：  
![选中C盘#postpic/pica/windows-system-installation-tutor/15.png]()
然后就开始安装了，等一会儿，如下图：  
![安装中#postpic/pica/windows-system-installation-tutor/16.png]()
等安装结束之后会读条，这个时候就要准备拔U盘了，等到读条结束之后，屏幕完全暗下来的一瞬间，拔出U盘，不然就重启了。读条界面如下：  
![读条#postpic/pica/windows-system-installation-tutor/17.png]()
然后电脑应该就自动重启了，成功的话，就已经进入windows了，然后进入windows之后会有检查设备，准备啊，然后让你设置用户名什么的，那个就不说了。  

# UEFI与Legacy区别
UEFI Bios启动模式可以支持两种启动模式，即是Legacy+UEFI启动模式和UEFI启动模式，当中Legacy+UEFI启动模式说的是UEFI和传统BIOS两者共存模式，此种模式还能兼容传统BIOS引导模式以此来启动电脑系统；而UEFI启动模式则只能在UEFI引导模式来启动电脑系统。  
![启动区别#postpic/pica/windows-system-installation-tutor/23.png]()
BIOS是英文"Basic Input Output System"的缩略词，直译过来后中文名称就是"基本输入输出系统"。UEFI全称“统一的可扩展固件接口”(Unified Extensible Firmware Interface)，是一种详细描述类型接口的标准。上图是两者启动时候工作的区别，UEFI相比传统BIOS少了自检这一步，所以快了许多。简单的讲，UEFI比传统的BIOS要快，更优秀。现在大多数电脑都支持UEFI了，传统BIOS，即Legacy快被淘汰了。  
你们可能现在还在混乱，Legacy、Legacy BIOS、UEFI、UEFI BIOS、BIOS、传统BIOS这些到底有几种启动模式？我是这么区分的，带UEFI四个字的表明是UEFI启动模式，不带UEFI的就是传统的启动模式。所以现在说了半天，一共只有两种启动模式。只不过这两种启动模式有好多种通俗的叫法。  

# Legacy模式安装
如果需要Legacy模式安装的话，那么我们需要在BIOS里面打开Legacy。首先将计算机关闭，然后开机，狂按F2(或者是其他能够进入BIOS的按键，不同电脑可能不一样，自行百度)，进入BIOS。如果进不了BIOS？[Windows10 PC 无法进入选择启动项界面 无法进入BIOS界面](/2018/05/23/windows-pc-cannot-select-boot-device/)  
进入了BIOS之后，看到下面的画面，正如我们上面说的，不同的电脑BIOS的颜色，选项的位置都不一样，所以我只是拿下面这个做个例子。界面上会有提示告诉你怎么移动菜单。找到如下这种`Boot Mode`类似的可以选择启动模式的地方，选项是UEFI、Lagacy等。然后选择Legacy Support模式，如果没有这种`Boot Mode`类似的，那么就找什么Legacy Enable，Legacy Mode，Legacy Support，Launch CSM什么之类的，然后把Legacy支持打开。  
打开了Legacy以后，电脑现在能够进入UEFI的，也能够进入Legacy的。  
![添加Legacy支持#postpic/pica/windows-system-installation-tutor/18.png]()
之后，保存设置并退出，这个也一般会有提示的，比如上图中，右下角，F10是保存并退出，如果没找到这种，找到Exit菜单，然后看看类似Exit and Save，Exit Saving Changes等等就行。  
现在电脑是关闭状态，然后插入U盘，开机，狂按F12(或者是其他能够进入选择启动项界面的按键，不同电脑不一样，自行百度)。如果进不去？[Windows10 PC 无法进入选择启动项界面 无法进入BIOS界面](/2018/05/23/windows-pc-cannot-select-boot-device/)  
下图就是选择启动项界面。我们可以对比只开启UEFI时候的选择启动项界面(就在上边儿，自己看下)，多了几项。前两个是Legacy模式的启动项，后两个是UEFI模式的启动项。中间那个莫名其妙不用管。我们选择第二个，USB HDD这个就是我们的Windows系统盘的Legacy模式安装的启动项。  
![选择启动项#postpic/pica/windows-system-installation-tutor/21.png]()
等一会儿然后进入下面这个界面了。细心的我们可以发现，这个界面相比UEFI模式启动的时候区别是，这个对话框有横向拉伸的迹象。  
![Legacy模式安装#postpic/pica/windows-system-installation-tutor/22.png]()
到这个界面之后，就和上边儿的安装一样了，就不多说了。  

# PE格式化SSD
首先你得有一个WinPE的盘。WinPE是什么？如何制作？[U启动 制作WinPE启动盘 支持UEFI启动](/2018/07/13/burn-windows-preinstallation-environment-disk/)  
然后确保你的电脑正常关闭，并能够进入BIOS，选择启动项界面，如果不知道按哪个按键，一般BIOS是F2，选择启动项是F12，也有Fn+F2和Fn+F12等等，ESC和Enter都有，具体是哪个按键请自行百度。  
插入WinPE盘，按下开机按钮后，就狂按F12(能进入选择启动项的界面的按键)，进入选择启动项界面。如果怎么按都进入不了？[Windows10 PC 无法进入选择启动项界面 无法进入BIOS界面](/2018/05/23/windows-pc-cannot-select-boot-device/)  
然后会到选择启动项界面。这个界面上，Windows Boot Manager是我电脑上现存的windows10的启动项，括号里的是磁盘的编号，EFI USB Device这个就是WinPE了，括号里是我U盘的牌子，我们上下键移动选中EFI USB Device，然后Enter键进入PE。  
![选择启动项#postpic/pica/windows-system-installation-tutor/2.png]()
然后等待一会儿，会有读条什么的，等到进入下图这个界面，说明成功进入了PE。  
![选择启动项#postpic/pica/windows-system-installation-tutor/19.png]()
然后用PE里面自带的磁盘管理工具，新建一个分区，格式化一下SSD磁盘，NTFS格式。我现在没有SSD，所以没办法拍照，所以，就意会一下，等以后有了再修改博文。  