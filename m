Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F583FBC15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 20:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhH3SVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbhH3SVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:21:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C1C0604C7;
        Mon, 30 Aug 2021 11:18:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t19so33047944ejr.8;
        Mon, 30 Aug 2021 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nZc2m/dOqxmB1eKzo22dnXLX+VFfEl/hwdI2/cyoEM=;
        b=A7h8ybB2P+VfxNJI8xfu7cEEl6RfK7GygfAovranOttjBmqnUVsfl9rZwsB0/8ueiQ
         TbLaGdtZk1fV1H0FFIh3V5oL95D0uAw6tIhs2R9LHq+P45BwQfuIFJDU0VpbrpyWfDCw
         Irv+4eEqcirZuczPZg/tUPVRLnjcnl+E0zbbvVkSHmr5R+iDQlxAcqrYFXEyQWEOqemX
         9m9JMczC5/QBNSVhnSfD0IK8LiQC7DYhPZN1WUGN7en8Df4mqhQAB3zux9ia3wgo+WW/
         iTWX99ISGeytT5+wDhptZuK/r2To5cSyF35/RZUU5E4sRg/A+2FGJNzn02BNAOVo3i5K
         uu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nZc2m/dOqxmB1eKzo22dnXLX+VFfEl/hwdI2/cyoEM=;
        b=RYfwICTJPp1J+oJVXyw5/bMqg7bquycVdcTMBzUFS/Fqffmrgqv0+29bv85U9ui2sQ
         /UK76vdb9c6xO+5w58TQ3+Mha71xKaP52CpXsCXX/PEbr5Fl90aXP/2c47T3diGX35SF
         2eEnAgPSSasC1jQRTB65LcOVks11kfBeNiY42WRT/riL9OmUW0j+eRHU2hgTnEZWsH+r
         4yU3GiHEXGshU6ZQ5qzAydh1MlvBGW+n4Y4bTR9qV05i4eAl4/F6+TD6WBEx9IXIzpcI
         vkfv/V5wiqh8wvJj53ph+/NqW1eOrRUor5S4RczpmSZFfPwpQ2BLzZY09f7wzKgHQIwm
         J+Og==
X-Gm-Message-State: AOAM533KxCjDqFVHFSTzceIcOQztaLC0JSO2ZKemmfer30RImoL0Ovzc
        na58kmIAdIMDhfFOSrgT+l4aq5oUnjt5S7dNI6npAfSqIpzi8PU1
X-Google-Smtp-Source: ABdhPJyQzW3MlAgCliu3WdiEbQ0YtZ+8ycOJa910u+zPDe/bD8bYKE5SakukZYmkGdvUYCdU8uIVUyt9VaN9BvcL3l4=
X-Received: by 2002:a17:906:8cc:: with SMTP id o12mr18643103eje.252.1630347531529;
 Mon, 30 Aug 2021 11:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
 <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
 <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
 <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com> <20210830185541.715f6a39@windsurf>
In-Reply-To: <20210830185541.715f6a39@windsurf>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 30 Aug 2021 23:48:40 +0530
Message-ID: <CAOuPNLhTidgLNWUbtUgdESYcKcE1C4SOdzKeQVhFGQvEoc0QEg@mail.gmail.com>
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

On Mon, 30 Aug 2021 at 22:25, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> Hello,
>
> On Mon, 30 Aug 2021 21:55:19 +0530
> Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> > Sorry for coming back to this again..
> > Unfortunately, none of the options is working for us with squashfs
> > (bootloader, initramfs).
> > initramfs have different kinds of challenges because of the partition
> > size issue.
> > So, our preferred option is still the bootloader command line approach..
> >
> > Is there a proven and working solution of dm-verity with squashfs ?
> > If yes, please share some references.
> >
> > The current problem with squashfs is that we could not append the
> > verity-metadata to squashfs, so we store it on a separate volume and
> > access it.
>
> Here, it definitely worked to append the hash tree to the squashfs
> image and store them in the same partition.
>
> > By specifying it like : /dev/mtdblock53
> >
> > Then we get the error like this:
> > {
> > [    4.950276] device-mapper: init: attempting early device configuration.
> > [    4.957577] device-mapper: init: adding target '0 95384 verity 1
> > /dev/ubiblock0_0 /dev/mtdblock53 4096 4096 11923 8 sha256
> > 16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3
> > aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
> > restart_on_corruption ignore_zero_blocks use_fec_from_device
> > /dev/mtdblock53 fec_roots 2 fec_blocks 12026 fec_start 12026'
> > [    4.975283] device-mapper: verity: sha256 using implementation
> > "sha256-generic"
> > [    4.998728] device-mapper: init: dm-0 is ready
>
> Could you show the full kernel command line ?
Shared below

> > Do you see any other problem here with dm-verity cmdline or with squashfs ?
> >
> > Is squashfs ever proved to be working with dm-verity on higher kernel version ?
> > Currently our kernel version is 4.14.
>
> I confirm we used squashfs on dm-verity successfully. For sure on 4.19,
> perhaps on older kernels as well.

ohh that means we already have a working reference.
If possible can you share the details, even 4.19 or higher will be
also a good reference.

> > Or, another option is to use the new concept from 5.1 kernel that is:
> > dm-mod.create = ?
> How are you doing it today without dm-mod.create ?
I think in 4.14 we don't have dm-mod.create right ?

> Again, please give your complete kernel command line.
>
Here is our kernel command line:

[    0.000000] Kernel command line: ro rootwait
console=ttyMSM0,115200,n8 ....  verity="95384 11923
16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3 12026
" rootfstype=squashfs ubi.mtd=40,0,30 ubi.block=0,0 root=/dev/dm-0
.... init=/sbin/init root=/dev/dm-0 dm="rootfs none ro,0 95384 verity
1 /dev/ubiblock0_0 /dev/mtdblock53 4096 4096 11923 8 sha256
16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3
aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
restart_on_corruption ignore_zero_blocks use_fec_from_device
/dev/mtdblock53 fec_roots 2 fec_blocks 12026 fec_start 12026" ...

Do you see any issue here ?
Can you share your command line for squashfs to compare ?

Thank you,
Pintu
