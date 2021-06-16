Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1C3A99A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 13:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhFPL4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 07:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhFPL4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:56:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13215C061760;
        Wed, 16 Jun 2021 04:54:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w21so2318591edv.3;
        Wed, 16 Jun 2021 04:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srb2aA4QI+Kt38SYZXXO2+WoZGE2YUSVVf+BZ30Sr7M=;
        b=EJNlFoLCeiKYalj/YVM+4iOQNt4iIZz3fgUM5iOrsviVv2bsoYVtmFWOfbjgcRRsEN
         vsiiF6q6jDEVfkw6XEqvvp9/NKAOKakwPCncGWwqO7L+g3IrvThkmPsYUDXWgcH44QWQ
         KGPjQwln4fSmxzb4t5U/A/QUaL4shTIIcPNLOZZr59vBdwn6X4rVKj5N+OvQ+hSv0mru
         P7Vl2BgubMqZwgwDrIfywFTnVy+BZJpnyIG+DEm1HFegF/0RHghNdP/Cf0ypfQx/cqyf
         NqAoyUlTP49E1MUadmEOc+29XrW2DQFtYeeH5FKJlHH6QhqRUFxThW4eG3OrGifUHzmn
         I2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srb2aA4QI+Kt38SYZXXO2+WoZGE2YUSVVf+BZ30Sr7M=;
        b=D0oVI300Oo08UvCAiBZPukj1MScQZxM9R5OD4BZGAabzlhq0FH/Kk9yCd/pE3dIRxo
         7iXwOvTG94ThEteU8FWBOZZdvoa5krVav9uqI379PET4sKP0covQEyuzPxdwMd2dTVib
         Eu26aShak3TDrDfXoQ24zEoYV8bLqIvxiXfAdvUpCNKes4fZJAHySBNrDxjpYeaR1/Pj
         zCILDyJHVRBwsKk4rG5WxU+HwBllrw3gzS70DKkP7zWro4A2HCo3NHPh/XlFUTAW2FCC
         BBOKC8+pYk/Ur7kcd6GYrMAVpMGW2Ud+7MDG1XV7fLc623LH0CckkxcUXdw7MmJtb/uh
         hr3g==
X-Gm-Message-State: AOAM530szMCjtvpyQZda1CAyNL6KuNtyozoS7LG6jthiP3RnfjWHDKab
        NIV6vX8cFHIZU9zAvlZkvTtfNI1C9RjQe+M9s50=
X-Google-Smtp-Source: ABdhPJxQcv0BCqR/GZONpX232XrI7n9ZVRq7/rV84Ud53uQb3ivwJ1EyVUXdmdZOCose/YOD9vqpDclsIrMXrfPlo9Y=
X-Received: by 2002:aa7:c40a:: with SMTP id j10mr1288230edq.59.1623844486650;
 Wed, 16 Jun 2021 04:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLi8_PDyxtt+=j8AsX9pwLWcT4LmVWKj+UcyFOnj4RDBzg@mail.gmail.com>
 <dacd3fd3-faf5-9795-1bf9-92b1a237626b@gmail.com> <CAOuPNLjCB2m7+b9CJxqTr-THggs-kTPp=0AX727QJ5CTs5OC0w@mail.gmail.com>
 <CAOuPNLio33vrJ_1am-hbgMunUJereC5GOy3QVU6PDDk-3QeneA@mail.gmail.com>
In-Reply-To: <CAOuPNLio33vrJ_1am-hbgMunUJereC5GOy3QVU6PDDk-3QeneA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 16 Jun 2021 17:24:35 +0530
Message-ID: <CAOuPNLgU8K8OzFzKXgp31t6iajuo3_9GxrP4c=92idmcdJ8oZQ@mail.gmail.com>
Subject: Re: Kernel 4.14: SQUASHFS error: xz decompression failed, data
 probably corrupt
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, 15 Jun 2021 at 15:31, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Tue, 15 Jun 2021 at 10:42, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > On Tue, 15 Jun 2021 at 03:53, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > >
> > >
> > > On 6/14/2021 3:39 AM, Pintu Agarwal wrote:
> > > > Hi All,
> > > >
> > > > With Kernel 4.14 we are getting squashfs error during bootup resulting
> > > > in kernel panic.
> > > > The details are below:
> > > > Device: ARM-32 board with Cortex-A7 (Single Core)
> > > > Storage: NAND Flash 512MiB
> > > > Kernel Version: 4.14.170 (maybe with some Linaro updates)
> > > > File system: Simple busybox with systemd (without Android)
> > > > File system type: UBIFS + SQUASHFS
> > > > UBI Volumes supported: rootfs (ro), others (rw)
> > > > -------------------
> > > >
> > > > When we try to flash the UBI images and then try to boot the device,
> > > > we observe the below errors:
> > >
> > > Someone in The OpenWrt community seems to have run into this problem,
> > > possibly on the exact same QCOM SoC than you and came up with the following:
> > >
> > > https://forum.openwrt.org/t/patch-squashfs-data-probably-corrupt/70480
> > >
> > Thanks!
> > Yes I have already seen this and even one more.
> > https://www.programmersought.com/article/31513579159/
> >
> > But I think these changes are not yet in the mainline right ?
> >
> > So, I wanted to know which are the exact patches which are already
> > accepted in mainline ?
> > Or, is it already mainlined ?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/fs/squashfs?h=next-20210611
> > From here, I see that we are only till this:
> > ==> 2018-08-02: Squashfs: Compute expected length from inode size
> > rather than block length
> >
> @Phillip Lougher, do you have any suggestions/comments on these errors ?
> Why do you think these errors occur ?
> Also, I noticed that even if these errors occur, the device may boot normally.
> However, for some people it does not boot at all.
>

It seems we have fixed this issue now from bootloader.
I think it is related to -F (free space fixup) flag for ubifs partition.
http://www.linux-mtd.infradead.org/faq/ubifs.html#L_free_space_fixup

During flashing, we are trying to remove -F flag from ubifs image, but
I think this should be avoided for squashfs image.
I guess this issue might occur if we are trying to mixup
squashfs/ubifs volumes together ?
Or, we are trying to flash squashfs image on UBIFS volume ?
