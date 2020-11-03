Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4322A40AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 10:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgKCJuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 04:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgKCJux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:50:53 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C777C0613D1;
        Tue,  3 Nov 2020 01:50:53 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h62so7296843wme.3;
        Tue, 03 Nov 2020 01:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIISwRExwdI2+x4VFQbEleB63CJNBOFa6P0LD6oETsQ=;
        b=KAV0zv+zSHQvH+jMHJl1SnuJ+5Tf48eAog6XDXDIxuEK3gguUXVjqzut3p3XP4tKyC
         SH4pygGeqiecTbGWjuNfMwh0znVyMcJ7ZwBjm1T6RtHMdFHWz5Hjr0ITVjFI795gm5aN
         LVfxznqT58TiORANCujTSLVRMOYg10uV9TAtsK+R7A374MbtM03MH+bmGmd8BFuxdLUA
         x/n7xt6+g9D+iGC0k0W++PVt/DwBPNzvYjGdfr+2vDNJAPPrv8Kn2GuQMqiQFxgMrn0q
         rfI2+ZaaBvNcBZ6XLoY0D4wKtSxHu+8nBOTbfIXe91FYer6RbZU8ak5cvvmHPeErxSyx
         rWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIISwRExwdI2+x4VFQbEleB63CJNBOFa6P0LD6oETsQ=;
        b=c/ndCbtpbgXZHpzl4DrWN7JXzivp3V5mR1Kc5K1BwY9MSd2rTb7FdAJeEqtEtMTWb7
         trZBGCPM0GUQDYUrXBY2e080UZV0ynfmPpKuxgORvWUDJoRPwLHhJ9oqlr5WomW7tTpt
         wYszeyUsNasTSY5PJBiBsjpY8gRfqCqUIhoVZxpbvwi0z9cL8QBqbGBRHqQL//83k38i
         HjDbGx2zb+Mi5GmR/SOnDHPyhmud0TfbOVtjaZU6/jlkDz30k6CS6lIcU6S6GI4k7Gwb
         DjlWJfBphGagjcXMCUGrQOoulW+pJUI/WiuTCIfxY2ZaTa6L16hpflcFwZ+h79A/PIh+
         mUmA==
X-Gm-Message-State: AOAM531QyrNF+vqkDOeDk+RagTUhB6s11nv4ult/mNryIsBMXMLn6J3g
        hx4V5WJqIBWM514Iqwz87rk=
X-Google-Smtp-Source: ABdhPJyAM2Ozh+PB4pOGLvi2yB/JeDwDlpVOy57dw5jo64ZV2FxHVsG/hh71Kcqe0IX6ApZ1tOazsw==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr909591wmb.99.1604397051882;
        Tue, 03 Nov 2020 01:50:51 -0800 (PST)
Received: from localhost.localdomain ([170.253.60.68])
        by smtp.googlemail.com with ESMTPSA id k22sm2349838wmi.34.2020.11.03.01.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 01:50:51 -0800 (PST)
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
To:     Benjamin LaHaise <bcrl@kvack.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Joe Perches <joe@perches.com>
Cc:     Alejandro Colomar <colomar.6.4.3@gmail.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] fs/aio.c: Cosmetic
Date:   Tue,  3 Nov 2020 10:50:16 +0100
Message-Id: <20201103095015.3911-1-colomar.6.4.3@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <35625559ea6fa7827e840905a4a03e624fdeb43f.camel@perches.com>
References: <35625559ea6fa7827e840905a4a03e624fdeb43f.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes:
- Consistently use 'unsigned int', instead of 'unsigned'.
- Add a blank line after variable declarations.
- Move variable declarations to the top of functions.
- Invert logic of 'if's to reduce indentation and simplify function logic.
	- Add goto tags when needed.
	- Early return when appropriate.
- Add braces to 'else' if the corresponding 'if' used braces.
- Replace spaces by tabs
- Add spaces when appropriate (after comma, around operators, ...).
- Split multiple assignments.
- Align function arguments.
- Fix typos in comments.
- s/%Lx/%llx/  Standard C uses 'll'.
- Remove trailing whitespace in comments.

This patch does not introduce any actual changes in behavior.

Signed-off-by: Alejandro Colomar <colomar.6.4.3@gmail.com>
---

Hi,

