Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A207A7BF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjITL5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 07:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbjITL5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:57:02 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E867135
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 04:56:47 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230920115645euoutp01d88456cf088cef99a77641d0cae36849~GmW2aLpYC0417004170euoutp01D
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 11:56:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230920115645euoutp01d88456cf088cef99a77641d0cae36849~GmW2aLpYC0417004170euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695211005;
        bh=exkjwGsq72t9D7qBBVBdLdBtc3DWn+e/IuVjp8SVRTY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=k+aGKczDoUGYQrIng6uRRULHbEnlHCJoFBH3ENOqFt43jfNrrzbPzo49kd0u3bowb
         mgRcusDiOugo3x6rM3N/uJeOfhcZT4OT/6pLGWzTZyDVi+TJtEqSMJuJjMUyu5Y/DD
         BfElClcntHqQCFVs25ju3ZquhahTKGZma9yowN/I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230920115645eucas1p2652c4c73be77db7782b15029a28d6689~GmW2JxQC81604116041eucas1p2w;
        Wed, 20 Sep 2023 11:56:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D3.3F.11320.DFDDA056; Wed, 20
        Sep 2023 12:56:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b~GmW13pa5n1137911379eucas1p1_;
        Wed, 20 Sep 2023 11:56:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920115645eusmtrp284ab616da2b95d7fb930c4444320c9a2~GmW13Im7-2674426744eusmtrp2J;
        Wed, 20 Sep 2023 11:56:45 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-85-650addfddede
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 23.EA.14344.DFDDA056; Wed, 20
        Sep 2023 12:56:45 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920115644eusmtip1c7dcff6386bd2e7497b1f43afc36dfc2~GmW1qyTvW2945029450eusmtip1T;
        Wed, 20 Sep 2023 11:56:44 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 20 Sep 2023 12:56:44 +0100
Date:   Wed, 20 Sep 2023 13:56:43 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <p.raghav@samsung.com>
Subject: Re: [PATCH 01/18] mm/readahead: rework loop in
 page_cache_ra_unbounded()
Message-ID: <20230920115643.ohzza3x3cpgbo54s@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918110510.66470-2-hare@suse.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7p/73KlGjz4LWmx+m4/m8WeRZOY
        LFauPspksfeWtsWevSdZLG5MeMpo8fvHHDYHdo/NK7Q8Lp8t9di0qpPNY/fNBjaPzaerPT5v
        kgtgi+KySUnNySxLLdK3S+DKWPjpEWvBadaKz1tvszcwrmPpYuTkkBAwkVjd9Iy1i5GLQ0hg
        BaPEpXlXmSCcL4wSfzffY4NwPjNKHGzrYYNp2bTyHSNEYjmjxOHd25hBEmBVf79LQiS2MErc
        fryIESTBIqAqcfXcFiCbg4NNQEuisZMdJCwioCTxsf0QO0g9s8ArRokF/3ezgNQICwRLbFhl
        A1LDK2Au8ej5FDYIW1Di5MwnYHczC+hILNj9iQ2knFlAWmL5Pw6QMKeAkcSUm61QrylJNGw+
        A2XXSpzacgvsMwmBFxwSU29uZ4ZIuEhsaJzLBGELS7w6voUdwpaR+L9zPlS8WuLpjd/MEM0t
        jBL9O9eDLZYQsJboO5MDYTpKPNgfC2HySdx4KwhxJZ/EpG3TmSHCvBIdbUIQA9UkVt97wzKB
        UXkWkr9mIflrFsJfCxiZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQmmtP/jn/Zwbj8
        1Ue9Q4xMHIyHGCU4mJVEeHPVuFKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnN
        Tk0tSC2CyTJxcEo1MNl9mu31c8XU08tk+jL692l0XM7UsbKubl5gIDMl15RlWlrs5UlLkmWT
        BI3+35fzM77xa6mNiOCUnUueMpcrKh8Q0Da1vzvty0vugG0v+M6d/65akcaf3zR/xp80df6f
        MS09x2xNra7POCh1XWfyd6ZvvKdPzbDjFeTJtX29+6e2+u3GsoT+zZLtVXMeem87/K4zM+5F
        hab6U+fpsWcm9ObkyB0+73l920vxb+obW45PnVayxsT33r/NPX8Ypl/tyWE22nEj6dLpF8o5
        HuxbZKZ9/8Ty5MzN4/Yaiz6lbZr6fh77+tS/kmliBmE7tkvbaf2daOz/yutz+SvFE/c42Bgd
        SwyblBJLDf3s303fuFuJpTgj0VCLuag4EQCk5N/ZowMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7p/73KlGkxezGGx+m4/m8WeRZOY
        LFauPspksfeWtsWevSdZLG5MeMpo8fvHHDYHdo/NK7Q8Lp8t9di0qpPNY/fNBjaPzaerPT5v
        kgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL
        WPjpEWvBadaKz1tvszcwrmPpYuTkkBAwkdi08h0jiC0ksJRR4sltc4i4jMTGL1dZIWxhiT/X
        uti6GLmAaj4ySqztusoC4WxhlFje28sOUsUioCpx9dwWoEkcHGwCWhKNnWBhEQEliY/th9hB
        6pkFXjFKLPi/mwWkRlggWGLDKhuQGl4Bc4lHz6ewQRwRKXFwzU42iLigxMmZT8AOZRbQkViw
        +xMbSCuzgLTE8n8cIGFOASOJKTdboX5RkmjYfAbKrpX4/PcZ4wRG4VlIJs1CMmkWwqQFjMyr
        GEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiNu27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHeXDWu
        VCHelMTKqtSi/Pii0pzU4kOMpsCAmMgsJZqcD4z5vJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQh
        gfTEktTs1NSC1CKYPiYOTqkGJqYM2QmW9zQmXrp1/om7y13tNzKVWyy7Jq4P8VLefuPqqWdP
        Hrw8YXTLy/3Cj5s9uvGbVxXutRYxF16zRfrtLWXO0611N/8YuW13Kl+ROiE/0m/2ynUn658u
        TFr/PnCz3vmrLjK2NuqhOaeUpkzTlXienx3Fdb2lMfuI0JmKeVMmWGkZWxwQ2KQqt+3U9fhH
        UR1ON47M/7YuIq2s6dbuwvNlM3qaWtYXvJycVZSx+sGjFIsHjB19teeW6bKteDpRo3z+n2NM
        C4okNFJe3+E2jrJ/HK7Ty7GqNqZK3VVIs1X11P3emqezV/y9snDnr1XBEx73+8asyZOu2ajK
        3Gdx24Rx3ycjmS/V9Vl6sRe5DyuxFGckGmoxFxUnAgDee5p8QQMAAA==
X-CMS-MailID: 20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b
X-Msg-Generator: CA
X-RootMTR: 20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b
References: <20230918110510.66470-1-hare@suse.de>
        <20230918110510.66470-2-hare@suse.de>
        <CGME20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:04:53PM +0200, Hannes Reinecke wrote:
>  		if (folio && !xa_is_value(folio)) {
> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			 * not worth getting one just for that.
>  			 */
>  			read_pages(ractl);
> -			ractl->_index++;
> -			i = ractl->_index + ractl->_nr_pages - index - 1;
> +			ractl->_index += folio_nr_pages(folio);
> +			i = ractl->_index + ractl->_nr_pages - index;
I am not entirely sure if this is correct.

The above if condition only verifies if a folio is in the page cache but
doesn't tell if it is uptodate. But we are advancing the ractl->index
past this folio irrespective of that.

Am I missing something?
