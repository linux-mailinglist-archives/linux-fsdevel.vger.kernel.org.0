Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BAC3D228D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhGVKaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 06:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhGVKaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:30:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396FEC061575;
        Thu, 22 Jul 2021 04:10:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ee25so6283320edb.5;
        Thu, 22 Jul 2021 04:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bB4VtmJFxxMk/xBdcOQ1aAgpkQfyBX7MX2ec1/1+iic=;
        b=kS8N55z/Mvvyqlvp1E5NKwCjT4j99fk1wbSreQcjnCFZZsU7Bh5VqyE1wmM9X18znC
         TMJnNpDiSyrcNnMiYG6Kggc97uaIFNHZlxaQIqMp2bHz4UUgGi7YGg9G18IEDxlH+ACC
         wMhw7fE6DLlLZob+k8ZvVGvbTCyVUv5vErhRggVkfD9adlzkHza1sZUkUOFCuD0omtlr
         hJT/jtngpCE+rIMfgocltP39U68xb+xt0KpHmHMbH8JLUQH/yNYRUqWStTVXeAhx/lvZ
         ZmYS8iGhs9Df5x4d+InHU6Hxqgmqc9WgkjnFkCNXmtpznjNP2/eYi5l0mEIm+YgSUzrt
         YkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bB4VtmJFxxMk/xBdcOQ1aAgpkQfyBX7MX2ec1/1+iic=;
        b=mpnV11yxLolOigXJZeYdPUd+6rgsSJ14fBGd2XtDW5kh3zX0/QWcNybvfnXMgc8a4m
         Kf9twkGaU+cVXf8CGrIVaKBBdfTWYoVvMVAYkaUU0TNM7Qgm85F0Vb/OtXGL5lO0dENc
         Hh4u3AMrMso+sQgdC9UsseEApHZsiImfcXeTVOEVh7eJvJ9ypdLZYpWPdbc/lCngYY3r
         qccJhNizoU5u0QnH0S6HPELViT7JoNUo4CpaY+NBo1GqjRhMVTRzRLplZphC4Xq3VIdx
         dRiAcIgWmY8etNOWVdNFbD4J0Vx0kONreft8AloKduyWu+4nDicYNHovKd1tvRtl6qnq
         NZqA==
X-Gm-Message-State: AOAM530hnjhQ8cVtl8ihhzQ2GdOsBIVAsTzsmdxbvO2E7iIGytTARCBb
        NgZ4xV/HB70/Ln6lIGbuiD4rIOKAOMV5sAHz68k=
X-Google-Smtp-Source: ABdhPJxfnXX/pOEUxaSfYeYzP/ePzj4psI/hct4tmT+zwV5PstjA001Zgw8aamUPhp7zuqIJ4TTRbyX/Qbj5vJ+xi6Y=
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr52960170edv.230.1626952237710;
 Thu, 22 Jul 2021 04:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at>
 <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com>
 <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at> <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at>
In-Reply-To: <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 22 Jul 2021 16:40:26 +0530
Message-ID: <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 22 Jul 2021 at 02:24, Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> >> But let me advertise ubiblock a second time.
> > Sorry, I could not understand about the ubiblock request. Is it
> > possible to elaborate little more ?
> > We are already using squashfs on top of our UBI volumes (including
> > rootfs mounting).
> > This is the kernel command line we pass:
> > rootfstype=3Dsquashfs root=3D/dev/mtdblock44 ubi.mtd=3D40,0,30
> > And CONFIG_MTD_UBI_BLOCK=3Dy is already enabled in our kernel.
> > Do we need to do something different for ubiblock ?
>
> From that command line I understand that you are *not* using squashfs on =
top of UBI.
> You use mtdblock. ubiblock is a mechanism to turn an UBI volume into a re=
ad-only
> block device.
> See: http://www.linux-mtd.infradead.org/doc/ubi.html#L_ubiblock
>
Okay, you mean to say, we should use this ?
ubi.mtd=3D5 ubi.block=3D0,0 root=3D/dev/ubiblock0_0
Instead of this:
root=3D/dev/mtdblock44 ubi.mtd=3D40,0,30

Okay I will discuss this internally and check..

> >> If you place your squashfs on a UBI static volume, UBI knows the exact=
 length
> >> and you can checksum it
> >> more easily.
> > Yes, we use squashfs on UBI volumes, but our volume type is still dynam=
ic.
> > Also, you said, UBI knows the exact length, you mean the whole image le=
ngth ?
> > How can we get this length at runtime ?
>
> You need a static volume for that. If you update a static volume the leng=
th is
> known by UBI.
>
Thank you so much for your reply!

Sorry, I could not get this part. How static volume can give image len ?
You mean there is some interface available in kernel to get actual image le=
n ?

> > Also, how can we get the checksum of the entire UBI volume content
> > (ignoring the erased/empty/bad block content) ?
>
> Just read from the volume. /dev/ubiX_Y.
>
I think this also will give the entire volume size, but we still don't know=
 how
many pages have real data ?
For example:
Suppose, my raw partition/volume is of size 10MB
But my actual data inside it is of size ~3MB (may be split across?)
Then, how can we get the actual size of the data content ?
You mean to say: /dev/ubiX_Y should contain only data blocks ?

> > Or, you mean to say, the whole checksum logic is in-built inside the
> > UBI layer and users don't need to worry about the integrity at all ?
>