On 2020-11-03 04:22, Joe Perches wrote:
> On Mon, 2020-11-02 at 17:50 -0700, Andreas Dilger wrote:
>> On Nov 2, 2020, at 2:58 PM, Alejandro Colomar <colomar.6.4.3@gmail.com> wrote:
>>> Changes:
>>> - Consistently use 'unsigned int', instead of 'unsigned'.
>>> - Add a blank line after variable declarations.
>>> - Move variable declarations to the top of functions.
>>> - Add a blank line at the top of functions if there are no declarations.
>>
>> I'd agree that the other changes are following kernel coding style, but
>> I've never heard of leaving a blank line at the start of functions without
>> any local variables.
> 
> I think that is odd as well.

Ooops, it's funny, I was almost sure I had read it,
but my imagination seems to be taking control over me :p

Anyway, I fixed it now.

> 
>> I don't see anything in process/coding-style.rst to
>> support this change, nor are the majority of variable-less functions
>> formatted this way, and it seems to just be a waste of vertical space.
> 
> checkpatch emits a --strict CHECK for those blank lines after
> open braces
[...]

I now passed checkpatch to fs/aio.c and
found a few more things to fix in that file.
There are still a few warnings, but I fixed most of them.

Thanks,

Alex

 fs/aio.c | 466 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 243 insertions(+), 223 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index c45c20d87538..5b567d8f56e3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -55,17 +55,16 @@
 #define AIO_RING_COMPAT_FEATURES	1
 #define AIO_RING_INCOMPAT_FEATURES	0
 struct aio_ring {
-	unsigned	id;	/* kernel internal index number */
-	unsigned	nr;	/* number of io_events */
-	unsigned	head;	/* Written to by userland or under ring_lock
+	unsigned int	id;	/* kernel internal index number */
+	unsigned int	nr;	/* number of io_events */
+	unsigned int	head;	/* Written to by userland or under ring_lock
 				 * mutex by aio_read_events_ring(). */
-	unsigned	tail;
-
-	unsigned	magic;
-	unsigned	compat_features;
-	unsigned	incompat_features;
-	unsigned	header_length;	/* size of aio_ring */
+	unsigned int	tail;
 
+	unsigned int	magic;
+	unsigned int	compat_features;
+	unsigned int	incompat_features;
+	unsigned int	header_length;	/* size of aio_ring */
 
 	struct io_event		io_events[];
 }; /* 128 bytes + ring size */
@@ -80,12 +79,12 @@ struct aio_ring {
 
 struct kioctx_table {
 	struct rcu_head		rcu;
-	unsigned		nr;
+	unsigned int		nr;
 	struct kioctx __rcu	*table[];
 };
 
 struct kioctx_cpu {
-	unsigned		reqs_available;
+	unsigned int		reqs_available;
 };
 
 struct ctx_rq_wait {
@@ -107,7 +106,7 @@ struct kioctx {
 	 * For percpu reqs_available, number of slots we move to/from global
 	 * counter at a time:
 	 */
-	unsigned		req_batch;
+	unsigned int		req_batch;
 	/*
 	 * This is what userspace passed to io_setup(), it's not used for
 	 * anything but counting against the global max_reqs quota.
@@ -115,10 +114,10 @@ struct kioctx {
 	 * The real limit is nr_events - 1, which will be larger (see
 	 * aio_setup_ring())
 	 */
-	unsigned		max_reqs;
+	unsigned int		max_reqs;
 
 	/* Size of ringbuffer, in units of struct io_event */
-	unsigned		nr_events;
+	unsigned int		nr_events;
 
 	unsigned long		mmap_base;
 	unsigned long		mmap_size;
@@ -156,15 +155,15 @@ struct kioctx {
 	} ____cacheline_aligned_in_smp;
 
 	struct {
-		unsigned	tail;
-		unsigned	completed_events;
+		unsigned int	tail;
+		unsigned int	completed_events;
 		spinlock_t	completion_lock;
 	} ____cacheline_aligned_in_smp;
 
 	struct page		*internal_pages[AIO_RING_PAGES];
 	struct file		*aio_ring_file;
 
-	unsigned		id;
+	unsigned int		id;
 };
 
 /*
@@ -236,6 +235,7 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
 	struct file *file;
 	struct inode *inode = alloc_anon_inode(aio_mnt->mnt_sb);
+
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
@@ -269,12 +269,13 @@ static int __init aio_setup(void)
 		.init_fs_context = aio_init_fs_context,
 		.kill_sb	= kill_anon_super,
 	};
+
 	aio_mnt = kern_mount(&aio_fs);
 	if (IS_ERR(aio_mnt))
 		panic("Failed to create aio fs mount.");
 
-	kiocb_cachep = KMEM_CACHE(aio_kiocb, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
-	kioctx_cachep = KMEM_CACHE(kioctx,SLAB_HWCACHE_ALIGN|SLAB_PANIC);
+	kiocb_cachep = KMEM_CACHE(aio_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	kioctx_cachep = KMEM_CACHE(kioctx, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
 	return 0;
 }
 __initcall(aio_setup);
@@ -284,18 +285,19 @@ static void put_aio_ring_file(struct kioctx *ctx)
 	struct file *aio_ring_file = ctx->aio_ring_file;
 	struct address_space *i_mapping;
 
-	if (aio_ring_file) {
-		truncate_setsize(file_inode(aio_ring_file), 0);
+	if (!aio_ring_file)
+		return;
 
-		/* Prevent further access to the kioctx from migratepages */
-		i_mapping = aio_ring_file->f_mapping;
-		spin_lock(&i_mapping->private_lock);
-		i_mapping->private_data = NULL;
-		ctx->aio_ring_file = NULL;
-		spin_unlock(&i_mapping->private_lock);
+	truncate_setsize(file_inode(aio_ring_file), 0);
 
-		fput(aio_ring_file);
-	}
+	/* Prevent further access to the kioctx from migratepages */
+	i_mapping = aio_ring_file->f_mapping;
+	spin_lock(&i_mapping->private_lock);
+	i_mapping->private_data = NULL;
+	ctx->aio_ring_file = NULL;
+	spin_unlock(&i_mapping->private_lock);
+
+	fput(aio_ring_file);
 }
 
 static void aio_free_ring(struct kioctx *ctx)
