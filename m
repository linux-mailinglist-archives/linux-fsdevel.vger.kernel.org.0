Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C466E265E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjDNPBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDNPBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:01:54 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332571710
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 08:01:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230414150150euoutp01f9c2ce4cd173db073347001cbd042426~V1UDFs4--0481704817euoutp01U
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 15:01:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230414150150euoutp01f9c2ce4cd173db073347001cbd042426~V1UDFs4--0481704817euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681484510;
        bh=k2KMSY3rEPC/l3wXRBxqdB3ENhOA3GWRhLXn6UokrYg=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Ncz0YzLo1qqj+ch4v7bUvJJXCgwLKsEPK9l45RyoZdy6Re9wKeeWsAPS7OUvNr9Tb
         hluSI+0SskDxTDzCmAZpz3CVupM3qtk4E5ZHB3E1ymr06yODepqJ5QyRugAKxXnBdr
         9NjW7NC41M1IBrwiAU1NtRlDHH0+AD7CaoecEfdY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230414150149eucas1p28c28debfd8970a58a0f7aad4911ed40e~V1UC3sMaI3175731757eucas1p2W;
        Fri, 14 Apr 2023 15:01:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 19.16.09966.DDA69346; Fri, 14
        Apr 2023 16:01:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230414150149eucas1p2530c12531599e6fd376a19f8a7d59740~V1UCcvLn-1376713767eucas1p21;
        Fri, 14 Apr 2023 15:01:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230414150149eusmtrp2ffa4c4747cf08e810cdb7586e9c84a38~V1UCcMMtp2102421024eusmtrp2t;
        Fri, 14 Apr 2023 15:01:49 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-3a-64396add5e29
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.E9.34412.DDA69346; Fri, 14
        Apr 2023 16:01:49 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230414150149eusmtip2609769cecb935de635342ecd39098ad9~V1UCPooxn2857528575eusmtip2U;
        Fri, 14 Apr 2023 15:01:49 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 14 Apr 2023 16:01:48 +0100
