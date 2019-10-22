Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE75CE03AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 14:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbfJVMOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 08:14:41 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388552AbfJVMOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:14:40 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N94FT-1hzG5w0ynf-0163wO; Tue, 22 Oct 2019 14:14:39 +0200
Received: by mail-qt1-f173.google.com with SMTP id o49so18528472qta.7;
        Tue, 22 Oct 2019 05:14:38 -0700 (PDT)
X-Gm-Message-State: APjAAAWhI0hzM0vbW0n0IVJBI4DTREhNH2/9q8A2dMgEqBqBeaGNtqnR
        N1cmFPhOpyMkJcM0a3KeJ8TaWPnj3xF+yvg9CbE=
X-Google-Smtp-Source: APXvYqwo4iaXiWc9keweLjxIvSCa7w0jFkiDPZWKviou4a0Bxa+qtglo0QV3JQ+Kl6v/4gAkkG+1IujkTObOOFibW4w=
X-Received: by 2002:a0c:d0e1:: with SMTP id b30mr2712706qvh.197.1571746477934;
 Tue, 22 Oct 2019 05:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191009190853.245077-1-arnd@arndb.de> <20191009191044.308087-10-arnd@arndb.de>
 <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
 <CAK8P3a0BYkPTSnQUmde2k+HVcg7XNihzWTEzrCD4d8G8ecO9-w@mail.gmail.com> <20191022043051.GA20354@ZenIV.linux.org.uk>
In-Reply-To: <20191022043051.GA20354@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Oct 2019 14:14:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3yutJU83AfxKXTFuCVQwsX50KYsDgbGbHeJJ0JoLbejg@mail.gmail.com>
Message-ID: <CAK8P3a3yutJU83AfxKXTFuCVQwsX50KYsDgbGbHeJJ0JoLbejg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v6 10/43] compat_ioctl: move rtc handling into rtc-dev.c
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/sHdnSiMoAnuM2mO95KOE1bx19PpHaydUFH1K+CfceIAFsFpJAM
 rHUGwT7BLz6Nf6J3HzeN0wmpzHtsk+andbk3mN6fst1uJoDtrgDM1iqpwO+4x8pOh4rx0Hz
 J788tLZ8Jcb2nlqTm79+wmsBwrlIIn9BteVWN0KpNR8mVajx7S3ufQPSP4hXXe9xgEPBL6o
 Tq2fW98R+vMFfw32z0X7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hz09wcLX470=:PJGHc4BNLHrKEDiBlWzeo0
 qg+wjdYtLVinPq6/kb5HqpC3WTomSRIIC/882A3Rp1pp1X6k3fDRrsLOYsqjtDg/2AngeC3Po
 +gcXPBdvSDPRMPFO/SUIxwo9AsUlL86gt0lZ54FSqgdD+43WwLV99b8oESOlVo0fENg7UnlU3
 dGqnisbDj3eBPoI41g5CdwxLrl0rEBGltmJrNQnRQHSqIEIj5YwF1v4xcCgfyVzjkeFne1fpP
 +KF8QiXdeq42TfF8ZVQJTF6z4ynjV8gJ8ydk7w8R8NXlvTaozZpNqizW/606u+WliaomFJ+JS
 bb6MbbcO2rcqerDAmYDeVIl7EIFeRygTPdvy+UoEADrP7MGr9FU/8Ss/qhh/c2VFU+WVc9oH+
 hHlFo4SB6I1okQRf2niB9NpPBm25KnMnb+6K7cmWmhuBwzV9fo2lYqRMhHyWVmmU3EWH6fhX3
 4q4mkO47CZfKy1n07YbeFzl/Zrl+ZdUPsT83O7igTaAKTpi/zW/D/rS2i6zg0VaQK9QGBaO7W
 2N9irEMD7wIMFL8z3wytwyVV2E5tDRpvX4RrGb6HWfq3Q8Udsg0FWZXP5/dGDJvMaOlwlE2S1
 heNOXCveXxZDCldYhvkPAjuBav3a3iwjDRMuaGve0E5VScKpunJPw0Im765axTG/bTsdCtx/3
 ikvyoLKMuQ9TC8iEJa0U2e2rQuaqclRdzGiC0VcsdBMox5PwfBQ91pvHsEHyhlc4/1IOzNAXL
 XCB5qkJZ7KFsSu6ioaYkUCDIJgNTCNxrj5vc658gUWhDmfvCOR3ewDEt5WTBtScnYzThr0oG8
 pStovhV2K+CTjj9L6gj3PhDG5G6nRU7Emk+s2vS3wABdgokWGrLJnUa3yCXtGAv09IWJLJIjW
 F9L+UFH0M00un80xvusA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 6:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Oct 17, 2019 at 04:33:09PM +0200, Arnd Bergmann wrote:
>
> > However, looking at this again after your comment I found a rather
> > more serious bug in my new RTC_IRQP_SET handling: Any 64-bit
> > machine can now bypass the permission check for RTC_IRQP_SET by
> > calling RTC_IRQP_SET32 instead.
>
> You've lost the check on RTC_EPOCH_SET as well.

Right, originally my plan was to keep the epoch handling local to
rtc-vr41xx.c as explained in the patch description. The driver is
specific to a particular very obsolete MIPS machine that was
apparently only ever used with 32-bit kernels.

I guess it can't hurt to treat it the same as RTC_IRQP_SET32
if you prefer. Folding in this change now and adapting the
changelog text:

--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -402,6 +402,7 @@ static long rtc_dev_ioctl(struct file *file,
 #ifdef CONFIG_COMPAT
 #define RTC_IRQP_SET32         _IOW('p', 0x0c, __u32)
 #define RTC_IRQP_READ32                _IOR('p', 0x0b, __u32)
+#define RTC_EPOCH_SET32                _IOW('p', 0x0e, __u32)

 static long rtc_dev_compat_ioctl(struct file *file,
                                 unsigned int cmd, unsigned long arg)
@@ -416,6 +417,10 @@ static long rtc_dev_compat_ioctl(struct file *file,
        case RTC_IRQP_SET32:
                /* arg is a plain integer, not pointer */
                return rtc_dev_ioctl(file, RTC_IRQP_SET, arg);
+
+       case RTC_EPOCH_SET32:
+               /* arg is a plain integer, not pointer */
+               return rtc_dev_ioctl(file, RTC_EPOCH_SET, arg);
        }

        return rtc_dev_ioctl(file, cmd, (unsigned long)uarg);
diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 79f27de545af..c3671043ace7 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -69,7 +69,6 @@ static void __iomem *rtc2_base;

 /* 32-bit compat for ioctls that nobody else uses */
 #define RTC_EPOCH_READ32       _IOR('p', 0x0d, __u32)
-#define RTC_EPOCH_SET32                _IOW('p', 0x0e, __u32)

 static unsigned long epoch = 1970;     /* Jan 1 1970 00:00:00 */

@@ -187,7 +186,6 @@ static int vr41xx_rtc_ioctl(struct device *dev,
unsigned int cmd, unsigned long
 #ifdef CONFIG_64BIT
        case RTC_EPOCH_READ32:
                return put_user(epoch, (unsigned int __user *)arg);
-       case RTC_EPOCH_SET32:
 #endif
        case RTC_EPOCH_SET:
                /* Doesn't support before 1900 */

> Another potential issue is drivers/input/misc/hp_sdc_rtc.c,
> provided that the hardware in question might possibly exist
> on hppa64 boxen - CONFIG_GSC defaults to y and it's not
> 32bit-only, so that thing is at least selectable on 64bit
> kernels.

I decided long ago not to care: that code has never compiled after
it was originally merged into the kernel in 2005:

static int hp_sdc_rtc_ioctl(struct inode *inode, struct file *file,
                           unsigned int cmd, unsigned long arg)
{
#if 1
       return -EINVAL;
#else
      ...
    RTC_IRQP_SET, RTC_EPOCH_SET, ...
      ...
#endif
}

I don't see any chance that this code is revived. If anyone wanted to
make it work, the right approach would be to use the rtc framework
and rewrite the code first.

I could send a patch to remove the dead code though if that helps.

     Arnd