@@ -309,6 +311,7 @@ static void aio_free_ring(struct kioctx *ctx)
 
 	for (i = 0; i < ctx->nr_pages; i++) {
 		struct page *page;
+
 		pr_debug("pid(%d) [%d] page->count=%d\n", current->pid, i,
 				page_count(ctx->ring_pages[i]));
 		page = ctx->ring_pages[i];
@@ -340,7 +343,8 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 		ctx = rcu_dereference(table->table[i]);
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
-				ctx->user_id = ctx->mmap_base = vma->vm_start;
+				ctx->mmap_base = vma->vm_start;
+				ctx->user_id = vma->vm_start;
 				res = 0;
 			}
 			break;
@@ -374,7 +378,7 @@ static const struct file_operations aio_ring_fops = {
 
 #if IS_ENABLED(CONFIG_MIGRATION)
 static int aio_migratepage(struct address_space *mapping, struct page *new,
-			struct page *old, enum migrate_mode mode)
+			   struct page *old, enum migrate_mode mode)
 {
 	struct kioctx *ctx;
 	unsigned long flags;
@@ -413,8 +417,9 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 		/* Make sure the old page hasn't already been changed */
 		if (ctx->ring_pages[idx] != old)
 			rc = -EAGAIN;
-	} else
+	} else {
 		rc = -EINVAL;
+	}
 
 	if (rc != 0)
 		goto out_unlock;
@@ -498,6 +503,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
+
 		page = find_or_create_page(file->f_mapping,
 					   i, GFP_HIGHUSER | __GFP_ZERO);
 		if (!page)
@@ -543,7 +549,8 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ring = kmap_atomic(ctx->ring_pages[0]);
 	ring->nr = nr_events;	/* user copy */
 	ring->id = ~0U;
-	ring->head = ring->tail = 0;
+	ring->tail = 0;
+	ring->head = 0;
 	ring->magic = AIO_RING_MAGIC;
 	ring->compat_features = AIO_RING_COMPAT_FEATURES;
 	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
@@ -632,7 +639,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
 
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 {
-	unsigned i, new_nr;
+	unsigned int i, new_nr;
 	struct kioctx_table *table, *old;
 	struct aio_ring *ring;
 
@@ -640,23 +647,27 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 	table = rcu_dereference_raw(mm->ioctx_table);
 
 	while (1) {
-		if (table)
-			for (i = 0; i < table->nr; i++)
-				if (!rcu_access_pointer(table->table[i])) {
-					ctx->id = i;
-					rcu_assign_pointer(table->table[i], ctx);
-					spin_unlock(&mm->ioctx_lock);
-
-					/* While kioctx setup is in progress,
-					 * we are protected from page migration
-					 * changes ring_pages by ->ring_lock.
-					 */
-					ring = kmap_atomic(ctx->ring_pages[0]);
-					ring->id = ctx->id;
-					kunmap_atomic(ring);
-					return 0;
-				}
-
+		if (!table)
+			goto new_table;
+
+		for (i = 0; i < table->nr; i++) {
+			if (rcu_access_pointer(table->table[i]))
+				continue;
+
+			ctx->id = i;
+			rcu_assign_pointer(table->table[i], ctx);
+			spin_unlock(&mm->ioctx_lock);
+
+			/* While kioctx setup is in progress,
+			 * we are protected from page migration
+			 * changes ring_pages by ->ring_lock.
+			 */
+			ring = kmap_atomic(ctx->ring_pages[0]);
+			ring->id = ctx->id;
+			kunmap_atomic(ring);
+			return 0;
+		}
+new_table:
 		new_nr = (table ? table->nr : 1) * 4;
 		spin_unlock(&mm->ioctx_lock);
 
@@ -685,7 +696,7 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 	}
 }
 
