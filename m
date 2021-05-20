Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E39389CBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 06:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhETEjZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 00:39:25 -0400
Received: from p3plsmtp25-01-2.prod.phx3.secureserver.net ([216.69.139.12]:35200
        "EHLO p3plwbeout25-01.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhETEjY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 00:39:24 -0400
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163])
        by :WBEOUT: with ESMTP
        id jaK6lMZiOgx69jaK7ljjF7; Wed, 19 May 2021 21:30:15 -0700
X-CMAE-Analysis: v=2.4 cv=Nf4ja0P4 c=1 sm=1 tr=0 ts=60a5e5d8
 a=ExpeE9u7wY9QIRtJzA+xFA==:117 a=ExpeE9u7wY9QIRtJzA+xFA==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=5FLXtPjwQuUA:10 a=S_-2Y0Uh84wA:10
 a=pGLkceISAAAA:8 a=FXvPX3liAAAA:8 a=T2fdhVjMfPcJot0J8BkA:9 a=QEXdDO2ut3YA:10
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID:  jaK6lMZiOgx69
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1ljaK6-0005lk-DN; Thu, 20 May 2021 05:30:14 +0100
Date:   Thu, 20 May 2021 05:30:14 +0100 (BST)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>, sean@geanix.com,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Message-ID: <486335206.6969995.1621485014357@webmail.123-reg.co.uk>
In-Reply-To: <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
 <1762403920.6716767.1621029029246@webmail.123-reg.co.uk>
 <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
Subject: Re: [RESEND]: Kernel 4.14: SQUASHFS error: unable to read xattr id
 index table
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev22
X-Originating-IP: 82.69.79.175
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-Authenticated-As: phillip@squashfs.org.uk
X-122-reg-Authenticated: phillip@squashfs.org.uk
X-CMAE-Envelope: MS4xfOCmG3lER58/+OsQ8SAo7h16KE9Kv5FT4m1+HPnUFSpVz8b4RcOnAIGzSOnOYmSkzwythcWEqeb0CeoDAessXxeyTk33w1pzTDNw12WUH0JvmIDE/XiB
 LiL0k5d0q33CQ8Oi6RIlyV+C6ND6i6nyqwM96DZe45bm4f2gtHZ2tTpGug0s7bzAHXWU/L09I7CiKMpwPKftnSm23bbpmUVwvHF2+psOufhbwBbrTlohvEBG
 G502ve3bhSwrq/xBzmQds/X6N3Up5XHWOOBNe+77Yn0oovAa+qO87UCFo/F7vNmeSsWeyp2jCfpNb8xJ1hvmk/l/Xr/VDqWMjrsKMHQWi6JYp7QWFOi/RCbH
 7J4zPdeX3DGPUaVSpXyEIJz4VV5rhQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 17/05/2021 12:34 Pintu Agarwal <pintu.ping@gmail.com> wrote:
> 
>  
> On Sat, 15 May 2021 at 03:21, Phillip Lougher <phillip@squashfs.org.uk> wrote:
> >
> > Your kernel (4.14.170) was released on 5 Feb 2020, and so it won't
> > contain any of the above commits. The xattr -id code in 4.14.170,
> > was last updated in May 2011, and so it is much more likely the
> > problem is elsewhere.
> >
> Okay this seems to be UBI volume flashing issue then. I will also try
> with non-squashfs image (just ubifs).
> See the result in the end.
> 
> > The xattr id index table is written to the end of the Squashfs filesystem,
> > and it is the first table read on mounting.
> >
> Okay this gives me a clue that there are some corruptions while
> writing the leftover blocks in the end.
> 
> > 1. Check the Squashfs filesystem for correctness before writing it to
> > the flash. You can run Unsquashfs on the image and see if it reports
> > any errors.
> >
> Can you give me some pointers on how to use unsquashfs ? I could not
> find any unsquashfs command on my device.
> Do we need to do it on the device or my Ubuntu PC ? Are there some
> commands/utility available on ubuntu ?
> 

You should run Unsquashfs on the host Ubuntu PC to verify
the integrity of the Squashfs image before transferring and
flashing.

Unsquashfs is in the squashfs-tools package on Ubuntu.  To install
run as root

% apt-get install squashfs-tools

Then run it on your Squashfs image

% unsquashfs <your image>

If the image is uncorrupted, it will unpack the image into
"squashfs-root".  If it is corrupted it will give error
messages.

 
> > 2. You need to check the filesystem for integrity after writing it to
> > the flash. Compute a checksum, and compare it with the original
> > checksum.
> >
> Can you also guide me with an example, how to do this as well ?

I have not used the MTD subsystem for more than 13 years, and so
this is best answered on linux-mtd.  There may be some specfic
UBI/MTD tools available now to do integrity checking.

But failing that, and presuming you have character device access
to the flashed partition, you can "dd" the image out of the flash
into a file, and then run a checksum program against it.

You appear to be running busybox, and this has both support for
"dd" and the "md5sum" checksum program.

So do this

% dd if=<your character device> of=img bs=1 count=<image size>

Where <image size> is the size of the Squashfs image reported
by "ls -l" or "stat".  You need to get the exact byte count
right, otherwise the resultant checksum won't be right.

Then run md5sum on the extracted "img" file.

% md5sum img

This will produce a checksum.

You can then compare that with the result of "md5sum" on your
original Squashfs image before flashing (produced on the host
or the target).

If the checksums differ then it is corrupted.

> 
> BTW, I also tried "rootfs" volume flashing using "ubifs" image (non
> squashfs). Here are the results.
> a) With ubifs image also, the device is not booting after flashing the volume.
> b) But I can see that the "rootfs" volume could be mounted, but later
> gives some other errors during read_node.
> 
> These are the boot up errors logs:
> {{{
> [ 4.600001] vreg_conn_pa: dis▒[ 4.712458] UBIFS (ubi0:0): UBIFS:
> mounted UBI device 0, volume 0, name "rootfs", R/O mode
> [ 4.712520] UBIFS (ubi0:0): LEB size: 253952 bytes (248 KiB),
> min./max. I/O unit sizes: 4096 bytes/4096 bytes
> [ 4.719823] UBIFS (ubi0:0): FS size: 113008640 bytes (107 MiB, 445
> LEBs), journal size 9404416 bytes (8 MiB, 38 LEBs)
> [ 4.729867] UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
> [ 4.740400] UBIFS (ubi0:0): media format: w4/r0 (latest is w5/r0),
> UUID xxxxxxxxx-xxxxxxxxxx, small LPT model
> [ 4.748587] VFS: Mounted root (ubifs filesystem) readonly on device 0:16.
> [ 4.759033] devtmpfs: mounted
> [ 4.766803] Freeing unused kernel memory: 2048K
> [ 4.805035] UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node type
> (255 but expected 9)
> [ 4.805097] UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node at
> LEB 336:250560, LEB mapping status 1
> [ 4.812401] Not a node, first 24 bytes:
> [ 4.812413] 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff ff ........................
> }}}
> 
> Seems like there is some corruption in the first 24 bytes ??
> 

This implies there is corruption being introduced at the MTD level or
below.

Phillip

> 
> Thanks,
> Pintu
