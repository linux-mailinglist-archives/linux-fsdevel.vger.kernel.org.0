Return-Path: <linux-fsdevel+bounces-38159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21AC9FD1F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 09:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23A03A0659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090D154426;
	Fri, 27 Dec 2024 08:29:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229E2BAF7;
	Fri, 27 Dec 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735288182; cv=none; b=tB7LH+cZjfGGS//4CY7D3h7a2NSBTWVoLf5MEF/DX9bIsfzzLPIOhBU9seFICSJ9kA4WEcuUy4iyIJoSHh3yXrEl9AZVJ8M+mM5ZobAIoQ210uQqvfppMWOlTXb4+xVIZxqsrc7aHRVDNIqUShXvMdNvmdK6fUPwHjEtpxopwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735288182; c=relaxed/simple;
	bh=aUJgAbO5iskOk/k258sYNnwjVkxh2pFnqJLESNLyWsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqBuUr8N+gevgWRRs2Gn0t8nCb5ANRaRYUW+a8ecdeXDh36xBRzcTuOix3yydz3P22SCGEUAPdFOr3SfspK1dTzycra/7fGzSQsRv3ihFitpNAWC8MZ0St25IO3eLaZP0pzo6U8b2mpsTJMcbEPKbI2r1u4bRASV6ttFHQyLmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YKJZ41cHRz4f3jXX;
	Fri, 27 Dec 2024 16:29:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 035DC1A06DA;
	Fri, 27 Dec 2024 16:29:36 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoJsZW5nzMkSFw--.2142S3;
	Fri, 27 Dec 2024 16:29:34 +0800 (CST)
Message-ID: <67ae32aa-11e1-4e7f-b911-2546856564c2@huaweicloud.com>
Date: Fri, 27 Dec 2024 16:29:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests PATCH] generic/567: add partial pages zeroing out case
To: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org,
 zlang@kernel.org
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, willy@infradead.org, ojaswin@linux.ibm.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
 <7e77d8d1bf4521a727247badd6b6231256abb791.camel@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <7e77d8d1bf4521a727247badd6b6231256abb791.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3XoJsZW5nzMkSFw--.2142S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWUuF4fWF45ZrW7Ary8uFg_yoWrZFy5pa
	43Ga4ayr4Iqa4xW3y2vF13XFyrtrsavFsrAry3X345ZF1j9r1xKFsIg340q3WkKr4kuw4F
	vw4ktFyrW3WDZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/12/27 13:28, Nirjhar Roy wrote:
> On Mon, 2024-12-23 at 10:39 +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> This addresses a data corruption issue encountered during partial
>> page
>> zeroing in ext4 which the block size is smaller than the page size
>> [1].
>> Expand this test to include a zeroing range test that spans two
>> partial
>> pages to cover this case.
>>
>> Link: 
>> https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/
>>  [1]
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  tests/generic/567     | 50 +++++++++++++++++++++++++--------------
>> ----
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
>> -# correctly written. This can expose data corruption bugs on
>> filesystems
>> -# where the block size is smaller than the page size.
>> +# Test mapped writes against punch-hole and zero-range to ensure we
>> get
>> +# the data correctly written. This can expose data corruption bugs
>> on
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
> Since this test requires block size < page size, do you think it is a
> good idea to hard code the _scratch_mkfs parameters to explicitly pass
> the block size to < less than zero? This will require less manipulation
> with the local.config file. Or maybe have a _notrun to _notrun the test
> if the block size is not less than the page size?

Hi, Nirjhar. Thank you for the review!

Although the issue we encountered is on the configuration that block
size is less than page size, I believe it is also harmless to run this
test in an environment where the block size is equal to the page size.
This is a quick and basic test.

>>  _scratch_mount
>>  
>> -# Punch a hole straddling two pages to check that the mapped write
>> after the
>> -# hole-punching is correctly handled.
>> -
>> -$XFS_IO_PROG -t -f \
>> --c "pwrite -S 0x58 0 12288" \
>> --c "mmap -rw 0 12288" \
>> --c "mwrite -S 0x5a 2048 8192" \
>> --c "fpunch 2048 8192" \
>> --c "mwrite -S 0x59 2048 8192" \
>> --c "close" 
> Minor: isn't the close command redundant? xfs_io will in any case close
> the file right?

Yes, but this explicit close is from the original text and appears
harmless, so I'd suggest keeping it.

>>      \
>> -$testfile | _filter_xfs_io
>> -
>> -echo "==== Pre-Remount ==="
>> -_hexdump $testfile
>> -_scratch_cycle_mount
>> -echo "==== Post-Remount =="
>> -_hexdump $testfile
>> +# Punch a hole and zero out straddling two pages to check that the
>> mapped
>> +# write after the hole-punching and range-zeroing are correctly
>> handled.
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
> Just guessing here: Do you think it is makes sense to test with both
> delayed and non-delayed allocation? I mean with and without "msync"?

Sorry, I don't understand why we need msync. The umount should flush
the dirty pages to the disk even without msync, I mean this this test
does not focus on the functionality of msync now.

>> +}
>> +
>> +_straddling_test "fpunch"
>> +_straddling_test "fzero"
> Minor: Since we are running 2 independant sub-tests, isn't it better to
> use 2 different files?
> 

Yes, Darrick had the same suggestion, and I have separated this into
generic/758 in my v2.

  https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.



