Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E64CF378
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiCGIYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 03:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCGIYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:24:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A9329BE;
        Mon,  7 Mar 2022 00:23:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so5929437wmq.2;
        Mon, 07 Mar 2022 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cKT/1dr2+xKuQJ1Vz6xwOwRtkb0/MEs5jCMptCWDMo=;
        b=J5fAGTwGnB/kolKDKE/OvpYt3yxiunGyzMPExKPEaS/WHQbKueEN1jbpNN41YHWwAg
         0fkWNEWLh+sEpRDvpouBsRTjx+dYxPibW7ftz3vRg7uzNst/YqjjmyVPM3DLo7ViDRPI
         8NBxGrQOb3Z/vd7evYbjY4eftApTRcsfbn+oJS0vOtVXWD2Xx2DVJkxkt4pMXM27IEXQ
         HL2VJwt+5aOKW7CBt5v+Mc4EM1UJf89766XMJn7zQIBhLFfIyOqaNG+GC/yOdM+zI/Vd
         +2V0kmOXrlnkLN6sN39+btM7Eb5DuI3joP2/DqXySv+/X8NA0TdyY5SVkrewhZcSFYAI
         ALnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cKT/1dr2+xKuQJ1Vz6xwOwRtkb0/MEs5jCMptCWDMo=;
        b=PDhUPvkXrofLTZpF06FFe6Bvf/OwjHOFjOn2PPRt/iaO2DsZdX6/GQDKbCG4lYm1aE
         FFL/LM+sUkk4EcFu9U4VNXdmmlyqCelpfnKBQLsbNAF1Vh0bhVO8olyzxxwd6NPIawjD
         iAahIzQcPVmmfJGF1MccaJlU1gc+YORAsCGfAiWrDt9ZTTWjPKcB1QEK7eccZD4adt52
         ufOYI9wkcKg/ZkhiOfaCcXr+n/WvzwGvj9kYc1vFujH+QB3kOIOAn/Fwygi6Eurs3cO3
         KC0ba1ux8mbGldy6Mi+bVY7EFqDyy8iHO9NpoPHqiVaSMr3G6N3VaId6ZLAJByr+PAnz
         9L6w==
X-Gm-Message-State: AOAM5310IyGboxaJBxqgcAsTk0nnnApPrFfb10tZ7kLS8Zu+EHlBs3Gx
        wlL61Y3BTfKlE+tQnkPYR0M=
X-Google-Smtp-Source: ABdhPJwHe86+JdMQtbw+MzMFqmMZSqJvWkmQwxYT1IUaRM5F0YbE4cXQ8TsbeLQ2UNwIPtytvasRXQ==
X-Received: by 2002:a05:600c:ac5:b0:389:a170:c34 with SMTP id c5-20020a05600c0ac500b00389a1700c34mr4886407wmr.100.1646641393404;
        Mon, 07 Mar 2022 00:23:13 -0800 (PST)
Received: from localhost.localdomain (cpc110361-king13-2-0-cust623.19-1.cable.virginm.net. [92.238.50.112])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b001f067c7b47fsm15055067wru.27.2022.03.07.00.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:23:13 -0800 (PST)
From:   Salih MSA <salihmahmoudsahmed@gmail.com>
X-Google-Original-From: Salih MSA <salih.msa@outlook.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, Salih MSA <salih.msa@outlook.com>
Subject: [PATCH] fs: aio: fixed purely styling errors
Date:   Mon,  7 Mar 2022 08:22:57 +0000
Message-Id: <20220307082257.582466-1-salih.msa@outlook.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mostly clarified unsigned -> unsigned int.
Also separated declarations from functionality.

