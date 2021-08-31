Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA83FC811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhHaNUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhHaNUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:20:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492F4C061575;
        Tue, 31 Aug 2021 06:19:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n11so26709282edv.11;
        Tue, 31 Aug 2021 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHPtKZe+G6zxzj4XJ8SxB02koJw5U2FZ5BVM7LmQV+E=;
        b=mPKAMH17uL9S9ww1ldPDQOsQ4tTR+P+D3eOikgUSj0/+DitNDCohbo4ATcp1I06SjT
         DtASqynYghW0q1tPUeMWGawXlf0BFDZDe9W9LfZoTUBzaDmO+SsnKPGwswyHM9cysBWv
         4dXshjYaPHsm5wiPS8yv5btgABt9VfHyhyTQ0pp27r3RtOEUJG4mOx9Aof4boWcpriPC
         WmAO0yAdJJ5bXh6Qcze45IPs8ymDvoyTzQWwgJe8uW2f+g+Bs5RC8aaPz2P0RFuUseWe
         b0waCZ9QlHqyvpigVnykIqxtucM9IwJpoIX/QBCE/8MkozyCsuo0YzXplg2GcSTjZIms
         JKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHPtKZe+G6zxzj4XJ8SxB02koJw5U2FZ5BVM7LmQV+E=;
        b=T7k9xP6Gc7Rm+0wj3D5H+yy/XVcKGuHM55fkYKJLQE0M1+J5R+tcWmVzRB2j4jVZUe
         PYjzqBJNf6PZJ+GbUG0QJTkmOR4zKPQDz5MlHii4YzRHCtW+rgKk/haV1QN6FRvmM/AL
         wMklMR9DDVuvmCKHO0GN1iVHrHrsF3T8V6QXbv+L34nQS1CHGpwJgNewpcT1AtPxUMeQ
         Z9pGaI8nmclNw1l3O7dyyrXEH9ax7AG7Pq4wAsboXdiVMOB/OPQk3VCYCKVLKQNhmq/a
         csBV9JL9xf2JcUGwHvjwLTEL28TSw6ZhB6ZFY0i1kmOuTG/lwSVAdMzkSeFQ4GjCKEt1
         46Gw==
X-Gm-Message-State: AOAM533s5b1khuES0pyzplUwOdb4/FPvQrhoMy4PtynZ7oKE6cejP226
        n6O+xcbMAtSrT2Tg48JP7ijdo2YXOzAY+7g8Nh4=
X-Google-Smtp-Source: ABdhPJwT+pZxjrRI5pwhP4OcAeoy4nNGBgvF439fo+caHd7TPPXqp99zWOeMMGPaHPRArVb7drlTb+9fGGonvNasmbw=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr29849642edd.63.1630415980838;
 Tue, 31 Aug 2021 06:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
 <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
 <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
 <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
 <20210830185541.715f6a39@windsurf> <CAOuPNLhTidgLNWUbtUgdESYcKcE1C4SOdzKeQVhFGQvEoc0QEg@mail.gmail.com>
 <20210830211224.76391708@windsurf>
In-Reply-To: <20210830211224.76391708@windsurf>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 31 Aug 2021 18:49:28 +0530
Message-ID: <CAOuPNLgMd0AThhmSknbmKqp3_P8PFhBGr-jW0Mqjb6K6NchEMg@mail.gmail.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting issue
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, 31 Aug 2021 at 00:42, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> Hello,
>
> On Mon, 30 Aug 2021 23:48:40 +0530
> Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> > ohh that means we already have a working reference.
> > If possible can you share the details, even 4.19 or higher will be
> > also a good reference.
> >
> > > > Or, another option is to use the new concept from 5.1 kernel that is:
> > > > dm-mod.create = ?
> > > How are you doing it today without dm-mod.create ?
> > I think in 4.14 we don't have dm-mod.create right ?
>
> No, but you can backport it easily. Back at
> http://lists.infradead.org/pipermail/openwrt-devel/2019-November/025967.html
> I provided backports of this feature to OpenWrt, for the 4.14 and 4.19
> kernels.
>
Yes, I can backport it to our 4.14 Kernel.
Can you share the list of patches to be backported to make it work on 4.14 ?
If it's backported also I need to report to our internal kernel, but
it might be slightly easier.
Please share the details.

> > Here is our kernel command line:
> >
> > [    0.000000] Kernel command line: ro rootwait
> > console=ttyMSM0,115200,n8 ....  verity="95384 11923
> > 16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3 12026
> > " rootfstype=squashfs ubi.mtd=40,0,30 ubi.block=0,0 root=/dev/dm-0
> > .... init=/sbin/init root=/dev/dm-0 dm="rootfs none ro,0 95384 verity
> > 1 /dev/ubiblock0_0 /dev/mtdblock53 4096 4096 11923 8 sha256
> > 16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3
> > aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
> > restart_on_corruption ignore_zero_blocks use_fec_from_device
> > /dev/mtdblock53 fec_roots 2 fec_blocks 12026 fec_start 12026" ...
>
> I don't see how this can work without the dm-mod.create feature. Are
> you sure the verity= and dm= kernel arguments exist?

Sorry, I am not a security guy and this was done by someone from the
security team.
But, I know that this is already working with ext4.
The moment we change to squashfs, it does not work.

The only difference with squashfs are:
=> verity metadata are kept on separate volume
=> The rootfstype and related stuff are different
=> verity command line related stuff are almost the same.

Also, you mentioned:
>>> Here, it definitely worked to append the hash tree to the squashfs
>>> image and store them in the same partition.
Can you share some details about it ?
How it can be done since squashfs is readonly.
Do, we need to change some parameters during squashfs image generation ?
{
  $(STAGING_DIR_HOST)/bin/mksquashfs4 $(call mkfs_target_dir,$(1)) $@ \
- -nopad -noappend -root-owned \
+ -noappend -root-owned \
}

Also, for the above cmdline, is there any problem with the block size ?
As @Mikulas said before that the block size could be the issue

Also, for squashfs we are passing like this for root=. Is it fine ?
rootfstype=squashfs ubi.mtd=40,0,30 ubi.block=0,0 root=/dev/dm-0

I see that dm-0 is already passed elsewhere so do we really need it ?
I suspect it is not required as a block device.


Thanks,
Pintu
