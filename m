Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D3C1CC734
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEJGZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbgEJGZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:40 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A61O3j037234;
        Sun, 10 May 2020 02:25:35 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws43kntv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:33 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6K1xE003462;
        Sun, 10 May 2020 06:25:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55a12u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PS9N10485922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 789D942041;
        Sun, 10 May 2020 06:25:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC5134203F;
        Sun, 10 May 2020 06:25:26 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:26 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 05/16] ext4: mballoc: Fix few other format specifier in mb_debug()
Date:   Sun, 10 May 2020 11:54:45 +0530
Message-Id: <574fa7f833abf2dbf3b53a2fea3195e71f6cdbd8.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=3 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005100050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix few other format specifiers in mb_debug() msgs.
As such no other functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 49de715d04f9..4ada63cf425f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3280,8 +3280,8 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
 
-	mb_debug(1, "goal: %u(was %u) blocks at %u\n", (unsigned) size,
-		(unsigned) orig_size, (unsigned) start);
+	mb_debug(1, "goal: %lld(was %lld) blocks at %u\n", size, orig_size,
+		 start);
 }
 
 static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
@@ -3370,7 +3370,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(pa->pa_free < len);
 	pa->pa_free -= len;
 
-	mb_debug(1, "use %llu/%u from inode pa %p\n", start, len, pa);
+	mb_debug(1, "use %llu/%d from inode pa %p\n", start, len, pa);
 }
 
 /*
@@ -3577,7 +3577,7 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 		ext4_set_bits(bitmap, start, len);
 		preallocated += len;
 	}
-	mb_debug(1, "preallocated %u for group %u\n", preallocated, group);
+	mb_debug(1, "preallocated %d for group %u\n", preallocated, group);
 }
 
 static void ext4_mb_pa_callback(struct rcu_head *head)
@@ -4173,7 +4173,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 
 	ext4_msg(sb, KERN_ERR, "Can't allocate:"
 			" Allocation context details:");
-	ext4_msg(sb, KERN_ERR, "status %d flags %d",
+	ext4_msg(sb, KERN_ERR, "status %u flags 0x%x",
 			ac->ac_status, ac->ac_flags);
 	ext4_msg(sb, KERN_ERR, "orig %lu/%lu/%lu@%lu, "
 			"goal %lu/%lu/%lu@%lu, "
@@ -4191,7 +4191,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 			(unsigned long)ac->ac_b_ex.fe_len,
 			(unsigned long)ac->ac_b_ex.fe_logical,
 			(int)ac->ac_criteria);
-	ext4_msg(sb, KERN_ERR, "%d found", ac->ac_found);
+	ext4_msg(sb, KERN_ERR, "%u found", ac->ac_found);
 	ext4_mb_show_pa(sb);
 }
 #else
-- 
2.21.0

