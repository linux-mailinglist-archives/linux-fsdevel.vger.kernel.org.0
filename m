Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF47512E3D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgABIYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:24:31 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:56241 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgABIYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:24:14 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200102082410epoutp016746fb00529a195dbde234892c3e1d9c~mBE2Y4_nj1725517255epoutp01C
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 08:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200102082410epoutp016746fb00529a195dbde234892c3e1d9c~mBE2Y4_nj1725517255epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577953450;
        bh=2AiL0/FzT0N/kY6Jou6rW2xmbfEd/9y88c2eKhesSjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKkcfLgwiVRdYXugbK3Dq8cMb9qa59oIjxGlKMl1LK5UWwSi2E0k93TU+tPvZklnN
         seCOxgiE4bH7vHANKTdQMrFT8sfzpBjhCz/KBDy0/fjS9q+h8pgnvS7C2pX0wCjInO
         L+PaZch9knkg+ZXV69KKHdqquFV/Qw2u6dV2EdJA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200102082410epcas1p423fbe9b8c327492fbb37e9018f9ff074~mBE2IbVEI0674706747epcas1p4a;
        Thu,  2 Jan 2020 08:24:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47pLfd6Y0CzMqYlx; Thu,  2 Jan
        2020 08:24:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.C7.52419.9A8AD0E5; Thu,  2 Jan 2020 17:24:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200102082409epcas1p4210cf0ea40d23689c4a5ba18b50979cf~mBE1T0rsd0403204032epcas1p4B;
        Thu,  2 Jan 2020 08:24:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200102082409epsmtrp219f410e8b13e7546bf48a37077fc2719~mBE1TOD5u2039720397epsmtrp2e;
        Thu,  2 Jan 2020 08:24:09 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-e3-5e0da8a92387
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.68.10238.9A8AD0E5; Thu,  2 Jan 2020 17:24:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082409epsmtip2cd61cfe722b61178a85c898a31c373e8~mBE1Gu1Gs2215622156epsmtip2c;
        Thu,  2 Jan 2020 08:24:09 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v9 13/13] MAINTAINERS: add exfat filesystem
Date:   Thu,  2 Jan 2020 16:20:36 +0800
Message-Id: <20200102082036.29643-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102082036.29643-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmru7KFbxxBnN7zSyaF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+stJp7+zWSx5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YAtiicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhToFSfm
        Fpfmpesl5+daGRoYGJkCVSbkZMzdvJit4BtrRdek/AbGBtYuRk4OCQETiYb9N4FsLg4hgR2M
        EhcP72aDcD4xShyZvg3K+cYo8X77EyaYlp1XT7JDJPYySnz5f5QZruXqvauMXYwcHGwC2hJ/
        toiCNIgI2Etsnn2ABaSGWWATo8Se+V9ZQWqEBawlDmyQAqlhEVCVmL3pADOIzStgK/Hu70qo
        ++QlVm+AiHMCxWe+bwW7SEJgC5vEh9U7GCGKXCTOv13DDmELS7w6vgXKlpL4/G4vG8guCYFq
        iY/7mSHCHYwSL77bQtjGEjfXbwA7h1lAU2L9Ln2IsKLEzt9zwaYzC/BJvPvawwoxhVeio00I
        okRVou/SYWiQSEt0tX+AWuohce7NV0ZIiExglJhxdxnrBEa5WQgbFjAyrmIUSy0ozk1PLTYs
        MEaOr02M4DSnZb6DccM5n0OMAhyMSjy8N+bxxAmxJpYVV+YeYpTgYFYS4S0P5I0T4k1JrKxK
        LcqPLyrNSS0+xGgKDMiJzFKiyfnAFJxXEm9oamRsbGxhYmZuZmqsJM7L8eNirJBAemJJanZq
        akFqEUwfEwenVANj+cIsEe+g06dc9aoyq5mU3jzom/MitqrsxZ12oe65m+7NOt34r+XGlXLT
        Gd6c3PcPp3AyyG37vyDwxC6Vm3tcWISktSL+Bdd2zMvdvrPdoeYmT+7KmUVvjiu2u0Zo7Dsi
        fXkK18T5Ms0bs88d6d/hr77vx2zTAta2SnXu/wt/8Wac4Z8/KeOkEktxRqKhFnNRcSIAAySL
        bYkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO7KFbxxBg+eyls0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBFcdmkpOZklqUW6dslcGXM3byYreAba0XXpPwGxgbWLkZODgkB
        E4mdV0+ydzFycQgJ7GaU2LlgBTtEQlri2IkzzF2MHEC2sMThw8UQNR8YJWbO3sQCEmcT0Jb4
        s0UUpFxEwFGid9dhFpAaZoFdjBInTp9mBKkRFrCWOLBBCqSGRUBVYvamA8wgNq+ArcS7vyuh
        bpCXWL0BIs4JFJ/5vpUNxBYSsJF49e8x2wRGvgWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYKDUUtzB+PlJfGHGAU4GJV4eG/M44kTYk0sK67MPcQowcGsJMJbHsgbJ8SbklhZ
        lVqUH19UmpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVAPj9Oc37fboLzu0PmXG
        7zhOuZp3v9ZEnV3Ddn/O0SiBAqdZCeV3eYR3Rbas+nyUJ2hpZF4Y/+O0PbpVzY3Wm4P+2J3a
        L34g4a9i6nkhWdXqFf9zb2wPZ5meKcu/WrTWxOkv64sJOToaO6Zvn6DXzyCXFbCOxUzVOTXH
        sP/sVZHa8LlWFrXeASlKLMUZiYZazEXFiQChoV6zQgIAAA==
X-CMS-MailID: 20200102082409epcas1p4210cf0ea40d23689c4a5ba18b50979cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082409epcas1p4210cf0ea40d23689c4a5ba18b50979cf
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082409epcas1p4210cf0ea40d23689c4a5ba18b50979cf@epcas1p4.samsung.com>
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
index 7b626563fb3c..aa03dd5c34e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6237,6 +6237,13 @@ F:	include/trace/events/mdio.h
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

