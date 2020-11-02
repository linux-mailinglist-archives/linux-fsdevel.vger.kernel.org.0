Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45852A2DC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 16:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgKBPMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 10:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKBPL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:11:58 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62DEC0617A6;
        Mon,  2 Nov 2020 07:11:57 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e2so9841069wme.1;
        Mon, 02 Nov 2020 07:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ooI4a4Wj0KgUXphko6rEvbX2q4xK/1fOkH+dAWrnRqM=;
        b=ngylODPXlSSepICMQe8ubxA41VXpmZUdr61pDgHRakzQn/Lahvr9kZBtJkClWb4uOl
         vs4WUTIPb2Qa2RNxWBqgjmBO7L/EuI0Yoy9OvaMP8U/A+0pcX9WV3Dd8WzoNrkPdrMNf
         rEE5enDKwExXLfrycEOblfAEat9fNrZPvr9+Mv4fdP8wmvsmDQp3Jqmcm7GwtF6aoqb0
         vwULvMHqpA5cBaK+2IsQvv0ZZK+F9yjFuF0a6it7LUiEZAJ7kBEN5W1II367ZUA9Ap7v
         ocMq7Yjr6M+qQvvsDe2vKKIo/uqUAPVeqr87a/0jK7yhd7Dh/rx7/f0DLRLovzc/gcZI
         osvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ooI4a4Wj0KgUXphko6rEvbX2q4xK/1fOkH+dAWrnRqM=;
        b=GTgpJHlw2jQE6BVdXNrI7ePDk0o27OQYycazH3goclL3kw0Vi/IG6U9YDNtPHOuEXv
         NUHCTxcrx0H5eXJKGSQw/tTaKS5SvRXuE097ufeV9TLWz7MG9VH2njsYN9oIEtM+Vn9G
         iZSf/hEwUkNLcrQ2WvfvIerHloJ9p4b70eX+Knl3tcElHDmqf6n3Tc21VyqMPVpjOkWb
         +GMJTCLLRgiSVo4+HD6136cbpB2qmX3dB/4ePkeOL72BvPdI2kowLaOLAgtQQU7EhDdS
         KCSCktG9V9/zwUmls1Tve7pNEl4pQyyrE78TW9xthMYz9ei6NkD3bShK/BpVe8wiFqkT
         vxcw==
X-Gm-Message-State: AOAM533oSlHW0bhR2mfYNOiLvlWxVQcGWA6ZXvA99Hv4QL2zV/Svrd8t
        E8r98rSbx3azPsSetneq+EU=
X-Google-Smtp-Source: ABdhPJxvrJn1cYmnbIt1Izng3kINeUuD6CaBVUXnv89TZNcqT7yi1SkAgD7eSAocYj2r7+CUTGGJcw==
X-Received: by 2002:a1c:7202:: with SMTP id n2mr7376001wmc.38.1604329916371;
        Mon, 02 Nov 2020 07:11:56 -0800 (PST)
Received: from localhost.localdomain ([170.253.60.68])
        by smtp.googlemail.com with ESMTPSA id b63sm16690026wme.9.2020.11.02.07.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:11:55 -0800 (PST)
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
To:     Benjamin LaHaise <bcrl@kvhack.org>
Cc:     Alejandro Colomar <colomar.6.4.3@gmail.com>, linux-aio@kvhack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/aio.c: Cosmetic
Date:   Mon,  2 Nov 2020 16:05:08 +0100
Message-Id: <20201102150507.314164-1-colomar.6.4.3@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes:
- Consistently use 'unsigned int', instead of 'unsigned'.
- Add a blank line after variable declarations.
- Move variable declarations to the top of functions.
- Add a blank line at the top of functions if there are no declarations.
- Invert logic of 'if's to reduce indentation and simplify function logic.
	- Add goto tags when needed.
	- Early return when appropriate.
- Add braces to 'else' if the corresponding 'if' used braces.
- Replace spaces by tabs

This patch does not introduce any actual changes in behavior.

Signed-off-by: Alejandro Colomar <colomar.6.4.3@gmail.com>
---

Hello Benjamin,

I found some inconsistencies in the code here
when fixing the manual page for io_setup(3).

I compiled the whole fs (`make fs`):
I used the .config file from debian testing.
No warnings; it compiles fine after the changes.

However I didn't compile the whole kernel (my system got out of space :( ).

This patch should not change any behavior.

Cheers,

Alex


 fs/aio.c | 390 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 208 insertions(+), 182 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index d5ec30385566..9d7dc92a6d7d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -55,16 +55,16 @@
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
+	unsigned int	tail;
 
