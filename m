Return-Path: <linux-fsdevel+bounces-1326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1B7D9096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A751C21073
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1811735;
	Fri, 27 Oct 2023 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NfmdLziJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB71171E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:03:24 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D81BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 01:03:22 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231027080318euoutp01082c6461b64e070157ce5a03d7d10904~R6ClFnvjF2668326683euoutp01k
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:03:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231027080318euoutp01082c6461b64e070157ce5a03d7d10904~R6ClFnvjF2668326683euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698393798;
	bh=rLBM49fPnnkhTpGrCYa4ODHPS3Vstui8y7gu0ZH/pzc=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=NfmdLziJ6nV/4bCuilyYvw/XBhtD1Q/b7QEkbMqdWdjy8/CPrfN4R5ho6QVHy2oo8
	 PPx1wCCmu9aQX9DXzVQTNY5wW8pTSPGVMjlBzQyj4LhULNWMhSUExffE+JIXzaFmsc
	 vCZjXDqRzMgq4orGIg7wBskUtJGDyFcEG5/nwgPQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231027080318eucas1p1c415a2ded01a158bb723589c92ad19b3~R6Ckym9Uy0196401964eucas1p10;
	Fri, 27 Oct 2023 08:03:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 0B.B8.37758.6CE6B356; Fri, 27
	Oct 2023 09:03:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231027080317eucas1p2b582202e5e56cb78fbaaa79022977995~R6CkYdZqe3072830728eucas1p2-;
	Fri, 27 Oct 2023 08:03:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231027080317eusmtrp2af8cb688393866b29c77f1bb64b6b507~R6CkXn_iN2544125441eusmtrp25;
	Fri, 27 Oct 2023 08:03:17 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-b8-653b6ec673fd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D6.AC.10549.5CE6B356; Fri, 27
	Oct 2023 09:03:17 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231027080317eusmtip2728a6edf2da46567b4ed06bb821726c8~R6CkN0vc52284722847eusmtip2c;
	Fri, 27 Oct 2023 08:03:17 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 27 Oct 2023 09:03:16 +0100
