Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20CA47BF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 07:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfIAFx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 01:53:27 -0400
Received: from sonic313-21.consmr.mail.gq1.yahoo.com ([98.137.65.84]:41560
        "EHLO sonic313-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbfIAFx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 01:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567317204; bh=cbLFg2yrWQtoO4qA45rEI4HXSWdaCmb489J65bS2rfc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qruMeycJEBBf5BaHholvlfnh+eiAqmJi9dQ3S5CZNTBEGjuMCfbU4sVyq+3b9c8NoBllmK7WC9PeFxjH+fBRpFzgZujw+P9tlCMYF1imvmohUhCKEmVQTT40WnTQzJJVUTyk84nKUGp27e6Wlc6k9UEKDwnIayMT3yYdYvI23tcq3XrVQ4xwEdvux38WxJnkSO4zSCa923mYJ/4w+MgIhpIQQquskBa6GqvNGOQIV7wFbUdOFPXZSJynw2axuduTM8UCozJUCmr/lsIjGdH+SK38vIfXVUQdwq+OJpMhaZas+U6zhvUwO94vKhBjd82zgn8tOeomtwS1hdz7IreK2w==
X-YMail-OSG: d1lVx30VM1kHkzCpf_8fp5QA2JVSF7jHDZs4YCd9wNyKvoOZew5djhskmRe8w4x
 K3zlEBzMNAvxi_O10iPD4E30xkYEA22jIykpZSNtwED8UQ9IssIz9J6b_tykkiXEE7QBbEfuEZLk
 C7m5Gr56BIIEPUKKXX79_dSN9N0vtOQIdtg7mDKyVwEjXUI.ZJPf0BcYHlGSmiDHJrpObZFkSiOm
 _xEB0tDT5Yh6tki7OtqzLa3pwtP4RK1.rxuj4PREtinHi5nElyYyPNo4452mx.rZRxVYJVcKPtb2
 VC8hyNtEwdsusJtxgHGuZSXqJ692fUlacrgVQEROqzJSw8ACGgyj124mYdYSUiK2tqjQDlckFE9c
 Ty2QC9irzu73.4NFxHdnMdcIoJ1K9LgDwJ2FPGIdU2AtJUPKqqHV.yiCO_dtlFFj6btWG0tHQs8.
 sTO7qQoZQqnrW5wiClfvZ8jiOmqcxpXFDYbxc_0r_VXRvdWBz4h85AeXiMmDqmVu.jUG3UFDCBpY
 XUvadvKgWDvrGMQa_7qvg7Kf6ZLdgfRKvcd6.YR0Q.WneOdquH1WHyGvYU1dexz0tXaIcqPTrKDq
 FT8vtx_jx6dO_wYgqujtF4i1LaqPxTeZ2fiWeKcwTu.MZ6XyhpXIbYPGMmSPS5iuzv5_LrSOwUQb
 LZVs3IIQ6QBC5ghzJ32KR3AgWvzaeGeokQz.WmBjsZhMgsL35RuMvYjeNj_s1oUSPdewvRM0BySA
 eyDqlRg.RgHn18HMz4ca_yzXZUupz0xUufbiE0QrFfh1yNhst0NsU9ZbQlztdigBPJlBwWD9MfGL
 J62kiD_otaArkXA9Xp8xD2Vxb74rubDlAI.8400Bsmf4wmDwr7ciawLcJ4wjAJ4jdm3.cBb1yQCc
 ns4qWTp_d5qAdAz3ImnUdDjil.gIcpcCMRUqlMVsz5t2jb4kTtRvIjW1PdI6aOAZJN4t8xZLOpdZ
 ijSV9FE.Hkmxxe0lp39E.17TIlnwdEw4rOJJHqCzwduLy8ACKvKPK6ZqNvwPhYD0LyqVnDGOPysL
 Myg1ka4PORB.Pi4uiO.0s6cx62jW6MEoZk_I9UR_L_4LQuuAKRDf3psbaOBJ6bkegAM6mTICJj5t
 Fq8ZO9RNYpefdc1aK0yngywjT2LgWk1R3OzH38FSn4dmguP.HNDHfvEwVnOXpKgtq5e2okQIhc2A
 JJHS0VkjTvjlLs9xGBxoCg2ywr7j4FgyTZV31USh4HDiM1WtKWKucPgLExGuOdjhOosbH_LcNdJH
 dUo8FbgBikQFZBiiSKFPKOBYo8F9OjAkfDXc3earO1yppjVmveA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:24 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 426e3b5ec1af9e36f409445c51071a70;
          Sun, 01 Sep 2019 05:53:20 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 18/21] erofs: add "erofs_" prefix for common and short functions
