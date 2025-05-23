Return-Path: <linux-fsdevel+bounces-49761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2BAC2299
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDF53A5042
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280123A566;
	Fri, 23 May 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oW3KvDT9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEMSiW8V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908A224243;
	Fri, 23 May 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003185; cv=none; b=GDjvGxb1xqxDtZtInIpEOAo5zq5hzx8zl1pPjs7VdeiHk/V1l97MF7YQ4VQ0deN8w3mVb78eqd+vN8U8pZNzwT3dSO7FWTB3SZxvnQTDL8Xf2Be8884Tg1tp1El28tm8lOABLc8s3dkvFZszmQnGlUTKXQ1YATn6YwQJTwvckUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003185; c=relaxed/simple;
	bh=xg8uFFp0tFIZ21rnNVN9vbqDmCgZzc5TgOsxp8lLXCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZO5BAbpyMdCaGt87quJLvpZWcOk+icIwgML66mSXW+F8AWPogibjAP0+OdloueBcy0UTj6rMMMtUImKCQQhmcpcF7STXp4Ki42/FNRwwr2a58ynKT4fPadNTi5kjqbIR9u3dEmOYV9rdImTvwc+jU0QN6AM60t/faQWFX/hD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oW3KvDT9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEMSiW8V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 May 2025 14:26:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748003172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5s6iTnGwb/aLbBd8LHliltI3JdB57RnJATnoeD7k2I=;
	b=oW3KvDT9rVsKBmpzH71QtUwEhPRIpf6IKhhtkn8eEdEGuYNGKYWARus9jVyK8mNT8c/2/3
	GocPW5+ELsJzAKrOcSRWnSNjqPMZBj1hMimBWVM/A1jpoUeAfTQtPxuYowHT6mbgUjeOi9
	RceUNJRkxWFTUmZ94DBDYupp5yIT7Mp9i6rTQhD6Nt042MkrWwgR6k5ltY8uTG/UpFgVi+
	vou7UYiF6gocOi7t2j7RQaovhoI3xXsTqaeAVOWOBtLSgLV0bk4oyodEL3K8tKgHW/PxrJ
	EqDlc/MxdMh/epdeS8JudXgGxC4xu1sIoE7SHJHQG7G371NBwAF16eAIXDoGNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748003172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5s6iTnGwb/aLbBd8LHliltI3JdB57RnJATnoeD7k2I=;
	b=MEMSiW8V20wID6Rj+lpw7lVLFkB0cV6Qzbp6X1aU+Ugxnz3IPcLZTAtspJX+DayMhnA5zv
	6QrId1Bya4t0thAQ==
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
Subject: Re: [PATCH v2] eventpoll: Fix priority inversion problem
Message-ID: <20250523122611.Q64SSO7S@linutronix.de>
References: <20250523061104.3490066-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250523061104.3490066-1-namcao@linutronix.de>

On 2025-05-23 08:11:04 [+0200], Nam Cao wrote:
> The ready event list of an epoll object is protected by read-write
> semaphore:
>=20
>   - The consumer (waiter) acquires the write lock and takes items.
>   - the producer (waker) takes the read lock and adds items.
>=20
> The point of this design is enabling epoll to scale well with large number
> of producers, as multiple producers can hold the read lock at the same
> time.
>=20
> Unfortunately, this implementation may cause scheduling priority inversion
> problem. Suppose the consumer has higher scheduling priority than the
> producer. The consumer needs to acquire the write lock, but may be blocked
> by the producer holding the read lock. Since read-write semaphore does not
> support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=3D=
y),
> we have a case of priority inversion: a higher priority consumer is block=
ed
> by a lower priority producer. This problem was reported in [1].
>=20
> Furthermore, this could also cause stall problem, as described in [2].
>=20
> To fix this problem, make the event list half-lockless:
>=20
>   - The consumer acquires a mutex (ep->mtx) and takes items.
>   - The producer locklessly adds items to the list.
>=20
> Performance is not the main goal of this patch, but as the producer now c=
an
> add items without waiting for consumer to release the lock, performance
> improvement is observed using the stress test from
> https://github.com/rouming/test-tools/blob/master/stress-epoll.c. This is
> the same test that justified using read-write semaphore in the past.
>=20
> Testing using 12 x86_64 CPUs:
>=20
>           Before     After        Diff
> threads  events/ms  events/ms
>       8       6944      20151    +190%
>      16       9367      27972    +199%
>      32       8707      31872    +266%
>      64      10342      38577    +273%
>     128      10860      40062    +269%
>=20
> Testing using 1 riscv64 CPU (averaged over 10 runs, as the numbers are
> noisy):
>=20
>           Before     After        Diff
> threads  events/ms  events/ms
>       1         75         96     +28%
>       2        153        158      +3%
>       4        229        257     +12%
>       8        250        270      +8%
>      16        263        275      +5%
>=20
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Closes: https://lore.kernel.org/linux-rt-users/20210825132754.GA895675@lo=
thringen/ [1]
> Reported-by: Valentin Schneider <vschneid@redhat.com>
> Closes: https://lore.kernel.org/linux-rt-users/xhsmhttqvnall.mognet@vschn=
eid.remote.csb/ [2]
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Intel(R) Xeon(R) CPU E5-2650, 2 NUMA nodes, 32 CPUs
| $ ./avg-nums.py results-rc7.txt=20
| Threads  | avg events/ms | stddev | samples
|    8       2565.20           48.15      5
|   16       2627.60           75.12      5
|   32       3897.20          117.41      5
|   64       4094.80           75.46      5
|  128       4464.40           92.54      5
| $ ./avg-nums.py results-rc7-patched.txt
| Threads  | avg events/ms | stddev | samples
|    8      15286.00         3116.36      5
|   16      27606.20         1890.96      5
|   32      33690.20         4010.02      5
|   64      54234.40         2832.40      5
|  128      71566.40         2284.48      5

