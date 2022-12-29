Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97D6592B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 23:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiL2Wvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 17:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiL2WvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:51:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0085020A;
        Thu, 29 Dec 2022 14:51:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y16so18483573wrm.2;
        Thu, 29 Dec 2022 14:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuYI44yqA+jJ0GJlY6M75U/WDifI/BGOeeh04zYv+gQ=;
        b=czGgzlq6ErQML0uDaeprZiSrlegHLztZxTOy78NAQvOfI1DQ5VyFkBW1D4o4kw/1fb
         Mh3/on4hHMPwuzw7YYhn+fkTyIhljeTmnhFKxNFhgEOWyjXxrISGffE/8vOg3gxnnc4I
         I9PfJKrcvMljesnCPljN+q227WfcK5BrniNYZCSVqF4WdoQ6GniJ8v3koHkhipFU3Rha
         sY9tf5BFvj5zN1HNEl6DZprmPVZKCjrlH25ZqwkbEyRfRjO/RlLyU07Q+fiDbCnemE8E
         OC2dZ/TR466lGBxuWsxALeOHmlFuGDqjD/NPJLTsph3jWwO4Ka1OB0kL0RhyONC2c0Ly
         wlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuYI44yqA+jJ0GJlY6M75U/WDifI/BGOeeh04zYv+gQ=;
        b=WGtaH1U4QctSlt38wvXknIkCdx6zdsrw9oRgzDglKtbhQLwmWlCen9jSoY/dJMIzG1
         iLhHcJcFMMj2PnLyZlUPzNH5l9zI31/iZNlIpLhL5wo4RRY2Z8ejWhnrJG4pSZ/Ol4IB
         FazDVIsVCKzijz4rsX0YeQJZAfgPcCvwLpzvIe5dHYPRPyJa/2caIlU7hSJyW746yaRa
         zNnz5CDvkqpFhRRViMksvLXrkvPdfUwuw4tkIfsbzJcP7kX+C2LYcEgNGlYwmYEehe7b
         4T8/rfsQ3f9YmcCP+uuXiKbBuKCwfOL83ObmZTdayEZqXDCRumRDW35q0DqhGAFOyhGa
         7AQQ==
X-Gm-Message-State: AFqh2ko4ZKo6ev12mjE0/wdW6z76+l8OnpKwpRRwwghCsa7AZMpMg1kc
        8ZFe5X0l68L7uwJBYRXQK68o/EPTO6E=
X-Google-Smtp-Source: AMrXdXuc7EYWnXzmJl85FArH4jBSWHgiBakOpbe+kr0eElPXzFuj7/GxT44QVHAM9Uus3eN5e0PCFA==
X-Received: by 2002:adf:fd89:0:b0:24f:5890:6168 with SMTP id d9-20020adffd89000000b0024f58906168mr18975982wrr.10.1672354270380;
        Thu, 29 Dec 2022 14:51:10 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id p3-20020adfcc83000000b0027a57c1a6fbsm13493312wrj.22.2022.12.29.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 14:51:09 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 4/4] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Thu, 29 Dec 2022 23:51:00 +0100
Message-Id: <20221229225100.22141-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229225100.22141-1-fmdefrancesco@gmail.com>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

The use of kmap_local_page() in fs/ufs is "safe" because (1) the kernel
virtual addresses are exclusively re-used by the thread which
established the mappings (i.e., thread locality is never violated) and (2)
the nestings of mappings and un-mappings are always stack based (LIFO).

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
and use it as parameter for the second argument of ufs_put_page().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c   | 72 +++++++++++++++++++++++++++++++++-----------------
 fs/ufs/namei.c |  8 +++---
 fs/ufs/ufs.h   |  2 +-
 3 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 0bfd563ab0c2..8676a144e589 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-inline void ufs_put_page(struct page *page)
+inline void ufs_put_page(struct page *page, void *page_addr)
 {
-	kunmap(page);
+	kunmap_local(page_addr);
 	put_page(page);
 }
 
@@ -76,7 +76,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	de = ufs_find_entry(dir, qstr, &page);
 	if (de) {
 		res = fs32_to_cpu(dir->i_sb, de->d_ino);
-		ufs_put_page(page);
+		ufs_put_page(page, de);
 	}
 	return res;
 }
@@ -99,18 +99,17 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
 	err = ufs_commit_chunk(page, pos, len);
-	ufs_put_page(page);
+	ufs_put_page(page, de);
 	if (update_times)
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 }
 
 
-static bool ufs_check_page(struct page *page)
+static bool ufs_check_page(struct page *page, char *kaddr)
 {
 	struct inode *dir = page->mapping->host;
 	struct super_block *sb = dir->i_sb;
-	char *kaddr = page_address(page);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_SIZE;
 	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
@@ -185,23 +184,32 @@ static bool ufs_check_page(struct page *page)
 	return false;
 }
 
