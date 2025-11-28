Return-Path: <linux-fsdevel+bounces-70183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF8C930D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 20:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E286346347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 19:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA5285C98;
	Fri, 28 Nov 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="oRkHD7GW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF212405ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764359522; cv=none; b=XDOR6IpaS6oLFn375znNp4Hxbm+PabhvAPebDkttn862x5+X3zuxlkmbnUdJRZ+SdMP18nqipQ0t49lSkaQsnATpsOh/JLtRDi3t4qY6lMaW1bNqjbCqPXCu2i2g1r4r6V5AjGO06gu1FI0Zzhdrd+dQRX0T16i3bij+EzClsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764359522; c=relaxed/simple;
	bh=fr+jP199sGl3igilTi+Z1y48pflhFtqO7Bl3hqEOijo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FhvFuHwWEkTnkp3OGYqLyZvlEYkES0KOiKz9+RdDO3J/D1q+1hASPIdm/FAk+O+DtcltPeKUxp4Np2JjKK7L8x8KB2+XI06a7BWhaMpWkB6Q2OI+vhHMCw92IPh7tN59NcrPHTjxfEerpcKGmXfBz8TRT+wuy/IfoIu3os5E1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=oRkHD7GW; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id P4T2vwL7JNPOjP4T2vR7Wm; Fri, 28 Nov 2025 20:49:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1764359360; bh=/cxiBHYHSHBK4pdc/WBVYZOwI9cSyPcAiyDzJ7AgTC8=;
	h=From;
	b=oRkHD7GW7WqkgNljKBjLHHKw2zVITIUQDe3z3Jc05N8sDYnNyrkoDB0dhh3zwkl7g
	 QgZ2bqWuzkVtSJaF2FqFQwSrPcWIhGuEoHI8fwnuSjMJvTv4lcszf2hFaBPaMDi1T0
	 1tQZLLbokSGNZQzN9/sE0LCUxzEklVpmIqH/4juVQ67QEFuepyNBLiSUoClv+NWYXk
	 amdFgh314MljwDGyBcZqFOCOyW9+12pThEeYXx6JBzyxanOMHFd1iJcvqiVw0sKmfX
	 MHKYbo/44j0k22vn7ax7fFLNCFUivqVlYGpDDidW3t9hJ+oEzLZ6lsFrDEanCfzzPS
	 fbFeokwRXMUmA==
X-CNFS-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=6929fcc0 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=NGwE20YKNqMAeTZI74wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <f7e56d56-014f-4027-ab9d-d602c5e67137@libero.it>
Date: Fri, 28 Nov 2025 20:49:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: Ideas for RAIDZ-like design to solve write-holes, with larger fs
 block size
To: Qu Wenruo <wqu@suse.com>
References: <4c0c1d27-957c-4a6f-9397-47ca321b1805@suse.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, zfs-devel@list.zfsonlinux.org
In-Reply-To: <4c0c1d27-957c-4a6f-9397-47ca321b1805@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDpanaMlEmEWynxBIBqgLFcHBhnGtHwzSaWvXylp9Zxj9Bzr8KcE9PbdTcjgEppkzUm6g8VF+DkLe1o41r1Su3ocSNwFKyBK0sJmneMz6LIkNpsRUbi+
 sEFYGvYsQb04LcwtNNakxK6iDhCFuW2aeLez4qe9b/cPIScwNNVqWdGfW20tTOjdoZxa8jKgNXXIbUtxnVHMIrV4qdEti9sWwdgSjRA1pyI+3SwOjMjTso9k
 c0A/YvxFUGiq628GBx36x/6HLfbji+3bIONZV3prRHlR6W7PsVd12dgk0vQpJ9YRFwfNJguz4ZfGr8npaHy51w==

On 28/11/2025 04.07, Qu Wenruo wrote:
> Hi,
> 
> With the recent bs > ps support for btrfs, I'm wondering if it's possible to experiment some RAIDZ-like solutions to solve RAID56 write-holes problems (at least for data COW cases) without traditional journal.

