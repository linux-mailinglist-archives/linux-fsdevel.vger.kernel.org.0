Return-Path: <linux-fsdevel+bounces-5294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC4809AFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 05:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292631C20C76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 04:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4575667
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zg5Ds5JA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OxZEHxqI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zg5Ds5JA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OxZEHxqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161B1712;
	Thu,  7 Dec 2023 19:30:48 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD3ED1FD95;
	Fri,  8 Dec 2023 03:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702006246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPbjaalRYKm9QivlQuryrahlBhRTkM5VSSKDElwEPLI=;
	b=Zg5Ds5JAZACw4o+g9jJZBmTt8O7GGia+Z7B28SSO5ghA9zHtjZE1/qnDyxS8RoiXAmkfk8
	ex4KlIzW4nquEv8QGyIQ2pKi3iksw/Y6pjvL4WN++TgOzz0/0n7OYLKayrv0CmLTvUgIbD
	/5lwiFXCxC0LoZQPTpsavfkp3BMRR+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702006246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPbjaalRYKm9QivlQuryrahlBhRTkM5VSSKDElwEPLI=;
	b=OxZEHxqIuxXo33jqY+SDnj7i5LU9K/udAF5suU/yqdh9vXcCozViAtxy8JbLlzwPkia4pw
	iGTEtKTw9v1/QIDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702006246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPbjaalRYKm9QivlQuryrahlBhRTkM5VSSKDElwEPLI=;
	b=Zg5Ds5JAZACw4o+g9jJZBmTt8O7GGia+Z7B28SSO5ghA9zHtjZE1/qnDyxS8RoiXAmkfk8
	ex4KlIzW4nquEv8QGyIQ2pKi3iksw/Y6pjvL4WN++TgOzz0/0n7OYLKayrv0CmLTvUgIbD
	/5lwiFXCxC0LoZQPTpsavfkp3BMRR+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702006246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPbjaalRYKm9QivlQuryrahlBhRTkM5VSSKDElwEPLI=;
	b=OxZEHxqIuxXo33jqY+SDnj7i5LU9K/udAF5suU/yqdh9vXcCozViAtxy8JbLlzwPkia4pw
	iGTEtKTw9v1/QIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D46581375D;
	Fri,  8 Dec 2023 03:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k/10HeKNcmULMQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 08 Dec 2023 03:30:42 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] nfsd: Don't leave work of closing files to a work queue.
Date: Fri,  8 Dec 2023 14:27:27 +1100
Message-ID: <20231208033006.5546-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208033006.5546-1-neilb@suse.de>
References: <20231208033006.5546-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.71
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 1.90

The work of closing a file can have non-trivial cost.  Doing it in a
separate work queue thread means that cost isn't imposed on the nfsd
threads and an imbalance can be created.  This can result in files being
queue for the work queue more quickly that the work queue can process
them, resulting in unbounded growth of the queue and memory exhaustion.

To avoid this work imbalance that exhausts memory, this patch moves all
closing of files into the nfsd threads.  This means that when the work
imposes a cost, that cost appears where it would be expected - in the
work of the nfsd thread.  A subsequent patch will ensure the final
__fput() is called in the same (nfsd) thread which calls filp_close().

Files opened for NFSv3 are never explicitly closed by the client and are
kept open by the server in the "filecache", which responds to memory
pressure, is garbage collected even when there is no pressure, and
sometimes closes files when there is particular need such as for rename.
These files currently have filp_close() called in a dedicated work
queue, so their __fput() can have no effect on nfsd threads.

This patch discards the work queue and instead has each nfsd thread call
flip_close() on as many as 8 files from the filecache each time it acts
on a client request (or finds there are no pending client requests).  If
there are more to be closed, more threads are woken.  This spreads the
work of __fput() over multiple threads and imposes any cost on those
threads.

The number 8 is somewhat arbitrary.  It needs to be greater than 1 to
ensure that files are closed more quickly than they can be added to the
cache.  It needs to be small enough to limit the per-request delays that
will be imposed on clients when all threads are busy closing files.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 67 +++++++++++++++++++++------------------------
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/nfssvc.c    |  2 ++
 3 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e9734c7451b5..f9da4b0c4d42 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -61,13 +61,10 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
 struct nfsd_fcache_disposal {
-	struct work_struct work;
 	spinlock_t lock;
 	struct list_head freeme;
 };
 
-static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
-
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
@@ -423,7 +420,37 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 		spin_lock(&l->lock);
 		list_move_tail(&nf->nf_lru, &l->freeme);
 		spin_unlock(&l->lock);
