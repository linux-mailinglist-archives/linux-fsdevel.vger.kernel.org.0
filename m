Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3F91AB449
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 01:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDOXfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 19:35:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:63390 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbgDOXfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 19:35:50 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200415233547epoutp02b520cfe2bf3cb449fd06e5c831ca8691~GImfLVsyw2960729607epoutp02I
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 23:35:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200415233547epoutp02b520cfe2bf3cb449fd06e5c831ca8691~GImfLVsyw2960729607epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586993747;
        bh=9x2DzfI1/6azeSx364Tska8oCeF3SMdDtzWdBAYjLAc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rPMROPwOvFNVj+/F0juPKJ/WuksAnA6l4wwxJ4QVrj3LCUwwIwf4ZenO0+1xx9qq1
         XgnOEfIjZllIRzdKWnD64DSJF9S8nBfhnwp3AnQp6z1tjEtwf+x2m2aKln9Ii1REml
         OtEGJ+YZNVHUhd5tKY0m4IAhJ9zBD79ebgl8afYs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200415233547epcas1p1615fdcb7cdddce3c4b8eac746f9bcd07~GIme-ZVoM1372213722epcas1p1W;
        Wed, 15 Apr 2020 23:35:47 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 492dyV1wXFzMqYkk; Wed, 15 Apr
        2020 23:35:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.4B.04744.25A979E5; Thu, 16 Apr 2020 08:35:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200415233545epcas1p4d9d0511a539f34404697590bf8cae933~GImdUmHRX1195211952epcas1p4p;
        Wed, 15 Apr 2020 23:35:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200415233545epsmtrp26818656049545ae41cf4d856ebcb6eb5~GImdTtAg60991809918epsmtrp2M;
        Wed, 15 Apr 2020 23:35:45 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-f6-5e979a52765f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.E9.04024.15A979E5; Thu, 16 Apr 2020 08:35:45 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200415233545epsmtip2f4ef5d32c169cf69c379f1c9350c4204~GImdDfSQV0355203552epsmtip2i;
        Wed, 15 Apr 2020 23:35:45 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Goldwyn Rodrigues'" <rgoldwyn@suse.de>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'Eric Sandeen'" <sandeen@sandeen.net>
