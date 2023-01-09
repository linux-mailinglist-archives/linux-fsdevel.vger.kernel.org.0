Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E0A661BB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 02:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjAIBAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 20:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjAIBA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:00:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4D7E0EF;
        Sun,  8 Jan 2023 17:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8Hhb3yO2xt6gqHF5G59d8rKyNf/7Spq2m0uP00f4G2Q=; b=lEOP6YPKYKgnbveh4FVdjua8eT
        RoT2/kNjk9hzN54vMFOnV1u0kvRKVZYiwr7eIdgQSEHxjAqY4+9TobbyPLbHmj0BvoC/SwDM54lnl
        xswvkHBu2aVOqP5NDxaaeYGXXbhUzm2f4WGqJsRoNZa8OGZ/fekp5jnqj4EP7zHhmnPHyrzVsOz7D
        QqzJS0ySiBitbUWwnjDHw5EjniAqk+MTaksab6IiZ9yntc2IGQS9jHxVNqCe+DyUEVgZoVDwCnnTT
        XpDmjqa+iCc9bz94N1/r2YEwNwSQeQua2QWCV9NOQrTSLlTySrNY9HLLQ6VyD8+mzrkPzTyOMl3zz
        DrQjKS5A==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEgWX-00GZgZ-VC; Mon, 09 Jan 2023 01:00:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH] fuse: fix all W=1 kernel-doc warnings
Date:   Sun,  8 Jan 2023 17:00:23 -0800
Message-Id: <20230109010023.20719-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
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

Use correct function name in kernel-doc notation. (1)
Don't use "/**" to begin non-kernel-doc comments. (3)

Fixes these warnings:

fs/fuse/cuse.c:272: warning: expecting prototype for cuse_parse_dev_info(). Prototype was for cuse_parse_devinfo() instead
fs/fuse/dev.c:212: warning: expecting prototype for A new request is available, wake fiq(). Prototype was for fuse_dev_wake_and_unlock() instead
fs/fuse/dir.c:149: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Mark the attributes as stale due to an atime change.  Avoid the invalidate if
fs/fuse/file.c:656: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * In case of short read, the caller sets 'pos' to the position of

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
---
 fs/fuse/cuse.c |    2 +-
 fs/fuse/dev.c  |    2 +-
 fs/fuse/dir.c  |    2 +-
 fs/fuse/file.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -- a/fs/fuse/cuse.c b/fs/fuse/cuse.c
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -256,7 +256,7 @@ static int cuse_parse_one(char **pp, cha
 }
 
 /**
- * cuse_parse_dev_info - parse device info
+ * cuse_parse_devinfo - parse device info
  * @p: device info string
  * @len: length of device info string
  * @devinfo: out parameter for parsed device info
diff -- a/fs/fuse/dev.c b/fs/fuse/dev.c
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -204,7 +204,7 @@ static unsigned int fuse_req_hash(u64 un
 	return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
 }
 
-/**
+/*
  * A new request is available, wake fiq->waitq
  */
 static void fuse_dev_wake_and_unlock(struct fuse_iqueue *fiq)
diff -- a/fs/fuse/dir.c b/fs/fuse/dir.c
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -145,7 +145,7 @@ static void fuse_dir_changed(struct inod
 	inode_maybe_inc_iversion(dir, false);
 }
 
-/**
+/*
  * Mark the attributes as stale due to an atime change.  Avoid the invalidate if
  * atime is not used.
  */
diff -- a/fs/fuse/file.c b/fs/fuse/file.c
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -652,7 +652,7 @@ static ssize_t fuse_get_res_by_io(struct
 	return io->bytes < 0 ? io->size : io->bytes;
 }
 
-/**
+/*
  * In case of short read, the caller sets 'pos' to the position of
  * actual end of fuse request in IO request. Otherwise, if bytes_requested
  * == bytes_transferred or rw == WRITE, the caller sets 'pos' to -1.
