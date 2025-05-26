Return-Path: <linux-fsdevel+bounces-49835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDBFAC3956
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 07:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8151893A95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 05:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB21D1C6FF5;
	Mon, 26 May 2025 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PktyAzPG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5mklkIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AA136349;
	Mon, 26 May 2025 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237951; cv=none; b=qvl9UpWIUSEDcSKcq71ckYPfmst8apk/+fawIDrvMA6+5cXmlgTd0hBv9V7Yr8PygTy3qQCY3X09CofvX2yoZ6Hj1Dp+3Ia6aq3JnNoPJ9cB/87nWg6hfMyfCSqxqH3TlUTsuaLw6j/6BQEoBTTXhlKscOgBugcWau12wje/3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237951; c=relaxed/simple;
	bh=bvi9/AnhH38DquhZv0IqLUVYPmYVpjwwJgZnzK0ONZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfw0Xwb/YrZGqb1NDG//cUEw0k/Z/jcI7LzRgaiWeZUq6lRIwkMNrp3HWbKWSmrKF/iA+kgQ5V8Vumo8FQnOZj0aws/B2EgteZ0m5nESQDyGyC3OVCOWVcluzwt54Z2ylAWJpqKmh6Gzq3FRXkU+zKurP/+MZ8IJOD9gXTrinlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PktyAzPG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5mklkIN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 May 2025 07:39:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748237945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFwlwfcUWsrciv3uqI5GflyLPzZ54rN6yZqsSqBaoTY=;
	b=PktyAzPGgeoAdDzdgI+++hZu7fMbjfr6H+099v4my+y4508n4MJtiQACCvEsFZ3xAct+gU
	boRl35+QrYJPScjva4DLTwapEu9rpM9aBpbLIplcNApH5gkBmhOz1B2Uokyfv69V6uUsBx
	TEQotNpT9xs+PXbjnouMYjcjNHqty81ZRuhCNWfrezU2GdSPqfZUbPpujlj+gBL8qcOZn1
	PES5mgYalFB+A3xxG/pQNBJVn4VKiDlZ5yU425BnpA9itXXPxGOfubOiR9RKUGSNab3xsE
	ts9jPCucocoCFAVeR9ccxiZje1e3VguAAbTdaz7RnnAj+xhRXAN/mL0du1KE4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748237945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFwlwfcUWsrciv3uqI5GflyLPzZ54rN6yZqsSqBaoTY=;
	b=L5mklkINJ3LFQ0YLlGpTfMRx3J90rM/lyphpIJf4TmO140xAbC8rlZUug/3iyyK6EV/Oa2
	JWUZ6azxdyj8UqAw==
From: Nam Cao <namcao@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] eventpoll: Fix priority inversion problem
Message-ID: <20250526053900.asTaMltl@linutronix.de>
References: <20250523061104.3490066-1-namcao@linutronix.de>
 <20250523122611.Q64SSO7S@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523122611.Q64SSO7S@linutronix.de>

On Fri, May 23, 2025 at 02:26:11PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-05-23 08:11:04 [+0200], Nam Cao wrote:
> On the AMD I tried
> Unpatched:
> | $ perf bench epoll all 2>&1 | grep -v "^\["
> | # Running epoll/wait benchmark...
> | Run summary [PID 3019]: 255 threads monitoring on 64 file-descriptors for 8 secs.
> |
> |
> | Averaged 785 operations/sec (+- 0.05%), total secs = 8
> |
> | # Running epoll/ctl benchmark...
> | Run summary [PID 3019]: 256 threads doing epoll_ctl ops 64 file-descriptors for 8 secs.
> |
> |
> | Averaged 2652 ADD operations (+- 1.19%)
> | Averaged 2652 MOD operations (+- 1.19%)
> | Averaged 2652 DEL operations (+- 1.19%)
> 
> Patched:
> | $ perf bench epoll all 2>&1 | grep -v "^\["
> | # Running epoll/wait benchmark...
> | Run summary [PID 3001]: 255 threads monitoring on 64 file-descriptors for 8 secs.
> | 
> | 
> | Averaged 1386 operations/sec (+- 3.94%), total secs = 8
> | 
> | # Running epoll/ctl benchmark...
> | Run summary [PID 3001]: 256 threads doing epoll_ctl ops 64 file-descriptors for 8 secs.
> | 
> | 
> | Averaged 1495 ADD operations (+- 1.11%)
> | Averaged 1495 MOD operations (+- 1.11%)
> | Averaged 1495 DEL operations (+- 1.11%)
> 
> The epoll_waits improves again, epoll_ctls does not. I'm not sure how to
> read the latter. My guess would be that ADD/ MOD are fine but DEL is a
> bit bad because it has to del, iterate, …, add back.

Yeah EPOLL_CTL_DEL is clearly worse. But epoll_ctl() is not
performance-critical, so I wouldn't worry about it.

> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index d4dbffdedd08e..483a5b217fad4 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -136,14 +136,29 @@ struct epitem {
> >  		struct rcu_head rcu;
> >  	};
> >  
> > -	/* List header used to link this structure to the eventpoll ready list */
> > -	struct list_head rdllink;
> > +	/*
> > +	 * Whether epitem.rdllink is currently used in a list. When used, it cannot be detached or
> 
> Notation wise I would either use plain "rdllink" or the C++ notation
> "epitem::rdllink".
> 
> > +	 * inserted elsewhere.
> 
> When set, it is attached to eventpoll::rdllist and can not be attached
> again.
> This nothing to do with detaching.
> 
> > +	 * It may be in use for two reasons:
> > +	 *
> > +	 * 1. This item is on the eventpoll ready list.
> > +	 * 2. This item is being consumed by a waiter and stashed on a temporary list. If inserting
> > +	 *    is blocked due to this reason, the waiter will add this item to the list once
> > +	 *    consuming is done.
> > +	 */
> > +	bool link_used;
> >  
> >  	/*
> > -	 * Works together "struct eventpoll"->ovflist in keeping the
> > -	 * single linked chain of items.
> > +	 * Indicate whether this item is ready for consumption. All items on the ready list has this
>                                                                                            have
> > +	 * flag set. Item that should be on the ready list, but cannot be added because of
> > +	 * link_used (in other words, a waiter is consuming the ready list), also has this flag
> > +	 * set. When a waiter is done consuming, the waiter will add ready items to the ready list.
> 
> This sounds confusing. What about:
> 
> | Ready items should be on eventpoll::rdllist. This might be not the case
> | if a waiter is consuming the list and removed temporary all items while
> | doing so. Once done, the item will be added back to eventpoll::rdllist.
> 
> The reason is either an item is removed from the list and you have to
> remove them all, look for the right one, remove it from the list, splice
> what is left to the original list.
> I did not find another reason for that.

Thanks for the comments. However, while looking at them again, I think I
complicate things with these flags.

Instead of "link_used", I could take advantage of llist_node::next. Instead
of "ready", I could do another ep_item_poll().

Therefore I am removing them for v3, then there won't be any more confusion
with these flags.

Thanks for the review, I will resolve your other comments in v3.
Nam

