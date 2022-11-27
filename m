Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C90E639AA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Nov 2022 13:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK0Myd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 07:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiK0Myc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:54:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E8B853;
        Sun, 27 Nov 2022 04:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+/gwq53s+yOrtaDnXOgMDY3qInFEyjZ4Z34ZEF9k31o=; b=DY0Zspi6toRhkvomljYMhIBx4o
        7NBElV2PwaHEU6Z+dPc+7EllibgMbWzMwxJP/D1aBBIkRNBzuqXUYGsV8iAkXkjmD2bk/6yyjUD7k
        0p5EehuHGPrIdLWj6x5egLDK2ArUze9HStyyp9moDMGsWnqoVP8aQaMF6y0Q4iAuWLdsOFs/LfA3U
        NZOshhAlbziAqPvoshg3QZmql5AGiR6nOOl82k0cLj6s3dcR6iUaJb3tieyYF73GB/5rnLvRjiby2
        L8NweRoZGLPKsJZFVO5NqN2f8vNV0zOZAGFGSiotCVBrseXuprx78xJoIormWUPrJuPl8GySJ5sPl
        /qDvceYA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ozHB6-00BbHf-LU; Sun, 27 Nov 2022 12:54:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, qiwuchen55@gmail.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2 v2] fs/namespace.c: fix typos in comment
Date:   Sun, 27 Nov 2022 04:54:24 -0800
Message-Id: <20221127125424.10101-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Fix the typos of correct parameter description.

[v2: Randy] Change one function comment's "dest_dentry" to "dest_mp".

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: qiwuchen55@gmail.com
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/namespace.c |    7 ++++---
 fs/pnode.c     |    4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff -- a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2238,9 +2238,10 @@ int count_mounts(struct mnt_namespace *n
 }
 
 /*
- *  @source_mnt : mount tree to be attached
- *  @nd         : place the mount tree @source_mnt is attached
- *  @parent_nd  : if non-null, detach the source_mnt from its parent and
+ *  @source_mnt : source mount.
+ *  @dest_mnt   : destination mount.
+ *  @dest_mp    : destination mountpoint.
+ *  @moving     : if true, attach source_mnt to dest_mnt and
  *  		   store the parent mount and mountpoint dentry.
  *  		   (done when source_mnt is moved)
  *
diff -- a/fs/pnode.c b/fs/pnode.c
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -274,14 +274,14 @@ static int propagate_one(struct mount *m
 
 /*
  * mount 'source_mnt' under the destination 'dest_mnt' at
- * dentry 'dest_dentry'. And propagate that mount to
+ * dentry 'dest_mp'. And propagate that mount to
  * all the peer and slave mounts of 'dest_mnt'.
  * Link all the new mounts into a propagation tree headed at
  * source_mnt. Also link all the new mounts using ->mnt_list
  * headed at source_mnt's ->mnt_list
  *
  * @dest_mnt: destination mount.
- * @dest_dentry: destination dentry.
+ * @dest_mp: destination mountpoint.
  * @source_mnt: source mount.
  * @tree_list : list of heads of trees to be attached.
  */
