Return-Path: <linux-fsdevel+bounces-4166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A97A7FD477
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49A52834E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF411BDC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JnK7Idlg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2099CE;
	Wed, 29 Nov 2023 01:09:14 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231129090912epoutp01287576b4930785cf93f93eaf7e5d2749~cDOimonBM2915529155epoutp01w;
	Wed, 29 Nov 2023 09:09:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231129090912epoutp01287576b4930785cf93f93eaf7e5d2749~cDOimonBM2915529155epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701248952;
	bh=ZovzIa/x7gESvqlSt8MTyDv+8XkVhK5BFR8JU7cv8uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JnK7IdlgxOc9Q23X7OMVPrBpysSJuuZERBFjBVVsNR1Ki2/vkhpVx085zB6ppDDZw
	 /pUN5ZpaFMOFM/R1nEpwrDc7MAYwwyEU3+7oXO4tctXaMuauYkwzh9R1Cuv0C3yZKX
	 WHCnm6JqybyD9SMyp7yZYsGfEuiBRC8erjh9zg2Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20231129090912epcas2p2022764258f6b5627e95e97dacfaa473f~cDOiKk8hU2271922719epcas2p29;
	Wed, 29 Nov 2023 09:09:12 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.99]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SgD5z40H5z4x9QB; Wed, 29 Nov
	2023 09:09:11 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.A1.08648.7BFF6656; Wed, 29 Nov 2023 18:09:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20231129090909epcas2p1b9a5283b915463941307500ce254b49e~cDOgJSMXm1798617986epcas2p1J;
	Wed, 29 Nov 2023 09:09:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231129090909epsmtrp2c29e7c26044fa606af3f3071461ca416~cDOgHm9OJ1714217142epsmtrp2W;
	Wed, 29 Nov 2023 09:09:09 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-73-6566ffb7b3d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.41.08755.5BFF6656; Wed, 29 Nov 2023 18:09:09 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231129090909epsmtip1474006a48ac17df56754960badb5b878~cDOfv9b6c1613516135epsmtip1D;
	Wed, 29 Nov 2023 09:09:09 +0000 (GMT)
Date: Wed, 29 Nov 2023 17:57:44 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 15/27] arm64: mte: Check that tag storage blocks
 are in the same zone
