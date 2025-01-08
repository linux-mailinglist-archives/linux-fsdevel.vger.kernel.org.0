Return-Path: <linux-fsdevel+bounces-38636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17938A054E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 09:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3465164EF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1F1ACEDD;
	Wed,  8 Jan 2025 08:00:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9986324;
	Wed,  8 Jan 2025 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323233; cv=none; b=E50q8ZEauHnfz6Ne9ipSIHgtDxqBmj5ceYYKHN1m/OUz0U1IAO4mBXY3Hc4pwDkg8kG36PlzK0uEKq9FROh1cAW817YWlq7LMVpMvXNgEYf/kP/lAZA8Sv2JcLblmVNI4vLk2Aets1OzJSQa6GkkA3FqtZM3Mp3qZgYKe+Cls+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323233; c=relaxed/simple;
	bh=PRn6O56hP1PW9dQPfJtdu8tCul4YM2r1wgdCeklt/Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmQF8ei8nyHQ3+ylKROZvKgRV1rUpJU9Gx8Nl7N75sluC75EFwtq1Zw9sfiX5RUH7Qwme0hK8yQN1X0ipRagIdCFaZR+wose32JZinvzxtumbw3Jcu6Sz1sHQ86fExBStAxIxgdU7IORUtgfEpgJ0xMqa8+K5ptdUpSmyE5NYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YSgLy5Qztz4f3jss;
	Wed,  8 Jan 2025 16:00:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B76211A1620;
	Wed,  8 Jan 2025 16:00:25 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl+VMH5n9XV5AQ--.56329S3;
	Wed, 08 Jan 2025 16:00:23 +0800 (CST)
Message-ID: <9586a142-ab96-4f3d-961d-8edb8a87e616@huaweicloud.com>
Date: Wed, 8 Jan 2025 16:00:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests PATCH v2] generic: add a partial pages zeroing out test
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
 ojaswin@linux.ibm.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20241225125120.1952219-1-yi.zhang@huaweicloud.com>
 <20250108015042.GC1251194@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250108015042.GC1251194@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnSl+VMH5n9XV5AQ--.56329S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8AF18GFyDZr1UGw4fGrg_yoWrAryfpF
	Z5W3ZIyr4xJa47J3s3uFn8Xry3Jws3ZF47ury7Wr90yFWvvrn7Ga9Igr48WFZ3Gw4j9r4F
	vw4kX34a9r4vvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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

On 2025/1/8 9:50, Darrick J. Wong wrote:
> On Wed, Dec 25, 2024 at 08:51:20PM +0800, Zhang Yi wrote:
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
>> v1->v2:
>>  - Add a new test instead of modifying generic/567.
>>  - Generalize the test to work for non-4k page sizes.
>> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
>>
>>  tests/generic/758     | 76 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/758.out |  3 ++
>>  2 files changed, 79 insertions(+)
>>  create mode 100755 tests/generic/758
>>  create mode 100644 tests/generic/758.out
>>
>> diff --git a/tests/generic/758 b/tests/generic/758
>> new file mode 100755
>> index 00000000..e03b5e80
>> --- /dev/null
>> +++ b/tests/generic/758
>> @@ -0,0 +1,76 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
>> +#
>> +# FS QA Test No. generic/758
> 
> "FS QA Test No. 758" is ok here, or whatever ./new spat out.
> 
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
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $verifyfile $testfile
> 
> Don't bother deleting anything on $SCRATCH_MNT, it'll get mkfs'd out of
> existence soon enough.
> 
>> +}
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +_require_test
>> +_require_scratch
>> +_require_xfs_io_command "fzero"
>> +
>> +verifyfile=$TEST_DIR/verifyfile
> 
> Also is there any harm in putting verifyfile on $SCRATCH_MNT and thereby
> not having to override _cleanup?
> 

Ha, it seems fine to me. Putting verifyfile on $SCRATCH_MNT should have no
side effects, I will do this in next iteration.

Thanks,
Yi.

> 
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +pagesz=$(getconf PAGE_SIZE)
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
>>


