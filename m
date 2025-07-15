Return-Path: <linux-fsdevel+bounces-54958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F125B05AB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6437C4A35D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF82E03E1;
	Tue, 15 Jul 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sf7bZYQ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eSMLzsEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F082627FC;
	Tue, 15 Jul 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584312; cv=none; b=ScWMAoxiP7vwH3HLwJZsxuVf/MAArt8y231qSdZIGSPkW2eWabJ5R9ggfj9GIqjdXUeBMGmpx4aWw+2DiCXob46oNV4ZIxgmBU5NNBwryPZvgJVJ+jBIALRsxdukKdZ0KpKGNKrjWFmXqYWl2ct/ipkh8oocHKlvLZJjcRYt/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584312; c=relaxed/simple;
	bh=6SCddfOTDHHGObCBwebbZIS9WbD3aNhWQRhtOi2Ux8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD3TtzwdrV6fCBoYf1jedyoOVBNjsng2FQf7JdX+sGed2+Q2Win5H0ljZjj4vRsXQhqbK+VsEDG+Y2xpmhJ7lmFTk9/rJO3ac4VW/YzoF3I/PO94TaEf03j5u7Ux5htboVddbyls3yU1zUJKM2Fc51rHfBLt1VwPbmUhLlZhlyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sf7bZYQ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eSMLzsEO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Jul 2025 14:58:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752584308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/B9TLRBtxUDCJxsWBE7GcJCQaPVHwv80Fiu3ht2Nt6I=;
	b=sf7bZYQ9ZiWk8RvGDCHDL5F8ixwxhN0UkvRoxyuTukIbBSsEU5PzrZOjeWZQYp48EFpWkg
	2MAY3rRSagVDoMRaqQnLWkcV+KBXWbfiLIXodnP4cSabUINmn/LdWr5WCB0XkAPhHim+yc
	wYyoC4xYPDTXbKQNr8l29WxulcFT1ro2IgYZ9tiyUH397IvTxTjpXM8nuA5oVZKywjewOH
	ECsLT2IXIEaRXeuhPaZLf9SvyA+dsHd9Zryu42MjCjReF68glSLY3u/CaW59YUn5t0n713
	YaoDdwkyDwSusJtCHbB77Nh12PYJTArvZDMAMY2d/B8VzFIqeHNaXNCek7KU4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752584308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/B9TLRBtxUDCJxsWBE7GcJCQaPVHwv80Fiu3ht2Nt6I=;
	b=eSMLzsEOm6CDkh/rn6rfN0u0+4XWy5ZXnYN77a0NBMn1Yx6NruYwZ37rJqm2+2cocS5fjg
	eItyNbeObWf/6VCg==
From: Nam Cao <namcao@linutronix.de>
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
Message-ID: <20250715125827.SpZa8hHS@linutronix.de>
References: <cover.1752581388.git.namcao@linutronix.de>
 <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>

On Tue, Jul 15, 2025 at 02:46:34PM +0200, Nam Cao wrote:
> The ready event list of an epoll object is protected by read-write
> semaphore:
> 
>   - The consumer (waiter) acquires the write lock and takes items.
>   - the producer (waker) takes the read lock and adds items.
> 
> The point of this design is enabling epoll to scale well with large number
> of producers, as multiple producers can hold the read lock at the same
> time.
> 
> Unfortunately, this implementation may cause scheduling priority inversion
> problem. Suppose the consumer has higher scheduling priority than the
> producer. The consumer needs to acquire the write lock, but may be blocked
> by the producer holding the read lock. Since read-write semaphore does not
> support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=y),
> we have a case of priority inversion: a higher priority consumer is blocked
> by a lower priority producer. This problem was reported in [1].
> 
> Furthermore, this could also cause stall problem, as described in [2].
> 
> Fix this problem by replacing rwlock with spinlock.
> 
> This reduces the event bandwidth, as the producers now have to contend with
> each other for the spinlock. According to the benchmark from
> https://github.com/rouming/test-tools/blob/master/stress-epoll.c:
> 
>     On 12 x86 CPUs:
>                   Before     After        Diff
>         threads  events/ms  events/ms
>               8       7162       4956     -31%
>              16       8733       5383     -38%
>              32       7968       5572     -30%
>              64      10652       5739     -46%
>             128      11236       5931     -47%
> 
>     On 4 riscv CPUs:
>                   Before     After        Diff
>         threads  events/ms  events/ms
>               8       2958       2833      -4%
>              16       3323       3097      -7%
>              32       3451       3240      -6%
>              64       3554       3178     -11%
>             128       3601       3235     -10%
> 
> Although the numbers look bad, it should be noted that this benchmark
> creates multiple threads who do nothing except constantly generating new
> epoll events, thus contention on the spinlock is high. For real workload,
> the event rate is likely much lower, and the performance drop is not as
> bad.
> 
> Using another benchmark (perf bench epoll wait) where spinlock contention
> is lower, improvement is even observed on x86:
> 
>     On 12 x86 CPUs:
>         Before: Averaged 110279 operations/sec (+- 1.09%), total secs = 8
>         After:  Averaged 114577 operations/sec (+- 2.25%), total secs = 8
> 
>     On 4 riscv CPUs:
>         Before: Averaged 175767 operations/sec (+- 0.62%), total secs = 8
>         After:  Averaged 167396 operations/sec (+- 0.23%), total secs = 8
> 
> In conclusion, no one is likely to be upset over this change. After all,
> spinlock was used originally for years, and the commit which converted to
> rwlock didn't mention a real workload, just that the benchmark numbers are
> nice.
> 
> This patch is not exactly the revert of commit a218cc491420 ("epoll: use
> rwlock in order to reduce ep_poll_callback() contention"), because git
> revert conflicts in some places which are not obvious on the resolution.
> This patch is intended to be backported, therefore go with the obvious
> approach:
> 
>   - Replace rwlock_t with spinlock_t one to one
> 
>   - Delete list_add_tail_lockless() and chain_epi_lockless(). These were
>     introduced to allow producers to concurrently add items to the list.
>     But now that spinlock no longer allows producers to touch the event
>     list concurrently, these two functions are not necessary anymore.
> 
> Fixes: a218cc491420 ("epoll: use rwlock in order to reduce ep_poll_callback() contention")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org

I forgot to add:

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Closes: https://lore.kernel.org/linux-rt-users/20210825132754.GA895675@lothringen/ [1]
Reported-by: Valentin Schneider <vschneid@redhat.com>
Closes: https://lore.kernel.org/linux-rt-users/xhsmhttqvnall.mognet@vschneid.remote.csb/ [2]

Christian, do you mind adding those for me, if/when you apply the patch?

Nam

