Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB24A4A4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378485AbiAaPRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:17:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26406 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240373AbiAaPRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:17:25 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VEur1u010872;
        Mon, 31 Jan 2022 15:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hzj8OtjaHAKx1NBUesa1KhmUxfrFA80XTWFu10bdNys=;
 b=l8tHupMjW7z+WGncufxjtUmECUOZ5hQv2yRX6I2b3s31KfFztTlQJM7wrUU2Fntx0135
 /EnU+C6v/szXIjAOMCfAt1YtMsoQ6/kInCsuqCQcpy/MddEACE3MlaAaTq7FJkTbsrKc
 FDO5SVKcqF12EtrPxP5ErlN/PjubhMNh9mfEOkDAhbr0PbPKgXkgWdjrbHrz5nbAcXi0
 j4rHBXsn2CKWaxNyspJkcLYDRjPBsBZXtEP1ksTPHRsz7WKzJsmlrlsASIDanfjJKjcR
 3tRMd274eSYAVrdOpYl2khtvqaFBIm3PgCfcQkoj3Dg3Wdm0oButKOv3FX0dF1ZqpDzQ iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxhm3s4fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:21 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VEVjp1026662;
        Mon, 31 Jan 2022 15:17:21 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxhm3s4eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VFCL8h004535;
        Mon, 31 Jan 2022 15:17:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dvvuj4wrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VFHGm646465374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:17:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C7A04C059;
        Mon, 31 Jan 2022 15:17:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3EE64C05C;
        Mon, 31 Jan 2022 15:17:15 +0000 (GMT)
Received: from localhost (unknown [9.43.5.245])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 15:17:15 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 6/6] ext4: Add extra check in ext4_mb_mark_bb() to prevent against possible corruption
Date:   Mon, 31 Jan 2022 20:46:55 +0530
Message-Id: <fa6d3adad7e1a4691c4c38b6b670d9330757ce82.1643642105.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643642105.git.riteshh@linux.ibm.com>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: isukeKH1Qu1x8SrxLPQ8yJYltflnbAZW
X-Proofpoint-GUID: 7UNt2fYuUgAYGvtKEeB320kit2nBQrQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_06,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=627 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds an extra checks in ext4_mb_mark_bb() function
to make sure we mark & report error if we were to mark/clear any
of the critical FS metadata specific bitmaps (&bail out) to prevent
from any accidental corruption.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5f20e355d08c..c94888534caa 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3920,6 +3920,13 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 		len -= overflow;
 	}
 
+	if (!ext4_group_block_valid(sb, group, block, len)) {
+		ext4_error(sb, "Marking blocks in system zone - "
+			   "Block = %llu, len = %d", block, len);
+		bitmap_bh = NULL;
+		goto out_err;
+	}
+
 	clen = EXT4_NUM_B2C(sbi, len);
 
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
-- 
2.31.1

