Return-Path: <linux-fsdevel+bounces-41192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F905A2C2BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0C11695B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2D1E7C37;
	Fri,  7 Feb 2025 12:31:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C02417EF;
	Fri,  7 Feb 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931483; cv=none; b=E37vSV1OP2PYsdMli6iOZIgOmo1VhYHDUutrI8yM8/MwsQ05f6nMb1YUoF+X5366QZE8JiGI/hdB+SCXkNDhtcPjxUfwyAfTcD7jwX5lv6FuL/FIENWvFnusNiO7I5eAaHa5Ayj4Bz5udWUwjLy5NbleTbvFcGtDG5lJkVlgCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931483; c=relaxed/simple;
	bh=ZSK3tTd78SFDrWY+mZUtcmMtccUuEPDk96bqa5dR+YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b34d9sG/wYJZFvEdX0ypnxbjdI/k2afaFqWuWxtkxuUk1/qa6UBw3Nlr0QyagYxkNZdY8v/Ur0pOgi+jziAQA9rYAVm/pVHbfEU6ieWytczIMV+zjP7Jbv00+k4U+VPWqBHn4sgt1ti0TiUkURzDkWTYiAiNVwTWuJpXceN/LBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YqCxX6Pzbz4f3jXT;
	Fri,  7 Feb 2025 20:30:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 12D4B1A1422;
	Fri,  7 Feb 2025 20:31:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8V_aVnR2qtDA--.49471S3;
	Fri, 07 Feb 2025 20:31:17 +0800 (CST)
Message-ID: <5e4cfa32-83bc-4025-a5db-298b7c080037@huaweicloud.com>
Date: Fri, 7 Feb 2025 20:31:16 +0800
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
 djwong@kernel.org, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com, Zhang Yi <yi.zhang@huawei.com>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-2-yi.zhang@huaweicloud.com>
 <d0f8315b-e006-498a-b3e8-77542f352d40@oracle.com>
 <dfd16793-f1fb-4ce6-8ad8-86de0818ff4e@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <dfd16793-f1fb-4ce6-8ad8-86de0818ff4e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3Wl8V_aVnR2qtDA--.49471S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWrKF18ZryfJryUAr4Utwb_yoW5WF4rpF
	yvgFyDtr93tF1xAwn2vanFgFW5Zws3Aa4fGwn8tryj9rs8ZFySgFW0gFy5u347Wryfuw18
	tFWYvr9xCa10yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrs
	qXDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/2/7 20:22, Zhang Yi wrote:
> On 2025/1/29 0:46, John Garry wrote:
>> On 15/01/2025 11:46, Zhang Yi wrote:
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Currently, it's hard to know whether the storage device supports unmap
>>> write zeroes. We cannot determine it only by checking if the disk
>>> supports the write zeroes command, as for some HDDs that do submit
>>> actual zeros to the disk media even if they claim to support the write
>>> zeroes command, but that should be very slow.
>>
>> This second sentence is too long, such that your meaning is hard to understand.
>>
>>>
>>> Therefor, add a new queue limit feature, BLK_FEAT_WRITE_ZEROES_UNMAP and
>>
>> Therefore?
>>
>>> the corresponding sysfs entry, to indicate whether the block device
>>> explicitly supports the unmapped write zeroes command. Each device
>>> driver should set this bit if it is certain that the attached disk
>>> supports this command. 
>>
>> How can they be certain? You already wrote that some claim to support it, yet don't really. Well, I think that is what you meant.
>>
> 
> Hi, John. thanks for your reply!
> 
> Sorry for the late and not make it clear enough earlier. Currently, there
> are four situations of write zeroes command (aka REQ_OP_WRITE_ZEROES)
> supported by various disks and backend storage devices.
> 
> A. Devices that do not support the write zeroes command
>    These devices have bdev_limits(bdev)->max_write_zeroes_sectors set to
>    zero.
> B. Devices that support the write zeroes command
>    These devices have bdev_limits(bdev)->max_write_zeroes_sectors set to a
>    non-zero value. They can be further categorized into three
>    sub-situations:
> B.1. Devices that write physical zeroes to the media
>      These devices perform the write zeroes operation by physically writing
>      zeroes to the storage media, which can be very slow (e.g., HDDs).
> B.2. Devices that support unmap write zeroes
>      These devices can offload the write zeroes operation by unmapping the
>      logical blocks, effectively putting them into a deallocated state
>      (e.g., SSDs). This operation is typically very fast, allowing
>      filesystems to use this command to quickly create zeroed files. NVMe
>      and SCSI disk drivers already support this and can query the attached
>      disks to determine whether they support unmap write zeroes (please see
>      patches 2 and 3 for details).
> B.3. The implementation of write zeroes on disks are unknown
>      This category includes non-standard disks and some network storage
>      devices where the exact implementation of the write zeroes command is
>      unclear.
> 
> Currently, users can only distinguish A and B through querying
> 
>    /sys/block/<disk>/queue/write_zeroes_unmap
                             ^^^^^^^^^^^^^^^^^^
Oh, sorry, it should be 'write_zeroes_max_bytes'

     /sys/block/<disk>/queue/write_zeroes_max_bytes

Thanks,
Yi.



