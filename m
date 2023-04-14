Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40FA6E265A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDNPAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjDNPAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:00:44 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD64E6E8F
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 08:00:41 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230414150039euoutp01d45a9f27e921a435932ddad5197f090d~V1TBPcj9D0862308623euoutp01O
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 15:00:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230414150039euoutp01d45a9f27e921a435932ddad5197f090d~V1TBPcj9D0862308623euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681484439;
        bh=ibChgCKjv6ZNfmfGmvDkXir9juzYcVtKHbDliZZElaE=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=b690qyFDFwdcZ4VpnIRFLL/sUbT6SKTU5rccJefapP1Sc1SdUqZVPKF8BapH2rn1P
         tMvqlriK162g7L5dsDz0/eHqz/THTrnO2cnb86Q3d9haatkjOYZdzlTHbdc6zsP2bv
         HWyS0Cl3/3wCVJGW6hSRBj+qk5YRqZE8+wh93ctA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230414150039eucas1p2a78fe0f14bab4af8b151f58376e57051~V1TBGk7b_0877108771eucas1p2m;
        Fri, 14 Apr 2023 15:00:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 35.24.10014.79A69346; Fri, 14
        Apr 2023 16:00:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230414150038eucas1p2149867beb4014958519034201f06b78e~V1TAwwbuA3074830748eucas1p2A;
        Fri, 14 Apr 2023 15:00:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230414150038eusmtrp18f1f982ab0452497f21645f8377db0c8~V1TAwKdSE1449714497eusmtrp1b;
        Fri, 14 Apr 2023 15:00:38 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-0d-64396a97478d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 49.D8.22108.69A69346; Fri, 14
        Apr 2023 16:00:38 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230414150038eusmtip13ca9996d02463ff786bf3a84ff4d3a95~V1TAlif7k0761007610eusmtip1h;
        Fri, 14 Apr 2023 15:00:38 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 14 Apr 2023 16:00:37 +0100
