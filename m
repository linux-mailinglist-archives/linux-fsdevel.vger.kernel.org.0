Return-Path: <linux-fsdevel+bounces-53102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042BCAEA2F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA4D4A81E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA692EBDFB;
	Thu, 26 Jun 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YkCVOwiW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1+HqzXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAD2EBBB7;
	Thu, 26 Jun 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953001; cv=none; b=TNVWjX+TvILBaegfei6t7N2QD5eVFUrkIpHgpLvss2ng0lFgnQwtWNLfZTiv8PwQUW3B7CvZEWBdpzcRAc8oc7AiqL35jZFlnVtftvKyryMhsl0k8GoJhZZU+R38BtgUHSb3zR3ERQemjmEvs7h27hJEvHuJP8+XLguQ4arvuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953001; c=relaxed/simple;
	bh=Mpi5liKjyiDncbXlQSUN5m41aQloT3tVm9OabwEOvYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K79BoxzgtpjmZXmg0Ox82FqPpX73HuakOfdx+aBmA0YvWrkswnMHOFR4eRPuNLb3UBHuE+AiBSxj1pNmtweOAogRSUxGXjms0Xf9JCRmVHdRP1SKaYuQ5VLDgqVNI1m1mUn9AzETIOX0e1v2dUlEqxL8lMgk87hahtCpFpt01kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YkCVOwiW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L1+HqzXN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 17:49:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750952996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZA23onas5n4B09dCvBkdk+b6pfrOmlq+EopDm/BmP0=;
	b=YkCVOwiWQSz/zQsWs8NjbsXOY4f36xUq/3yuKyRYBF7mthALXB1sTb+OqMvEZYQo2F/NHv
	v3RYujSu5+03ArJGLSSQIbn7ZtzKOHus/j879dVfNiFVDo+ExtLiRYZj+eYfv2sgc4n0p4
	BKsG87GRClfb1NdRBfjXCyJRCR7dYn62Xjnt6cuA4Nb3uEivkxspTucqGWsc2iJOT3FMFN
	L7ZQJMZ8lQRxIw/xsDqvokCSJqJp0TpLAcIiUEzhrrOs//RbAANi7vD44QhTZpxcckxxOT
	77oif/ku8R6GBghxw8pWwQaQRGLjyE8ySjKgt+MN3s7RVox/f/ztalWYb4fKUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750952996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZA23onas5n4B09dCvBkdk+b6pfrOmlq+EopDm/BmP0=;
	b=L1+HqzXNd+Bj8avf6MduLQ8qq7mxtyC+oQmhlzi+om4KOidY7K/whfDEQ3Ihv82ZGiIyhq
	yGZR1jmzlOTgt5Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250626154954.NH9L0mtz@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <841pr6msql.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <841pr6msql.fsf@jogness.linutronix.de>

On 2025-06-26 17:29:46 [+0206], John Ogness wrote:
> > @@ -361,10 +348,14 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
> >  	        (p1->file < p2->file ? -1 : p1->fd - p2->fd));
> >  }
> >  
> > -/* Tells us if the item is currently linked */
> > -static inline int ep_is_linked(struct epitem *epi)
> > +/*
> > + * Add the item to its container eventpoll's rdllist; do nothing if the item is already on rdllist.
> > + */
> > +static void epitem_ready(struct epitem *epi)
> >  {
> > -	return !list_empty(&epi->rdllink);
> > +	if (&epi->rdllink == cmpxchg(&epi->rdllink.next, &epi->rdllink, NULL))
> 
> Perhaps:
> 
> 	if (try_cmpxchg(&epi->rdllink.next, &epi->rdllink, NULL))

Not sure this is the same.
This will write back the current value of epi->rdllink.next to
epi->rdllink if epi->rdllink.next is not &epi->rdllink.

The intention is to check if epi->rdllink.next is set to &epi->rdllink
(pointing to itself) and if so set it NULL just to avoid to ensure
further cmpxchg() will fail here.

> > +		llist_add(&epi->rdllink, &epi->ep->rdllist);
> > +
> >  }
> >  
> >  static inline struct eppoll_entry *ep_pwq_from_wait(wait_queue_entry_t *p)
> 
> John Ogness

Sebastian

