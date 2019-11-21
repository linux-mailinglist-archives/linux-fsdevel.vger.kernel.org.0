Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2507104A37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKUF3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:29:55 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30258 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfKUF31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:29:27 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191121052924epoutp029539de862bfa0bd573b4fae23b5b502d~ZFmQ40Lsf0175801758epoutp02j
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191121052924epoutp029539de862bfa0bd573b4fae23b5b502d~ZFmQ40Lsf0175801758epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574314164;
        bh=cebDS4wJnJkhFo4uYCXo0DH3otueb9YFlYeYEY3vVQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9Nl+8obhK1RFwrGhcAg/qj1a95IuFTDCIEdnBlqAAa25tBIreH8NY8UnhMfp7jvK
         jL/WO57M4nTBNx0KhAobL8ROBCiZHleLKyZY9b6YyWVnleaRn7RSunq94q+q/bmoVt
         h0P3eEzySnxeMbiE95BPVDwLWI22A5Q0VScRi29M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191121052923epcas1p2a8e607675c80b4ad3a73a050a9be6878~ZFmQMsPSJ0047900479epcas1p2c;
        Thu, 21 Nov 2019 05:29:23 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47JSmM0YthzMqYkj; Thu, 21 Nov
        2019 05:29:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.F7.04235.2B026DD5; Thu, 21 Nov 2019 14:29:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191121052922epcas1p4c3957530e6d0ea89e1fc09322e999fb9~ZFmPGEO9N2154621546epcas1p4y;
        Thu, 21 Nov 2019 05:29:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191121052922epsmtrp113cf68692eb44478fcc823d1928ef9d1~ZFmPCy12Y1320813208epsmtrp19;
        Thu, 21 Nov 2019 05:29:22 +0000 (GMT)
X-AuditID: b6c32a36-defff7000000108b-3f-5dd620b25486
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.06.03654.2B026DD5; Thu, 21 Nov 2019 14:29:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052922epsmtip157e89ab879a8f84b1fe10cc62b038b54~ZFmO2_ASG1142611426epsmtip15;
        Thu, 21 Nov 2019 05:29:22 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 13/13] MAINTAINERS: add exfat filesystem
Date:   Thu, 21 Nov 2019 00:26:18 -0500
Message-Id: <20191121052618.31117-14-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121052618.31117-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTX3eTwrVYgx07bCwOP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZ1SOTUZqYkpqkUJq
        XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QsUoKZYk5pUChgMTiYiV9
        O5ui/NKSVIWM/OISW6XUgpScAkODAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyMpmW/mQq+sVa0
        LTvB2MDYwNrFyMEhIWAisX+vZxcjJ4eQwA5GiVOPxLoYuYDsT4wS7xd2sEA43xglpnybzgJS
        BdIwve0AE0RiL6PEnrvrWeFaZsxYxAIylk1AW+LPFlGQBhEBe4nNsw+ATWIWuM4o8ezWDFaQ
        hLCAtcStP5/BprIIqEpcXHWcHcTmFbCVuLToEhvENnmJ1RsOMIPM5ASK3/9dCTJHQuA2m8TX
        3W+ZIGpcJJYfvc0KYQtLvDq+hR3ClpJ42d/GDvFmtcTH/cwQ4Q5GiRffbSFsY4mb6zeAQ4JZ
        QFNi/S59iLCixM7fcxlBbGYBPol3X3uggcUr0dEmBFGiKtF36TDUAdISXe0foJZ6SNyZPIUd
        EiITGCWu/PjFOIFRbhbChgWMjKsYxVILinPTU4sNC4yQo2sTIzgpapntYFx0zucQowAHoxIP
        b4bG1Vgh1sSy4srcQ4wSHMxKIrx7rl+JFeJNSaysSi3Kjy8qzUktPsRoCgzHicxSosn5wISd
        VxJvaGpkbGxsYWJmbmZqrCTOy/HjYqyQQHpiSWp2ampBahFMHxMHp1QDo/nTRyIim9PMt9z5
        FqC8c12IttVymXnGm6YtrBKPXvCFLVlZ9McntVfSd7yOMGTcflTw7W40Y8wk5myZMNsDH+4c
        0Hnu4/rkT9rDa7onav79/SP3rt408+mdy/OuNXR1v+61NvkhfKZ0xdPKufvkJvfMm6NYqvah
        8vivpSn1Dz/4Bf1V2yR6cLISS3FGoqEWc1FxIgBUxvjsoAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnO4mhWuxBhfeS1gcfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9Rb/37SwWGz5d4TV4tL7DywO3B47Z91l
        99g/dw27x+6bDWwefVtWMXqs33KVxWPz6WqPz5vkPA5tf8PmcfvZNpYAzigum5TUnMyy1CJ9
        uwSujKZlv5kKvrFWtC07wdjA2MDaxcjJISFgIjG97QBTFyMXh5DAbkaJh9MPMEIkpCWOnTjD
        3MXIAWQLSxw+XAxR84FR4vT7tUwgcTYBbYk/W0RBykUEHCV6dx1mAalhFnjMKHHi/BOwOcIC
        1hK3/nxmAbFZBFQlLq46zg5i8wrYSlxadIkNYpe8xOoNB8B2cQLF7/+uBAkLCdhIXD3xgnUC
        I98CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB4auluYPx8pL4Q4wCHIxKPLwZ
        GldjhVgTy4orcw8xSnAwK4nw7rl+JVaINyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJ
        JanZqakFqUUwWSYOTqkGxroHxh09l9XsLoe/NjVauiUgJ7tR2Vldmt2uLT209eCeyQt6fTN7
        JY/1v3C9GNayMSr19QPG9/NX1zyd76qsdP/NJK3Ld7i6tyfMPcv227OpLnGbeSfXrUVrtjBa
        cTxI4rp+0JWZw7Ijl8NLQuPqnpyIKbsOuRw5sZ/J+OdzpvVNFcmlmU+ylFiKMxINtZiLihMB
        Or62olsCAAA=
X-CMS-MailID: 20191121052922epcas1p4c3957530e6d0ea89e1fc09322e999fb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052922epcas1p4c3957530e6d0ea89e1fc09322e999fb9
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052922epcas1p4c3957530e6d0ea89e1fc09322e999fb9@epcas1p4.samsung.com>
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
index 9d61ef301811..41a69751840c 100644
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

