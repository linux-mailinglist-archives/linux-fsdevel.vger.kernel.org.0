Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82311CC746
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgEJG0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:26:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44366 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728424AbgEJG0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:26:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A62A0j074487;
        Sun, 10 May 2020 02:25:48 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30xa4gab9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:48 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6K07C003362;
        Sun, 10 May 2020 06:25:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55a13a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:46 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PhnI61669622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABA7C42045;
        Sun, 10 May 2020 06:25:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20A4C4203F;
        Sun, 10 May 2020 06:25:42 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:41 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 13/16] ext4: Replace EXT_DEBUG with __maybe_unused in ext4_ext_handle_unwritten_extents()
Date:   Sun, 10 May 2020 11:54:53 +0530
Message-Id: <ae335b94506cd9db9d2648c1f4dd25a80f9f3ce2.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxlogscore=584 suspectscore=1 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace EXT_DEBUG with __maybe_unused from inside
ext4_ext_handle_unwritten_extents() function.

There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/extents.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 461600c07316..dc980fbc49aa 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3794,9 +3794,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			struct ext4_ext_path **ppath, int flags,
 			unsigned int allocated, ext4_fsblk_t newblock)
 {
-#ifdef EXT_DEBUG
-	struct ext4_ext_path *path = *ppath;
-#endif
+	struct ext4_ext_path __maybe_unused *path = *ppath;
 	int ret = 0;
 	int err = 0;
 
-- 
2.21.0