AMD EPYC 7713, 2 NUMA nodes, 256 CPUs
| $ ./avg-nums.py nums-rc7.txt=20
| Threads  | avg events/ms | stddev | samples
|    8       2616.40          158.54      5
|   16       3710.40          104.34      5
|   32       6916.80          275.06      5
|   64       8487.20          263.31      5
|  128      10035.20          124.82      5
| $ ./avg-nums.py nums-rc7-patched.txt
| Threads  | avg events/ms | stddev | samples
|    8      20743.80         1158.03      5
|   16      41453.00         5706.46      5
|   32      88848.20        15076.17      5
|   64     166501.60        28763.04      5
|  128     312733.80        46626.34      5

So it improves on both machines. The deviation is larger on patched
version but still clearly winning.

On the AMD I tried
Unpatched:
| $ perf bench epoll all 2>&1 | grep -v "^\["
| # Running epoll/wait benchmark...
| Run summary [PID 3019]: 255 threads monitoring on 64 file-descriptors for=
 8 secs.
|
|
| Averaged 785 operations/sec (+- 0.05%), total secs =3D 8
|
| # Running epoll/ctl benchmark...
| Run summary [PID 3019]: 256 threads doing epoll_ctl ops 64 file-descripto=
rs for 8 secs.
|
|
| Averaged 2652 ADD operations (+- 1.19%)
| Averaged 2652 MOD operations (+- 1.19%)
| Averaged 2652 DEL operations (+- 1.19%)

Patched:
| $ perf bench epoll all 2>&1 | grep -v "^\["
| # Running epoll/wait benchmark...
| Run summary [PID 3001]: 255 threads monitoring on 64 file-descriptors for=
 8 secs.
|=20
|=20
| Averaged 1386 operations/sec (+- 3.94%), total secs =3D 8
|=20
| # Running epoll/ctl benchmark...
| Run summary [PID 3001]: 256 threads doing epoll_ctl ops 64 file-descripto=
rs for 8 secs.
|=20
|=20
| Averaged 1495 ADD operations (+- 1.11%)
| Averaged 1495 MOD operations (+- 1.11%)
| Averaged 1495 DEL operations (+- 1.11%)

The epoll_waits improves again, epoll_ctls does not. I'm not sure how to
read the latter. My guess would be that ADD/ MOD are fine but DEL is a
bit bad because it has to del, iterate, =E2=80=A6, add back.

Anyway, this still an improvement overall.

