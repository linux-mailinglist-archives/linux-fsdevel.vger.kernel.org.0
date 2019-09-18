Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77414B6F4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbfIRWRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 18:17:21 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33364 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbfIRWRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:17:21 -0400
Received: by mail-ua1-f67.google.com with SMTP id u31so430198uah.0;
        Wed, 18 Sep 2019 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvyK6cOQSVAg+pYnospWHicPx4sekfGX7Yi8JoZJ894=;
        b=RQqY6qxStYD6GrM+3jvoM7UqPq/BBlPGOnsRl8/61T8a4RBMc166iouDxrMerp5XJq
         yp9im9pXXkI0a5IeS1reX/+bPGNUHz5jyYNW1ORYOhKcvAd6kb2oXTWCpOPREuUlqzr4
         Gds9kNT0NxZ4U9njJUGxd4U7HFL1yxOWD9nbkSpJKNk5GIyjVVN2FQR81CrRh9lzDroH
         aPPA+0XrG4kCcNZ+cgwl3HFVlZZW28ItUHhbSbDUP3XD58dBmuKo07uctb1NhwQdyzlR
         15egksXX+lF/OLrytz2U/Dkkgrj7NVYhHxdgfFo6nK+eCMLpMvT5I2eMpXxzNqzocIOP
         Pvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvyK6cOQSVAg+pYnospWHicPx4sekfGX7Yi8JoZJ894=;
        b=ac3J64tFeMtrlOGqcqC2ikdIvXLco0VBRmug6Vl5EUY1cwo+9cOC167uievoBInOCK
         QuCcSzGnSztFNRupe2kjboYqO9dDN/0I4gN8r95xqgfaBATO3Y37lK/tcQL10ssJicnl
         9J+FWwf82DszUe145KpugWXZZRO+IFSzQsWpEn7yUec4XxzxT12LLIaqAVPKKTnJbzn1
         tUNJM3S1kWPIr7nOAk1J3dA+FstYN9XWi8+/UrdLKg0nZLewyd0CnLL+2f0h2eV/sp/P
         RFSgWpwihnUVlCudwmw16dxQBV0kjv/hnqXqV9pg5Dsdticc9e7o6BFQDYD4+g2Uv6Y6
         oRhg==
X-Gm-Message-State: APjAAAVtc3vIWFXI8MhGjvXrK3TRyiZhVssLhX804hbfhxNSiM98Sm1v
        RuAl6frahIeZ9FAy6NOTOghMxRAeCBRCTS99Tec=
X-Google-Smtp-Source: APXvYqxr6YANlJ2C8oJKmxha7piyJuTYMt0okrOTrbCDI/e1c9lkVDzuxCa2GvYTvrdzw+znKPnsKc9jWeGrUTmw3V4=
X-Received: by 2002:ab0:7816:: with SMTP id x22mr3891970uaq.97.1568845040262;
 Wed, 18 Sep 2019 15:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190918195920.25210-1-qkrwngud825@gmail.com> <201909190546.Al3zu1Yd%lkp@intel.com>
In-Reply-To: <201909190546.Al3zu1Yd%lkp@intel.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Thu, 19 Sep 2019 07:17:09 +0900
Message-ID: <CAD14+f2b=eTOZqhfa-KGp+w8i1GfGhpzY9yWKWvh+wRRp9BUDw@mail.gmail.com>
Subject: Re: [PATCH] staging: exfat: rebase to sdFAT v2.2.0
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Greg KH <gregkh@linuxfoundation.org>,
        alexander.levin@microsoft.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        sergey.senozhatsky@gmail.com, sj1557.seo@samsung.com,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Welp, looks like I didn't test debug configs properly.

Allow me 1-2 days to work on fixing it for v2.

Thanks in advance.

On Thu, Sep 19, 2019 at 6:31 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Park,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3 next-20190917]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Park-Ju-Hyung/staging-exfat-rebase-to-sdFAT-v2-2-0/20190919-040526
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/staging/exfat/super.c: In function 'exfat_debug_kill_sb':
> >> drivers/staging/exfat/super.c:3079:4: error: implicit declaration of function 'exfat_cache_release'; did you mean 'exfat_dcache_release'? [-Werror=implicit-function-declaration]
>        exfat_cache_release(sb);
>        ^~~~~~~~~~~~~~~~~~~
>        exfat_dcache_release
>    cc1: some warnings being treated as errors
> --
>    drivers/staging/exfat/misc.c: In function 'exfat_uevent_ro_remount':
> >> drivers/staging/exfat/misc.c:57:2: error: implicit declaration of function 'ST_LOG'; did you mean 'DT_REG'? [-Werror=implicit-function-declaration]
>      ST_LOG("[EXFAT](%s[%d:%d]): Uevent triggered\n",
>      ^~~~~~
>      DT_REG
>    cc1: some warnings being treated as errors
>
> vim +3079 drivers/staging/exfat/super.c
>
>   3063
>   3064  #ifdef CONFIG_EXFAT_DBG_IOCTL
>   3065  static void exfat_debug_kill_sb(struct super_block *sb)
>   3066  {
>   3067          struct exfat_sb_info *sbi = EXFAT_SB(sb);
>   3068          struct block_device *bdev = sb->s_bdev;
>   3069
>   3070          long flags;
>   3071
>   3072          if (sbi) {
>   3073                  flags = sbi->debug_flags;
>   3074
>   3075                  if (flags & EXFAT_DEBUGFLAGS_INVALID_UMOUNT) {
>   3076                          /* invalidate_bdev drops all device cache include dirty.
>   3077                           * we use this to simulate device removal
>   3078                           */
> > 3079                          exfat_cache_release(sb);
>   3080                          invalidate_bdev(bdev);
>   3081                  }
>   3082          }
>   3083
>   3084          kill_block_super(sb);
>   3085  }
>   3086  #endif /* CONFIG_EXFAT_DBG_IOCTL */
>   3087
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
