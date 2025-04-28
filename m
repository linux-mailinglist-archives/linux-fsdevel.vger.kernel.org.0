Return-Path: <linux-fsdevel+bounces-47486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F805A9E71F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 06:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129DA3BA70F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A61C5D46;
	Mon, 28 Apr 2025 04:34:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047A19B3CB;
	Mon, 28 Apr 2025 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745814873; cv=none; b=rnQYpCyN2CCoD6D49m4GoyDJ6WgeKsuWwL05xGfxmb9HoiluPjbdQiGu4QKOvCaF22MSTDk7Kb7kU5bK3bkiUVLd0vv9ihTShOiaWToScLHjl6lI6V4VU3rAZJlp4o/T5eswACHaWrbaa4x72F1HgkA1a0CN5A1F47tB4vLE2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745814873; c=relaxed/simple;
	bh=YgYp62UqQEYf4XBik3kZic3wxkJmHyo/wSwqGIZg4DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zijn1Xt8l1xWYUyqs0hGH7jf26rZwTN68AXRGvwybJMGks8mlJ5lO2pxmTkVZ3+G57owOeg91MkysEyqjtUdbwJ7EiOh2ZJ8REx24/Q1T0YGeqQSWwf44My0uHh3cP1ErDv1k20wLJwTKBUL0OxQdi3RVoBOV8iJqGOnRsSENts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zm9ZK5ghFz4f3kvh;
	Mon, 28 Apr 2025 12:34:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6EF841A19C3;
	Mon, 28 Apr 2025 12:34:27 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB3219SBQ9oYaMoKw--.53973S3;
	Mon, 28 Apr 2025 12:34:27 +0800 (CST)
Message-ID: <01c1241e-9f80-44fc-8b04-c219aeacfc08@huaweicloud.com>
Date: Mon, 28 Apr 2025 12:34:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/3] blktest: add unmap write zeroes tests
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 hch <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
 "bmarzins@redhat.com" <bmarzins@redhat.com>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai3@huawei.com" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
 <yxfbr3na7iyci7rs3rk4m7zmjrfw3zdccrnur2nkk2lddlowmx@wy32rpgrlzoh>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <yxfbr3na7iyci7rs3rk4m7zmjrfw3zdccrnur2nkk2lddlowmx@wy32rpgrlzoh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3219SBQ9oYaMoKw--.53973S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWxAFyrJFyrKrW5Jry8uFg_yoW8tr13pF
	1rAa40yr4fKFnFg3W09FZIqr15Ars3Aay5Ars5Gr10krn8ZF1a9ryjg3yjywsFgr13W3Z2
	yay2ga4S9ayUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/4/3 15:55, Shinichiro Kawasaki wrote:
> On Mar 18, 2025 / 15:28, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The Linux kernel is planning to support FALLOC_FL_WRITE_ZEROES in
>> fallocate(2). Add tests for the newly added BLK_FEAT_WRITE_ZEROES_UNMAP
>> feature flag on the block device queue limit. These tests test block
>> device unmap write zeroes sysfs interface
>>
>>         /sys/block/<disk>/queue/write_zeroes_unmap
>>
>> with various SCSI/NVMe/device-mapper devices.
>>
>> The /sys/block/<disk>/queue/write_zeroes_unmap interface should return
>> 1 if the block device supports unmap write zeroes command, and it should
>> return 0 otherwise.
>>
>>  - scsi/010 test SCSI devices.
>>  - dm/003 test device mapper stacked devices.
>>  - nvme/060 test NVMe devices.
> 
> Zhang, thank you again for the patches. The test contents look meaningful
> for me :)  When the kernel side changes get ready, I will run the test cases
> and do further review.
> 
> One thing I noticed is that the patches trigger shellcheck warnings. When you
> respin the patches, please run "make check" and address the warnings.
> 
> $ make check
> shellcheck -x -e SC2119 -f gcc check common/* \
>         tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
> common/rc:624:7: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
> common/rc:626:7: note: Double quote to prevent globbing and word splitting. [SC2086]
> common/rc:632:7: warning: Quote this to prevent word splitting. [SC2046]
> common/rc:632:7: note: Useless echo? Instead of 'echo $(cmd)', just use 'cmd'. [SC2005]
> common/rc:632:7: note: Use $(...) notation instead of legacy backticks `...`. [SC2006]
> common/rc:632:17: warning: Quote this to prevent word splitting. [SC2046]
> common/rc:632:29: note: Double quote to prevent globbing and word splitting. [SC2086]
> tests/dm/003:28:8: warning: Declare and assign separately to avoid masking return values. [SC2155]
> tests/nvme/060:32:8: warning: Declare and assign separately to avoid masking return values. [SC2155]
> make: *** [Makefile:21: check] Error 1

Sure, I'll do this check in my next iteration.

Thanks,
Yi,


