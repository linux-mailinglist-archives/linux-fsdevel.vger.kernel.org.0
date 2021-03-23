Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E4345807
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 07:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCWGxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 02:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCWGwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:52:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E58DC061574;
        Mon, 22 Mar 2021 23:52:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id n11so10717609pgm.12;
        Mon, 22 Mar 2021 23:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4BJC7S/OHZH6r8G1p6h+vG5igR/AXMYKIeleYipdgog=;
        b=Jmf0RegJqP2Pv3A4c4aF0/gmSf6+6HrlFHRVTSSUrghVF9nCaINxndubGsMjua+9jx
         nVNN+74OAbU6Zq5NwuVqMNylj12C8z07gbNj3qGIBk+zo3WSvBvN4+MsetAWQPqTLwAR
         jyZB4TsbmqkKMmqev9FTBFQ7uJrk/4yMYTXzWJYN1upgrZ25BlYgNynx+CX+A4dn+W7o
         9+Z/ihGuQcb9pa7X9u8LNQQkO3alkdBaFgOmvIUkZR5LO2aDbhbF20GFe7hFctDkqYLZ
         qa5m1tzZIZNbszlfmjSqM5JI6BIYB4PWQTf+BXADLazyiEOO7K6G8igQhTLes1QbTXt3
         CE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4BJC7S/OHZH6r8G1p6h+vG5igR/AXMYKIeleYipdgog=;
        b=NaV+VsOu4amCwlUiE7oqpmU8lD1WKcQe8ubiP5jl/rUWivg++9Jj24A4gLVI4QNi1v
         nzkupYThspvHra1sPeVggl5JZRLy4w3wPPLPgBKvUpv4mq+r2QreSqdCeb1qK8kNrYZ5
         8AbCDVVaFgDKuc6XrdYFXG+ZM629f7HwAZ1HoiUm2aOb89v5d3RchXX3F7/KmfY+h1Qf
         V9ug4pSRpOludO/SSkY5YWN9GdLRRqp4XX1IkGkz4JocfCOgZsCsIwY9ra6GHyNRwchs
         abrD3HWN/TPdWUHqGHsp6QcZU+CwxSgVpFuNafMMbYieM8gKGIJ3nP6vQhH714S+BCM1
         tCKw==
X-Gm-Message-State: AOAM532J4owVdGSQ5BUV2rJhTr2S3TyZT9ISFypXOZQsROxPnW1wXA2L
        NXCCtHghcWTz8Gk221Pz8/R8GH7IryAbzw==
X-Google-Smtp-Source: ABdhPJz8QAYoWG6wxn4mYky+RduES+d7sjpyy67TiBiUF7887q1MlGQU4J6U81nMYI4WCALE38vWdQ==
X-Received: by 2002:aa7:92cb:0:b029:1f1:542f:2b2b with SMTP id k11-20020aa792cb0000b02901f1542f2b2bmr3454382pfa.31.1616482365799;
        Mon, 22 Mar 2021 23:52:45 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id o9sm16633654pfh.47.2021.03.22.23.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 23:52:45 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
X-Google-Original-From: Xiaofeng Cao <caoxiaofeng@yulong.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH v2] fs/dcache: fix typos and sentence disorder
Date:   Tue, 23 Mar 2021 14:52:45 +0800
Message-Id: <20210323065245.15083-1-caoxiaofeng@yulong.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

change 'sould' to 'should'
change 'colocated' to 'co-located'
change 'talke' to 'take'
reorganize sentence

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
v2:change 'colocated' to 'co-located' instead of 'collocated'
 fs/dcache.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7d24ff7eb206..c23834334314 100644
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
+	// ->i_dentry and ->i_rcu are co-located, but the latter won't be
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

