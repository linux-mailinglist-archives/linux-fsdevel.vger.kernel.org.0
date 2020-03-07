Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F317CEF2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgCGPON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 10:14:13 -0500
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:35244 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbgCGPOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 10:14:12 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3BD404DD0;
        Sat,  7 Mar 2020 15:14:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:69:152:230:355:379:599:857:960:966:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1431:1434:1437:1461:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1981:2194:2196:2198:2199:2200:2201:2393:2525:2568:2682:2685:2693:2731:2734:2743:2859:2894:2897:2901:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3149:3167:3168:3173:3622:3770:3865:3867:3868:3870:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4039:4043:4250:4321:4384:4385:4395:4559:4659:5007:6678:7514:7688:7875:7903:7904:7974:8568:8599:8784:8957:8987:9010:9025:9038:9072:9149:9207:9388:9545:9592:10004:10030:10049:10848:11026:11232:11256:11257:11657:11896:11914:12043:12063:12291:12297:12438:12555:12683:12712:12737:12740:12764:12776:12895:12903:13846:13894:14096:14097:14106:14651:14659:14877:18000:21060:21080:21107:21325:21433:21451:21611:21617:21691:21740:21773:21774:30017:30034:30054:30055:30056:30064:30070:30090:30091,
X-HE-Tag: self72_66569836913a
X-Filterd-Recvd-Size: 92677
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Mar 2020 15:14:03 +0000 (UTC)
Message-ID: <0d5503e1d864f2588e756ae590ff8935e11bf9d6.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 07 Mar 2020 07:12:26 -0800
In-Reply-To: <20200307110154.719572e4@onda.lan>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
         <20200304131035.731a3947@lwn.net>
         <alpine.DEB.2.21.2003042145340.2698@felia>
         <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
         <alpine.DEB.2.21.2003062214500.5521@felia>
         <20200307110154.719572e4@onda.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-03-07 at 11:01 +0100, Mauro Carvalho Chehab wrote:
> Talking about problems at MAINTAINERS file, while the entries are
> supposed to be in alphabetical order, there are some things at the
> wrong place there.
> 
> This can easily seen with:
> 
> 	$ cat MAINTAINERS |grep -E '^[A-Z][A-Z]' >a;sort -f a >b;diff -U1 a b|less
> 
> See for example the first hunk:
> 
> @@ -54,3 +54,2 @@
>  ALACRITECH GIGABIT ETHERNET DRIVER
> -FORCEDETH GIGABIT ETHERNET DRIVER
>  ALCATEL SPEEDTOUCH USB DRIVER

People are really bad at alphabetizing...

This could also be fixed by using Linus' original
script.

$ git checkout 7683e9e529258d01ce99216ad3be21f59eff83ec -- scripts/parse-maintainers.pl
$ perl ./scripts/parse-maintainers.pl < MAINTAINERS > MAINTAINERS.new
$ mv MAINTAINERS.new MAINTAINERS
$ git checkout HEAD -- scripts/parse-maintainers.pl

This currently produces this -next diff:
---
 MAINTAINERS | 1584 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 792 insertions(+), 792 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c555f4..5846e94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -184,6 +184,23 @@ L:	linux-hams@vger.kernel.org
 S:	Maintained
 F:	drivers/net/hamradio/6pack.c
 
+802.11 (including CFG80211/NL80211)
+M:	Johannes Berg <johannes@sipsolutions.net>
+L:	linux-wireless@vger.kernel.org
+W:	http://wireless.kernel.org/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
+S:	Maintained
+F:	net/wireless/
+F:	include/uapi/linux/nl80211.h
+F:	include/linux/ieee80211.h
+F:	include/net/wext.h
+F:	include/net/cfg80211.h
+F:	include/net/iw_handler.h
+F:	include/net/ieee80211_radiotap.h
+F:	Documentation/driver-api/80211/cfg80211.rst
+F:	Documentation/networking/regulatory.txt
+
 8169 10/100/1000 GIGABIT ETHERNET DRIVER
 M:	Realtek linux nic maintainers <nic_swsd@realtek.com>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
