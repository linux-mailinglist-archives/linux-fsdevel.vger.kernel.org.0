Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6591D104A2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKUF33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:29:29 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:62551 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKUF33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:29:29 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191121052923epoutp0104aa1868708839fbfdf3a9b1b506867d~ZFmQSUVfE1285312853epoutp01J
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191121052923epoutp0104aa1868708839fbfdf3a9b1b506867d~ZFmQSUVfE1285312853epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574314163;
        bh=LzsUvoRQ+/EvYb4sCIgQeQ8VbnU5fmhs4hyN/5tdGrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCvGprBT1OhYCMuwEBMqw3mT4L/5pfvYzWK0jkmGsrADMq4k5edLaiCjvEZ2LHGJR
         9WWe/FKtAixjn3xyrzgxh/XSd+SreYqDkhcCapsXUzvTXVAEyKevFz67TZpUHv5KYz
         19xqNPKukDRjE/uX57zdCEHcUKnPLD91bNNHjqGU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191121052923epcas1p2db841f8c65bf88c587f95a5d2e34913b~ZFmPzJTFA3070730707epcas1p2s;
        Thu, 21 Nov 2019 05:29:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47JSmL2Y4RzMqYkh; Thu, 21 Nov
        2019 05:29:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.9C.04072.2B026DD5; Thu, 21 Nov 2019 14:29:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052921epcas1p1f3a18589dce59939af6b462f35412642~ZFmOhmscp0315303153epcas1p1g;
        Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191121052921epsmtrp23866cba3e7cff6caba222d783180f6ab~ZFmOcMb-s1671516715epsmtrp2O;
        Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000000fe8-be-5dd620b2738f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.98.03814.1B026DD5; Thu, 21 Nov 2019 14:29:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052921epsmtip15b70f610a8ab1e7a2f1f7f33092767e7~ZFmOQUcD61142911429epsmtip17;
        Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Thu, 21 Nov 2019 00:26:17 -0500
Message-Id: <20191121052618.31117-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121052618.31117-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0zTUBj1rl1X0JEypl4x0VkligZYGZtVmZpITBUSCfwzEiis2Yh7NO1m
        nPwQ4zNIVHwA4hMRVJAMYfJQ8AG+TVQQJaBEDUaNGkFRQSXqSvHx73znnnPPd7/74YgmHwvH
        s51uTnCydhILRuvbIqOjanWP0/TljVq6rW+vit5c5sPoM1XXFXRXbw9CN7fcRumHFw5j9K+S
        10p6uGgj/ev9FpT2/7ympDv6B9Cl45mmkl4Vc/nIWRVzsTsXY3b5KwHj8z9Cmbq7Ocxg7TSm
        teE9xjx5VY8mB622x9s41sIJOs6Z5bJkO61mMjE1fVm60aSnoqgF9HxS52QdnJlMSEqOWp5t
        DzRL6taxdk+ASmZFkYxZHC+4PG5OZ3OJbjPJ8RY7T+n5aJF1iB6nNTrL5VhI6fWxxoAyw27b
        O1gO+Ap8/fXqBiQX9GN5IAiHRBw8UVQewMG4hmgE8FPtCCIXnwBs3lQ2VnwFsNr3JlDgo5aq
        fLPk1hAtAH4r1P41DN36qJI0GDEPjvgnShotsQTWHbqCShqE6ALwVU+xUjoIIxj4/flmIOlR
        IgKea7dItJoww6qhY6jc3XRYVXNlNDYowD/74ZWugcQTDJ6vKBh7QQK819CvkHEYfHvTr5Jx
        OBz80ILJLefAj5cRmd4B4Jshs4wNsNtXo5QkCBEJfRdiZHoGbPpxBEgYIULghy/5SvkWNdyx
        TSNLIuCujrax0Kkwb/vAWCgD7297CeSB7AHwZuFuxR4wreRfwnEAKsEkjhcdVk6keOr/36oF
        o5s419gI9t9LagUEDsgJatucR2kaJbtO9DpaAcQRUqtu7upM06gtrHcDJ7jSBY+dE1uBMTDG
        AiR8YpYrsNdOdzpljDUYDHScab7JaCAnq/Hh9jQNYWXd3FqO4znhj0+BB4XngoRZfa44K+VV
        3VivjZgeWnRq7R3TlBWlr9VrVkQu/vx0QmpD6T7T7C/DM4WU3kj/ItPOA96nl+btK3gurOwf
        MIxL9Bpj6npiKT64aMhxOrkpI7vn6tZVxSG4Jycl6cBIfZmPz3sxBV+Y+ViR6U3qDH339UHq
        g/jPL0JPwoPGTt/RbhIVbSw1FxFE9jdrBZZQnwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO5GhWuxBs/26FkcfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9Rb/37SwWGz5d4TV4tL7DywO3B47Z91l
        99g/dw27x+6bDWwefVtWMXqs33KVxWPz6WqPz5vkPA5tf8PmcfvZNpYAzigum5TUnMyy1CJ9
        uwSujEmflzIWLOOoOLp2O3MD43u2LkYODgkBE4nVPbZdjJwcQgK7GSUONeqC2BIC0hLHTpxh
        higRljh8uLiLkQuo5AOjxNuHk8HibALaEn+2iIKUiwg4SvTuOswCUsMs8JhR4sT5J4wgCWEB
        D4lfD5oZQepZBFQlNl5MAQnzCthKrP4+nwVilbzE6g0HwEZyAsXv/66EuMZG4uqJF6wTGPkW
        MDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDlwtrR2MJ07EH2IU4GBU4uHN0Lga
        K8SaWFZcmXuIUYKDWUmEd8/1K7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRm
        p6YWpBbBZJk4OKUaGKf/F2cQfC79sezkwm+3zpzX2VbZ2Hr2Q2+sFIfnfFmBj+XXfUUT/IJ4
        7vTN02x+ffhmB1f6sVX5U3c0OW47uPw6yy8v668Xlne1uuy/x8Ba8pBzekiqvmJP94wzx+sK
        1r7cKnvlUvLri7oHNrnEN3pwNV5zknQpvOe5OdVYwul3etTZg5OXcCuxFGckGmoxFxUnAgAr
        2SvgWAIAAA==
X-CMS-MailID: 20191121052921epcas1p1f3a18589dce59939af6b462f35412642
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052921epcas1p1f3a18589dce59939af6b462f35412642
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052921epcas1p1f3a18589dce59939af6b462f35412642@epcas1p1.samsung.com>
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

