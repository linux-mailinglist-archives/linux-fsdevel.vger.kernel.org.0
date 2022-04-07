Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6214F71CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 03:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiDGCAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 22:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDGCAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:00:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835226623E
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 18:58:13 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220407015811epoutp01137758bfd04a214347c9217d51f39e15~jepo307SE2954329543epoutp01e
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 01:58:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220407015811epoutp01137758bfd04a214347c9217d51f39e15~jepo307SE2954329543epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649296691;
        bh=HATTJavYX0NaR1Ru6uSU0WfORlW5BDFsbjrG7uyQkOo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NI0SUe/wBCeW/Wfb8QMwfIl94kGmNU4v87bLBkts9fw3DZh8gsW3nbTJxGmZIjPTz
         3iWGdn38EmHH0YC68xqiHc3GIhe86GaS5a5Xh5GuyBjxNw5ogN2VSAOTCC2M7E+3Js
         SHv8hp6YSjvVaAfd6ZEuLEgjeeo4E1NOjCR2Bw+A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220407015811epcas1p4a8108b8c9a7cb8d03fadc9276e785f49~jepor_pj53027330273epcas1p4k;
        Thu,  7 Apr 2022 01:58:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.222]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KYl012vqkz4x9Q2; Thu,  7 Apr
        2022 01:58:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.86.21932.1354E426; Thu,  7 Apr 2022 10:58:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220407015809epcas1p24ec163ab4cb0533c2145a4e546e96dea~jepmuPQr02195521955epcas1p2q;
        Thu,  7 Apr 2022 01:58:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220407015809epsmtrp1b83b12d3585db4f50abbdd52ecb6d75f~jepmtPkqE3173431734epsmtrp1W;
        Thu,  7 Apr 2022 01:58:08 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-5d-624e4531ac97
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.36.03370.0354E426; Thu,  7 Apr 2022 10:58:08 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220407015808epsmtip1b9a53c7dfe9f0aef7302dac6270cb392~jepmkrL371345013450epsmtip1-;
        Thu,  7 Apr 2022 01:58:08 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <axboe@kernel.dk>, "'Christoph  Hellwig'" <hch@infradead.org>
In-Reply-To: <HK2PR04MB38916A5D693D52FF1C2FD24781E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 0/2] exfat: reduce block requests when zeroing a
 cluster