Message-ID: <20231129085744.GB2988384@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231119165721.9849-16-alexandru.elisei@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHve+9vlaW6ltBd8uIYSVuEy20SOGygHPqyMvQhU2XJWYJ1vaN
	Ekpb26IOVMrCFNkEhLABMoHwaypY0vJLEGT8GD+E4XBoJqAEZmUoRUBwKMJaHy7+9znnfL/3
	3HtOLg8X3OC686I0RkavkatFpAtR07opUFy7/DUjedAgRHnmchL9dOEmiZo6FehFxm9c1D82
	4Ej9k0igqdIfAJozP8PR/fRqHP1aYCfQ/ZlUAt1rKsPQcFoWgWptkxiaqGolUHL9HIEsY7c4
	6GpjF4Fu1ueR6G75Mge1mXsJdCWvi4My7TaAisreRf3NBRjKWnhEorSh2yTqONOMoabkEcyh
	rcVQYtsUiXIGBwFKbpvHUePSAoGq259yUdKQDP1VUsndvpEuP18O6OfPMgCd1HSHSxdYYumk
	tkkObf3Fm7ZcPE3SlpkMLj106ypJd2Y/J+hCUxZOW4sT6HFrDqCnmgZI2no9np61bAin9kcH
	qxi5ktF7MhqFVhmliQwRhe2N2BkhC5BIxdIgFCjy1MhjmBDRrt3h4tAotWOYIs/DcnWsIxUu
	NxhEvtuC9dpYI+Op0hqMISJGp1TrAnU+BnmMIVYT6aNhjB9IJRI/mUN4IFrVlWQGugHXowWP
	fgcmMLY2BazmQcof1nxrIVKAC09A1QF46eH8SjAD4ESNlcsG8wCmLl/nvLL0NQ9ibKERwJwr
	vSvBfQDvtI6AFMDjEdRGOJC+3WkgqfdgZ1UpcLIb5QtHqyeAU49T3SQcPteDOQuu1EF4yvzk
	pYhP+cDFjkUuy2/Crpy/CeeZq6ltsNCEO72QSnGB/Q2LGHujXbA8f4rLsiuc6KhaYXc4a28k
	WY6Gw9PpK2yEl3tMK5qtMNd26mVfnFLBwspG3NkLUl6w7Q7BptfA5NYXXDbNh8knBazTC14r
	PU+wLISjFac4rISGC9+r2Ym0Afhjw2MsHWzIfe0xua81Y3kLLGiYIXMddpx6G5Yt8VjcBM31
	vgWAcxGsZ3SGmEhG4aeT/r9fhTbGAl5+Le+ddeDP/CWfFoDxQAuAPFzkxveZVjACvlL+TRyj
	10boY9WMoQXIHJs5i7uvU2gdf1NjjJD6B0n8AwKkgX4ySaDoLf7d735WCqhIuZGJZhgdo3/l
	w3ir3U0YMerpF0Z5XI1yCbd0ZQd6m0eUfzwd5luDdbYDu+czbWT+lD4I23wsPn7Nkebjggf8
	w9OrNKlexzhxwoX4T+Y/9Vmf89H45Wcn6WhFXfdW7NbcgfH9vand06aufRVxo2tVFYf3xg61
	S8o1Z+ThNdMn/lV6lHY/LB1JsB40FFWuLRa8n+Hfm1jXWUZkCh9vl60qOlE6V9nRXn10j8HX
	NyH0K4Vwse/GOpd24T37h1fwyUuHVDs+PlLpMZvxKPdLPuyrz9pjfGf97Um1fXnL5mKZ2+nj
	fWKx97l9I2HkIZKXrXlSEnDhjF3c0sOZCRWb3d6wlWDTlGHH59cuFHV+keb2WWKDiDCo5FJv
	XG+Q/wdLqxP94wQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxiG857z9vTQrcuxuPAKiVm6qLObLc0kvD8cuMxtZ1mcEr8SRKHS
	YyUrpWvpBi5xMLtZBwrWNdqOmLo5ENZZ1wJVgaaDCnRscaMBNloH4StIlA8ZagFhlGaZ/67c
	z309z5+HJkVf8xLpPE0hp9Mo1GJKABvbxOu3NCwf5ZLHLVJc5XRQ+EJtkMLezlz81NzOx93D
	PSvRvVKIp6rLAZ5zzpN4tLKBxD/bJyEefXgW4gFvDYHvVlgg9ow9IPBEfRvEpltzELuGe3m4
	uSUAcfBWFYX/dizzsN/5G8Q3qwI8fH5yDODvajbibp+dwJbIfQpXhPso3HHGR2CvaZBY6XoI
	XOqforA1FALY5H9E4palCMQNtx/zsTGcgv/6/jp/+wbWcckB2IV5M2CN3n4+a3cZWKP/AY91
	X5WwrrrTFOt6aOaz4d5miu28uADZyyUWknVf+Ywdd1sBO+XtoVh316fsrGv9biZTsE3JqfM+
	5nSytBzBsfaZCNRa1hSZy3z8EtAs/ArE0YjZiu74QkSURUwTQFZPcSxfh2yzASLG8WjA6OfF
	OsMAGRtXmKYhswH1VG6PxhSzCXXWV4Mor2VkaKhhYoUFNMn8SqGzP9hW3XjmCDrl/Ge1JGSk
	aLFjkR/b6QfI5DgUy9eggHUERplkJOjPpXtE9BbJJKGaJTqKcUwaulxCVgLG9oxge0aw/S/Y
	AVkH1nFafb4qXy/XyjXcJ1K9Il9v0KikuQX5LrD6OJLNN4CnblraCggatAJEk+K1QulMLicS
	KhXFxzldQbbOoOb0rSCJhuIEYcL4GaWIUSkKuQ85Tsvp/psSdFxiCfHHiT4v/MAy+zbcJdK0
	nJzJko0Vce6Zb0aSA5vTn9hTKrLeNd8p/za+PKMja0d6TcFo+Pq+yMbn6d/ntKbDl67s8S/y
	+oPlJ/tfJedT2lUvHpQlf15IXryrzEgt27t/y4+CwYS+xyRvLLJb6U7e+cW+0izjqRyBvHeu
	T563M+WX1MZC5skR4/kFQ2Z9y1unrR+9JsssWl6qHQnVnpPZs4snjz/KttbnvInMal/qdKir
	zJm9J+GdbR5r69WtTVOJezXTO4JNE+8NZhwdunbg5ftWScaJTYdfL8h0vfHlAdU5WST40zTR
	9X53kfrgS9Vpt59Tpk+8onrBGt4/1DbwdJfdwCbViqH+mEIuIXV6xb8/ir1dpwMAAA==
