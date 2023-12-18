Return-Path: <linux-fsdevel+bounces-6390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB6817813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648841C23A96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3354FF86;
	Mon, 18 Dec 2023 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1H7LuPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806337863
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702919009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+ySM2A8m6VADzcnOowSsvlY09s82EUkwc3W/+e6jno=;
	b=Q1H7LuPr3qLSqoQC3Gx5n9I/WPrLICkkDi91P83nuuzEkwLNq+bIE9XsADO78smTDNQ6jp
	wCswaG+PxZ7L7h7BNc09WFZ0+NBzcjId9pbTq1bVQOKOnRiyqHIPzpOTcgDjWEskzoxDFl
	mHeqHLi/3Ugkk5jc08YSvRTnKynuoPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-0kgxDM8POeGzsAmCC_8GYw-1; Mon, 18 Dec 2023 12:03:21 -0500
X-MC-Unique: 0kgxDM8POeGzsAmCC_8GYw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E765185A785;
	Mon, 18 Dec 2023 17:02:41 +0000 (UTC)
Received: from [10.22.32.252] (unknown [10.22.32.252])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7A71F492BFA;
	Mon, 18 Dec 2023 17:02:40 +0000 (UTC)
Message-ID: <ab9d5f65-b4bc-42d7-b600-0ff037ad61d9@redhat.com>
Date: Mon, 18 Dec 2023 12:02:40 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/50] locking/seqlock: Split out seqlock_types.h
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: tglx@linutronix.de, x86@kernel.org, tj@kernel.org, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, keescook@chromium.org,
 dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
 boqun.feng@gmail.com, brauner@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-11-kent.overstreet@linux.dev>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20231216032651.3553101-11-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