More than a RAIDZ-like solution (== a variable stripe size), it seems that you want to use a stripe width equal to the fs block size. So you can avoid the RWM cycles inside a stripe. It is an interesting idea, with a little development cost, which may work quite well when the number of disks * ps matches the fs bs.

In order to reduce some downside, I suggests to use a "per chunk" fs-bs

> 
> Currently my idea looks like this:
> 
> - Fixed and much smaller stripe data length
>    Currently the data stripe length is fixed for all btrfs RAID profiles,
>    64K.
> 
>    But will change to 4K (minimal and default) for RAIDZ chunks.
> 
> - Force a larger than 4K fs block size (or data io size)
>    And that fs block size will determine how many devices we can use for
>    a RAIDZ chunk.
> 
>    E.g. with 32K fs block size, and 4K stripe length, we can use 8
>    devices for data, +1 for parity.
>    But this also means, one has to have at least 9 devices to maintain
>    the this scheme with 4K stripe length.
>    (More is fine, less is not possible)
> 
> 
> But there are still some uncertainty that I hope to get some feedback before starting coding on this.
> 
> - Conflicts with raid-stripe-tree and no zoned support
>    I know WDC is working on raid-stripe-tree feature, which will support
>    all profiles including RAID56 for data on zoned devices.
> 
>    And the feature can be used without zoned device.
> 
>    Although there is never RAID56 support implemented so far.
> 
>    Would raid-stripe-tree conflicts with this new RAIDZ idea, or it's
>    better just wait for raid-stripe-tree?
> 
> - Performance
>    If our stripe length is 4K it means one fs block will be split into
>    4K writes into each device.
> 
>    The initial sequential write will be split into a lot of 4K sized
>    random writes into the real disks.
> 
>    Not sure how much performance impact it will have, maybe it can be
>    solved with proper blk plug?
> 
> - Larger fs block size or larger IO size
>    If the fs block size is larger than the 4K stripe length, it means
>    the data checksum is calulated for the whole fs block, and it will
>    make rebuild much harder.
> 
>    E.g. fs block size is 16K, stripe length is 4K, and have 4 data
>    stripes and 1 parity stripe.
> 
>    If one data stripe is corrupted, the checksum will mismatch for the
>    whole 16K, but we don't know which 4K is corrupted, thus has to try
>    4 times to get a correct rebuild result.
> 
>    Apply this to a whole disk, then rebuild will take forever...

I am not sure about that: the checksum failure should be an exception.
A disk failure is more common. But it this case, the parity should be enough
to rebuild correctly the data and in the most case the checksum will be correct.

> 
>    But this only requires extra rebuild mechanism for RAID chunks.
> 
> 
>    The other solution is to introduce another size limit, maybe something
>    like data_io_size, and for example using 16K data_io_size, and still
>    4K fs block size, with the same 4K stripe length.
> 
>    So that every writes will be aligned to that 16K (a single 4K write
>    will dirty the whole 16K range). And checksum will be calculated for
>    each 4K block.
> 
>    Then reading the 16K we verify every 4K block, and can detect which
>    block is corrupted and just repair that block.
> 
>    The cost will be the extra space spent saving 4x data checksum, and
>    the extra data_io_size related code.

I am not sure about the assumption that the BS must be equal to 4k*(ndisk-1).

This is an upper limit, but you could have different mapping. E.g. another valid
example is having BS=4k*(ndisk/2-2). But I think that even more strange arrangement
can be done, like:
	ndisk = 7
	BS=4k*3

so the 2nd stripe is in two different rows:


              D1     D2     D2     D4     D5     D6     D7
            ------ ------ ------ ------ ------ ------ ------
              B1     B1     B1     P1     B2     B2     B2
              P2     B3 ....

What you really need is that:
1) bs=stripe width <= (ndisk - parity-level)* 4k
2) each bs is never updated in the middle (which would create a new RWM cycle)

> 
> 
> - Way more rigid device number requirement
>    Everything must be decided at mkfs time, the stripe length, fs block
>    size/data io size, and number of devices.

As wrote above, I suggests to use a "per chunk" fs-bs