-static void aio_nr_sub(unsigned nr)
+static void aio_nr_sub(unsigned int nr)
 {
 	spin_lock(&aio_nr_lock);
 	if (WARN_ON(aio_nr - nr > aio_nr))
@@ -698,7 +709,7 @@ static void aio_nr_sub(unsigned nr)
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
  */
-static struct kioctx *ioctx_alloc(unsigned nr_events)
+static struct kioctx *ioctx_alloc(unsigned int nr_events)
 {
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx;
@@ -851,7 +862,7 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 
 /*
  * exit_aio: called when the last user of mm goes away.  At this point, there is
- * no way for any new requests to be submited or any of the io_* syscalls to be
+ * no way for any new requests to be submitted or any of the io_* syscalls to be
  * called on the context.
  *
  * There may be outstanding kiocbs, but free_ioctx() will explicitly wait on
@@ -899,7 +910,7 @@ void exit_aio(struct mm_struct *mm)
 	kfree(table);
 }
 
-static void put_reqs_available(struct kioctx *ctx, unsigned nr)
+static void put_reqs_available(struct kioctx *ctx, unsigned int nr)
 {
 	struct kioctx_cpu *kcpu;
 	unsigned long flags;
@@ -921,24 +932,27 @@ static bool __get_reqs_available(struct kioctx *ctx)
 	struct kioctx_cpu *kcpu;
 	bool ret = false;
 	unsigned long flags;
+	int old, avail;
 
 	local_irq_save(flags);
 	kcpu = this_cpu_ptr(ctx->cpu);
-	if (!kcpu->reqs_available) {
-		int old, avail = atomic_read(&ctx->reqs_available);
+	if (kcpu->reqs_available)
+		goto kcpu_reqs_avail;
 
-		do {
-			if (avail < ctx->req_batch)
-				goto out;
+	avail = atomic_read(&ctx->reqs_available);
 
-			old = avail;
-			avail = atomic_cmpxchg(&ctx->reqs_available,
-					       avail, avail - ctx->req_batch);
-		} while (avail != old);
+	do {
+		if (avail < ctx->req_batch)
+			goto out;
 
-		kcpu->reqs_available += ctx->req_batch;
-	}
+		old = avail;
+		avail = atomic_cmpxchg(&ctx->reqs_available,
+				       avail, avail - ctx->req_batch);
+	} while (avail != old);
 
+	kcpu->reqs_available += ctx->req_batch;
+
+kcpu_reqs_avail:
 	ret = true;
 	kcpu->reqs_available--;
 out:
@@ -953,10 +967,10 @@ static bool __get_reqs_available(struct kioctx *ctx)
  *	from aio_get_req() (the we're out of events case).  It must be
  *	called holding ctx->completion_lock.
  */
-static void refill_reqs_available(struct kioctx *ctx, unsigned head,
-                                  unsigned tail)
+static void refill_reqs_available(struct kioctx *ctx, unsigned int head,
+				  unsigned int tail)
 {
-	unsigned events_in_ring, completed;
+	unsigned int events_in_ring, completed;
 
 	/* Clamp head since userland can write to it. */
 	head %= ctx->nr_events;
@@ -984,27 +998,28 @@ static void refill_reqs_available(struct kioctx *ctx, unsigned head,
  */
 static void user_refill_reqs_available(struct kioctx *ctx)
 {
+	struct aio_ring *ring;
+	unsigned int head;
+
 	spin_lock_irq(&ctx->completion_lock);
-	if (ctx->completed_events) {
-		struct aio_ring *ring;
-		unsigned head;
-
-		/* Access of ring->head may race with aio_read_events_ring()
-		 * here, but that's okay since whether we read the old version
-		 * or the new version, and either will be valid.  The important
-		 * part is that head cannot pass tail since we prevent
-		 * aio_complete() from updating tail by holding
-		 * ctx->completion_lock.  Even if head is invalid, the check
-		 * against ctx->completed_events below will make sure we do the
-		 * safe/right thing.
-		 */
-		ring = kmap_atomic(ctx->ring_pages[0]);
-		head = ring->head;
-		kunmap_atomic(ring);
+	if (!ctx->completed_events)
+		goto out;
 
-		refill_reqs_available(ctx, head, ctx->tail);
-	}
+	/* Access of ring->head may race with aio_read_events_ring()
+	 * here, but that's okay since whether we read the old version
+	 * or the new version, and either will be valid.  The important
+	 * part is that head cannot pass tail since we prevent
+	 * aio_complete() from updating tail by holding
+	 * ctx->completion_lock.  Even if head is invalid, the check
+	 * against ctx->completed_events below will make sure we do the
+	 * safe/right thing.
+	 */
+	ring = kmap_atomic(ctx->ring_pages[0]);
+	head = ring->head;
+	kunmap_atomic(ring);
 
+	refill_reqs_available(ctx, head, ctx->tail);
+out:
 	spin_unlock_irq(&ctx->completion_lock);
 }
 
@@ -1050,7 +1065,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx, *ret = NULL;
 	struct kioctx_table *table;
-	unsigned id;
+	unsigned int id;
 
 	if (get_user(id, &ring->id))
 		return NULL;
@@ -1090,7 +1105,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
-	unsigned tail, pos, head;
+	unsigned int	tail, pos, head;
 	unsigned long	flags;
 
 	/*
@@ -1114,7 +1129,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	kunmap_atomic(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 
-	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
+	pr_debug("%p[%u]: %p: %p %llx %llx %llx\n", ctx, tail, iocb,
 		 (void __user *)(unsigned long)iocb->ki_res.obj,
 		 iocb->ki_res.data, iocb->ki_res.res, iocb->ki_res.res2);
 
@@ -1160,10 +1175,10 @@ static void aio_complete(struct aio_kiocb *iocb)
 
 static inline void iocb_put(struct aio_kiocb *iocb)
 {
-	if (refcount_dec_and_test(&iocb->ki_refcnt)) {
-		aio_complete(iocb);
-		iocb_destroy(iocb);
-	}
+	if (!refcount_dec_and_test(&iocb->ki_refcnt))
+		return;
+	aio_complete(iocb);
+	iocb_destroy(iocb);
 }
 
 /* aio_read_events_ring
@@ -1174,7 +1189,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
 				 struct io_event __user *event, long nr)
 {
 	struct aio_ring *ring;
-	unsigned head, tail, pos;
+	unsigned int head, tail, pos;
 	long ret = 0;
 	int copy_ret;
 
@@ -1182,7 +1197,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
 	 * The mutex can block and wake us up and that will cause
 	 * wait_event_interruptible_hrtimeout() to schedule without sleeping
 	 * and repeat. This should be rare enough that it doesn't cause
-	 * peformance issues. See the comment in read_events() for more detail.
+	 * performance issues. See the comment in read_events() for more detail.
 	 */
 	sched_annotate_sleep();
 	mutex_lock(&ctx->ring_lock);
@@ -1300,16 +1315,16 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  *	Create an aio_context capable of receiving at least nr_events.
  *	ctxp must not point to an aio_context that already exists, and
  *	must be initialized to 0 prior to the call.  On successful
- *	creation of the aio_context, *ctxp is filled in with the resulting 
+ *	creation of the aio_context, *ctxp is filled in with the resulting
  *	handle.  May fail with -EINVAL if *ctxp is not initialized,
- *	if the specified nr_events exceeds internal limits.  May fail 
- *	with -EAGAIN if the specified nr_events exceeds the user's limit 
+ *	if the specified nr_events exceeds internal limits.  May fail
+ *	with -EAGAIN if the specified nr_events exceeds the user's limit
  *	of available events.  May fail with -ENOMEM if insufficient kernel
  *	resources are available.  May fail with -EFAULT if an invalid
  *	pointer is passed for ctxp.  Will fail with -ENOSYS if not
  *	implemented.
  */
-SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
+SYSCALL_DEFINE2(io_setup, unsigned int, nr_events, aio_context_t __user *, ctxp)
 {
 	struct kioctx *ioctx = NULL;
 	unsigned long ctx;
@@ -1321,26 +1336,25 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 
 	ret = -EINVAL;
 	if (unlikely(ctx || nr_events == 0)) {
-		pr_debug("EINVAL: ctx %lu nr_events %u\n",
-		         ctx, nr_events);
+		pr_debug("EINVAL: ctx %lu nr_events %u\n", ctx, nr_events);
 		goto out;
 	}
 
 	ioctx = ioctx_alloc(nr_events);
 	ret = PTR_ERR(ioctx);
-	if (!IS_ERR(ioctx)) {
-		ret = put_user(ioctx->user_id, ctxp);
-		if (ret)
-			kill_ioctx(current->mm, ioctx, NULL);
-		percpu_ref_put(&ioctx->users);
-	}
+	if (IS_ERR(ioctx))
+		goto out;
+	ret = put_user(ioctx->user_id, ctxp);
+	if (ret)
+		kill_ioctx(current->mm, ioctx, NULL);
+	percpu_ref_put(&ioctx->users);
 
 out:
 	return ret;
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
+COMPAT_SYSCALL_DEFINE2(io_setup, unsigned int, nr_events, u32 __user *, ctx32p)
 {
 	struct kioctx *ioctx = NULL;
 	unsigned long ctx;
@@ -1352,20 +1366,19 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 
 	ret = -EINVAL;
 	if (unlikely(ctx || nr_events == 0)) {
-		pr_debug("EINVAL: ctx %lu nr_events %u\n",
-		         ctx, nr_events);
+		pr_debug("EINVAL: ctx %lu nr_events %u\n", ctx, nr_events);
 		goto out;
 	}
 
 	ioctx = ioctx_alloc(nr_events);
 	ret = PTR_ERR(ioctx);
-	if (!IS_ERR(ioctx)) {
-		/* truncating is ok because it's a user address */
-		ret = put_user((u32)ioctx->user_id, ctx32p);
-		if (ret)
-			kill_ioctx(current->mm, ioctx, NULL);
-		percpu_ref_put(&ioctx->users);
-	}
+	if (IS_ERR(ioctx))
+		goto out;
+	/* truncating is ok because it's a user address */
+	ret = put_user((u32)ioctx->user_id, ctx32p);
+	if (ret)
+		kill_ioctx(current->mm, ioctx, NULL);
+	percpu_ref_put(&ioctx->users);
 
 out:
 	return ret;
@@ -1373,7 +1386,7 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 #endif
 
 /* sys_io_destroy:
- *	Destroy the aio_context specified.  May cancel any outstanding 
+ *	Destroy the aio_context specified.  May cancel any outstanding
  *	AIOs and block on completion.  Will fail with -ENOSYS if not
  *	implemented.  May fail with -EINVAL if the context pointed to
  *	is invalid.
@@ -1381,31 +1394,32 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 {
 	struct kioctx *ioctx = lookup_ioctx(ctx);
-	if (likely(NULL != ioctx)) {
-		struct ctx_rq_wait wait;
-		int ret;
+	struct ctx_rq_wait wait;
+	int ret;
 
-		init_completion(&wait.comp);
-		atomic_set(&wait.count, 1);
+	if (unlikely(!ioctx)) {
+		pr_debug("EINVAL: invalid context id\n");
+		return -EINVAL;
+	}
 
-		/* Pass requests_done to kill_ioctx() where it can be set
-		 * in a thread-safe way. If we try to set it here then we have
-		 * a race condition if two io_destroy() called simultaneously.
-		 */
-		ret = kill_ioctx(current->mm, ioctx, &wait);
-		percpu_ref_put(&ioctx->users);
+	init_completion(&wait.comp);
+	atomic_set(&wait.count, 1);
 
-		/* Wait until all IO for the context are done. Otherwise kernel
-		 * keep using user-space buffers even if user thinks the context
-		 * is destroyed.
-		 */
-		if (!ret)
-			wait_for_completion(&wait.comp);
+	/* Pass requests_done to kill_ioctx() where it can be set
+	 * in a thread-safe way. If we try to set it here then we have
+	 * a race condition if two io_destroy() called simultaneously.
+	 */
+	ret = kill_ioctx(current->mm, ioctx, &wait);
+	percpu_ref_put(&ioctx->users);
 
-		return ret;
-	}
-	pr_debug("EINVAL: invalid context id\n");
-	return -EINVAL;
+	/* Wait until all IO for the context are done. Otherwise kernel
+	 * keep using user-space buffers even if user thinks the context
+	 * is destroyed.
+	 */
+	if (!ret)
+		wait_for_completion(&wait.comp);
+
+	return ret;
 }
 
 static void aio_remove_iocb(struct aio_kiocb *iocb)
@@ -1466,8 +1480,9 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 		}
 
 		req->ki_ioprio = iocb->aio_reqprio;
-	} else
+	} else {
 		req->ki_ioprio = get_current_ioprio();
+	}
 
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
@@ -1478,8 +1493,8 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 }
 
 static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
