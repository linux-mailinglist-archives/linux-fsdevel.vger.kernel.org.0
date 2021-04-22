Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBB36765D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbhDVAj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:39:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50873 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343984AbhDVAjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:39:24 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210422003849epoutp039b9e62892de32dc322feb5e85c49646b~4BybZz9Ga1371613716epoutp03a
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 00:38:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210422003849epoutp039b9e62892de32dc322feb5e85c49646b~4BybZz9Ga1371613716epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619051929;
        bh=xsBknzlDxmSfXAIXNzGrnEmNwCb0KAIpNYMKuTCtwZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LieUNdm/boVbhwgkuFCuD92QSVq359pEpwjOMkHD1novEDVkBiqzKb14qbZEZqH9P
         bRuRkGbfRSi9swIIRa3qQHiZr6/43GzAE5fhZBDpZLgBKsQGBBCVLHvjo4Cgmuii2r
         2aRrQBun84V322dStWg/CgkrFBdIj+1wg8xHsupE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210422003848epcas1p4951406627aaf0ba4487b888f8ac2fccc~4Byazi5BC3271432714epcas1p4B;
        Thu, 22 Apr 2021 00:38:48 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FQdny4GKdz4x9Q9; Thu, 22 Apr
        2021 00:38:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.A1.09701.695C0806; Thu, 22 Apr 2021 09:38:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210422003846epcas1p1c8e4f9e46f77d2974e488785cd16d529~4ByYSD87N1793517935epcas1p1u;
        Thu, 22 Apr 2021 00:38:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210422003846epsmtrp14e7ebd36f3535c5aa43a1c2b6a06d0d9~4ByYQ4Lay2297822978epsmtrp1k;
        Thu, 22 Apr 2021 00:38:46 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-40-6080c5960c55
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.CA.08637.595C0806; Thu, 22 Apr 2021 09:38:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210422003845epsmtip18b0300aca580ef50d7767066a1f870c7~4ByYBLh9M1951419514epsmtip1F;
        Thu, 22 Apr 2021 00:38:45 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 10/10] MAINTAINERS: add cifsd kernel server
