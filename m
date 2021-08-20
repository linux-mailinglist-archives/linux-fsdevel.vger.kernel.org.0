Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1353B3F33A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhHTSZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 14:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbhHTSZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:25:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBFFC061757;
        Fri, 20 Aug 2021 11:25:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lo4so21871492ejb.7;
        Fri, 20 Aug 2021 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tF/rYLQ+DtMioyJLcb3Pd0DjkRnK2a1fMohMiDkI93E=;
        b=BiEuWlvzwz1TCjxw7PuZdooB500Q4kzhIVUdIw3j2f/DYzySsEKyZHNG2apBbVlKd+
         S26tsKYb7CsPo4zgHSDtIzzYo00dcDHQDbnFmVFdGK44zilVcYPK8XbkEB0+pAMq50gC
         d4YZBHWkvFVZ1yHzBrmK/INfta5lh00UQTLjmPTz3Re3NlPs/oYT0HjmIRtpJk9TkiFY
         Ff3JYakC6Th0dSUjZssoBQ2UgXVUbcjpBstZ0r2py3h3LhDGnPij8AaFsW7zcw+tcLVo
         zI2dNXaeDh/LXQFbqvCN37iujdclM04i7cO/IY7dB1QRo+tCfc6BeP1HEMzkhkiqk5GF
         mnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tF/rYLQ+DtMioyJLcb3Pd0DjkRnK2a1fMohMiDkI93E=;
        b=QhiQ7UkRthAV6ciqLJ+dcblB1xVXsT2zPsF4q8k7vapFhRPEEvvW888z0VMLlbYGmL
         BI0D3DEU7qyE5f2+C2xJSr+aIEbGxgXc7QDylBIVP41dqplK1l2uxQ+beI9ebxXQrNWU
         F1VJCpJwmYKu9f7d6cGG97rDIKpfSPetqLC8VYoRT7dJRpaZ+62tsUpPW7B9ErEwrbUg
         A/sPFG1g8SeeorujhIYAyUwdbtW6khHUd/IfLvDlAmUvcnl3Q4DxU3Nl3ZjY4ykNshau
         BluswgcMTrNCE2t5tO4L/J0ybK1MZy5soOqX2aGfmL8PG/SFcmBf1qEmqAFfQ/TU91p/
         K1xQ==
X-Gm-Message-State: AOAM5320xObBdtNTp8IVXBK5yVrUCyiksfwIBM4txTZScT67FIGdlGht
        yeNesY2vV3RORZBI3/7NEv0PQ43mqx4wBPrjUrM5a/kgPfbR9Q==
X-Google-Smtp-Source: ABdhPJz7fGXk3BnM0WOR5XhOuGf6TCNsxu1Wo/01tMBExMGZe8icmT2pSL/tQVP6uELLgOsvWPMUd8g3QIqx0O0Ktmk=
X-Received: by 2002:a17:907:1043:: with SMTP id oy3mr3902073ejb.116.1629483901606;
 Fri, 20 Aug 2021 11:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
 <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
 <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
 <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at> <CAAEAJfDDtGcUquyP7Jn0Urttt4kSfAQbJ_qPQ90ROtWLavW9EA@mail.gmail.com>
 <CAOuPNLj+DSigRY_AgHQnGKCK-Vm4ykQBR8UfnTi2UObORTcBFg@mail.gmail.com>
In-Reply-To: <CAOuPNLj+DSigRY_AgHQnGKCK-Vm4ykQBR8UfnTi2UObORTcBFg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 20 Aug 2021 23:54:50 +0530
Message-ID: <CAOuPNLgfJGzp-RJBjydFDL1ZAvOd7=-MgXhnsb2eb_xFSLC66w@mail.gmail.com>
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

On Thu, 29 Jul 2021 at 22:41, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Thu, 29 Jul 2021 at 17:33, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > On Thu, 29 Jul 2021 at 08:45, Richard Weinberger <richard@nod.at> wrote=
:
> > >
> > > Ezequiel,
> > >
> > > ----- Urspr=C3=BCngliche Mail -----
> > > > [snip]
> > > >
> > > > Ouch, so surprised that after all these years someone is doing squa=
shfs/mtdblock
> > > > instead of using ubiblock :-)
> > > >
> > > > Can we patch either Kconfig or add some warn_once on mtdblock
> > > > usage, suggesting to use ubiblock instead?
> > >
> > > a hint in Kconfig makes IMHO sense. Do you want to send a patch?
> > > A warning is too much since on some tiny embedded system with NOR fla=
sh mtdblock is still
> > > a good choice.
> > > ubiblock is mostly useful for NAND flash.
> > >
> > > > I remember there was still some use case(s) for mtdblock but I can'=
t remember
> > > > now what was it, perhaps we should document the expectations?
> > > > (Is that for JFFS2 to mount?)
> > >
> > > a long time ago mount didn't accept character devices, so you had to =
pass mtdblockX to mount
> > > JFFS2.
> > > This limitation is gone.
> > >

Hi,

Just a further follow-up on this discussion.
Whether to use /dev/mtdblock or /dev/ubiblock for rootfs (squashfs)
mounting during boot.

As suggested here:
Instead of using this in kernel command line:
[    0.000000] Kernel command line: ... rootfstype=3Dsquashfs
root=3D/dev/mtdblock44 ubi.mtd=3D40,0,30 ...

I used this:
[    0.000000] Kernel command line: ... rootfstype=3Dsquashfs
ubi.mtd=3D40,0,30 ubi.block=3D0,0 root=3D/dev/ubiblock0_0 ...

The device is booting fine with ubiblock as well.
But, per say, I could not find any visible difference.
I just observed a slight improvement in boot time, but I need to
double-check on this, with few more reboot cycles.

Apart from this what are the other visible benefits of using ubiblock
which can be explained to be management or internal team ?
I could not find any documentation explaining the difference, except this o=
ne:
http://www.linux-mtd.infradead.org/doc/ubi.html#L_ubiblock

Can someone also point me to the respective driver code in case of
using /dev/mtdblock and /dev/ubiblock ?
Apart from theory I also want to check the impact at the code level..

Thanks,
Pintu
