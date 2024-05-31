Return-Path: <linux-fsdevel+bounces-20604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C730E8D5A8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 08:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3DD1C21D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 06:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056BF7FBCE;
	Fri, 31 May 2024 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFoB69CH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjDiGFYZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED54CDF9;
	Fri, 31 May 2024 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137022; cv=none; b=ZBNXcAnrH7oOS6mZxmbSKpPgY/uLauVajn1tutRet4mqTBIP4ZCCQIh7O81eIAhyGfTZNAL3DChj4fa6yex6bM3yyELO+V5753hzTlBbF3V7OXulGYv92xY1SfA6pZaK7XE3cmsFN8HpQJnyJgUxSDxDnWbOYDU2sN//1T76fbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137022; c=relaxed/simple;
	bh=ryUzeilFSwy47t1FN5S64noxvyK7l66pL9dkJAS2C6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn6tmxHn4LLXgrM/wPFLubzdwvn7rKVUjbMwCItLZhgEeqQkIeJSJW4p+5FFTz8Va4dvhrJNH4Ya2bvbNoQPKaVjNxNr9K2fgbn2UYA9CinuMsL4MuWHuHB6kVFNoJjtPrcqIPtx+KxOpR1IYf8Fd8JU3c7akhoxvZGGsKRR+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFoB69CH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wjDiGFYZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 08:30:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717137018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0QKmm22JdPzh0GWkCWU77DhQui4Y/61huUJNDliaZA=;
	b=QFoB69CHRFvRO1Fso0pUfBNcwKfvV+h0+FJ/JubW7z2q2efjpJH6b8WXySQFplvr1+uXPZ
	KLbaZDksbyDfeWdtuooMyEMWp2ZoG1Uk7JhevAk1v/dMmfGLQ9hpLraPoG2PxVOz3zv49k
	x2CDiEMw2/V/a4e3tSwnS2ueF1V8p9oolXLmNYaG04PACNgDw2vxMaBZrDUbJv1i6YW7RG
	tg6VtHYT2cTLxQicta5t7yKAAsTuCWRA6rUmFrJfxOR9tsinUBUOzKeatteAwEd58UKcAO
	CvkGDyB+LajttHbABral2JxJId1Skikf1EwZDGXGZhhxn6JKsXDxr1bKpcvtbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717137018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0QKmm22JdPzh0GWkCWU77DhQui4Y/61huUJNDliaZA=;
	b=wjDiGFYZOlVuL2w0+5a4ueNxOgXg4POfy35IGj/X1kD63/lhPCtWQRjwR3TImhrfyR/JY7
	a3VsRjTwQkRt8gCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240531063016.OCMg21Uq@linutronix.de>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
 <20240527172650.kieptfl3zhyljkzx@airbuntu>
 <20240529082912.gPDpgVy3@linutronix.de>
 <20240529103409.3iiemroaavv5lh2p@airbuntu>
 <20240529105528.9QBTCqCr@linutronix.de>
 <20240530111044.d4jegeiueizvdjrg@airbuntu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530111044.d4jegeiueizvdjrg@airbuntu>

On 2024-05-30 12:10:44 [+0100], Qais Yousef wrote:
> > This is not consistent because IMHO the clock setup & slack should be
> > handled equally. So I am asking the sched folks for a policy and I am
> > leaning towards looking at task-policy in this case instead of prio
> > because you shouldn't do anything that can delay.
> 
> Can't we do that based on is_soft/is_hard flag in hrtimer struct when we apply
> the slack in hrtimer_set_expires_range_ns() instead?

We need to decide on a policy first.
You don't want to add overhead on each invocation plus some in-kernel
ask for delta. ->is_soft is not a good criteria.

Sebastian

