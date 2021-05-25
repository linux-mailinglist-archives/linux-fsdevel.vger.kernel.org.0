Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC738F9FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 07:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhEYFjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 01:39:15 -0400
Received: from first.geanix.com ([116.203.34.67]:59786 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhEYFjO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 01:39:14 -0400
Received: from [192.168.64.199] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id E782A464055;
        Tue, 25 May 2021 05:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1621921063; bh=rvt46guryJk9/Wnd4YA1ncpdXvc8YqbSChYOuGt4yHs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SV90DYl4ICZDpG7ZH4nflCT3i1GPF6moa91VBUZuB7pYw4uM/FHwbj0Sgu8ld8ymO
         4iGVaNfBOWbAiqVYoaJX7eY79t0A7PSoNj8GfawdVc3AIOcP8dzgZ72sr+wfYNMqeM
         DYtE7AJZI9ijMJBMearYEwVEsDM3+prvy7cSVITEzhZG7xWNrQgIjwsVi53DP/AnM5
         FHF89dLgYm86rk/idx5Bvh2yPJwx5Cxo+mdSk9CBP8iBKeR31EdEt9CmEwGALS75wx
         Phi5VcmePAW9K35mqCfZCr5v4tAUJPoGwlMzJNpwJw+rSh5U8MWsvZSPAMgM/X9eWp
         qpGPmjNexbB0g==
Subject: Re: [RESEND]: Kernel 4.14: UBIFS+SQUASHFS: Device fails to boot after
 flashing rootfs volume
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
 <1762403920.6716767.1621029029246@webmail.123-reg.co.uk>
 <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
 <486335206.6969995.1621485014357@webmail.123-reg.co.uk>
 <CAOuPNLjBsm9YLtcb4SnqLYYaHPnscYq4captvCmsR7DthiWGsQ@mail.gmail.com>
 <1339b24a-b5a5-5c73-7de0-9541455b66af@geanix.com>
 <CAOuPNLiMnHJJNFBbOrMOLmnxU86ROMBaLaeFxviPENCkuKfUVg@mail.gmail.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <4304c082-6fc5-7389-f883-d0adfc95ee86@geanix.com>
Date:   Tue, 25 May 2021 07:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOuPNLiMnHJJNFBbOrMOLmnxU86ROMBaLaeFxviPENCkuKfUVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/05/2021 08.12, Pintu Agarwal wrote:
> On Sun, 23 May 2021 at 23:01, Sean Nyekjaer <sean@geanix.com> wrote:
>>
> 
>>> I have also tried that and it seems the checksum exactly matches.
>>> $ md5sum system.squash
>>> d301016207cc5782d1634259a5c597f9  ./system.squash
>>>
>>> On the device:
>>> /data/pintu # dd if=/dev/ubi0_0 of=squash_rootfs.img bs=1K count=48476
>>> 48476+0 records in
>>> 48476+0 records out
>>> 49639424 bytes (47.3MB) copied, 26.406276 seconds, 1.8MB/s
>>> [12001.375255] dd (2392) used greatest stack depth: 4208 bytes left
>>>
>>> /data/pintu # md5sum squash_rootfs.img
>>> d301016207cc5782d1634259a5c597f9  squash_rootfs.img
>>>
>>> So, it seems there is no problem with either the original image
>>> (unsquashfs) as well as the checksum.
>>>
>>> Then what else could be the suspect/issue ?
>>> If you have any further inputs please share your thoughts.
>>>
>>> This is the kernel command line we are using:
>>> [    0.000000] Kernel command line: ro rootwait
>>> console=ttyMSM0,115200,n8 androidboot.hardware=qcom
>>> msm_rtb.filter=0x237 androidboot.console=ttyMSM0
>>> lpm_levels.sleep_disabled=1 firmware_class.path=/lib/firmware/updates
>>> service_locator.enable=1 net.ifnames=0 rootfstype=squashfs
>>> root=/dev/ubiblock0_0 ubi.mtd=30 ubi.block=0,0
>>>
>>> These are few more points to be noted:
>>> a) With squashfs we are getting below error:
>>> [    4.603156] squashfs: SQUASHFS error: unable to read xattr id index table
>>> [...]
>>> [    4.980519] Kernel panic - not syncing: VFS: Unable to mount root
>>> fs on unknown-block(254,0)
>>>
>>> b) With ubifs (without squashfs) we are getting below error:
>>> [    4.712458] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0,
>>> name "rootfs", R/O mode
>>> [...]
>>> UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node type (255 but expected 9)
>>> UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node at LEB
>>> 336:250560, LEB mapping status 1
>>> Not a node, first 24 bytes:
>>> 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> ff ff ff ff
>>>
>>> c) While flashing "usrfs" volume (ubi0_1) there is no issue and device
>>> boots successfully.
>>>
>>> d) This issue is happening only after flashing rootfs volume (ubi0_0)
>>> and rebooting the device.
>>>
>>> e) We are using "uefi" and fastboot mechanism to flash the volumes.
>> Are you writing the squashfs into the ubi block device with uefi/fastboot?
>>>
>>> f) Next I wanted to check the read-only UBI volume flashing mechanism
>>> within the Kernel itself.
>>> Is there a way to try a read-only "rootfs" (squashfs type) ubi volume
>>> flashing mechanism from the Linux command prompt ?
>>> Or, what are the other ways to verify UBI volume flashing in Linux ?
>>>
>>> g) I wanted to root-cause, if there is any problem in our UBI flashing
>>> logic, or there's something missing on the Linux/Kernel side (squashfs
>>> or ubifs) or the way we configure the system.
> 
>>
>> Have you had it to work? Or is this a new project?
>> If you had it to work, i would start bisecting...
>>
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

We are writing our rootfs with this command:
ubiupdatevol /dev/ubi0_4 rootfs.squashfs

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
> 

Please understand the differences between the UBI and UBIFS. UBI(unsorted block image) and UBIFS(UBI File System).
I think you want to write the squashfs to the UBI(unsorted block image).

Can you try to boot with a initramfs, and then use ubiupdatevol to write the rootfs.squshfs.

/Sean
