Return-Path: <linux-fsdevel+bounces-3914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0C7F9C05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 09:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C3B1C20A22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77112E4F;
	Mon, 27 Nov 2023 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d+2uBYIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F2910A
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 00:46:00 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231127084557epoutp0101f3aa1d2dc42e40ec05849c74106686~bbnrM0JjZ0551505515epoutp01a
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 08:45:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231127084557epoutp0101f3aa1d2dc42e40ec05849c74106686~bbnrM0JjZ0551505515epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701074758;
	bh=piRk08qZfobEfHZbLHWLRh0ey5j7Xjw276JOr6tBb3E=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=d+2uBYIe0lk3Xd5YtO5FdHPBCJSC2EvPlQW4FMeFQQziTZ6qMqD3UFvM1SIY2OHDM
	 KJIYM2goUWTIrgfhbo+0DOr0FkkK5jnSQsvOZnLUK6PilggnD5t6P/TjM4RNLuaVF/
	 VFpi3uU8/cDfxs0FihU2OZLIpKkKokr315aqxuPc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231127084556epcas5p241418aab1d1e0c32b1625b1d4250d59e~bbnqKCPcm1616516165epcas5p2B;
	Mon, 27 Nov 2023 08:45:56 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Sdzh23ZJ5z4x9Q2; Mon, 27 Nov
	2023 08:45:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.E3.10009.24754656; Mon, 27 Nov 2023 17:45:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231127084554epcas5p42b5b728347a459ec810ea94431747245~bbnnnVvQm0391603916epcas5p4P;
	Mon, 27 Nov 2023 08:45:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231127084554epsmtrp29c53b82d287ade04348d49b36526c855~bbnnmklrv2734227342epsmtrp2T;
	Mon, 27 Nov 2023 08:45:54 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-65-6564574220a6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.E1.07368.14754656; Mon, 27 Nov 2023 17:45:53 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231127084552epsmtip20847e394abfdec7d8e4740203e96378e~bbnlzRNeL2675026750epsmtip2C;
	Mon, 27 Nov 2023 08:45:52 +0000 (GMT)
