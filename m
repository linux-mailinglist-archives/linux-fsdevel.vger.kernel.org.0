Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A440A381376
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhENWAF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 18:00:05 -0400
Received: from p3plsmtp05-03-02.prod.phx3.secureserver.net ([97.74.135.48]:56580
        "EHLO p3plwbeout05-03.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhENWAE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 18:00:04 -0400
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163])
        by :WBEOUT: with ESMTP
        id hfi1lAcRMQWnThfi3lNRgd; Fri, 14 May 2021 14:51:03 -0700
X-CMAE-Analysis: v=2.4 cv=Vurmv86n c=1 sm=1 tr=0 ts=609ef0c7
 a=ExpeE9u7wY9QIRtJzA+xFA==:117 a=ExpeE9u7wY9QIRtJzA+xFA==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=5FLXtPjwQuUA:10 a=S_-2Y0Uh84wA:10
 a=pGLkceISAAAA:8 a=HhkP5SpAjtIQq_n__E0A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID:  hfi1lAcRMQWnT
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1lhfhV-0000mN-9y; Fri, 14 May 2021 22:50:29 +0100
Date:   Fri, 14 May 2021 22:50:29 +0100 (BST)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        open list <linux-kernel@vger.kernel.org>, sean@geanix.com,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Message-ID: <1762403920.6716767.1621029029246@webmail.123-reg.co.uk>
In-Reply-To: <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
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
X-CMAE-Envelope: MS4xfDniopKcDnq7/kPy6ImW88oea0CzZzcc0Dm/vXQdL5U4Hm6zaAvKl5tEtv8NAfMNKmIxr8gFiucy3VnQqnpRN/2aBec0nAzJtbNc/NfursA6lYbjxTNc
 mxCqsDWAp1TinGIsnCgrtyh2mVaWUQ5zx/7CX8FzTbCPT6400uVvdqwXXC30rFkIgn7dTeB+fc6kv0eHH6LOCWzJCL/2O9yytOUyZpcF0eAmG86NpPErck+W
 EsvWw44WUfaySnEGsqC+N7XPRhjupb+Bz0tHys9k401Bvoidcb226gDh80QJnwHWQ+b6PmtPgohxBDvsbTCTa6S9e7myM5CVztzhtIo/IFmp2QFMCeC/SMTO
 G0raZDNjjzEZNLwhG+oO3GhLRQyBhw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 14/05/2021 13:37 Pintu Agarwal <pintu.ping@gmail.com> wrote:
> 
>  
> Hi,
> 
> This is regarding the squashfs mount failure that I am getting on my
> device during boot time.
> I just wanted to know if someone else has come across this issue, or
> this issue is already fixed, or this is altogether a different issue?
> 
> Here are more details:
> Kernel: 4.14.170 ; Qualcomm chipset (arm32 bit)
> Platform: busybox
> Storage: NAND 512MB
> Filesystem: ubifs + squashfs
> ubi0 : with 5 volumes (rootfs, usrfs, others)
> Kernel command line: ro rootwait console=ttyMSM0,115200,n8
> rootfstype=squashfs root=/dev/mtdblock34 ubi.mtd=30,0,30 ....
> 
> Background:
> We are using ubifs filesystem with squashfs for rootfs (as ready only).
> First we tried to flash "usrfs" (data) volume (ubi0_1) and it worked
> fine (with device booting successfully).
> 
> Next we are trying to flash "rootfs" volume (ubi0_0) now. The volume
> flashing is successful but after that when we reboot the system we are
> getting below errors.
> 
> Logs:
> [....]
> [    4.589340] vreg_conn_pa: dis▒[    4.602779] squashfs: SQUASHFS
> error: unable to read xattr id index table
> [...]
> [    4.964083] No filesystem could mount root, tried:
> [    4.964087]  squashfs
> [    4.966255]
> [    4.973443] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(31,34)
> 
> -----------
> [    4.246861] ubi0: attaching mtd30
> [    4.453241] ubi0: scanning is finished
> [    4.460655] ubi0: attached mtd30 (name "system", size 216 MiB)
> [    4.460704] ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 253952 bytes
> [    4.465562] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 4096
> [    4.472483] ubi0: VID header offset: 4096 (aligned 4096), data offset: 8192
> [    4.479295] ubi0: good PEBs: 864, bad PEBs: 0, corrupted PEBs: 0
> [    4.486067] ubi0: user volume: 5, internal volumes: 1, max. volumes
> count: 128
> [    4.492311] ubi0: max/mean erase counter: 4/0, WL threshold: 4096,
> image sequence number: 1
> [    4.499333] ubi0: available PEBs: 0, total reserved PEBs: 864, PEBs
> reserved for bad PEB handling: 60
> 
> So, we just wanted to know if this issue is related to squashfs or if
> there is some issue with our volume flashing.
> Note: We are using fastboot mechanism to support UBI volume flashing.
> 
> Observation:
> Recently I have seen some squashfs changes related to similar issues
> (xattr) so I wanted to understand if these changes are relevant to our
> issue or not ?
> 
> Age           Commit message(Expand)                                 Author
> 2021-03-30    squashfs: fix xattr id and id lookup sanity checks
> Phillip Lougher
> 2021-03-30    squashfs: fix inode lookup sanity checks
> Sean Nyekjaer
> 2021-02-23    squashfs: add more sanity checks in xattr id lookup
> Phillip Lougher
> 2021-02-23    squashfs: add more sanity checks in inode lookup
> Phillip Lougher
> 2021-02-23    squashfs: add more sanity checks in id lookup
> Phillip Lougher
> 
> Please let us know your opinion about this issue...
> It will help us to decide whether the issue is related to squashfs  or not.
> 
> 
> Thanks,
> Pintu

Your kernel (4.14.170) was released on 5 Feb 2020, and so it won't
contain any of the above commits. The xattr -id code in 4.14.170,
was last updated in May 2011, and so it is much more likely the
problem is elsewhere.

The xattr id index table is written to the end of the Squashfs filesystem,
and it is the first table read on mounting.

As such this is the error you will receive if the Squashfs filesystem
has been truncated in some way. This is by far the most likely reason
for the error.

So you need to check if the Squashfs filesystem image is truncated or
corrupted in some way. This could obviously have happened before
writing to the flash, during writing or afterwards. It could also be
being truncated at read time. The cause could be faulty hardware or
software at any point in the I/O path, at any point in the processs.

So, you need to double check everything at each of the above stages.

1. Check the Squashfs filesystem for correctness before writing it to
the flash. You can run Unsquashfs on the image and see if it reports
any errors.

2. You need to check the filesystem for integrity after writing it to
the flash. Compute a checksum, and compare it with the original
checksum.

In that way you can pinpoint the cause of the truncation/corruption.
But, this is unlikely to be a Squashfs issue, and more likely
truncation/corruption caused by something else.

Phillip
