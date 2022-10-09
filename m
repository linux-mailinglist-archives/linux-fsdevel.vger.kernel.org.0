Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88235F8B53
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJIMuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiJIMuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:50:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434413E07
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Oct 2022 05:49:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v186so8657599pfv.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Oct 2022 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6urVoNrsZ3xK9TTBedmkBiGA8HxDh2mm40ljL3bOKM=;
        b=pq/4RfUrUoPRHxYYsIO3qsins+f7aijUS9Smc+k9NuASiOHf3eAr8xByAnM9F9sDHy
         BhEj38M3ifTSsNkOM0G+bHojP+PB/URgDCdwCbDrkZIexZYO7xCMJyvRgRXedwYNOm0Q
         0M0qj5ChYI5gL23sjzZxyrt/o1Z/Nr/paJnO2oE19RN+LVz9UNjV3ebHzQLi4Uz26uZY
         k4CXzkpv9udFFtlwXvjc/I+kMMhbN5/wD/Hy8H/G2fca+VvRQuqRQhVHmCgtn8M9LFO0
         rzfUWm1XFzMvYjrxadTi13QNk6BRmyCsyY3QC3AzFLweOhPER4HAD2HWh3JrznT5AApg
         jqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P6urVoNrsZ3xK9TTBedmkBiGA8HxDh2mm40ljL3bOKM=;
        b=Ni6qPpdrvcPxRv7I6bsGz5D5cGm7t34Hbvv9q9cqPsw8sf587fRUNjmipklkMVHPjg
         VLpamPjSi6zQAekB3CEW0VbVBZEOpTzW53BNZv7cwUd05ZOTvhIYMTXHsAcynB2YQuPR
         V2Zom8Va947ZTkYqykw8Y9UtLTB0sP/8V75wL2ZzM+r3RIwoxj7EVfWOI+A0v3Pkt5Rd
         r6IrIoSaysTo7lBOBFycsWPR94R+9eMNRDNxaAD988EdQy6sS8AwVKZ9lEsAvnGuaoyX
         +RwFkDyD9ZcuJt/fGfARxoJSIPbb0vmd4VVc2Xxa8Si5SrjMfD+HVSCsp3VTGS5be1XD
         4y2g==
X-Gm-Message-State: ACrzQf28dI9BXu5QiLao1SDcIWwtZLN+vMY6sJEqJ4CJD+Ont0KI/cpP
        9v07Yq8q61sOv82j52vzxqxZnA==
X-Google-Smtp-Source: AMsMyM6TMEJOGeopAX1WHu2EFpazDEUo6VXOzDLqfIE+spUe2oERt7fQpueMN3Vy3k3bUkjIoAqyLA==
X-Received: by 2002:a05:6a00:18a6:b0:563:4655:2966 with SMTP id x38-20020a056a0018a600b0056346552966mr1883772pfh.1.1665319796431;
        Sun, 09 Oct 2022 05:49:56 -0700 (PDT)
Received: from [10.3.156.122] ([63.216.146.184])
        by smtp.gmail.com with ESMTPSA id n32-20020a634d60000000b0044e8d66ae05sm4537244pgl.22.2022.10.09.05.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 05:49:55 -0700 (PDT)
Message-ID: <672939d2-e556-f9a5-d0f6-3f0b73edf0c9@bytedance.com>
Date:   Sun, 9 Oct 2022 20:49:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [RFC PATCH 3/5] cachefiles: resend an open request
 if the read request's object is closed
To:     JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-4-zhujia.zj@bytedance.com>
 <206e172c-5ba0-1233-f46d-edb828df53ad@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <206e172c-5ba0-1233-f46d-edb828df53ad@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/10/8 17:05, JeffleXu 写道:
> 
> 
> On 8/18/22 9:52 PM, Jia Zhu wrote:
>> When an anonymous fd is closed by user daemon, if there is a new read
>> request for this file comes up, the anonymous fd should be re-opened
>> to handle that read request rather than fail it directly.
>>
>> 1. Introduce reopening state for objects that are closed but have
>>     inflight/subsequent read requests.
>> 2. No longer flush READ requests but only CLOSE requests when anonymous
>>     fd is closed.
>> 3. Enqueue the reopen work to workqueue, thus user daemon could get rid
>>     of daemon_read context and handle that request smoothly. Otherwise,
>>     the user daemon will send a reopen request and wait for itself to
>>     process the request.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
>> ---
>>   fs/cachefiles/internal.h |  3 ++
>>   fs/cachefiles/ondemand.c | 79 +++++++++++++++++++++++++++-------------
>>   2 files changed, 56 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>> index cdf4ec781933..66bbd4f1d22a 100644
>> --- a/fs/cachefiles/internal.h
>> +++ b/fs/cachefiles/internal.h
>> @@ -48,9 +48,11 @@ struct cachefiles_volume {
>>   enum cachefiles_object_state {
>>   	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon or initial state */
>>   	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with object is available */
>> +	CACHEFILES_ONDEMAND_OBJSTATE_reopening, /* Object that was closed and is being reopened. */
>>   };
>>   
>>   struct cachefiles_ondemand_info {
>> +	struct work_struct		work;
>>   	int				ondemand_id;
>>   	enum cachefiles_object_state	state;
>>   	struct cachefiles_object	*object;
>> @@ -341,6 +343,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
>>   
>>   CACHEFILES_OBJECT_STATE_FUNCS(open);
>>   CACHEFILES_OBJECT_STATE_FUNCS(close);
>> +CACHEFILES_OBJECT_STATE_FUNCS(reopening);
>>   #else
>>   #define CACHEFILES_ONDEMAND_OBJINFO(object)	NULL
>>   
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index f51266554e4d..79ffb19380cd 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -18,14 +18,10 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
>>   	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
>>   	cachefiles_ondemand_set_object_close(object);
>>   
>> -	/*
>> -	 * Flush all pending READ requests since their completion depends on
>> -	 * anon_fd.
>> -	 */
>> -	xas_for_each(&xas, req, ULONG_MAX) {
>> +	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
>> +	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
> 
> Could you please add a more detailed comment here, explaing why flushing
> CLOSE requests when anony fd gets closed is needed, and why the original
> xas_for_each() would race with daemon_read()? There are some refs at [1]
> and [2].
> 
> [1]
> https://hackmd.io/YNsTQqLcQYOZ4gAlFWrNcA#flush-CLOSE-requests-when-anon-fd-is-closed
> [2]
> https://hackmd.io/YNsTQqLcQYOZ4gAlFWrNcA#race-between-readingflush-requests
> 
> The sequence chart is welcome to be added into the comment to explain
> the race, or the code will be difficult to understand since the subtlety
> of the race.
OK, I'd like to do that.
> 
> 
>>   		if (req->msg.object_id == object_id &&
>> -		    req->msg.opcode == CACHEFILES_OP_READ) {
>> -			req->error = -EIO;
>> +		    req->msg.opcode == CACHEFILES_OP_CLOSE) {
>>   			complete(&req->done);
>>   			xas_store(&xas, NULL);
>>   		}
>> @@ -175,6 +171,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	trace_cachefiles_ondemand_copen(req->object, id, size);
>>   
>>   	cachefiles_ondemand_set_object_open(req->object);
>> +	wake_up_all(&cache->daemon_pollwq);
>>   
>>   out:
>>   	complete(&req->done);
>> @@ -234,6 +231,14 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   	return ret;
>>   }
>>   
>> +static void ondemand_object_worker(struct work_struct *work)
>> +{
>> +	struct cachefiles_object *object =
>> +		((struct cachefiles_ondemand_info *)work)->object;
>> +
>> +	cachefiles_ondemand_init_object(object);
>> +}
>> +
>>   ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   					char __user *_buffer, size_t buflen)
>>   {
>> @@ -249,7 +254,27 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	 * requests from being processed repeatedly.
>>   	 */
>>   	xa_lock(&cache->reqs);
>> -	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
>> +	xas_for_each_marked(&xas, req, UINT_MAX, CACHEFILES_REQ_NEW) {
>> +		/*
>> +		 * Reopen the closed object with associated read request.
>> +		 * Skip read requests whose related object are reopening.
>> +		 */
>> +		if (req->msg.opcode == CACHEFILES_OP_READ) {
>> +			ret = cmpxchg(&CACHEFILES_ONDEMAND_OBJINFO(req->object)->state,
>> +						  CACHEFILES_ONDEMAND_OBJSTATE_close,
>> +						  CACHEFILES_ONDEMAND_OBJSTATE_reopening);
>> +			if (ret == CACHEFILES_ONDEMAND_OBJSTATE_close) {
>> +				INIT_WORK(&CACHEFILES_ONDEMAND_OBJINFO(req->object)->work,
>> +						ondemand_object_worker);
> 
> How about initializing @work in cachefiles_ondemand_init_obj_info(), so
> that the work_struct of each object only needs to be initialized once?
> 
SGTM.
> 
>> +				queue_work(fscache_wq,
>> +					&CACHEFILES_ONDEMAND_OBJINFO(req->object)->work);
>> +				continue;
>> +			} else if (ret == CACHEFILES_ONDEMAND_OBJSTATE_reopening) {
>> +				continue;
>> +			}
>> +		}
>> +		break;
>> +	}
>>   	if (!req) {
>>   		xa_unlock(&cache->reqs);
>>   		return 0;
>> @@ -267,14 +292,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	xa_unlock(&cache->reqs);
>>   
>>   	id = xas.xa_index;
>> -	msg->msg_id = id;
>>   
>>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>>   		ret = cachefiles_ondemand_get_fd(req);
>> -		if (ret)
>> +		if (ret) {
>> +			cachefiles_ondemand_set_object_close(req->object);
>>   			goto error;
>> +		}
>>   	}
>>   
>> +	msg->msg_id = id;
>> +	msg->object_id = CACHEFILES_ONDEMAND_OBJINFO(req->object)->ondemand_id;
>> +
>>   	if (copy_to_user(_buffer, msg, n) != 0) {
>>   		ret = -EFAULT;
>>   		goto err_put_fd;
>> @@ -307,19 +336,23 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>   					void *private)
>>   {
>>   	struct cachefiles_cache *cache = object->volume->cache;
>> -	struct cachefiles_req *req;
>> +	struct cachefiles_req *req = NULL;
>>   	XA_STATE(xas, &cache->reqs, 0);
>>   	int ret;
>>   
>>   	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>>   		return 0;
>>   
>> -	if (test_bit(CACHEFILES_DEAD, &cache->flags))
>> -		return -EIO;
>> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>>   
>>   	req = kzalloc(sizeof(*req) + data_len, GFP_KERNEL);
>> -	if (!req)
>> -		return -ENOMEM;
>> +	if (!req) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>>   
>>   	req->object = object;
>>   	init_completion(&req->done);
>> @@ -357,7 +390,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>   		/* coupled with the barrier in cachefiles_flush_reqs() */
>>   		smp_mb();
>>   
>> -		if (opcode != CACHEFILES_OP_OPEN &&
>> +		if (opcode == CACHEFILES_OP_CLOSE &&
>>   			!cachefiles_ondemand_object_is_open(object)) {
>>   			WARN_ON_ONCE(CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id == 0);
>>   			xas_unlock(&xas);
>> @@ -382,8 +415,12 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>   	wake_up_all(&cache->daemon_pollwq);
>>   	wait_for_completion(&req->done);
>>   	ret = req->error;
>> +	kfree(req);
>> +	return ret;
>>   out:
>>   	kfree(req);
>> +	if (opcode == CACHEFILES_OP_OPEN)
>> +		cachefiles_ondemand_set_object_close(req->object);
> 
> Could you please add a comment here explaining why we need to set the
> object state back to CLOSE state for OPEN (espectially reopening)
> requests when error occured, and why we only set it back to CLOSE state
> when error occured before the anony fd gets initialized? (That's because
> when the error occures after the anony fd has been initialized, the
> object will be reset to CLOSE state through
> cachefiles_ondemand_fd_release() triggered by close_fd().) Or the code
> is quite difficult to comprehend.
> 
Thanks for the suggestion. I'll do it.
> 
>>   	return ret;
>>   }
>>   
>> @@ -435,7 +472,6 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
>>   	if (!cachefiles_ondemand_object_is_open(object))
>>   		return -ENOENT;
>>   
>> -	req->msg.object_id = CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id;
>>   	trace_cachefiles_ondemand_close(object, &req->msg);
>>   	return 0;
>>   }
>> @@ -451,16 +487,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
>>   	struct cachefiles_object *object = req->object;
>>   	struct cachefiles_read *load = (void *)req->msg.data;
>>   	struct cachefiles_read_ctx *read_ctx = private;
>> -	int object_id = CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id;
>>   
>> -	/* Stop enqueuing requests when daemon has closed anon_fd. */
>> -	if (!cachefiles_ondemand_object_is_open(object)) {
>> -		WARN_ON_ONCE(object_id == 0);
>> -		pr_info_once("READ: anonymous fd closed prematurely.\n");
>> -		return -EIO;
>> -	}
>> -
>> -	req->msg.object_id = object_id;
>>   	load->off = read_ctx->off;
>>   	load->len = read_ctx->len;
>>   	trace_cachefiles_ondemand_read(object, &req->msg, load);
> 
