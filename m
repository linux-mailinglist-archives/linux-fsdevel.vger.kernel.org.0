Return-Path: <linux-fsdevel+bounces-52917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E506AE8715
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51379164DCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC02265CDD;
	Wed, 25 Jun 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0DjZmKYp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGCr9ha6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0272748D;
	Wed, 25 Jun 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863038; cv=none; b=YUzzfSY7DCpfoQHlK1dS/GP5/j1R2hLX9XOIxFxB+E3NIhHqCxolnTV3NwOmpTN5k9JRIeSpr8B+ELurjMe6RbqVHnB9ISqRkkXIgpqOuTYmuRglxunHJtRHJLpXXxhNRNatlg/JhMTqe6T7Kfh0Qr/i2aw0SLMCnRc9K++tpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863038; c=relaxed/simple;
	bh=i3Y+NX2yIkTE6if39QTvyYngYQbwBEOT+RphBGvC6XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjSgZ4eoC9pFglMsYa55yXbjpaIoT0/9SaXBzskxMzUehz/oyI0f5dBkDX9jiGlyeKvTKkcspJuA6oSUJxywTp/Pi3VmZE5VxSR8BYcQNqp585zRTUr7tVO1xT359xAiTZHQpQfwk7JmGVnDlncrHE+zFoSwaqH2KP6BuPdsXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0DjZmKYp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGCr9ha6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:50:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750863033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcrexWB9KD0jruJMQXOBWyR3l7NzZZewWuOS/rt3/UU=;
	b=0DjZmKYpIwp0ExsYEKau8R+3zmOtOcZBCibe9pMfiHeuqAsCorqShFLiVgKEAQIANhZL95
	S3tQKYew/fBAMo0X0UtCigIk0XCZ3c0t/XYOmS3ONZeTdxL3WRZrLD/ShaynunN1yy9qJv
	Zq/s2QXDELsJO5681eYfywJKm58F4j2rSlmmLy6QP8Bqb7pCQLdSuplWoGmNKrpaeF3Tkd
	Ldfa7lGvNR2dnOAruQWe78UGAXC9WrK8+J6I6uAXtqO7jb8BG6C1RPqNAHt3YaEyXT8o5D
	aOWUrKtqXnQK0Z4OPpUGm41iD/BkJKopdW8cu2zosBZUlPFRgGrEAn8Xx5IWiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750863033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcrexWB9KD0jruJMQXOBWyR3l7NzZZewWuOS/rt3/UU=;
	b=lGCr9ha6d3/TwagN6mRuS4aWZewQQg87Fd4sj82L6WYJUZrCLh57SurwuQmTkkgIcxKMxV
	6ED+k6skl0j/V4Bg==
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
Message-ID: <20250625145031.GQ4Bnc4K@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250527090836.1290532-1-namcao@linutronix.de>

On 2025-05-27 11:08:36 [+0200], Nam Cao wrote:
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1867,19 +1704,18 @@ static int ep_send_events(struct eventpoll *ep,
>  	init_poll_funcptr(&pt, NULL);
>  
>  	mutex_lock(&ep->mtx);
> -	ep_start_scan(ep, &txlist);
>  
> -	/*
> -	 * We can loop without lock because we are passed a task private list.
> -	 * Items cannot vanish during the loop we are holding ep->mtx.
> -	 */
> -	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
> +	while (res < maxevents) {
>  		struct wakeup_source *ws;
> +		struct llist_node *n;
>  		__poll_t revents;
>  
> -		if (res >= maxevents)
> +		n = llist_del_first(&ep->rdllist);
> +		if (!n)
>  			break;
>  
> +		epi = llist_entry(n, struct epitem, rdllink);
> +
>  		/*
>  		 * Activate ep->ws before deactivating epi->ws to prevent
>  		 * triggering auto-suspend here (in case we reactive epi->ws
> @@ -1896,21 +1732,30 @@ static int ep_send_events(struct eventpoll *ep,
>  			__pm_relax(ws);
>  		}
>  
> -		list_del_init(&epi->rdllink);
> -
>  		/*
>  		 * If the event mask intersect the caller-requested one,
>  		 * deliver the event to userspace. Again, we are holding ep->mtx,
>  		 * so no operations coming from userspace can change the item.
>  		 */
>  		revents = ep_item_poll(epi, &pt, 1);
> -		if (!revents)
> +		if (!revents) {
> +			init_llist_node(n);
> +
> +			/*
> +			 * Just in case epi becomes ready after ep_item_poll() above, but before
> +			 * init_llist_node(). Make sure to add it to the ready list, otherwise an
> +			 * event may be lost.
> +			 */

So why not llist_del_first_init() at the top? Wouldn't this avoid the
add below? 

> +			if (unlikely(ep_item_poll(epi, &pt, 1))) {
> +				ep_pm_stay_awake(epi);
> +				epitem_ready(epi);
> +			}
>  			continue;
> +		}
>  
>  		events = epoll_put_uevent(revents, epi->event.data, events);
>  		if (!events) {
> -			list_add(&epi->rdllink, &txlist);
> -			ep_pm_stay_awake(epi);
> +			llist_add(&epi->rdllink, &ep->rdllist);

That epitem_ready() above and this llist_add() add epi back where it was
retrieved from. Wouldn't it loop in this case?

I think you can avoid the add above and here adding it to txlist would
avoid the loop. (It returns NULL if the copy-to-user failed so I am not
sure why another retry will change something but the old code did it,
too so).

>  			if (!res)
>  				res = -EFAULT;
>  			break;

One note: The old code did "list_add() + ep_pm_stay_awake()". Now you do
"ep_pm_stay_awake() + epitem_ready()". epitem_ready() adds the item
conditionally to the list so you may do ep_pm_stay_awake() without
adding it to the list because it already is. Looking through
ep_pm_stay_awake() it shouldn't do any harm except incrementing a
counter again.

Sebastian

