Return-Path: <linux-fsdevel+bounces-49582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522EEABF88B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636F74E64E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDBE213E94;
	Wed, 21 May 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FaWZvNGI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5NoVv3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC520FA98;
	Wed, 21 May 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839205; cv=none; b=QthTmGid/Gkecah5j/7GSiXd0CrflgvDYArTsYqeDerVB9XogzSnIRRx85Tp5V1VrChoObnG2LRTUUjnk+iHyyPVv/Gyw1lEnGj3QNmPaP53CgprM54UBukVyadp1Hgxwb2uJ6mXMPcL+8W4daVINIhd15snxwLizS4HuhqQBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839205; c=relaxed/simple;
	bh=HdHZ+GZxvRQ8ukrgIxElrOk6u+xpJOILJEbe3C7fOtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYeBfwXynndcCh6R8z9OOSTJO9Mgu73MdLlQidu6U1KuGZlawkXKcCcf1oYDFxqDmOfPNzl1KJ4y75sHfSrufkuF+RpI7yD4FOsKtMYfke+qgTgnTxN3DFuTr34lKtQP+wTOVWBRKlFZyE8k37nHF/n3pOWeGsrWxzw5TBvY7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FaWZvNGI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5NoVv3J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 16:53:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747839201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D86Wz2y6QUxOmJHz72oCX5H2kzf71CnW/bwyrbGaFDk=;
	b=FaWZvNGIv1or7u8xnJbhu5qwENB/o38MU3LLx+maV/xJRYZbHj+pVsm+J0IfjK4wG7pjaE
	/XZakmIoWiU2Y49oDr+vWpR4Hp0u8h/9gAiE6LNrHPjaTiF0Gka68ww449sDGAGrHLlVnc
	8sSXrChrI8ETBcmWuFVYpUKK3Hxq5StzLFO5q3Z1GXnQky22gFsqhfaL8HDKkpkxktvM8x
	qwgHG4ej4uG8Gp44N67jYj2hRRTOHzcdj+pysc1unfg2+MVzIvmxqVWu0/owhiw7nL37Qg
	O+3ChZ4AwmIBzCqaNN8tgF8R/86rXDImNVVOokFcfKWThGSgtPDUr9qoywXd1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747839201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D86Wz2y6QUxOmJHz72oCX5H2kzf71CnW/bwyrbGaFDk=;
	b=v5NoVv3J3aBrPArsCIRill2BVfiTV3wWC/KlMvAlGXX36r9WA4OPXDoV/cH4HHQmGNJiIW
	MRb6+y1IHg3cPNAQ==
From: Nam Cao <namcao@linutronix.de>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] eventpoll: Fix priority inversion problem
Message-ID: <20250521145320.oqUIOaRG@linutronix.de>
References: <20250519074016.3337326-1-namcao@linutronix.de>
 <xhsmh8qmq9h37.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh8qmq9h37.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Wed, May 21, 2025 at 04:25:00PM +0200, Valentin Schneider wrote:
> On 19/05/25 09:40, Nam Cao wrote:
> > @@ -136,14 +136,28 @@ struct epitem {
> >               struct rcu_head rcu;
> >       };
> >
> > -	/* List header used to link this structure to the eventpoll ready list */
> > -	struct list_head rdllink;
> > +	/*
> > +	 * Whether this item can be added to the eventpoll ready list. Adding to the list can be
> > +	 * blocked for two reasons:
> > +	 *
> > +	 *  1. This item is already on the list.
> > +	 *  2. A waiter is consuming the ready list and has consumed this item. The waiter therefore
> > +	 *     is blocking this item from being added again, preventing seeing the same item twice.
> > +	 *     If adding is blocked due to this reason, the waiter will add this item to the list
> > +	 *     once consuming is done.
> > +	 */
> > +	bool link_locked;
> 
> Nit: IIUC it's not just the readylist, it's anytime the link is used
> (e.g. to punt it on a txlist), so how about:
> 
>         /*
>          * Whether epitem.rdllink is currently used in a list. When used, it
>          * cannot be detached or inserted elsewhere.
>          *
>          * It may be in use for two reasons:
>          *
>          * 1. This item is on the eventpoll ready list
>          * 2. This item is being consumed by a waiter and stashed on a temporary
>          *    list. If adding is blocked due to this reason, the waiter will add
>          *    this item to the list once consuming is done.
>          */
>          bool link_used;

