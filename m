Return-Path: <linux-fsdevel+bounces-46711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F06A94250
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C412A1890746
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479391AF0C8;
	Sat, 19 Apr 2025 08:36:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9881FB3;
	Sat, 19 Apr 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051799; cv=none; b=XN2iKgABBud3JoWE3vxDPY5ULxy562T8SQIpQtwQEYjzl87/i58kfIDwj22NlNVn2+01j1nFUZWQaHS22iQa/s1KSmKGEMhNYYLVfEWO2VZ9MEbAf7BNC04Oeg8gHJ9xQgrQ9a+WWaxQD6uaDuicVYjNIZVC1UEvKYkzgwCHjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051799; c=relaxed/simple;
	bh=hzfqABzEFoCegbb562VZjEiiDht46E+3UQFtZqN61aY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWf9im7S4wOJVcIsJLIBGpkkH3hAEmkPYtIYXMQthdAYQRcdgeRrCvvlNcWUsqW9sXUg35HfSt1aIa10yXL48l2Uyl7tnaHlNg+lEU8dF4uG35dwuzbLnzeDVi+tRVVZLKLJyqgqnEqm0716T6za3mOut18PlD/F78lCzoE/Y6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZflL55Hwtz1R7Rx;
	Sat, 19 Apr 2025 16:34:37 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id A4C4C140297;
	Sat, 19 Apr 2025 16:36:35 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Apr
 2025 16:36:34 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <alex.aring@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] fs: Fix comment typos and grammatical errors
Date: Sat, 19 Apr 2025 16:55:54 +0800
Message-ID: <20250419085554.1452319-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500017.china.huawei.com (7.202.181.81)

This patch does minor comment cleanup:
- Fix spelling mistakes (e.g. "silibing" -> "sibling")
- Correct grammatical errors
No functional changes involved.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/locks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1619cddfa7a4..f06258216b31 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -12,7 +12,7 @@
  * If multiple threads attempt to lock the same byte (or flock the same file)
  * only one can be granted the lock, and other must wait their turn.
  * The first lock has been "applied" or "granted", the others are "waiting"
- * and are "blocked" by the "applied" lock..
+ * and are "blocked" by the "applied" lock.
  *
  * Waiting and applied locks are all kept in trees whose properties are:
  *
@@ -43,7 +43,7 @@
  * waiting for the lock so it can continue handling as follows: if the
  * root of the tree applies, we do so (3).  If it doesn't, it must
  * conflict with some applied lock.  We remove (wake up) all of its children
- * (2), and add it is a new leaf to the tree rooted in the applied
+ * (2), and add it as a new leaf to the tree rooted in the applied
  * lock (1).  We then repeat the process recursively with those
  * children.
  *
@@ -1327,7 +1327,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 * replacing. If new lock(s) need to be inserted all modifications are
 	 * done below this, so it's safe yet to bail out.
 	 */
-	error = -ENOLCK; /* "no luck" */
+	error = -ENOLCK; /* "no lock" */
 	if (right && left == right && !new_fl2)
 		goto out;
 
@@ -2862,7 +2862,7 @@ static int locks_show(struct seq_file *f, void *v)
 		return 0;
 
 	/* View this crossed linked list as a binary tree, the first member of flc_blocked_requests
-	 * is the left child of current node, the next silibing in flc_blocked_member is the
+	 * is the left child of current node, the next sibling in flc_blocked_member is the
 	 * right child, we can alse get the parent of current node from flc_blocker, so this
 	 * question becomes traversal of a binary tree
 	 */
-- 
2.31.1


