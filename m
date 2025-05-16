Return-Path: <linux-fsdevel+bounces-49313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C8ABA6C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 01:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF82F4A7FE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 23:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7BC281358;
	Fri, 16 May 2025 23:55:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71ED231856;
	Fri, 16 May 2025 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439705; cv=none; b=DQIcXEGkahqz+U7VSY+GidFD/Jr4N2cI0yOfX1EdqR7FS0CyOFldImGRa4sO6HybYD6m0ZD4a4o6KbuHe0INtEig0sTNRwzOR6P5sf4gyijxPVabzGt+VlpiaMn5BKAcgQjHYIQQILJwUdTWPFhPdUAT49//lziS70S68pNXbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439705; c=relaxed/simple;
	bh=CfqjHVwYMYg0l/h6PF8KpBfyUMOE57166y6yYuTN2a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8IljFLVgItpe9UfaPQbXOll3PrvUqhN0cITOQnvN5qc+OllrNHImuRaKd9fDd2AeZfZAAy3oCV23u98VmJ2x9cT2H3vcQV8+4YosWXgnJV/CO3hN21lR4fOJkFJE8wxQJeVNwyXiqEv+FcClncJydhvAkmQ5h9f7nzhGH2ANm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZzkT53QB4z4f3jd5;
	Sat, 17 May 2025 07:54:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5983D1A1382;
	Sat, 17 May 2025 07:54:58 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgAHa19P0CdoeQWHMg--.3231S3;
	Sat, 17 May 2025 07:54:58 +0800 (CST)
Message-ID: <b3d6db6f-61d8-498a-b90c-0716a64f7528@huaweicloud.com>
Date: Sat, 17 May 2025 07:54:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Rename the parameter of mnt_get_write_access()
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com
References: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
 <vtfnncganindq4q7t4icfaujkgejlbd7repvurpjx6nwf6i7zp@hr44m22ij4qf>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <vtfnncganindq4q7t4icfaujkgejlbd7repvurpjx6nwf6i7zp@hr44m22ij4qf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHa19P0CdoeQWHMg--.3231S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8tw43Cr17JF18Xr4Utwb_yoW5Aw4kpr
	WSgFy8Ka1xJry29rnFya9xCa4fW3ykKrZrK34rWw1avrZ8Zr1Sga4vgr4S9F1kAr9rA34x
	uF40y3s3ur1ayrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/5/16 18:31, Jan Kara 写道:
> On Fri 16-05-25 11:21:47, Zizhi Wo wrote:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> Rename the parameter in mnt_get_write_access() from "m" to "mnt" for
>> consistency between declaration and implementation.
>>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> 
> I'm sorry but this is just a pointless churn. I agree the declaration and
> implementation should better be consistent (although in this particular
> case it isn't too worrying) but it's much easier (and with much lower
> chance to cause conflicts) to just fixup the declaration.
> 
> 								Honza

Yes, I had considered simply fixing the declaration earlier. However, in
the include/linux/mount.h file, similar functions like
"mnt_put_write_access" use "mnt" as the parameter name rather than "m",
just like "mnt_get_write_access". So I chose to modify the function
implementation directly, although this resulted in a larger amount of
changes. So as you can see, for simplicity, I will directly update the
parameter name in the function declaration in the second version.

Thanks,
Zizhi Wo

> 
>> ---
>>   fs/namespace.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 1b466c54a357..b1b679433ab3 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -483,7 +483,7 @@ static int mnt_is_readonly(struct vfsmount *mnt)
>>    */
>>   /**
>>    * mnt_get_write_access - get write access to a mount without freeze protection
>> - * @m: the mount on which to take a write
>> + * @mnt: the mount on which to take a write
>>    *
>>    * This tells the low-level filesystem that a write is about to be performed to
>>    * it, and makes sure that writes are allowed (mnt it read-write) before
>> @@ -491,13 +491,13 @@ static int mnt_is_readonly(struct vfsmount *mnt)
>>    * frozen. When the write operation is finished, mnt_put_write_access() must be
>>    * called. This is effectively a refcount.
>>    */
>> -int mnt_get_write_access(struct vfsmount *m)
>> +int mnt_get_write_access(struct vfsmount *mnt)
>>   {
>> -	struct mount *mnt = real_mount(m);
>> +	struct mount *m = real_mount(mnt);
>>   	int ret = 0;
>>   
>>   	preempt_disable();
>> -	mnt_inc_writers(mnt);
>> +	mnt_inc_writers(m);
>>   	/*
>>   	 * The store to mnt_inc_writers must be visible before we pass
>>   	 * MNT_WRITE_HOLD loop below, so that the slowpath can see our
>> @@ -505,7 +505,7 @@ int mnt_get_write_access(struct vfsmount *m)
>>   	 */
>>   	smp_mb();
>>   	might_lock(&mount_lock.lock);
>> -	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
>> +	while (READ_ONCE(m->mnt.mnt_flags) & MNT_WRITE_HOLD) {
>>   		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>>   			cpu_relax();
>>   		} else {
>> @@ -530,8 +530,8 @@ int mnt_get_write_access(struct vfsmount *m)
>>   	 * read-only.
>>   	 */
>>   	smp_rmb();
>> -	if (mnt_is_readonly(m)) {
>> -		mnt_dec_writers(mnt);
>> +	if (mnt_is_readonly(mnt)) {
>> +		mnt_dec_writers(m);
>>   		ret = -EROFS;
>>   	}
>>   	preempt_enable();
>> -- 
>> 2.39.2
>>


