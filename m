Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F304AFAC00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 09:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfKMIXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 03:23:25 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:56652 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfKMIW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:28 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191113082226epoutp01b5084681af7890636109643200d14e0a~WqzD1e7CI2713827138epoutp01A
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191113082226epoutp01b5084681af7890636109643200d14e0a~WqzD1e7CI2713827138epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573633346;
        bh=fXkAtD1f7Qm39aNQCzJO0k9yjEGia/5jB2GlQkPa4H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTu+WMBy4q7MIHS8tcwliyVz1BAVnCF77vT1avhXUe+WX6zfQtI0z51P8VXJzEr3W
         ABZHQrMc78jqNvfv49qJ/2dHw50ZiQ9Z1mXP9Sw7ki8H4zQrwDZ4w93R1b37k9VWaN
         qGH2YfyDaXknXMAc45jEE70tGYoswMs2RYG2q4zM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191113082226epcas1p3059927eacf3b9c9a7d5708684e802a6e~WqzDf0Uam0735307353epcas1p3Q;
        Wed, 13 Nov 2019 08:22:26 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Cczj1qwZzMqYkn; Wed, 13 Nov
        2019 08:22:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.93.04068.04DBBCD5; Wed, 13 Nov 2019 17:22:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191113082224epcas1p34767ff06541d67b9b8b124288c31ce70~WqzBp5rXO0735307353epcas1p3I;
        Wed, 13 Nov 2019 08:22:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113082224epsmtrp265af6071b86e96fd491e2c64bc9ff927~WqzBpCebW2391923919epsmtrp2F;
        Wed, 13 Nov 2019 08:22:24 +0000 (GMT)
X-AuditID: b6c32a39-3b9219c000000fe4-4e-5dcbbd40c0c6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.84.24756.04DBBCD5; Wed, 13 Nov 2019 17:22:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082224epsmtip1c4651b210508573917050d8f30a5ffe5~WqzBcu1RS2834328343epsmtip13;
        Wed, 13 Nov 2019 08:22:24 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Wed, 13 Nov 2019 03:17:59 -0500
Message-Id: <20191113081800.7672-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmvq7D3tOxBvOeq1o0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6
        yfm5VoYGBkamQJUJORmXDi1kK1jKUbF44mq2BsZ3bF2MHBwSAiYSMz5rdDFycQgJ7GCU2PTr
        DROE84lR4vn6R6wQzjdGiZ93moE6OME6Xh7sgkrsZZQ4/vwBC1zLhseHweayCWhL/NkiCtIg
        ImAvsXn2AbAaZoE5jBI7emcxgiSEBVwlen5MBrNZBFQl+o4uYAWxeQVsJKbd/sEKsU1eYvWG
        A8wgMzmB4tfW2oLMkRDYwCbRce8DE0SNi8TcdauZIWxhiVfHt7BD2FISn9/thfqzWuLjfqiS
        DkaJF99tIWxjiZvrN7CClDALaEqs36UPEVaU2Pl7LthlzAJ8Eu++9rBCTOGV6GgTgigBOvjS
        YagDpCW62j9ALfWQ2PNnJdjxQgL9jBKXthlPYJSbhbBgASPjKkax1ILi3PTUYsMCU+To2sQI
        Tm1aljsYj53zOcQowMGoxMMrsfBUrBBrYllxZe4hRgkOZiUR3h0VJ2KFeFMSK6tSi/Lji0pz
        UosPMZoCg3Eis5Rocj4w7eaVxBuaGhkbG1uYmJmbmRorifM6Ll8aKySQnliSmp2aWpBaBNPH
        xMEp1cDYGjDhyszZGjZ6k3wZlDW2676Yk7B+HUttza7oxOBCf2HN2Z8sA6xUU5X4zsR31hbv
        mn13en0g+zmRCW/vFXyc7JD/rlOMa+HBekfGJxy8+RkzC2923rofNMX3xf1w+yrDfa8ZZyxc
        XLr2Qub/Aw/VZH/P5T1/v8W57pGmyfwrkXyHquZkhrspsRRnJBpqMRcVJwIAh+5DpoMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnK7D3tOxBtsuc1g0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MS4cWshUs5ahYPHE1WwPjO7YuRk4OCQETiZcH
        u1i7GLk4hAR2M0osWfCPBSIhLXHsxBnmLkYOIFtY4vDhYoiaD4wSsxZ8BYuzCWhL/NkiClIu
        IuAo0bvrMAtIDbPAIkaJdx8ns4IkhAVcJXp+TGYEsVkEVCX6ji4Ai/MK2EhMu/2DFWKXvMTq
        DQfAZnICxa+ttQUJCwlYS3x9e4B5AiPfAkaGVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
        uZsYwUGopbmD8fKS+EOMAhyMSjy8EgtPxQqxJpYVV+YeYpTgYFYS4d1RcSJWiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBsYlG4SvO7MvTzqjKKh6s8ZY
        rfzj7fD5LFLpNlIsdXt1+wX6f7E2dV412iL50JEpwOLxiTg7zabvNx8vu9Ts2xg1i7fJ5yLP
        5aCZ7x5//FySqD8n/6dF+7L1UUKL7waG7okXcqv8+S906Yssv99PzvQd6K48ECjyRftLQ9AG
        3jDefakFa5QEJiqxFGckGmoxFxUnAgC5ovopPgIAAA==
X-CMS-MailID: 20191113082224epcas1p34767ff06541d67b9b8b124288c31ce70
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082224epcas1p34767ff06541d67b9b8b124288c31ce70
References: <20191113081800.7672-1-namjae.jeon@samsung.com>
        <CGME20191113082224epcas1p34767ff06541d67b9b8b124288c31ce70@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add exfat in fs/Kconfig and fs/Makefile

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

