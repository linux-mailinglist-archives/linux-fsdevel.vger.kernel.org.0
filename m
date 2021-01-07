Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32C82ECA7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 07:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbhAGGYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 01:24:24 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:40602 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhAGGYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 01:24:23 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210107062338epoutp035413f2ea383bdda2b6569bd70d1ba1bb~X3whUewem1835718357epoutp03u
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 06:23:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210107062338epoutp035413f2ea383bdda2b6569bd70d1ba1bb~X3whUewem1835718357epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610000618;
        bh=R4is/Ep0hJRf/2NW4TpOdp4BEDnzWEJy5TzUv5ZED2A=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iuJoVKGWyVOXlpt9KDtR7f5H9fLPvseGfPyThnvZmrGmeH21XvNEEwLYKWqAUZcIu
         8dp0VZ9SFDijiL5sL64wLYzV6B2TFwzLUMSxzPWd64s9tFx9tYMpjZIpDGBJjovbiX
         BmJnuCOS0bhOp7QRCSPttTK08OW9Ab9JX6hk0fBE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210107062338epcas1p2dd7fff20df0d09ccbeb9dc5b00247a86~X3wg4jwrz1993319933epcas1p2l;
        Thu,  7 Jan 2021 06:23:38 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DBGQK1VQ9z4x9Q7; Thu,  7 Jan
        2021 06:23:37 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.05.02418.9E8A6FF5; Thu,  7 Jan 2021 15:23:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210107062336epcas1p1f7bb77862b7c00b818c6a24bb04a76fa~X3wfcHk6k1697116971epcas1p1Y;
        Thu,  7 Jan 2021 06:23:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210107062336epsmtrp1906a12427a548ad8cd6d0590ccf351a0~X3wfbZqkr0225302253epsmtrp16;
        Thu,  7 Jan 2021 06:23:36 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-8e-5ff6a8e9a0c5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.3A.08745.8E8A6FF5; Thu,  7 Jan 2021 15:23:36 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210107062336epsmtip2f5d1ae94da103c2b4b84f1d97733f074~X3wfOZmuL2214722147epsmtip2j;
        Thu,  7 Jan 2021 06:23:36 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20210106043945.36546-1-hyeongseok@gmail.com>
Subject: RE: [PATCH] exfat: improve performance of exfat_free_cluster when
 using dirsync mount option
