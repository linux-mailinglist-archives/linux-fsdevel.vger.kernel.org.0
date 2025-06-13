Return-Path: <linux-fsdevel+bounces-51546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C8AD8188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71273B79DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 03:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F9F246791;
	Fri, 13 Jun 2025 03:15:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2320E70C;
	Fri, 13 Jun 2025 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784549; cv=none; b=lF9Wakv2w/ThDufJYWIBmX3L7MycqUa0NRVtAVF8Pf7lyzIIMoDsbHtyL4wkSmXBigmyvzBl4vspWe+hELrCGOY03waEYioGA8Qhx076oQleHi1uEa/sEmm1drHASIacIG9pcaibaEs4tvaDpgunb/0s/MZxPkJc0TDm02olxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784549; c=relaxed/simple;
	bh=wiWZ2dzLQqc4OfpRI+E8bl3uA461tgzyLh2UFnwyaAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GheMIyNuTe+cAnMFkBm/O47OAIxvKfRWncwOzF6hwSI7tiy528Hdan2dCK+AwJfUBmVwOAn8btlWXz1FwT+wfkJZVEq+4UCnBXfH6oioGpS/xxO1j1HgeDIYHr8XMtckqCoonEY1/B+XSyLku3GhYBkpZ2U51RJ5oSIPViuuN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bJPfn3RlhzKHN5T;
	Fri, 13 Jun 2025 11:15:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CBD201A1911;
	Fri, 13 Jun 2025 11:15:43 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2Ddl0to15NsPQ--.28263S3;
	Fri, 13 Jun 2025 11:15:43 +0800 (CST)
Message-ID: <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
Date: Fri, 13 Jun 2025 11:15:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, john.g.garry@oracle.com,
 bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
 brauner@kernel.org, martin.petersen@oracle.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
 <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
 <20250612150347.GK6138@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250612150347.GK6138@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3W2Ddl0to15NsPQ--.28263S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45Gr4fJw4UWr13Zw4DXFb_yoW5Jr43pF
	W8GF1vyFWDKF15Gw1q93W0qr1Fvrs2ywsxXws5CrWUAwn0qr17WF1kKFWjkF97Z3Wxu3y5
	Xa15G343ua15C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/12 23:03, Darrick J. Wong wrote:
> On Thu, Jun 12, 2025 at 07:20:45PM +0800, Zhang Yi wrote:
>> On 2025/6/12 12:47, Christoph Hellwig wrote:
>>> On Wed, Jun 11, 2025 at 03:31:21PM +0800, Zhang Yi wrote:
>>>>>> +/* supports unmap write zeroes command */
>>>>>> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
>>>>>
>>>>>
>>>>> Should this be exposed through sysfs as a read-only value?
>>>>
>>>> Uh, are you suggesting adding another sysfs interface to expose
>>>> this feature?
>>>
>>> That was the idea.  Or do we have another way to report this capability?
>>>
>>
>> Exposing this feature looks useful, but I think adding a new interface
>> might be somewhat redundant, and it's also difficult to name the new
>> interface. What about extend this interface to include 3 types? When
>> read, it exposes the following:
>>
>>  - none     : the device doesn't support BLK_FEAT_WRITE_ZEROES_UNMAP.
>>  - enabled  : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, but the
>>               BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is not set.
>>  - disabled : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, and the
>>               BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is set.
>>
>> Users can write '0' and '1' to disable and enable this operation if it
>> is not 'none', thoughts?
> 
> Perhaps it should reuse the enumeration pattern elsewhere in sysfs?
> For example,
> 
> # cat /sys/block/sda/queue/scheduler
> none [mq-deadline]
> # echo none > /sys/block/sda/queue/scheduler
> # cat /sys/block/sda/queue/scheduler
> [none] mq-deadline
> 
> (Annoying that this seems to be opencoded wherever it appears...)
> 

Yeah, this solution looks good to me. However, we currently have only
two selections (none and unmap). What if we keep it as is and simply
hide this interface if BLK_FEAT_WRITE_ZEROES_UNMAP is not set, making
it visible only when the device supports this feature? Something like
below:

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e918b2c93aed..204ee4d5f63f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -747,6 +747,9 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
             attr == &queue_max_active_zones_entry.attr) &&
            !blk_queue_is_zoned(q))
                return 0;
+       if (attr == &queue_write_zeroes_unmap_entry.attr &&
+           !(q->limits.features & BLK_FEAT_WRITE_ZEROES_UNMAP))
+               return 0;

        return attr->mode;
 }

Thanks,
Yi.


