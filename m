Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F37743FFDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 17:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJ2PyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhJ2PyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:54:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF54C061714;
        Fri, 29 Oct 2021 08:51:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s1so40256164edd.3;
        Fri, 29 Oct 2021 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NESlwwMORorwSWYzWjNc0O70aEVgaVjtuvkdZI1/8es=;
        b=KtJDps6dyol74mgZwTFC89lUznMWMTflRjyEGBQg8fGTIHN4eS84jauTuUjHSkxHST
         dg466nqGzuri8/DlWUUN8zd2NaCCz0U8kvOGxHCqjTMGdZ6iMDYunWvuGt2cOtXkcv/e
         Ue2xn0HPWcE13DrP2OOnzAVehZzgf7sonec4sRhiS1xjKpw6AHFzBdaM06bbQlJ7Ja6j
         DqvSlb2Et8rx+kql0yC4WX+v7blifYbbw8XxCxbiTrhkRNvvRa2UjvXED5+77b1wlOPY
         lBS+nUPNJn2q/KU3a4esLsUmSIB7aVNfjuXrsKyw+tg80XBA+VjpMSYDL8e2U0sAf4mG
         8W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NESlwwMORorwSWYzWjNc0O70aEVgaVjtuvkdZI1/8es=;
        b=IL3WJ5eAgcGwVVL69Y8FLZVE3zcGbUKQ/yzWZyy+Q8uu9RV8i2Ro2GZWqFz6DnlAMp
         ankvuDDSM+lAHUj/Gwtwm06bYSQGxvoqlAEdfToDAScoRjcbn9ulyzYSkKPuWwzC323x
         qJzbRENJky/4iqUhePkcCutt2ESqhFJnH6j9bIHMJjthColtEmKK05lP9H0kEVyb/1Tp
         8UkrQvF54Xhc7Wwtcmt+1dUfgSL58IXb2QFOmOQFcQQoDZguc2EM82xJ7ksr4Nil9dxR
         zOpWG822uXhTbisrDi2BCLq42uLYaGUah0jxjZGzybFU0Wi4wcmScaDK1gjNoeUtmpc0
         QkBA==
X-Gm-Message-State: AOAM530/+CbR+RScdKX4btlx+OjU2X+KAxSMQW0OCxDxwQ1TIqlooTy9
        CyjvUQgMevWwyU42kUasL1hCpiDqYUExXei0wmU=
X-Google-Smtp-Source: ABdhPJwaZoIDWVCGaHYKcnttqgtKxA/h8msb9rhToLx+whKahsfVfCWinU7ltf1BsXNc6XsBxJ1fumjug1/uaYuC90g=
X-Received: by 2002:a05:6402:274f:: with SMTP id z15mr16361253edd.306.1635522704379;
 Fri, 29 Oct 2021 08:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
 <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
 <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
 <20210830185541.715f6a39@windsurf> <CAOuPNLhTidgLNWUbtUgdESYcKcE1C4SOdzKeQVhFGQvEoc0QEg@mail.gmail.com>
 <20210830211224.76391708@windsurf> <CAOuPNLgMd0AThhmSknbmKqp3_P8PFhBGr-jW0Mqjb6K6NchEMg@mail.gmail.com>
 <CAOuPNLiW10-E6F_Ndte7U9NPBKa9Y_UuLhgdwAYTc0eYMk5Mqg@mail.gmail.com>
 <CAOuPNLj2Xmx52Gtzx5oEKif4Qz-Tz=vaxhRvHQG-5emO7ewRhg@mail.gmail.com> <YTinqiH9h+Q9bYsr@kroah.com>
In-Reply-To: <YTinqiH9h+Q9bYsr@kroah.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 29 Oct 2021 21:21:33 +0530
Message-ID: <CAOuPNLhzfGDoQsEZB5eH30WvH2w9hyMEU8Bt81SzK-scaAwgwA@mail.gmail.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sami Tolvanen <samitolvanen@google.com>, snitzer@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        open list <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>, agk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

On Wed, 8 Sept 2021 at 17:38, Greg KH <gregkh@linuxfoundation.org> wrote:

> > > > > No, but you can backport it easily. Back at
> > > > > http://lists.infradead.org/pipermail/openwrt-devel/2019-November/025967.html
> > > > > I provided backports of this feature to OpenWrt, for the 4.14 and 4.19
> > > > > kernels.
> >
> > Can you please let me know where to get the below patches for
> > backporting to our kernel:
> >  create mode 100644
> > target/linux/generic/backport-4.14/390-dm-add-support-to-directly-boot-to-a-mapped-device.patch
> >  create mode 100644
> > target/linux/generic/backport-4.14/391-dm-init-fix-max-devices-targets-checks.patch
> >  create mode 100644
> > target/linux/generic/backport-4.14/392-dm-ioctl-fix-hang-in-early-create-error-condition.patch
> >  create mode 100644
> > target/linux/generic/backport-4.14/393-Documentation-dm-init-fix-multi-device-example.patch
>
> If you are stuck on an older kernel version, then you need to get
> support from the vendor that is forcing you to be on that kernel
> version, as you are already paying them for support.  Please take
> advantage of that, as no one knows what is really in "your kernel".
>

This is to update this thread that now I am able to successfully
bring-up dm-verity with NAND+ubiblock+squashfs on our 4.14 kernel
itself without backporting the patches.
Now, I am able to boot dm-verity using both initramfs and bootloader approach.
The initramfs booting issue was our internal issue which was related
to Kernel size configuration in UEFI.
The bootloader approach issue was related to system image size issue,
where we need to pass the exact image size to find the verity-metadata
offset at the end of system image.

However, I felt that dm-verity documentation still needs to be
enhanced further with a better example.
With the 5.4 Kernel, I may further explore the option of using
dm-mod.create option, then I might get more clarity on how best to use
it.

Thank you all for your help and support!

Regards,
Pintu
