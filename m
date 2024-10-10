Return-Path: <linux-fsdevel+bounces-31508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42730997B49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 05:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02554285323
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 03:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE031917F4;
	Thu, 10 Oct 2024 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fDcQIfq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE287EADB;
	Thu, 10 Oct 2024 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531084; cv=none; b=b5k+LWOYbMJr32rEqG+Q60o5iQqTiUq2IZitCI7HvsE4yzKBE7aIRWQioUKz9JRvYX8dbvanaBX4vSKU2CEqPTtZL/DEY68LNWnCpzNF9j6ZQ6VPdZTspbDT5/c7TzNncY8fi/0q9Y61+WZxEYIsvG2ba3PNycgz1vAWKsB7ZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531084; c=relaxed/simple;
	bh=lKlY6LrzcbOuR5HpOg7+tmkpr/RbcYJrHU7j49Hg9as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhfTqCiWHE+OrV78ZSdPq7NtW5gamVUoADBA7W4CkplX2rKNeB2gfxme/Ez9FJJsKumgUSc4Ia4+j4Mqq0M0okxngxEhxxtvkG8aUWLS+pRknfzBsNMupeI4KWDGUezE/YVRNbJKaThE+HDHmpD/Mz6aUeBhgrP3dd63WG3iw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fDcQIfq4; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728531074; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wvKYRrPMNqDfmQ/O3t8Xbz15qAUDwoPYqCFME5Mo35Q=;
	b=fDcQIfq45L3wEK7lpzXP/Tj3QeNzcSv90fO4bF3gIijrU9usEzn81XjH89V/IxBsy0f6rvRXnmbwEAS3KSDrBHHvT975r9j53fPErLxskEVogBVot6nViBmJj20WDwM9YKYfQx3SoYA3Wjb3y8ViYUxXYIYClQ6Xl6Fq9pCICgs=
Received: from 30.221.129.194(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGkt5uu_1728531072)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 11:31:13 +0800
Message-ID: <15a74197-9b84-4d73-a770-8bfc2fde7742@linux.alibaba.com>
Date: Thu, 10 Oct 2024 11:31:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] netfs/cachefiles: Some bugfixes
To: Zizhi Wo <wozizhi@huawei.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, brauner@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, libaokun1@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, yukuai3@huawei.com
References: <20240821024301.1058918-1-wozizhi@huawei.com>
 <827d5f2e-d6a7-43ca-8034-5e2508d89f22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <827d5f2e-d6a7-43ca-8034-5e2508d89f22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Zizhi,

On 2024/10/10 11:08, Zizhi Wo wrote:
> Hi!
> 
> This patchset involves some general cachefiles workflows and the on-
> demand loading process. For example, the eighth patch fixes a memory
> ordering issue in cachefiles, and the fifth patch includes some cleanup.
> These all related to changes in the general cachefiles workflow, and I
> think these deserve some attention.
> 
> Additionally, although the current EROFS on-demand loading mode based on
> cachefiles interaction might be considered for switching to the fanotify
> mode in the future, I believe the code based on the current cachefiles
> on-demand loading mode still requires maintenance. The first few patches
> here are bugfixes specifically for that.

Yes, I also agree with you.  I pinged David weeks ago, because many
bugfixes are not only impacted to cachefiles on-demand feature but
also generic cachefiles, hopefully they could be addressed upstream.

Thanks,
Gao Xiang

> 
> Therefore, I would greatly appreciate it if anyone could take some time
> to review these patches. So friendly ping.
> 
> Thanks,
> Zizhi Wo
> 
> 
> 在 2024/8/21 10:42, Zizhi Wo 写道:
>> Hi!
>>
>> We recently discovered some bugs through self-discovery and testing in
>> erofs ondemand loading mode, and this patchset is mainly used to fix
>> them. These patches are relatively simple changes, and I would be excited
>> to discuss them together with everyone. Below is a brief introduction to
>> each patch:
>>
>> Patch 1: Fix for wrong block_number calculated in ondemand write.
>>
>> Patch 2: Fix for wrong length return value in ondemand write.
>>
>> Patch 3: Fix missing position update in ondemand write, for scenarios
>> involving read-ahead, invoking the write syscall.
>>
>> Patch 4: Previously, the last redundant data was cleared during the umount
>> phase. This patch remove unnecessary data in advance.
>>
>> Patch 5: Code clean up for cachefiles_commit_tmpfile().
>>
>> Patch 6: Modify error return value in cachefiles_daemon_secctx().
>>
>> Patch 7: Fix object->file Null-pointer-dereference problem.
>>
>> Patch 8: Fix for memory out of order in fscache_create_volume().
>>
>>
>> Zizhi Wo (8):
>>    cachefiles: Fix incorrect block calculations in
>>      __cachefiles_prepare_write()
>>    cachefiles: Fix incorrect length return value in
>>      cachefiles_ondemand_fd_write_iter()
>>    cachefiles: Fix missing pos updates in
>>      cachefiles_ondemand_fd_write_iter()
>>    cachefiles: Clear invalid cache data in advance
>>    cachefiles: Clean up in cachefiles_commit_tmpfile()
>>    cachefiles: Modify inappropriate error return value in
>>      cachefiles_daemon_secctx()
>>    cachefiles: Fix NULL pointer dereference in object->file
>>    netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
>>
>>   fs/cachefiles/daemon.c    |  2 +-
>>   fs/cachefiles/interface.c |  3 +++
>>   fs/cachefiles/io.c        | 10 +++++-----
>>   fs/cachefiles/namei.c     | 23 +++++++++++++----------
>>   fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
>>   fs/netfs/fscache_volume.c |  3 +--
>>   6 files changed, 52 insertions(+), 27 deletions(-)
>>


