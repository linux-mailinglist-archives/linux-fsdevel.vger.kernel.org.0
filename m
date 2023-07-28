Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9479A7664C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjG1HFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 03:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjG1HFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:05:04 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E632688;
        Fri, 28 Jul 2023 00:05:01 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230728070458euoutp022f15e56badf4165b98bf10ed163f85c3~19irGFNPg2448024480euoutp02O;
        Fri, 28 Jul 2023 07:04:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230728070458euoutp022f15e56badf4165b98bf10ed163f85c3~19irGFNPg2448024480euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690527898;
        bh=br9G7r4+wWkapIsRtHLfrIdX5fm3tF8e2xPu8oGSqtY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=uLe/QZJmwzYlCsgebU5xg+cv1Milka3pnjtEiravXqPEwVPKIskZ1xm1M7EDMqlgf
         qREl8PJdPDwP2JvfJN0AO05NsuSx55b+RtvEs3oTU/GYvY85Z+uEfwPkg/qZK4Z1RD
         LENgMw/TW50s64xPFhpuACQKS/BfTPn0pOZ3j+A4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230728070458eucas1p1b02fcc2dedf94d9f266c017dd17c370e~19iq8kmU-3067930679eucas1p16;
        Fri, 28 Jul 2023 07:04:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.1E.42423.A9863C46; Fri, 28
        Jul 2023 08:04:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230728070458eucas1p297053e1ebb40da3524acb7f73fa72081~19iqmBx-n0463204632eucas1p2h;
        Fri, 28 Jul 2023 07:04:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230728070458eusmtrp27a6d8a269fecfab6123bb80997a2d0ba~19iqlcqH12380823808eusmtrp21;
        Fri, 28 Jul 2023 07:04:58 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-4f-64c3689a20fc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 54.55.14344.A9863C46; Fri, 28
        Jul 2023 08:04:58 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230728070457eusmtip2cae171e462fe20d725967fe6b7db42eb~19iqaA12w2281622816eusmtip2f;
        Fri, 28 Jul 2023 07:04:57 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 28 Jul 2023 08:04:57 +0100
Date:   Fri, 28 Jul 2023 09:04:56 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, <willy@infradead.org>,
        <josh@joshtriplett.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 00/14] sysctl: Add a size argument to register functions
 in sysctl
Message-ID: <20230728070456.zkzuh5caofkvvupj@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="aodohqg2l7fppyro"
Content-Disposition: inline
In-Reply-To: <ZMKPzzkVy45lSCJ7@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87qzMg6nGFx8KGPxf0G+xZnuXIs9
        e0+yWFzeNYfN4saEp4wWxxaIWfz+AeQt2+nnwOExu+Eii8eCTaUem1doedx6beuxaVUnm8fn
        TXIBbFFcNimpOZllqUX6dglcGf8OnmQsmMpfcW3fIqYGxrc8XYycHBICJhIXFk1n6mLk4hAS
        WMEocffzYWYI5wujxOvTU9ggnM9AmStrgRwOsJZbN2Ig4ssZJY7Mns4CV7Tn0yZ2CGcro8Th
        72uZQJawCKhKfPg1A8xmE9CROP/mDjOILSKgIbFvQi/YcmaBm4wSJ89sZwdJCAtESGzv2s0C
        YvMKmEvs3HeYDcIWlDg58wlYnFmgQmL1mZnsICcxC0hLLP/HARLmFDCT2Hz2GxvEc8oSB5f8
        ZoewayVObbkFtktCYD6nxPLPaxkhEi4Si9vOs0LYwhKvjm+BapCR+L9zPlTDZEaJ/f8+sEM4
        qxklljV+ZYKospZoufIEqsNRYuWpY6yQQOKTuPFWEOJQPolJ26YzQ4R5JTrahCCq1SRW33vD
        MoFReRaS12YheW0WwmsQYR2JBbs/sWEIa0ssW/iaGcK2lVi37j3LAkb2VYziqaXFuempxYZ5
        qeV6xYm5xaV56XrJ+bmbGIFJ7fS/4592MM599VHvECMTB+MhRhWg5kcbVl9glGLJy89LVRLh
        PRVwKEWINyWxsiq1KD++qDQntfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDUy2T
        o8/XtecfPFy5NmWbsu6j+b/VgsWs8zr8eJ66it1bPD3rhcPrYv2zl9gnzX1UcONF62rv+cUz
        zi4PZXj2qOiGNVMsg86vqPrJRr4cCQav33L41v0py9nXcJDh83dRg/iLyRtNPsndCFOsuT+9
        V1///IwnFxQOiS60KuhK5fV6Opld6ZVpgMj8LwHTXyt/edi8YXNKVcvU9EuijzX3+muW3/zE
        oHyag+2ucOIp8/vztxan8CkUHNbatOaylNI9prlXzr9gUE3N/mhukrm889W3r78DNvusnH3+
        7soD37ZsZ3+8OfBA1U937V8H/se2nbsq5FEcajBV+2zuob15U41E3pU/PP/mar+KcY35rXgl
        luKMREMt5qLiRACTyzow5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xe7qzMg6nGHzZymrxf0G+xZnuXIs9
        e0+yWFzeNYfN4saEp4wWxxaIWfz+AeQt2+nnwOExu+Eii8eCTaUem1doedx6beuxaVUnm8fn
        TXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6
        Gb/3z2UrmMxf0Xb0D1MD42ueLkYODgkBE4lbN2K6GLk4hASWMkpc3tHC1sXICRSXkdj45Sor
        hC0s8edaFxtE0UdGiSv3/zNBOFsZJV6feM4OUsUioCrx4dcMJhCbTUBH4vybO8wgtoiAhsS+
        Cb1gDcwCNxklTp7ZDtYgLBAhsb1rNwuIzStgLrFz32GoFdOZJN5umgWVEJQ4OfMJmM0sUCZx
        6d1NFpC7mQWkJZb/4wAJcwqYSWw++w3qbGWJg0t+s0PYtRKf/z5jnMAoPAvJpFlIJs1CmAQR
        1pK48e8lE4awtsSyha+ZIWxbiXXr3rMsYGRfxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERjZ
        24793LKDceWrj3qHGJk4GA8xqgB1Ptqw+gKjFEtefl6qkgjvqYBDKUK8KYmVValF+fFFpTmp
        xYcYTYHBOJFZSjQ5H5hy8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4
        OKUamBw3T5nIsnPuroINmbd5lig9Va2dsWm+mMzvp9e3Lqp6E9D+hF3mzULrhEkp0zxilr3O
        Pftu6dPCYI+vb+7M7xTNk5XgWGe288SMbY3b15y5uX/J6x/hnBsl2hWSDgc+idBt6stOut7+
        ZsKxSmMd+cc80pfCGTg0n08J8X0zgX/Zhu2pNZyfzkgfmLju2d4TB45x759+f+ueDw+FT9/+
        /WNepvv+uCnNrzq7vJpL/spZVnc0liQ1r//u8+tU3HNm9uLZL220p/QwRN15teLsdN89W1Rc
        ozfrWYVprAx+unWuFLf01A9Ta+x/up/n3CbsnBJ/d8FdxYbXqx5emHo+Nr7jNwub0MSrkezr
        bjGpqPyJVmIpzkg01GIuKk4EAHRmUFaBAwAA
