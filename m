Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67B4BD82E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 09:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346597AbiBUH44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 02:56:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346598AbiBUH4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:56:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8CC49;
        Sun, 20 Feb 2022 23:56:31 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L5KFcZ030789;
        Mon, 21 Feb 2022 07:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PmskHBvk9YyygPKmyeAxW3mTfC0jTkQ+gXzlUv9/kfk=;
 b=YUj8xii9DEoaSZvZc41GDq5eKYR8FCWFFp5+x7TiKFzCmn4ADcrG0fLZiil4IXJ6Cxkc
 648q5SYgwZm+oNX1u7S0rpo6vF/QNUkx9jG5IGdfg4ncKLIP72NtzyxLfUN3mdgcY1Ft
 i6dRjxBij9guDLO7pPCPqcYtBxwVgnhVCu8mJ3BnCKed0rzCxIxxM59Vj0etjpjjCAgd
 Ute/d2Ak2F9BZ4VEdDHNDD38DSqFX0YgqAoWjrpDkr/+j6Ay0o42LqpzW52jmGu6x1Rl
 q4O/mR0OD0Ic8pxaiQVDBNdTIpuHKsEwVfnz9BipvMB6jg2AjqCduOov/ieif6dl3iE1 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec0etxp6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:56:27 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21L7kKMK010789;
        Mon, 21 Feb 2022 07:56:27 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec0etxp61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:56:26 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21L7ipqt006766;
        Mon, 21 Feb 2022 07:56:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3ear68qsr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:56:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21L7uMgP58786162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 07:56:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AC1BA404D;
        Mon, 21 Feb 2022 07:56:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACFF4A4040;
        Mon, 21 Feb 2022 07:56:21 +0000 (GMT)
Received: from localhost (unknown [9.43.127.119])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Feb 2022 07:56:21 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/1] ext4: Improve fast_commit performance and scalability
Date:   Mon, 21 Feb 2022 13:26:15 +0530
Message-Id: <930f35d4fd5f83e2673c868781d9ebf15e91bf4e.1645426817.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1645426817.git.riteshh@linux.ibm.com>
References: <cover.1645426817.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HBZBy9MOmWD1EMedhCGYvYQq4Eq6A7ki
X-Proofpoint-ORIG-GUID: T7Mhw7MQBgJ8wzteKsgaKyQ7JagH_EAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=583 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210047
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently ext4_fc_commit_dentry_updates() is of quadratic time
complexity, which is causing performance bottlenecks with high
threads/file/dir count with fs_mark.

This patch makes commit dentry updates (and hence ext4_fc_commit()) path
to linear time complexity. Hence improves the performance of workloads
which does fsync on multiple threads/open files one-by-one.

Absolute numbers in avg file creates per sec (from fs_mark in 1K order)
=======================================================================
no.     Order   without-patch(K)   with-patch(K)   Diff(%)
1       1        16.90              17.51           +3.60
2       2,2      32.08              31.80           -0.87
3       3,3      53.97              55.01           +1.92
4       4,4      78.94              76.90           -2.58
5       5,5      95.82              95.37           -0.46
6       6,6      87.92              103.38          +17.58
7       6,10      0.73              126.13          +17178.08
8       6,14      2.33              143.19          +6045.49

workload type
==============
For e.g. 7th row order of 6,10 (2^6 == 64 && 2^10 == 1024)
echo /run/riteshh/mnt/{1..64} |sed -E 's/[[:space:]]+/ -d /g' \
  | xargs -I {} bash -c "sudo fs_mark -L 100 -D 1024 -n 1024 -s0 -S5 -d {}"

