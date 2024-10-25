Return-Path: <linux-fsdevel+bounces-32860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8549AFC2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838711F24653
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C321CB9E5;
	Fri, 25 Oct 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Natw1kbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E6E1C174E;
	Fri, 25 Oct 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843727; cv=none; b=k5YPFjOYncOOL/sYls67d9M/NmRctoxYI+2CZ23CKxPncYoFGx679Hhqz5WT1Xj476lIADfg3ed9+yZORXLgU+boIQzHkhWp7jD+C0mj+KD9iKwNaHbRcHfqBqMvqYTM9uWuNsuDqAcccgqeCPWdDDT3FLMRh4d7q56ubSMHbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843727; c=relaxed/simple;
	bh=o4DybrSrVDihFHShJ4/Vt2gN6reU2X6JWSVhAb8Si0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msaV3yeNuOhVp2cPRuIpxAmAN5Fksaq8QaWOrjt+C9GLFBOGpS3kQER0i63U5qZ7dVMx55upgAdrWRKn7m2ujm68AHPBiGfIE9rcDSXthsZNGIt9LDd6RerPXxwt59LDVjQCUVplqprTSCLU8T81VKdU11xKrQwRx/U4VkkxNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Natw1kbr; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=r3nzekg+I5f5WPWu38712yQntFNa5m3rM6B0eksQk4Q=;
	b=Natw1kbrvfTOT4ZfU9XEKb1XkpTwUg8TJ0VSX+39UG1yBFgq8F6aezMpcoL6Su
	FVBgZxlMpaXB+5TBJmlZuefn/BYK1oURmGfP4u8BYmNhi08RlnvSsGKk2//2/K4t
	2MXXhkPzp0vM4AT42fZfpMNHBJMS9UQ4LL/rcIY+LKtzA=
Received: from [10.42.12.92] (unknown [111.48.69.246])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3_7H5URtnkF8hAA--.10152S2;
	Fri, 25 Oct 2024 16:08:26 +0800 (CST)
Message-ID: <afe66b04-3990-457c-ad43-9b5370a815d6@163.com>
Date: Fri, 25 Oct 2024 16:08:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mount_setattr: fix idmap_mount_tree_invalid
 failed to run
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, brauner@kernel.org,
 sforshee@kernel.org, shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhouyuhang <zhouyuhang@kylinos.cn>
References: <20241024095013.1213852-1-zhouyuhang1010@163.com>
 <1c8674a0-d220-4349-88ea-780f0fed8545@linuxfoundation.org>
From: zhouyuhang <zhouyuhang1010@163.com>
In-Reply-To: <1c8674a0-d220-4349-88ea-780f0fed8545@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3_7H5URtnkF8hAA--.10152S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4rWF48Gr1DuFWDZr48Xrb_yoW5AF1UpF
	WrX3ZFkrW8GF17KF1xC3ZYq3WIqrsrZa13Grn5Wry5AFs8GrnFqFyfKFyjqry2kr13XrWF
	vw1rX3W5WFsIyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jT_MxUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiLwuDJmca6GZ6hAABsN



在 2024/10/24 22:26, Shuah Khan 写道:
> On 10/24/24 03:50, zhouyuhang wrote:
>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>
>> Test case idmap_mount_tree_invalid failed to run on the newer kernel
>> with the following output:
>>
>>   #  RUN mount_setattr_idmapped.idmap_mount_tree_invalid ...
>>   # mount_setattr_test.c:1428:idmap_mount_tree_invalid:Expected 
>> sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, 
>> sizeof(attr)) (0) ! = 0 (0)
>>   # idmap_mount_tree_invalid: Test terminated by assertion
>>
>> This is because tmpfs is mounted at "/mnt/A", and tmpfs already
>> contains the flag FS_ALLOW_IDMAP after the commit 7a80e5b8c6fa ("shmem:
>> support idmapped mounts for tmpfs"). So calling sys_mount_setattr here
>> returns 0 instead of -EINVAL as expected.
>>
>> Ramfs is mounted at "/mnt/B" and does not support idmap mounts.
>> So we can use "/mnt/B" instead of "/mnt/A" to make the test run
>> successfully with the following output:
>>
>>   # Starting 1 tests from 1 test cases.
>>   #  RUN mount_setattr_idmapped.idmap_mount_tree_invalid ...
>>   #            OK mount_setattr_idmapped.idmap_mount_tree_invalid
>>   ok 1 mount_setattr_idmapped.idmap_mount_tree_invalid
>>   # PASSED: 1 / 1 tests passed.
>>
>
> Sounds like this code is testing this very condition passing
> in invalid mount to see what happens. If that is the intent
> this patch is incorrect.
>

I think I probably understand what you mean, what you're saying is that 
the output of this line of errors is the condition,
and the main purpose of the test case is to see what happens when it 
invalid mount. But it's valid now, isn't it?
So we need to fix it. I don't think that constructing this error with 
ramfs will have any impact on the code that follows.
If you feel that using "/mnt/B" is unreliable, I think we can 
temporarily mount ramfs to "/mnt/A" here and continue using "/mnt/A".
Do you think this is feasible? Looking forward to your reply, thank you.

>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>> ---
>>   tools/testing/selftests/mount_setattr/mount_setattr_test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git 
>> a/tools/testing/selftests/mount_setattr/mount_setattr_test.c 
>> b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>> index c6a8c732b802..54552c19bc24 100644
>> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
>> @@ -1414,7 +1414,7 @@ TEST_F(mount_setattr_idmapped, 
>> idmap_mount_tree_invalid)
>>       ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/b", 0, 0, 0), 0);
>>       ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/BB/b", 0, 0, 0), 0);
>>   -    open_tree_fd = sys_open_tree(-EBADF, "/mnt/A",
>> +    open_tree_fd = sys_open_tree(-EBADF, "/mnt/B",
>>                        AT_RECURSIVE |
>>                        AT_EMPTY_PATH |
>>                        AT_NO_AUTOMOUNT |
>
> thanks,
> -- Shuah


