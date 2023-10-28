Return-Path: <linux-fsdevel+bounces-1485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB07DA828
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 895F8B21108
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54E17726;
	Sat, 28 Oct 2023 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zocf1mPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D021548D
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 16:58:05 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC6D9
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 09:58:02 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231028165759euoutp020da9fb507d00eeb5aff7a47a5b37c13a~SU_tNUpaw1850618506euoutp02Y
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 16:57:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231028165759euoutp020da9fb507d00eeb5aff7a47a5b37c13a~SU_tNUpaw1850618506euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698512279;
	bh=G263tCHuDjJWOrwK6rEkPLZvqg9BXIQH5T/9FBnMH6E=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=Zocf1mPDBLhG3gdgDail1+1Z52J6+grvuiHKQqiGOjlV/BmTuF8z2HF43j/RfVGSk
	 k5KX0z4vGR9RhuhLuCkytRXwDmPYSR5veAC1av/wO4rMkv20FHUruEB84+YdXYnXW+
	 URhGy3kxHbeQTku6e9id8c1fMTDxtdXEdsCAKeBU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028165759eucas1p28f9e44a256911712dfde00b4fc25782e~SU_s5Pv423067730677eucas1p2a;
	Sat, 28 Oct 2023 16:57:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 05.77.42423.79D3D356; Sat, 28
	Oct 2023 17:57:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231028165758eucas1p2348332c8a754013fcb3e378c7ac8e5a7~SU_sDjzy23067330673eucas1p2S;
	Sat, 28 Oct 2023 16:57:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231028165758eusmtrp1516a860d449c05fefcb3a461e4b4d671~SU_sDAKzY1424814248eusmtrp1m;
	Sat, 28 Oct 2023 16:57:58 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-4f-653d3d97707c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 88.5F.25043.69D3D356; Sat, 28
	Oct 2023 17:57:58 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231028165758eusmtip2883361337e9b28a56538d2314cb482f7~SU_r4vCDv0609306093eusmtip2h;
	Sat, 28 Oct 2023 16:57:58 +0000 (GMT)
Received: from [192.168.1.64] (106.210.248.118) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 28 Oct 2023 17:57:56 +0100
Message-ID: <c7d07c6d-97a7-4ad1-bb74-d9a1a67613e8@samsung.com>
Date: Sat, 28 Oct 2023 18:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page
 size
