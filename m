Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78393D8111
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 23:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhG0VQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhG0VQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:16:39 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D6EC061760;
        Tue, 27 Jul 2021 14:16:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h27so10611047qtu.9;
        Tue, 27 Jul 2021 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zei6F6+BbgKDPk/JT5TPStQmPkRCi2WEQwwoBdhRoIY=;
        b=solrd46rzkgzUZMr6uvDwyWIlp4cDe57cqaw9HivmA5r/T6sxH/Qz8iwM3KuA1IWcu
         NrS2JtbmSJwbWfN7H+hfxIq7Aiqc5W2w/tD48fbMdtk2Ecei4CQTVB5dmIeCv7E8ASEk
         7J2hWl6tuBwIjKsQFYJiNum2Q4+RN9W3mQYmgNRxlUKfBTm4IwcUtrhVIn3ThOiyRp1g
         H8DPVWCeOSkT1YX0RNMs9bNiha/N995LI/GSN4QYcJdQuoD+9baFuZ5odVN0eRsYb6I/
         3S8biW6jIpuJPKAVFnNrgfS7yt6MMqywdC5Om1cZWBAOjCV8u4KIGVySVD963Ax4gDX1
         KVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zei6F6+BbgKDPk/JT5TPStQmPkRCi2WEQwwoBdhRoIY=;
        b=JYq8OuFDdcNEzivb1zTOzYyvi9Nr1uh3oaWhk9sds6RuW0mj0PJGKT5Anc8ltGdH+P
         Yi9ru6Lj9GdZu1H+cq4oQc1CsDzOXB6MyRj8F4ZZAB8qWEEdnQELHZA6Eo++0sE5XjVP
         p25krbaC0XgQzEEROEgt4YulQ0aLSGrJTmAgEWFkpP4+OsxpC5JYZbAYlgelLGU5Yf5p
         aKFGu6xfo9TXI2niEZ5IqU1PFvepk/yC7eIEFsSXwR6RxpjLApBey3eYOuGpMTdb2mH4
         DctMrT5FQeVhJkFg8I3RNmmqRxJ7R8my568AC/brrKOKe/yMOdj0TPqgBoMydWpmSdIp
         ffWw==
X-Gm-Message-State: AOAM533Ex9HPlptznNIlWFQksFhEjQ+l4VZ+9bwtq8U9Nhnkvmzgz3jZ
        yMMR+0r7MPIwyGCrJb70VdgrnO65bTQytIOSqEE=
X-Google-Smtp-Source: ABdhPJz7eMTUfDZGZR8ARw+sscj4utcJttleb4w7Knuq362uAZGy2HzIqMJqIOrLcZYkNzHnckOpwxYHoaKXGHEODos=
X-Received: by 2002:ac8:6708:: with SMTP id e8mr20622179qtp.166.1627420597040;
 Tue, 27 Jul 2021 14:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at>
 <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com>
 <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at> <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
In-Reply-To: <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 27 Jul 2021 23:16:25 +0200
Message-ID: <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
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

On Thu, Jul 22, 2021 at 1:11 PM Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Thu, 22 Jul 2021 at 02:24, Richard Weinberger <richard@nod.at> wrote:
> >
> > ----- Urspr=C3=BCngliche Mail -----
> > >> But let me advertise ubiblock a second time.
> > > Sorry, I could not understand about the ubiblock request. Is it
> > > possible to elaborate little more ?
> > > We are already using squashfs on top of our UBI volumes (including
> > > rootfs mounting).
> > > This is the kernel command line we pass:
> > > rootfstype=3Dsquashfs root=3D/dev/mtdblock44 ubi.mtd=3D40,0,30
> > > And CONFIG_MTD_UBI_BLOCK=3Dy is already enabled in our kernel.
> > > Do we need to do something different for ubiblock ?
> >
> > From that command line I understand that you are *not* using squashfs o=
n top of UBI.
> > You use mtdblock. ubiblock is a mechanism to turn an UBI volume into a =
read-only
> > block device.
> > See: http://www.linux-mtd.infradead.org/doc/ubi.html#L_ubiblock
> >
> Okay, you mean to say, we should use this ?
> ubi.mtd=3D5 ubi.block=3D0,0 root=3D/dev/ubiblock0_0
> Instead of this:
> root=3D/dev/mtdblock44 ubi.mtd=3D40,0,30

Yes. But it is not only about a different command line. It is a
different concept.
You use a emulated block device on top of UBI, and not directly on top
of an MTD part.

> Sorry, I could not get this part. How static volume can give image len ?
> You mean there is some interface available in kernel to get actual image =
len ?

use the ubinfo tool. Static volumes know exactly how much they are filled.

> > > Also, how can we get the checksum of the entire UBI volume content
> > > (ignoring the erased/empty/bad block content) ?
> >
> > Just read from the volume. /dev/ubiX_Y.
> >
> I think this also will give the entire volume size, but we still don't kn=
ow how
> many pages have real data ?

"ubiinfo /dev/ubiX_Y" will tell you if the volume is of type static.

> For example:
> Suppose, my raw partition/volume is of size 10MB
> But my actual data inside it is of size ~3MB (may be split across?)
> Then, how can we get the actual size of the data content ?

See above.

> You mean to say: /dev/ubiX_Y should contain only data blocks ?

Yes. An UBI volume contains only "user data".

--=20
Thanks,
//richard
