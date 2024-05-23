Return-Path: <linux-fsdevel+bounces-20059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11C8CD5BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20FFB20B75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112614BF92;
	Thu, 23 May 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pqlvxgCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784813DBA0;
	Thu, 23 May 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474535; cv=none; b=qswdAMVKmGstkZkWe8821x82ZKln7AiC/rEQWlxtpoACUu1Zr6qMMXFOzUs1nVX7rEzryV0teXHMbNL7iJNcBViYUol3w3nXbd4BhC3hodDRiBmrMMpURLrSTtdCxHP5RWbEhX/oVNTPJF7WLGlucOxhZqrUTVk+S6qrwpaX1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474535; c=relaxed/simple;
	bh=YRzIZV+8IYLn+F4nAiVNJuRhYPZ1yBzoJnVmLoTmfFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcO9x1cUlRjH0/gzvTBB9uZy8iTaHe8by9mftFgNl4jc3mBUZjLGRkenSt/pZtuk0i+Vvt7zrdQOpFfIzTWMFm45I1MFSnc6TyZoJPDUmwjTxaQJD8pM6fc3YFZ1xMcfIMV+bi5Sq+CyMSvr1aabMC5dZUHNPflTtDo+h03dle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pqlvxgCI; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716474523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9wPJMsA7uUhGJBy9UQb2/zbE2MRvDozVPDCHZoma3hs=;
	b=pqlvxgCIOI5o9dB3XK5gyt1UAyhflc3P2qlqzJRGsSBghtHe9YD/DfvD4Mmwk+0Q4uOj6dJ0SnxpzQ6ANrV6TrWYXHwpm2E7HFkNAwMi+DToyV3pZV/YGlHodpWmJh4Up3ManIdoarILHggZYdSvQOImrZKM6lOzsPGrT3YPBZQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W739OVi_1716474521;
Received: from 30.39.171.189(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W739OVi_1716474521)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 22:28:43 +0800
Message-ID: <11f10862-9149-49c7-bac4-f0c1e0601b23@linux.alibaba.com>
Date: Thu, 23 May 2024 22:28:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] cachefiles: add consistency check for
 copen/cread
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240522114308.2402121-7-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240522114308.2402121-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/24 7:43 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This prevents malicious processes from completing random copen/cread
> requests and crashing the system. Added checks are listed below:
> 
>   * Generic, copen can only complete open requests, and cread can only
>     complete read requests.
>   * For copen, ondemand_id must not be 0, because this indicates that the
>     request has not been read by the daemon.
>   * For cread, the object corresponding to fd and req should be the same.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/cachefiles/ondemand.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index bb94ef6a6f61..898fab68332b 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -82,12 +82,12 @@ static loff_t cachefiles_ondemand_fd_llseek(struct file *filp, loff_t pos,
>  }
>  
>  static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
> -					 unsigned long arg)
> +					 unsigned long id)
>  {
>  	struct cachefiles_object *object = filp->private_data;
>  	struct cachefiles_cache *cache = object->volume->cache;
>  	struct cachefiles_req *req;
> -	unsigned long id;
> +	XA_STATE(xas, &cache->reqs, id);
>  
>  	if (ioctl != CACHEFILES_IOC_READ_COMPLETE)
>  		return -EINVAL;
> @@ -95,10 +95,15 @@ static long cachefiles_ondemand_fd_ioctl(struct file *filp, unsigned int ioctl,
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return -EOPNOTSUPP;
>  
> -	id = arg;
> -	req = xa_erase(&cache->reqs, id);
> -	if (!req)
> +	xa_lock(&cache->reqs);
> +	req = xas_load(&xas);
> +	if (!req || req->msg.opcode != CACHEFILES_OP_READ ||
> +	    req->object != object) {
> +		xa_unlock(&cache->reqs);
>  		return -EINVAL;
> +	}
> +	xas_store(&xas, NULL);
> +	xa_unlock(&cache->reqs);
>  
>  	trace_cachefiles_ondemand_cread(object, id);
>  	complete(&req->done);
> @@ -126,6 +131,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	unsigned long id;
>  	long size;
>  	int ret;
> +	XA_STATE(xas, &cache->reqs, 0);
>  
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return -EOPNOTSUPP;
> @@ -149,9 +155,16 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	if (ret)
>  		return ret;
>  
> -	req = xa_erase(&cache->reqs, id);
> -	if (!req)
> +	xa_lock(&cache->reqs);
> +	xas.xa_index = id;
> +	req = xas_load(&xas);
> +	if (!req || req->msg.opcode != CACHEFILES_OP_OPEN ||
> +	    !req->object->ondemand->ondemand_id) {

For a valid opened object, I think ondemand_id shall > 0.  When the
copen is for the object which is in the reopening state, ondemand_id can
be CACHEFILES_ONDEMAND_ID_CLOSED (actually -1)?

Otherwise looks good to me.


-- 
Thanks,
Jingbo

