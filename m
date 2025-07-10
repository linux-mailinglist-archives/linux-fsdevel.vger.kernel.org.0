Return-Path: <linux-fsdevel+bounces-54427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA61AFF99D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664233ABB99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3974287508;
	Thu, 10 Jul 2025 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0VcIind";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WNlullci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775871F948;
	Thu, 10 Jul 2025 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128493; cv=none; b=Z3WBAK64J2OmiJmJbrK+yaWmEuTuFgJ5if6DTvzcQFlwcWni/cCJ80FDklv1sGrtEzWzSe6XPaPox3U55BAYCLcHzF2IPZ5un7Jbg9y/gMGLpCHCRGVHpvwW9qRddztqBwW1PA+bQuAJPHIhn/KbigKXSJwGpQfKZLgDquueos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128493; c=relaxed/simple;
	bh=HKk1TXT/elCUckABOi7nQjnbhFAoy0ksCF6kdatm9S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJZvcv1upWMXnT50VA03UVSdsc7dlqaktZb+g2044E04X22SX8loUGlmg5tbYCbOspJcIyRP/gKWC/e8s0t3pCLJe4uE1eBAPjQybFSYqm7eTl8709NYdVdHZXVNqIjYTMCZ54Dn1dvVLYWe5uNwRJ2L0/wfJfv9ZRAsIIg4w04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0VcIind; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WNlullci; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 08:21:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752128489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoVDFEhzdw4xLmQyVO2AhjEgBOLroUBOpc+jt0DrQQ8=;
	b=u0VcIindh9wkQ4btLIM4EIkuqFd0y7fVkxQh87q1QAgVkogt8WP1FvOcpUDRX8nyvVbYuM
	Ahpj1z77RZdNV9YzINUwBC65H4HR3vsuDzEhgo84W02v7dAD7mspETwNAGgfQ2tEwktDZJ
	gS8AFDhR0cmg667iEkIa9tZvtPgi4Z2jCCX0KZq2Of7whG+XOx4Rnm/0QxUVWguBnR0YUe
	c09SRiG0SuYtoeTB5eyfRdx05ix+qKcFpJe4pEQ/Y1qFbFwlNmvt2KL34RUb2rR9H2HUie
	huxiBXnokVyV7Ejx0YBBGKO7irHaTCTdjc+yKNNZW9YCvJeptKrKFh+P3R6xdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752128489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoVDFEhzdw4xLmQyVO2AhjEgBOLroUBOpc+jt0DrQQ8=;
	b=WNlullciP7Aizocv9Sd+z3qURZ/QTbs22xiC17wMCXtGTg/UQs3RUx9CUeUepqFiglONEg
	g3obNyvyIra+FZAg==
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
Message-ID: <20250710062127.QnaeZ8c7@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250701-wochen-bespannt-33e745d23ff6@brauner>
 <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
 <20250710034805.4FtG7AHC@linutronix.de>
 <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>

On Thu, Jul 10, 2025 at 11:08:18AM +0800, Xi Ruoyao wrote:
> After upgrading my kernel to the recent mainline I've encountered some
> stability issue, like:
> 
> - When GDM started gnome-shell, the screen often froze and the only
> thing I could do was to switch into a VT and reboot.
> - Sometimes gnome-shell started "fine" but then starting an application
> (like gnome-console) needed to wait for about a minute.
> - Sometimes the system shutdown process hangs waiting for a service to
> stop.
> - Rarely the system boot process hangs for no obvious reason.
> 
> Most strangely in all the cases there are nothing alarming in dmesg or
> system journal.
> 
> I'm unsure if this is the culprit but I'm almost sure it's the trigger.
> Maybe there's some race condition in my userspace that the priority
> inversion had happened to hide...  but anyway reverting this patch
> seemed to "fix" the issue.
> 
> Any thoughts or pointers to diagnose further?

I have been running this new epoll on my work machine for weeks by now
without issue, while you seem to reproduce it reliably. I'm guessing that
the problem is on some code path which is dead on my system, but executed
on yours.

I am curious if Gnome is using some epoll options which are unused on my
system.

I presume you can still access dmesg despite the freeze. Do you mind
running the below patch, let me know what's in your dmesg? It may help
identifying that code path.

Best regards,
Nam

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 895256cd2786..e3dafc48a59a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -532,6 +532,9 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 		WRITE_ONCE(ep->busy_poll_usecs, epoll_params.busy_poll_usecs);
 		WRITE_ONCE(ep->busy_poll_budget, epoll_params.busy_poll_budget);
 		WRITE_ONCE(ep->prefer_busy_poll, epoll_params.prefer_busy_poll);
+		printk("%s busy_poll_usecs=%d busy_poll_budget=%d prefer_busy_poll=%d\n",
+			__func__, epoll_params.busy_poll_usecs, epoll_params.busy_poll_budget,
+			epoll_params.prefer_busy_poll);
 		return 0;
 	case EPIOCGPARAMS:
 		memset(&epoll_params, 0, sizeof(epoll_params));
@@ -2120,6 +2123,9 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	struct epitem *epi;
 	struct eventpoll *tep = NULL;
 
+	printk("%s: epfd=%d op=%d fd=%d events=0x%x data=0x%llx nonblock=%d\n",
+		__func__, epfd, op, fd, epds->events, epds->data, nonblock);
+
 	CLASS(fd, f)(epfd);
 	if (fd_empty(f))
 		return -EBADF;
diff --git a/io_uring/epoll.c b/io_uring/epoll.c
index 8d4610246ba0..e9c33c0c8cc5 100644
--- a/io_uring/epoll.c
+++ b/io_uring/epoll.c
@@ -54,6 +54,8 @@ int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
 	int ret;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 
+	printk("%s flags=0x%x\n", __func__, issue_flags);
+
 	ret = do_epoll_ctl(ie->epfd, ie->op, ie->fd, &ie->event, force_nonblock);
 	if (force_nonblock && ret == -EAGAIN)
 		return -EAGAIN;

