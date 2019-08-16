Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448CC8FACD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 08:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfHPGRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 02:17:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfHPGRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:17:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G64Mfd039150;
        Fri, 16 Aug 2019 02:17:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udkpmx8x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 02:17:08 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7G64WS0039836;
        Fri, 16 Aug 2019 02:17:07 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udkpmx8wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 02:17:07 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7G6H6tv001875;
        Fri, 16 Aug 2019 06:17:06 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 2u9nj662h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 06:17:06 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7G6H6cL55116270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 06:17:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1B36112062;
        Fri, 16 Aug 2019 06:17:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2F02112063;
        Fri, 16 Aug 2019 06:17:02 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.23])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 06:17:02 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, chandanrmail@gmail.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, ebiggers@kernel.org,
        jaegeuk@kernel.org, yuchao0@huawei.com, hch@infradead.org
Subject: [PATCH V4 8/8] fscrypt: remove struct fscrypt_ctx
Date:   Fri, 16 Aug 2019 11:48:04 +0530
Message-Id: <20190816061804.14840-9-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190816061804.14840-1-chandan@linux.ibm.com>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160066
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit "fscrypt: remove the 'write' part of struct fscrypt_ctx" reduced
"struct fscrypt_ctx" to be used only for decryption. With "read
callbacks" being integrated into Ext4 and F2FS, we don't use "struct
fscrypt_ctx" anymore. Hence this commit removes the structure and the
associated code.

While at it, this commit also removes definitions of
__fscrypt_decrypt_bio() and fscrypt_decrypt_bio() since we have to now
use the APIs provided by read_callbacks facility.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/crypto/bio.c             | 43 ------------------
 fs/crypto/crypto.c          | 89 +------------------------------------
 fs/crypto/fscrypt_private.h |  3 --
 include/linux/fscrypt.h     | 38 ----------------
 4 files changed, 2 insertions(+), 171 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index b4f47b98ee6d..f65cc3059e5c 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -26,49 +26,6 @@
 #include <linux/namei.h>
 #include "fscrypt_private.h"
 
-static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
-{
-	struct bio_vec *bv;
-	int i;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bv, bio, i, iter_all) {
-		struct page *page = bv->bv_page;
-		int ret = fscrypt_decrypt_pagecache_blocks(page, bv->bv_len,
-							   bv->bv_offset);
-		if (ret)
-			SetPageError(page);
-		else if (done)
-			SetPageUptodate(page);
-		if (done)
-			unlock_page(page);
-	}
-}
-
-void fscrypt_decrypt_bio(struct bio *bio)
-{
-	__fscrypt_decrypt_bio(bio, false);
-}
-EXPORT_SYMBOL(fscrypt_decrypt_bio);
-
-static void completion_pages(struct work_struct *work)
-{
-	struct fscrypt_ctx *ctx = container_of(work, struct fscrypt_ctx, work);
-	struct bio *bio = ctx->bio;
-
-	__fscrypt_decrypt_bio(bio, true);
-	fscrypt_release_ctx(ctx);
-	bio_put(bio);
-}
-
-void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx, struct bio *bio)
-{
-	INIT_WORK(&ctx->work, completion_pages);
-	ctx->bio = bio;
-	fscrypt_enqueue_decrypt_work(&ctx->work);
-}
-EXPORT_SYMBOL(fscrypt_enqueue_decrypt_bio);
-
 int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 				sector_t pblk, unsigned int len)
 {
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index dcf630d7e446..2e5245f5639f 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -31,24 +31,16 @@
 #include "fscrypt_private.h"
 
 static unsigned int num_prealloc_crypto_pages = 32;
-static unsigned int num_prealloc_crypto_ctxs = 128;
 
 module_param(num_prealloc_crypto_pages, uint, 0444);
 MODULE_PARM_DESC(num_prealloc_crypto_pages,
 		"Number of crypto pages to preallocate");
-module_param(num_prealloc_crypto_ctxs, uint, 0444);
-MODULE_PARM_DESC(num_prealloc_crypto_ctxs,
-		"Number of crypto contexts to preallocate");
 
 static mempool_t *fscrypt_bounce_page_pool = NULL;
 
-static LIST_HEAD(fscrypt_free_ctxs);
-static DEFINE_SPINLOCK(fscrypt_ctx_lock);
-
 static struct workqueue_struct *fscrypt_read_workqueue;
 static DEFINE_MUTEX(fscrypt_init_mutex);
 
-static struct kmem_cache *fscrypt_ctx_cachep;
 struct kmem_cache *fscrypt_info_cachep;
 
 void fscrypt_enqueue_decrypt_work(struct work_struct *work)
@@ -57,62 +49,6 @@ void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 }
 EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
 
