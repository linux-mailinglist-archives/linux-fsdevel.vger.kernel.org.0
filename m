Return-Path: <linux-fsdevel+bounces-3187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EECA7F0CBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 08:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9255280F77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA66ABB;
	Mon, 20 Nov 2023 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FhAWekAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA049B4
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 23:20:05 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231120072001epoutp01817f7e09c5d39753b33f387c96f37608~ZQ7oqepuP1970019700epoutp01n
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 07:20:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231120072001epoutp01817f7e09c5d39753b33f387c96f37608~ZQ7oqepuP1970019700epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1700464801;
	bh=08OznTbE1xy9VWqmAZqJPEOINmHmLDLarSBeKfOODqc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FhAWekAeHPERF4vrVhPC6H+qG3TWYTPL73qoX20otUoW0ohJILWSM57DBqD/WlENn
	 Q3isMYwgfeT8GROp96Hvvj1didl4r+29fn7E1U0NWkHVteKDUcmpTI7Sb/9ISJ+Wgm
	 ezuKUkOzJUAFaUl8Lv7dj5SuOhYh07CkTy40ELHM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231120072000epcas5p1c2431cdded9d85f8b98561b6664e2f76~ZQ7oVw5Zd1198611986epcas5p1p;
	Mon, 20 Nov 2023 07:20:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SYf674nM5z4x9Q3; Mon, 20 Nov
	2023 07:19:59 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.EB.09672.F980B556; Mon, 20 Nov 2023 16:19:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231120071959epcas5p15d708b0afa2d12acee04898971e8a4fe~ZQ7mz19Ts1198611986epcas5p1j;
	Mon, 20 Nov 2023 07:19:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231120071959epsmtrp2765a2d8309c47a1dd22c52129cb2b920~ZQ7mzFHl81618616186epsmtrp22;
	Mon, 20 Nov 2023 07:19:59 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-aa-655b089f5850
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.C8.08755.F980B556; Mon, 20 Nov 2023 16:19:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231120071957epsmtip14e6469b5d41c0ba9dc7a6a5e065dee82~ZQ7k_Bv7o2063120631epsmtip1M;
	Mon, 20 Nov 2023 07:19:57 +0000 (GMT)
