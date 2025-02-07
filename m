Return-Path: <linux-fsdevel+bounces-41189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA93A2C297
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DF91692AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23291E5B6B;
	Fri,  7 Feb 2025 12:22:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73031DE8AE;
	Fri,  7 Feb 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930978; cv=none; b=DGVUBqHQ4AnBt4okN4PwnWyd4qE6703wdZyg3r7QuebNaj0aZ/Qs7s0AvFklL4qcQj/mbxshZyKe8SHUMk3apa6HqP9/V8Y7mgFxnIMVdd3D8XQciBz1rbEKk/AccHGkfMXR9ogx4XrxY8INhcBW8Q4OJM4tr3GY/MnSj56hPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930978; c=relaxed/simple;
	bh=AdBS0I8vu7ciAZPZL8z1n8FfsdCUbedyn0kNYo9MOvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ge5oPDvHbw9kmJnVn/GdEwhAfIM4ypNNnNFpRoQQihovfYxl0I5hWgjZXzsFcZT8IK19XzwvJpTNGilaf3nPPBDg1Vl6omD6QFlivzDWmdPzdNYbo7r6dJcAe3k0TNoY3mkL7GKmLeB9fUw35goLwGwECggZYmXumdo8v4fspAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YqCls3ByTz4f3jt0;
	Fri,  7 Feb 2025 20:22:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 548CC1A0C4E;
	Fri,  7 Feb 2025 20:22:49 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCH618X+6VnJ9usDA--.50162S3;
	Fri, 07 Feb 2025 20:22:49 +0800 (CST)
Message-ID: <dfd16793-f1fb-4ce6-8ad8-86de0818ff4e@huaweicloud.com>
Date: Fri, 7 Feb 2025 20:22:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/8] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP
 to queue limits features
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
 djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-2-yi.zhang@huaweicloud.com>
 <d0f8315b-e006-498a-b3e8-77542f352d40@oracle.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <d0f8315b-e006-498a-b3e8-77542f352d40@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH618X+6VnJ9usDA--.50162S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWkurykCrW3ZryfCr17ZFb_yoWfZrWrpF
	ykKFyUtryUKF18Awn7ZF1UXFyUAw1kAa43Gr10kFyUJr47Xr1IgF40gFyYgw1DXr4fWw40
	qF4jgr9xua17ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2025/1/29 0:46, John Garry wrote:
> On 15/01/2025 11:46, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Currently, it's hard to know whether the storage device supports unmap
>> write zeroes. We cannot determine it only by checking if the disk
>> supports the write zeroes command, as for some HDDs that do submit
>> actual zeros to the disk media even if they claim to support the write
>> zeroes command, but that should be very slow.
> 
> This second sentence is too long, such that your meaning is hard to understand.
> 
>>
>> Therefor, add a new queue limit feature, BLK_FEAT_WRITE_ZEROES_UNMAP and
> 
> Therefore?
> 
>> the corresponding sysfs entry, to indicate whether the block device
>> explicitly supports the unmapped write zeroes command. Each device
>> driver should set this bit if it is certain that the attached disk
>> supports this command. 
> 
> How can they be certain? You already wrote that some claim to support it, yet don't really. Well, I think that is what you meant.
> 

Hi, John. thanks for your reply!

Sorry for the late and not make it clear enough earlier. Currently, there
are four situations of write zeroes command (aka REQ_OP_WRITE_ZEROES)
supported by various disks and backend storage devices.

A. Devices that do not support the write zeroes command
   These devices have bdev_limits(bdev)->max_write_zeroes_sectors set to
   zero.
B. Devices that support the write zeroes command
   These devices have bdev_limits(bdev)->max_write_zeroes_sectors set to a
   non-zero value. They can be further categorized into three
   sub-situations:
B.1. Devices that write physical zeroes to the media
     These devices perform the write zeroes operation by physically writing
     zeroes to the storage media, which can be very slow (e.g., HDDs).
B.2. Devices that support unmap write zeroes
     These devices can offload the write zeroes operation by unmapping the
     logical blocks, effectively putting them into a deallocated state
     (e.g., SSDs). This operation is typically very fast, allowing
     filesystems to use this command to quickly create zeroed files. NVMe
     and SCSI disk drivers already support this and can query the attached
     disks to determine whether they support unmap write zeroes (please see
     patches 2 and 3 for details).
B.3. The implementation of write zeroes on disks are unknown
     This category includes non-standard disks and some network storage
     devices where the exact implementation of the write zeroes command is
     unclear.

Currently, users can only distinguish A and B through querying

   /sys/block/<disk>/queue/write_zeroes_unmap

However, we cannot differentiate between the three sub-situations within B.
At the very least, we should aim to clearly distinguish between B.1 and B.2
on the standard HDDs and SSDs. After this series, we should set
BLK_FEAT_WRITE_ZEROES_UNMAP for devices in B.2, while leaving it unset for
the other three cases.