On 12/15/23 22:26, Kent Overstreet wrote:
> Trimming down sched.h dependencies: we don't want to include more than
> the base types.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>   include/linux/sched.h         |  2 +-
>   include/linux/seqlock.h       | 79 +----------------------------
>   include/linux/seqlock_types.h | 93 +++++++++++++++++++++++++++++++++++
>   3 files changed, 96 insertions(+), 78 deletions(-)
>   create mode 100644 include/linux/seqlock_types.h
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6d803d0904d9..436f7ce1450a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -33,7 +33,7 @@
>   #include <linux/task_io_accounting.h>
>   #include <linux/posix-timers_types.h>
>   #include <linux/rseq.h>
> -#include <linux/seqlock.h>
> +#include <linux/seqlock_types.h>
>   #include <linux/kcsan.h>
>   #include <linux/rv.h>
>   #include <linux/livepatch_sched.h>
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index e92f9d5577ba..d90d8ee29d81 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -18,6 +18,7 @@
>   #include <linux/lockdep.h>
>   #include <linux/mutex.h>
>   #include <linux/preempt.h>
> +#include <linux/seqlock_types.h>
>   #include <linux/spinlock.h>
>   
>   #include <asm/processor.h>
> @@ -37,37 +38,6 @@
>    */
>   #define KCSAN_SEQLOCK_REGION_MAX 1000
>   
> -/*
> - * Sequence counters (seqcount_t)
> - *
> - * This is the raw counting mechanism, without any writer protection.
> - *
> - * Write side critical sections must be serialized and non-preemptible.
> - *
> - * If readers can be invoked from hardirq or softirq contexts,
> - * interrupts or bottom halves must also be respectively disabled before
> - * entering the write section.
> - *
> - * This mechanism can't be used if the protected data contains pointers,
> - * as the writer can invalidate a pointer that a reader is following.
> - *
> - * If the write serialization mechanism is one of the common kernel
> - * locking primitives, use a sequence counter with associated lock
> - * (seqcount_LOCKNAME_t) instead.
> - *
> - * If it's desired to automatically handle the sequence counter writer
> - * serialization and non-preemptibility requirements, use a sequential
> - * lock (seqlock_t) instead.
> - *
> - * See Documentation/locking/seqlock.rst
> - */
> -typedef struct seqcount {
> -	unsigned sequence;
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> -	struct lockdep_map dep_map;
> -#endif
> -} seqcount_t;
> -
>   static inline void __seqcount_init(seqcount_t *s, const char *name,
>   					  struct lock_class_key *key)
>   {
> @@ -131,28 +101,6 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
>    * See Documentation/locking/seqlock.rst
>    */
>   
> -/*
> - * For PREEMPT_RT, seqcount_LOCKNAME_t write side critical sections cannot
> - * disable preemption. It can lead to higher latencies, and the write side
> - * sections will not be able to acquire locks which become sleeping locks
> - * (e.g. spinlock_t).
> - *
> - * To remain preemptible while avoiding a possible livelock caused by the
> - * reader preempting the writer, use a different technique: let the reader
> - * detect if a seqcount_LOCKNAME_t writer is in progress. If that is the
> - * case, acquire then release the associated LOCKNAME writer serialization
> - * lock. This will allow any possibly-preempted writer to make progress
> - * until the end of its writer serialization lock critical section.
> - *
> - * This lock-unlock technique must be implemented for all of PREEMPT_RT
> - * sleeping locks.  See Documentation/locking/locktypes.rst
> - */
> -#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
> -#define __SEQ_LOCK(expr)	expr
> -#else
> -#define __SEQ_LOCK(expr)
> -#endif
> -
>   /*
>    * typedef seqcount_LOCKNAME_t - sequence counter with LOCKNAME associated
>    * @seqcount:	The real sequence counter
> @@ -194,11 +142,6 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
>    * @lockbase:		prefix for associated lock/unlock
>    */
>   #define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockbase)	\
> -typedef struct seqcount_##lockname {					\
> -	seqcount_t		seqcount;				\
> -	__SEQ_LOCK(locktype	*lock);					\
> -} seqcount_##lockname##_t;						\
> -									\
>   static __always_inline seqcount_t *					\
>   __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
>   {									\
> @@ -284,6 +227,7 @@ SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
>   SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
>   SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
>   SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
> +#undef SEQCOUNT_LOCKNAME
>   
>   /*
>    * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
> @@ -794,25 +738,6 @@ static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
>   	smp_wmb();      /* increment "sequence" before following stores */
>   }
>   
> -/*
> - * Sequential locks (seqlock_t)
> - *
> - * Sequence counters with an embedded spinlock for writer serialization
> - * and non-preemptibility.
> - *
> - * For more info, see:
> - *    - Comments on top of seqcount_t
> - *    - Documentation/locking/seqlock.rst
> - */
> -typedef struct {
> -	/*
> -	 * Make sure that readers don't starve writers on PREEMPT_RT: use
> -	 * seqcount_spinlock_t instead of seqcount_t. Check __SEQ_LOCK().
> -	 */
> -	seqcount_spinlock_t seqcount;
> -	spinlock_t lock;
> -} seqlock_t;
> -
>   #define __SEQLOCK_UNLOCKED(lockname)					\
>   	{								\
>   		.seqcount = SEQCNT_SPINLOCK_ZERO(lockname, &(lockname).lock), \
> diff --git a/include/linux/seqlock_types.h b/include/linux/seqlock_types.h
> new file mode 100644
> index 000000000000..dfdf43e3fa3d
> --- /dev/null
> +++ b/include/linux/seqlock_types.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SEQLOCK_TYPES_H
> +#define __LINUX_SEQLOCK_TYPES_H
> +
> +#include <linux/lockdep_types.h>
> +#include <linux/mutex_types.h>
> +#include <linux/spinlock_types.h>
> +
> +/*
> + * Sequence counters (seqcount_t)
> + *
> + * This is the raw counting mechanism, without any writer protection.
> + *
> + * Write side critical sections must be serialized and non-preemptible.
> + *
> + * If readers can be invoked from hardirq or softirq contexts,
> + * interrupts or bottom halves must also be respectively disabled before
> + * entering the write section.
> + *
> + * This mechanism can't be used if the protected data contains pointers,
> + * as the writer can invalidate a pointer that a reader is following.
> + *
> + * If the write serialization mechanism is one of the common kernel
> + * locking primitives, use a sequence counter with associated lock
> + * (seqcount_LOCKNAME_t) instead.
> + *
> + * If it's desired to automatically handle the sequence counter writer
> + * serialization and non-preemptibility requirements, use a sequential
> + * lock (seqlock_t) instead.
> + *
> + * See Documentation/locking/seqlock.rst
> + */
> +typedef struct seqcount {
> +	unsigned sequence;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map dep_map;
> +#endif
> +} seqcount_t;
> +
> +/*
> + * For PREEMPT_RT, seqcount_LOCKNAME_t write side critical sections cannot
> + * disable preemption. It can lead to higher latencies, and the write side
> + * sections will not be able to acquire locks which become sleeping locks
> + * (e.g. spinlock_t).
> + *
> + * To remain preemptible while avoiding a possible livelock caused by the
> + * reader preempting the writer, use a different technique: let the reader
> + * detect if a seqcount_LOCKNAME_t writer is in progress. If that is the
> + * case, acquire then release the associated LOCKNAME writer serialization
> + * lock. This will allow any possibly-preempted writer to make progress
> + * until the end of its writer serialization lock critical section.
> + *
> + * This lock-unlock technique must be implemented for all of PREEMPT_RT
> + * sleeping locks.  See Documentation/locking/locktypes.rst
> + */
> +#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
> +#define __SEQ_LOCK(expr)	expr
> +#else
> +#define __SEQ_LOCK(expr)
> +#endif
> +
> +#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockbase)	\
> +typedef struct seqcount_##lockname {					\
> +	seqcount_t		seqcount;				\
> +	__SEQ_LOCK(locktype	*lock);					\
> +} seqcount_##lockname##_t;
> +
> +SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
> +SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
> +SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
> +SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
> +#undef SEQCOUNT_LOCKNAME
> +
> +/*
> + * Sequential locks (seqlock_t)
> + *
> + * Sequence counters with an embedded spinlock for writer serialization
> + * and non-preemptibility.
> + *
> + * For more info, see:
> + *    - Comments on top of seqcount_t
> + *    - Documentation/locking/seqlock.rst
> + */
> +typedef struct {
> +	/*
> +	 * Make sure that readers don't starve writers on PREEMPT_RT: use
> +	 * seqcount_spinlock_t instead of seqcount_t. Check __SEQ_LOCK().
> +	 */
> +	seqcount_spinlock_t seqcount;
> +	spinlock_t lock;
> +} seqlock_t;
> +
> +#endif /* __LINUX_SEQLOCK_TYPES_H */

seqlock.h is directly included in kernel/sched/sched.h, so breaking out 
seqlock_types.h and including only that in include/linux/sched.h should 
be OK.

Acked-by: Waiman Long <longman@redhat.com>


