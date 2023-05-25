Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7392E710B08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbjEYLdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjEYLdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6227B12F;
        Thu, 25 May 2023 04:33:32 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PADGRW007782;
        Thu, 25 May 2023 11:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jpKB/Cu0/a1TyjNxyFz/CQQnLADMgzFNjxzQ90nNq90=;
 b=sA0AQO9Q+YNzM2U1zto0nyIOz8C6AYci3kcsoxF5VKlFuBQETRIgVdekzHB0B+XoiYbQ
 CDyREf9jG2ybza6v5ZtxEUFdL0ZhFGKFp0nskW4f/o+lCzr0P7oQoi0IQQvxiXUHou1s
 wb1QZmH7e5cjVVgGSGMV516UM79KG40hcqj7ZKNjMeZ3FmWDfJvq/1bLcaxUdIki+MNF
 fRFbo66WtXimP6wBBE0+l3KpUp31RKh2tWPC4Vt6maNthihK12EX1wFt8dEe1AP7g5+L
 R8e6ylEh3yfOEhYORBbvxNVS7YxtzRe4xxNI3itzwnrXXKzv9tSTlAWukALsplr1xku5 cw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt5ktj3gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:24 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P5qoG4013258;
        Thu, 25 May 2023 11:33:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qppcf20qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXKNE60948806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F403D2004D;
        Thu, 25 May 2023 11:33:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 251922004B;
        Thu, 25 May 2023 11:33:18 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:17 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH 04/13] ext4: Fix a small typo in ext4_mb_prefetch_fini()
Date:   Thu, 25 May 2023 17:02:58 +0530
Message-Id: <39e9a6c41244ecd49552262af51aa8aa5ae1bc9d.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _3Qfh_YVxRUizpHRJGoOMHnYi5tYNjzM
X-Proofpoint-GUID: _3Qfh_YVxRUizpHRJGoOMHnYi5tYNjzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a small typo in the if condition introduced in the
commit b6bef1b5.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 288d504ee744..72c5d1a33bad 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2609,7 +2609,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		gdp = ext4_get_group_desc(sb, group, NULL);
 		grp = ext4_get_group_info(sb, group);
 
-		if (grp && grp && EXT4_MB_GRP_NEED_INIT(grp) &&
+		if (gdp && grp && EXT4_MB_GRP_NEED_INIT(grp) &&
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
 		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
-- 
2.31.1

