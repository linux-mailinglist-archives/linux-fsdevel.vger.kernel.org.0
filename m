Return-Path: <linux-fsdevel+bounces-1490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32D37DA929
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECB91F2189D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 19:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3918658;
	Sat, 28 Oct 2023 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lZMpb5Xu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291B1862D
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 19:57:53 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D235FA9
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 12:57:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231028195750euoutp010e4fb345b0a0d8b1b654513a868e6d7b~SXbutMZjo0373303733euoutp01s
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 19:57:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231028195750euoutp010e4fb345b0a0d8b1b654513a868e6d7b~SXbutMZjo0373303733euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698523070;
	bh=5EC2GyHdoSWSoe3c/2nJMUdY1tku6rieIVa6/lIJ/BQ=;
	h=Date:From:Subject:To:CC:In-Reply-To:References:From;
	b=lZMpb5Xu1LfSdf9En4ySrO5wK9vL49zluGDTWl/gXjTjTpC5xJhxT11me4OG/OgWc
	 JnpCdHJSgRn1LqF5diwa1pjTK+9ISSJkIiRbM+nwfYKs45hylHgiaavQ9dtC7RlqJ4
	 8SwV+0NIhsaAt5BFIceb3nr7BOC9P5wdp3d/tJV0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028195749eucas1p2f7f599f0ed441262393c43b657e5f767~SXbt37FOY0723707237eucas1p27;
	Sat, 28 Oct 2023 19:57:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.54.37758.DB76D356; Sat, 28
	Oct 2023 20:57:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231028195748eucas1p22df6026b95e2e669b383f279b57b6b31~SXbtIY4Vn0724407244eucas1p2F;
	Sat, 28 Oct 2023 19:57:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231028195748eusmtrp1768e80f955ca47d612c11de232e7e364~SXbtH11Ob1398113981eusmtrp1U;
	Sat, 28 Oct 2023 19:57:48 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-77-653d67bd162b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.90.25043.CB76D356; Sat, 28
	Oct 2023 20:57:48 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231028195748eusmtip20218d1bd702bb549332f11cdce88a70a~SXbs8kt-G1450514505eusmtip2R;
	Sat, 28 Oct 2023 19:57:48 +0000 (GMT)
Received: from [192.168.1.64] (106.210.248.118) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 28 Oct 2023 20:57:46 +0100
Message-ID: <76c72990-cc1c-49ed-bbb6-145a518ad652@samsung.com>
Date: Sat, 28 Oct 2023 21:57:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page
 size
To: Matthew Wilcox <willy@infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <kernel@pankajraghav.com>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<djwong@kernel.org>, <mcgrof@kernel.org>, <da.gomez@samsung.com>,
	<gost.dev@samsung.com>, <david@fromorbit.com>
