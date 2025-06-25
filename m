Return-Path: <linux-fsdevel+bounces-52931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D9AE88EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCC716E99A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC629B214;
	Wed, 25 Jun 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UTPLqWGW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2z60Z06n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE62BE7AA;
	Wed, 25 Jun 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867041; cv=none; b=Dc17vIpaII4qr564XK+Z5v/xnWmIC+P6EMsjMkYwVNeL9J+W8YumLAtEblWm5OiJUck3hmpWXF/2vRelDHREfZpCk9looUhPZnsHxZrdQgOiQUbbq7ydWVJSDfDUaxKbTyLwg7btQag7ao80JuTAo3J5awHewSV6fNMWTgLOjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867041; c=relaxed/simple;
	bh=E5uqucEcM/mKn6EztccekkvQtFRto2xMKL0P3StcGmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvrgxUmhCcCtvT6rAOnnSFoYyvicrATnxZyCTC3xpJkQGLRPUdWUY2KzljwYhCPfgXS4bhQUYngQfcu62bhTPqSsvj/SxEuVL81yFNUK1iY1Lz89I9axVb86HAlGrCTjsmPiS+x3+pa+SWiXM4k+7fLI/8QRWZjD4CZNS8Jr9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UTPLqWGW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2z60Z06n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 17:57:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750867038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfjwWrD5XKW/BysMkuSVW+dt/gVl5mSe4HCW3w5BYuU=;
	b=UTPLqWGWembTwGM1I/YUgZo4X/TUmmRzpL5RjQlkxjSQAX8mSoiH1S881swoIMJ+d6miOb
	kVV8R1iW6jSLzQpMd65GwdIIX+P/ejWPkCPEcQn9+rcJw44H01J8c0FqrrfJLAfZONwI1F
	4vvVpQ3SCo6DAIU69OJ1xr/1Ggx8BpQ+77ATNEJ3V3/mNyyH+2q3YY/FXs0vQsXhv2/qwL
	sPatIYxsz03GvfZN4DzhenQFfHGpgX5DpGtrxbUFxINOx3sg3SSKtXmkyU9sA6wlmaoEIF
	/r1J4q7gh1O5JqWopj8qNOCBbNerEWHdUBUW2mx6EtCOk0hQsgtKnE5eZCzU1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750867038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfjwWrD5XKW/BysMkuSVW+dt/gVl5mSe4HCW3w5BYuU=;
	b=2z60Z06nBhUZVxBM6oxgQ3PZgvvFA8ivzh/kRDzxuBwWuBlnDpNa6XDz+vnlONDs8uyNZI
	1Ye7EO0EF0GRprCQ==
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
Message-ID: <20250625155713.lckVkmJH@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250625145031.GQ4Bnc4K@linutronix.de>
 <20250625152702.JiI8qdk-@linutronix.de>
 <20250625153354.0cgh85EQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625153354.0cgh85EQ@linutronix.de>

On Wed, Jun 25, 2025 at 05:33:54PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-25 17:27:02 [+0200], Nam Cao wrote:
> > > > @@ -1896,21 +1732,30 @@ static int ep_send_events(struct eventpoll *ep,
> > > >  			__pm_relax(ws);
> > > >  		}
> > > >  
> > > > -		list_del_init(&epi->rdllink);
> > > > -
> > > >  		/*
> > > >  		 * If the event mask intersect the caller-requested one,
> > > >  		 * deliver the event to userspace. Again, we are holding ep->mtx,
> > > >  		 * so no operations coming from userspace can change the item.
> > > >  		 */
> > > >  		revents = ep_item_poll(epi, &pt, 1);
> > > > -		if (!revents)
> > > > +		if (!revents) {
> > > > +			init_llist_node(n);
> > > > +
> > > > +			/*
> > > > +			 * Just in case epi becomes ready after ep_item_poll() above, but before
> > > > +			 * init_llist_node(). Make sure to add it to the ready list, otherwise an
> > > > +			 * event may be lost.
> > > > +			 */
> > > 
> > > So why not llist_del_first_init() at the top? Wouldn't this avoid the
> > > add below? 
> > 
> > Look at that function:
> > 	static inline struct llist_node *llist_del_first_init(struct llist_head *head)
> > 	{
> > 		struct llist_node *n = llist_del_first(head);
> > 
> > 		// BROKEN: another task does llist_add() here for the same node
> > 
> > 		if (n)
> > 			init_llist_node(n);
> > 		return n;
> > 	}
> > 
> > It is not atomic to another task doing llist_add() to the same node.
> > init_llist_node() would then put the list in an inconsistent state.
> 
> Okay, I wasn't expecting another llist_add() from somewhere else. Makes
> sense.

Sorry, it's been a few weeks and I misremembered. But that wasn't the
reason. epitem_ready() is atomic to llist_del_first_init().

The actual reason is that, llist_del_first_init() would allow another
llist_add() to happen. So in the future loop iterations, we could see the
same item again, and we would incorrectly report more events than actually
available.

Thus, init_llist_node() doesn't happen until we are done looping.

> > To be sure, I tried your suggestion. Systemd sometimes failed to boot, and
> > my stress test crashed instantly.
> 
> I had a trace_printk() there while testing and it never triggered.

This code path is only executed for broken userspace.

Nam

