Return-Path: <linux-fsdevel+bounces-48182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E962AABCDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346B83BF802
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94521553AA;
	Tue,  6 May 2025 07:51:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEF4B1E6B;
	Tue,  6 May 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517883; cv=none; b=BaxwbXjyh7CAKHPtpfrT1CZdxEIkftbfOMmkXqWq4lmb5bRTKNMzfZo8pzKBZkM8S3L514z5A4px/vdmFGqQceD5XU1rhVHBfqRp2rpfel+1s0pdiNdf+8t4MUifZRZAIOOWLZikG0RLR8kXjg0UMfGNBUFOnGDmWT4kP3S4x1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517883; c=relaxed/simple;
	bh=1CX/lfJBBRj/7Bkzs8EaPt98CGd3E61b+7bPWFKLsdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTgHqQpo8kNbM5mWksZVCQbMA6JYrQIfL4tymVgN9LgtYWjjIE+Aq2ThtsJAff2dbYf7OKjlcfSd9hR6a7xKYqnprjqibEXRPyy7u6DcxkJ9zYknf2+Itd8sj1oyhlnv5VBp17xrlYhwYMbWgoGU6Kbp3RIKSrzcwvPvn8dylKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zs9Ym0TKjz4f3jXs;
	Tue,  6 May 2025 15:50:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 798ED1A1C5E;
	Tue,  6 May 2025 15:51:16 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXe19yvxlod1paLg--.34192S3;
	Tue, 06 May 2025 15:51:16 +0800 (CST)
Message-ID: <52c1dd13-1a04-4d9a-b687-639ed348474e@huaweicloud.com>
Date: Tue, 6 May 2025 15:51:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 01/11] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP
 to queue limits features
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
 bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
 brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-2-yi.zhang@huaweicloud.com>
 <yq18qnav4zj.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <yq18qnav4zj.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXe19yvxlod1paLg--.34192S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4rtF4kur4rCryrKF15Arb_yoW5AF1rp3
	yjv3W8tr9xGF17uw1kZw1vqry5uws3CFW3Gw48X3s09ws8XF1xtFySqFyYg3yxGr1fGa4j
	vFWvqa47Aan8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Martin!

On 2025/5/6 12:21, Martin K. Petersen wrote:
> 
> Hi Zhang!
> 
>> +		[RO] Devices that explicitly support the unmap write zeroes
>> +		operation in which a single write zeroes request with the unmap
>> +		bit set to zero out the range of contiguous blocks on storage
>> +		by freeing blocks, rather than writing physical zeroes to the
>> +		media. If the write_zeroes_unmap is set to 1, this indicates
>> +		that the device explicitly supports the write zero command.
>> +		However, this may be a best-effort optimization rather than a
>> +		mandatory requirement, some devices may partially fall back to
>> +		writing physical zeroes due to factors such as receiving
>> +		unaligned commands. If the parameter is set to 0, the device
>> +		either does not support this operation, or its support status is
>> +		unknown.
> 
> I am not so keen on mixing Write Zeroes (which is NVMe-speak) and Unmap
> (which is SCSI). Also, Deallocate and Unmap reflect block provisioning
> state on the device but don't really convey what is semantically
> important for your proposed change (zeroing speed and/or media wear
> reduction).
> 

Since this flag doesn't strictly guarantee zeroing speed or media wear
reduction optimizations, but rather reflects typical optimization
behavior across most supported devices and cases. Therefore, I propose
using a name that accurately indicates the function of the block device.
However, also can't think of a better name either. Using the name
WRITE_ZEROES_UNMAP seems appropriate to convey that the block device
supports this type of Deallocate and Unmap state.

> That said, I'm having a hard time coming up with a better term.
> WRITE_ZEROES_OPTIMIZED, maybe? Naming is hard...

Using WRITE_ZEROES_OPTIMIZED feels somewhat too generic to me, and
users may not fully grasp the specific optimizations it entails based
on the name.

> 
> For the description, perhaps something like the following which tries to
> focus on the block layer semantics without using protocol-specific
> terminology?
> 
> [RO] This parameter indicates whether a device supports zeroing data in
> a specified block range without incurring the cost of physically writing
> zeroes to media for each individual block. This operation is a
> best-effort optimization, a device may fall back to physically writing
> zeroes to media due to other factors such as misalignment or being asked
> to clear a block range smaller than the device's internal allocation
> unit. If write_zeroes_unmap is set to 1, the device implements a zeroing
> operation which opportunistically avoids writing zeroes to media while
> still guaranteeing that subsequent reads from the specified block range
> will return zeroed data. If write_zeroes_unmap is set to 0, the device
> may have to write each logical block media during a zeroing operation.
> 

Thank you for optimizing the description, it looks good to me. I'd like
to this one in my next iteration. :)

Thanks,
Yi.


