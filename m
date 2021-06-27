Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC73B5295
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jun 2021 10:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhF0Ior (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 04:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhF0Ior (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 04:44:47 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57619C061574;
        Sun, 27 Jun 2021 01:42:23 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id c2so7693439qvs.6;
        Sun, 27 Jun 2021 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a61V3I0RkkpncjLGVitOxPP7pgTIYctbNAh6crT1fIc=;
        b=gKew31FjLvxKtF6+77teKgibgLTHgFRU5qg2qWDHmdxmA+nK6/ioIljeTlE2gkljsA
         OltSzDEsciEudxpZD6N6nk19v/b/FDgp7J5Vkqoe5/TPN1fCiViHcp7HPiUnnSFkDz0J
         /oXEuT0FMuwWBPbB6E/hx9HTlFSqRUfJ3DXTUNbMpPkpdRHaTE3rws/aR0OJ3IRy+oqF
         5FokggCbmsr7TxHM3EauIuNZt9/sArkWjZUeD9+vLQaaE42rTq7Z7pJQ32Njj3uOjfdB
         cJTpWSoGEzzV9chvCAX09S17WfJEzbMmYbg37T8nKB4+JHdvh4W7okCIA1yd5mdNG+hQ
         LxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a61V3I0RkkpncjLGVitOxPP7pgTIYctbNAh6crT1fIc=;
        b=ROfUM31QSOR0VVErcRAF0f8bIJitQbcbR++QEX0bC0+tIXDG/97oxfpDinRkabsC0+
         7uExU8AFJFbJzLU9sY0cvhaZ5fpEu2hFn//5XGObu7kHSRIIwx3TpaRil8FNzS8gHVwq
         sKdYyblbKlZp31rOXyfIMA6YO8L323cvQfIsLEAG/7J4mrvygr4ERrtQ9CUJj122V/Tg
         IKkxhmdL7JBvjz5QDm/kXd4mO83taOREog3IUModXztG3oplj864EyfZ72HiTokzB7H5
         7y+MDEvslQFBV2kTXfxyRktrbK7dWEjk0/IHvNz1eYmS17xk+2X/uIS5SIKctUvnwnWJ
         lFWA==
X-Gm-Message-State: AOAM5310l6y+i4GVGEmC/lw3cCn92Oqq+vRPxxhgZsHfYlQY6UAxBBT3
        u/iLkrTNo+6jTxexO+p0W3TRk8J8JbFImQ+Mydc=
X-Google-Smtp-Source: ABdhPJyyeE8ckdqwy4lInSfTvN820ZtsN8ptJ11b7lF7PyF+wWfDVsSd9SrZBO+/1VHcgFifkey80tQxdyaQe1hv/oE=
X-Received: by 2002:a05:6214:c2a:: with SMTP id a10mr16518973qvd.60.1624783342077;
 Sun, 27 Jun 2021 01:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiZL4wXc__+Zx+m7TMjUjNq10tykHow3R9AvCknSNR6bQ@mail.gmail.com>
 <CAOuPNLhoLBwksNt+tJ2=hZr-TGHZgEiu7dgk66BUsraGA16Juw@mail.gmail.com>
In-Reply-To: <CAOuPNLhoLBwksNt+tJ2=hZr-TGHZgEiu7dgk66BUsraGA16Juw@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 27 Jun 2021 10:42:10 +0200
Message-ID: <CAFLxGvw1UoC3whDoQ5w6zfDNe=cLYi278y6vvSadQhOV9MGvTA@mail.gmail.com>
Subject: Re: Query: UBIFS: How to detect empty volumes
To:     Pintu Agarwal <pintu.ping@gmail.com>
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

On Thu, Jun 24, 2021 at 6:09 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
> I have one basic query related to UBIFS volumes on a system with NAND partition.

There is no such thing as a UBIFS volume. Do you mean UBI volumes?

> In short, how to detect a particular empty volume inside a system
> partition while flashing the partition image?

What do you mean by system partition? A MTD partition?

> Suppose I have one big system partition that consists of 4-5 ubi
> volumes inside it with varying sizes.
> Lets say:
> -- System Partition (ubi image)
>     - rootfs volume (ro, squashfs)
>     - data volume (rw, ubifs)
>     - firmware volume (ro, ubifs)
>     - some-other volume (ro, squashfs)

So by system partition you mean the MTD partition that hosts UBI itself?

> Consider that all these could be flashed together as part of
> system.ubi image in a single shot from the bootloader.
> Now, suppose, one of the volume image (say firmware) is missing or
> remains empty (as you know we can have empty volumes).
>
> So, during system image flashing, we wanted to detect if one of the
> volume (firmware) is empty.
> Since this is an important volume, so we wanted to detect if this
> volume is empty/missing we will abort flashing the system partition.
> As there is no point in booting the system without this partition.
>
> So, I am exploring options, how can this be detected ?

Read from the volume after flashing. If you get only 0xFF bytes it is empty.

> I mean is there any kind of magic number or header information which
> we can read to detect a particular empty volume ?
> Can we get any information from just "system.ubi" image to indicate
> about the volume information ?

You'll need to perform a proper UBI scan on all blocks.
If for the sad volume no LEBs have been found it is empty.

> Also it could be possible that 2 or more volumes are empty, but we are
> only concerned about one particular volume (firmware), so how to
> detect particular volume ?

I don't understand the use case. Is your image creation process so error prone
that you can't be sure whether critical parts got included or not?

-- 
Thanks,
//richard
