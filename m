Return-Path: <linux-fsdevel+bounces-60133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB567B418CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B6486B47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F22EC0BE;
	Wed,  3 Sep 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1x93UW+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PTw9nrho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F32EBDC0;
	Wed,  3 Sep 2025 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888817; cv=none; b=hJTWKheyMUIbBT+0nlO2s6b+b7N3QzWjeTu6Yl8GwxrHtlm2aDFSFK6TMHFydMFT5cCGRf9aMeEu6N0ltGhvDbjfqDgKlTTZWlGgx85EMf2+mye0VMmAMU+A5oIxO+IC65m54WyTXLvGrTKJIjbb4l3sGAd01XAL/68OMjms3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888817; c=relaxed/simple;
	bh=KRqFvSzAOzh6xpHpW2TgXgZ9cEUGzyrAE8yaUm6zFIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZmtaXDAZqRw243WXcv7ad3cqRhqEL5Pl5ikVixNZf4n8pBdWmXhcm6JmPzf3OU8kj9ofKLu24q3BcjwvzRVUoEzN1o9JM8R7xBQ83IrtQbofsTjx/MMTDc+KyH8v4AUCIzAZuUIici+WsUri4WGyKDoldjIrRDJBamUmfe/J5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e1x93UW+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PTw9nrho; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Sep 2025 10:40:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756888813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wogFgenDG1/W+A7VwzKgS47uNOS4th3XGCCabqsEsFs=;
	b=e1x93UW+fXGbE9x+mkaYFYIGSaEwWnxr/aKUHww/6pu62fMhH9Idy84PE1HnY+D8LeZJxu
	AuRNMSSRvijvRpvH4l+gMcMVAebcwKjwN1vbR21eDqkuIXVVLZ6mTMOKPNegWKcm11+Zmd
	8YabgGHMgeBm9+6XuJQCZzl9X9/lj2NkenpzLovfhMsNW9alRox0YCTlDnsmGnmo1i4V7y
	+6yvMx0awJudcX/KHVMLB9a91DB1Izpd2wryS5Ip3uKGBMA0Ex8z1lp+rJHEpqutNo1UBe
	VFJKWzyFeGqdxHfHrJVEFHLW6XRK3r/V0EyVM1wmO3x5xLAlS4vWQhaqmekfkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756888813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wogFgenDG1/W+A7VwzKgS47uNOS4th3XGCCabqsEsFs=;
	b=PTw9nrho0V342O0vBLEtKLxur6/CvaXZQdDl3QDB91D/RjkoovOULkypqUBuixvsCHYrv0
	05+HFNt7BQbC7SDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>, Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	John Ogness <john.ogness@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
Message-ID: <20250903084012.A8dd-A5z@linutronix.de>
References: <cover.1752581388.git.namcao@linutronix.de>
 <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
 <20250826084320.XeTd6XAK@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826084320.XeTd6XAK@linutronix.de>

On 2025-08-26 10:43:20 [+0200], Nam Cao wrote:
> On Tue, Jul 15, 2025 at 02:46:34PM +0200, Nam Cao wrote:
> > The ready event list of an epoll object is protected by read-write
> > semaphore:
> > 
> >   - The consumer (waiter) acquires the write lock and takes items.
> >   - the producer (waker) takes the read lock and adds items.
> > 
> > The point of this design is enabling epoll to scale well with large number
> > of producers, as multiple producers can hold the read lock at the same
> > time.
> > 
> > Unfortunately, this implementation may cause scheduling priority inversion
> > problem. Suppose the consumer has higher scheduling priority than the
> > producer. The consumer needs to acquire the write lock, but may be blocked
> > by the producer holding the read lock. Since read-write semaphore does not
> > support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=y),
> > we have a case of priority inversion: a higher priority consumer is blocked
> > by a lower priority producer. This problem was reported in [1].
> > 
> > Furthermore, this could also cause stall problem, as described in [2].
> > 
> > Fix this problem by replacing rwlock with spinlock.
> 
> Hi Christian,
> 
> May I know your plan with this patch? Are you still waiting for something?
> 
> You may still understandably be paranoid about epoll due to the last
> regression. But it's been weeks, and this patch is quite simple, so I start
> to wonder if it is forgotten.

A friendly reminder.

> Nam

Sebastian

