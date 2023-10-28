Return-Path: <linux-fsdevel+bounces-1495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359E07DA97F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A471C20990
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF918B10;
	Sat, 28 Oct 2023 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mm7/kBdi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCE17994
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:45 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2908D9
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211540euoutp02ccd2574008f16ae0e7fba5c1c8bc6dd7~SYfsIfodr0331103311euoutp02Z
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231028211540euoutp02ccd2574008f16ae0e7fba5c1c8bc6dd7~SYfsIfodr0331103311euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527740;
	bh=JNoJR/Xq7klfzP9hsOQ2xMnfdiLvLMoR5LEBEoVDOGw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Mm7/kBdisYvKed+Ygjkzhy9JoYAi4fful3cwN1vo9Q93LupZh5jo6Qx+rmZQKHVPd
	 DyzqzIDTQ4ta+ecdzC7gF4ZhT3ywHxbN9VgChrJTvJA8ynYNXCPcGdwAnG6/90wRR5
	 OB4t5WBqrOK4IkC+G7LWapdYxKCBFI2bfx6akZgc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211539eucas1p244eaee8bc62c90f79ee02e581ed59c80~SYfrfIuDH1224812248eucas1p22;
	Sat, 28 Oct 2023 21:15:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.20.11320.BF97D356; Sat, 28
	Oct 2023 22:15:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211538eucas1p1456b4c759a9fed51a6a77fbf2c946011~SYfqobMTB1181011810eucas1p1C;
	Sat, 28 Oct 2023 21:15:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231028211538eusmtrp241d650d122083e72da8aaaa16e6632fb~SYfqnuS2Q1141411414eusmtrp2Z;
	Sat, 28 Oct 2023 21:15:38 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-82-653d79fb8a21
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.F0.25043.AF97D356; Sat, 28
	Oct 2023 22:15:38 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211538eusmtip1460431297fe820fa6ae8f8fd8d552ed5~SYfqdcDZX0467404674eusmtip1I;
	Sat, 28 Oct 2023 21:15:38 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:38 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:37 +0100
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
Subject: [RFC PATCH 02/11] test_xarray: add tests for advanced multi-index
 use
Thread-Topic: [RFC PATCH 02/11] test_xarray: add tests for advanced
	multi-index use
