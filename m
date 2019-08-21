Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB30973FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfHUHyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 03:54:41 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:48751 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfHUHyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:54:39 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190821075436epoutp040c84c20ae0f5c7d840c312661c17113d~84Oxjfvax2258522585epoutp04x
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 07:54:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190821075436epoutp040c84c20ae0f5c7d840c312661c17113d~84Oxjfvax2258522585epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566374076;
        bh=HTqJmzQb78c+WqBPB/TdiHvNXR8CCp1GserLHPcAGAM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=B5jxDUEk9/Wv2ZsXCfJ0XkAJm9DIHY27cqGo72ZywbwCE+aVOvTsvyScwL4p6sybM
         owql64lYHWS43PFd/HInQdLPv83SRaGXip0WkjESDr2vLz6mjff1A3/7j7+O7TOWyK
         7NAk6jkpVH93RiwuqnuxfGH0LViWO/nOoUaD+g4w=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190821075435epcas2p2329ac0d31488e7667c632810cc878449~84Ow2IQSF1069310693epcas2p2D;
        Wed, 21 Aug 2019 07:54:35 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.182]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46D0LK1qCszMqYkr; Wed, 21 Aug
        2019 07:54:33 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.06.04112.9B8FC5D5; Wed, 21 Aug 2019 16:54:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20190821075432epcas2p3758bf7b07f209fb4094d79bf46c8f4e9~84OuTKtNR3087030870epcas2p3N;
        Wed, 21 Aug 2019 07:54:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821075432epsmtrp11638c73e7bcdf5c06195a2218aa9d41f~84OuR59zE2895328953epsmtrp1D;
        Wed, 21 Aug 2019 07:54:32 +0000 (GMT)
