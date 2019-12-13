Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7711DE02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbfLMFyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:54:12 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30458 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732134AbfLMFxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:53:48 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191213055347epoutp026335c20b3f6e0837ac10b077ab694293~f2H0-qv542413924139epoutp02D
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 05:53:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191213055347epoutp026335c20b3f6e0837ac10b077ab694293~f2H0-qv542413924139epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576216427;
        bh=LzsUvoRQ+/EvYb4sCIgQeQ8VbnU5fmhs4hyN/5tdGrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8mXyuA0oFrynayuIVhpV9vyv0EiCEDt9pVHPSVqgVe0SOm1IH/sRLLzHpXF/G0cY
         IiQJPDRICZiqgpQnWvL0zVRMm6ybV/4I9UkjvdZ1QfT12BAiRmueZ8C7BXmP+4TNrq
         srQje52qUft0ilu16YecHatoyECy9NEFebeOr/1I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191213055346epcas1p2e057b4c3d005819b57375144de43bdf5~f2H0uzxtf2651326513epcas1p2C;
        Fri, 13 Dec 2019 05:53:46 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Z0GK5KkqzMqYkY; Fri, 13 Dec
        2019 05:53:45 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.EB.48498.96723FD5; Fri, 13 Dec 2019 14:53:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191213055344epcas1p37b9d8fc36fce255eedc99a335feca564~f2Hy3BIpb0380703807epcas1p36;
        Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213055344epsmtrp168fe5b792c8c6ca11ed19107e8ce46d8~f2Hy2aPPQ0541405414epsmtrp1Q;
        Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-fc-5df327694500
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.F0.10238.86723FD5; Fri, 13 Dec 2019 14:53:44 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055344epsmtip2c9c2c3b6789e50dca3d3eff783ddebf5~f2HyriX9H1079410794epsmtip2w;
        Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v7 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Fri, 13 Dec 2019 00:50:27 -0500
Message-Id: <20191213055028.5574-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213055028.5574-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmgW6m+udYgw+/tS2aF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEq
        E3IyJn1eyliwjKPi6NrtzA2M79m6GDk5JARMJFb19zF1MXJxCAnsYJR49fATlPOJUWLO32WM
        EM43Ronn1y8ydzGyg7WcsIMI72WUeH/vEzvIJLCGe91hXYwcHGwC2hJ/toiChEUE7CU2zz7A
        AlLPLNDCKLHg9A9mkISwgIdE/12QZZwcLAKqEjcXLge7iFfARmLRh+eMENfJS6zecACsnhMo
        Pm/yB3aI+AI2iVX38kB2SQi4SHw+Fg4RFpZ4dXwLVImUxMv+NnaIkmqJj/uZIcIdjBIvvttC
        2MYSN9dvYAUpYRbQlFi/Sx8irCix8/dcsAOYBfgk3n3tYYWYwivR0SYEUaIq0XfpMBOELS3R
        1Q5zl4fEtFnfWCCB088ocXTCEqYJjHKzEDYsYGRcxSiWWlCcm55abFhghBxZmxjBKUzLbAfj
        onM+hxgFOBiVeHgZUj7FCrEmlhVX5h5ilOBgVhLhta8BCvGmJFZWpRblxxeV5qQWH2I0BQbj
        RGYp0eR8YHrNK4k3NDUyNja2MDEzNzM1VhLn5fhxMVZIID2xJDU7NbUgtQimj4mDU6qBseyZ
        cdU5jx9rIuvbeo5+SMj8xHj09ASjJweDzl6psxTQO5N9f/fjXd/XXW4J47n38GyJ3YTZwmtP
        ffwx+ynjHv9DMttcFgtvWsp/eNLdyyLqRk8aJj7IfDPTK2rjOesX58PEbG/rP5FZ/+uslC77
        +8V5xVyaWl+mTpjZN2FK54esF9/cN2/yefVQiaU4I9FQi7moOBEAyTG4G3cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSvG6G+udYg/8rtCyaF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFFcNimpOZllqUX6dglcGZM+L2UsWMZRcXTtduYGxvdsXYzsHBICJhIn7LoYuTiEBHYzSnw8
        1cHUxcgJFJaWOHbiDHMXIweQLSxx+HAxRM0HRomf01sZQeJsAtoSf7aIgpSLCDhK9O46zAJS
        wyzQxSjxqOkbM0hCWMBDov/uJ7CZLAKqEjcXLmcDsXkFbCQWfXjOCLFLXmL1hgNg9ZxA8XmT
        P7CD2EIC1hJ3375im8DIt4CRYRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnC4aWnu
        YLy8JP4QowAHoxIPL0PKp1gh1sSy4srcQ4wSHMxKIrz2NUAh3pTEyqrUovz4otKc1OJDjNIc
        LErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGL18H/UXPNGOiuOenbb7TmMLe+GpF1+YPmza
        cvCC9imz1vqXv3NnpOyc28nRN03RSIJ5ytOXa3YZbONJzRY7GDU9/IjA95RPExm9Flg5/fkY
        4VZsIfvGNEI1+PdLdvlz3R5+0VwarHVH5z/pvdl25sQDwb3JpzSfJNhFKeiW3lSZovejRIC5
        RYmlOCPRUIu5qDgRAJ+aCuQzAgAA
X-CMS-MailID: 20191213055344epcas1p37b9d8fc36fce255eedc99a335feca564
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213055344epcas1p37b9d8fc36fce255eedc99a335feca564
References: <20191213055028.5574-1-namjae.jeon@samsung.com>
        <CGME20191213055344epcas1p37b9d8fc36fce255eedc99a335feca564@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add exfat in fs/Kconfig and fs/Makefile.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/Kconfig  | 3 ++-
 fs/Makefile | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7b623e9fc1b0..5edd87eb5c13 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -139,9 +139,10 @@ endmenu
 endif # BLOCK
 
 if BLOCK
-menu "DOS/FAT/NT Filesystems"
+menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
+source "fs/exfat/Kconfig"
 source "fs/ntfs/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 1148c555c4d3..4358dda56b1e 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
+obj-$(CONFIG_EXFAT)		+= exfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
-- 
2.17.1

