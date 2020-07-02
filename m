Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2799D211CFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 09:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGBH3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 03:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgGBH3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:29:13 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE566C08C5C1;
        Thu,  2 Jul 2020 00:29:12 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so8207128ilk.5;
        Thu, 02 Jul 2020 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1JYUiZsxV/hMqrpLUs3eN2g4ApG1ieFT2Q/4RZEarjc=;
        b=rCWJI7mQ/bCtr5n0mdqafiP2XG4Iimc39L1DpZO3Lg0k56dhrpAtgQLgzRBSF17agA
         L943zCVJlxtNTd5OETRNKM8jHKtxROnLJ3QI7Qp/g1IpuAfLhoTOJSGfU/BCVjMBFwOs
         jxckQsWgrPrzLxoccRKw2AbOS8lrJBST82Uo/5SgpHlAZsvuTInYpl0i+dJr3s1PYr03
         DsjcEh08nbiiiFmRGLlFRJfTngc394pyW7yOhXvSKk6gAjeaNXyf4Wzn0a6MAJbvsRCl
         DPnT1LaqIfKWwEx2kRlw/cJS+9RvwyPp4wXUKYc8Jji7FFqHcGohCjDu6Lmm7jdX1sbd
         R2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1JYUiZsxV/hMqrpLUs3eN2g4ApG1ieFT2Q/4RZEarjc=;
        b=WYa36GyTwlxWWraLhIu4Grjn1YTqdoGAWiNg5+lNEqi29e0oEOzfJHtoHI3Tj0dfB/
         hrevjLUmoT14uksetmWrNTvE1e8+xsbNQsI3i9Yp+HsSihJcGywHHkAKsKSh6kF/NQ0K
         JvtAkvgRMDMysNU4gOLFno1lP2BEhdmIXlP9KiiTznw6IjVeyIxmbeazuVAB8bRjY6ha
         eD9DagHSFPS5O4oDSC4MTUZHiChmZEcFGcZ3swTy8hk/2OObJe028HFkHYlxUOwWuw1V
         FTOAaqu6nSs3wEW1maILwVn49/SZtUDbDK9uUedSYIJBJEz8OBdgzQrx6IbaSst/eQVh
         GCNg==
X-Gm-Message-State: AOAM5311QnNyQmNNU7Hsbv6uEC0RuIxIMoIRwYxAOxmAFQVrBW5yFwDR
        gQKSMaPyP6o3guquo3OroCQSC5FM4WVdKeNnbwHdmWlx1hM=
X-Google-Smtp-Source: ABdhPJzbbDY7urAQRlKLl4KjvuXttgvLDwsny9BZOKcPD5aZ6grseaJPZkGn3cT+o2uRlfKvb8jTRPG9kMBxkBaDgrg=
X-Received: by 2002:a92:940f:: with SMTP id c15mr12132416ili.204.1593674952134;
 Thu, 02 Jul 2020 00:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff@epcas1p3.samsung.com>
 <000201d62835$7ddafe50$7990faf0$@samsung.com> <CA+icZUUjcyrVsDNQ4gHVMYWkLLX9oscme3PmXUnfnc5DojkqVA@mail.gmail.com>
 <CANFS6bbandOzMxFk-VHbHR1FXqbVJSE_Dr3=miQSwwDcJO-v0A@mail.gmail.com>
In-Reply-To: <CANFS6bbandOzMxFk-VHbHR1FXqbVJSE_Dr3=miQSwwDcJO-v0A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 2 Jul 2020 09:29:00 +0200
Message-ID: <CA+icZUUiOqP5=1i6QtorSbjsyaQRe1thwcp36qfTdDUnKKqmJA@mail.gmail.com>
Subject: Re: exfatprogs-1.0.3 version released
To:     Hyunchul Lee <hyc.lee@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 2, 2020 at 6:57 AM Hyunchul Lee <hyc.lee@gmail.com> wrote:
>
> Hello Sedat,
>
> For v1.0.3 and later releases, we can provide tar.xz tarballs, hashes
> and detached signatures.
> But is there a reason why hashes are required despite the signature?
>
> We will let you know when it's done.
>

Hi Hyunchul,

thanks for your feedback and providing tar.xz tarballs.

BTW, Debian uses tar.xz tarballs as default for their packages.

Hashes are for me a way to check if my download was complete and correct.
That is the normal way.
To sign them, too.

Some days ago I downloaded Grml ISO-image.
For ISO-images I see you can verify your download via hashes (sha1,
md5 or better sha256 or sha512).
I had once a Red Hat ISO-Image which did not install correctly.
Checking the ISO-Image via offered hashes revealed it was not
complete/correct downloaded.
That happened once in my life.

I see another topic:
In the Debian world we have now exfat-utils (exfat-fuse based) and no
exfatprogs Debian package.
Some days ago Linux v5.7 entered Debian/testing AMD64 - my preferred distro=
.
It's still on my todo-list but I have not tested the kernel-side of
exfat-fs implementation.

As said I contacted the Debian maintainer via PM and he is thinking of
taking the maintenance of exfatprogs.
But he did not do a last decision.

You happen to know what other Linux distributions do in this topic?

Thanks.

Regards,
- Sedat -

[0] https://grml.org/download/
[1] https://packages.debian.org/exfat-utils
[2] https://packages.debian.org/exfat-fuse

> Thanks.
>
> Regards,
> Hyunchul
>
> 2020=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 7:16,=
 Sedat Dilek <sedat.dilek@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Tue, May 12, 2020 at 10:17 AM Namjae Jeon <namjae.jeon@samsung.com> =
wrote:
> > >
> > > Hi folk,
> > >
> > > We have released exfatprogs-1.0.3 version.
> > > Any feedback is welcome!:)
> > >
> > > CHANGES :
> > >  * Rename label.exfat to tune.exfat.
> > >  * tune.exfat: change argument style(-l option for print level,
> > >    -L option for setting label)
> > >  * mkfs.exfat: harmonize set volume label option with tune.exfat.
> > >
> > > NEW FEATURES :
> > >  * Add man page.
> > >
> > > BUG FIXES :
> > >  * Fix the reported build warnings/errors.
> > >  * Add memset to clean garbage in allocation.
> > >  * Fix wrong volume label array size.
> > >  * Open a device using O_EXCL to avoid formatting it while it is moun=
ted.
> > >  * Fix incomplete "make dist" generated tarball.
> > >
> > > The git tree is at:
> > >       https://github.com/exfatprogs/exfatprogs
> > >
> > > The tarballs can be found at:
> > >       https://github.com/exfatprogs/exfatprogs/releases/download/1.0.=
3/exfatprogs-1.0.3.tar.gz
> > >
> >
> > Hi,
> >
> > thanks for the upgrade.
> >
> > Today, I contacted the Debian maintainer on how he wants to
> > distinguish between exfat-utils vs. exfatprogs as Linux v5.7 entered
> > Debian/unstable.
> >
> > When I looked at the release/tags page on github:
> >
> > Can you please offer tar.xz tarballs, please?
> > Hashes? Like sha256sum
> > Signing keys? (Signed tarballs?)
> >
> > Thanks.
> >
> > Regards,
> > - Sedat -
