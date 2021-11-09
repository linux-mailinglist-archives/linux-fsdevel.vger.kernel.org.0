Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61E944B079
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhKIPhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 10:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKIPhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:37:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B3C061764;
        Tue,  9 Nov 2021 07:35:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v11so75916454edc.9;
        Tue, 09 Nov 2021 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qNKxbY+CJKEKz5I5jfTajE0gm0ARDEZSOX6nNnQ06Ds=;
        b=TXmn+AUrGkmNG6aVTCQ0ceEBQWA2M0tCUS/XInhy1eodftrDVpbDBrlqrZo3ouldi8
         NJkXvXRXOaayYgUBC4m23zYND11+H90KgMe/DtN010GUmH+cm1Ca1n7elJHv1GuOq93i
         jhdYBhtB4KGGjpHGGM7alNugiLoMwZP0z9QLW1x3qBvAr8c+csj5oVu8tUSZqu3SSgZL
         w7RgWjtzV6oyKMBvdonnmhOCh4vx/Ug1DvwGx8uRM504DeU1cbpsWiKNk0iRbFQEAYoz
         88cyNWDPAcDtw5ltRTqLeART8tt8Qzj25UE+9iScIm8svh+kBXJuTXw4GpPKmboPJjPk
         57CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qNKxbY+CJKEKz5I5jfTajE0gm0ARDEZSOX6nNnQ06Ds=;
        b=dK9V518Oew/iXxYOdSYnVYguWNPR5M22wEdSD410b3R6iGcF9vL+tULQpoQSVKV3/U
         drTATkWuumYJ/W4ND4v2hAZRamLQFN4nElgOC3zmigBTvKqflc2V/NxbW2sA2vfImoYL
         hMB3WF7sRS/fcZKtMAdengFgeGkjXM5Fjei9RuvgghVT+x3yboGtr4aERqltLofcAZxJ
         TfphXh7cDXpiHW1YQ8lfh4gS8Kcdt5LjT6k0X4LycxvkXvsfpmQKtnLP0zY3dhe/zt/S
         bj10mRDBkisafuEA8xhAe+UhkQcB3EJfDccL4tgVXsjBYPiPbOBnThxwgN2XvYMzQ9Le
         jyLg==
X-Gm-Message-State: AOAM530R0tjHVYtINa+iEdes1tJtljY4v3m3rB7dABFvy8WGkcQlGyTx
        Nr0mTmbHut03rWPw7MKpF0sgMSQ4J6uQpEzOT6WCHyvkgM4=
X-Google-Smtp-Source: ABdhPJz3XYwx9pVakfx2STu6CYLqj/G+Ya7i+K/njYwnyhQXDgoupRe5ikHsWAMxrdD4KeZhZ4/qfjONVlKpPr2sjMc=
X-Received: by 2002:a05:6402:3586:: with SMTP id y6mr11479655edc.332.1636472102206;
 Tue, 09 Nov 2021 07:35:02 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLinoW5Cx=xbUcT-DB4RiQkAPpe=9hsc-Rkch0LxD0mh+Q@mail.gmail.com>
 <CAOuPNLgquwOJg85kDcf67+4kTYP9N=45FvV+VDTJr6txYi5-wg@mail.gmail.com>
In-Reply-To: <CAOuPNLgquwOJg85kDcf67+4kTYP9N=45FvV+VDTJr6txYi5-wg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 9 Nov 2021 21:04:50 +0530
Message-ID: <CAOuPNLjFtS7ftg=+-K3S+0ndyNYmUNqXo7SHkyV4zK4G9bZ4Og@mail.gmail.com>
Subject: Re: Kernel-4.14: With ubuntu-18.04 building rootfs images and booting
 gives SQUASHFS error: xz decompression failed, data probably corrupt
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com, Phillip Lougher <phillip@squashfs.org.uk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Florian Fainelli <f.fainelli@gmail.com>,
        sumit.semwal@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 9 Nov 2021 at 16:45, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> On Mon, 8 Nov 2021 at 20:00, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Hi,
> > Here are few details.
> > * Linux Kernel: 4.14
> > * Processor: Qualcomm Arm32 Cortex-A7
> > * Storage: NAND 512MB
> > * Platform: Simple busybox
> > * Filesystem: UBIFS, Squashfs
> > * Build system: Linux Ubuntu 18.04 with Yocto build system
> > * Consists of nand raw partitions, squashfs ubi volumes.
> >
> > What we are trying to do:
> > We are trying to boot dm-verity enabled rootfs on our system.
> > The images for rootfs were generated on Ubuntu 18.04 machine using
> > Yocto build system.
> >
> > Issue:
> > Earlier, when we were using Ubuntu 16.04 to generate our images, the
> > system was booting fine even with dm-verity enabled.
> > Recently we switched to Ubuntu 18.04 build machine, and now with the
> > same changes we are seeing the below squashfs error, just after the
> > mount.
> > Note: with 18.04 also our rootfs is mounting successfully and
> > dm-verity is also working fine.
> > We only get these squashfs errors flooded in the boot logs:
> > {{{
> > ....
> > [    5.153479] device-mapper: init: dm-0 is ready
> > [    5.334282] VFS: Mounted root (squashfs filesystem) readonly on device 253:0.
> > ....
> > [    8.954120] SQUASHFS error: xz decompression failed, data probably corrupt
> > [    8.954153] SQUASHFS error: squashfs_read_data failed to read block 0x1106
> > [    8.970316] SQUASHFS error: Unable to read data cache entry [1106]
> > [    8.970349] SQUASHFS error: Unable to read page, block 1106, size 776c
> > [    8.980298] SQUASHFS error: Unable to read data cache entry [1106]
> > [    8.981911] SQUASHFS error: Unable to read page, block 1106, size 776c
> > [    8.988280] SQUASHFS error: Unable to read data cache entry [1106]
> > ....
> > }}}
> >
> Just one question:
> Is there any history about these squashfs errors while cross-compiling
> images on Ubuntu 18.04 or higher ?
>
One quick observation:
This issue is seen only when we enable dm-verity in our bootloader and
cross-building the bootloader/kernel (with Yocto 2.6 toolchain
arm-oe-linux-gnueabi-) on Ubuntu 18.04.
The issue is *NOT* seen (on the same device) when building the
dm-verity enabled kernel on Ubuntu 16.04.

Is it something to do with the cross-toolchain difference between
Ubuntu 16 and 18 ?


Thanks,
Pintu