Date:   Thu, 7 Apr 2022 10:58:08 +0900
Message-ID: <190101d84a22$ede7e210$c9b7a630$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHKvq7lmZVFrYJbCLZOIHnfj8b5SAFc+dS+rPPgFGA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTV9fQ1S/J4NIDUYvVd/vZLE5PWMRk
        MXHaUmaLPXtPslhc3jWHzYHVY/MKLY/LZ0s9Nq3qZPP4vEkugCUq2yYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKuSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITuj+/ws1oLLLBVTZ61hbmA8
        y9zFyMEhIWAicf+xVxcjF4eQwA5GifNXnrBBOJ8YJX5t/scC4XxmlPj7ZwFrFyMnWMeKbR1M
        EIldjBKv9u+EqnrJKNHUfJQNpIpNQFfiyY2fYDtEBLQl7r9IB6lhFmhmlFj5fSYTSA2nQKzE
        7yPTwKYKCwRKzHuziwXEZhFQkTjzG+Q+Tg5eAUuJo9uPs0HYghInZz4Bq2EWkJfY/nYOM8RF
        ChK7Px0FmyMiYCXx/yPEfGYBEYnZnW3MIIslBP6yS/Q8mQL1govExP4/UM3CEq+Ob2GHsKUk
        Xva3QdlAlzY3GkHYHYwSTzfKQgLMXuL9JQsQk1lAU2L9Ln2ICkWJnb/nMkKs5ZN497WHFaKa
        V6KjTQiiREXi+4edLDCLrvy4yjSBUWkWksdmIXlsFpIHZiEsW8DIsopRLLWgODc9tdiwwAQe
        18n5uZsYwelRy2IH49y3H/QOMTJxMB5ilOBgVhLhrcr1SRLiTUmsrEotyo8vKs1JLT7EaAoM
        6onMUqLJ+cAEnVcSb2hiaWBiZmRiYWxpbKYkzts79XSikEB6YklqdmpqQWoRTB8TB6dUA1PJ
        +b0uZswc54+X/rs9+c1VFRM5Y7sF6Uo9fwUnzdH2XGm/b2Ekk7DviyvO21c3debn3Jr7UKZv
        asBsta0x6+fPfy2fvGvSPwa2yba97ptzNL7p7YsSfcq/ocn/GOO2U0mHlnQldP31PbzKcGvA
        ym5dSw5/rgvWWRwLzM2cGHV2qXo/P9LQ/Pj3X4Pb61oi+iYvrIkwElxWFOC2nCHHNabK+szj
        8Pjw0j73U+ejzur2ryi3O2j55T+3jrLejN43W65/tJicU6cusTPYvZXX6FqQy9ynqYFcwW4M
        K/kYzmzZ5LGS7ybHToVbIlqxn74yyjXd7Xi3OGfR6z4536xlbO++pz9I8fXMYd0j/orbSoml
        OCPRUIu5qDgRANrjV44YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnK6Bq1+SQftqS4vVd/vZLE5PWMRk
        MXHaUmaLPXtPslhc3jWHzYHVY/MKLY/LZ0s9Nq3qZPP4vEkugCWKyyYlNSezLLVI3y6BK6P7
        /CzWgsssFVNnrWFuYDzL3MXIySEhYCKxYlsHUxcjF4eQwA5Gid2nH7B1MXIAJaQkDu7ThDCF
        JQ4fLoYoec4o8eJvAztIL5uArsSTGz+ZQWpEBLQl7r9IB6lhFmhnlNgy6TcrRMM6RolP056D
        NXAKxEr8PjKNFcQWFvCXuHvsDCOIzSKgInHmN8RBvAKWEke3H2eDsAUlTs58wgJiMwMt6H3Y
        yghhy0tsfzsH6gEFid2fjoLNFBGwkvj/cSYTRI2IxOzONuYJjMKzkIyahWTULCSjZiFpWcDI
        sopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhWtLR2MO5Z9UHvECMTB+MhRgkOZiUR
        3qpcnyQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamC7U
        tlnt+HHvBP+OjPwNKopcTdMddns8T7rYZXqrfd+BU+9sVJXSPXL1fXZtVT5RojJBZ2KzjE1K
        yokqPsOnh+bmmii4LxLdxXooJONg15KXx+clxHQ5LK30//zPS1K/+FfJ9NlPdc5vCvHam9V5
        SHLy7tzLrWXnrHhPZRTYXapazDTF36Prdg7r3ZiJHMFLGaXv8C9nZ70SkyRskN/HsKD9g2qp
        d+ZOd11NsYOyXt+ab874v5K3sWTGX+V9USK3ZdqZFqzrXrH9dFHb0VuXptas/3xd4L3lF/7H
        ujqKuTd/ljXwf2z0fDrj/k9nlXn184Ov65ZFJdyTmKyZFu10mXtNe+rU6LaSa93xTbe5lViK
        MxINtZiLihMBEMsoEQQDAAA=
X-CMS-MailID: 20220407015809epcas1p24ec163ab4cb0533c2145a4e546e96dea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220402032958epcas1p30a336a9b4f54e6972bdc196217ac1133
References: <CGME20220402032958epcas1p30a336a9b4f54e6972bdc196217ac1133@epcas1p3.samsung.com>
        <HK2PR04MB38916A5D693D52FF1C2FD24781E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Changes since v1:
> - Added helper to block level instead of manual accessing bd_inode
>   from the filesystem as suggested by Christoph Hellwig
> 
> Yuezhang Mo (2):
>   block: add sync_blockdev_range()
>   exfat: reduce block requests when zeroing a cluster
> 
>  block/bdev.c           | 10 ++++++++++
>  fs/exfat/fatent.c      | 41 +++++++++++++++++------------------------
>  include/linux/blkdev.h |  6 ++++++
>  3 files changed, 33 insertions(+), 24 deletions(-)
> 

Looks good, thanks for your patch!
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> --
> 2.25.1