Message-ID: <1e7e9810-9b06-48c4-aec8-d4817cca9d17@samsung.com>
Date: Fri, 27 Oct 2023 10:03:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page
 size
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <kernel@pankajraghav.com>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<willy@infradead.org>, <djwong@kernel.org>, <mcgrof@kernel.org>,
	<da.gomez@samsung.com>, <gost.dev@samsung.com>, <david@fromorbit.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20231027051847.GA7885@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+845np2tZqep7TUraSmU0coudMKI7i0yKrtR2GW2kw51ypaZ
	RTFDBe2+8rbUyspcRYZpzqykkTNtWlHSJpZBaiWZyFJny8rtrPC/53vf5/e97/PxUbioxGsS
	pVQdZNUqeZyEFBAPzEMvZ5tVYezcExleTIX5A2LedHgzhtt1GGP5aieYR48bCObhLyOPsZ7r
	RIzTUUAuo2SNxSC7XxoiK7+VScpqbFpS1mRYLrOXT91E7hIsUbBxykOses7SfYIYx91GLHGQ
	d7iySYu0yEBmIT4F9AKo+tHk1iK6FIElb1cWEozoHwg+61p43MGOQOfM5f0j3rzTE1zjJoLc
	01/w/64zBQ4PUo3APDCMXIiQXgo5pkLCpQk6GGwNLSRXnwAN+R3uuh8dCO2tee4RPvRGeFb4
	HHNpnBZDa8dlt/al18OnvnrkGoDTFgTpg29HAIoi6RBIzXSzfHoWXGzO8rAzIb3KyeN0IFT1
	FOBchGmgs/V6cfoYNFa0Yq47gT7Jh4/DdoxrrIL+70Uekw9011d48k+GP9WXPZ6j0Gl14hyc
	huBsdRnpWgjoMDhjieM8yyHjrIHgyt5g7ZnA7eMNuge5+DkUrB/1FPpRkfWjIuhHRbiCiFtI
	zCZp4qNZzXwVmyzVyOM1Sapo6f6E+HI08pVe/K7vN6LS7j6pCWEUMiGgcImvcGc4w4qECnnK
	EVadsFedFMdqTCiAIiRiYbAikBXR0fKDbCzLJrLqf12M4k/SYuhUW+v2ddV2f005ORx+r+vu
	5s19headAf4WQq/44C02zQsqKlgf8OTR64VjNu5Pr72Rvc845GtQKz8KpFERXjXzf/bS0Ldo
	+sBTVXiR1djrYxSUBVyNWpGK7QjT5fgl5m8bePLMb8NepUOC2+ZmOy4OiyrNycWbdsiGOmfU
	FtetDXofwy8ZfLk4p6imaqsWL/s2ZoF0S9v4UHHp1ninfqxQoTbWznN8bXmV0hA1bqVy9fE1
	xj2R7bJrPeMdq2zXJ1bWJcqzFdauyAt1sc0lSUcHI7A8U+X1yEttAxkhd86rnufNyWetqa93
	p8S2N2f+PtAxvfbOlLQVr+BLd1ro1WRKQmhi5KEhuFoj/wsgetSDuQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xe7pH86xTDZqb1Sy2HLvHaHH5CZ/F
	ytVHmSzOvPzMYrFn70kWi11/drBb3JjwlNHi9485bA4cHqcWSXhsXqHlsWlVJ5vH7psNbB5n
	Vzp6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
	pG+XoJfxY90ppoLv7BVbzzYwNjCuZOti5OSQEDCRuHx9FksXIxeHkMBSRoltm38wQiRkJDZ+
	ucoKYQtL/LnWxQZR9JFRovPLLEYIZyejRN+x0+wgVbwCdhLTDs1lAbFZBFQlbp68ygYRF5Q4
	OfMJWFxUQF7i/q0ZYPXCAr4SeybeAbOZBcQlbj2ZzwRiiwh4Szz+eBxsAbPAGUaJ1u9X2CG2
	bWaUuDp7P3MXIwcHm4CWRGMnWDOngLbElHNdTBCDNCVat/+GGiovsf3tHGaIFxQlJt18D/VO
	rcTnv88YJzCKzkJy3ywkd8xCMmoWklELGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbz
	tmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8kT4WqUK8KYmVValF+fFFpTmpxYcYTYGBNJFZSjQ5
	H5hO8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamNT7kuce2J1m
	cq0wKcO0921V0JRrySXOtkdX7k+7uNvz4f3whjPqvZrGN43ONvxc/Ur6n2bOQUdfxf1LX095
	lKK6YH+E/dw6qxOi4cdNnjsFOpc/WSxnlrzbIebQxgCbab4tLSfe6Kz/fqdZxEWiYUX6yr+L
	8v/bs7JKL5y1WyF/trbGqXWi8htq5FtNzkXMjQmoS9Re+ejZ1Pi691NlTh2y+r/7YVOC9IW+
	uqg+odmGgtUN/MwXP912Pfmj6pQG++OeTVWB/Snv7Tdd3/ZxSkXXh8ID0n26//LfmMxinPng
	vpiUXVHTC6ninvC7l6/ZByzmfCu81WSXfM69be8Z/t9X8TlzS6ygMveJ0nNNISWW4oxEQy3m
	ouJEAHC+RQRvAwAA
X-CMS-MailID: 20231027080317eucas1p2b582202e5e56cb78fbaaa79022977995
X-Msg-Generator: CA
X-RootMTR: 20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
	<CGME20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669@eucas1p2.samsung.com>
	<20231027051847.GA7885@lst.de>

On 27/10/2023 07:18, Christoph Hellwig wrote:
>>  
>> -	__bio_add_page(bio, page, len, 0);
>> +	while (len) {
>> +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
>> +
>> +		__bio_add_page(bio, page, io_len, 0);
>> +		len -= io_len;
>> +	}
> 
> Maybe out of self-interest, but shouldn't we replace ZERO_PAGE with a
> sufficiently larger ZERO_FOLIO?  Right now I have a case where I have
> to have a zero padding of up to MAX_PAGECACHE_ORDER minus block size,
> so having a MAX_PAGECACHE_ORDER folio would have been really helpful
> for me, but I suspect there are many other such cases as well.

I think that would definitely be useful.

I also noticed this pattern in fscrypt_zeroout_range_inline_crypt().
Probably there are more places which could use a ZERO_FOLIO directly
instead of iterating with ZERO_PAGE.

Chinner also had a similar comment. It would be nice if we can reserve
a zero huge page that is the size of MAX_PAGECACHE_ORDER and add it as
one folio to the bio.

