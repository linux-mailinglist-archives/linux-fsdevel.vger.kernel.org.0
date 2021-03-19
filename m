Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD93411D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 01:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhCSA4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 20:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhCSA4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:56:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1571C06174A;
        Thu, 18 Mar 2021 17:56:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 94so5632407qtc.0;
        Thu, 18 Mar 2021 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/qfLSyLd0K9YGBbsrkX6y/zxovsImFNR4VD6QZeGkI=;
        b=RYUQcQDTiHBQersdyIlqcOM22jD3MwhlaHLHXE9hrTJE6c1kFSKKvc5Fkn4tSFXLQx
         AUmfGyPoKIzzWzXJCgdl8Kj53WVKI4NETi5Sh4x7wB9nTcoszT6oLEI0hLi6dsfTKY0x
         OMd5kK5zqqusQVSOqx6OOVRwkIPXVAJhv6GgI5dD5BwzbOEAIpaEDxBkGHk58YT4z2N3
         vAyRFQss/db0CVMuCuoKJB5AO73DhZWxvUaLbilCcWgsYRds2iQ+mz5ERgmhagcRPyse
         txoFDHFk38wF2HOT912T3+mKRXiK/pQBDqlIgkjlaSQKL2B+CGic6sP0WzTm8y+tYGED
         M5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/qfLSyLd0K9YGBbsrkX6y/zxovsImFNR4VD6QZeGkI=;
        b=rO1aX6XL2ktURYIIWwrVKB1LQ0jOwmN5Vjg5YroRWDUiC4pHxkzcDd+tgtwfLDcYZz
         2xnld46ZbeyvAaPTgr4CFiSutw/iczSlg4x0mPE9Vr2KPkrnUL6W3N5oUk4ybqY7Jg5D
         WmG0/zV2E5lvE0RukRr9pj/utDIM24ht7OdXE3RU2FD2HQmyWnJT/2im2qun8bI4tdVw
         BRxzuJzd3F0TWqY8c/M6Zo6BtB8ezvw+bd+C01Lk7zUMRevogBiY3GZ+a24KAhNQgaK7
         1yM4E3jZqnCEqYoxmOVgvOpILZM6E4vd/CM/B7a8oHM5m62akp4SquSgBa+MS4qbAYzy
         eYEA==
X-Gm-Message-State: AOAM533lHitFen4mw9o95vtnZ8yT6q9EQ6lekB5eCMbdM9zCZJVy+oUq
        JXn2EhF0qsev1ncJ0RP1WSpLILxpji5FG3kQ
X-Google-Smtp-Source: ABdhPJxq4i7nB2mxLIjfC82G/X3cc5MA28UM+DRIRDZEtfKdckVKadT8wpQdDhlgnA71DceRfA5sew==
X-Received: by 2002:a05:622a:253:: with SMTP id c19mr6276095qtx.355.1616115362720;
        Thu, 18 Mar 2021 17:56:02 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id j6sm3205216qkm.81.2021.03.18.17.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:56:02 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] fs/inode.c: Fix a rudimentary typo
Date:   Fri, 19 Mar 2021 06:23:42 +0530
Message-Id: <20210319005342.23795-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

s/funtion/function/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index a047ab306f9a..38c2e6b58dc4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1423,7 +1423,7 @@ EXPORT_SYMBOL(ilookup);
  * function must never block --- find_inode() can block in
  * __wait_on_freeing_inode() --- or when the caller can not increment
  * the reference count because the resulting iput() might cause an
- * inode eviction.  The tradeoff is that the @match funtion must be
+ * inode eviction.  The tradeoff is that the @match function must be
  * very carefully implemented.
  */
 struct inode *find_inode_nowait(struct super_block *sb,
--
2.26.2

