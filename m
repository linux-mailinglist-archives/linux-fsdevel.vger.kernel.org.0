Return-Path: <linux-fsdevel+bounces-39349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B89A131A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 04:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77917165F66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED813B298;
	Thu, 16 Jan 2025 03:04:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB6156F3C;
	Thu, 16 Jan 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736996686; cv=none; b=lrXQvekCIcbOEn/rUteDS/HULxzefaH7fzu56l0E24HTxCBM6gr++2/ICAYOl9gOIpJM+wVaabFmqpmALpI65ZFzR6/H7P6jZh31onc9hvVH3OwIXACaH1E7r6pXwZUL80Bdyz70eNF3qj7QpjXBfHZVknYfnz/bHut84/nzS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736996686; c=relaxed/simple;
	bh=EBV0OW05/JxgCgTU9SnU/dFX3BjZl3agdkLEtQYLN4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGCdzJX9cYIPMmx7btjTb0oake4KhVI95WwF0/auANfWDicqrE5rnVc/qVaXYWcTiKC85NdHrDv7DD/Vi3KEaY2kUntfbQFrSjWDwr1hxCn7dfQFoY9ji+ExrbocDGxoNBXehb6UN+SzYudMWJ4LdcGbrir6p27AZHwfzXWJBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YYSPs3q4lz4f3l26;
	Thu, 16 Jan 2025 11:04:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2E1901A0E96;
	Thu, 16 Jan 2025 11:04:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl9Fd4hnGHdVBA--.30220S3;
	Thu, 16 Jan 2025 11:04:38 +0800 (CST)
Message-ID: <a8ea2143-0b10-43ba-a464-7ce3348bb5af@huaweicloud.com>
Date: Thu, 16 Jan 2025 11:04:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] fallocate: introduce FALLOC_FL_WRITE_ZEROES
 flag
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai3@huawei.com" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <ccebada1-ac72-468e-8342-a9c645e5221e@nvidia.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ccebada1-ac72-468e-8342-a9c645e5221e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHKl9Fd4hnGHdVBA--.30220S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8AryxWrW8Kr4xAw18Zrb_yoW8Aw43pF
	WUXrZ8KrWkuF40yrnrua17u34fXw4xCr1fArWUWFyUZ3ZxAry7CanxK3yj9FW8uF9agF1j
	vrW8JF9rCr4FyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/1/16 5:07, Chaitanya Kulkarni wrote:
> On 1/15/25 03:46, Zhang Yi wrote:
>> Currently, we can use the fallocate command to quickly create a
>> pre-allocated file. However, on most filesystems, such as ext4 and XFS,
>> fallocate create pre-allocation blocks in an unwritten state, and the
>> FALLOC_FL_ZERO_RANGE flag also behaves similarly. The extent state must
>> be converted to a written state when the user writes data into this
>> range later, which can trigger numerous metadata changes and consequent
>> journal I/O. This may leads to significant write amplification and
>> performance degradation in synchronous write mode. Therefore, we need a
>> method to create a pre-allocated file with written extents that can be
>> used for pure overwriting. At the monent, the only method available is
>> to create an empty file and write zero data into it (for example, using
>> 'dd' with a large block size). However, this method is slow and consumes
>> a considerable amount of disk bandwidth, we must pre-allocate files in
>> advance but cannot add pre-allocated files while user business services
>> are running.
> 
> it will be very useful if we can get some blktests for scsi/nvme/dm.
> Please note that this not a blocker to get this path series to be merged,
> but this will help everyone including regular tests runs we do to ensure
> the stability of new interface.

Hello, Chaitanya,

Thanks for your feedback! Yeah, the proposal for this series is still under
discussion, I will add counterpart tests to both blktests and fstests once
the solution is determined.

> 
> if you do please CC and Shinichiro (added to CC list) to we can help those
> tests review and potentially also can provide tested by tag tht can help
> this work to move forward.
> 
Sure, this will be very helpful.

Thanks,
Yi.