> ---
> v2:
>   - rename link_locked -> link_used
>   - replace xchg() with smp_store_release() when applicable
>   - make sure llist_node is in clean state when not on a list
>   - remove now-unused list_add_tail_lockless()
> ---
>  fs/eventpoll.c | 498 +++++++++++++++++++------------------------------
>  1 file changed, 189 insertions(+), 309 deletions(-)
>=20
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index d4dbffdedd08e..483a5b217fad4 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -136,14 +136,29 @@ struct epitem {
>  		struct rcu_head rcu;
>  	};
> =20
> -	/* List header used to link this structure to the eventpoll ready list =
*/
> -	struct list_head rdllink;
> +	/*
> +	 * Whether epitem.rdllink is currently used in a list. When used, it ca=
nnot be detached or

Notation wise I would either use plain "rdllink" or the C++ notation
"epitem::rdllink".

> +	 * inserted elsewhere.

When set, it is attached to eventpoll::rdllist and can not be attached
again.
This nothing to do with detaching.

> +	 * It may be in use for two reasons:
> +	 *
> +	 * 1. This item is on the eventpoll ready list.
> +	 * 2. This item is being consumed by a waiter and stashed on a temporar=
y list. If inserting
> +	 *    is blocked due to this reason, the waiter will add this item to t=
he list once
> +	 *    consuming is done.
> +	 */
> +	bool link_used;
> =20
>  	/*
> -	 * Works together "struct eventpoll"->ovflist in keeping the
> -	 * single linked chain of items.
> +	 * Indicate whether this item is ready for consumption. All items on th=
e ready list has this
                                                                           =
                have
> +	 * flag set. Item that should be on the ready list, but cannot be added=
 because of
> +	 * link_used (in other words, a waiter is consuming the ready list), al=
so has this flag
> +	 * set. When a waiter is done consuming, the waiter will add ready item=
s to the ready list.

This sounds confusing. What about:

| Ready items should be on eventpoll::rdllist. This might be not the case
| if a waiter is consuming the list and removed temporary all items while
| doing so. Once done, the item will be added back to eventpoll::rdllist.

The reason is either an item is removed from the list and you have to
remove them all, look for the right one, remove it from the list, splice
what is left to the original list.
I did not find another reason for that.

>  	 */
> -	struct epitem *next;
> +	bool ready;
> +
> +	/* List header used to link this structure to the eventpoll ready list =
*/
> +	struct llist_node rdllink;
> =20
>  	/* The file descriptor information this item refers to */
>  	struct epoll_filefd ffd;
> @@ -191,22 +206,15 @@ struct eventpoll {
>  	/* Wait queue used by file->poll() */
>  	wait_queue_head_t poll_wait;
> =20
> -	/* List of ready file descriptors */
> -	struct list_head rdllist;
> -
> -	/* Lock which protects rdllist and ovflist */
> -	rwlock_t lock;
> +	/*
> +	 * List of ready file descriptors. Adding to this list is lockless. Onl=
y one task can remove
> +	 * from this list at a time, which is ensured by the mutex "mtx".

| Items can be removed only with eventpoll::mtx=20

Or something like that. I would appreciate if you add a proper
lockdep_assert_held() where the llist_del.*() are. Those are more
powerful ;)

> +	 */
> +	struct llist_head rdllist;
> =20
>  	/* RB tree root used to store monitored fd structs */
>  	struct rb_root_cached rbr;
> =20
> -	/*
> -	 * This is a single linked list that chains all the "struct epitem" that
> -	 * happened while transferring ready events to userspace w/out
> -	 * holding ->lock.
> -	 */
> -	struct epitem *ovflist;
> -
>  	/* wakeup_source used when ep_send_events or __ep_eventpoll_poll is run=
ning */
>  	struct wakeup_source *ws;
> =20
> @@ -361,10 +369,27 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p=
1,
>  	        (p1->file < p2->file ? -1 : p1->fd - p2->fd));
>  }
> =20
> -/* Tells us if the item is currently linked */
> -static inline int ep_is_linked(struct epitem *epi)
> +static void epitem_ready(struct epitem *epi)
>  {
> -	return !list_empty(&epi->rdllink);
> +	/*
> +	 * Mark it ready, just in case a waiter is blocking this item from goin=
g into the ready
> +	 * list. This will tell the waiter to add this item to the ready list, =
after the waiter is
> +	 * finished.
> +	 */
> +	smp_store_release(&epi->ready, true);
> +
> +	/*
> +	 * If this item is not blocked, add it to the ready list. This item cou=
ld be blocked for two
> +	 * reasons:
> +	 *
> +	 * 1. It is already on the ready list. Then nothing further is required.
> +	 * 2. A waiter is consuming the ready list, and has consumed this item.=
 The waiter is now
> +	 *    blocking this item, so that this item won't be seen twice. In thi=
s case, the waiter
> +	 *    will add this item to the ready list after the waiter is finished.

Are there two waiter blocking each other or is there a waker also
involved? The term blocked might also not the right one.
My understanding is that the item is already on the list but the list is
rearranged because an item is removed.

> +	 */
> +	if (!cmpxchg(&epi->link_used, false, true))
> +		llist_add(&epi->rdllink, &epi->ep->rdllist);
> +
>  }
> =20
>  static inline struct eppoll_entry *ep_pwq_from_wait(wait_queue_entry_t *=
p)
> @@ -383,13 +408,27 @@ static inline struct epitem *ep_item_from_wait(wait=
_queue_entry_t *p)
>   *
>   * @ep: Pointer to the eventpoll context.
>   *
> - * Return: a value different than %zero if ready events are available,
> - *          or %zero otherwise.
> + * Return: true if ready events might be available, false otherwise.
>   */
> -static inline int ep_events_available(struct eventpoll *ep)
> +static inline bool ep_events_available(struct eventpoll *ep)
>  {
> -	return !list_empty_careful(&ep->rdllist) ||
> -		READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR;
> +	bool available;
> +	int locked;
> +
> +	locked =3D mutex_trylock(&ep->mtx);
> +	if (!locked) {
> +		/*
> +		 * Someone else is holding the lock and may be removing/adding items t=
o rdllist,
                                                                        ^<s=
pace>
> +		 * therefore the llist_empty() test below is not reliable. Return true=
 in this case,
> +		 * as in "events might be available". We will know for sure if there i=
s event in
> +		 * ep_try_send_events().

Maybe
| The lock held and someone might have removed all items while inspecting
| it. The llist_empty() check in this case is futile. Assume that
| something is enqueued and let ep_try_send_events() figure it out.

> +		 */
> +		return true;
> +	}
> +
> +	available =3D !llist_empty(&ep->rdllist);
> +	mutex_unlock(&ep->mtx);
> +	return available;
>  }
> =20
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> @@ -724,77 +763,6 @@ static inline void ep_pm_stay_awake_rcu(struct epite=
m *epi)
>  	rcu_read_unlock();
>  }
> =20
> -
> -/*
> - * ep->mutex needs to be held because we could be hit by
> - * eventpoll_release_file() and epoll_ctl().
> - */
> -static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
> -{
> -	/*
> -	 * Steal the ready list, and re-init the original one to the
> -	 * empty list. Also, set ep->ovflist to NULL so that events
> -	 * happening while looping w/out locks, are not lost. We cannot
> -	 * have the poll callback to queue directly on ep->rdllist,
> -	 * because we want the "sproc" callback to be able to do it
> -	 * in a lockless way.
> -	 */
> -	lockdep_assert_irqs_enabled();
> -	write_lock_irq(&ep->lock);
> -	list_splice_init(&ep->rdllist, txlist);
> -	WRITE_ONCE(ep->ovflist, NULL);
> -	write_unlock_irq(&ep->lock);
> -}
> -
> -static void ep_done_scan(struct eventpoll *ep,
> -			 struct list_head *txlist)
> -{
> -	struct epitem *epi, *nepi;
> -
> -	write_lock_irq(&ep->lock);
> -	/*
> -	 * During the time we spent inside the "sproc" callback, some
> -	 * other events might have been queued by the poll callback.
> -	 * We re-insert them inside the main ready-list here.
> -	 */
> -	for (nepi =3D READ_ONCE(ep->ovflist); (epi =3D nepi) !=3D NULL;
> -	     nepi =3D epi->next, epi->next =3D EP_UNACTIVE_PTR) {
> -		/*
> -		 * We need to check if the item is already in the list.
> -		 * During the "sproc" callback execution time, items are
> -		 * queued into ->ovflist but the "txlist" might already
> -		 * contain them, and the list_splice() below takes care of them.
> -		 */
> -		if (!ep_is_linked(epi)) {
> -			/*
> -			 * ->ovflist is LIFO, so we have to reverse it in order
> -			 * to keep in FIFO.
> -			 */
> -			list_add(&epi->rdllink, &ep->rdllist);
> -			ep_pm_stay_awake(epi);
> -		}
> -	}
> -	/*
> -	 * We need to set back ep->ovflist to EP_UNACTIVE_PTR, so that after
> -	 * releasing the lock, events will be queued in the normal way inside
> -	 * ep->rdllist.
> -	 */
> -	WRITE_ONCE(ep->ovflist, EP_UNACTIVE_PTR);
> -
> -	/*
> -	 * Quickly re-inject items left on "txlist".
> -	 */
> -	list_splice(txlist, &ep->rdllist);
> -	__pm_relax(ep->ws);
> -
> -	if (!list_empty(&ep->rdllist)) {
> -		if (waitqueue_active(&ep->wq))
> -			wake_up(&ep->wq);
> -	}
> -
> -	write_unlock_irq(&ep->lock);
> -}
> -
>  static void ep_get(struct eventpoll *ep)
>  {
>  	refcount_inc(&ep->refcount);
> @@ -832,8 +800,10 @@ static void ep_free(struct eventpoll *ep)
>  static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool f=
orce)
>  {
>  	struct file *file =3D epi->ffd.file;
> +	struct llist_node *put_back_last;
>  	struct epitems_head *to_free;
>  	struct hlist_head *head;
> +	LLIST_HEAD(put_back);
> =20
>  	lockdep_assert_irqs_enabled();

You could remove that lockdep assert. It was only due to the
write_.*lock_irq() which is gone.
> =20
> @@ -867,10 +837,25 @@ static bool __ep_remove(struct eventpoll *ep, struc=
t epitem *epi, bool force)
> =20
>  	rb_erase_cached(&epi->rbn, &ep->rbr);
> =20
> -	write_lock_irq(&ep->lock);
> -	if (ep_is_linked(epi))
> -		list_del_init(&epi->rdllink);
> -	write_unlock_irq(&ep->lock);
> +	/*
> +	 * ep->mtx is held, which means no waiter is touching the ready list. T=
his item is also no
> +	 * longer being added. Therefore, the ready flag can only mean one thin=
g: this item is on
> +	 * the ready list.
> +	 */
> +	if (smp_load_acquire(&epi->ready)) {
> +		put_back_last =3D NULL;
> +		while (true) {
> +			struct llist_node *n =3D llist_del_first(&ep->rdllist);
> +
> +			if (&epi->rdllink =3D=3D n || WARN_ON(!n))
> +				break;
> +			if (!put_back_last)
> +				put_back_last =3D n;
> +			llist_add(n, &put_back);
> +		}
> +		if (put_back_last)
> +			llist_add_batch(put_back.first, put_back_last, &ep->rdllist);
> +	}
> =20
>  	wakeup_source_unregister(ep_wakeup_source(epi));
>  	/*
> @@ -974,8 +959,9 @@ static __poll_t ep_item_poll(const struct epitem *epi=
, poll_table *pt, int depth
>  static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait,=
 int depth)
>  {
>  	struct eventpoll *ep =3D file->private_data;
> -	LIST_HEAD(txlist);
> -	struct epitem *epi, *tmp;
> +	struct wakeup_source *ws;
> +	struct llist_node *n;
> +	struct epitem *epi;
>  	poll_table pt;
>  	__poll_t res =3D 0;
> =20
> @@ -989,22 +975,58 @@ static __poll_t __ep_eventpoll_poll(struct file *fi=
le, poll_table *wait, int dep
>  	 * the ready list.
>  	 */
>  	mutex_lock_nested(&ep->mtx, depth);
> -	ep_start_scan(ep, &txlist);
> -	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
> +	while (true) {
> +		n =3D llist_del_first_init(&ep->rdllist);
> +		if (!n)
> +			break;
> +
> +		epi =3D llist_entry(n, struct epitem, rdllink);
> +
> +		/*
> +		 * Clear the ready flag now. If it is actually ready, we will set it b=
ack.
> +		 *
> +		 * However, if it is not ready now, it could become ready after ep_ite=
m_poll() and
> +		 * before we release list_locked this item, and it wouldn't be added t=
o the ready
> +		 * list. To detect that case, we look at this flag again after releasi=
ng
> +		 * link_used, so that it can be added to the ready list if required.
> +		 */

How can it be on readylist and not ready? I know you the code but an
item is inly added to the readylist after consulting ep_item_poll(). So
I am not sure why this should change.

I would suggest to:
| Clear ::ready and keep ::link_used set. The ep_item_poll() is consulted
| to check if that item can remain on the list. If it may, we set ::ready
| back and add it to list. Keeping ::link_used prevents a double add.
| If not ::link_used is cleared. Additionally ::ready is checked again
| below to check if the condition changed in between. If so, it is added
| back to the list.

> +		smp_store_release(&epi->ready, false);
> +
>  		if (ep_item_poll(epi, &pt, depth + 1)) {
>  			res =3D EPOLLIN | EPOLLRDNORM;
> +			smp_store_release(&epi->ready, true);
> +			llist_add(n, &ep->rdllist);
>  			break;
>  		} else {
>  			/*
> -			 * Item has been dropped into the ready list by the poll
> -			 * callback, but it's not actually ready, as far as
> -			 * caller requested events goes. We can remove it here.
> +			 * We need to activate ep before deactivating epi, to prevent autosus=
pend
> +			 * just in case epi becomes active after ep_item_poll() above.
> +			 *
> +			 * This is similar to ep_send_events().
>  			 */
> +			ws =3D ep_wakeup_source(epi);
> +			if (ws) {
> +				if (ws->active)
> +					__pm_stay_awake(ep->ws);
> +				__pm_relax(ws);
> +			}
>  			__pm_relax(ep_wakeup_source(epi));
> -			list_del_init(&epi->rdllink);
> +
> +			smp_store_release(&epi->link_used, false);
> +
> +			/*
> +			 * Check the ready flag, just in case the item becomes ready after
> +			 * ep_item_poll() but before releasing link_used above. The item was
> +			 * blocked from being added, so we add it now.
> +			 */

This comment could go if we have the one above referencing to this
scenario.

> +			if (smp_load_acquire(&epi->ready)) {
> +				ep_pm_stay_awake(epi);
> +				epitem_ready(epi);
> +			}
> +
> +			__pm_relax(ep->ws);
>  		}
>  	}
> -	ep_done_scan(ep, &txlist);
>  	mutex_unlock(&ep->mtx);
>  	return res;
>  }
> @@ -1153,12 +1175,10 @@ static int ep_alloc(struct eventpoll **pep)
>  		return -ENOMEM;
> =20
>  	mutex_init(&ep->mtx);
> -	rwlock_init(&ep->lock);
>  	init_waitqueue_head(&ep->wq);
>  	init_waitqueue_head(&ep->poll_wait);
> -	INIT_LIST_HEAD(&ep->rdllist);
> +	init_llist_head(&ep->rdllist);
>  	ep->rbr =3D RB_ROOT_CACHED;
> -	ep->ovflist =3D EP_UNACTIVE_PTR;
>  	ep->user =3D get_current_user();
>  	refcount_set(&ep->refcount, 1);
> =20
> @@ -1240,94 +1260,11 @@ struct file *get_epoll_tfile_raw_ptr(struct file =
*file, int tfd,
>  }
>  #endif /* CONFIG_KCMP */
> =20
> -/*
> - * Adds a new entry to the tail of the list in a lockless way, i.e.
> - * multiple CPUs are allowed to call this function concurrently.
> - *
> - * Beware: it is necessary to prevent any other modifications of the
> - *         existing list until all changes are completed, in other words
> - *         concurrent list_add_tail_lockless() calls should be protected
> - *         with a read lock, where write lock acts as a barrier which
> - *         makes sure all list_add_tail_lockless() calls are fully
> - *         completed.
> - *
> - *        Also an element can be locklessly added to the list only in one
> - *        direction i.e. either to the tail or to the head, otherwise
> - *        concurrent access will corrupt the list.
> - *
> - * Return: %false if element has been already added to the list, %true
> - * otherwise.
> - */
> -static inline bool list_add_tail_lockless(struct list_head *new,
> -					  struct list_head *head)
> -{
> -	struct list_head *prev;
> -
> -	/*
> -	 * This is simple 'new->next =3D head' operation, but cmpxchg()
> -	 * is used in order to detect that same element has been just
> -	 * added to the list from another CPU: the winner observes
> -	 * new->next =3D=3D new.
> -	 */
> -	if (!try_cmpxchg(&new->next, &new, head))
> -		return false;
> -
> -	/*
> -	 * Initially ->next of a new element must be updated with the head
> -	 * (we are inserting to the tail) and only then pointers are atomically
> -	 * exchanged.  XCHG guarantees memory ordering, thus ->next should be
> -	 * updated before pointers are actually swapped and pointers are
> -	 * swapped before prev->next is updated.
> -	 */
> -
> -	prev =3D xchg(&head->prev, new);
> -
> -	/*
> -	 * It is safe to modify prev->next and new->prev, because a new element
> -	 * is added only to the tail and new->next is updated before XCHG.
> -	 */
> -
> -	prev->next =3D new;
> -	new->prev =3D prev;
> -
> -	return true;
> -}
> -
> -/*
> - * Chains a new epi entry to the tail of the ep->ovflist in a lockless w=
ay,
> - * i.e. multiple CPUs are allowed to call this function concurrently.
> - *
> - * Return: %false if epi element has been already chained, %true otherwi=
se.
> - */
> -static inline bool chain_epi_lockless(struct epitem *epi)
> -{
> -	struct eventpoll *ep =3D epi->ep;
> -
> -	/* Fast preliminary check */
> -	if (epi->next !=3D EP_UNACTIVE_PTR)
> -		return false;
> -
> -	/* Check that the same epi has not been just chained from another CPU */
> -	if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) !=3D EP_UNACTIVE_PTR)
> -		return false;
> -
> -	/* Atomically exchange tail */
> -	epi->next =3D xchg(&ep->ovflist, epi);
> -
> -	return true;
> -}
> -
>  /*
>   * This is the callback that is passed to the wait queue wakeup
>   * mechanism. It is called by the stored file descriptors when they
>   * have events to report.
>   *
> - * This callback takes a read lock in order not to contend with concurre=
nt
> - * events from another file descriptor, thus all modifications to ->rdll=
ist
> - * or ->ovflist are lockless.  Read lock is paired with the write lock f=
rom
> - * ep_start/done_scan(), which stops all list modifications and guarante=
es
> - * that lists state is seen correctly.
> - *
>   * Another thing worth to mention is that ep_poll_callback() can be call=
ed
>   * concurrently for the same @epi from different CPUs if poll table was =
inited
>   * with several wait queues entries.  Plural wakeup from different CPUs =
of a
> @@ -1337,15 +1274,11 @@ static inline bool chain_epi_lockless(struct epit=
em *epi)
>   */
>  static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int=
 sync, void *key)
