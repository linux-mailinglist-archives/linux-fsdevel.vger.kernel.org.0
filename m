Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDCD1C0E14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEAGac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728291AbgEAGab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162Y6n078151;
        Fri, 1 May 2020 02:30:26 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7mc9ggm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:26 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416Ax6q030098;
        Fri, 1 May 2020 06:30:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5v503-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416ULbU62587058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4905EA405C;
        Fri,  1 May 2020 06:30:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98058A4054;
        Fri,  1 May 2020 06:30:19 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:19 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 06/20] ext4: mballoc: Correct the mb_debug() format specifier for pa_len var
Date:   Fri,  1 May 2020 11:59:48 +0530
Message-Id: <8e3f2b264de62f49c83d65ad3bdaa76fd1207419.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 impostorscore=0 suspectscore=3 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010040
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pa->pa_len is an integer. Fix all of the format specifier used in
mb_debug() for pa_len to %d instead of %u.

As such no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2acabc3927e0..a4d9abf97193 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3749,7 +3749,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_INODE_PA;
 
-	mb_debug(1, "new inode pa %p: %llu/%u for %u\n", pa,
+	mb_debug(1, "new inode pa %p: %llu/%d for %u\n", pa,
 			pa->pa_pstart, pa->pa_len, pa->pa_lstart);
 	trace_ext4_mb_new_inode_pa(ac, pa);
 
@@ -3810,7 +3810,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_GROUP_PA;
 
-	mb_debug(1, "new group pa %p: %llu/%u for %u\n", pa,
+	mb_debug(1, "new group pa %p: %llu/%d for %u\n", pa,
 			pa->pa_pstart, pa->pa_len, pa->pa_lstart);
 	trace_ext4_mb_new_group_pa(ac, pa);
 
@@ -3893,10 +3893,10 @@ ext4_mb_release_inode_pa(struct ext4_buddy *e4b, struct buffer_head *bitmap_bh,
 	}
 	if (free != pa->pa_free) {
 		ext4_msg(e4b->bd_sb, KERN_CRIT,
-			 "pa %p: logic %lu, phys. %lu, len %lu",
+			 "pa %p: logic %lu, phys. %lu, len %d",
 			 pa, (unsigned long) pa->pa_lstart,
 			 (unsigned long) pa->pa_pstart,
-			 (unsigned long) pa->pa_len);
+			 pa->pa_len);
 		ext4_grp_locked_error(sb, group, 0, 0, "free %u, pa_free %u",
 					free, pa->pa_free);
 		/*
@@ -4184,7 +4184,7 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 			ext4_get_group_no_and_offset(sb, pa->pa_pstart,
 						     NULL, &start);
 			spin_unlock(&pa->pa_lock);
-			printk(KERN_ERR "PA:%u:%d:%u \n", i,
+			printk(KERN_ERR "PA:%u:%d:%d \n", i,
 			       start, pa->pa_len);
 		}
 		ext4_unlock_group(sb, i);
-- 
2.21.0

