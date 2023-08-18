Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCD781424
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379909AbjHRUKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 16:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379908AbjHRUKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:10:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9C53C06;
        Fri, 18 Aug 2023 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=60RGfnzVkWZGcy2faovMqvZTGSsR1zPLBMJDqq61rqk=; b=WHyarD/3+eUz+uGtPzU/G057Mx
        xWCvrnWRY1cj1s5n3HJU8qd6/0ptwHW+/JB8qQ7WUEBPMCRSgmvQAZS7J9q1mXdJCCqXUHCC/bgQA
        AIw2Qajo7xbtlNXEpXTyWOVCvAdv7rQM9SGq0+EIpJ629cI6KkyisCVv8Ko1+baL6pBNULFsKf8/E
        Ti4e6lNdwlj+duuEjnrsKW36aboknozxKXxkKVs+LvAAgRrLq8iEoCTneaDbPn6gnI5gQ7QZGee6M
        ZbonTEEZK/6N4wwAzxps0sHoC17+ytg7CFtMwFw5fSEhsEkfD3saq5V+Jycd4bFHrfdeHpbKHglLX
        XrhiXx6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5nI-00BPfN-Rs; Fri, 18 Aug 2023 20:10:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-docs@vger.kernel.org
Subject: [PATCH] devpts: Fix kernel-doc warnings
Date:   Fri, 18 Aug 2023 21:10:03 +0100
Message-Id: <20230818201003.2720257-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This documentation has bit-rotted over time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/devpts/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 5ede89880911..299c295a27a0 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -534,12 +534,12 @@ void devpts_kill_index(struct pts_fs_info *fsi, int idx)
 
 /**
  * devpts_pty_new -- create a new inode in /dev/pts/
- * @ptmx_inode: inode of the master
- * @device: major+minor of the node to be created
+ * @fsi: Filesystem info for this instance.
  * @index: used as a name of the node
  * @priv: what's given back by devpts_get_priv
  *
- * The created inode is returned. Remove it from /dev/pts/ by devpts_pty_kill.
+ * The dentry for the created inode is returned.
+ * Remove it from /dev/pts/ with devpts_pty_kill().
  */
 struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 {
@@ -580,7 +580,7 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 
 /**
  * devpts_get_priv -- get private data for a slave
- * @pts_inode: inode of the slave
+ * @dentry: dentry of the slave
  *
  * Returns whatever was passed as priv in devpts_pty_new for a given inode.
  */
@@ -593,7 +593,7 @@ void *devpts_get_priv(struct dentry *dentry)
 
 /**
  * devpts_pty_kill -- remove inode form /dev/pts/
- * @inode: inode of the slave to be removed
+ * @dentry: dentry of the slave to be removed
  *
  * This is an inverse operation of devpts_pty_new.
  */
-- 
2.40.1

