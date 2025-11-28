Return-Path: <linux-fsdevel+bounces-70186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14067C931C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 21:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 875AC3465BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 20:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BA2DAFA2;
	Fri, 28 Nov 2025 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="g0QY2q2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D1265CA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764361473; cv=none; b=HbabJDlWH806u5ZNC8QcJhdo0OxgMpow/p9Cx4M+nBPC2R7NL2rLidcaAvoz+kYaAwD3KIdYLagy+IPDriEzzfLM+XJis8SmW4R12VKKs2NwTP6ftW6Ig+dz24z/x1rxP2PQNm8Zgo9HqrZ3I76IF+UWS5c5pymmQIJ1ZgBhkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764361473; c=relaxed/simple;
	bh=RH7XFojMHBVykL2bN4Yut9+cEPEjfC8U4z6bYRlfrHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ne/vB8NEusDyRq8F+tbzGr+j5ZpYjpxACc2iNPJa0fA5//TjSntA41qGZoM7OIrt7KKanNd3WxJMFpnmXeRB222PIZxqu3U0GoIGwEiAtlcKS4/UefQGdASNmH61reIRL19l5Lz5ZkWB0LtKB3y3vtRDfIwzARLnXb8bJ459zXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=g0QY2q2/; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id P4yUvtTo6SdejP4yUv3aEd; Fri, 28 Nov 2025 21:21:51 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1764361311; bh=+T+8WLvnMXr4Hv95E8M++zTG682x+A9AUQ+G4j1EO08=;
	h=From;
	b=g0QY2q2/BZSfQUQqFQ4eWdyfIw1KoduE7LFM2cWgGRjd8cUnnVxaiTHpJflDhlaWk
	 yjvrt22GfOd5o39RjMDiEHKf9Atthgef93t8KUoP9q5/wXireJhKXCrZv/ca4mS8B4
	 7qr/rgsSlT3QTtDhLq5JWCv2Es0MaDlk/0hf2DdoQoOLdFm90JPFTZcUuUSkL01jao
	 78loMYzpJ7KquxDwvbHDokWJUlSyXryy9km5mWDgeQTU3Biu4PMpz1jzp9c4p2KZn6
	 XmFrzJ0vEnR8slSeDab9BnmhwSDGX3dK/IaY7ng5cwDSBDnWmWt3uAMKp+9Bkegp5h
	 UGW1y7uSf456Q==
X-CNFS-Analysis: v=2.4 cv=Kb7SsRYD c=1 sm=1 tr=0 ts=692a045f cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=yB7FpVEhcoUkYgwGBewA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <466de455-a413-424f-9853-7d7d10abce49@inwind.it>
Date: Fri, 28 Nov 2025 21:21:50 +0100
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
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, zfs-devel@list.zfsonlinux.org
References: <4c0c1d27-957c-4a6f-9397-47ca321b1805@suse.com>
 <f7e56d56-014f-4027-ab9d-d602c5e67137@libero.it>
 <45e8a40a-635e-462e-9f83-9210a5961e1b@gmx.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <45e8a40a-635e-462e-9f83-9210a5961e1b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfA7n2R6x3f0ypR0FM8q2NI9lspj9FgcOoKKn0Hpd2KmW3fqmEELl3EBIiGkVy3RAKrqhIQhOInIXE0UFqmzuEuw0yOow0EgqCyXapmv4GH6Z9BIkMPPL
 dOA21ILpSjwVehObKZDzhTuwiMlX8VEg3rBTJ/K38NNDMOnMW1zlqC5m401q9wwYyATKus9GImtLVGBQDYoFYkt1imT7WnJrXtMVsIZWBuorCQrNW0kjskP+
 0EJM/bUFcm06AGReomGFqcP9zvLOtYCRFaVkvy5AlP17YnP+X+T1lNM/mz+BuVYNy87C1vt8zcV1S4nj0kVep58btMGsWaGMpbRto9cNH+o=

On 28/11/2025 21.10, Qu Wenruo wrote:
[...]

