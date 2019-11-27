Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0016510A9D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 06:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfK0FLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 00:11:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43553 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfK0FLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:11:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id q16so5020964plr.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 21:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=3WUZxNq/iUK4LqDCwROiTaUO/Kf6cWdZbuCr5MlpkgY=;
        b=TOMvLyVWWpSppZapKy91zhWlqSeGklWcw5WyFHKA9sh5SXIhBwvsCLx48XeEG8Zj71
         pdO2Axp4rnZCvUDLT6eLzrm6nZM0UHzDqYqoOgMgXy6KClk9Xfr8ljoH7WnW2k3dIfUU
         Ujq+xA4F2V5mD64JYyZv7/zunRj8fEx6tvO+r++7M+Cd0+S57tSygw+4QEK23CjZ1Sbh
         PTdLqGV/fHOUtDr6p4LOO90hYQ7+Zx/PUzEbYSG96VpBs529byKt6a8uupjEfbgDSUXb
         coIA4H6QzxhXRb2BjHtV/cM6CWWbJDMQAKGA7+Nqo0p1tRhL82J7Eb0FNIOYuLwZ0Lgl
         DeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=3WUZxNq/iUK4LqDCwROiTaUO/Kf6cWdZbuCr5MlpkgY=;
        b=h/QQr9+8NbM5cOizsAlYFLPGY9I/iN0FG8mWU2hYh8fkUFilCQcGHNUzqIZ1WIIf51
         drQ55sU9Rux2hvXTaFNDfp4YeqRZX7p98IIIrpyTULioc5hs/1c0BPtMT3Z0QxWpirqz
         K7udSCS9bCKxZOVhzSFdnk3V3WV1g3STi71BSIOOk1IYyVD7rZdtlDfm7mG2w6eKEBW5
         spsTx9/og5BkoPOW9p1xl/F6nZtkzeRql79k3pNw8fR+5j7rcLJNtWRbS/UyR14sDdkP
         Qu4pZvI0rvwT8kZwhJT9qv91IoX/hTWybQaVuLexE2sXgdOEbD8e7CINZl0RvICgObM8
         d6TQ==
X-Gm-Message-State: APjAAAVrYmNcQeEXG6FSsOw6H/nJhz3Zwhi4rN9z99vGZF9KZmuxtGHf
        vKzb7eaaQclRry7Xg2XZ1OZXapLaZs8=
X-Google-Smtp-Source: APXvYqx6h2w/JtfYH+geZm4TGKlsTuoAsKQ6Jt/TjbNJCmPIJr/k3aSXPBht25xi7Qv5yjMPUsh34Q==
X-Received: by 2002:a17:902:24b:: with SMTP id 69mr2080192plc.203.1574831504966;
        Tue, 26 Nov 2019 21:11:44 -0800 (PST)
Received: from ?IPv6:2600:380:491b:510:a048:61f:d592:c4b4? ([2600:380:491b:510:a048:61f:d592:c4b4])
        by smtp.gmail.com with ESMTPSA id e7sm14044590pfi.29.2019.11.26.21.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 21:11:43 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC] signalfd: add support for SFD_TASK
Message-ID: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
Date:   Tue, 26 Nov 2019 22:11:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------87DB3E5ABFD4EB218E95005E"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------87DB3E5ABFD4EB218E95005E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I posted this a few weeks back, took another look at it and refined it a
bit. I'd like some input on the viability of this approach.

A new signalfd setup flag is added, SFD_TASK. This is only valid if used
with SFD_CLOEXEC. If set, the task setting up the signalfd descriptor is
remembered in the signalfd context, and will be the one we use for
checking signals in the poll/read handlers in signalfd.

This is needed to make signalfd useful with io_uring and aio, of which
the former in particular has my interest.

I _think_ this is sane. To prevent the case of a task clearing O_CLOEXEC
on the signalfd descriptor, forking, and then exiting, we grab a
reference to the task when we assign it. If that original task exits, we
catch it in signalfd_flush() and ensure waiters are woken up. The
waiters also hold a task reference, so we don't have to wait for them to
go away.

Need to double check we can't race between original task exiting and new
task grabbing a reference. I don't think this is solid in the version
below. Probably need to add a refcount for ctx->task (the pointer, not
the task) for that.

Comments? Attaching two test programs using io_uring, one using poll and
the other read. Remove SFD_TASK from either of them, and they will fail
ala:

./signalfd-read
Timed out waiting for cqe

and with SFD_TASK set, both will exit silent with a value of 0. You need
liburing installed, then compile them with:

gcc -Wall -O2 -o signalfd-read signalfd-read.c -luring

---

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 44b6845b071c..4bbdab9438c1 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -50,28 +50,62 @@ void signalfd_cleanup(struct sighand_struct *sighand)
  
  struct signalfd_ctx {
  	sigset_t sigmask;
+	struct task_struct *task;
  };
  
