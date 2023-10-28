Return-Path: <linux-fsdevel+bounces-1491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E467DA979
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA2AB21167
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B986F182C1;
	Sat, 28 Oct 2023 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p25vRFik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98517990
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:45 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38445F1
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211541euoutp012513bd0de6ed35275d6ce5b658bd87f7~SYftpWsMZ2659126591euoutp01D
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231028211541euoutp012513bd0de6ed35275d6ce5b658bd87f7~SYftpWsMZ2659126591euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527741;
	bh=KNdASYDMYBghyPawUeQa4sXu1VB/4Vbh5nAWx6WaBVc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=p25vRFikG8/u08B+ePf6VvgHwV8NxkrJZH/Gsn8m+A4lT/HMsDTVuZiosdX3Q/nYP
	 4pTukVv2uwz4EsY7oichDyeSqZ7xpFNFT2zF1JcaGs7iKcTK7FxWMMW++fF5boQcA6
	 LYREJzDKHJlJFelI5RdkTvhHCEVS+bsyGNhQaI6M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211541eucas1p2956f217a1965e3854c430386af01e412~SYfs9xZLz1224812248eucas1p24;
	Sat, 28 Oct 2023 21:15:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.81.42423.DF97D356; Sat, 28
	Oct 2023 22:15:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad~SYfslkcX60616106161eucas1p1P;
	Sat, 28 Oct 2023 21:15:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231028211540eusmtrp2885c51cf5903a19a29a6bef124f4dabc~SYfslCIHP1141411414eusmtrp2a;
	Sat, 28 Oct 2023 21:15:40 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-be-653d79fdc682
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.F0.25043.CF97D356; Sat, 28
	Oct 2023 22:15:40 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231028211540eusmtip266e8e32a92786e265d14e5903bc6464c~SYfsYR64B1182011820eusmtip2o;
	Sat, 28 Oct 2023 21:15:40 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:40 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:39 +0100
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
Subject: [RFC PATCH 03/11] shmem: drop BLOCKS_PER_PAGE macro
Thread-Topic: [RFC PATCH 03/11] shmem: drop BLOCKS_PER_PAGE macro
Thread-Index: AQHaCePme5B6ldUfmUi6e3JGjkM9rA==
Date: Sat, 28 Oct 2023 21:15:39 +0000
Message-ID: <20231028211518.3424020-4-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87p/K21TDU7tYLeYs34Nm8Xqu/1s
	Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/gEpvTHjKaLHs63t2i90bF7FZ/P4x
	h82B12N2w0UWjwWbSj02r9DyuHy21GPTqk42j02fJrF7nJjxm8Xj8ya5AI4oLpuU1JzMstQi
	fbsErowT+zkLfrJWnJw+kamB8RtLFyMnh4SAicSLF4/YQWwhgRWMEvuOpXYxcgHZXxglrh6Z
	xwbhfGaUWPPoGzNMR8uvfVCJ5YwSNxa1s8JVNRyYwQ7hnGGUuPLxKNTglYwS8x5EgNhsApoS
	+05uAisSEZjNKnF4cQcjSIJZoE5izbNZQFdxcAgL2Egc3GYGEhYRcJR4en4RO4StJ/H15A8m
	EJtFQFXi99yVTCDlvALWEpPXSoCEOYE673/bzgZiMwrISjxa+YsdYrq4xK0n85kgPhCUWDR7
	D9Q3YhL/dj1kg7B1JM5ef8IIYRtIbF26DxpGShJ/OhZCXakncWPqFDYIW1ti2cLXYHN4gWae
	nPmEBeQtCYF/nBINa+9CNbtIXFn1BMoWlnh1fAs7hC0j8X/nfKYJjNqzkNw3C8mOWUh2zEKy
	YwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAtHb63/FPOxjnvvqod4iRiYPxEKME
	B7OSCC+zo02qEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQimCwTB6dU
	A5P9jDmlq4+837ha/eB1m4PF6iKbuHkWFNexrXP3Z8wtsTeSKZ+/zU5SSqfFdu7qRvdwR7M0
	M6OYuxlPlOVe+T19+2QhR07OKw5urZUKNktXp/y96zb1sljVDHXZ52aX3wizGZTVn/2zZMbR
	e2fnLtwzUXPZg8XCPF5frqlPYdiQ+5qb7cKtTRMn6zR/+pu35NjfiJvnxISentZ/p65gueiY
	V5Gowr8Wpx52/h6eMNO7jMZm9wOmTDI+dLt+9t2X5+66zHti6VUz74L6fab5dhmdZ8793H8/
	e2GtQsjWHGmZ2x1VIZHfvi6ZFPT61eZoO1v5nlndRyZuMrmtKSRYO0V73e6vGXZbJgtXHN1Z
	oZauxFKckWioxVxUnAgApQsA0toDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsVy+t/xe7p/Km1TDR5sU7eYs34Nm8Xqu/1s
	Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
	Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
	GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZJ/ZzFvxkrTg5fSJT
	A+M3li5GTg4JAROJll/72LoYuTiEBJYySry/NY8dIiEjsfHLVVYIW1jiz7UuqKKPjBJLWx6x
	QjhnGCUOX2xihnBWMkqcmrYJrJ1NQFNi30kQm4tDRGA2q8ThxR2MIAlmgTqJNc9mAS3n4BAW
	sJE4uM0MJCwi4Cjx9PwidghbT+LryR9MIDaLgKrE77krmUDKeQWsJSavlQAxhQRyJfrbMkEq
	OIGG3P+2nQ3EZhSQlXi08hc7xCJxiVtP5jNBPCAgsWTPeWYIW1Ti5eN/UI/pSJy9/oQRwjaQ
	2Lp0HzRUlCT+dCyEOlhP4sbUKWwQtrbEsoWvwebwCghKnJz5hGUCo/QsJOtmIWmZhaRlFpKW
	BYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJT07ZjP7fsYFz56qPeIUYmDsZDjBIczEoi
	vMyONqlCvCmJlVWpRfnxRaU5qcWHGE2BITSRWUo0OR+YHPNK4g3NDEwNTcwsDUwtzYyVxHk9
	CzoShQTSE0tSs1NTC1KLYPqYODilGpjanh3aXWR/1vyIa8aCFQWvODaEeT03c1qTtiH4vPMW
	rjtHjl1Q/ldeGmXc+3enwCFH38jZUfM1BFJvejecLP7woI+FWZqjMCH1S2PZNlZpL7c+jud+
	JpW+vdveB4S7Np4tauIp40kpZJocnR/Gd8laT2itR6Ob/UEtgcveSV2LTmd9MM4NMOJ2DwnN
	CZ6dPVFXbMEp9RmvhGKCPBu6/0x0Dc80TdZPbXiqGbJ7vc5bG5/nMfr6+7vfZzYs9xIwFAxQ
	nbFtc85Mw6+Hbl4W5G8oXPxrfvDhreF1/oFnfod13DmZuW+l5Ld57JW6OnOOvPvWppnGlhvA
	HRHjuCWzvHsOR/6/1p1RUSnmO3cosRRnJBpqMRcVJwIAW8mX/9YDAAA=
X-CMS-MailID: 20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad
X-Msg-Generator: CA
X-RootMTR: 20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad@eucas1p1.samsung.com>

The commit [1] replaced all BLOCKS_PER_PAGE in favor of the
generic PAGE_SECTORS but definition was not removed. Drop it
as unused macro.

[1] e09764cff44b5 ("shmem: quota support").

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0d1ce70bce38..a2ac425b97ea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -84,7 +84,6 @@ static struct vfsmount *shm_mnt __ro_after_init;
=20
 #include "internal.h"
=20
-#define BLOCKS_PER_PAGE  (PAGE_SIZE/512)
 #define VM_ACCT(size)    (PAGE_ALIGN(size) >> PAGE_SHIFT)
=20
 /* Pretend that each entry is of this size in directory's i_size */
--=20
2.39.2