>>>
>>> - Larger fs block size or larger IO size
>>>    If the fs block size is larger than the 4K stripe length, it means
>>>    the data checksum is calulated for the whole fs block, and it will
>>>    make rebuild much harder.
>>>
>>>    E.g. fs block size is 16K, stripe length is 4K, and have 4 data
>>>    stripes and 1 parity stripe.
>>>
>>>    If one data stripe is corrupted, the checksum will mismatch for the
>>>    whole 16K, but we don't know which 4K is corrupted, thus has to try
>>>    4 times to get a correct rebuild result.
>>>
>>>    Apply this to a whole disk, then rebuild will take forever...
>>
>> I am not sure about that: the checksum failure should be an exception.
>> A disk failure is more common. But it this case, the parity should be enough
>> to rebuild correctly the data and in the most case the checksum will be correct.
> 
> Well, there will definitely be some crazy corner cases jumping out of the bush, like someone just copy a super block into a completely blank disk, and let btrfs try to rebuild it.
> 
> And not to mention RAID6...

Increasing the logic complexity, you increase the number corner case were computation cost explodes. However for standard user it should not be problematic.

> 
>>
>>>
>>>    But this only requires extra rebuild mechanism for RAID chunks.
>>>
>>>
>>>    The other solution is to introduce another size limit, maybe something
>>>    like data_io_size, and for example using 16K data_io_size, and still
>>>    4K fs block size, with the same 4K stripe length.
>>>
>>>    So that every writes will be aligned to that 16K (a single 4K write
>>>    will dirty the whole 16K range). And checksum will be calculated for
>>>    each 4K block.
>>>
>>>    Then reading the 16K we verify every 4K block, and can detect which
>>>    block is corrupted and just repair that block.
>>>
>>>    The cost will be the extra space spent saving 4x data checksum, and
>>>    the extra data_io_size related code.
>>
>> I am not sure about the assumption that the BS must be equal to 4k*(ndisk-1).
>>
>> This is an upper limit, but you could have different mapping. E.g. another valid
>> example is having BS=4k*(ndisk/2-2). But I think that even more strange arrangement
>> can be done, like:
>>      ndisk = 7
>>      BS=4k*3
> 
> At least for btrfs block size must be power of 2, and the whole fs must follow the same block size.
> So 12K block size is not going to exist.
> 
> We can slightly adjust the stripe length of each chunk, but I tend to not do so until I got an RFC version.
> 
>>
>> so the 2nd stripe is in two different rows:
>>
>>
>>               D1     D2     D2     D4     D5     D6     D7
>>             ------ ------ ------ ------ ------ ------ ------
>>               B1     B1     B1     P1     B2     B2     B2
>>               P2     B3 ....
>>
>> What you really need is that:
>> 1) bs=stripe width <= (ndisk - parity-level)* 4k
>> 2) each bs is never updated in the middle (which would create a new RWM cycle)
>>
>>>
>>>
>>> - Way more rigid device number requirement
>>>    Everything must be decided at mkfs time, the stripe length, fs block
>>>    size/data io size, and number of devices.
>>
>> As wrote above, I suggests to use a "per chunk" fs-bs
> 
> As mentioned, bs must be per-fs, or writes can not be ensured to be bs aligned.


Ok.. try to see from another POV: may be that it would be enough that the allocator  ... allocates space for extent with a specific multiple of ps ?
This and the fact that an extent is immutable, should be enough...

