Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F96D97443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 09:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfHUH5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 03:57:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63894 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUH5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:57:49 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190821075746epoutp01d79a412df330000fad31ee01018b4c0c~84Riw3gRa2309323093epoutp01u
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 07:57:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190821075746epoutp01d79a412df330000fad31ee01018b4c0c~84Riw3gRa2309323093epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566374266;
        bh=ozhdgcpKWdJ9STHx0/l4UukvGXSFa8gUQOw9uROJorw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Te7AorPt/qgkuEhu7rtZoJJ/4J2N3dZgeKLWGsbDPOWoh6Pd9U47Q+WaQqJ7H44k4
         Z51RruAKWu+b+jize4UCFr2NATWriMVJhGDms/0EnUmnOnpOW8JELIj4/XTJYrj/66
         lIJT/Lu2kn95Mo304e74T9fzUwCtTtD4EGZh+/iM=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190821075745epcas2p23a902d93d70a249b07900f5ff2742fad~84RhyryS60392603926epcas2p2K;
        Wed, 21 Aug 2019 07:57:45 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.183]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46D0Pz1WwGzMqYkj; Wed, 21 Aug
        2019 07:57:43 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.76.04156.779FC5D5; Wed, 21 Aug 2019 16:57:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20190821075742epcas2p4b9104e8249067c048d4050f2888da0a9~84RfNOmwq0945209452epcas2p4w;
        Wed, 21 Aug 2019 07:57:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821075742epsmtrp1c0bda618eef3e376a7e2738bb69573b3~84RfMAFUf3112831128epsmtrp1X;
        Wed, 21 Aug 2019 07:57:42 +0000 (GMT)
X-AuditID: b6c32a45-ddfff7000000103c-b1-5d5cf977fb70
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.C9.03706.679FC5D5; Wed, 21 Aug 2019 16:57:42 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821075742epsmtip1a675fb73939b515803f3ca44f0e6b4ec~84Re0K2Zg1561515615epsmtip1q;
        Wed, 21 Aug 2019 07:57:42 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Herbert Xu'" <herbert@gondor.apana.org.au>
Cc:     "'Herbert Xu'" <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Biggers'" <ebiggers@kernel.org>,
        "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        "'Chao Yu'" <chao@kernel.org>,
        "'Jaegeuk Kim'" <jaegeuk@kernel.org>,
        "'Andreas Dilger'" <adilger.kernel@dilger.ca>,
        "'Theodore Ts'o'" <tytso@mit.edu>, <dm-devel@redhat.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>,
        "'Alasdair Kergon'" <agk@redhat.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 6/9] dm crypt: support diskcipher
