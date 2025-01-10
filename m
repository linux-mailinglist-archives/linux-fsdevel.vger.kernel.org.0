Return-Path: <linux-fsdevel+bounces-38774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF51CA08520
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E28E1889B3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A4218C01D;
	Fri, 10 Jan 2025 02:05:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421718027;
	Fri, 10 Jan 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736474724; cv=none; b=o6mGw16RtBVHJ77Po0k/3pSKFbUOCyBnQWGrEyLOjg1TdoCcRZnX+mGuSRKnY8Q59g/8I8hUFcOK6mu0uWtj5XlYFLfcNSnTKvWo2YrJQFzIXVpIgJUKCnSybPRt07Lr0AYd1T73APQY8ks3+IWoN17xI5k+LFIhfyjEi2kNfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736474724; c=relaxed/simple;
	bh=4xYgW0a6YtAwogWixOy5AD59vqq7JLFwPDnj5/tyBVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIRGej6TV9FwSjkUb5L2IcflM4NQOSNVfG4XdGd62SBBYshxFCrvctnQvnL6wtRrIaaY9+9eKqpp+gMonRhE81g3rAysod+cetLSeXsH8ATQxzHgbp8h62yvVFnu33bB+cuJDVE/pt2QdklZDQ9HtQwWFH8TkmmHDVxvvJ7TBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YTlN74xC6z4f3jHt;
	Fri, 10 Jan 2025 10:04:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 23B081A0E79;
	Fri, 10 Jan 2025 10:05:17 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgA3m19ZgIBnk6geAg--.15902S3;
	Fri, 10 Jan 2025 10:05:14 +0800 (CST)
Message-ID: <be3dfb59-b9ec-4682-92c4-b47b12dab5e8@huaweicloud.com>
Date: Fri, 10 Jan 2025 10:05:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests PATCH v3] generic: add a partial pages zeroing out test
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
 ojaswin@linux.ibm.com, djwong@kernel.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
 <20250109181914.xffhgu2x75eh4m2u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250109181914.xffhgu2x75eh4m2u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3m19ZgIBnk6geAg--.15902S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8AF18GFW5ur4rCw1kuFg_yoWrAF43pF
	Wru3Wayr4xJa47G3s3uFn8XryrJrs3ZF47ur9xWw1YkFWqvrn7CFZIgr48GrZxGr4j9r4F
	vw4vq34a9r1qqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/1/10 2:19, Zorro Lang wrote:
> On Wed, Jan 08, 2025 at 04:44:07PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> This addresses a data corruption issue encountered during partial page
>> zeroing in ext4 which the block size is smaller than the page size [1].
>> Add a new test which is expanded upon generic/567, this test performs a
>> zeroing range test that spans two partial pages to cover this case, and
>> also generalize it to work for non-4k page sizes.
>>
>> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>> v2->v3:
>>  - Put the verifyfile in $SCRATCH_MNT and remove the overriding
>>    _cleanup.
>>  - Correct the test name.
>> v1->v2:
>>  - Add a new test instead of modifying generic/567.
>>  - Generalize the test to work for non-4k page sizes.
>> v2: https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/
>> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
>>
>>  tests/generic/758     | 68 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/758.out |  3 ++
>>  2 files changed, 71 insertions(+)
>>  create mode 100755 tests/generic/758
>>  create mode 100644 tests/generic/758.out
>>
>> diff --git a/tests/generic/758 b/tests/generic/758
>> new file mode 100755
>> index 00000000..bf0a342b
>> --- /dev/null
>> +++ b/tests/generic/758
>> @@ -0,0 +1,68 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
>> +#
>> +# FS QA Test No. 758
>> +#
>> +# Test mapped writes against zero-range to ensure we get the data
>> +# correctly written. This can expose data corruption bugs on filesystems
>> +# where the block size is smaller than the page size.
>> +#
>> +# (generic/567 is a similar test but for punch hole.)
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rw zero
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +_require_scratch
>> +_require_xfs_io_command "fzero"
>> +
>> +verifyfile=$SCRATCH_MNT/verifyfile
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +pagesz=$(getconf PAGE_SIZE)
> 
> There's a common helper "_get_page_size" to do this.
> 

Ha, I missed this, thanks for point this out.

>> +
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount
>> +
>> +_dump_files()
>> +{
>> +	echo "---- testfile ----"
>> +	_hexdump $testfile
>> +	echo "---- verifyfile --"
>> +	_hexdump $verifyfile
>> +}
>> +
>> +# Build verify file, the data in this file should be consistent with
>> +# that in the test file.
>> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
>> +		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
>> +		$verifyfile | _filter_xfs_io >> /dev/null
>                                              ????????
>                                              >> $seqres.full ?

I think both of these are okay, write to $seqres.full also looks fine
to me.

> 
>> +
>> +# Zero out straddling two pages to check that the mapped write after the
>> +# range-zeroing are correctly handled.
>> +$XFS_IO_PROG -t -f \
>> +	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
>> +	-c "mmap -rw 0 $((pagesz * 3))" \
>> +	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
>> +	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
>> +	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
>> +	-c "close"      \
>> +$testfile | _filter_xfs_io > $seqres.full
>                               ^^
>                               >> $seqres.full
> 
> I'll help to make above tiny changes when I merge it, others looks good
> to me.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks.
Yi.

> 
>> +
>> +echo "==== Pre-Remount ==="
>> +if ! cmp -s $testfile $verifyfile; then
>> +	echo "Data does not match pre-remount."
>> +	_dump_files
>> +fi
>> +_scratch_cycle_mount
>> +echo "==== Post-Remount =="
>> +if ! cmp -s $testfile $verifyfile; then
>> +	echo "Data does not match post-remount."
>> +	_dump_files
>> +fi
>> +
>> +status=0
>> +exit
>> diff --git a/tests/generic/758.out b/tests/generic/758.out
>> new file mode 100644
>> index 00000000..d01c1959
>> --- /dev/null
>> +++ b/tests/generic/758.out
>> @@ -0,0 +1,3 @@
>> +QA output created by 758
>> +==== Pre-Remount ===
>> +==== Post-Remount ==
>> -- 
>> 2.39.2
>>


