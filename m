Return-Path: <linux-fsdevel+bounces-25502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CE94CA65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 08:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DACB20E7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 06:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5416D30B;
	Fri,  9 Aug 2024 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V0GFKljp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED516D304
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184549; cv=none; b=Fe5ZlH8Xkw2Eff9+AXW+tgCtWBg5a81qZSfPcXt/na5f7IMKoM/swGA+me6ksbHhKNR/dN1CBc/23nshkYVlUOrsWxaWkERQp9h2YazxFM64KZw8vn5SYj/Nm364RJURjXZqK0JE3dnwXqK0IOasYgTitjpbif7hqJ1DUtYqSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184549; c=relaxed/simple;
	bh=UgUuWd0qWzb36ND/i8/QltMosW8bO2ptFfLUkxgqZrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+ftVa+Z614MaR2Fa+t2XfxikfeUuSmy32B1jlXWnZ2z5iGcHvKPY8AW45Hxlb1QddgWdVAlm1jzGZVHhyxM3FNYbXjNQwfNQZO1pzj/pjnlc1FJA9WX4raL/ic7UIBykmXqD3t+NtOZ7yKvCZ0QxOdYK5thuzF82jH/TLLyUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V0GFKljp; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723184542; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aN3KP31OsnFkOv0fYrCS0K4TEBD8eGgscS6eUgCwKcA=;
	b=V0GFKljpFYuBGyFEb/b8nVQJPRnM+DoxL5w6IcutUQHEXKfkHnPDrCUm7Lv5A/nHMI9W0NvF7Yn5fCDHNEIdVhvHEocbk2Xvrr5BGi4N/RDwSlgQhw03YDnohWQBzgdBTd1saYKJPzB1VtIsPlVz0G89FO6VGFH+5tdO8F50/mo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WCOu4Qi_1723184540;
