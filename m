Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B491020F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKSJkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:40:47 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:14102 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfKSJkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:40:32 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191119094029epoutp042c8ef76c3ebee9e0a8dc24a3f4e117e8~Yhu66C1ey0888908889epoutp04W
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191119094029epoutp042c8ef76c3ebee9e0a8dc24a3f4e117e8~Yhu66C1ey0888908889epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574156429;
        bh=LzsUvoRQ+/EvYb4sCIgQeQ8VbnU5fmhs4hyN/5tdGrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqP6bN/L1cCNM6MuzQyTUdWtFJ2gQvtjsOzmG5ggwuXHLgEgwPfYr9VQPWvIBBq/2
         eL4AVzSvReeJC3VPHb95Oi1uuQjRbQ8m2B8V59RmSrFptMa/0Du3tXjP0W7F14rKsL
         p2+UCwJvFBwmWMmaEl+ojg6sDIyTfA+O7wROntXo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191119094028epcas1p16ea6bbbcc65534c8c7976482a703e7c9~Yhu6RQrhu0953509535epcas1p13;
        Tue, 19 Nov 2019 09:40:28 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47HLR00HGBzMqYkb; Tue, 19 Nov
        2019 09:40:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.A4.04406.B88B3DD5; Tue, 19 Nov 2019 18:40:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191119094027epcas1p416eca98bc8ccefbcada87ae6b475d4c4~Yhu44AOD92221122211epcas1p4Z;
        Tue, 19 Nov 2019 09:40:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191119094027epsmtrp2ce954b0514e369a1ca8cc7e1d46b697d~Yhu43Wbrl0322303223epsmtrp2j;
        Tue, 19 Nov 2019 09:40:27 +0000 (GMT)
X-AuditID: b6c32a38-947ff70000001136-41-5dd3b88be542
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.A2.03814.B88B3DD5; Tue, 19 Nov 2019 18:40:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094027epsmtip2d6737fe0092ba5d731068cce22ee09f5~Yhu4sxHwG0597405974epsmtip2f;
        Tue, 19 Nov 2019 09:40:27 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Tue, 19 Nov 2019 04:37:17 -0500
Message-Id: <20191119093718.3501-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119093718.3501-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOztTVaWV9LDE7tMBC29rFk2gFRZxIRIiCIrGDO+hoN87Z
        LDVokHjLLAsytYsaM9JMU/NWy3BGRWne6CYSKZRZeMl0hVptO93+PTzv8z7v873fiyGyk6gc
        M5htDGumjQQaIGx2hysjTrUOJCqLB3Wke/ScmDx5rQ4lb9Q8FJAvh98g5D3XEyE50H4JJX+W
        fhCR34pPkE0/ukRk/+SUcHsA1VY6LKY6Lt8UU3dfO1CqsKkaUI1PM6mZhlCqs+UzSg29bxYm
        YAeNMakMrWfYMMacbNEbzCmxxJ69STuStDqlKkK1hYwiwsy0iYkldsYlROwyGL0RibA02mj3
        Ugk0xxGbtsawFruNCUu1cLZYgrHqjVaV0hrJ0SbObk6JTLaYolVK5WatV3nYmHpuxgmsVdix
        h7UtiANMovlAgkFcA3vzvgryQQAmw1sBLDz/DPEVZPgXAO+UM3xhDsCKrLfiPx2jI/VCvuAC
        MMsxL/jb8epMZD7AMBTfCBeagn30CnwbbCx74NcjeBeAY1/P+o2W4xTMrnT7pwlxBXTn3vT7
        SPEYODy4CPhha2BN/QO/RuLl35VVAZ8RxB+j8Lqn5PcbdkJHX66Ix8vh+KOm30nlcGbChfoC
        QTwTTncgPJ3rDeGJ5bEavq6rF/kkCB4O69o38fRa2DZ/2R8BwZfAidkCEe8ihbnZMl6igIX9
        bgGPV8P8nCkxL6FgbZuS384ZALt7s8RnQWjpvwHlAFSDlYyVM6UwnMqq+f+7GoD/ADeQreBe
        T1wnwDFABEkfrxtIlInoNC7d1AkghhArpPEjvYkyqZ5Oz2BYSxJrNzJcJ9B691iEyIOTLd5z
        NtuSVNrNarWa1OiidFo1sUqKfetLlOEptI05wjBWhv3TJ8AkcgcIPLrMveaqIl2fNiTJdNqz
        ivZPbTMoDhXfJjZ6OpzHt06f3idfDIl7VhrtqQxx3mqMx06PBxTkjYVHOEqaNabFo/eDZyuc
        L3a35EgWxuPWf2SH7F0TW74HDb57r4samnvecCWwvTbD4OqavFjn+FTx9IKnZEx6sLsn+YBN
        s5RdDCGEXCqt2oCwHP0LbpeWrZYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvG73jsuxBmuWSFocfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9RZb/h1htbj0/gOLA5fHzll32T32z13D
        7rH7ZgObR9+WVYwem09Xe3zeJOdxaPsbNo/bz7axBHBEcdmkpOZklqUW6dslcGVM+ryUsWAZ
        R8XRtduZGxjfs3UxcnJICJhIPH60gaWLkYtDSGA3o8SVZW+ZIBLSEsdOnGHuYuQAsoUlDh8u
        hqj5wCix7MsLNpA4m4C2xJ8toiDlIgKOEr27DoPNYRY4xyix89kyRpCEsICHRNuiw8wgNouA
        qsThjjVg83kFbCTuXvnLCLFLXmL1hgNgNZxA8YezIXqFBKwlGh81s09g5FvAyLCKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4WLW0djCeOBF/iFGAg1GJh/eEyuVYIdbEsuLK3EOM
        EhzMSiK8fo8uxArxpiRWVqUW5ccXleakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLg
        lGpgtLmnbH4mjs170XwNjZvdm2I4uH4+k3Dzej+9JWO/LM/uk5y2EXwz7+ldSrqUJHRuWbbz
        1G93L6+z9qzaozljolT8n64pR9r+2rYLNzrLMF5/5VaQn7YlIE+UqUPo6brFxhb2KybxBZm9
        u/1w51rJBzwaG8Kn7Fc4tkVs7l/RLaxq7slLGq5vUWIpzkg01GIuKk4EAG/ZLghSAgAA
X-CMS-MailID: 20191119094027epcas1p416eca98bc8ccefbcada87ae6b475d4c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094027epcas1p416eca98bc8ccefbcada87ae6b475d4c4
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
        <CGME20191119094027epcas1p416eca98bc8ccefbcada87ae6b475d4c4@epcas1p4.samsung.com>
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