Thread-Index: AQHaCePl1pHcrPV2xkWSZMmpwVjy+w==
Date: Sat, 28 Oct 2023 21:15:37 +0000
Message-ID: <20231028211518.3424020-3-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxSYRTHe+By75Wi3cTyKTUbWS0sspZ1IzPbWvGl5Zq9zLUZixs5ERlI
	7y9mNdMPVlamQKFmmkU5yJQUXMNZovbinNNMJZLMwZqZZC+aFlxrfvudc57z///P9uDMQDtr
	AZ4sT6eUcrGMh7KR6uc/X60cO76JiqrvDyd1lQaUfNB7GSXbXbPJj19zEdLaHUlarHaEbK/V
	oWSfYZJF1o6bMbLrykdAln0bwsg6YwlKjv3QoXEckTajDREVmdSix/f4ovaXapHpfjYqMn3N
	w0RNBWOIaMS0MB5PZMdIKFnyEUq5KvYA+7DW0sBQfF52bDxfmAH0i3JAAA6JtbCpeBDkADYe
	SNwDsHnEgdKFF8Brv51MuhgBsKJ0AMsBuH/ljWcv3S8HsM5pAf8f9Q89m9poBfDN0OiUVgWA
	DfZR4HNEieWw3m7CfIMgQsuCDXcu+QdM4gw0DGgQH3OJeNiiuYv6OIjYDRtvtTJoFsCOARfm
	Y4RYAr3N3f5MHGIjPNdzxtcOIGKgY7TGvwqIMPih4hdGywfDbpeeQV89B5ZoLUya58GJWidK
	8wr4stMFaI6CT+7WIzTz4Pil4qmYAth14zpKcyQsK/b4dTh/Ne2FLsR3FyQy2dBaVTplthW2
	jbpZNHOh+0UVRnMonHyqZ1wBkZpp+TTTPDTTPDTTPIoAch8EU2pVqpRSrZFTRwUqcapKLZcK
	DqalmsDf39Yy8cJrBuXuYYENMHBgAxBn8oI4zC0xVCBHIj5+glKmJSnVMkplAyE4wgvmLJGE
	U4GEVJxOpVCUglL+mzLwgAUZjOpHKyUPrT1K58yUB3Yzr8hSZYzu3R2q7jjZll3ae7V8MLfz
	qXHNhNR6sSl/y3o+jtxEue8TLxz9cUo+Vp5XGv22tjKmtdGWIh2ubjW6Tg/aBcKLg4f6xrUl
	t93b5i/qOu9+Fz4c0j2rSXg6TG8eqrwwaXHL3ktszoekN8iA5c34VMNlKhp3nQ0xJAu5LciG
	7T0LHZzFEewvsQlZHfnpulzUU1iVxhGHZlnkNYzXRw5SO+I69u1KMEfHIUn8gtntmfu/VMQH
	667pHddneOteLbeum1viiUrgJ/J3yIuWSsnn3ydkCnb9HoVDyorrU6TvNDZ3CrM2V0cgq/cm
	ZfIQ1WHxaj5TqRL/Ac0u88TcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsVy+t/xu7q/Km1TDX4+VbaYs34Nm8Xqu/1s
	Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
	Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
	GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZs/ccZip4q17xZ5pV
	A+N8hS5GDg4JAROJC6/Duxi5OIQEljIC2YtZuhg5geIyEhu/XGWFsIUl/lzrYoMo+sgosWny
	MUYI5wyjxNv3X6EyKxklThzYwAjSwiagKbHv5CZ2kISIwGxWicOLO8ASzAJ1EmuezQLbISzg
	J3Hv5V+wuIhAqMT8e/fZIGw9iavPnrCD2CwCqhJfTt1iB7mVV8BaovFOHYgpJJAr0d+WCVLB
	KWAjcf/bdrBORgFZiUcrf7FDbBKXuPVkPhPEBwISS/acZ4awRSVePv4H9ZmOxNnrTxghbAOJ
	rUv3QX2vJPGnYyHUxXoSN6ZOYYOwtSWWLXwNNodXQFDi5MwnLBMYpWchWTcLScssJC2zkLQs
	YGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZiath37uWUH48pXH/UOMTJxMB5ilOBgVhLh
	ZXa0SRXiTUmsrEotyo8vKs1JLT7EaAoMoYnMUqLJ+cDkmFcSb2hmYGpoYmZpYGppZqwkzutZ
	0JEoJJCeWJKanZpakFoE08fEwSnVwOR56tOqI322ddo/H6305LugNa/mya2Hyxc0Oi3gEFdW
	UZ7jt1j8W86BIpYct9pKs70zLRRfv1ZmvbvC2O5pkmjS07f/Hjw3vyMR4yz34L5E/rfHL0OV
	V63h/r9YtbzMbaXg0gkvN3g8e/xo04I7nQHsnJ+UH/Hd8uZMeN5pEevvt2/hm2o1o1nqc+sU
	pzidqp2xRsrWPVXnxBxD3ztRS4+euZXkEnrUPurpY07DJyIdfT6Sr76yX5q3IuP2g/Vci8sP
	Oq1JO6l0IMn21pXIqJZInytlrme27NPXfuiz9tDZ99MW/zsYY17ZM+NHotDxuOUxeZvPPWA5
	+77ONrfFXWXjqZ/He39Oq3t8SXDefKNJSizFGYmGWsxFxYkAFE7R3dYDAAA=
X-CMS-MailID: 20231028211538eucas1p1456b4c759a9fed51a6a77fbf2c946011
X-Msg-Generator: CA
X-RootMTR: 20231028211538eucas1p1456b4c759a9fed51a6a77fbf2c946011
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211538eucas1p1456b4c759a9fed51a6a77fbf2c946011
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211538eucas1p1456b4c759a9fed51a6a77fbf2c946011@eucas1p1.samsung.com>

From: Luis Chamberlain <mcgrof@kernel.org>

The multi index selftests are great but they don't replicate
how we deal with the page cache exactly, which makes it a bit
hard to follow as the page cache uses the advanced API.

Add tests which use the advanced API, mimicking what we do in the
page cache, while at it, extend the example to do what is needed for
min order support.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Daniel Gomez <da.gomez@samsung.com>
---
 lib/test_xarray.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 6c22588963bc..22a687e33dc5 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -694,6 +694,139 @@ static noinline void check_multi_store(struct xarray =
*xa)
 #endif
 }
