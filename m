Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F538FDB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhEYJXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhEYJXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 05:23:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F3C061574;
        Tue, 25 May 2021 02:22:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so35242358edt.13;
        Tue, 25 May 2021 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4WpDFzjrpXp5hP9+v4938PGOuID77BZ1+yoSzNr4bw=;
        b=aZgrutsc1m9tSr4hBJxEgoXTPkpi+M04jPX97JYoXk0DECbfii3wJvYf/10Qf2eBuK
         k1wIdc84jsy0PLkiG1QLRUm7WRkFkJNUOJ7kxOcpcWplwI6clR/o52Jnzt2Hnv7CI+iL
         YApQWP86Q2iCfglmBKUZBEbLewHv3AAGVa+n/bp+Pqyn3BH+WA31yoIyV4/vtwP6K0i5
         foZx3ib56Gh6Y61t5cGVd3eei85F68GsG+jdSKqqinNG1KZerpnlOTFEjtCm+DBfBel9
         ke/0+B5oGRNdxlXy+M47uvRh7X/hBT1TobVh7NSwTZF+8y/P6kFDrCX7KTd9kIxL5o7A
         SGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4WpDFzjrpXp5hP9+v4938PGOuID77BZ1+yoSzNr4bw=;
        b=N211E6foPuhhfY3C2eN3VoCOjWx0iVrK08swMVIz5bN3BuZaqMDA23bfueXnv1rbdU
         XpiMlQROeqxtgtn3eqoHnO4+1pjCjyERSi7XMbbcEOXzNGuq6ZMeJTlzT/j0aMUJvytI
         pXNvPvyPFh0BAl7mmo0a0OxlEWx6DncDlEK0zKhDH1z4p4vCCXCsDM5Ao94eCFKWCN5v
         eT3+Rnf3UoqsmnKzUBgKKNvbWRRg3Jk6zI4ldQLWwr6gmekSreJjnSeAgVdzqMCVAkPg
         8gapWlRNEiDyFymLIXyN272PZpZ6Z0Itw/NSnMtrJqgvF9FAZH1sjM5e1DF38yTiGP6Z
         Z+Mw==
X-Gm-Message-State: AOAM533CQQnsa3KLX1H7nefXnTFCP2GREVdTc1q5UbMM6BTzfaJpaIUS
        mXwsZG6IteOWdwy0dnVHKWb7E2yFZoahw1DSqiI=
X-Google-Smtp-Source: ABdhPJxSspRrEdzmSkEjEkJp7+mPyCDdSHTlgwh1A+zFibAdE7o8FKoR4TgcbystH6uJzQMBL8BnZShsXhII1ig9tY8=
X-Received: by 2002:a50:ccdc:: with SMTP id b28mr30538106edj.92.1621934537751;
 Tue, 25 May 2021 02:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
 <1762403920.6716767.1621029029246@webmail.123-reg.co.uk> <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
 <486335206.6969995.1621485014357@webmail.123-reg.co.uk> <CAOuPNLjBsm9YLtcb4SnqLYYaHPnscYq4captvCmsR7DthiWGsQ@mail.gmail.com>
 <1339b24a-b5a5-5c73-7de0-9541455b66af@geanix.com> <CAOuPNLiMnHJJNFBbOrMOLmnxU86ROMBaLaeFxviPENCkuKfUVg@mail.gmail.com>
 <877196209.4648525.1621840046695@webmail.123-reg.co.uk>
