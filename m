Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591D84D9D84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbiCOOa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349170AbiCOOaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:30:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B95520C;
        Tue, 15 Mar 2022 07:29:11 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FDTRnY000974;
        Tue, 15 Mar 2022 14:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=FLU9puj/Xqg6RFneYuMWVXxMv3H+XMSCS5Uotgaugv8=;
 b=gUr2CJaOj8rrBgni6xw8ufnVFnrUcJ1WsmwMWDkRsgmkFISPVyMTiIMhaHInzEQ8yopq
 BhWt36nRco+rozuBt1bJVOG6wZjJcBoAuPCrLUI7UMdR3Dx6hDh6UHGVOjg7z2DStbqB
 k/6a1hegfCfkDFAgs6QcNWpxug18HiGPg1y2NzMLrSaBlXLl3l9HDTX++MQblodYZtYj
 KVuQorV19Tfmd0hBMu402SqOZaakEvqEGpXTU9OV+2QvDMnbDRvkCNF3WsyIVyEIGuBF
 3Pqa5cIp9Zue7rqyV3K5eapmVqFY7Vnpnq7mdeQjHDIJpGNCQqpTwVH8nufYB6fwVuni YA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3etuqvsg33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FET8xR026817;
        Tue, 15 Mar 2022 14:29:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3erk58ntnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FET6Dl33358274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:29:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21D0E11C050;
        Tue, 15 Mar 2022 14:29:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A73DE11C04C;
        Tue, 15 Mar 2022 14:29:05 +0000 (GMT)
Received: from localhost (unknown [9.43.32.151])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Mar 2022 14:29:05 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/4] generic/468: Add another falloc test entry
Date:   Tue, 15 Mar 2022 19:58:56 +0530
Message-Id: <08bd90fa8c291a4ccba2e5d6182a8595b7e6d7ab.1647342932.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1647342932.git.riteshh@linux.ibm.com>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UpLqvbReOIrdLH9wmoRjQOnuSZJLPPWb
X-Proofpoint-ORIG-GUID: UpLqvbReOIrdLH9wmoRjQOnuSZJLPPWb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=715 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203150092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add another falloc test entry which could hit a kernel bug
with ext4 fast_commit feature w/o below kernel commit [1].

<log>
[  410.888496][ T2743] BUG: KASAN: use-after-free in ext4_mb_mark_bb+0x26a/0x6c0
[  410.890432][ T2743] Read of size 8 at addr ffff888171886000 by task mount/2743

This happens when falloc -k size is huge which spans across more than
1 flex block group in ext4. This causes a bug in fast_commit replay
code which is fixed by kernel commit at [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/generic/468     | 4 ++++
 tests/generic/468.out | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tests/generic/468 b/tests/generic/468
index 95752d3b..cbef9746 100755
--- a/tests/generic/468
+++ b/tests/generic/468
@@ -34,6 +34,9 @@ _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount

+blocksize=4096
+fact=18
+
 testfile=$SCRATCH_MNT/testfile

 # check inode metadata after shutdown
@@ -85,6 +88,7 @@ for i in fsync fdatasync; do
 	test_falloc $i "-k " 1024
 	test_falloc $i "-k " 4096
 	test_falloc $i "-k " 104857600
+	test_falloc $i "-k " $((32768*$blocksize*$fact))
 done

 status=0
diff --git a/tests/generic/468.out b/tests/generic/468.out
index b3a28d5e..a09cedb8 100644
--- a/tests/generic/468.out
+++ b/tests/generic/468.out
@@ -5,9 +5,11 @@ QA output created by 468
 ==== falloc -k 1024 test with fsync ====
 ==== falloc -k 4096 test with fsync ====
 ==== falloc -k 104857600 test with fsync ====
+==== falloc -k 2415919104 test with fsync ====
 ==== falloc 1024 test with fdatasync ====
 ==== falloc 4096 test with fdatasync ====
 ==== falloc 104857600 test with fdatasync ====
 ==== falloc -k 1024 test with fdatasync ====
 ==== falloc -k 4096 test with fdatasync ====
 ==== falloc -k 104857600 test with fdatasync ====
+==== falloc -k 2415919104 test with fdatasync ====
--
2.31.1

