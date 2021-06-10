Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2203A2C02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFJMyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 08:54:36 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:33392 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFJMyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:54:35 -0400
Received: by mail-ej1-f49.google.com with SMTP id g20so44039352ejt.0;
        Thu, 10 Jun 2021 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BIJBn/I6DRBXkEoZUzmiw1Hh2oOM7OAEUZCbmNimrwY=;
        b=JkluSf/kl2F7pNpCnxbzkaVwHuZZbX004ST6XQIMXpUB48TnjcdtkwyMJF3vjfK+US
         dCsa1LW5/u5uVXRow00lXdnBnabFjYoxv4ih3oGHdLwcYW7N+3t0VO///nBRaMPE4CQM
         y17F3pnDnvPxrH6LrAPIZJiWTHw6yzLRGkG9q+XdGSy8RojgFDBH14Qwf1/0YGP6JfgV
         ir1CGl09B0TG9crbxf1wpzWsS9/iGdKfXfAZqTthgRm/AfsIbHcNB3tOSzicfcQfkc49
         YOaec5jHZNOY0VZ5bDGQg/uwbGnJzwfcCZ9ESx6gRYiB/iYHZxpQ+ZAuoXqaZ2N4hECy
         IBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BIJBn/I6DRBXkEoZUzmiw1Hh2oOM7OAEUZCbmNimrwY=;
        b=b+1x3W6PYCCibglnJ+2iZDWsgbjqvNZ4baL4NG9oTltLTlotcsQ3lm0BLHBbpzcAK6
         BxD+keSi+Y1ADjOZxF4S37DtAqpGF6/rsEveqAuto4AwHdm4BZ/GV6pC1OhmcoF+ruLY
         o+zSdE3IL0bvSs1O+zTYDPAszwrEWRj6nVk7j+58FT4QszqrZe7sqppDcyraH4hgFdG1
         YkMgCRx93VqydpVu+yEH9iXS3yBrKy+sfQSwh+ChhByIY+MendDSU77Xx3wKAnhOafk2
         Fc+mlZ5nK1tH4c52bV/+t/MgImLNfApYu8DwEXbmCit7Iu+RfQwyWf7hOBGBwcbQyZbR
         OSzw==
X-Gm-Message-State: AOAM531gF7UOSKGA21FYzw1pMXaPFYMod49/MdCg2/cSOcgnKWuE+BfO
        FvURuMCBrBTnsXhirDSmXR9+nrlRPvHmzC9cW3Y=
X-Google-Smtp-Source: ABdhPJxXGCyOtIxT2sWmcCzl9YoKQTh3945/iYZzq+xMr4L07m30j9mVZpaBSttdKfgV16WQ8kEgWktAM7iiCMaEC60=
X-Received: by 2002:a17:906:c293:: with SMTP id r19mr4417749ejz.252.1623329489454;
 Thu, 10 Jun 2021 05:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiRDZ9M4n3uh=i6FpHXoVEWMHpt0At8YaydrOM=LvSvdg@mail.gmail.com>
 <295072107.94766.1623262940865.JavaMail.zimbra@nod.at>
In-Reply-To: <295072107.94766.1623262940865.JavaMail.zimbra@nod.at>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 10 Jun 2021 18:21:18 +0530
Message-ID: <CAOuPNLhPiVgi5Q343VP-p7vwBtA1-A5jt8Ow4_2eF4ZwsiA+eQ@mail.gmail.com>
Subject: Re: qemu: arm: mounting ubifs using nandsim on busybox
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Jun 2021 at 23:52, Richard Weinberger <richard@nod.at> wrote:
>
> Pintu,
>
> ----- Urspr=C3=BCngliche Mail -----
> > Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-blo=
ck(31,0)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > If any one has used nandsim on qemu before, please let us know the exac=
t steps.
>
> nandsim works as expected. It creates a new and *erased* NAND for you.
> So you have no UBI volumes. Therfore UBIFS cannot be mounted.
> I suggest creating a tiny initramfs that creates UBI volumes before mount=
ing UBIFS on
> one of the freshly created (and empty) volumes.
>
oh sorry I forgot to mention this.
I am able to create and update volumes manually after booting the
system with initramfs.
{{{
Creating rootfs volume:
mknod /dev/ubi0 c 250 0
mknod /dev/ubi0_0 c 250 1
ubiattach /dev/ubi_ctrl -m 2
ubimkvol /dev/ubi0 -N rootfs -m
ubiupdatevol /dev/ubi0_0 ubifs-rootfs.img
mount -t ubifs ubi0:rootfs ubi-root/
}}}

But I wanted to do all these automatically during boot time itself.
Also I wanted to use ubinize.cfg as is from the original system and
simulate everything using qemu and nadsim (if possible)
So I thought it must be possible by setting some parameters in qemu such as=
:
mtdparts=3Dnand:,
-device nand,chip_id=3D0x39,drive=3Dmtd0,
-drive if=3Dmtd,file=3D./ubi-boot.img,id=3Dmtd0,
anything else ?

Or maybe do something at the boot time itself to load the volume image ?
If there are some possibilities please let me know.
With this I can use my original setup as it is and verify everything
with different kernel versions.

Thanks,
Pintu
