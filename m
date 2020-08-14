Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28673244301
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 04:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHNC1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 22:27:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:15967 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHNC1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:27:15 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200814022713epoutp0209f61c9cf7eb21e8a9d72c62b9da567d~rAWbOLK4G1545015450epoutp02K
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2020 02:27:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200814022713epoutp0209f61c9cf7eb21e8a9d72c62b9da567d~rAWbOLK4G1545015450epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597372033;
        bh=MIG/bbNGLuaMWJ/EfwZO+2MOD+efwae9X1/0CUFZm4U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Xlf/Zy+DS1humk2q3/5apsWaLvhs+7pX2HlP5jg4cuYaxW7Dy31dTNyZjPwNq3O0n
         u9pVvHKWVrI6efg/he89YRIu9qMCdFLYAzXv1nOnHFPs9b3w5jmkA73a/b/7dWdbtI
         vldkw2mWP0YLq6DqD5sc0o67CcmU8uVDnAH3Bto0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200814022713epcas1p21e806300b5da3157380c491af04a2f2f~rAWasIx0M1142111421epcas1p2M;
        Fri, 14 Aug 2020 02:27:13 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BSS4w2J4qzMqYkZ; Fri, 14 Aug
        2020 02:27:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.2D.28581.F76F53F5; Fri, 14 Aug 2020 11:27:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200814022710epcas1p336eb6fe9619998742f1c5c60a0d597cc~rAWYgsxns1867918679epcas1p30;
        Fri, 14 Aug 2020 02:27:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200814022710epsmtrp2df169b10a75061145a236e3329a6fb1d~rAWYgFZ_A1486114861epsmtrp2S;
        Fri, 14 Aug 2020 02:27:10 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-fd-5f35f67f82f5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.07.08382.E76F53F5; Fri, 14 Aug 2020 11:27:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200814022710epsmtip16edc9bd2f3ca907646c4020777e3402b~rAWYZIYIg2328323283epsmtip1Y;
        Fri, 14 Aug 2020 02:27:10 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     kohada.t2@gmail.com, kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        sj1557.seo@samsung.com, sedat.dilek@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH] exfat: fix misspellings using codespell tool
