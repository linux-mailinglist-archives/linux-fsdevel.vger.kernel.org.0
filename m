Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFEF74F7DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGKSPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 14:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGKSPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:15:19 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73D710F2;
        Tue, 11 Jul 2023 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689099302;
        bh=nvlXLtHpMBPCVmgilaVkOP61WlhExjq63x1MWlHuXJU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=s3qSjF17/0N423y8N7qQ1cNwTPtXy9Q4d+0+w0cvh79BaeGpqS0f8J8/VFAkQosw2
         gRswHTmtjA/GISMy3fn9+MDawPGdW7zQ9xjPQd+0lfDRh5YnpC9f89UbyQ6DTlzllD
         u5CAJkQoa7/MHL2hyTeaQodEHg0Jkva5q9ypcffw=
Received: from [IPV6:240e:331:c24:b000:834a:7cef:6ef:2fd5] ([240e:331:c24:b000:834a:7cef:6ef:2fd5])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 3BB22495; Wed, 12 Jul 2023 02:14:59 +0800
X-QQ-mid: xmsmtpt1689099299tpc3g3wl5
Message-ID: <tencent_8B551E757BD0C0E46A7A23B3AA5FD4336206@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnUs4C74227OijJNwyVi8WJOHGbv8zemIKtCS6pSuAD/BQNlrvHE
         WExDMBbFeM3H0h/TOEcTRiPzQ2ImrkBLnrwiaZBFuCucVkht0JUHf38AMokgwNSL962nqGmJ77PF
         gkQ2NP4kovz2JkZip0BFOd3RnV4uR/AD3B0drRzPdK5VwnSOYV9Z5XVPq0nAKryMnYCEeuhoTsaN
         JyZldX3tJ9aFIrUIkIMKjHeht+9leMl4Cl3YowmRqJ2PxZ4USkESuzSAwGqiv67biw5NhvVdw12r
         Z+bsNhyYXcCF/NVvLaEGKsD4mq3gmwcni4JUinsN3ynVJxWP1upOj/Gpyf/Qx4ckSsTz7P63HTBd
         lEu6YMWnXq6xi8JbELqzAGleu4VIwvHrYMTlELZy7YxDAsRn3wY8ApgYnqOnN1V4Q2nc3ZK66h1w
         3IUCrFDbzn+0SfNE0EPTlCoxxV8iVE+mpDzN1vrZ9SyWIR2d+7Kz+0OUah1UDuz1XAcVPdVz0Q4y
         wYA+KjPLwTEOVUH+8kBq7WziQhop8OfjkMbbcvOt7ppl6IzFKR816oz7DVHzkpFPwj+ECd81RjWt
         7SjTDEcCish4bOpQm3JuumjEBwV7GjA+gYknbzE9bNDHC1ouPlIlOUmQaXsMKkYnUYFgoEr0CLZD
         uokrAVceu8EzEemvIgABrTA/6C/zQ6TyQEw978W/r4AWxmuwX5L6ZABOg4BB5fIBM9DQ9nb1WbbR
         w8M/7j6tCsH/RUslxF/PGJfteJ9An6/2XxqIjNPhubousIunkaskUXjFuwvq60rqgHjX3bYjsuni
         qgr8Lw4xJD9TO4R8rd+za/mrizlDDzWLkAEt0znIreZ8Gx84CayQWqOQJHC91tdfcs9MjdfGcSM0
         NkDb4DWl+WTZ+R35z7JtpREwZVpMhmHRh2nFHmIjo079x/YvRfMTvkMSzfhtJNJgGeIeeIg9oiU+
         3RX6uaZjBeaiLhNv2z6RMmQuKm2Y53TIjXcqcUsqAcXgshXhsyHanl33fJxMwgzhkFbPuP3Gc3kH
         1nTujw0ZO6W1IRKj1Daa6Bsebsel8=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <13e8f36b-3e01-f17e-1025-d52c8c63928d@foxmail.com>
Date:   Wed, 12 Jul 2023 02:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] eventfd: avoid overflow to ULLONG_MAX when ctx->count is
 0
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
 <20230710-fahrbahn-flocken-03818a6b2e91@brauner>
 <tencent_BCEA8520DBC99F741C6666BF8167B32A2007@qq.com>
 <20230711-legalisieren-qualvoll-c578e099c65a@brauner>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20230711-legalisieren-qualvoll-c578e099c65a@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2023/7/11 17:39, Christian Brauner wrote:
> On Mon, Jul 10, 2023 at 11:02:33PM +0800, Wen Yang wrote:
>> On 2023/7/10 22:12, Christian Brauner wrote:
>>> On Sun, Jul 09, 2023 at 02:54:51PM +0800, wenyang.linux@foxmail.com wrote:
>>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>>
>>>> For eventfd with flag EFD_SEMAPHORE, when its ctx->count is 0, calling
>>>> eventfd_ctx_do_read will cause ctx->count to overflow to ULLONG_MAX.
>>>>
>>>> Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")
>>>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
>>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>> Cc: Christian Brauner <brauner@kernel.org>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Cc: Dylan Yudaken <dylany@fb.com>
>>>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: linux-fsdevel@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>> So this looks ok but I would like to see an analysis how the overflow
>>> can happen. I'm looking at the callers and it seems that once ctx->count
>>> hits 0 eventfd_read() won't call eventfd_ctx_do_read() anymore. So is
>>> there a caller that can call directly or indirectly
>>> eventfd_ctx_do_read() on a ctx->count == 0?
>> eventfd_read() ensures that ctx->count is not 0 before calling
>> eventfd_ctx_do_read() and it is correct.
>>
>> But it is not appropriate for eventfd_ctx_remove_wait_queue() to call
>> eventfd_ctx_do_read() unconditionally,
>>
>> as it may not only causes ctx->count to overflow, but also unnecessarily
>> calls wake_up_locked_poll().
>>
>>
>> I am sorry for just adding the following string in the patch:
>> Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")
>>
>>
>> Looking forward to your suggestions.
>>
>> --
>>
>> Best wishes,
>>
>> Wen
>>
>>
>>> I'm just slightly skeptical about patches that fix issues without an
>>> analysis how this can happen.
>>>
>>>>    fs/eventfd.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/eventfd.c b/fs/eventfd.c
>>>> index 8aa36cd37351..10a101df19cd 100644
>>>> --- a/fs/eventfd.c
>>>> +++ b/fs/eventfd.c
>>>> @@ -189,7 +189,7 @@ void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
>>>>    {
>>>>    	lockdep_assert_held(&ctx->wqh.lock);
>>>> -	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
>>>> +	*cnt = ((ctx->flags & EFD_SEMAPHORE) && ctx->count) ? 1 : ctx->count;
>>>>    	ctx->count -= *cnt;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
>>>> @@ -269,6 +269,8 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
>>>>    		return -EFAULT;
>>>>    	if (ucnt == ULLONG_MAX)
>>>>    		return -EINVAL;
>>>> +	if ((ctx->flags & EFD_SEMAPHORE) && !ucnt)
>>>> +		return -EINVAL;
> Hm, why is bit necessary though? What's wrong with specifying ucnt == 0
> with EFD_SEMAPHORE? This also looks like a (very low potential) uapi
> break.


Thank you for your careful review.

As you pointed out, this may break the uapi.
Although manaul has the following description (man 2 eventfd):
*  The file descriptor is readable (the select(2) readfds argument; the 
poll(2) POLLIN flag) if the counter has a value greater than 0.
*  The file descriptor is writable (the select(2) writefds argument; the 
poll(2) POLLOUT flag) if it is possible to write a value of at least "1" 
without blocking.

But it does not specify that the ucnt cannot be zero, so we can only 
delete the two lines of code above

Could we propose another patch specifically to address the issue you 
have identified?

Since there are indeed some corner scenes when ucnt is 0 and ctx->count 
is also 0:


static ssize_t eventfd_write(struct file *file, const char __user *buf, 
size_t count,
                              loff_t *ppos)
{
...
         if (ULLONG_MAX - ctx->count > ucnt)
                 res = sizeof(ucnt);                 ---> always > 0
...
         if (likely(res > 0)) {
                 ctx->count += ucnt;                 ---> unnecessary 
addition of 0
                 current->in_eventfd = 1;            ---> May affect 
eventfd_signal()
                 if (waitqueue_active(&ctx->wqh))
                         wake_up_locked_poll(&ctx->wqh, EPOLLIN);  ---> 
heavyweight wakeup
                 current->in_eventfd = 0;
         }
...
}


static __poll_t eventfd_poll(struct file *file, poll_table *wait)
{
...
         count = READ_ONCE(ctx->count);

         if (count > 0)
                 events |= EPOLLIN;    ---> If count is 0, all previous 
operations are wasted

         if (count == ULLONG_MAX)
                 events |= EPOLLERR;
         if (ULLONG_MAX - 1 > count)
                 events |= EPOLLOUT;

         return events;
}

Could we optimize it like this?

static ssize_t eventfd_write(struct file *file, const char __user *buf, 
size_t count,
                              loff_t *ppos)
{
...
         if (likely(res > 0)) {
                 ctx->count += ucnt;
                 if (ctx->count) {                       ---> avoiding 
unnecessary heavyweight operations
                         current->in_eventfd = 1;
                         if (waitqueue_active(&ctx->wqh))
wake_up_locked_poll(&ctx->wqh, EPOLLIN);
                         current->in_eventfd = 0;
                 }
         }
...
}


--

Best wishes,

Wen