-	unsigned	magic;
-	unsigned	compat_features;
-	unsigned	incompat_features;
-	unsigned	header_length;	/* size of aio_ring */
+	unsigned int	magic;
+	unsigned int	compat_features;
+	unsigned int	incompat_features;
+	unsigned int	header_length;	/* size of aio_ring */
 
 
 	struct io_event		io_events[];
@@ -80,12 +80,12 @@ struct aio_ring {
 
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
@@ -107,7 +107,7 @@ struct kioctx {
 	 * For percpu reqs_available, number of slots we move to/from global
 	 * counter at a time:
 	 */
-	unsigned		req_batch;
+	unsigned int		req_batch;
 	/*
 	 * This is what userspace passed to io_setup(), it's not used for
 	 * anything but counting against the global max_reqs quota.
@@ -115,10 +115,10 @@ struct kioctx {
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
@@ -156,15 +156,15 @@ struct kioctx {
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
@@ -236,6 +236,7 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
 	struct file *file;
 	struct inode *inode = alloc_anon_inode(aio_mnt->mnt_sb);
+
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
@@ -252,6 +253,7 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 
 static int aio_init_fs_context(struct fs_context *fc)
 {
+
 	if (!init_pseudo(fc, AIO_RING_MAGIC))
 		return -ENOMEM;
 	fc->s_iflags |= SB_I_NOEXEC;
@@ -269,6 +271,7 @@ static int __init aio_setup(void)
 		.init_fs_context = aio_init_fs_context,
 		.kill_sb	= kill_anon_super,
 	};
+
 	aio_mnt = kern_mount(&aio_fs);
 	if (IS_ERR(aio_mnt))
 		panic("Failed to create aio fs mount.");
@@ -284,18 +287,19 @@ static void put_aio_ring_file(struct kioctx *ctx)
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
@@ -363,6 +367,7 @@ static const struct vm_operations_struct aio_ring_vm_ops = {
 
 static int aio_ring_mmap(struct file *file, struct vm_area_struct *vma)
 {
+
 	vma->vm_flags |= VM_DONTEXPAND;
 	vma->vm_ops = &aio_ring_vm_ops;
 	return 0;
@@ -413,8 +418,9 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 		/* Make sure the old page hasn't already been changed */
 		if (ctx->ring_pages[idx] != old)
 			rc = -EAGAIN;
-	} else
+	} else {
 		rc = -EINVAL;
+	}
 
 	if (rc != 0)
 		goto out_unlock;
@@ -632,7 +638,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
 
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 {
-	unsigned i, new_nr;
+	unsigned int i, new_nr;
 	struct kioctx_table *table, *old;
 	struct aio_ring *ring;
 
@@ -640,23 +646,27 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
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
 
@@ -685,8 +695,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 	}
 }
 
