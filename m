Return-Path: <linux-fsdevel+bounces-22457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396169174CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 01:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21271F22D65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5317F4F5;
	Tue, 25 Jun 2024 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ixPfC+R6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F811494A3;
	Tue, 25 Jun 2024 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358579; cv=none; b=cpgW/bjSpAwn0WRIG4JasxsylvGEhUEQu/FroMygAMeEjBGZMEug1UCk5cFDXZAHvRbfgpLLLZjms6j3pt0McDl3QVtme83j326p+ri+X9bkETbcZWh56ww5nUJSj/TXKM8xvCImcGg51ILcVlsYFS4VuvCEAVPP4ZJt2oEFKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358579; c=relaxed/simple;
	bh=GSWh5tUlg8abecnbp/JI8+OT4IW804zroCodts6x+H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEoUp6IrnCxiHirl4QD2JBuFaNkLdX4Ri2rsWXdkyMmgc8e5KMH46voUi/cNbdolUWLhyXzj8/1OgJ/lrh96VMO9axdrjbv7wYzs0xjquM2cmqtFmj9iz8O8xzigZ5enZbhm1mz+WNyi3F7wRuJ5N03tEf7F0iaeL+/luPlqBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ixPfC+R6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=oNwQOc6Av7EhMWoM+Hq6+7opqEKayKU1T/eW7wAsTJI=; b=ixPfC+R6yIWVUWUt
	S9s/EAj+iyy2aKXT1GYCSnoQnKCS+JBnRv7qMwRrjO7cFNr6U1B2voAdv5EYHXWl6ad1bpJNtxnKJ
	7EGM0uoCA3kxjMkwK5L63y588ylqI3r5Q0OUM5dCqWnilu4FLu+uPYyE/kCjZJe8VvQ3oC90rAbJw
	17ATwq6ZydmYoWkbblW96mY0cMQYd8dylS85kmoOLwXuK/yp84N7VCMbqNwk4+btsJLAXjJPDPtE5
	edwjJG5ybHFtUaXONo8QayqJFIIwQxx4jTTHMTLP6zX8mXM8U00MBYjnkq2FrnmtQ3akjiLiWEL9N
	N9MJf2soBLQ+zUXL7Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sMFhm-008La2-1S;
	Tue, 25 Jun 2024 23:36:06 +0000
Date: Tue, 25 Jun 2024 23:36:06 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 2/5] rosebush: Add new data structure
Message-ID: <ZntUZjXKBVDuAufy@gallifrey>
References: <20240625211803.2750563-1-willy@infradead.org>
 <20240625211803.2750563-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240625211803.2750563-3-willy@infradead.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:35:19 up 48 days, 10:49,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Matthew Wilcox (Oracle) (willy@infradead.org) wrote:
> Rosebush is a resizing hash table.  See
> Docuemntation/core-api/rosebush.rst for details.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/core-api/index.rst    |   1 +
>  Documentation/core-api/rosebush.rst | 121 +++++
>  MAINTAINERS                         |   8 +
>  include/linux/rosebush.h            |  62 +++
>  lib/Makefile                        |   2 +-
>  lib/rosebush.c                      | 654 ++++++++++++++++++++++++++++
>  6 files changed, 847 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/core-api/rosebush.rst
>  create mode 100644 include/linux/rosebush.h
>  create mode 100644 lib/rosebush.c
> 
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index f147854700e4..8984a7d6ad73 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -36,6 +36,7 @@ Library functionality that is used throughout the kernel.
>     kobject
>     kref
>     assoc_array
> +   rosebush
>     xarray
>     maple_tree
>     idr
> diff --git a/Documentation/core-api/rosebush.rst b/Documentation/core-api/rosebush.rst
> new file mode 100644
> index 000000000000..f0c0bc690e48
> --- /dev/null
> +++ b/Documentation/core-api/rosebush.rst
> @@ -0,0 +1,121 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +========
> +Rosebush
> +========
> +
> +:Author: Matthew Wilcox
> +
> +Overview
> +========
> +
> +Rosebush is a hashtable, different from the rhashtable.  It is scalable
> +(one spinlock per bucket), resizing in two dimensions (number and size
> +of buckets),

Is that old - I thought the cover letter said v2 had fixed size buckets?

Dave

