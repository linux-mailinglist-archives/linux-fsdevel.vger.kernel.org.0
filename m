Return-Path: <linux-fsdevel+bounces-38378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6BA0120E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 04:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A591884CBB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 03:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A5E13AD03;
	Sat,  4 Jan 2025 03:15:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9B13AD26;
	Sat,  4 Jan 2025 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735960547; cv=none; b=TQje4B/Q91pPQRkxH4Kkh4oOOkeI19RmAK2x3stnwJjGj2LQNvJzRALE6k7l7d3UdPoLv7Pugy7EvY4/J/lFUV/oVjXKSLDY7jItgMSnvmeaI11bVywGgo8bkZOhEmTCihQVsDiuAXCT3RIStfyF178qmcHBdUyK9QhnWa6qukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735960547; c=relaxed/simple;
	bh=gN7eSogZEhLqZYrFoaw6mI0oU2elRJuyTufEmVcPsGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rLw4xDmfZbn6PEtd1VgpACmgUt2BY9qfn8IW74KNoHBW2bniEJfYhZRba/Y1WL4ApP1n98CjMAOcMbzEYkWnYGD+CohAeh38BlASIX1Ze7ZPFAeEModN3gOrawQ+LHewwFa3KmT40bRRTaHCbSULhrBbcnNyBVRoHwK5PeJQ0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YQ5Cf4Ltvz1JGZ3;
	Sat,  4 Jan 2025 11:14:54 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 48C9A1400CA;
	Sat,  4 Jan 2025 11:15:35 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 4 Jan
 2025 11:15:34 +0800
Message-ID: <ad80d4a4-6bc7-47ab-bca1-569d77c868a1@huawei.com>
Date: Sat, 4 Jan 2025 11:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtCVUcgUkVQT1JUXSBleHQ0OiDigJxlcnJvcnM9cmVtb3VudC1y?=
 =?UTF-8?B?b+KAnSBoYXMgYmVjb21lIOKAnGVycm9ycz1zaHV0ZG93buKAnT8=?=
To: Jan Kara <jack@suse.cz>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Christian Brauner <brauner@kernel.org>,
	<sunyongjian1@huawei.com>, Yang Erkun <yangerkun@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>, Baokun Li
	<libaokun1@huawei.com>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
 <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
 <198ead4f-dba6-43d7-a4a5-06b92001518d@huawei.com>
 <7zrjd67t2fyl6wre7t6fuudjn22edslce5xlgioqc7ovfjtwp7@wk44gob6kwwh>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <7zrjd67t2fyl6wre7t6fuudjn22edslce5xlgioqc7ovfjtwp7@wk44gob6kwwh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/3 22:34, Jan Kara wrote:
> On Fri 03-01-25 21:19:27, Baokun Li wrote:
>> On 2025/1/3 18:42, Jan Kara wrote:
>>>>>> What's worse is that after commit
>>>>>>      95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
>>>>>> was merged in v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in
>>>>>> ext4_handle_error(). This causes the file system to not be read-only
>>>>>> when an error is triggered in "errors=remount-ro" mode, because
>>>>>> EXT4_FLAGS_SHUTDOWN prevents both writing and reading.
>>>>> Here I don't understand what is really the problem with EXT4_MF_FS_ABORTED
>>>>> removal. What do you exactly mean by "causes the file system to not be
>>>>> read-only"? We still return EROFS where we used to, we disallow writing as
>>>>> we used to. Can you perhaps give an example what changed with this commit?
>>>> Sorry for the lack of clarity in my previous explanation. The key point
>>>> is not about removing EXT4_MF_FS_ABORTED, but rather we will set
>>>> EXT4_FLAGS_SHUTDOWN bit, which not only prevents writes but also prevents
>>>> reads. Therefore, saying it's not read-only actually means it's completely
>>>> unreadable.
>>> Ah, I see. I didn't think about that. Is it that you really want reading to
>>> work from a filesystem after error? Can you share why (I'm just trying to
>>> understand the usecase)? Or is this mostly a theoretical usecase?
>> Switching to read-only mode after an error is a common practice for most
>> file systems (ext4/btrfs/affs/fat/jfs/nilfs/nilfs2/ocfs2/ubifs/ufs, etc.).
>> There are two main benefits to doing this:
>>   * Read-only processes can continue to run unaffected after the error.
>>   * Shutting down after an error would lose some data in memory that has
>>     not been written to disk. If the file system is read-only, we can back
>>     up these data to another location in time and then exit gracefully.
>>> I think we could introduce "shutdown modifications" state which would still
>>> allow pure reads to succeed if there's a usecase for such functionality.
>> I agree that maintaining a flag like EXT4_FLAGS_RDONLY within ext4 seems
>> to be a good solution at this point. It avoids both introducing mechanism
>> changes and VFS coupling. If no one has a better idea, I will implement it.
> Yeah, let's go with a separate "emergency RO" ext4 flag then. I think we
> could just enhance the ext4_forced_shutdown() checks to take a flag whether
> the operation is a modification or not and when it is a modification, it
> would additionally trigger also when EMERGENCY_RO flag is set (which would
> get set by ext4_handle_error()).
>
> Thanks for having a look into this.
>
> 								Honza
Sounds very nice, this way the changes will be minimal and the code won't
look messy.Thank you for your suggestion!

Cheers,
Baokun
>>>>> So how does your framework detect that the filesystem has failed with
>>>>> errors=remount-ro? By parsing /proc/mounts or otherwise querying current
>>>>> filesystem mount options?
>>>> In most cases, run the mount command and filter related options.
>>>>> Would it be acceptable for you to look at some
>>>>> other mount option (e.g. "shutdown") to detect that state? We could easily
>>>>> implement that.
>>>> We do need to add a shutdown hint, but that's not the point.
>>>>
>>>> We've discussed this internally, and now if the logs are flushed,
>>>> we have no way of knowing if the current filesystem is shutdown. We don't
>>>> know if the -EIO from the filesystem is a hardware problem or if the
>>>> filesystem is already shutdown. So even if there is no current problem,
>>>> we should add some kind of hint to let the user know that the current
>>>> filesystem is shutdown.
>>>>
>>>> The changes to display shutdown are as follows, so that we can see if the
>>>> current filesystem has been shutdown in the mount command.
>>> Yes, I think this would be a good addition regardless of other changes we
>>> might need to do. It would be preferable to be able to come up with
>>> something that's acceptable for querying of shutdown state also for other
>>> filesystems - I've CCed fsdevel and XFS in particular since it has much
>>> longer history of fs shutdown implementation.
>>>
>>> 								Honza
>>>
>>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>>> index 3955bec9245d..ba28ef0f662e 100644
>>>> --- a/fs/ext4/super.c
>>>> +++ b/fs/ext4/super.c
>>>> @@ -3157,6 +3157,9 @@ static int _ext4_show_options(struct seq_file *seq,
>>>> struct super_block *sb,
>>>>           if (nodefs && !test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
>>>>                   SEQ_OPTS_PUTS("prefetch_block_bitmaps");
>>>>
>>>> +       if (!nodefs && ext4_forced_shutdown(sb))
>>>> +               SEQ_OPTS_PUTS("shutdown");
>>>> +
>>>>           ext4_show_quota_options(seq, sb);
>>>>           return 0;
>>>>    }
>>>>> I'm sorry again for causing you trouble.
>>>> Never mind, thank you for your reply!
>>>>


