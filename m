Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA23DA9CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhG2RLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhG2RLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:11:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C01C061765;
        Thu, 29 Jul 2021 10:11:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h8so9200589ede.4;
        Thu, 29 Jul 2021 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7tiye3BP8+eAcI9Ua4+M/nbZ9rLFrkFbWFrBumIaS3k=;
        b=jnQzJO8sksNbCAaYpocc6iVuTNjQe4LOxEXA9e6MbHgwF1T+0wDhULbKB+n6uwG92Z
         i7ETciQurvwcg/RC1ie/FcIjkoVO+nSu2eESwbrQUWVFg98qdz17RytgNe36zA81/pS8
         yYsWYLtTXt/xpr+O179oFNKkLgnq4NaVJPWrrIcYK97DfUJlOBRhmGsd9OZpRmg8f+tS
         3xPimxAi8xYUQYMPjHvc2SxMZmhZPPKvCbXH6dvAdzTDI36YYYa2K6Vw+20EXYexPZck
         CxRhCV637h2ramddrX200aXEf6hFnHtNsjRU1x7dNVv2e9vduJMO1dZ10NpPPTj+LUm8
         gu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7tiye3BP8+eAcI9Ua4+M/nbZ9rLFrkFbWFrBumIaS3k=;
        b=l2aUQ+CE4IJ0XRNSxSR5bk3hTt4EbNbx2bx5gTdyqY+F4n87f5s68WP8oxNJObSSVD
         /vkiRxeCRiu2oGIqj77++/TvsugRl7OYNh/1rQtM+Obhzc6055mVlzS95JKl+ky3XdH9
         cyQqm7swZrZKLk1g+qoST/A8Db3DzoXm66GHtLGubg7m00nBEuk8dM40mn3tPRCfw7HR
         RxSlrzpxfNyF//K+mvzKvErwQhneXl0tUyNVgRdJJMKnAtoThvbKMe7Gf1SK3BH2sxW6
         77dOWSHrUzWuakei/DaTLcdjnOkcqMmpb3drfiJW3mcAOczjayfjCRpZy2nwD6tOI6Vr
         KEXA==
X-Gm-Message-State: AOAM532HcMh7anKiLBqfS6NZZqzurMUdrdQd/yL6Uicq/KfAMCMStuxM
        mNZ2KWQRk9QRvLK5KxmEV7uaw4o7/2ILzdeDGMc=
X-Google-Smtp-Source: ABdhPJwgSE2otSPTvBYc+j0oKM7zrw81iIsLjHzZEDcxHmknvloadG02SDKv5NWVGH6KBOGAEif3p+3tkjqdpx+yudk=
X-Received: by 2002:a05:6402:514e:: with SMTP id n14mr7359602edd.129.1627578710016;
 Thu, 29 Jul 2021 10:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
 <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
 <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
 <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at> <CAAEAJfDDtGcUquyP7Jn0Urttt4kSfAQbJ_qPQ90ROtWLavW9EA@mail.gmail.com>
In-Reply-To: <CAAEAJfDDtGcUquyP7Jn0Urttt4kSfAQbJ_qPQ90ROtWLavW9EA@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 29 Jul 2021 22:41:38 +0530
Message-ID: <CAOuPNLj+DSigRY_AgHQnGKCK-Vm4ykQBR8UfnTi2UObORTcBFg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Jul 2021 at 17:33, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> On Thu, 29 Jul 2021 at 08:45, Richard Weinberger <richard@nod.at> wrote:
> >
> > Ezequiel,
> >
> > ----- Urspr=C3=BCngliche Mail -----
> > > [snip]
> > >
> > > Ouch, so surprised that after all these years someone is doing squash=
fs/mtdblock
> > > instead of using ubiblock :-)
> > >
> > > Can we patch either Kconfig or add some warn_once on mtdblock
> > > usage, suggesting to use ubiblock instead?
> >
> > a hint in Kconfig makes IMHO sense. Do you want to send a patch?
> > A warning is too much since on some tiny embedded system with NOR flash=
 mtdblock is still
> > a good choice.
> > ubiblock is mostly useful for NAND flash.
> >
> > > I remember there was still some use case(s) for mtdblock but I can't =
remember
> > > now what was it, perhaps we should document the expectations?
> > > (Is that for JFFS2 to mount?)
> >
> > a long time ago mount didn't accept character devices, so you had to pa=
ss mtdblockX to mount
> > JFFS2.
> > This limitation is gone.
> >
>
> OK, let me try to cook a patch for you.
>

Dear Eze and Richard,

First of all, thank you so much for all your replies so far.
Sorry, I have limited knowledge about NAND, MTD, UBI layers, but my
current work involves all these so I am here.
But I will surely share this information to our internal team about
using ubiblock instead of mtdblock.

However, I still fail to understand the problem and consequences of
using mtdblock for rootfs instead of ubiblock.
Last time, for my squashfs test, when I tried to replace the command
line with ubiblock, I could not see any difference.
How to visibly see the difference so that I can easily understand and
explain the difference internally?
Or, is there a document available somewhere to highlight the
difference between the two?

BTW, we have few raw nand partitions and few ubi volumes [including
rootfs(squashfs), data(ubifs, rw)]
So, I guess we should use ubiblock for all ubi volumes?

Regarding Kconfig, I have few opinions.
Yes, adding more description in Kconfig is a good choice.
But I see that most of the time these kernel config options remains
(as default) and platform developers never cares about the
description.
So, how to better create awareness among them, not to make these mistakes?
One option is to capture these details as part of Kernel documentation.
Right now when I search I could not find anything.
Another option is to add a few (critical) warnings in kernel bootup
logs to give some hint to the developer that there is probably
something wrong.
This will directly be visible to all and some developers will not like
to ignore it.
Or, maybe adding both options is also good.


Thanks,
Pintu