In-Reply-To: <877196209.4648525.1621840046695@webmail.123-reg.co.uk>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 25 May 2021 14:52:06 +0530
Message-ID: <CAOuPNLgrwnqv_=Ux5SeY3XTDG2b0=ntRbciWVshhaVwJYFEZ3g@mail.gmail.com>
Subject: Re: [RESEND]: Kernel 4.14: UBIFS+SQUASHFS: Device fails to boot after
 flashing rootfs volume
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 May 2021 at 12:37, Phillip Lougher <phillip@squashfs.org.uk> wrote:
>
> > No, this is still experimental.
> > Currently we are only able to write to ubi volumes but after that
> > device is not booting (with rootfs volume update).
> > However, with "userdata" it is working fine.
> >
> > I have few more questions to clarify.
> >
> > a) Is there a way in kernel to do the ubi volume update while the
> > device is running ?
> >     I tried "ubiupdatevol" but it does not seem to work.
> >     I guess it is only to update the empty volume ?
> >     Or, maybe I don't know how to use it to update the live "rootfs" volume
> >
> > b) How to verify the volume checksum as soon as we finish writing the
> > content, since the device is not booting ?
> >      Is there a way to verify the rootfs checksum at the bootloader or
> > kernel level before mounting ?
> >
> > c) We are configuring the ubi volumes in this way. Is it fine ?
> > [rootfs_volume]
> > mode=ubi
> > image=.<path>/system.squash
> > vol_id=0
> > vol_type=dynamic
> > vol_name=rootfs
> > vol_size=62980096  ==> 60.0625 MiB
> >
> > Few more info:
> > ----------------------
> > Our actual squashfs image size:
> > $ ls -l ./system.squash
> > rw-rr- 1 pintu users 49639424 ../system.squash
> >
> > after earse_volume: page-size: 4096, block-size-bytes: 262144,
> > vtbl-count: 2, used-blk: 38, leb-size: 253952, leb-blk-size: 62
> > Thus:
> > 49639424 / 253952 = 195.46 blocks
> >
> > This then round-off to 196 blocks which does not match exactly.
> > Is there any issue with this ?
> >
> > If you have any suggestions to debug further please help us...
> >
> >
> > Thanks,
> > Pintu
>
> Three perhaps obvious questions here:
>
> 1. As an experimental system, are you using a vanilla (unmodified)
>    Linux kernel, or have you made modifications.  If so, how is it
>    modified?
>
> 2. What is the difference between "rootfs" and "userdata"?
>    Have you written exactly the same Squashfs image to "rootfs"
>    and "userdata", and has it worked with "userdata" and not
>    worked with "rootfs".
>
>    So far it is unclear whether "userdata" has worked because
>    you've written different images/data to it.
>
>    In other words tell us exactly what you're writing to "userdata"
>    and what you're writing to "rootfs".  The difference or non-difference
>    may be significant.
>
> 3. The rounding up to a whole 196 blocks should not be a problem.
>    The problem is, obviously, if it is rounding down to 195 blocks,
>    where the tail end of the Squashfs image will be lost.
>
>    Remember this is exactly what the Squashfs error is saying, the image
>    has been truncated.
>
>    You could try adding a lot of padding to the end of the Squashfs image
>    (Squashfs won't care), so it is more than the effective block size,
>    and then writing that, to prevent any rounding down or truncation.
>

Just wanted to share the Good news that the ubi volume flashing is
working now :)
First I have created a small read-only volume (instead of rootfs) and
tried to write to it and then compared the checksum.
Initially when I checked, the checksum was not matching and when I
compared the 2 images I found there were around 8192 blocks containing
FF data at the end of each erase block.
After the fix, this time the checksum matches exactly.

/data/pintu # md5sum test-vol-orig.img
6a8a185ec65fcb212b6b5f72f0b0d206  test-vol-orig.img

/data/pintu # md5sum test-vol-after.img
6a8a185ec65fcb212b6b5f72f0b0d206  test-vol-after.img

Once this is working, I tried with rootfs volume, and this time the
device is booting fine :)

The fix is related to the data-len and data-offset calculation in our
volume write code.
[...]
size += data_offset;
[...]
ubi_block_write(....)
buf_size -= (size - data_offset);
offset += (size - data_offset);
[...]
In the previous case, we were not adding and subtracting the data_offset.

The Kernel command line we are using is this:
[    0.000000] Kernel command line: ro rootwait
console=ttyMSM0,115200,n8 [..skip..] rootfstype=squashfs
root=/dev/mtdblock34 ubi.mtd=30,0,30 [...skip..]

Hope, this parameters are fine (no change here).

Thank you Phillip and Sean for your help.
Phillip I think this checksum trick really helped me in figuring out
the root cause :)

Glad to work with you...

Thanks,
Pintu
