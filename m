Return-Path: <linux-fsdevel+bounces-7989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA52F82E021
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB75B1C22080
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9931945B;
	Mon, 15 Jan 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrYLCeRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999F18EC9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e744f7ca3bso140981057b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 10:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705343927; x=1705948727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=21zH497B8+dg0O/C7EwYJfD0SYQoqr7syeq2JJc4d60=;
        b=UrYLCeREsFnwAxoJC+umUFKYt2DuQ3CNnswQf7APYA2WgQWK5V8XPnb95quE5NoFwE
         83zrG5dhCYFJxsVLPJCIdm493/BXW7HXchO7TjTw9BCTqQBHsefT6v2e8qVHzj4efQmH
         1HQOGvPo37nTrw4veIPGkRNtVEWJjYGNwqGA7jIpv/YiZjI2SwCApeEQX9z1V+tJ28j5
         5nL+WaXh/9aBG3pq2ECFqqQxosXJFi8mzNiJ6AzT9jAlNSngk0Fa+kgsq5GB1TiBBvF7
         cGFQoFgJmVvr3mtRpSxipoIfXN5Ao6V+4Rbqbgr8Gu6SgNKdb7u1MwQXHwUG1osMDJzG
         Ol4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705343927; x=1705948727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21zH497B8+dg0O/C7EwYJfD0SYQoqr7syeq2JJc4d60=;
        b=RM9jlVM5J3VQqOyhzhOgqfCqsmSiZV2zzN2k+JEUhRgnh5aY6JdW66WjJTrVASd6Jx
         35Qok9Gt4/Z+PtA/y4aM/4AVQlU0JeGMPtnX38iCsbIlGhuQVY64qY+08fU7QOP93Jed
         Ut3gX8/aYrsb7WRdamo0rTnYB/aD8nwbGIMdyVfGStdpwQsytwloqJIJFfz/Pi9m6VpL
         /Xy7wlcycj6Vlfgmzp1uhxUDv3NmxpLD8Z8bIlRZugJchstoU31WKapO4Uyyh0EJ07eq
         /UrmtqXIUt09/NypWbcFv2G2kiJasToRQNpKvBDjx0PrFImqkTBqDbGjoFTAe9NfrF2k
         l3wQ==
X-Gm-Message-State: AOJu0YxG42cOivkrqrx8SLKLeSvHhqjy5xXi/GHbUbYHFNeoVCy/Ox+4
	bFZUBG7XMgCIEP5QJ8NHatMgyrN6LNeNW3NOhw==
X-Google-Smtp-Source: AGHT+IFB8/hnPbdwsoiv7tQuwUtxLgPQDLNW02byS+mXpmjbpqM8r5SRgtD+OQwpIXqVBxjlqXtVMNNKQrk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3af2:e48e:2785:270])
 (user=surenb job=sendgmr) by 2002:a05:690c:805:b0:5fc:4ef9:9d6b with SMTP id
 bx5-20020a05690c080500b005fc4ef99d6bmr2038449ywb.9.1705343927162; Mon, 15 Jan
 2024 10:38:47 -0800 (PST)
Date: Mon, 15 Jan 2024 10:38:36 -0800
In-Reply-To: <20240115183837.205694-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115183837.205694-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240115183837.205694-4-surenb@google.com>
Subject: [RFC 3/3] mm/maps: read proc/pid/maps under RCU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

With maple_tree supporting vma tree traversal under RCU and per-vma locks
making vma access RCU-safe, /proc/pid/maps can be read under RCU and
without the need to read-lock mmap_lock. However vma content can change
from under us, therefore we need to pin pointer fields used when
generating the output (currently only vm_file and anon_name).
In addition, we validate data before publishing it to the user using new
seq_file validate interface. This way we keep this mechanism consistent
with the previous behavior where data tearing is possible only at page
boundaries.
This change is designed to reduce mmap_lock contention and prevent a
process reading /proc/pid/maps files (often a low priority task, such as
monitoring/data collection services) from blocking address space updates.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/internal.h |   3 ++
 fs/proc/task_mmu.c | 130 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a71ac5379584..47233408550b 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -290,6 +290,9 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 	struct vma_iterator iter;
+	int mm_lock_seq;
+	struct anon_vma_name *anon_name;
+	struct file *vm_file;
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 62b16f42d5d2..d4305cfdca58 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -141,6 +141,22 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
 	return vma;
 }
 
+static const struct seq_operations proc_pid_maps_op;
+
+static inline bool needs_mmap_lock(struct seq_file *m)
+{
+#ifdef CONFIG_PER_VMA_LOCK
+	/*
+	 * smaps and numa_maps perform page table walk, therefore require
+	 * mmap_lock but maps can be read under RCU.
+	 */
+	return m->op != &proc_pid_maps_op;
+#else
+	/* Without per-vma locks VMA access is not RCU-safe */
+	return true;
+#endif
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
@@ -162,11 +178,17 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return NULL;
 	}
 