Perf profile
(w/o patches)
=============================
87.15%  [kernel]  [k] ext4_fc_commit           --> Heavy contention/bottleneck
 1.98%  [kernel]  [k] perf_event_interrupt
 0.96%  [kernel]  [k] power_pmu_enable
 0.91%  [kernel]  [k] update_sd_lb_stats.constprop.0
 0.67%  [kernel]  [k] ktime_get

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h        |  2 ++
 fs/ext4/fast_commit.c | 74 ++++++++++++++++++++++++++++++++-----------
 fs/ext4/fast_commit.h |  1 +
 3 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0d4f284c0514..3f87cca49f0c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1046,6 +1046,8 @@ struct ext4_inode_info {

 	/* Fast commit related info */

+	/* For tracking dentry create updates */
+	struct list_head i_fc_dilist;
 	struct list_head i_fc_list;	/*
 					 * inodes that need fast commit
 					 * protected by sbi->s_fc_lock.
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3c5baca38767..5ac594e03402 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -199,6 +199,7 @@ void ext4_fc_init_inode(struct inode *inode)
 	ext4_fc_reset_inode(inode);
 	ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
 	INIT_LIST_HEAD(&ei->i_fc_list);
+	INIT_LIST_HEAD(&ei->i_fc_dilist);
 	init_waitqueue_head(&ei->i_fc_wait);
 	atomic_set(&ei->i_fc_updates, 0);
 }
@@ -279,6 +280,8 @@ void ext4_fc_stop_update(struct inode *inode)
 void ext4_fc_del(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_fc_dentry_update *fc_dentry;

 	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
 	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
@@ -286,7 +289,7 @@ void ext4_fc_del(struct inode *inode)

 restart:
 	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-	if (list_empty(&ei->i_fc_list)) {
+	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
 		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 		return;
 	}
@@ -295,8 +298,33 @@ void ext4_fc_del(struct inode *inode)
 		ext4_fc_wait_committing_inode(inode);
 		goto restart;
 	}
-	list_del_init(&ei->i_fc_list);
-	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+
+	if (!list_empty(&ei->i_fc_list))
+		list_del_init(&ei->i_fc_list);
+
+	/*
+	 * Since this inode is getting removed, let's also remove all FC
+	 * dentry create references, since it is not needed to log it anyways.
+	 */
+	if (list_empty(&ei->i_fc_dilist)) {
+		spin_unlock(&sbi->s_fc_lock);
+		return;
+	}
+
+	fc_dentry = list_first_entry(&ei->i_fc_dilist, struct ext4_fc_dentry_update, fcd_dilist);
+	WARN_ON(fc_dentry->fcd_op != EXT4_FC_TAG_CREAT);
+	list_del_init(&fc_dentry->fcd_list);
+	list_del_init(&fc_dentry->fcd_dilist);
+
+	WARN_ON(!list_empty(&ei->i_fc_dilist));
+	spin_unlock(&sbi->s_fc_lock);
+
+	if (fc_dentry->fcd_name.name &&
+		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
+		kfree(fc_dentry->fcd_name.name);
+	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
+
+	return;
 }

 /*
@@ -427,7 +455,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		node->fcd_name.name = node->fcd_iname;
 	}
 	node->fcd_name.len = dentry->d_name.len;
-
+	INIT_LIST_HEAD(&node->fcd_dilist);
 	spin_lock(&sbi->s_fc_lock);
 	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
@@ -435,6 +463,20 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 				&sbi->s_fc_dentry_q[FC_Q_STAGING]);
 	else
 		list_add_tail(&node->fcd_list, &sbi->s_fc_dentry_q[FC_Q_MAIN]);
+
+	/*
+	 * This helps us keep a track of all fc_dentry updates which is part of
+	 * this ext4 inode. So in case the inode is getting unlinked, before
+	 * even we get a chance to fsync, we could remove all fc_dentry
+	 * references while evicting the inode in ext4_fc_del().
+	 * Also with this, we don't need to loop over all the inodes in
+	 * sbi->s_fc_q to get the corresponding inode in
+	 * ext4_fc_commit_dentry_updates().
+	 */
+	if (dentry_update->op == EXT4_FC_TAG_CREAT) {
+		WARN_ON(!list_empty(&ei->i_fc_dilist));
+		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
+	}
 	spin_unlock(&sbi->s_fc_lock);
 	mutex_lock(&ei->i_fc_lock);

@@ -954,7 +996,7 @@ __releases(&sbi->s_fc_lock)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_fc_dentry_update *fc_dentry, *fc_dentry_n;
 	struct inode *inode;
-	struct ext4_inode_info *ei, *ei_n;
+	struct ext4_inode_info *ei;
 	int ret;

 	if (list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN]))
@@ -970,21 +1012,16 @@ __releases(&sbi->s_fc_lock)
 			spin_lock(&sbi->s_fc_lock);
 			continue;
 		}
-
-		inode = NULL;
-		list_for_each_entry_safe(ei, ei_n, &sbi->s_fc_q[FC_Q_MAIN],
-					 i_fc_list) {
-			if (ei->vfs_inode.i_ino == fc_dentry->fcd_ino) {
-				inode = &ei->vfs_inode;
-				break;
-			}
-		}
 		/*
-		 * If we don't find inode in our list, then it was deleted,
-		 * in which case, we don't need to record it's create tag.
+		 * With fcd_dilist we need not loop in sbi->s_fc_q to get the
+		 * corresponding inode pointer
 		 */
-		if (!inode)
-			continue;
+		WARN_ON(list_empty(&fc_dentry->fcd_dilist));
+		ei = list_first_entry(&fc_dentry->fcd_dilist,
+				struct ext4_inode_info, i_fc_dilist);
+		inode = &ei->vfs_inode;
+		WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
+
 		spin_unlock(&sbi->s_fc_lock);

 		/*
@@ -1228,6 +1265,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 					     struct ext4_fc_dentry_update,
 					     fcd_list);
 		list_del_init(&fc_dentry->fcd_list);
+		list_del_init(&fc_dentry->fcd_dilist);
 		spin_unlock(&sbi->s_fc_lock);

 		if (fc_dentry->fcd_name.name &&
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 083ad1cb705a..02afa52e8e41 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -109,6 +109,7 @@ struct ext4_fc_dentry_update {
 	struct qstr fcd_name;	/* Dirent name */
 	unsigned char fcd_iname[DNAME_INLINE_LEN];	/* Dirent name string */
 	struct list_head fcd_list;
+	struct list_head fcd_dilist;
 };

 struct ext4_fc_stats {
--
2.31.1

