Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF69A871
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 09:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfHWHS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 03:18:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:35784 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732030AbfHWHS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:18:56 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190823071852epoutp01dab3bb131b70d5ad7737cfdda23085e5~9fCJGvYHU0132801328epoutp01P
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2019 07:18:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190823071852epoutp01dab3bb131b70d5ad7737cfdda23085e5~9fCJGvYHU0132801328epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566544732;
        bh=+fYE/jWK1CRZuDZ2tVBT+Ef/F2Gp0hZ+OjNZD7CcuN0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JPCoQLPyMnwUsXcRJAb87lIbwjVAz8UJnhO9geXbleKdINR95oS+Pk7MPNyeSIKlr
         Ie5LM4HsFuPx33ZSSTfcMnvc55/lFYB3Po/KTATm56/rPppRH16qhqPtM2q1rTtoUK
         Y+RZMMMZQWD9EG8hvLGNnIEbSL4l0oI/7oyWJQfs=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190823071851epcas2p2a4a203c12c80c1285afac51eb7c84d8f~9fCIdn5SC1459514595epcas2p2h;
        Fri, 23 Aug 2019 07:18:51 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.182]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46FCS92KMhzMqYkd; Fri, 23 Aug
        2019 07:18:49 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.3F.04112.9539F5D5; Fri, 23 Aug 2019 16:18:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20190823071848epcas2p3fe4d229d22b14162c354f88a29f366c2~9fCGBJdVk1882918829epcas2p3k;
        Fri, 23 Aug 2019 07:18:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190823071848epsmtrp10b85cadf4258caf7cfd003e7d6717ccd~9fCF-zuWg1973319733epsmtrp1u;
        Fri, 23 Aug 2019 07:18:48 +0000 (GMT)
