Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3710BE91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 22:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfK0VgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 16:36:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37967 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbfK0Usd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:48:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so11737726pfp.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 12:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y6LYqA1009w6/0ukN0Ib/bql9rL9dUoPmyEoPz0e4AE=;
        b=FdkcHHVvIY3IEFp0+wECGStXgSWXF4l63Es+grBYcdduCC7OlLsRIWiHcAceeoSO0c
         KE0p4VBA6wuzuhj5W0xVaHoLemUCW42tcOtTP+cZ+h2pgIpk+E/D3wCOKVQUIM+vbQeD
         r227ZE4R8e355lnIjtEEyv7foBGflEwCdB+rrMnT3BGtEawzPn0rS2mjsjtJQxaES0ma
         eJ/eamuR4soalOyEHTTDv8WPVrjK73knNLLbRQvV61uDf2IZW9VCQ8huhMtc5lyBy5Vv
         6I9el17XC6e3uHm27KZt//D+ZWGQ5xffzzug2d10YB5s8pc6U+zTQfApYxQWmT3KvFdF
         Cteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6LYqA1009w6/0ukN0Ib/bql9rL9dUoPmyEoPz0e4AE=;
        b=QHtUVa8FWIcAE3S5hMOL2O+X6PqaNwCOfBoi3GrGruzML1dtjsF6EGZQPyF9a74XfZ
         BFUUT7MJVJAMVt2UBQfBYyuKHZCMtgC7PBcGI0aEetWmpKgu5eGVEeQlPiz7w8WHeI+V
         HIt37jPc2MeiiSXn+EvDPtxjc8XwsO8DjKpI+syXd3ema48qtxQPSrpQE+rJRSmpdgQC
         LZI1yhFJXdutJuqDVFydKECm4mkvnpy1Wqp/qi6nSkmCdxnMENNE/yedNGk8V0Ob/Cef
         vau8xiEr7G6w8sQsqm1BL5/LVF8H9Gw5kITzB8J7QTtEZMxRq42D1PVBHDJUJb1gMu9A
         WyUA==
X-Gm-Message-State: APjAAAV2kgLGMhf2V+5g1IW2jNTxswOWO2sclaeZX5PXv+LScJdDa+xA
        qXrbdn4HyZ5GuBhvfrUhCxAWt3XT1CJwHA==
X-Google-Smtp-Source: APXvYqxQ65bEvXdycLMXbBtX1P9RFv4BXVKPMqYZ/aYjR1KmPzyt6bVrEPZZCdlnLzb3SEwPi+GajQ==
X-Received: by 2002:a63:4b52:: with SMTP id k18mr7079804pgl.394.1574887712054;
        Wed, 27 Nov 2019 12:48:32 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:814b:c5b0:7860:90ce? ([2605:e000:100e:8c61:814b:c5b0:7860:90ce])
        by smtp.gmail.com with ESMTPSA id l7sm3479413pfl.11.2019.11.27.12.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 12:48:31 -0800 (PST)
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Jann Horn <jannh@google.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk>
Date:   Wed, 27 Nov 2019 12:48:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/27/19 12:23 PM, Jann Horn wrote:
> On Wed, Nov 27, 2019 at 6:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>> I posted this a few weeks back, took another look at it and refined it a
>> bit. I'd like some input on the viability of this approach.
>>
>> A new signalfd setup flag is added, SFD_TASK. This is only valid if used
>> with SFD_CLOEXEC. If set, the task setting up the signalfd descriptor is
>> remembered in the signalfd context, and will be the one we use for
>> checking signals in the poll/read handlers in signalfd.
>>
>> This is needed to make signalfd useful with io_uring and aio, of which
>> the former in particular has my interest.
>>
>> I _think_ this is sane. To prevent the case of a task clearing O_CLOEXEC
>> on the signalfd descriptor, forking, and then exiting, we grab a
>> reference to the task when we assign it. If that original task exits, we
>> catch it in signalfd_flush() and ensure waiters are woken up.
> 
> Mh... that's not really reliable, because you only get ->flush() from
> the last exiting thread (or more precisely, the last exiting task that
> shares the files_struct).
> 
> What is your goal here? To have a reference to a task without keeping
> the entire task_struct around in memory if someone leaks the signalfd
> to another process - basically like a weak pointer? If so, you could
> store a refcounted reference to "struct pid" instead of a refcounted
> reference to the task_struct, and then do the lookup of the
> task_struct on ->poll and ->read (similar to what procfs does).

Yeah, I think that works out much better (and cleaner). How about this,
then? Follows your advice and turns it into a struct pid instead. I
don't particularly like the -ESRCH in dequeue and setup, what do you
think? For poll, POLLERR seems like a prudent choice.

Tested with the test cases I sent out yesterday, works for me.

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 44b6845b071c..ccb1173b20aa 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -50,6 +50,7 @@ void signalfd_cleanup(struct sighand_struct *sighand)
  
  struct signalfd_ctx {
  	sigset_t sigmask;
+	struct pid *task_pid;
  };
  
  static int signalfd_release(struct inode *inode, struct file *file)
@@ -58,20 +59,41 @@ static int signalfd_release(struct inode *inode, struct file *file)
  	return 0;
  }
  
