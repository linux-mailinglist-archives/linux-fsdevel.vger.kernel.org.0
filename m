Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688AC5FF4A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 22:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJNUh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiJNUhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:37:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A57E22EB;
        Fri, 14 Oct 2022 13:36:56 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EIxpxY032271;
        Fri, 14 Oct 2022 20:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uju5r2ZMBGoIR5kk52WPXzsCPs50oTLfQ2yC39sIArk=;
 b=j129xyoM3Khu54r0771K7KNRRM9LVwj4/zp3Z2eGJ5b65a1fvhWvAC+k7qaJSFqB/YgN
 8TtpqQYueW6LP+IN8p0GJNrBZhgWGyE0uHYttKwjXpRlLk8/GdEJtF2CbL1Tf+xErraK
 TkjLXPeYHex+yMoxjMy6h86CaMi2+0NVrqdUdOWE2Oxrz9uzX+qu7j9mxbcOrPSBiWEd
 FV8kUAXn2hYzy++tDfTffekSQh41xr8ytMk0nNBGujKBBY/dYTzNNoQRZnHhI95YknBP
 wtr0llOAvLkP2hZW+Od+v/vjP5qvm+EfQK/lHlR/E2gBBc0DI7zIDzfoA2SaQgOQYGeZ ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k7dhejqqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 20:36:51 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29EKAJPC004118;
        Fri, 14 Oct 2022 20:36:50 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k7dhejqpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 20:36:50 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29EKamMH016753;
        Fri, 14 Oct 2022 20:36:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3k30fjhws5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 20:36:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29EKbIKL52298158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 20:37:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6245442041;
        Fri, 14 Oct 2022 20:36:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 147B44203F;
        Fri, 14 Oct 2022 20:36:44 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.122.214])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Oct 2022 20:36:43 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v2 4/8] ext4: Move overlap assert logic into a separate function
Date:   Sat, 15 Oct 2022 02:06:26 +0530
Message-Id: <2cc301d39f072148ffabf136df255be707d8f706.1665776268.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1665776268.git.ojaswin@linux.ibm.com>
References: <cover.1665776268.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n5Cz3yqGrFiDadGxwfZ8gaw2bjXGfju3
X-Proofpoint-ORIG-GUID: 9I8RdPNSMvlL8vgjB2MTZLMIQbfBefJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Abstract out the logic to double check for overlaps in normalize_pa to
a separate function. Since there has been no reports in past where we
have seen any overlaps which hits this bug_on(), in future we can
consider calling this function under "#ifdef AGGRESSIVE_CHECK" only.

There are no functional changes in this patch

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 89dcb72869cd..210f90a6229a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3984,6 +3984,29 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
 	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
 }
 
+static inline void
+ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
+			  ext4_lblk_t start, ext4_lblk_t end)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
+	struct ext4_prealloc_space *tmp_pa;
+	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
+		spin_lock(&tmp_pa->pa_lock);
+		if (tmp_pa->pa_deleted == 0) {
+			tmp_pa_start = tmp_pa->pa_lstart;
+			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+
+			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
+		}
+		spin_unlock(&tmp_pa->pa_lock);
+	}
+	rcu_read_unlock();
+}
+
 /*
  * Normalization means making request better in terms of
  * size and alignment
@@ -4140,18 +4163,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	size = end - start;
 
 	/* XXX: extra loop to check we really don't overlap preallocations */
-	rcu_read_lock();
-	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_inode_list) {
-		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_deleted == 0) {
-			tmp_pa_start = tmp_pa->pa_lstart;
-			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
-
-			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
-		}
-		spin_unlock(&tmp_pa->pa_lock);
-	}
-	rcu_read_unlock();
+	ext4_mb_pa_assert_overlap(ac, start, end);
 
 	/*
 	 * In this function "start" and "size" are normalized for better
-- 
2.31.1

