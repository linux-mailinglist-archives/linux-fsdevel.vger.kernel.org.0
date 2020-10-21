Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9F294ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 11:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441593AbgJUJzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441589AbgJUJzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:55:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EABC0613CE;
        Wed, 21 Oct 2020 02:55:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hk7so879946pjb.2;
        Wed, 21 Oct 2020 02:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xvsCC2mBKT4ppcZJ4GK5YKV7EITC8GNqyfDyTOioyI=;
        b=pmfiT6oh2bHuSADiyOLDDks78cTk7QHi2EI5fq9k/Pe01OyezNU2yH33NoxKkinL+l
         Zos1wo6pLDd9mr8H6g7fLo8R8AGkzqbOuWtdQAa9OXq3joEHn38Qzex61tB40oTsQcx/
         kySSqgmDmtPDiLr6irnSNyGPjR3UJOwFFCgVmPsc+pD1HNKV86ZDHa0tGm/qiti5JYGk
         Hy1gY6GncSsBL7gGIsQnpGKURipQLijX1uZnaoosHNR4shbKbGBYaqfqa3o/svaULUjf
         Q5GrM3XaQAtUnMK6apIQJrRlUCG6jb3TO7GRJSsG6vffTDqp2RrjXoUvcPwS3ZQE0UED
         DTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xvsCC2mBKT4ppcZJ4GK5YKV7EITC8GNqyfDyTOioyI=;
        b=jOGEl85ohhzUyYdeP0iHnBrFqXgiU0bjBPaeA0r93DPvhS3Os7Fyd0SbkUp5h6i5yP
         kRvza9Sv5orian8n3dEIkx+spE7/kGp7UgYYgkeyu2i973vtPcCuX+ZOE0xlZNdjz5tn
         5K4LHiUyv/uNMZ0n02C+1af57H3JCMErF6KzdwtwD3yYYVQtYPzk1u9mO/cxp0ZbIy5w
         7DXp0IzWiftzoX2nDCwCLDCDSuoYZspnajoP+c43+WT6kFa6IBe/Dm4MHweOL32ypbhQ
         d4imAyyQfw9p1NFihY22eMiYHgM9zPNE7NDVcgINT5u9Goi2xXKR3wA7fE9Joz/FuuYt
         DXiw==
X-Gm-Message-State: AOAM5309I0zZTdvwevmga4vdmvcYr8A598VwatMoFfbDKKNvWRX34o2L
        Ym4DAZMUNrGMm0sgdAgVHY4=
X-Google-Smtp-Source: ABdhPJyhYswSXJeohbalULZv+UeobqcRJjTOt+P7VKb7A5oTSmH9ZHqCbmMfjvXwdutBXLcVfaaM7Q==
X-Received: by 2002:a17:90a:9d83:: with SMTP id k3mr2525977pjp.5.1603274151933;
        Wed, 21 Oct 2020 02:55:51 -0700 (PDT)
Received: from dc803.localdomain (FL1-133-208-230-116.hyg.mesh.ad.jp. [133.208.230.116])
        by smtp.gmail.com with ESMTPSA id q81sm1901786pfc.36.2020.10.21.02.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 02:55:51 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] exfat: simplify exfat_hint_femp structure
Date:   Wed, 21 Oct 2020 18:55:44 +0900
Message-Id: <20201021095545.9208-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The hint provided by exfat_hint_femp is that the cluster number is enough,
so replace exfat_chain with the cluster number.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c      |  3 +--
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/namei.c    | 19 ++++++-------------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ff809239a540..2e68796750b0 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -978,8 +978,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 				num_empty++;
 				if (candi_empty.eidx == EXFAT_HINT_NONE &&
 						num_empty == 1) {
-					exfat_chain_set(&candi_empty.cur,
-						clu.dir, clu.size, clu.flags);
+					candi_empty.clu = clu.dir;
 				}
 
 				if (candi_empty.eidx == EXFAT_HINT_NONE &&
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f1402fed3302..28330804f9c9 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -153,7 +153,7 @@ struct exfat_hint_femp {
 	/* count of continuous empty entry */
 	int count;
 	/* the cluster that first empty slot exists in */
-	struct exfat_chain cur;
+	unsigned int clu;
 };
 
 /* hint structure */
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 54f54624d7e5..cfe11b368122 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -202,10 +202,10 @@ static int exfat_search_empty_slot(struct super_block *sb,
 		struct exfat_hint_femp *hint_femp, struct exfat_chain *p_dir,
 		int num_entries)
 {
-	int i, dentry, num_empty = 0;
+	int i, dentry = 0, num_empty = 0;
 	int dentries_per_clu;
 	unsigned int type;
-	struct exfat_chain clu;
+	struct exfat_chain clu = *p_dir;
 	struct exfat_dentry *ep;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct buffer_head *bh;
@@ -218,11 +218,8 @@ static int exfat_search_empty_slot(struct super_block *sb,
 			hint_femp->eidx = EXFAT_HINT_NONE;
 			return dentry;
 		}
-
-		exfat_chain_dup(&clu, &hint_femp->cur);
-	} else {
-		exfat_chain_dup(&clu, p_dir);
-		dentry = 0;
+		clu.dir = hint_femp->clu;
+		clu.size -= EXFAT_B_TO_CLU(dentry * DENTRY_SIZE, sbi);
 	}
 
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
@@ -240,8 +237,7 @@ static int exfat_search_empty_slot(struct super_block *sb,
 				if (hint_femp->eidx == EXFAT_HINT_NONE) {
 					hint_femp->eidx = dentry;
 					hint_femp->count = CNT_UNUSED_NOHIT;
-					exfat_chain_set(&hint_femp->cur,
-						clu.dir, clu.size, clu.flags);
+					hint_femp->clu = clu.dir;
 				}
 
 				if (type == TYPE_UNUSED &&
@@ -354,7 +350,6 @@ static int exfat_find_empty_entry(struct inode *inode,
 			 */
 			exfat_chain_cont_cluster(sb, p_dir->dir, p_dir->size);
 			p_dir->flags = ALLOC_FAT_CHAIN;
-			hint_femp.cur.flags = ALLOC_FAT_CHAIN;
 		}
 
 		if (clu.flags == ALLOC_FAT_CHAIN)
@@ -367,10 +362,8 @@ static int exfat_find_empty_entry(struct inode *inode,
 			 */
 			hint_femp.eidx = EXFAT_B_TO_DEN_IDX(p_dir->size, sbi);
 			hint_femp.count = sbi->dentries_per_clu;
-
-			exfat_chain_set(&hint_femp.cur, clu.dir, 0, clu.flags);
+			hint_femp.clu = clu.dir;
 		}
-		hint_femp.cur.size++;
 		p_dir->size++;
 		size = EXFAT_CLU_TO_B(p_dir->size, sbi);
 
-- 
2.25.1

