Return-Path: <linux-fsdevel+bounces-1493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8A7DA97B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DF81C209CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79018AE1;
	Sat, 28 Oct 2023 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jjaWoMKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88411B667
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:45 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F869E6
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:41 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211539euoutp02587f3a611d700338187795ff6be84bc4~SYfrvmt7H0878908789euoutp02F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231028211539euoutp02587f3a611d700338187795ff6be84bc4~SYfrvmt7H0878908789euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527739;
	bh=eR4ECi1C+RsYauRNG0Oa6wKRBmELNPkutLhe+B7jobc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=jjaWoMKmpeL2sLoVtVIJ4rBEKLLd2KsJYQnpEHdBiXJriXoTywXG7JA0og2/7E9L4
	 nh3HhyRmF4s0KfRNL2fV8cM/ugVIvmzKE6VHyE/hZDSmpARN7AkVO0+/3hrdTuAeGS
	 B39ZTQ5pTxSF7SBjTBKGSvpsliXmO/RVLKc4DdkQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211538eucas1p2c2a45a33072dae2e110eb46cac041cea~SYfq672AJ1087910879eucas1p2A;
	Sat, 28 Oct 2023 21:15:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id DA.57.37758.AF97D356; Sat, 28
	Oct 2023 22:15:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54~SYfqiRzRj2326023260eucas1p1N;
	Sat, 28 Oct 2023 21:15:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231028211538eusmtrp26da1062912af33695c737ab5cb5b69ed~SYfqhpNZo1141411414eusmtrp2Y;
	Sat, 28 Oct 2023 21:15:38 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-f7-653d79fa5a08
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.F0.25043.AF97D356; Sat, 28
	Oct 2023 22:15:38 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211538eusmtip1dbcf26df78fa637ec241be47c974aeb8~SYfqUnhnc0467404674eusmtip1G;
	Sat, 28 Oct 2023 21:15:38 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:37 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:36 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "minchan@kernel.org" <minchan@kernel.org>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "gost.dev@samsung.com" <gost.dev@samsung.com>, Pankaj Raghav
	<p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
