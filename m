Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632673F3FB7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhHVOWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhHVOWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:22:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D85C061575
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Aug 2021 07:21:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cq23so21853664edb.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Aug 2021 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J4ZN/SXLkaHtgaR5XMNgO5PtUr/lZWOqM0+2vN5G3FE=;
        b=DKAzZ8Q4mXjXOBqaMdNNISaFGKc9lQXjGeecFK1OFEAGNv2u4kbda/p/vKDS42UX6h
         KCXnwavPMs6+8oSSt9oJoXkxaP9Q5UkTSr7FiLunnGQmvE+ZnSd68uG/V5VaRYLxKilv
         sgqkfYGdvvmKvjugUd17wtvv/GWx3EW+MjQU7pkg9mto22HFkW814EuquaKH3vCu+wZO
         s0wasYNMAQAX6EvNlLuWjb7KZQ2WpdC1Pz0wN8qQ+3SGgtMlZRJSTD9So4RWGK/AIZ+v
         7xm5ED3BN1nuzyFckLpNfhulcdYXepu3YnnuqDVFjagvD+9mH0T6TEdLq/6Cd8op2Ng7
         +qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J4ZN/SXLkaHtgaR5XMNgO5PtUr/lZWOqM0+2vN5G3FE=;
        b=pc48LYaHjiqKmrHNK9Lclpn+nxpeCRuKb2MnKuzXrb3nlu10T+Wwg53cnRN93lhkCI
         aXnpB7mTc2neNEY1eCLQnj+eZOCfspVfrl2w9bIneeoy2GNOzHuCvh6/rrhl10hFOktW
         GULCzWHDEMG5NDHa01hpzmhqYB/azDucatuJqGte/rGP0Rncre0aLgIPeV4CADfUmsZa
         WkMbU9ugnnH6irFldaf2awwTSM4xPaMF7tqsuEyYhKH1y89RMsJNq9z4mHzm7JzHNiqs
         I/gVrCsEOp10Urv+g/6rWY1vy4GJqYvX59B0IxwN91h0e/K2dFWJn9KTY3GqOCqxSpfs
         z4uw==
X-Gm-Message-State: AOAM532KVXi9BOZdOH7X5urA0akTIh9KeKXaaW0dz9kLpOfhexmOior8
        Sw2aShI81zluEazz/HU8VGWpgFi9g5BPEVH5Ln/1VQ==
X-Google-Smtp-Source: ABdhPJyMJP+G+zDtU3cQrzH4Rz/vW+DE8h+ZLTS8Oh06SyfmGu1gILfLx/I1pNO4KYHoUUGvd0DJPnSytYxVcS+uRfA=
X-Received: by 2002:aa7:dcd1:: with SMTP id w17mr31920855edu.322.1629642083843;
 Sun, 22 Aug 2021 07:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
 <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
 <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
 <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at> <CAAEAJfDDtGcUquyP7Jn0Urttt4kSfAQbJ_qPQ90ROtWLavW9EA@mail.gmail.com>
 <CAOuPNLj+DSigRY_AgHQnGKCK-Vm4ykQBR8UfnTi2UObORTcBFg@mail.gmail.com> <CAOuPNLgfJGzp-RJBjydFDL1ZAvOd7=-MgXhnsb2eb_xFSLC66w@mail.gmail.com>
In-Reply-To: <CAOuPNLgfJGzp-RJBjydFDL1ZAvOd7=-MgXhnsb2eb_xFSLC66w@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 22 Aug 2021 11:21:12 -0300
Message-ID: <CAAEAJfBuut7VSbrrz6CxOC+Cke36eGGv8VUvfdbfLwvSBxOAAA@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Pintu Agarwal <pintu.ping@gmail.com>
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

Hi Pintu,