To: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <kernel@pankajraghav.com>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<djwong@kernel.org>, <mcgrof@kernel.org>, <da.gomez@samsung.com>,
	<gost.dev@samsung.com>, <david@fromorbit.com>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <3ce86ed7-2514-4d60-99b0-5029bcfb2126@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.118]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSF82am7RRTMhS0N6ISUaJiBIwaBwUjUXTwh0tijMG1gQlFS9EO
	dY0GxY1NBdRqbVmqIqBiLBTZJAa1lIK44FJQQU0xkUis4gIURcqo4d937zv33XNeHolLSwXj
	yXhVEqtWyZX+Qg+iwtLfMksbHs6G/LwmosstHYhudXjStcZsjC6+9gCjmz/2EnTtnUaCrh6s
	FNH2012IdvXphYvFjM0ITFlRIGMqSRUyNW3JQuZhcQRT1rSf6TVNWi2K9giLZZXxu1h18KKt
	Hgq91kbsuEDu+fCyQ5CM3gnTkJgEai6Y896gNORBSqkiBMV5gzhffENQdcKC8UUvAkfRDfRv
	xGht/au6iqBn6Ifov8pg/DBysZSqRlDXPc/NEmoRnHltEbiZoALAef0izve9oPGCg3DzWMoP
	OtvPi9zsTa2C+wYr5mYfioGTz62EewFOJWPw7kT7yDBOyaDdkTcsIkkhFQiHUkVuFFMLoW9A
	zCtmwNHbLhHPfpBi5tcCNQVsjrcCng+Arbx9JCVQOWLI1xf+FS2FdL0N49kbuhvKRTxPgKac
	DILn/dBld+H88BEEp6puCt0mYNjEyWYlr4mAY6eKCb7tCfYeL96PJ2RXaPHTKEA36iV0o4Lp
	RkXQjYqQj4gSJGM1XEIcy81WsbuDOHkCp1HFBcUkJpjQ8Jdq+t3wtRIZur8E1SOMRPUISNzf
	R4JHhLFSSax87z5WnbhFrVGyXD3yJQl/mSQg1o+VUnHyJHY7y+5g1f9OMVI8PhkLrnqjyRcM
	RU7t2RirvTy5LWvw2aaulNqr5SuWV7qyh3Rer0rTJK8vL7sSxTxJTNc7OuQHvgaXFSy4f8sU
	+R5xS1eKjXP7EgxRiswW+B72aUnD5ryqgpiZbxfkmr+nfp5mqGk7F2les7UCnCoTcfjXgO9a
	ld6+L8uRvwEfg5tyb2Zsz9SmK9XWiRmMvf9Rn0wpu9vQuVMdINsYXD3vY81BONg6JzQ3SXEp
	J9o35Iqm2TX9KHHeEue5OIu7uGl+jPWxOSe0jtxW8ir0hXNWZtQaV+DTs52TQhrp6HtbuhRt
	tqTj48KcNPSzPYcIjakxWlPEpKwvCH+xrmxiS7OzcMCf4BTy2YG4mpP/AWsG8DbBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7rTbG1TDVo381lsOXaP0eLyEz6L
	PYsmMVmsXH2UyeLMy88sFnv2nmSx2PVnB7vFjQlPGS1+/5jD5sDpcWqRhMfmFVoem1Z1snns
	vtnA5nF2paPH5tPVHp83yQWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
	6dvZpKTmZJalFunbJehlzJl+iqVgJkfFs+v3WBsYH7J1MXJySAiYSCw6cZm5i5GLQ0hgKaPE
	rlUnoBIyEhu/XGWFsIUl/lzrYoMo+sgocfrYbihnF6PEqRlfwKp4Bewkptw5BmazCKhKfFgz
	mxkiLihxcuYTFhBbVEBe4v6tGewgtrCAr8SeiXfAbBEBD4m+qydYQIYyCzQwSTzsuAV10w8m
	ibdzV4JVMQuIS9x6Mp+pi5GDg01AS6Kxkx3E5BSwlvjxixOiQlOidftvqGp5ieatEDdICChL
	nHryAOqbWonPf58xTmAUnYXkvFlIFsxCMmoWklELGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn
	525iBEb3tmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8zI42qUK8KYmVValF+fFFpTmpxYcYTYFh
	NJFZSjQ5H5he8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamLJO
	szrEljYbqRTZuThmxxq6b/AteNh9PGqGSN+qmfJBJo9mRW3eevaJ0sxpP0XqFPku85Se9bsg
	znbYPdN10UEzEwexgvQXZWdaTh/fd9l3pUV9/OHiMOurAqlF96x+TT+ySG59p4dfVjDX3975
	bo25a9eWtD5jZXf97LiIScPc9fzd9WE3CkJCuUv5Mp/3v9E1VAwvyTsikrcual6U/e6shbNX
	nZr1PTj+OR97nzG/SOHWx5LlZ4497ulgzNlY68fZkp+6SPrJ359JxR48TnLCt6IPaRYoP74x
	LdunQ0z38T2XU5vPS5/ouv/gytm70qefrEs1vefYZL/q+qGV0TPkoj23P+LUu2NXee2yEktx
	RqKhFnNRcSIAnmFIrHcDAAA=
X-CMS-MailID: 20231028165758eucas1p2348332c8a754013fcb3e378c7ac8e5a7
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
	<3ce86ed7-2514-4d60-99b0-5029bcfb2126@suse.de>

>> -       bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>> +       if (len > PAGE_SIZE) {
>> +               page = mm_get_huge_zero_page(current->mm);
>> +               if (likely(page))
>> +                       huge_page = true;
>> +       }
>> +
>> +       if (!huge_page)
>> +               page = ZERO_PAGE(0);
>> +
>> +       fallback = ((len > PAGE_SIZE) && !huge_page);
>> +
> That is pointless.
> Bios can handle pages larger than PAGE_SIZE.

Yes, I know BIOs can handle large pages. But the point here is if we fail
to allocate a huge zero page that can cover the complete large FSB ( > page size),
then we need to use the statically allocated ZERO_PAGE (see the original patch)
for multiple offsets covering the range.

Unless we have an API that can return a zero folio with arbitrary order(see also the
reply from Willy), we can't use a bio with one vec for LBS support.

--
Pankaj

