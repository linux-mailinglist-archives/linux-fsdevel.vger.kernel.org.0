Return-Path: <linux-fsdevel+bounces-5300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09F7809C7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 07:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F48028171A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34063101C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="goPP2wDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B1D26AC;
	Thu,  7 Dec 2023 21:41:21 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231208054119epoutp01c076a167c4e59ebf8153b06075f17436~exMm-9AMa0608406084epoutp01k;
	Fri,  8 Dec 2023 05:41:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231208054119epoutp01c076a167c4e59ebf8153b06075f17436~exMm-9AMa0608406084epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702014080;
	bh=TShggJDiDmcvjOqlveL4HgbFDSRxgxWpVCqxzQnUxMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=goPP2wDUv91kZK/qLNaZSHEpbDk1J7Z+ge5rlSwzVgpiFaehYP1SqkF072Ix25Of/
	 0XbiHNq5CnHbNug7y+OO3hdKm6Sx4hOXRIPa1b2lpUVQ6OF6i/pah3mXqJLGSV27IA
	 2zLdqpsW0PERec2uwrfYsmB1ezsb2JOPuV+6maRY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20231208054119epcas2p23c182dc4bb113f596c3884c7aaed3bce~exMmur3ux3074330743epcas2p2Q;
	Fri,  8 Dec 2023 05:41:19 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Smg3y6k7zz4x9QC; Fri,  8 Dec
	2023 05:41:18 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.2A.18994.E7CA2756; Fri,  8 Dec 2023 14:41:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20231208054118epcas2p1bb98fbd9e0fb6a15e91a9b03d8c09ce3~exMlelct03160631606epcas2p1u;
	Fri,  8 Dec 2023 05:41:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231208054118epsmtrp2958e412c6b2a3e5a6a38d437b1243d25~exMldE9ty2518625186epsmtrp2M;
	Fri,  8 Dec 2023 05:41:18 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-f0-6572ac7e950d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E8.87.07368.E7CA2756; Fri,  8 Dec 2023 14:41:18 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231208054117epsmtip10f9d367f5057e635709e0ea235922862~exMlIWgTu3219832198epsmtip1t;
	Fri,  8 Dec 2023 05:41:17 +0000 (GMT)
Date: Fri, 8 Dec 2023 14:29:38 +0900
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
Subject: Re: [PATCH RFC v2 16/27] arm64: mte: Manage tag storage on page
 allocation
