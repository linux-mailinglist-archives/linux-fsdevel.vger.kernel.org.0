Return-Path: <linux-fsdevel+bounces-5299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BE1809C79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 07:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD00281FE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46937D284
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jex/enZ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD41171C;
	Thu,  7 Dec 2023 21:39:22 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231208053920epoutp0108610d4bffc289b8801cfbe4687de767~exK3VjBDb0681006810epoutp01G;
	Fri,  8 Dec 2023 05:39:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231208053920epoutp0108610d4bffc289b8801cfbe4687de767~exK3VjBDb0681006810epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702013960;
	bh=a9SzkBB0LEpQmzUH0qCc/2HzgkvZOhyaAeKEGrhz5ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jex/enZ+dylgtXCvv6kls24noB9SFdLnofHHu+4WYyasi7Tzb7jWpLrrz1CvKjSK3
	 +jwFqONJHjFv1ikWV2QLMJ6MVXqkCWABL10VtBMBjJ1exBEewOOgyo+mZm+gI+2aO0
	 M9oYLOK7+6DwTvODHZCi+WVWcXorzaW+6UB58dRE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231208053919epcas2p44cfb65876ff22dafd91b51d26c59cc0e~exK3EuTok2742427424epcas2p4G;
	Fri,  8 Dec 2023 05:39:19 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Smg1g1WDxz4x9QG; Fri,  8 Dec
	2023 05:39:19 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.34.10006.70CA2756; Fri,  8 Dec 2023 14:39:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231208053918epcas2p3b3b14464cfaf4906f09bccce59a50ce9~exK17ecSy2469724697epcas2p3E;
	Fri,  8 Dec 2023 05:39:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231208053918epsmtrp2b7a6676ba19ddc4c06ac7a36b96675dc~exK15GY552373123731epsmtrp2h;
	Fri,  8 Dec 2023 05:39:18 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-a4-6572ac07480e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.6C.08755.60CA2756; Fri,  8 Dec 2023 14:39:18 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231208053918epsmtip1d5b1cb1fa46d6cf791f4f107d621ecc4~exK1lwyLD0309703097epsmtip1M;
	Fri,  8 Dec 2023 05:39:18 +0000 (GMT)
