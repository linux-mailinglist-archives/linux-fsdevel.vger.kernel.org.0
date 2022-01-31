Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8559F4A4A47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbiAaPRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:17:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244544AbiAaPRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:17:21 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VFBxmg029898;
        Mon, 31 Jan 2022 15:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3h2Jmvgu/Oj0kwsrV8X7R0zbAkGu0EdRMUYkCyXzlGQ=;
 b=XShyzl8TU5Xc1lfjBpwwdoMOf4nDkIVFbeS8pb0AeWJV9NPbeLK7jDxy+oUPyoznYifJ
 iUUA8Oplrjc0IcuG+P1kGBzUbGAbjDGcSGuFo3qsUQfga+SienhZtVJzON3IS7QY4CQ+
 1hGYhZeRkKujqHw7oxR8FaLijamO12Ldag7usYl3Mqgkh34j+sPng7m5zm9GsSDfmCVZ
 KiFIroSAWmd8O+iEjcgEfaEblQijsPYHz7visD2adYNZno+fTUqHOKKI3RLKESkHorKm
 xiI7s/WmcK4LRQMIJRVRQb4KbofnSYU3IcK8sybDfN0qRNk33hI7Z9aiCtEaFhp4TaRz LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxj6t03n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:17 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VFDNsC005228;
        Mon, 31 Jan 2022 15:17:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxj6t03me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VFCDTx009222;
        Mon, 31 Jan 2022 15:17:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3dvw79csxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VFHDQc43975004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:17:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4C7DA4059;
        Mon, 31 Jan 2022 15:17:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76834A405E;
        Mon, 31 Jan 2022 15:17:12 +0000 (GMT)
Received: from localhost (unknown [9.43.5.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 15:17:12 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 4/6] ext4: No need to test for block bitmap bits in ext4_mb_mark_bb()
Date:   Mon, 31 Jan 2022 20:46:53 +0530
Message-Id: <65ffc304d66815b6e3270f71e5d756b307d3c5be.1643642105.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643642105.git.riteshh@linux.ibm.com>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9HFRfCNzmaW7b4-X8zPsbDQtCUaQt7Bi
X-Proofpoint-ORIG-GUID: G7BaB9Xvklv1gys-AsyL2QyQHn21QwJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_06,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=802 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need the return value of mb_test_and_clear_bits() in ext4_mb_mark_bb()
So simply use mb_clear_bits() instead.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 60d32d3d8dc4..2f931575e6c2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3943,7 +3943,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	if (state)
 		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
 	else
-		mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
+		mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
 	if (ext4_has_group_desc_csum(sb) &&
 	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
-- 
2.31.1