Message-ID: <20231208052938.GC1359878@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZWc9sVTCHTBcp2Z2@raptor>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1ATVxTG5+4um4BFF7D1mnaEiUWEaSBJgVxaaO2IzKq1g9oOTlExQ5ZH
	gSSTBCut5S1EpoCkYg2ig8NLaSoY3q/IqwLSlioVWh6iKFCxwAwUrPJqYLXjf7/z3fOdc+69
	c7i47R8cHjdcrmFUcmkkn7QiqlqdPQWxBhUjzK8Vo9xSA4m+v9pDIlNHMFrS3eSgOw/vmqXH
	CQSaLvoWoLnS5zgaPVOJo+a8KQKNzmQQaNhUjKGhzGwCVY9NYmiiopVA2ro5Ahkf9lqghsZO
	AvXU5ZLonmHFArWV/kKg2txOC/Td1BhA+cXb0J2mPAxlP/ubRJmDfSRqT2/CkEl7HzPnVmMo
	oW2aRPqBAYC0bfM4alx+RqDKn55yUPKgB/qzsIyzw5E2XDIAeuG5DtDJpn4OnWeMppPbJi3o
	8isutLHkNEkbZ3QcerC3gaQ7zi8Q9OX4bJwuL4ij/yrXA3radJeky7u+pmeNW/ypzyO8wxip
	jFE5MPJghSxcHurD33swaGeQh6dQJBB5IQnfQS6NYnz4vh/7C/zCI82PyXc4Lo2MNkv+UrWa
	7/aBt0oRrWEcwhRqjQ+fUcoilRKlq1oapY6Wh7rKGc17IqFQ7GFOPBYRdu36P7iy+qMTk01Z
	ZDwYEacBSy6k3OFV/X1OGrDi2lINAJ4evkGywQyA3frfCTaYB1C3UI+9tIyPnMXYg0YACyZL
	ABuMAlh3fYpczSKot2Fv/21ilUnKCXZUFIFV3ki5wZHKiTUDTt0i4dCFn9fK2lGfwZK+YXyV
	rSlXmJa+SLBsAzv1j9bYktoGTQtL+KoZUhlWsOXaWcDO5AsHJ2YtWLaDE+0VHJZ5cHaqkWRZ
	DavyWzHWHA9guZbtBql3Yc5Y6lohnAqDen2mmblmfSts6ydYeT3Uti5xWNkaalNsWedWeKPo
	EsHyZjjyY+qLEWi4XFP04lWTMGi40IudAVtyXrlPzivdWH4H5tXPkDnmFjj1Jixe5rLoDEvr
	3PKARQngMUp1VCgTLFaKBHLmy///OVgRZQRrK+ayrwY8KV1ybQEYF7QAyMX5G60juxWMrbVM
	GvMVo1IEqaIjGXUL8DD/UBbOez1YYd5RuSZI5O4ldPf0FEnEHkIJf5P1vVMXZbZUqFTDRDCM
	klG99GFcS148VhCAS98fOngqqdNbVnggIOXWBrfi8YTwXXNOfiHl4ix/q4IDR58uBhrao0y8
	9H/nHx1rG48dcsxSfQEOnbRbiV1ZrpnYMxD4TcrID83u5wqr92uP7Fo3G2vCjDn2j9+wd7nS
	ek4g2S15IBNvqvut6XL39NG4/i5tfRZ/YfJD4QPY3HXCv259EHO8cvseSdPhwL1VIem6X8n9
	LRh6K5WbxktKULwGPzkktvGeTsj0Z3YHLcQs6rjOAWX5m2/bpR5Jz7InHQU2suium7KywZDD
	AZodlJPXvkS37bqQxNqpJzEpTIVvaKLw/M51Sz19SRmtXXETgbEqFfZpu7jYb8PJiwWVfEId
	JhW54Cq19D8uG+JY6wQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH855zenog6zxWlr0gEtcMJU0sNkh4YozDJY6zzA+LbmQxi9i0
	Z4CWwlphUzcHW0XWCDSdTNoxrPEC6xrRtggWaRh0rg0aHUodl1ECA5WtYLjIgFFHaZb57Zf/
	7fnyMKTYLEhg8jVHeK1GoZbQsdT1LknSlhN2Lb/12pWXoK7JTsPZH+7T4PEpYdl0Swg9o70r
	0pMyCqYun0Yw17RIwpixmYSfrJMUjE1XURD0NBDwe3UNBS3jIQImXF0UVLjnKHCMBgRws91P
	wX13HQ1D9ucC8DbdoeBGnV8A30yOI7jQsAl6OqwE1Cz8RUP14EMafqnsIMBTMUysZFsIKPNO
	0WAeGEBQ4X1GQnt4gYLmn+eFoB9Mh75LV4WZyZy93o64pUUT4vSefiFndRRzem9IwDkbpZzD
	9jXNOaZNQm4wcJPmfLVLFHe+tIbknBe/4B47zYib8vTSnLP7ODfjSHqX3R+7Q8Wr80t4berO
	g7F5C38OEkXzOz+9s1xFlqK2rQYUw2B2G340coYwoFhGzLYhfK6lVhA14rFlxk9EeR0O6r2C
	aGgU4d6yq6sGxb6OA/2/UhGm2c3Y57qMIhzHpuKR5gkUKZDsbRpX/WhZXV3Hvo9tD4NkhEWs
	DBsq/6GiqycJ3PHUIIgaa7Hf/MfqKslK8W/hJyvXmBVejxvCTESOYTdhz9IyaUSs5YWG5YWG
	5f+GFZE2FM8X6QpyC5TyIrmG/0SmUxToijW5MmVhgQOtfo80pRUNnQvLOhHBoE6EGVISJ1Lf
	LeTFIpXi6DFeW5ijLVbzuk60nqEkr4rktd+pxGyu4gh/mOeLeO1/LsHEJJQS3QmHngUnp639
	yriUFLsyfUN79hrbg2RSlFk9n60b8F1Y9ska/0bv5F3rmxybKivXuA7ayncE5jJ2qdyS4qOP
	yKBx91u4fHvihOxe/fOMhO6ziVtyhodTzLOte1/2de3dv+uSO0n7pv5E81jaKxtn+g7dyzLJ
	j886HPPGDQeY+H0Nb3/gTb3YmAWBw2kHTiflDC/cuuGrrVeHWHwqOXNC+1Xo+mv2mI7K9o1n
	vo9zLW2vtJg+79ltKplx7Rv/uPR2SJX/pdKf7novW3ysf9tHxGfVibmza6+c/PCNb8mKzQ+m
	3VmniFljd/pQmkHbtkbqbzsffszcdbaK9iw+3ZOWUTIioXR5CrmU1OoU/wJa/2McrAMAAA==
X-CMS-MailID: 20231208054118epcas2p1bb98fbd9e0fb6a15e91a9b03d8c09ce3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----xhiRNYr7C6p2kRFttE2KPojvpONXRQ6l4raSmD__Jn20cHwF=_9337f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119165906epcas2p4c6691d274bec428329b193b99119a8d1
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
	<CGME20231119165906epcas2p4c6691d274bec428329b193b99119a8d1@epcas2p4.samsung.com>
	<20231119165721.9849-17-alexandru.elisei@arm.com>
	<20231129091040.GC2988384@tiffany> <ZWc9sVTCHTBcp2Z2@raptor>

