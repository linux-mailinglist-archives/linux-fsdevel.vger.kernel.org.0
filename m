Return-Path: <linux-fsdevel+bounces-51649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ABAAD9A1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DDB189C420
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 04:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF931DE2CF;
	Sat, 14 Jun 2025 04:48:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5BE2E11B4;
	Sat, 14 Jun 2025 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749876514; cv=none; b=C0RUzzQzaoYvxlLTBHaEHmtq3kpnipjYu5D7GO99LLpYP0IMl3Kq7CUV/908TohLvUP2+gRTdmZR3+StVExqLT87MuAXPIaJHsUq+HTtsSuKG8F0glHMZenQeLVSwYEMtiTXwnc5fUaIoi4lMY13HWeZh5krz7NQDt9XKHb4q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749876514; c=relaxed/simple;
	bh=lygWowa6guLMhQzlm7uWnDHP6s+JxGl/+Zxvm0cojAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xb0CwOOum4CbZMen1P0TwwNbbS7PT1LItKYBP1CKmNqAgRbRuXs8t5Y9dIyQcINwhYS4lpBX5RE3JyWeeZvkQWCnSJO0RpLvmWVRucXFIc8HBkQdd+lNXIpMn6Lm6xL9I5ubJNnguP4isz+VksLiNOw11vMskbnuqBzD1U2mxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bK3gL25lkzKHN2h;
	Sat, 14 Jun 2025 12:48:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9C4381A17DF;
	Sat, 14 Jun 2025 12:48:28 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGAa_0xoKqTaPQ--.42646S3;
	Sat, 14 Jun 2025 12:48:28 +0800 (CST)
Message-ID: <3d749264-6fdd-458f-a3a8-35d2320193b3@huaweicloud.com>
Date: Sat, 14 Jun 2025 12:48:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
 shinichiro.kawasaki@wdc.com, brauner@kernel.org, martin.petersen@oracle.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
 <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
 <20250612150347.GK6138@frogsfrogsfrogs>
 <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
 <20250613055630.GA9119@lst.de> <20250613145433.GF6134@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250613145433.GF6134@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXvGAa_0xoKqTaPQ--.42646S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15uw47uryUJF4kCryxGrg_yoW8tF47pF
	yjgFyxKrWDtF1UA3s5Aa10gF1Fq3y3Ga4xCrn7Wryku3s8WrnrWFs2g343XFyxC3s3Wa1j
	vayxC3sI9ayvvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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

On 2025/6/13 22:54, Darrick J. Wong wrote:
> On Fri, Jun 13, 2025 at 07:56:30AM +0200, Christoph Hellwig wrote:
>> On Fri, Jun 13, 2025 at 11:15:41AM +0800, Zhang Yi wrote:
>>> Yeah, this solution looks good to me. However, we currently have only
>>> two selections (none and unmap). What if we keep it as is and simply
>>> hide this interface if BLK_FEAT_WRITE_ZEROES_UNMAP is not set, making
>>> it visible only when the device supports this feature? Something like
>>> below:
>>
>> I really hate having all kinds of different interfaces for configurations.
> 
> I really hate the open-coded string parsing nonsense that is sysfs. ;)
> 
>> Maybe we should redo this similar to the other hardware/software interfaces
>> and have a hw_ limit that is exposed by the driver and re-only in
>> sysfs, and then the user configurable one without _hw.  Setting it to
>> zero disables the feature.
> 
> Yeah, that fits the /sys/block/foo/queue model better.
> 

OK, well. Please let me confirm, are you both suggesting adding
max_hw_write_zeores_unmap_sectors and max_write_zeroes_unmap_sectors to
the queue_limits instead of adding BLK_FEAT_WRITE_ZEROES_UNMAP to the
queue_limits->features. Something like the following.

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 378d3a1a22fc..14394850863c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -376,7 +376,9 @@ struct queue_limits {
        unsigned int            max_hw_discard_sectors;
        unsigned int            max_user_discard_sectors;
        unsigned int            max_secure_erase_sectors;
-       unsigned int            max_write_zeroes_sectors;
+       unsigned int            max_hw_write_zeroes_sectors;
+       unsigned int            max_hw_write_zeores_unmap_sectors;
+       unsigned int            max_write_zeroes_unmap_sectors;
        unsigned int            max_hw_zone_append_sectors;
        unsigned int            max_zone_append_sectors;
        unsigned int            discard_granularity;

Besides, we should also rename max_write_zeroes_sectors to
max_hw_write_zeroes_sectors since it is a hardware limitation reported
by the driver.  If the device supports unmap write zeroes,
max_hw_write_zeores_unmap_sectors should be equal to
max_hw_write_zeroes_sectors, otherwise it should be 0.

Right?

Best regards,
Yi.


