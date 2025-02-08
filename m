Return-Path: <linux-fsdevel+bounces-41280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD2A2D374
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 04:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484AC16B4F5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 03:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFC17A5A4;
	Sat,  8 Feb 2025 03:13:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8091547C9;
	Sat,  8 Feb 2025 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738984387; cv=none; b=r4e94GcPY06IHBYK7HlykgWgX6XA/Mrhf7lVj+4vMUsqT4/j5S9dD8t/N80re58pHP4FaGj61ZG+jyD5blLCQ+lxxrhXIvAu0fm+SD0Cffa5ycuMkM6SkJd16sMzpD1eP8VO0RWmBuwaQP2W7lfGEw0RMfarjM+UBHUM3wuFqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738984387; c=relaxed/simple;
	bh=VX6uwaIuuHIeFUDpO1ARDCQuWM2rr0gm/U8UpfQylTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZVc/A8D7KvYWpYpPL/xZfZYQV0x1vNHpuFCkZzrfbxTmXvIInn6svmOt8DkrB+P1JQ7WD3b0cyRpmgXWtjWLahp56OgDF92fHmakwpqdJzUVWM7+wjcGfr9DuVGxr8G2B3YMHaAaaNs7b0w/wgNheC9CKaTtaz8eZ2MbsaultE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YqbVs354vz4f3jMQ;
	Sat,  8 Feb 2025 11:12:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F0B121A1428;
	Sat,  8 Feb 2025 11:12:59 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGC5y6ZnjDPoDA--.64325S3;
	Sat, 08 Feb 2025 11:12:59 +0800 (CST)
Message-ID: <3b1dcd45-efa6-4aad-9cd4-3302a29eb093@huaweicloud.com>
Date: Sat, 8 Feb 2025 11:12:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/8] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu, djwong@kernel.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-5-yi.zhang@huaweicloud.com>
 <Z6aFtJzGWMNhILJW@redhat.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z6aFtJzGWMNhILJW@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHrGC5y6ZnjDPoDA--.64325S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxZr4kXFy8CF1xuw18uFg_yoW8AF15pF
	n2ga4Iyry5tF47C3W0gFW2vFyYga1YyFy7Cry7C3y5ZF15Kry8KFsFyFy7Wan8Ja47Xw48
	t3WjkF9rZw4UZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2025/2/8 6:14, Benjamin Marzinski wrote:
> On Wed, Jan 15, 2025 at 07:46:33PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
>> default. This feature shall be disabled if any underlying device does
>> not support it.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  drivers/md/dm-table.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>> index bd8b796ae683..58cce31bcc1e 100644
>> --- a/drivers/md/dm-table.c
>> +++ b/drivers/md/dm-table.c
>> @@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
>>  static void dm_set_stacking_limits(struct queue_limits *limits)
>>  {
>>  	blk_set_stacking_limits(limits);
>> -	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
>> +	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
>> +			    BLK_FEAT_WRITE_ZEROES_UNMAP;
>>  }
>>  
> 
> dm_table_set_restrictions() can set limits->max_write_zeroes_sectors to
> 0, and it's called after dm_calculate_queue_limits(), which calls
> blk_stack_limits(). Just to avoid having the BLK_FEAT_WRITE_ZEROES_UNMAP
> still set while a device's max_write_zeroes_sectors is 0, it seems like
> you would want to clear it as well if dm_table_set_restrictions() sets
> limits->max_write_zeroes_sectors to 0.
> 

Hi, Ben!

Yeah, right. Thanks for pointing this out, and I also checked other
instances in dm where max_write_zeroes_sectors is set to 0, and it seems
we should also clear BLK_FEAT_WRITE_ZEROES_UNMAP in
disable_write_zeroes() as well.

Thanks,
Yi.


