Return-Path: <linux-fsdevel+bounces-38112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010499FC36F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 04:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345797A1BF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 03:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50825757;
	Wed, 25 Dec 2024 03:11:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751F101E6;
	Wed, 25 Dec 2024 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735096284; cv=none; b=LY7seu6oaUTG/uG4/WEWEW76kiBD9ZY4LyJZgu/cFENBA+ZmEwTBR3aa5RKKxBy9du6rzs1YXofPk4L3yVNfWh0KImRUiCDOQuuHejqKvPByhBZVxKNAS7KBvQ2Bm8aKR2951YjDeYwE9FKbS4SZGMhRQLyLTmGDOPtoP0olpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735096284; c=relaxed/simple;
	bh=9SWBds2nHkwPyTHcoJlZn5LbIzOFokFiVPFU3AggpKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiXHePIRMQMtEbO0NDwQxf5jpDTpKOeEynKF/1bh65L6UycKoFO/rP6pHQZV6uWhwb5vaEXtf8jpuYEyNQ5HLy9zwcAQtLG+vkALP7rZ/yb54nVLmBItstj9oGPLGC4lO99IKeqJQ55EGpkxlSyUp8P8RR1XGZB57DkyuIu/Ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YHxbh22mwz4f3jd2;
	Wed, 25 Dec 2024 11:10:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 030E41A0AE9;
	Wed, 25 Dec 2024 11:11:16 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCngYXPd2tnrZFAFg--.1644S3;
	Wed, 25 Dec 2024 11:11:13 +0800 (CST)
Message-ID: <e876594b-7ed8-4048-b1e3-4a40387d3299@huaweicloud.com>
Date: Wed, 25 Dec 2024 11:11:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests PATCH] generic/567: add partial pages zeroing out case
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
 <Z2pYVqXKLvM2xwKt@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z2pYVqXKLvM2xwKt@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCngYXPd2tnrZFAFg--.1644S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW5Kr45Ww4xXw47Zw18Zrb_yoW5Ar1xpF
	y3Ga4ayr4Iqa4xuw4avr13XFyrtrsavFsrZr13Xr98ZF1j9r1xKrnF9340qFyDKr4v9r4F
	vws7try5Ww1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/24 14:45, Ojaswin Mujoo wrote:
> On Mon, Dec 23, 2024 at 10:39:30AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> This addresses a data corruption issue encountered during partial page
>> zeroing in ext4 which the block size is smaller than the page size [1].
>> Expand this test to include a zeroing range test that spans two partial
>> pages to cover this case.
>>
>> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  tests/generic/567     | 50 +++++++++++++++++++++++++------------------
>>  tests/generic/567.out | 18 ++++++++++++++++
>>  2 files changed, 47 insertions(+), 21 deletions(-)
>>
>> diff --git a/tests/generic/567 b/tests/generic/567
>> index fc109d0d..756280e8 100755
>> --- a/tests/generic/567
>> +++ b/tests/generic/567
>> @@ -4,43 +4,51 @@
>>  #
>>  # FS QA Test No. generic/567
>>  #
>> -# Test mapped writes against punch-hole to ensure we get the data
>> -# correctly written. This can expose data corruption bugs on filesystems
>> -# where the block size is smaller than the page size.
>> +# Test mapped writes against punch-hole and zero-range to ensure we get
>> +# the data correctly written. This can expose data corruption bugs on
>> +# filesystems where the block size is smaller than the page size.
>>  #
>>  # (generic/029 is a similar test but for truncate.)
>>  #
>>  . ./common/preamble
>> -_begin_fstest auto quick rw punch
>> +_begin_fstest auto quick rw punch zero
>>  
>>  # Import common functions.
>>  . ./common/filter
>>  
>>  _require_scratch
>>  _require_xfs_io_command "fpunch"
>> +_require_xfs_io_command "fzero"
>>  
>>  testfile=$SCRATCH_MNT/testfile
>>  
>>  _scratch_mkfs > /dev/null 2>&1
>>  _scratch_mount
>>  
>> -# Punch a hole straddling two pages to check that the mapped write after the
>> -# hole-punching is correctly handled.
>> -
>> -$XFS_IO_PROG -t -f \
>> --c "pwrite -S 0x58 0 12288" \
>> --c "mmap -rw 0 12288" \
>> --c "mwrite -S 0x5a 2048 8192" \
>> --c "fpunch 2048 8192" \
>> --c "mwrite -S 0x59 2048 8192" \
>> --c "close"      \
>> -$testfile | _filter_xfs_io
>> -
>> -echo "==== Pre-Remount ==="
>> -_hexdump $testfile
>> -_scratch_cycle_mount
>> -echo "==== Post-Remount =="
>> -_hexdump $testfile
>> +# Punch a hole and zero out straddling two pages to check that the mapped
>> +# write after the hole-punching and range-zeroing are correctly handled.
>> +_straddling_test()
>> +{
>> +	local test_cmd=$1
>> +
>> +	$XFS_IO_PROG -t -f \
>> +		-c "pwrite -S 0x58 0 12288" \
>> +		-c "mmap -rw 0 12288" \
>> +		-c "mwrite -S 0x5a 2048 8192" \
>> +		-c "$test_cmd 2048 8192" \
>> +		-c "mwrite -S 0x59 2048 8192" \
>> +		-c "close"      \
>> +	$testfile | _filter_xfs_io
> 
> Hey Zhang,
> 
> While we are at it, can we generalize the test to work for
> non-4k page sizes as well.
> 

Hi, Ojaswin.

Yeah, I suppose we can do it.

Thanks,
Yi.