Content-Language: en-US
In-Reply-To: <ZTxA0TRYivu/vSsA@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.118]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH932e55577qZ6ulifCVHaaJVf2W4r5YY5zBFj1MRV33Wnn+5c
	lLGTziqUVLucdIm5Liwq4rrYknInYxqu8ytkdJgfyXCYrgfrv9fn/Xl/nr3f3z0MKTrFm8go
	M7djVaY8PYgWUpe6vt8Jb09dgGe36WlxS9dTJO4d8Babz9wgxD2DQ5TY2m6jxJafl/lix+FX
	SOz+Vk0vZKT2OpA214dKmxqKaGlbn5aW3jZLpENNU1bT8cLoFJyuzMGqWTFbhArTt0YyWyvY
	ea2+nKdFg3QxEjDARsLvu1ZeMRIyIrYeQX+XjuaGLwiumO8R3DCE4PTnQ8S/k7ImB/KwiDUh
	OFge99/UYymguMGC4LzuHN/j8mJjoMpoHFkwDMWGwLHKAE72BdvRAcrDE9hAeOas4nssNBsK
	e4tGL/3YVdB5/CbhkcezM+Bdy1zP10lWS8DzQifp8ZCsPzgHjKPZBCPZavILaE6fCbpWN5/j
	QGh9X01y+YPBPtDP43g32FucoyWBPSCAUw1FiFsshr6awr/sB67uFj7Hk+BW+UGK413wyuEm
	ueMCBKVXGmlPUmCjoKQnnfNIYH+pmeJkb3C89+XyeMORS3ryMAoxjHkJw5g6hjEVDGMq1CKq
	AfljjTojFavnZeIdEWp5hlqTmRqRnJXRhEZ+pFu/u4cvo3rXp4gORDCoAwFDBo33IiXRWOSV
	Is/Nw6qszSpNOlZ3oACGCvL3CkkJxCI2Vb4dp2GcjVX/tgQjmKglYq/H7VLIc+y5e0yF4VVh
	W5Kji19CneDrxixT6dfY+SvZzz4Ox457jVGV8k9vwnOefPywJP/+CRlPWWkNKVGk2Vandbnc
	uKykrj3S17hvU/da3WTZhUjb0mkMfnvk8QmJISzF/SzBJy0e71dIfgVP1QWEvzbFVNkbJPrk
	h87plt5tK42tOx3KTpX+R3D+IjLuQV7tqkfrZYujkgjZ/cTu7239rnEritYt601Iak44qxz+
	+FDoYx6sSJq1oW4O4zLvjbmqf2cTbnXkvnyzfM2LzpJaWZJ7ikZQkcdbWxj2ZOvR4ZNLeg5Y
	sn9prT+fShIrl0cTa8q8NdbZF+/2xVrY0iBKrZDPCSVVavkf9JyT9bcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7p70m1TDa62iFhsOXaP0eLyEz6L
	lauPMlmcefmZxWLP3pMsFrv+7GC3uDHhKaPF7x9z2Bw4PE4tkvDYvELLY9OqTjaP3Tcb2DzO
	rnT0+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1
	SN8uQS9j+Y/1zAUNnBX7V0xmbWB8ydbFyMkhIWAiMXHTDUYQW0hgKaPE6U4RiLiMxMYvV1kh
	bGGJP9e6gOq5gGo+Mkp8/nSCEcLZxShxec4esEm8AnYSM+bPZ+li5OBgEVCVmD1VGiIsKHFy
	5hMWEFtUQF7i/q0Z7CAlbAJaEo2d7CBhYQFfiT0T74CFRQQ0JN5sMQKZzizQwCTxsOMWM9Re
	Joklf3aCHcosIC5x68l8JhCbE+iBeU0tbBBxTYnW7b/ZIWx5ie1v5zBDPKAscerJA6hnaiU+
	/33GOIFRdBaS82YhGTsLyahZSEYtYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERjH2479
	3LKDceWrj3qHGJk4GA8xSnAwK4nwMjvapArxpiRWVqUW5ccXleakFh9iNAUG0URmKdHkfGAi
	ySuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYFqsdnbbdMMbtTU/
	byvKTl1h2rQ+e+uWJc39MYK6m3J3ztdvmety3+jt35ueNh2Tf5tsnOet4uP6XEeRpfj+1Qdh
	aTNOc2h82P93R2YUw79Tega3G07VPanVz78etSf4Y6Pmgujav+Yy0aezGTUEZK5U/z3R2JB1
	Nai3+0rh6vfpcw6/a7+7Q0nF7v7m/4dFn69xd9qlMftNm08Xr9a/D60pVg7Pdx48yHdNKDyh
	rcFHRdpRQibhmeznLJ5f2X/TjAOV/5R3rTT8X7paPGrpHsfuW9P/56zUXjm5/k56xq9T71ou
	FJ2ffKIrpX7t9A3xd787XTu6RKur3lXkLfsvRral5c1Vyzku/v1jrbth1z4lluKMREMt5qLi
	RADFsi59bAMAAA==
X-CMS-MailID: 20231028195748eucas1p22df6026b95e2e669b383f279b57b6b31
X-Msg-Generator: CA
X-RootMTR: 20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
	<CGME20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669@eucas1p2.samsung.com>
	<20231027051847.GA7885@lst.de>
	<1e7e9810-9b06-48c4-aec8-d4817cca9d17@samsung.com>
	<ZTuVVSD1FnQ7qPG5@casper.infradead.org>
	<3d65652f-04c7-4240-9969-ba2d3869dbbf@samsung.com>
	<ZTxA0TRYivu/vSsA@casper.infradead.org>

>> Thanks for the pointer. I made a rough version of how it might
>> look like if I use that API:
> 
> useful thing to do.  i think this shows we need a new folio api wrapping
> it.  happy to do that when i'm back, or you can have a crack at it.
> 
A folio wrapping for mm_get_huge_zero_page()?

I tried to look for all the callers of mm_get_huge_zero_page() and I don't
see them doing the folio <-> page dance. Of course, if we end up using
mm_get_huge_zero_page() in iomap, then getting making a folio API might be
worth it!

> your point about it possibly failing is correct.  so i think we need an
> api which definitely returns a folio, but it might be of arbitrary
> order.
> 
That will be really nice, given that many parts of the kernel might
use that API to get away with iterating with ZERO_PAGE().

>> +
>>         iomap_dio_submit_bio(iter, dio, bio, pos);
> 
> then this can look something like:
> 
> 	while (len) {
> 		size_t size = min(len, folio_size(folio));
> 
> 		__bio_add_folio(bio, folio, size, 0);
> 		len -= size;
> 	}
>

Ah, this looks good!

>> PS: Enjoy your holidays :)
> 
> cheers ;-)