Date: Fri, 8 Dec 2023 14:27:39 +0900
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
Message-ID: <20231208052739.GB1359878@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZWh5S9BoO5bG5nQM@raptor>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATVxjt3d1sAjNxVqTllqplQtXCCCSUx8URp7W0s6X+wDrax3SkK+wA
	JSRpNtRH6QiIJUaRdy0UEYYSkAmEEpD3m/Joq45opCIog0IlFCixIghiE9Y+/p3vfOfc7zVX
	hDtdEbqKYhQaVq1g5BLSkbjU7RHoJTSoWam+UYAKjAYSnbt4nURt/RHoaVavEA3eM9uoqSQC
	zenPAPTI+ARHExl1OOosmiXQhPUsge62lWFoND2XQPWTMxiy1HYTSNv0iEA1924KUEvrAIGu
	NxWQ6I7hmQD1GC8TqLFgQICyZycBKinbigY7ijCUu/QHidJHhkjUl9aBoTbtGGbT1mMoqWeO
	RHm3bwOk7VnAUevqEoHqfnosRCkj/uhWabXwzS20odAA6OUnWYBOaRsW0kU18XRKz4yANpV7
	0jUVp0i6xpolpEdutpB0/3fLBF2cmIvTph+O0w9MeYCeazOTtOmXr+iHNZvDqE9id0azTCSr
	dmMVEcrIGEVUsOT9feFvh/sHSGVesiAUKHFTMHFssCRkT5jXuzFy2zIlbl8y8ngbFcZwnMRn
	1061Ml7DukUrOU2whFVFylWBKm+OiePiFVHeClazQyaV+vrbhJ/FRicnVwJVyeYjKYkdZCIo
	d9EBkQhSfjC3I1gHHEROVAOApkpGBxxt2ApgszkJ54MFAEcmrgjsKrthYchC8olWAMceWAk+
	mACwtLifsD9LUK/B1MljdgNJbYP9tXpgx86UDxyvswC7Hqd+JuHo979i9sQG6hBMNf61JhJT
	3jD76imSx+vhQN59wo4dqK0wrWxxrSVI5TrCipMnSL6lEKirLsR5vAFa+mqFPHaFD2dbn2s4
	eKmkG+PNibZBtXefG96A+ZOpwN41TkVDa30svxd32DO8Vhen1kFt91MhT4uh9hsn3ugO2/WF
	BI9fhuOVqQJeQsOl03J+JScwuDJqARlgc/7/psn/r1b+WoHtsKjZSvL0K7BsVcRDD2hs8ikC
	ggrwEqvi4qJYzlcl+/e6Ecq4GrD2sTzfaQDZM396dwFMBLoAFOESZ7H8qpJ1EkcyR4+xamW4
	Ol7Ocl3A33aZTNz1xQil7WcqNOEyvyCpX0CALNDXXxoocRHfOXk+0omKYjRsLMuqWPU/Pkzk
	4JqIVeMEpwtaXPzdIdnlUJwJFkS1XyiYd0ubtuhWTkodfOaGN3VmnF/aeSCaea9pY56i21VK
	X+zfmDAtOBhrFtd/0fd4/45udM68d12/v2bWzGXmHf+gPMTHkH7rmcfsjYTeVbHX5/kj+xuq
	MksHDgoYY7O7c2RlyzWnvvMH6jTKO8npU2fFRfMxxEZR9scOr370NaHevXtL+LUPE6saf8uu
	DjW80C4+HJYbnzOU5rs3Zzn025ldh+9jdVNW7dDreZLpo2E38u85pp8JCqg9Ylrp8di0nWg0
	Fudcpis+JQfHhZaq9NCxbVsv1A7X79HPm13eqi/Un15aXu7U9epl+2IT6n5cLyG4aEbmias5
	5m/j/7z54QQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxbZRjF89779vZS03gtNbvA0phGmLJJRybkTQC3KFlu5uKcJsT4ka2j
	dxRtS3MvHw7MBMHREVkRgqOVYadAB3aWtUAnH5VBN6kyRwYddVQxdCVAYOg6mBsOpaBx/52c
	8zs5zx8PiUsaBLFkri6f5XRKjZwQwe4huew5wsaxO8trYlGj3Uag021jBHIPZ6OHtVeE6HrQ
	t27NlUG01PoJQMv2BzgK1XTh6JLlNkShO6cgmnJbMfSLsR4i18wihuY7hyAy9CxD5AjeEKC+
	fi9EYz2NBPrV9rcAeexXIfq20StAdbdnAPrKmoCuD1gwVH9/gUDGwASBvq8ewJDb8Bu2zrow
	VOZZIpBpchIgg2cFR/1r9yHqunxPiCoCKejnlg7hnnjG1mQDzOqDWsBUuG8KGYujgKnwLAoY
	57lExtF+kmAcd2qFTOBGH8EMN6xC5mxpPc44mz9kZp0mwCy5fQTj/LGECTtkr1JvitJVrCa3
	kOUULxwWqUNnRoE+GPd+l7MfloKyJ6tAFElTz9MrE/NEFRCREqoX0F+eqIObQQxtDnuxTR1N
	T1V4BJtQENAOS/M6RJKQepqunCmOMAS1jR7ubAURLaUU9HTXPIjwODVC0Ke+NgsiQTR1hK60
	392AxFQSXXft5L/LH2O09e44sRk8QXtNtzauwKlE2r82h0XGcCqOtq6RETuKSqCrrX/iNYAy
	P9IwP9Iw/9+wALwdxLB6Xpuj5ZP1yTq2KIlXavkCXU5Sdp7WATaeJ/HZi8DV/nvSIMBIMAho
	EpdLxZpreaxErFIeK2a5vENcgYblB0EcCeVbxFtmq1USKkeZz77HsnqW+y/FyKjYUsxoWFnY
	V69THC0+8Ub7yF8pI1c6M4teK8zIgKoCTpEl6RVhGoZvyDKWxcu4osckUsnNA+MdzYHlPaYf
	zNPd6fqj3fcmzFVzav/WF5tSQkuyC++4vKrTs/jCgcIdpsxtfZk130gnX0/TDapvBfwto0d2
	hssNYfXQ6q6XLzfprgrSK32K1HfP7gg/nj9r2/72wO7ogGtm7/l90/HH3trvaPtOv32r6eBH
	lx5m8H+k+cqfOm75PHjm0CsvLfZkpcmytSVtqeOE3ZR7MKbFt9oqzE39CfVcTPCP7Yqamt4L
	sRS84wPj+f79o6PiC8qS7k+fOXw8dG733Gcmp/QL0m9N6y30ySGvViYn4hyv/AcLkeWFqwMA
	AA==