-static void aio_nr_sub(unsigned nr)
+static void aio_nr_sub(unsigned int nr)
 {
+
 	spin_lock(&aio_nr_lock);
 	if (WARN_ON(aio_nr - nr > aio_nr))
 		aio_nr = 0;
@@ -698,7 +709,7 @@ static void aio_nr_sub(unsigned nr)
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
  */
-static struct kioctx *ioctx_alloc(unsigned nr_events)
+static struct kioctx *ioctx_alloc(unsigned int nr_events)
 {
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx;
@@ -899,7 +910,7 @@ void exit_aio(struct mm_struct *mm)
 	kfree(table);
 }
 
-static void put_reqs_available(struct kioctx *ctx, unsigned nr)
+static void put_reqs_available(struct kioctx *ctx, unsigned int nr)
 {
 	struct kioctx_cpu *kcpu;
 	unsigned long flags;
@@ -924,21 +935,23 @@ static bool __get_reqs_available(struct kioctx *ctx)
 
 	local_irq_save(flags);
 	kcpu = this_cpu_ptr(ctx->cpu);
-	if (!kcpu->reqs_available) {
-		int old, avail = atomic_read(&ctx->reqs_available);
+	if (kcpu->reqs_available)
+		goto kcpu_reqs_avail;
+
+	int old, avail = atomic_read(&ctx->reqs_available);
 
-		do {
-			if (avail < ctx->req_batch)
-				goto out;
+	do {
+		if (avail < ctx->req_batch)
+			goto out;
 
-			old = avail;
-			avail = atomic_cmpxchg(&ctx->reqs_available,
-					       avail, avail - ctx->req_batch);
-		} while (avail != old);
+		old = avail;
+		avail = atomic_cmpxchg(&ctx->reqs_available,
+				       avail, avail - ctx->req_batch);
+	} while (avail != old);
 
-		kcpu->reqs_available += ctx->req_batch;
-	}
+	kcpu->reqs_available += ctx->req_batch;
 
+kcpu_reqs_avail:
 	ret = true;
 	kcpu->reqs_available--;
 out:
@@ -953,10 +966,10 @@ static bool __get_reqs_available(struct kioctx *ctx)
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
@@ -984,32 +997,34 @@ static void refill_reqs_available(struct kioctx *ctx, unsigned head,
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
 
 static bool get_reqs_available(struct kioctx *ctx)
 {
+
 	if (__get_reqs_available(ctx))
 		return true;
 	user_refill_reqs_available(ctx);
@@ -1050,7 +1065,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx, *ret = NULL;
 	struct kioctx_table *table;
-	unsigned id;
+	unsigned int id;
 
 	if (get_user(id, &ring->id))
 		return NULL;
@@ -1074,6 +1089,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 
 static inline void iocb_destroy(struct aio_kiocb *iocb)
 {
+
 	if (iocb->ki_eventfd)
 		eventfd_ctx_put(iocb->ki_eventfd);
 	if (iocb->ki_filp)
@@ -1090,7 +1106,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
-	unsigned tail, pos, head;
+	unsigned int	tail, pos, head;
 	unsigned long	flags;
 
 	/*
@@ -1160,10 +1176,11 @@ static void aio_complete(struct aio_kiocb *iocb)
 
 static inline void iocb_put(struct aio_kiocb *iocb)
 {
-	if (refcount_dec_and_test(&iocb->ki_refcnt)) {
-		aio_complete(iocb);
-		iocb_destroy(iocb);
-	}
+
+	if (!refcount_dec_and_test(&iocb->ki_refcnt))
+		return;
+	aio_complete(iocb);
+	iocb_destroy(iocb);
 }
 
 /* aio_read_events_ring
@@ -1174,7 +1191,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
 				 struct io_event __user *event, long nr)
 {
 	struct aio_ring *ring;
-	unsigned head, tail, pos;
+	unsigned int head, tail, pos;
 	long ret = 0;
 	int copy_ret;
 
@@ -1309,7 +1326,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
  *	pointer is passed for ctxp.  Will fail with -ENOSYS if not
  *	implemented.
  */
-SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
+SYSCALL_DEFINE2(io_setup, unsigned int, nr_events, aio_context_t __user *, ctxp)
 {
 	struct kioctx *ioctx = NULL;
 	unsigned long ctx;
@@ -1328,19 +1345,19 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 
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
@@ -1359,13 +1376,13 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 
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
@@ -1381,31 +1398,32 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
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
@@ -1466,8 +1484,9 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 		}
 
 		req->ki_ioprio = iocb->aio_reqprio;
-	} else
+	} else {
 		req->ki_ioprio = get_current_ioprio();
+	}
 
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
@@ -1499,6 +1518,7 @@ static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
 
 static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 {
+
 	switch (ret) {
 	case -EIOCBQUEUED:
 		break;
@@ -1567,21 +1587,23 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
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
@@ -1674,8 +1696,8 @@ static int aio_poll_cancel(struct kiocb *iocb)
 	return 0;
 }
 
-static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
-		void *key)
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned int mode,
+		int sync, void *key)
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
 	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
@@ -1688,29 +1710,31 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	list_del_init(&req->wait.entry);
 
-	if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
-		struct kioctx *ctx = iocb->ki_ctx;
+	if (!(mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags))) {
+		schedule_work(&req->work);
+		return 1;
+	}
 
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
+	struct kioctx *ctx = iocb->ki_ctx;
+
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
 
@@ -1770,24 +1794,25 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
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
+	}
+	if (mask || apt.error) {
+		list_del_init(&req->wait.entry);
+	} else if (cancel) {
+		WRITE_ONCE(req->cancelled, true);
+	} else if (!req->done) { /* actually waiting for an event */
+		list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
+		aiocb->ki_cancel = aio_poll_cancel;
 	}
+	spin_unlock(&req->head->lock);
+out:
 	if (mask) { /* no async, we'd stolen it */
 		aiocb->ki_res.res = mangle_poll(mask);
 		apt.error = 0;
@@ -2058,11 +2083,12 @@ static long do_io_getevents(aio_context_t ctx_id,
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
-- 
2.28.0