-/**
- * fscrypt_release_ctx() - Release a decryption context
- * @ctx: The decryption context to release.
- *
- * If the decryption context was allocated from the pre-allocated pool, return
- * it to that pool.  Else, free it.
- */
-void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
-{
-	unsigned long flags;
-
-	if (ctx->flags & FS_CTX_REQUIRES_FREE_ENCRYPT_FL) {
-		kmem_cache_free(fscrypt_ctx_cachep, ctx);
-	} else {
-		spin_lock_irqsave(&fscrypt_ctx_lock, flags);
-		list_add(&ctx->free_list, &fscrypt_free_ctxs);
-		spin_unlock_irqrestore(&fscrypt_ctx_lock, flags);
-	}
-}
-EXPORT_SYMBOL(fscrypt_release_ctx);
-
-/**
- * fscrypt_get_ctx() - Get a decryption context
- * @gfp_flags:   The gfp flag for memory allocation
- *
- * Allocate and initialize a decryption context.
- *
- * Return: A new decryption context on success; an ERR_PTR() otherwise.
- */
-struct fscrypt_ctx *fscrypt_get_ctx(gfp_t gfp_flags)
-{
-	struct fscrypt_ctx *ctx;
-	unsigned long flags;
-
-	/*
-	 * First try getting a ctx from the free list so that we don't have to
-	 * call into the slab allocator.
-	 */
-	spin_lock_irqsave(&fscrypt_ctx_lock, flags);
-	ctx = list_first_entry_or_null(&fscrypt_free_ctxs,
-					struct fscrypt_ctx, free_list);
-	if (ctx)
-		list_del(&ctx->free_list);
-	spin_unlock_irqrestore(&fscrypt_ctx_lock, flags);
-	if (!ctx) {
-		ctx = kmem_cache_zalloc(fscrypt_ctx_cachep, gfp_flags);
-		if (!ctx)
-			return ERR_PTR(-ENOMEM);
-		ctx->flags |= FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
-	} else {
-		ctx->flags &= ~FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
-	}
-	return ctx;
-}
-EXPORT_SYMBOL(fscrypt_get_ctx);
-
 struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags)
 {
 	return mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
@@ -399,11 +335,6 @@ const struct dentry_operations fscrypt_d_ops = {
 
 static void fscrypt_destroy(void)
 {
-	struct fscrypt_ctx *pos, *n;
-
-	list_for_each_entry_safe(pos, n, &fscrypt_free_ctxs, free_list)
-		kmem_cache_free(fscrypt_ctx_cachep, pos);
-	INIT_LIST_HEAD(&fscrypt_free_ctxs);
 	mempool_destroy(fscrypt_bounce_page_pool);
 	fscrypt_bounce_page_pool = NULL;
 }
@@ -419,7 +350,7 @@ static void fscrypt_destroy(void)
  */
 int fscrypt_initialize(unsigned int cop_flags)
 {
-	int i, res = -ENOMEM;
+	int res = -ENOMEM;
 
 	/* No need to allocate a bounce page pool if this FS won't use it. */
 	if (cop_flags & FS_CFLG_OWN_PAGES)
@@ -429,15 +360,6 @@ int fscrypt_initialize(unsigned int cop_flags)
 	if (fscrypt_bounce_page_pool)
 		goto already_initialized;
 
-	for (i = 0; i < num_prealloc_crypto_ctxs; i++) {
-		struct fscrypt_ctx *ctx;
-
-		ctx = kmem_cache_zalloc(fscrypt_ctx_cachep, GFP_NOFS);
-		if (!ctx)
-			goto fail;
-		list_add(&ctx->free_list, &fscrypt_free_ctxs);
-	}
-
 	fscrypt_bounce_page_pool =
 		mempool_create_page_pool(num_prealloc_crypto_pages, 0);
 	if (!fscrypt_bounce_page_pool)
@@ -492,18 +414,12 @@ static int __init fscrypt_init(void)
 	if (!fscrypt_read_workqueue)
 		goto fail;
 
-	fscrypt_ctx_cachep = KMEM_CACHE(fscrypt_ctx, SLAB_RECLAIM_ACCOUNT);
-	if (!fscrypt_ctx_cachep)
-		goto fail_free_queue;
-
 	fscrypt_info_cachep = KMEM_CACHE(fscrypt_info, SLAB_RECLAIM_ACCOUNT);
 	if (!fscrypt_info_cachep)
-		goto fail_free_ctx;
+		goto fail_free_queue;
 
 	return 0;
 
-fail_free_ctx:
-	kmem_cache_destroy(fscrypt_ctx_cachep);
 fail_free_queue:
 	destroy_workqueue(fscrypt_read_workqueue);
 fail:
@@ -520,7 +436,6 @@ static void __exit fscrypt_exit(void)
 
 	if (fscrypt_read_workqueue)
 		destroy_workqueue(fscrypt_read_workqueue);
-	kmem_cache_destroy(fscrypt_ctx_cachep);
 	kmem_cache_destroy(fscrypt_info_cachep);
 
 	fscrypt_essiv_cleanup();
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 8565536feb2b..702403dc7614 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -93,9 +93,6 @@ typedef enum {
 	FS_ENCRYPT,
 } fscrypt_direction_t;
 
-#define FS_CTX_REQUIRES_FREE_ENCRYPT_FL		0x00000001
-#define FS_CTX_HAS_BOUNCE_BUFFER_FL		0x00000002
-
 static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
 					   u32 filenames_mode)
 {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4d6528351f25..ce3b15fd9fba 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -19,7 +19,6 @@
 
 #define FS_CRYPTO_BLOCK_SIZE		16
 
-struct fscrypt_ctx;
 struct fscrypt_info;
 
 struct fscrypt_str {
@@ -63,18 +62,6 @@ struct fscrypt_operations {
 	unsigned int max_namelen;
 };
 
-/* Decryption work */
-struct fscrypt_ctx {
-	union {
-		struct {
-			struct bio *bio;
-			struct work_struct work;
-		};
-		struct list_head free_list;	/* Free list */
-	};
-	u8 flags;				/* Flags */
-};
-
 static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 {
 	/* pairs with cmpxchg_release() in fscrypt_get_encryption_info() */
@@ -101,8 +88,6 @@ static inline void fscrypt_handle_d_move(struct dentry *dentry)
 
 /* crypto.c */
 extern void fscrypt_enqueue_decrypt_work(struct work_struct *);
-extern struct fscrypt_ctx *fscrypt_get_ctx(gfp_t);
-extern void fscrypt_release_ctx(struct fscrypt_ctx *);
 
 extern struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
 						     unsigned int len,
@@ -232,9 +217,6 @@ static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
 }
 
 /* bio.c */
-extern void fscrypt_decrypt_bio(struct bio *);
-extern void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx,
-					struct bio *bio);
 extern int fscrypt_zeroout_range(const struct inode *, pgoff_t, sector_t,
 				 unsigned int);
 
@@ -279,16 +261,6 @@ static inline void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 {
 }
 
-static inline struct fscrypt_ctx *fscrypt_get_ctx(gfp_t gfp_flags)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
-{
-	return;
-}
-
 static inline struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
 							    unsigned int len,
 							    unsigned int offs,
@@ -425,16 +397,6 @@ static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
 	return !memcmp(de_name, fname->disk_name.name, fname->disk_name.len);
 }
 
-/* bio.c */
-static inline void fscrypt_decrypt_bio(struct bio *bio)
-{
-}
-
-static inline void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx,
-					       struct bio *bio)
-{
-}
-
 static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 					sector_t pblk, unsigned int len)
 {
-- 
2.19.1

