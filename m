Return-Path: <linux-fsdevel+bounces-11940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44E85945A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 04:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3AD283484
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 03:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A8184F;
	Sun, 18 Feb 2024 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sZvhASvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAC15C0;
	Sun, 18 Feb 2024 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226457; cv=none; b=CnvO8MuqdpEoo5v0cRwR70pVAwFrQiu04sGBBtly/5/QSNr9X7AXMpthAnN9rp6rXi2wdercs0ulctwhgG/l0PUkHKa8Uxqm1L1rvky75D+yJMjm7+wiRdZN9fIASg+lCTniSvqsdmAkyYbi5PKHK/Rh6SxXdBvn9pBn+Lh6X8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226457; c=relaxed/simple;
	bh=XfZHq5PLl/gGIAJY4T+e1XbJYYy90SoHG1cHEE8y4og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MW+wEaIc6NZbY5xwmVxSukT8ojTOME1W0Ii5UtCAsK3vGDXuvdPtEwTsI0UspdTHFWr73AKo1jbK/iSGbh6ZgjQ4mGF5gDTkhxXxNG3a0uEjjfppunQgYJ6J7FYexWNHmyVQ3BuUqNLiyBb/vLuX2LQ1wU2WQ9DUuZ28byCx1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sZvhASvT; arc=none smtp.client-ip=47.90.199.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708226435; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cqOsry37fOCW6Y3ou1nZ7EHlwm2eSJbNTtcAmfAvy8w=;
	b=sZvhASvTaT1ZXVmRBexej/rFkeiSqwgKJhwU1CPYYXxwc2q7ZVDJTp2zLEiulOQ0Y18Bci8pELb2fYWQ4YGjqfZg8Eh/YoaYbX4ZP/0JG/qRIG/ec0suw5t4WF+G/DTKqPqaLF11G4qrWTbzERdaM7E0dJHiEnWfvt/iRIgo8xs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W0kSJnS_1708226113;
Received: from 30.221.145.138(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W0kSJnS_1708226113)
          by smtp.aliyun-inc.com;
          Sun, 18 Feb 2024 11:15:13 +0800
Message-ID: <cee45d07-b885-4b4b-b9b5-d7aeedc2b2e7@linux.alibaba.com>
Date: Sun, 18 Feb 2024 11:15:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] cachefiles: fix memory leak in
 cachefiles_add_cache()
To: Baokun Li <libaokun1@huawei.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240217081431.796809-1-libaokun1@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240217081431.796809-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/24 4:14 PM, Baokun Li wrote:
> The following memory leak was reported after unbinding /dev/cachefiles:
> 
> ==================================================================
> unreferenced object 0xffff9b674176e3c0 (size 192):
>   comm "cachefilesd2", pid 680, jiffies 4294881224
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc ea38a44b):
>     [<ffffffff8eb8a1a5>] kmem_cache_alloc+0x2d5/0x370
>     [<ffffffff8e917f86>] prepare_creds+0x26/0x2e0
>     [<ffffffffc002eeef>] cachefiles_determine_cache_security+0x1f/0x120
>     [<ffffffffc00243ec>] cachefiles_add_cache+0x13c/0x3a0
>     [<ffffffffc0025216>] cachefiles_daemon_write+0x146/0x1c0
>     [<ffffffff8ebc4a3b>] vfs_write+0xcb/0x520
>     [<ffffffff8ebc5069>] ksys_write+0x69/0xf0
>     [<ffffffff8f6d4662>] do_syscall_64+0x72/0x140
>     [<ffffffff8f8000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> ==================================================================
> 
> Put the reference count of cache_cred in cachefiles_daemon_unbind() to
> fix the problem. And also put cache_cred in cachefiles_add_cache() error
> branch to avoid memory leaks.
> 
> Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/cachefiles/cache.c  | 2 ++
>  fs/cachefiles/daemon.c | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
> index 7077f72e6f47..f449f7340aad 100644
> --- a/fs/cachefiles/cache.c
> +++ b/fs/cachefiles/cache.c
> @@ -168,6 +168,8 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
>  	dput(root);
>  error_open_root:
>  	cachefiles_end_secure(cache, saved_cred);
> +	put_cred(cache->cache_cred);
> +	cache->cache_cred = NULL;
>  error_getsec:
>  	fscache_relinquish_cache(cache_cookie);
>  	cache->cache = NULL;
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 3f24905f4066..6465e2574230 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -816,6 +816,7 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
>  	cachefiles_put_directory(cache->graveyard);
>  	cachefiles_put_directory(cache->store);
>  	mntput(cache->mnt);
> +	put_cred(cache->cache_cred);
>  
>  	kfree(cache->rootdirname);
>  	kfree(cache->secctx);

-- 
Thanks,
Jingbo

