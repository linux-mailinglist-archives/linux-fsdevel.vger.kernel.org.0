Return-Path: <linux-fsdevel+bounces-1324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B47D9062
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E89B213F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77C3101CB;
	Fri, 27 Oct 2023 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OO0vl7UZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA814D312
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 07:53:28 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7831AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 00:53:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231027075322euoutp0260a30c5dcaca4bd3a2a3b9c387ef36d8~R555xwxjc2941629416euoutp02N
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 07:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231027075322euoutp0260a30c5dcaca4bd3a2a3b9c387ef36d8~R555xwxjc2941629416euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698393202;
	bh=PxERn5YTThx5iF3PbxacxOMVyXeEpWzKixGsUs4v23M=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=OO0vl7UZn1WwoP0K3/bSJ9tHKFQOdKnjRcnOzZiU/GjnXW59x3nIhCpAAOkdmusJt
	 g34SSG8qGwpXYrSG6tBdVn1kTIXvsCwYVOgKCSLHsdEMa87Hx6ZnyfnnRs61NpE01x
	 tBmFPC7lhTUtXgPN3nh9+kHwrXSyBJbnbrVdG8lo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231027075321eucas1p13570248a0a6cd38d2edf8a1dda482e76~R555dQvlz0418704187eucas1p1e;
	Fri, 27 Oct 2023 07:53:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.92.42423.17C6B356; Fri, 27
	Oct 2023 08:53:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231027075321eucas1p2b46640bdcbaaab0436f5c2c1ebaa2911~R555CiDom2548125481eucas1p2Z;
	Fri, 27 Oct 2023 07:53:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231027075321eusmtrp1f741c38e82f5b4c828647e7908841b40~R555Bg4GB1938619386eusmtrp1s;
	Fri, 27 Oct 2023 07:53:21 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-2e-653b6c719197
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.AA.10549.17C6B356; Fri, 27
	Oct 2023 08:53:21 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231027075321eusmtip17c64741ae6a95bb33c3dde69d4aef601~R5541MSio1368813688eusmtip1o;
	Fri, 27 Oct 2023 07:53:21 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 27 Oct 2023 08:53:20 +0100
Message-ID: <7ad225ac-721f-4c99-8d99-c90992609267@samsung.com>
Date: Fri, 27 Oct 2023 09:53:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page
 size
