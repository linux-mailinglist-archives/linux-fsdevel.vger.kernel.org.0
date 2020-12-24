Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D32E2471
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 06:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLXF25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 00:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgLXF25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 00:28:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA03C061794;
        Wed, 23 Dec 2020 21:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8Qc1ISgNacQk+//eBUSG28G+Kj9xBNwyPmPzmkXKVGY=; b=rEiavNyo9r7H5tmlMFNIfthLLG
        AGf7SbpbTXSMjVi1Wo3mj1Q9vmiB+l2fyNlODBOZiew6Hc1quZWHVRQq3rqyVgGGwRyJIpKCAaVdu
        v/XFve/Gw6D8e+suKuIDA2PHP8XC42CSeZiYG9uyCN/Jmef9572ahBzgzcEaQOrGxtysjSJ8GQKFV
        Xzr5uDjVBSulBTqo17domLr9b++PA2q4rZXejBhzHaQ1hKLv4AOiTKBC5f3L9FCwBupAb2/rbQuPE
        FBJuwrpBK1ktpgyLd7KujlXQ8BjcFMDJE6HR9Y+axbU8EXqq+Vk5g/wkcg0cr9k0ifCa7zelnkGRT
        svG6ZcfA==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksJAc-0005PN-Sr; Thu, 24 Dec 2020 05:28:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: delete repeated words in comments
Date:   Wed, 23 Dec 2020 21:28:10 -0800
Message-Id: <20201224052810.25315-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete duplicate words in fs/*.c.
The doubled words that are being dropped are:
  that, be, the, in, and, for

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/block_dev.c |    2 +-
 fs/dcache.c    |    4 ++--
 fs/direct-io.c |    4 ++--
 fs/exec.c      |    4 ++--
 fs/fhandle.c   |    2 +-
 fs/pipe.c      |    2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

--- linux-next-20201223.orig/fs/block_dev.c
+++ linux-next-20201223/fs/block_dev.c
@@ -1260,7 +1260,7 @@ rescan:
 	return ret;
 }
 /*
- * Only exported for for loop and dasd for historic reasons.  Don't use in new
+ * Only exported for loop and dasd for historic reasons.  Don't use in new
  * code!
  */
 EXPORT_SYMBOL_GPL(bdev_disk_changed);
--- linux-next-20201223.orig/fs/dcache.c
+++ linux-next-20201223/fs/dcache.c
@@ -2150,8 +2150,8 @@ EXPORT_SYMBOL(d_obtain_root);
  * same inode, only the actual correct case is stored in the dcache for
  * case-insensitive filesystems.
  *
- * For a case-insensitive lookup match and if the the case-exact dentry
- * already exists in in the dcache, use it and return it.
+ * For a case-insensitive lookup match and if the case-exact dentry
+ * already exists in the dcache, use it and return it.
  *
  * If no entry exists with the exact case name, allocate new dentry with
  * the exact case, and return the spliced entry.
--- linux-next-20201223.orig/fs/direct-io.c
+++ linux-next-20201223/fs/direct-io.c
@@ -460,7 +460,7 @@ static inline void dio_cleanup(struct di
  * Wait for the next BIO to complete.  Remove it and return it.  NULL is
  * returned once all BIOs have been completed.  This must only be called once
  * all bios have been issued so that dio->refcount can only decrease.  This
- * requires that that the caller hold a reference on the dio.
+ * requires that the caller hold a reference on the dio.
  */
 static struct bio *dio_await_one(struct dio *dio)
 {
@@ -1277,7 +1277,7 @@ do_blockdev_direct_IO(struct kiocb *iocb
 	if (retval == -ENOTBLK) {
 		/*
 		 * The remaining part of the request will be
-		 * be handled by buffered I/O when we return
+		 * handled by buffered I/O when we return
 		 */
 		retval = 0;
 	}
--- linux-next-20201223.orig/fs/exec.c
+++ linux-next-20201223/fs/exec.c
@@ -1454,7 +1454,7 @@ EXPORT_SYMBOL(finalize_exec);
 /*
  * Prepare credentials and lock ->cred_guard_mutex.
  * setup_new_exec() commits the new creds and drops the lock.
- * Or, if exec fails before, free_bprm() should release ->cred and
+ * Or, if exec fails before, free_bprm() should release ->cred
  * and unlock.
  */
 static int prepare_bprm_creds(struct linux_binprm *bprm)
@@ -1837,7 +1837,7 @@ static int bprm_execve(struct linux_binp
 
 out:
 	/*
-	 * If past the point of no return ensure the the code never
+	 * If past the point of no return ensure the code never
 	 * returns to the userspace process.  Use an existing fatal
 	 * signal if present otherwise terminate the process with
 	 * SIGSEGV.
--- linux-next-20201223.orig/fs/fhandle.c
+++ linux-next-20201223/fs/fhandle.c
@@ -173,7 +173,7 @@ static int handle_to_path(int mountdirfd
 
 	/*
 	 * With handle we don't look at the execute bit on the
-	 * the directory. Ideally we would like CAP_DAC_SEARCH.
+	 * directory. Ideally we would like CAP_DAC_SEARCH.
 	 * But we don't have that
 	 */
 	if (!capable(CAP_DAC_READ_SEARCH)) {
--- linux-next-20201223.orig/fs/pipe.c
+++ linux-next-20201223/fs/pipe.c
@@ -171,7 +171,7 @@ EXPORT_SYMBOL(generic_pipe_buf_try_steal
  *
  * Description:
  *	This function grabs an extra reference to @buf. It's used in
- *	in the tee() system call, when we duplicate the buffers in one
+ *	the tee() system call, when we duplicate the buffers in one
  *	pipe into another.
  */
 bool generic_pipe_buf_get(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
