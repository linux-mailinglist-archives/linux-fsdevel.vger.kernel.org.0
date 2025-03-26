Return-Path: <linux-fsdevel+bounces-45093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EEA71A50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 16:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937C38406EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A391F30D1;
	Wed, 26 Mar 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="bqN04ONk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829114A4C6;
	Wed, 26 Mar 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002756; cv=none; b=oy+lud40HL7s7F7HtdVziiCZcvqZT0/UmP2rZCU+N8waRu4iBfwuswXPkGsq8PELjLaHlgYILjTnkmKmtq1IHQ9DmGn+jtRA3zx6QiESA7ZPfh2hWzvraP8csEsfl/OuhIEXQ4RO9D1uXhE44YyM+45S5Pyz4oarzCHQpDLCSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002756; c=relaxed/simple;
	bh=zvSLsBbwCYYceRJJBesmODIk7KjdXqmIWjzW7NvWBHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7rLnZLiPQTJnF9gdrLfJAGwXYvTwncofQ+QnJeytCtE/dbG8LOSXUNo5L8WczfNWjPBdYvrMp89Euq+BsLFDgGlesPGNyoPu7KzAdAMt7JbnO1eF3G6NL2fs8M2M6J+2KTJmh4+sIXCkICl2sWm1t8OgzwDW08wa8yQfyqwdi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=bqN04ONk; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1743002753;
	bh=zvSLsBbwCYYceRJJBesmODIk7KjdXqmIWjzW7NvWBHc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=bqN04ONkr3eEnnwYwj8NI+uhBTHJzZAcWjkhOh4K0QLLnb91l4kM7m/jVMR+C4JH+
	 713ZCeJv+zlmsHqAF7Evd5eVftPQxhBdk5P3LtqlFXCxKHAlHwmUGEkmlfvQZ0Eolr
	 3icyJ66cVrASEoLfAOx6nggQRFGBV46Tnbo0+7OE=
