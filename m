Return-Path: <linux-fsdevel+bounces-52924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36113AE8817
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B154A7798
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E6727E059;
	Wed, 25 Jun 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZSbQ5RU7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNO6L5Y2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD425D213;
	Wed, 25 Jun 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865230; cv=none; b=EjnNLTusrZD4MIAVOho43lgUULfrOoOJmK6eXnPrO1n+01atNfoIRTqsi0Fc/rZbqmO7rOGj3fDeae5d7vvDW2QpP7ftDfbptv0kPQLXUuJSQKpUn/OmiTXBBPavp05+7xUC5ca1ehhidQ7IZTAV1XYGy8vKIcUMfrg9qTItsHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865230; c=relaxed/simple;
	bh=9SrF5F8tK2AZ8HYnqleXgGlTslsdcdNtdJjCJkcB9zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktsLJlwjCFPRbT8LTwD8Dps51g0B6IbISWNsdEtuIcdb15Gl1FyufoFZtbkuyotO5oIomMC8e67Z0uUEpxSvYZhRV03pH5UHq7fcA7R1ZdrSiBv9U6/zsLpqD3pzMZzDLtQFzCEQRZG/R2+9b/4D7aQrcvKyQytjUPG6/Q9o7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZSbQ5RU7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNO6L5Y2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 17:27:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750865227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIJ0rYAutoLD6SXbknpamg61E61NUlOCl4wh8dNG4w4=;
	b=ZSbQ5RU7Y25NMsyZbOAU0RyRDC4/1PpRn3fILezvzmgAiBNsAyXhXk+6nESltLNJ39FYYU
	WrBZB87Q0xmg4c95YT4wvu4Y9+KEXR6FwC+eOrFA7n/A4zFPXppjBWmU/cJHy9XGpvRST3
	XgRgw4qYG93HHw52wCA9Mr5f8rM86YODlw0s9BskevjrEcERZ9kLXFQloN74/a+fM2B74X
	LVojve0S3mPtXfSljYIGw+ZAPVWwKQvCIiLPhkjZkHhdl0/eYQqru1336fyPydSFr4zcYo
	tb7m6sP4p9Qxyiit5OnoHB3lRFBN7SFa9xTZfD+65NBld4hjrMGgRlFTdoi8yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750865227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIJ0rYAutoLD6SXbknpamg61E61NUlOCl4wh8dNG4w4=;
	b=uNO6L5Y2EZTzN5Kkw2C1JFhZD2laJnNCAIy5RsyzCP668jqUtn0go5tONpWaSZdu5xoRoF
	Inz8GlajmTRE35BA==
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
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250625152702.JiI8qdk-@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250625145031.GQ4Bnc4K@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625145031.GQ4Bnc4K@linutronix.de>

On Wed, Jun 25, 2025 at 04:50:31PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-05-27 11:08:36 [+0200], Nam Cao wrote:
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1867,19 +1704,18 @@ static int ep_send_events(struct eventpoll *ep,
> >  	init_poll_funcptr(&pt, NULL);
> >  
> >  	mutex_lock(&ep->mtx);
> > -	ep_start_scan(ep, &txlist);
> >  
> > -	/*
> > -	 * We can loop without lock because we are passed a task private list.
> > -	 * Items cannot vanish during the loop we are holding ep->mtx.
> > -	 */
> > -	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
> > +	while (res < maxevents) {
> >  		struct wakeup_source *ws;
> > +		struct llist_node *n;
> >  		__poll_t revents;
> >  
> > -		if (res >= maxevents)
> > +		n = llist_del_first(&ep->rdllist);
> > +		if (!n)
> >  			break;
> >  
> > +		epi = llist_entry(n, struct epitem, rdllink);
> > +
> >  		/*
> >  		 * Activate ep->ws before deactivating epi->ws to prevent
> >  		 * triggering auto-suspend here (in case we reactive epi->ws
> > @@ -1896,21 +1732,30 @@ static int ep_send_events(struct eventpoll *ep,
> >  			__pm_relax(ws);
> >  		}
> >  
> > -		list_del_init(&epi->rdllink);
> > -
> >  		/*
> >  		 * If the event mask intersect the caller-requested one,
> >  		 * deliver the event to userspace. Again, we are holding ep->mtx,
> >  		 * so no operations coming from userspace can change the item.
> >  		 */
> >  		revents = ep_item_poll(epi, &pt, 1);
> > -		if (!revents)
> > +		if (!revents) {
> > +			init_llist_node(n);
> > +
> > +			/*
> > +			 * Just in case epi becomes ready after ep_item_poll() above, but before
> > +			 * init_llist_node(). Make sure to add it to the ready list, otherwise an
> > +			 * event may be lost.
> > +			 */
> 
> So why not llist_del_first_init() at the top? Wouldn't this avoid the
> add below? 

Look at that function:
	static inline struct llist_node *llist_del_first_init(struct llist_head *head)
	{
		struct llist_node *n = llist_del_first(head);

		// BROKEN: another task does llist_add() here for the same node

		if (n)
			init_llist_node(n);
		return n;
	}

It is not atomic to another task doing llist_add() to the same node.
init_llist_node() would then put the list in an inconsistent state.

To be sure, I tried your suggestion. Systemd sometimes failed to boot, and
my stress test crashed instantly.

> 
> > +			if (unlikely(ep_item_poll(epi, &pt, 1))) {
> > +				ep_pm_stay_awake(epi);
> > +				epitem_ready(epi);
> > +			}
> >  			continue;
> > +		}
> >  
> >  		events = epoll_put_uevent(revents, epi->event.data, events);
> >  		if (!events) {
> > -			list_add(&epi->rdllink, &txlist);
> > -			ep_pm_stay_awake(epi);
> > +			llist_add(&epi->rdllink, &ep->rdllist);
> 
> That epitem_ready() above and this llist_add() add epi back where it was
> retrieved from. Wouldn't it loop in this case?

This is the EFAULT case, we are giving up, therefore we put the item back
and bail out. Therefore no loop.

If we have already done at least one item, then we report that to user. If
none, then we report -EFAULT. Regardless, this current item is not
"successfully consumed", so we put it back for the others to take it. We
are done here.

> I think you can avoid the add above and here adding it to txlist would
> avoid the loop. (It returns NULL if the copy-to-user failed so I am not
> sure why another retry will change something but the old code did it,
> too so).
> 
> >  			if (!res)
> >  				res = -EFAULT;
> >  			break;
> 
> One note: The old code did "list_add() + ep_pm_stay_awake()". Now you do
> "ep_pm_stay_awake() + epitem_ready()". epitem_ready() adds the item
> conditionally to the list so you may do ep_pm_stay_awake() without
> adding it to the list because it already is. Looking through
> ep_pm_stay_awake() it shouldn't do any harm except incrementing a
> counter again.

Yes, it shouldn't do any harm.

Thanks for reviewing, I know this lockless thing is annoying to look at.

Nam

