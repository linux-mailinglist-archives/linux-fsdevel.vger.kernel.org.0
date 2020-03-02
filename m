Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0C1753BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCBG0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:26:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:63874 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgCBG0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:32 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200302062630epoutp01249c7f1f1a8e97c77975ff0ac5316bb7~4aLPL5yJ_2122921229epoutp01u
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200302062630epoutp01249c7f1f1a8e97c77975ff0ac5316bb7~4aLPL5yJ_2122921229epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130390;
        bh=5wuHmJt7eMxzYfAxpivau2fYK84StEh1B3GDoCKboJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhMaiSXyGTtjTOfi0y6PGQmBiyAJRjNz0s0vu18qxQqvZ+NyL/qXGcE+inANbpJUH
         mLgij3VBvccy+er/NiPDtQah3KoiCAusfKXsLhf1r1dlET2NvNzXtDGKg97eH7twJO
         oQecA4pzEE32VqokNYN154i7uHKw4d4bwqJVw56U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200302062630epcas1p4035b8ee30549f7f1980716e1c9973fa3~4aLO1oABH2049420494epcas1p4R;
        Mon,  2 Mar 2020 06:26:30 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48W9C90kD7zMqYkc; Mon,  2 Mar
        2020 06:26:29 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.3D.57028.517AC5E5; Mon,  2 Mar 2020 15:26:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302062628epcas1p159ad0d797c1d4334fbcaf84f39bfea40~4aLNnwZ3M0222602226epcas1p1T;
        Mon,  2 Mar 2020 06:26:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302062628epsmtrp19300b68045cc9abfefa2511f93784dc8~4aLNmxGB61431214312epsmtrp1f;
        Mon,  2 Mar 2020 06:26:28 +0000 (GMT)
X-AuditID: b6c32a35-974d39c00001dec4-4b-5e5ca715205d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.FA.06569.417AC5E5; Mon,  2 Mar 2020 15:26:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062628epsmtip23d73577456f35b615b5d6134b24e8efa~4aLNdRouD1931619316epsmtip2X;
        Mon,  2 Mar 2020 06:26:28 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 13/14] staging: exfat: make staging/exfat and fs/exfat
 mutually exclusive
Date:   Mon,  2 Mar 2020 15:21:44 +0900
Message-Id: <20200302062145.1719-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmrq7o8pg4gy//WSz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HF4vzf46wO3B6/f01i
        9Ng56y67x/65a9g9dt9sYPPo27KK0ePzJjmPQ9vfsHlsevKWKYAjKscmIzUxJbVIITUvOT8l
        My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hQJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsaC7h7Ggq3sFcs/N7M2
        MC5l62Lk5JAQMJH49nw2excjF4eQwA5GidkPzrBCOJ8YJS4cOckE4XxjlDh5+yQzTMv0u2+h
        qvYySkyeOIcNrqV99xogh4ODTUBb4s8WUZAGEQFpiTP9l8AmMQs0MEk0H2hiB0kIC8RLrP60
        mAXEZhFQlTj96jcTiM0rYCMxo/MuI8Q2eYnVGw6AbeYEit/ZdYERokZQ4uTMJ2C9zEA1zVtn
        M4MskBBoZpd4//g7O0Szi8TyFf9ZIWxhiVfHt0DFpSRe9rexgxwqIVAt8XE/1GcdjBIvvttC
        2MYSN9dvYAUpYRbQlFi/Sx8irCix8/dcRoi1fBLvvvawQkzhlehoE4IoUZXou3SYCcKWluhq
        /wC1yENia5suJKT6gSH9+DTLBEaFWUiemYXkmVkIixcwMq9iFEstKM5NTy02LDBEjuBNjOCE
        q2W6g3HKOZ9DjAIcjEo8vDueR8cJsSaWFVfmHmKU4GBWEuH15QQK8aYkVlalFuXHF5XmpBYf
        YjQFhvtEZinR5HxgNsgriTc0NTI2NrYwMTM3MzVWEud9GKkZJySQnliSmp2aWpBaBNPHxMEp
        1cDY0BbB/N3TdL5B35ZbGp1yai2hr0zZbvsGr3Dm+ldwbqbRrT/B+fJN3paz9x2Ju6rasWPx
        bfuLgWkHlKX3vaoXaDHpCPFPSxdv3da1+21NyOF5qw1nVRUU6AjIaop/LQqdxbn9z8lfKydl
        njX+NeOaxqLO+S/SOrYFaXdGaqck7KmZkGTcslGJpTgj0VCLuag4EQAt3s5+zgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXldkeUycwYq9OhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARxWWTkpqTWZZapG+XwJWx
        oLuHsWAre8Xyz82sDYxL2boYOTkkBEwkpt99y9rFyMUhJLCbUWL/9xtQCWmJYyfOMHcxcgDZ
        whKHDxdD1HxglOjb1MoEEmcT0Jb4s0UUpFwEqPxM/yUmkBpmgR4mic9TFjOBJIQFYiVm7FgA
        ZrMIqEqcfvUbzOYVsJGY0XmXEWKXvMTqDQeYQWxOoPidXRfA4kIC1hJPX9xlhqgXlDg58wkL
        yF5mAXWJ9fOEQMLMQK3NW2czT2AUnIWkahZC1SwkVQsYmVcxSqYWFOem5xYbFhjlpZbrFSfm
        Fpfmpesl5+duYgRHkZbWDsYTJ+IPMQpwMCrx8O54Hh0nxJpYVlyZe4hRgoNZSYTXlxMoxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgdHoUrhddkC019yb
        ympLLr6P4ftvxtz3I/TYXe8FP72Zf/4odV7lmrFVzjwmQqf36TMH3oDOHRNqQ55HL3rpV1D6
        xb2k4nX0s55bX7QPHjbjc7lz+V20tVrS12M7Nc6nXmi1YjKa2qorxJRg//fOkSv7xX7N0k9q
        lf9+gOfsf+ZsxWt7amZKv1ViKc5INNRiLipOBABQu+MYngIAAA==
X-CMS-MailID: 20200302062628epcas1p159ad0d797c1d4334fbcaf84f39bfea40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062628epcas1p159ad0d797c1d4334fbcaf84f39bfea40
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062628epcas1p159ad0d797c1d4334fbcaf84f39bfea40@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make staging/exfat and fs/exfat mutually exclusive to select the one
between two same filesystem.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

