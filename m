Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8406D1020F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfKSJkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:40:45 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:14118 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfKSJkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:40:33 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191119094030epoutp04587c567663421d9cd3ef7c0c27fa8cfe~Yhu8EkFKI0888908889epoutp04Y
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191119094030epoutp04587c567663421d9cd3ef7c0c27fa8cfe~Yhu8EkFKI0888908889epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574156430;
        bh=qOKAH/xLKFcgxQkDaZUSWSDe5GuU0Alfu+G9AfD13f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5SstefjLfER0KVgHoZ4QIpuK4sd/nDB0lr7xzTb3ZYVwz2/OqW+gKCOePopFhsfO
         0THhlIHcq9htLDB6PgtDniNQZ1JIt+6CmSDzXiaEbthk025iz9KCRqN1EKvaVgKB/c
         H21XqWV5MzzwBnXiI5VBADTolHIo2xDmad0hYO4s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191119094030epcas1p2f80550ea22fa01d8281f6a3a08584ce9~Yhu7kOKRY0594305943epcas1p2B;
        Tue, 19 Nov 2019 09:40:30 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47HLR15tmFzMqYlv; Tue, 19 Nov
        2019 09:40:29 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.17.04080.C88B3DD5; Tue, 19 Nov 2019 18:40:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191119094028epcas1p1b69cd151e3e574859a34e3a931d48cf2~Yhu5e1Sbf1202912029epcas1p1n;
        Tue, 19 Nov 2019 09:40:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119094028epsmtrp11752626f62460a50efbd63a3ddfac27e~Yhu5eNoNz0080100801epsmtrp1u;
        Tue, 19 Nov 2019 09:40:28 +0000 (GMT)
X-AuditID: b6c32a37-7cdff70000000ff0-cd-5dd3b88c353a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.12.03654.B88B3DD5; Tue, 19 Nov 2019 18:40:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094027epsmtip26fb07c57a37db5118d506c3c4b73852f~Yhu5RX4eu0708907089epsmtip2I;
        Tue, 19 Nov 2019 09:40:27 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3 13/13] MAINTAINERS: add exfat filesystem
Date:   Tue, 19 Nov 2019 04:37:18 -0500
Message-Id: <20191119093718.3501-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119093718.3501-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTV7dnx+VYgwvnhS0OP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eost/46wWlx6/4HFgctj56y77B77565h
        99h9s4HNo2/LKkaPzaerPT5vkvM4tP0Nm8ftZ9tYAjiicmwyUhNTUosUUvOS81My89JtlbyD
        453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgE5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
        l9gqpRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZFy5spG54Btrxc3GtUwNjA2sXYyc
        HBICJhIXp8xg62Lk4hAS2MEo8XpSAyOE84lRYvWPfywQzjdGiQO7b7LDtHx9+54JxBYS2Mso
        Me24BVxHU9MioFkcHGwC2hJ/toiC1IgI2Etsnn0AbBCzwBFGiRdfJoANEhawlth+4BeYzSKg
        KvFm0huwobwCNhI3P7+Huk9eYvWGA8wgNidQ/OHsZWDnSQicYJNYfuMvI0SRi8ST01OhrhOW
        eHV8C5QtJfGyv40d5CAJgWqJj/uZIcIdQEd8t4WwjSVurt/AClLCLKApsX6XPkRYUWLn77lg
        05kF+CTefe1hhZjCK9HRJgRRoirRd+kwE4QtLdHV/gFqkYfE/ZUOkBDpZ5T4cOw9+wRGuVkI
        CxYwMq5iFEstKM5NTy02LDBGjq9NjOAUqGW+g3HDOZ9DjAIcjEo8vArql2OFWBPLiitzDzFK
        cDArifD6PboQK8SbklhZlVqUH19UmpNafIjRFBiOE5mlRJPzgek5ryTe0NTI2NjYwsTM3MzU
        WEmcl+PHxVghgfTEktTs1NSC1CKYPiYOTqkGRh4+09qznxJVtnK1XXE8PFN0h8sVE7G+2Lc7
        fyw/6ly4pk+Vp3H130fMy3dbnfr7Yn9xIlfnJ9Z9Ar8v9TtsfXk8Lyz02flJTRPnVUyf9GGi
        SX1VlvBBlugfSf7ijmcinzB4mnps6Eq8n/bGRMxJxdBr3447Jju076/tyjUW/FscJR3rryRR
        osRSnJFoqMVcVJwIAKWEaL+XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvG7PjsuxBucuM1ocfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9RZb/h1htbj0/gOLA5fHzll32T32z13D
        7rH7ZgObR9+WVYwem09Xe3zeJOdxaPsbNo/bz7axBHBEcdmkpOZklqUW6dslcGVcubKRueAb
        a8XNxrVMDYwNrF2MnBwSAiYSX9++Z+pi5OIQEtjNKLHxzjpmiIS0xLETZ4BsDiBbWOLw4WKI
        mg+MEl9OzWQFibMJaEv82SIKUi4i4CjRu+swC0gNs8A5Romdz5YxgiSEBawlth/4xQ5iswio
        SryZ9IYJxOYVsJG4+fk91BHyEqs3HADbywkUfzgbolcIqLfxUTP7BEa+BYwMqxglUwuKc9Nz
        iw0LDPNSy/WKE3OLS/PS9ZLzczcxgoNVS3MH4+Ul8YcYBTgYlXh4T6hcjhViTSwrrsw9xCjB
        wawkwuv36EKsEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxS
        DYyr0k6Z1vRoBF52tGnLSznavt522YrJc7Xr/bb88l6j0nQ37LML/3rRVy/dKrse39v4ksmY
        tVGv7WuqvO6n3hWd15g+1FssOdp/bOPdEAlzl/w3ji6fuDe+Fu3vmJReISLhMXX7R5b+zqk+
        l/7qPTdeZd0Q2Pjnneql3Sulo4t3H2eccDxM6JISS3FGoqEWc1FxIgAvoKWRUgIAAA==
X-CMS-MailID: 20191119094028epcas1p1b69cd151e3e574859a34e3a931d48cf2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094028epcas1p1b69cd151e3e574859a34e3a931d48cf2
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
        <CGME20191119094028epcas1p1b69cd151e3e574859a34e3a931d48cf2@epcas1p1.samsung.com>
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
index 89cb4dd0924d..0001db230e4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6215,6 +6215,13 @@ F:	include/trace/events/mdio.h
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