+static int signalfd_flush(struct file *file, void *data)
+{
+	struct signalfd_ctx *ctx = file->private_data;
+	struct task_struct *tsk = ctx->task;
+
+	if (tsk == current) {
+		ctx->task = NULL;
+		wake_up(&tsk->sighand->signalfd_wqh);
+		put_task_struct(tsk);
+	}
+
+	return 0;
+}
+
  static int signalfd_release(struct inode *inode, struct file *file)
  {
-	kfree(file->private_data);
+	struct signalfd_ctx *ctx = file->private_data;
+
+	if (ctx->task)
+		put_task_struct(ctx->task);
+	kfree(ctx);
  	return 0;
  }
  
+static void signalfd_put_task(struct task_struct *tsk)
+{
+	put_task_struct(tsk);
+}
+
+static struct task_struct *signalfd_get_task(struct signalfd_ctx *ctx)
+{
+	struct task_struct *tsk = ctx->task ?: current;
+
+	get_task_struct(tsk);
+	return tsk;
+}
+
  static __poll_t signalfd_poll(struct file *file, poll_table *wait)
  {
  	struct signalfd_ctx *ctx = file->private_data;
+	struct task_struct *tsk = signalfd_get_task(ctx);
  	__poll_t events = 0;
  
-	poll_wait(file, &current->sighand->signalfd_wqh, wait);
+	poll_wait(file, &tsk->sighand->signalfd_wqh, wait);
  
-	spin_lock_irq(&current->sighand->siglock);
-	if (next_signal(&current->pending, &ctx->sigmask) ||
-	    next_signal(&current->signal->shared_pending,
+	spin_lock_irq(&tsk->sighand->siglock);
+	if (next_signal(&tsk->pending, &ctx->sigmask) ||
+	    next_signal(&tsk->signal->shared_pending,
  			&ctx->sigmask))
  		events |= EPOLLIN;
-	spin_unlock_irq(&current->sighand->siglock);
+	spin_unlock_irq(&tsk->sighand->siglock);
  
+	signalfd_put_task(tsk);
  	return events;
  }
  
@@ -167,10 +201,11 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
  				int nonblock)
  {
  	ssize_t ret;
+	struct task_struct *tsk = signalfd_get_task(ctx);
  	DECLARE_WAITQUEUE(wait, current);
  
-	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(current, &ctx->sigmask, info);
+	spin_lock_irq(&tsk->sighand->siglock);
+	ret = dequeue_signal(tsk, &ctx->sigmask, info);
  	switch (ret) {
  	case 0:
  		if (!nonblock)
@@ -178,29 +213,35 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
  		ret = -EAGAIN;
  		/* fall through */
  	default:
-		spin_unlock_irq(&current->sighand->siglock);
+		spin_unlock_irq(&tsk->sighand->siglock);
+		signalfd_put_task(tsk);
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
+		if (tsk != current && !ctx->task) {
+			ret = -ESRCH;
+			break;
+		}
  	}
-	spin_unlock_irq(&current->sighand->siglock);
+	spin_unlock_irq(&tsk->sighand->siglock);
  
-	remove_wait_queue(&current->sighand->signalfd_wqh, &wait);
+	remove_wait_queue(&tsk->sighand->signalfd_wqh, &wait);
  	__set_current_state(TASK_RUNNING);
  
+	signalfd_put_task(tsk);
  	return ret;
  }
  
@@ -254,6 +295,7 @@ static const struct file_operations signalfd_fops = {
  #ifdef CONFIG_PROC_FS
  	.show_fdinfo	= signalfd_show_fdinfo,
  #endif
+	.flush		= signalfd_flush,
  	.release	= signalfd_release,
  	.poll		= signalfd_poll,
  	.read		= signalfd_read,
@@ -267,19 +309,26 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
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
+		if (flags & SFD_TASK) {
+			ctx->task = current;
+			get_task_struct(ctx->task);
+		}
  
  		/*
  		 * When we call this, the initialization must be complete, since
@@ -290,6 +339,7 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
  		if (ufd < 0)
  			kfree(ctx);
  	} else {
+		struct task_struct *tsk;
  		struct fd f = fdget(ufd);
  		if (!f.file)
  			return -EBADF;
@@ -298,11 +348,13 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
  			fdput(f);
  			return -EINVAL;
  		}
-		spin_lock_irq(&current->sighand->siglock);
+		tsk = signalfd_get_task(ctx);
+		spin_lock_irq(&tsk->sighand->siglock);
  		ctx->sigmask = *mask;
-		spin_unlock_irq(&current->sighand->siglock);
+		spin_unlock_irq(&tsk->sighand->siglock);
  
-		wake_up(&current->sighand->signalfd_wqh);
+		wake_up(&tsk->sighand->signalfd_wqh);
+		signalfd_put_task(tsk);
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


--------------87DB3E5ABFD4EB218E95005E
Content-Type: text/x-csrc; charset=UTF-8;
 name="signalfd-poll.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="signalfd-poll.c"

#include <unistd.h>
#include <sys/signalfd.h>
#include <sys/poll.h>
#include <sys/time.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>

#include <liburing.h>

#define SFD_TASK	00000001

int main(int argc, char *argv[])
{
	struct __kernel_timespec ts;
	struct io_uring_sqe *sqe;
	struct io_uring_cqe *cqe;
	struct io_uring ring;
	struct itimerval itv;
	sigset_t mask;
	int sfd, ret;

	sigemptyset(&mask);
	sigaddset(&mask, SIGALRM);
	sigprocmask(SIG_BLOCK, &mask, NULL);

	sfd = signalfd(-1, &mask, SFD_CLOEXEC | SFD_TASK);
	if (sfd < 0) {
		if (errno == EINVAL) {
			printf("Not supported\n");
			return 0;
		}
		perror("signalfd");
		return 1;
	}

	memset(&itv, 0, sizeof(itv));
	itv.it_value.tv_sec = 0;
	itv.it_value.tv_usec = 100000;
	setitimer(ITIMER_REAL, &itv, NULL);

	io_uring_queue_init(32, &ring, 0);
	sqe = io_uring_get_sqe(&ring);
	io_uring_prep_poll_add(sqe, sfd, POLLIN);
	io_uring_submit(&ring);

	ts.tv_sec = 1;
	ts.tv_nsec = 0;
	ret = io_uring_wait_cqe_timeout(&ring, &cqe, &ts);
	if (ret < 0) {
		fprintf(stderr, "Timed out waiting for cqe\n");
		ret = 1;
	} else {
		if (cqe->res < 0) {
			fprintf(stderr, "cqe failed with %d\n", cqe->res);
			ret = 1;
		} else if (!(cqe->res & POLLIN)) {
			fprintf(stderr, "POLLIN not set in result mask?\n");
			ret = 1;
		} else {
			ret = 0;
		}
	}
	io_uring_cqe_seen(&ring, cqe);

	io_uring_queue_exit(&ring);
	close(sfd);
	return ret;
}

--------------87DB3E5ABFD4EB218E95005E
Content-Type: text/x-csrc; charset=UTF-8;
 name="signalfd-read.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="signalfd-read.c"

#include <unistd.h>
#include <sys/signalfd.h>
#include <sys/poll.h>
#include <sys/time.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>

#include <liburing.h>

#define SFD_TASK	00000001

int main(int argc, char *argv[])
{
	struct __kernel_timespec ts;
	struct signalfd_siginfo si;
	struct iovec iov = {
		.iov_base = &si,
		.iov_len = sizeof(si),
	};
	struct io_uring_sqe *sqe;
	struct io_uring_cqe *cqe;
	struct io_uring ring;
	struct itimerval itv;
	sigset_t mask;
	int sfd, ret;

	sigemptyset(&mask);
	sigaddset(&mask, SIGALRM);
	sigprocmask(SIG_BLOCK, &mask, NULL);

	sfd = signalfd(-1, &mask, SFD_CLOEXEC | SFD_TASK);
	if (sfd < 0) {
		if (errno == EINVAL) {
			printf("Not supported\n");
			return 0;
		}
		perror("signalfd");
		return 1;
	}

	memset(&itv, 0, sizeof(itv));
	itv.it_value.tv_sec = 0;
	itv.it_value.tv_usec = 100000;
	setitimer(ITIMER_REAL, &itv, NULL);

	io_uring_queue_init(32, &ring, 0);
	sqe = io_uring_get_sqe(&ring);
	io_uring_prep_readv(sqe, sfd, &iov, 1, 0);
	io_uring_submit(&ring);

	ts.tv_sec = 1;
	ts.tv_nsec = 0;
	ret = io_uring_wait_cqe_timeout(&ring, &cqe, &ts);
	if (ret < 0) {
		fprintf(stderr, "Timed out waiting for cqe\n");
		ret = 1;
	} else {
		ret = 0;
		if (cqe->res < 0) {
			fprintf(stderr, "cqe failed with %d\n", cqe->res);
			ret = 1;
		} else if (cqe->res != sizeof(si)) {
			fprintf(stderr, "Read %d, wanted %d\n", cqe->res, (int)sizeof(si));
			ret = 1;
		}
	}
	io_uring_cqe_seen(&ring, cqe);

	io_uring_queue_exit(&ring);
	close(sfd);
	return ret;
}

--------------87DB3E5ABFD4EB218E95005E--
