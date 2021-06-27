Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B083B5388
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jun 2021 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhF0Nv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhF0Nvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 09:51:55 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04480C061574;
        Sun, 27 Jun 2021 06:49:30 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b5so14699326ilc.12;
        Sun, 27 Jun 2021 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWGO+itUm6tMgujfJIGgElCIQmjPwoC/qMTdg68ZcXc=;
        b=jSx1jWRNMlAT68tgB7bCsuZqgDYgfiNEwJ1mD2Za+4v4gYkEgHIsfr7NLcl/pPu17E
         sMc7eWOadn89rncqJblRCe2nilMIVe9+Lr0KL+CbAUtDY2ukpo7/iwZ9MCTOworuIwiH
         STBBr6guaR+2aQXcvf7lerOIhVDZWCDmuWp6R4Jv4BwYxFgPZTyv53kg0xQ8/VfTwaJp
         JHRC80ddtc2TbByE27FVpuS/MB4VoLb+XNQQ0kvnqfs1ibZToIoi5tPVhQKdn3uswlkQ
         SW+TyonxdygwCu6jods4Mn3ql5Ei8/OiH53q17/MtCKvNkPl+64lanBnagGZjHi4lnWg
         AD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWGO+itUm6tMgujfJIGgElCIQmjPwoC/qMTdg68ZcXc=;
        b=hq9056m9lXtDmEVWZZACpz9+Fd5UlTq5ZnFCiWgh962ImJtv4mrkazt5trkebXVWyz
         uIOqXUYMsh1JXAptviJN5wwNYONKUKbPQ9qJSE2abk/o2xogSEu0Bv0DJLGTGjdjAMOb
         rQPwnHnf8sTp6A7bRhnsvX3qW/Eoz9PEr8pRZD19EEt/VrljwNRKD/nA4YFM9JUpWEtN
         tacI0+TDp+Nn3Z2zyv10CLsHbsQk6LzooX4QWswH48I7K6Jkzcl86xZkif8QpH1Ywj/6
         X58Hdhzv0so010IaN5rUuiVTWpBphfV4tA3dz0cRWNm4VIZlHXaOvrSr8k2bKIjpoB/X
         YTGA==
X-Gm-Message-State: AOAM531lT869KKvSBSsVJ2SB54URP0OdLtnYQiQqEgEjI9Qn6KYC8Em8
        iWn5l6uIn4dqNtKjgArGbU7QhWaF2mUuag7GBqQ=
X-Google-Smtp-Source: ABdhPJz1Ubb4xI0HYKINaSQPBvAxnz0e8JYIbsgs0KMkjdWkzp48dXCScptKhbn01OC2YzZmtwYq7A6g9xKqrnL9EGY=
X-Received: by 2002:a92:d4c5:: with SMTP id o5mr8968854ilm.306.1624801770256;
 Sun, 27 Jun 2021 06:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiZL4wXc__+Zx+m7TMjUjNq10tykHow3R9AvCknSNR6bQ@mail.gmail.com>
 <CAOuPNLhoLBwksNt+tJ2=hZr-TGHZgEiu7dgk66BUsraGA16Juw@mail.gmail.com> <CAFLxGvw1UoC3whDoQ5w6zfDNe=cLYi278y6vvSadQhOV9MGvTA@mail.gmail.com>
In-Reply-To: <CAFLxGvw1UoC3whDoQ5w6zfDNe=cLYi278y6vvSadQhOV9MGvTA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sun, 27 Jun 2021 19:19:18 +0530
Message-ID: <CAOuPNLj4ktYYieOqxd1EGUWt0DZamwQik_jg6cj2ZyqRaL9Amw@mail.gmail.com>
Subject: Re: Query: UBIFS: How to detect empty volumes
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 27 Jun 2021 at 14:12, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Thu, Jun 24, 2021 at 6:09 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > I have one basic query related to UBIFS volumes on a system with NAND partition.
>
> There is no such thing as a UBIFS volume. Do you mean UBI volumes?
>
Yes I mean the ubi volumes which are created using the ubinize config file.

> > In short, how to detect a particular empty volume inside a system
> > partition while flashing the partition image?
>
> What do you mean by system partition? A MTD partition?
By this I mean the entire UBI partition that contains the magic header "UBI#"
>
> > Suppose I have one big system partition that consists of 4-5 ubi
> > volumes inside it with varying sizes.
> > Lets say:
> > -- System Partition (ubi image)
> >     - rootfs volume (ro, squashfs)
> >     - data volume (rw, ubifs)
> >     - firmware volume (ro, ubifs)
> >     - some-other volume (ro, squashfs)
>
> So by system partition you mean the MTD partition that hosts UBI itself?
>
Yes the entire UBI partition that contains UBI volumes

> > Consider that all these could be flashed together as part of
> > system.ubi image in a single shot from the bootloader.
> > Now, suppose, one of the volume image (say firmware) is missing or
> > remains empty (as you know we can have empty volumes).
> >
> > So, during system image flashing, we wanted to detect if one of the
> > volume (firmware) is empty.
> > Since this is an important volume, so we wanted to detect if this
> > volume is empty/missing we will abort flashing the system partition.
> > As there is no point in booting the system without this partition.
> >
> > So, I am exploring options, how can this be detected ?
>
> Read from the volume after flashing. If you get only 0xFF bytes it is empty.
>
I mean, without flashing the image, is it possible to determine/guess
from the image content/header
 that a volume in the image is empty.
If it is empty then do not allow to flash the image.

> > I mean is there any kind of magic number or header information which
> > we can read to detect a particular empty volume ?
> > Can we get any information from just "system.ubi" image to indicate
> > about the volume information ?
>
> You'll need to perform a proper UBI scan on all blocks.
> If for the sad volume no LEBs have been found it is empty.
>
hmm, this seems reasonable. We have something called
"ubi_scan_partition" that scans for bad blocks, during "ubi_open".
And we also have ubi_find_volume that checks for vtbl record in an
incoming image.
Let me check about the LEB option here.

> > Also it could be possible that 2 or more volumes are empty, but we are
> > only concerned about one particular volume (firmware), so how to
> > detect particular volume ?
>
> I don't understand the use case. Is your image creation process so error prone
> that you can't be sure whether critical parts got included or not?
>
Actually our UBI creation process contains multiple volumes, in which
one volume contains
firmware image, that comes from another subsystem.
So, it requires copying that firmware image manually before building
the etire yocto image.
But, it might be possible that some developer may miss/skip this
firmware copying part, thus
the resulting image may end up is having an empty firmware volume.
However, this firmware volume is an important volume, without which
the modem may not boot up.