+static void signalfd_put_task(struct signalfd_ctx *ctx, struct task_struct *tsk)
+{
+	if (ctx->task_pid)
+		put_task_struct(tsk);
+}
+
+static struct task_struct *signalfd_get_task(struct signalfd_ctx *ctx)
+{
+	if (ctx->task_pid)
+		return get_pid_task(ctx->task_pid, PIDTYPE_PID);
+
+	return current;
+}
+
  static __poll_t signalfd_poll(struct file *file, poll_table *wait)
  {
  	struct signalfd_ctx *ctx = file->private_data;
+	struct task_struct *tsk;
  	__poll_t events = 0;
  
-	poll_wait(file, &current->sighand->signalfd_wqh, wait);
+	tsk = signalfd_get_task(ctx);
+	if (tsk) {
+		poll_wait(file, &tsk->sighand->signalfd_wqh, wait);
  
-	spin_lock_irq(&current->sighand->siglock);
-	if (next_signal(&current->pending, &ctx->sigmask) ||
-	    next_signal(&current->signal->shared_pending,
-			&ctx->sigmask))
-		events |= EPOLLIN;
-	spin_unlock_irq(&current->sighand->siglock);
+		spin_lock_irq(&tsk->sighand->siglock);
+		if (next_signal(&tsk->pending, &ctx->sigmask) ||
+		    next_signal(&tsk->signal->shared_pending,
+				&ctx->sigmask))
+			events |= EPOLLIN;
+		spin_unlock_irq(&tsk->sighand->siglock);
  
+		signalfd_put_task(ctx, tsk);
+	} else {
+		events |= EPOLLERR;
+	}
  	return events;
  }
  
@@ -167,10 +189,15 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
  				int nonblock)
  {
  	ssize_t ret;
+	struct task_struct *tsk;
  	DECLARE_WAITQUEUE(wait, current);
  
-	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(current, &ctx->sigmask, info);
+	tsk = signalfd_get_task(ctx);
+	if (!tsk)
+		return -ESRCH;
+
+	spin_lock_irq(&tsk->sighand->siglock);
+	ret = dequeue_signal(tsk, &ctx->sigmask, info);
  	switch (ret) {
  	case 0:
  		if (!nonblock)
@@ -178,29 +205,31 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
  		ret = -EAGAIN;
  		/* fall through */
  	default:
-		spin_unlock_irq(&current->sighand->siglock);
+		spin_unlock_irq(&tsk->sighand->siglock);
+		signalfd_put_task(ctx, tsk);
  		return ret;
  	}
  
-	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
+	add_wait_queue(&tsk->sighand->signalfd_wqh, &wait);
  	for (;;) {
  		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(current, &ctx->sigmask, info);
+		ret = dequeue_signal(tsk, &ctx->sigmask, info);
  		if (ret != 0)
  			break;
  		if (signal_pending(current)) {
  			ret = -ERESTARTSYS;
  			break;
  		}
-		spin_unlock_irq(&current->sighand->siglock);
+		spin_unlock_irq(&tsk->sighand->siglock);
  		schedule();
-		spin_lock_irq(&current->sighand->siglock);
+		spin_lock_irq(&tsk->sighand->siglock);
  	}
-	spin_unlock_irq(&current->sighand->siglock);
+	spin_unlock_irq(&tsk->sighand->siglock);
  
-	remove_wait_queue(&current->sighand->signalfd_wqh, &wait);
+	remove_wait_queue(&tsk->sighand->signalfd_wqh, &wait);
  	__set_current_state(TASK_RUNNING);
  
+	signalfd_put_task(ctx, tsk);
  	return ret;
  }
  
@@ -267,19 +296,24 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
  	/* Check the SFD_* constants for consistency.  */
  	BUILD_BUG_ON(SFD_CLOEXEC != O_CLOEXEC);
  	BUILD_BUG_ON(SFD_NONBLOCK != O_NONBLOCK);
+	BUILD_BUG_ON(SFD_TASK & (SFD_CLOEXEC | SFD_NONBLOCK));
  
-	if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK))
+	if (flags & ~(SFD_CLOEXEC | SFD_NONBLOCK | SFD_TASK))
+		return -EINVAL;
+	if ((flags & (SFD_CLOEXEC | SFD_TASK)) == SFD_TASK)
  		return -EINVAL;
  
  	sigdelsetmask(mask, sigmask(SIGKILL) | sigmask(SIGSTOP));
  	signotset(mask);
  
  	if (ufd == -1) {
-		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
  		if (!ctx)
  			return -ENOMEM;
  
  		ctx->sigmask = *mask;
+		if (flags & SFD_TASK)
+			ctx->task_pid = get_task_pid(current, PIDTYPE_PID);
  
  		/*
  		 * When we call this, the initialization must be complete, since
@@ -290,6 +324,7 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
  		if (ufd < 0)
  			kfree(ctx);
  	} else {
+		struct task_struct *tsk;
  		struct fd f = fdget(ufd);
  		if (!f.file)
  			return -EBADF;
@@ -298,11 +333,17 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
  			fdput(f);
  			return -EINVAL;
  		}
-		spin_lock_irq(&current->sighand->siglock);
+		tsk = signalfd_get_task(ctx);
+		if (!tsk) {
+			fdput(f);
+			return -ESRCH;
+		}
+		spin_lock_irq(&tsk->sighand->siglock);
  		ctx->sigmask = *mask;
-		spin_unlock_irq(&current->sighand->siglock);
+		spin_unlock_irq(&tsk->sighand->siglock);
  
-		wake_up(&current->sighand->signalfd_wqh);
+		wake_up(&tsk->sighand->signalfd_wqh);
+		signalfd_put_task(ctx, tsk);
  		fdput(f);
  	}
  
diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
index 83429a05b698..064c5dc3eb99 100644
--- a/include/uapi/linux/signalfd.h
+++ b/include/uapi/linux/signalfd.h
@@ -16,6 +16,7 @@
  /* Flags for signalfd4.  */
  #define SFD_CLOEXEC O_CLOEXEC
  #define SFD_NONBLOCK O_NONBLOCK
+#define SFD_TASK 00000001
  
  struct signalfd_siginfo {
  	__u32 ssi_signo;

-- 
Jens Axboe