=20
+#ifdef CONFIG_XARRAY_MULTI
+static noinline void check_xa_multi_store_adv_add(struct xarray *xa,
+						  unsigned long index,
+						  unsigned int order,
+						  void *p)
+{
+	XA_STATE(xas, xa, index);
+
+	xas_set_order(&xas, index, order);
+
+	do {
+		xas_lock_irq(&xas);
+
+		xas_store(&xas, p);
+		XA_BUG_ON(xa, xas_error(&xas));
+		XA_BUG_ON(xa, xa_load(xa, index) !=3D p);
+
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	XA_BUG_ON(xa, xas_error(&xas));
+}
+
+static noinline void check_xa_multi_store_adv_delete(struct xarray *xa,
+						     unsigned long index,
+						     unsigned int order)
+{
+	unsigned int nrpages =3D 1UL << order;
+	unsigned long base =3D round_down(index, nrpages);
+	XA_STATE(xas, xa, base);
+
+	xas_set_order(&xas, base, order);
+	xas_store(&xas, NULL);
+	xas_init_marks(&xas);
+}
+
+static unsigned long some_val =3D 0xdeadbeef;
+static unsigned long some_val_2 =3D 0xdeaddead;
+
+/* mimics the page cache */
+static noinline void check_xa_multi_store_adv(struct xarray *xa,
+					      unsigned long pos,
+					      unsigned int order)
+{
+	unsigned int nrpages =3D 1UL << order;
+	unsigned long index, base, next_index, next_next_index;
+	unsigned int i;
+
+	index =3D pos >> PAGE_SHIFT;
+	base =3D round_down(index, nrpages);
+	next_index =3D round_down(base + nrpages, nrpages);
+	next_next_index =3D round_down(next_index + nrpages, nrpages);
+
+	check_xa_multi_store_adv_add(xa, base, order, &some_val);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, base + i) !=3D &some_val);
+
+	XA_BUG_ON(xa, xa_load(xa, next_index) !=3D NULL);
+
+	/* Use order 0 for the next item */
+	check_xa_multi_store_adv_add(xa, next_index, 0, &some_val_2);
+	XA_BUG_ON(xa, xa_load(xa, next_index) !=3D &some_val_2);
+
+	/* Remove the next item */
+	check_xa_multi_store_adv_delete(xa, next_index, 0);
+
+	/* Now use order for a new pointer */
+	check_xa_multi_store_adv_add(xa, next_index, order, &some_val_2);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_index + i) !=3D &some_val_2);
+
+	check_xa_multi_store_adv_delete(xa, next_index, order);
+	check_xa_multi_store_adv_delete(xa, base, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* starting fresh again */
+
+	/* let's test some holes now */
+
+	/* hole at base and next_next */
+	check_xa_multi_store_adv_add(xa, next_index, order, &some_val_2);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, base + i) !=3D NULL);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_index + i) !=3D &some_val_2);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_next_index + i) !=3D NULL);
+
+	check_xa_multi_store_adv_delete(xa, next_index, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* hole at base and next */
+
+	check_xa_multi_store_adv_add(xa, next_next_index, order, &some_val_2);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, base + i) !=3D NULL);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_index + i) !=3D NULL);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_next_index + i) !=3D &some_val_2);
+
+	check_xa_multi_store_adv_delete(xa, next_next_index, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+#endif
+
+static noinline void check_multi_store_advanced(struct xarray *xa)
+{
+#ifdef CONFIG_XARRAY_MULTI
+	unsigned int max_order =3D IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
+	unsigned long end =3D ULONG_MAX/2;
+	unsigned long pos, i;
+
+	/*
+	 * About 117 million tests below.
+	 */
+	for (pos =3D 7; pos < end; pos =3D (pos * pos) + 564) {
+		for (i =3D 0; i < max_order; i++) {
+			check_xa_multi_store_adv(xa, pos, i);
+			check_xa_multi_store_adv(xa, pos + 157, i);
+		}
+	}
+#endif
+}
+
 static noinline void check_xa_alloc_1(struct xarray *xa, unsigned int base=
)
 {
 	int i;
@@ -1825,6 +1958,7 @@ static int xarray_checks(void)
 	check_reserve(&array);
 	check_reserve(&xa0);
 	check_multi_store(&array);
+	check_multi_store_advanced(&array);
 	check_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
--=20
2.39.2