> and concurrent (can be iterated under the RCU read lock).
> +It is designed to minimise dependent cache misses, which can stall a
> +modern CPU for thousands of instructions.
> +
> +Objects stored in a rosebush do not have an embedded linked list.
> +They can therefore be placed into the same rosebush multiple times and
> +be placed in multiple rosebushes.  It is also possible to store pointers
> +which have special meaning like ERR_PTR().  It is not possible to store
> +a NULL pointer in a rosebush, as this is the return value that indicates
> +the iteration has finished.
> +
> +The user of the rosebush is responsible for calculating their own hash.
> +A high quality hash is desirable to keep the scalable properties of
> +the rosebush, but a hash with poor distribution in the lower bits will
> +not lead to a catastrophic breakdown.  It may lead to excessive memory
> +consumption and a lot of CPU time spent during lookup.
> +
> +Rosebush is not yet IRQ or BH safe.  It can be iterated in interrupt
> +context, but not modified.
> +
> +RCU Iteration
> +-------------
> +
> +There is no rosebush_lookup() function.  This is because the hash value
> +may not be unique.  Instead, the user should iterate the rosebush,
> +which will return pointers which probably have matching hash values.
> +It is the user's responsibility to determine if the returned pointer is
> +one they are interested in.
> +
> +Rosebush iteration guarantees to return all pointers which have a
> +matching hash, were in the rosebush before the iteration started and
> +remain in the rosebush after iteration ends.  It may return additional
> +pointers, including pointers which do not have a matching hash value,
> +but it guarantees not to skip any pointers, and it guarantees to only
> +return pointers which have (at some point) been stored in the rosebush.
> +
> +If the rosebush is modified while the iteration is in progress, newly
> +added entries may or may not be returned and removed entries may or may
> +not be returned.  Causality is not honoured; e.g. if Entry A is known
> +to be inserted before Entry B, it is possible for an iteration to return
> +Entry B and not Entry A.
> +
> +Functions and structures
> +========================
> +
> +.. kernel-doc:: include/linux/rosebush.h
> +.. kernel-doc:: lib/rosebush.c
> +
> +Internals
> +=========
> +
> +The rosebush is organised into a top level table which contains pointers
> +to buckets.  Each bucket contains a spinlock (for modifications to the
> +bucket), the number of entries in the bucket and a contention counter.
> +
> +The top level table is a power of two in size.  The bottom M bits of the
> +hash are used to index into this table.  The bucket contains hash values
> +followed by their corresponding pointers.  We also track a contention
> +count, which lets us know if this spinlock is overloaded and we should
> +split the bucket to improve scalability.
> +
> +A bucket may be shared between multiple table entries.  For simplicity,
> +we require that all buckets are shared between a power-of-two number
> +of slots.  For example, a table with 8 entries might have entries that
> +point to buckets A, B, A, B, A, C, A, D.  If we were to then split bucket
> +A, we would replace the first pair of pointers with pointers to bucket
> +E and the second pair with pointers to bucket F.  This is akin to the
> +buddy page allocator.
> +
> +When we decide that the table needs to be resized, we allocate a new
> +table, and duplicate the current contents of the table into each half
> +of the new table.  At this point, all buckets in the table are shared.
> +We then split the bucket that we're trying to insert into.
> +
> +IRQ / BH safety
> +---------------
> +
> +If we decide to make the rosebush modifiable in IRQ context, we need
> +to take the locks in an irq-safe way; we need to figure out how to
> +allocate the top level table without vmalloc(), and we need to manage
> +without kvfree_rcu_mightsleep().  These all have solutions, but those
> +solutions have a cost that isn't worth paying until we have users.
> +
> +Some of those problems go away if we limit our support to removal in IRQ
> +context and only allow insertions in process context (as we do not need
> +to reallocate the table or bucket when removing an item).
> +
> +Small rosebushes
> +----------------
> +
> +As an optimisation, if the rosebush has no entries, the buckets pointer
> +is NULL.  If the rosebush has only a few entries, there are only two
> +buckets (allocated as a single allocation) and the table pointer points
> +directly to the first one instead of pointing to a table.
> +
> +Shrinking the rosebush
> +----------------------
> +
> +We do not currently attempt either to join buckets or to shrink the table
> +if sufficiently many buckets are shared.  If this proves to be a desirable
> +course of action, we can add support for it, with sufficient hysteresis
> +that adding/removing a single entry will not cause bouncing.
> +
> +Rosebush statistics
> +-------------------
> +
> +It would probably be wise to be able to gather statistics about bucket
> +occupancy rates, but this work has not yet been done.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a39c237edb95..d4a8e99919a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19467,6 +19467,14 @@ F:	include/net/rose.h
>  F:	include/uapi/linux/rose.h
>  F:	net/rose/
>  
> +ROSEBUSH DATA STRUCTURE
> +M:	Matthew Wilcox <willy@infradead.org>
> +L:	maple-tree@lists.infradead.org
> +S:	Supported
> +F:	Documentation/core-api/rosebush.rst
> +F:	include/linux/rosebush.h
> +F:	lib/*rosebush.c
> +
>  ROTATION DRIVER FOR ALLWINNER A83T
>  M:	Jernej Skrabec <jernej.skrabec@gmail.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/include/linux/rosebush.h b/include/linux/rosebush.h
> new file mode 100644
> index 000000000000..57f4dfa3f93d
> --- /dev/null
> +++ b/include/linux/rosebush.h
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* See lib/rosebush.c */
> +
> +#ifndef _LINUX_ROSEBUSH_H
> +#define _LINUX_ROSEBUSH_H
> +
> +#include <linux/spinlock.h>
> +
> +/*
> + * Embed this struct in your struct, don't allocate it separately.
> + * None of this is for customers to use; treat it as opaque.
> + * In particular, taking the rbh_resize_lock will prevent only rbh_table
> + * from being reallocated; buckets can still be grown and split without
> + * the lock.  But you will get incomprehensible lockdep warnings!
> + */
> +struct rbh {
> +	spinlock_t	rbh_resize_lock;
> +	unsigned long	rbh_table;	/* A tagged pointer */
> +};
> +
> +#define DEFINE_ROSEBUSH(name)	struct rbh name = \
> +	{ .rbh_resize_lock = __SPIN_LOCK_UNLOCKED(name.lock), }
> +
> +int rbh_insert(struct rbh *rbh, u32 hash, void *p);
> +int rbh_reserve(struct rbh *rbh, u32 hash);
> +int rbh_use(struct rbh *rbh, u32 hash, void *p);
> +int rbh_remove(struct rbh *rbh, u32 hash, void *p);
> +void rbh_destroy(struct rbh *rbh);
> +
> +/**
> + * rbh_release - Release a reserved slot in a rosebush.
> + * @rbh: The rosebush.
> + * @hash: The hash value that was reserved.
> + *
> + * If you decide that you do not need to use a reserved slot, call this
> + * function to release the slot.
> + *
> + * Return: 0 on success, -ENOENT if no reserved slot was found.
> + */
> +
> +static inline int rbh_release(struct rbh *rbh, u32 hash)
> +{
> +	return rbh_remove(rbh, hash, NULL);
> +}
> +
> +struct rbh_iter {
> +	struct rbh *rbh;
> +	struct rbh_bucket *bucket;
> +	u32 hash;
> +	unsigned int index;
> +};
> +
> +#define RBH_ITER(name, _rbh, _hash)					\
> +	struct rbh_iter name = { .rbh = _rbh, .hash = _hash, }
> +
> +void *rbh_next(struct rbh_iter *rbhi);
> +
> +void rbh_iter_remove(struct rbh_iter *rbhi, void *p);
> +void rbh_iter_lock(struct rbh_iter *rbhi);
> +void rbh_iter_unlock(struct rbh_iter *rbhi);
> +
> +#endif
> diff --git a/lib/Makefile b/lib/Makefile
> index 3b1769045651..723e6c90b58d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -28,7 +28,7 @@ CFLAGS_string.o += -fno-stack-protector
>  endif
>  
>  lib-y := ctype.o string.o vsprintf.o cmdline.o \
> -	 rbtree.o radix-tree.o timerqueue.o xarray.o \
> +	 rosebush.o rbtree.o radix-tree.o timerqueue.o xarray.o \
>  	 maple_tree.o idr.o extable.o irq_regs.o argv_split.o \
>  	 flex_proportions.o ratelimit.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
> diff --git a/lib/rosebush.c b/lib/rosebush.c
> new file mode 100644
> index 000000000000..47106a04d11d
> --- /dev/null
> +++ b/lib/rosebush.c
> @@ -0,0 +1,654 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Rosebush, a resizing bucket hash table
> + * Copyright (c) 2024 Oracle Corporation
> + * Author: Matthew Wilcox <willy@infradead.org>
> + */
> +
> +#include <linux/export.h>
> +#include <linux/rcupdate.h>
> +#include <linux/rosebush.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/stddef.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/barrier.h>
> +
> +/*
> + * The lock is held whenever we are modifying the contents of the bucket.
> + * The contention counter tracks whether we need to split the bucket due
> + * to contention on the spinlock.
> + * The bucket is 256 bytes in size (20 * 12 = 240, plus parent, lock, etc)
> + */
> +#ifdef CONFIG_64BIT
> +#define RBH_ENTRIES	20
> +#else
> +#define RBH_ENTRIES	30
> +#endif
> +
> +struct rbh_bucket {
> +	u32 rbh_hashes[RBH_ENTRIES];
> +	void __rcu *rbh_slots[RBH_ENTRIES];
> +	const struct rbh *rbh;
> +	spinlock_t rbh_lock;
> +	u32 rbh_contention;
> +};
> +
> +struct rbh_table {
> +	DECLARE_FLEX_ARRAY(struct rbh_bucket __rcu *, buckets);
> +};
> +
> +struct rbh_initial_table {
> +	struct rbh_bucket buckets[2];
> +};
> +
> +/*
> + * As far as lockdep is concerned, all buckets in the same rosebush use
> + * the same lock.  We use the classes to distinguish the rbh resize lock
> + * from the bucket locks.  The only time we take two bucket locks is
> + * when we already hold the resize lock, so there is no need to define
> + * an order between bucket locks.
> + */
> +#ifdef CONFIG_DEBUG_SPINLOCK
> +#define bucket_lock_init(rbh, bucket)					\
> +	__raw_spin_lock_init(spinlock_check(&(bucket)->rbh_lock),	\
> +		"rbh", (rbh)->rbh_resize_lock.dep_map.key, LD_WAIT_SPIN)
> +#else
> +#define bucket_lock_init(rbh, bucket)					\
> +	spin_lock_init(&(bucket)->rbh_lock)
> +#endif
> +
> +#define rbh_resize_lock(rbh)	spin_lock_nested(&(rbh)->rbh_resize_lock, 2)
> +#define rbh_resize_unlock(rbh)	spin_unlock(&(rbh)->rbh_resize_lock)
> +
> +struct table_mask {
> +	struct rbh_table *table;
> +	u32 mask;
> +};
> +
> +/*
> + * A very complicated way of spelling &rbh->bucket[hash].
> + *
> + * The first complication is that we encode the number of buckets
> + * in the pointer so that we can get both in an atomic load.
> + *
> + * The second complication is that small hash tables don't have a top
> + * level table; instead the buckets pointer points to a pair of buckets.
> + */
> +static struct rbh_bucket *get_bucket(struct rbh *rbh, u32 hash,
> +		struct table_mask *state)
> +{
> +	unsigned long tagged;
> +	struct rbh_initial_table *initial_table;
> +	unsigned int bnr;
> +
> +	/* rcu_dereference(), but not a pointer */
> +	tagged = READ_ONCE(rbh->rbh_table);
> +	if (!tagged)
> +		return NULL;
> +
> +	/* The lowest bits indicates how many buckets the table holds */
> +	state->table = (struct rbh_table *)(tagged & (tagged + 1));
> +	state->mask = tagged - (unsigned long)state->table;
> +	bnr = hash & state->mask;
> +	if (state->mask != 1)
> +		return rcu_dereference(state->table->buckets[bnr]);
> +
> +	initial_table = (struct rbh_initial_table *)state->table;
> +	return &initial_table->buckets[bnr];
> +}
> +
> +static struct rbh_bucket *lock_bucket(struct rbh *rbh, u32 hash)
> +	__acquires(&bucket->rbh_lock)
> +{
> +	struct rbh_bucket *bucket, *new_bucket;
> +	struct table_mask state;
> +
> +	bucket = get_bucket(rbh, hash, &state);
> +	if (!bucket)
> +		return bucket;
> +again:
> +	spin_lock(&bucket->rbh_lock);
> +	new_bucket = get_bucket(rbh, hash, &state);
> +	if (bucket == new_bucket)
> +		return bucket;
> +	spin_unlock(&bucket->rbh_lock);
> +	bucket = new_bucket;
> +	goto again;
> +}
> +
> +static bool rbh_first(struct rbh *rbh, u32 hash)
> +{
> +	struct rbh_initial_table *table;
> +	int i;
> +
> +//printk("%s: table size %zd\n", __func__, sizeof(*table));
> +	table = kmalloc(sizeof(*table), GFP_KERNEL);
> +	if (!table)
> +		return false;
> +
> +	rbh_resize_lock(rbh);
> +	if (rbh->rbh_table) {
> +		rbh_resize_unlock(rbh);
> +		/* Somebody else resized it for us */
> +		kfree(table);
> +		return true;
> +	}
> +
> +	bucket_lock_init(rbh, &table->buckets[0]);
> +	table->buckets[0].rbh = rbh;
> +	table->buckets[0].rbh_contention = 0;
> +	bucket_lock_init(rbh, &table->buckets[1]);
> +	table->buckets[1].rbh = rbh;
> +	table->buckets[1].rbh_contention = 0;
> +	for (i = 0; i < RBH_ENTRIES; i++) {
> +		table->buckets[0].rbh_hashes[i] = ~0;
> +		table->buckets[1].rbh_hashes[i] = 0;
> +	}
> +	/* rcu_assign_pointer() but not a pointer */
> +	smp_store_release(&rbh->rbh_table, (unsigned long)table | 1);
> +	rbh_resize_unlock(rbh);
> +
> +//printk("%s: new table = %px\n", __func__, table);
> +	return true;
> +}
> +
> +static void copy_initial_buckets(const struct rbh *rbh,
> +		struct rbh_table *table, struct rbh_initial_table *init_table)
> +	__acquires(&init_table->buckets[0].rbh_lock)
> +	__acquires(&init_table->buckets[1].rbh_lock)
> +{
> +	struct rbh_bucket *bucket;
> +
> +	bucket = (void __force *)table->buckets[0];
> +	spin_lock(&init_table->buckets[0].rbh_lock);
> +	memcpy(bucket, &init_table->buckets[0], sizeof(init_table->buckets[0]));
> +	bucket_lock_init(rbh, bucket);
> +
> +	bucket = (void __force *)table->buckets[1];
> +	spin_lock_nested(&init_table->buckets[1].rbh_lock, 1);
> +	memcpy(bucket, &init_table->buckets[1], sizeof(init_table->buckets[1]));
> +	bucket_lock_init(rbh, bucket);
> +}
> +
> +/*
> + * When we grow the table, we duplicate the bucket pointers so this
> + * thread doesn't pay the entire cost of growing the table.
> + */
> +static int rbh_grow_table(struct rbh *rbh, u32 hash, struct table_mask *state)
> +	__releases(RCU)
> +	__acquires(RCU)
> +{
> +	struct rbh_table *table;
> +	struct rbh_initial_table *init_table;
> +	u32 mask = state->mask;
> +	unsigned long tagged = (unsigned long)state->table | mask;
> +	size_t size;
> +
> +	rcu_read_unlock();
> +
> +	size = (mask + 1) * 2 * sizeof(void *);
> +	if (size > 4 * PAGE_SIZE)
> +		/* XXX: NUMA_NO_NODE doesn't necessarily interleave */
> +		table = __vmalloc_node(size, size, GFP_KERNEL, NUMA_NO_NODE,
> +				&table);
> +	else
> +		table = kvmalloc(size, GFP_KERNEL);
> +	if (!table) {
> +		rcu_read_lock();
> +		/* Maybe somebody resized it for us */
> +		if (READ_ONCE(rbh->rbh_table) != tagged)
> +			return 0;
> +		return -ENOMEM;
> +	}
> +	BUG_ON((unsigned long)table & (size - 1));
> +
> +	if (mask == 1) {
> +		/* Don't need to bother with RCU until we publish the table */
> +		table->buckets[0] = (void __rcu *)kmalloc(sizeof(struct rbh_bucket), GFP_KERNEL);
> +		if (!table->buckets[0])
> +			goto free_all;
> +		table->buckets[1] = (void __rcu *)kmalloc(sizeof(struct rbh_bucket), GFP_KERNEL);
> +		if (!table->buckets[1])
> +			goto free_all;
> +	}
> +
> +	rbh_resize_lock(rbh);
> +	if (rbh->rbh_table != tagged) {
> +		rbh_resize_unlock(rbh);
> +		/* Somebody else resized it for us */
> +		kvfree(table);
> +		rcu_read_lock();
> +		return 0;
> +	}
> +
> +//printk("%s: replacing table %p with table %p mask %d\n", __func__, state->table, table, mask);
> +	if (mask == 1) {
> +		init_table = (void *)state->table;
> +		copy_initial_buckets(rbh, table, init_table);
> +	} else {
> +		memcpy(&table->buckets, &state->table->buckets,
> +				(mask + 1) * sizeof(void *));
> +	}
> +	memcpy(&table->buckets[mask + 1], &table->buckets[0],
> +			(mask + 1) * sizeof(void *));
> +
> +	tagged = ((unsigned long)table) | (mask << 1) | 1;
> +	/* rcu_assign_pointer() but not a pointer */
> +	smp_store_release(&rbh->rbh_table, tagged);
> +	rbh_resize_unlock(rbh);
> +	if (mask == 1) {
> +		spin_unlock(&init_table->buckets[0].rbh_lock);
> +		spin_unlock(&init_table->buckets[1].rbh_lock);
> +	}
> +	kvfree_rcu_mightsleep(state->table);
> +
> +	rcu_read_lock();
> +	return 0;
> +free_all:
> +	kfree((void __force *)table->buckets[0]);
> +	kvfree(table);
> +	rcu_read_lock();
> +	return -ENOMEM;
> +}
> +
> +static void bucket_copy(const struct rbh *rbh, struct rbh_bucket *buckets[2],
> +		const struct rbh_bucket *old_bucket, u32 hash, u32 mask)
> +{
> +	unsigned int i;
> +	unsigned int js[2] = {0, 0};
> +
> +	bucket_lock_init(rbh, buckets[0]);
> +	buckets[0]->rbh_contention = 0;
> +	buckets[0]->rbh = rbh;
> +	bucket_lock_init(rbh, buckets[1]);
> +	buckets[1]->rbh_contention = 0;
> +	buckets[1]->rbh = rbh;
> +	for (i = 0; i < RBH_ENTRIES; i++) {
> +		unsigned int nr = !!(old_bucket->rbh_hashes[i] & mask);
> +		buckets[nr]->rbh_hashes[js[nr]] = old_bucket->rbh_hashes[i];
> +		buckets[nr]->rbh_slots[js[nr]++] = old_bucket->rbh_slots[i];
> +	}
> +//printk("%s: bucket:%p copied %d entries from %p hash:%x mask:%x\n", __func__, buckets[0], js[0], old_bucket, hash, mask);
> +//printk("%s: bucket:%p copied %d entries from %p hash:%x mask:%x\n", __func__, buckets[1], js[1], old_bucket, hash, mask);
> +
> +	/* Fill the new buckets with deleted entries */
> +	while (js[0] < RBH_ENTRIES)
> +		buckets[0]->rbh_hashes[js[0]++] = ~hash;
> +	while (js[1] < RBH_ENTRIES)
> +		buckets[1]->rbh_hashes[js[1]++] = ~hash;
> +}
> +
> +#define rbh_dereference_protected(p, rbh)				\
> +	rcu_dereference_protected(p, lockdep_is_held(&(rbh)->rbh_resize_lock))
> +
> +static int rbh_split_bucket(struct rbh *rbh, struct rbh_bucket *bucket,
> +		u32 hash, struct table_mask *state)
> +{
> +	unsigned long tagged;
> +	u32 bit, mask;
> +	struct rbh_table *table;
> +	struct rbh_bucket *buckets[2];
> +	int err = 0;
> +
> +	if (state->mask == 1) {
> +		err = rbh_grow_table(rbh, hash, state);
> +	} else {
> +		u32 buddy = (hash & state->mask) ^ ((state->mask + 1) / 2);
> +		if (rcu_dereference(state->table->buckets[buddy]) != bucket)
> +			err = rbh_grow_table(rbh, hash, state);
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	rcu_read_unlock();
> +
> +	/* XXX: use slab */
> +	buckets[0] = kmalloc(sizeof(*bucket), GFP_KERNEL);
> +	if (!buckets[0])
> +		return -ENOMEM;
> +	buckets[1] = kmalloc(sizeof(*bucket), GFP_KERNEL);
> +	if (!buckets[1]) {
> +		kfree(buckets[0]);
> +		return -ENOMEM;
> +	}
> +
> +//printk("%s: adding buckets %p %p for hash %d\n", __func__, buckets[0], buckets[1], hash);
> +	rbh_resize_lock(rbh);
> +	tagged = rbh->rbh_table;
> +	table = (struct rbh_table *)(tagged & (tagged + 1));
> +	mask = tagged - (unsigned long)table;
> +	hash &= mask;
> +	if (rbh_dereference_protected(table->buckets[hash], rbh) != bucket)
> +		goto free;
> +
> +	/* Figure out which entries we need to take to the new bucket */
> +	bit = mask + 1;
> +	while (bit > 1) {
> +		bit /= 2;
> +//printk("hash:%d buddy:%d\n", hash, hash ^ bit);
> +		if (rbh_dereference_protected(table->buckets[hash ^ bit], rbh)
> +				!= bucket)
> +			break;
> +	}
> +	bit *= 2;
> +	if (bit == mask + 1)
> +		goto free;
> +
> +	spin_lock(&bucket->rbh_lock);
> +	bucket_copy(rbh, buckets, bucket, hash, bit);
> +
> +//printk("hash:%d mask:%d bit:%d\n", hash, mask, bit);
> +	hash &= (bit - 1);
> +	do {
> +//printk("assigning bucket %p to index %d\n", buckets[0], hash);
> +		rcu_assign_pointer(table->buckets[hash], buckets[0]);
> +		hash += bit;
> +//printk("assigning bucket %p to index %d\n", buckets[1], hash);
> +		rcu_assign_pointer(table->buckets[hash], buckets[1]);
> +		hash += bit;
> +	} while (hash < mask);
> +//printk("owner:%px\n", bucket->rbh_lock.owner)
> +	spin_unlock(&bucket->rbh_lock);
> +	rbh_resize_unlock(rbh);
> +	kvfree_rcu_mightsleep(bucket);
> +
> +	return 0;
> +free:
> +	rbh_resize_unlock(rbh);
> +//printk("%s: freeing bucket %p\n", __func__, bucket);
> +	kfree(buckets[0]);
> +	kfree(buckets[1]);
> +
> +	return 0;
> +}
> +
> +static int __rbh_insert(struct rbh *rbh, u32 hash, void *p)
> +{
> +	struct table_mask state;
> +	struct rbh_bucket *bucket, *new_bucket;
> +	unsigned int i;
> +	int err;
> +
> +restart:
> +	rcu_read_lock();
> +	bucket = get_bucket(rbh, hash, &state);
> +	if (unlikely(!bucket)) {
> +		rcu_read_unlock();
> +		if (!rbh_first(rbh, hash))
> +			return -ENOMEM;
> +		goto restart;
> +	}
> +
> +again:
> +	if (spin_trylock(&bucket->rbh_lock)) {
> +		if (bucket->rbh_contention)
> +			bucket->rbh_contention--;
> +	} else {
> +		spin_lock(&bucket->rbh_lock);
> +		/* Numbers chosen ad-hoc */
> +		bucket->rbh_contention += 10;
> +		if (unlikely(bucket->rbh_contention > 5000)) {
> +			spin_unlock(&bucket->rbh_lock);
> +			/* OK if this fails; it's only contention */
> +			rbh_split_bucket(rbh, bucket, hash, &state);
> +
> +			bucket = get_bucket(rbh, hash, &state);
> +			spin_lock(&bucket->rbh_lock);
> +		}
> +	}
> +
> +	new_bucket = get_bucket(rbh, hash, &state);
> +	if (bucket != new_bucket) {
> +		spin_unlock(&bucket->rbh_lock);
> +		bucket = new_bucket;
> +		goto again;
> +	}
> +
> +	/* Deleted elements differ in their bottom bit */
> +	for (i = 0; i < RBH_ENTRIES; i++) {
> +		u32 bhash = bucket->rbh_hashes[i];
> +
> +		if ((bhash & 1) == (hash & 1))
> +			continue;
> +		rcu_assign_pointer(bucket->rbh_slots[i], p);
> +		/* This array is read under RCU */
> +		WRITE_ONCE(bucket->rbh_hashes[i], hash);
> +
> +		spin_unlock(&bucket->rbh_lock);
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	/* No space in this bucket */
> +	spin_unlock(&bucket->rbh_lock);
> +
> +	err = rbh_split_bucket(rbh, bucket, hash, &state);
> +	rcu_read_unlock();
> +	if (err)
> +		return err;
> +	goto restart;
> +}
> +
> +/**
> + * rbh_insert - Add a pointer to a rosebush.
> + * @rbh: The rosebush.
> + * @hash: The hash value for this pointer.
> + * @p: The pointer to add.
> + *
> + * Return: 0 on success, -ENOMEM if memory allocation fails,
> + * -EINVAL if @p is NULL.
> + */
> +int rbh_insert(struct rbh *rbh, u32 hash, void *p)
> +{
> +	if (p == NULL)
> +		return -EINVAL;
> +	return __rbh_insert(rbh, hash, p);
> +}
> +EXPORT_SYMBOL(rbh_insert);
> +
> +/**
> + * rbh_remove - Remove a pointer from a rosebush.
> + * @rbh: The rosebush.
> + * @hash: The hash value for this pointer.
> + * @p: The pointer to remove.
> + *
> + * Return: 0 on success, -ENOENT if this pointer could not be found.
> + */
> +int rbh_remove(struct rbh *rbh, u32 hash, void *p)
> +{
> +	struct rbh_bucket *bucket;
> +	unsigned int i;
> +	int err = -ENOENT;
> +
> +	rcu_read_lock();
> +	bucket = lock_bucket(rbh, hash);
> +	if (!bucket)
> +		goto rcu_unlock;
> +
> +	for (i = 0; i < RBH_ENTRIES; i++) {
> +		if (bucket->rbh_hashes[i] != hash)
> +			continue;
> +		if (rcu_dereference_protected(bucket->rbh_slots[i],
> +				lockdep_is_held(&bucket->rbh_lock)) != p)
> +			continue;
> +		bucket->rbh_hashes[i] = ~hash;
> +		/* Do not modify the slot */
> +		err = 0;
> +		break;
> +	}
> +
> +	spin_unlock(&bucket->rbh_lock);
> +rcu_unlock:
> +	rcu_read_unlock();
> +	return err;
> +}
> +EXPORT_SYMBOL(rbh_remove);
> +
> +/**
> + * rbh_reserve - Reserve a slot in a rosebush for later use.
> + * @rbh: The rosebush.
> + * @hash: The hash value that will be used.
> + *
> + * Some callers need to take another lock before inserting an object
> + * into the rosebush.  This function reserves space for them to do that.
> + * A subsequent call to rbh_use() will not allocate memory.  If you find
> + * that you do not need the reserved space any more, call rbh_remove(),
> + * passing NULL as the pointer.
> + *
> + * Return: 0 on success, -ENOMEM on failure.
> + */
> +int rbh_reserve(struct rbh *rbh, u32 hash)
> +{
> +	return __rbh_insert(rbh, hash, NULL);
> +}
> +EXPORT_SYMBOL(rbh_reserve);
> +
> +/**
> + * rbh_use - Use a reserved slot in a rosebush.
> + * @rbh: The rosebush.
> + * @hash: The hash value for this pointer.
> + * @p: The pointer to add.
> + *
> + * Return: 0 on success, -EINVAL if @p is NULL,
> + * -ENOENT if no reserved slot could be found.
> + */
> +int rbh_use(struct rbh *rbh, u32 hash, void *p)
> +{
> +	struct rbh_bucket *bucket;
> +	unsigned int i;
> +	int err = -ENOENT;
> +
> +	rcu_read_lock();
> +	bucket = lock_bucket(rbh, hash);
> +	if (!bucket)
> +		goto rcu_unlock;
> +
> +	for (i = 0; i < RBH_ENTRIES; i++) {
> +		if (bucket->rbh_hashes[i] != hash)
> +			continue;
> +		if (bucket->rbh_slots[i] != NULL)
> +			continue;
> +		rcu_assign_pointer(bucket->rbh_slots[i], p);
> +		err = 0;
> +		break;
> +	}
> +
> +	spin_unlock(&bucket->rbh_lock);
> +rcu_unlock:
> +	rcu_read_unlock();
> +	return err;
> +}
> +EXPORT_SYMBOL(rbh_use);
> +
> +/**
> + * rbh_next - Find the next entry matching this hash
> + * @rbhi: The rosebush iterator.
> + *
> + * Return: NULL if there are no more matching hash values, otherwise
> + * the next pointer.
> + */
> +void *rbh_next(struct rbh_iter *rbhi)
> +{
> +	struct table_mask state;
> +	struct rbh_bucket *bucket = rbhi->bucket;
> +	void *p;
> +
> +	if (!bucket) {
> +		bucket = get_bucket(rbhi->rbh, rbhi->hash, &state);
> +		if (!bucket)
> +			return NULL;
> +		rbhi->bucket = bucket;
> +		rbhi->index = UINT_MAX;
> +	}
> +
> +	while (++rbhi->index < RBH_ENTRIES) {
> +		if (READ_ONCE(bucket->rbh_hashes[rbhi->index]) != rbhi->hash)
> +			continue;
> +		p = rcu_dereference(bucket->rbh_slots[rbhi->index]);
> +		if (p)
> +			return p;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(rbh_next);
> +
> +/**
> + * rbh_destroy - Destroy a rosebush
> + * @rbh: The rosebush to destroy
> + *
> + * The caller must ensure that no other threads will simultaneously
> + * attempt to use the rosebush.
> + */
> +void rbh_destroy(struct rbh *rbh)
> +{
> +	unsigned long tagged = rbh->rbh_table;
> +	struct rbh_table *table = (struct rbh_table *)(tagged & (tagged + 1));
> +	u32 mask = tagged - (unsigned long)table;
> +	u32 i, j, k;
> +
> +	for (i = 0; i <= mask; i++) {
> +		struct rbh_bucket __rcu *bucket;
> +
> +		bucket = table->buckets[i];
> +		if (!bucket)
> +			continue;
> +		kfree((void __force *)bucket);
> +		for (j = (mask + 1) / 2; j > 0; j /= 2) {
> +			if (table->buckets[i ^ j] == bucket)
> +				continue;
> +			j *= 2;
> +			break;
> +		}
> +		k = i;
> +		do {
> +			table->buckets[k] = NULL;
> +			k += j;
> +		} while (k < mask && table->buckets[k] == bucket);
> +	}
> +
> +	kfree(table);
> +	rbh->rbh_table = 0;
> +}
> +
> +#ifndef __KERNEL__
> +static void dump_bucket(struct rbh_bucket *bucket, unsigned bnr)
> +{
> +	unsigned i;
> +
> +	printk("bucket:%p index:%d rbh:%p\n", bucket, bnr, bucket->rbh);
> +	for (i = 0; i < RBH_ENTRIES; i++) {
> +		printk("hash:%x entry:%p (%x)\n", bucket->rbh_hashes[i],
> +			bucket->rbh_slots[i], bucket->rbh_hashes[i] * 2 + 1);
> +	}
> +}
> +
> +static void rbh_dump(struct rbh *rbh)
> +{
> +	unsigned long tagged = READ_ONCE(rbh->rbh_table);
> +	struct rbh_table *table;
> +	u32 mask, i;
> +
> +	table = (struct rbh_table *)(tagged & (tagged + 1));
> +	mask = tagged - (unsigned long)table;
> +
> +	printk("rosebush %p has %d buckets in table %p\n", rbh, mask + 1, table);
> +
> +	if (mask == 1) {
> +		dump_bucket((struct rbh_bucket *)table, 0);
> +		dump_bucket((struct rbh_bucket *)table + 1, 1);
> +	} else for (i = 0; i <= mask; i++)
> +		dump_bucket(table->buckets[i], i);
> +}
> +#endif
> +
> +/*
> + * TODO:
> + * * convert the dcache
> + * * 2 byte hashes in the bucket.  Once the table has 2^17 buckets, we can
> + *   use 10 bytes per entry instead of 12 (24 entries/bucket instead of 20)
> + * * 1 byte hashes in the bucket.  Once the table has 2^25 buckets, we can
> + *   use 9 bytes per entry instead of 10 (26 entries/bucket instead of 24)
> + */
> -- 
> 2.43.0
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

