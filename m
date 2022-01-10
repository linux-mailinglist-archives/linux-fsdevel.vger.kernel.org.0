Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF7B48A401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 00:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbiAJXw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 18:52:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60484 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242630AbiAJXw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:52:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF7CAB8182C;
        Mon, 10 Jan 2022 23:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664DFC36AE9;
        Mon, 10 Jan 2022 23:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641858773;
        bh=4VvzZMtfRjogNATVuly7HCr4bU/KjXd//JPKVpmM4iI=;
        h=From:To:Cc:Subject:Date:From;
        b=PhOJdb/BbbetmhvRZ8YfkUuHc91RnIu3ITcVX1WlCaW9qc9hrsvuAco5XA6y86sXV
         OwcvK9SdD4r+guOkuSSE4TIAPF4/qrfkoN/dmJmGbdY0/mAPD3UuvOZn4s7/3k5xmc
         1CilNEeSwYRsioZWBfo6V0VGA45oaVFjCVI1uNxZKuWQRvYS8LRW/wCfKcjVwfDJly
         9pszTO4GCse8ddhehZeYy5XRA51kSzfcIU08rSVU/7BPax44dYRKnnivW8UzlY2pPt
         udGBYB1i/bOPwS+QI0lYfV2DLI0PkVpNwl/Q4p4KicAzLUXe9gUDbTgDLgQmsYzSLK
         lcSYw2/CboAXA==
From:   Jeff Layton <jlayton@kernel.org>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: move FUSE_SUPER_MAGIC definition to magic.h
Date:   Mon, 10 Jan 2022 18:52:52 -0500
Message-Id: <20220110235252.138931-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...to help userland apps that need to identify FUSE mounts.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/inode.c            | 3 +--
 include/uapi/linux/magic.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8b89e3ba7df3..672793e163a5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,7 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <uapi/linux/magic.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
@@ -50,8 +51,6 @@ MODULE_PARM_DESC(max_user_congthresh,
  "Global limit for the maximum congestion threshold an "
  "unprivileged user can set");
 
-#define FUSE_SUPER_MAGIC 0x65735546
-
 #define FUSE_DEFAULT_BLKSIZE 512
 
 /** Maximum number of outstanding background requests */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 53a3c20394cf..a3034558b018 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -36,6 +36,7 @@
 #define EFIVARFS_MAGIC		0xde5e81e4
 #define HOSTFS_SUPER_MAGIC	0x00c0ffee
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
+#define FUSE_SUPER_MAGIC	0x65735546
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.34.1

