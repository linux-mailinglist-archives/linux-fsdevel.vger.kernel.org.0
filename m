Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAA02AC37C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 19:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKISRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 13:17:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58950 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgKISRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:17:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9I9DYI112566;
        Mon, 9 Nov 2020 18:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QeScwIhwnzSF8a9zop6RGxI+oNni8aCPT3nzu77fEyI=;
 b=cuER5DpvPc6aVPCiciZ4g32Z/yBgBUF/o3d/nWW/z5f7EnYCeZFS0EwTiUCq+RyvH/wm
 cKkjBWfGwtFB+LDMHyVJzr401SAPNT9cFp2tys4hQclA2JaUBUi4B66YWBL3yhgzcSSu
 UR2xiUNmaoflo96gFFHvrN34vRIoNt0cCMCscTZRdXhVkqrmmlw6CQkCfZcwwzB7JHxn
 O94HOd9IqEUqAM25j2M8McCabD9dz9TWcUECjN56gQDcuh2PX8sIj9G8Gfm6CXbberiD
 uEIYgLFTWJdeYjIB8jT2H6olVbsBFQ3bZrEDEGB54uJ5x3yr9b+gzUxk/CfAAVbqV4JO 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34p72edmur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 18:17:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9IAnKo157251;
        Mon, 9 Nov 2020 18:17:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34p5fy1gy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 18:17:06 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9IH5iB010033;
        Mon, 9 Nov 2020 18:17:05 GMT
Received: from localhost (/10.159.239.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 10:17:05 -0800
Subject: [PATCH 3/3] vfs: move __sb_{start,end}_write* to fs.h
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 09 Nov 2020 10:17:04 -0800
Message-ID: <160494582399.772573.10836748188202532335.stgit@magnolia>
In-Reply-To: <160494580419.772573.9286165021627298770.stgit@magnolia>
References: <160494580419.772573.9286165021627298770.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=1 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Now that we've straightened out the callers, move these three functions
to fs.h since they're fairly trivial.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/super.c         |   30 ------------------------------
 include/linux/fs.h |   21 ++++++++++++++++++---
 2 files changed, 18 insertions(+), 33 deletions(-)


diff --git a/fs/super.c b/fs/super.c
index 59aa59279133..98bb0629ee10 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1631,36 +1631,6 @@ int super_setup_bdi(struct super_block *sb)
 }
 EXPORT_SYMBOL(super_setup_bdi);
 
-/*
- * This is an internal function, please use sb_end_{write,pagefault,intwrite}
- * instead.
- */
-void __sb_end_write(struct super_block *sb, int level)
-{
-	percpu_up_read(sb->s_writers.rw_sem + level-1);
-}
-EXPORT_SYMBOL(__sb_end_write);
-
-/*
- * This is an internal function, please use sb_start_{write,pagefault,intwrite}
- * instead.
- */
-void __sb_start_write(struct super_block *sb, int level)
-{
-	percpu_down_read(sb->s_writers.rw_sem + level - 1);
-}
-EXPORT_SYMBOL(__sb_start_write);
-
-/*
- * This is an internal function, please use sb_start_{write,pagefault,intwrite}
- * instead.
- */
-bool __sb_start_write_trylock(struct super_block *sb, int level)
-{
-	return percpu_down_read_trylock(sb->s_writers.rw_sem + level - 1);
-}
-EXPORT_SYMBOL_GPL(__sb_start_write_trylock);
-
 /**
  * sb_wait_write - wait until all writers to given file system finish
  * @sb: the super for which we wait
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 305989afd49c..6dabd019cab0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1580,9 +1580,24 @@ extern struct timespec64 current_time(struct inode *inode);
  * Snapshotting support.
  */
 
-void __sb_end_write(struct super_block *sb, int level);
-void __sb_start_write(struct super_block *sb, int level);
-bool __sb_start_write_trylock(struct super_block *sb, int level);
+/*
+ * These are internal functions, please use sb_start_{write,pagefault,intwrite}
+ * instead.
+ */
+static inline void __sb_end_write(struct super_block *sb, int level)
+{
+	percpu_up_read(sb->s_writers.rw_sem + level-1);
+}
+
+static inline void __sb_start_write(struct super_block *sb, int level)
+{
+	percpu_down_read(sb->s_writers.rw_sem + level - 1);
+}
+
+static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
+{
+	return percpu_down_read_trylock(sb->s_writers.rw_sem + level - 1);
+}
 
 #define __sb_writers_acquired(sb, lev)	\
 	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)

