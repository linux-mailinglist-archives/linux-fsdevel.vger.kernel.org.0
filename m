Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69B138E154
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEXHI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 03:08:57 -0400
Received: from p3plsmtp27-06-2.prod.phx3.secureserver.net ([216.69.139.56]:44285
        "EHLO p3plwbeout27-06.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232238AbhEXHI4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 03:08:56 -0400
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163])
        by :WBEOUT: with ESMTP
        id l4gQl9HSt0UQrl4gRl8d6y; Mon, 24 May 2021 00:07:27 -0700
X-CMAE-Analysis: v=2.4 cv=Ydl4Wydf c=1 sm=1 tr=0 ts=60ab50b0
 a=ExpeE9u7wY9QIRtJzA+xFA==:117 a=ExpeE9u7wY9QIRtJzA+xFA==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=5FLXtPjwQuUA:10 a=S_-2Y0Uh84wA:10
 a=pGLkceISAAAA:8 a=ilKATfAMAAAA:8 a=GNDy42jkh3YXtMofuRQA:9 a=QEXdDO2ut3YA:10
 a=73awMTU50e6eLoBjGbzZ:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID:  l4gQl9HSt0UQr
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1ll4gQ-0008Pe-O3; Mon, 24 May 2021 08:07:26 +0100
Date:   Mon, 24 May 2021 08:07:26 +0100 (BST)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Message-ID: <877196209.4648525.1621840046695@webmail.123-reg.co.uk>
In-Reply-To: <CAOuPNLiMnHJJNFBbOrMOLmnxU86ROMBaLaeFxviPENCkuKfUVg@mail.gmail.com>
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
 <1762403920.6716767.1621029029246@webmail.123-reg.co.uk>
 <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
 <486335206.6969995.1621485014357@webmail.123-reg.co.uk>
 <CAOuPNLjBsm9YLtcb4SnqLYYaHPnscYq4captvCmsR7DthiWGsQ@mail.gmail.com>
 <1339b24a-b5a5-5c73-7de0-9541455b66af@geanix.com>
 <CAOuPNLiMnHJJNFBbOrMOLmnxU86ROMBaLaeFxviPENCkuKfUVg@mail.gmail.com>
Subject: Re: [RESEND]: Kernel 4.14: UBIFS+SQUASHFS: Device fails to boot
 after flashing rootfs volume
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev22
X-Originating-IP: 82.69.79.175
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-Authenticated-As: phillip@squashfs.org.uk
X-122-reg-Authenticated: phillip@squashfs.org.uk
X-CMAE-Envelope: MS4xfAIJw/tWoJLDfWJ9YR/cKUv3pJZbJj1z063OWN8NiR+81r2cVao4r0+HQcyCvcdvxAdvOyDPY25xO7HDqnooF11NGQKoRI/1m0appWOUViNo3ghH9onv
 m6xcXr3s526MTaMqlg2Lsm/sWxjG+i5NlKizPoU6KTooVopCzq4oEDpxgXy3IOnUF9w7Kcu74Z4TCFZyZShd5MYsF9y4YP4gaAOi9RK92ROs9ZpFfzq7iuFL
 nTbQAIQjAp3lMP1GqiKqiDLLHDtWeZ6ejV2r0d9URe+CbU6EjHZkr3iqFyuG3EPoef6rv6fId/ubyZQ6mI/T9O6COHMnRQce0M/HoF7clP2CxA0Sy5iKAsP3
 hv61ArqPw2rlFzA9763ZPXsG5ysHXA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 24/05/2021 07:12 Pintu Agarwal <pintu.ping@gmail.com> wrote:
> 
>  
> On Sun, 23 May 2021 at 23:01, Sean Nyekjaer <sean@geanix.com> wrote:
> >
> 
> > > I have also tried that and it seems the checksum exactly matches.
> > > $ md5sum system.squash
> > > d301016207cc5782d1634259a5c597f9  ./system.squash
> > >
> > > On the device:
> > > /data/pintu # dd if=/dev/ubi0_0 of=squash_rootfs.img bs=1K count=48476
> > > 48476+0 records in
> > > 48476+0 records out
> > > 49639424 bytes (47.3MB) copied, 26.406276 seconds, 1.8MB/s
> > > [12001.375255] dd (2392) used greatest stack depth: 4208 bytes left
> > >
> > > /data/pintu # md5sum squash_rootfs.img
> > > d301016207cc5782d1634259a5c597f9  squash_rootfs.img
> > >
> > > So, it seems there is no problem with either the original image
> > > (unsquashfs) as well as the checksum.
> > >
> > > Then what else could be the suspect/issue ?
> > > If you have any further inputs please share your thoughts.
> > >
> > > This is the kernel command line we are using:
> > > [    0.000000] Kernel command line: ro rootwait
> > > console=ttyMSM0,115200,n8 androidboot.hardware=qcom
> > > msm_rtb.filter=0x237 androidboot.console=ttyMSM0
> > > lpm_levels.sleep_disabled=1 firmware_class.path=/lib/firmware/updates
> > > service_locator.enable=1 net.ifnames=0 rootfstype=squashfs
> > > root=/dev/ubiblock0_0 ubi.mtd=30 ubi.block=0,0
> > >
> > > These are few more points to be noted:
> > > a) With squashfs we are getting below error:
> > > [    4.603156] squashfs: SQUASHFS error: unable to read xattr id index table
> > > [...]
> > > [    4.980519] Kernel panic - not syncing: VFS: Unable to mount root
> > > fs on unknown-block(254,0)
> > >
> > > b) With ubifs (without squashfs) we are getting below error:
> > > [    4.712458] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0,
> > > name "rootfs", R/O mode
> > > [...]
> > > UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node type (255 but expected 9)
> > > UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node at LEB
> > > 336:250560, LEB mapping status 1
> > > Not a node, first 24 bytes:
> > > 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff ff ff
> > >
> > > c) While flashing "usrfs" volume (ubi0_1) there is no issue and device
> > > boots successfully.
> > >
> > > d) This issue is happening only after flashing rootfs volume (ubi0_0)
> > > and rebooting the device.
> > >
> > > e) We are using "uefi" and fastboot mechanism to flash the volumes.
> > Are you writing the squashfs into the ubi block device with uefi/fastboot?
> > >
> > > f) Next I wanted to check the read-only UBI volume flashing mechanism
> > > within the Kernel itself.
> > > Is there a way to try a read-only "rootfs" (squashfs type) ubi volume
> > > flashing mechanism from the Linux command prompt ?
> > > Or, what are the other ways to verify UBI volume flashing in Linux ?
> > >
> > > g) I wanted to root-cause, if there is any problem in our UBI flashing
> > > logic, or there's something missing on the Linux/Kernel side (squashfs
> > > or ubifs) or the way we configure the system.
> 
> >
> > Have you had it to work? Or is this a new project?
> > If you had it to work, i would start bisecting...
> >
> 
> No, this is still experimental.
> Currently we are only able to write to ubi volumes but after that
> device is not booting (with rootfs volume update).
> However, with "userdata" it is working fine.
> 
> I have few more questions to clarify.
> 
> a) Is there a way in kernel to do the ubi volume update while the
> device is running ?
>     I tried "ubiupdatevol" but it does not seem to work.
>     I guess it is only to update the empty volume ?
>     Or, maybe I don't know how to use it to update the live "rootfs" volume
> 
> b) How to verify the volume checksum as soon as we finish writing the
> content, since the device is not booting ?
>      Is there a way to verify the rootfs checksum at the bootloader or
> kernel level before mounting ?
> 
> c) We are configuring the ubi volumes in this way. Is it fine ?
> [rootfs_volume]
> mode=ubi
> image=.<path>/system.squash
> vol_id=0
> vol_type=dynamic
> vol_name=rootfs
> vol_size=62980096  ==> 60.0625 MiB
> 
> Few more info:
> ----------------------
> Our actual squashfs image size:
> $ ls -l ./system.squash
> rw-rr- 1 pintu users 49639424 ../system.squash
> 
> after earse_volume: page-size: 4096, block-size-bytes: 262144,
> vtbl-count: 2, used-blk: 38, leb-size: 253952, leb-blk-size: 62
> Thus:
> 49639424 / 253952 = 195.46 blocks
> 
> This then round-off to 196 blocks which does not match exactly.
> Is there any issue with this ?
> 
> If you have any suggestions to debug further please help us...
> 
> 
> Thanks,
> Pintu

Three perhaps obvious questions here:

1. As an experimental system, are you using a vanilla (unmodified)
   Linux kernel, or have you made modifications.  If so, how is it
   modified?

2. What is the difference between "rootfs" and "userdata"?
   Have you written exactly the same Squashfs image to "rootfs"
   and "userdata", and has it worked with "userdata" and not
   worked with "rootfs".

   So far it is unclear whether "userdata" has worked because
   you've written different images/data to it.

   In other words tell us exactly what you're writing to "userdata"
   and what you're writing to "rootfs".  The difference or non-difference
   may be significant.

3. The rounding up to a whole 196 blocks should not be a problem.
   The problem is, obviously, if it is rounding down to 195 blocks,
   where the tail end of the Squashfs image will be lost.

   Remember this is exactly what the Squashfs error is saying, the image
   has been truncated.

   You could try adding a lot of padding to the end of the Squashfs image
   (Squashfs won't care), so it is more than the effective block size,
   and then writing that, to prevent any rounding down or truncation.

Phillip