Date:   Sun,  1 Sep 2019 13:51:27 +0800
Message-Id: <20190901055130.30572-19-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

Add erofs_ prefix to free_inode, alloc_inode, ...

Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c         |  6 +++---
 fs/erofs/decompressor.c | 22 +++++++++++-----------
 fs/erofs/inode.c        |  8 ++++----
 fs/erofs/namei.c        | 10 +++++-----
 fs/erofs/super.c        | 26 +++++++++++++-------------
 fs/erofs/zdata.c        | 19 ++++++++++---------
 6 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index d3cd7a453648..e8325eaa0fd8 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -9,7 +9,7 @@
 
 #include <trace/events/erofs.h>
 
-static inline void read_endio(struct bio *bio)
+static void erofs_readendio(struct bio *bio)
 {
 	struct super_block *const sb = bio->bi_private;
 	struct bio_vec *bvec;
@@ -58,7 +58,7 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 		struct bio *bio;
 
 		bio = erofs_grab_bio(sb, REQ_OP_READ | REQ_META,
-				     blkaddr, 1, sb, read_endio);
+				     blkaddr, 1, sb, erofs_readendio);
 
 		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
 			err = -EFAULT;
@@ -260,7 +260,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 			nblocks = BIO_MAX_PAGES;
 
 		bio = erofs_grab_bio(sb, REQ_OP_READ, blknr, nblocks,
-				     sb, read_endio);
+				     sb, erofs_readendio);
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index df349888f911..bb2944c96c89 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -32,8 +32,8 @@ static bool use_vmap;
 module_param(use_vmap, bool, 0444);
 MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");
 
-static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
-				 struct list_head *pagepool)
+static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
+					 struct list_head *pagepool)
 {
 	const unsigned int nr =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -114,7 +114,7 @@ static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
 	return tmp;
 }
 
-static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 {
 	unsigned int inputmargin, inlen;
 	u8 *src;
@@ -187,8 +187,8 @@ static struct z_erofs_decompressor decompressors[] = {
 		.name = "shifted"
 	},
 	[Z_EROFS_COMPRESSION_LZ4] = {
-		.prepare_destpages = lz4_prepare_destpages,
-		.decompress = lz4_decompress,
+		.prepare_destpages = z_erofs_lz4_prepare_destpages,
+		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
 	},
 };
@@ -246,8 +246,8 @@ static void erofs_vunmap(const void *mem, unsigned int count)
 		vunmap(mem);
 }
 
-static int decompress_generic(struct z_erofs_decompress_req *rq,
-			      struct list_head *pagepool)
+static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
+				      struct list_head *pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -307,8 +307,8 @@ static int decompress_generic(struct z_erofs_decompress_req *rq,
 	return ret;
 }
 
-static int shifted_decompress(const struct z_erofs_decompress_req *rq,
-			      struct list_head *pagepool)
+static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
+				     struct list_head *pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -352,7 +352,7 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct list_head *pagepool)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
-		return shifted_decompress(rq, pagepool);
-	return decompress_generic(rq, pagepool);
+		return z_erofs_shifted_transform(rq, pagepool);
+	return z_erofs_decompress_generic(rq, pagepool);
 }
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 6e2486cc3cd4..7da5a41f82e3 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -9,7 +9,7 @@
 #include <trace/events/erofs.h>
 
 /* no locking */
