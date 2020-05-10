Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5C1CC738
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEJGZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgEJGZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A62gPm117557;
        Sun, 10 May 2020 02:25:37 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws5cuywa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:37 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6K4Em003465;
        Sun, 10 May 2020 06:25:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55a130-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PWPd56164496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3212642042;
        Sun, 10 May 2020 06:25:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B366F42041;
        Sun, 10 May 2020 06:25:30 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:30 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 07/16] ext4: mballoc: Make ext4_mb_use_preallocated() return type as bool
Date:   Sun, 10 May 2020 11:54:47 +0530
Message-Id: <7880cb6ef911465beafefcd7e9c3ea214688744b.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=1
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=900
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change return type of function ext4_mb_use_preallocated() to bool to
better reflect what this function can return.

There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index aaf43c6c08e1..262a53f1d283 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3432,7 +3432,7 @@ ext4_mb_check_group_pa(ext4_fsblk_t goal_block,
 /*
  * search goal blocks in preallocated space
  */
-static noinline_for_stack int
+static noinline_for_stack bool
 ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
@@ -3444,7 +3444,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 	/* only data can be preallocated */
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
-		return 0;
+		return false;
 
 	/* first, try per-file preallocation */
 	rcu_read_lock();
@@ -3471,7 +3471,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 			spin_unlock(&pa->pa_lock);
 			ac->ac_criteria = 10;
 			rcu_read_unlock();
-			return 1;
+			return true;
 		}
 		spin_unlock(&pa->pa_lock);
 	}
@@ -3479,12 +3479,12 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 	/* can we use group allocation? */
 	if (!(ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC))
-		return 0;
+		return false;
 
 	/* inode may have no locality group for some reason */
 	lg = ac->ac_lg;
 	if (lg == NULL)
-		return 0;
+		return false;
 	order  = fls(ac->ac_o_ex.fe_len) - 1;
 	if (order > PREALLOC_TB_SIZE - 1)
 		/* The max size of hash table is PREALLOC_TB_SIZE */
@@ -3513,9 +3513,9 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (cpa) {
 		ext4_mb_use_group_pa(ac, cpa);
 		ac->ac_criteria = 20;
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
-- 
2.21.0

