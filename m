Return-Path: <linux-fsdevel+bounces-46158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32423A83765
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 05:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6B719E310C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D4F1F151E;
	Thu, 10 Apr 2025 03:52:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F81F0E34;
	Thu, 10 Apr 2025 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257147; cv=none; b=K8th+mNkO3W5wg3SM5YVRhZ9oIJk07VRYbHbxHsfTDYFyYD0Tf2bYFVu4u8ZCp/UoFKH8vibfva/2DRSauTwWYrOQGhgyfeyZOhdMX1N/2cfey5JSIsNB037Um8Gz1pMzCPaQLAARWrn0bLqO3YWra7x3zPzLvn2eTK/rQ3Uowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257147; c=relaxed/simple;
	bh=8UR0rCYcem4Ns+qpODAMEUGXyGRLAyiltIyTO13LKmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=at1qXZXy8xHzZG1iZEYddrbZOs95a1Hb6qpgdr0BMp6NfFByYxKsrUpbhlL5S0/oxd+VuiAGsMq5c0M2kwuKZ/9Omu8+1Yak6JDLqeUOx9pP4i0KCcjqB2dzdbCf71kQbjraQq0YgUFzN5qwAMG6erIdszTNDg5F7UVhhEbPDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZY5V93kgHz4f3jtT;
	Thu, 10 Apr 2025 11:52:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8AE731A13CE;
	Thu, 10 Apr 2025 11:52:19 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl9xQPdn5yMjJA--.22084S3;
	Thu, 10 Apr 2025 11:52:19 +0800 (CST)
Message-ID: <43a34aa8-3f2f-4d86-be53-8a832be8532f@huaweicloud.com>
Date: Thu, 10 Apr 2025 11:52:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
 <20250409103148.GA4950@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250409103148.GA4950@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl9xQPdn5yMjJA--.22084S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxXw43Jr1DWF47Zw4xZwb_yoW5WFW5p3
	yfJF1jyrnaqw1fC3Z7Zw48Wr109ws7GF43Gw4aqryjvwnxXF1xKF1S93WYvFWkurs3G3W0
	qFWjqF9rCw1qvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2025/4/9 18:31, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 03:35:36PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Currently, disks primarily implement the write zeroes command (aka
>> REQ_OP_WRITE_ZEROES) through two mechanisms: the first involves
>> physically writing zeros to the disk media (e.g., HDDs), while the
>> second performs an unmap operation on the logical blocks, effectively
>> putting them into a deallocated state (e.g., SSDs). The first method is
>> generally slow, while the second method is typically very fast.
>>
>> For example, on certain NVMe SSDs that support NVME_NS_DEAC, submitting
>> REQ_OP_WRITE_ZEROES requests with the NVME_WZ_DEAC bit can accelerate
>> the write zeros operation by placing disk blocks into
> 
> Note that this is a can, not a must.  The NVMe definition of Write
> Zeroes is unfortunately pretty stupid.
> 
>> +		[RO] Devices that explicitly support the unmap write zeroes
>> +		operation in which a single write zeroes request with the unmap
>> +		bit set to zero out the range of contiguous blocks on storage
>> +		by freeing blocks, rather than writing physical zeroes to the
>> +		media.
> 
> This is not actually guaranteed for nvme or scsi.

Thank you for your review and comments. However, I'm not sure I fully
understand your points. Could you please provide more details?

AFAIK, the NVMe protocol has the following description in the latest
NVM Command Set Specification Figure 82 and Figure 114:

===
Deallocate (DEAC): If this bit is set to ‘1’, then the host is
requesting that the controller deallocate the specified logical blocks.
If this bit is cleared to ‘0’, then the host is not requesting that
the controller deallocate the specified logical blocks...

DLFEAT:
Write Zeroes Deallocation Support (WZDS): If this bit is set to ‘1’,
then the controller supports the Deallocate bit in the Write Zeroes
command for this namespace...
Deallocation Read Behavior (DRB): This field indicates the deallocated
logical block read behavior. For a logical block that is deallocated,
this field indicates the values read from that deallocated logical block
and its metadata (excluding protection information)...

  Value  Definition
  001b   A deallocated logical block returns all bytes cleared to 0h
===

At the same time, the current kernel determines whether to set the
unmap bit when submitting the write zeroes command based on the above
protocol. So I think this rules should be clear now.

Were you saying that what is described in this protocol is not a
mandatory requirement? Which means the disks that claiming to support
the UNMAP write zeroes command(WZDS=1,DRB=1), but in fact, they still
write actual zeroes data to the storage media? Or were you referring
to some irregular disks that do not obey the protocol and mislead
users?

Thanks,
Yi.