Message-ID: <505f1aac-8348-56c2-b925-6a905af9be24@samsung.com>
Date:   Fri, 14 Apr 2023 17:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [RFC 2/4] buffer: add alloc_folio_buffers() helper
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <brauner@kernel.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        <gost.dev@samsung.com>, <hare@suse.de>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZDlP2fevtfD5gMPd@casper.infradead.org>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7p3syxTDM691rWYs34Nm8Xrw58Y
        LfYsmsRksWfvSRaLy7vmsFncmPCU0eL83+OsFr9/zGFz4PDYvELLY9OqTjaPEzN+s3hsPl3t
        8XmTnMemJ2+ZAtiiuGxSUnMyy1KL9O0SuDK2zHvDWPCHrWJ+g1oD4yXWLkZODgkBE4nfc6Yy
        dzFycQgJrGCUOP3zFwuE84VRYv7Tm+wQzmdGif+t/UwwLWsfvGWCSCxnlJj36CMjXNWMVQ/A
        BgsJ7GSU+HcrF8TmFbCTWHmtkR3EZhFQlbj8so8RIi4ocXLmExYQW1QgWmLxvilgtrCAvUTH
        iY3MIDazgLjErSfzgbZxcIgIaEi82WIEsotZ4AqjxNM7R1hA4mwCWhKNnWDjOYGOa1v4G6pV
        XmL72znMEEcrSky6+R7q51qJU1tugT0gIdDNKfF5xkp2iISLxN8THxghbGGJV8e3QMVlJP7v
        nA/1fbXE0xu/mSGaWxgl+neuZwM5QkLAWqLvTA6IySygKbF+lz5E1FHixFoeCJNP4sZbQYjL
        +CQmbZvOPIFRdRZSOMxC8u8sJA/MQpi5gJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4m
        RmA6Ov3v+JcdjMtffdQ7xMjEwXiIUYKDWUmEt8rSMkWINyWxsiq1KD++qDQntfgQozQHi5I4
        r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDk87CGwpHS45v+SqmPTFTba704n8vX05Wrb0rknP/
        bUSd+pOoA8VnyqasKbWMWvrqjovIlGlairNcs3jF7GYsk7ax7/b9Kn9UuYytMcv12zs3kx6+
        lV0JDTqc67l/Tnp9boPi4XvCeit8YtYtvWtq3vJhhZKB/pbeORbb3Beu4pz53CBC9kqnzZ0L
        827a12kIKc3McGC2zPTcIhe6vmWH9zThP9uka3Ll9atFv24x2Xmv4xDH/VeFR0umZqpUNwh/
        7xBuW7c8e5Lu74dMR02Wdly8/dL8tjjDons9mc9r1O1lA+68O//Ms+KK+LasoErnA3tZvS/O
        us+mJxr7zULtrc6rPeWpRa2T57F0X519QYmlOCPRUIu5qDgRAOzELsa2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xe7p3syxTDM694reYs34Nm8Xrw58Y
        LfYsmsRksWfvSRaLy7vmsFncmPCU0eL83+OsFr9/zGFz4PDYvELLY9OqTjaPEzN+s3hsPl3t
        8XmTnMemJ2+ZAtii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DK2zHvDWPCHrWJ+g1oD4yXWLkZODgkBE4m1D94ydTFycQgJLGWU2P79O1RCRmLj
        l6tQtrDEn2tdbBBFHxklFq0EKQJxdjJKTL63nBGkilfATmLltUZ2EJtFQFXi8ss+qLigxMmZ
        T1hAbFGBaIkby78xgdjCAvYSHSc2MoPYzALiEreezAeKc3CICGhIvNliBDKfWeAKo8TTO0dY
        IJY9Z5S4+2wmG0gRm4CWRGMn2C5OoBfaFv6GmqMp0br9NzuELS+x/e0cZogPFCUm3XwP9U2t
        xOe/zxgnMIrOQnLeLCRnzEIyahaSUQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERvO2
        Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrxVlpYpQrwpiZVVqUX58UWlOanFhxhNgWE0kVlKNDkf
        mE7ySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYmOsTFhQdVZm6
        WPOmSqBVaNTP6EiTG2u+vrQKOvT5pPjlT73yer7+OnO+9OmuV835eGC90vmgHQsf/n9w4pDe
        3p7ZR0TZd0ucL5/ffXxe/ZYWBT5mwaJXtUuDnd5+vfbvw7ZE32Oc6o8udTnZt4tkSH25pxtS
        6j93EpPS1679t4yduRaeafXedydmkZjHfOdXyxZ/uOFnOu9i+oLMU/8Cd/iqvfxZbpQ7Yauf
        vkPi1GIJuwkLP+5lsG7LuTDp8e17gu29W00ZpTy/sylZebtsuG3otjTg3Ku3HzeaSj3VzJAJ
        qk5I+jxrglbGm8yI3cUtLJ03O+K3pei+KHYpihW+urTl9v9vHOJPy2btDli3VYmlOCPRUIu5
        qDgRACVJkUxvAwAA
X-CMS-MailID: 20230414150149eucas1p2530c12531599e6fd376a19f8a7d59740
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99
References: <20230414110821.21548-1-p.raghav@samsung.com>
        <CGME20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99@eucas1p2.samsung.com>
        <20230414110821.21548-3-p.raghav@samsung.com>
        <ZDlP2fevtfD5gMPd@casper.infradead.org>
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

On 2023-04-14 15:06, Matthew Wilcox wrote:
> On Fri, Apr 14, 2023 at 01:08:19PM +0200, Pankaj Raghav wrote:
>> Folio version of alloc_page_buffers() helper. This is required to convert
>> create_page_buffers() to create_folio_buffers() later in the series.
>>
>> It removes one call to compound_head() compared to alloc_page_buffers().
> 
> I would convert alloc_page_buffers() to folio_alloc_buffers() and
> add
> 
> static struct buffer_head *alloc_page_buffers(struct page *page,
> 		unsigned long size, bool retry)
> {
> 	return folio_alloc_buffers(page_folio(page), size, retry);
> }
> 
> in buffer_head.h
> 
> (there are only five callers, so this feels like a better tradeoff
> than creating a new function)
> 
That is a good idea and follows the usual pattern for folio conversion. I will
send a new version soon with your other comments as well.

--
Pankaj