> 
> Thanks,
> Qu
> 
>>
>>>    Sure one can still add more devices than required, but it will just
>>>    behave like more disks with RAID1.
>>>    Each RAIDZ chunk will have fixed amount of devices.
>>>
>>>    And furthermore, one can no longer remove devices below the minimal
>>>    amount required by the RAIDZ chunks.
>>>    If going with 16K blocksize/data io size, 4K stripe length, then it
>>>    will always require 5 disks for RAIDZ1.
>>>    Unless the end user gets rid of all RAIDZ chunks (e.g. convert
>>>    to regular RAID1* or even SINGLE).
>>>
>>> - Larger fs block size/data io size means higher write amplification
>>>    That's the most obvious part, and may be less obvious higher memory
>>>    pressure, and btrfs is already pretty bad at write-amplification.
>>>
>>
>> This is true, but you avoid the RWM cycle which is also expensive.
>>
>>>    Currently page cache is relying on larger folios to handle those
>>>    bs > ps cases, requiring more contigous physical memory space.
>>>
>>>    And this limit will not go away even the end user choose to get
>>>    rid of all RAIDZ chunks.
>>>
>>>
>>> So any feedback is appreciated, no matter from end users, or even ZFS developers who invented RAIDZ in the first place.
>>>
>>> Thanks,
>>> Qu
>>>
>>
>> Let me to add a "my" proposal (which is completely unrelated to your one :-)
>>
>>
>> Assumptions:
>>
>> - an extent is never update (true for BTRFS)
>> - in the example below it is showed a raid5 case; but it can be easily extend for higher redundancy level
>>
>> Nomenclature:
>> - N = disks count
>> - stride = number of consecutive block in a disk, before jumping to other disks
>> - stripe = stride * (N - 1)   # -1 is for raid5, -2 in case of raid6 ...
>>
>> Idea design:
>>
>> - the redundancy is put inside the extent (and not below). Think it like a new kind of compression.
>>
>> - a new chunk type is created composed by a sequence of blocks (4k ?) spread on the disks, where the 1st block is disk1 - offeset 0,  2nd block is disk2 - offset 0 .... Nth block is disk N, offset 0, (N+1)th block is placed at disk1, offset +4K.... Like raid 0 with stride 4k.
>>
>> - option #1 (simpler)
>>
>>      - when an extent is created, every (N-1) blocks a parity block is stored; if the extent is shorter than N-1, a parity block is attached at its end;
>>
>>               D1     D2     D2     D4
>>             ------ ------ ------ ------
>>              E1,0   E1,1   P1,0   E2,0
>>              E2,1   E2,2   P2,1   E2,3
>>              E2,4   P2,1   E3,0   E3,1
>>              E3,2   P3,0   E3,3   E3,4
>>              E3,5   P3,1   E3,6   E3,7
>>              E3,8   P3,2   E3,9   E3,10
>>              P3,3
>>
>>         Dz      Disk #z
>>         Ex,y    Extent x, offset y
>>         Px,y    Parity, extent x, range [y*N...y*N+N-1]
>>
>>
>> - option #2 (more complex)
>>
>>      - like above when an extent is created, every (N-1) blocks a parity block is stored; if the extent is shorter than N-1, a parity block is attached at its end;
>>        The idea is that if an extent spans more than a rows, the logical block can be arranged so the stride may be longer (comparable with the number of the rows).
>>        In this way you can write more *consecutive* 4K block a time (when enough data to write is available). In this case is crucial the delayed block allocation.
>>        See E2,{0,1} and E3,{0,3},E3,{4,7}, E3,{8,10}....
>>
>>               D1     D2     D2     D4
>>             ------ ------ ------ ------
>>              E1,0   E1,1   P1,0   E2,0
>>              E2,1   E2,3   P2,1   E2,4
>>              E2,2   P2,1   E3,0   E3,4
>>              E3,8   P3,0   E3,1   E3,5
>>              E3,9   P3,1   E3,2   E3,6
>>              E3,10  P3,2   E3,3   E3,7
>>              P3,3
>>
>>         Dz      Disk #z
>>         Ex,y    Extent x, offset y
>>         Px,y    Parity, extent x, range row related
>>
>>
>>
>> Pros:
>> - no update in the middle of a stripe with so no RWM cycles anymore
>> - (option 2 only), in case a large write, consecutive blocks can be arranged in the same disk
>> - each block can have its checksum
>> - each stripe can have different raid level
>> - maximum flexibility to change the number of disks
>>
>> Cons:
>> - the scrub logic must be totally redesigned
>> - the map logical block <-> physical block in option#1 is not complex to compute. However in option#2 it will be ... funny to find a good algorithm.
>> - the ratio data-blocks/parity-blocks may be very inefficient for small write.
>> - moving an extent between different block groups with different number of disks, would cause to reallocate the parity blocks inside the extent
>>
>> Best
>> G.Baroncelli
>>
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