On Fri, 20 Aug 2021 at 15:25, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Thu, 29 Jul 2021 at 22:41, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > On Thu, 29 Jul 2021 at 17:33, Ezequiel Garcia
> > <ezequiel@vanguardiasur.com.ar> wrote:
> > >
> > > On Thu, 29 Jul 2021 at 08:45, Richard Weinberger <richard@nod.at> wro=
te:
> > > >
> > > > Ezequiel,
> > > >
> > > > ----- Urspr=C3=BCngliche Mail -----
> > > > > [snip]
> > > > >
> > > > > Ouch, so surprised that after all these years someone is doing sq=
uashfs/mtdblock
> > > > > instead of using ubiblock :-)
> > > > >
> > > > > Can we patch either Kconfig or add some warn_once on mtdblock
> > > > > usage, suggesting to use ubiblock instead?
> > > >
> > > > a hint in Kconfig makes IMHO sense. Do you want to send a patch?
> > > > A warning is too much since on some tiny embedded system with NOR f=
lash mtdblock is still
> > > > a good choice.
> > > > ubiblock is mostly useful for NAND flash.
> > > >
> > > > > I remember there was still some use case(s) for mtdblock but I ca=
n't remember
> > > > > now what was it, perhaps we should document the expectations?
> > > > > (Is that for JFFS2 to mount?)
> > > >
> > > > a long time ago mount didn't accept character devices, so you had t=
o pass mtdblockX to mount
> > > > JFFS2.
> > > > This limitation is gone.
> > > >
>
> Hi,
>
> Just a further follow-up on this discussion.
> Whether to use /dev/mtdblock or /dev/ubiblock for rootfs (squashfs)
> mounting during boot.
>
> As suggested here:
> Instead of using this in kernel command line:
> [    0.000000] Kernel command line: ... rootfstype=3Dsquashfs
> root=3D/dev/mtdblock44 ubi.mtd=3D40,0,30 ...
>
> I used this:
> [    0.000000] Kernel command line: ... rootfstype=3Dsquashfs
> ubi.mtd=3D40,0,30 ubi.block=3D0,0 root=3D/dev/ubiblock0_0 ...
>
> The device is booting fine with ubiblock as well.
> But, per say, I could not find any visible difference.
> I just observed a slight improvement in boot time, but I need to
> double-check on this, with few more reboot cycles.
>

That's a very good thing, it means we offered you a smooth transition :-)

> Apart from this what are the other visible benefits of using ubiblock
> which can be explained to be management or internal team ?
> I could not find any documentation explaining the difference, except this=
 one:
> http://www.linux-mtd.infradead.org/doc/ubi.html#L_ubiblock
>

I'm not a flash expert here. In any case, you are expected to do your own
research (just like we all did), design your own setup matching
your use-case, design tests based on your workload and access patterns, etc=
.

There are presentations on YouTube which discuss UBI, UBIFS and
NAND-based designs on Linux, as well as white papers discussing
NAND flashes challenges.

Having said that...

When you use UBI block, you are accessing the flash via the UBI layer.
This is IMO the best way to design your system, since UBI addresses
wear leveling and bad blocks, and offers atomic updates.

In other words, IMO it's best to expose the NAND through UBI
for both read-only and read-write access, using a single UBI device,
and then creating UBI volumes as needed. This will allow UBI
to spread wear leveling across the whole device, which is expected
to increase the flash lifetime.

For instance, just as some silly example, you could have something like thi=
s:

                               | RootFS SquashFS  |
                               | UBI block        | UBIFS User R-W area
------------------------------------------------------------------------
Kernel A | Kernel B | RootFS A | RootFS B         | User
------------------------------------------------------------------------
                                 UBIX
------------------------------------------------------------------------
                                 /dev/mtdX

This setup allows safe kernel and rootfs upgrading. The RootFS is read-only
via SquashFS and there's a read-write user area. UBI is supporting all
the volumes, handling bad blocks and wear leveling.

> Can someone also point me to the respective driver code in case of
> using /dev/mtdblock and /dev/ubiblock ?
> Apart from theory I also want to check the impact at the code level..
>

You can find all the UBI code in drivers/mtd/ubi of course. The differences
between mtdblock and ubiblock are huge: one goes directly to the flash,
and the other uses UBI.

Good luck!
Ezequiel
