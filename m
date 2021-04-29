Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4162C36E2A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 02:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhD2Ahg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 20:37:36 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:56892 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhD2Ahf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:37:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210429003646epoutp0437d92e07201926650cdc2629779e456a~6LRoWkHCW1636716367epoutp04B
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Apr 2021 00:36:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210429003646epoutp0437d92e07201926650cdc2629779e456a~6LRoWkHCW1636716367epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619656606;
        bh=Rs4hweBVlusbdTQ2mGXyjhwjjfoX5tya5FD/hbIXQIc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NyskOLoDAuYSb88Kdw2PQF9v3uZ+mEQvaOzNq26zZ31YeOmMF88VsHb9IgNRKy3+A
         X1RnMlpBmQIDLtSQERjos0m4UD7tn6SiOsPnFDw5G6gc6JAHgndMBn6I5nvtW/QaLl
         YGTG7xSDSjJLGrd9rvLaNAOBdwSnQZsiNGDuXkUs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210429003645epcas1p3250a9c6843a0a62a96ad2d3370f46823~6LRnz99cg2885728857epcas1p3G;
        Thu, 29 Apr 2021 00:36:45 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FVxQN6jVnz4x9QC; Thu, 29 Apr
        2021 00:36:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.AC.09701.C9FF9806; Thu, 29 Apr 2021 09:36:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210429003644epcas1p2373d7cd3fbf45977a30fd5458e26127b~6LRmvQNnn1490814908epcas1p2X;
        Thu, 29 Apr 2021 00:36:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210429003644epsmtrp280f8ded9a3e3130ee5e2dc7c0f8f1ed2~6LRmuI0it2361323613epsmtrp2Q;
        Thu, 29 Apr 2021 00:36:44 +0000 (GMT)
X-AuditID: b6c32a36-631ff700000025e5-25-6089ff9c7ad7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.7A.08163.C9FF9806; Thu, 29 Apr 2021 09:36:44 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210429003643epsmtip21858ebde757f65931994178dd6f95e19~6LRma_odS2570725707epsmtip2f;
        Thu, 29 Apr 2021 00:36:43 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <smfrench@gmail.com>, <senozhatsky@chromium.org>,
        <hyc.lee@gmail.com>, <viro@zeniv.linux.org.uk>, <hch@lst.de>,
        <hch@infradead.org>, <ronniesahlberg@gmail.com>,
        <aurelien.aptel@gmail.com>, <aaptel@suse.com>,
        <sandeen@sandeen.net>, <dan.carpenter@oracle.com>,
        <colin.king@canonical.com>, <rdunlap@infradead.org>,
        <willy@infradead.org>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <stfrench@microsoft.com>
