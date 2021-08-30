Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59A73FB98B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhH3P7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbhH3P7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:59:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE072C061575;
        Mon, 30 Aug 2021 08:58:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bt14so32227877ejb.3;
        Mon, 30 Aug 2021 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzLND7Bopp3YFFk8qiP7F6kcwfQFWTuokrIXZ++/vhE=;
        b=fWObb/2djR3cm5fTeSb9+LO040MhFz5L6dYeZV2JHwopgB9+uTVKX06+arqZaC/X/A
         CieSqOlJb1rXXSJrzxaNkQgh8u3zzv/A4aEBrh2o1JhmOaeb6vwugLWOQlJsYiJIw8qS
         tvHq6oG1/2ZJ274+HV+NShdq6LN2DQLgmxfNjjMaMFcYx//2fA862tSOQj5f/eZQ9DfX
         b1gkzvAZtFQ9xT5v8M/Au7rrlv1090n1d+lzlw4QyHtMacgZE0HLJkoZFCQ3WBimy/7R
         zt5JCF0eDOzbL0fjAB/CVVnoMQbx01IaCxBvsW0dA0TSgbbANhLMeSAQie1MFUoCqDbJ
         DMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzLND7Bopp3YFFk8qiP7F6kcwfQFWTuokrIXZ++/vhE=;
        b=TbVCBOCpgBDWFh0mU8UsPtSHGWUaVqj44NxJVX2qls4gZbqXDFVTOZCTKqU19rEvL3
         20nT3/QuDUsQdvcpNkZftjdLA/2UnDuYjOW2+mNyX057g6CRRWQhHrf/D3imDm+hiYfo
         dOBV7RZs13a4NrDFa504UvlnOvABKE5pTdhy8GHcfMjX5BvPtXzYqdXnQREPrkCma3pO
         ROprc/TUqKPO/Dtl3i0nNFgniLwKuAKQdooVvVd/Q75LeXVJJsOk2X1yP7LqNcTWml+b
         Uo32MCGrw8Rni0l8huK5hrpiIjeBxRtZYaIr98uo/873KvP/goUgr2ekcZpTtsYGrKtB
         nFog==
X-Gm-Message-State: AOAM533SOJ+dgtfRZR+EXztBA7/yfQLaWu5VjaG5dAv7cL0LAGfbzi7a
        yk40jA9l6D6DjBbHR4WUZoei9VNQFDEKHPUepNs=
X-Google-Smtp-Source: ABdhPJzLFV/rR6wo4yVk550MR8vklFxaVF9r2OFQz46oVJLdEyjG3JtCYPFfu2QJXiMKd5YRHHpxH9vLiBtmGZzmN1k=
X-Received: by 2002:a17:906:3e10:: with SMTP id k16mr26711718eji.116.1630339120139;
 Mon, 30 Aug 2021 08:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
 <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
 <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
 <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at> <CAAEAJfDDtGcUquyP7Jn0Urttt4kSfAQbJ_qPQ90ROtWLavW9EA@mail.gmail.com>
 <CAOuPNLj+DSigRY_AgHQnGKCK-Vm4ykQBR8UfnTi2UObORTcBFg@mail.gmail.com>
 <CAOuPNLgfJGzp-RJBjydFDL1ZAvOd7=-MgXhnsb2eb_xFSLC66w@mail.gmail.com> <CAAEAJfBuut7VSbrrz6CxOC+Cke36eGGv8VUvfdbfLwvSBxOAAA@mail.gmail.com>
In-Reply-To: <CAAEAJfBuut7VSbrrz6CxOC+Cke36eGGv8VUvfdbfLwvSBxOAAA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 30 Aug 2021 21:28:28 +0530
Message-ID: <CAOuPNLjJMCyxK8mvnBo2aZQXSNqY47YeXCxWmtPECq-=csz6bQ@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Richard Weinberger <richard@nod.at>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Sean Nyekjaer <sean@geanix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 22 Aug 2021 at 19:51, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:

> In other words, IMO it's best to expose the NAND through UBI
> for both read-only and read-write access, using a single UBI device,
> and then creating UBI volumes as needed. This will allow UBI
> to spread wear leveling across the whole device, which is expected
> to increase the flash lifetime.
>
> For instance, just as some silly example, you could have something like this:
>
>                                | RootFS SquashFS  |
>                                | UBI block        | UBIFS User R-W area
> ------------------------------------------------------------------------
> Kernel A | Kernel B | RootFS A | RootFS B         | User
> ------------------------------------------------------------------------
>                                  UBIX
> ------------------------------------------------------------------------
>                                  /dev/mtdX
>
> This setup allows safe kernel and rootfs upgrading. The RootFS is read-only
> via SquashFS and there's a read-write user area. UBI is supporting all
> the volumes, handling bad blocks and wear leveling.
>
Dear Ezequiel,
Thank you so much for your reply.

This is exactly what we are also doing :)
In our system we have a mix of raw and ubi partitions.
The ubi partitioning is done almost exactly the same way.
Only for the rootfs (squashfs) I see we were using /mtd/block<id> to
mount the rootfs.
Now, I understood we should change it to use /dev/ubiblock<id>
This might have several benefits, but one most important could be,
using ubiblock can handle bad-blocks/wear-leveling automatically,
whereas mtdblocks access the flash directly ?
I found some references for these..
So, this seems good for my proposal.

Another thing that is still open for us is:
How do we calculate the exact image size from a raw mtd partition ?
For example, support for one of the raw nand partitions, the size is
defined as 15MB but we flash the actual image of size only 2.5MB.
So, in the runtime how to determine the image size as ~2.5MB (at least
roughly) ?
Is it still possible ?


Thanks,
Pintu
