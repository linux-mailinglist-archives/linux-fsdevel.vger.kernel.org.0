Return-Path: <linux-fsdevel+bounces-17603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69B18B008D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 06:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86D51C232DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D36143860;
	Wed, 24 Apr 2024 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ghP3DquY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960A142E69;
	Wed, 24 Apr 2024 04:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932991; cv=none; b=dgVvKymaJMR8hfYDfn/YUPH1elI7FjqkPpPmMdQJtZEdoTvCWnwgVuWDwfbBUHi1sB6Z4itPGGx41V2cmyVR7o5nZXogib0BNYwmSllaWvXW7LTn9/Afbo9Q760gNAtJMh0SJ6XJSdS02fxel0GarV9sMPio/u1SbDvmT7ychXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932991; c=relaxed/simple;
	bh=/CE1ga0bQu85DlhG1yON8BpABcc2bBmdR5TCzDeQvFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSY8+gjLc2Qg/FTwjr1dvh0wB1TLVuoh9/XkrhWFoj/dktkvGgAmiCwz4Z4Q4zGtb5dL2yw8YYZZQfOigF77Et9xk7INrkwMJqD6IIq2eLO8yJJJ4opfV946gxJ7jIRbHJ2KkDs+1y/8aCpggpPfMTzyJN/FOH8ZytrXuY9iKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ghP3DquY; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713932986; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IM9801pvB5uZHmd1rEJHc3tA7W/DHFfufzGQLjxpri4=;
	b=ghP3DquYWy/lKk3CFOb5B9MNGC/zFnrWcvDWCiNSEyLAiGYj3CLNcnIrWsjwOzQgs+LMJQzTaLHTyPYw6+XEn3R+QafhmyM2+GzdM9eg7hA/RwcWCmo3VilBgQXf7j0BrPg8sz7tBu2EK16SOeKSQ3CfvGEHV5pAfTWI7W/n4mw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5B7uD2_1713932984;
Received: from 30.97.48.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5B7uD2_1713932984)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 12:29:45 +0800
Message-ID: <de9d403c-c4ed-46c5-a572-18dc48bbd204@linux.alibaba.com>
Date: Wed, 24 Apr 2024 12:29:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] cachefiles: add missing lock protection when polling
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 jefflexu@linux.alibaba.com, linux-cachefs@redhat.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Baokun Li <libaokun1@huawei.com>
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-6-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240424033409.2735257-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Baokun,

On 2024/4/24 11:34, libaokun@huaweicloud.com wrote:
> From: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Add missing lock protection in poll routine when iterating xarray,
> otherwise:
> 
> Even with RCU read lock held, only the slot of the radix tree is
> ensured to be pinned there, while the data structure (e.g. struct
> cachefiles_req) stored in the slot has no such guarantee.  The poll
> routine will iterate the radix tree and dereference cachefiles_req
> accordingly.  Thus RCU read lock is not adequate in this case and
> spinlock is needed here.
> 
> Fixes: b817e22b2e91 ("cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I'm not sure why this patch didn't send upstream,
https://gitee.com/anolis/cloud-kernel/commit/324ecaaa10fefb0e3d94b547e3170e40b90cda1f

But since we're now working on upstreaming, so let's drop
the previous in-house review tags..

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/cachefiles/daemon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..73ed2323282a 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -365,14 +365,14 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
>   
>   	if (cachefiles_in_ondemand_mode(cache)) {
>   		if (!xa_empty(&cache->reqs)) {
> -			rcu_read_lock();
> +			xas_lock(&xas);
>   			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
>   				if (!cachefiles_ondemand_is_reopening_read(req)) {
>   					mask |= EPOLLIN;
>   					break;
>   				}
>   			}
> -			rcu_read_unlock();
> +			xas_unlock(&xas);
>   		}
>   	} else {
>   		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))