Received: from 30.221.146.182(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WCOu4Qi_1723184540)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 14:22:21 +0800
Message-ID: <8d28f744-0f14-4cad-9b51-30dec0fec692@linux.alibaba.com>
Date: Fri, 9 Aug 2024 14:22:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-2-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240808190110.3188039-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/9/24 3:01 AM, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
> 
> This commit adds a timeout option (in seconds) for requests. If the
> timeout elapses before the server replies to the request, the request
> will fail with -ETIME.
> 
> There are 3 possibilities for a request that times out:
> a) The request times out before the request has been sent to userspace
> b) The request times out after the request has been sent to userspace
> and before it receives a reply from the server
> c) The request times out after the request has been sent to userspace
> and the server replies while the kernel is timing out the request
> 
> While a request timeout is being handled, there may be other handlers
> running at the same time if:
> a) the kernel is forwarding the request to the server
> b) the kernel is processing the server's reply to the request
> c) the request is being re-sent
> d) the connection is aborting
> e) the device is getting released
> 
> Proper synchronization must be added to ensure that the request is
> handled correctly in all of these cases. To this effect, there is a new
> FR_FINISHING bit added to the request flags, which is set atomically by
> either the timeout handler (see fuse_request_timeout()) which is invoked
> after the request timeout elapses or set by the request reply handler
> (see dev_do_write()), whichever gets there first. If the reply handler
> and the timeout handler are executing simultaneously and the reply handler
> sets FR_FINISHING before the timeout handler, then the request will be
> handled as if the timeout did not elapse. If the timeout handler sets
> FR_FINISHING before the reply handler, then the request will fail with
> -ETIME and the request will be cleaned up.
> 
> Currently, this is the refcount lifecycle of a request:
> 
> Synchronous request is created:
> fuse_simple_request -> allocates request, sets refcount to 1
>   __fuse_request_send -> acquires refcount
>     queues request and waits for reply...
> fuse_simple_request -> drops refcount
> 
> Background request is created:
> fuse_simple_background -> allocates request, sets refcount to 1
> 
> Request is replied to:
> fuse_dev_do_write
>   fuse_request_end -> drops refcount on request
> 
> Proper acquires on the request reference must be added to ensure that the
> timeout handler does not drop the last refcount on the request while
> other handlers may be operating on the request. Please note that the
> timeout handler may get invoked at any phase of the request's
> lifetime (eg before the request has been forwarded to userspace, etc).
> 
> It is always guaranteed that there is a refcount on the request when the
> timeout handler is executing. The timeout handler will be either
> deactivated by the reply/abort/release handlers, or if the timeout
> handler is concurrently executing on another CPU, the reply/abort/release
> handlers will wait for the timeout handler to finish executing first before
> it drops the final refcount on the request.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c    | 197 +++++++++++++++++++++++++++++++++++++++++++++--
>  fs/fuse/fuse_i.h |  14 ++++
>  fs/fuse/inode.c  |   7 ++
>  3 files changed, 210 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9eb191b5c4de..bcb9ff2156c0 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
>  
>  static struct kmem_cache *fuse_req_cachep;
>  
> +static void fuse_request_timeout(struct timer_list *timer);
> +
>  static struct fuse_dev *fuse_get_dev(struct file *file)
>  {
>  	/*
> @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>  	refcount_set(&req->count, 1);
>  	__set_bit(FR_PENDING, &req->flags);
>  	req->fm = fm;
> +	if (fm->fc->req_timeout)
> +		timer_setup(&req->timer, fuse_request_timeout, 0);
>  }
>  
>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
> @@ -277,7 +281,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
>   * the 'end' callback is called if given, else the reference to the
>   * request is released
>   */
> -void fuse_request_end(struct fuse_req *req)
> +static void do_fuse_request_end(struct fuse_req *req)
>  {
>  	struct fuse_mount *fm = req->fm;
>  	struct fuse_conn *fc = fm->fc;
> @@ -296,8 +300,6 @@ void fuse_request_end(struct fuse_req *req)
>  		list_del_init(&req->intr_entry);
>  		spin_unlock(&fiq->lock);
>  	}
> -	WARN_ON(test_bit(FR_PENDING, &req->flags));
> -	WARN_ON(test_bit(FR_SENT, &req->flags));
>  	if (test_bit(FR_BACKGROUND, &req->flags)) {
>  		spin_lock(&fc->bg_lock);
>  		clear_bit(FR_BACKGROUND, &req->flags);
> @@ -329,8 +331,104 @@ void fuse_request_end(struct fuse_req *req)
>  put_request:
>  	fuse_put_request(req);
>  }
> +
> +void fuse_request_end(struct fuse_req *req)
> +{
> +	WARN_ON(test_bit(FR_PENDING, &req->flags));
> +	WARN_ON(test_bit(FR_SENT, &req->flags));
> +
> +	if (req->timer.function)
> +		timer_delete_sync(&req->timer);
> +
> +	do_fuse_request_end(req);
> +}
>  EXPORT_SYMBOL_GPL(fuse_request_end);
>  
> +static void timeout_inflight_req(struct fuse_req *req)
> +{
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_pqueue *fpq;
> +
> +	spin_lock(&fiq->lock);
> +	fpq = req->fpq;
> +	spin_unlock(&fiq->lock);
> +
> +	/*
> +	 * If fpq has not been set yet, then the request is aborting (which
> +	 * clears FR_PENDING flag) before dev_do_read (which sets req->fpq)
> +	 * has been called. Let the abort handler handle this request.
> +	 */
> +	if (!fpq)
> +		return;
> +
> +	spin_lock(&fpq->lock);
> +	if (!fpq->connected || req->out.h.error == -ECONNABORTED) {
> +		/*
> +		 * Connection is being aborted or the fuse_dev is being released.
> +		 * The abort / release will clean up the request
> +		 */
> +		spin_unlock(&fpq->lock);
> +		return;
> +	}
> +
> +	if (!test_bit(FR_PRIVATE, &req->flags))
> +		list_del_init(&req->list);
> +
> +	spin_unlock(&fpq->lock);
> +
> +	req->out.h.error = -ETIME;
> +
> +	do_fuse_request_end(req);
> +}
> +
> +static void timeout_pending_req(struct fuse_req *req)
> +{
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	bool background = test_bit(FR_BACKGROUND, &req->flags);
> +
> +	if (background)
> +		spin_lock(&fc->bg_lock);
> +	spin_lock(&fiq->lock);
> +
> +	if (!test_bit(FR_PENDING, &req->flags)) {
> +		spin_unlock(&fiq->lock);
> +		if (background)
> +			spin_unlock(&fc->bg_lock);
> +		timeout_inflight_req(req);
> +		return;
> +	}
> +
> +	if (!test_bit(FR_PRIVATE, &req->flags))
> +		list_del_init(&req->list);
> +
> +	spin_unlock(&fiq->lock);
> +	if (background)
> +		spin_unlock(&fc->bg_lock);
> +
> +	req->out.h.error = -ETIME;
> +
> +	do_fuse_request_end(req);
> +}
> +
> +static void fuse_request_timeout(struct timer_list *timer)
> +{
> +	struct fuse_req *req = container_of(timer, struct fuse_req, timer);
> +
> +	/*
> +	 * Request reply is being finished by the kernel right now.
> +	 * No need to time out the request.
> +	 */
> +	if (test_and_set_bit(FR_FINISHING, &req->flags))
> +		return;
> +
> +	if (test_bit(FR_PENDING, &req->flags))
> +		timeout_pending_req(req);
> +	else
> +		timeout_inflight_req(req);
> +}
> +
>  static int queue_interrupt(struct fuse_req *req)
>  {
>  	struct fuse_iqueue *fiq = &req->fm->fc->iq;
> @@ -393,6 +491,11 @@ static void request_wait_answer(struct fuse_req *req)
>  		if (test_bit(FR_PENDING, &req->flags)) {
>  			list_del(&req->list);
>  			spin_unlock(&fiq->lock);
> +			if (req->timer.function) {
> +				bool timed_out = !timer_delete_sync(&req->timer);
> +				if (timed_out)
> +					return;
> +			}
>  			__fuse_put_request(req);
>  			req->out.h.error = -EINTR;
>  			return;
> @@ -409,7 +512,8 @@ static void request_wait_answer(struct fuse_req *req)
>  
>  static void __fuse_request_send(struct fuse_req *req)
>  {
> -	struct fuse_iqueue *fiq = &req->fm->fc->iq;
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
>  
>  	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
>  	spin_lock(&fiq->lock);
> @@ -421,6 +525,10 @@ static void __fuse_request_send(struct fuse_req *req)
>  		/* acquire extra reference, since request is still needed
>  		   after fuse_request_end() */
>  		__fuse_get_request(req);
> +		if (req->timer.function) {
> +			req->timer.expires = jiffies + fc->req_timeout;
> +			add_timer(&req->timer);
> +		}
>  		queue_request_and_unlock(fiq, req);
>  
>  		request_wait_answer(req);
> @@ -539,6 +647,10 @@ static bool fuse_request_queue_background(struct fuse_req *req)
>  		if (fc->num_background == fc->max_background)
>  			fc->blocked = 1;
>  		list_add_tail(&req->list, &fc->bg_queue);
> +		if (req->timer.function) {
> +			req->timer.expires = jiffies + fc->req_timeout;
> +			add_timer(&req->timer);
> +		}
>  		flush_bg_queue(fc);
>  		queued = true;
>  	}
> @@ -594,6 +706,10 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
>  
>  	spin_lock(&fiq->lock);
>  	if (fiq->connected) {
> +		if (req->timer.function) {
> +			req->timer.expires = jiffies + fm->fc->req_timeout;
> +			add_timer(&req->timer);
> +		}
>  		queue_request_and_unlock(fiq, req);
>  	} else {
>  		err = -ENODEV;
> @@ -1268,8 +1384,26 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  	req = list_entry(fiq->pending.next, struct fuse_req, list);
>  	clear_bit(FR_PENDING, &req->flags);
>  	list_del_init(&req->list);
> +	/* Acquire a reference in case the timeout handler starts executing */
> +	__fuse_get_request(req);
> +	req->fpq = fpq;
>  	spin_unlock(&fiq->lock);
>  
> +	if (req->timer.function) {
> +		/*
> +		 * Temporarily disable the timer on the request to avoid race
> +		 * conditions between this code and the timeout handler.
> +		 *
> +		 * The timer is readded at the end of this function.
> +		 */
> +		bool timed_out = !timer_delete_sync(&req->timer);
> +		if (timed_out) {
> +			WARN_ON(!test_bit(FR_FINISHED, &req->flags));

Is there any possibility that FR_FINISHED bit has not been set for the
request when the timeout handler finishes, e.g. for the following sequence?


```
# read			# timer handler		#aborting
fuse_dev_do_read
  spin_lock(&fiq->lock)
  # remove req from
  # pending list
  spin_unlock(&fiq->lock)

						fuse_abort_conn
						  spin_lock(fpq->lock)
						  fpq->connected = 0
						  spin_unlock(fpq->lock)

			fuse_request_timeout
  # disarm the timer
    # wait for
    # timer handler
			  timeout_inflight_req
			    spin_lock(&fpq->lock)
			    if !fpq->connected:
			      spin_unlock(&fpq->lock)
			      return
  WARN(no FR_FINISHED)!
						  end_requests
						    set FR_FINISHED bit
```




> +			fuse_put_request(req);
> +			goto restart;
> +		}
> +	}
> +
>  	args = req->args;
>  	reqsize = req->in.h.len;
>  
> @@ -1280,6 +1414,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  		if (args->opcode == FUSE_SETXATTR)
>  			req->out.h.error = -E2BIG;
>  		fuse_request_end(req);
> +		fuse_put_request(req);
>  		goto restart;
>  	}
>  	spin_lock(&fpq->lock);
> @@ -1316,13 +1451,18 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  	}
>  	hash = fuse_req_hash(req->in.h.unique);
>  	list_move_tail(&req->list, &fpq->processing[hash]);
> -	__fuse_get_request(req);
>  	set_bit(FR_SENT, &req->flags);
> +
> +	/* re-arm the original timer */
> +	if (req->timer.function)
> +		add_timer(&req->timer);
> +
>  	spin_unlock(&fpq->lock);
>  	/* matches barrier in request_wait_answer() */
>  	smp_mb__after_atomic();
>  	if (test_bit(FR_INTERRUPTED, &req->flags))
>  		queue_interrupt(req);
> +

A nonsense newline diff?



-- 
Thanks,
Jingbo