+/*
+ * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
+ * and must be treated accordingly for nesting purposes.
+ */
 static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **p)
 {
+	char *kaddr;
+
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page)) {
-		kmap(page);
+		kaddr = kmap_local_page(page);
 		if (unlikely(!PageChecked(page))) {
-			if (!ufs_check_page(page))
+			if (!ufs_check_page(page, kaddr))
 				goto fail;
 		}
 		*p = page;
-		return page_address(page);
+		return kaddr;
 	}
 	return ERR_CAST(page);
 
 fail:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	return ERR_PTR(-EIO);
 }
 
@@ -227,6 +235,13 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 					fs16_to_cpu(sb, p->d_reclen));
 }
 
+/*
+ * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
+ * accordingly for nesting purposes.
+ */
 struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 {
 	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
@@ -244,6 +259,11 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
  * returns the page in which the entry was found, and the entry itself
  * (as a parameter - res_dir). Page is returned mapped and unlocked.
  * Entry is guaranteed to be valid.
+ *
+ * On Success ufs_put_page() should be called on *res_page.
+ *
+ * ufs_find_entry() acts as a call to ufs_get_page() and must be treated
+ * accordingly for nesting purposes.
  */
 struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 				     struct page **res_page)
@@ -282,7 +302,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 					goto found;
 				de = ufs_next_entry(sb, de);
 			}
-			ufs_put_page(page);
+			ufs_put_page(page, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -360,7 +380,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
 		}
 		unlock_page(page);
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	BUG();
 	return -EINVAL;
@@ -390,7 +410,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -468,13 +488,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 					       ufs_get_de_namlen(sb, de),
 					       fs32_to_cpu(sb, de->d_ino),
 					       d_type)) {
-					ufs_put_page(page);
+					ufs_put_page(page, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
 		}
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -485,10 +505,15 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
  * previous entry.
  */
 int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
-		     struct page * page)
+		     struct page *page)
 {
 	struct super_block *sb = inode->i_sb;
-	char *kaddr = page_address(page);
+	/*
+	 * The "dir" dentry points somewhere in the same page whose we need the
+	 * address of; therefore, we can simply get the base address "kaddr" by
+	 * masking the previous with PAGE_MASK.
+	 */
+	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
 	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
 	loff_t pos;
@@ -527,7 +552,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 out:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	UFSD("EXIT\n");
 	return err;
 }
@@ -551,8 +576,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 		goto fail;
 	}
 
-	kmap(page);
-	base = (char*)page_address(page);
+	base = kmap_local_page(page);
 	memset(base, 0, PAGE_SIZE);
 
 	de = (struct ufs_dir_entry *) base;
@@ -569,7 +593,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
 	ufs_set_de_namlen(sb, de, 2);
 	strcpy (de->d_name, "..");
-	kunmap(page);
+	kunmap_local(base);
 
 	err = ufs_commit_chunk(page, 0, chunk_size);
 fail:
@@ -585,9 +609,9 @@ int ufs_empty_dir(struct inode * inode)
 	struct super_block *sb = inode->i_sb;
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
+	char *kaddr;
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
 		struct ufs_dir_entry *de;
 
 		kaddr = ufs_get_page(inode, i, &page);
@@ -620,12 +644,12 @@ int ufs_empty_dir(struct inode * inode)
 			}
 			de = ufs_next_entry(sb, de);
 		}
-		ufs_put_page(page);
+		ufs_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	ufs_put_page(page);
+	ufs_put_page(page, kaddr);
 	return 0;
 }
 
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 486b0f2e8b7a..7175d45e704c 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -250,7 +250,7 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct page *dir_page = NULL;
-	struct ufs_dir_entry * dir_de = NULL;
+	struct ufs_dir_entry *dir_de = NULL;
 	struct page *old_page;
 	struct ufs_dir_entry *old_de;
 	int err = -ENOENT;
@@ -307,7 +307,7 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		if (old_dir != new_dir)
 			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
 		else {
-			ufs_put_page(dir_page);
+			ufs_put_page(dir_page, dir_de);
 		}
 		inode_dec_link_count(old_dir);
 	}
@@ -316,10 +316,10 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 out_dir:
 	if (dir_de) {
-		ufs_put_page(dir_page);
+		ufs_put_page(dir_page, dir_de);
 	}
 out_old:
-	ufs_put_page(old_page);
+	ufs_put_page(old_page, old_de);
 out:
 	return err;
 }
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index f7ba8df25d03..942639e9a817 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -98,7 +98,7 @@ extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, uns
 extern void ufs_put_cylinder (struct super_block *, unsigned);
 
 /* dir.c */
-extern void ufs_put_page(struct page *page);
+extern void ufs_put_page(struct page *page, void *vaddr);
 extern const struct inode_operations ufs_dir_inode_operations;
 extern int ufs_add_link (struct dentry *, struct inode *);
 extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
-- 
2.39.0