Received: from [172.22.32.239] (unknown [99.209.85.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 56E1C1C0243;
	Wed, 26 Mar 2025 11:25:53 -0400 (EDT)
Message-ID: <45d6ff00d8068ee87ccc396ae28c7931b8c3306c.camel@HansenPartnership.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig
 <hch@infradead.org>,  linux-fsdevel@vger.kernel.org,
 lsf-pc@lists.linux-foundation.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
 linux-pm@vger.kernel.org
Date: Wed, 26 Mar 2025 11:25:52 -0400
In-Reply-To: <vhwrsep5wa5j5mn3gads2tw7b2aeo6j6p3nffvxumknfuwhdva@pohjz7u45nwc>
References: 
	<acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
	 <Z9z32X7k_eVLrYjR@infradead.org>
	 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
	 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
	 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
	 <Z-HFjTGaOnOjnhLP@dread.disaster.area>
	 <7f3eddf89f8fd128ffeb643bc582e45a7d13c216.camel@HansenPartnership.com>
	 <Z-HJqLI7Bi4iHWKU@dread.disaster.area>
	 <l6qesrzfadpiknnpy7dare7pfnxyfjljseuxvhjcajszymktu3@oitqnbt6fwvr>
	 <1af829aa7a65eb5ebc0614a00f7019615ed0f62b.camel@HansenPartnership.com>
	 <vhwrsep5wa5j5mn3gads2tw7b2aeo6j6p3nffvxumknfuwhdva@pohjz7u45nwc>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-26 at 15:59 +0100, Jan Kara wrote:
[...]
> So to summarize I think we may need to introduce freezable variant of
> percpu_rwsem_down_read() and use it in sb_start_write().

Aye, aye, sir! and thanks for making the can of worms bigger ...

This is what I came up with for freezable variants of the
sb_write_start().  I'm still building the kernel (laptop only ...) so
I'll let you know in an hour or so if it actually works.

Regards,

James

---

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd84d1c3b8af..ce21d81c6e34 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1782,7 +1782,8 @@ static inline void __sb_end_write(struct super_block =
*sb, int level)
=20
 static inline void __sb_start_write(struct super_block *sb, int level)
 {
-	percpu_down_read(sb->s_writers.rw_sem + level - 1);
+	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
+				   level =3D=3D SB_FREEZE_WRITE);
 }
=20
 static inline bool __sb_start_write_trylock(struct super_block *sb, int le=
vel)
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index c012df33a9f0..a55fe709b832 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -42,9 +42,10 @@ is_static struct percpu_rw_semaphore name =3D {				\
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
 	__DEFINE_PERCPU_RWSEM(name, static)
=20
-extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
+extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool, bool);
=20
-static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
+static inline void percpu_down_read_internal(struct percpu_rw_semaphore *s=
em,
+					     bool freezable)
 {
 	might_sleep();
=20
@@ -62,7 +63,7 @@ static inline void percpu_down_read(struct percpu_rw_sema=
phore *sem)
 	if (likely(rcu_sync_is_idle(&sem->rss)))
 		this_cpu_inc(*sem->read_count);
 	else
-		__percpu_down_read(sem, false); /* Unconditional memory barrier */
+		__percpu_down_read(sem, false, freezable); /* Unconditional memory barri=
er */
 	/*
 	 * The preempt_enable() prevents the compiler from
 	 * bleeding the critical section out.
@@ -70,6 +71,17 @@ static inline void percpu_down_read(struct percpu_rw_sem=
aphore *sem)
 	preempt_enable();
 }
=20
+static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
+{
+	percpu_down_read_internal(sem, false);
+}
+
+static inline void percpu_down_read_freezable(struct percpu_rw_semaphore *=
sem,
+					      bool freeze)
+{
+	percpu_down_read_internal(sem, freeze);
+}
+
 static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *se=
m)
 {
 	bool ret =3D true;
@@ -81,7 +93,7 @@ static inline bool percpu_down_read_trylock(struct percpu=
_rw_semaphore *sem)
 	if (likely(rcu_sync_is_idle(&sem->rss)))
 		this_cpu_inc(*sem->read_count);
 	else
-		ret =3D __percpu_down_read(sem, true); /* Unconditional memory barrier *=
/
+		ret =3D __percpu_down_read(sem, true, false); /* Unconditional memory ba=
rrier */
 	preempt_enable();
 	/*
 	 * The barrier() from preempt_enable() prevents the compiler from
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 6083883c4fe0..890837b73476 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -138,7 +138,8 @@ static int percpu_rwsem_wake_function(struct wait_queue=
_entry *wq_entry,
 	return !reader; /* wake (readers until) 1 writer */
 }
=20
-static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader=
)
+static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader=
,
+			      bool freeze)
 {
 	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
 	bool wait;
@@ -156,7 +157,8 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphor=
e *sem, bool reader)
 	spin_unlock_irq(&sem->waiters.lock);
=20
 	while (wait) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE |
+				  freeze ? TASK_FREEZABLE : 0);
 		if (!smp_load_acquire(&wq_entry.private))
 			break;
 		schedule();
@@ -164,7 +166,8 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphor=
e *sem, bool reader)
 	__set_current_state(TASK_RUNNING);
 }
=20
-bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try,
+				bool freeze)
 {
 	if (__percpu_down_read_trylock(sem))
 		return true;
@@ -174,7 +177,7 @@ bool __sched __percpu_down_read(struct percpu_rw_semaph=
ore *sem, bool try)
=20
 	trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_READ);
 	preempt_enable();
-	percpu_rwsem_wait(sem, /* .reader =3D */ true);
+	percpu_rwsem_wait(sem, /* .reader =3D */ true, freeze);
 	preempt_disable();
 	trace_contention_end(sem, 0);
=20
@@ -237,7 +240,7 @@ void __sched percpu_down_write(struct percpu_rw_semapho=
re *sem)
 	 */
 	if (!__percpu_down_write_trylock(sem)) {
 		trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
-		percpu_rwsem_wait(sem, /* .reader =3D */ false);
+		percpu_rwsem_wait(sem, /* .reader =3D */ false, false);
 		contended =3D true;
 	}
=20

	=09