Date:   Thu, 22 Apr 2021 09:28:24 +0900
Message-Id: <20210422002824.12677-11-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422002824.12677-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmru60ow0JBmfuylk0vj3NYnH89V92
        i9+re9ksXv+bzmJxesIiJouVq48yWVy7/57dYs/ekywWl3fNYbP4Mb3e4u0doIrevk+sFq1X
        tCx2b1zEZrH282N2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2mNXQy+Yxu+Eii8fOWXfZPTav
        0PLYfbOBzaN1x192j49Pb7F49G1ZxeixZfFDJo/1W66yeHzeJOex6clbpgCeqBybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAXlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORn/nq9kLdjA
        XbF6+gTWBsbHnF2MnBwSAiYSW59uY+1i5OIQEtjBKLG57xYLhPOJUeLVp+NQmW+MEounzGGD
        afk1/TY7RGIvo8TkFxOZ4Fra9x1g7GLk4GAT0Jb4s0UUxBQRsJe4vdgHpIRZ4BCzxNcrfYwg
        g4QF7CQu325kAbFZBFQl9n6+ywRi8wrYSmw508oEsUxeYvWGA8wgNidQ/NeGlYwggyQErnBI
        XNpyjxlkgYSAi8Tb724Q9cISr45vYYewpSRe9rexQ5RUS3zczwwR7mCUePHdFsI2lri5fgMr
        SAmzgKbE+l36EGFFiZ2/54JdySzAJ/Huaw8rxBReiY42IYgSVYm+S4ehjpSW6Gr/ALXUQ2LK
        8sXMkACZwCjx8/gr9gmMcrMQNixgZFzFKJZaUJybnlpsWGCEHF+bGMEpWMtsB+Oktx/0DjEy
        cTAeYpTgYFYS4V1b3JAgxJuSWFmVWpQfX1Sak1p8iNEUGHQTmaVEk/OBWSCvJN7Q1MjY2NjC
        xMzczNRYSZw33bk6QUggPbEkNTs1tSC1CKaPiYNTqoFp9Z5QdftSnSLDU9IbpgY4722cfU62
        75eAv3je/fVx3zZuv7e7Ilyy64wwR21Y9GZdJfYuztBdi88JbK9k0n+4NylpqcLsa5GvT/P/
        bGU6K2mfsm5CpY6qxfw3CjfOPS12PH3SMP9Yl3JRy9vMFGn/4miuCX8Vj3BOFzSu41lhsf1t
        5oTlvG+4Vfeee2Rwbr3pkmnpF3b42ay7vj9RxubPlie9Eh98zRLddqRYSj80qbTjiYo12zg3
        t+oiB+8qt82T1qifVWlQ6vRwSlxqYp8cM9fh7c+jmTHmuuHFGTx3/9ZuCN0lue5YR0zcRD//
        WqvjO99e+VF/2PvcNdnT1mdEjp87tXeqod1ujzhZ+b9KLMUZiYZazEXFiQDYgITqSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnO7Uow0JBpf/2Vg0vj3NYnH89V92
        i9+re9ksXv+bzmJxesIiJouVq48yWVy7/57dYs/ekywWl3fNYbP4Mb3e4u0doIrevk+sFq1X
        tCx2b1zEZrH282N2izcvDrNZ3Jo4n83i/N/jrBa/f8xhcxD2mNXQy+Yxu+Eii8fOWXfZPTav
        0PLYfbOBzaN1x192j49Pb7F49G1ZxeixZfFDJo/1W66yeHzeJOex6clbpgCeKC6blNSczLLU
        In27BK6Mf89XshZs4K5YPX0CawPjY84uRk4OCQETiV/Tb7N3MXJxCAnsZpS4Muk0K0RCWuLY
        iTPMXYwcQLawxOHDxRA1HxglPt2bwQQSZxPQlvizRRSkXETAUeLE1EWMIDXMAteYJb5tn8AI
        khAWsJO4fLuRBcRmEVCV2Pv5LhOIzStgK7HlTCsTxC55idUbDjCD2JxA8V8bVoL1CgnYSDRN
        v8oygZFvASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4GjR0tzBuH3VB71DjEwc
        jIcYJTiYlUR41xY3JAjxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgm
        y8TBKdXAdLExlE1TcUKKJXPoSfdcufMlj5WbHidtWvoxVGb2v/JrthnOAU/kBI0WifrvfBp/
        kXeWx6df/HxyZt+fZ3FO124Sc/toIOIYfoun4d29Q+9/fH76wb4y/xP773m3oufdd1G9e9PF
        Y6Y+z7fAl1LyKewpJ3ZZSX7SfztZ+kdcwvtoBwc10w95Xp8btGQj6lYEn9w96ybPA3/f44+f
        s/h/UjdfFzLDt8nmdpfHJBer2lfSZ+5vv1P6Pfm8CH/KdrFmx6PHFWSNt+g/E8t//mxWwaPS
        g/1xd5d4Xp244Om5O0nrdFn3CL1V2O6yfe8svhTbnVHbb+q72vP/i3iaHPSTf7p0vTpjzqHO
        cN2Cd23hSizFGYmGWsxFxYkAvbhi4AUDAAA=
X-CMS-MailID: 20210422003846epcas1p1c8e4f9e46f77d2974e488785cd16d529
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003846epcas1p1c8e4f9e46f77d2974e488785cd16d529
References: <20210422002824.12677-1-namjae.jeon@samsung.com>
        <CGME20210422003846epcas1p1c8e4f9e46f77d2974e488785cd16d529@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself, Steve French, Sergey Senozhatsky and Hyunchul Lee
as cifsd maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..30f678f8b4d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4434,7 +4434,7 @@ F:	include/linux/clk/
 F:	include/linux/of_clk.h
 X:	drivers/clk/clkdev.c
 
-COMMON INTERNET FILE SYSTEM (CIFS)
+COMMON INTERNET FILE SYSTEM CLIENT (CIFS)
 M:	Steve French <sfrench@samba.org>
 L:	linux-cifs@vger.kernel.org
 L:	samba-technical@lists.samba.org (moderated for non-subscribers)
@@ -4444,6 +4444,16 @@ T:	git git://git.samba.org/sfrench/cifs-2.6.git
 F:	Documentation/admin-guide/cifs/
 F:	fs/cifs/
 
+COMMON INTERNET FILE SYSTEM SERVER (CIFSD)
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
+M:	Steve French <sfrench@samba.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-cifs@vger.kernel.org
+L:	linux-cifsd-devel@lists.sourceforge.net
+S:	Maintained
+F:	fs/cifsd/
+
 COMPACTPCI HOTPLUG CORE
 M:	Scott Murray <scott@spiteful.org>
 L:	linux-pci@vger.kernel.org
-- 
2.17.1