------xhiRNYr7C6p2kRFttE2KPojvpONXRQ6l4raSmD__Jn20cHwF=_9337f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi.

On Wed, Nov 29, 2023 at 01:33:37PM +0000, Alexandru Elisei wrote:
> Hi,
> 
> On Wed, Nov 29, 2023 at 06:10:40PM +0900, Hyesoo Yu wrote:
> > On Sun, Nov 19, 2023 at 04:57:10PM +0000, Alexandru Elisei wrote:
> > > [..]
> > > +static int order_to_num_blocks(int order)
> > > +{
> > > +	return max((1 << order) / 32, 1);
> > > +}
> > > [..]
> > > +int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
> > > +{
> > > +	unsigned long start_block, end_block;
> > > +	struct tag_region *region;
> > > +	unsigned long block;
> > > +	unsigned long flags;
> > > +	unsigned int tries;
> > > +	int ret = 0;
> > > +
> > > +	VM_WARN_ON_ONCE(!preemptible());
> > > +
> > > +	if (page_tag_storage_reserved(page))
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * __alloc_contig_migrate_range() ignores gfp when allocating the
> > > +	 * destination page for migration. Regardless, massage gfp flags and
> > > +	 * remove __GFP_TAGGED to avoid recursion in case gfp stops being
> > > +	 * ignored.
> > > +	 */
> > > +	gfp &= ~__GFP_TAGGED;
> > > +	if (!(gfp & __GFP_NORETRY))
> > > +		gfp |= __GFP_RETRY_MAYFAIL;
> > > +
> > > +	ret = tag_storage_find_block(page, &start_block, &region);
> > > +	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
> > > +		return 0;
> > > +	end_block = start_block + order_to_num_blocks(order) * region->block_size;
> > > +
> > 
> > Hello.
> > 
> > If the page size is 4K,  block size is 2 (block size bytes 8K), and order is 6,
> > then we need 2 pages for the tag. However according to the equation, order_to_num_blocks
> > is 2 and block_size is also 2, so end block will be incremented by 4.
> > 
> > However we actually only need 8K of tag, right for 256K ?
> > Could you explain order_to_num_blocks * region->block_size more detail ?
> 
> I think you are correct, thank you for pointing it out. The formula should
> probably be something like:
> 
> static int order_to_num_blocks(int order, u32 block_size)
> {
> 	int num_tag_pages = max((1 << order) / 32, 1);
> 
> 	return DIV_ROUND_UP(num_tag_pages, block_size);
> }
> 
> and that will make end_block = start_block + 2 in your scenario.
> 
> Does that look correct to you?
> 
> Thanks,
> Alex
> 

That looks great!

Thanks,
Regards.

> > 
> > Thanks,
> > Regards.
> > 
> > > +	mutex_lock(&tag_blocks_lock);
> > > +
> > > +	/* Check again, this time with the lock held. */
> > > +	if (page_tag_storage_reserved(page))
> > > +		goto out_unlock;
> > > +
> > > +	/* Make sure existing entries are not freed from out under out feet. */
> > > +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> > > +	for (block = start_block; block < end_block; block += region->block_size) {
> > > +		if (tag_storage_block_is_reserved(block))
> > > +			block_ref_add(block, region, order);
> > > +	}
> > > +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> > > +
> > > +	for (block = start_block; block < end_block; block += region->block_size) {
> > > +		/* Refcount incremented above. */
> > > +		if (tag_storage_block_is_reserved(block))
> > > +			continue;
> > > +
> > > +		tries = 3;
> > > +		while (tries--) {
> > > +			ret = alloc_contig_range(block, block + region->block_size, MIGRATE_CMA, gfp);
> > > +			if (ret == 0 || ret != -EBUSY)
> > > +				break;
> > > +		}
> > > +
> > > +		if (ret)
> > > +			goto out_error;
> > > +
> > > +		ret = tag_storage_reserve_block(block, region, order);
> > > +		if (ret) {
> > > +			free_contig_range(block, region->block_size);
> > > +			goto out_error;
> > > +		}
> > > +
> > > +		count_vm_events(CMA_ALLOC_SUCCESS, region->block_size);
> > > +	}
> > > +
> > > +	page_set_tag_storage_reserved(page, order);
> > > +out_unlock:
> > > +	mutex_unlock(&tag_blocks_lock);
> > > +
> > > +	return 0;
> > > +
> > > +out_error:
> > > +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> > > +	for (block = start_block; block < end_block; block += region->block_size) {
> > > +		if (tag_storage_block_is_reserved(block) &&
> > > +		    block_ref_sub_return(block, region, order) == 1) {
> > > +			__xa_erase(&tag_blocks_reserved, block);
> > > +			free_contig_range(block, region->block_size);
> > > +		}
> > > +	}
> > > +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> > > +
> > > +	mutex_unlock(&tag_blocks_lock);
> > > +
> > > +	count_vm_events(CMA_ALLOC_FAIL, region->block_size);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +void free_tag_storage(struct page *page, int order)
> > > +{
> > > +	unsigned long block, start_block, end_block;
> > > +	struct tag_region *region;
> > > +	unsigned long flags;
> > > +	int ret;
> > > +
> > > +	ret = tag_storage_find_block(page, &start_block, &region);
> > > +	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
> > > +		return;
> > > +
> > > +	end_block = start_block + order_to_num_blocks(order) * region->block_size;
> > > +
> > > +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> > > +	for (block = start_block; block < end_block; block += region->block_size) {
> > > +		if (WARN_ONCE(!tag_storage_block_is_reserved(block),
> > > +		    "Block 0x%lx is not reserved for pfn 0x%lx", block, page_to_pfn(page)))
> > > +			continue;
> > > +
> > > +		if (block_ref_sub_return(block, region, order) == 1) {
> > > +			__xa_erase(&tag_blocks_reserved, block);
> > > +			free_contig_range(block, region->block_size);
> > > +		}
> > > +	}
> > > +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> > > +}
> > > diff --git a/fs/proc/page.c b/fs/proc/page.c
> > > index 195b077c0fac..e7eb584a9234 100644
> > > --- a/fs/proc/page.c
> > > +++ b/fs/proc/page.c
> > > @@ -221,6 +221,7 @@ u64 stable_page_flags(struct page *page)
> > >  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> > >  	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> > >  	u |= kpf_copy_bit(k, KPF_ARCH_3,	PG_arch_3);
> > > +	u |= kpf_copy_bit(k, KPF_ARCH_4,	PG_arch_4);
> > >  #endif
> > >  
> > >  	return u;
> > > diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
> > > index 859f4b0c1b2b..4a0d719ffdd4 100644
> > > --- a/include/linux/kernel-page-flags.h
> > > +++ b/include/linux/kernel-page-flags.h
> > > @@ -19,5 +19,6 @@
> > >  #define KPF_SOFTDIRTY		40
> > >  #define KPF_ARCH_2		41
> > >  #define KPF_ARCH_3		42
> > > +#define KPF_ARCH_4		43
> > >  
> > >  #endif /* LINUX_KERNEL_PAGE_FLAGS_H */
> > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > index a88e64acebfe..7915165a51bd 100644
> > > --- a/include/linux/page-flags.h
> > > +++ b/include/linux/page-flags.h
> > > @@ -135,6 +135,7 @@ enum pageflags {
> > >  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> > >  	PG_arch_2,
> > >  	PG_arch_3,
> > > +	PG_arch_4,
> > >  #endif
> > >  	__NR_PAGEFLAGS,
> > >  
> > > diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> > > index 6ca0d5ed46c0..ba962fd10a2c 100644
> > > --- a/include/trace/events/mmflags.h
> > > +++ b/include/trace/events/mmflags.h
> > > @@ -125,7 +125,8 @@ IF_HAVE_PG_HWPOISON(hwpoison)						\
> > >  IF_HAVE_PG_IDLE(idle)							\
> > >  IF_HAVE_PG_IDLE(young)							\
> > >  IF_HAVE_PG_ARCH_X(arch_2)						\
> > > -IF_HAVE_PG_ARCH_X(arch_3)
> > > +IF_HAVE_PG_ARCH_X(arch_3)						\
> > > +IF_HAVE_PG_ARCH_X(arch_4)
> > >  
> > >  #define show_page_flags(flags)						\
> > >  	(flags) ? __print_flags(flags, "|",				\
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index f31f02472396..9beead961a65 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2474,6 +2474,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
> > >  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> > >  			 (1L << PG_arch_2) |
> > >  			 (1L << PG_arch_3) |
> > > +			 (1L << PG_arch_4) |
> > >  #endif
> > >  			 (1L << PG_dirty) |
> > >  			 LRU_GEN_MASK | LRU_REFS_MASK));
> > > -- 
> > > 2.42.1
> > > 
> > > 
> 
> 
> 

------xhiRNYr7C6p2kRFttE2KPojvpONXRQ6l4raSmD__Jn20cHwF=_9337f_
Content-Type: text/plain; charset="utf-8"


------xhiRNYr7C6p2kRFttE2KPojvpONXRQ6l4raSmD__Jn20cHwF=_9337f_--