-		queue_work(nfsd_filecache_wq, &l->work);
+		svc_wake_up(nn->nfsd_serv);
+	}
+}
+
+/**
+ * nfsd_file_net_dispose - deal with nfsd_files waiting to be disposed.
+ * @nn: nfsd_net in which to find files to be disposed.
+ *
+ * When files held open for nfsv3 are removed from the filecache, whether
+ * due to memory pressure or garbage collection, they are queued to
+ * a per-net-ns queue.  This function completes the disposal, either
+ * directly or by waking another nfsd thread to help with the work.
+ */
+void nfsd_file_net_dispose(struct nfsd_net *nn)
+{
+	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+
+	if (!list_empty(&l->freeme)) {
+		LIST_HEAD(dispose);
+		int i;
+
+		spin_lock(&l->lock);
+		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
+			list_move(l->freeme.next, &dispose);
+		spin_unlock(&l->lock);
+		if (!list_empty(&l->freeme))
+			/* Wake up another thread to share the work
+			 * *before* doing any actual disposing.
+			 */
+			svc_wake_up(nn->nfsd_serv);
+		nfsd_file_dispose_list(&dispose);
 	}
 }
 
@@ -635,27 +662,6 @@ nfsd_file_close_inode_sync(struct inode *inode)
 	}
 }
 
-/**
- * nfsd_file_delayed_close - close unused nfsd_files
- * @work: dummy
- *
- * Scrape the freeme list for this nfsd_net, and then dispose of them
- * all.
- */
-static void
-nfsd_file_delayed_close(struct work_struct *work)
-{
-	LIST_HEAD(head);
-	struct nfsd_fcache_disposal *l = container_of(work,
-			struct nfsd_fcache_disposal, work);
-
-	spin_lock(&l->lock);
-	list_splice_init(&l->freeme, &head);
-	spin_unlock(&l->lock);
-
-	nfsd_file_dispose_list(&head);
-}
-
 static int
 nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
 			    void *data)
@@ -718,10 +724,6 @@ nfsd_file_cache_init(void)
 		return ret;
 
 	ret = -ENOMEM;
-	nfsd_filecache_wq = alloc_workqueue("nfsd_filecache", 0, 0);
-	if (!nfsd_filecache_wq)
-		goto out;
-
 	nfsd_file_slab = kmem_cache_create("nfsd_file",
 				sizeof(struct nfsd_file), 0, 0, NULL);
 	if (!nfsd_file_slab) {
@@ -736,7 +738,6 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-
 	ret = list_lru_init(&nfsd_file_lru);
 	if (ret) {
 		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
@@ -786,8 +787,6 @@ nfsd_file_cache_init(void)
 	nfsd_file_slab = NULL;
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	destroy_workqueue(nfsd_filecache_wq);
-	nfsd_filecache_wq = NULL;
 	rhltable_destroy(&nfsd_file_rhltable);
 	goto out;
 }
@@ -833,7 +832,6 @@ nfsd_alloc_fcache_disposal(void)
 	l = kmalloc(sizeof(*l), GFP_KERNEL);
 	if (!l)
 		return NULL;
-	INIT_WORK(&l->work, nfsd_file_delayed_close);
 	spin_lock_init(&l->lock);
 	INIT_LIST_HEAD(&l->freeme);
 	return l;
@@ -842,7 +840,6 @@ nfsd_alloc_fcache_disposal(void)
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	cancel_work_sync(&l->work);
 	nfsd_file_dispose_list(&l->freeme);
 	kfree(l);
 }
@@ -911,8 +908,6 @@ nfsd_file_cache_shutdown(void)
 	fsnotify_wait_marks_destroyed();
 	kmem_cache_destroy(nfsd_file_mark_slab);
 	nfsd_file_mark_slab = NULL;
-	destroy_workqueue(nfsd_filecache_wq);
-	nfsd_filecache_wq = NULL;
 	rhltable_destroy(&nfsd_file_rhltable);
 
 	for_each_possible_cpu(i) {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index e54165a3224f..c61884def906 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -56,6 +56,7 @@ void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
+void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fe61d9bbcc1f..26e203f42edd 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -956,6 +956,8 @@ nfsd(void *vrqstp)
 
 		svc_recv(rqstp);
 		validate_process_creds();
+
+		nfsd_file_net_dispose(nn);
 	}
 
 	atomic_dec(&nfsdstats.th_cnt);
-- 
2.43.0


