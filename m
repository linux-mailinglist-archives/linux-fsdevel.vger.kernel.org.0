Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFBB1C0E1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgEAGai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728241AbgEAGah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:37 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162QIc018952;
        Fri, 1 May 2020 02:30:33 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r82sgx0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:28 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416AvJS014986;
        Fri, 1 May 2020 06:30:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 30mcu8fa9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UNDa10355102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D477A4068;
        Fri,  1 May 2020 06:30:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DC17A405B;
        Fri,  1 May 2020 06:30:21 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:21 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 07/20] ext4: mballoc: Fix few other format specifier in mb_debug()
Date:   Fri,  1 May 2020 11:59:49 +0530
Message-Id: <488470904ae90a0c97b9ff9737fc1d32461fb848.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010040
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
index a4d9abf97193..2999b41bb5f8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3309,8 +3309,8 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
 
-	mb_debug(1, "goal: %u(was %u) blocks at %u\n", (unsigned) size,
-		(unsigned) orig_size, (unsigned) start);
+	mb_debug(1, "goal: %lld(was %lld) blocks at %u\n", size, orig_size,
+		 start);
 }
 
 static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
@@ -3399,7 +3399,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(pa->pa_free < len);
 	pa->pa_free -= len;
 
-	mb_debug(1, "use %llu/%u from inode pa %p\n", start, len, pa);
+	mb_debug(1, "use %llu/%d from inode pa %p\n", start, len, pa);
 }
 
 /*
@@ -3606,7 +3606,7 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 		ext4_set_bits(bitmap, start, len);
 		preallocated += len;
 	}
-	mb_debug(1, "preallocated %u for group %u\n", preallocated, group);
+	mb_debug(1, "preallocated %d for group %u\n", preallocated, group);
 }
 
 static void ext4_mb_pa_callback(struct rcu_head *head)
@@ -4205,7 +4205,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 
 	ext4_msg(sb, KERN_ERR, "Can't allocate:"
 			" Allocation context details:");
-	ext4_msg(sb, KERN_ERR, "status %d flags %d",
+	ext4_msg(sb, KERN_ERR, "status %u flags 0x%x",
 			ac->ac_status, ac->ac_flags);
 	ext4_msg(sb, KERN_ERR, "orig %lu/%lu/%lu@%lu, "
 			"goal %lu/%lu/%lu@%lu, "
@@ -4223,7 +4223,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
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