@@ -647,13 +664,6 @@ M:	Lino Sanfilippo <LinoSanfilippo@gmx.de>
 S:	Maintained
 F:	drivers/net/ethernet/alacritech/*
 
-FORCEDETH GIGABIT ETHERNET DRIVER
-M:	Rain River <rain.1986.08.12@gmail.com>
-M:	Zhu Yanjun <zyjzyj2000@gmail.com>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	drivers/net/ethernet/nvidia/*
-
 ALCATEL SPEEDTOUCH USB DRIVER
 M:	Duncan Sands <duncan.sands@free.fr>
 L:	linux-usb@vger.kernel.org
@@ -689,6 +699,14 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/media/allegro-dvt/
 
+Allwinner A10 CSI driver
+M:	Maxime Ripard <mripard@kernel.org>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+F:	drivers/media/platform/sunxi/sun4i-csi/
+F:	Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
+S:	Maintained
+
 ALLWINNER CPUFREQ DRIVER
 M:	Yangtao Li <tiny.windzz@gmail.com>
 L:	linux-pm@vger.kernel.org
@@ -779,6 +797,12 @@ F:	drivers/tty/serial/altera_jtaguart.c
 F:	include/linux/altera_uart.h
 F:	include/linux/altera_jtaguart.h
 
+AMAZON ANNAPURNA LABS FIC DRIVER
+M:	Talel Shenhar <talel@amazon.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
+F:	drivers/irqchip/irq-al-fic.c
+
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
@@ -1274,6 +1298,12 @@ F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
 
+ARM HDLCD DRM DRIVER
+M:	Liviu Dudau <liviu.dudau@arm.com>
+S:	Supported
+F:	drivers/gpu/drm/arm/hdlcd_*
+F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
+
 ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -1298,12 +1328,6 @@ F:	drivers/mtd/maps/physmap_of_versatile.c
 F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
-ARM HDLCD DRM DRIVER
-M:	Liviu Dudau <liviu.dudau@arm.com>
-S:	Supported
-F:	drivers/gpu/drm/arm/hdlcd_*
-F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
-
 ARM KOMEDA DRM-KMS DRIVER
 M:	James (Qian) Wang <james.qian.wang@arm.com>
 M:	Liviu Dudau <liviu.dudau@arm.com>
@@ -1316,16 +1340,6 @@ F:	drivers/gpu/drm/arm/display/komeda/
 F:	Documentation/devicetree/bindings/display/arm,komeda.txt
 F:	Documentation/gpu/komeda-kms.rst
 
-ARM MALI-DP DRM DRIVER
-M:	Liviu Dudau <liviu.dudau@arm.com>
-M:	Brian Starkey <brian.starkey@arm.com>
-L:	Mali DP Maintainers <malidp@foss.arm.com>
-S:	Supported
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	drivers/gpu/drm/arm/
-F:	Documentation/devicetree/bindings/display/arm,malidp.txt
-F:	Documentation/gpu/afbc.rst
-
 ARM MALI PANFROST DRM DRIVER
 M:	Rob Herring <robh@kernel.org>
 M:	Tomeu Vizoso <tomeu.vizoso@collabora.com>
@@ -1337,6 +1351,16 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/panfrost/
 F:	include/uapi/drm/panfrost_drm.h
 
+ARM MALI-DP DRM DRIVER
+M:	Liviu Dudau <liviu.dudau@arm.com>
+M:	Brian Starkey <brian.starkey@arm.com>
+L:	Mali DP Maintainers <malidp@foss.arm.com>
+S:	Supported
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	drivers/gpu/drm/arm/
+F:	Documentation/devicetree/bindings/display/arm,malidp.txt
+F:	Documentation/gpu/afbc.rst
+
 ARM MFM AND FLOPPY DRIVERS
 M:	Ian Molton <spyro@f2s.com>
 S:	Maintained
@@ -1415,12 +1439,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
 F:	drivers/irqchip/irq-vic.c
 
-AMAZON ANNAPURNA LABS FIC DRIVER
-M:	Talel Shenhar <talel@amazon.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
-F:	drivers/irqchip/irq-al-fic.c
-
 ARM SMMU DRIVERS
 M:	Will Deacon <will@kernel.org>
 R:	Robin Murphy <robin.murphy@arm.com>
@@ -1498,14 +1516,6 @@ F:	drivers/pinctrl/sunxi/
 F:	drivers/soc/sunxi/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
 
-Allwinner A10 CSI driver
-M:	Maxime Ripard <mripard@kernel.org>
-L:	linux-media@vger.kernel.org
-T:	git git://linuxtv.org/media_tree.git
-F:	drivers/media/platform/sunxi/sun4i-csi/
-F:	Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
-S:	Maintained
-
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <narmstrong@baylibre.com>
 M:	Jerome Brunet <jbrunet@baylibre.com>
@@ -1516,21 +1526,6 @@ F:	include/dt-bindings/clock/meson*
 F:	include/dt-bindings/clock/gxbb*
 F:	Documentation/devicetree/bindings/clock/amlogic*
 
-ARM/Amlogic Meson SoC support
-M:	Kevin Hilman <khilman@baylibre.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-amlogic@lists.infradead.org
-W:	http://linux-meson.com/
-S:	Maintained
-F:	arch/arm/mach-meson/
-F:	arch/arm/boot/dts/meson*
-F:	arch/arm64/boot/dts/amlogic/
-F:	drivers/pinctrl/meson/
-F:	drivers/mmc/host/meson*
-F:	drivers/soc/amlogic/
-F:	drivers/rtc/rtc-meson*
-N:	meson
-
 ARM/Amlogic Meson SoC Crypto Drivers
 M:	Corentin Labbe <clabbe@baylibre.com>
 L:	linux-crypto@vger.kernel.org
@@ -1546,6 +1541,21 @@ S:	Maintained
 F:	sound/soc/meson/
 F:	Documentation/devicetree/bindings/sound/amlogic*
 
+ARM/Amlogic Meson SoC support
+M:	Kevin Hilman <khilman@baylibre.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-amlogic@lists.infradead.org
+W:	http://linux-meson.com/
+S:	Maintained
+F:	arch/arm/mach-meson/
+F:	arch/arm/boot/dts/meson*
+F:	arch/arm64/boot/dts/amlogic/
+F:	drivers/pinctrl/meson/
+F:	drivers/mmc/host/meson*
+F:	drivers/soc/amlogic/
+F:	drivers/rtc/rtc-meson*
+N:	meson
+
 ARM/Annapurna Labs ALPINE ARCHITECTURE
 M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
 M:	Antoine Tenart <antoine.tenart@bootlin.com>
@@ -1789,6 +1799,16 @@ N:	imx
 N:	mxs
 X:	drivers/media/i2c/
 
+ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE
+M:	Shawn Guo <shawnguo@kernel.org>
+M:	Li Yang <leoyang.li@nxp.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
+F:	arch/arm/boot/dts/ls1021a*
+F:	arch/arm64/boot/dts/freescale/fsl-*
+F:	arch/arm64/boot/dts/freescale/qoriq-*
+
 ARM/FREESCALE VYBRID ARM ARCHITECTURE
 M:	Shawn Guo <shawnguo@kernel.org>
 M:	Sascha Hauer <s.hauer@pengutronix.de>
@@ -1800,16 +1820,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
 F:	arch/arm/mach-imx/*vf610*
 F:	arch/arm/boot/dts/vf*
 
-ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE
-M:	Shawn Guo <shawnguo@kernel.org>
-M:	Li Yang <leoyang.li@nxp.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
-F:	arch/arm/boot/dts/ls1021a*
-F:	arch/arm64/boot/dts/freescale/fsl-*
-F:	arch/arm64/boot/dts/freescale/qoriq-*
-
 ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2500,16 +2510,6 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/memory/*emif*
 
-ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
-M:	Tero Kristo <t-kristo@ti.com>
-M:	Nishanth Menon <nm@ti.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	Documentation/devicetree/bindings/arm/ti/k3.txt
-F:	arch/arm64/boot/dts/ti/Makefile
-F:	arch/arm64/boot/dts/ti/k3-*
-F:	include/dt-bindings/pinctrl/k3.h
-
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2537,6 +2537,16 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/power/reset/keystone-reset.c
 
+ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
+M:	Tero Kristo <t-kristo@ti.com>
+M:	Nishanth Menon <nm@ti.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+F:	arch/arm64/boot/dts/ti/Makefile
+F:	arch/arm64/boot/dts/ti/k3-*
+F:	include/dt-bindings/pinctrl/k3.h
+
 ARM/THECUS N2100 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2572,13 +2582,6 @@ F:	drivers/reset/reset-uniphier.c
 F:	drivers/tty/serial/8250/8250_uniphier.c
 N:	uniphier
 
-Ux500 CLOCK DRIVERS
-M:	Ulf Hansson <ulf.hansson@linaro.org>
-L:	linux-clk@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	drivers/clk/ux500/
-
 ARM/VERSATILE EXPRESS PLATFORM
 M:	Liviu Dudau <liviu.dudau@arm.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
@@ -3291,19 +3294,6 @@ S:	Supported
 F:	drivers/net/dsa/b53/*
 F:	include/linux/platform_data/b53.h
 
-BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
-M:	Florian Fainelli <f.fainelli@gmail.com>
-M:	Ray Jui <rjui@broadcom.com>
-M:	Scott Branden <sbranden@broadcom.com>
-M:	bcm-kernel-feedback-list@broadcom.com
-T:	git git://github.com/broadcom/mach-bcm
-S:	Maintained
-N:	bcm281*
-N:	bcm113*
-N:	bcm216*
-N:	kona
-F:	arch/arm/mach-bcm/
-
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
 M:	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
 L:	bcm-kernel-feedback-list@broadcom.com
@@ -3317,6 +3307,19 @@ F:	drivers/staging/vc04_services
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 
+BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
+M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Ray Jui <rjui@broadcom.com>
+M:	Scott Branden <sbranden@broadcom.com>
+M:	bcm-kernel-feedback-list@broadcom.com
+T:	git git://github.com/broadcom/mach-bcm
+S:	Maintained
+N:	bcm281*
+N:	bcm113*
+N:	bcm216*
+N:	kona
+F:	arch/arm/mach-bcm/
+
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
@@ -3533,6 +3536,15 @@ S:	Maintained
 F:	drivers/bcma/
 F:	include/linux/bcma/
 
+BROADCOM SPI DRIVER
+M:	Kamal Dasu <kdasu.kdev@gmail.com>
+M:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
+F:	drivers/spi/spi-bcm-qspi.*
+F:	drivers/spi/spi-brcmstb-qspi.c
+F:	drivers/spi/spi-iproc-qspi.c
+
 BROADCOM STB AVS CPUFREQ DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
 M:	bcm-kernel-feedback-list@broadcom.com
@@ -3549,14 +3561,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 F:	drivers/thermal/broadcom/brcmstb*
 
-BROADCOM STB NAND FLASH DRIVER
-M:	Brian Norris <computersforpeace@gmail.com>
-M:	Kamal Dasu <kdasu.kdev@gmail.com>
-L:	linux-mtd@lists.infradead.org
-L:	bcm-kernel-feedback-list@broadcom.com
-S:	Maintained
-F:	drivers/mtd/nand/raw/brcmnand/
-
 BROADCOM STB DPFE DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
 M:	bcm-kernel-feedback-list@broadcom.com
@@ -3565,14 +3569,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.txt
 F:	drivers/memory/brcmstb_dpfe.c
 
-BROADCOM SPI DRIVER
+BROADCOM STB NAND FLASH DRIVER
+M:	Brian Norris <computersforpeace@gmail.com>
 M:	Kamal Dasu <kdasu.kdev@gmail.com>
-M:	bcm-kernel-feedback-list@broadcom.com
+L:	linux-mtd@lists.infradead.org
+L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
-F:	drivers/spi/spi-bcm-qspi.*
-F:	drivers/spi/spi-brcmstb-qspi.c
-F:	drivers/spi/spi-iproc-qspi.c
+F:	drivers/mtd/nand/raw/brcmnand/
 
 BROADCOM SYSTEMPORT ETHERNET DRIVER
 M:	Florian Fainelli <f.fainelli@gmail.com>
@@ -3957,23 +3960,6 @@ S:	Maintained
 F:	drivers/auxdisplay/cfag12864bfb.c
 F:	include/linux/cfag12864b.h
 
-802.11 (including CFG80211/NL80211)
-M:	Johannes Berg <johannes@sipsolutions.net>
-L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
-S:	Maintained
-F:	net/wireless/
-F:	include/uapi/linux/nl80211.h
-F:	include/linux/ieee80211.h
-F:	include/net/wext.h
-F:	include/net/cfg80211.h
-F:	include/net/iw_handler.h
-F:	include/net/ieee80211_radiotap.h
-F:	Documentation/driver-api/80211/cfg80211.rst
-F:	Documentation/networking/regulatory.txt
-
 CHAR and MISC DRIVERS
 M:	Arnd Bergmann <arnd@arndb.de>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
@@ -4023,6 +4009,14 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 F:	drivers/platform/chrome/
 
+CHROMEOS EC CODEC DRIVER
+M:	Cheng-Yi Chiang <cychiang@chromium.org>
+S:	Maintained
+R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
+R:	Guenter Roeck <groeck@chromium.org>
+F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
+F:	sound/soc/codecs/cros_ec_codec.*
+
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
@@ -4032,14 +4026,6 @@ N:	cros_ec
 N:	cros-ec
 F:	drivers/power/supply/cros_usbpd-charger.c
 
-CHROMEOS EC CODEC DRIVER
-M:	Cheng-Yi Chiang <cychiang@chromium.org>
-S:	Maintained
-R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
-R:	Guenter Roeck <groeck@chromium.org>
-F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
-F:	sound/soc/codecs/cros_ec_codec.*
-
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
@@ -4075,35 +4061,6 @@ F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
 F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
 F:	Documentation/hwmon/lochnagar.rst
 
-CISCO FCOE HBA DRIVER
-M:	Satish Kharat <satishkh@cisco.com>
-M:	Sesidhar Baddela <sebaddel@cisco.com>
-M:	Karan Tilak Kumar <kartilak@cisco.com>
-L:	linux-scsi@vger.kernel.org
-S:	Supported
-F:	drivers/scsi/fnic/
-
-CISCO SCSI HBA DRIVER
-M:	Karan Tilak Kumar <kartilak@cisco.com>
-M:	Sesidhar Baddela <sebaddel@cisco.com>
-L:	linux-scsi@vger.kernel.org
-S:	Supported
-F:	drivers/scsi/snic/
-
-CISCO VIC ETHERNET NIC DRIVER
-M:	Christian Benvenuti <benve@cisco.com>
-M:	Govindarajulu Varadarajan <_govind@gmx.com>
-M:	Parvi Kaustubhi <pkaustub@cisco.com>
-S:	Supported
-F:	drivers/net/ethernet/cisco/enic/
-
-CISCO VIC LOW LATENCY NIC DRIVER
-M:	Christian Benvenuti <benve@cisco.com>
-M:	Nelson Escobar <neescoba@cisco.com>
-M:	Parvi Kaustubhi <pkaustub@cisco.com>
-S:	Supported
-F:	drivers/infiniband/hw/usnic/
-
 CIRRUS LOGIC MADERA CODEC DRIVERS
 M:	Charles Keepax <ckeepax@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
@@ -4127,6 +4084,35 @@ F:	drivers/pinctrl/cirrus/*
 F:	sound/soc/codecs/cs47l*
 F:	sound/soc/codecs/madera*
 
+CISCO FCOE HBA DRIVER
+M:	Satish Kharat <satishkh@cisco.com>
+M:	Sesidhar Baddela <sebaddel@cisco.com>
+M:	Karan Tilak Kumar <kartilak@cisco.com>
+L:	linux-scsi@vger.kernel.org
+S:	Supported
+F:	drivers/scsi/fnic/
+
+CISCO SCSI HBA DRIVER
+M:	Karan Tilak Kumar <kartilak@cisco.com>
+M:	Sesidhar Baddela <sebaddel@cisco.com>
+L:	linux-scsi@vger.kernel.org
+S:	Supported
+F:	drivers/scsi/snic/
+
+CISCO VIC ETHERNET NIC DRIVER
+M:	Christian Benvenuti <benve@cisco.com>
+M:	Govindarajulu Varadarajan <_govind@gmx.com>
+M:	Parvi Kaustubhi <pkaustub@cisco.com>
+S:	Supported
+F:	drivers/net/ethernet/cisco/enic/
+
+CISCO VIC LOW LATENCY NIC DRIVER
+M:	Christian Benvenuti <benve@cisco.com>
+M:	Nelson Escobar <neescoba@cisco.com>
+M:	Parvi Kaustubhi <pkaustub@cisco.com>
+S:	Supported
+F:	drivers/infiniband/hw/usnic/
+
 CLANG-FORMAT FILE
 M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
@@ -4300,6 +4286,19 @@ F:	Documentation/admin-guide/cgroup-v1/
 F:	include/linux/cgroup*
 F:	kernel/cgroup/
 
+CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
+M:	Tejun Heo <tj@kernel.org>
+M:	Jens Axboe <axboe@kernel.dk>
+L:	cgroups@vger.kernel.org
+L:	linux-block@vger.kernel.org
+T:	git git://git.kernel.dk/linux-block
+F:	Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+F:	block/blk-cgroup.c
+F:	include/linux/blk-cgroup.h
+F:	block/blk-throttle.c
+F:	block/blk-iolatency.c
+F:	block/bfq-cgroup.c
+
 CONTROL GROUP - CPUSET
 M:	Li Zefan <lizefan@huawei.com>
 L:	cgroups@vger.kernel.org
@@ -4321,19 +4320,6 @@ S:	Maintained
 F:	mm/memcontrol.c
 F:	mm/swap_cgroup.c
 
-CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
-M:	Tejun Heo <tj@kernel.org>
-M:	Jens Axboe <axboe@kernel.dk>
-L:	cgroups@vger.kernel.org
-L:	linux-block@vger.kernel.org
-T:	git git://git.kernel.dk/linux-block
-F:	Documentation/admin-guide/cgroup-v1/blkio-controller.rst
-F:	block/blk-cgroup.c
-F:	include/linux/blk-cgroup.h
-F:	block/blk-throttle.c
-F:	block/blk-iolatency.c
-F:	block/bfq-cgroup.c
-
 CORETEMP HARDWARE MONITORING DRIVER
 M:	Fenghua Yu <fenghua.yu@intel.com>
 L:	linux-hwmon@vger.kernel.org
@@ -4363,6 +4349,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/ti/cpmac.c
 
+CPU FREQUENCY DRIVERS - VEXPRESS SPC ARM BIG LITTLE
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-pm@vger.kernel.org
+W:	http://www.arm.com/products/processors/technologies/biglittleprocessing.php
+S:	Maintained
+F:	drivers/cpufreq/vexpress-spc-cpufreq.c
+
 CPU FREQUENCY SCALING FRAMEWORK
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
@@ -4381,13 +4375,17 @@ F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	tools/testing/selftests/cpufreq/
 
-CPU FREQUENCY DRIVERS - VEXPRESS SPC ARM BIG LITTLE
-M:	Viresh Kumar <viresh.kumar@linaro.org>
-M:	Sudeep Holla <sudeep.holla@arm.com>
+CPU IDLE TIME MANAGEMENT FRAMEWORK
+M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 L:	linux-pm@vger.kernel.org
-W:	http://www.arm.com/products/processors/technologies/biglittleprocessing.php
 S:	Maintained
-F:	drivers/cpufreq/vexpress-spc-cpufreq.c
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
+B:	https://bugzilla.kernel.org
+F:	Documentation/admin-guide/pm/cpuidle.rst
+F:	Documentation/driver-api/pm/cpuidle.rst
+F:	drivers/cpuidle/*
+F:	include/linux/cpuidle.h
 
 CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
@@ -4430,18 +4428,6 @@ L:	linux-arm-kernel@lists.infradead.org
 S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.c
 
-CPU IDLE TIME MANAGEMENT FRAMEWORK
-M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
-M:	Daniel Lezcano <daniel.lezcano@linaro.org>
-L:	linux-pm@vger.kernel.org
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
-B:	https://bugzilla.kernel.org
-F:	Documentation/admin-guide/pm/cpuidle.rst
-F:	Documentation/driver-api/pm/cpuidle.rst
-F:	drivers/cpuidle/*
-F:	include/linux/cpuidle.h
-
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
@@ -4739,6 +4725,11 @@ M:	"Maciej W. Rozycki" <macro@linux-mips.org>
 S:	Maintained
 F:	drivers/net/fddi/defxx.*
 
+DEFZA FDDI NETWORK DRIVER
+M:	"Maciej W. Rozycki" <macro@linux-mips.org>
+S:	Maintained
+F:	drivers/net/fddi/defza.*
+
 DEINTERLACE DRIVERS FOR ALLWINNER H3
 M:	Jernej Skrabec <jernej.skrabec@siol.net>
 L:	linux-media@vger.kernel.org
@@ -4747,11 +4738,6 @@ S:	Maintained
 F:	drivers/media/platform/sunxi/sun8i-di/
 F:	Documentation/devicetree/bindings/media/allwinner,sun8i-h3-deinterlace.yaml
 
-DEFZA FDDI NETWORK DRIVER
-M:	"Maciej W. Rozycki" <macro@linux-mips.org>
-S:	Maintained
-F:	drivers/net/fddi/defza.*
-
 DELL LAPTOP DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
 M:	Pali Rohár <pali.rohar@gmail.com>
@@ -4868,6 +4854,14 @@ S:	Maintained
 F:	drivers/base/devcoredump.c
 F:	include/linux/devcoredump.h
 
+DEVICE DIRECT ACCESS (DAX)
+M:	Dan Williams <dan.j.williams@intel.com>
+M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Dave Jiang <dave.jiang@intel.com>
+L:	linux-nvdimm@lists.01.org
+S:	Supported
+F:	drivers/dax/
+
 DEVICE FREQUENCY (DEVFREQ)
 M:	MyungJoo Ham <myungjoo.ham@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
@@ -4977,25 +4971,6 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-diolan-u2c.c
 
-FILESYSTEM DIRECT ACCESS (DAX)
-M:	Dan Williams <dan.j.williams@intel.com>
-R:	Matthew Wilcox <willy@infradead.org>
-R:	Jan Kara <jack@suse.cz>
-L:	linux-fsdevel@vger.kernel.org
-L:	linux-nvdimm@lists.01.org
-S:	Supported
-F:	fs/dax.c
-F:	include/linux/dax.h
-F:	include/trace/events/fs_dax.h
-
-DEVICE DIRECT ACCESS (DAX)
-M:	Dan Williams <dan.j.williams@intel.com>
-M:	Vishal Verma <vishal.l.verma@intel.com>
-M:	Dave Jiang <dave.jiang@intel.com>
-L:	linux-nvdimm@lists.01.org
-S:	Supported
-F:	drivers/dax/
-
 DIRECTORY NOTIFICATION (DNOTIFY)
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
@@ -5052,24 +5027,6 @@ F:	Documentation/driver-api/dma-buf.rst
 K:	dma_(buf|fence|resv)
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
-DMA-BUF HEAPS FRAMEWORK
-M:	Sumit Semwal <sumit.semwal@linaro.org>
-R:	Andrew F. Davis <afd@ti.com>
-R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
-R:	Liam Mark <lmark@codeaurora.org>
-R:	Laura Abbott <labbott@redhat.com>
-R:	Brian Starkey <Brian.Starkey@arm.com>
-R:	John Stultz <john.stultz@linaro.org>
-S:	Maintained
-L:	linux-media@vger.kernel.org
-L:	dri-devel@lists.freedesktop.org
-L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
-F:	include/uapi/linux/dma-heap.h
-F:	include/linux/dma-heap.h
-F:	drivers/dma-buf/dma-heap.c
-F:	drivers/dma-buf/heaps/*
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>
 L:	dmaengine@vger.kernel.org
@@ -5096,6 +5053,24 @@ F:	include/linux/dma-direct.h
 F:	include/linux/dma-mapping.h
 F:	include/linux/dma-noncoherent.h
 
+DMA-BUF HEAPS FRAMEWORK
+M:	Sumit Semwal <sumit.semwal@linaro.org>
+R:	Andrew F. Davis <afd@ti.com>
+R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
+R:	Liam Mark <lmark@codeaurora.org>
+R:	Laura Abbott <labbott@redhat.com>
+R:	Brian Starkey <Brian.Starkey@arm.com>
+R:	John Stultz <john.stultz@linaro.org>
+S:	Maintained
+L:	linux-media@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
+F:	include/uapi/linux/dma-heap.h
+F:	include/linux/dma-heap.h
+F:	drivers/dma-buf/dma-heap.c
+F:	drivers/dma-buf/heaps/*
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+
 DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
 M:	Lukasz Luba <lukasz.luba@arm.com>
 L:	linux-pm@vger.kernel.org
@@ -5137,12 +5112,6 @@ X:	Documentation/power/
 X:	Documentation/spi/
 T:	git git://git.lwn.net/linux.git docs-next
 
-DOCUMENTATION/ITALIAN
-M:	Federico Vaga <federico.vaga@vaga.pv.it>
-L:	linux-doc@vger.kernel.org
-S:	Maintained
-F:	Documentation/translations/it_IT
-
 DOCUMENTATION SCRIPTS
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-doc@vger.kernel.org
@@ -5151,6 +5120,12 @@ F:	scripts/documentation-file-ref-check
 F:	scripts/sphinx-pre-install
 F:	Documentation/sphinx/parse-headers.pl
 
+DOCUMENTATION/ITALIAN
+M:	Federico Vaga <federico.vaga@vaga.pv.it>
+L:	linux-doc@vger.kernel.org
+S:	Maintained
+F:	Documentation/translations/it_IT
+
 DONGWOON DW9714 LENS VOICE COIL DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
@@ -5242,6 +5217,15 @@ F:	drivers/power/avs/
 F:	include/linux/power/smartreflex.h
 L:	linux-pm@vger.kernel.org
 
+DRM DRIVER FOR ALLWINNER DE2 AND DE3 ENGINE
+M:	Maxime Ripard <mripard@kernel.org>
+M:	Chen-Yu Tsai <wens@csie.org>
+R:	Jernej Skrabec <jernej.skrabec@siol.net>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	drivers/gpu/drm/sun4i/sun8i*
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+
 DRM DRIVER FOR ARM PL111 CLCD
 M:	Eric Anholt <eric@anholt.net>
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -5255,11 +5239,6 @@ S:	Maintained
 F:	drivers/gpu/drm/panel/panel-arm-versatile.c
 F:	Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
 
-DRM DRIVER FOR AST SERVER GRAPHICS CHIPS
-M:	Dave Airlie <airlied@redhat.com>
-S:	Odd Fixes
-F:	drivers/gpu/drm/ast/
-
 DRM DRIVER FOR ASPEED BMC GFX
 M:	Joel Stanley <joel@jms.id.au>
 L:	linux-aspeed@lists.ozlabs.org
@@ -5268,6 +5247,11 @@ S:	Supported
 F:	drivers/gpu/drm/aspeed/
 F:	Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
 
+DRM DRIVER FOR AST SERVER GRAPHICS CHIPS
+M:	Dave Airlie <airlied@redhat.com>
+S:	Odd Fixes
+F:	drivers/gpu/drm/ast/
+
 DRM DRIVER FOR BOCHS VIRTUAL GPU
 M:	Gerd Hoffmann <kraxel@redhat.com>
 L:	virtualization@lists.linux-foundation.org
@@ -5305,6 +5289,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 S:	Maintained
 F:	drivers/gpu/drm/tiny/gm12u320.c
 
+DRM DRIVER FOR HX8357D PANELS
+M:	Eric Anholt <eric@anholt.net>
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+S:	Maintained
+F:	drivers/gpu/drm/tiny/hx8357d.c
+F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
+
 DRM DRIVER FOR ILITEK ILI9225 PANELS
 M:	David Lechner <david@lechnology.com>
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -5319,13 +5310,6 @@ S:	Maintained
 F:	drivers/gpu/drm/tiny/ili9486.c
 F:	Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
 
-DRM DRIVER FOR HX8357D PANELS
-M:	Eric Anholt <eric@anholt.net>
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-S:	Maintained
-F:	drivers/gpu/drm/tiny/hx8357d.c
-F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
-
 DRM DRIVER FOR INTEL I810 VIDEO CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/i810/
@@ -5401,17 +5385,17 @@ S:	Maintained
 F:	drivers/gpu/drm/qxl/
 F:	include/uapi/drm/qxl_drm.h
 
+DRM DRIVER FOR RAGE 128 VIDEO CARDS
+S:	Orphan / Obsolete
+F:	drivers/gpu/drm/r128/
+F:	include/uapi/drm/r128_drm.h
+
 DRM DRIVER FOR RAYDIUM RM67191 PANELS
 M:	Robert Chiras <robert.chiras@nxp.com>
 S:	Maintained
 F:	drivers/gpu/drm/panel/panel-raydium-rm67191.c
 F:	Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
 
-DRM DRIVER FOR RAGE 128 VIDEO CARDS
-S:	Orphan / Obsolete
-F:	drivers/gpu/drm/r128/
-F:	include/uapi/drm/r128_drm.h
-
 DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
@@ -5429,12 +5413,6 @@ S:	Orphan / Obsolete
 F:	drivers/gpu/drm/sis/
 F:	include/uapi/drm/sis_drm.h
 
-DRM DRIVER FOR SITRONIX ST7701 PANELS
-M:	Jagan Teki <jagan@amarulasolutions.com>
-S:	Maintained
-F:	drivers/gpu/drm/panel/panel-sitronix-st7701.c
-F:	Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
-
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -5442,6 +5420,12 @@ S:	Maintained
 F:	drivers/gpu/drm/tiny/st7586.c
 F:	Documentation/devicetree/bindings/display/sitronix,st7586.txt
 
+DRM DRIVER FOR SITRONIX ST7701 PANELS
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	drivers/gpu/drm/panel/panel-sitronix-st7701.c
+F:	Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
+
 DRM DRIVER FOR SITRONIX ST7735R PANELS
 M:	David Lechner <david@lechnology.com>
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -5481,13 +5465,6 @@ S:	Odd Fixes
 F:	drivers/gpu/drm/udl/
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
-DRM DRIVER FOR VIRTUALBOX VIRTUAL GPU
-M:	Hans de Goede <hdegoede@redhat.com>
-L:	dri-devel@lists.freedesktop.org
-S:	Maintained
-F:	drivers/gpu/drm/vboxvideo/
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-
 DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
 M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
 R:	Haneen Mohammed <hamohammed.sa@gmail.com>
@@ -5498,6 +5475,13 @@ L:	dri-devel@lists.freedesktop.org
 F:	drivers/gpu/drm/vkms/
 F:	Documentation/gpu/vkms.rst
 
+DRM DRIVER FOR VIRTUALBOX VIRTUAL GPU
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	drivers/gpu/drm/vboxvideo/
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+
 DRM DRIVER FOR VMWARE VIRTUAL GPU
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	Thomas Hellstrom <thellstrom@vmware.com>
@@ -5547,15 +5531,6 @@ F:	drivers/gpu/drm/sun4i/
 F:	Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
-DRM DRIVER FOR ALLWINNER DE2 AND DE3 ENGINE
-M:	Maxime Ripard <mripard@kernel.org>
-M:	Chen-Yu Tsai <wens@csie.org>
-R:	Jernej Skrabec <jernej.skrabec@siol.net>
-L:	dri-devel@lists.freedesktop.org
-S:	Supported
-F:	drivers/gpu/drm/sun4i/sun8i*
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-
 DRM DRIVERS FOR AMLOGIC SOCS
 M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	dri-devel@lists.freedesktop.org
@@ -5708,6 +5683,17 @@ S:	Maintained
 F:	drivers/gpu/drm/stm
 F:	Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
 
+DRM DRIVERS FOR TI KEYSTONE
+M:	Jyri Sarha <jsarha@ti.com>
+M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	drivers/gpu/drm/tidss/
+F:	Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
+F:	Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+F:	Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+
 DRM DRIVERS FOR TI LCDC
 M:	Jyri Sarha <jsarha@ti.com>
 R:	Tomi Valkeinen <tomi.valkeinen@ti.com>
@@ -5723,17 +5709,6 @@ S:	Maintained
 F:	drivers/gpu/drm/omapdrm/
 F:	Documentation/devicetree/bindings/display/ti/
 
-DRM DRIVERS FOR TI KEYSTONE
-M:	Jyri Sarha <jsarha@ti.com>
-M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
-L:	dri-devel@lists.freedesktop.org
-S:	Maintained
-F:	drivers/gpu/drm/tidss/
-F:	Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
-F:	Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
-F:	Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-
 DRM DRIVERS FOR V3D
 M:	Eric Anholt <eric@anholt.net>
 S:	Supported
@@ -5757,10 +5732,19 @@ R:	Russell King <linux+etnaviv@armlinux.org.uk>
 R:	Christian Gmeiner <christian.gmeiner@gmail.com>
 L:	etnaviv@lists.freedesktop.org (moderated for non-subscribers)
 L:	dri-devel@lists.freedesktop.org
-S:	Maintained
-F:	drivers/gpu/drm/etnaviv/
-F:	include/uapi/drm/etnaviv_drm.h
-F:	Documentation/devicetree/bindings/display/etnaviv/
+S:	Maintained
+F:	drivers/gpu/drm/etnaviv/
+F:	include/uapi/drm/etnaviv_drm.h
+F:	Documentation/devicetree/bindings/display/etnaviv/
+
+DRM DRIVERS FOR XEN
+M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+L:	dri-devel@lists.freedesktop.org
+L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/gpu/drm/xen/
+F:	Documentation/gpu/xen-front.rst
 
 DRM DRIVERS FOR ZTE ZX
 M:	Shawn Guo <shawnguo@kernel.org>
@@ -5781,15 +5765,6 @@ F:	drivers/gpu/drm/panel/
 F:	include/drm/drm_panel.h
 F:	Documentation/devicetree/bindings/display/panel/
 
-DRM DRIVERS FOR XEN
-M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-L:	dri-devel@lists.freedesktop.org
-L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/gpu/drm/xen/
-F:	Documentation/gpu/xen-front.rst
-
 DRM TTM SUBSYSTEM
 M:	Christian Koenig <christian.koenig@amd.com>
 M:	Huang Rui <ray.huang@amd.com>
@@ -6147,6 +6122,14 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/pnd2_edac.[ch]
 
+EDAC-QCOM
+M:	Channagoud Kadabi <ckadabi@codeaurora.org>
+M:	Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
+L:	linux-arm-msm@vger.kernel.org
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/edac/qcom_edac.c
+
 EDAC-R82600
 M:	Tim Small <tim@buttersideup.com>
 L:	linux-edac@vger.kernel.org
@@ -6179,14 +6162,6 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/ti_edac.c
 
-EDAC-QCOM
-M:	Channagoud Kadabi <ckadabi@codeaurora.org>
-M:	Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
-L:	linux-arm-msm@vger.kernel.org
-L:	linux-edac@vger.kernel.org
-S:	Maintained
-F:	drivers/edac/qcom_edac.c
-
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
@@ -6243,6 +6218,14 @@ M:	David Woodhouse <dwmw2@infradead.org>
 L:	linux-embedded@vger.kernel.org
 S:	Maintained
 
+EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
+M:	Adrian Hunter <adrian.hunter@intel.com>
+M:	Ritesh Harjani <riteshh@codeaurora.org>
+M:	Asutosh Das <asutoshd@codeaurora.org>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/cqhci*
+
 Emulex 10Gbps iSCSI - OneConnect DRIVER
 M:	Subbu Seetharaman <subbu.seetharaman@broadcom.com>
 M:	Ketan Mukadam <ketan.mukadam@broadcom.com>
@@ -6419,6 +6402,15 @@ F:	include/linux/extcon.h
 F:	Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
 F:	Documentation/devicetree/bindings/extcon/
 
+EXTRA BOOT CONFIG
+M:	Masami Hiramatsu <mhiramat@kernel.org>
+S:	Maintained
+F:	lib/bootconfig.c
+F:	fs/proc/bootconfig.c
+F:	include/linux/bootconfig.h
+F:	tools/bootconfig/*
+F:	Documentation/admin-guide/bootconfig.rst
+
 EXYNOS DP DRIVER
 M:	Jingoo Han <jingoohan1@gmail.com>
 L:	dri-devel@lists.freedesktop.org
@@ -6537,6 +6529,17 @@ F:	include/uapi/linux/fcntl.h
 F:	fs/fcntl.c
 F:	fs/locks.c
 
+FILESYSTEM DIRECT ACCESS (DAX)
+M:	Dan Williams <dan.j.williams@intel.com>
+R:	Matthew Wilcox <willy@infradead.org>
+R:	Jan Kara <jack@suse.cz>
+L:	linux-fsdevel@vger.kernel.org
+L:	linux-nvdimm@lists.01.org
+S:	Supported
+F:	fs/dax.c
+F:	include/linux/dax.h
+F:	include/trace/events/fs_dax.h
+
 FILESYSTEMS (VFS and infrastructure)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
 L:	linux-fsdevel@vger.kernel.org
@@ -6619,6 +6622,27 @@ S:	Odd Fixes
 L:	linux-block@vger.kernel.org
 F:	drivers/block/floppy.c
 
+FLYSKY FSIA6B RC RECEIVER
+M:	Markus Koch <markus@notsyncing.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/joystick/fsia6b.c
+
+FORCEDETH GIGABIT ETHERNET DRIVER
+M:	Rain River <rain.1986.08.12@gmail.com>
+M:	Zhu Yanjun <zyjzyj2000@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/nvidia/*
+
+FPGA DFL DRIVERS
+M:	Wu Hao <hao.wu@intel.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
+F:	Documentation/fpga/dfl.rst
+F:	include/uapi/linux/fpga-dfl.h
+F:	drivers/fpga/dfl*
+
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
 L:	linux-fpga@vger.kernel.org
@@ -6632,14 +6656,6 @@ F:	drivers/fpga/
 F:	include/linux/fpga/
 W:	http://www.rocketboards.org
 
-FPGA DFL DRIVERS
-M:	Wu Hao <hao.wu@intel.com>
-L:	linux-fpga@vger.kernel.org
-S:	Maintained
-F:	Documentation/fpga/dfl.rst
-F:	include/uapi/linux/fpga-dfl.h
-F:	drivers/fpga/dfl*
-
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 W:	http://floatingpoint.sourceforge.net/emulator/index.html
@@ -6713,6 +6729,24 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cpm.c
 
+FREESCALE IMX / MXC FEC DRIVER
+M:	Fugang Duan <fugang.duan@nxp.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/freescale/fec_main.c
+F:	drivers/net/ethernet/freescale/fec_ptp.c
+F:	drivers/net/ethernet/freescale/fec.h
+F:	Documentation/devicetree/bindings/net/fsl-fec.txt
+
+FREESCALE IMX / MXC FRAMEBUFFER DRIVER
+M:	Sascha Hauer <s.hauer@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
+L:	linux-fbdev@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	include/linux/platform_data/video-imxfb.h
+F:	drivers/video/fbdev/imxfb.c
+
 FREESCALE IMX DDR PMU DRIVER
 M:	Frank Li <Frank.li@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org
@@ -6737,24 +6771,6 @@ S:	Maintained
 F:	drivers/i2c/busses/i2c-imx-lpi2c.c
 F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
 
-FREESCALE IMX / MXC FEC DRIVER
-M:	Fugang Duan <fugang.duan@nxp.com>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	drivers/net/ethernet/freescale/fec_main.c
-F:	drivers/net/ethernet/freescale/fec_ptp.c
-F:	drivers/net/ethernet/freescale/fec.h
-F:	Documentation/devicetree/bindings/net/fsl-fec.txt
-
-FREESCALE IMX / MXC FRAMEBUFFER DRIVER
-M:	Sascha Hauer <s.hauer@pengutronix.de>
-R:	Pengutronix Kernel Team <kernel@pengutronix.de>
-L:	linux-fbdev@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	include/linux/platform_data/video-imxfb.h
-F:	drivers/video/fbdev/imxfb.c
-
 FREESCALE QORIQ DPAA ETHERNET DRIVER
 M:	Madalin Bucur <madalin.bucur@nxp.com>
 L:	netdev@vger.kernel.org
@@ -6982,6 +6998,13 @@ F:	tools/testing/selftests/futex/
 F:	tools/perf/bench/futex*
 F:	Documentation/*futex*
 
+GASKET DRIVER FRAMEWORK
+M:	Rob Springer <rspringer@google.com>
+M:	Todd Poynor <toddpoynor@google.com>
+M:	Ben Chan <benchan@chromium.org>
+S:	Maintained
+F:	drivers/staging/gasket/
+
 GCC PLUGINS
 M:	Kees Cook <keescook@chromium.org>
 R:	Emese Revfy <re.emese@gmail.com>
@@ -6992,13 +7015,6 @@ F:	scripts/gcc-plugin.sh
 F:	scripts/Makefile.gcc-plugins
 F:	Documentation/core-api/gcc-plugins.rst
 
-GASKET DRIVER FRAMEWORK
-M:	Rob Springer <rspringer@google.com>
-M:	Todd Poynor <toddpoynor@google.com>
-M:	Ben Chan <benchan@chromium.org>
-S:	Maintained
-F:	drivers/staging/gasket/
-
 GCOV BASED KERNEL PROFILING
 M:	Peter Oberparleiter <oberpar@linux.ibm.com>
 S:	Maintained
@@ -7401,6 +7417,13 @@ T:	git git://linuxtv.org/anttip/media_tree.git
 S:	Maintained
 F:	drivers/media/usb/hackrf/
 
+HANTRO VPU CODEC DRIVER
+M:	Ezequiel Garcia <ezequiel@collabora.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/media/hantro/
+F:	Documentation/devicetree/bindings/media/rockchip-vpu.txt
+
 HARD DRIVE ACTIVE PROTECTION SYSTEM (HDAPS) DRIVER
 M:	Frank Seidel <frank@f-seidel.de>
 L:	platform-driver-x86@vger.kernel.org
@@ -7431,11 +7454,6 @@ F:	Documentation/admin-guide/hw_random.rst
 F:	drivers/char/hw_random/
 F:	include/linux/hw_random.h
 
-HARDWARE TRACING FACILITIES
-M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
-S:	Maintained
-F:	drivers/hwtracing/
-
 HARDWARE SPINLOCK CORE
 M:	Ohad Ben-Cohen <ohad@wizery.com>
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
@@ -7448,6 +7466,11 @@ F:	Documentation/hwspinlock.txt
 F:	drivers/hwspinlock/
 F:	include/linux/hwspinlock.h
 
+HARDWARE TRACING FACILITIES
+M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
+S:	Maintained
+F:	drivers/hwtracing/
+
 HARMONY SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
 S:	Maintained
@@ -7573,16 +7596,6 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
-HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
-M:	Zaibo Xu <xuzaibo@huawei.com>
-L:	linux-crypto@vger.kernel.org
-S:	Maintained
-F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
-F:	drivers/crypto/hisilicon/sec2/sec_main.c
-F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
-F:	drivers/crypto/hisilicon/sec2/sec.h
-F:	Documentation/ABI/testing/debugfs-hisi-sec
-
 HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
 M:	Zaibo Xu <xuzaibo@huawei.com>
 L:	linux-crypto@vger.kernel.org
@@ -7592,6 +7605,13 @@ F:	drivers/crypto/hisilicon/hpre/hpre_main.c
 F:	drivers/crypto/hisilicon/hpre/hpre.h
 F:	Documentation/ABI/testing/debugfs-hisi-hpre
 
+HISILICON LPC BUS DRIVER
+M:	john.garry@huawei.com
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/bus/hisi_lpc.c
+F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+
 HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
@@ -7600,18 +7620,6 @@ W:	http://www.hisilicon.com
 S:	Maintained
 F:	drivers/net/ethernet/hisilicon/hns3/
 
-HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
-M:	Zaibo Xu <xuzaibo@huawei.com>
-S:	Maintained
-F:	drivers/char/hw_random/hisi-trng-v2.c
-
-HISILICON LPC BUS DRIVER
-M:	john.garry@huawei.com
-W:	http://www.hisilicon.com
-S:	Maintained
-F:	drivers/bus/hisi_lpc.c
-F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
-
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
@@ -7628,6 +7636,16 @@ S:	Supported
 F:	drivers/perf/hisilicon
 F:	Documentation/admin-guide/perf/hisi-pmu.rst
 
+HISILICON QM AND ZIP Controller DRIVER
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/hisilicon/qm.c
+F:	drivers/crypto/hisilicon/qm.h
+F:	drivers/crypto/hisilicon/sgl.c
+F:	drivers/crypto/hisilicon/zip/
+F:	Documentation/ABI/testing/debugfs-hisi-zip
+
 HISILICON ROCE DRIVER
 M:	Lijun Ou <oulijun@huawei.com>
 M:	Wei Hu(Xavier) <xavier.huwei@huawei.com>
@@ -7643,22 +7661,27 @@ S:	Supported
 F:	drivers/scsi/hisi_sas/
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
 
+HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
+M:	Zaibo Xu <xuzaibo@huawei.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
+F:	drivers/crypto/hisilicon/sec2/sec_main.c
+F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
+F:	drivers/crypto/hisilicon/sec2/sec.h
+F:	Documentation/ABI/testing/debugfs-hisi-sec
+
+HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
+M:	Zaibo Xu <xuzaibo@huawei.com>
+S:	Maintained
+F:	drivers/char/hw_random/hisi-trng-v2.c
+
 HISILICON V3XX SPI NOR FLASH Controller Driver
 M:	John Garry <john.garry@huawei.com>
 W:	http://www.hisilicon.com
 S:	Maintained
 F:	drivers/spi/spi-hisi-sfc-v3xx.c
 
-HISILICON QM AND ZIP Controller DRIVER
-M:	Zhou Wang <wangzhou1@hisilicon.com>
-L:	linux-crypto@vger.kernel.org
-S:	Maintained
-F:	drivers/crypto/hisilicon/qm.c
-F:	drivers/crypto/hisilicon/qm.h
-F:	drivers/crypto/hisilicon/sgl.c
-F:	drivers/crypto/hisilicon/zip/
-F:	Documentation/ABI/testing/debugfs-hisi-zip
-
 HMM - Heterogeneous Memory Management
 M:	Jérôme Glisse <jglisse@redhat.com>
 L:	linux-mm@kvack.org
@@ -7970,6 +7993,18 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/i2c-stub.c
 
+I3C DRIVER FOR CADENCE I3C MASTER IP
+M:	Przemysław Gaj <pgaj@cadence.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
+F:	drivers/i3c/master/i3c-master-cdns.c
+
+I3C DRIVER FOR SYNOPSYS DESIGNWARE
+M:	Vitor Soares <vitor.soares@synopsys.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
+F:	drivers/i3c/master/dw*
+
 I3C SUBSYSTEM
 M:	Boris Brezillon <bbrezillon@kernel.org>
 L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
@@ -7982,18 +8017,6 @@ F:	Documentation/driver-api/i3c
 F:	drivers/i3c/
 F:	include/linux/i3c/
 
-I3C DRIVER FOR SYNOPSYS DESIGNWARE
-M:	Vitor Soares <vitor.soares@synopsys.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
-F:	drivers/i3c/master/dw*
-
-I3C DRIVER FOR CADENCE I3C MASTER IP
-M:	Przemysław Gaj <pgaj@cadence.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
-F:	drivers/i3c/master/i3c-master-cdns.c
-
 IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
 M:	Fenghua Yu <fenghua.yu@intel.com>
@@ -8026,10 +8049,24 @@ F:	drivers/crypto/nx/nx.*
 F:	drivers/crypto/nx/nx_csbcpb.h
 F:	drivers/crypto/nx/nx_debugfs.c
 
+IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
+L:	linux-pci@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	drivers/pci/hotplug/rpadlpar*
+
 IBM Power Linux RAID adapter
 M:	Brian King <brking@us.ibm.com>
 S:	Supported
-F:	drivers/scsi/ipr.*
+F:	drivers/scsi/ipr.*
+
+IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
+L:	linux-pci@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	drivers/pci/hotplug/rpaphp*
 
 IBM Power SRIOV Virtual NIC Device Driver
 M:	Thomas Falcon <tlfalcon@linux.ibm.com>
@@ -8090,20 +8127,6 @@ F:	drivers/crypto/vmx/aes*
 F:	drivers/crypto/vmx/ghash*
 F:	drivers/crypto/vmx/ppc-xlate.pl
 
-IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
-M:	Tyrel Datwyler <tyreld@linux.ibm.com>
-L:	linux-pci@vger.kernel.org
-L:	linuxppc-dev@lists.ozlabs.org
-S:	Supported
-F:	drivers/pci/hotplug/rpaphp*
-
-IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
-M:	Tyrel Datwyler <tyreld@linux.ibm.com>
-L:	linux-pci@vger.kernel.org
-L:	linuxppc-dev@lists.ozlabs.org
-S:	Supported
-F:	drivers/pci/hotplug/rpadlpar*
-
 IBM ServeRAID RAID DRIVER
 S:	Orphan
 F:	drivers/scsi/ips.*
@@ -8961,17 +8984,6 @@ S:	Supported
 W:	http://www.linux-iscsi.org
 F:	drivers/infiniband/ulp/isert
 
-ISDN/mISDN SUBSYSTEM
-M:	Karsten Keil <isdn@linux-pingi.de>
-L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
-L:	netdev@vger.kernel.org
-W:	http://www.isdn4linux.de
-S:	Maintained
-F:	drivers/isdn/mISDN/
-F:	drivers/isdn/hardware/
-F:	drivers/isdn/Kconfig
-F:	drivers/isdn/Makefile
-
 ISDN/CMTP OVER BLUETOOTH
 M:	Karsten Keil <isdn@linux-pingi.de>
 L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
@@ -8984,6 +8996,17 @@ F:	net/bluetooth/cmtp/
 F:	include/linux/isdn/
 F:	include/uapi/linux/isdn/
 
+ISDN/mISDN SUBSYSTEM
+M:	Karsten Keil <isdn@linux-pingi.de>
+L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
+L:	netdev@vger.kernel.org
+W:	http://www.isdn4linux.de
+S:	Maintained
+F:	drivers/isdn/mISDN/
+F:	drivers/isdn/hardware/
+F:	drivers/isdn/Kconfig
+F:	drivers/isdn/Makefile
+
 IT87 HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-hwmon@vger.kernel.org
@@ -9936,6 +9959,17 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 F:	drivers/iio/dac/ltc1660.c
 
+LTC2947 HARDWARE MONITOR DRIVER
+M:	Nuno Sá <nuno.sa@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+F:	drivers/hwmon/ltc2947-core.c
+F:	drivers/hwmon/ltc2947-spi.c
+F:	drivers/hwmon/ltc2947-i2c.c
+F:	drivers/hwmon/ltc2947.h
+F:	Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
+
 LTC2983 IIO TEMPERATURE DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -9951,17 +9985,6 @@ S:	Maintained
 F:	Documentation/hwmon/ltc4261.rst
 F:	drivers/hwmon/ltc4261.c
 
-LTC2947 HARDWARE MONITOR DRIVER
-M:	Nuno Sá <nuno.sa@analog.com>
-W:	http://ez.analog.com/community/linux-device-drivers
-L:	linux-hwmon@vger.kernel.org
-S:	Supported
-F:	drivers/hwmon/ltc2947-core.c
-F:	drivers/hwmon/ltc2947-spi.c
-F:	drivers/hwmon/ltc2947-i2c.c
-F:	drivers/hwmon/ltc2947.h
-F:	Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
-
 LTC4306 I2C MULTIPLEXER DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
@@ -10072,6 +10095,14 @@ F:	include/linux/platform_data/mv88e6xxx.h
 F:	Documentation/devicetree/bindings/net/dsa/marvell.txt
 F:	Documentation/networking/devlink/mv88e6xxx.rst
 
+MARVELL ARMADA 3700 PHY DRIVERS
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+F:	drivers/phy/marvell/phy-mvebu-a3700-utmi.c
+F:	Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
+F:	Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
+
 MARVELL ARMADA DRM SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
@@ -10081,14 +10112,6 @@ F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
 F:	Documentation/devicetree/bindings/display/armada/
 
-MARVELL ARMADA 3700 PHY DRIVERS
-M:	Miquel Raynal <miquel.raynal@bootlin.com>
-S:	Maintained
-F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
-F:	drivers/phy/marvell/phy-mvebu-a3700-utmi.c
-F:	Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
-F:	Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
-
 MARVELL CRYPTO DRIVER
 M:	Boris Brezillon <bbrezillon@kernel.org>
 M:	Arnaud Ebalard <arno@natisbad.org>
@@ -10159,17 +10182,14 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/marvell_nand.c
 F:	Documentation/devicetree/bindings/mtd/marvell-nand.txt
 
-MARVELL SOC MMC/SD/SDIO CONTROLLER DRIVER
-M:	Nicolas Pitre <nico@fluxnic.net>
-S:	Odd Fixes
-F:	drivers/mmc/host/mvsdio.*
-
-MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
-M:	Hu Ziji <huziji@marvell.com>
-L:	linux-mmc@vger.kernel.org
+MARVELL OCTEONTX2 PHYSICAL FUNCTION DRIVER
+M:	Sunil Goutham <sgoutham@marvell.com>
+M:	Geetha sowjanya <gakula@marvell.com>
+M:	Subbaraya Sundeep <sbhatta@marvell.com>
+M:	hariprasad <hkelam@marvell.com>
+L:	netdev@vger.kernel.org
 S:	Supported
-F:	drivers/mmc/host/sdhci-xenon*
-F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
+F:	drivers/net/ethernet/marvell/octeontx2/nic/
 
 MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
@@ -10181,14 +10201,17 @@ S:	Supported
 F:	drivers/net/ethernet/marvell/octeontx2/af/
 F:	Documentation/networking/device_drivers/marvell/octeontx2.rst
 
-MARVELL OCTEONTX2 PHYSICAL FUNCTION DRIVER
-M:	Sunil Goutham <sgoutham@marvell.com>
-M:	Geetha sowjanya <gakula@marvell.com>
-M:	Subbaraya Sundeep <sbhatta@marvell.com>
-M:	hariprasad <hkelam@marvell.com>
-L:	netdev@vger.kernel.org
+MARVELL SOC MMC/SD/SDIO CONTROLLER DRIVER
+M:	Nicolas Pitre <nico@fluxnic.net>
+S:	Odd Fixes
+F:	drivers/mmc/host/mvsdio.*
+
+MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
+M:	Hu Ziji <huziji@marvell.com>
+L:	linux-mmc@vger.kernel.org
 S:	Supported
-F:	drivers/net/ethernet/marvell/octeontx2/nic/
+F:	drivers/mmc/host/sdhci-xenon*
+F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
@@ -10345,6 +10368,13 @@ F:	drivers/media/mc/
 F:	include/media/media-*.h
 F:	include/uapi/linux/media.h
 
+MEDIA DRIVER FOR FREESCALE IMX PXP
+M:	Philipp Zabel <p.zabel@pengutronix.de>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	drivers/media/platform/imx-pxp.[ch]
+
 MEDIA DRIVERS FOR ASCOT2E
 M:	Sergey Kozlov <serjk@netup.ru>
 M:	Abylay Ospan <aospan@netup.ru>
@@ -10401,13 +10431,6 @@ F:	drivers/staging/media/imx/
 F:	include/linux/imx-media.h
 F:	include/media/imx.h
 
-MEDIA DRIVER FOR FREESCALE IMX PXP
-M:	Philipp Zabel <p.zabel@pengutronix.de>
-L:	linux-media@vger.kernel.org
-T:	git git://linuxtv.org/media_tree.git
-S:	Maintained
-F:	drivers/media/platform/imx-pxp.[ch]
-
 MEDIA DRIVERS FOR FREESCALE IMX7
 M:	Rui Miguel Silva <rmfrfs@gmail.com>
 L:	linux-media@vger.kernel.org
@@ -10465,6 +10488,15 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Supported
 F:	drivers/media/pci/netup_unidvb/*
 
+MEDIA DRIVERS FOR NVIDIA TEGRA - VDE
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-media@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
+F:	drivers/staging/media/tegra-vde/
+
 MEDIA DRIVERS FOR RENESAS - CEU
 M:	Jacopo Mondi <jacopo@jmondi.org>
 L:	linux-media@vger.kernel.org
@@ -10545,15 +10577,6 @@ S:	Supported
 F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
 F:	drivers/media/platform/stm32/stm32-dcmi.c
 
-MEDIA DRIVERS FOR NVIDIA TEGRA - VDE
-M:	Dmitry Osipenko <digetx@gmail.com>
-L:	linux-media@vger.kernel.org
-L:	linux-tegra@vger.kernel.org
-T:	git git://linuxtv.org/media_tree.git
-S:	Maintained
-F:	Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
-F:	drivers/staging/media/tegra-vde/
-
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
@@ -10583,6 +10606,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 F:	drivers/bluetooth/btmtkuart.c
 
+MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
+F:	drivers/power/reset/mt6323-poweroff.c
+
 MEDIATEK CIR DRIVER
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
@@ -10597,12 +10627,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/dma/mtk-*
 F:	drivers/dma/mediatek/
 
-MEDIATEK PMIC LED DRIVER
-M:	Sean Wang <sean.wang@mediatek.com>
-S:	Maintained
-F:	drivers/leds/leds-mt6323.c
-F:	Documentation/devicetree/bindings/leds/leds-mt6323.txt
-
 MEDIATEK ETHERNET DRIVER
 M:	Felix Fietkau <nbd@openwrt.org>
 M:	John Crispin <john@phrozen.org>
@@ -10612,20 +10636,6 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/mediatek/
 
-MEDIATEK SWITCH DRIVER
-M:	Sean Wang <sean.wang@mediatek.com>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	drivers/net/dsa/mt7530.*
-F:	net/dsa/tag_mtk.c
-
-MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS
-M:	Sean Wang <sean.wang@mediatek.com>
-L:	linux-pm@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
-F:	drivers/power/reset/mt6323-poweroff.c
-
 MEDIATEK JPEG DRIVER
 M:	Rick Chang <rick.chang@mediatek.com>
 M:	Bin Liu <bin.liu@mediatek.com>
@@ -10686,11 +10696,24 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/mtk_*
 F:	Documentation/devicetree/bindings/mtd/mtk-nand.txt
 
+MEDIATEK PMIC LED DRIVER
+M:	Sean Wang <sean.wang@mediatek.com>
+S:	Maintained
+F:	drivers/leds/leds-mt6323.c
+F:	Documentation/devicetree/bindings/leds/leds-mt6323.txt
+
 MEDIATEK RANDOM NUMBER GENERATOR SUPPORT
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
 F:	drivers/char/hw_random/mtk-rng.c
 
+MEDIATEK SWITCH DRIVER
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/dsa/mt7530.*
+F:	net/dsa/tag_mtk.c
+
 MEDIATEK USB3 DRD IP DRIVER
 M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 L:	linux-usb@vger.kernel.org (moderated for non-subscribers)
@@ -10981,6 +11004,21 @@ F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
 F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
+MICROCHIP AT91 USART MFD DRIVER
+M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/mfd/at91-usart.c
+F:	include/dt-bindings/mfd/at91-usart.h
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+F:	drivers/spi/spi-at91-usart.c
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+
 MICROCHIP AUDIO ASOC DRIVERS
 M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
@@ -11029,21 +11067,6 @@ S:	Supported
 F:	drivers/media/platform/atmel/atmel-isi.c
 F:	drivers/media/platform/atmel/atmel-isi.h
 
-MICROCHIP AT91 USART MFD DRIVER
-M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
-L:	linux-kernel@vger.kernel.org
-S:	Supported
-F:	drivers/mfd/at91-usart.c
-F:	include/dt-bindings/mfd/at91-usart.h
-F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
-
-MICROCHIP AT91 USART SPI DRIVER
-M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
-L:	linux-spi@vger.kernel.org
-S:	Supported
-F:	drivers/spi/spi-at91-usart.c
-F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
-
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <woojung.huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
@@ -11068,11 +11091,6 @@ S:	Maintained
 F:	drivers/video/fbdev/atmel_lcdfb.c
 F:	include/video/atmel_lcdc.h
 
-MICROCHIP MMC/SD/SDIO MCI DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-S:	Maintained
-F:	drivers/mmc/host/atmel-mci.c
-
 MICROCHIP MCP16502 PMIC DRIVER
 M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -11088,6 +11106,11 @@ S:	Supported
 F:	drivers/iio/adc/mcp3911.c
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 
+MICROCHIP MMC/SD/SDIO MCI DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+S:	Maintained
+F:	drivers/mmc/host/atmel-mci.c
+
 MICROCHIP NAND DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-mtd@lists.infradead.org
@@ -11129,12 +11152,6 @@ S:	Supported
 F:	drivers/misc/atmel-ssc.c
 F:	include/linux/atmel-ssc.h
 
-MICROCHIP USBA UDC DRIVER
-M:	Cristian Birsan <cristian.birsan@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/usb/gadget/udc/atmel_usba_udc.*
-
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb@vger.kernel.org
@@ -11142,6 +11159,12 @@ S:	Maintained
 F:	drivers/usb/misc/usb251xb.c
 F:	Documentation/devicetree/bindings/usb/usb251xb.txt
 
+MICROCHIP USBA UDC DRIVER
+M:	Cristian Birsan <cristian.birsan@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/usb/gadget/udc/atmel_usba_udc.*
+
 MICROCHIP XDMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org
@@ -11149,6 +11172,14 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/at_xdmac.c
 
+MICROSEMI ETHERNET SWITCH DRIVER
+M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/mscc/
+F:	include/soc/mscc/ocelot*
+
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
@@ -11171,14 +11202,6 @@ F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 F:	Documentation/scsi/smartpqi.txt
 
-MICROSEMI ETHERNET SWITCH DRIVER
-M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
-M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-L:	netdev@vger.kernel.org
-S:	Supported
-F:	drivers/net/ethernet/mscc/
-F:	include/soc/mscc/ocelot*
-
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
@@ -11220,6 +11243,13 @@ F:	Documentation/devicetree/bindings/power/mti,mips-cpc.txt
 F:	arch/mips/generic/
 F:	arch/mips/tools/generic-board-config.sh
 
+MIPS RINT INSTRUCTION EMULATION
+M:	Aleksandar Markovic <aleksandar.markovic@mips.com>
+L:	linux-mips@vger.kernel.org
+S:	Supported
+F:	arch/mips/math-emu/sp_rint.c
+F:	arch/mips/math-emu/dp_rint.c
+
 MIPS/LOONGSON1 ARCHITECTURE
 M:	Keguang Zhang <keguang.zhang@gmail.com>
 L:	linux-mips@vger.kernel.org
@@ -11249,13 +11279,6 @@ F:	drivers/platform/mips/cpu_hwmon.c
 F:	drivers/*/*loongson3*
 F:	drivers/*/*/*loongson3*
 