X-CMS-MailID: 20230728070458eucas1p297053e1ebb40da3524acb7f73fa72081
X-Msg-Generator: CA
X-RootMTR: 20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd
References: <CGME20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd@eucas1p2.samsung.com>
        <20230726140635.2059334-1-j.granados@samsung.com>
        <ZMFizKFkVxUFtSqa@bombadil.infradead.org>
        <20230727114318.q5hxwwnjbwhm37wn@localhost>
        <ZMKPzzkVy45lSCJ7@bombadil.infradead.org>
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

--aodohqg2l7fppyro
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 08:39:59AM -0700, Luis Chamberlain wrote:
> On Thu, Jul 27, 2023 at 01:43:18PM +0200, Joel Granados wrote:
> > On Wed, Jul 26, 2023 at 11:15:40AM -0700, Luis Chamberlain wrote:
> > > On Wed, Jul 26, 2023 at 04:06:20PM +0200, Joel Granados wrote:
> > > > What?
> > > > These commits set things up so we can start removing the sentinel e=
lements.
> > >=20
> > > Yes but the why must explained right away.
> > My intention of putting the "what" first was to explain the chunking and
>=20
> It may help also just to clarify:
>=20
>    sentinel, the extra empty struct ctl_table at the end of each
>    sysctl array.
This clarification is already there: "... sentinel element (the extra
empty element in the ctl_table arrays ...".

>=20
> > Thx for this.
> > This is a more clear wording for the "Why". Do you mind if I copy/paste
> > it (with some changes to make it flow) into my next cover letter?
>=20
> I don't mind at all.
>=20
>   Luis

--=20

Joel Granados

--aodohqg2l7fppyro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTDaJYACgkQupfNUreW
QU+vVAwAgQjVd6B4tr1mRhFBZ0k0OybQ2cBcaFiVHeSQv6xgqasDX9RQI60TfUhV
fqkSg9vSHUvznOLzXRQO9tLPoADS8n7B4gpnJLCYeIEHO8vp9oZU/wlVTAbRRilL
Wg+8UCDmztLIRyrGlVZIIVOeVHr4B4KZqu24fT5pFh3uMeAxLBGPFozcwzM4IGxB
nUQb8nVvon6Pf0yVCIAT+Qq5xF9uOIbT0W0/Q89cjgygKlMDnPtNZjlMrRIvvvT1
EtLovOeys9Vbzbm52IxNeI+F02d1RzwL1ZcNWxOS/W4St+8SsIhK57W3ZCsjaX0i
PErXwQET17rgnOGzoKGOpwIhDLYoZtmwRtOhr3DNA+7Mpw7afFpDjkLLfBDOEQhj
iIhX0o1qYmSlkx9UecmrVH9TU//ByGygBQA0nBkcYesWKvj9qRD0DuOe38w+IAud
234k0oj286eq7WeTfW32plcVKlU9w6we1Rf7QQ1CkWoHVoyidn9sjuNhT6rNZWu9
Uq8aVZoJ
=iiSr
-----END PGP SIGNATURE-----

--aodohqg2l7fppyro--
