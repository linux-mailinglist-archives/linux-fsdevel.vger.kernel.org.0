Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0E3407E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhCROcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhCROb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:31:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED49CC06174A;
        Thu, 18 Mar 2021 07:31:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k4so1394876plk.5;
        Thu, 18 Mar 2021 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nR83JA4b5HB5bOQRjKcdlvfRl/xxpZygi7T8aV5A6LE=;
        b=AHQ8xDkXbGTG01WcTU2JkX2eQcjwwDt6XMo3ENY3ygLd8xXK3wl7SrwkcVaC9fzXfr
         RqunxnshDJ9x8LB6rJlmUbtY2WaKVDg12XkxGKAbW+MHN7/WdJNLmb8rTdpQKm9VMYBc
         mnh/VtfYY0j0w6x5W+GW3jjelOQkc6Z1E6NkgdCaKez8dRaObJlOQgpdpSzqxZ+afB2F
         heyODydj+Ntk6xeMwBt4tiHJhiFAFenwVtS5OWFPJ9qehNIMCNm3U4ZxgUZ0E24TaIMU
         CqpGtrfcXwceNP/S3B+eAwET8skFxHYBidwJSb99Ky5I0jgLCpT0PUluFGbEmX8+Jmc8
         S+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nR83JA4b5HB5bOQRjKcdlvfRl/xxpZygi7T8aV5A6LE=;
        b=egydzy10YLHutx26Sf57ncMkR6uhLI0Qk7b0zrwfrYNfSzhDvgq8f6CUVz3JArk8rl
         QQsQ6VKWFd+/d27ldCWG+h7TNOoE6z26uaR00rdfLEFGZ6/zy0X1ViZbyUaw8nU4G+h8
         YTN7JA0gjRFZMbxIbXXE49nJageP/8HIeErBc0REJ9U2/evcIBg+NG4Tq8GPelFZwGqA
         t6VnQe/KHefYTLF3sG7dTaOoJmdjCu0qS9BX1gTs7xhxPDFLlbcLbWO6DOW+wduBBMZl
         KnYfmlaLhtuqRpBFe9hJckyt9dBO875PirZh8uXOgpKn/ABkVFsiLAn8gRoOddtlAxom
         EnWQ==
X-Gm-Message-State: AOAM533thY8DnNcDpHPDqtsiSkMakF7enpk4D65Q2fxFLZSm15oATYgT
        rexu6T7WaVoMjgyGrRLpP7RDW238H3fsGQ==
X-Google-Smtp-Source: ABdhPJwGsYoRYYunnE/ubzWh74dGQCPIG2yueitlRNavJmalQVkEXzYnKrgNQFHSphloVxNqum+Pmg==
X-Received: by 2002:a17:90a:7f87:: with SMTP id m7mr4588416pjl.64.1616077915484;
        Thu, 18 Mar 2021 07:31:55 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id x19sm2838254pfc.152.2021.03.18.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 07:31:55 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
X-Google-Original-From: Xiaofeng Cao <caoxiaofeng@yulong.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] fs/dcache: fix typos and sentence disorder
Date:   Thu, 18 Mar 2021 22:31:53 +0800
Message-Id: <20210318143153.13455-1-caoxiaofeng@yulong.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

change 'sould' to 'should'
change 'colocated' to 'collocated'
change 'talke' to 'take'
reorganize sentence

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 fs/dcache.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7d24ff7eb206..99a58676f478 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -741,7 +741,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	unsigned int d_flags;
 
 	/*
-	 * If we have a d_op->d_delete() operation, we sould not
+	 * If we have a d_op->d_delete() operation, we should not
 	 * let the dentry count go to zero, so use "put_or_lock".
 	 */
 	if (unlikely(dentry->d_flags & DCACHE_OP_DELETE))
@@ -1053,7 +1053,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	struct dentry *de = NULL;
 
 	spin_lock(&inode->i_lock);
-	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
+	// ->i_dentry and ->i_rcu are collocated, but the latter won't be
 	// used without having I_FREEING set, which means no aliases left
 	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
 		if (S_ISDIR(inode->i_mode)) {
@@ -1297,7 +1297,7 @@ void shrink_dcache_sb(struct super_block *sb)
 EXPORT_SYMBOL(shrink_dcache_sb);
 
 /**
- * enum d_walk_ret - action to talke during tree walk
+ * enum d_walk_ret - action to take during tree walk
  * @D_WALK_CONTINUE:	contrinue walk
  * @D_WALK_QUIT:	quit walk
  * @D_WALK_NORETRY:	quit when retry is needed
@@ -2156,8 +2156,8 @@ EXPORT_SYMBOL(d_obtain_alias);
  *
  * On successful return, the reference to the inode has been transferred
  * to the dentry.  In case of an error the reference on the inode is
- * released.  A %NULL or IS_ERR inode may be passed in and will be the
- * error will be propagate to the return value, with a %NULL @inode
+ * released.  A %NULL or IS_ERR inode may be passed in and the error will
+ * be propagated to the return value, with a %NULL @inode
  * replaced by ERR_PTR(-ESTALE).
  */
 struct dentry *d_obtain_root(struct inode *inode)
-- 
2.25.1