Date:   Thu, 7 Jan 2021 15:23:36 +0900
Message-ID: <244001d6e4bd$a18072f0$e48158d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQE9l3LMTUKYLRjlfrko2bpokujgCAI4/HcfqzyDawA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmru7LFd/iDWYt57D4O/ETk8WevSdZ
        LC7vmsNm8WN6vQOLx85Zd9k9+rasYvT4vEkugDkqxyYjNTEltUghNS85PyUzL91WyTs43jne
        1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaJmSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
        tSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY/r2y4wFD3kqftzfy9zAeIOji5GTQ0LA
        RKL731fGLkYuDiGBHYwSNx/PZoFwPjFKXH3+nhXC+cwo8WbyCjaYlh8tt6ASuxglnt/6xwbh
        vGSU2DXhABNIFZuArsSTGz+ZQWwRAQ+Jx03HwOLMAs4Sh2+cAotzClhJ3Dq3jh3EFhZIl2i8
        uB5sA4uAisTqu++B6jk4eAUsJZ79zAUJ8woISpyc+YQFYoy8xPa3c5ghDlKQ2P3pKCvEKiuJ
        n9cXskHUiEjM7mxjBrlNQuAru8TNrROgPnCRuPB/IzuELSzx6vgWKFtK4mV/G5RdL/F//lp2
        iOYWRomHn7aBHSQhYC/x/pIFiMksoCmxfpc+RLmixM7fcxkh9vJJvPvawwpRzSvR0SYEUaIi
        8f3DThaYTVd+XGWawKg0C8lns5B8NgvJB7MQli1gZFnFKJZaUJybnlpsWGCIHNmbGMEJUct0
        B+PEtx/0DjEycTAeYpTgYFYS4bU49iVeiDclsbIqtSg/vqg0J7X4EKMpMKgnMkuJJucDU3Je
        SbyhqZGxsbGFiZm5mamxkjhvksGDeCGB9MSS1OzU1ILUIpg+Jg5OqQamXBlT7yMyel1nP93y
        /VrtmnSRZds5JsXt4p/MF6xfPmfhiuBysaoDOy6/P/q8+vCy5s6+tZsdwh4KGm19vF3FxfVE
        KtudwLJDNqxHHW/KSppIlQOT7syaisreNwYqK8yWZZ1kdfK6w9cyf+5y470hijafA8pqQgMf
        6f0MPd97nDcrb1W2pNPSFdWrElJ7NnlnWsXP4OQo2nCyhnfnsd5n7z++inGvsN36vPdtoNrS
        x43nG9J+lG36vjv8Ta/efZXETKMp4m9VG/af2DhtKV9Jk0/Suer/95g+PS1r5fsmklnsq6hc
        seiz1eZQv6L9Jek5sp9jFOMu9egJ67jpJL2YGVj+c9ZSU/lZu3/UTlViKc5INNRiLipOBADp
        FdHwEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO6LFd/iDS78lrP4O/ETk8WevSdZ
        LC7vmsNm8WN6vQOLx85Zd9k9+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2P69suMBQ95Kn7c
        38vcwHiDo4uRk0NCwETiR8st1i5GLg4hgR2MEhs/NrJ3MXIAJaQkDu7ThDCFJQ4fLoYoec4o
        cWr7ezaQXjYBXYknN34yg9giAl4S+5tes4PYzAKuEvOfr2aDaOhmlPh3+RtYEaeAlcStc+vA
        ioQFUiX2Pp0DNohFQEVi9d33TCDLeAUsJZ79zAUJ8woISpyc+YQFJMwsoCfRtpERYry8xPa3
        c5ghzleQ2P3pKCvECVYSP68vZIOoEZGY3dnGPIFReBaSSbMQJs1CMmkWko4FjCyrGCVTC4pz
        03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCY0JLawfjnlUf9A4xMnEwHmKU4GBWEuG1OPYlXog3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamuplzD7iV3t4r
        oe+jeuSuz4LGlGcfGoS0kjat3slyYDZPSEDot6c2liKlbK9Yni+5PK9Xij+Tf+pk080+S22W
        B3azvt1+qLZr4YSKMnMHi4/6QS4rSir42CaY7UzYZVtw35InIb7SSPmHQG3TaRnrVaovnpxa
        yHxVUf9X9VbNJXxSXNIxqq2z0v+1NRXNjXso/+CUoKTQ3KxnzpvLlH5fLmTctCA7U3vR1k+p
        oa+OWz//UrVkx8ZMdes6kxXFjMucrV9t+JbxiPX6mj+TwsKMgJHL1vLhg6Ao8xy5F7PX/+Bi
        unnjZ7dzR23FZFP5mz+DTob9vyN1esttsfjtf8JTvp7Pi7CUMP0irDX9MZsSS3FGoqEWc1Fx
        IgCitn9S+AIAAA==
X-CMS-MailID: 20210107062336epcas1p1f7bb77862b7c00b818c6a24bb04a76fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210106044038epcas1p2d3488531b0a63c122f7401d4d56b03a8
References: <CGME20210106044038epcas1p2d3488531b0a63c122f7401d4d56b03a8@epcas1p2.samsung.com>
        <20210106043945.36546-1-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> There are stressful update of cluster allocation bitmap when using dirsync
> mount option which is doing sync buffer on every cluster bit clearing.
> This could result in performance degradation when deleting big size file.
> Fix to update only when the bitmap buffer index is changed would make less
> disk access, improving performance especially for truncate operation.
> 
> Testing with Samsung 256GB sdcard, mounted with dirsync option (mount -t
> exfat /dev/block/mmcblk0p1 /temp/mount -o dirsync)
> 
> Remove 4GB file, blktrace result.
> [Before] : 39 secs.
> Total (blktrace):
>  Reads Queued:      0,        0KiB	 Writes Queued:      32775,
16387KiB
>  Read Dispatches:   0,        0KiB	 Write Dispatches:   32775,
16387KiB
>  Reads Requeued:    0		         Writes Requeued:        0
>  Reads Completed:   0,        0KiB	 Writes Completed:   32775,
16387KiB
>  Read Merges:       0,        0KiB	 Write Merges:           0,
0KiB
>  IO unplugs:        2        	     Timer unplugs:          0
> 
> [After] : 1 sec.
> Total (blktrace):
>  Reads Queued:      0,        0KiB	 Writes Queued:         13,
6KiB
>  Read Dispatches:   0,        0KiB	 Write Dispatches:      13,
6KiB
>  Reads Requeued:    0		         Writes Requeued:        0
>  Reads Completed:   0,        0KiB	 Writes Completed:      13,
6KiB
>  Read Merges:       0,        0KiB	 Write Merges:           0,
0KiB
>  IO unplugs:        1        	     Timer unplugs:          0
> 
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>

Looks good.
Thanks for your work!

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

