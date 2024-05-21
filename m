Return-Path: <linux-fsdevel+bounces-19877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF58CACFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 13:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70735B2244D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A2A6D1A3;
	Tue, 21 May 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FRQFlY5f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6JINQMdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EEB28F0;
	Tue, 21 May 2024 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289241; cv=none; b=WMA3fs1vqeQs29HZSfsXipCvyCT/du+044EpNUJHGt3BOLbun3eYwWUTB9AKEeutwsY+0mNWGbjwxIZHxgfuSuX9Azn3jVywgpK3lnY6fT8qdhOArS4Wntcbt1ujF6I9vNiO9RmaXKNzF0eVaa3hUG3evfT5SGIItsMlsy6ILsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289241; c=relaxed/simple;
	bh=xpW8cWC8VndEV56VMUUuteKJq55p9xa45elyZ7RSY7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tug+Y8y+/P11qZk+ajxUnVZbZ7VLKzxoUe2wq77TMzWZOBz1muu3wt447pGjEZ0qzRr/lybKr6WxC2eP4EOdkt9P2FwpBKZJaAbYPCNpSqcJywqmM451sFIrYh8jmKMVEPOIiwbIbHta5XZgv/b2VP4cxCjk6mn0S5QIT5tavOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FRQFlY5f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6JINQMdp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 May 2024 13:00:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716289236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SKqiKY3fPfFrak3zoFgzP4YhDQY8tnNkx/mXavMpSw=;
	b=FRQFlY5ffVxx8kUFmC0jx5rMqBpFzKeZH41Rq+N8SgCWVWEyt1zyWLKwZeKbBLRZckUHxP
	3ZecqZU/4oAZPmzLmFjWAymZK5GmmDbQ9ZUaSFLxijU5FeSNJ78QPknI8k8SYSUIvCTVKH
	Z7GP4piQL3qIMOrpguhh45A5lD2rDfi/7Ll9EujkhRxmilGycuQatQX9pSAUN2Kscgr3ab
	OCLCV8NyrT1rNT2nuJYVE/ZVuwM465v+Cnd288JvHFu+ayaUrWpJDPn0kQsAFe8VClF5Gt
	RgyYimqytc+W9AhUH1eFwVYf/Bx4N9w3/7laag/KIvkhm7YT61swbU4b0z/h+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716289236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SKqiKY3fPfFrak3zoFgzP4YhDQY8tnNkx/mXavMpSw=;
	b=6JINQMdpOPpHBR1iFBmVIaq+lA45HD37UNR4XddxkdAxN5OycpjJSBl/4PhNdTDmrOJ0SB
	ZyMpkCCSdbU4tQBA==
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
Message-ID: <20240521110035.KRIwllGe@linutronix.de>
References: <20240515220536.823145-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240515220536.823145-1-qyousef@layalina.io>

On 2024-05-15 23:05:36 [+0100], Qais Yousef wrote:
> rt_task() checks if a task has RT priority. But depends on your
> dictionary, this could mean it belongs to RT class, or is a 'realtime'
> task, which includes RT and DL classes.
>=20
> Since this has caused some confusion already on discussion [1], it
> seemed a clean up is due.
>=20
> I define the usage of rt_task() to be tasks that belong to RT class.
> Make sure that it returns true only for RT class and audit the users and
> replace the ones required the old behavior with the new realtime_task()
> which returns true for RT and DL classes. Introduce similar
> realtime_prio() to create similar distinction to rt_prio() and update
> the users that required the old behavior to use the new function.
>=20
> Move MAX_DL_PRIO to prio.h so it can be used in the new definitions.
>=20
> Document the functions to make it more obvious what is the difference
> between them. PI-boosted tasks is a factor that must be taken into
> account when choosing which function to use.
>=20
> Rename task_is_realtime() to realtime_task_policy() as the old name is
> confusing against the new realtime_task().

I *think* everyone using rt_task() means to include DL tasks. And
everyone means !SCHED-people since they know when the difference matters.

> No functional changes were intended.
>=20
> [1] https://lore.kernel.org/lkml/20240506100509.GL40213@noisy.programming=
=2Ekicks-ass.net/
>=20
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>=20
> Changes since v1:
>=20
> 	* Use realtime_task_policy() instead task_has_realtime_policy() (Peter)
> 	* Improve commit message readability about replace some rt_task()
> 	  users.
>=20
> v1 discussion: https://lore.kernel.org/lkml/20240514234112.792989-1-qyous=
ef@layalina.io/
>=20
>  fs/select.c                       |  2 +-

fs/bcachefs/six.c
six_owner_running() has rt_task(). But imho should have realtime_task()
to consider DL. But I think it is way worse that it has its own locking
rather than using what everyone else but then again it wouldn't be the
new hot thing=E2=80=A6

>  include/linux/ioprio.h            |  2 +-
>  include/linux/sched/deadline.h    |  6 ++++--
>  include/linux/sched/prio.h        |  1 +
>  include/linux/sched/rt.h          | 27 ++++++++++++++++++++++++++-
>  kernel/locking/rtmutex.c          |  4 ++--
>  kernel/locking/rwsem.c            |  4 ++--
>  kernel/locking/ww_mutex.h         |  2 +-
>  kernel/sched/core.c               |  6 +++---
>  kernel/time/hrtimer.c             |  6 +++---
>  kernel/trace/trace_sched_wakeup.c |  2 +-
>  mm/page-writeback.c               |  4 ++--
>  mm/page_alloc.c                   |  2 +-
>  13 files changed, 48 insertions(+), 20 deletions(-)
=E2=80=A6
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 70625dff62ce..08b95e0a41ab 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1996,7 +1996,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_s=
leeper *sl,
>  	 * expiry.
>  	 */
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> -		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
> +		if (realtime_task_policy(current) && !(mode & HRTIMER_MODE_SOFT))
>  			mode |=3D HRTIMER_MODE_HARD;
>  	}
> =20
> @@ -2096,7 +2096,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrt=
imer_mode mode,
>  	u64 slack;
> =20
>  	slack =3D current->timer_slack_ns;
> -	if (rt_task(current))
> +	if (realtime_task(current))
>  		slack =3D 0;
> =20
>  	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
> @@ -2301,7 +2301,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u6=
4 delta,
>  	 * Override any slack passed by the user if under
>  	 * rt contraints.
>  	 */
> -	if (rt_task(current))
> +	if (realtime_task(current))
>  		delta =3D 0;

I know this is just converting what is already here but=E2=80=A6
__hrtimer_init_sleeper() looks at the policy to figure out if the task
is realtime do decide if should expire in HARD-IRQ context. This is
correct, a boosted task should not sleep.

hrtimer_nanosleep() + schedule_hrtimeout_range_clock() is looking at
priority to decide if slack should be removed. This should also look at
policy since a boosted task shouldn't sleep.

In order to be PI-boosted you need to acquire a lock and the only lock
you can sleep while acquired without generating a warning is a mutex_t
(or equivalent sleeping lock) on PREEMPT_RT.=20

>  	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched=
_wakeup.c
> index 0469a04a355f..19d737742e29 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -545,7 +545,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
>  	 *  - wakeup_dl handles tasks belonging to sched_dl class only.
>  	 */
>  	if (tracing_dl || (wakeup_dl && !dl_task(p)) ||
> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> +	    (wakeup_rt && !realtime_task(p)) ||
>  	    (!dl_task(p) && (p->prio >=3D wakeup_prio || p->prio >=3D current->=
prio)))
>  		return;
> =20

Sebastian

