Return-Path: <linux-fsdevel+bounces-19752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799178C9961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D741F21A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0D18EA8;
	Mon, 20 May 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fL5JIaS3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800E18C3B;
	Mon, 20 May 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190609; cv=none; b=ZjI7Z/S79wHhAUVzPaCSqQQ9Q3vmhNePThAYKsK0ItYXsHGRKBzc1Vy0lvZtQ7rzfXysCTa3qT4cXuJl3ZxpHf+BR95i5nrvQJY2peNAUPHddLf4m1LFFJRCK4DcOIukIFfP/1IjZybbnzNICq4H3Esul0AACHBbn0Tl+Bq4Hs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190609; c=relaxed/simple;
	bh=/9O/iuoU1hbs2fn3JIo7FuAozBRS9Xx4kKlyEmiJpWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGx4dp3ppatsr2L4tE2ac1acPN4HwCNUAqdHa7X4O1Xz6LBZ9iD5RlrMCysA45JCSRxRja4Exvd1lTKdxmUb9FCNhRhe5DpKyOF7DTQEEQZH8F/JrHzXa5kGA0wJVT2oZNoE7X4YpuY6ZkB1TPe3fPDf67pj/BoYWDdyePNF9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fL5JIaS3; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716190597; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y4VyW6RT9bxLxNrdTlih7hQvvkEMAoIZw9HLmgrPep4=;
	b=fL5JIaS3F6RKBcrxOgK1UYhEXzMznRwoyTskXfEna2KNqNYwj6f49+f58Z9VuG36TbcGmtImg4Q78vK3Vn8jGC8ztjtq/dobIorteWBNUvT2H4lyBqd899OU39XGyx9WJW2blYA4SMitOlecjyeA5H7dpVBjSazUltWTi6Y64e8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6nxons_1716190595;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6nxons_1716190595)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 15:36:36 +0800
Message-ID: <a4cb6b6b-0105-4ba5-b43d-662ef96fbec6@linux.alibaba.com>
Date: Mon, 20 May 2024 15:36:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-5-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-5-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We got the following issue in a fuzz test of randomly issuing the restore
> command:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0xb41/0xb60
> Read of size 8 at addr ffff888122e84088 by task ondemand-04-dae/963
> 
> CPU: 13 PID: 963 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #564
> Call Trace:
>  kasan_report+0x93/0xc0
>  cachefiles_ondemand_daemon_read+0xb41/0xb60
>  vfs_read+0x169/0xb50
>  ksys_read+0xf5/0x1e0
> 
> Allocated by task 116:
>  kmem_cache_alloc+0x140/0x3a0
>  cachefiles_lookup_cookie+0x140/0xcd0
>  fscache_cookie_state_machine+0x43c/0x1230
>  [...]
> 
> Freed by task 792:
>  kmem_cache_free+0xfe/0x390
>  cachefiles_put_object+0x241/0x480
>  fscache_cookie_state_machine+0x5c8/0x1230
>  [...]
> ==================================================================
> 
> Following is the process that triggers the issue:
> 
>      mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
> cachefiles_withdraw_cookie
>  cachefiles_ondemand_clean_object(object)
>   cachefiles_ondemand_send_req
>    REQ_A = kzalloc(sizeof(*req) + data_len)
>    wait_for_completion(&REQ_A->done)
> 
>             cachefiles_daemon_read
>              cachefiles_ondemand_daemon_read
>               REQ_A = cachefiles_ondemand_select_req
>               msg->object_id = req->object->ondemand->ondemand_id
>                                   ------ restore ------
>                                   cachefiles_ondemand_restore
>                                   xas_for_each(&xas, req, ULONG_MAX)
>                                    xas_set_mark(&xas, CACHEFILES_REQ_NEW)
> 
>                                   cachefiles_daemon_read
>                                    cachefiles_ondemand_daemon_read
>                                     REQ_A = cachefiles_ondemand_select_req
>               copy_to_user(_buffer, msg, n)
>                xa_erase(&cache->reqs, id)
>                complete(&REQ_A->done)
>               ------ close(fd) ------
>               cachefiles_ondemand_fd_release
>                cachefiles_put_object
>  cachefiles_put_object
>   kmem_cache_free(cachefiles_object_jar, object)
>                                     REQ_A->object->ondemand->ondemand_id
>                                      // object UAF !!!
> 
> When we see the request within xa_lock, req->object must not have been
> freed yet, so grab the reference count of object before xa_unlock to
> avoid the above issue.
> 
> Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/cachefiles/ondemand.c          | 2 ++
>  include/trace/events/cachefiles.h | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 56d12fe4bf73..bb94ef6a6f61 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -336,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>  	cache->req_id_next = xas.xa_index + 1;
>  	refcount_inc(&req->ref);
> +	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
>  	xa_unlock(&cache->reqs);
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
> @@ -355,6 +356,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  			close_fd(((struct cachefiles_open *)msg->data)->fd);
>  	}
>  out:
> +	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
>  	/* Remove error request and CLOSE request has no reply */
>  	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
>  		xas_reset(&xas);
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
> index cf4b98b9a9ed..119a823fb5a0 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -33,6 +33,8 @@ enum cachefiles_obj_ref_trace {
>  	cachefiles_obj_see_withdrawal,
>  	cachefiles_obj_get_ondemand_fd,
>  	cachefiles_obj_put_ondemand_fd,
> +	cachefiles_obj_get_read_req,
> +	cachefiles_obj_put_read_req,

How about cachefiles_obj_[get|put]_ondemand_read, so that it could be
easily identified as ondemand mode at the first glance?

>  };
>  
>  enum fscache_why_object_killed {
> @@ -127,7 +129,9 @@ enum cachefiles_error_trace {
>  	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
>  	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
>  	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
> -	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
> +	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
> +	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
> +	E_(cachefiles_obj_put_read_req,		"PUT read_req")

Ditto.


Otherwise, LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

