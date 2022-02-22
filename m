Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B134C0314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 21:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiBVUfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 15:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiBVUfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:35:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59E13DE18;
        Tue, 22 Feb 2022 12:34:49 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MIBpC8001629;
        Tue, 22 Feb 2022 20:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N4wXgrKKNYsKxA0GIpturVHAkEwLI1uIxpSY7XxtnkI=;
 b=px6VC7LOB3arD5tB/TQwhg29As53xsOMJdohclJQTvK2pjpZsstaSRuWlPoiXCoDL5wU
 M+OJJnIVUxGqQAy1k+TIhjbKyrH+J7Q/SNknzLtAQsMis/U+XEEJkfnIJb5R+hT5itGT
 BA9OvUvg3ef4L4TLtJJy1/S24A9IlHahnML4OLaFzUCjhy8idj0iQ4Qr15kIxDzXZhQ6
 F0+mps4LV7+s/cfrBuWa9B9R546RD1EJKIaQCMIxaMNSPx8vvNNzcLfd7giJdzMKo2KZ
 bXOhnty/BqVDmI1b+VFULfhMX0SEXND+TFOrStAhznRi3sIPHuY0oy04AJ0w/SoWeax/ Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed4w2k9f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:45 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MKKIeM002979;
        Tue, 22 Feb 2022 20:34:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed4w2k9er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MKK6Jn025865;
        Tue, 22 Feb 2022 20:34:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear695pfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:34:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MKYeHO38273384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 20:34:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 440D64C046;
        Tue, 22 Feb 2022 20:34:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 782214C044;
        Tue, 22 Feb 2022 20:34:38 +0000 (GMT)
Received: from localhost (unknown [9.43.75.136])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 20:34:38 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 3/9] ext4: Add couple of more fast_commit tracepoints
Date:   Wed, 23 Feb 2022 02:04:11 +0530
Message-Id: <90608d31b7ad8500c33d875d3a7fa50e3456dc1a.1645558375.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1645558375.git.riteshh@linux.ibm.com>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dxw13DDGATk2tsRk8N-il_bA5G0-Whtd
X-Proofpoint-GUID: c-vqlSPw2ubQrujNaqyfb9TD6rAk8v_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=707 clxscore=1015 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds two more tracepoints for ext4_fc_track_template() &
ext4_fc_cleanup() which are helpful in debugging some fast_commit issues.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/fast_commit.c       |  3 ++
 include/trace/events/ext4.h | 67 +++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5ac594e03402..bf70879bb4fe 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -386,6 +386,8 @@ static int ext4_fc_track_template(
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return -EINVAL;
 
+	trace_ext4_fc_track_template(handle, inode, __fc_track_fn, enqueue);
+
 	tid = handle->h_transaction->t_tid;
 	mutex_lock(&ei->i_fc_lock);
 	if (tid == ei->i_sync_tid) {
@@ -1241,6 +1243,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	if (full && sbi->s_fc_bh)
 		sbi->s_fc_bh = NULL;
 
+	trace_ext4_fc_cleanup(journal, full, tid);
 	jbd2_fc_release_bufs(journal);
 
 	spin_lock(&sbi->s_fc_lock);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 17fb9c506e8a..cd09dccea502 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2855,6 +2855,73 @@ TRACE_EVENT(ext4_fc_track_range,
 		      __entry->end)
 	);
 
+TRACE_EVENT(ext4_fc_track_template,
+	TP_PROTO(handle_t *handle, struct inode *inode,
+		 void *__fc_track_fn, int enqueue),
+
+	TP_ARGS(handle, inode, __fc_track_fn, enqueue),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(tid_t, t_tid)
+		__field(ino_t, i_ino)
+		__field(tid_t, i_sync_tid)
+		__field(void *, __fc_track_fn)
+		__field(int, enqueue)
+		__field(bool, jbd2_ongoing)
+		__field(bool, fc_ongoing)
+	),
+
+	TP_fast_assign(
+		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+		struct ext4_inode_info *ei = EXT4_I(inode);
+
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->t_tid = handle->h_transaction->t_tid;
+		__entry->i_ino = inode->i_ino;
+		__entry->i_sync_tid = ei->i_sync_tid;
+		__entry->__fc_track_fn = __fc_track_fn;
+		__entry->enqueue = enqueue;
+		__entry->jbd2_ongoing =
+		    sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING;
+		__entry->fc_ongoing =
+		    sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING;
+	),
+
+	TP_printk("dev %d,%d, t_tid %u, ino %lu, i_sync_tid %u, "
+		  "track_fn %pS, enqueue %d, jbd2_ongoing %d, fc_ongoing %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->t_tid, __entry->i_ino, __entry->i_sync_tid,
+		  (void *)__entry->__fc_track_fn, __entry->enqueue,
+		  __entry->jbd2_ongoing, __entry->fc_ongoing)
+	);
+
+TRACE_EVENT(ext4_fc_cleanup,
+	TP_PROTO(journal_t *journal, int full, tid_t tid),
+
+	TP_ARGS(journal, full, tid),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(int, j_fc_off)
+		__field(int, full)
+		__field(tid_t, tid)
+	),
+
+	TP_fast_assign(
+		struct super_block *sb = journal->j_private;
+
+		__entry->dev = sb->s_dev;
+		__entry->j_fc_off = journal->j_fc_off;
+		__entry->full = full;
+		__entry->tid = tid;
+	),
+
+	TP_printk("dev %d,%d, j_fc_off %d, full %d, tid %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->j_fc_off, __entry->full, __entry->tid)
+	);
+
 TRACE_EVENT(ext4_update_sb,
 	TP_PROTO(struct super_block *sb, ext4_fsblk_t fsblk,
 		 unsigned int flags),
-- 
2.31.1

