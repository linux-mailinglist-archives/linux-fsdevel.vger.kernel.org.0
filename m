Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB2B382B26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhEQLg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 07:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbhEQLg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 07:36:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD098C061573;
        Mon, 17 May 2021 04:35:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n2so8674369ejy.7;
        Mon, 17 May 2021 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FCQ4za7ydSGKNQfq/GaeAXtIfgkTGsnkE551SGRAL9o=;
        b=IB9zj1RMby7NHuY+7EN5m0uiAFQ4KX5vVjwATaFjhOVla9g4hl35b4tz/iuyPZBZvY
         TO53L9gA7bcbg6kfi24+bfALq1f8UhZF+LyQKnCznWBhslNChAXgtqX2X/dfceGYSejs
         z/y6qxLL6XKD0/1mtcX0CHf2DdzSrvqT8EK5lz/V3duMoRrrrxoJQSAe2zP87CLyg/HF
         dV1wkNfAsQr/fqnFGW7ROnn95vR2gM4Z84eV+TzD142yjIgzw7r3adE+p70fRc0IxJCK
         kKZeCaMz0o9Yx3y+YDPn1UAZw0vEngxW57zT02arhnkCUOHKci8Dgi7nQ3PTbPIR13FE
         OX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FCQ4za7ydSGKNQfq/GaeAXtIfgkTGsnkE551SGRAL9o=;
        b=rxLV7zPUbcsue0YrPH/ydX59/AEQI4yZVUJ2J2fT1VrNyj6LBM/tfQ63bZf+0DsPb+
         93SvVUfDA6mz8QKKKPJDSS2fcSWjAX/lrTcU0cXskxszsohALsAHXdehrSrPINa1mq6b
         lys2axyXbVAbB2jKzXX1YbuyZnowhJVXhnNEiPqp8kPaRKzmkM7bVVpfNahOun4VehOt
         MD3g0nvV+3+Z9l7j9UUjj5KM9IJoFgGEWgZsh/lu84Gx2A2laXZEe4kzBR1DxQMIE/4V
         husUmrklTiz4TSEN20fwn+ovK8kjQXTjQYbUgLoYfmvyXIJbdZ4tqOJqVpiXCgchGunr
         ymbA==
X-Gm-Message-State: AOAM530+xFhR+oME/cYA3LX2nf0qDeYawGJz0oeKkh20x4T0SCUy22Rq
        TRHhhVBvQ5baiUDk+gpDho47Rig91qilpwOSIgs=
X-Google-Smtp-Source: ABdhPJyxsRSu2QlYp44XYtwgzl6I0bstgqJ8bH0KDvR4FPEZPA6A61/popKdfYsU1DuCwFXs5irRgBvYX3UaMzX40+4=
X-Received: by 2002:a17:906:40d1:: with SMTP id a17mr29376397ejk.43.1621251309364;
 Mon, 17 May 2021 04:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com> <1762403920.6716767.1621029029246@webmail.123-reg.co.uk>
In-Reply-To: <1762403920.6716767.1621029029246@webmail.123-reg.co.uk>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 17 May 2021 17:04:57 +0530
Message-ID: <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
Subject: Re: [RESEND]: Kernel 4.14: SQUASHFS error: unable to read xattr id
 index table
To:     phillip@squashfs.org.uk
Cc:     open list <linux-kernel@vger.kernel.org>, sean@geanix.com,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 15 May 2021 at 03:21, Phillip Lougher <phillip@squashfs.org.uk> wro=
te:
>
> Your kernel (4.14.170) was released on 5 Feb 2020, and so it won't
> contain any of the above commits. The xattr -id code in 4.14.170,
> was last updated in May 2011, and so it is much more likely the
> problem is elsewhere.
>
Okay this seems to be UBI volume flashing issue then. I will also try
with non-squashfs image (just ubifs).
See the result in the end.

> The xattr id index table is written to the end of the Squashfs filesystem=
,
> and it is the first table read on mounting.
>
Okay this gives me a clue that there are some corruptions while
writing the leftover blocks in the end.

> 1. Check the Squashfs filesystem for correctness before writing it to
> the flash. You can run Unsquashfs on the image and see if it reports
> any errors.
>
Can you give me some pointers on how to use unsquashfs ? I could not
find any unsquashfs command on my device.
Do we need to do it on the device or my Ubuntu PC ? Are there some
commands/utility available on ubuntu ?

> 2. You need to check the filesystem for integrity after writing it to
> the flash. Compute a checksum, and compare it with the original
> checksum.
>
Can you also guide me with an example, how to do this as well ?

BTW, I also tried "rootfs" volume flashing using "ubifs" image (non
squashfs). Here are the results.
a) With ubifs image also, the device is not booting after flashing the volu=
me.
b) But I can see that the "rootfs" volume could be mounted, but later
gives some other errors during read_node.

These are the boot up errors logs:
{{{
[ 4.600001] vreg_conn_pa: dis=E2=96=92[ 4.712458] UBIFS (ubi0:0): UBIFS:
mounted UBI device 0, volume 0, name "rootfs", R/O mode
[ 4.712520] UBIFS (ubi0:0): LEB size: 253952 bytes (248 KiB),
min./max. I/O unit sizes: 4096 bytes/4096 bytes
[ 4.719823] UBIFS (ubi0:0): FS size: 113008640 bytes (107 MiB, 445
LEBs), journal size 9404416 bytes (8 MiB, 38 LEBs)
[ 4.729867] UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
[ 4.740400] UBIFS (ubi0:0): media format: w4/r0 (latest is w5/r0),
UUID xxxxxxxxx-xxxxxxxxxx, small LPT model
[ 4.748587] VFS: Mounted root (ubifs filesystem) readonly on device 0:16.
[ 4.759033] devtmpfs: mounted
[ 4.766803] Freeing unused kernel memory: 2048K
[ 4.805035] UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node type
(255 but expected 9)
[ 4.805097] UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node at
LEB 336:250560, LEB mapping status 1
[ 4.812401] Not a node, first 24 bytes:
[ 4.812413] 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ........................
}}}

Seems like there is some corruption in the first 24 bytes ??


Thanks,
Pintu