-static int read_inode(struct inode *inode, void *data)
+static int erofs_read_inode(struct inode *inode, void *data)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_inode_v1 *v1 = data;
@@ -158,7 +158,7 @@ static int erofs_fill_symlink(struct inode *inode, void *data,
 	return 0;
 }
 
-static int fill_inode(struct inode *inode, int isdir)
+static int erofs_fill_inode(struct inode *inode, int isdir)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -188,7 +188,7 @@ static int fill_inode(struct inode *inode, int isdir)
 	DBG_BUGON(!PageUptodate(page));
 	data = page_address(page);
 
-	err = read_inode(inode, data + ofs);
+	err = erofs_read_inode(inode, data + ofs);
 	if (!err) {
 		/* setup the new inode */
 		switch (inode->i_mode & S_IFMT) {
@@ -281,7 +281,7 @@ struct inode *erofs_iget(struct super_block *sb,
 
 		vi->nid = nid;
 
-		err = fill_inode(inode, isdir);
+		err = erofs_fill_inode(inode, isdir);
 		if (!err)
 			unlock_new_inode(inode);
 		else {
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index a6b6a4ab1403..108033be8af5 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -14,9 +14,9 @@ struct erofs_qstr {
 };
 
 /* based on the end of qn is accurate and it must have the trailing '\0' */
-static inline int dirnamecmp(const struct erofs_qstr *qn,
-			     const struct erofs_qstr *qd,
-			     unsigned int *matched)
+static inline int erofs_dirnamecmp(const struct erofs_qstr *qn,
+				   const struct erofs_qstr *qd,
+				   unsigned int *matched)
 {
 	unsigned int i = *matched;
 
@@ -71,7 +71,7 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 		};
 
 		/* string comparison without already matched prefix */
-		int ret = dirnamecmp(name, &dname, &matched);
+		int ret = erofs_dirnamecmp(name, &dname, &matched);
 
 		if (!ret) {
 			return de + mid;
@@ -134,7 +134,7 @@ static struct page *find_target_block_classic(struct inode *dir,
 							  EROFS_BLKSIZ);
 
 			/* string comparison without already matched prefix */
-			diff = dirnamecmp(name, &dname, &matched);
+			diff = erofs_dirnamecmp(name, &dname, &matched);
 			kunmap_atomic(de);
 
 			if (!diff) {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b4bf72755300..7bdd9f47c4ac 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -16,12 +16,12 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-static void init_once(void *ptr)
+static void erofs_inode_init_once(void *ptr)
 {
 	inode_init_once(&((struct erofs_inode *)ptr)->vfs_inode);
 }
 
-static struct inode *alloc_inode(struct super_block *sb)
+static struct inode *erofs_alloc_inode(struct super_block *sb)
 {
 	struct erofs_inode *vi =
 		kmem_cache_alloc(erofs_inode_cachep, GFP_KERNEL);
@@ -34,7 +34,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 	return &vi->vfs_inode;
 }
 
-static void free_inode(struct inode *inode)
+static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
@@ -62,7 +62,7 @@ static bool check_layout_compatibility(struct super_block *sb,
 	return true;
 }
 
-static int superblock_read(struct super_block *sb)
+static int erofs_read_superblock(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 	struct buffer_head *bh;
@@ -217,7 +217,7 @@ static int erofs_build_cache_strategy(struct erofs_sb_info *sbi,
 #endif
 
 /* set up default EROFS parameters */
-static void default_options(struct erofs_sb_info *sbi)
+static void erofs_default_options(struct erofs_sb_info *sbi)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
 	sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
@@ -251,7 +251,7 @@ static match_table_t erofs_tokens = {
 	{Opt_err, NULL}
 };
 
-static int parse_options(struct super_block *sb, char *options)
+static int erofs_parse_options(struct super_block *sb, char *options)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *p;
@@ -395,7 +395,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbi;
-	err = superblock_read(sb);
+	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
 
@@ -409,9 +409,9 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = erofs_xattr_handlers;
 #endif
 	/* set erofs default mount options */
-	default_options(sbi);
+	erofs_default_options(sbi);
 
-	err = parse_options(sb, data);
+	err = erofs_parse_options(sb, data);
 	if (err)
 		return err;
 
@@ -511,7 +511,7 @@ static int __init erofs_module_init(void)
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
 					       sizeof(struct erofs_inode), 0,
 					       SLAB_RECLAIM_ACCOUNT,
-					       init_once);
+					       erofs_inode_init_once);
 	if (!erofs_inode_cachep) {
 		err = -ENOMEM;
 		goto icache_err;
@@ -618,7 +618,7 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 	int err;
 
 	DBG_BUGON(!sb_rdonly(sb));
-	err = parse_options(sb, data);
+	err = erofs_parse_options(sb, data);
 	if (err)
 		goto out;
 
@@ -638,8 +638,8 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 
 const struct super_operations erofs_sops = {
 	.put_super = erofs_put_super,
-	.alloc_inode = alloc_inode,
-	.free_inode = free_inode,
+	.alloc_inode = erofs_alloc_inode,
+	.free_inode = erofs_free_inode,
 	.statfs = erofs_statfs,
 	.show_options = erofs_show_options,
 	.remount_fs = erofs_remount,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ce1a0f2997a9..3af040c608f1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -40,7 +40,7 @@ void z_erofs_exit_zip_subsystem(void)
 	kmem_cache_destroy(pcluster_cachep);
 }
 
-static inline int init_unzip_workqueue(void)
+static inline int z_erofs_init_workqueue(void)
 {
 	const unsigned int onlinecpus = num_possible_cpus();
 	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
@@ -54,7 +54,7 @@ static inline int init_unzip_workqueue(void)
 	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
 
-static void init_once(void *ptr)
+static void z_erofs_pcluster_init_once(void *ptr)
 {
 	struct z_erofs_pcluster *pcl = ptr;
 	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
@@ -67,7 +67,7 @@ static void init_once(void *ptr)
 		pcl->compressed_pages[i] = NULL;
 }
 
-static void init_always(struct z_erofs_pcluster *pcl)
+static void z_erofs_pcluster_init_always(struct z_erofs_pcluster *pcl)
 {
 	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
 
@@ -81,9 +81,10 @@ int __init z_erofs_init_zip_subsystem(void)
 {
 	pcluster_cachep = kmem_cache_create("erofs_compress",
 					    Z_EROFS_WORKGROUP_SIZE, 0,
-					    SLAB_RECLAIM_ACCOUNT, init_once);
+					    SLAB_RECLAIM_ACCOUNT,
+					    z_erofs_pcluster_init_once);
 	if (pcluster_cachep) {
-		if (!init_unzip_workqueue())
+		if (!z_erofs_init_workqueue())
 			return 0;
 
 		kmem_cache_destroy(pcluster_cachep);
@@ -272,8 +273,8 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 }
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
-static inline bool try_inplace_io(struct z_erofs_collector *clt,
-				  struct page *page)
+static inline bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
+					  struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = clt->pcl;
 	const unsigned int clusterpages = BIT(pcl->clusterbits);
@@ -296,7 +297,7 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
 	/* give priority for inplaceio */
 	if (clt->mode >= COLLECT_PRIMARY &&
 	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
-	    try_inplace_io(clt, page))
+	    z_erofs_try_inplace_io(clt, page))
 		return 0;
 
 	ret = z_erofs_pagevec_enqueue(&clt->vector,
@@ -409,7 +410,7 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 	if (!pcl)
 		return ERR_PTR(-ENOMEM);
 
-	init_always(pcl);
+	z_erofs_pcluster_init_always(pcl);
 	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 
 	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
-- 
2.17.1

