Return-Path: <linux-fsdevel+bounces-31506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F62997B18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 05:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95619B248F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 03:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE918C03D;
	Thu, 10 Oct 2024 03:08:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBB188A08;
	Thu, 10 Oct 2024 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529718; cv=none; b=KL3IsWpGIpGcZ2GNKTfMjcGJIN2ULxw2edQSw3dPMD6uGOfeE7gaUlYZK5LGBGa08Tw/Y6Dp1rP8qHBuiv/0161B5PobCJ3e1a8RS7vttcxiN6FhrC+j3xesWXg0FJl4iotCZzwwvprkVf6ilOBpliMNgUfVHmj7WR39WPUfTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529718; c=relaxed/simple;
	bh=Lxfp7RU/RhZnU5IWgrLQzC+0QltIKYSvJmjwzgbPXbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f9gbrHql/0sPjHS5GUtv2e14OEZabN77I8+uq9xn7QOnZzst76lOo0cGyQ9J+7i1pGfHfd0I4qR+wxp+vpN2defZ4LAUA3Lrq2FibgAqvL0GCFFV6l/lrQM/EHaeZfyUzOu3P+n6gUTuCC1ieKBBVjr4qVX3lvTaxTtjPypS/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPF3G00dnz1HK3D;
	Thu, 10 Oct 2024 11:04:25 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E027140392;
	Thu, 10 Oct 2024 11:08:32 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 11:08:31 +0800
Message-ID: <827d5f2e-d6a7-43ca-8034-5e2508d89f22@huawei.com>
Date: Thu, 10 Oct 2024 11:08:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] netfs/cachefiles: Some bugfixes
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<libaokun1@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>
References: <20240821024301.1058918-1-wozizhi@huawei.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20240821024301.1058918-1-wozizhi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)

Hi!

This patchset involves some general cachefiles workflows and the on-
demand loading process. For example, the eighth patch fixes a memory
ordering issue in cachefiles, and the fifth patch includes some cleanup.
These all related to changes in the general cachefiles workflow, and I
think these deserve some attention.

Additionally, although the current EROFS on-demand loading mode based on
cachefiles interaction might be considered for switching to the fanotify
mode in the future, I believe the code based on the current cachefiles
on-demand loading mode still requires maintenance. The first few patches
here are bugfixes specifically for that.

Therefore, I would greatly appreciate it if anyone could take some time
to review these patches. So friendly ping.

Thanks,
Zizhi Wo


在 2024/8/21 10:42, Zizhi Wo 写道:
> Hi!
> 
> We recently discovered some bugs through self-discovery and testing in
> erofs ondemand loading mode, and this patchset is mainly used to fix
> them. These patches are relatively simple changes, and I would be excited
> to discuss them together with everyone. Below is a brief introduction to
> each patch:
> 
> Patch 1: Fix for wrong block_number calculated in ondemand write.
> 
> Patch 2: Fix for wrong length return value in ondemand write.
> 
> Patch 3: Fix missing position update in ondemand write, for scenarios
> involving read-ahead, invoking the write syscall.
> 
> Patch 4: Previously, the last redundant data was cleared during the umount
> phase. This patch remove unnecessary data in advance.
> 
> Patch 5: Code clean up for cachefiles_commit_tmpfile().
> 
> Patch 6: Modify error return value in cachefiles_daemon_secctx().
> 
> Patch 7: Fix object->file Null-pointer-dereference problem.
> 
> Patch 8: Fix for memory out of order in fscache_create_volume().
> 
> 
> Zizhi Wo (8):
>    cachefiles: Fix incorrect block calculations in
>      __cachefiles_prepare_write()
>    cachefiles: Fix incorrect length return value in
>      cachefiles_ondemand_fd_write_iter()
>    cachefiles: Fix missing pos updates in
>      cachefiles_ondemand_fd_write_iter()
>    cachefiles: Clear invalid cache data in advance
>    cachefiles: Clean up in cachefiles_commit_tmpfile()
>    cachefiles: Modify inappropriate error return value in
>      cachefiles_daemon_secctx()
>    cachefiles: Fix NULL pointer dereference in object->file
>    netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
> 
>   fs/cachefiles/daemon.c    |  2 +-
>   fs/cachefiles/interface.c |  3 +++
>   fs/cachefiles/io.c        | 10 +++++-----
>   fs/cachefiles/namei.c     | 23 +++++++++++++----------
>   fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
>   fs/netfs/fscache_volume.c |  3 +--
>   6 files changed, 52 insertions(+), 27 deletions(-)
> 

