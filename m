Return-Path: <linux-fsdevel+bounces-53762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8674AF68B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 05:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99441BC6B45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 03:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A8239E99;
	Thu,  3 Jul 2025 03:35:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41982356CB;
	Thu,  3 Jul 2025 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751513751; cv=none; b=M2qq9J+n25bWLP31FcMT74Xgk1wkSDTCoPPMBnRzcT4NzgE3fF/sVzZqUFiKr43DrkONV2PLyTnO7ahyX3JSIbbMvmDo2r37r27mLYdkPhGydq4aHuE7s8s+NQtDjq3rC/FNiNgMgEMmpxO8bGx2cBwuhVSKX3n17ERWb+QlkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751513751; c=relaxed/simple;
	bh=aAiZg72MzhU/nwICqHjkhrX5X7yDG6hB2keLduoAXfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rP3x7ENl+MzP7CcMHIkTRJ05oHHO+/d2u0mKLGU/jI/rPcRDAuDGTd+NDD83wYMB4uA2xi8gDQMwo8UxHYDrgvZ3/WX5pwh8Z6h3lo34dzyNhgSrDA0xMf3wECCgey5hRr+zirRdxo4uXTzaQ4ctji5ystQmuFaiy5/f9M4r9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bXj8g3pglzKHMbj;
	Thu,  3 Jul 2025 11:35:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E416B1A1101;
	Thu,  3 Jul 2025 11:35:45 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgBHpySN+mVo3w_yAQ--.57305S3;
	Thu, 03 Jul 2025 11:35:43 +0800 (CST)
Message-ID: <99010bfd-c968-49c7-b62b-c72b38722c1b@huaweicloud.com>
Date: Thu, 3 Jul 2025 11:35:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
To: Christian Brauner <brauner@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
 bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
 martin.petersen@oracle.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
 <20250623-woanders-allabendlich-f87ae2d9c704@brauner>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250623-woanders-allabendlich-f87ae2d9c704@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBHpySN+mVo3w_yAQ--.57305S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF45tr1Duw4ftrWrZw1kZrb_yoWrtw15pa
	yUJFZ8KF4DJr17J397uF109F15Zws3Ar15Ka1rKw1kZrWYqrnagFWIga4UXasrCr93Ww1x
	ZFsFya4q9ay7AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2025/6/23 18:46, Christian Brauner wrote:
> On Thu, 19 Jun 2025 19:17:57 +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Changes since v1:
>>  - Rebase codes on 6.16-rc2.
>>  - Use max_{hw|user}_wzeroes_unmap_sectors queue limits instead of
>>    BLK_FEAT_WRITE_ZEROES_UNMAP feature to represent the status of the
>>    unmap write zeroes operation as Christoph and Darrick suggested. This
>>    redoes the first 5 patches, so remove all the reviewed-by tags,
>>    please review them again.
>>  - Simplify the description of FALLOC_FL_WRITE_ZEROES in patch 06 as
>>    Darrick suggested.
>>  - Revise the check order of FALLOC_FL_WRITE_ZEROES in patch 08 as
>>    Christoph suggested.
>> Changes since RFC v4:
>>  - Rebase codes on 6.16-rc1.
>>  - Add a new queue_limit flag, and change the write_zeroes_unmap sysfs
>>    interface to RW mode. User can disable the unmap write zeroes
>>    operation by writing '0' to it when the operation is slow.
>>  - Modify the documentation of write_zeroes_unmap sysfs interface as
>>    Martin suggested.
>>  - Remove the statx interface.
>>  - Make the bdev and ext4 don't allow to submit FALLOC_FL_WRITE_ZEROES
>>    if the block device does not enable the unmap write zeroes operation,
>>    it should return -EOPNOTSUPP.
>> Changes sicne RFC v3:
>>  - Rebase codes on 6.15-rc2.
>>  - Add a note in patch 1 to indicate that the unmap write zeros command
>>    is not always guaranteed as Christoph suggested.
>>  - Rename bdev_unmap_write_zeroes() helper and move it to patch 1 as
>>    Christoph suggested.
>>  - Introduce a new statx attribute flag STATX_ATTR_WRITE_ZEROES_UNMAP as
>>    Christoph and Christian suggested.
>>  - Exchange the order of the two patches that modified
>>    blkdev_fallocate() as Christoph suggested.
>> Changes since RFC v2:
>>  - Rebase codes on next-20250314.
>>  - Add support for nvme multipath.
>>  - Add support for NVMeT with block device backing.
>>  - Clear FALLOC_FL_WRITE_ZEROES if dm clear
>>    limits->max_write_zeroes_sectors.
>>  - Complement the counterpart userspace tools(util-linux and xfs_io)
>>    and tests(blktests and xfstests), please see below for details.
>> Changes since RFC v1:
>>  - Switch to add a new write zeroes operation, FALLOC_FL_WRITE_ZEROES,
>>    in fallocate, instead of just adding a supported flag to
>>    FALLOC_FL_ZERO_RANGE.
>>  - Introduce a new flag BLK_FEAT_WRITE_ZEROES_UNMAP to the block
>>    device's queue limit features, and implement it on SCSI sd driver,
>>    NVMe SSD driver and dm driver.
>>  - Implement FALLOC_FL_WRITE_ZEROES on both the ext4 filesystem and
>>    block device (bdev).
>>
>> [...]
> 
> If needed, the branch can be declared stable and thus be used as base
> for other work.
> 
> ---
> 
> Applied to the vfs-6.17.fallocate branch of the vfs/vfs.git tree.
> Patches in the vfs-6.17.fallocate branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.17.fallocate

Hi Christian,

I noticed that this patch series doesn't appear to be merged into this
branch. Just wondering if it might have been missed?

Best regards,
Yi.

> 
> [1/9] block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits
>       https://git.kernel.org/vfs/vfs/c/2695a9b086fd
> [2/9] nvme: set max_hw_wzeroes_unmap_sectors if device supports DEAC bit
>       https://git.kernel.org/vfs/vfs/c/bf07c1180194
> [3/9] nvmet: set WZDS and DRB if device enables unmap write zeroes operation
>       https://git.kernel.org/vfs/vfs/c/a6c7ab5adcba
> [4/9] scsi: sd: set max_hw_wzeroes_unmap_sectors if device supports SD_ZERO_*_UNMAP
>       https://git.kernel.org/vfs/vfs/c/92372ed1cc88
> [5/9] dm: clear unmap write zeroes limits when disabling write zeroes
>       https://git.kernel.org/vfs/vfs/c/e383d550e716
> [6/9] fs: introduce FALLOC_FL_WRITE_ZEROES to fallocate
>       https://git.kernel.org/vfs/vfs/c/1ed1b5df86ec
> [7/9] block: factor out common part in blkdev_fallocate()
>       https://git.kernel.org/vfs/vfs/c/96433508c8c0
> [8/9] block: add FALLOC_FL_WRITE_ZEROES support
>       https://git.kernel.org/vfs/vfs/c/2b4e5f9b3eb9
> [9/9] ext4: add FALLOC_FL_WRITE_ZEROES support
>       https://git.kernel.org/vfs/vfs/c/51954e469396