>    Sure one can still add more devices than required, but it will just
>    behave like more disks with RAID1.
>    Each RAIDZ chunk will have fixed amount of devices.
> 
>    And furthermore, one can no longer remove devices below the minimal
>    amount required by the RAIDZ chunks.
>    If going with 16K blocksize/data io size, 4K stripe length, then it
>    will always require 5 disks for RAIDZ1.
>    Unless the end user gets rid of all RAIDZ chunks (e.g. convert
>    to regular RAID1* or even SINGLE).
> 
> - Larger fs block size/data io size means higher write amplification
>    That's the most obvious part, and may be less obvious higher memory
>    pressure, and btrfs is already pretty bad at write-amplification.
> 

This is true, but you avoid the RWM cycle which is also expensive.

>    Currently page cache is relying on larger folios to handle those
>    bs > ps cases, requiring more contigous physical memory space.
> 
>    And this limit will not go away even the end user choose to get
>    rid of all RAIDZ chunks.
> 
> 
> So any feedback is appreciated, no matter from end users, or even ZFS developers who invented RAIDZ in the first place.
> 
> Thanks,
> Qu
> 

Let me to add a "my" proposal (which is completely unrelated to your one :-)


Assumptions:

- an extent is never update (true for BTRFS)
- in the example below it is showed a raid5 case; but it can be easily extend for higher redundancy level

Nomenclature:
- N = disks count
- stride = number of consecutive block in a disk, before jumping to other disks
- stripe = stride * (N - 1)   # -1 is for raid5, -2 in case of raid6 ...

Idea design:

- the redundancy is put inside the extent (and not below). Think it like a new kind of compression.

- a new chunk type is created composed by a sequence of blocks (4k ?) spread on the disks, where the 1st block is disk1 - offeset 0,  2nd block is disk2 - offset 0 .... Nth block is disk N, offset 0, (N+1)th block is placed at disk1, offset +4K.... Like raid 0 with stride 4k.

- option #1 (simpler)

     - when an extent is created, every (N-1) blocks a parity block is stored; if the extent is shorter than N-1, a parity block is attached at its end;

              D1     D2     D2     D4	
            ------ ------ ------ ------
             E1,0   E1,1   P1,0   E2,0
             E2,1   E2,2   P2,1   E2,3
             E2,4   P2,1   E3,0   E3,1
             E3,2   P3,0   E3,3   E3,4
             E3,5   P3,1   E3,6   E3,7
             E3,8   P3,2   E3,9   E3,10
             P3,3

        Dz      Disk #z
        Ex,y	Extent x, offset y
        Px,y    Parity, extent x, range [y*N...y*N+N-1]


- option #2 (more complex)

     - like above when an extent is created, every (N-1) blocks a parity block is stored; if the extent is shorter than N-1, a parity block is attached at its end;
       The idea is that if an extent spans more than a rows, the logical block can be arranged so the stride may be longer (comparable with the number of the rows).
       In this way you can write more *consecutive* 4K block a time (when enough data to write is available). In this case is crucial the delayed block allocation.
       See E2,{0,1} and E3,{0,3},E3,{4,7}, E3,{8,10}....

              D1     D2     D2     D4	
            ------ ------ ------ ------
             E1,0   E1,1   P1,0   E2,0
             E2,1   E2,3   P2,1   E2,4
             E2,2   P2,1   E3,0   E3,4
             E3,8   P3,0   E3,1   E3,5
             E3,9   P3,1   E3,2   E3,6
             E3,10  P3,2   E3,3   E3,7
             P3,3

        Dz      Disk #z
        Ex,y	Extent x, offset y
        Px,y    Parity, extent x, range row related



Pros:
- no update in the middle of a stripe with so no RWM cycles anymore
- (option 2 only), in case a large write, consecutive blocks can be arranged in the same disk
- each block can have its checksum
- each stripe can have different raid level
- maximum flexibility to change the number of disks

Cons:
- the scrub logic must be totally redesigned
- the map logical block <-> physical block in option#1 is not complex to compute. However in option#2 it will be ... funny to find a good algorithm.
- the ratio data-blocks/parity-blocks may be very inefficient for small write.
- moving an extent between different block groups with different number of disks, would cause to reallocate the parity blocks inside the extent

Best
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

