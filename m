Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93B94B5956
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347420AbiBNSH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 13:07:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiBNSH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:07:27 -0500
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 10:07:17 PST
Received: from agrajag.zerfleddert.de (agrajag.zerfleddert.de [88.198.237.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60AB60D9A;
        Mon, 14 Feb 2022 10:07:17 -0800 (PST)
Received: by agrajag.zerfleddert.de (Postfix, from userid 1000)
        id 65B9C5B203F1; Mon, 14 Feb 2022 18:57:12 +0100 (CET)
Date:   Mon, 14 Feb 2022 18:57:12 +0100
From:   Tobias Jordan <kernel@cdqe.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org
Subject: [PATCH] inode: fix comment for find_inode_by_ino_rcu
Message-ID: <YgqX+MMIhe8g6XC9@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix obvious copy-and-paste relics in comment for find_inode_by_ino_rcu.

Fixes: 3f19b2ab97a9 ("vfs, afs, ext4: Make the inode hash table RCU searchable")

Signed-off-by: Tobias Jordan <kernel@cdqe.de>
---
 fs/inode.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 63324df6fa27..c297d57ee9c7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1587,19 +1587,11 @@ EXPORT_SYMBOL(find_inode_rcu);
  * find_inode_by_ino_rcu - Find an inode in the inode cache
  * @sb:		Super block of file system to search
  * @ino:	The inode number to match
  *
- * Search for the inode specified by @hashval and @data in the inode cache,
- * where the helper function @test will return 0 if the inode does not match
- * and 1 if it does.  The @test function must be responsible for taking the
- * i_lock spin_lock and checking i_state for an inode being freed or being
- * initialized.
+ * Search for the inode specified by @ino in the inode cache.
  *
- * If successful, this will return the inode for which the @test function
- * returned 1 and NULL otherwise.
- *
- * The @test function is not permitted to take a ref on any inode presented.
- * It is also not permitted to sleep.
+ * If successful, this will return the inode, NULL otherwise.
  *
  * The caller must hold the RCU read lock.
  */
 struct inode *find_inode_by_ino_rcu(struct super_block *sb,
-- 
2.30.2