X-CMS-MailID: 20231208053918epcas2p3b3b14464cfaf4906f09bccce59a50ce9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----jVQIulvRnesfT.0dBTaAFRklTpdxk.gFV3lmrScQ3G3ZF59d=_93327_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119165900epcas2p3efd0f3ac19b7bcf7883e8d3945e63326
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
	<CGME20231119165900epcas2p3efd0f3ac19b7bcf7883e8d3945e63326@epcas2p3.samsung.com>
	<20231119165721.9849-16-alexandru.elisei@arm.com>
	<20231129085744.GB2988384@tiffany> <ZWh5S9BoO5bG5nQM@raptor>

------jVQIulvRnesfT.0dBTaAFRklTpdxk.gFV3lmrScQ3G3ZF59d=_93327_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi~

On Thu, Nov 30, 2023 at 12:00:11PM +0000, Alexandru Elisei wrote:
> Hi,
> 
> On Wed, Nov 29, 2023 at 05:57:44PM +0900, Hyesoo Yu wrote:
> > On Sun, Nov 19, 2023 at 04:57:09PM +0000, Alexandru Elisei wrote:
> > > alloc_contig_range() requires that the requested pages are in the same
> > > zone. Check that this is indeed the case before initializing the tag
> > > storage blocks.
> > > 
> > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > ---
> > >  arch/arm64/kernel/mte_tag_storage.c | 33 +++++++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > > index 8b9bedf7575d..fd63430d4dc0 100644
> > > --- a/arch/arm64/kernel/mte_tag_storage.c
> > > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > > @@ -265,6 +265,35 @@ void __init mte_tag_storage_init(void)
> > >  	}
> > >  }
> > >  
> > > +/* alloc_contig_range() requires all pages to be in the same zone. */
> > > +static int __init mte_tag_storage_check_zone(void)
> > > +{
> > > +	struct range *tag_range;
> > > +	struct zone *zone;
> > > +	unsigned long pfn;
> > > +	u32 block_size;
> > > +	int i, j;
> > > +
> > > +	for (i = 0; i < num_tag_regions; i++) {
> > > +		block_size = tag_regions[i].block_size;
> > > +		if (block_size == 1)
> > > +			continue;
> > > +
> > > +		tag_range = &tag_regions[i].tag_range;
> > > +		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += block_size) {
> > > +			zone = page_zone(pfn_to_page(pfn));
> > 
> > Hello.
> > 
> > Since the blocks within the tag_range must all be in the same zone, can we move the "page_zone"
> > out of the loop ?
> `
> Hmm.. why do you say that the pages in a tag_range must be in the same
> zone? I am not very familiar with how the memory management code puts pages
> into zones, but I would imagine that pages in a tag range straddling the
> 4GB limit (so, let's say, from 3GB to 5GB) will end up in both ZONE_DMA and
> ZONE_NORMAL.
> 
> Thanks,
> Alex
> 

Oh, I see that reserve_tag_storage only calls alloc_contig_rnage in units of block_size,
I thought it could be called for the entire range the page needed at once.
(Maybe it could be a bit faster ? It doesn't seem like unnecessary drain and
other operation are repeated.)

If we use the cma code when activating the tag storage, it will be error if the
entire area of tag region is not in the same zone, so there should be a constraint
that it must be in the same zone when defining the tag region on device tree.

Thanks,
Regards.

> > 
> > Thanks,
> > Regards.
> > 
> > > +			for (j = 1; j < block_size; j++) {
> > > +				if (page_zone(pfn_to_page(pfn + j)) != zone) {
> > > +					pr_err("Tag storage block pages in different zones");
> > > +					return -EINVAL;
> > > +				}
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	 return 0;
> > > +}
> > > +
> > >  static int __init mte_tag_storage_activate_regions(void)
> > >  {
> > >  	phys_addr_t dram_start, dram_end;
> > > @@ -321,6 +350,10 @@ static int __init mte_tag_storage_activate_regions(void)
> > >  		goto out_disabled;
> > >  	}
> > >  
> > > +	ret = mte_tag_storage_check_zone();
> > > +	if (ret)
> > > +		goto out_disabled;
> > > +
> > >  	for (i = 0; i < num_tag_regions; i++) {
> > >  		tag_range = &tag_regions[i].tag_range;
> > >  		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
> > > -- 
> > > 2.42.1
> > > 
> > > 
> 
> 
> 

------jVQIulvRnesfT.0dBTaAFRklTpdxk.gFV3lmrScQ3G3ZF59d=_93327_
Content-Type: text/plain; charset="utf-8"


------jVQIulvRnesfT.0dBTaAFRklTpdxk.gFV3lmrScQ3G3ZF59d=_93327_--

