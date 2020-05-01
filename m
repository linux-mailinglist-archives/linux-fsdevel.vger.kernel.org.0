Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157301C0E10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgEAGac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728288AbgEAGaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162E7a164435;
        Fri, 1 May 2020 02:30:23 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r84m8qpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416Ax6p030098;
        Fri, 1 May 2020 06:30:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5v502-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UIpP29098192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E11BEA405F;
        Fri,  1 May 2020 06:30:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5943DA4064;
        Fri,  1 May 2020 06:30:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 05/20] ext4: mballoc: Add more mb_debug() msgs
Date:   Fri,  1 May 2020 11:59:47 +0530
Message-Id: <6d3adc19f79dcfac70c873b5cee132a4a433f4a6.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=3
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010040
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
index d7ae5a092796..2acabc3927e0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2137,7 +2137,7 @@ static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t ngroups, group, i;
-	int cr;
+	int cr = -1;
 	int err = 0, first_err = 0;
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
@@ -2289,6 +2289,10 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 out:
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
+
+	mb_debug(1, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
+		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
+		 ac->ac_flags, cr, err);
 	return err;
 }
 
@@ -3949,7 +3953,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	mb_debug(1, "discard preallocation for group %u\n", group);
 
 	if (list_empty(&grp->bb_prealloc_list))
-		return 0;
+		goto out_dbg;
 
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh)) {
@@ -3957,7 +3961,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		ext4_error_err(sb, -err,
 			       "Error %d reading block bitmap for %u",
 			       err, group);
-		return 0;
+		goto out_dbg;
 	}
 
 	err = ext4_mb_load_buddy(sb, group, &e4b);
@@ -3965,7 +3969,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		ext4_warning(sb, "Error %d loading buddy information for %u",
 			     err, group);
 		put_bh(bitmap_bh);
-		return 0;
+		goto out_dbg;
 	}
 
 	if (needed == 0)
@@ -4011,6 +4015,8 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	/* found anything to free? */
 	if (list_empty(&list)) {
 		BUG_ON(free != 0);
+		mb_debug(1, "Someone else may have freed PA for this group %u\n",
+			 group);
 		goto out;
 	}
 
@@ -4035,6 +4041,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
+out_dbg:
+	mb_debug(1, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
+		 free, group, grp->bb_free);
 	return free;
 }
 
@@ -4602,6 +4611,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ar->len = ar->len >> 1;
 		}
 		if (!ar->len) {
+			ext4_mb_show_pa(sb);
 			*errp = -ENOSPC;
 			return 0;
 		}
-- 
2.21.0

