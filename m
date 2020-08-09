Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D33123FE03
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Aug 2020 13:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHILqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Aug 2020 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgHILql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:46:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C4C061756
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Aug 2020 04:46:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l60so3276514pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2020 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tfZN55ghx6kyrOr9htmdAtXQNqLYCOsGgIWdC0RY4bQ=;
        b=KI6MB1vHUn5OrFuZ6LQ4kfMcai4/b6KRGi/ZyOkWaM3jibY0WKGYuul51x1E4iMy+l
         n91G+WOdSxgXpTvgbY5G+Zvvo2sK5G4eTjW8gBw++3KqwCQUmrP5IIFYL5xxQ8cn6l/d
         KJQG7R8wWyDn5BaHqehqfUKXcS1/aB1Izg1KngwQUrwSZGgJ3omykax/rzfxW47y5bwg
         gF+fV3e40C2xRs3DvPTC8suSLs3pLVq/SBIUVNkXWt/WirjTP7tz+3XodxWdNu1Ccw93
         exgINcoMRwvzqGR66XDqVByRBRCj56HPper4NcRf4svJp+PbYp/1eyKD2XLphp4+z3Uj
         J7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tfZN55ghx6kyrOr9htmdAtXQNqLYCOsGgIWdC0RY4bQ=;
        b=ZJc/3nOpFK8N4eQwGCS5Pb53Ku9eTZFpiAiMX8XM+SJxFCkmDI2iSrRNeRsLsVTEo5
         cSJFppy6DVu/shWaJnK2IqXrh16LP8f/3UFf94FuEy0LxrTTPQ849p4IsEK4sCJl1jiE
         5xQ+/lArR3DOgTzKkcQ3MYgzRTb3s0hQrOhg6F9PKvPXgivpG9bdRBDJ5t4Y4UQkQWS3
         XfRaayLsx1Hw86xLA3GGaYgv6BKhirRW/JCKtS0r0Bfcj19UZWJz4p87c0OewEamnR2U
         UFknfX6ng9N9R23/snO5wk597tbtVd2bf6lAGWpIZFpsgoEwCIAJlSYoQXtMUfYA9XRR
         9G0w==
X-Gm-Message-State: AOAM5312tEjA7QY+voYszjjB0ByPJ1CLdL/Fx1EurSIKbRXXoKx49bxc
        nUkR8JAFnZLB5wHvA91YgIvNYN44HEA=
X-Google-Smtp-Source: ABdhPJxj6NtsfUolytiXik+L9JzBczaA570DhJYXWTh0tL1dxZKC2VS5XzMT/z6Yh3H2boOg9MVKFw==
X-Received: by 2002:a17:902:9a09:: with SMTP id v9mr13891476plp.331.1596973599944;
        Sun, 09 Aug 2020 04:46:39 -0700 (PDT)
Received: from localhost.localdomain ([147.46.114.52])
        by smtp.gmail.com with ESMTPSA id o15sm829542pfu.167.2020.08.09.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 04:46:39 -0700 (PDT)
From:   Injae Kang <abcinje@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Injae Kang <abcinje@gmail.com>
Subject: [PATCH] fs: dcache: fix coding style
Date:   Sun,  9 Aug 2020 11:46:33 +0000
Message-Id: <20200809114633.1412161-1-abcinje@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix coding style of dcache.c

