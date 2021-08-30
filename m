Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77653FBA11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhH3Q00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhH3Q00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:26:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610EAC061575;
        Mon, 30 Aug 2021 09:25:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j13so17164791edv.13;
        Mon, 30 Aug 2021 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nM2mQX3CjHoVvQzXA9QRVqQGDAbVu2Bb047tmbqXsXo=;
        b=bA1E1KgWEDH/JcQBubmzNzyWUytl4cFe1kH1PHzTekCt2/yQWDd9CgouzSCv4R5Vi4
         EAAT69bmH3esYn8vAL2aDmmP0bTIOyhneMcIKUrz/BGD9oiHxicw70vvihG98A9qa/qc
         keNzwt5MF1V7X099AZ2XqHRnAKPBeXfaXlZaBMQCydYPuTQVE6Lqqanx0X9VRfP+suuQ
         uMjyKJ0lRrurDG5/5T1+XuL9kAQal6psuSclzLdI540j58xR/20m8n0N8uEMb3mYL8dn
         H7PyCSmpnrntHaDQgdvamIsORLZVaJXj4guatB/MWW+Qcj4uLzMMs8fFK/zsKrcHxkEj
         fGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nM2mQX3CjHoVvQzXA9QRVqQGDAbVu2Bb047tmbqXsXo=;
        b=h45xocemoznMeBhN3chUIVd6XVb0HB3A/kO22Owt6+JYnN0IYxj/FBlxp3oXhbifA7
         wypu6roiMX1d9LL3RwfOgmWVjt77cHRwXMdDG2Q8f9IgxtR4NjzIJxbsrSm3ZO6F4M4y
         0jjAKsSQLggWE0K7/UTxAU5JMeNTGv19TXp2UBuUOlg8gPv7IRTr4HbEltR//kgDsjkf
         rcL+3+pmcHt1db9CFCST9breypTEe4e5AAczHrJ4zFHR+BZA+racch8kt7LdB7nb+gbH
         eO/Tja+V7Z+aujG8spAvfFHqCgYUBnokaKwPASSB+7MMxka9eCDTlMqHDBAxELhpQy8f
         8bjQ==
X-Gm-Message-State: AOAM530Eh2l05HR5NQitdbbWlmEYBy8xCNMGfXrk0TgfCPf/hBeZKRr1
        RKIEstVjuWsj6poe6dq4e0GTgwPUDVTcw4jD//Q=
X-Google-Smtp-Source: ABdhPJxFVwH5a9vwpgHr69uleyHJFXry4tEBhgWEqP3jLJ2yNeNcN8OYKvlGgPaWD3RXyoBlU+G/vqMKDepmDLjCHqM=
X-Received: by 2002:a05:6402:2050:: with SMTP id bc16mr5209767edb.92.1630340730956;
 Mon, 30 Aug 2021 09:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
 <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
 <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
In-Reply-To: <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 30 Aug 2021 21:55:19 +0530
Message-ID: <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting issue
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, Sami Tolvanen <samitolvanen@google.com>,
        thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jul 2021 at 22:59, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Wed, 21 Jul 2021 at 22:40, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> > > >
> > > > Try to set up dm-verity with block size 512 bytes.
> > > >
> > > > I don't know what block size does squashfs use, but if the filesystem
> > > > block size is smaller than dm-verity block size, it doesn't work.
> > > >
> > > Okay thank you so much for this clue,
> > > It seems we are using 65536 as the squashfs block size:
> >
> > 65536 is the compression block size - it is unrelated to I/O block size.
> >
> > There's a config option SQUASHFS_4K_DEVBLK_SIZE. The documentation says
> > that it uses by default 1K block size and if you enable this option, it
> > uses 4K block size.
> >
> Okay it seems this config is set in our case:
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> So, with this the squashfs and dm-verity block size exactly matches (4K)
>
> > So, try to set it. Or try to reduce dm-verity block size down to 1K.
> >
Hi,

Sorry for coming back to this again..
Unfortunately, none of the options is working for us with squashfs
(bootloader, initramfs).
initramfs have different kinds of challenges because of the partition
size issue.
So, our preferred option is still the bootloader command line approach..

Is there a proven and working solution of dm-verity with squashfs ?
If yes, please share some references.

The current problem with squashfs is that we could not append the
verity-metadata to squashfs, so we store it on a separate volume and
access it.
By specifying it like : /dev/mtdblock53

Then we get the error like this:
{
[    4.950276] device-mapper: init: attempting early device configuration.
[    4.957577] device-mapper: init: adding target '0 95384 verity 1
/dev/ubiblock0_0 /dev/mtdblock53 4096 4096 11923 8 sha256
16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3
aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
restart_on_corruption ignore_zero_blocks use_fec_from_device
/dev/mtdblock53 fec_roots 2 fec_blocks 12026 fec_start 12026'
[    4.975283] device-mapper: verity: sha256 using implementation
"sha256-generic"
[    4.998728] device-mapper: init: dm-0 is ready

[    5.614498] 1f35            1736 mtdblock53
[    5.614502]  (driver?)
[    5.621098] fc00           61504 ubiblock0_0
[    5.621102]  (driver?)
[    5.627661] fd00           47692 dm-0
[    5.627665]  (driver?)
[    5.633663] No filesystem could mount root, tried:
[    5.633667]  squashfs
[    5.636009]
[    5.643215] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(253,0)
}

Do you see any other problem here with dm-verity cmdline or with squashfs ?

Is squashfs ever proved to be working with dm-verity on higher kernel version ?
Currently our kernel version is 4.14.

Or, another option is to use the new concept from 5.1 kernel that is:
dm-mod.create = ?
But, currently I don't know how to use it with squashfs either...
Any reference example will be helpful..

Thanks,
Pintu