In-Reply-To: <20210428201657.GC7400@fieldses.org>
Subject: RE: [PATCH v2 07/10] cifsd: add oplock/lease cache mechanism
Date:   Thu, 29 Apr 2021 09:36:44 +0900
Message-ID: <005e01d73c8f$bac48470$304d8d50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNL6Zwb6vy310px/Tzlbv2G7iqz3AB9QMybAefQKBkBP1K+fafEJEaQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJsWRmVeSWpSXmKPExsWy7bCmnu6c/50JBsde6ls0vj3NYnH89V92
        ixdToix+r+5ls3j9bzqLxekJi5gsVq4+ymRx7f57dos9e0+yWFzeNYfN4u0doGxv3ydWi9Yr
        Wha7Ny5is1j7+TG7xZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7zGroZfOY3XCRxWPD1CY2j52z
        7rJ7bF6h5bH7ZgObR+uOv+weH5/eYvHYsvghk8f6LVdZPD5vkvPY9OQtUwBPVI5NRmpiSmqR
        Qmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCLSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqEnIxXsycwFnxh
        qli47D1rA+Nipi5GTg4JAROJe2tvsnQxcnEICexglFj7qocdwvnEKLHm9lw2COczo8SqX/+Y
        YVoOHrrICpHYxSgxY8dVKOcFUMukhYwgVWwCuhL//uxnA7FFBPQkbve/BZvLLNDEIjF77Uqw
        7ZwChhKfF00BaxAWcJVoe9PIDmKzCKhKbNpyFMzmFbCUOPngESOELShxcuYTFhCbWUBeYvvb
        OVAnKUj8fLoM6AoOoGVuEj9+BECUiEjM7myDKlnMKXH4thWE7SKx4csBdghbWOLV8S1QtpTE
        53d72UDGSAhUS3zcD9XawSjx4rsthG0scXP9BrBNzAKaEut36UOEFSV2/p7LCLGVT+Ld1x5W
        iCm8Eh1tQhAlqhJ9lw5DQ11aoqv9A/sERqVZSN6aheStWUjun4WwbAEjyypGsdSC4tz01GLD
        AiPkuN7ECE79WmY7GCe9/aB3iJGJg/EQowQHs5II7+91nQlCvCmJlVWpRfnxRaU5qcWHGE2B
        AT2RWUo0OR+YffJK4g1NjYyNjS1MzMzNTI2VxHnTnasThATSE0tSs1NTC1KLYPqYODilGpgK
        f2+f6KSh8/CMcVy39Vw/11MW75O2TXouEzdj3c98UylP+6BNTssCb0Wn3q2eV3HRwGfl1rNr
        w6cJz/csiFv43m7mDG+21ii7uQv6yxUf9qVarw18+0pv4ftf+6IYpt75Kh9l7en/WMP21MRb
        lhoeF15n9ajl8H/3UFn0P45teZTF17drfut4T8srfW7VkKy5ZpLx1W8COULX00MVgte7Hb4X
        8U3w4YVrfO53fu3rNw95x/64we/tYt42Eakrn3P3eZtU5Fk0dGaYJQtXCp8LXVeuue/epgdr
        xbNm8qxk8L4pvzh4cXOI672Fj97/Ohf8nHevkL3VLZHuM5N9nG+x/P+q+lOfT56Z40Iap7ES
        S3FGoqEWc1FxIgCWwHLkhgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSvO6c/50JBjOXcVk0vj3NYnH89V92
        ixdToix+r+5ls3j9bzqLxekJi5gsVq4+ymRx7f57dos9e0+yWFzeNYfN4u0doGxv3ydWi9Yr
        Wha7Ny5is1j7+TG7xZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7zGroZfOY3XCRxWPD1CY2j52z
        7rJ7bF6h5bH7ZgObR+uOv+weH5/eYvHYsvghk8f6LVdZPD5vkvPY9OQtUwBPFJdNSmpOZllq
        kb5dAlfGq9kTGAu+MFUsXPaetYFxMVMXIyeHhICJxMFDF1m7GLk4hAR2MEocWP+XESIhLXHs
        xBnmLkYOIFtY4vDhYoiaZ4wS7xtegtWwCehK/Puznw3EFhHQk7jd/5YdpIhZYBqLxPNPaxgh
        Op4wSmy6fZ8VpIpTwFDi86IpYN3CAq4SbW8a2UFsFgFViU1bjoLZvAKWEicfPGKEsAUlTs58
        wgJyBTPQhraNYGFmAXmJ7W/nMEMcqiDx8+kyVpASEQE3iR8/AiBKRCRmd7YxT2AUnoVk0CyE
        QbOQDJqFpGMBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgFKCltYNxz6oPeocY
        mTgYDzFKcDArifD+XteZIMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILU
        IpgsEwenVANTuVSr8XZWuU3h25KWpT9XXX1U87QXj/Mdx8n5q+cILjVc13TseRYnv39ttL2B
        w6eg2srWtG9Hl816H8397dm9lA4Pa6mzE++ynX7m9KhJ63fmmUPtfEo7dge7HPjpJ3Z4kUvC
        QiaR7ofz4hyYf9Qvytqy43T2EVOTB6wPQ5dOPeO5uLXulACXyQdbYSkp1l8KwtuqxF58D5QW
        /33iq9V3Qc22fSbn48oYxW8aKHAnHcj8WKMk2tFTuMr00cMVLgw9wd6vTB1WfbzdGO51TsBn
        4+q8Usn3L+b8OdGo13y6smZ2/aG5PBKTEmamlVx24jxfopO/PqX/3Lq9GQHPL8QEvTouuKk9
        NK412sXpXLASS3FGoqEWc1FxIgBRtLHMcAMAAA==
X-CMS-MailID: 20210429003644epcas1p2373d7cd3fbf45977a30fd5458e26127b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422003843epcas1p374627e9b9bc86da8408892407a0b4428
References: <20210422002824.12677-1-namjae.jeon@samsung.com>
        <CGME20210422003843epcas1p374627e9b9bc86da8408892407a0b4428@epcas1p3.samsung.com>
        <20210422002824.12677-8-namjae.jeon@samsung.com>
        <20210428201657.GC7400@fieldses.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, Apr 22, 2021 at 09:28:21AM +0900, Namjae Jeon wrote:
> > This adds oplock and lease cache mechanism.
> 
> Are leases and oplocks only enforced against other cifsd clients?
Yes.
> So, a non-cifs user of the filesystem won't break cifsd's leases?
Yes, It may be considered together in the ksmbd/nfsd interop added by
TODO of feature table.

> --b.
> 