X-CMS-MailID: 20231129090909epcas2p1b9a5283b915463941307500ce254b49e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OVq5TT9zsDSQAN86dWjJc6zPY8CEKIwxCZDtRM.ioT5ZEg4T=_379e7_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119165900epcas2p3efd0f3ac19b7bcf7883e8d3945e63326
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
	<CGME20231119165900epcas2p3efd0f3ac19b7bcf7883e8d3945e63326@epcas2p3.samsung.com>
	<20231119165721.9849-16-alexandru.elisei@arm.com>

------OVq5TT9zsDSQAN86dWjJc6zPY8CEKIwxCZDtRM.ioT5ZEg4T=_379e7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Nov 19, 2023 at 04:57:09PM +0000, Alexandru Elisei wrote:
> alloc_contig_range() requires that the requested pages are in the same
> zone. Check that this is indeed the case before initializing the tag
> storage blocks.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/kernel/mte_tag_storage.c | 33 +++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> index 8b9bedf7575d..fd63430d4dc0 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -265,6 +265,35 @@ void __init mte_tag_storage_init(void)
>  	}
>  }
>  
> +/* alloc_contig_range() requires all pages to be in the same zone. */
> +static int __init mte_tag_storage_check_zone(void)
> +{
> +	struct range *tag_range;
> +	struct zone *zone;
> +	unsigned long pfn;
> +	u32 block_size;
> +	int i, j;
> +
> +	for (i = 0; i < num_tag_regions; i++) {
> +		block_size = tag_regions[i].block_size;
> +		if (block_size == 1)
> +			continue;
> +
> +		tag_range = &tag_regions[i].tag_range;
> +		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += block_size) {
> +			zone = page_zone(pfn_to_page(pfn));

Hello.

Since the blocks within the tag_range must all be in the same zone, can we move the "page_zone"
out of the loop ?

Thanks,
Regards.

> +			for (j = 1; j < block_size; j++) {
> +				if (page_zone(pfn_to_page(pfn + j)) != zone) {
> +					pr_err("Tag storage block pages in different zones");
> +					return -EINVAL;
> +				}
> +			}
> +		}
> +	}
> +
> +	 return 0;
> +}
> +
>  static int __init mte_tag_storage_activate_regions(void)
>  {
>  	phys_addr_t dram_start, dram_end;
> @@ -321,6 +350,10 @@ static int __init mte_tag_storage_activate_regions(void)
>  		goto out_disabled;
>  	}
>  
> +	ret = mte_tag_storage_check_zone();
> +	if (ret)
> +		goto out_disabled;
> +
>  	for (i = 0; i < num_tag_regions; i++) {
>  		tag_range = &tag_regions[i].tag_range;
>  		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
> -- 
> 2.42.1
> 
> 

------OVq5TT9zsDSQAN86dWjJc6zPY8CEKIwxCZDtRM.ioT5ZEg4T=_379e7_
Content-Type: text/plain; charset="utf-8"


------OVq5TT9zsDSQAN86dWjJc6zPY8CEKIwxCZDtRM.ioT5ZEg4T=_379e7_--