>> If the bit is not set, the disk either does not
>> support it, or its support status is unknown.
>>
>> For the stacked devices cases, the BLK_FEAT_WRITE_ZEROES_UNMAP should be
>> supported both by the stacking driver and all underlying devices.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   Documentation/ABI/stable/sysfs-block | 14 ++++++++++++++
>>   block/blk-settings.c                 |  6 ++++++
>>   block/blk-sysfs.c                    |  3 +++
>>   include/linux/blkdev.h               |  3 +++
>>   4 files changed, 26 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
>> index 0cceb2badc83..ab4117cefd9a 100644
>> --- a/Documentation/ABI/stable/sysfs-block
>> +++ b/Documentation/ABI/stable/sysfs-block
>> @@ -722,6 +722,20 @@ Description:
>>           0, write zeroes is not supported by the device.
>>     +What:        /sys/block/<disk>/queue/write_zeroes_unmap
>> +Date:        January 2025
>> +Contact:    Zhang Yi <yi.zhang@huawei.com>
>> +Description:
>> +        [RO] Devices that explicitly support the unmap write zeroes
>> +        operation in which a single write zeroes request with the unmap
>> +        bit set to zero out the range of contiguous blocks on storage
> 
> which bit are you referring to?

Different disks and drivers have different control bit. For NVMe devices,
the control bit is NVME_WZ_DEAC, while for SCSI SSDs, it is set via
"cmd->cmnd[1] = 0x8", please see nvme_setup_write_zeroes() and
sd_setup_write_same[16|10]_cmnd() for details.

> 
>> +        by freeing blocks, rather than writing physical zeroes to the
>> +        media. If write_zeroes_unmap is 1, this indicates that the
>> +        device explicitly supports the write zero command. Otherwise,
>> +        the device either does not support it, or its support status is
>> +        unknown.
> 
> I am struggling to understand the full meaning of a value of '0'.
> 
> Does it means that either:
> a. it does not support write zero
> b. it does support write zero, yet just did not set BLK_FEAT_WRITE_ZEROES_UNMAP
> 

Yes, if it is set to 0, it should be the cases A, B.1 and B.3 I
mentioned above.

>> +
>> +
>>   What:        /sys/block/<disk>/queue/zone_append_max_bytes
>>   Date:        May 2020
>>   Contact:    linux-block@vger.kernel.org
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 8f09e33f41f6..a8bf2f8f0634 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -652,6 +652,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>>           t->features &= ~BLK_FEAT_NOWAIT;
>>       if (!(b->features & BLK_FEAT_POLL))
>>           t->features &= ~BLK_FEAT_POLL;
>> +    if (!(b->features & BLK_FEAT_WRITE_ZEROES_UNMAP))
>> +        t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
> 
> Why not just set this in BLK_FEAT_INHERIT_MASK? It's seems like a sensible thing to do...
> 
No, we can't inherit BLK_FEAT_WRITE_ZEROES_UNMAP if any of the stacking
driver and underlying device not support unmap write zeroes. The
stacking driver should set it by default, and drop it if one unsupported
device attached, please see patch 4 for the device-mapper case.

>>         t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
>>   @@ -774,6 +776,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>>           t->zone_write_granularity = 0;
>>           t->max_zone_append_sectors = 0;
>>       }
>> +
>> +    if (!t->max_write_zeroes_sectors)
>> +        t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
>> +
>>       blk_stack_atomic_writes_limits(t, b);
>>         return ret;
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 767598e719ab..13f22bee19d2 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -248,6 +248,7 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)    \
>>   QUEUE_SYSFS_FEATURE_SHOW(poll, BLK_FEAT_POLL);
>>   QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
>>   QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
>> +QUEUE_SYSFS_FEATURE_SHOW(write_zeroes_unmap, BLK_FEAT_WRITE_ZEROES_UNMAP);
>>     static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
>>   {
>> @@ -468,6 +469,7 @@ QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
>>     QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
>>   QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
>> +QUEUE_RO_ENTRY(queue_write_zeroes_unmap, "write_zeroes_unmap");
>>   QUEUE_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
>>   QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
>>   @@ -615,6 +617,7 @@ static struct attribute *queue_attrs[] = {
>>       &queue_poll_delay_entry.attr,
>>       &queue_virt_boundary_mask_entry.attr,
>>       &queue_dma_alignment_entry.attr,
>> +    &queue_write_zeroes_unmap_entry.attr,
>>       NULL,
>>   };
>>   diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 378d3a1a22fc..14ba1e2709bb 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -335,6 +335,9 @@ typedef unsigned int __bitwise blk_features_t;
>>   #define BLK_FEAT_ATOMIC_WRITES_STACKED \
>>       ((__force blk_features_t)(1u << 16))
>>   +/* supports unmap write zeroes command */
>> +#define BLK_FEAT_WRITE_ZEROES_UNMAP    ((__force blk_features_t)(1u << 17))
> 
> Is this flag ever checked within the kernel?
> 
> If not, I assume your idea is that the user checks this flag via sysfs for the block device which the fs is mounted on just to know if FALLOC_FL_WRITE_ZEROES is definitely fast, right?

You are right.

Thanks,
Yi.


