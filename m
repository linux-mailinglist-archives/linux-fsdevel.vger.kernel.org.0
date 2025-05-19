Return-Path: <linux-fsdevel+bounces-49385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2013BABBA41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0241B63566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5026D4E3;
	Mon, 19 May 2025 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c5oSWHzZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xx+xZPCL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD11C84B8;
	Mon, 19 May 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647949; cv=none; b=m8w5e2CUjE1exL+5CtMAZPqafWVIcUXtwn12LnaShwsWqXdzX+GFZu2UwHxIKP5PybOYTh2E0pUXBxxn1/PkAPMYr1f0OtsXUlpVfmjx5lHQYBixjCxYp7o3sQpdSap3SkSOczdsi94b+i79GBckyUvfZvboUws3mCOLpuvMzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647949; c=relaxed/simple;
	bh=gth7CHYYNDX5MdGfaO8LJ2FN2cN2NuN0sWe+Tk6eoZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDoBGWePdRPWdui+WzCEuYSut6/EkWA4/Y+1ild9g47CNgmZELhXf8x1ggujM/tz0HyN6q2w6P2VVmRyENgBesdTg18ZZyY8M7V9dRpMxr46yyKl36x1HItPzUIXt3/8M0Tm8LGBRaMQeEoYs277P5e/OrvME4ufJ7z0YhW7N5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c5oSWHzZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xx+xZPCL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 May 2025 11:45:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747647945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kh5YNJbsenpOdAJ3ZCZ/uJk0ypi6vPEtUU1Y01srTxA=;
	b=c5oSWHzZ/zyTxNycDLQHAzOcEKfiU+AEyy0sJrVNfEtNKJ6AgnBP8lNKnukFR5kuQyujui
	/5aFrsuc709T4L21Rh8fOA7TVavXvVpKb7yaffKkWvPbmr8uAH5fmEH7ATyYiMMq5LuuLL
	UfHeIr65avpBwp8M73ISjizgwGMUPrThhG4DydTwK8x5zgFUFtFZSs1zIUlAPOktw/K4gC
	3WatHsshmTi3FNAwOTVJB7ww1o86MOSZFfP1Z5YSo+SyqfpfdKSx8kUiI3qoamidr64AU9
	QOl0boRvkvA2FPhJJzul+0nCYsulelFEZ1mOZn5924nQQ7tZhLyUJFg4jDlYjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747647945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kh5YNJbsenpOdAJ3ZCZ/uJk0ypi6vPEtUU1Y01srTxA=;
	b=xx+xZPCLWjjGpkDQrVhGl6mGrYVqrC5CgBMoaMDuATKQk377CoJLl/HISY5TDkR7S0Ld89
	U+6OnkZOC74CM7AQ==
From: Nam Cao <namcao@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
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
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>
Subject: Re: [PATCH] eventpoll: Fix priority inversion problem
Message-ID: <20250519094543.m4bNJP6X@linutronix.de>
References: <20250519074016.3337326-1-namcao@linutronix.de>
 <ae4985d3b157e31c667f532906cb6ff55633141b.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae4985d3b157e31c667f532906cb6ff55633141b.camel@siemens.com>

On Mon, May 19, 2025 at 11:25:51AM +0200, Florian Bezdeka wrote:
> Hi all,
> 
> sorry for top-posting, but I think it makes sense in this case as I'm
> trying to merge different workstreams, likely working on the same
> problem showing up in different colors.
> 
> Main goal is to make everybody aware of the other stream / patch
> series.
> 
> We have colleagues from Bytedance working on non-RT performance
> optimizations related to CONFIG_CFS_BANDWIDTH at [1]. 
> 
> This series came to light while searching for a solution for a RT
> lockup, reported at [2]. 
> 
> We heavily tested [1] during the last month on RT and can report
> success now. In our tests we saw read-lock holder preemption only
> within the epoll interface. It might be that [1] fixes more potential
> issues in this regard.
> 
> Today [3] (= the patch I'm replying to, see below) got posted.
> Linutronix reworking the epoll infrastructure.
> 
> I would love to learn how/if the combination, basically [1] and [3] fit
> together.

[1] fixes stall problem involving rw semaphore which epoll uses, but it
doesn't fix the possible priority inversion with epoll

[3] fixes priority inversion problem with epoll by stop using rw semaphore,
but it doesn't do anything about rw semaphore

So I propose we keep both.

Best regards,
Nam

> My understanding right now is, that [1] fixes a CFS issue, throttling
> while holding a lock is not ideal on !RT - but might cause a critical
> lockup on RT - while [3] is addressing a similar (RT) problem in epoll.
> 
> Best regards,
> Florian
> 
> [1] https://lore.kernel.org/all/20250409120746.635476-1-ziqianlu@bytedance.com/
> [2] https://lore.kernel.org/linux-rt-users/xhsmhttqvnall.mognet@vschneid.remote.csb/
> [3] https://lore.kernel.org/linux-rt-users/20250519074016.3337326-1-namcao@linutronix.de/T/#u

