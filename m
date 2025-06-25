Return-Path: <linux-fsdevel+bounces-52925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96959AE8844
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF254A3A35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947029E0F4;
	Wed, 25 Jun 2025 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwttktU3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V69TqSXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771072877DC;
	Wed, 25 Jun 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865640; cv=none; b=nILNB7RkWDCaE9yDWScrI8LslQl70s3EmegSCnhUFgpBLnqhk05KMzBBXSuq6LsawbJvN4T/5y6kA8uLtQu9/FotWScSUPXpOlnY1MoTvsxAbusAo6YnjCWx9MBS3mn3toBsmHCCfPl6dwl/B5d9OIJdAoOMLcosje6wAWGlTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865640; c=relaxed/simple;
	bh=6RjDvqxMF4UNHL2ffnUoiaYP0QyOxEoOLDFwtWWOF4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghIqdiT0/v7+vIH3938bfcZOy3gfyG2g1kL/a71Y+xP7XHtQsWbaYdjjVMXEpXHH0C/UkuV0Yr4kD6zgHZLhAJ1mb40G6xCteOPD8B2Ec0cGnHivDd/llkdbyUjTbcwfImnqUSrU5DX+N454mzEqICiQUI2XvHFTWqWSI0DO5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwttktU3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V69TqSXF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 17:33:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750865636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc4y94UlE/VFlG8nYY1S5q5zlkhHTNo8sayND4Be7QQ=;
	b=uwttktU3aAKdTHXQWCtIKF3v5Ar5unQ4u3+4SXrV/qww7ACldqp+X+UR9TT4IMXEB/0sM7
	XyY+8YsP5Nrf4BQGtGuRBTtXm9pDtvHqyOpKiQ/qdnlx4Nw5BHaVK2Ez2+zGUJVisboIgn
	K5RClptQLUbOZrG/maDpMAw50tGlih46+H034JQ6n1dxfr8/x6cYOQwcPMcJul6nrG2at9
	xTXPav42Y+F1gcu90TTPdEuZVYqlir7uwyuUsh74d40/KDxBcCVr/zBIlFAbUGUEdsIXcZ
	zg2S3Sc5ZjGnSuOMDKbKAdW5BNxmSIEcegJeBIfgsjbG5VOpKkWm4KYkgeVa4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750865636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc4y94UlE/VFlG8nYY1S5q5zlkhHTNo8sayND4Be7QQ=;
	b=V69TqSXFfwgCkx+m2VTPolpJ/8qMEVOcBR3NJRUz59cRIa7Qm9WyCgDUibBvY7P2vnZItX
	MtbhB5W5LmLXK2BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
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
Message-ID: <20250625153354.0cgh85EQ@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250625145031.GQ4Bnc4K@linutronix.de>
 <20250625152702.JiI8qdk-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625152702.JiI8qdk-@linutronix.de>

On 2025-06-25 17:27:02 [+0200], Nam Cao wrote:
> > > @@ -1896,21 +1732,30 @@ static int ep_send_events(struct eventpoll *ep,
> > >  			__pm_relax(ws);
> > >  		}
> > >  
> > > -		list_del_init(&epi->rdllink);
> > > -
> > >  		/*
> > >  		 * If the event mask intersect the caller-requested one,
> > >  		 * deliver the event to userspace. Again, we are holding ep->mtx,
> > >  		 * so no operations coming from userspace can change the item.
> > >  		 */
> > >  		revents = ep_item_poll(epi, &pt, 1);
> > > -		if (!revents)
> > > +		if (!revents) {
> > > +			init_llist_node(n);
> > > +
> > > +			/*
> > > +			 * Just in case epi becomes ready after ep_item_poll() above, but before
> > > +			 * init_llist_node(). Make sure to add it to the ready list, otherwise an
> > > +			 * event may be lost.
> > > +			 */
> > 
> > So why not llist_del_first_init() at the top? Wouldn't this avoid the
> > add below? 
> 
> Look at that function:
> 	static inline struct llist_node *llist_del_first_init(struct llist_head *head)
> 	{
> 		struct llist_node *n = llist_del_first(head);
> 
> 		// BROKEN: another task does llist_add() here for the same node
> 
> 		if (n)
> 			init_llist_node(n);
> 		return n;
> 	}
> 
> It is not atomic to another task doing llist_add() to the same node.
> init_llist_node() would then put the list in an inconsistent state.

Okay, I wasn't expecting another llist_add() from somewhere else. Makes
sense.

> To be sure, I tried your suggestion. Systemd sometimes failed to boot, and
> my stress test crashed instantly.

I had a trace_printk() there while testing and it never triggered.

> > 
> > > +			if (unlikely(ep_item_poll(epi, &pt, 1))) {
> > > +				ep_pm_stay_awake(epi);
> > > +				epitem_ready(epi);
> > > +			}
> > >  			continue;
> > > +		}
> > >  
> > >  		events = epoll_put_uevent(revents, epi->event.data, events);
> > >  		if (!events) {
> > > -			list_add(&epi->rdllink, &txlist);
> > > -			ep_pm_stay_awake(epi);
> > > +			llist_add(&epi->rdllink, &ep->rdllist);
> > 
> > That epitem_ready() above and this llist_add() add epi back where it was
> > retrieved from. Wouldn't it loop in this case?
> 
> This is the EFAULT case, we are giving up, therefore we put the item back
> and bail out. Therefore no loop.

Right.

> If we have already done at least one item, then we report that to user. If
> none, then we report -EFAULT. Regardless, this current item is not
> "successfully consumed", so we put it back for the others to take it. We
> are done here.
> 
> > I think you can avoid the add above and here adding it to txlist would
> > avoid the loop. (It returns NULL if the copy-to-user failed so I am not
> > sure why another retry will change something but the old code did it,
> > too so).
> > 
> > >  			if (!res)
> > >  				res = -EFAULT;
> > >  			break;
> > 
> > One note: The old code did "list_add() + ep_pm_stay_awake()". Now you do
> > "ep_pm_stay_awake() + epitem_ready()". epitem_ready() adds the item
> > conditionally to the list so you may do ep_pm_stay_awake() without
> > adding it to the list because it already is. Looking through
> > ep_pm_stay_awake() it shouldn't do any harm except incrementing a
> > counter again.
> 
> Yes, it shouldn't do any harm.
> 
> Thanks for reviewing, I know this lockless thing is annoying to look at.

but it looks now a bit smaller :)

> Nam

Sebastian

