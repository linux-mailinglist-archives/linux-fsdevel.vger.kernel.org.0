Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098845BA8D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiIPJA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 05:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiIPJAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:00:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4B248FF
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 02:00:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l65so20606106pfl.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WujN6b69hBLbBl5JiKiO3Hx91SbLnwPc9Vm4CnthUKc=;
        b=Q9qhc+C3cxqmsergSUYPmPyZAVN8RvRQcUMtaRqmm+ti3YKlXq4I1p7VimdJTka3co
         srzSVu2/D+odNyjDADYNFKbwKuWyoou/cUBuiedsU6EvqvEKslEnJn58RI21x5RGS3X0
         Xt9d7MVvNeKu3s/fUpvpVxRA3jdv8E1YDjGKYBEHC3q1DCrMkjTWLuNMneKraA+NNmiI
         iX7+GNBq4qak7WSGqlkph9VoGNiGwY+WTx/06VU9yrj3YGpS0Cv6jsvNqdZ2LNMUiiQI
         LPeDR3TW6WoZsj+4dBsBzKVPCZqTn/UucimDwYuv6olV2Fm660O2qOGYEWbU5y4eHQ2C
         nwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WujN6b69hBLbBl5JiKiO3Hx91SbLnwPc9Vm4CnthUKc=;
        b=c4Ij4hzDPo2GbNq/cmkRsNHoSt6KdF3JFbE1jFXf8mEtUR88pX2+6Rp0vKknhmKR42
         qGJMtP1WLZN4NwTkRQBmhjvjAy19QJ49VcEmdimTXmlKfb82VhyLemsD00AXi+i+UWYE
         BbAjxyqky9HbfTJ2qQAIHVsl1TRpULjguEyQ437GAIZGa6y1U02KRO4ON5KytOfjmKZn
         cvoGQUr8ITWjSlgfvsHQKCZ5ia8SXKUeCCgCeKnDySGHKFtrZTp7/yvQ8sSg+bwmWhME
         xtzeXUt+pBf+AtQMTR5+QcxXo3LwryJf4lVatKAM3756cGIW/98CbU4OmqiZrsI+JT3+
         j4dQ==
X-Gm-Message-State: ACrzQf0bYFvg8fn7cfwQfOMyr6VnD4LSo8gfHGLGYM45R+O5GqB/DoJK
        4klUJB/FCp79CDtdHdDjoBdLjQ==
X-Google-Smtp-Source: AMsMyM4fX6r4DgmvxpnId0unQj7Wsr4yOfUqSv85lMJocAiEz+a22cM9MKu+XTYkwgbG4sQbMHhe5Q==
X-Received: by 2002:a63:69c7:0:b0:41c:590a:62dc with SMTP id e190-20020a6369c7000000b0041c590a62dcmr3539732pgc.388.1663318809204;
        Fri, 16 Sep 2022 02:00:09 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a450b00b001fd7fe7d369sm970578pjg.54.2022.09.16.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:00:08 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 5/6] erofs: Support sharing cookies in the same domain
Date:   Fri, 16 Sep 2022 16:59:39 +0800
Message-Id: <20220916085940.89392-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220916085940.89392-1-zhujia.zj@bytedance.com>
References: <20220916085940.89392-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Several erofs filesystems can belong to one domain, and data blobs can
be shared among these erofs filesystems of same domain.

Users could specify domain_id mount option to create or join into a
domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 99 ++++++++++++++++++++++++++++++++++++++++++---
 fs/erofs/internal.h |  3 ++
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4a7346b9fa73..d52d3d0ce9af 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -7,6 +7,7 @@
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
+static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
@@ -527,8 +528,8 @@ static int erofs_fscache_register_domain(struct super_block *sb)
 	return err;
 }
 
-struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						     char *name, bool need_inode)
+struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
+						    char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
@@ -577,17 +578,103 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 	return ERR_PTR(ret);
 }
 
-void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
+static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 {
-	if (!ctx)
-		return;
-
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
 	iput(ctx->inode);
+	kfree(ctx->name);
 	kfree(ctx);
 }
 
+static
+struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
+							char *name, bool need_inode)
+{
+	int err;
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_domain *domain = EROFS_SB(sb)->domain;
+
+	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
+	if (IS_ERR(ctx))
+		return ctx;
+
+	ctx->name = kstrdup(name, GFP_KERNEL);
+	if (!ctx->name) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
+	if (!inode) {
+		kfree(ctx->name);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	ctx->domain = domain;
+	ctx->anon_inode = inode;
+	inode->i_private = ctx;
+	refcount_inc(&domain->ref);
+	return ctx;
+out:
+	erofs_fscache_relinquish_cookie(ctx);
+	return ERR_PTR(err);
+}
+
+static
+struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
+						    char *name, bool need_inode)
+{
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_domain *domain = EROFS_SB(sb)->domain;
+	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
+
+	mutex_lock(&erofs_domain_cookies_lock);
+	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
+		ctx = inode->i_private;
+		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
+			continue;
+		igrab(inode);
+		mutex_unlock(&erofs_domain_cookies_lock);
+		return ctx;
+	}
+	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
+	mutex_unlock(&erofs_domain_cookies_lock);
+	return ctx;
+}
+
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
+{
+	if (EROFS_SB(sb)->opt.domain_id)
+		return erofs_domain_register_cookie(sb, name, need_inode);
+	return erofs_fscache_acquire_cookie(sb, name, need_inode);
+}
+
+void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
+{
+	bool drop;
+	struct erofs_domain *domain;
+
+	if (!ctx)
+		return;
+	domain = ctx->domain;
+	if (domain) {
+		mutex_lock(&erofs_domain_cookies_lock);
+		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
+		iput(ctx->anon_inode);
+		mutex_unlock(&erofs_domain_cookies_lock);
+		if (!drop)
+			return;
+	}
+
+	erofs_fscache_relinquish_cookie(ctx);
+	erofs_fscache_domain_put(domain);
+}
+
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	int ret;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 273fb35170e2..0f63830c9056 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -109,6 +109,9 @@ struct erofs_domain {
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
+	struct inode *anon_inode;
+	struct erofs_domain *domain;
+	char *name;
 };
 
 struct erofs_sb_info {
-- 
2.20.1