>  {
> -	int pwake =3D 0;
>  	struct epitem *epi =3D ep_item_from_wait(wait);
>  	struct eventpoll *ep =3D epi->ep;
>  	__poll_t pollflags =3D key_to_poll(key);
> -	unsigned long flags;
>  	int ewake =3D 0;
> =20
> -	read_lock_irqsave(&ep->lock, flags);
> -
>  	ep_set_busy_poll_napi_id(epi);
> =20
>  	/*
> @@ -1355,7 +1288,7 @@ static int ep_poll_callback(wait_queue_entry_t *wai=
t, unsigned mode, int sync, v
>  	 * until the next EPOLL_CTL_MOD will be issued.
>  	 */
>  	if (!(epi->event.events & ~EP_PRIVATE_BITS))
> -		goto out_unlock;
> +		goto out;
> =20
>  	/*
>  	 * Check the events coming with the callback. At this stage, not
> @@ -1364,22 +1297,10 @@ static int ep_poll_callback(wait_queue_entry_t *w=
ait, unsigned mode, int sync, v
>  	 * test for "key" !=3D NULL before the event match test.
>  	 */
>  	if (pollflags && !(pollflags & epi->event.events))
> -		goto out_unlock;
> +		goto out;
> =20
> -	/*
> -	 * If we are transferring events to userspace, we can hold no locks
> -	 * (because we're accessing user memory, and because of linux f_op->pol=
l()
> -	 * semantics). All the events that happen during that period of time are
> -	 * chained in ep->ovflist and requeued later on.
> -	 */
> -	if (READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR) {
> -		if (chain_epi_lockless(epi))
> -			ep_pm_stay_awake_rcu(epi);
> -	} else if (!ep_is_linked(epi)) {
> -		/* In the usual case, add event to ready list. */
> -		if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
> -			ep_pm_stay_awake_rcu(epi);
> -	}
> +	ep_pm_stay_awake_rcu(epi);
> +	epitem_ready(epi);
> =20
>  	/*
>  	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
> @@ -1408,15 +1329,9 @@ static int ep_poll_callback(wait_queue_entry_t *wa=
it, unsigned mode, int sync, v
>  			wake_up(&ep->wq);
>  	}
>  	if (waitqueue_active(&ep->poll_wait))
> -		pwake++;
> -
> -out_unlock:
> -	read_unlock_irqrestore(&ep->lock, flags);
> -
> -	/* We have to call this outside the lock */
> -	if (pwake)
>  		ep_poll_safewake(ep, epi, pollflags & EPOLL_URING_WAKE);
> =20
> +out:
>  	if (!(epi->event.events & EPOLLEXCLUSIVE))
>  		ewake =3D 1;
> =20
> @@ -1674,11 +1589,10 @@ static int ep_insert(struct eventpoll *ep, const =
struct epoll_event *event,
>  	}

if you scroll up, there is lockdep_assert_irqs_enabled(), please remove
it.

>  	/* Item initialization follow here ... */
> -	INIT_LIST_HEAD(&epi->rdllink);
> +	init_llist_node(&epi->rdllink);
>  	epi->ep =3D ep;
>  	ep_set_ffd(&epi->ffd, tfile, fd);
>  	epi->event =3D *event;
> -	epi->next =3D EP_UNACTIVE_PTR;
> =20
>  	if (tep)
>  		mutex_lock_nested(&tep->mtx, 1);
> @@ -1745,16 +1659,13 @@ static int ep_insert(struct eventpoll *ep, const =
struct epoll_event *event,
>  		return -ENOMEM;
>  	}
> =20
> -	/* We have to drop the new item inside our item list to keep track of i=
t */
> -	write_lock_irq(&ep->lock);
> -
>  	/* record NAPI ID of new item if present */
>  	ep_set_busy_poll_napi_id(epi);
> =20
>  	/* If the file is already "ready" we drop it inside the ready list */
> -	if (revents && !ep_is_linked(epi)) {
> -		list_add_tail(&epi->rdllink, &ep->rdllist);
> +	if (revents) {
>  		ep_pm_stay_awake(epi);
> +		epitem_ready(epi);
> =20
>  		/* Notify waiting tasks that events are available */
>  		if (waitqueue_active(&ep->wq))
> @@ -1763,8 +1674,6 @@ static int ep_insert(struct eventpoll *ep, const st=
ruct epoll_event *event,
>  			pwake++;
>  	}
> =20
> -	write_unlock_irq(&ep->lock);
> -
>  	/* We have to call this outside the lock */
>  	if (pwake)
>  		ep_poll_safewake(ep, NULL, 0);
> @@ -1779,7 +1688,6 @@ static int ep_insert(struct eventpoll *ep, const st=
ruct epoll_event *event,
>  static int ep_modify(struct eventpoll *ep, struct epitem *epi,
>  		     const struct epoll_event *event)
>  {
> -	int pwake =3D 0;
>  	poll_table pt;
> =20
>  	lockdep_assert_irqs_enabled();

this can go, too.

> @@ -1827,24 +1735,16 @@ static int ep_modify(struct eventpoll *ep, struct=
 epitem *epi,
>  	 * list, push it inside.
>  	 */
>  	if (ep_item_poll(epi, &pt, 1)) {
> -		write_lock_irq(&ep->lock);
> -		if (!ep_is_linked(epi)) {
> -			list_add_tail(&epi->rdllink, &ep->rdllist);
> -			ep_pm_stay_awake(epi);
> +		ep_pm_stay_awake(epi);
> +		epitem_ready(epi);
> =20
> -			/* Notify waiting tasks that events are available */
> -			if (waitqueue_active(&ep->wq))
> -				wake_up(&ep->wq);
> -			if (waitqueue_active(&ep->poll_wait))
> -				pwake++;
> -		}
> -		write_unlock_irq(&ep->lock);
> +		/* Notify waiting tasks that events are available */
> +		if (waitqueue_active(&ep->wq))
> +			wake_up(&ep->wq);
> +		if (waitqueue_active(&ep->poll_wait))
> +			ep_poll_safewake(ep, NULL, 0);
>  	}
> =20
> -	/* We have to call this outside the lock */
> -	if (pwake)
> -		ep_poll_safewake(ep, NULL, 0);
> -
>  	return 0;
>  }
> =20
> @@ -1852,7 +1752,7 @@ static int ep_send_events(struct eventpoll *ep,
>  			  struct epoll_event __user *events, int maxevents)
>  {
>  	struct epitem *epi, *tmp;
> -	LIST_HEAD(txlist);
> +	LLIST_HEAD(txlist);
>  	poll_table pt;
>  	int res =3D 0;
> =20
> @@ -1867,19 +1767,20 @@ static int ep_send_events(struct eventpoll *ep,
>  	init_poll_funcptr(&pt, NULL);
> =20
>  	mutex_lock(&ep->mtx);
> -	ep_start_scan(ep, &txlist);
> =20
> -	/*
> -	 * We can loop without lock because we are passed a task private list.
> -	 * Items cannot vanish during the loop we are holding ep->mtx.
> -	 */
> -	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
> +	while (res < maxevents) {
>  		struct wakeup_source *ws;
> +		struct llist_node *n;
>  		__poll_t revents;
> =20
> -		if (res >=3D maxevents)
> +		n =3D llist_del_first(&ep->rdllist);
> +		if (!n)
>  			break;
> =20
> +		epi =3D llist_entry(n, struct epitem, rdllink);
> +		llist_add(n, &txlist);
> +		smp_store_release(&epi->ready, false);
> +
>  		/*
>  		 * Activate ep->ws before deactivating epi->ws to prevent
>  		 * triggering auto-suspend here (in case we reactive epi->ws
> @@ -1896,8 +1797,6 @@ static int ep_send_events(struct eventpoll *ep,
>  			__pm_relax(ws);
>  		}
> =20
> -		list_del_init(&epi->rdllink);
> -
>  		/*
>  		 * If the event mask intersect the caller-requested one,
>  		 * deliver the event to userspace. Again, we are holding ep->mtx,
> @@ -1909,8 +1808,7 @@ static int ep_send_events(struct eventpoll *ep,
> =20
>  		events =3D epoll_put_uevent(revents, epi->event.data, events);
>  		if (!events) {
> -			list_add(&epi->rdllink, &txlist);
> -			ep_pm_stay_awake(epi);
> +			smp_store_release(&epi->ready, true);
>  			if (!res)
>  				res =3D -EFAULT;
>  			break;
> @@ -1924,19 +1822,40 @@ static int ep_send_events(struct eventpoll *ep,
>  			 * Trigger mode, we need to insert back inside
>  			 * the ready list, so that the next call to
>  			 * epoll_wait() will check again the events
> -			 * availability. At this point, no one can insert
> -			 * into ep->rdllist besides us. The epoll_ctl()
> -			 * callers are locked out by
> -			 * ep_send_events() holding "mtx" and the
> -			 * poll callback will queue them in ep->ovflist.
> +			 * availability.
>  			 */
> -			list_add_tail(&epi->rdllink, &ep->rdllist);
> +			smp_store_release(&epi->ready, true);
> +		}
> +	}
> +
> +	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
> +		/*
> +		 * We are done iterating. Allow the items we took to be added back to =
the ready
> +		 * list.
> +		 */
> +		init_llist_node(&epi->rdllink);
> +		smp_store_release(&epi->link_used, false);
> +
> +		/*
> +		 * In the loop above, we may mark some items ready, and they should be=
 added back.
> +		 *
> +		 * Additionally, someone else may also attempt to add the item to the =
ready list,
> +		 * but got blocked by us. Add those blocked items now.
> +		 */

You the get epi items here from the ep->rdllist. In order to get there,
you have ::ready set and once it is added ::link_used is also set. That
item is removed from the list. If one of the conditions are true, you
set ::ready true and expect it to be added to the rdlist below. But
since ::link_used is true, this won't happen.

> +		if (smp_load_acquire(&epi->ready)) {
>  			ep_pm_stay_awake(epi);
> +			epitem_ready(epi);
>  		}
>  	}
> -	ep_done_scan(ep, &txlist);
> +
> +	__pm_relax(ep->ws);
>  	mutex_unlock(&ep->mtx);
> =20
> +	if (!llist_empty(&ep->rdllist)) {
> +		if (waitqueue_active(&ep->wq))
> +			wake_up(&ep->wq);
> +	}
> +
>  	return res;
>  }
> =20
> @@ -2090,54 +2009,15 @@ static int ep_poll(struct eventpoll *ep, struct e=
poll_event __user *events,
>  		init_wait(&wait);
>  		wait.func =3D ep_autoremove_wake_function;

another lockdep_assert_irqs_enabled() at the top which can go.

> -		write_lock_irq(&ep->lock);
> -		/*
> -		 * Barrierless variant, waitqueue_active() is called under
> -		 * the same lock on wakeup ep_poll_callback() side, so it
> -		 * is safe to avoid an explicit barrier.
> -		 */
> -		__set_current_state(TASK_INTERRUPTIBLE);
> -
> -		/*
> -		 * Do the final check under the lock. ep_start/done_scan()
> -		 * plays with two lists (->rdllist and ->ovflist) and there
> -		 * is always a race when both lists are empty for short
> -		 * period of time although events are pending, so lock is
> -		 * important.
> -		 */
> -		eavail =3D ep_events_available(ep);
> -		if (!eavail)
> -			__add_wait_queue_exclusive(&ep->wq, &wait);
> +		prepare_to_wait_exclusive(&ep->wq, &wait, TASK_INTERRUPTIBLE);
> =20
> -		write_unlock_irq(&ep->lock);
> -
> -		if (!eavail)
> +		if (!ep_events_available(ep))
>  			timed_out =3D !ep_schedule_timeout(to) ||
>  				!schedule_hrtimeout_range(to, slack,
>  							  HRTIMER_MODE_ABS);
> -		__set_current_state(TASK_RUNNING);
> =20
> -		/*
> -		 * We were woken up, thus go and try to harvest some events.
> -		 * If timed out and still on the wait queue, recheck eavail
> -		 * carefully under lock, below.
> -		 */
> -		eavail =3D 1;
> -
> -		if (!list_empty_careful(&wait.entry)) {
> -			write_lock_irq(&ep->lock);
> -			/*
> -			 * If the thread timed out and is not on the wait queue,
> -			 * it means that the thread was woken up after its
> -			 * timeout expired before it could reacquire the lock.
> -			 * Thus, when wait.entry is empty, it needs to harvest
> -			 * events.
> -			 */
> -			if (timed_out)
> -				eavail =3D list_empty(&wait.entry);
> -			__remove_wait_queue(&ep->wq, &wait);
> -			write_unlock_irq(&ep->lock);
> -		}
> +		finish_wait(&ep->wq, &wait);
> +		eavail =3D ep_events_available(ep);
>  	}
>  }
> =20

Sebastian