Date:   Fri, 14 Aug 2020 11:21:36 +0900
Message-Id: <20200814022136.11296-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7bCmrm79N9N4g1WbxSx+zL3NYvHm5FQW
        iz17T7JY/Jheb7Fu6gkWiy3/jrA6sHk0H1vJ5rFz1l12j74tqxg9Pm+SC2CJyrHJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
        0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07MLS7NS9dLzs+1MjQwMDIFqkzIybg+6TNjwQLe
        ihPHX7A1MN7n6mLk5JAQMJFY03+VtYuRi0NIYAejxLrdt9khnE+MEi+P9DBBON8YJZpunGKG
        aZmydi8bRGIvo8SBeR9YQBJgLUe2FXYxcnCwCWhL/NkiCmKKCChKXH7vBFLOLDCfUWL21gWM
        IOXCArYSn2c9YgKxWQRUJVrvrQKzeQVsJLoWNrND7JKXWL3hADNIs4TAInaJp5MPQB3hIvHr
        03sWCFtY4tXxLVANUhKf34EcxwFkV0t83A9V3sEo8eK7LYRtLHFz/QZWkBJmAU2J9bv0IcKK
        Ejt/zwU7jVmAT+Ld1x5WiCm8Eh1tQhAlqhJ9lw4zQdjSEl3tH6CWekg0HjrGDAmEWInOqz8Y
        JzDKzkJYsICRcRWjWGpBcW56arFhgQlyFG1iBKcmLYsdjHPfftA7xMjEwXiIUYKDWUmEl/my
        cbwQb0piZVVqUX58UWlOavEhRlNgcE1klhJNzgcmx7ySeENTI2NjYwsTM3MzU2Mlcd6HtxTi
        hQTSE0tSs1NTC1KLYPqYODilGpiaKls8d7HdPNOzQzWEQ8Jx7c2jtRkPld8brtyrOndr/TMG
        SXOXHz1ugUsmH/g4dw6vhHbL88feqnn6Zz+sqfL75h/7zEnKSiphw8RuP7vgT459tiau8j9O
        f/g2LfDAon9bk+R15qQwcHXzzcwWkyw9phD6x1vnoMqFBr/4lrcfLujnsEbsfeS9IsOh1e/a
        xpSwvdsepTzayxKw3c76EqNJjIaXudrFFbmH9M5v731vcDt6qWbmlX2NB/d9P/nKS7ydmUs2
        b5VDyVuOGr+Vi2o5c8oqtmyStWVTPPlRzVLoOEu7SrVKm07l89Tlvh8muv5ieXw4hGN2h8Je
        +Yw5d431A0ycLGfbGYpys3A+UmIpzkg01GIuKk4EAL5WtSfWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsWy7bCSnG7dN9N4g1PTLS1+zL3NYvHm5FQW
        iz17T7JY/Jheb7Fu6gkWiy3/jrA6sHk0H1vJ5rFz1l12j74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mq4PukzY8EC3ooTx1+wNTDe5+pi5OSQEDCRmLJ2L1sXIxeHkMBuRoktWx8yQiSkJY6d
        OMPcxcgBZAtLHD5cDFHzgVGi4dMxsDibgLbEny2iIKaIgKLE5fdOICXMAosZJZbd6WIBGSMs
        YCvxedYjJhCbRUBVovXeKjCbV8BGomthMzvEKnmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAw
        L7Vcrzgxt7g0L10vOT93EyM4WLQ0dzBuX/VB7xAjEwfjIUYJDmYlEV7my8bxQrwpiZVVqUX5
        8UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgtgskycXBKNTDlCzsuTvc9Z7N7g0PrhuZP
        U/Jv7zvXbzrtyrpWNqMzcYUNnTv/7QlhEirtWOE8f8G0lUs+Nx85XNph9zkq5b3iwflnNtkp
        vy3ep70si3/73zJ5o92PApdXSHziWaief7SaTXJBzW57P06li5fVD+6q1q+MttrwTd2TXV1x
        yuXlkipLGOUNZwk8nL13X9zV60lzrt196GN2N7oqKWfVmWcbmY99s8rVOrhz+38h7pNf+aru
        aiy92Wq5xadyx+PQMnNWTk7ZJynOoUkRmhdrHtyxNP2fOD9H7aPZ1u6PiW/Xbgw4FLbM6rtZ
        0aE9iyeGyu05oORzOvho2/U9h1e9eZHdovmj+jlP7LcNq2yfbtF6pMRSnJFoqMVcVJwIAFcm
        pCGFAgAA
X-CMS-MailID: 20200814022710epcas1p336eb6fe9619998742f1c5c60a0d597cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200814022710epcas1p336eb6fe9619998742f1c5c60a0d597cc
References: <CGME20200814022710epcas1p336eb6fe9619998742f1c5c60a0d597cc@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sedat reported typos using codespell tool.

 $ codespell fs/exfat/*.c | grep -v iput
 fs/exfat/namei.c:293: upto ==> up to
 fs/exfat/nls.c:14: tabel ==> table

 $ codespell fs/exfat/*.h 
 fs/exfat/exfat_fs.h:133: usally ==> usually

Fix typos found by codespell.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 fs/exfat/exfat_fs.h | 2 +-
 fs/exfat/namei.c    | 2 +-
 fs/exfat/nls.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 95d717f8620c..44dc04520175 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -128,7 +128,7 @@ enum {
 
 struct exfat_dentry_namebuf {
 	char *lfn;
-	int lfnbuf_len; /* usally MAX_UNINAME_BUF_SIZE */
+	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
 };
 
 /* unicode name structure */
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e73f20f66cb2..2aff6605fecc 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -290,7 +290,7 @@ static int exfat_check_max_dentries(struct inode *inode)
 {
 	if (EXFAT_B_TO_DEN(i_size_read(inode)) >= MAX_EXFAT_DENTRIES) {
 		/*
-		 * exFAT spec allows a dir to grow upto 8388608(256MB)
+		 * exFAT spec allows a dir to grow up to 8388608(256MB)
 		 * dentries
 		 */
 		return -ENOSPC;
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index a3c927501e67..675d0e7058c5 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -11,7 +11,7 @@
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
-/* Upcase tabel macro */
+/* Upcase table macro */
 #define EXFAT_NUM_UPCASE	(2918)
 #define UTBL_COUNT		(0x10000)
 
-- 
2.17.1