-		struct iovec **iovec, bool vectored, bool compat,
-		struct iov_iter *iter)
+			    struct iovec **iovec, bool vectored, bool compat,
+			    struct iov_iter *iter)
 {
 	void __user *buf = (void __user *)(uintptr_t)iocb->aio_buf;
 	size_t len = iocb->aio_nbytes;
@@ -1514,7 +1529,7 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 }
 
 static int aio_read(struct kiocb *req, const struct iocb *iocb,
-			bool vectored, bool compat)
+		    bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
@@ -1542,7 +1557,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 }
 
 static int aio_write(struct kiocb *req, const struct iocb *iocb,
-			 bool vectored, bool compat)
+		     bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
@@ -1563,21 +1578,23 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
-	if (!ret) {
-		/*
-		 * Open-code file_start_write here to grab freeze protection,
-		 * which will be released by another thread in
-		 * aio_complete_rw().  Fool lockdep by telling it the lock got
-		 * released so that it doesn't complain about the held lock when
-		 * we return to userspace.
-		 */
-		if (S_ISREG(file_inode(file)->i_mode)) {
-			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
-			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
-		}
-		req->ki_flags |= IOCB_WRITE;
-		aio_rw_done(req, call_write_iter(file, req, &iter));
+	if (ret)
+		goto out;
+
+	/*
+	 * Open-code file_start_write here to grab freeze protection,
+	 * which will be released by another thread in
+	 * aio_complete_rw().  Fool lockdep by telling it the lock got
+	 * released so that it doesn't complain about the held lock when
+	 * we return to userspace.
+	 */
+	if (S_ISREG(file_inode(file)->i_mode)) {
+		__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
+		__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 	}
+	req->ki_flags |= IOCB_WRITE;
+	aio_rw_done(req, call_write_iter(file, req, &iter));
+out:
 	kfree(iovec);
 	return ret;
 }
