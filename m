Return-Path: <linux-fsdevel+bounces-59003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418AB33DEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E17188D5DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20D2E7F21;
	Mon, 25 Aug 2025 11:25:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1B2DBF69;
	Mon, 25 Aug 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121128; cv=none; b=pk43SL10fY7pzFcTAESLxwCyMm2LrhubJsFrA90PVlG1bthhf2FD1Q2Qe7PbPhcHJ1w3xG9WTvAl/2LLAF3OvtYNZsytMbwPfGbBKxPaNJR2IvV/XDIcyuuJ+YyChLKz1r+IoQQzAiJ4QdYfMYTO4hTeHnZBJOJsVna1tNXGAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121128; c=relaxed/simple;
	bh=DwChpy4ANEjVlPYn/TaBAfYFi6YRdwQVHhewt+5qY8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZFyWQrfw5lQwgmv4GHDEsUgJYukbUAmdRZCyq0jmLBJDb0DW30qfkEdjHZSpUwfoiuAHVs1SarldZyLRvv8x6fv4qCokM1jbQxS2ZK4LxahyoLC6Tqz7QRRBfpBpv0Cp4cqpEorH7EOEP97crc3FlxTyLavNByyYhwNdLk2P6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9T4127PgzKHNJh;
	Mon, 25 Aug 2025 19:25:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DAEE31A1A88;
	Mon, 25 Aug 2025 19:25:20 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCX4o4cSKxo6pz5AA--.64814S3;
	Mon, 25 Aug 2025 19:25:18 +0800 (CST)
Message-ID: <bb1f66f4-da09-4841-a7f7-839047b1fe32@huaweicloud.com>
Date: Mon, 25 Aug 2025 19:25:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] md: init queue_limits->max_hw_wzeroes_unmap_sectors
 parameter
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 drbd-dev@lists.linbit.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.g.garry@oracle.com, hch@lst.de,
 martin.petersen@oracle.com, axboe@kernel.dk, yi.zhang@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
 <20250825083320.797165-2-yi.zhang@huaweicloud.com>
 <8c843d2c-56c1-44af-aa1f-59675885747e@molgen.mpg.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <8c843d2c-56c1-44af-aa1f-59675885747e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX4o4cSKxo6pz5AA--.64814S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWfCr43Ar13tF1kKr17ZFb_yoW7ZF4xpw
	s2qFyIvr98Way8A3yUXw1UuFWrX345C3yqkFy7X3Z5ur17Wry2gF48Xa90gr1DXw4rJw1U
	t3WUKrZru3WUKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi, Paul!

On 8/25/2025 4:59 PM, Paul Menzel wrote:
> Dear Yi,
> 
> 
> Thank you for your patch.
> 
> Am 25.08.25 um 10:33 schrieb Zhang Yi:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The parameter max_hw_wzeroes_unmap_sectors in queue_limits should be
>> equal to max_write_zeroes_sectors if it is set to a non-zero value.
> 
> Excuse my ignorance, but why?

Currently, the max_hw_wzeroes_unmap_sectors parameter is used only to
determine whether the backend device supports the "unmap write zeroes"
operation. If it is set to a non-zero value, it indicates that the
device supports this operation. It depends on the device supports the
write zeroes command, which means that the max_write_zeroes_sectors
should not be zero. However, we do not use this specific value, so the
max_hw_wzeroes_unmap_sectors can only have one of two values:
max_write_zeroes_sectors or 0, any other value is meaningless.

> 
>> However, the stacked md drivers call md_init_stacking_limits() to
>> initialize this parameter to UINT_MAX but only adjust
>> max_write_zeroes_sectors when setting limits. Therefore, this
>> discrepancy triggers a value check failure in blk_validate_limits().
>>
>> Fix this failure by explicitly setting max_hw_wzeroes_unmap_sectors to
>> zero.
> 
> In `linear_set_limits()` and `raid0_set_limits()` you set it to `mddev->chunk_sectors`. Is that intentional?

Yes, the linear and raid0 drivers can support unmap write zeroes
operation if all of the backend devices supports it, so we can initialize
it to chunk_sectors (the same to max_write_zeroes_sectors). raid1/10/5
drivers doesn't support write zeroes, so we have to set it to zero.

> 
>> Fixes: 0c40d7cb5ef3 ("block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits")
>> Reported-by: John Garry <john.g.garry@oracle.com>
>> Closes: https://lore.kernel.org/linux-block/803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com/
> 
> It’d be great if you added the test case to the commit message.

Yeah, I will add a test to blktests.

Thanks,
Yi.

> 
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   drivers/md/md-linear.c | 1 +
>>   drivers/md/raid0.c     | 1 +
>>   drivers/md/raid1.c     | 1 +
>>   drivers/md/raid10.c    | 1 +
>>   drivers/md/raid5.c     | 1 +
>>   5 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
>> index 5d9b08115375..3e1f165c2d20 100644
>> --- a/drivers/md/md-linear.c
>> +++ b/drivers/md/md-linear.c
>> @@ -73,6 +73,7 @@ static int linear_set_limits(struct mddev *mddev)
>>       md_init_stacking_limits(&lim);
>>       lim.max_hw_sectors = mddev->chunk_sectors;
>>       lim.max_write_zeroes_sectors = mddev->chunk_sectors;
>> +    lim.max_hw_wzeroes_unmap_sectors = mddev->chunk_sectors;
>>       lim.io_min = mddev->chunk_sectors << 9;
>>       err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
>>       if (err)
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index f1d8811a542a..419139ad7663 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -382,6 +382,7 @@ static int raid0_set_limits(struct mddev *mddev)
>>       md_init_stacking_limits(&lim);
>>       lim.max_hw_sectors = mddev->chunk_sectors;
>>       lim.max_write_zeroes_sectors = mddev->chunk_sectors;
>> +    lim.max_hw_wzeroes_unmap_sectors = mddev->chunk_sectors;
>>       lim.io_min = mddev->chunk_sectors << 9;
>>       lim.io_opt = lim.io_min * mddev->raid_disks;
>>       lim.chunk_sectors = mddev->chunk_sectors;
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 408c26398321..35c6498b4917 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -3211,6 +3211,7 @@ static int raid1_set_limits(struct mddev *mddev)
>>         md_init_stacking_limits(&lim);
>>       lim.max_write_zeroes_sectors = 0;
>> +    lim.max_hw_wzeroes_unmap_sectors = 0;
>>       lim.features |= BLK_FEAT_ATOMIC_WRITES;
>>       err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
>>       if (err)
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index b60c30bfb6c7..9832eefb2f15 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -4008,6 +4008,7 @@ static int raid10_set_queue_limits(struct mddev *mddev)
>>         md_init_stacking_limits(&lim);
>>       lim.max_write_zeroes_sectors = 0;
>> +    lim.max_hw_wzeroes_unmap_sectors = 0;
>>       lim.io_min = mddev->chunk_sectors << 9;
>>       lim.chunk_sectors = mddev->chunk_sectors;
>>       lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 023649fe2476..e385ef1355e8 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -7732,6 +7732,7 @@ static int raid5_set_limits(struct mddev *mddev)
>>       lim.features |= BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE;
>>       lim.discard_granularity = stripe;
>>       lim.max_write_zeroes_sectors = 0;
>> +    lim.max_hw_wzeroes_unmap_sectors = 0;
>>       mddev_stack_rdev_limits(mddev, &lim, 0);
>>       rdev_for_each(rdev, mddev)
>>           queue_limits_stack_bdev(&lim, rdev->bdev, rdev->new_data_offset,


