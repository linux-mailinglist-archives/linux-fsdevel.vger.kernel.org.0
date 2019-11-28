Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABAF10C10B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 01:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfK1Alj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 19:41:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41374 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfK1Ali (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:41:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id t8so10665473plr.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 16:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FCiDCrNWk1YCTMlC7xjXzOvPP0i1Om+8u3DnK4v7/Qc=;
        b=X3xB36e4EQWqCYVF4OXJnwgar73VGA54bTqvkE8LL2j1oEMZboe2ttwzLWtciDJdAZ
         Qv3Fi2IFeqquyLNfJ88tXGfczCgu+p1U7LQu40GdmZ6wCw6Img2BAuy/Da47COsn7x4A
         LV2c1NhNio+K6Cb+U3ToCE1il7CLnHmyI8Q+pRUQVOLeePwv1T+nO11Aiaf2ODTPtqxY
         xTPp5GCbJcnmTgNIXZnZExM1UWMIMlvC2mEiKNFDyqAsLNjVcAf3ENOlGU7xEZ5G+3y3
         TmDmbkArdyeql1RQx8xSw9JPHGd9CzJWrpNu3oBHJxYmpql+C8r6lPPwiGJhEOrX4rx7
         AZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FCiDCrNWk1YCTMlC7xjXzOvPP0i1Om+8u3DnK4v7/Qc=;
        b=IcF9ESrDuUjZBK43qIJeem2nDersx9dRGrbIMezlULsS7Dlg+zhvnbTNkpjKrqpbg+
         ZuT8njP8YFpTbgz+e5+BKvqVB7u3V12xfnmNZZ6Tgzl8bKSPKu7xEvNWcmsxyAA+mGRE
         AfOT36tCU7yLZkukN+sJkS9XPxl32c+GqjPNNBfpRjzgRF18bOgjB+B2zT113FJdto61
         Fwp/yMPHIqTQa4QMdX3hVM6D9C/quBVk3NJ4msndcD8ELm/XmDrGdTre69N34CjXME8M
         7rze6mtzeudt78+E3PlAGn5Z+eWRQrY7fUSCk/jI73NSo+O7bvLXlOzPHjuGXeZUH6Hd
         dffw==
X-Gm-Message-State: APjAAAW2IO1SkGQlzbMtQP8CTEJOp+tx9QEZiHbOmIIhLOceBoM0CzDV
        +eM6SX5FjRIEKIkeCKWblXKif6JIjor06w==
X-Google-Smtp-Source: APXvYqyRUIpejqSYzX0mOTGgo+FLGivwtk2CiUOFjGkaOSvo9BAqGUZB8aiNen60atz+pjwaI+X4aQ==
X-Received: by 2002:a17:90a:1982:: with SMTP id 2mr9749179pji.30.1574901695752;
        Wed, 27 Nov 2019 16:41:35 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:51d8:c1d0:d39b:624d? ([2605:e000:100e:8c61:51d8:c1d0:d39b:624d])
        by smtp.gmail.com with ESMTPSA id f26sm16757441pgf.22.2019.11.27.16.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 16:41:34 -0800 (PST)
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Jann Horn <jannh@google.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk>
 <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75dec576-9339-af9c-89fc-1e60f8ec8066@kernel.dk>
Date:   Wed, 27 Nov 2019 16:41:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/27/19 4:27 PM, Jann Horn wrote:
> On Wed, Nov 27, 2019 at 9:48 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 11/27/19 12:23 PM, Jann Horn wrote:
>>> On Wed, Nov 27, 2019 at 6:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>> I posted this a few weeks back, took another look at it and refined it a
>>>> bit. I'd like some input on the viability of this approach.
>>>>
>>>> A new signalfd setup flag is added, SFD_TASK. This is only valid if used
>>>> with SFD_CLOEXEC. If set, the task setting up the signalfd descriptor is
>>>> remembered in the signalfd context, and will be the one we use for
>>>> checking signals in the poll/read handlers in signalfd.
>>>>
>>>> This is needed to make signalfd useful with io_uring and aio, of which
>>>> the former in particular has my interest.
>>>>
>>>> I _think_ this is sane. To prevent the case of a task clearing O_CLOEXEC
>>>> on the signalfd descriptor, forking, and then exiting, we grab a
>>>> reference to the task when we assign it. If that original task exits, we
>>>> catch it in signalfd_flush() and ensure waiters are woken up.
>>>
>>> Mh... that's not really reliable, because you only get ->flush() from
>>> the last exiting thread (or more precisely, the last exiting task that
>>> shares the files_struct).
>>>
>>> What is your goal here? To have a reference to a task without keeping
>>> the entire task_struct around in memory if someone leaks the signalfd
>>> to another process - basically like a weak pointer? If so, you could
>>> store a refcounted reference to "struct pid" instead of a refcounted
>>> reference to the task_struct, and then do the lookup of the
>>> task_struct on ->poll and ->read (similar to what procfs does).
>>
>> Yeah, I think that works out much better (and cleaner). How about this,
>> then? Follows your advice and turns it into a struct pid instead. I
>> don't particularly like the -ESRCH in dequeue and setup, what do you
>> think? For poll, POLLERR seems like a prudent choice.
> 
> -ESRCH may be kinda weird, but I also can't think of anything
> better... and it does describe the problem pretty accurately: The task
> whose signal state you're trying to inspect is gone. I went through
> the list of errnos, and everything else sounded more weird...

Right, that's why I ultimately ended up with -ESRCH. But I'll take that
as concensus :-)

