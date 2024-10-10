Return-Path: <linux-fsdevel+bounces-31509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA55997B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 06:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1701F2383E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 04:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA0193407;
	Thu, 10 Oct 2024 04:08:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84662188A08;
	Thu, 10 Oct 2024 04:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533290; cv=none; b=lkFCybWGALCK2u3OTm5e05ikt3/qxijuCbo3wN4o5NcxOyRtIHyCDh1coGjvh5J6BNagdNAX+kMlI5dNsewJPC+i3KNmGHwJq63yXAGw5mzenphmEX2kKeuRUwRRjkFPIHA4YW5qXiGdNtjTvtrbxehO+QHmZEFhb+QLWXOcpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533290; c=relaxed/simple;
	bh=yEFQVMNS7LuFdl3Wk8HBNh7UJ7G7pNX0/RK0G8dPY5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oLA8rzhPzXCqXovHVXNAyD+4tQIkqzSJ1M1P8B0yCmblKjXCezlCRlYq/fYbyuC6XbXSxGpOhYQLrn3RCwKwa9Zd7xxl9F7LU5ARC7v/XYykHFkSNiMp5FG/96DeClwcEDk3nqAdYwJnW17mQpqUqR+707TZgCi9gmNn1Wz2D5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPGRD6w7VzyT2T;
	Thu, 10 Oct 2024 12:06:48 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FEBC18009B;
	Thu, 10 Oct 2024 12:08:06 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 12:08:04 +0800
Message-ID: <90e546b6-ee8a-436f-890b-0e73cb0b1530@huawei.com>
Date: Thu, 10 Oct 2024 12:08:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] netfs/cachefiles: Some bugfixes
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <netfs@lists.linux.dev>,
	<dhowells@redhat.com>, <jlayton@kernel.org>, <brauner@kernel.org>
CC: <jefflexu@linux.alibaba.com>, <zhujia.zj@bytedance.com>,
	<linux-erofs@lists.ozlabs.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <libaokun1@huawei.com>,
	<yangerkun@huawei.com>, <houtao1@huawei.com>, <yukuai3@huawei.com>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
 <827d5f2e-d6a7-43ca-8034-5e2508d89f22@huawei.com>
 <15a74197-9b84-4d73-a770-8bfc2fde7742@linux.alibaba.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <15a74197-9b84-4d73-a770-8bfc2fde7742@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2024/10/10 11:31, Gao Xiang 写道:
> Hi Zizhi,
> 
> On 2024/10/10 11:08, Zizhi Wo wrote:
>> Hi!
>>
>> This patchset involves some general cachefiles workflows and the on-
>> demand loading process. For example, the eighth patch fixes a memory
>> ordering issue in cachefiles, and the fifth patch includes some cleanup.
>> These all related to changes in the general cachefiles workflow, and I
>> think these deserve some attention.
>>
>> Additionally, although the current EROFS on-demand loading mode based on
>> cachefiles interaction might be considered for switching to the fanotify
>> mode in the future, I believe the code based on the current cachefiles
>> on-demand loading mode still requires maintenance. The first few patches
>> here are bugfixes specifically for that.
> 
> Yes, I also agree with you.  I pinged David weeks ago, because many
> bugfixes are not only impacted to cachefiles on-demand feature but
> also generic cachefiles, hopefully they could be addressed upstream.
> 

Thank you very much for your support and reply!

Thanks,
Zizhi Wo

> Thanks,
> Gao Xiang
>
>>
>> Therefore, I would greatly appreciate it if anyone could take some time
>> to review these patches. So friendly ping.
>>
>> Thanks,
>> Zizhi Wo
>>
>>
>> 在 2024/8/21 10:42, Zizhi Wo 写道:
>>> Hi!
>>>
>>> We recently discovered some bugs through self-discovery and testing in
>>> erofs ondemand loading mode, and this patchset is mainly used to fix
>>> them. These patches are relatively simple changes, and I would be 
>>> excited
>>> to discuss them together with everyone. Below is a brief introduction to
>>> each patch:
>>>
>>> Patch 1: Fix for wrong block_number calculated in ondemand write.
>>>
>>> Patch 2: Fix for wrong length return value in ondemand write.
>>>
>>> Patch 3: Fix missing position update in ondemand write, for scenarios
>>> involving read-ahead, invoking the write syscall.
>>>
>>> Patch 4: Previously, the last redundant data was cleared during the 
>>> umount
>>> phase. This patch remove unnecessary data in advance.
>>>
>>> Patch 5: Code clean up for cachefiles_commit_tmpfile().
>>>
>>> Patch 6: Modify error return value in cachefiles_daemon_secctx().
>>>
>>> Patch 7: Fix object->file Null-pointer-dereference problem.
>>>
>>> Patch 8: Fix for memory out of order in fscache_create_volume().
>>>
>>>
>>> Zizhi Wo (8):
>>>    cachefiles: Fix incorrect block calculations in
>>>      __cachefiles_prepare_write()
>>>    cachefiles: Fix incorrect length return value in
>>>      cachefiles_ondemand_fd_write_iter()
>>>    cachefiles: Fix missing pos updates in
>>>      cachefiles_ondemand_fd_write_iter()
>>>    cachefiles: Clear invalid cache data in advance
>>>    cachefiles: Clean up in cachefiles_commit_tmpfile()
>>>    cachefiles: Modify inappropriate error return value in
>>>      cachefiles_daemon_secctx()
>>>    cachefiles: Fix NULL pointer dereference in object->file
>>>    netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
>>>
>>>   fs/cachefiles/daemon.c    |  2 +-
>>>   fs/cachefiles/interface.c |  3 +++
>>>   fs/cachefiles/io.c        | 10 +++++-----
>>>   fs/cachefiles/namei.c     | 23 +++++++++++++----------
>>>   fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
>>>   fs/netfs/fscache_volume.c |  3 +--
>>>   6 files changed, 52 insertions(+), 27 deletions(-)
>>>
> 

