Return-Path: <linux-fsdevel+bounces-25059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C68819487B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 04:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A40B23F1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89906BA20;
	Tue,  6 Aug 2024 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VmSVuGye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65BC2E9
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912322; cv=none; b=HCmZiZBabXs8YztOeSuF4Vt+bpZ3eK/UXnI4mIk4iKb+FEskZmvTgxYHyGrtKZM2vqIe/17NtcnSCZw6gTTMTpXKV7yDWA2dGMBFoiLsX9Rzq/Cnj8eRPlrMyFOtvN5PHO9uEWEmQgamr7fQdXKSsitxuQ7NYuKGSLcyYqmwZ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912322; c=relaxed/simple;
	bh=yE2f9TGX9hjQP1I5zJRaQUCjSzDtgS2Xp1IYq51Zdrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGeSABYVRCZEaodjnWP471sKh5dCyC+H0W0BqUuC8HyRPzncAVNNEP5nO52ZLTxIvBRCARrd/rWXrESpLnMnH9FovO1i6J2405T48Ak4+6HnLJG/PyTthA7/RD8hTAhaTaoDRmWx9r7H79p97/iP2a2m+q7THbBziA2oG02LPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VmSVuGye; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722912317; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6D8bCaEwqhUGJ1A0mf1Epe7eHlhWC479LPNlgW/id2w=;
	b=VmSVuGyeSpqmxZSkvdL8gN6LiT+mmxzR4hWzEbbNVrbMIyABwoOI2eB1Imkv0PrKzT1JajgOiqYxhAYlq2Nf57pyG9jjWhmknsE80RGYU8wRW4j1Zq3o3gfCnCqIUIGEbNqE/bCM0vX4L4q/qcdH8O55JBYpE1o7UTGbNu16fYY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WCDe9pW_1722912315;
Received: from 30.221.146.248(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WCDe9pW_1722912315)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 10:45:16 +0800
Message-ID: <c238a20d-807f-41d2-9ce0-519bffe5ab26@linux.alibaba.com>
Date: Tue, 6 Aug 2024 10:45:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, laoar.shao@gmail.com, kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com>
 <ffce4a22-5104-4707-812b-962638e45aeb@linux.alibaba.com>
 <CAJnrk1aHnn+i2FNxOEnLdhC6m9gF_O77t9yjsvsmFwLjBh-Gkw@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1aHnn+i2FNxOEnLdhC6m9gF_O77t9yjsvsmFwLjBh-Gkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/6/24 6:53 AM, Joanne Koong wrote:
> On Mon, Aug 5, 2024 at 12:32 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 7/30/24 8:23 AM, Joanne Koong wrote:
>>> There are situations where fuse servers can become unresponsive or take
>>> too long to reply to a request. Currently there is no upper bound on
>>> how long a request may take, which may be frustrating to users who get
>>> stuck waiting for a request to complete.
>>>
>>> This commit adds a timeout option (in seconds) for requests. If the
>>> timeout elapses before the server replies to the request, the request
>>> will fail with -ETIME.
>>>
>>> There are 3 possibilities for a request that times out:
>>> a) The request times out before the request has been sent to userspace
>>> b) The request times out after the request has been sent to userspace
>>> and before it receives a reply from the server
>>> c) The request times out after the request has been sent to userspace
>>> and the server replies while the kernel is timing out the request
>>>
>>> While a request timeout is being handled, there may be other handlers
>>> running at the same time if:
>>> a) the kernel is forwarding the request to the server
>>> b) the kernel is processing the server's reply to the request
>>> c) the request is being re-sent
>>> d) the connection is aborting
>>> e) the device is getting released
>>>
>>> Proper synchronization must be added to ensure that the request is
>>> handled correctly in all of these cases. To this effect, there is a new
>>> FR_FINISHING bit added to the request flags, which is set atomically by
>>> either the timeout handler (see fuse_request_timeout()) which is invoked
>>> after the request timeout elapses or set by the request reply handler
>>> (see dev_do_write()), whichever gets there first. If the reply handler
>>> and the timeout handler are executing simultaneously and the reply handler
>>> sets FR_FINISHING before the timeout handler, then the request will be
>>> handled as if the timeout did not elapse. If the timeout handler sets
>>> FR_FINISHING before the reply handler, then the request will fail with
>>> -ETIME and the request will be cleaned up.
>>>
>>> Currently, this is the refcount lifecycle of a request:
>>>
>>> Synchronous request is created:
>>> fuse_simple_request -> allocates request, sets refcount to 1
>>>   __fuse_request_send -> acquires refcount
>>>     queues request and waits for reply...
>>> fuse_simple_request -> drops refcount
>>>
>>> Background request is created:
>>> fuse_simple_background -> allocates request, sets refcount to 1
>>>
>>> Request is replied to:
>>> fuse_dev_do_write
>>>   fuse_request_end -> drops refcount on request
>>>
>>> Proper acquires on the request reference must be added to ensure that the
>>> timeout handler does not drop the last refcount on the request while
>>> other handlers may be operating on the request. Please note that the
>>> timeout handler may get invoked at any phase of the request's
>>> lifetime (eg before the request has been forwarded to userspace, etc).
>>>
>>> It is always guaranteed that there is a refcount on the request when the
>>> timeout handler is executing. The timeout handler will be either
>>> deactivated by the reply/abort/release handlers, or if the timeout
>>> handler is concurrently executing on another CPU, the reply/abort/release
>>> handlers will wait for the timeout handler to finish executing first before
>>> it drops the final refcount on the request.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++--
>>>  fs/fuse/fuse_i.h |  14 ++++
>>>  fs/fuse/inode.c  |   7 ++
>>>  3 files changed, 200 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 9eb191b5c4de..9992bc5f4469 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
>>>
>>>  static struct kmem_cache *fuse_req_cachep;
>>>
>>> +static void fuse_request_timeout(struct timer_list *timer);
>>> +
>>>  static struct fuse_dev *fuse_get_dev(struct file *file)
>>>  {
>>>       /*
>>> @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>>>       refcount_set(&req->count, 1);
>>>       __set_bit(FR_PENDING, &req->flags);
>>>       req->fm = fm;
>>> +     if (fm->fc->req_timeout)
>>> +             timer_setup(&req->timer, fuse_request_timeout, 0);
>>>  }
>>>
>>>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
>>> @@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc)
>>>   * the 'end' callback is called if given, else the reference to the
>>>   * request is released
>>>   */
>>> -void fuse_request_end(struct fuse_req *req)
>>> +static void do_fuse_request_end(struct fuse_req *req, bool from_timer_callback)
>>>  {
>>>       struct fuse_mount *fm = req->fm;
>>>       struct fuse_conn *fc = fm->fc;
>>>       struct fuse_iqueue *fiq = &fc->iq;
>>>
>>> +     if (from_timer_callback)
>>> +             req->out.h.error = -ETIME;
>>> +
>>
>> FMHO, could we move the above error assignment up to the caller to make
>> do_fuse_request_end() look cleaner?
> 
> Sure, I was thinking that it looks cleaner setting this in
> do_fuse_request_end() instead of having to set it in both
> timeout_pending_req() and timeout_inflight_req(), but I see your point
> as well.
> I'll make this change in v3.
> 
>>
>>
>>>       if (test_and_set_bit(FR_FINISHED, &req->flags))
>>>               goto put_request;
>>>
>>> @@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
>>>               list_del_init(&req->intr_entry);
>>>               spin_unlock(&fiq->lock);
>>>       }
>>> -     WARN_ON(test_bit(FR_PENDING, &req->flags));
>>> -     WARN_ON(test_bit(FR_SENT, &req->flags));
>>>       if (test_bit(FR_BACKGROUND, &req->flags)) {
>>>               spin_lock(&fc->bg_lock);
>>>               clear_bit(FR_BACKGROUND, &req->flags);
>>> @@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
>>>               wake_up(&req->waitq);
>>>       }
>>>
>>> +     if (!from_timer_callback && req->timer.function)
>>> +             timer_delete_sync(&req->timer);
>>> +
>>
>> Similarly, move the caller i.e. fuse_request_end() call
>> timer_delete_sync() instead?
> 
> I don't think we can do that because the fuse_put_request() at the end
> of this function often holds the last refcount on the request which
> frees the request when it releases the ref.

Initially I mean timer_delete_sync() could be called before
do_fuse_request_end() inside fuse_request_end().  But anyway it's a
rough idea just for making the code look cleaner, without thinking if
this logic change is right or not.


>>> +static void timeout_pending_req(struct fuse_req *req)
>>> +{
>>> +     struct fuse_conn *fc = req->fm->fc;
>>> +     struct fuse_iqueue *fiq = &fc->iq;
>>> +     bool background = test_bit(FR_BACKGROUND, &req->flags);
>>> +
>>> +     if (background)
>>> +             spin_lock(&fc->bg_lock);
>>
>> Just out of curious, why fc->bg_lock is needed here, which makes the
>> code look less clean?
> 
> The fc->bg_lock is needed because the background request may still be
> on the fc->bg_queue when the request times out (eg the request hasn't
> been flushed yet). We need to acquire the fc->bg_lock so that we can
> delete it from the queue, in case somehting else is modifying the
> queue at the same time.

I can understand now.  Thanks!

> 
>>
>>
>>> +     spin_lock(&fiq->lock);
>>> +
>>> +     if (!test_bit(FR_PENDING, &req->flags)) {
>>> +             spin_unlock(&fiq->lock);
>>> +             if (background)
>>> +                     spin_unlock(&fc->bg_lock);
>>> +             timeout_inflight_req(req);
>>> +             return;
>>> +     }
>>> +
>>> +     if (!test_bit(FR_PRIVATE, &req->flags))
>>> +             list_del_init(&req->list);
>>> +
>>> +     spin_unlock(&fiq->lock);
>>> +     if (background)
>>> +             spin_unlock(&fc->bg_lock);
>>> +
>>> +     do_fuse_request_end(req, true);
>>
>> I'm not sure if special handling for requests in fpq->io list in needed
>> here.  At least when connection is aborted, thos LOCKED requests in
>> fpq->io list won't be finished instantly until they are unlocked.
>>
> 
> The places where FR_LOCKED gets set on the request are in
> fuse_dev_do_write and fuse_dev_do_read when we do some of the page
> copying stuff. In both those functions, this timeout_pending_req()
> path isn't hit while we have the lock obtained - in fuse_dev_do_write,
> we test and set FR_FINISHING first before doing the page copying (the
> timeout handler will return before calling timeout_pending_req()), and
> in fuse_dev_do_read, the locking is called after the FR_PENDING flag
> has been cleared.
> 
> I think there is a possibility that the timeout handler executes
> timeout_inflight_req() while the lock is obtained in fuse_dev_do_read
> during the page copying, but this patch added an extra
> __fuse_get_request() on the request before doing the page copying,
> which means the timeout handler will not free out the request while
> the lock is held and the page copying is being done.
> 

Yes, this is the only possible place where the timeout handler could
concurrently run while the request is in copying state (i.e. LOCKED).
As I described above, when connection is aborted, the LOCKED requests
will be left there and won't be finished until they are unlocked.  I'm
not sure why this special handling is needed for LOCKED requests, but I
guess it's not because of UAF issue.  From the comment of
lock_request(), "Up to the next unlock_request() there mustn't be
anything that could cause a page-fault.", though I can't understand in
which case there will be a page fault and it will be an issue.

Maybe I'm wrong.  It would be helpful if someone could shed light on this.


-- 
Thanks,
Jingbo