X-AuditID: b6c32a48-f37ff70000001010-86-5d5cf8b9dcde
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.79.03706.8B8FC5D5; Wed, 21 Aug 2019 16:54:32 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821075432epsmtip253f2d9c05d500f90970ebcdc57e310bc~84Ot-od_T3239432394epsmtip2r;
        Wed, 21 Aug 2019 07:54:32 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Mike Snitzer'" <snitzer@redhat.com>
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
Date:   Wed, 21 Aug 2019 16:54:32 +0900
Message-ID: <001a01d557f5$ab0a4a40$011edec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Content-Language: ko
Thread-Index: AdVX9QyEG4+5qw7KRk2/gqnMxtuMUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxT29r2+9wBLrhXntZrZvWkWJGCLll0WmVt0+jJNrNkSo4LdC7wA
        WX+tr3WwZJNtWBGadZopUruGuWm0C0ELCigYRzs7hl11qJOquEXiIvhrKAR/jbV9mPHfOd/5
        vnvOd08OQyjraRVTbrYLNjNvZKlU8kQwE2d3jBcWaRqHUvHooxoSN/96lsA/XndTuHdPRIa9
        0WoSd93bL8dNnc8IXDc0Dw82ewh85YlTjt03hwkcjR6lceDmZTnuimXhGwOPZbjBd43Cvx9Y
        jYd8YyTu7Oohcd9JL4VDE26A90VPy7Dz2CjA212PaRxu2vDWHK71SL+Mq275mDtxZiHXF3Fw
        Af9Oirt2uZPiWn7Yxp1qfCjjvjj3M8HdP32J4r5q9QPuYeBl/fRNxmVlAl8i2NSCudhSUm4u
        LWDXvGdYYdDlabTZ2nz8Oqs28yahgF25Vp+9qtwY986qt/JGRxzS86LILn5zmc3isAvqMoto
        L2AFa4nRqtVac0TeJDrMpTnFFtMbWo0mVxdnfmAsi9XVU9Z9TIXzSoCoAiGqFqQwCC5F4RsB
        UAtSGSVsB8gd9E8mIwBVj18nEywlHAMoun12LWCSir0PUiVOF0C7XbspKbkN0K3zz5ICCmah
        lnDipRQmA2aiX65+I0+QCPgvjQZHupOkmVCHBkJ1yTlIuBAd/Pt+PKYZBcxHA4YEqoAzUE/D
        YJJNwPmo7a6XkKZWo/bIMJDwDLR/p5OQWuWgCx2PyEQrBD9n0E/hKloSrESH97pkUjwTDYVb
        J3EVuu12Tsbb0KVD39OS2AXQuScvCkuQ59YOkHBPxM00n1wsfcSrKBSbnC0d1QSf0xKsQDVO
        pSRcgL4d6ZNJsAo9cH0mwRy62DtOfg1e8Uwx6Zli0jPFmOf/to2A9IOXBKtoKhXEXOvSqZsO
        gORRLOLawZnf1nYDyAB2uqK9f3ORUs5vFStN3QAxBJuhqPBuKlIqSvjKTwSbxWBzGAWxG+ji
        G9hFqGYVW+InZrYbtLrcvDxNvg7r8nIxO1sRSOsvVMJS3i58KAhWwfZCJ2NSVFXg+LyNF1t7
        vcsVc97u2LyhPgidT6/Oivas2LOmAjR9dzyYJYxX3gG+daubjvlnLFHb/3QMn/0y8sdcIT1t
        7N77Wy483XX+VKT5n/mFfemv8b627Mwdbe8uyPRNlK9/Z9rdjZ+G//poeb0exg6v00+7g7wT
        oVhaAxyDwVDWKLeq4kAnzZJiGa9dRNhE/j+QRa7/KgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCSvO6OHzGxBjNXaFh8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBl3OqezlYwg6Oi7cYm5gbGI2xdjBwc
        EgImEtM+cHUxcnEICexmlFg16QZjFyMnUFxKYmv7HmYIW1jifssRVoii54wSD39eBUuwCWhL
        bD6+CqxBREBT4sTtKawgNrPANA6JXR/EQWxhAVOJe0e62UBsFgFViaXP3wPZ7By8ApYS9+JB
        orwCghInZz5hATmHWUBPom0jI8QQeYntb+dAXaAgsePsa6i4iMTszjZmiKV6Ehd3fmGZwCg4
        C8mkWQiTZiGZNAtJ9wJGllWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHxr6W5g/Hy
        kvhDjAIcjEo8vDtuRscKsSaWFVfmHmKU4GBWEuGtmBMVK8SbklhZlVqUH19UmpNafIhRmoNF
        SZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVANjcVNZnlGXxD0pT0sbo+QV7PNEp90NOvP9wOXl
        ubMDp85MW/HfyaitQ3zr5d+zitTdAy4m308+t/jIDR2XdxHl6Z+vt8UuT9421zd+h6Nl/q0M
        kb2LZ/13SKt+cPrVkmu7X2bIhQV+j9rfcVJoQtHaO/kTVjnKxt+va+/TC6x/3Pk19WTu8yNT
        lFiKMxINtZiLihMBBGnmbfsCAAA=
X-CMS-MailID: 20190821075432epcas2p3758bf7b07f209fb4094d79bf46c8f4e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821075432epcas2p3758bf7b07f209fb4094d79bf46c8f4e9
References: <CGME20190821075432epcas2p3758bf7b07f209fb4094d79bf46c8f4e9@epcas2p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:13:36AM +0200, Milan Broz wrote: 
>
> NACK.
> 
> The whole principle of dm-crypt target is that it NEVER EVER submits
> plaintext data down the stack in bio.
> 
> If you want to do some lower/higher layer encryption, use key management
> on a different layer.
> So here, just setup encryption for fs, do not stack it with dm-crypt.
> 
> Also, dm-crypt is software-independent solution
> (software-based full disk encryption), it must not depend on
> any underlying hardware.
> Hardware can be of course used used for acceleration, but then
> just implement proper crypto API module that accelerates particular
cipher.

I'm sorry for breaking the basic rules of dm-crypt. 
But, if I want to use the H/W crypto accelerator running in storage
controller,
I have to drop plaintext to bio.
I think the "proper crypto API module" that you mentioned is diskcipher
because diskcipher isn't only for FMP.
Diskcipher is a crypto API that supports encryption on storage controllers.

Thanks
Boojin Kim

