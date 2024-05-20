Return-Path: <linux-fsdevel+bounces-19734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BFF8C97E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 04:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC601F220DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 02:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99E4BA47;
	Mon, 20 May 2024 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MFkpSrBr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED9D27E;
	Mon, 20 May 2024 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171674; cv=none; b=d3ud1KI6CmwwqMO7FjWFmMGz1avUyz2bzHDLV1YpJS6KX/plAZhz5j8mTV8Hs3Pg/lJmNiS+Q+FTZbxQnr4hCsYUZGs4o0WiSee4BtAZ1muRFPrwwSkZVHIRrDsyjBmdPNz14Vh6AxqmQGPxergJGWcvV9bEDCf/qc/oE7Uv1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171674; c=relaxed/simple;
	bh=/iOGvsrjFGV63irIU6immb0EJljLXPU1vagBsVi7LVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHJ5WXN+BOjtW0w/rXjAp9kz3tIbs2tb+HeFiEiX6HbQNHq27jktnYJaf55R4Ht4FF141C08T/o9qCUvboL4me2r0P+/j6ZdCEcCsDOztiVEZw8g7DbWyPBNbkkEN22epb/a56RecOYrK2t5W7H2fsr1Waj1BQ7atwg9zrj4aiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MFkpSrBr; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716171664; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JEAxIHH4Mzu7tZcEd3SvUP+FFw/Ul2NIJxhCNffO0+0=;
	b=MFkpSrBrZRhc48OZoZkxsaOukLJDOXfom+K0gwp1Xupa065wBdq2NGWvCTkLWTPdP9KYYQ09ML5bc+KrNY5/5UydFP4xViGqpkqj/vmPoP2Y0EHWNfs6dXd+aCb5tcHDEz/cUTSEsOb7o3TNSoTcDqYLlwjPC12hWS0mh5waYiI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6kg4SN_1716171661;
Received: from 30.97.48.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6kg4SN_1716171661)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 10:21:03 +0800
Message-ID: <a440cd35-18ce-4943-b370-c92f761d9bcf@linux.alibaba.com>
Date: Mon, 20 May 2024 10:20:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] cachefiles: remove request from xarry during
 flush requests
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-2-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-2-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/15 16:45, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>


The subject line can be
"cachefiles: remove requests from xarray during flushing requests"

> 
> Even with CACHEFILES_DEAD set, we can still read the requests, so in the
> following concurrency the request may be used after it has been freed:
> 
>       mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>   cachefiles_ondemand_init_object
>    cachefiles_ondemand_send_req
>     REQ_A = kzalloc(sizeof(*req) + data_len)
>     wait_for_completion(&REQ_A->done)
>              cachefiles_daemon_read
>               cachefiles_ondemand_daemon_read
>                                    // close dev fd
>                                    cachefiles_flush_reqs
>                                     complete(&REQ_A->done)
>     kfree(REQ_A)
>                xa_lock(&cache->reqs);
>                cachefiles_ondemand_select_req
>                  req->msg.opcode != CACHEFILES_OP_READ
>                  // req use-after-free !!!
>                xa_unlock(&cache->reqs);
>                                     xa_destroy(&cache->reqs)
> 
> Hence remove requests from cache->reqs when flushing them to avoid
> accessing freed requests.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/cachefiles/daemon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..ccb7b707ea4b 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
>   	xa_for_each(xa, index, req) {
>   		req->error = -EIO;
>   		complete(&req->done);
> +		__xa_erase(xa, index);
>   	}
>   	xa_unlock(xa);
>   