Acked.

> >
> >       /*
> > -	 * Works together "struct eventpoll"->ovflist in keeping the
> > -	 * single linked chain of items.
> > +	 * Indicate whether this item is ready for consumption. All items on the ready list has this
> > +	 * flag set. Item that should be on the ready list, but cannot be added because of
> > +	 * link_locked (in other words, a waiter is consuming the ready list), also has this flag
> > +	 * set. When a waiter is done consuming, the waiter will add ready items to the ready list.
> >        */
> > -	struct epitem *next;
> > +	bool ready;
> > +
> > +	/* List header used to link this structure to the eventpoll ready list */
> > +	struct llist_node rdllink;
> >
> >       /* The file descriptor information this item refers to */
> >       struct epoll_filefd ffd;
> 
> > @@ -361,10 +368,27 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
> >               (p1->file < p2->file ? -1 : p1->fd - p2->fd));
> >  }
> >
> > -/* Tells us if the item is currently linked */
> > -static inline int ep_is_linked(struct epitem *epi)
> > +static void epitem_ready(struct epitem *epi)
> >  {
> > -	return !list_empty(&epi->rdllink);
> > +	/*
> > +	 * Mark it ready, just in case a waiter is blocking this item from going into the ready
> > +	 * list. This will tell the waiter to add this item to the ready list, after the waiter is
> > +	 * finished.
> > +	 */
> > +	xchg(&epi->ready, true);
> 
> Perhaps a stupid question, why use an xchg() for .ready and .link_locked
> (excepted for that epitem_ready() cmpxchg()) writes when the return value
> is always discarded? Wouldn't e.g. smp_store_release() suffice, considering
> the reads are smp_load_acquire()?

That's me being stupid, smp_store_release() is good enough.

> > +
> > +	/*
> > +	 * If this item is not blocked, add it to the ready list. This item could be blocked for two
> > +	 * reasons:
> > +	 *
> > +	 * 1. It is already on the ready list. Then nothing further is required.
> > +	 * 2. A waiter is consuming the ready list, and has consumed this item. The waiter is now
> > +	 *    blocking this item, so that this item won't be seen twice. In this case, the waiter
> > +	 *    will add this item to the ready list after the waiter is finished.
> > +	 */
> > +	if (!cmpxchg(&epi->link_locked, false, true))
> > +		llist_add(&epi->rdllink, &epi->ep->rdllist);
> > +
> >  }
> >
> >  static inline struct eppoll_entry *ep_pwq_from_wait(wait_queue_entry_t *p)
> 
> > @@ -1924,19 +1874,39 @@ static int ep_send_events(struct eventpoll *ep,
> >                        * Trigger mode, we need to insert back inside
> >                        * the ready list, so that the next call to
> >                        * epoll_wait() will check again the events
> > -			 * availability. At this point, no one can insert
> > -			 * into ep->rdllist besides us. The epoll_ctl()
> > -			 * callers are locked out by
> > -			 * ep_send_events() holding "mtx" and the
> > -			 * poll callback will queue them in ep->ovflist.
> > +			 * availability.
> >                        */
> > -			list_add_tail(&epi->rdllink, &ep->rdllist);
> > +			xchg(&epi->ready, true);
> > +		}
> > +	}
> > +
> > +	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
> > +		/*
> > +		 * We are done iterating. Allow the items we took to be added back to the ready
> > +		 * list.
> > +		 */
> > +		xchg(&epi->link_locked, false);
> > +
> > +		/*
> > +		 * In the loop above, we may mark some items ready, and they should be added back.
> > +		 *
> > +		 * Additionally, someone else may also attempt to add the item to the ready list,
> > +		 * but got blocked by us. Add those blocked items now.
> > +		 */
> > +		if (smp_load_acquire(&epi->ready)) {
> >                       ep_pm_stay_awake(epi);
> > +			epitem_ready(epi);
> >               }
> 
> Isn't this missing a:
> 
>                 list_del_init(&epi->rdllink);
> 
> AFAICT we're always going to overwrite that link when next marking the item
> as ready, but I'd say it's best to exit this with a clean state. That would
> have to be before the clearing of link_locked so it doesn't race with a
> concurrent epitem_ready() call.

To confirm I understand you: there is no functional problem, and your
comment is more of a "just to be safe"?

Thanks so much for the review,
Nam