@@ -1670,13 +1687,14 @@ static int aio_poll_cancel(struct kiocb *iocb)
 	return 0;
 }
 
-static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
-		void *key)
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned int mode,
+			 int sync, void *key)
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
 	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
 	__poll_t mask = key_to_poll(key);
 	unsigned long flags;
+	struct kioctx *ctx;
 
 	/* for instances that support it check for an event match first: */
 	if (mask && !(mask & req->events))
@@ -1684,29 +1702,31 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	list_del_init(&req->wait.entry);
 
-	if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
-		struct kioctx *ctx = iocb->ki_ctx;
+	if (!(mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags))) {
+		schedule_work(&req->work);
+		return 1;
+	}
+
+	ctx = iocb->ki_ctx;
 
-		/*
-		 * Try to complete the iocb inline if we can. Use
-		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
-		 * call this function with IRQs disabled and because IRQs
-		 * have to be disabled before ctx_lock is obtained.
-		 */
-		list_del(&iocb->ki_list);
-		iocb->ki_res.res = mangle_poll(mask);
-		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
-			iocb = NULL;
-			INIT_WORK(&req->work, aio_poll_put_work);
-			schedule_work(&req->work);
-		}
-		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		if (iocb)
-			iocb_put(iocb);
-	} else {
+	/*
+	 * Try to complete the iocb inline if we can. Use
+	 * irqsave/irqrestore because not all filesystems (e.g. fuse)
+	 * call this function with IRQs disabled and because IRQs
+	 * have to be disabled before ctx_lock is obtained.
+	 */
+	list_del(&iocb->ki_list);
+	iocb->ki_res.res = mangle_poll(mask);
+	req->done = true;
+	if (iocb->ki_eventfd && eventfd_signal_count()) {
+		iocb = NULL;
+		INIT_WORK(&req->work, aio_poll_put_work);
 		schedule_work(&req->work);
 	}
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	if (iocb)
+		iocb_put(iocb);
+
 	return 1;
 }
 
