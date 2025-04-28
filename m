Return-Path: <linux-fsdevel+bounces-47483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E0A9E691
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 05:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4297178949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB66319938D;
	Mon, 28 Apr 2025 03:33:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F14A11;
	Mon, 28 Apr 2025 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811181; cv=none; b=ca4CWR0fwazAo/JDw5/ZGlow81shiXUpeqjjeCd/lyh3H1fAZGL5BBoU1vCS7q9z0jfR9vXwBFhEwQ1dPkfqXbZ0e3XdpDZE8gspg0YNb1FSdcbnYhjxQhl1Dl7/PYEDEiWFP5L8fHK8NUmc9JfOxyQ81aDsksi4Ivpcv8aL9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811181; c=relaxed/simple;
	bh=rZPb+nYyN6fqWnBmjxisPyPRLgUVCz2sdtg+z7gQqTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrMNRzSPwh6WMIfgOgD/o4RBGxiibJAuwgdVb7OUg/GsqXpN+Id62Rlhu7nPh9R8bNOjKWBUBTRnBPCF6bz5Z+w/91HZ7wb6ncDHx/OSZ6MqrrpMhheG13MSgjPvbxjPTYPzSCnQvjE5k8gM76nE92L5xfsP718gxyYvpmaaWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zm8CB3ynMz4f3kvw;
	Mon, 28 Apr 2025 11:32:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 344901A1AF2;
	Mon, 28 Apr 2025 11:32:48 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1_d9g5ov1YkKw--.49750S3;
	Mon, 28 Apr 2025 11:32:47 +0800 (CST)
Message-ID: <6db8d3e6-44ce-4b2b-b496-ec0104aee997@huaweicloud.com>
Date: Mon, 28 Apr 2025 11:32:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/3] scsi/010: add unmap write zeroes tests
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
 <20250318072835.3508696-2-yi.zhang@huaweicloud.com>
 <krhbty6cnaj3zv4bka4jmpwmm74v7k3cts6csp6yoc7xjexoyu@6yrwd7rr2rip>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <krhbty6cnaj3zv4bka4jmpwmm74v7k3cts6csp6yoc7xjexoyu@6yrwd7rr2rip>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1_d9g5ov1YkKw--.49750S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8Cw48GryUuFyUZFWrXwb_yoW5Gry5pF
	WxGa9Ykr1ktr17G3WSvF45Wr13J3yfAr47AFWxCw1UCr98Zryakr1IgrWUWa4fGrZ8Gw1F
	y3WUXFySkryUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hello Shinichiro！

I apologize for the significant delay, and I greatly appreciate your
review and suggestions.

On 2025/4/3 15:26, Shinichiro Kawasaki wrote:
> Hello Zhang, thank you for the patches.
> 
> On Mar 18, 2025 / 15:28, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Test block device unmap write zeroes sysfs interface with various SCSI
>> debug devices. The /sys/block/<disk>/queue/write_zeroes_unmap interface
>> should return 1 if the SCSI device enable the WRITE SAME command with
>> unmap functionality, and it should return 0 otherwise.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  tests/scsi/010     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/scsi/010.out |  2 ++
>>  2 files changed, 58 insertions(+)
>>  create mode 100755 tests/scsi/010
>>  create mode 100644 tests/scsi/010.out
>>
>> diff --git a/tests/scsi/010 b/tests/scsi/010
>> new file mode 100755
>> index 0000000..27a672c
>> --- /dev/null
>> +++ b/tests/scsi/010
>> @@ -0,0 +1,56 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2025 Huawei.
>> +#
>> +# Test block device unmap write zeroes sysfs interface with various scsi
>> +# devices.
>> +
>> +. tests/scsi/rc
>> +. common/scsi_debug
>> +
>> +DESCRIPTION="test unmap write zeroes sysfs interface with scsi devices"
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
> The device_requries() hook does not work for test cases which implement test().
> It is rather dirty, but I think we need to delay the check for
> write_zeroes_unmap sysfs attribute availability until test() gets called.
> See below for my idea.
> 

Indeed, I completely missed that.

>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	# disable WRITE SAME with unmap
>> +	if ! _configure_scsi_debug lbprz=0; then
>> +		return 1
>> +	fi
> 
> I suggest to check queue/write_zeroes_unmap here. If it's not available, set
> SKIP_REASONS and return like this (totally untested):
> 
> 	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap ]]; then
> 		_exit_scsi_debug
> 		SKIP_REASONS+=("kernel does not support unmap write zeroes sysfs interface")
> 		return 1
> 	fi
> 

Yeah, I agree with you. For now, there is no helper available for
checking the sysfs interface of the SCSI debugging device.

I will add a new helper setup_test_device() in this test as the
following two patches do, and put this check into that helper.

Thanks,
Yi.


