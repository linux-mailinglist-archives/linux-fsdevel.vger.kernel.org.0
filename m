Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB949101A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 08:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKSHON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 02:14:13 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35562 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfKSHON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:14:13 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191119071410epoutp04b9529d88ba86cfe37af305053dfa8064~YfvLG8XjX1949019490epoutp04K
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 07:14:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191119071410epoutp04b9529d88ba86cfe37af305053dfa8064~YfvLG8XjX1949019490epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574147650;
        bh=LzsUvoRQ+/EvYb4sCIgQeQ8VbnU5fmhs4hyN/5tdGrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+y6AiGORcGsx9AtPegn3HiyMTXEjKsKYv7zLaBiRnwrxEQoRaZ5ZUCTVtt1h7/VW
         F1Sz2A5vetwlkoUTgCYEb1fBXKe/65NeVRRHeLpc+0vXFbZxCOiQ6BHHxrM4sF9Tyi
         2TE+vqnKdP3vWQCqXxmaAlTbD2Qk6HgMTp8F7s4o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191119071410epcas1p1f977186847bf941799e18723dc7c206a~YfvKzcM2I3222032220epcas1p1a;
        Tue, 19 Nov 2019 07:14:10 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47HHB959BmzMqYm0; Tue, 19 Nov
        2019 07:14:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.3C.04235.14693DD5; Tue, 19 Nov 2019 16:14:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071409epcas1p1b2464462c7972c11ae8719528f0c43a8~YfvJcJl6u0158901589epcas1p16;
        Tue, 19 Nov 2019 07:14:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119071409epsmtrp1bebabae489c5894fe68d7fb51a37d2c1~YfvJbgiTu3109231092epsmtrp1B;
        Tue, 19 Nov 2019 07:14:09 +0000 (GMT)
X-AuditID: b6c32a36-defff7000000108b-9f-5dd396411b95
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.14.03654.14693DD5; Tue, 19 Nov 2019 16:14:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071408epsmtip1759fcf86aa0480b04ad146c83afcd70a~YfvJOoaJC1409814098epsmtip1E;
        Tue, 19 Nov 2019 07:14:08 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Tue, 19 Nov 2019 02:11:06 -0500
Message-Id: <20191119071107.1947-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119071107.1947-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmnq7jtMuxBvsnq1k0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMH6DIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGh
        QYFecWJucWleul5yfq6VoYGBkSlQZUJOxqTPSxkLlnFUHF27nbmB8T1bFyMnh4SAicSCk/dZ
        uxi5OIQEdjBK/LvbyAjhfGKU+PnsFFTmG6PE73+zWWBaGvdsZIdI7GWUOL7gAwtcy6TjR4H6
        OTjYBLQl/mwRBWkQEbCX2Dz7AFgNs8BmRomHm5aCTRIW8JB4c3UaI4jNIqAq0dvzjRnE5hWw
        kbjx/ioTxDZ5idUbDoDFOYHi/fO+g22WENjDJnH97yKgQexAjovEpXyIcmGJV8e3sEPYUhIv
        +9vYQc6REKiW+LifGSLcwSjx4rsthG0scXP9BlaQEmYBTYn1u/QhwooSO3/PBTuMWYBP4t3X
        HlaIKbwSHW1CECWqEn2XDkPdKC3R1f4BaqmHxJJbk6EB0s8o8f3uVZYJjHKzEDYsYGRcxSiW
        WlCcm55abFhghBxfmxjBCU/LbAfjonM+hxgFOBiVeHhPqFyOFWJNLCuuzD3EKMHBrCTC6/fo
        QqwQb0piZVVqUX58UWlOavEhRlNgME5klhJNzgcm47ySeENTI2NjYwsTM3MzU2MlcV6OHxdj
        hQTSE0tSs1NTC1KLYPqYODilGhjXrZxylZNpp/wWFmuRVfNlri9Y3efQtNbOvWu+nES6Q83H
        N2J/1W02nf94XsDrOfOpy1/+7DdovmJxL+TBFw6egw8qDlc/yeR69ct4zrp3Zy/rFYrkduxg
        vlzxbYOo7BQHh4WCs7/3bV3YKGY1Veoiw0WmpQlLPy/ZEVzu5/my3ORzjF3b7lQ3JZbijERD
        Leai4kQAOOfIrI4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnK7jtMuxBnN/MVs0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD2KyyYlNSezLLVI3y6BK2PS56WMBcs4Ko6u3c7cwPie
        rYuRk0NCwESicc9G9i5GLg4hgd2MEmeWLmGHSEhLHDtxhrmLkQPIFpY4fLgYouYDo8Tqh3MY
        QeJsAtoSf7aIgpSLCDhK9O46zAJSwwwyZ8v0X4wgCWEBD4k3V6eB2SwCqhK9Pd+YQWxeARuJ
        G++vMkHskpdYveEAWJwTKN4/7zvYDUIC1hKbFy1hncDIt4CRYRWjZGpBcW56brFhgWFearle
        cWJucWleul5yfu4mRnBoamnuYLy8JP4QowAHoxIP7wmVy7FCrIllxZW5hxglOJiVRHj9Hl2I
        FeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoGRQcqtkquv
        a/PrvXOUuFetmX/V5HCq9GTnY+Vc5zy6rs9istv/VOTIzeS79lFPfy5V14taWLriFsO7gnxG
        ryP7D8wJFJdRTNIP08gublIsqbG8veaRkPbCZ8v1plYfUvLyvKdeccXiw/Pjlw7ZLVzpvMr/
        8PdUxbc913t8fV9NvC8z00axfsMnJZbijERDLeai4kQAEQkQu0kCAAA=
X-CMS-MailID: 20191119071409epcas1p1b2464462c7972c11ae8719528f0c43a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071409epcas1p1b2464462c7972c11ae8719528f0c43a8
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071409epcas1p1b2464462c7972c11ae8719528f0c43a8@epcas1p1.samsung.com>
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