Signed-off-by: Salih MSA <salih.msa@outlook.com>
---
 fs/aio.c | 84 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 4ceba13a7db0..1c2bc6654159 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -54,16 +54,16 @@
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
@@ -79,12 +79,12 @@ struct aio_ring {
 
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
@@ -106,7 +106,7 @@ struct kioctx {
 	 * For percpu reqs_available, number of slots we move to/from global
 	 * counter at a time:
 	 */
-	unsigned		req_batch;
+	unsigned int		req_batch;
 	/*
 	 * This is what userspace passed to io_setup(), it's not used for
 	 * anything but counting against the global max_reqs quota.
@@ -114,10 +114,10 @@ struct kioctx {
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
@@ -155,15 +155,15 @@ struct kioctx {
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
@@ -262,6 +262,7 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 {
 	struct file *file;
 	struct inode *inode = alloc_anon_inode(aio_mnt->mnt_sb);
+
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
@@ -300,7 +301,7 @@ static int __init aio_setup(void)
 		panic("Failed to create aio fs mount.");
 
 	kiocb_cachep = KMEM_CACHE(aio_kiocb, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
-	kioctx_cachep = KMEM_CACHE(kioctx,SLAB_HWCACHE_ALIGN|SLAB_PANIC);
+	kioctx_cachep = KMEM_CACHE(kioctx, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
 	aio_sysctl_init();
 	return 0;
 }
@@ -336,6 +337,7 @@ static void aio_free_ring(struct kioctx *ctx)
 
 	for (i = 0; i < ctx->nr_pages; i++) {
 		struct page *page;
+
 		pr_debug("pid(%d) [%d] page->count=%d\n", current->pid, i,
 				page_count(ctx->ring_pages[i]));
 		page = ctx->ring_pages[i];
@@ -525,6 +527,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
+
 		page = find_or_create_page(file->f_mapping,
 					   i, GFP_HIGHUSER | __GFP_ZERO);
 		if (!page)
@@ -659,7 +662,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
 
 static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 {
-	unsigned i, new_nr;
+	unsigned int i, new_nr;
 	struct kioctx_table *table, *old;
 	struct aio_ring *ring;
 
@@ -711,7 +714,7 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 	}
 }
 
-static void aio_nr_sub(unsigned nr)
+static void aio_nr_sub(unsigned int nr)
 {
 	spin_lock(&aio_nr_lock);
 	if (WARN_ON(aio_nr - nr > aio_nr))
@@ -724,7 +727,7 @@ static void aio_nr_sub(unsigned nr)
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
  */
-static struct kioctx *ioctx_alloc(unsigned nr_events)
+static struct kioctx *ioctx_alloc(unsigned int nr_events)
 {
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx;
@@ -925,7 +928,7 @@ void exit_aio(struct mm_struct *mm)
 	kfree(table);
 }
 
-static void put_reqs_available(struct kioctx *ctx, unsigned nr)
+static void put_reqs_available(struct kioctx *ctx, unsigned int nr)
 {
 	struct kioctx_cpu *kcpu;
 	unsigned long flags;
@@ -979,10 +982,10 @@ static bool __get_reqs_available(struct kioctx *ctx)
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
@@ -1013,7 +1016,7 @@ static void user_refill_reqs_available(struct kioctx *ctx)
 	spin_lock_irq(&ctx->completion_lock);
 	if (ctx->completed_events) {
 		struct aio_ring *ring;
-		unsigned head;
+		unsigned int head;
 
 		/* Access of ring->head may race with aio_read_events_ring()
 		 * here, but that's okay since whether we read the old version
@@ -1076,7 +1079,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	struct mm_struct *mm = current->mm;
 	struct kioctx *ctx, *ret = NULL;
 	struct kioctx_table *table;
-	unsigned id;
+	unsigned int id;
 
 	if (get_user(id, &ring->id))
 		return NULL;
@@ -1116,7 +1119,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
-	unsigned tail, pos, head;
+	unsigned int tail, pos, head;
 	unsigned long	flags;
 
 	/*
@@ -1140,7 +1143,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	kunmap_atomic(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 
-	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
+	pr_debug("%p[%u]: %p: %p %llx %llx %llx\n", ctx, tail, iocb,
 		 (void __user *)(unsigned long)iocb->ki_res.obj,
 		 iocb->ki_res.data, iocb->ki_res.res, iocb->ki_res.res2);
 
@@ -1200,7 +1203,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
 				 struct io_event __user *event, long nr)
 {
 	struct aio_ring *ring;
-	unsigned head, tail, pos;
+	unsigned int head, tail, pos;
 	long ret = 0;
 	int copy_ret;
 
@@ -1326,16 +1329,16 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
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
@@ -1347,8 +1350,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 
 	ret = -EINVAL;
 	if (unlikely(ctx || nr_events == 0)) {
-		pr_debug("EINVAL: ctx %lu nr_events %u\n",
-		         ctx, nr_events);
+		pr_debug("EINVAL: ctx %lu nr_events %u\n", ctx, nr_events);
 		goto out;
 	}
 
@@ -1366,7 +1368,7 @@ SYSCALL_DEFINE2(io_setup, unsigned, nr_events, aio_context_t __user *, ctxp)
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
+COMPAT_SYSCALL_DEFINE2(io_setup, unsigned int, nr_events, u32 __user *, ctx32p)
 {
 	struct kioctx *ioctx = NULL;
 	unsigned long ctx;
@@ -1378,8 +1380,7 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 
 	ret = -EINVAL;
 	if (unlikely(ctx || nr_events == 0)) {
-		pr_debug("EINVAL: ctx %lu nr_events %u\n",
-		         ctx, nr_events);
+		pr_debug("EINVAL: ctx %lu nr_events %u\n", ctx, nr_events);
 		goto out;
 	}
 
@@ -1399,7 +1400,7 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 #endif
 
 /* sys_io_destroy:
- *	Destroy the aio_context specified.  May cancel any outstanding 
+ *	Destroy the aio_context specified.  May cancel any outstanding
  *	AIOs and block on completion.  Will fail with -ENOSYS if not
  *	implemented.  May fail with -EINVAL if the context pointed to
  *	is invalid.
@@ -1407,7 +1408,8 @@ COMPAT_SYSCALL_DEFINE2(io_setup, unsigned, nr_events, u32 __user *, ctx32p)
 SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 {
 	struct kioctx *ioctx = lookup_ioctx(ctx);
-	if (likely(NULL != ioctx)) {
+
+	if (likely(ioctx != NULL)) {
 		struct ctx_rq_wait wait;
 		int ret;
 
@@ -1755,7 +1757,7 @@ static int aio_poll_cancel(struct kiocb *iocb)
 	return 0;
 }
 
-static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned int mode, int sync,
 		void *key)
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
-- 
2.25.1