Message-ID: <1e2481ac-6075-c940-327b-350f1d4b9ee5@samsung.com>
Date: Mon, 27 Nov 2023 14:15:51 +0530
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
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Daejun Park
	<daejun7.park@samsung.com>, Jan Kara <jack@suse.cz>, Christian Brauner
	<brauner@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
	<chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231127070830.GA27870@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmpq5TeEqqwcHDEhar7/azWbw+/InR
	YtqHn8wWp6eeZbJY9SDcYuXqo0wWs6c3M1k8WT+L2WLvLW2LPXtPslh0X9/BZrH8+D8mi/N/
	j7M68HpcvuLtcflsqcemVZ1sHrtvNrB5fHx6i8Wjb8sqRo8zC46we3zeJOex6clbpgDOqGyb
	jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCjlRTKEnNK
	gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGS0X
	tjIXHOOqWPPqH0sD4xmOLkZODgkBE4nJv9awgNhCArsZJa7fcYSwPzFKNM8o7WLkArK/MUps
	nTydHabhxbfF7BCJvYwSHw82MkM4bxkl2n7tBKviFbCT2DLvBVsXIwcHi4CqxO0JwhBhQYmT
	M5+AbRMVSJL4dXUOI4gtLBAm8eDwFCYQm1lAXOLWk/lMIK0iAh4Sc5+ogIxnFmhjlti7aAo7
	SJxNQFPiwuRSkHJOAR2Jyz8XsUC0yktsfzsH7BwJgRMcErcWP2OGONpFYvO3iVAPCEu8Or4F
	ypaS+PxuLxuEnSxxaeY5Jgi7ROLxnoNQtr1E66l+ZpC9zEB71+/Sh9jFJ9H7+wnYmRICvBId
	bUIQ1YoS9yY9ZYWwxSUezljCClHiIdExRxISUPcZJU4/WcU+gVFhFlKgzELy/Cwk38xCWLyA
	kWUVo2RqQXFuemqxaYFRXmo5PLKT83M3MYLTs5bXDsaHDz7oHWJk4mA8xCjBwawkwqv3MTlV
	iDclsbIqtSg/vqg0J7X4EKMpMHImMkuJJucDM0ReSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC
	6YklqdmpqQWpRTB9TBycUg1MTWWvnBmNrhvVTCueHBNpcSDp8Wz3yYucHh7fv/Ha193FZlY/
	vr19ddFKyTJNXnr51s+GfRY9EUsPTnMI9Dczjo8X/PBBvtJO+k7B7X3yj8wczmsY/K6NfSJQ
	devTXNmOnxfjvX/zqUp0TNm2o3QJ3z2Wa0L311h/eG+cxWjzp95iqsFkGc6Aeh/Om2vSRI9t
	ZktN4aq1fJnySXIli9g/zSuOSt7C0+InR35a4vZOu25WT8HFNO1LXrNLNonb2KtHtNX5d9v/
	PCkQtPp1jnHXeWNd/jIjP9ErXyet+sSmbaHk8FFB+oVlrGG99meHz50ZdRJeovL5uzPYF/17
	tefU1Birs6v4VGYvWn/95yUlluKMREMt5qLiRACO31mKWAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvK5jeEqqwbblNhar7/azWbw+/InR
	YtqHn8wWp6eeZbJY9SDcYuXqo0wWs6c3M1k8WT+L2WLvLW2LPXtPslh0X9/BZrH8+D8mi/N/
	j7M68HpcvuLtcflsqcemVZ1sHrtvNrB5fHx6i8Wjb8sqRo8zC46we3zeJOex6clbpgDOKC6b
	lNSczLLUIn27BK6MlgtbmQuOcVWsefWPpYHxDEcXIyeHhICJxItvi9m7GLk4hAR2M0pMPbiK
	HSIhLtF87QeULSyx8t9zqKLXjBKtT9YzgSR4Bewktsx7wdbFyMHBIqAqcXuCMERYUOLkzCcs
	ILaoQJLEnvuNYOXCAmESDw5PAbOZgebfejKfCaRVRMBDYu4TFYhwG7PElNUsEKvuM0o8nXgf
	rIZNQFPiwuRSkBpOAR2Jyz8XsUDUm0l0be1ihLDlJba/ncM8gVFoFpIrZiHZNgtJyywkLQsY
	WVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgTHo5bGDsZ78//pHWJk4mA8xCjBwawk
	wqv3MTlViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBiav
	v6tWmIdb6saJXFnaLVg2NVCEVW0Xh9/1M4y9sVPeun3w8P6uyMhxtPHsuuXizf98D+88J7Su
	5qB7j9zOryYFByfsNd2oFzqFx74xNVX95I37Vo+sShZVJs45M1++Tv7CJ7Fm+Q5+8QWGHc6a
	Ox3nqf593ywn1Pw/f47N+6ki7z5cXnZUqMGWtfBm086CC8J/jP+eCzjiYMBjuT3Depd7kaWq
	VGCmkU/CpV+Jli5K0ee5HjKdKJomnBR/7/v8YttgoavOjvJxr+ZH3I6c58sdcPCErInwwSNF
	PypculUsw+Msamdtq/O8K2OuWrhz0TfJ/pZu5qOVe+Kdmxe923rhZ0tVXemB72pvs9UqlFiK
	MxINtZiLihMB/dm8DDYDAAA=
X-CMS-MailID: 20231127084554epcas5p42b5b728347a459ec810ea94431747245
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231127070931epcas5p4a75cd61de4c00a00b9c75518d1831bbf
References: <20231114214132.1486867-1-bvanassche@acm.org>
	<20231114214132.1486867-2-bvanassche@acm.org>
	<CGME20231127070931epcas5p4a75cd61de4c00a00b9c75518d1831bbf@epcas5p4.samsung.com>
	<20231127070830.GA27870@lst.de>

On 11/27/2023 12:38 PM, Christoph Hellwig wrote:
> On Tue, Nov 14, 2023 at 01:40:56PM -0800, Bart Van Assche wrote:
>> -	case WRITE_LIFE_SHORT:
>> +	case WRITE_LIFE_2:
>>   		return CURSEG_HOT_DATA;
>> -	case WRITE_LIFE_EXTREME:
>> +	case WRITE_LIFE_5:
>>   		return CURSEG_COLD_DATA;
>>   	default:
>>   		return CURSEG_WARM_DATA;
> 
> A WRITE_LIFE_2 constant is strictly more confusing than just using 2,
> so this patch makes no sense whatsoever.
> 
> More importantly these constant have been around forever, so we'd better
> have a really good argument for changing them.

How about this argument (assuming you may not have seen) from previous 
iteration [1]-

"Does it make sense to do away with these, and have temperature-neutral
names instead e.g., WRITE_LIFE_1, WRITE_LIFE_2?

With the current choice:
- If the count goes up (beyond 5 hints), infra can scale fine but these
names do not. Imagine ULTRA_EXTREME after EXTREME.
- Applications or in-kernel users can specify LONG hint with data that
actually has a SHORT lifetime. Nothing really ensures that LONG is
really LONG.

Temperature-neutral names seem more generic/scalable and do not present
the unnecessary need to be accurate with relative temperatures."

[1]
https://lore.kernel.org/linux-block/b3058ce6-e297-b4c3-71d4-4b76f76439ba@samsung.com/

