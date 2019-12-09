Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517D211672F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 07:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfLIGzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 01:55:37 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:35999 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfLIGzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:55:08 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191209065506epoutp039ba9e1fb3761fbb3e64ccdac9b7a3476~eoYOzCNdC2181621816epoutp03J
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2019 06:55:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191209065506epoutp039ba9e1fb3761fbb3e64ccdac9b7a3476~eoYOzCNdC2181621816epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575874506;
        bh=BQMzFjXZUxAA/aGKbpc6LXqAXraXwtjNcNJwMrNXjDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIdMBItwr+Z3wsU8CcWpu7skJjZfoquCrD03/RWyT6mMEYMM1nGyoz8y2szFxa7Ab
         VmsbiwhMf4a6heu+4SMwRnsN1K6mTYmw/DJjtVy8Z/z07BhEGvpwRxu+X/+GR19RvS
         zyx5DXiJlIh1knXLhRB3DIe8W6ZiFH3/ue4aXxew=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191209065506epcas1p2a6ae4a51cecd9a810d7300b5a946e882~eoYOhwbd12291722917epcas1p2e;
        Mon,  9 Dec 2019 06:55:06 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47WYpx0HCFzMqYkb; Mon,  9 Dec
        2019 06:55:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.C8.48498.8CFEDED5; Mon,  9 Dec 2019 15:55:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191209065504epcas1p261e9cd0660deddb18d76684038c9b8fa~eoYM10z-F2289222892epcas1p2X;
        Mon,  9 Dec 2019 06:55:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209065504epsmtrp16a0d75588ba5ce063bf867195e5a2184~eoYM1LKIk2418724187epsmtrp1Y;
        Mon,  9 Dec 2019 06:55:04 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-30-5dedefc8e4d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.48.10238.8CFEDED5; Mon,  9 Dec 2019 15:55:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209065504epsmtip135698c2d1f76a7685c4bcd84b9b236c7~eoYMnWBLm1817618176epsmtip1B;
        Mon,  9 Dec 2019 06:55:04 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v6 13/13] MAINTAINERS: add exfat filesystem
Date:   Mon,  9 Dec 2019 01:51:48 -0500
Message-Id: <20191209065149.2230-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209065149.2230-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTu5929u1qL63x0srB1IUJF3cPpTV0FPRgUJAkW2rKru0xzL3Zn
        2AO0l8owbRBZWRGpYSY4zHcvm5ZF0ZNQM4xIzMRnURlGtO1q9d93vvN95xzOOSQm/YSHkblm
        O2czs0aaCBC1dkfERj+amtDJx4eUzPHqRoK5fuOBH3P7zmMR87rzIsHMVhYyzb97cObV1LRo
        o1h771KDWHtroIjQljfXI+3XpnCtu22cSMHTjck5HKvnbDLOnG3R55oNGnpbauamTHW8XBGt
        WMck0DIza+I09ObtKdFbc42eKWjZAdaY76FSWJ6nY9cn2yz5dk6WY+HtGpqz6o1Whdwaw7Mm
        Pt9siMm2mBIVcrlS7VHuM+Zc7dtt/Y4XdMz8FBWhItyB/Emg4sBZMejnQAGklGpHMHl0lBCC
        Lwg+zJ0XCcF3BK5nLX4Llg5nPSYk7iDoa6kW/7V0HX/o8ZMkQUXBr+YQryGY2gA3q7p8lTDq
        BIIrT2YxbyKISoLuphYfFlFroKt/WOz1SqhkmLtcIDRbBTdcXT6Jv4ceL7vvmxWoiwRUuaoI
        QbQZnve8m8dBMNbbLBZwGHyuKPbVBOowzNzDBLoUwegPjYBVMNDowr0SjIqAxs5YgV4NHXOX
        kBdj1FKY/FaGC1UkUFosFSRroPxV9/xKVoCjZHq+qRZq+9/gwkYqELx3tOKnUfiFfx2uIFSP
        QjkrbzJwvMKq/P9eTcj3ZJHx7ejqs+1uRJGIXiKRJU7opDh7gD9ociMgMTpYUuMc00klevbg
        Ic5mybTlGznejdSePTqxsJBsi+dlzfZMhVqpUqmYuPiEeLWKXiYhZ1/qpJSBtXN5HGflbAs+
        P9I/rAjV7a9esSVROhvaGxJgV2552ldyyt2ZN9QHLsWMrqyO760ZdWRlpGUkzVTuTLsWRZ9f
        VPviXPaSthR70mBu+bFOSjJdmNq/doTZw2gMgQ0foe3IG+PXrMC75pFTsGMlHb5x+eLHO/Df
        BWdPut42iFp3xTbsrSxMODN85kJQOjj1tIjPYRWRmI1n/wCBSn/EegMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSnO6J929jDea0SFk0L17PZrFy9VEm
        iz17T7JYXN41h83ix/R6iy3/jrBaXHr/gcWB3WP/3DXsHrtvNrB59G1ZxejxeZOcx6Htb9gC
        WKO4bFJSczLLUov07RK4MhZdjyj4xlqx8+NPlgbGBtYuRk4OCQETiZ0TVzF3MXJxCAnsZpTo
        /XCeBSIhLXHsxBmgBAeQLSxx+HAxRM0HRol355+ygsTZBLQl/mwRBSkXEXCU6N11mAWkhlmg
        i1HiUdM3ZpCEsIC1xOFNW8FsFgFViQM3nrCD9PIK2Ej8nlcBsUpeYvWGA2AlnEDhNz0HmUBs
        IaDWqy+XMk5g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM43LQ0dzBeXhJ/
        iFGAg1GJh7fC5m2sEGtiWXFl7iFGCQ5mJRHeJRNfxQrxpiRWVqUW5ccXleakFh9ilOZgURLn
        fZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAKJDzP0x9/71LC/Ozu+yiXYRymNPXLLDp/G+tnXVC
        OzaBXdhqzS0XtU0d06UC9gYYnddmWLqw+9K9/Q8n6FxLY/n5Pk3o4udTZVNCk8NurF//6qik
        k4xX9fZ10VcbZx9oXGB61OVuKlP+3vkfTf5FqZSevXBQ+de8jSkZfxYlTZm3wZq3xazwrhJL
        cUaioRZzUXEiAD7uCVwzAgAA
X-CMS-MailID: 20191209065504epcas1p261e9cd0660deddb18d76684038c9b8fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065504epcas1p261e9cd0660deddb18d76684038c9b8fa
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
        <CGME20191209065504epcas1p261e9cd0660deddb18d76684038c9b8fa@epcas1p2.samsung.com>
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
index 8ecf4253d794..4523823ad5cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6214,6 +6214,13 @@ F:	include/trace/events/mdio.h
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

