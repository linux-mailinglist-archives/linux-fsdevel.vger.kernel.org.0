Return-Path: <linux-fsdevel+bounces-22742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1836191B89D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C1EB227C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54661419B5;
	Fri, 28 Jun 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jjde3unv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A56140E29;
	Fri, 28 Jun 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560371; cv=none; b=ZQcoX/bCZ85Uy+zcoCMJbcw6mcoXtJTjeoQQqDhS9yirCaEcDQ1nvKI2KIsmv6tXJt5ueQqIscNBRGOy4HaekhGevQAnIFH6T7hoVMXKI/77UZZ959CeqJWEt2D5ognb/9N8Ng3j+TIULyMokdSRP51x2S87cSli1boIZwO1+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560371; c=relaxed/simple;
	bh=tHW0KMxF0Le+fZFdbDVVw/G/3C67/mNlFJa2G6YHrE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snVRK/qmiNQ68VJXiqb7z/tieXb9vbVwoZ2ihgPqN7QMqUJXb67Y44E3zuqVIKHbvFd/VSCbQuQM+yArDheLyic8pRCQpIAKxMeqwamEp5OEXS2cYf5snvR8AEwX24O27bH7xFUf1y9qF7+IuOOdyqjq0ghpBveLXzl1s6LOot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jjde3unv; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719560366; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BL+alWHXQ+GW6lLZJwH43dW4UHUN5EClmD0/pcFXBWQ=;
	b=Jjde3unvFIDMqkQDjk/kGfHG7aclt1j/yzhl9QaEv5cL1RTDk2txEqCRBAMnY/gP4C0dsWjZDuNcbChyfBFnxWZrt8BpoMe+/DRKi8sviPZpSwHYA4OZs/pu7xeeKJZUQL8i8T2pniDxWNOTCfxItws00OOfv9FGbBOpihFLeFc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9Pclg9_1719560365;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9Pclg9_1719560365)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 15:39:25 +0800
Message-ID: <ce6a7e15-5bea-413a-951e-b252319e1dfd@linux.alibaba.com>
Date: Fri, 28 Jun 2024 15:39:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] cachefiles: random bugfixes
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org, Christian Brauner <brauner@kernel.org>
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Baokun,

On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Hi all!
> 
> This is the third version of this patch series, in which another patch set
> is subsumed into this one to avoid confusing the two patch sets.
> (https://patchwork.kernel.org/project/linux-fsdevel/list/?series=854914)
> 
> Thank you, Jia Zhu, Gao Xiang, Jeff Layton, for the feedback in the
> previous version.
> 
> We've been testing ondemand mode for cachefiles since January, and we're
> almost done. We hit a lot of issues during the testing period, and this
> patch series fixes some of the issues. The patches have passed internal
> testing without regression.
> 
> The following is a brief overview of the patches, see the patches for
> more details.
> 
> Patch 1-2: Add fscache_try_get_volume() helper function to avoid
> fscache_volume use-after-free on cache withdrawal.
> 
> Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
> concurrency causing cachefiles_volume use-after-free.
> 
> Patch 4: Propagate error codes returned by vfs_getxattr() to avoid
> endless loops.
> 
> Patch 5-7: A read request waiting for reopen could be closed maliciously
> before the reopen worker is executing or waiting to be scheduled. So
> ondemand_object_worker() may be called after the info and object and even
> the cache have been freed and trigger use-after-free. So use
> cancel_work_sync() in cachefiles_ondemand_clean_object() to cancel the
> reopen worker or wait for it to finish. Since it makes no sense to wait
> for the daemon to complete the reopen request, to avoid this pointless
> operation blocking cancel_work_sync(), Patch 1 avoids request generation
> by the DROPPING state when the request has not been sent, and Patch 2
> flushes the requests of the current object before cancel_work_sync().
> 
> Patch 8: Cyclic allocation of msg_id to avoid msg_id reuse misleading
> the daemon to cause hung.
> 
> Patch 9: Hold xas_lock during polling to avoid dereferencing reqs causing
> use-after-free. This issue was triggered frequently in our tests, and we
> found that anolis 5.10 had fixed it. So to avoid failing the test, this
> patch is pushed upstream as well.
> 
> Comments and questions are, as always, welcome.
> Please let me know what you think.

Patch 4-9 looks good to me, and they are independent to patch 1-3
so personally I guess they could go upstream in advance.

I hope the way to fix cachefiles in patch 1-4 could be also
confirmed by David and Jeff since they relates the generic
cachefiles logic anyway.

Thanks,
Gao Xiang

> 
> Thanks,
> Baokun

