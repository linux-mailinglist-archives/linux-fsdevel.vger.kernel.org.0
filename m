Return-Path: <linux-fsdevel+bounces-58108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DCCB29655
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 03:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4837D7AED35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9C231A30;
	Mon, 18 Aug 2025 01:43:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFDF2264B1;
	Mon, 18 Aug 2025 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755481386; cv=none; b=ctQEW1YCjkW2RAlKRRJ0ycLxKTikY+X0/qXoSwikPggBpOTfRuuS3/ekXwSq1PvSPjfL77DAkpRuYJVrmFy/rckmPYyACJqFE/NPtrU7GlGBFhbIZDycI7v2r10on+9nsC9KYLlWTlRN0/ZJKJ/O6RPBDdDHcFHtcgB0E8YyDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755481386; c=relaxed/simple;
	bh=3BrdEm9YWQ4b9T8dYVemL7Ff85aMXjPNNHmqsSoFDS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFuLyyJ63V4nRgl+Y2V8qKQmGQ56b88dudhjhvHwlBN7pMl+oOqbGQyaI3ny9p881epnPFs4S0vx4ImYfAUBuG5nXME+W357Efi41RfBW28vqgeXNOCinjAhZkhcxhbEdeN0LTa0I47fPh3FTwdgAYBBHoxEfDERO5hDkjXmwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c4wTL0jTWzYQv8W;
	Mon, 18 Aug 2025 09:43:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A71FF1A018D;
	Mon, 18 Aug 2025 09:43:00 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHgxMfhaJo6Ns1EA--.15154S3;
	Mon, 18 Aug 2025 09:42:57 +0800 (CST)
Message-ID: <95a4a94b-7aa0-4e3c-a386-7692dde66a4f@huaweicloud.com>
Date: Mon, 18 Aug 2025 09:42:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 0/3] blktest: add unmap write zeroes tests
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 hch <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "bmarzins@redhat.com" <bmarzins@redhat.com>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai3@huawei.com" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20250813024421.2507446-1-yi.zhang@huaweicloud.com>
 <7dswufawxmyqblokjesulhdexqld3bx7sycgmylbaeqs43ougk@25rseyqm3beg>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <7dswufawxmyqblokjesulhdexqld3bx7sycgmylbaeqs43ougk@25rseyqm3beg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHgxMfhaJo6Ns1EA--.15154S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy3tFy8uFWrXr15tr1rXrb_yoW8tw15pr
	W5Xa4Dtws8GrWDJa4vvayq9Fy3Jws7Zry7A3Z5tr18Cr15ZFyfWrZ8Xw4aga17KrnxGw1I
	v3W2gryS93WUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 8/17/2025 2:14 PM, Shinichiro Kawasaki wrote:
> On Aug 13, 2025 / 10:44, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Change since v2:
>>  - Modify the sysfs interfaces according to the kernel implementation.
>>  - Determine whether the kernel supports it by directly checking the
>>    existence of the sysfs interface, instead of using device_requries(). 
>>  - Drop _short_dev() helper and directly use _real_dev() to acquire dm
>>    path.
>>  - Check the return value of setup_test_device().
>>  - Fix the '"make check'" errors.
>>
>>
>> The Linux kernel (since version 6.17)[1] supports FALLOC_FL_WRITE_ZEROES
>> in fallocate(2) and add max_{hw|user}_wzeroes_unmap_sectors parameters
>> to the block device queue limit. These tests test those block device
>> unmap write zeroes sysfs interface
>>
>>         /sys/block/<disk>/queue/write_zeroes_max_bytes
>>         /sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes
>>
>> with various SCSI/NVMe/device-mapper devices.
>>
>> The value of /sys/block//queue/write_zeroes_unmap_max_hw_bytes should be
>> equal to a nonzero value of /sys/block//queue/write_zeroes_max_bytes if
>> the block device supports the unmap write zeroes command; otherwise, it
>> should return 0. We can also disable unmap write zeroes command by
>> setting /sys/block/<disk>/queue/write_zeroes_max_bytes to 0.
>>
>>  - scsi/010 test SCSI devices.
>>  - dm/003 test device mapper stacked devices.
>>  - nvme/065 test NVMe devices.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
> 
> I applied this v2 series. Of note is that I amended the 2nd and 3rd patches to
> fix the shellcheck warnings below. Anyway, thanks for the patches!
> 
> $ make check
> shellcheck -x -e SC2119 -f gcc check common/* \
>         tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
> common/rc:679:7: note: Double quote to prevent globbing and word splitting. [SC2086]
> tests/nvme/065:44:7: warning: Quote this to prevent word splitting. [SC2046]
> tests/nvme/065:44:7: note: Useless echo? Instead of 'echo $(cmd)', just use 'cmd'. [SC2005]
> make: *** [Makefile:21: check] Error 1

Sorry for missing these warnings, and thank you for fixing them! :-)

Thanks.
Yi.


