Return-Path: <linux-fsdevel+bounces-3572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED147F69B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 01:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932332814D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0F39B;
	Fri, 24 Nov 2023 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qoMKvIi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14110C8;
	Thu, 23 Nov 2023 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hdx62OaweghTuxJKy40I6uvLAL8EQr33RCrXQ1/BSAM=; b=qoMKvIi5r5oZJ2h7x8vFmUTFH/
	6RnF4ojppprty21w1nQzLV+gYTyUE4lCmMtNjsF2raI02Tj2zpioiEHk4QGyt4w80YieSspGf2fnF
	RdZRC9oVIcBI16G2r6MR/+OK8pEpqzFEY+VmTHuFOVKFA72Hxy3SU2K/MPEWO7wtkEbOOfJtCRU+t
	Fb+CxW/aGVJPIEp7iveJx5p/wbXkbqzEWI4vun00r/uijzTewRLZ4jBALwZ2C79tsCA5CFVU7WWfd
	rGLd+dPY6HGv0OOdqjDDJEBd7/1eXu2bHnuKHns+Wwyz2AEoYtVgn6u7VCekpLJN+iDWmcJTUKdYi
	FPaTQFTA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Juy-005rtQ-0Z;
	Fri, 24 Nov 2023 00:19:36 +0000
Message-ID: <de256121-f613-42d3-b267-9cd9fbfc8946@infradead.org>
Date: Thu, 23 Nov 2023 16:19:35 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/Kconfig: Make hugetlbfs a menuconfig
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, linux-fsdevel@vger.kernel.org
References: <20231123223929.1059375-1-peterx@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231123223929.1059375-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

BTW:

On 11/23/23 14:39, Peter Xu wrote:
> Hugetlb vmemmap default option (HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON)
> is a sub-option to hugetlbfs, but it shows in the same level as hugetlbfs
> itself, under "Pesudo filesystems".
> Make the vmemmap option a sub-option to hugetlbfs, by changing hugetlbfs
> into a menuconfig.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/Kconfig | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index fd1f655b4f1f..8636198a8689 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -254,7 +254,7 @@ config TMPFS_QUOTA
>  config ARCH_SUPPORTS_HUGETLBFS
>  	def_bool n
>  
> -config HUGETLBFS
> +menuconfig HUGETLBFS
>  	bool "HugeTLB file system support"
>  	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>  	depends on (SYSFS || SYSCTL)
> @@ -266,14 +266,7 @@ config HUGETLBFS
>  
>  	  If unsure, say N.
>  
> -config HUGETLB_PAGE
> -	def_bool HUGETLBFS
> -
> -config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> -	def_bool HUGETLB_PAGE
> -	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> -	depends on SPARSEMEM_VMEMMAP
> -
> +if HUGETLBFS
>  config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
>  	bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
>  	default n
> @@ -282,6 +275,15 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
>  	  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to

Is this small 'v'            ^ a typo?

thanks.

>  	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
>  	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
> +endif # HUGETLBFS
> +
> +config HUGETLB_PAGE
> +	def_bool HUGETLBFS
> +
> +config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +	def_bool HUGETLB_PAGE
> +	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
> +	depends on SPARSEMEM_VMEMMAP
>  
>  config ARCH_HAS_GIGANTIC_PAGE
>  	bool

-- 
~Randy

