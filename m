Return-Path: <linux-fsdevel+bounces-28098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D45966E71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 03:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280D51C220D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 01:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96E224CC;
	Sat, 31 Aug 2024 01:45:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78A1C69D
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2024 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725068728; cv=none; b=K7Zot4GBkyhQDMmaYMeMZ+XuC3amUtKB3jvnY/QWGsoSlIpsEAZpimTHIrUUofoTk8XUJnN3Q8tIf1LMote3mxuIBcnXdHlNOgUO90Kvg4+wW8Vrt3l/fs2lpM9WfI6kKLufC0kXuRrFv8HdZiBC/sXbdq5vEK9PkuiUwqSKwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725068728; c=relaxed/simple;
	bh=FSsAAg1+2QrfVu1Mh2WhY+nTYrOsdvwb4w4JlpmEo9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rRcQn3IKrAjcpsrB6sR3hOSNDRww5Cp7mvgkZ1gIzxp82GjwOXsDpyH7huEKleF/IJeMza+d0mUsYdCn3+Jla1+tN2mg2KmGo1RMgRkd+t7/3m/0S7+itBJhMabHB0rKH9X31VMzDcsw2svLmMpCUJevX5LSa3SNFVrN/LR+SQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wwd4s3FldzQrFN;
	Sat, 31 Aug 2024 09:40:29 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2870614011B;
	Sat, 31 Aug 2024 09:45:22 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 31 Aug 2024 09:45:21 +0800
Message-ID: <05de6982-0f52-437b-815f-e77bd4178691@huawei.com>
Date: Sat, 31 Aug 2024 09:45:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] f2fs: new mount API conversion
Content-Language: en-US
To: Eric Sandeen <sandeen@sandeen.net>, <jaegeuk@kernel.org>,
	<chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <brauner@kernel.org>,
	<lczerner@redhat.com>, <linux-fsdevel@vger.kernel.org>
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
 <6c1baa6e-5f71-418f-a7fc-27c798e51498@huawei.com>
 <5c194e3e-6dc9-41a2-b967-13fc1177b2f4@sandeen.net>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <5c194e3e-6dc9-41a2-b967-13fc1177b2f4@sandeen.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/31 1:07, Eric Sandeen wrote:
> Just FWIW -
> 
> I had missed this thread when I got temporarily unsubscribed from fsdevel.
> I have a series that I was hacking on for this same work, at
> https://git.kernel.org/pub/scm/linux/kernel/git/sandeen/linux.git/commit/?h=f2fs-mount-api
> but it's very rough and almost certainly contains bugs. It may or may not
> be of any help to you, but just FYI.
> 
> I'll try to help review/test your series since I tried to solve this as
> well, but I never completed the work. :)

That will be great! Thank you very much!
There is still a lot of refactoring that can be done. At the time, the 
consideration was to make the smallest possible changes, so many places 
were essentially preserved. We can work together to make this better.

Thanks,
Hongbo

> 
> Thanks,
> -Eric
> 
> On 8/27/24 6:47 AM, Hongbo Li wrote:
>> Does there exist CI test for f2fs? I can only write the mount test for f2fs refer to tests/ext4/053. And I have tested this in local.
>>
>> Thanks,
>> Hongbo
>>
>> On 2024/8/14 10:39, Hongbo Li wrote:
>>> Since many filesystems have done the new mount API conversion,
>>> we introduce the new mount API conversion in f2fs.
>>>
>>> The series can be applied on top of the current mainline tree
>>> and the work is based on the patches from Lukas Czerner (has
>>> done this in ext4[1]). His patch give me a lot of ideas.
>>>
>>> Here is a high level description of the patchset:
>>>
>>> 1. Prepare the f2fs mount parameters required by the new mount
>>> API and use it for parsing, while still using the old API to
>>> get mount options string. Split the parameter parsing and
>>> validation of the parse_options helper into two separate
>>> helpers.
>>>
>>>     f2fs: Add fs parameter specifications for mount options
>>>     f2fs: move the option parser into handle_mount_opt
>>>     f2fs: move option validation into a separate helper
>>>
>>> 2. Remove the use of sb/sbi structure of f2fs from all the
>>> parsing code, because with the new mount API the parsing is
>>> going to be done before we even get the super block. In this
>>> part, we introduce f2fs_fs_context to hold the temporary
>>> options when parsing. For the simple options check, it has
>>> to be done during parsing by using f2fs_fs_context structure.
>>> For the check which needs sb/sbi, we do this during super
>>> block filling.
>>>
>>>     f2fs: Allow sbi to be NULL in f2fs_printk
>>>     f2fs: Add f2fs_fs_context to record the mount options
>>>     f2fs: separate the options parsing and options checking
>>>
>>> 3. Switch the f2fs to use the new mount API for mount and
>>> remount.
>>>
>>>     f2fs: introduce fs_context_operation structure
>>>     f2fs: switch to the new mount api
>>>
>>> 4. Cleanup the old unused structures and helpers.
>>>
>>>     f2fs: remove unused structure and functions
>>>
>>> There is still a potential to do some cleanups and perhaps
>>> refactoring. However that can be done later after the conversion
>>> to the new mount API which is the main purpose of the patchset.
>>>
>>> [1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/
>>>
>>> Hongbo Li (9):
>>>     f2fs: Add fs parameter specifications for mount options
>>>     f2fs: move the option parser into handle_mount_opt
>>>     f2fs: move option validation into a separate helper
>>>     f2fs: Allow sbi to be NULL in f2fs_printk
>>>     f2fs: Add f2fs_fs_context to record the mount options
>>>     f2fs: separate the options parsing and options checking
>>>     f2fs: introduce fs_context_operation structure
>>>     f2fs: switch to the new mount api
>>>     f2fs: remove unused structure and functions
>>>
>>>    fs/f2fs/super.c | 2211 ++++++++++++++++++++++++++++-------------------
>>>    1 file changed, 1341 insertions(+), 870 deletions(-)
>>>
>>
> 

