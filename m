Return-Path: <linux-fsdevel+bounces-1494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B1B7DA97D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D61A1C20992
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA118AF4;
	Sat, 28 Oct 2023 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VYigV6I+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9B17997
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:46 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F7EF3
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:45 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211543euoutp02fbe7cc60dc92446817cf957ddad059d2~SYfu8rZwA0878908789euoutp02M
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231028211543euoutp02fbe7cc60dc92446817cf957ddad059d2~SYfu8rZwA0878908789euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527743;
	bh=8ofABjUQrTp1kzdTCcGf7BUaZhuxx/1pi/TdtpYF5D0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=VYigV6I+Xlg2f6kz+xnces7qO2f0nE5tR01Ol4rTD112qHEJhBXjL2IHc3c+wZLc0
	 4J5CPLxTCXq6Ef4vaHJ1aZ336J5ZiBJuzTVHj3DUHIMh8LafS+j7OlzIeMZQm0qVAT
	 WE449o7Hrm2ASSKGptRHfU9DYe+D1wjPkqA1i5Rs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211542eucas1p241e7ab5f2da4fdfc2cba9e250271dcbc~SYfuALImE1087910879eucas1p2E;
	Sat, 28 Oct 2023 21:15:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id A1.20.11320.EF97D356; Sat, 28
	Oct 2023 22:15:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231028211541eucas1p26663bd957cb449c7346b9dd00e33a20f~SYftgbGJH1224812248eucas1p26;
	Sat, 28 Oct 2023 21:15:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231028211541eusmtrp14898d07da8c7cf9ca684d016181d49c0~SYftf57WW0755507555eusmtrp1Z;
	Sat, 28 Oct 2023 21:15:41 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-85-653d79fec53a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.52.10549.DF97D356; Sat, 28
	Oct 2023 22:15:41 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211541eusmtip17d9fe4ecde792d45fb6ab59803d2f652~SYftVSUg60467404674eusmtip1K;
	Sat, 28 Oct 2023 21:15:41 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:41 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:40 +0100
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
Subject: [RFC PATCH 04/11] shmem: return number of pages beeing freed in
 shmem_free_swap
Thread-Topic: [RFC PATCH 04/11] shmem: return number of pages beeing freed
	in shmem_free_swap
Thread-Index: AQHaCePnyXBbRf49wEefJYEMRSVIWA==
Date: Sat, 28 Oct 2023 21:15:40 +0000
Message-ID: <20231028211518.3424020-5-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djPc7r/Km1TDU6/4LCYs34Nm8Xqu/1s
	Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
	Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUVw2Kak5mWWp
	Rfp2CVwZmze/Zir4K1xxbvFp1gbGh/xdjJwcEgImEjNnnmTtYuTiEBJYwShxbN8yJgjnC6PE
	h1mfoTKfGSUmXdjKBNNyZvNrqMRyRoknKy4iVC39coAZpEpI4AyjxNmz6hCJlYwSDybfAWtn
	E9CU2HdyEztIQkRgNqvE4cUdjCAJZoE6iTXPZrGA2MICURJLv58DmyQiEC8x48x+oGYOIFtP
	4tRCHZAwi4CqxPdTm8BKeAWsJe5sW8AKYnMK2Ejc/7adDcRmFJCVeLTyFzvEeHGJW0/mQ70g
	KLFo9h5mCFtM4t+uh2wQto7E2etPGCFsA4mtS/exQNhKEn86FkKdqSdxY+oUNghbW2LZwtdQ
	NwhKnJz5hAXkLwmBJi6J/ml/WCGaXSRWXTrNDmELS7w6vgXKlpE4PbmHZQKj9iwk981CsmMW
	kh2zkOxYwMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzC5nf53/MsOxuWvPuodYmTi
	YDzEKMHBrCTCy+xokyrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgm
	y8TBKdXA5LH5/BK/2XEvS0rDH+p7a7B1C6yv5pZ8Hrog9fpHIc7Xjh3THu8JEH6/46rF+0/P
	5mefTb6oK9z4ecvG5UkRh+4rPDjgsbi8KLD//7rop+uf/D6qcVXAY33SL0aBpEXfze4yzMp6
	wDntj7HrkZbeX9t2BXJs75mxSrZj26JTbnpNnfcuWpwOKZsifMdBc1Go2pKX9mwTW5cGRRTM
	KPx6WXLJh58OjOyf9Fd3KqSVrairSrgVuXgH+7RwsVUfY3Q3hjyP/fDw5PNtdrHL0tY0rC5x
	9F3XG/Lth9vc68G3E5wS5jVW/D8/V28Xa/vN7fl7BH4sX5fK6JGgKX94b9IG6bVvlnLo/qhM
	kda/yPs5eaMSS3FGoqEWc1FxIgCyhiiy3QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsVy+t/xu7p/K21TDV781bCYs34Nm8Xqu/1s
	Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
	Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
	GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZmze/Zir4K1xxbvFp
	1gbGh/xdjJwcEgImEmc2v2YFsYUEljJK7P4MFZeR2PjlKiuELSzx51oXWxcjF1DNR0aJrgP7
	mSEazjBKTDhiC5FYySixc/EkdpAEm4CmxL6Tm9hBEiICs1klDi/uYARJMAvUSax5NosFxBYW
	iJJY+v0c2CQRgXiJzn09QDUcQLaexKmFOiBhFgFVie+nNoGV8ApYS9zZtoAVpERIIFeivy0T
	JMwpYCNx/9t2NhCbUUBW4tHKX+wQm8Qlbj2ZzwTxgIDEkj3nmSFsUYmXj/9BPaYjcfb6E0YI
	20Bi69J9LBC2ksSfjoVQF+tJ3Jg6hQ3C1pZYtvA11DmCEidnPmGZwCg9C8m6WUhaZiFpmYWk
	ZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA1LTt2M/NOxjnvfqod4iRiYPxEKMEB7OS
	CC+zo02qEG9KYmVValF+fFFpTmrxIUZTYBBNZJYSTc4HJse8knhDMwNTQxMzSwNTSzNjJXFe
	z4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmmfIPt4terD4tu9SmM9LA3Cl3+rl9SbIbAh19csok
	tTdrHQteNC8mwjyl+P6tJ4k7qlqZDJr1NVZr9BpOTLjBZH7d5fsBuftTpyqfOb2shdHht5SG
	epxciZ3IgeYjy/arTw9P/KnP6X7P4siBiOmnTGbZJ+1Lf5qZsXyyQ0v7uf/rxW7yGvjcPJLJ
	fKPhVLJB6AkOF4udC38f+i2vXs8R63PiQUOSqO/G5hNfeC55v05f5/yIxelO0gQ7ncoivYe2
	QdOKOA6c5nj7m9FW57D0h8/XmfNub3GU5r+sVqZ49rt4lbXhhhMdbSvOqj3N330w1vbT/trU
	/+EGZfWKps5m5+wP2Kdt0K769dNqyx8lluKMREMt5qLiRAAYunQX1gMAAA==