Message-ID: <58ba1aec-f42b-f896-617f-a3720c09b30f@samsung.com>
Date:   Fri, 14 Apr 2023 17:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, <brauner@kernel.org>,
        <willy@infradead.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mcgrof@kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87rTsyxTDOYe4rSYs34Nm8Xrw58Y
        LfYsmsRksWfvSRaLy7vmsFncmPCU0eL83+OsFr9/zGFz4PDYvELLY9OqTjaPEzN+s3hsPl3t
        8XmTnMemJ2+ZAtiiuGxSUnMyy1KL9O0SuDK2PjzMVvCev2Jzz0nGBsYVvF2MnBwSAiYSq+4v
        ZAGxhQRWMEqsna7YxcgFZH9hlLh3uJEJwvnMKPF99j02mI7+QxuYIRLLGSUezfnLCtEOVPXh
        vxZEYifQqKdPGEESvAJ2Eht7njOB2CwCqhJXp35lgogLSpyc+QRst6hAtMTifVOAbA4OYQEv
        iR+9SSBhZgFxiVtP5oNdISLQDXTS9c/MEIkiicXPljGB1LMJaEk0drKDhDkFrCUmPmxggyiR
        l2jeOpsZ4mhFiUk337NC2LUSp7bcApspIdDPKfFx/R2oz1wkvq3/yQhhC0u8Or6FHcKWkTg9
        uYcFwq6WeHrjNzNEcwujRP/O9WwgR0gAbe47kwNiMgtoSqzfpQ9R7ijRd3kfI0QFn8SNt4IQ
        p/FJTNo2nXkCo+ospICYheTjWUg+mIUwdAEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95Pzc
        TYzAhHT63/GvOxhXvPqod4iRiYPxEKMEB7OSCG+VpWWKEG9KYmVValF+fFFpTmrxIUZpDhYl
        cV5t25PJQgLpiSWp2ampBalFMFkmDk6pBqZNdfNLPtQlC2bMastJmfq6IcR8g2DJupp53k7f
        896lLHng/yZ115dGl+aHi2U4ee3PV04Sv1FR1nNRpzBpVrrZam2etk+bbuUu6t0s6zrRoEy8
        bV2typEnersdLK0/33OyM5bZtejO4b+7NrS5Kn8MFvLy/zh/av21fWHCJ+ZGZfGIthW5Ptl7
        aN7Weyp3ynhk2p+mhwU9L1LoVnU+IbFSxPPf7i3WpieWO/zd/7OXeUmw/NFd09OfrS59cmqX
        vZ/Y+ll2E9wnbOfpvLXhil+tpc7RDczpFgsVQiZ+jC5P7NpjpxOuZmpb/23r59VZQT/T2sJW
        WXybG5v2feGtwEe3/QV+mCdFSCkrWPzfkafEUpyRaKjFXFScCAAJJ+gXtwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7rTsixTDF7d07OYs34Nm8Xrw58Y
        LfYsmsRksWfvSRaLy7vmsFncmPCU0eL83+OsFr9/zGFz4PDYvELLY9OqTjaPEzN+s3hsPl3t
        8XmTnMemJ2+ZAtii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DK2PjzMVvCev2Jzz0nGBsYVvF2MnBwSAiYS/Yc2MHcxcnEICSxllPjzeQILREJG
        YuOXq6wQtrDEn2tdbBBFHxkl7r7+xgrh7GSUaDt5CqyKV8BOYmPPcyYQm0VAVeLq1K9MEHFB
        iZMzn4BNFRWIlrix/BtQnINDWMBL4kdvEkiYWUBc4taT+UwgM0UEOhklti47xgiRKJJY/GwZ
        E8SyfYwSfy8+YwVpZhPQkmjsZAep4RSwlpj4sIENol5TonX7b3YIW16ieetsZogPFCUm3XwP
        9U2txOe/zxgnMIrOQnLeLCR3zEIyahaSUQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIE
        xvO2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrxVlpYpQrwpiZVVqUX58UWlOanFhxhNgWE0kVlK
        NDkfmFDySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYXF6WdcUl
        y1+cIOk8q+nP5NNsbk7n12+yluH6+3YrQ4SR51KBaSVhK6bclvm/V+TZZVu/GQVVf3Yx9AZO
        W/3lROK3+3t9Uiw4VpZ9V+DtcOnmMpbi+tOU6yz9+p01e/zLS3+qU+rCTfTUK81KHv2de99W
        LFJ88nymiiNnLp6TYNmn8PxVnvPsnS/LTLkfXml5pm52y0aFmXH/W+bySMnnTNLTz9+dsfhP
        U+G9q9V7dpY03OPoOCPqpMcwpzmY4W/QNM+FC3eeurOJSeQK16PPW+SNm4UlbvxSMpqmVSvs
        IP9+mvTK36UL5u956d8nJGi/0fDvujc9zI8/7Yu6NGe36yfL4n+11fqe/C3nfwb8U2Ipzkg0
        1GIuKk4EAKw5vklwAwAA
X-CMS-MailID: 20230414150038eucas1p2149867beb4014958519034201f06b78e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
        <20230414110821.21548-1-p.raghav@samsung.com>
        <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Pankaj Raghav (4):
>>    fs/buffer: add set_bh_folio helper
>>    buffer: add alloc_folio_buffers() helper
>>    fs/buffer: add folio_create_empty_buffers helper
>>    fs/buffer: convert create_page_buffers to create_folio_buffers
>>
>>   fs/buffer.c                 | 131 +++++++++++++++++++++++++++++++++---
>>   include/linux/buffer_head.h |   4 ++
>>   2 files changed, 125 insertions(+), 10 deletions(-)
>>
> Funnily enough, I've been tinkering along the same lines, and ended up with pretty similar patches.
> I've had to use two additional patches to get my modified 'brd' driver off the ground with logical
> blocksize of 16k:

Good to know that we are working on a similar direction here.

> - mm/filemap: allocate folios according to the blocksize
>   (will be sending the patch separately)
> - Modify read_folio() to use the correct order:
> 
> @@ -2333,13 +2395,15 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>         if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
>                 limit = inode->i_sb->s_maxbytes;
> 
> -       VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -
>         head = create_folio_buffers(folio, inode, 0);
>         blocksize = head->b_size;
>         bbits = block_size_bits(blocksize);
> 
> -       iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
> +       if (WARN_ON(PAGE_SHIFT < bbits)) {
> +               iblock = (sector_t)folio->index >> (bbits - PAGE_SHIFT);
> +       } else {
> +               iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
> +       }
>         lblock = (limit+blocksize-1) >> bbits;
>         bh = head;
>         nr = 0;
> 
> 
> With that (and my modified brd driver) I've been able to set the logical blocksize to 16k for brd
> and have it happily loaded.

I will give your patches a try as well.
