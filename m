Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D9D1753B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCBG0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:26:34 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:63858 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgCBG0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:31 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200302062629epoutp012bc9206e96edfd9308adcbc63eca5bc8~4aLN8N0Cf2154221542epoutp01V
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200302062629epoutp012bc9206e96edfd9308adcbc63eca5bc8~4aLN8N0Cf2154221542epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130389;
        bh=HGeLiXmjrg1U6Sm0vuBOs8aVdsuX8sWnhzIQ2hZIiNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMRFAmfpeeEN/gGStDIveuATqMtGGKkSrXJxDuyrCr4iZG0vumszPmVZl89Nw1cb0
         w7UGkypIpEdt0WSrF+nGHf0EE09WPRIgHR8X7WJhI5GYoKmydsHUzouDejwCpm85k0
         A45oh5IADl+kp61d6LsvrNXfYn8Fazv5wIXuJmqk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302062628epcas1p104f1819c097e18e0b9a563fff3331603~4aLNcpqFS0219602196epcas1p1k;
        Mon,  2 Mar 2020 06:26:28 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48W9C76gY0zMqYkj; Mon,  2 Mar
        2020 06:26:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.F7.52419.317AC5E5; Mon,  2 Mar 2020 15:26:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200302062627epcas1p40f1ac87d14fca82d278beaded987f0fb~4aLMd1NCG2314123141epcas1p4U;
        Mon,  2 Mar 2020 06:26:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302062627epsmtrp2f9d1807eedea87cc9aa7f853074f3691~4aLMcyhvo1854618546epsmtrp2d;
        Mon,  2 Mar 2020 06:26:27 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-09-5e5ca713e750
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.49.10238.317AC5E5; Mon,  2 Mar 2020 15:26:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062627epsmtip2a5a2b19bcf86ed75d425964240e0747d~4aLMQ_RK41396013960epsmtip2Z;
        Mon,  2 Mar 2020 06:26:27 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 12/14] MAINTAINERS: add exfat filesystem
Date:   Mon,  2 Mar 2020 15:21:43 +0900
Message-Id: <20200302062145.1719-13-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUwTQRjNdNvdrVqzFtERE60bjUFTaS2lq2mNicasVyDxlxe4gbFt7JVu
        wStRAgqEEBCMEAskRmMUPKhYoSAERBEVD6QQU6+ooBAPPIhHrNe2i8q/N2/e+973zUFiyiY8
        jrQ6PMjt4Gw0PkHacDVerY45tSVV055rYH6WXSeY3BN1OFNzplPCPHjyEGNaWm9KmWBzFc58
        q9jPlHaHJYz/1zUZ0/v+g5S597NLtnwiG/5eBtgm7xOCbas+S7CXQ9k4W+yvBexo/Sy2o/Et
        ztYPvpOkkJtsRgviMpBbhRzpzgyrw2yi125IW5GmT9Jo1doljIFWOTg7MtEr16WoV1ltQqO0
        KouzZQpUCsfzdMIyo9uZ6UEqi5P3mGjkyrC5tBrXIp6z85kO86J0p32pVqNZrBeU22yWztM1
        mCuI7zr97AGeDYKyQiAnIZUIG/P6pIVgAqmkAgC+GuojxMUnAPMraqQRlZL6AmCw2/jXcaus
        ZUzUCuDQxYDkn6Oy5Z1QlyRxaiH84Y+NGKZSM+Htkt6oBqOyJTC3PYeIbMRQRugdLsciWErN
        g/1DN7CIVyHwpUXJYthseMbXHpXIBfpxcw+IYAU1Bd48OhhtDhM0uZcqsUh9SP3G4UDrCCGa
        V8KGl28kIo6Br7v8Y3wcHB1pxSNZkNoLP7ZhIl0A4PBXk4h1MFTni46CUfGwrjlBpOfApnA1
        EGMnw5HPRTKxigIW5ClFyTxY3Ht1LHQmLMz/QIgSFpa3GcWDKgHQ/7YSPwRU3nHDeMcN4/0f
        fAxgtWAacvF2M+K1Lt34660H0We7wBAAvrvrOgBFAnqSIjC0OVUp47L43fYOAEmMnqpYLxco
        RQa3ew9yO9PcmTbEdwC9cOylWFxsulP4BA5Pmla/WKfTMYlJhiS9jp6ueL4xPlVJmTkP2oGQ
        C7n/+iSkPC4bTCvoH3wkbTZ1nh9Q3Rn9WhJM+Wi9eJbvOpwzXeZVPh313T+WmhxKrJjPrX6x
        5E75cHK4gd9OUKEpVurzEW0+WZdHHJ/Rd/CCwnqyz4IfyfkyWFscGzaEgG9V44FvAfm9rB7u
        3JXyfai6aKflVJW5cW7WGqRebxrY9WugKjZvKy3lLZx2AebmuT+E7YqizAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXld4eUycwednMhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARxWWTkpqTWZZapG+XwJVx
        dMVK5oLLbBUrHlxna2C8zNrFyMkhIWAicWrSHvYuRi4OIYHdjBIP97xlhkhISxw7cQbI5gCy
        hSUOHy6GqPnAKLGg9ywTSJxNQFvizxZRkHIRoPIz/ZeYQGqYBXqYJD5PWcwEkhAWsJGY9WIa
        2EwWAVWJq89PgM3kBYpP7PGHWCUvsXrDAbASTqDwnV0XGEFsIQFriacv7oLFeQUEJU7OfMIC
        0sosoC6xfp4QSJgZqLV562zmCYyCs5BUzUKomoWkagEj8ypGydSC4tz03GLDAsO81HK94sTc
        4tK8dL3k/NxNjOAY0tLcwXh5SfwhRgEORiUe3p3Po+OEWBPLiitzDzFKcDArifD6cgKFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYMxqKZq44KvVw1q/
        t7vOvnE+6FUsabElmIP3xO9k+dfPArJnSme7ux12MjTgcShnNec9GXFPe2Vh+PzUXc4PShT1
        mZ65P3ebctvfNsX697GpK8prGRMXVPHKzTfdtXZloEwW1+d1S4XfLLWcanP46wLXucn75TdV
        eDEdmrxRZ1/QS+uKKBFeSyWW4oxEQy3mouJEAM3IAX+dAgAA
X-CMS-MailID: 20200302062627epcas1p40f1ac87d14fca82d278beaded987f0fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062627epcas1p40f1ac87d14fca82d278beaded987f0fb
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062627epcas1p40f1ac87d14fca82d278beaded987f0fb@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself and Sungjong Seo as exfat maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b04505e7c3..faaa5ecf5990 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6345,6 +6345,13 @@ F:	include/trace/events/mdio.h
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

