Return-Path: <linux-fsdevel+bounces-29066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5805B974793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 02:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C8C1F25E3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 00:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0018C3E;
	Wed, 11 Sep 2024 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="PfU+CRym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE63BBA20;
	Wed, 11 Sep 2024 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015793; cv=none; b=fGvvG5NDrKrcdBm0kf/6PaYPl9sz3mCHAdMmrLorqBvd8WR4BoGjyce03HQZL78kDunPUGWse8/mzTCmx9Iiw76Q0929HHsk/mw7dWlzknToikwFaFu8VgMSkv5P7CsYwoCI1PifmUAtNXGDQm1iU20xrA8rDtCefutogk8Omk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015793; c=relaxed/simple;
	bh=dH7fv14lgnC0D0A5OnxBGGxWTkAjfmvEzxeklRot7jA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=J4urWD9EEVnvFtLwxlG/iRZNMXXEkyRg/u22lGDm0rk43AcI8HcgF7qsOapRqprm5+m3F+YKIG+9VpS/oO7k+GJvxhbm3JePIxFykA11JFRjM/araytNFymkEhfWdH9nIsuaeEcdJnUJUIg90iHi3oL5ORVtm+je8pyOTS4fPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=PfU+CRym; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=nTtMb9H3dXUpUSnSef+Be8oMvAgnwIOToyszkwVy8e4=; b=PfU+CRymWcXZGU8mYwkDuJY5Nt
	KxhnN6hTdnUpKK6c3FLfnreXMcwDl5uXgI0f+QVr9IAL/a7U4alJzvox0Hu/jx8FdVvfCvk6K23RF
	lK8vn7f2TcsKwePi8XAAm+Do+v3+uwGtpS1ailTPFQB4bfs203NzQnnCCUXb/sMVlet5HU1E6m9vy
	zcwHt8C4DgCDQe3olE14BG0oSvKMkpTZrdceJIxDReKKpwni+aYI+Z20uWIsMZDYZ8HVFkh+hCtJv
	YV4oSurTolqbMlZJN15P2PVDkvC2Zg5xnEPszFLT8tR9OOrTm8xYZG/nJd2oKo02MXEmzvmD9xZuB
	l6TfHBVA==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1soBXi-000ozM-2O;
	Tue, 10 Sep 2024 18:49:11 -0600
Message-ID: <6f3402ae-01ad-4764-8941-f88bc77f5227@deltatee.com>
Date: Tue, 10 Sep 2024 18:48:48 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
 linux-mm@kvack.org
Cc: vishal.l.verma@intel.com, dave.jiang@intel.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <4f8326d9d9e81f1cb893c2bd6f17878b138cf93d.1725941415.git-series.apopple@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <4f8326d9d9e81f1cb893c2bd6f17878b138cf93d.1725941415.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: apopple@nvidia.com, dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 02/12] pci/p2pdma: Don't initialise page refcount to one
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-09-09 22:14, Alistair Popple wrote:
> The reference counts for ZONE_DEVICE private pages should be
> initialised by the driver when the page is actually allocated by the
> driver allocator, not when they are first created. This is currently
> the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
> but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/pci/p2pdma.c |  6 ++++++
>  mm/memremap.c        | 17 +++++++++++++----
>  mm/mm_init.c         | 22 ++++++++++++++++++----
>  3 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4f47a13..210b9f4 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -129,6 +129,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  	}
>  
>  	/*
> +	 * Initialise the refcount for the freshly allocated page. As we have
> +	 * just allocated the page no one else should be using it.
> +	 */
> +	set_page_count(virt_to_page(kaddr), 1);
> +
> +	/*
>  	 * vm_insert_page() can sleep, so a reference is taken to mapping
>  	 * such that rcu_read_unlock() can be done before inserting the
>  	 * pages
This seems to only set reference count to the first page, when there can
be more than one page referenced by kaddr.

I suspect the page count adjustment should be done in the for loop
that's a few lines lower than this.

I think a similar mistake was made by other recent changes.

Thanks,

Logan