Signed-off-by: Injae Kang <abcinje@gmail.com>
---
 fs/dcache.c | 54 ++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 361ea7ab30ea..3fe4bd610cc2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -193,7 +193,7 @@ int proc_nr_dentry(struct ctl_table *table, int write, void *buffer,
  */
 static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char *ct, unsigned tcount)
 {
-	unsigned long a,b,mask;
+	unsigned long a, b, mask;
 
 	for (;;) {
 		a = read_word_at_a_time(cs);
@@ -268,7 +268,7 @@ static void __d_free(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
 
-	kmem_cache_free(dentry_cache, dentry); 
+	kmem_cache_free(dentry_cache, dentry);
 }
 
 static void __d_free_external(struct rcu_head *head)
@@ -354,7 +354,7 @@ static void dentry_free(struct dentry *dentry)
  * Release the dentry's inode, using the filesystem
  * d_iput() operation if defined.
  */
-static void dentry_unlink_inode(struct dentry * dentry)
+static void dentry_unlink_inode(struct dentry *dentry)
 	__releases(dentry->d_lock)
 	__releases(dentry->d_inode->i_lock)
 {
@@ -393,7 +393,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
  * These helper functions make sure we always follow the
  * rules. d_lock must be held by the caller.
  */
-#define D_FLAG_VERIFY(dentry,x) WARN_ON_ONCE(((dentry)->d_flags & (DCACHE_LRU_LIST | DCACHE_SHRINK_LIST)) != (x))
+#define D_FLAG_VERIFY(dentry, x) WARN_ON_ONCE(((dentry)->d_flags & (DCACHE_LRU_LIST | DCACHE_SHRINK_LIST)) != (x))
 static void d_lru_add(struct dentry *dentry)
 {
 	D_FLAG_VERIFY(dentry, 0);
@@ -830,7 +830,7 @@ static inline bool fast_dput(struct dentry *dentry)
 }
 
 
-/* 
+/*
  * This is dput
  *
  * This is complicated by the fact that we do not want to put
@@ -849,7 +849,7 @@ static inline bool fast_dput(struct dentry *dentry)
 
 /*
  * dput - release a dentry
- * @dentry: dentry to release 
+ * @dentry: dentry to release
  *
  * Release a dentry. This will drop the usage count and if appropriate
  * call the dentry unlink method as well as removing it from the queues and
@@ -960,7 +960,7 @@ struct dentry *dget_parent(struct dentry *dentry)
 }
 EXPORT_SYMBOL(dget_parent);
 
-static struct dentry * __d_find_any_alias(struct inode *inode)
+static struct dentry *__d_find_any_alias(struct inode *inode)
 {
 	struct dentry *alias;
 
@@ -1012,7 +1012,7 @@ static struct dentry *__d_find_alias(struct inode *inode)
 
 	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
 		spin_lock(&alias->d_lock);
- 		if (!d_unhashed(alias)) {
+		if (!d_unhashed(alias)) {
 			__dget_dlock(alias);
 			spin_unlock(&alias->d_lock);
 			return alias;
@@ -1460,7 +1460,7 @@ int d_set_mounted(struct dentry *dentry)
 			ret = 0;
 		}
 	}
- 	spin_unlock(&dentry->d_lock);
+	spin_unlock(&dentry->d_lock);
 out:
 	write_sequnlock(&rename_lock);
 	return ret;
@@ -1699,7 +1699,7 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
+
 static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
 	struct dentry *dentry;
@@ -1726,14 +1726,14 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 						  GFP_KERNEL_ACCOUNT |
 						  __GFP_RECLAIMABLE);
 		if (!p) {
-			kmem_cache_free(dentry_cache, dentry); 
+			kmem_cache_free(dentry_cache, dentry);
 			return NULL;
 		}
 		atomic_set(&p->u.count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_iname;
-	}	
+	}
 
 	dentry->d_name.len = name->len;
 	dentry->d_name.hash = name->hash;
@@ -1783,7 +1783,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
-struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
+struct dentry *d_alloc(struct dentry *parent, const struct qstr *name)
 {
 	struct dentry *dentry = __d_alloc(parent->d_sb, name);
 	if (!dentry)
@@ -1808,7 +1808,7 @@ struct dentry *d_alloc_anon(struct super_block *sb)
 }
 EXPORT_SYMBOL(d_alloc_anon);
 
-struct dentry *d_alloc_cursor(struct dentry * parent)
+struct dentry *d_alloc_cursor(struct dentry *parent)
 {
 	struct dentry *dentry = d_alloc_anon(parent->d_sb);
 	if (dentry) {
@@ -1965,8 +1965,8 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
-void d_instantiate(struct dentry *entry, struct inode * inode)
+
+void d_instantiate(struct dentry *entry, struct inode *inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
 	if (inode) {
@@ -2175,7 +2175,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2384,7 +2384,7 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	 * See Documentation/filesystems/path-lookup.txt for more details.
 	 */
 	rcu_read_lock();
-	
+
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 
 		if (dentry->d_name.hash != hash)
@@ -2405,10 +2405,10 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 		break;
 next:
 		spin_unlock(&dentry->d_lock);
- 	}
- 	rcu_read_unlock();
+	}
+	rcu_read_unlock();
 
- 	return found;
+	return found;
 }
 
 /**
@@ -2447,7 +2447,7 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * it from the hash queues and waiting for
  * it to be deleted later when it has no users
  */
- 
+
 /**
  * d_delete - delete a dentry
  * @dentry: The dentry to delete
@@ -2455,8 +2455,8 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * Turn the dentry into a negative dentry if possible, otherwise
  * remove it from the hash queues so it can be deleted later
  */
- 
-void d_delete(struct dentry * dentry)
+
+void d_delete(struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 
@@ -2491,8 +2491,8 @@ static void __d_rehash(struct dentry *entry)
  *
  * Adds a dentry to the hash according to its name.
  */
- 
-void d_rehash(struct dentry * entry)
+
+void d_rehash(struct dentry *entry)
 {
 	spin_lock(&entry->d_lock);
 	__d_rehash(entry);
@@ -3082,7 +3082,7 @@ EXPORT_SYMBOL(d_splice_alias);
  * Returns false otherwise.
  * Caller must ensure that "new_dentry" is pinned before calling is_subdir()
  */
-  
+
 bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 {
 	bool result;
-- 
2.25.1