X-CMS-MailID: 20231028211541eucas1p26663bd957cb449c7346b9dd00e33a20f
X-Msg-Generator: CA
X-RootMTR: 20231028211541eucas1p26663bd957cb449c7346b9dd00e33a20f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211541eucas1p26663bd957cb449c7346b9dd00e33a20f
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211541eucas1p26663bd957cb449c7346b9dd00e33a20f@eucas1p2.samsung.com>

Both shmem_free_swap callers expect the number of pages being freed. In
the large folios context, this needs to support larger values other than
0 (used as 1 page being freed) and -ENOENT (used as 0 pages being
freed). In preparation for large folios adoption, make shmem_free_swap
routine return the number of pages being freed. So, returning 0 in this
context, means 0 pages being freed.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a2ac425b97ea..9f4c9b9286e5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -827,18 +827,22 @@ static void shmem_delete_from_page_cache(struct folio=
 *folio, void *radswap)
 }
=20
 /*
- * Remove swap entry from page cache, free the swap and its page cache.
+ * Remove swap entry from page cache, free the swap and its page cache. Re=
turns
+ * the number of pages being freed. 0 means entry not found in XArray (0 p=
ages
+ * being freed).
  */
-static int shmem_free_swap(struct address_space *mapping,
+static long shmem_free_swap(struct address_space *mapping,
 			   pgoff_t index, void *radswap)
 {
 	void *old;
+	long swaps_freed =3D 1UL << xa_get_order(&mapping->i_pages, index);
=20
 	old =3D xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
 	if (old !=3D radswap)
-		return -ENOENT;
+		return 0;
 	free_swap_and_cache(radix_to_swp_entry(radswap));
-	return 0;
+
+	return swaps_freed;
 }
=20
 /*
@@ -990,7 +994,7 @@ static void shmem_undo_range(struct inode *inode, loff_=
t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed +=3D !shmem_free_swap(mapping,
+				nr_swaps_freed +=3D shmem_free_swap(mapping,
 							indices[i], folio);
 				continue;
 			}
@@ -1057,14 +1061,17 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, loff_t lend,
 			folio =3D fbatch.folios[i];
=20
 			if (xa_is_value(folio)) {
+				long swaps_freed;
+
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, indices[i], folio)) {
+				swaps_freed =3D shmem_free_swap(mapping, indices[i], folio);
+				if (!swaps_freed) {
 					/* Swap was replaced by page: retry */
 					index =3D indices[i];
 					break;
 				}
-				nr_swaps_freed++;
+				nr_swaps_freed +=3D swaps_freed;
 				continue;
 			}
=20
--=20
2.39.2

