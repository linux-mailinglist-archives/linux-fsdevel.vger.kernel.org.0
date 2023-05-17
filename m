Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560BF706B83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjEQOrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjEQOrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 10:47:11 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3EF4215
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 07:47:05 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230517144703euoutp02471a1f7fdbd753bc4e7bdc91ff1cba58~f9ZkyjiZ40177001770euoutp02f
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 14:47:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230517144703euoutp02471a1f7fdbd753bc4e7bdc91ff1cba58~f9ZkyjiZ40177001770euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684334824;
        bh=7c2YUVjEhEkACJ2qGx3ePwIsHucOGV8Y0+ZlGBhfQjI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=UGW49f+k6/URPMgh2WYJFMk/1EELGp2HK/nHpSBerCUtn3AzFMYjZkxen1qsdpzZu
         w7twg9e2TgHgIWG67Q+XFvxNk9lmKhUg7mhz7gPQzw7Y22YxSzwFClli9h0noqpzup
         gwPFEck03a86khMzsI9ejYI6ZURPFR+gdoyQ/ZCg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230517144703eucas1p1e4a4d7e9dc9074edc22be143cfd54feb~f9ZkSpbRz2461924619eucas1p1U;
        Wed, 17 May 2023 14:47:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 31.7A.37758.7E8E4646; Wed, 17
        May 2023 15:47:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230517144703eucas1p1550db888e29fc5b182c202f24adddb87~f9Zj_bNwa1358013580eucas1p1s;
        Wed, 17 May 2023 14:47:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230517144703eusmtrp17735afbad4559fd15283d75c43d5187b~f9Zj9psz62220322203eusmtrp1h;
        Wed, 17 May 2023 14:47:03 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-de-6464e8e7a478
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.1F.10549.6E8E4646; Wed, 17
        May 2023 15:47:03 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230517144702eusmtip2ae8bcb65480eb718cbafe9f04badd0e1~f9ZjwNMM01658016580eusmtip2Y;
        Wed, 17 May 2023 14:47:02 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 17 May 2023 15:47:02 +0100
Date:   Wed, 17 May 2023 16:47:01 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        <cluster-devel@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>, <p.raghav@samsung.com>
Subject: Re: [PATCH 4/6] buffer: Convert __block_write_full_page() to
 __block_write_full_folio()