> One more thing, though: We'll have to figure out some way to
> invalidate the fd when the target goes through execve(), in particular
> if it's a setuid execution. Otherwise we'll be able to just steal
> signals that were intended for the other task, that's probably not
> good.
> 
> So we should:
>   a) prevent using ->wait() on an old signalfd once the task has gone
> through execve()
>   b) kick off all existing waiters
>   c) most importantly, prevent ->read() on an old signalfd once the
> task has gone through execve()
> 
> We probably want to avoid using the cred_guard_mutex here, since it is
> quite broad and has some deadlocking issues; it might make sense to
> put the update of ->self_exec_id in fs/exec.c under something like the
> siglock, and then for a) and c) we can check whether the
> ->self_exec_id changed while holding the siglock, and for b) we can
> add a call to signalfd_cleanup() after the ->self_exec_id change.

OK, that seems like one for after the break. Was hoping there'd be a
more trivial way to accomplish that, I'll give it some thought.

>> +static void signalfd_put_task(struct signalfd_ctx *ctx, struct task_struct *tsk)
>> +{
>> +       if (ctx->task_pid)
>> +               put_task_struct(tsk);
>> +}
>> +
>> +static struct task_struct *signalfd_get_task(struct signalfd_ctx *ctx)
>> +{
>> +       if (ctx->task_pid)
>> +               return get_pid_task(ctx->task_pid, PIDTYPE_PID);
>> +
>> +       return current;
>> +}
> 
> This works, and I guess it's a question of coding style... but I'd
> kinda prefer to do the refcount operation in both cases, so that the
> semantics of the returned reference are simply "holds a reference"
> instead of "either holds a reference or borrows from current depending
> on ctx->task_pid". But if you feel strongly about it, feel free to
> keep it as-is.

I don't feel super strongly about it, but I wanted to avoid adding an
unnecessary get/put of the current task for the existing use cases of
signalfd. So I'll probably just keep it as-is.

>> -       add_wait_queue(&current->sighand->signalfd_wqh, &wait);
>> +       add_wait_queue(&tsk->sighand->signalfd_wqh, &wait);
>>          for (;;) {
>>                  set_current_state(TASK_INTERRUPTIBLE);
>> -               ret = dequeue_signal(current, &ctx->sigmask, info);
>> +               ret = dequeue_signal(tsk, &ctx->sigmask, info);
>>                  if (ret != 0)
>>                          break;
>>                  if (signal_pending(current)) {
>>                          ret = -ERESTARTSYS;
>>                          break;
>>                  }
>> -               spin_unlock_irq(&current->sighand->siglock);
>> +               spin_unlock_irq(&tsk->sighand->siglock);
>>                  schedule();
> 
> Should we be dropping the reference to the task before schedule() and
> re-acquiring it afterwards so that if we're blocked on a signalfd read
> and then the corresponding task dies, the refcount can drop to zero
> and we can get woken up? Probably doesn't matter, but seems a bit
> cleaner to me.

That would be simple enough to do, as we know that tsk is either still
the same, or we need to abort. Hence no need to fiddle waitqueues at
that point. I'll make that change.

>> -               spin_lock_irq(&current->sighand->siglock);
>> +               spin_lock_irq(&tsk->sighand->siglock);
>>          }
>> -       spin_unlock_irq(&current->sighand->siglock);
>> +       spin_unlock_irq(&tsk->sighand->siglock);
>>
>> -       remove_wait_queue(&current->sighand->signalfd_wqh, &wait);
>> +       remove_wait_queue(&tsk->sighand->signalfd_wqh, &wait);
>>          __set_current_state(TASK_RUNNING);
>>
>> +       signalfd_put_task(ctx, tsk);
>>          return ret;
>>    }
>>
>> @@ -267,19 +296,24 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
>>          /* Check the SFD_* constants for consistency.  */
>>          BUILD_BUG_ON(SFD_CLOEXEC != O_CLOEXEC);
>>          BUILD_BUG_ON(SFD_NONBLOCK != O_NONBLOCK);
>> +       BUILD_BUG_ON(SFD_TASK & (SFD_CLOEXEC | SFD_NONBLOCK));
>>
>> -       if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK))
>> +       if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK | SFD_TASK))
>> +               return -EINVAL;
>> +       if ((flags & (SFD_CLOEXEC | SFD_TASK)) == SFD_TASK)
>>                  return -EINVAL;
> 
> (non-actionable comment: It seems kinda weird that you can specify
> these parameters with no effect for the `uffd != -1` case... but since
> the existing parameters already work that way, I guess it's
> consistent.)

Yeah, just following what it already does, though I do agree it is weird
with the two separate cases and it only impacting one of them. Didn't
want to make it behave differently.

-- 
Jens Axboe

