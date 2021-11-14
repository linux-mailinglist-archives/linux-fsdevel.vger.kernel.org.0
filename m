Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6F44FA1A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 20:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhKNTWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 14:22:15 -0500
Received: from p3plsmtp23-02-2.prod.phx3.secureserver.net ([68.178.252.164]:40559
        "EHLO p3plwbeout23-02.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236178AbhKNTWH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:22:07 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Nov 2021 14:22:07 EST
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id mKtbmo6o0bs7KmKtcmX8rd; Sun, 14 Nov 2021 12:10:32 -0700
X-CMAE-Analysis: v=2.4 cv=IYRC5Uma c=1 sm=1 tr=0 ts=61915f28
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=vIxV3rELxO4A:10 a=pGLkceISAAAA:8
 a=Mf-47KkiosanKr8LZmEA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  mKtbmo6o0bs7K
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1mmKta-000C30-IJ; Sun, 14 Nov 2021 19:10:31 +0000
Message-ID: <4b99139a-802a-8255-adf5-2d3f9d0ccf7c@squashfs.org.uk>
Date:   Sun, 14 Nov 2021 19:10:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Kernel-4.14: With ubuntu-18.04 building rootfs images and booting
 gives SQUASHFS error: xz decompression failed, data probably corrupt
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Daniel Rosenberg <drosen@google.com>, astrachan@google.com,
        speed.eom@samsung.com, Sami Tolvanen <samitolvanen@google.com>,
        snitzer@redhat.com, squashfs-devel@lists.sourceforge.net
References: <CAOuPNLinoW5Cx=xbUcT-DB4RiQkAPpe=9hsc-Rkch0LxD0mh+Q@mail.gmail.com>
 <CAOuPNLgquwOJg85kDcf67+4kTYP9N=45FvV+VDTJr6txYi5-wg@mail.gmail.com>
 <CAOuPNLjFtS7ftg=+-K3S+0ndyNYmUNqXo7SHkyV4zK4G9bZ4Og@mail.gmail.com>
 <CAOuPNLg_YwyhK6iPZZbRWe57Kkr1d8LjJaDniCvvOqk4t2-Sog@mail.gmail.com>
 <CAOuPNLgYhm=goOiABjUFsAvRW+s2NqHjHYdm5MA9PvoUAMxOpg@mail.gmail.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <CAOuPNLgYhm=goOiABjUFsAvRW+s2NqHjHYdm5MA9PvoUAMxOpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfC7uEvtm1c9Ob5ZRw6yUx9aWnQebPTpTQrB6eoTQZQy3tI/jgNwO2i9rpqf1sv/4FeqNH2y5A3BLBRm2Wnr+msfm/85DLixyQVlYNLZx1/OhVbNLuBTi
 yLiFlyHscVIzqHmDvHO71eTk/6iw4iaup24Bu1fPx19QkjFQPr4vAZuy0BZHQ1SLUMsYe1J3tcFdedcAwPtgjzyMkF8C5TCH5QxC2v/ZeQcXR3kL0aZgzBb0
 Enc1KNOr6VHZ7cVXnO5tew==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/11/2021 07:06, Pintu Agarwal wrote:
> + Adding squashfs-devel to get opinion from squashfs side.
> 
> On Fri, 12 Nov 2021 at 12:48, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>>
>> Hi,
>>
>> On Tue, 9 Nov 2021 at 21:04, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>>
>>>>> We only get these squashfs errors flooded in the boot logs:
>>>>> {{{
>>>>> ....
>>>>> [    5.153479] device-mapper: init: dm-0 is ready
>>>>> [    5.334282] VFS: Mounted root (squashfs filesystem) readonly on device 253:0.
>>>>> ....
>>>>> [    8.954120] SQUASHFS error: xz decompression failed, data probably corrupt
>>>>> [    8.954153] SQUASHFS error: squashfs_read_data failed to read block 0x1106
>>>>> [    8.970316] SQUASHFS error: Unable to read data cache entry [1106]
>>>>> [    8.970349] SQUASHFS error: Unable to read page, block 1106, size 776c
>>>>> [    8.980298] SQUASHFS error: Unable to read data cache entry [1106]
>>>>> [    8.981911] SQUASHFS error: Unable to read page, block 1106, size 776c
>>>>> [    8.988280] SQUASHFS error: Unable to read data cache entry [1106]
>>>>> ....
>>>>> }}}
>>>>>
>>
>> One more observation:
>> When I disable FEC flag in bootloader, I see the below error:
>> [    8.360791] device-mapper: verity: 253:0: data block 2 is corrupted
>> [    8.361134] device-mapper: verity: 253:0: data block 3 is corrupted
>> [    8.366016] SQUASHFS error: squashfs_read_data failed to read block 0x1106
>> [    8.379652] SQUASHFS error: Unable to read data cache entry [1106]
>> [    8.379680] SQUASHFS error: Unable to read page, block 1106, size 7770
>>
>> Also, now I see that the decompress error is gone, but the read error
>> is still there.
>>
>> This seems to me that dm-verity detects some corrupted blocks but with
>> FEC it auto corrects itself, how when dm-verity auto corrects itself,
>> the squashfs decompression algorithm somehow could not understand it.
>>
>> So, it seems like there is some mis-match between the way FEC
>> correction and the squashfs decompression happens ?
>>
>> Is this issue seen by anybody else here ?
>>
> 
> The squashfs version used by Kernel:
> [    0.355958] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> 
> The squashfs version available on Ubuntu:
> mksquashfs version 4.3-git (2014/06/09)
> 
> The squashfs version used by Yocto 2.6:
> squashfs-tools/0001-squashfs-tools-Allow-setting-selinux-xattrs-through-.patch:61:
>     printf("mksquashfs version 4.3-git (2014/09/12)\n");
> 
> We create dm-verity squashfs image using version 4.3 whereas, the
> kernel uses 4.0 version to decompress it.
> Is there something missing here?
> 
> When FEC (Forward Error Correction) comes into picture, then squashfs
> decompress fails.
> When we remove FEC flag from dm-verity then decompress works but read
> error still occurs.
> This seems as if something is missing either in FEC handling or either
> in squashfs decompress logic.
> 
> Just wanted to know if there are any fixes already available in the
> mainline for this ?
> 
> 

As Squashfs maintainer I want you to stop randomly blaming anything and 
everything here.  You won't fix anything doing that.

In a previous email you stated


> 
> One quick observation:
> This issue is seen only when we enable dm-verity in our bootloader and
> cross-building the bootloader/kernel (with Yocto 2.6 toolchain
> arm-oe-linux-gnueabi-) on Ubuntu 18.04.
> The issue is *NOT* seen (on the same device) when building the
> dm-verity enabled kernel on Ubuntu 16.04.
>
> Is it something to do with the cross-toolchain difference between
> Ubuntu 16 and 18 ?
> 

If that is the case, then it is not an issue with Squashfs or any
kernel code, it is a build time issue and *that* is where you should
be concentrating your efforts.  Find out what differences are there.

You don't seem to understand that a Squashfs filesystem generated
by any Mksquashfs 4.X is mountable *without* errors on any kernel
since 2.6.29 (January 2009).  Looking for mismatches between
Mksquashfs and/or kernel version and blaming that for the above 
different behaviour is a complete waste of time.

Phillip
