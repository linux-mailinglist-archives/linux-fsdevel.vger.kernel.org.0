Return-Path: <linux-fsdevel+bounces-38362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BDCA009DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 14:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E2C16423F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879021FA15D;
	Fri,  3 Jan 2025 13:19:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63CA47;
	Fri,  3 Jan 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735910375; cv=none; b=jA6iuCnAqXr8TPZHz6krYBr3ldKht1Gi/q/bo+MjpGjJ/EIjIefIfFJOvttAIyPKlEvsSEfxZSTJaPERDpxqjRBTgi7Iq/FBi96taO1u+bLpEM0iZgiggLKKnhfKBpUI7N+YgzYAuhkTb9q9/E/1BefIozsXU+Omz6b72rS38nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735910375; c=relaxed/simple;
	bh=7+kn2M32PgmaukCxU6+DCgTJhm+mAzf5giiwwywEpbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iVdWrpChnooq3lETUzuRhY4PkmzdZmMCZqrMiB77unNQHQc2KY3REWWoBNv5lkuVy8aCgLtnF4jsDMDaE3vPOeHd8o4etLfL21rqRKmJE2RZ4C1UPMMNdUWGQOZA/JFDqxBo3dK+jNl/lTTL4YmAk/CNuoSY/Bzsh1Lxjz02biQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YPkfx2jV2z1JGc4;
	Fri,  3 Jan 2025 21:18:49 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B70914011B;
	Fri,  3 Jan 2025 21:19:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Jan
 2025 21:19:28 +0800
Message-ID: <198ead4f-dba6-43d7-a4a5-06b92001518d@huawei.com>
Date: Fri, 3 Jan 2025 21:19:27 +0800
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
	<linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
 <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/3 18:42, Jan Kara wrote:
> [CCed XFS and fsdevel list in case people have opinion what would be the
> best interface to know the fs has shutdown]
>   
> On Fri 03-01-25 17:26:58, Baokun Li wrote:
>> Hi Honza，
>>
>> Happy New Year!
> Thanks!
>
>> On 2025/1/2 23:58, Jan Kara wrote:
>>> On Mon 30-12-24 15:27:01, Baokun Li wrote:
>>>> We reported similar issues to the community in 2020,
>>>> https://lore.kernel.org/all/20210104160457.GG4018@quack2.suse.cz/
>>>> Jan Kara provides a simple and effective patch. This patch somehow
>>>> didn't end up merged into upstream, but this patch has been merged into
>>>> our internal version for a couple years now and it works fine, is it
>>>> possible to revert the patch that no longer sets SB_RDONLY and use
>>>> the patch in the link above?
>>> Well, the problem with filesystem freezing was just the immediate trigger
>>> for the changes. But the setting of SB_RDONLY bit by ext4 behind the VFS'
>>> back (as VFS is generally in charge of manipulating that bit and you must
>>> hold s_umount for that which we cannot get in ext4 when handling errors)
>>> was always problematic and I'm almost sure syzbot would find more problems
>>> with that than just fs freezing. As such I don't think we should really
>>> return to doing that in ext4 but we need to find other ways how to make
>>> your error injection to work...
>> I believe this is actually a bug in the evolution of the freeze
>> functionality. In v2.6.35-rc1 with commit 18e9e5104fcd ("Introduce
>> freeze_super and thaw_super for the fsfreeze ioctl"), the introduction
>> of freeze_super/thaw_super did not cause any problems when setting the
>> irreversible read-only (ro) bit without locking, because at that time
>> we used the flag in sb->s_frozen to determine the file system's state.
>> It was not until v4.3-rc1 with commit 8129ed29644b ("change sb_writers
>> to use percpu_rw_semaphore") introduced locking into
>> freeze_super/thaw_super that setting the irreversible ro without locking
>> caused thaw_super to fail to release the locks that should have been
>> released, eventually leading to hangs or other issues.
>>
>> Therefore, I believe that the patch discussed in the previous link is
>> the correct one, and it has a smaller impact and does not introduce any
>> mechanism changes. Furthermore, after roughly reviewing the code using
>> SB_RDONLY, I did not find any logic where setting the irreversible ro
>> without locking could cause problems. If I have overlooked anything,
>> please let me know.
> Well, I don't remember the details but I think there were issues when
> remount between ro/rw state raced with ext4 error setting the filesystem
> read-only. ext4_remount() isn't really prepared for SB_RDONLY changing
> under it and VFS could possibly get confused as well. Also if nothing else
> the unlocked update (or the properly locked one!) to sb->s_flags can get
> lost due to a racing read-modify-write cycle of sb->s_flags from other
> process.
With journaling enabled, we abort the journal upon encountering an error.

If the transition is from rw (read-write) to ro (read-only), the change
to read-only due to the error itself is not a problem.

When transitioning from ro back to rw, even if s_flags is lost, the ro
state will be re-established upon detecting the aborted journal when
metadata modifications are attempted. Therefore, the data on disk is not
affected.

However, similar to how freeze works, some locks that depend on the ro/rw
state might cause a hang. Therefore, I haven't found any code where a race
condition could cause problems, but I might have missed something.
> All these could possibly be fixed but in general it is a rather fragile
> design that the SB_RDONLY flag can change under you at any moment.
> Basically two following sb_rdonly() checks have to be prepared to get
> different results regardless of locks they hold. And this is very easy to
> forget. So I still think moving away from that is a good direction.
If you dislike the deep coupling of these codes with the VFS, we can
maintain a read-only flag internally within ext4, similar to
BCH_FS_emergency_ro in bcachefs.
>>>> What's worse is that after commit
>>>>     95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag")
>>>> was merged in v6.6-rc1, the EXT4_FLAGS_SHUTDOWN bit is set in
>>>> ext4_handle_error(). This causes the file system to not be read-only
>>>> when an error is triggered in "errors=remount-ro" mode, because
>>>> EXT4_FLAGS_SHUTDOWN prevents both writing and reading.
>>> Here I don't understand what is really the problem with EXT4_MF_FS_ABORTED
>>> removal. What do you exactly mean by "causes the file system to not be
>>> read-only"? We still return EROFS where we used to, we disallow writing as
>>> we used to. Can you perhaps give an example what changed with this commit?
>> Sorry for the lack of clarity in my previous explanation. The key point
>> is not about removing EXT4_MF_FS_ABORTED, but rather we will set
>> EXT4_FLAGS_SHUTDOWN bit, which not only prevents writes but also prevents
>> reads. Therefore, saying it's not read-only actually means it's completely
>> unreadable.
> Ah, I see. I didn't think about that. Is it that you really want reading to
> work from a filesystem after error? Can you share why (I'm just trying to
> understand the usecase)? Or is this mostly a theoretical usecase?
Switching to read-only mode after an error is a common practice for most
file systems (ext4/btrfs/affs/fat/jfs/nilfs/nilfs2/ocfs2/ubifs/ufs, etc.).
There are two main benefits to doing this:
  * Read-only processes can continue to run unaffected after the error.
  * Shutting down after an error would lose some data in memory that has
    not been written to disk. If the file system is read-only, we can back
    up these data to another location in time and then exit gracefully.
> I think we could introduce "shutdown modifications" state which would still
> allow pure reads to succeed if there's a usecase for such functionality.
I agree that maintaining a flag like EXT4_FLAGS_RDONLY within ext4 seems
to be a good solution at this point. It avoids both introducing mechanism
changes and VFS coupling. If no one has a better idea, I will implement it.


Cheers,
Baokun
>>> So how does your framework detect that the filesystem has failed with
>>> errors=remount-ro? By parsing /proc/mounts or otherwise querying current
>>> filesystem mount options?
>> In most cases, run the mount command and filter related options.
>>> Would it be acceptable for you to look at some
>>> other mount option (e.g. "shutdown") to detect that state? We could easily
>>> implement that.
>> We do need to add a shutdown hint, but that's not the point.
>>
>> We've discussed this internally, and now if the logs are flushed,
>> we have no way of knowing if the current filesystem is shutdown. We don't
>> know if the -EIO from the filesystem is a hardware problem or if the
>> filesystem is already shutdown. So even if there is no current problem,
>> we should add some kind of hint to let the user know that the current
>> filesystem is shutdown.
>>
>> The changes to display shutdown are as follows, so that we can see if the
>> current filesystem has been shutdown in the mount command.
> Yes, I think this would be a good addition regardless of other changes we
> might need to do. It would be preferable to be able to come up with
> something that's acceptable for querying of shutdown state also for other
> filesystems - I've CCed fsdevel and XFS in particular since it has much
> longer history of fs shutdown implementation.
>
> 								Honza
>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 3955bec9245d..ba28ef0f662e 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -3157,6 +3157,9 @@ static int _ext4_show_options(struct seq_file *seq,
>> struct super_block *sb,
>>          if (nodefs && !test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
>>                  SEQ_OPTS_PUTS("prefetch_block_bitmaps");
>>
>> +       if (!nodefs && ext4_forced_shutdown(sb))
>> +               SEQ_OPTS_PUTS("shutdown");
>> +
>>          ext4_show_quota_options(seq, sb);
>>          return 0;
>>   }
>>> I'm sorry again for causing you trouble.
>> Never mind, thank you for your reply!
>>


