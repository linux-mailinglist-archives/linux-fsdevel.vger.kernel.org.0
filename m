Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5ECF11DE06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfLMFyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:54:13 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:56528 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbfLMFxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:53:48 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191213055347epoutp0402f44a6f3f165e31a3f6eb9aba856534~f2H1AQRI91153911539epoutp04Q
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 05:53:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191213055347epoutp0402f44a6f3f165e31a3f6eb9aba856534~f2H1AQRI91153911539epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576216427;
        bh=UUoUAxVUeGrd9/f+ZckaJUxyKKqatbYoOYEmtYBTzpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IK1vWp/3YnFJagt3J1SaBEFZoJ/zErxi9Kfav+dRaTmSWaFxLQ74BJsHcb+292Jem
         rw2otUadPuWpaGcnjbOzJjMgrxMASRtRbDXLOcQdNYEvT30Wfdjmc+qLMZLXDPeKyc
         NAa892dyYPS8VDpF4qOVXpB8EnxwZwrq9EYlVMvM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191213055346epcas1p47bab349ea9bb7a977767bac55ad71608~f2H0aCfRe0641506415epcas1p4l;
        Fri, 13 Dec 2019 05:53:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47Z0GK5jdxzMqYkm; Fri, 13 Dec
        2019 05:53:45 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.00.48019.96723FD5; Fri, 13 Dec 2019 14:53:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191213055345epcas1p10a858f9ceb26f217e00183669947e500~f2HzZVMHJ0207402074epcas1p16;
        Fri, 13 Dec 2019 05:53:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191213055345epsmtrp208bdf9b7ae4a1ae58673551318c6de99~f2HzYqiXh0142801428epsmtrp2E;
        Fri, 13 Dec 2019 05:53:45 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-c3-5df327690a6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.92.06569.96723FD5; Fri, 13 Dec 2019 14:53:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055345epsmtip250e8fabe94f851aeef61b31144a0b3ff~f2HzP73Al1079710797epsmtip2M;
        Fri, 13 Dec 2019 05:53:45 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v7 13/13] MAINTAINERS: add exfat filesystem
Date:   Fri, 13 Dec 2019 00:50:28 -0500
Message-Id: <20191213055028.5574-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213055028.5574-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmrm6m+udYg9/PtS2aF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEq
        E3IyTvWuYCv4xlrx+8AU9gbGBtYuRk4OCQETiS/LHzB1MXJxCAnsYJR4+3YvC0hCSOATo8T+
        k4EQ9jdGiXVndWAaFt46ygjRsJdR4uqzVcwQDlDDxI8Pgbo5ONgEtCX+bBEFaRARsJfYPPsA
        C0gNs0ALo8SC0z+YQRLCAtYSV/c9BdvGIqAqsfr3NDCbV8BG4t+FPywQ2+QlVm84AFbPCRSf
        N/kDO8ggCYE5bBKnW39CFblI7D3WAvWPsMSr41vYIWwpic/v9rKBHCQhUC3xcT8zRLiDUeLF
        d1sI21ji5voNrCAlzAKaEut36UOEFSV2/p7LCGIzC/BJvPvawwoxhVeio00IokRVou/SYSYI
        W1qiq/0D1FIPiVuzp7JCgqSfUWL52VUsExjlZiFsWMDIuIpRLLWgODc9tdiwwAQ5vjYxghOZ
        lsUOxj3nfA4xCnAwKvHwMqR8ihViTSwrrsw9xCjBwawkwmtfAxTiTUmsrEotyo8vKs1JLT7E
        aAoMyInMUqLJ+cAkm1cSb2hqZGxsbGFiZm5maqwkzsvx42KskEB6YklqdmpqQWoRTB8TB6dU
        A6Ni9NZCrw/PxUNrCvO/rn7yjvtK9P6l9wqDKrJ+Fvs6WyueeWo8acbDj9tutz2ydORaEv3Q
        tNtUw+SWWsPu2i7tWPFwTnbHq54lN4xZf/MEPTpVbnvgR6nVnLPFJlcFpE3nqy+Muu/2o7um
        +okAW/GcQ8wMZ54tn29pPEFNp0BpeZzJ7FP9KkosxRmJhlrMRcWJADls5YB6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvG6m+udYgx/LhSyaF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFFcNimpOZllqUX6dglcGad6V7AVfGOt+H1gCnsDYwNrFyMnh4SAicTCW0cZuxi5OIQEdjNK
        nJm9mxkiIS1x7MQZIJsDyBaWOHy4GKLmA6PEp/f/2UHibALaEn+2iIKUiwg4SvTuOswCUsMs
        0MUo8ajpG9gcYQFriav7nrKA2CwCqhKrf08Ds3kFbCT+XfjDArFLXmL1hgNg9ZxA8XmTP7CD
        2EJAvXffvmKbwMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcMhpae1gPHEi
        /hCjAAejEg/visRPsUKsiWXFlbmHGCU4mJVEeO1rgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        5fOPRQoJpCeWpGanphakFsFkmTg4pRoYp54KStKaqlTBPf06y64KhdqjR6//2Bm1JJ7FZZHF
        sR31fkf2bApsPzJt76kTPZbz51uKGVzlWWB2xrFIvuxkyObUT3khav+cP67svLq7eObfLTuS
        pm1ctfzvrtsle+NF7SQy+EvNlWMmvSo72X/29YlzSYdF3eZOfZRqW96k4sy5eOlVSYOXF5VY
        ijMSDbWYi4oTAdkRkio1AgAA
X-CMS-MailID: 20191213055345epcas1p10a858f9ceb26f217e00183669947e500
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213055345epcas1p10a858f9ceb26f217e00183669947e500
References: <20191213055028.5574-1-namjae.jeon@samsung.com>
        <CGME20191213055345epcas1p10a858f9ceb26f217e00183669947e500@epcas1p1.samsung.com>
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
index d10d73276fed..672ed71d01f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6216,6 +6216,13 @@ F:	include/trace/events/mdio.h
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

