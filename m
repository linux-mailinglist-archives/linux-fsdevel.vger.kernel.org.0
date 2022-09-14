Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA485B86A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 12:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiINKvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiINKvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:51:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E858760F5
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:50:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y136so14533003pfb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mLKoFPsfe1DGX67jxmoOMM6ui+KnXFQNQxxyiB6uJvQ=;
        b=wuB6Y8o7aBM+itTdXuxbD9c9ov2tLG0Re7l2uBZ7YsxJr9YLMuY+rQpmy0KcyxH43B
         CDaMvLmDbhoGhdUma+3KR6N4jNBW9P1Smph3Nh7+cPODdEDuWVJhIRB8YcszkwsUmktU
         n/zWlKad//6cofQRLkqmyjCiTqdiQbw2N2rNXggm6veLySgMwOdc2bYlObleX+Yi2sO/
         DI3gAK7pcEO/vnSPYVqArRxAinRjQI7NvBu02rFPpSvKtpp+9FGVxkrd0fsBGujWd47V
         51qsMnezq/zeoKKoydcDXO7GdsPp7dNIEi9ka0UaRSAt7Mb5LK1bGRVH0njwarepSHyn
         8t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mLKoFPsfe1DGX67jxmoOMM6ui+KnXFQNQxxyiB6uJvQ=;
        b=w4KDbO1kN71SJl12ILk2oja6z1Eq2yn7qf1V4t6gXIhLwLEr+El2sh6MUznCMQ/mwZ
         0avcG4rYr/YfJXxol/DilwVC02sQyx7QXCDlxJE4z8RZsqE9OM2sN54PvmqPgW4pBeCQ
         SgvZKwmJTXNSrylI40H+2xchLqPWxaZIUXYE1gegIYkZi17LQwXkmHDHDQ36MsGCjSyG
         SbD6Z52d9KJ4YpddqO1pk7ekwHeIFNhAzpLhjdMwihrjgeOH34RGE/BM1cgD8WJWraAt
         1zaLSW8TTv87GiYkaLx+ycfnP1EqjIPZ/6cxmUQKYSI9gBMHjFh8FwuN0Ki6opuF4LDa
         P3HQ==
X-Gm-Message-State: ACgBeo1pRyiFo0zfry2KliSFQXMXOS3U5j4piisrSeIYV+CM3pC7QrbF
        kpLPVpKWUBNaioTfc3aERINYyA==
X-Google-Smtp-Source: AA6agR4fp34wrjI43Hdysv4EUHq0KqK4ftDpRUIqIM0HnWzgjWPBkYz+EgLGamHV3dSau08iBdku4Q==
X-Received: by 2002:a63:e305:0:b0:439:6e0c:f81e with SMTP id f5-20020a63e305000000b004396e0cf81emr1144234pgh.50.1663152657977;
        Wed, 14 Sep 2022 03:50:57 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:50:57 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 2/6] erofs: code clean up for fscache
Date:   Wed, 14 Sep 2022 18:50:37 +0800
Message-Id: <20220914105041.42970-3-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220914105041.42970-1-zhujia.zj@bytedance.com>
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some cleanups. No logic changes.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 26 +++++++++++++++-----------
 fs/erofs/internal.h | 17 ++++++++---------
 fs/erofs/super.c    | 22 +++++++++-------------
 3 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8e01d89c3319..4159cf781924 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -417,9 +417,8 @@ const struct address_space_operations erofs_fscache_access_aops = {
 	.readahead = erofs_fscache_readahead,
 };
 
-int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache,
-				  char *name, bool need_inode)
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
@@ -428,7 +427,7 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
 					name, strlen(name), NULL, 0, 0);
@@ -458,8 +457,7 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 		ctx->inode = inode;
 	}
 
-	*fscache = ctx;
-	return 0;
+	return ctx;
 
 err_cookie:
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
@@ -467,13 +465,11 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 	ctx->cookie = NULL;
 err:
 	kfree(ctx);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 {
-	struct erofs_fscache *ctx = *fscache;
-
 	if (!ctx)
 		return;
 
@@ -485,13 +481,13 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 	ctx->inode = NULL;
 
 	kfree(ctx);
-	*fscache = NULL;
 }
 
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct fscache_volume *volume;
+	struct erofs_fscache *fscache;
 	char *name;
 	int ret = 0;
 
@@ -508,6 +504,12 @@ int erofs_fscache_register_fs(struct super_block *sb)
 
 	sbi->volume = volume;
 	kfree(name);
+
+	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
+	if (IS_ERR(fscache))
+		return PTR_ERR(fscache);
+
+	sbi->s_fscache = fscache;
 	return ret;
 }
 
@@ -515,6 +517,8 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
+	erofs_fscache_unregister_cookie(sbi->s_fscache);
 	fscache_relinquish_volume(sbi->volume, NULL, false);
+	sbi->s_fscache = NULL;
 	sbi->volume = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..aa71eb65e965 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -610,27 +610,26 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
-int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache,
-				  char *name, bool need_inode);
-void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode);
+void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
-static inline int erofs_fscache_register_cookie(struct super_block *sb,
-						struct erofs_fscache **fscache,
-						char *name, bool need_inode)
+static inline
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+static inline void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache)
 {
 }
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9716d355a63e..7aa57dcebf31 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -224,10 +224,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			     struct erofs_device_info *dif, erofs_off_t *pos)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
 	struct block_device *bdev;
 	void *ptr;
-	int ret;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
 	if (IS_ERR(ptr))
@@ -245,10 +245,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	}
 
 	if (erofs_is_fscache_mode(sb)) {
-		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
-				dif->path, false);
-		if (ret)
-			return ret;
+		fscache = erofs_fscache_register_cookie(sb, dif->path, false);
+		if (IS_ERR(fscache))
+			return PTR_ERR(fscache);
+		dif->fscache = fscache;
 	} else {
 		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
 					  sb->s_type);
@@ -706,11 +706,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (err)
 			return err;
 
-		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
-						    sbi->opt.fsid, true);
-		if (err)
-			return err;
-
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
@@ -817,7 +812,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	fs_put_dax(dif->dax_dev, NULL);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
-	erofs_fscache_unregister_cookie(&dif->fscache);
+	erofs_fscache_unregister_cookie(dif->fscache);
+	dif->fscache = NULL;
 	kfree(dif->path);
 	kfree(dif);
 	return 0;
@@ -889,7 +885,6 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
 	kfree(sbi);
@@ -909,7 +904,8 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
+	erofs_fscache_unregister_cookie(sbi->s_fscache);
+	sbi->s_fscache = NULL;
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.20.1