Subject: [RFC PATCH 01/11] XArray: add cmpxchg order test
Thread-Topic: [RFC PATCH 01/11] XArray: add cmpxchg order test
Thread-Index: AQHaCePk2/Onfe3eA0ia1dQGCoKrAw==
Date: Sat, 28 Oct 2023 21:15:35 +0000
Message-ID: <20231028211518.3424020-2-da.gomez@samsung.com>
In-Reply-To: <20231028211518.3424020-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87q/Km1TDS60mFvMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
	In27BK6MV8/WsRU08lVMWbqLqYHxPXcXIyeHhICJxLkp75i6GLk4hARWMEq83rOKEcL5wigx
	Z+M5ZpAqIYHPjBLr//HCdJzp+AbVsZxR4unkncwQDlDRlx3P2SGcM4wSR57tYoFwVjJK3H95
	jwmkn01AU2LfyU1gVSICs1klDi/uYARJMAvUSax5NosFxBYWsJS4seoSK4gtImAn8fDWS3YI
	W0/i3PVXbCA2i4CqxJPtG8BqeAWsJVae2gN2LKeAjcT9b9vBahgFZCUerfzFDjFfXOLWk/lM
	EE8ISiyaDVEvISAm8W/XQzYIW0fi7PUnjBC2gcTWpftYIGwliT8dC6Hu1JO4MXUKG4StLbFs
	4WtmiBsEJU7OfAL2sYRAE5fE2mc/2SGaXSRufFsAZQtLvDq+BcqWkfi/cz7TBEbtWUjum4Vk
	xywkO2Yh2bGAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYHo7/e/41x2MK1591DvE
	yMTBeIhRgoNZSYSX2dEmVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFq
	EUyWiYNTqoFJ9ZV/dd1GI93DtoE+27iP3VQ4ffXl/YronfulpAUW3vBc+Yoj+Y+QktapC9o9
	ie4vzrw/zPHf4fX9CZc3CJTYPJzxyG6VhHtbSsXDEOb24DbWe1LLLR7t/HX6aaRDYMaDdekp
	f93/HRLfkVxR4cRnJ/BOOF6Md4Vuk6RAxY6V+seDzR89vpE74Y+KXFHjuqJrpZtuHFk7S+G3
	/sdX7B9O7Hqg65WeyVyWuM02XO/u7oK3nKvys4olVu68H3BARrXU0Nxyc12CU7RNWKK61RQH
	/bBl0sXvlt6R2W211/bJ87PzE/ua/ecu2Lk661AG2/9GewfxVw6iSw4zJZyqF3wy383xsKyp
	ksmlayuiXQKUWIozEg21mIuKEwF6TjHB3gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsVy+t/xu7q/Km1TDb7/lLKYs34Nm8Xqu/1s
	Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
	Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
	GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZr56tYyto5KuYsnQX
	UwPje+4uRk4OCQETiTMd35i6GLk4hASWMkqcO7WZDSIhI7Hxy1VWCFtY4s+1LjaIoo+MEl0d
	q6CcM4wSrxb9h3JWMkrMuvqRHaSFTUBTYt/JTewgCRGB2awShxd3MIIkmAXqJNY8m8UCYgsL
	WErcWHUJbIeIgJ3Ew1sv2SFsPYlz11+B3cEioCrxZPsGsBpeAWuJlaf2MHcxcgBty5Xob8sE
	CXMK2Ejc/7YdrJxRQFbi0cpf7BCrxCVuPZnPBPGCgMSSPeeZIWxRiZeP/0G9piNx9voTRgjb
	QGLr0n0sELaSxJ+OhVAn60ncmDqFDcLWlli28DUzxDmCEidnPmGZwCg9C8m6WUhaZiFpmYWk
	ZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzABLXt2M8tOxhXvvqod4iRiYPxEKMEB7OS
	CC+zo02qEG9KYmVValF+fFFpTmrxIUZTYBBNZJYSTc4Hpsi8knhDMwNTQxMzSwNTSzNjJXFe
	z4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamtVN4di4qPqJW9uUiy9JTR6OSr77+oZN58HBy0mlj
	rV2/wkqcnLi/Hmj1VTzpycA2fRuHyt1LNnszbn2vFJ8bua0+pNPuTkzxli/OPRdfr5O/Zr9u
	4bfNfZ58P5nt92YmyEsFH3/sNP2aiJC23dSJnoa/W9+ryPQa+ixZMWVjxofg/+83lyowMH29
	fFbh9dyvPAd4dnM67THTdqvzipjd8sfUpmPqg4vNn92ZS1iuJion6zwJPOIQksO5fJnqn7Zw
	kVcx3Mvu7H/8/f2ErochM97c/v6E9eWUHOkY1k3uv+XuL1Z0CHta+1oldMaK+gfeAkqFCz+W
	BJhWPH6WrvJD2nztj0ARLbfcNVZfC3pllViKMxINtZiLihMBJkEZzNkDAAA=
X-CMS-MailID: 20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54
X-Msg-Generator: CA
X-RootMTR: 20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54@eucas1p1.samsung.com>

XArray multi-index entries do not keep track of the order stored once
the entry is being marked as used (replaced with NULL). Add a test
to check the order is actually lost.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_xarray.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e77d4856442c..6c22588963bc 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -423,6 +423,26 @@ static noinline void check_cmpxchg(struct xarray *xa)
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
=20
+static noinline void check_cmpxchg_order(struct xarray *xa)
+{
+	void *FIVE =3D xa_mk_value(5);
+	unsigned int order =3D IS_ENABLED(CONFIG_XARRAY_MULTI) ? 15 : 1;
+	void *old;
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+	XA_BUG_ON(xa, xa_store_index(xa, 5, GFP_KERNEL) !=3D NULL);
+	XA_BUG_ON(xa, xa_insert(xa, 5, FIVE, GFP_KERNEL) !=3D -EBUSY);
+	XA_BUG_ON(xa, xa_store_order(xa, 5, order, FIVE, GFP_KERNEL));
+	XA_BUG_ON(xa, xa_get_order(xa, 5) !=3D order);
+	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) !=3D order);
+	old =3D xa_cmpxchg(xa, 5, FIVE, NULL, GFP_KERNEL);
+	XA_BUG_ON(xa, old !=3D FIVE);
+	XA_BUG_ON(xa, xa_get_order(xa, 5) !=3D 0);
+	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) !=3D 0);
+	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(old)) !=3D 0);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
 static noinline void check_reserve(struct xarray *xa)
 {
 	void *entry;
@@ -1801,6 +1821,7 @@ static int xarray_checks(void)
 	check_xas_erase(&array);
 	check_insert(&array);
 	check_cmpxchg(&array);
+	check_cmpxchg_order(&array);
 	check_reserve(&array);
 	check_reserve(&xa0);
 	check_multi_store(&array);
--=20
2.39.2

