Return-Path: <linux-fsdevel+bounces-54446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A3AFFC74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB507BF078
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC128CF5F;
	Thu, 10 Jul 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wbVYBay2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u79uacZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDC212B28;
	Thu, 10 Jul 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136362; cv=none; b=i7kbwmxJfQ6Y+l/XXmjGha9S5HfKtAzYlSW60IlxHObukNnfeYL2F2mRP1pe4q1d4Mqk341ZUk+1SjfauogJFZKa2ch9+HxVpYNYDSenvwQrqL6HvEE/iysoiHhfAf6PyPQKWkIUb83WIxz4VeKlUPKd+E9QDIXIMuSUoq0ZUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136362; c=relaxed/simple;
	bh=Ek4BpA+GydLM0dETCP7Ag2Ju3QLuMtoN1MvWTFcHuX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHCvkRUDfIBvOd13IfaCbLInnW0epR0g1MeuQYUZMMWlXdKX29h5za8nm/NC+Jhgb39FGxwhFXEyiFMkNGaa3nPTkeWf23re4UnPvllCHzzxqmAH1dEUctEaNgACXgLeiNTS1UiiFZ9gHDYfOSAJimlLNcctjB+hszCUfDKmL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wbVYBay2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u79uacZK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 10:32:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752136358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ji6yaYEXe7yuZbmagaPWJavr5SkVHgUp4aZABDeNCkk=;
	b=wbVYBay2b/UYpVaLp4+inEHZmdLIZeshr728ej65/o6x6CQwyoCzAzy4Un36DrNOnYFUOa
	+cDuX1UDNcwK3KXn5F/YZr8InlVMQYeQDom6zN2OdOJMgicRXP9hwUYneHAeSapq9iEFyg
	/ijfMwVPuQszhtbFAusMqSViwIJxIaQlZNKLXaWRYmRT73VEKeeOcgbU8NPXv/BfS8XKYP
	gJrncmLtoo2U49sX26lpgpieYioKtvmzXTjHjfFMR/XlIubhJCt7WSLYLtwYJeXuN/vR7i
	R8LWi13fPc5GlxKWkYOjjv1Lfa3yTLvp87//hh8njmnXawjpN/l5jSPzGpQfoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752136358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ji6yaYEXe7yuZbmagaPWJavr5SkVHgUp4aZABDeNCkk=;
	b=u79uacZKlgHStnKIWeeR4vn8TbEUPphs+t9dcomh1VsOFby8/1TWxBKSPSV1kH8ThDVhgT
	cV/yI3rQZGZzD9CA==
From: Nam Cao <namcao@linutronix.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250710083236.V8WA6EFF@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250701-wochen-bespannt-33e745d23ff6@brauner>
 <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
 <20250710034805.4FtG7AHC@linutronix.de>
 <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>

On Thu, Jul 10, 2025 at 02:54:06PM +0800, Xi Ruoyao wrote:
> On Thu, 2025-07-10 at 08:21 +0200, Nam Cao wrote:
> > I am curious if Gnome is using some epoll options which are unused on my
> > system.
> 
> > I presume you can still access dmesg despite the freeze. Do you mind
> > running the below patch, let me know what's in your dmesg? It may help
> > identifying that code path.
> 
> Attached the system journal (dmesg was truncated due to too many lines).
> I guess the relevant part should be between line 6947 ("New session 2 of
> user xry111") and line 8022 ("start operation timed out. Terminating").

Thanks! I have an idea..

Looking at the boot log you sent, I noticed some time gap immediately after
EPOLL_CTL_DEL.

So I looked at EPOLL_CTL_DEL again, and noticed something that could
explain your timed out issue:

  1. EPOLL_CTL_DEL may need to temporarily remove the entire event list.

  2. While the above is happening, another task may do epoll_wait(). It sees
     nothing in the event list, and goes to sleep.

  3. EPOLL_CTL_DEL is now finished and puts the items back into the event
     list. However, the task from (2.) is not woken up, therefore it keep
     sleeping despite there are events available.

If this is really what causing you problem, the below patch should fix it:


diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 895256cd2786..a8fb8ec51751 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -813,8 +813,13 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 				put_back_last = n;
 			__llist_add(n, &put_back);
 		}
-		if (put_back_last)
+		if (put_back_last) {
 			llist_add_batch(put_back.first, put_back_last, &ep->rdllist);
+
+			/* borrow the memory barrier from llist_add_batch() */
+			if (waitqueue_active(&ep->wq))
+				wake_up(&ep->wq);
+		}
 	}
 
 	wakeup_source_unregister(ep_wakeup_source(epi));