Message-ID: <280d4060-452a-6d1b-ee2a-bec5a5e78a0f@samsung.com>
Date: Mon, 20 Nov 2023 12:49:56 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 01/15] fs: Rename the kernel-internal data lifetime
 constants
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>, Jan Kara
	<jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231114214132.1486867-2-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmuu58juhUgzU3FC1W3+1ns3h9+BOj
	xbQPP5ktTk89y2Sx6kG4xcrVR5ksZk9vZrJ4sn4Ws8XeW9oWe/aeZLHovr6DzWL58X9MFuf/
	Hmd14PW4fMXb4/LZUo9NqzrZPHbfbGDz+Pj0FotH35ZVjB5nFhxh9/i8Sc5j05O3TAGcUdk2
	GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKymUJeaU
	AoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM749
	DClIr5h/5DhrA2NwFyMnh4SAicSl8ztZuxi5OIQEdjNKTHp3kh3C+cQocbanCcr5xihx+8Jb
	NpiWb89nQbXsZZRYPqeBBcJ5yyix6UoLC0gVr4CdxPWtt5lAbBYBVYkji36wQ8QFJU7OfAJW
	IyqQJPHr6hxGEFtYIEziweEpYPXMAuISt57MB7NFBOIkWme9YgRZwCzwiUnizePdQGdwcLAJ
	aEpcmFwKUsMpYCWxefURRoheeYntb+cwg9RLCJzhkFjX9Jwd4mwXievrpjJC2MISr45vgYpL
	SXx+txfqtWSJSzPPMUHYJRKP9xyEsu0lWk/1M4PsZQbau36XPsQuPone30+YQMISArwSHW1C
	ENWKEvcmPWWFsMUlHs5YAmV7SKxe8p8FHnATnz9jnMCoMAspWGYheX8WkndmIWxewMiyilEy
	taA4Nz212LTAOC+1HB7dyfm5mxjBKVrLewfjowcf9A4xMnEwHmKU4GBWEuH9JhSRKsSbklhZ
	lVqUH19UmpNafIjRFBg/E5mlRJPzgVkiryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs
	1NSC1CKYPiYOTqkGJm773n013/iqr1wOnGGxQ++/ntFdhobT717OurZTaeLkfXV7Iqyil9Qr
	iy/ynvm8e/XTid9TSl55LWhYqbaCl9dyl+6u6jntf6uOXpoid99j2kVL3Q7FLudHHx+uCxfp
	+uXpsOlc2aGqsqebz3Afc7jvXP7d+Zjx5vb6iM6t87bnvC1/2t0V/3PWbGHDo7Wzhf8GWd/3
	e+Jp1NLn+Lx8SaSQ8XzWa/fjNWcyiLxVNdE4f2GHxDO2TXwaupX8D7nC7ARca1TyQ4Xssqdd
	2XulYUrehilV4lXvPVYe3X2uMqvLNqEsn22RwXJ9+f9b37Pd0l7VteqiNcPzDKudNhlV3irH
	JU/P33Q09y7f8YkJG5RYijMSDbWYi4oTARzb3nFaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnO58juhUg863LBar7/azWbw+/InR
	YtqHn8wWp6eeZbJY9SDcYuXqo0wWs6c3M1k8WT+L2WLvLW2LPXtPslh0X9/BZrH8+D8mi/N/
	j7M68HpcvuLtcflsqcemVZ1sHrtvNrB5fHx6i8Wjb8sqRo8zC46we3zeJOex6clbpgDOKC6b
	lNSczLLUIn27BK6Mbw9DCtIr5h85ztrAGNzFyMkhIWAi8e35LNYuRi4OIYHdjBIPL15ghkiI
	SzRf+8EOYQtLrPz3nB2i6DWjxNabk8ESvAJ2Ete33mYCsVkEVCWOLPoBFReUODnzCQuILSqQ
	JLHnfiNYjbBAmMSDw1PAbGagBbeezAezRQTiJA7vvwG2gFngE5NE//4fUNv2Mkrs2vMbaBIH
	B5uApsSFyaUgDZwCVhKbVx9hhBhkJtG1tQvKlpfY/nYO8wRGoVlI7piFZN8sJC2zkLQsYGRZ
	xSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHI9amjsYt6/6oHeIkYmD8RCjBAezkgjv
	N6GIVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1MF5OU
	1+32TJLKPqH3LDyPz3stV5hH8FJevaBCZXMRq76eytMf58kWuOn8VhMNf5t3SfR3ucgT7zmK
	1ziO6Pdxyvx/kxRg6/vo96P/s6d88Tb6u27frQlZ7M+fHJbaNGlFNcvUPdX1mwQL113bd9/y
	9odlrxval/9bbNhQZlRTtXXFGt2p7Nt+VoSt3XT25rP/UwXmxK7bfEP8PeOrJw/mNZ09fIlJ
	q+nBKZ+w9acv/3FN2WfW/z8zcuXfJzdnvE5u3Dr3Dkcwf/1Dk1mrU5YGhd1ijbGe+XUf473S
	VOmSy5GnUvuVPq/PVJjZUBs2cdOz8ktfWrleV363+LJCsG7fluw/XznNk1r/JC5p7TzEU63E
	UpyRaKjFXFScCAAD6u+0NgMAAA==
X-CMS-MailID: 20231120071959epcas5p15d708b0afa2d12acee04898971e8a4fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231114214200epcas5p45e852e70cc77f187c35ddbfe10ab96bd
References: <20231114214132.1486867-1-bvanassche@acm.org>
	<CGME20231114214200epcas5p45e852e70cc77f187c35ddbfe10ab96bd@epcas5p4.samsung.com>
	<20231114214132.1486867-2-bvanassche@acm.org>

On 11/15/2023 3:10 AM, Bart Van Assche wrote:

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>



