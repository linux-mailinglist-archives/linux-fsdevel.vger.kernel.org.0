Return-Path: <linux-fsdevel+bounces-49507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC76EABD9C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E431886355
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B80242D7F;
	Tue, 20 May 2025 13:41:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19ECBA45;
	Tue, 20 May 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748499; cv=none; b=ULBQvn0Wic0VgXmgstY0osGnH/7PCBfsmJVDSKDCj3rEtXSudAJaXNEGuJAqf2fbDu4V23vKUjUv1go4kUvKu0pabAKOOF3qbgJSNoB7BN5zsCbdN2mujXQN5Zw/XnS7uAfWmIIsNXQDVKmSSnqoBdMHnaPsZwCQ1snkaYsE/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748499; c=relaxed/simple;
	bh=Pl97RPJA65yK6wsBR+Mdo3QzFLJwyLoN2KOV3HaMVWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khqCIRD3J1ryb6x0ZZFErmnAi/VGfcfY0ixcq69DFDUgzJe/0w1YEByJLG7DM7+EPDR/3sDN4vD5wX4RIEXli+IDEGpnwg75/V7fdAth8ZziMDG0rzVqbUsQ6P83eaB01+2yANRNXHm58aXOQb/ETJ+oKaEvzzAE9Mv6v1JmXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b1wgW1yr4z4f3k5c;
	Tue, 20 May 2025 21:41:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 18A5E1A0359;
	Tue, 20 May 2025 21:41:31 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl+IhixoqLbsMw--.53088S3;
	Tue, 20 May 2025 21:41:29 +0800 (CST)
Message-ID: <1988ee26-c250-41c3-a5eb-aa3af70828a2@huaweicloud.com>
Date: Tue, 20 May 2025 21:41:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] ext4: enable large folio for regular files
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
 libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <aCxbeamCS5r2ivy5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aCxbeamCS5r2ivy5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnSl+IhixoqLbsMw--.53088S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4fKFWDJF4fAw4rtr13Jwb_yoW7WrW8p3
	4a9F43Kr4Sg34UC397Ar1YqrW0ya1UJr4rAa4xW340vryUAr17uw1Igr4F93srAryxCr1S
	yrWUAryxuF1YyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/20 18:37, Ojaswin Mujoo wrote:
> On Mon, May 12, 2025 at 02:33:11PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Changes since v1:
>>  - Rebase codes on 6.15-rc6.
>>  - Drop the modifications in block_read_full_folio() which has supported
>>    by commit b72e591f74de ("fs/buffer: remove batching from async
>>    read").
>>  - Fine-tuning patch 6 without modifying the logic.
>>
>> v1: https://lore.kernel.org/linux-ext4/20241125114419.903270-1-yi.zhang@huaweicloud.com/
>>
>> Original Description:
>>
>> Since almost all of the code paths in ext4 have already been converted
>> to use folios, there isn't much additional work required to support
>> large folios. This series completes the remaining work and enables large
>> folios for regular files on ext4, with the exception of fsverity,
>> fscrypt, and data=journal mode.
>>
>> Unlike my other series[1], which enables large folios by converting the
>> buffered I/O path from the classic buffer_head to iomap, this solution
>> is based on the original buffer_head, it primarily modifies the block
>> offset and length calculations within a single folio in the buffer
>> write, buffer read, zero range, writeback, and move extents paths to
>> support large folios, doesn't do further code refactoring and
>> optimization.
>>
>> This series have passed kvm-xfstests in auto mode several times, every
>> thing looks fine, any comments are welcome.
>>
>> About performance:
>>
>> I used the same test script from my iomap series (need to drop the mount
>> opts parameter MOUNT_OPT) [2], run fio tests on the same machine with
>> Intel Xeon Gold 6240 CPU with 400GB system ram, 200GB ramdisk and 4TB
>> nvme ssd disk. Both compared with the base and the IOMAP + large folio
>> changes.
>>
>>  == buffer read ==
>>
>>                 base          iomap+large folio base+large folio
>>  type     bs    IOPS  BW(M/s) IOPS  BW(M/s)     IOPS   BW(M/s)
>>  ----------------------------------------------------------------
>>  hole     4K  | 576k  2253  | 762k  2975(+32%) | 747k  2918(+29%)
>>  hole     64K | 48.7k 3043  | 77.8k 4860(+60%) | 76.3k 4767(+57%)
>>  hole     1M  | 2960  2960  | 4942  4942(+67%) | 4737  4738(+60%)
>>  ramdisk  4K  | 443k  1732  | 530k  2069(+19%) | 494k  1930(+11%)
>>  ramdisk  64K | 34.5k 2156  | 45.6k 2850(+32%) | 41.3k 2584(+20%)
>>  ramdisk  1M  | 2093  2093  | 2841  2841(+36%) | 2585  2586(+24%)
>>  nvme     4K  | 339k  1323  | 364k  1425(+8%)  | 344k  1341(+1%)
>>  nvme     64K | 23.6k 1471  | 25.2k 1574(+7%)  | 25.4k 1586(+8%)
>>  nvme     1M  | 2012  2012  | 2153  2153(+7%)  | 2122  2122(+5%)
>>
>>
>>  == buffer write ==
>>
>>  O: Overwrite; S: Sync; W: Writeback
>>
>>                      base         iomap+large folio    base+large folio
>>  type    O S W bs    IOPS  BW     IOPS  BW(M/s)        IOPS  BW(M/s)
>>  ----------------------------------------------------------------------
>>  cache   N N N 4K  | 417k  1631 | 440k  1719 (+5%)   | 423k  1655 (+2%)
>>  cache   N N N 64K | 33.4k 2088 | 81.5k 5092 (+144%) | 59.1k 3690 (+77%)
>>  cache   N N N 1M  | 2143  2143 | 5716  5716 (+167%) | 3901  3901 (+82%)
>>  cache   Y N N 4K  | 449k  1755 | 469k  1834 (+5%)   | 452k  1767 (+1%)
>>  cache   Y N N 64K | 36.6k 2290 | 82.3k 5142 (+125%) | 67.2k 4200 (+83%)
>>  cache   Y N N 1M  | 2352  2352 | 5577  5577 (+137%  | 4275  4276 (+82%)
>>  ramdisk N N Y 4K  | 365k  1424 | 354k  1384 (-3%)   | 372k  1449 (+2%)
>>  ramdisk N N Y 64K | 31.2k 1950 | 74.2k 4640 (+138%) | 56.4k 3528 (+81%)
>>  ramdisk N N Y 1M  | 1968  1968 | 5201  5201 (+164%) | 3814  3814 (+94%)
>>  ramdisk N Y N 4K  | 9984  39   | 12.9k 51   (+29%)  | 9871  39   (-1%)
>>  ramdisk N Y N 64K | 5936  371  | 8960  560  (+51%)  | 6320  395  (+6%)
>>  ramdisk N Y N 1M  | 1050  1050 | 1835  1835 (+75%)  | 1656  1657 (+58%)
>>  ramdisk Y N Y 4K  | 411k  1609 | 443k  1731 (+8%)   | 441k  1723 (+7%)
>>  ramdisk Y N Y 64K | 34.1k 2134 | 77.5k 4844 (+127%) | 66.4k 4151 (+95%)
>>  ramdisk Y N Y 1M  | 2248  2248 | 5372  5372 (+139%) | 4209  4210 (+87%)
>>  ramdisk Y Y N 4K  | 182k  711  | 186k  730  (+3%)   | 182k  711  (0%)
>>  ramdisk Y Y N 64K | 18.7k 1170 | 34.7k 2171 (+86%)  | 31.5k 1969 (+68%)
>>  ramdisk Y Y N 1M  | 1229  1229 | 2269  2269 (+85%)  | 1943  1944 (+58%)
>>  nvme    N N Y 4K  | 373k  1458 | 387k  1512 (+4%)   | 399k  1559 (+7%)
>>  nvme    N N Y 64K | 29.2k 1827 | 70.9k 4431 (+143%) | 54.3k 3390 (+86%)
>>  nvme    N N Y 1M  | 1835  1835 | 4919  4919 (+168%) | 3658  3658 (+99%)
>>  nvme    N Y N 4K  | 11.7k 46   | 11.7k 46   (0%)    | 11.5k 45   (-1%)
>>  nvme    N Y N 64K | 6453  403  | 8661  541  (+34%)  | 7520  470  (+17%)
>>  nvme    N Y N 1M  | 649   649  | 1351  1351 (+108%) | 885   886  (+37%)
>>  nvme    Y N Y 4K  | 372k  1456 | 433k  1693 (+16%)  | 419k  1637 (+12%)
>>  nvme    Y N Y 64K | 33.0k 2064 | 74.7k 4669 (+126%) | 64.1k 4010 (+94%)
>>  nvme    Y N Y 1M  | 2131  2131 | 5273  5273 (+147%) | 4259  4260 (+100%)
>>  nvme    Y Y N 4K  | 56.7k 222  | 56.4k 220  (-1%)   | 59.4k 232  (+5%)
>>  nvme    Y Y N 64K | 13.4k 840  | 19.4k 1214 (+45%)  | 18.5k 1156 (+38%)
>>  nvme    Y Y N 1M  | 714   714  | 1504  1504 (+111%) | 1319  1320 (+85%)
>>
>> [1] https://lore.kernel.org/linux-ext4/20241022111059.2566137-1-yi.zhang@huaweicloud.com/
>> [2] https://lore.kernel.org/linux-ext4/3c01efe6-007a-4422-ad79-0bad3af281b1@huaweicloud.com/
>>
>> Thanks,
>> Yi.
> 
> Hi Yi,
> 
> I don't see any obvious functional regressions on PowerPC with 64k
> pagesize. I know Ted has picked this up, but feel free to add:
> 
> Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> # on powerpc ps > bs
> 
> I'll give my RVBs individually, since I'm still not sure about some of
> the patches.
> 

Thank you very much for the test and review.

Best Regards,
Yi.




