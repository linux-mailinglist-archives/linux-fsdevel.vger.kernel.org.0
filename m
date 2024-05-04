Return-Path: <linux-fsdevel+bounces-18709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5AA8BB921
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 04:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F09B1C214D4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 02:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AEAD2D;
	Sat,  4 May 2024 02:01:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3501290F;
	Sat,  4 May 2024 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788064; cv=none; b=g9IGJQOONNwtp2qV2mNskizLQ0yvH06oT+xaqcvpdAxif9y54+tE3zqfWAqP2MyiJ33TYd9CtvqUwFaIBb0pYs49yTnBQ0KDCYVFDnsH3ibpNNU9zV2GYz9u0YA5N4SUzFRm8YzwhKsutzesgNlnpTJ8R0PMn10YgecbseTZ6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788064; c=relaxed/simple;
	bh=p/4OKG7IKVhS9/UwA2sss4ACe6shZpxAMFimTuKTqQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O0cVRhcAsD8RzW0W3BEysgFJDX9Hj4E3+yblJVQif9i/DjbvnCf5+wgJq1TWYjJYoYwUsB/rx74v8S5A+ynOB/7bdcCIYUDtMJD793rVt4NX1vPPVls0zZ8X1vFA459j0EKuJFdtV/V5AcNPTsNY1lm9ir4KJypx2BOCxlpfg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VWW5V2j5rzxNgY;
	Sat,  4 May 2024 09:57:34 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id ADEB0180021;
	Sat,  4 May 2024 10:00:55 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 10:00:54 +0800
Message-ID: <be5a48e4-c33c-1d0b-18ac-b93da89b354c@huawei.com>
Date: Sat, 4 May 2024 10:00:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] [ext4?] WARNING in mb_cache_destroy
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <tytso@mit.edu>, syzbot
	<syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, <nathan@kernel.org>, <ndesaulniers@google.com>,
	<ritesh.list@gmail.com>, <syzkaller-bugs@googlegroups.com>,
	<trix@redhat.com>, yangerkun <yangerkun@huawei.com>
References: <00000000000072c6ba06174b30b7@google.com>
 <0000000000003bf5be061751ae70@google.com>
 <20240502103341.t53u6ya7ujbzkkxo@quack3>
 <dca44ba5-5c33-05ef-d9de-21a84f9d7eaa@huawei.com>
 <20240503102328.cstcauc5qakmk2bg@quack3>
 <9209062c-fa94-33f3-fd89-834a3314c7ed@huawei.com>
 <20240503140916.zd33jcev7c6fy254@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240503140916.zd33jcev7c6fy254@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/5/3 22:09, Jan Kara wrote:
> On Fri 03-05-24 19:38:21, Baokun Li wrote:
>> On 2024/5/3 18:23, Jan Kara wrote:
>>> Hi!
>>>
>>> On Fri 03-05-24 17:51:07, Baokun Li wrote:
>>>> On 2024/5/2 18:33, Jan Kara wrote:
>>>>> On Tue 30-04-24 08:04:03, syzbot wrote:
>>>>>> syzbot has bisected this issue to:
>>>>>>
>>>>>> commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3
>>>>>> Author: Baokun Li <libaokun1@huawei.com>
>>>>>> Date:   Thu Jun 16 02:13:56 2022 +0000
>>>>>>
>>>>>>        ext4: fix use-after-free in ext4_xattr_set_entry
>>>>> So I'm not sure the bisect is correct since the change is looking harmless.
>>>> Yes, the root cause of the problem has nothing to do with this patch,
>>>> and please see the detailed analysis below.
>>>>> But it is sufficiently related that there indeed may be some relationship.
>>>>> Anyway, the kernel log has:
>>>>>
>>>>> [   44.932900][ T1063] EXT4-fs warning (device loop0): ext4_evict_inode:297: xattr delete (err -12)
>>>>> [   44.943316][ T1063] EXT4-fs (loop0): unmounting filesystem.
>>>>> [   44.949531][ T1063] ------------[ cut here ]------------
>>>>> [   44.955050][ T1063] WARNING: CPU: 0 PID: 1063 at fs/mbcache.c:409 mb_cache_destroy+0xda/0x110
>>>>>
>>>>> So ext4_xattr_delete_inode() called when removing inode has failed with
>>>>> ENOMEM and later mb_cache_destroy() was eventually complaining about having
>>>>> mbcache entry with increased refcount. So likely some error cleanup path is
>>>>> forgetting to drop mbcache entry reference somewhere but at this point I
>>>>> cannot find where. We'll likely need to play with the reproducer to debug
>>>>> that. Baokun, any chance for looking into this?
>>>>>
>>>>> 								Honza
>>>> As you guessed, when -ENOMEM is returned in ext4_sb_bread(),
>>>> the reference count of ce is not properly released, as follows.
>>>>
>>>> ext4_create
>>>>    __ext4_new_inode
>>>>     security_inode_init_security
>>>>      ext4_initxattrs
>>>>       ext4_xattr_set_handle
>>>>        ext4_xattr_block_find
>>>>        ext4_xattr_block_set
>>>>         ext4_xattr_block_cache_find
>>>>           ce = mb_cache_entry_find_first
>>>>               __entry_find
>>>>               atomic_inc_not_zero(&entry->e_refcnt)
>>>>           bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
>>>>           if (PTR_ERR(bh) == -ENOMEM)
>>>>               return NULL;
>>>>
>>>> Before merging into commit 67d7d8ad99be("ext4: fix use-after-free
>>>> in ext4_xattr_set_entry"), it will not return early in
>>>> ext4_xattr_ibody_find(),
>>>> so it tries to find it in iboy, fails the check in xattr_check_inode() and
>>>> returns without executing ext4_xattr_block_find(). Thus it will bisect
>>>> the patch, but actually has nothing to do with it.
>>>>
>>>> ext4_xattr_ibody_get
>>>>    xattr_check_inode
>>>>     __xattr_check_inode
>>>>      check_xattrs
>>>>       if (end - (void *)header < sizeof(*header) + sizeof(u32))
>>>>         "in-inode xattr block too small"
>>>>
>>>> Here's the patch in testing, I'll send it out officially after it is tested.
>>>> (PS:  I'm not sure if propagating the ext4_xattr_block_cache_find() errors
>>>> would be better.)
>>> Great! Thanks for debugging this! Some comments to your fix below:
>>>
>>>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>>>> index b67a176bfcf9..5c9e751915fd 100644
>>>> --- a/fs/ext4/xattr.c
>>>> +++ b/fs/ext4/xattr.c
>>>> @@ -3113,11 +3113,10 @@ ext4_xattr_block_cache_find(struct inode *inode,
>>>>
>>>>            bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
>>>>            if (IS_ERR(bh)) {
>>>> -            if (PTR_ERR(bh) == -ENOMEM)
>>>> -                return NULL;
>>>> +            if (PTR_ERR(bh) != -ENOMEM)
>>>> +                EXT4_ERROR_INODE(inode, "block %lu read error",
>>>> +                         (unsigned long)ce->e_value);
>>>>                bh = NULL;
>>>> -            EXT4_ERROR_INODE(inode, "block %lu read error",
>>>> -                     (unsigned long)ce->e_value);
>>>>            } else if (ext4_xattr_cmp(header, BHDR(bh)) == 0) {
>>>>                *pce = ce;
>>>>                return bh;
>>> So if we get the ENOMEM error, continuing the iteration seems to be
>>> pointless as we'll likely get it for the following entries as well. I think
>>> the original behavior of aborting the iteration in case of ENOMEM is
>>> actually better. We just have to do mb_cache_entry_put(ea_block_cache, ce)
>>> before returning...
>>>
>>> 								Honza
>> Returning NULL here would normally attempt to allocate a new
>> xattr_block in ext4_xattr_block_set(), and when ext4_sb_bread() fails,
>> allocating the new block and inserting it would most likely fail as well,
>> so my initial thought was to propagate the error from ext4_sb_bread()
>> to also make ext4_xattr_block_set() fail when ext4_sb_bread() fails.
> Yes, this would be probably even better solution.
Okay.
>
>> But I noticed that before Ted added the special handling for -ENOMEM,
>> EXT4_ERROR_INODE was called to set the ERROR_FS flag no matter
>> what error ext4_sb_bread() returned, and after we can distinguish
>> between -EIO and -ENOMEM, we don't have to set the ERROR_FS flag
>> in the case of -ENOMEM. So there's this conservative fix now.
>>
>> In short, in my personal opinion, for -EIO and -ENOMEM, they should
>> be the same except whether or not the ERROR_FS flag is set.
>> Otherwise, I think adding mb_cache_entry_put() directly is the easiest
>> and most straightforward fix.  Honza, do you have any other thoughts?
> Yeah. I'd go for adding mb_cache_entry_put() now as a quick fix and then
> work on propagating the error from ext4_xattr_block_cache_find() as a
> cleaner solution...
>
> 								Honza
>
Ok, thank you very much for the suggestion!
I'll send the quick fix out right away.

Cheers,
Baokun

