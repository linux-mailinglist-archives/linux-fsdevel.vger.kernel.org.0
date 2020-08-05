Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B4A23C3AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 04:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgHECtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 22:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHECtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:49:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F2C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kmnpOvEulIhRHkhNjjhjDke+7apG/W2Df0BhaWKBT2E=; b=h+xgPPMg5IfjguEazeNX5OBzPn
        5PZENVRNcHx1oqj48O6RkNRsKR4apVuegEjrp2jIedke51o5b9RzVFS2hps/WRmomeZT1McEvQ3Oa
        c28xWtsXnwV/zHP08Pm3pXibifgICHwVL1MPL0K5rsFc9qQ7yu0NmoJwSlMNd2lPz5GAmckH4k8Q/
        iYtYeVL+7bwUuOs2R4zKdp+gAHds81jzZnlSN7f639SNBWgW1Q4ZwAUF/FZL5JFHX99ZTCV7Vv/A8
        gfGX0jvO+VaBKcl6xtk53A0MSOSaadQt2wKxjdrs+Vq4kVbIT6iDTxYxIcaMVQiAW9/wgDDB4so3B
        snkXGKGg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k39Uo-0007WK-OL; Wed, 05 Aug 2020 02:49:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] ubifs: delete duplicated words + other fixes
Date:   Tue,  4 Aug 2020 19:49:35 -0700
Message-Id: <20200805024935.12331-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete repeated words in fs/ubifs/.
{negative, is, of, and, one, it}
where "it it" was changed to "if it".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
---
 fs/ubifs/debug.c    |    2 +-
 fs/ubifs/dir.c      |    2 +-
 fs/ubifs/file.c     |    2 +-
 fs/ubifs/io.c       |    2 +-
 fs/ubifs/replay.c   |    2 +-
 fs/ubifs/tnc.c      |    2 +-
 fs/ubifs/tnc_misc.c |    3 +--
 7 files changed, 7 insertions(+), 8 deletions(-)

--- linux-next-20200804.orig/fs/ubifs/debug.c
+++ linux-next-20200804/fs/ubifs/debug.c
@@ -1012,7 +1012,7 @@ void dbg_save_space_info(struct ubifs_in
  *
  * This function compares current flash space information with the information
  * which was saved when the 'dbg_save_space_info()' function was called.
- * Returns zero if the information has not changed, and %-EINVAL it it has
+ * Returns zero if the information has not changed, and %-EINVAL if it has
  * changed.
  */
 int dbg_check_space_info(struct ubifs_info *c)
--- linux-next-20200804.orig/fs/ubifs/dir.c
+++ linux-next-20200804/fs/ubifs/dir.c
@@ -840,7 +840,7 @@ out_fname:
  *
  * This function checks if directory @dir is empty. Returns zero if the
  * directory is empty, %-ENOTEMPTY if it is not, and other negative error codes
- * in case of of errors.
+ * in case of errors.
  */
 int ubifs_check_dir_empty(struct inode *dir)
 {
--- linux-next-20200804.orig/fs/ubifs/file.c
+++ linux-next-20200804/fs/ubifs/file.c
@@ -205,7 +205,7 @@ static void release_new_page_budget(stru
  * @c: UBIFS file-system description object
  *
  * This is a helper function which releases budget corresponding to the budget
- * of changing one one page of data which already exists on the flash media.
+ * of changing one page of data which already exists on the flash media.
  */
 static void release_existing_page_budget(struct ubifs_info *c)
 {
--- linux-next-20200804.orig/fs/ubifs/io.c
+++ linux-next-20200804/fs/ubifs/io.c
@@ -1046,7 +1046,7 @@ out:
  * @lnum: logical eraseblock number
  * @offs: offset within the logical eraseblock
  *
- * This function reads a node of known type and and length, checks it and
+ * This function reads a node of known type and length, checks it and
  * stores in @buf. Returns zero in case of success, %-EUCLEAN if CRC mismatched
  * and a negative error code in case of failure.
  */
--- linux-next-20200804.orig/fs/ubifs/replay.c
+++ linux-next-20200804/fs/ubifs/replay.c
@@ -574,7 +574,7 @@ static int authenticate_sleb_hash(struct
  * @c: UBIFS file-system description object
  * @sleb: the scan LEB to authenticate
  * @log_hash:
- * @is_last: if true, this is is the last LEB
+ * @is_last: if true, this is the last LEB
  *
  * This function iterates over the buds of a single LEB authenticating all buds
  * with the authentication nodes on this LEB. Authentication nodes are written
--- linux-next-20200804.orig/fs/ubifs/tnc.c
+++ linux-next-20200804/fs/ubifs/tnc.c
@@ -378,7 +378,7 @@ static void lnc_free(struct ubifs_zbranc
  *
  * This function reads a "hashed" node defined by @zbr from the leaf node cache
  * (in it is there) or from the hash media, in which case the node is also
- * added to LNC. Returns zero in case of success or a negative negative error
+ * added to LNC. Returns zero in case of success or a negative error
  * code in case of failure.
  */
 static int tnc_read_hashed_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
--- linux-next-20200804.orig/fs/ubifs/tnc_misc.c
+++ linux-next-20200804/fs/ubifs/tnc_misc.c
@@ -455,8 +455,7 @@ out:
  * @node: node is returned here
  *
  * This function reads a node defined by @zbr from the flash media. Returns
- * zero in case of success or a negative negative error code in case of
- * failure.
+ * zero in case of success or a negative error code in case of failure.
  */
 int ubifs_tnc_read_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 			void *node)
