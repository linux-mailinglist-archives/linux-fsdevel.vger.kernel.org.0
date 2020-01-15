Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560EE13BAFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAOI2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:53 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37555 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgAOI2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:32 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200115082830epoutp012ef89183736a032978e1dec28f3adb25~qAhVnQm2b1528515285epoutp01r
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200115082830epoutp012ef89183736a032978e1dec28f3adb25~qAhVnQm2b1528515285epoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076910;
        bh=Vl3K76ctdGp141COTWoYQOF+6xn4+/PDupmo6U2ImZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bePGKMYxmVrk6PFU3o2YN2aAq+vqaOPLkHAUBEQWFjQ/4rVom0Uj6UdsS15W7dAo3
         iri5YH643ciSSOBh5P+SwigUyxFGHw72UXlHNv6tRVhfWsE0cKGu/B2ApVnbNV6vl4
         iUVwkXTkLk3ztL0b6Mu3jmqlKvZLHXna3FumUNUE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200115082829epcas1p3209c93f77c6b6fe5c33972db996af650~qAhVCsTtX1260012600epcas1p3S;
        Wed, 15 Jan 2020 08:28:29 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47yL7c5dtpzMqYkt; Wed, 15 Jan
        2020 08:28:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.6E.52419.B2DCE1E5; Wed, 15 Jan 2020 17:28:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200115082826epcas1p3475ce2b4d03234dc96ced428be582eb3~qAhSXqXdQ0883908839epcas1p3y;
        Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115082826epsmtrp1d583802d1489ee3814aba47b6e7efccb~qAhSW6h5O0484504845epsmtrp1L;
        Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-13-5e1ecd2bd3db
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.4A.10238.A2DCE1E5; Wed, 15 Jan 2020 17:28:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082826epsmtip13b5ff6f257339c40dd6564ee20020d24~qAhSKhnrh0110201102epsmtip1j;
        Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 14/14] staging: exfat: make staging/exfat and fs/exfat
 mutually exclusive
Date:   Wed, 15 Jan 2020 17:24:47 +0900
Message-Id: <20200115082447.19520-15-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTURjm3LvdTXFxmZYHI5uXRmnMNuf0Jq6iplyowIi+yXXTi0rb3drd
        JOuHimWyYqb9sNShKCFORcmVzRJ1VmZRpJHah78q6GN9mNmXGe16Z/XvOc/7POd5z3teKSov
        xWKkBaydsbG0icDCRVeH4tWqtfdjs9XuHjk5X31bQpY1d2Jka9sthJyYeoqSN/pGROSj3nqM
        /F5TTFbdm0NI7++bYnLs4yfRpnBq7mc1oHy1UxKq390uoa4/KcEol9cDqJnLsZS/J4BlSfab
        0vMZOpexKRg2x5JbwObpia07jVuMuhS1RqVZT6YSCpY2M3rCsC1LlVlgCrZHKAppkyNIZdEc
        R6zbkG6zOOyMIt/C2fUEY801WTVqayJHmzkHm5eYYzGnadTqJF1QeciUX/bhPWJ1Y8dq5j1I
        CagXO0GYFOLJ8EyTX8RjOX4NQE+32gnCg/gzgK7hUbFw+ArgqdGX6KJj3NscKvQB2N3+DP1r
        udPkA04glWL4WvjLu5Q3ROEbYXfdgIjXoPgggIGHbglfiMSNcPRKB8JjEa6E7vrmhQQZrocz
        3R2YkLYStnUNLPBhQf6m95GEvwjiAxisG6+WCCIDfPy8LGSIhG+HvSE+Br6pLJfwDUH8BJzu
        D72gAsDX3/QC1sInnV1iXoLi8bCzd51Ax0HfnBvwGMWXwA+zZ8XCLTJYUS4XJEroGhtCBLwc
        Ok9/CoVScKK2BQgjOQfgxbsu5ByIrf2X0AiAByxjrJw5j+E0Vu3/H3YZLKxfQuo10PVgmx/g
        UkBEyBTPV2TLxXQhV2T2AyhFiSjZyIUgJculi44zNovR5jAxnB/ogoOsQmOW5liCy8zajRpd
        klarJZNTUlN0WiJaltEYmy3H82g7c4RhrIxt0YdIw2JKQGl5gvxrRMOquC1tgdUzKsMBvS+z
        9PCOjkZka1rzGrjb2zH9IoUxnN280bknQdmeEXg1aY1j2w5Gpc/u6vFFT54aSu1/XDNW1TAZ
        2Lc3HTuvVO59DUAF++PFpR+9rkLDoL2sMtGDXln1rrK1ZaXsfcTR7VRxOahbkqSLEH15d5IQ
        cfm0JgG1cfQfDnTYPJQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnK7WWbk4g0mrdSz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HFgcvj969JjB47Z91l
        99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA9igum5TUnMyy1CJ9uwSujOZ3b5kK5rJVTP+7
        iqmBcQ5rFyMnh4SAicS1LYuBbC4OIYHdjBL792xngkhISxw7cYa5i5EDyBaWOHy4GKLmA6PE
        je5GdpA4m4C2xJ8toiDlIgKOEr27DrOA1DALnGaU6N74EGyOsECsxLa3K8FsFgFViblzFjOD
        2LwCthKfN69lg9glL7F6wwGwOCdQ/MiWy+wgtpCAjcS0JyeZJjDyLWBkWMUomVpQnJueW2xY
        YJiXWq5XnJhbXJqXrpecn7uJERykWpo7GC8viT/EKMDBqMTDq3BHNk6INbGsuDL3EKMEB7OS
        CO/JGUAh3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGKPu
        P5glLMQTsNxwSYzKP6Ngn+CCxlOGyn9rdv3L++npdlJ926HHe313Kd0Onigty/XQ6cS9LdMj
        TP5qGU3ieiK2+LTD60MS6aIujAa8cbvDFPiPzY2cKZbXYJVxmFdtxZy1BU62q07JH8pcxW8Y
        xBjCqGogZbpNeXfSfZ9eZU674LXLgoqMlFiKMxINtZiLihMBVqsQvE4CAAA=
X-CMS-MailID: 20200115082826epcas1p3475ce2b4d03234dc96ced428be582eb3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082826epcas1p3475ce2b4d03234dc96ced428be582eb3
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082826epcas1p3475ce2b4d03234dc96ced428be582eb3@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make staging/exfat and fs/exfat mutually exclusive to select the one
between two same filesystem.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 drivers/staging/exfat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index 292a19dfcaf5..9a0fccec65d9 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config STAGING_EXFAT_FS
 	tristate "exFAT fs support"
-	depends on BLOCK
+	depends on BLOCK && !EXFAT_FS
 	select NLS
 	help
 	  This adds support for the exFAT file system.
-- 
2.17.1

