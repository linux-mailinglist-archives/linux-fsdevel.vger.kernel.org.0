Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3283363CE5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 05:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiK3Ee1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 23:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiK3EeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:34:24 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A405FD1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 20:34:21 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221130043416epoutp02ec9586c07a1af5d26e4b9938a2daf51e~sQqlWs58F0288302883epoutp02h
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 04:34:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221130043416epoutp02ec9586c07a1af5d26e4b9938a2daf51e~sQqlWs58F0288302883epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669782856;
        bh=6dycdhzUsMa+NwKSFxTpqIW56UX7qOqZbM2o30JBaAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B2mkw7hmOgOKNi5qM3ajmon8+znUzQUbjCUqvObGIst1qWHBsfrerTU3ERk3IhelD
         PzARufRZkEkx2K5HW1haHIuG2i7V/dHlens8ImPHlHmVebIUFeaON1Rzmuimo4c5fR
         vCWQX05r+FUVACzEXSJJrkPQ20Kc5jcblkkgj9Kc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221130043416epcas5p1e5e92913164855ae029853bde2aa43bf~sQqks9l2A0431904319epcas5p1z;
        Wed, 30 Nov 2022 04:34:16 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NMRDk588bz4x9Pt; Wed, 30 Nov
        2022 04:34:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.F9.39477.64DD6836; Wed, 30 Nov 2022 13:34:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221130042624epcas5p169a43c3b0e5b05a7fa47d925e9a5e186~sQjtMrVtX0044000440epcas5p1v;
        Wed, 30 Nov 2022 04:26:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221130042624epsmtrp252aff7ff1f7dafdc419c2be4e1fa122a~sQjtLavM-1890818908epsmtrp2j;
        Wed, 30 Nov 2022 04:26:24 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-a5-6386dd46c561
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.50.18644.07BD6836; Wed, 30 Nov 2022 13:26:24 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221130042614epsmtip27f06f8882f26839742901009824ead68~sQjkL-WMh1919419194epsmtip25;
        Wed, 30 Nov 2022 04:26:14 +0000 (GMT)
Date:   Wed, 30 Nov 2022 09:44:50 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "naohiro.aota@wdc.com" <naohiro.aota@wdc.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v5 00/10] Implement copy offload support
Message-ID: <20221130041450.GA17533@test-zns>
MIME-Version: 1.0
In-Reply-To: <a7b0b049-7517-bc68-26ac-b896aaf5342e@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTHvfe2txc24PLSH6izK1umaCtlBX8wQBYNuT7HnNscicFabqAB
        2qaPOd0fIlLNMIgQJKMDh4N1iAwGZYxngTreYFUEBgawUoGNCkPYyGTIWloW//ucx/d3fuec
        HALzyGb5EmKJkpZLhEkc3JlRc2fHdm7U6CVRwEMLE1Z0t2Mw9doKBm+PZuJwrnWCCZf7jBhs
        mv2GCYdb6lB463YbChtuzqOwbfUZDk2LIwyYbRhEYNPITtjY1MWA/fX5OPxW+5QFszp0TFhr
        voDAhe/TWLB8Zo4B9ZoDsHNkMzSudDAjN1Ga8T6cqtOMsijjWCWD6u9TUVWlX+GUrvg81TCc
        glMZF2etCepxJjWnH8Cpq9WlCLVQ9QZ1ueUKSlWZn6HRrjGJYQm0MI6Ws2mJSBonlsSHcw59
        FLsvNig4gM/lh8A9HLZEmEyHc/YfjuZGiZOs7XPYnwuTVFZXtFCh4OyOCJNLVUqanSBVKMM5
        tCwuSSaQ8RTCZIVKEs+T0MpQfkBAYJA18VRiwsRQG1Nm8PyiQR2RgvS7pSNOBCAFoFfbz0hH
        nAkPsgEBd58amXbjOQJuVLay7MYCAqaMFsa6xFJrcWTVI6D113TMbkwioL931RohCAb5Nngw
        t92GOLkT9KwSNq0XyQMDI7+tPYqRYwS43vOAZQt4kmFAd/9n3MYuJBdUDHdidnYHXXlma2EW
        4URGgBeHbV5v0g+01HSgtmcAqXMCpsafHH/bDxb1k4idPcEfHdUsO/uChdkm3M5nwK2cEtwu
        TkOAZkjjEOwF6u7MtboYmQAu6s0O8VZwvbsctftdQcayGbX7XUDtjXX2A2UVhY4CPmBw6YKD
        KWApm3PMV4OCruksxjVkm+aV3jSv1LPzLlDY8BzXWGeHkZvBDy8JO+4AFfW7CxFmKeJDyxTJ
        8bQiSBYooc/8v2+RNLkKWTsO/4O1iOnxnzwDghKIAQEExvFymT+mFnm4xAnPnqPl0li5KolW
        GJAg66qyMF9vkdR6XRJlLF8QEiAIDg4WhLwbzOdscin62l/kQcYLlXQiTcto+boOJZx8U9BP
        0cxHZZXpqd4fyrbxPis2bcx79MGJ03divCLedFdlHPpyQ3jBkGVgqS5bv/JvgaEv9eiP0zUH
        DKNnQbbxraixqeWjliLtTde/LlWrx8LmWU8SLXRbb8nHMc0+ke5FT6R/637/JL+m6cWUkrt1
        cPK84bXidx7u1ea+bjo+sOXIQbEs0M1TfckzzXnGLX5XebOJY7bc71oU1NNFx+HJ0Ms9eat7
        NKx933UyQycitbINmrZzgr6JY+0bl7neS+Yctm5LV+Pw6Xs+Xr/wxSXkyEnscQF/lfXyPb/4
        f7QlOfrSqCOneqd5JfPNvlcUrkx2bv5Qrr5zNKP9hDN4v31m/N5drriew1AkCPn+mFwh/A+E
        mpVZpQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSvG7B7bZkg8mHOC3WnzrGbNE04S+z
        xeq7/WwW7w8+ZrX4ffY8s8Xed7NZLW4e2MlksXL1USaL3Qs/Mlkc/f+WzeLhl1ssFpMOXWO0
        2HtL22LP3pMsFpd3zWGzmL/sKbvFxOObWS12PGlktPi8tIXdYt3r9ywW+2Z5Wpy4JW1x/u9x
        Vgdxj1n3z7J57Jx1l93j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwevc3vgApa77N6vN93lc2j
        b8sqRo/Pm+Q82g90M3lsevKWKYAvissmJTUnsyy1SN8ugSvj/KxXzAVNghX39v9laWBcw9vF
        yMkhIWAi8WbHG9YuRi4OIYEdjBIXbn5mgkhISiz7e4QZwhaWWPnvOTtE0RNGia/nvjB2MXJw
        sAioSlx6rwFisgloS5z+zwFSLiKgJ3H11g2wcmaBFxwSiz49B5sjLGAjsfniVjYQm1dAV2L9
        zRNgcSGBWUwSy7t8IeKCEidnPmEBsZkFtCRu/HvJBDKfWUBaYvk/oPnsHJwCdhK/fEAKRAWU
        JQ5sO840gVFwFpLeWUh6ZyH0LmBkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERzt
        Wlo7GPes+qB3iJGJg/EQowQHs5II78eg1mQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYL
        CaQnlqRmp6YWpBbBZJk4OKUamJqefXm8YUKr1ZXjrZIc1vt/xL2e5LCVc8PBpEORC3bG8yku
        1KyXvDrrCvOskszXs38b/XM7fu36ik+m2T/0+mRTOBaG382btK/VNztaaLFc+98dN1YuyFNY
        /dvq5jT5qKXKlZcZpUL7e++pWZkv7v5XOVWJQc6ldMezxt6Wpc4iwZMfCFpuXHhwZ9iMl7Lz
        K+e4nT+4xsfCcnf1VPGv9WyCBqzLhQvz9od43Oz+ej5udT7bzvqJ/iWbTPz1E3z3bb8ylcOx
        9vnvvT6Pn0a472bMM7p3asXTN9dvdb1eYNBxN5f75vXrvbuLC4S4HDe23PNMuRZVvnJesH7Q
        216HuddPW9xsKtG3e9maqnxnvooSS3FGoqEWc1FxIgDjKZW2ZQMAAA==