X-AuditID: b6c32a48-f37ff70000001010-57-5d5f935942ee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.E5.03706.8539F5D5; Fri, 23 Aug 2019 16:18:48 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190823071848epsmtip1133664f58af60792a11a792437cc8f99~9fCFn2bUi1770217702epsmtip1x;
        Fri, 23 Aug 2019 07:18:48 +0000 (GMT)
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
Date:   Fri, 23 Aug 2019 16:18:47 +0900
Message-ID: <002b01d55983$01b40320$051c0960$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVZgoTeM6vEQWOMSaO8aX0QkbtHrA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxjN7Xt9r6JdrqVudw3bujc0EQO2ne0uC2xmY/jMTMSZuOjGujf6
        Uoj9lb6WqdmEbFAB2dAYEQoSf8XNbgQtiMS1hCCs4kSyEYwarVskqwIriIABRdbycOO/853v
        nPt9J1+ujFAcoVWyApuLd9o4C0MlkK2XVhtStx8y5mrC1XI8OVFG4qYrvxL4pztVFP7tcK8E
        1/eVkDgYrZPixsBTAu8fSsKDTV4C35jxSHHVvWEC9/WdpbH/3nUpDt5ag++GpyW4tuE2hf84
        sQEPNUyROBDsIXH/xXoKd81VAVzT1y7BnnOTAJdWTtM41Pjx+pfZljM3JWxJ85dsa8dKtr/X
        zfp95RR7+3qAYptPFbG/HHskYb+52k2wo+0DFPt9iw+wj/yv5izbYcnI5zkT71Tztjy7qcBm
        zmQ+3Gp836g3aLSp2nT8FqO2cVY+k8nalJOaXWCJZWfUhZzFHaNyOEFg1r6T4bS7Xbw63y64
        MhneYbI4tFpHmsBZBbfNnJZnt76t1Wh0+pjyc0v+yPkfpY4QvevOz2GiGBynKsASGYLrUPnI
        abICJMgUsA2gga4wIRbjAEWiE7RYTAE0fqD2P0v0/jAdxwoYBOjxRLYoegDQ04fnpfEGBdeg
        5pAPxLESatAF/xMQFxHwGY0GxzvJeCMR6lG4a3/sVZmMhCtRw6QxTsthOmo82kOJeDnqqR2c
        lxPwNXThn3pCXEKN2nqHQdyqhGnIU+IUJUpUV+5ZkEzT6Er/chFnobpvRyUiTkRDoRZaxCr0
        oMqzgIvQwOmT84ERrATo6szzxpvI+/e++VkEXI2aLq6NQwTfQF23FjZ7AZVdmqVFWo7KPArR
        mIyOjvdLRFqFxir3ijSLhh6XggPgde+iiN5FEb2Lsnj/H3sMkD7wIu8QrGZe0DnWLb60H8x/
        ihS2DXRc29QJoAwwy+SXKz7LVUi5QmG3tRMgGcEo5YUHY5TcxO3ewzvtRqfbwgudQB87wEFC
        tSLPHvtiNpdRq9cZDJp0PdYbdJh5Se5fevNTBTRzLn4nzzt453OfRLZEVQzWp3SsqI8EehAc
        G/xA+D0yV5R8ZiL4SQgmrNr6Q7mueOmN4u+UjRHSvfH+u9fYVaaxqZzWuj0j1dtqyo7MKLt3
        Hv6o4VDyX1knc7/elr1xy+xkS0Yi0335meYLvW/vn9GkVONcYPNs5Kz2q+pXkvZ17zrVXjlq
        vlvzXulszY7pJ5HoQ4YU8jltCuEUuH8B2IqajSoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCSnG7E5PhYg87bihZfv3SwWKw/dYzZ
        YvXdfjaL01PPMlnMOd/CYrH33WxWi7V7/jBbdL+SsXiyfhazxY1fbawW/Y9fM1ucP7+B3WLT
        42usFntvaVvcv/eTyWLmvDtsFpcWuVu8mveNxWLP3pMsFpd3zWGzOPK/n9Fixvl9TBZtG78y
        WrT2/GS3OL423EHSY8vKm0weLZvLPbYdUPW4fLbUY9OqTjaPO9f2sHlsXlLvsXvBZyaPpjNH
        mT3e77vK5tG3ZRWjx+dNcgE8UVw2Kak5mWWpRfp2CVwZb7auYC04zl5xd8095gbGhWxdjJwc
        EgImEu9evGYHsYUEdjNK9B0xgYhLSWxt38MMYQtL3G85wtrFyAVU85xR4syCxWANbALaEpuP
        r2IEsUUEDCS2b/oNZjMLTOOQ2PVBHMQWFjCVuHekG2gZBweLgKrEvK/xIGFeAUuJtXNPskHY
        ghInZz5hASlhFtCTaNsINUVeYvvbOVAnKEjsOPuaEaREBKSkpQiiRERidmcb8wRGwVlIBs1C
        GDQLyaBZSDoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjn8tzR2Ml5fEH2IU
        4GBU4uEt6IiLFWJNLCuuzD3EKMHBrCTCWzYRKMSbklhZlVqUH19UmpNafIhRmoNFSZz3ad6x
        SCGB9MSS1OzU1ILUIpgsEwenVAPj/OSa9W1d/dfS9K63n54b1X3C+cSWAqnD/vI1HyIsY87q
        y9e/2CLn6c+WUXD5Ym3vnseaC/u2PP5mt3a5zZYUj0uvzY7c3Zv15QDjJeHpgkwt3gwHH/eF
        CF+KdStfHfH8kRKHhM5DuXgjtzMbfnMVufJKnMreU1zOr6S3rV5ln++hk4tZLD4qsRRnJBpq
        MRcVJwIAsdKINPsCAAA=
X-CMS-MailID: 20190823071848epcas2p3fe4d229d22b14162c354f88a29f366c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190823071848epcas2p3fe4d229d22b14162c354f88a29f366c2
References: <CGME20190823071848epcas2p3fe4d229d22b14162c354f88a29f366c2@epcas2p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 01:28:37PM +0900, Herbert Xu wrote:
>
> No.  If you're after total offload then the crypto API is not for
> you.  What we can support is the offloading of encryption/decryption
> over many sectors.
>
> Cheers,

FMP doesn't use encrypt/decrypt of crypto API because it doesn't
expose cipher-text to DRAM.
But, Crypto API has many useful features such as cipher management,
cipher allocation with cipher name, key management and test manager.
All these features are useful for FMP.
FMP has been cerified with FIPS as below by using test vectors and
test manager of Crypto API.
https://csrc.nist.gov/projects/cryptographic-module-validation-program/Certi
ficate/3255
https://csrc.nist.gov/CSRC/media/projects/cryptographic-module-validation-pr
ogram/documents/security-policies/140sp3255.pdf

Can't I use crypto APIs to take advantage of this?
I want to find a good way that FMP can use crypto API.

Thanks
Boojin Kim.