To: Dave Chinner <david@fromorbit.com>, Pankaj Raghav
	<kernel@pankajraghav.com>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<willy@infradead.org>, <djwong@kernel.org>, <mcgrof@kernel.org>,
	<hch@lst.de>, <da.gomez@samsung.com>, <gost.dev@samsung.com>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZTrjv11yeQPaC6hO@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87qFOdapBk82G1psOXaP0eLyEz6L
	lauPMlmcefmZxWLP3pMsFrv+7GC3uDHhKaPF7x9z2Bw4PE4tkvDYvELLY9OqTjaP3Tcb2DzO
	rnT0+LxJLoAtissmJTUnsyy1SN8ugStj2ZZNLAUn+CpmLX/O1MC4nbuLkZNDQsBE4sTZlYxd
	jFwcQgIrGCVOHfjLAuF8YZRYumQblPOZUeLs3rssMC2LN31jgkgsZ5T4s+4PK1zV3w1tbBDO
	TkaJeytPsYK08ArYSaw48YkZxGYRUJWYO72fGSIuKHFy5hOwsaIC8hL3b81gB7GFBfwljsw9
	wQRiiwgESjy5fwTsQmaBw4wSc57fBytiFhCXuPVkPlARBwebgJZEYydYmFPAWGLZpttQJZoS
	rdt/Q9nyEtvfzmGGeEFRYtLN96wQdq3EqS23wN6REOjnlDj0/zXUny4SN/qboWxhiVfHt7BD
	2DISpyf3QMWrJZ7e+M0M0dzCKNG/cz0byEESAtYSfWdyIExHia4tlhAmn8SNt4IQ5/BJTNo2
	nXkCo+ospJCYheSxWUg+mIXkgwWMLKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECk9Lp
	f8c/7WCc++qj3iFGJg7GQ4wSHMxKIryRPhapQrwpiZVVqUX58UWlOanFhxilOViUxHlVU+RT
	hQTSE0tSs1NTC1KLYLJMHJxSDUxc/4OYP1gZ3vnGniffyySR/V7b7edzZ440X+OHh8vN5Jb7
	Kkx5JtCb/OqwwLs7Wx/57WH7JrrQmV+czVJWafEW8W1KH97p/9G9WlGiXxX5gfUyX9Mmafuu
	y+sStGpl3hQJNj2az3buy2WGbZ3crzRuhWxcanym4f5J8fwqZZ7XjGvW88qLM2zecfFo/ez3
	b1KMeP7NunL7WfRkza+OZjMt9HfdZuRYL3jc8onYb4XWhV/51wuaF0pvqrx+e+vhB38k8/W7
	n63deNR+9oRtqd976iwjtoadzVV8zfvzscRzng6dB09Xnws8FxkqIf3/wopo7hXnHTYfvc+1
	9szzm2vZSxv4uhSCo1vlegW3JRgpsRRnJBpqMRcVJwIADon9h7kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7qFOdapBv3LBS22HLvHaHH5CZ/F
	ytVHmSzOvPzMYrFn70kWi11/drBb3JjwlNHi9485bA4cHqcWSXhsXqHlsWlVJ5vH7psNbB5n
	Vzp6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
	pG+XoJexbMsmloITfBWzlj9namDczt3FyMkhIWAisXjTN6YuRi4OIYGljBLn/z1ghUjISGz8
	chXKFpb4c62LDaLoI6NE759rLBDOTkaJJ88/M4FU8QrYSaw48YkZxGYRUJWYO72fGSIuKHFy
	5hMWEFtUQF7i/q0Z7CC2sICvxJ6Jd8BsEYFAiSf3jzCCDGUWOMwoMef5fXaIDbsZJQ5PWMMG
	UsUsIC5x68l8oG0cHGwCWhKNnWDNnALGEss23WaHKNGUaN3+G8qWl9j+dg4zxAuKEpNuvod6
	p1bi899njBMYRWchuW8Wkg2zkIyahWTUAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHR
	vO3Yz807GOe9+qh3iJGJg/EQowQHs5IIb6SPRaoQb0piZVVqUX58UWlOavEhRlNgIE1klhJN
	zgemk7ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqaSY2JxfWof
	ZqoY//w1nUVfmHf6jelP7dbMyzd9EfBWclG/7Pfu2c8euoQcZ7oSVVCwtim3YbWnw3Uhw3ll
	Zfed9naGx6TbMR3ZsPvj4Q/aPSa9+/mSV2W9m3+HIUBzS9IE0xOfgnjtxAuvHLF3c1SwWLyp
	03AbYz7/C+k9PduS/qf7TdPv3nM0/9en35K/QlL29ms/eRJs22Mf4DA5m/sZm9+ES4m6gfMr
	3NfVLY7b//cM/9n1nqdOcP2yTH0mGrFSTPzC56mT2V5NmHsooW7u5MwZl1aV1L3zMn+83PmT
	0lSd/zd/rJr30lHYc0kr7wQ2FzEvTZWcpHmiz/Yt13MyaZ0en3x/zdvbh9aa7MlUYinOSDTU
	Yi4qTgQAacO6zG8DAAA=
X-CMS-MailID: 20231027075321eucas1p2b46640bdcbaaab0436f5c2c1ebaa2911
X-Msg-Generator: CA
X-RootMTR: 20231026221014eucas1p1b3513d4b9e978232491c3350bc868974
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231026221014eucas1p1b3513d4b9e978232491c3350bc868974
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
	<CGME20231026221014eucas1p1b3513d4b9e978232491c3350bc868974@eucas1p1.samsung.com>
	<ZTrjv11yeQPaC6hO@dread.disaster.area>

>> -	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>> +	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
> 
> How can that happen here? Max fsb size will be 64kB for the
> foreseeable future, the bio can hold 256 pages so it will have a
> minimum size capability of 1MB.
> 

I just added it as a pathological check. This will not trigger
anytime in the near future.

> FWIW, as a general observation, I think this is the wrong place to
> be checking that a filesystem block is larger than can be fit in a
> single bio. There's going to be problems all over the place if we
> can't do fsb sized IO in a single bio. i.e. I think this sort of
> validation should be performed during filesystem mount, not
> sporadically checked with WARN_ON() checks in random places in the
> IO path...
> 

I agree that it should be a check at a higher level.

As iomap can be used by any filesystem, the check on FSB limitation
should be a part iomap right? I don't see any explicit document/comment
that states the iomap limitations on FSB, etc.

>>  
>> -	__bio_add_page(bio, page, len, 0);
>> +	while (len) {
>> +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
>> +
>> +		__bio_add_page(bio, page, io_len, 0);
>> +		len -= io_len;
>> +	}
>>  	iomap_dio_submit_bio(iter, dio, bio, pos);
> 
> /me wonders if we should have a set of ZERO_FOLIO()s that contain a
> folio of each possible size. Then we just pull the ZERO_FOLIO of the
> correct size and use __bio_add_folio(). i.e. no need for
> looping over the bio to repeatedly add the ZERO_PAGE, etc, and the
> code is then identical for all cases of page size vs FSB size.
> 

I was exactly looking for ZERO_FOLIOs. Instead of having a ZERO_PAGE, can
we reserve a ZERO_HUGE_PAGE so that it can be used directly by
bio_add_folio_nofail()?


