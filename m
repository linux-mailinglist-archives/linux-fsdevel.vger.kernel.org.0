Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48934D4DFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiCJQBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiCJQAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:00:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230091662F3;
        Thu, 10 Mar 2022 07:59:53 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AEaEXA022069;
        Thu, 10 Mar 2022 15:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0+rzNxS4DQSmqTOqZuotWTKYkyQQ0/mys+OgdhO986g=;
 b=bF09D7tQWpFas11ZSBM6QSZxylALAk3NMgvPQj7DQIiGWHzeDJD49rdODvHqdDNAMgxR
 sH3dfIRAcrJDTXgpyxgKpBpHGyvYie4A72EkL+Y1ZOgR75PkrxC1dCvXeOJTzHXlDOCi
 VtWKN1eSmVNiBu7bY+tsRePSWjfPSroqVE6CLa3PXshbmyc0O/BvomwbkIdGqlpt8cyO
 0eOb1DDgSfEwcGyJkCsRanyo5yaTdbhMS+T1+MNpvlSRDDKwSnMlAARPF74gTYT0VLOA
 nx0vYe6UcNU75YeTSVElfCwWHZ/OE2M5AXd1qvjHhJ5s0QPaAJ1e71xir156DHH+OWmH dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqcyyb3k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:35 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22AFjiIl031612;
        Thu, 10 Mar 2022 15:59:34 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqcyyb3jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:34 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AFv6EF028968;
        Thu, 10 Mar 2022 15:59:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg951d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 15:59:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AFxUbg14221706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:59:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CCDC11C052;
        Thu, 10 Mar 2022 15:59:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20EB311C04C;
        Thu, 10 Mar 2022 15:59:30 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 15:59:29 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>, stable@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv2 02/10] ext4: Fix ext4_fc_stats trace point
Date:   Thu, 10 Mar 2022 21:28:56 +0530
Message-Id: <f165aa338a9d175844a19d7c582e7ecbd5cbc1a9.1646922487.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646922487.git.riteshh@linux.ibm.com>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XDBVF3UYp8kF75_UH50LtpaTIL0W6DNX
X-Proofpoint-GUID: uzvIu7okU2WkzfK0rUdSeRLVBF9dZgz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_06,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=924
 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ftrace's __print_symbolic() requires that any enum values used in the
symbol to string translation table be wrapped in a TRACE_DEFINE_ENUM
so that the enum value can be decoded from the ftrace ring buffer by
user space tooling.

This patch also fixes few other problems found in this trace point.
e.g. dereferencing structures in TP_printk which should not be done
at any cost.

Also to avoid checkpatch warnings, this patch removes those
whitespaces/tab stops issues.

Cc: stable@kernel.org
Fixes: commit aa75f4d3daae ("ext4: main fast-commit commit path")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 include/trace/events/ext4.h | 77 +++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 19e957b7f941..db404eb9b666 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -95,6 +95,16 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
 	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
 
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_XATTR);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_CROSS_RENAME);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_NOMEM);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_SWAP_BOOT);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_RESIZE);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_RENAME_DIR);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
+
 #define show_fc_reason(reason)						\
 	__print_symbolic(reason,					\
 		{ EXT4_FC_REASON_XATTR,		"XATTR"},		\
@@ -2723,41 +2733,50 @@ TRACE_EVENT(ext4_fc_commit_stop,
 
 #define FC_REASON_NAME_STAT(reason)					\
 	show_fc_reason(reason),						\
-	__entry->sbi->s_fc_stats.fc_ineligible_reason_count[reason]
+	__entry->fc_ineligible_rc[reason]
 
 TRACE_EVENT(ext4_fc_stats,
-	    TP_PROTO(struct super_block *sb),
-
-	    TP_ARGS(sb),
+	TP_PROTO(struct super_block *sb),
 
-	    TP_STRUCT__entry(
-		    __field(dev_t, dev)
-		    __field(struct ext4_sb_info *, sbi)
-		    __field(int, count)
-		    ),
+	TP_ARGS(sb),
 
-	    TP_fast_assign(
-		    __entry->dev = sb->s_dev;
-		    __entry->sbi = EXT4_SB(sb);
-		    ),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__array(unsigned int, fc_ineligible_rc, EXT4_FC_REASON_MAX)
+		__field(unsigned long, fc_commits)
+		__field(unsigned long, fc_ineligible_commits)
+		__field(unsigned long, fc_numblks)
+	),
 
-	    TP_printk("dev %d:%d fc ineligible reasons:\n"
-		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
-		      "num_commits:%ld, ineligible: %ld, numblks: %ld",
-		      MAJOR(__entry->dev), MINOR(__entry->dev),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
-		      __entry->sbi->s_fc_stats.fc_num_commits,
-		      __entry->sbi->s_fc_stats.fc_ineligible_commits,
-		      __entry->sbi->s_fc_stats.fc_numblks)
+	TP_fast_assign(
+		int i;
 
+		__entry->dev = sb->s_dev;
+		for (i = 0; i < EXT4_FC_REASON_MAX; i++) {
+			__entry->fc_ineligible_rc[i] =
+				EXT4_SB(sb)->s_fc_stats.fc_ineligible_reason_count[i];
+		}
+		__entry->fc_commits = EXT4_SB(sb)->s_fc_stats.fc_num_commits;
+		__entry->fc_ineligible_commits =
+			EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
+		__entry->fc_numblks = EXT4_SB(sb)->s_fc_stats.fc_numblks;
+	),
+
+	TP_printk("dev %d,%d fc ineligible reasons:\n"
+		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u "
+		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
+		  __entry->fc_commits, __entry->fc_ineligible_commits,
+		  __entry->fc_numblks)
 );
 
 #define DEFINE_TRACE_DENTRY_EVENT(__type)				\
-- 
2.31.1

