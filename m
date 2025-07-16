Return-Path: <linux-fsdevel+bounces-55110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772FB06F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B01659C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B95428DB54;
	Wed, 16 Jul 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tD8cN2xN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7sLjV2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42928C00D;
	Wed, 16 Jul 2025 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651676; cv=none; b=spLkT5e50rrGBJNIxQjaBDC+wma/upEpXAKEOnS3EJmgVMxXECupNj7HvnBPfpk0m8b6j8Pdehkz80LloMRR8QNeRFCEdgPochmv1WNJ7lfRD4Zz/0Xht6OVCg0urBPh/cVzKXwt4gXOY50eXsRA341fWitBBLu93f8Qf7ZIr3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651676; c=relaxed/simple;
	bh=7tLvQT4ajAYz8L2kE7Rd//y+9tF8RvMJqJqaL8Qg1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgPB/Z9D7Yh0zrug09E4n3Lub2kQXxfi+ylKT89Kzw4tCOvHwidzGziD0iD18O4Fc8Tzl3uMspvFqOawYz93gTB0WJ9dlWeZ3ntMiAGNOzG9ibLaxBrIK6ABALZlarxhGEiEdiZtF25RpGmBTUGKTISuxggkXzlc3uOxptpy5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tD8cN2xN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7sLjV2z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 09:41:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752651672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgwJrdiNOObJR6kCFcttJ7IUEoM+Yb14XVp75zVk58k=;
	b=tD8cN2xNnCAqUZh5XcNaMwn+byVnz2K5nP5G3TYtrRlAkyADjGxw+rE0uBNf/kyFYDzFa1
	bVZDvoOp3AJd9zVQ2UF6owcvmMTX0Jsh6tU992Y39wG/MG9o6EM3xma+sm21oKMznHqBIc
	mZorfBGb1lphqH17+J9fSxZUYL8lhEtV1ySR1c8ZhlAaotLB7pUF2IteVGys3YBxSs+VjI
	jF4by7tL7/hO7TAGhZG21xFEz0CsDnn4W0S4nMFyhyI8vkJt1oseSEhjoquWRkZUsrAETH
	pyLihMBYv2PDEINi8Jyj+OvI6afWwcUUghOOMl/rYiqE1XhyWLyWXV+A+bt33Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752651672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgwJrdiNOObJR6kCFcttJ7IUEoM+Yb14XVp75zVk58k=;
	b=Q7sLjV2z0D1AsbtLNbqAfLF4/7R9i0u8ircXmcQ8URApMlFJulJ16IcVCuG+i8DMFRGT95
	ucI7vdlm9ebQKHDg==
From: Nam Cao <namcao@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
Message-ID: <20250716074110.AY8PBtBi@linutronix.de>
References: <cover.1752581388.git.namcao@linutronix.de>
 <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
 <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>

