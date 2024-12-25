Return-Path: <linux-fsdevel+bounces-38113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B489FC370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 04:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501A17A1C36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 03:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19E2D047;
	Wed, 25 Dec 2024 03:14:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C233F7;
	Wed, 25 Dec 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735096448; cv=none; b=Q5ySNMnLkqH7YGTWbjod8KO7aLJHs//4cAPaZpou/KNyanUaxWIyLub/SM1HNKvDG81m6rqbjqcbtkCM7XFV6tRiEQXItf0VCmAjnXcsqWryNNvMP9YSLKtk/Rhr/jA12kTVSgB0uKN+ZNOg4w+izRzS08SRQXehK/SeopyKMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735096448; c=relaxed/simple;
	bh=T6utHAwyk/2f9bCYULVY1oH7vbi+AK/T+3AiMwYxIPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSF3HBKqq3tnPE82Y1H7v9Np+SY5/8UC+cCMatf34nlGv9XIBmvYwliiS59xl4MA4GvYjQTNa1UUWzP8dPCtiD2hfxDHnm1sfBMFprlYOBJaOYZCCpUyeOYfVRPz8b9K67vOJcVyFr/TvXPao6q1QDcwuIKUE5oZ20LFL6gr7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YHxft3MRKz4f3jd2;
	Wed, 25 Dec 2024 11:13:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2D2AC1A0AE9;
	Wed, 25 Dec 2024 11:14:02 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoZ4eGtnqr9AFg--.2389S3;
	Wed, 25 Dec 2024 11:14:01 +0800 (CST)
Message-ID: <1fab13e6-a64a-49e8-930d-13ac12e984e3@huaweicloud.com>
Date: Wed, 25 Dec 2024 11:14:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests PATCH] generic/567: add partial pages zeroing out case
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
 ojaswin@linux.ibm.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
 <20241224194042.GH6156@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241224194042.GH6156@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHYoZ4eGtnqr9AFg--.2389S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW5Kr45Ww4xArWkuF47XFb_yoWrCryDpF
	yfJa4ayr40q3W3AFsFv345XFyrJws3AF1UAr13Jry5ZF10y3W7KFsIgw10k3WUGr1vvr1F
	vr4Utryjqr4UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/25 3:40, Darrick J. Wong wrote:
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
> 
> Please don't overload an existing test.  Filesystems such as gfs2,
> hugetblfs, nfs, ntfs3, and ocfs2 support fpunch but don't support fzero.
> This change opens a testing gap for those filesystems.
> 

OK, thanks for point this out, I will create a new test for this case.

Thanks,
Yi.

> 
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
>> +
>> +	echo "==== Pre-Remount ==="
>> +	_hexdump $testfile
>> +	_scratch_cycle_mount
>> +	echo "==== Post-Remount =="
>> +	_hexdump $testfile
>> +}
>> +
>> +_straddling_test "fpunch"
>> +_straddling_test "fzero"
>>  
>>  status=0
>>  exit
>> diff --git a/tests/generic/567.out b/tests/generic/567.out
>> index 0e826ed3..df89b8f3 100644
>> --- a/tests/generic/567.out
>> +++ b/tests/generic/567.out
>> @@ -17,3 +17,21 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>  002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>>  *
>>  003000
>> +wrote 12288/12288 bytes at offset 0
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +==== Pre-Remount ===
>> +000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>> +*
>> +000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
>> +*
>> +002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>> +*
>> +003000
>> +==== Post-Remount ==
>> +000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>> +*
>> +000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
>> +*
>> +002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>> +*
>> +003000
>> -- 
>> 2.46.1
>>
>>


