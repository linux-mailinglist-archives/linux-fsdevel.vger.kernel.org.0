Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A262B101A21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 08:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKSHOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 02:14:17 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:62630 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfKSHON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:14:13 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191119071411epoutp020cd3f3c966c892acd2f4c0696a9b5438~YfvLiAt571289712897epoutp021
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 07:14:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191119071411epoutp020cd3f3c966c892acd2f4c0696a9b5438~YfvLiAt571289712897epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574147651;
        bh=qOKAH/xLKFcgxQkDaZUSWSDe5GuU0Alfu+G9AfD13f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FH9GH42Xy5r+mOGp0O4zBpybTjJ828xae9rwSuzj+KyTJHI78Gef24l7XdoMrhacy
         yjhw1uDmh7K5n9KcQI+LRoBGVOAAmJqzjE7KUfsfAEEy4FvDjgViYmW333pC1WZ9LX
         iWNkbLUddco9qcTS0VWVAiMmubSaMZQF5FAsF5e0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191119071410epcas1p4141b13c7535abd1e63cb4240fbd5d671~YfvK_IR540775207752epcas1p4v;
        Tue, 19 Nov 2019 07:14:10 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47HHBB1cbKzMqYkY; Tue, 19 Nov
        2019 07:14:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.3C.04235.24693DD5; Tue, 19 Nov 2019 16:14:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191119071409epcas1p2253bc4b3be05ac82201126bc62bd37ac~YfvKCSU_A1338013380epcas1p2-;
        Tue, 19 Nov 2019 07:14:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191119071409epsmtrp2e7fc92826931d38d7d565461e4b2ef82~YfvKBp3Mx0193901939epsmtrp2Z;
        Tue, 19 Nov 2019 07:14:09 +0000 (GMT)
X-AuditID: b6c32a36-e07ff7000000108b-a6-5dd396428540
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.84.03814.14693DD5; Tue, 19 Nov 2019 16:14:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071409epsmtip1b222ae39fb2bdfefd7f5d14083eea99b~YfvJ4X5Pd1281112811epsmtip1h;
        Tue, 19 Nov 2019 07:14:09 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 13/13] MAINTAINERS: add exfat filesystem
Date:   Tue, 19 Nov 2019 02:11:07 -0500
Message-Id: <20191119071107.1947-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119071107.1947-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmvq7TtMuxBlf38Vg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMH6DIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGh
        QYFecWJucWleul5yfq6VoYGBkSlQZUJOxpUrG5kLvrFW3Gxcy9TA2MDaxcjBISFgIvFocmEX
        IxeHkMAORolnO9rZIZxPjBI/Dl5hgXC+MUqsv7kIrmPpMsYuRk6g+F5GiUuNxRA2UMPuU7wg
        JWwC2hJ/toiChEUE7CU2zz4ANoZZYDOjxMNNS1lAEsIC1hIbjp9jBbFZBFQlGpfNZATp5RWw
        kThzMRMkLCEgL7F6wwFmEJsTKNw/7zvYbRICO9gk9s78yQxR5CIx69k/KFtY4tXxLewQtpTE
        53d72SBOrpb4uB+qpINR4sV3WwjbWOLm+g1gXzELaEqs36UPEVaU2Pl7LtiHzAJ8Eu++9kA9
        zivR0SYEUaIq0XfpMBOELS3R1f4BaqmHxO07KxghgdbPKNH6djvTBEa5WQgbFjAyrmIUSy0o
        zk1PLTYsMEKOrE2M4FSnZbaDcdE5n0OMAhyMSjy8J1QuxwqxJpYVV+YeYpTgYFYS4fV7dCFW
        iDclsbIqtSg/vqg0J7X4EKMpMBwnMkuJJucD03BeSbyhqZGxsbGFiZm5mamxkjgvx4+LsUIC
        6YklqdmpqQWpRTB9TBycUg2M2V1TZCaf0dLbwf+TQ7/o3KYNKXkT9adfaG1f4Z+xro9DlWHD
        ia1mLWunzDF7Xage6izT1R7gYTmLPWJFha7c+VadZUsKuI+o8mqWMuxd2FKpcemum9e2Zz+c
        Tm64zFTqaF6YUTFxo8bjA+93JjgxVSarv5mut9HhvNff4JXTRNc1bFs/7VGiEktxRqKhFnNR
        cSIA8wuB7osDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnK7jtMuxBlOO6Fk0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD2KyyYlNSezLLVI3y6BK+PKlY3MBd9YK242rmVqYGxg
        7WLk4JAQMJFYuoyxi5GLQ0hgN6PEpgWbgRxOoLi0xLETZ5ghaoQlDh8uhqj5wCix8PUjFpA4
        m4C2xJ8toiDlIgKOEr27DrOA1DCDzNky/RfYHGEBa4kNx8+xgtgsAqoSjctmMoL08grYSJy5
        mAmxSl5i9YYDzCA2J1C4f953dhBbCKh186IlrBMY+RYwMqxilEwtKM5Nzy02LDDKSy3XK07M
        LS7NS9dLzs/dxAgOSy2tHYwnTsQfYhTgYFTi4T2hcjlWiDWxrLgy9xCjBAezkgiv36MLsUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoYLaN5wlxsMybt
        iH3H05S09VBVuhTb9dUHXjl8W1S9xr0odsqZA7e/+6y+la14veOGzfumMgveGwsaI1o+pM3O
        OLjic7x7jm5C+qIHrleNbPfM8Jgo07IluNM670fe3vcaL3L2dfRedrh+5u85qeTDs38dtmy7
        MXcKx9MLLdvEXwd5BM1aU7y4V4mlOCPRUIu5qDgRAIgf8BNHAgAA
X-CMS-MailID: 20191119071409epcas1p2253bc4b3be05ac82201126bc62bd37ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071409epcas1p2253bc4b3be05ac82201126bc62bd37ac
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071409epcas1p2253bc4b3be05ac82201126bc62bd37ac@epcas1p2.samsung.com>
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