On Tue, Jul 15, 2025 at 09:42:52AM -0700, Linus Torvalds wrote:
> On Tue, 15 Jul 2025 at 05:47, Nam Cao <namcao@linutronix.de> wrote:
> >
> >  fs/eventpoll.c | 139 +++++++++----------------------------------------
> >  1 file changed, 26 insertions(+), 113 deletions(-)
> 
> Yeah, this is more like the kind of diffstat I like to see for
> eventpoll. Plus it makes things fundamentally simpler.
> 
> It might be worth looking at ep_poll_callback() - the only case that
> had read_lock_irqsave() - and seeing if perhaps some of the tests
> inside the lock might be done optimistically, or delayed to after the
> lock.
> 
> For example, the whole wakeup sequence looks like it should be done
> *after* the ep->lock has been released, because it uses its own lock
> (ie the
> 
>                 if (sync)
>                         wake_up_sync(&ep->wq);
>                 else
>                         wake_up(&ep->wq);
> 
> thing uses the wq lock, and there is nothing that ep->lock protects
> there as far as I can tell.
> 
> So I think this has some potential for _simple_ optimizations, but I'm
> not sure how worth it it is.

Actually ep->lock does protect this part. Because ep_poll() touches ep->wq
without holding the waitqueue's lock.

We could do something like the diff below. But things are not so simple
anymore.

Best regards,
Nam

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a171f7e7dacc..5e6c7da606e7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1252,8 +1252,6 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	unsigned long flags;
 	int ewake = 0;
 
-	spin_lock_irqsave(&ep->lock, flags);
-
 	ep_set_busy_poll_napi_id(epi);
 
 	/*
@@ -1263,7 +1261,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * until the next EPOLL_CTL_MOD will be issued.
 	 */
 	if (!(epi->event.events & ~EP_PRIVATE_BITS))
-		goto out_unlock;
+		goto out;
 
 	/*
 	 * Check the events coming with the callback. At this stage, not
@@ -1272,7 +1270,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * test for "key" != NULL before the event match test.
 	 */
 	if (pollflags && !(pollflags & epi->event.events))
-		goto out_unlock;
+		goto out;
 
 	/*
 	 * If we are transferring events to userspace, we can hold no locks
@@ -1280,6 +1278,8 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * semantics). All the events that happen during that period of time are
 	 * chained in ep->ovflist and requeued later on.
 	 */
+	spin_lock_irqsave(&ep->lock, flags);
+
 	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
 		if (epi->next == EP_UNACTIVE_PTR) {
 			epi->next = READ_ONCE(ep->ovflist);
@@ -1292,9 +1292,14 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		ep_pm_stay_awake_rcu(epi);
 	}
 
+	spin_unlock_irqrestore(&ep->lock, flags);
+
+
 	/*
 	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
 	 * wait list.
+	 *
+	 * Memory barrier for waitqueue_active() from spin_unlock_irqrestore().
 	 */
 	if (waitqueue_active(&ep->wq)) {
 		if ((epi->event.events & EPOLLEXCLUSIVE) &&
@@ -1321,9 +1326,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
 
-out_unlock:
-	spin_unlock_irqrestore(&ep->lock, flags);
-
+out:
 	/* We have to call this outside the lock */
 	if (pwake)
 		ep_poll_safewake(ep, epi, pollflags & EPOLL_URING_WAKE);
@@ -2001,13 +2004,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		init_wait(&wait);
 		wait.func = ep_autoremove_wake_function;
 
-		spin_lock_irq(&ep->lock);
-		/*
-		 * Barrierless variant, waitqueue_active() is called under
-		 * the same lock on wakeup ep_poll_callback() side, so it
-		 * is safe to avoid an explicit barrier.
-		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		prepare_to_wait_exclusive(&ep->wq, &wait, TASK_INTERRUPTIBLE);
 
 		/*
 		 * Do the final check under the lock. ep_start/done_scan()
@@ -2016,10 +2013,8 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * period of time although events are pending, so lock is
 		 * important.
 		 */
+		spin_lock_irq(&ep->lock);
 		eavail = ep_events_available(ep);
-		if (!eavail)
-			__add_wait_queue_exclusive(&ep->wq, &wait);
-
 		spin_unlock_irq(&ep->lock);
 
 		if (!eavail)
@@ -2036,7 +2031,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		eavail = 1;
 
 		if (!list_empty_careful(&wait.entry)) {
-			spin_lock_irq(&ep->lock);
+			spin_lock_irq(&ep->wq.lock);
 			/*
 			 * If the thread timed out and is not on the wait queue,
 			 * it means that the thread was woken up after its
@@ -2047,7 +2042,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			if (timed_out)
 				eavail = list_empty(&wait.entry);
 			__remove_wait_queue(&ep->wq, &wait);
-			spin_unlock_irq(&ep->lock);
+			spin_unlock_irq(&ep->wq.lock);
 		}
 	}
 }