In-Reply-To: <20200415164702.xf3t2stjpkjl6das@fiona>
Subject: RE: [ANNOUNCE] exfat-utils-1.0.1 initial version released
Date:   Thu, 16 Apr 2020 08:35:45 +0900
Message-ID: <000001d6137e$95efb510$c1cf1f30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCfrUrIEIADodibb3fNck4Cv/tmHQLnvwR+AfX3HKyqwLO/YA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmgW7QrOlxBidm8llcu/+e3WLP3pMs
        Fpd3zWGzmPB2HZNF6xUtB1aPnbPusntsWfyQyWPz6WqPz5vkAliicmwyUhNTUosUUvOS81My
        89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgLYqKZQl5pQChQISi4uV9O1sivJL
        S1IVMvKLS2yVUgtScgoMDQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMtr3z2cu2M9W8fjratYG
        xoWsXYycHBICJhK3Jrxh6mLk4hAS2MEoce39IlYI5xOjxN5z/6Ey3xglVnbfZYJp+fjgPiOI
        LSSwl1GicTUbRNFLRondf2ezgCTYBHQl/v3ZzwZiiwjoSLRvnsoMUsQsMJlR4tb3n2BFnECT
        5i94BmYLCzhJvF24HuwoFgFViX8fv4PZvAKWEu/XLWWEsAUlTs58AlbPLCAvsf3tHGaIixQk
        fj5dxgqxzElixovPjBA1IhKzO9vAFksI3GaTeNT0G+prF4lphyBekBAQlnh1fAs7hC0l8fnd
        XqCrOYDsaomP+6HmdzBKvPhuC2EbS9xcv4EVpIRZQFNi/S59iLCixM7fc6HW8km8+9rDCjGF
        V6KjTQiiRFWi79JhaBhKS3S1f2CfwKg0C8ljs5A8NgvJA7MQli1gZFnFKJZaUJybnlpsWGCC
        HNmbGMEpUstiB+Oecz6HGAU4GJV4eA1eTosTYk0sK67MPcQowcGsJMK7w396nBBvSmJlVWpR
        fnxRaU5q8SFGU2C4T2SWEk3OB6bvvJJ4Q1MjY2NjCxMzczNTYyVx3qnXc+KEBNITS1KzU1ML
        Uotg+pg4OKUaGNtf+T3YdtmC271YeDNfmE+vzraHorN7lK7ta4s6YP/K3NDvVJfWbq9OefV9
        Z+aGeUwK6+5zP/yrq9v/b+/Lp49ajDUshE8eTYtit1E0/8TAFzJdV8KiNeh6cvhR9+/XLP48
        ipGMnv7viMkxAeUlP///4OhLOmB38DjPiaDsdvXLDanHv1qbKrEUZyQaajEXFScCACUwMVKn
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvG7grOlxBqd+6Vpcu/+e3WLP3pMs
        Fpd3zWGzmPB2HZNF6xUtB1aPnbPusntsWfyQyWPz6WqPz5vkAliiuGxSUnMyy1KL9O0SuDLa
        989nLtjPVvH462rWBsaFrF2MnBwSAiYSHx/cZ+xi5OIQEtjNKDHh7AJ2iIS0xLETZ5i7GDmA
        bGGJw4eLIWqeM0psubyZCaSGTUBX4t+f/WwgtoiAjkT75qnMIEXMAtMZJe69fs0IkhAS2Mwo
        cWArB4jNCbRt/oJnLCC2sICTxNuF68GuYBFQlfj38TuYzStgKfF+3VJGCFtQ4uTMJywgRzAL
        6Em0bQQLMwvIS2x/O4cZ4k4FiZ9Pl7FC3OAkMePFZ6gaEYnZnW3MExiFZyGZNAth0iwkk2Yh
        6VjAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4UrQ0dzBeXhJ/iFGAg1GJh9fg
        5bQ4IdbEsuLK3EOMEhzMSiK8O/ynxwnxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2x
        JDU7NbUgtQgmy8TBKdXAKBzZkZhRnLQ06GyOyQa9e+8u/6/vD7bMeCy3pHuj/FRrQ5YHoSeL
        l/rvdH2/Q+jY3mN2UiHnky4LRG/brrPyxAL1GdtcZ85uif3Z4sf5vaF24VObGTdWSTwynjut
        xn7Pgg2TzZ5ukbHgPaiV/CJBhHOnyA5V+bxiD5szr7045jgZVG5czKG4U4mlOCPRUIu5qDgR
        AEU6DH2QAgAA
X-CMS-MailID: 20200415233545epcas1p4d9d0511a539f34404697590bf8cae933
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295
References: <CGME20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295@epcas1p4.samsung.com>
        <001201d60e12$8454abb0$8cfe0310$@samsung.com>
        <20200415164702.xf3t2stjpkjl6das@fiona>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hi,
Hi Goldwyn,

> 
> On 10:59 09/04, Namjae Jeon wrote:
> > The initial version(1.0.1) of exfat-utils is now available.
> > This is the official userspace utilities for exfat filesystem of
> > linux-kernel.
> 
> For the sake of sanity of the distributions which already carry exfat-
> utils based on fuse (https://protect2.fireeye.com/url?k=20c6da2a-7d5874b0-
> 20c75165-0cc47a336fae-
> 6943064efcd15854&q=1&u=https%3A%2F%2Fgithub.com%2Frelan%2Fexfat), would it
> be possible to either change the name of the project to say exfat-progs or
> increase the version number to beyond 1.4?
> 
> exfat-progs is more in line with xfsprogs, btrfsprogs or e2fsprogs :)
Oh, I see. I agree to rename to exfat-progs. I will work to release version
1.0.2 with that name.
Thank you for your opinion!
> 
> --
> Goldwyn