X-CMS-MailID: 20221130042624epcas5p169a43c3b0e5b05a7fa47d925e9a5e186
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_80049_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5
References: <CGME20221123061010epcas5p21cef9d23e4362b01f2b19d1117e1cdf5@epcas5p2.samsung.com>
        <20221123055827.26996-1-nj.shetty@samsung.com>
        <cd772b6c-90ae-f2d1-b71c-5d43f10891bf@nvidia.com>
        <20221129121634.GB16802@test-zns>
        <a7b0b049-7517-bc68-26ac-b896aaf5342e@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_80049_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Nov 30, 2022 at 12:05:00AM +0000, Chaitanya Kulkarni wrote:
> On 11/29/22 04:16, Nitesh Shetty wrote:
> > On Wed, Nov 23, 2022 at 10:56:23PM +0000, Chaitanya Kulkarni wrote:
> >> (+ Shinichiro)
> >>
> >> On 11/22/22 21:58, Nitesh Shetty wrote:
> >>> The patch series covers the points discussed in November 2021 virtual
> >>> call [LSF/MM/BFP TOPIC] Storage: Copy Offload [0].
> >>> We have covered the initial agreed requirements in this patchset and
> >>> further additional features suggested by community.
> >>> Patchset borrows Mikulas's token based approach for 2 bdev
> >>> implementation.
> >>>
> >>> This is on top of our previous patchset v4[1].
> >>
> >> Now that series is converging, since patch-series touches
> >> drivers and key components in the block layer you need accompany
> >> the patch-series with the blktests to cover the corner cases in the
> >> drivers which supports this operations, as I mentioned this in the
> >> call last year....
> >>
> >> If you need any help with that feel free to send an email to linux-block
> >> and CC me or Shinichiro (added in CC )...
> >>
> >> -ck
> >>
> > 
> > Yes any help would be appreciated. I am not familiar with blktest
> > development/testing cycle. Do we need add blktests along with patch
> > series or do we need to add after patch series gets merged(to be merged)?
> > 
> > Thanks
> > Nitesh
> > 
> > 
> 
> we have many testcases you can refer to as an example.
> Your cover-letter mentions that you have tested this code, just move
> all the testcases to the blktests.
> 
> More importantly for a feature like this you should be providing
> outstanding testcases in your github tree when you post the
> series, it should cover critical parts of the block layer and
> drivers in question.
> 
> The objective here is to have blktests updated when the code
> is upstream so all the distros can test the code from
> upstream blktest repo. You can refer to what we have done it
> for NVMeOF in-band authentication (Thanks to Hannes and Sagi
> in linux-nvme email-archives.
> 
> -ck
>

Sure, next version will update blktest.

Thank you,
Nitesh

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_80049_
Content-Type: text/plain; charset="utf-8"


------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_80049_--
