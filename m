Return-Path: <linux-fsdevel+bounces-47485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BDEA9E711
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 06:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3D97AA981
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24911ACED2;
	Mon, 28 Apr 2025 04:32:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA67757F3;
	Mon, 28 Apr 2025 04:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745814734; cv=none; b=oeeT/1cepcq03/BPKrE9rpYGoKv0C0MkbXpOEduL4q5gdNg0o95ej3XjdVrgn3gvSBqZ+W+CAIcl70uO9p1s9GLDMnzaui12ZaROXCNmrU1x4o+51RhX9bQxaT8dMAbmGTyATQC4AAmqq632Osrx8DRwVf2wm+AED86CT55ONDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745814734; c=relaxed/simple;
	bh=M9Mtf264J+Mb3cNVqR5CP6GjGyjzcGOdvAIaG/ht+Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG0ecmYxN/NGKv0nftvTzLF4OI+Ax2Abf6CPZcTzogH78HzrN/d8bZy9XyGnFhxl22eJ/4Vd2A+OX/Myd/UHapp0G8F8z/yVHDUFsjoXDNDHRiluSXPb3PdmFVHAMGgAyxpv6UF0GM1VHsbWbrOajsMadinYjqq4EaVY1fm66zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4Zm9X81FTszYQv5S;
	Mon, 28 Apr 2025 12:32:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9EB9F1A0904;
	Mon, 28 Apr 2025 12:32:07 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DFBA9o93coKw--.41236S3;
	Mon, 28 Apr 2025 12:32:07 +0800 (CST)
Message-ID: <7b0319ac-cad4-4285-800c-b1e18ee4d92b@huaweicloud.com>
Date: Mon, 28 Apr 2025 12:32:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/3] dm/003: add unmap write zeroes tests
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
 <20250318072835.3508696-3-yi.zhang@huaweicloud.com>
 <t4vmmsupkbffrp3p33okbdjtf6il2ahp5omp2s5fvuxkngipeo@4thxzp4zlcse>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <t4vmmsupkbffrp3p33okbdjtf6il2ahp5omp2s5fvuxkngipeo@4thxzp4zlcse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3W2DFBA9o93coKw--.41236S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr13XFyxAF1fXF1rAw4kCrg_yoWrZF18pF
	W5CF90yrZrKF17tw13ZF13Xr15Aws5Aw47Jw47J34jy398ZrySgFyxKF1UCa4xXrZ3ua10
	yay2qa4rCr1UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2025/4/3 15:43, Shinichiro Kawasaki wrote:
> On Mar 18, 2025 / 15:28, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Test block device unmap write zeroes sysfs interface with device-mapper
>> stacked devices. The /sys/block/<disk>/queue/write_zeroes_unmap
>> interface should return 1 if the underlying devices support the unmap
>> write zeroes command, and it should return 0 otherwise.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  common/rc        | 16 ++++++++++++++
>>  tests/dm/003     | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/dm/003.out |  2 ++
>>  3 files changed, 75 insertions(+)
>>  create mode 100755 tests/dm/003
>>  create mode 100644 tests/dm/003.out
>>
>> diff --git a/common/rc b/common/rc
>> index bc6c2e4..60c21f2 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -615,3 +615,19 @@ _io_uring_restore()
>>  		echo "$IO_URING_DISABLED" > /proc/sys/kernel/io_uring_disabled
>>  	fi
>>  }
>> +
>> +# get real device path name by following link
>> +_real_dev()
>> +{
>> +	local dev=$1
>> +	if [ -b "$dev" ] && [ -L "$dev" ]; then
>> +		dev=`readlink -f "$dev"`
>> +	fi
>> +	echo $dev
>> +}
> 
> This helper function looks useful, and it looks reasonable to add it.
> 
>> +
>> +# basename of a device
>> +_short_dev()
>> +{
>> +	echo `basename $(_real_dev $1)`
>> +}
> 
> But I'm not sure about this one. The name "_short_dev" is not super
> clear for me.
> 

I copied these two helpers form the xfstests. :)

>> diff --git a/tests/dm/003 b/tests/dm/003
>> new file mode 100755
>> index 0000000..1013eb5
>> --- /dev/null
>> +++ b/tests/dm/003
>> @@ -0,0 +1,57 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2025 Huawei.
>> +#
>> +# Test block device unmap write zeroes sysfs interface with device-mapper
>> +# stacked devices.
>> +
>> +. tests/dm/rc
>> +. common/scsi_debug
>> +
>> +DESCRIPTION="test unmap write zeroes sysfs interface with dm devices"
>> +QUICK=1
>> +
>> +requires() {
>> +	_have_scsi_debug
>> +}
>> +
>> +device_requries() {
>> +	_require_test_dev_sysfs queue/write_zeroes_unmap
>> +}
> 
> Same comment as the 1st patch: device_requries() does not work here.
> 
>> +
>> +setup_test_device() {
>> +	if ! _configure_scsi_debug "$@"; then
>> +		return 1
>> +	fi
> 
> In same manner as the 1st patch, I suggest to check /queue/write_zeroes_unmap
> here.
> 
> 	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap ]]; then
> 		_exit_scsi_debug
> 		SKIP_REASONS+=("kernel does not support unmap write zeroes sysfs interface")
> 		return 1
> 	fi
> 
> The caller will need to check setup_test_device() return value.

Sure.

> 
>> +
>> +	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
>> +	local blk_sz="$(blockdev --getsz "$dev")"
>> +	dmsetup create test --table "0 $blk_sz linear $dev 0"
> 
> I suggest to call _real_dev() here, and echo back the device name.
> 
> 	dpath=$(_real_dev /dev/mapper/test)
> 	echo ${dpath##*/}
> 
> The bash parameter expansion ${xxx##*/} works in same manner as the basename
> command. The caller can receive the device name in a local variable. This will
> avoid a bit of code duplication, and allow to avoid _short_dev().
> 

I'm afraid this approach will not work since we may set the
SKIP_REASONS parameter. We cannot pass the device name in this
manner as it will overlook the SKIP_REASONS setting when the caller
invokes $(setup_test_device xxx), this function runs in a subshell.

If you don't like _short_dev(), I think we can pass dname through a
global variable, something like below:

setup_test_device() {
	...
	dpath=$(_real_dev /dev/mapper/test)
	dname=${dpath##*/}
}

if ! setup_test_device lbprz=0; then
	return 1
fi
umap="$(< "/sys/block/${dname}/queue/write_zeroes_unmap")"

What do you think?

Thanks,
Yi.

>> +}
>> +
>> +cleanup_test_device() {
>> +	dmsetup remove test
>> +	_exit_scsi_debug
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	# disable WRITE SAME with unmap
>> +	setup_test_device lbprz=0
>> +	umap="$(cat "/sys/block/$(_short_dev /dev/mapper/test)/queue/write_zeroes_unmap")"
> 
> I suggest to modify the two lines above as follows, to match with the other
> suggested changes:
> 
> 	local dname umap
> 	if ! dname=$(setup_test_device lbprz=0); then
> 		return 1
> 	fi
> 	umap="$(< "/sys/block/${dname}/queue/write_zeroes_unmap")"
> 
> (Please note that the suggested changes are untested)