-MIPS RINT INSTRUCTION EMULATION
-M:	Aleksandar Markovic <aleksandar.markovic@mips.com>
-L:	linux-mips@vger.kernel.org
-S:	Supported
-F:	arch/mips/math-emu/sp_rint.c
-F:	arch/mips/math-emu/dp_rint.c
-
 MIROSOUND PCM20 FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
@@ -11318,6 +11341,14 @@ S:	Maintained
 F:	include/linux/module.h
 F:	kernel/module.c
 
+MONOLITHIC POWER SYSTEM PMIC DRIVER
+M:	Saravanan Sekar <sravanhome@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
+F:	drivers/regulator/mp5416.c
+F:	drivers/regulator/mpq7920.c
+F:	drivers/regulator/mpq7920.h
+
 MOTION EYE VAIO PICTUREBOOK CAMERA DRIVER
 W:	http://popies.net/meye/
 S:	Orphan
@@ -11331,14 +11362,6 @@ S:	Maintained
 F:	Documentation/driver-api/serial/moxa-smartio.rst
 F:	drivers/tty/mxser.*
 
-MONOLITHIC POWER SYSTEM PMIC DRIVER
-M:	Saravanan Sekar <sravanhome@gmail.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
-F:	drivers/regulator/mp5416.c
-F:	drivers/regulator/mpq7920.c
-F:	drivers/regulator/mpq7920.h
-
 MR800 AVERMEDIA USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media@vger.kernel.org
