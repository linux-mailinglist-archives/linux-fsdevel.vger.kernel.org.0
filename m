Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E881CC72A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgEJGZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbgEJGZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A624U8033027;
        Sun, 10 May 2020 02:25:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvmv6x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6K4Ej003465;
        Sun, 10 May 2020 06:25:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55a12s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6POGE50331710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A206B42042;
        Sun, 10 May 2020 06:25:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 302D542041;
        Sun, 10 May 2020 06:25:23 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:22 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 03/16] ext4: mballoc: Add more mb_debug() msgs
Date:   Sun, 10 May 2020 11:54:43 +0530
Message-Id: <5fc8e7788b924e211fcfa4a4c1d2f8503511661a.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=3
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005100050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds some more debugging mb_debug() msgs to help improve
mballoc code debugging.
Other than adding more mb_debug() msgs at few more places,
there should be no other functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d1464d9110ef..2e4697e7b945 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2108,7 +2108,7 @@ static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t ngroups, group, i;
-	int cr;
+	int cr = -1;
 	int err = 0, first_err = 0;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
@@ -2260,6 +2260,10 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 out:
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
+
+	mb_debug(1, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
+		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
+		 ac->ac_flags, cr, err);
 	return err;
 }
 
@@ -3918,7 +3922,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	mb_debug(1, "discard preallocation for group %u\n", group);
 
 	if (list_empty(&grp->bb_prealloc_list))
-		return 0;
+		goto out_dbg;
 
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh)) {
@@ -3926,7 +3930,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		ext4_error_err(sb, -err,
 			       "Error %d reading block bitmap for %u",
 			       err, group);
-		return 0;
+		goto out_dbg;
 	}
 
 	err = ext4_mb_load_buddy(sb, group, &e4b);
@@ -3934,7 +3938,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		ext4_warning(sb, "Error %d loading buddy information for %u",
 			     err, group);
 		put_bh(bitmap_bh);
-		return 0;
+		goto out_dbg;
 	}
 
 	if (needed == 0)
@@ -3979,6 +3983,8 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	/* found anything to free? */
 	if (list_empty(&list)) {
 		BUG_ON(free != 0);
+		mb_debug(1, "Someone else may have freed PA for this group %u\n",
+			 group);
 		goto out;
 	}
 
@@ -4003,6 +4009,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
+out_dbg:
+	mb_debug(1, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
+		 free, group, grp->bb_free);
 	return free;
 }
 
@@ -4538,6 +4547,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ar->len = ar->len >> 1;
 		}
 		if (!ar->len) {
+			ext4_mb_show_pa(sb);
 			*errp = -ENOSPC;
 			return 0;
 		}
-- 
2.21.0

