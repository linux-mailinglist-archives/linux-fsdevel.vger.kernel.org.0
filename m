Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B991211B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 06:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGBE5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 00:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBE5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:57:48 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED336C08C5C1;
        Wed,  1 Jul 2020 21:57:47 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id q15so3816093vso.9;
        Wed, 01 Jul 2020 21:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+0bMkjlNweJe9TFHPH7QDbYYIlGusfAJZ/4YOX6Udzc=;
        b=SoIMie4goVN84DWDKrrQhScJzlrtyk3eda4km0biJrrMKMlO2hXLTjzq1qRYcjsqfR
         J1KAs49bOFxAEXjkEHD3JVmST2xHDQwi3396NfQiVGTRpjvER5x4L0v7tK/tcnRldzB9
         vM6fuzWPJyspAQvxW9WsZJJyG4zpAMlCYLZUnOlpR8zF9VftwChCBfRhZR6yGYOqZdrv
         lUi2oF+6esFFpnmOVRAmN4AiQ23qJMMsMjVRPDX+mNZzcoxsLV8qjCjnJAFxutj8Bcwm
         Vyb9LZ1ak4EiacmeKs7DhSXnpf+5RQ/kADHxN3n5vR9giESkbe/lf/XB0rC1VbammrEO
         fWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+0bMkjlNweJe9TFHPH7QDbYYIlGusfAJZ/4YOX6Udzc=;
        b=CDkAl3lGs/yOsHCO4rFfqzX4qg3gMnxlv4eddXLinmmgHNNI/C3nkjnFaaJIZcLx2z
         xC/vAkLtkOWLqwUvy6QlofSA6Xhi8W3PMRVQwOQGFTO8CDGYpzoTY/FCAeOZOKZlIok1
         V7FKryXg9NuQExKcumceAmkup6Vvxb9Gwy7fmuGF1IO/bsbB7U+WFgsQ/SdN0jz3m7Ff
         Dk4pVPmHaMKIHyI0p87nWQw6tuU1BglEiBOoJ+CWtmPpI/Bkz6aV+gmoyKtYkFO2qVVN
         7lA2W44TwOldGktBBADUmC6C+vSQRXvhB6sZuL1dU267oq6rJexu8Bi6CovQkG0kUp1Z
         svLA==
X-Gm-Message-State: AOAM530ZCY/LQXgzBAxDoBeqbUYQachdUlNTWce6daeVIL1TFCh910pV
        XIfgmd98ZHtP4CZ6nW1GzqNxILutheionpFuoyo=
X-Google-Smtp-Source: ABdhPJy9NjgQQmaoE8GisXsEmJ3aGETwcyd72wUMMPxGQSA0S/P3mvAOMMCkXSX6wJYW4bdBwbWUaHacBwCdGY4n6Yk=
X-Received: by 2002:a67:ed02:: with SMTP id l2mr21816075vsp.137.1593665866885;
 Wed, 01 Jul 2020 21:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff@epcas1p3.samsung.com>
 <000201d62835$7ddafe50$7990faf0$@samsung.com> <CA+icZUUjcyrVsDNQ4gHVMYWkLLX9oscme3PmXUnfnc5DojkqVA@mail.gmail.com>
In-Reply-To: <CA+icZUUjcyrVsDNQ4gHVMYWkLLX9oscme3PmXUnfnc5DojkqVA@mail.gmail.com>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Thu, 2 Jul 2020 13:57:36 +0900
Message-ID: <CANFS6bbandOzMxFk-VHbHR1FXqbVJSE_Dr3=miQSwwDcJO-v0A@mail.gmail.com>
Subject: Re: exfatprogs-1.0.3 version released
To:     sedat.dilek@gmail.com
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

Hello Sedat,

For v1.0.3 and later releases, we can provide tar.xz tarballs, hashes
and detached signatures.
But is there a reason why hashes are required despite the signature?

We will let you know when it's done.

Thanks.

Regards,
Hyunchul

2020=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 7:16, S=
edat Dilek <sedat.dilek@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, May 12, 2020 at 10:17 AM Namjae Jeon <namjae.jeon@samsung.com> wr=
ote:
> >
> > Hi folk,
> >
> > We have released exfatprogs-1.0.3 version.
> > Any feedback is welcome!:)
> >
> > CHANGES :
> >  * Rename label.exfat to tune.exfat.
> >  * tune.exfat: change argument style(-l option for print level,
> >    -L option for setting label)
> >  * mkfs.exfat: harmonize set volume label option with tune.exfat.
> >
> > NEW FEATURES :
> >  * Add man page.
> >
> > BUG FIXES :
> >  * Fix the reported build warnings/errors.
> >  * Add memset to clean garbage in allocation.
> >  * Fix wrong volume label array size.
> >  * Open a device using O_EXCL to avoid formatting it while it is mounte=
d.
> >  * Fix incomplete "make dist" generated tarball.
> >
> > The git tree is at:
> >       https://github.com/exfatprogs/exfatprogs
> >
> > The tarballs can be found at:
> >       https://github.com/exfatprogs/exfatprogs/releases/download/1.0.3/=
exfatprogs-1.0.3.tar.gz
> >
>
> Hi,
>
> thanks for the upgrade.
>
> Today, I contacted the Debian maintainer on how he wants to
> distinguish between exfat-utils vs. exfatprogs as Linux v5.7 entered
> Debian/unstable.
>
> When I looked at the release/tags page on github:
>
> Can you please offer tar.xz tarballs, please?
> Hashes? Like sha256sum
> Signing keys? (Signed tarballs?)
>
> Thanks.
>
> Regards,
> - Sedat -