-	if (mmap_read_lock_killable(mm)) {
-		mmput(mm);
-		put_task_struct(priv->task);
-		priv->task = NULL;
-		return ERR_PTR(-EINTR);
+	if (needs_mmap_lock(m)) {
+		if (mmap_read_lock_killable(mm)) {
+			mmput(mm);
+			put_task_struct(priv->task);
+			priv->task = NULL;
+			return ERR_PTR(-EINTR);
+		}
+	} else {
+		/* For memory barrier see the comment for mm_lock_seq in mm_struct */
+		priv->mm_lock_seq = smp_load_acquire(&priv->mm->mm_lock_seq);
+		rcu_read_lock();
 	}
 
 	vma_iter_init(&priv->iter, mm, last_addr);
@@ -195,7 +217,10 @@ static void m_stop(struct seq_file *m, void *v)
 		return;
 
 	release_task_mempolicy(priv);
-	mmap_read_unlock(mm);
+	if (needs_mmap_lock(m))
+		mmap_read_unlock(mm);
+	else
+		rcu_read_unlock();
 	mmput(mm);
 	put_task_struct(priv->task);
 	priv->task = NULL;
@@ -283,8 +308,10 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	start = vma->vm_start;
 	end = vma->vm_end;
 	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
-	if (mm)
-		anon_name = anon_vma_name(vma);
+	if (mm) {
+		anon_name = needs_mmap_lock(m) ? anon_vma_name(vma) :
+				anon_vma_name_get_rcu(vma);
+	}
 
 	/*
 	 * Print the dentry name for named mappings, and a
@@ -338,19 +365,96 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 		seq_puts(m, name);
 	}
 	seq_putc(m, '\n');
+	if (anon_name && !needs_mmap_lock(m))
+		anon_vma_name_put(anon_name);
+}
+
+/*
+ * Pin vm_area_struct fields used by show_map_vma. We also copy pinned fields
+ * into proc_maps_private because by the time put_vma_fields() is called, VMA
+ * might have changed and these fields might be pointing to different objects.
+ */
+static bool get_vma_fields(struct vm_area_struct *vma, struct proc_maps_private *priv)
+{
+	if (vma->vm_file) {
+		priv->vm_file =  get_file_rcu(&vma->vm_file);
+		if (!priv->vm_file)
+			return false;
+
+	} else
+		priv->vm_file = NULL;
+
+	if (vma->anon_name) {
+		priv->anon_name = anon_vma_name_get_rcu(vma);
+		if (!priv->anon_name) {
+			if (priv->vm_file) {
+				fput(priv->vm_file);
+				return false;
+			}
+		}
+	} else
+		priv->anon_name = NULL;
+
+	return true;
+}
+
+static void put_vma_fields(struct proc_maps_private *priv)
+{
+	if (priv->anon_name)
+		anon_vma_name_put(priv->anon_name);
+	if (priv->vm_file)
+		fput(priv->vm_file);
 }
 
 static int show_map(struct seq_file *m, void *v)
 {
-	show_map_vma(m, v);
+	struct proc_maps_private *priv = m->private;
+
+	if (needs_mmap_lock(m))
+		show_map_vma(m, v);
+	else {
+		/*
+		 * Stop immediately if the VMA changed from under us.
+		 * Validation step will prevent publishing already cached data.
+		 */
+		if (!get_vma_fields(v, priv))
+			return -EAGAIN;
+
+		show_map_vma(m, v);
+		put_vma_fields(priv);
+	}
+
 	return 0;
 }
 
+static int validate_map(struct seq_file *m, void *v)
+{
+	if (!needs_mmap_lock(m)) {
+		struct proc_maps_private *priv = m->private;
+		int mm_lock_seq;
+
+		/* For memory barrier see the comment for mm_lock_seq in mm_struct */
+		mm_lock_seq = smp_load_acquire(&priv->mm->mm_lock_seq);
+		if (mm_lock_seq != priv->mm_lock_seq) {
+			/*
+			 * mmap_lock contention is detected. Wait for mmap_lock
+			 * write to be released, discard stale data and retry.
+			 */
+			mmap_read_lock(priv->mm);
+			mmap_read_unlock(priv->mm);
+			return -EAGAIN;
+		}
+	}
+	return 0;
+
+}
+
 static const struct seq_operations proc_pid_maps_op = {
-	.start	= m_start,
-	.next	= m_next,
-	.stop	= m_stop,
-	.show	= show_map
+	.start		= m_start,
+	.next		= m_next,
+	.stop		= m_stop,
+	.show		= show_map,
+	.validate	= validate_map,
 };
 
 static int pid_maps_open(struct inode *inode, struct file *file)
-- 
2.43.0.381.gb435a96ce8-goog


