Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A4FABF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 09:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfKMIWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 03:22:48 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:56658 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKMIW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:29 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191113082226epoutp013a8d8ce3705e5ddbc66485aac21ac6ff~WqzEDnb_Q2730127301epoutp01x
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191113082226epoutp013a8d8ce3705e5ddbc66485aac21ac6ff~WqzEDnb_Q2730127301epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573633346;
        bh=SNfwaZ1SrpMjqg07GVTUxUBoC0uFl6QDgaOnhDyXIss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3LD5YtZ6C1E8GVjl12CnHnkNirzfxJ7wCHMlHlaEHBDkFo2EFJnFl/x/pH17eTJm
         UPxmQrWP4khlBCiDUvJzIPMJ07rizxafma6lQiFhu0orvDBm3OI97dQ3UnLzgxszjf
         KLJ42BHiXOX/6hDYxlMMvF1t42vuWulYqjA490qM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191113082226epcas1p4a3f050e684458a43ee81d4afbd0b3d5b~WqzD0OBhe3012230122epcas1p4s;
        Wed, 13 Nov 2019 08:22:26 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47Cczj6V1MzMqYkh; Wed, 13 Nov
        2019 08:22:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.93.04068.14DBBCD5; Wed, 13 Nov 2019 17:22:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191113082224epcas1p44018da1790279ac6d2fbb51105c121ba~WqzCLhNL-3079030790epcas1p4h;
        Wed, 13 Nov 2019 08:22:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113082224epsmtrp2de85e54fcd71e273f916b29d474f7854~WqzCKyRw72310523105epsmtrp2f;
        Wed, 13 Nov 2019 08:22:24 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-54-5dcbbd418ca2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.84.24756.04DBBCD5; Wed, 13 Nov 2019 17:22:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082224epsmtip11bde97e9816d5d172838127e7da96b0e~WqzCAAVkC2165921659epsmtip1k;
        Wed, 13 Nov 2019 08:22:24 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 13/13] MAINTAINERS: add exfat filesystem
Date:   Wed, 13 Nov 2019 03:18:00 -0500
Message-Id: <20191113081800.7672-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUYRTlc3ZmR2lr2KwuBrUOCL3M3da1MdxSkhhoowUpKpBtcKdV2hc7
        q1iBSdFLSs0U0xSV0sg0N13KfKRoT3uhlrmSBD0kQ0yzLK2kHcce/84995xzL/f7SEw5joeQ
        KXY377JzVpoIkt3oXKkOj2t9lKierCKYoxfrCObK1bsBzMvBAYxpaX0oY3qbSgjme+Fhxjtz
        B2d6Po3JYkn2VvGgnG0rrZGzzb5Mgs32ViN2on4Z23FzhDASe6wxyTxn5l0q3p7kMKfYLXp6
        a4Jps0kXpdaEa6KZ9bTKztl4PR1vMIZvSbH696FVaZw11U8ZOUGgIzbGuBypbl6V7BDcepp3
        mq1Ojdq5VuBsQqrdsjbJYdugUavX6fzKvdbk/L423DmJpw9k58kyUSaehQJJoCLh1KkyPw4i
        lVQjgv7bH+RS8RnBx5bHAVIxiaC36tVfS27f8zlVK4K6torZxqxlqkiXhUiSoFbDT+8ikQ6m
        NkHDhXaZqMeoEgSNZ4qR2FhIMXBkXAwKJGVUGLzwzRAiVlAxMDL4FEnDlsNVTzsmZgb6+b5a
        vZgDlIeAae/Y3ELxcK7mzJx+IXy875VLOAQmRlsJ0QvUIRhvwyT6JIIP3/QS1oKvzoOLEoxa
        CXVNERIdCrd+lM4mYtR8GP16GpdSFHDyuFKShEF2T2eAhJdC1omxuaEsNHR+I6Tr5CD4kufD
        c9Gy4n8TyhGqRot5p2Cz8ILGqfv/verR7HdbFd2I7j01dCCKRPQ8BVR0JSpxLk04YOtAQGJ0
        sKIx/UGiUmHmDhzkXQ6TK9XKCx1I57/jWSxkUZLD/3ntbpNGt06r1TKRUeujdFp6iSLucmWi
        krJwbn4/zzt51x9fABkYkok2Db+d8QxhRQNVRnQx9BqZ0Ty97V2P4UkB4enOk73fFm9R5VRQ
        kSVrdr/N2Os2j/hO54fV7tx3vn+jMTa9fIW83hStgqjKzvbC7oRHu4LKNOx1w6/hZ66W3QOK
        iKnecno041L/+JsK1XCctauga3slyxzrVg4tMOx4HTlBG/bRMiGZ06zCXAL3G+rAUeGEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnK7D3tOxBs8e61g0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MKdf2sxZ8Y6241TeJpYGxgbWLkZNDQsBEYsK1
        K+xdjFwcQgK7GSWmf/7ECJGQljh24gxzFyMHkC0scfhwMUTNB0aJU7tPMILE2QS0Jf5sEQUp
        FxFwlOjddZgFpIZZYBGjxLuPk8EWCAtYSDR9BFnAycEioCpx9eY/NhCbV8BG4s3dc1C75CVW
        bzgAtosTKH5trS1IWEjAWuLr2wPMExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vO
        z93ECA5CLc0djJeXxB9iFOBgVOLhlVh4KlaINbGsuDL3EKMEB7OSCO+OihOxQrwpiZVVqUX5
        8UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTAmrlb6KBCjazbh+Oz8V33u
        ltyfLq7VYnPifXLILsK8bdrO3VP9sw/HN8tPUf+obhm/Wf5T1YqejsOibwW2/8yYcV0gQ3Gp
        xXQPaWenkCRerp+aoU7B4idMX06si5Xi29t388+5k6/O1M+r+bJ39nmmqT8rOnIkz60OPNV+
        4NCquXPD7+1s2jhNiaU4I9FQi7moOBEA06+xvz4CAAA=
X-CMS-MailID: 20191113082224epcas1p44018da1790279ac6d2fbb51105c121ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082224epcas1p44018da1790279ac6d2fbb51105c121ba
References: <20191113081800.7672-1-namjae.jeon@samsung.com>
        <CGME20191113082224epcas1p44018da1790279ac6d2fbb51105c121ba@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself and Sungjong Seo as exfat maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2d80079dccc..18c2629b67d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6216,6 +6216,13 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
+EXFAT FILE SYSTEM
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sungjong Seo <sj1557.seo@samsung.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/exfat/
+
 EXFAT FILE SYSTEM
 M:	Valdis Kletnieks <valdis.kletnieks@vt.edu>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.17.1