@@ -11572,13 +11595,10 @@ S:	Maintained
 F:	Documentation/hwmon/nct6775.rst
 F:	drivers/hwmon/nct6775.c
 
-NET_FAILOVER MODULE
-M:	Sridhar Samudrala <sridhar.samudrala@intel.com>
-L:	netdev@vger.kernel.org
-S:	Supported
-F:	drivers/net/net_failover.c
-F:	include/net/net_failover.h
-F:	Documentation/networking/net_failover.rst
+NETDEVSIM
+M:	Jakub Kicinski <kuba@kernel.org>
+S:	Maintained
+F:	drivers/net/netdevsim/*
 
 NETEM NETWORK EMULATOR
 M:	Stephen Hemminger <stephen@networkplumber.org>
@@ -11811,11 +11831,6 @@ NETWORKING [WIRELESS]
 L:	linux-wireless@vger.kernel.org
 Q:	http://patchwork.kernel.org/project/linux-wireless/list/
 
-NETDEVSIM
-M:	Jakub Kicinski <kuba@kernel.org>
-S:	Maintained
-F:	drivers/net/netdevsim/*
-
 NETXEN (1/10) GbE SUPPORT
 M:	Manish Chopra <manishc@marvell.com>
 M:	Rahul Verma <rahulv@marvell.com>
@@ -11824,6 +11839,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/qlogic/netxen/
 
+NET_FAILOVER MODULE
+M:	Sridhar Samudrala <sridhar.samudrala@intel.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/net_failover.c
+F:	include/net/net_failover.h
+F:	Documentation/networking/net_failover.rst
+
 NEXTHOP
 M:	David Ahern <dsahern@kernel.org>
 L:	netdev@vger.kernel.org
@@ -12037,6 +12060,14 @@ F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	include/linux/nvmem-consumer.h
 F:	include/linux/nvmem-provider.h
 
+NXP FSPI DRIVER
+R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
+M:	Ashish Kumar <ashish.kumar@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+
 NXP FXAS21002C DRIVER
 M:	Rui Miguel Silva <rmfrfs@gmail.com>
 L:	linux-iio@vger.kernel.org
@@ -12092,14 +12123,6 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 F:	include/linux/objagg.h
 
-NXP FSPI DRIVER
-R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
-M:	Ashish Kumar <ashish.kumar@nxp.com>
-L:	linux-spi@vger.kernel.org
-S:	Maintained
-F:	drivers/spi/spi-nxp-fspi.c
-F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
-
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
@@ -12312,12 +12335,6 @@ F:	drivers/regulator/twl6030-regulator.c
 F:	include/linux/platform_data/i2c-omap.h
 F:	include/linux/platform_data/ti-sysc.h
 
-ONION OMEGA2+ BOARD
-M:	Harvey Hunt <harveyhuntnexus@gmail.com>
-L:	linux-mips@vger.kernel.org
-S:	Maintained
-F:	arch/mips/boot/dts/ralink/omega2p.dts
-
 OMFS FILESYSTEM
 M:	Bob Copeland <me@bobcopeland.com>
 L:	linux-karma-devel@lists.sourceforge.net
@@ -12420,12 +12437,6 @@ S:	Maintained
 F:	drivers/media/i2c/ov7740.c
 F:	Documentation/devicetree/bindings/media/i2c/ov7740.txt
 
-OMNIVISION OV9640 SENSOR DRIVER
-M:	Petr Cvek <petrcvekcz@gmail.com>
-L:	linux-media@vger.kernel.org
-S:	Maintained
-F:	drivers/media/i2c/ov9640.*
-
 OMNIVISION OV8856 SENSOR DRIVER
 M:	Ben Kao <ben.kao@intel.com>
 L:	linux-media@vger.kernel.org
@@ -12433,6 +12444,12 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/i2c/ov8856.c
 
+OMNIVISION OV9640 SENSOR DRIVER
+M:	Petr Cvek <petrcvekcz@gmail.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/i2c/ov9640.*
+
 OMNIVISION OV9650 SENSOR DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 R:	Akinobu Mita <akinobu.mita@gmail.com>
@@ -12450,6 +12467,12 @@ S:	Maintained
 F:	drivers/mtd/nand/onenand/
 F:	include/linux/mtd/onenand*.h
 
+ONION OMEGA2+ BOARD
+M:	Harvey Hunt <harveyhuntnexus@gmail.com>
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	arch/mips/boot/dts/ralink/omega2p.dts
+
 OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 L:	tee-dev@lists.linaro.org
@@ -12926,6 +12949,13 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/pci/controller/dwc/pci-keystone.c
 
+PCI DRIVER FOR V3 SEMICONDUCTOR V360EPC
+M:	Linus Walleij <linus.walleij@linaro.org>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
+F:	drivers/pci/controller/pci-v3-semi.c
+
 PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
@@ -12973,6 +13003,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 F:	drivers/pci/controller/pci-xgene-msi.c
 
+PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+R:	Andrew Murray <amurray@thegoodpenguin.co.uk>
+L:	linux-pci@vger.kernel.org
+Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
+S:	Supported
+F:	drivers/pci/controller/
+
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
 L:	linux-pci@vger.kernel.org
@@ -12992,15 +13031,6 @@ F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 F:	arch/x86/kernel/early-quirks.c
 
-PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-R:	Andrew Murray <amurray@thegoodpenguin.co.uk>
-L:	linux-pci@vger.kernel.org
-Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
-S:	Supported
-F:	drivers/pci/controller/
-
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
 L:	linux-pci@vger.kernel.org
@@ -13075,13 +13105,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/rockchip-pcie*
 F:	drivers/pci/controller/pcie-rockchip*
 
-PCI DRIVER FOR V3 SEMICONDUCTOR V360EPC
-M:	Linus Walleij <linus.walleij@linaro.org>
-L:	linux-pci@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
-F:	drivers/pci/controller/pci-v3-semi.c
-
 PCIE DRIVER FOR SOCIONEXT UNIPHIER
 M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 L:	linux-pci@vger.kernel.org
@@ -13191,12 +13214,6 @@ S:	Maintained
 F:	Documentation/input/devices/pxrc.rst
 F:	drivers/input/joystick/pxrc.c
 
-FLYSKY FSIA6B RC RECEIVER
-M:	Markus Koch <markus@notsyncing.net>
-L:	linux-input@vger.kernel.org
-S:	Maintained
-F:	drivers/input/joystick/fsia6b.c
-
 PHONET PROTOCOL
 M:	Remi Denis-Courmont <courmisch@gmail.com>
 S:	Supported
@@ -13363,6 +13380,15 @@ M:	Logan Gunthorpe <logang@deltatee.com>
 S:	Maintained
 F:	drivers/dma/plx_dma.c
 
+PM-GRAPH UTILITY
+M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
+L:	linux-pm@vger.kernel.org
+W:	https://01.org/pm-graph
+B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
+T:	git git://github.com/intel/pm-graph
+S:	Supported
+F:	tools/power/pm-graph
+
 PMBUS HARDWARE MONITORING DRIVERS
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
@@ -13405,15 +13431,6 @@ L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/pm8001/
 
-PM-GRAPH UTILITY
-M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
-L:	linux-pm@vger.kernel.org
-W:	https://01.org/pm-graph
-B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
-T:	git git://github.com/intel/pm-graph
-S:	Supported
-F:	tools/power/pm-graph
-
 PNI RM3100 IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
@@ -13893,13 +13910,6 @@ F:	Documentation/devicetree/bindings/media/qcom,camss.txt
 F:	Documentation/media/v4l-drivers/qcom_camss.rst
 F:	drivers/media/platform/qcom/camss/
 
-QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
-M:	Ilia Lin <ilia.lin@kernel.org>
-L:	linux-pm@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
-F:	drivers/cpufreq/qcom-cpufreq-nvmem.c
-
 QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
 M:	Niklas Cassel <nks@flawful.org>
 L:	linux-pm@vger.kernel.org
@@ -13908,6 +13918,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 F:	drivers/power/avs/qcom-cpr.c
 
+QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
+M:	Ilia Lin <ilia.lin@kernel.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+F:	drivers/cpufreq/qcom-cpufreq-nvmem.c
+
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	netdev@vger.kernel.org
@@ -14103,6 +14120,11 @@ L:	linux-wireless@vger.kernel.org
 S:	Orphan
 F:	drivers/net/wireless/ray*
 
+RCMM REMOTE CONTROLS DECODER
+M:	Patrick Lerda <patrick9876@free.fr>
+S:	Maintained
+F:	drivers/media/rc/ir-rcmm-decoder.c
+
 RCUTORTURE TEST FRAMEWORK
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
@@ -14198,6 +14220,20 @@ F:	Documentation/devicetree/bindings/net/dsa/realtek-smi.txt
 F:	drivers/net/dsa/realtek-smi*
 F:	drivers/net/dsa/rtl83*
 
+REALTEK WIRELESS DRIVER (rtlwifi family)
+M:	Ping-Ke Shih <pkshih@realtek.com>
+L:	linux-wireless@vger.kernel.org
+W:	http://wireless.kernel.org/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
+S:	Maintained
+F:	drivers/net/wireless/realtek/rtlwifi/
+
+REALTEK WIRELESS DRIVER (rtw88)
+M:	Yan-Hsuan Chuang <yhchuang@realtek.com>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/realtek/rtw88/
+
 REDPINE WIRELESS DRIVER
 M:	Amitkumar Karwar <amitkarwar@gmail.com>
 M:	Siva Rebbagondla <siva8118@gmail.com>
@@ -14387,13 +14423,6 @@ S:	Maintained
 F:	drivers/media/platform/rockchip/rga/
 F:	Documentation/devicetree/bindings/media/rockchip-rga.txt
 
-HANTRO VPU CODEC DRIVER
-M:	Ezequiel Garcia <ezequiel@collabora.com>
-L:	linux-media@vger.kernel.org
-S:	Maintained
-F:	drivers/staging/media/hantro/
-F:	Documentation/devicetree/bindings/media/rockchip-vpu.txt
-
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
@@ -14493,20 +14522,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.g
 S:	Maintained
 F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
 
-REALTEK WIRELESS DRIVER (rtlwifi family)
-M:	Ping-Ke Shih <pkshih@realtek.com>
-L:	linux-wireless@vger.kernel.org
-W:	http://wireless.kernel.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
-S:	Maintained
-F:	drivers/net/wireless/realtek/rtlwifi/
-
-REALTEK WIRELESS DRIVER (rtw88)
-M:	Yan-Hsuan Chuang <yhchuang@realtek.com>
-L:	linux-wireless@vger.kernel.org
-S:	Maintained
-F:	drivers/net/wireless/realtek/rtw88/
-
 RTL8XXXU WIRELESS DRIVER (rtl8xxxu)
 M:	Jes Sorensen <Jes.Sorensen@gmail.com>
 L:	linux-wireless@vger.kernel.org
@@ -14596,6 +14611,18 @@ S:	Supported
 F:	arch/s390/pci/
 F:	drivers/pci/hotplug/s390_pci_hpc.c
 
+S390 VFIO AP DRIVER
+M:	Tony Krowiak <akrowiak@linux.ibm.com>
+M:	Pierre Morel <pmorel@linux.ibm.com>
+M:	Halil Pasic <pasic@linux.ibm.com>
+L:	linux-s390@vger.kernel.org
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+F:	drivers/s390/crypto/vfio_ap_drv.c
+F:	drivers/s390/crypto/vfio_ap_private.h
+F:	drivers/s390/crypto/vfio_ap_ops.c
+F:	Documentation/s390/vfio-ap.rst
+
 S390 VFIO-CCW DRIVER
 M:	Cornelia Huck <cohuck@redhat.com>
 M:	Eric Farman <farman@linux.ibm.com>
@@ -14614,18 +14641,6 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/s390/crypto/
 
-S390 VFIO AP DRIVER
-M:	Tony Krowiak <akrowiak@linux.ibm.com>
-M:	Pierre Morel <pmorel@linux.ibm.com>
-M:	Halil Pasic <pasic@linux.ibm.com>
-L:	linux-s390@vger.kernel.org
-W:	http://www.ibm.com/developerworks/linux/linux390/
-S:	Supported
-F:	drivers/s390/crypto/vfio_ap_drv.c
-F:	drivers/s390/crypto/vfio_ap_private.h
-F:	drivers/s390/crypto/vfio_ap_ops.c
-F:	Documentation/s390/vfio-ap.rst
-
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.ibm.com>
 M:	Benjamin Block <bblock@linux.ibm.com>
@@ -14993,21 +15008,6 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci*
 F:	include/linux/mmc/sdhci*
 
-EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
-M:	Adrian Hunter <adrian.hunter@intel.com>
-M:	Ritesh Harjani <riteshh@codeaurora.org>
-M:	Asutosh Das <asutoshd@codeaurora.org>
-L:	linux-mmc@vger.kernel.org
-S:	Maintained
-F:	drivers/mmc/host/cqhci*
-
-SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
-M:	Prabu Thangamuthu <prabu.t@synopsys.com>
-M:	Manjunath M B <manjumb@synopsys.com>
-L:	linux-mmc@vger.kernel.org
-S:	Maintained
-F:	drivers/mmc/host/sdhci-pci-dwc-mshc.c
-
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-mmc@vger.kernel.org
@@ -15106,6 +15106,14 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/serial_ir.c
 
+SERIAL LOW-POWER INTER-CHIP MEDIA BUS (SLIMbus)
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/slimbus/
+F:	Documentation/devicetree/bindings/slimbus/
+F:	include/linux/slimbus.h
+
 SFC NETWORK DRIVER
 M:	Solarflare linux maintainers <linux-net-drivers@solarflare.com>
 M:	Edward Cree <ecree@solarflare.com>
@@ -15251,12 +15259,6 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
-SIFIVE PDMA DRIVER
-M:	Green Wan <green.wan@sifive.com>
-S:	Maintained
-F:	drivers/dma/sf-pdma/
-F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
-
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
@@ -15275,6 +15277,12 @@ S:	Supported
 K:	fu540
 N:	fu540
 
+SIFIVE PDMA DRIVER
+M:	Green Wan <green.wan@sifive.com>
+S:	Maintained
+F:	drivers/dma/sf-pdma/
+F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+
 SILEAD TOUCHSCREEN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
@@ -15327,13 +15335,6 @@ F:	arch/arm/mach-s3c24xx/mach-bast.c
 F:	arch/arm/mach-s3c24xx/bast-ide.c
 F:	arch/arm/mach-s3c24xx/bast-irq.c
 
-SIPHASH PRF ROUTINES
-M:	Jason A. Donenfeld <Jason@zx2c4.com>
-S:	Maintained
-F:	lib/siphash.c
-F:	lib/test_siphash.c
-F:	include/linux/siphash.h
-
 SIOX
 M:	Thorsten Scherer <t.scherer@eckelmann.de>
 M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
@@ -15343,6 +15344,13 @@ F:	drivers/siox/*
 F:	drivers/gpio/gpio-siox.c
 F:	include/trace/events/siox.h
 
+SIPHASH PRF ROUTINES
+M:	Jason A. Donenfeld <Jason@zx2c4.com>
+S:	Maintained
+F:	lib/siphash.c
+F:	lib/test_siphash.c
+F:	include/linux/siphash.h
+
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
 L:	netdev@vger.kernel.org
@@ -15394,14 +15402,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
 
-SERIAL LOW-POWER INTER-CHIP MEDIA BUS (SLIMbus)
-M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-S:	Maintained
-F:	drivers/slimbus/
-F:	Documentation/devicetree/bindings/slimbus/
-F:	include/linux/slimbus.h
-
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
 L:	linux-security-module@vger.kernel.org
@@ -15481,6 +15481,29 @@ S:	Orphan
 F:	include/media/soc_camera.h
 F:	drivers/staging/media/soc_camera/
 
+SOCIONEXT (SNI) AVE NETWORK DRIVER
+M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/socionext/sni_ave.c
+F:	Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
+
+SOCIONEXT (SNI) NETSEC NETWORK DRIVER
+M:	Jassi Brar <jaswinder.singh@linaro.org>
+M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/socionext/netsec.c
+F:	Documentation/devicetree/bindings/net/socionext-netsec.txt
+
+SOCIONEXT (SNI) Synquacer SPI DRIVER
+M:	Masahisa Kojima <masahisa.kojima@linaro.org>
+M:	Jassi Brar <jaswinder.singh@linaro.org>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-synquacer.c
+F:	Documentation/devicetree/bindings/spi/spi-synquacer.txt
+
 SOCIONEXT SYNQUACER I2C DRIVER
 M:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-i2c@vger.kernel.org
@@ -15545,29 +15568,6 @@ F:	drivers/md/raid*
 F:	include/linux/raid/
 F:	include/uapi/linux/raid/
 
-SOCIONEXT (SNI) AVE NETWORK DRIVER
-M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	drivers/net/ethernet/socionext/sni_ave.c
-F:	Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
-
-SOCIONEXT (SNI) NETSEC NETWORK DRIVER
-M:	Jassi Brar <jaswinder.singh@linaro.org>
-M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	drivers/net/ethernet/socionext/netsec.c
-F:	Documentation/devicetree/bindings/net/socionext-netsec.txt
-
-SOCIONEXT (SNI) Synquacer SPI DRIVER
-M:	Masahisa Kojima <masahisa.kojima@linaro.org>
-M:	Jassi Brar <jaswinder.singh@linaro.org>
-L:	linux-spi@vger.kernel.org
-S:	Maintained
-F:	drivers/spi/spi-synquacer.c
-F:	Documentation/devicetree/bindings/spi/spi-synquacer.txt
-
 SOLIDRUN CLEARFOG SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
@@ -15915,16 +15915,24 @@ W:	http://wiki.laptop.org/go/DCON
 S:	Maintained
 F:	drivers/staging/olpc_dcon/
 
+STAGING - REALTEK RTL8188EU DRIVERS
+M:	Larry Finger <Larry.Finger@lwfinger.net>
+S:	Odd Fixes
+F:	drivers/staging/rtl8188eu/
+
 STAGING - REALTEK RTL8712U DRIVERS
 M:	Larry Finger <Larry.Finger@lwfinger.net>
 M:	Florian Schilhabel <florian.c.schilhabel@googlemail.com>.
 S:	Odd Fixes
 F:	drivers/staging/rtl8712/
 
-STAGING - REALTEK RTL8188EU DRIVERS
-M:	Larry Finger <Larry.Finger@lwfinger.net>
-S:	Odd Fixes
-F:	drivers/staging/rtl8188eu/
+STAGING - SEPS525 LCD CONTROLLER DRIVERS
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Beniamin Bia <beniamin.bia@analog.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Supported
+F:	drivers/staging/fbtft/fb_seps525.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 
 STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
@@ -15956,14 +15964,6 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/staging/wilc1000/
 
-STAGING - SEPS525 LCD CONTROLLER DRIVERS
-M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Beniamin Bia <beniamin.bia@analog.com>
-L:	linux-fbdev@vger.kernel.org
-S:	Supported
-F:	drivers/staging/fbtft/fb_seps525.c
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
-
 STAGING SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
@@ -16030,15 +16030,6 @@ S:	Supported
 F:	Documentation/networking/device_drivers/stmicro/
 F:	drivers/net/ethernet/stmicro/stmmac/
 
-EXTRA BOOT CONFIG
-M:	Masami Hiramatsu <mhiramat@kernel.org>
-S:	Maintained
-F:	lib/bootconfig.c
-F:	fs/proc/bootconfig.c
-F:	include/linux/bootconfig.h
-F:	tools/bootconfig/*
-F:	Documentation/admin-guide/bootconfig.rst
-
 SUN3/3X
 M:	Sam Creasey <sammy@sammy.net>
 W:	http://sammy.net/sun3/
@@ -16230,6 +16221,13 @@ F:	drivers/reset/reset-hsdk.c
 F:	include/dt-bindings/reset/snps,hsdk-reset.h
 F:	Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
 
+SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
+M:	Prabu Thangamuthu <prabu.t@synopsys.com>
+M:	Manjunath M B <manjumb@synopsys.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sdhci-pci-dwc-mshc.c
+
 SYSTEM CONFIGURATION (SYSCON)
 M:	Lee Jones <lee.jones@linaro.org>
 M:	Arnd Bergmann <arnd@arndb.de>
@@ -16543,6 +16541,13 @@ M:	Mark Gross <mark.gross@intel.com>
 S:	Supported
 F:	drivers/char/tlclk.c
 
+TEMPO SEMICONDUCTOR DRIVERS
+M:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
+S:	Maintained
+F:	sound/soc/codecs/tscs*.c
+F:	sound/soc/codecs/tscs*.h
+F:	Documentation/devicetree/bindings/sound/tscs*.txt
+
 TENSILICA XTENSA PORT (xtensa)
 M:	Chris Zankel <chris@zankel.net>
 M:	Max Filippov <jcmvbkbc@gmail.com>
@@ -16552,6 +16557,19 @@ S:	Maintained
 F:	arch/xtensa/
 F:	drivers/irqchip/irq-xtensa-*
 
+Texas Instruments ASoC drivers
+M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/ti/
+
+Texas Instruments' DAC7612 DAC Driver
+M:	Ricardo Ribalda <ricardo@ribalda.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/dac/ti-dac7612.c
+F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
+
 Texas Instruments' System Control Interface (TISCI) Protocol Driver
 M:	Nishanth Menon <nm@ti.com>
 M:	Tero Kristo <t-kristo@ti.com>
@@ -16575,19 +16593,6 @@ F:	drivers/irqchip/irq-ti-sci-inta.c
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	drivers/soc/ti/ti_sci_inta_msi.c
 
-Texas Instruments ASoC drivers
-M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-S:	Maintained
-F:	sound/soc/ti/
-
-Texas Instruments' DAC7612 DAC Driver
-M:	Ricardo Ribalda <ricardo@ribalda.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-F:	drivers/iio/dac/ti-dac7612.c
-F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
-
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
@@ -16610,6 +16615,15 @@ F:	include/uapi/linux/thermal.h
 F:	include/linux/cpu_cooling.h
 F:	Documentation/devicetree/bindings/thermal/
 
+THERMAL DRIVER FOR AMLOGIC SOCS
+M:	Guillaume La Roque <glaroque@baylibre.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+W:	http://linux-meson.com/
+S:	Supported
+F:	drivers/thermal/amlogic_thermal.c
+F:	Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+
 THERMAL/CPU_COOLING
 M:	Amit Daniel Kachhap <amit.kachhap@gmail.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
@@ -16623,15 +16637,6 @@ F:	drivers/thermal/cpufreq_cooling.c
 F:	drivers/thermal/cpuidle_cooling.c
 F:	include/linux/cpu_cooling.h
 
-THERMAL DRIVER FOR AMLOGIC SOCS
-M:	Guillaume La Roque <glaroque@baylibre.com>
-L:	linux-pm@vger.kernel.org
-L:	linux-amlogic@lists.infradead.org
-W:	http://linux-meson.com/
-S:	Supported
-F:	drivers/thermal/amlogic_thermal.c
-F:	Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
-
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
@@ -17047,13 +17052,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
 S:	Maintained
 K:	^Subject:.*(?i)trivial
 
-TEMPO SEMICONDUCTOR DRIVERS
-M:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
-S:	Maintained
-F:	sound/soc/codecs/tscs*.c
-F:	sound/soc/codecs/tscs*.h
-F:	Documentation/devicetree/bindings/sound/tscs*.txt
-
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jslaby@suse.com>
@@ -17642,6 +17640,13 @@ S:	Maintained
 F:	Documentation/fb/uvesafb.rst
 F:	drivers/video/fbdev/uvesafb.*
 
+Ux500 CLOCK DRIVERS
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-clk@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/clk/ux500/
+
 VF610 NAND DRIVER
 M:	Stefan Agner <stefan@agner.ch>
 L:	linux-mtd@lists.infradead.org
@@ -17721,18 +17726,18 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/platform/vicodec/*
 
-VIDEO MULTIPLEXER DRIVER
-M:	Philipp Zabel <p.zabel@pengutronix.de>
-L:	linux-media@vger.kernel.org
-S:	Maintained
-F:	drivers/media/platform/video-mux.c
-
 VIDEO I2C POLLING DRIVER
 M:	Matt Ranostay <matt.ranostay@konsulko.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/video-i2c.c
 
+VIDEO MULTIPLEXER DRIVER
+M:	Philipp Zabel <p.zabel@pengutronix.de>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/platform/video-mux.c
+
 VIDEOBUF2 FRAMEWORK
 M:	Pawel Osciak <pawel@osciak.com>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
@@ -17779,6 +17784,19 @@ F:	drivers/net/vsockmon.c
 F:	drivers/vhost/vsock.c
 F:	tools/testing/vsock/
 
+VIRTIO BLOCK AND SCSI DRIVERS
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	Jason Wang <jasowang@redhat.com>
+R:	Paolo Bonzini <pbonzini@redhat.com>
+R:	Stefan Hajnoczi <stefanha@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/block/virtio_blk.c
+F:	drivers/scsi/virtio_scsi.c
+F:	include/uapi/linux/virtio_blk.h
+F:	include/uapi/linux/virtio_scsi.h
+F:	drivers/vhost/scsi.c
+
 VIRTIO CONSOLE DRIVER
 M:	Amit Shah <amit@kernel.org>
 L:	virtualization@lists.linux-foundation.org
@@ -17802,19 +17820,6 @@ F:	include/uapi/linux/virtio_*.h
 F:	drivers/crypto/virtio/
 F:	mm/balloon_compaction.c
 
-VIRTIO BLOCK AND SCSI DRIVERS
-M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
-R:	Paolo Bonzini <pbonzini@redhat.com>
-R:	Stefan Hajnoczi <stefanha@redhat.com>
-L:	virtualization@lists.linux-foundation.org
-S:	Maintained
-F:	drivers/block/virtio_blk.c
-F:	drivers/scsi/virtio_scsi.c
-F:	include/uapi/linux/virtio_blk.h
-F:	include/uapi/linux/virtio_scsi.h
-F:	drivers/vhost/scsi.c
-
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
 L:	virtualization@lists.linux-foundation.org
@@ -18134,11 +18139,6 @@ M:	David Härdeman <david@hardeman.nu>
 S:	Maintained
 F:	drivers/media/rc/winbond-cir.c
 
-RCMM REMOTE CONTROLS DECODER
-M:	Patrick Lerda <patrick9876@free.fr>
-S:	Maintained
-F:	drivers/media/rc/ir-rcmm-decoder.c
-
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-watchdog@vger.kernel.org
@@ -18422,6 +18422,13 @@ F:	drivers/scsi/xen-scsifront.c
 F:	drivers/xen/xen-scsiback.c
 F:	include/xen/interface/io/vscsiif.h
 
+XEN SOUND FRONTEND DRIVER
+M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
+L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/xen/*
+
 XEN SWIOTLB SUBSYSTEM
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
@@ -18430,13 +18437,6 @@ S:	Supported
 F:	arch/x86/xen/*swiotlb*
 F:	drivers/xen/*swiotlb*
 
-XEN SOUND FRONTEND DRIVER
-M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
-L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-S:	Supported
-F:	sound/xen/*
-
 XFS FILESYSTEM
 M:	Darrick J. Wong <darrick.wong@oracle.com>
 M:	linux-xfs@vger.kernel.org
@@ -18465,6 +18465,17 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/xilinx_can.txt
 F:	drivers/net/can/xilinx_can.c
 
+XILINX SD-FEC IP CORES
+M:	Derek Kiernan <derek.kiernan@xilinx.com>
+M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+F:	Documentation/misc-devices/xilinx_sdfec.rst
+F:	drivers/misc/xilinx_sdfec.c
+F:	drivers/misc/Kconfig
+F:	drivers/misc/Makefile
+F:	include/uapi/misc/xilinx_sdfec.h
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
@@ -18481,17 +18492,6 @@ F:	Documentation/devicetree/bindings/media/xilinx/
 F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
-XILINX SD-FEC IP CORES
-M:	Derek Kiernan <derek.kiernan@xilinx.com>
-M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
-F:	Documentation/misc-devices/xilinx_sdfec.rst
-F:	drivers/misc/xilinx_sdfec.c
-F:	drivers/misc/Kconfig
-F:	drivers/misc/Makefile
-F:	include/uapi/misc/xilinx_sdfec.h
-
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org