@@ -1716,9 +1736,8 @@ struct aio_poll_table {
 	int				error;
 };
 
-static void
-aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
-		struct poll_table_struct *p)
+static void aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
+				struct poll_table_struct *p)
 {
 	struct aio_poll_table *pt = container_of(p, struct aio_poll_table, pt);
 
@@ -1766,24 +1785,25 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 	mask = vfs_poll(req->file, &apt.pt) & req->events;
 	spin_lock_irq(&ctx->ctx_lock);
-	if (likely(req->head)) {
-		spin_lock(&req->head->lock);
-		if (unlikely(list_empty(&req->wait.entry))) {
-			if (apt.error)
-				cancel = true;
-			apt.error = 0;
-			mask = 0;
-		}
-		if (mask || apt.error) {
-			list_del_init(&req->wait.entry);
-		} else if (cancel) {
-			WRITE_ONCE(req->cancelled, true);
-		} else if (!req->done) { /* actually waiting for an event */
-			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
-			aiocb->ki_cancel = aio_poll_cancel;
-		}
-		spin_unlock(&req->head->lock);
+	if (unlikely(!req->head))
+		goto out;
+	spin_lock(&req->head->lock);
+	if (unlikely(list_empty(&req->wait.entry))) {
+		if (apt.error)
+			cancel = true;
+		apt.error = 0;
+		mask = 0;
 	}
+	if (mask || apt.error) {
+		list_del_init(&req->wait.entry);
+	} else if (cancel) {
+		WRITE_ONCE(req->cancelled, true);
+	} else if (!req->done) { /* actually waiting for an event */
+		list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
+		aiocb->ki_cancel = aio_poll_cancel;
+	}
+	spin_unlock(&req->head->lock);
+out:
 	if (mask) { /* no async, we'd stolen it */
 		aiocb->ki_res.res = mangle_poll(mask);
 		apt.error = 0;
@@ -2045,20 +2065,21 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 }
 
 static long do_io_getevents(aio_context_t ctx_id,
-		long min_nr,
-		long nr,
-		struct io_event __user *events,
-		struct timespec64 *ts)
+			    long min_nr,
+			    long nr,
+			    struct io_event __user *events,
+			    struct timespec64 *ts)
 {
 	ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
 	struct kioctx *ioctx = lookup_ioctx(ctx_id);
 	long ret = -EINVAL;
 
-	if (likely(ioctx)) {
-		if (likely(min_nr <= nr && min_nr >= 0))
-			ret = read_events(ioctx, min_nr, nr, events, until);
-		percpu_ref_put(&ioctx->users);
-	}
+	if (unlikely(!ioctx))
+		return -EINVAL;
+
+	if (likely(min_nr <= nr && min_nr >= 0))
+		ret = read_events(ioctx, min_nr, nr, events, until);
+	percpu_ref_put(&ioctx->users);
 
 	return ret;
 }
@@ -2156,7 +2177,6 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-
 	ret = set_user_sigmask(ksig.sigmask, ksig.sigsetsize);
 	if (ret)
 		return ret;
@@ -2205,12 +2225,12 @@ struct __compat_aio_sigset {
 #if defined(CONFIG_COMPAT_32BIT_TIME)
 
 COMPAT_SYSCALL_DEFINE6(io_pgetevents,
-		compat_aio_context_t, ctx_id,
-		compat_long_t, min_nr,
-		compat_long_t, nr,
-		struct io_event __user *, events,
-		struct old_timespec32 __user *, timeout,
-		const struct __compat_aio_sigset __user *, usig)
+		       compat_aio_context_t, ctx_id,
+		       compat_long_t, min_nr,
+		       compat_long_t, nr,
+		       struct io_event __user *, events,
+		       struct old_timespec32 __user *, timeout,
+		       const struct __compat_aio_sigset __user *, usig)
 {
 	struct __compat_aio_sigset ksig = { 0, };
 	struct timespec64 t;
@@ -2240,12 +2260,12 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 #endif
 
 COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
-		compat_aio_context_t, ctx_id,
-		compat_long_t, min_nr,
-		compat_long_t, nr,
-		struct io_event __user *, events,
-		struct __kernel_timespec __user *, timeout,
-		const struct __compat_aio_sigset __user *, usig)
+		       compat_aio_context_t, ctx_id,
+		       compat_long_t, min_nr,
+		       compat_long_t, nr,
+		       struct io_event __user *, events,
+		       struct __kernel_timespec __user *, timeout,
+		       const struct __compat_aio_sigset __user *, usig)
 {
 	struct __compat_aio_sigset ksig = { 0, };
 	struct timespec64 t;
-- 
2.28.0