Date:   Wed, 21 Aug 2019 16:57:41 +0900
Message-ID: <001b01d557f6$1c49fd40$54ddf7c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AdVX9gnaDYeXFhMoSci3o9XSTfBUaA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xbZRTN1/f6XrdR89Yx/WyM1KfEbQzWVls+DBgjqE+3GJLNzBCa7oW+
        ALG/7GvHpsnGcHZlNC0zMULXTdItJnYio7CV8WObhUpAkLgK2XBjU/BHQZ0Cw3VuatsHkf/O
        PfeenHtycyWYzEfKJdVmO2czs0aaWIuf79+sya1JlOuUM0MkurPowlHb8JcYOnPDS6CvPhwV
        If/YYRz1/X5cjFp772OoYfYxNNPmw9DVe04x8k7PYWhs7CyJQtMTYtQ3mYNuTiVEqPnkdQJd
        CbyCZk8u4ai3bwhHsW4/gQb+9QLUNHZRhJztdwB6350g0WDr7hceZTo/vSZiDnfUMOcvZzOx
        UQcTCtYTzPWJXoLpOH2Q6WlZEDF1I1GMuX1xnGA8nUHALIQeL80oMxZWcayBsyk4c4XFUG2u
        LKK379QX6zVapSpXVYDyaYWZNXFFdMmO0tyXq43J7LRiL2t0JKlSlufpbc8X2iwOO6eosvD2
        IpqzGoxWlcqax7Mm3mGuzKuwmJ5TKZVqTXJyj7Hqwt2Y2Poetq83OkHUgm7RUbBGAqlnYbT/
        Y3AUrJXIqC4Aw8fuY0IxD6A37MaFYgnAc79cEq9I5hbqyBSWUX0ANn5hFobiAC56mtJDBJUD
        OwaDIIUzKSUMh/5Oe2DUPyScmY/gqcYGSgOnBhqIFMapbBhzB9ICKVUA464psYDXw6HmmfQ8
        RmXB8G9+TNhCAbtG54DAZ8Lj9U5MMMuDN0ai4pQZpB6QcLz/DCkISuCfk4PL4g1wdrBzmZfD
        uNe5jA/C8U9OkYLYDeDIvZXGM9D305GkmyTpthm2dW9LQUg9CQcml3d7CLr6H5ACLYUup0wQ
        PgVPzMdEAi2Hf7gPCDQDb9cdwhrBE75VIX2rQvpWBfP9b9sC8CB4mLPypkqOV1tVq48dAum/
        2PJSF2j6ekcEUBJAZ0gT5eU6mZjdy+83RQCUYHSmdJ+/TCeTGtj973A2i97mMHJ8BGiSNziG
        yTdWWJJfZrbrVRq1Vqss0CCNVo3oR6Qd666Vy6hK1s69xXFWzraiE0nWyGvBgWm1pdblS/x6
        pLh+djLn9e28/9tg/uUr45tCb7TtvHrztVvZLecWnlZEPvjhm4jB4zldF4993p6/6cfG1u+z
        9BeK49/1GP+6FQgfyuqpKbm7GKh5sf1EA7ZbO/x22XDhq5cUgXd/tnwm+ehNT6dcEV03iumW
        dMpdwz1bMzaKGl1S2EzjfBWr2oLZePY/dew/Ay0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCSnG7Zz5hYg1edmhZfv3SwWKw/dYzZ
        YvXdfjaL01PPMlnMOd/CYrH33WxWi7V7/jBbdL+SsXiyfhazxY1fbawW/Y9fM1ucP7+B3WLT
        42usFntvaVvcv/eTyWLmvDtsFpcWuVu8mveNxWLP3pMsFpd3zWGzOPK/n9Fixvl9TBZtG78y
        WrT2/GS3OL423EHSY8vKm0weLZvLPbYdUPW4fLbUY9OqTjaPO9f2sHlsXlLvsXvBZyaPpjNH
        mT3e77vK5tG3ZRWjx+dNcgE8UVw2Kak5mWWpRfp2CVwZO39cZi1oZq7Yc/QaWwPjLqYuRk4O
        CQETidefm9i7GLk4hAR2M0qsvbyLBSIhJbG1fQ8zhC0scb/lCCtE0XNGifPrD4F1swloS2w+
        vooRxBYRMJDYvuk3mM0sMI1DYtcHcRBbWMBU4t6RbjYQm0VAVeJyzyKwGl4BS4mXHfdYIWxB
        iZMznwAt5gDq1ZNo2wg1Rl5i+9s5UDcoSOw4+xoqLiIxu7ONGWKtnsTdM0dZJzAKzkIyaRbC
        pFlIJs1C0r2AkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwEtDS3MF4eUn8IUYB
        DkYlHt4dN6NjhVgTy4orcw8xSnAwK4nwVsyJihXiTUmsrEotyo8vKs1JLT7EKM3BoiTO+zTv
        WKSQQHpiSWp2ampBahFMlomDU6qBsbrk4svrTNERm2+ttP3R+VVg/8oXjwW/e6o+W62+5Nun
        Cp2guesvXr+QdiuAM+zKUw69JmlLjbWFzOIbHOOf9SrkP1i2xm/F6o1PfgkfqvCbv0Cs+Mjd
        5/Pnznw488rq9maZA3925rPqSzDMem3n4Phz0pOmPZqLD23W1/JRnvpqjv8aTvbrrDOVWIoz
        Eg21mIuKEwH4Sucq/gIAAA==
X-CMS-MailID: 20190821075742epcas2p4b9104e8249067c048d4050f2888da0a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821075742epcas2p4b9104e8249067c048d4050f2888da0a9
References: <CGME20190821075742epcas2p4b9104e8249067c048d4050f2888da0a9@epcas2p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:35:36AM +0200, Herbert Xu Herbert wrote:

> I agree.  Please take a look at the recent ESSIV patches on
> linux-crypto and build multi-block operations on top of them
> which can then be implemented by the hardware.
>
> Cheers,

Can you tell me which patch you mentioned? Is this?
https://patches.linaro.org/project/linux-crypto/list/?series=22762