Message-ID: <20230517144701.4dnd5pzvzudccc56@localhost>
MIME-Version: 1.0
In-Reply-To: <20230517032442.1135379-5-willy@infradead.org>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87rPX6SkGJxaIWaxbd1udos569ew
        WZxc/ZjNYsGbvWwWe/aeZLG4MeEpo0XX7FY2i98/5rA5cHhsXqHlsWlVJ5vHiRm/WTze77vK
        5rF+y1UWj8+b5ALYorhsUlJzMstSi/TtErgyLvxcwlywiK1iydQtbA2Ma1m7GDk5JARMJBZO
        3MzexcjFISSwglHiwLRlbBDOF0aJ9hknoZzPjBJnGj6zw7Rs6rwO1bKcUeLq1u8IVQ9fdTJB
        OFsYJfa0vGUBaWERUJX4ceMu0EYODjYBLYnGTrBJIgLGEhOX72cDsZkFFjBJbJxRD2ILCyRJ
        HPmyF6yVV8BcouHIZ0YIW1Di5MwnYHFOAWuJxdNes0BcpCTRsPkMlF0rsbf5ANh1EgIfOCQ2
        r3vGDLJXQsBF4n5zMkSNsMSr41ugvpGROD25B6q3WuLpjd/MEL0tjBL9O9ezQfRaS/SdyYG4
        M1Ni2/IdzBD1jhKP3syDGs8nceOtIEQJn8SkbdOhwrwSHW1CENVqEqvvvWGBCMtInPvEN4FR
        aRaSv2YhmQ9h60gs2P2JbRZQB7OAtMTyfxwQpqbE+l36CxhZVzGKp5YW56anFhvnpZbrFSfm
        Fpfmpesl5+duYgQmqtP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeAP7klOEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MK1lmxc3R9Q9+XuP/obvdxOEDpXx
        mH/oXVcXsmpK1X3Zrikd17WmXWItOrRWKOmb3JyHx99sWSjlu2nPpvWXEqYa+Ck48/cvWLbu
        ob2Ayo1uhodiGzZ8lzeykn0z/cg3Hr2rLmpdXaL5T+Z//Fn8d2bXKbN9F9pu93gqxavm6f3a
        dtdu18oSexbHZvZU1rSvN0qWF56K3zvv9Pb9m0WnJjyJ0P69OnVm+8QFApUT2LbMYV6ZvKv2
        4/TtX8uVpHTeWD+bWmRTLrNInKd2+4WLCRPuO01uXt+SEq024+D6mlVfLc8mZrpPnKi1fMOP
        p3w7Nmt3ftfb47fn5T3WXrWqnTN82z5b7Yg8vPWRcvqJDJNkJZbijERDLeai4kQAZcYTJMMD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7rPX6SkGPxOsti2bje7xZz1a9gs
        Tq5+zGax4M1eNos9e0+yWNyY8JTRomt2K5vF7x9z2Bw4PDav0PLYtKqTzePEjN8sHu/3XWXz
        WL/lKovH501yAWxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZ
        ZalF+nYJehkNp16wFdxnrtjz7iprA2MzcxcjJ4eEgInEps7r7F2MXBxCAksZJfbveQeVkJHY
        +OUqK4QtLPHnWhcbRNFHRokne+exQDhbGCVenHvGBlLFIqAq8ePGXaAODg42AS2Jxk52kLCI
        gLHExOX7wZqZBRYwSXy9u5cRJCEskCRx5MteFhCbV8BcouHIZ7C4kEC2xM9ny5gh4oISJ2c+
        AathFtCRWLD7ExvIfGYBaYnl/zhAwpwC1hKLp71mgThUSaJh8xkou1ai89VptgmMwrOQTJqF
        ZNIshEkLGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbgtmM/N+9gnPfqo94hRiYOxkOM
        EhzMSiK8gX3JKUK8KYmVValF+fFFpTmpxYcYTYEhMZFZSjQ5H5gE8kriDc0MTA1NzCwNTC3N
        jJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamBZfviK43YJBVXPD/Ltnp7YGBEQePhR1iy29
        kpft5qQMY215m33lHMKO0tGXlOpW1yi9KXp/qn9mucrmq2zh5StOFaVXFESsamLftXFpdNgl
        kyBd73+xdeWrVSw2rfeTe+vRsEy56D3vtQhpPn6z8rCkI9rOXEuLv0Q8r91d0NydUDez98SO
        T55Vvnrhlfda2G8wbPspqPCDhWnG55SABIv7HCLtbktWeSZIsH3pdKo819L2Ys7Cjo8y1/t1
        3bhfZByc9HDa+clWTUs8dfjtMqdtPsV/g/tc1CrB4l9dL5Kumiw9IJJ76szbssthPnwdBqHc
        2Y2XMtKc7ZaH3A5l1wlt+GJw7xhf6qLQqWlKLMUZiYZazEXFiQC0cgohSgMAAA==
X-CMS-MailID: 20230517144703eucas1p1550db888e29fc5b182c202f24adddb87
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1c0ccd_"
X-RootMTR: 20230517144703eucas1p1550db888e29fc5b182c202f24adddb87
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230517144703eucas1p1550db888e29fc5b182c202f24adddb87
References: <20230517032442.1135379-1-willy@infradead.org>
        <20230517032442.1135379-5-willy@infradead.org>
        <CGME20230517144703eucas1p1550db888e29fc5b182c202f24adddb87@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1c0ccd_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> @@ -1793,7 +1793,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>  	blocksize = bh->b_size;
>  	bbits = block_size_bits(blocksize);
>  
> -	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
> +	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);

Shouldn't the PAGE_SHIFT be folio_shift(folio) as you allow larger
folios to be passed to this function in the later patches?

>  	last_block = (i_size_read(inode) - 1) >> bbits;
>  

------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1c0ccd_
Content-Type: text/plain; charset="utf-8"


------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1c0ccd_--
