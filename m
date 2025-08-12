Return-Path: <linux-fsdevel+bounces-57491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3561CB2229C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B941885323
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC92E7171;
	Tue, 12 Aug 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBWJYBmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355172E719A;
	Tue, 12 Aug 2025 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990044; cv=none; b=Ghd6dzRecmv83yRX3VhGVo3wODu/ay3t26Tq8ZNyqGABG4qOnZ5Gm58KE5kID7UT17TOoy6g870ZVE4s9H30xXsTssW+dGHcIBvW+k1ZVxLSkGWvlaWViti0nZzDg/+xlnM4R4kt2hQ886hcf4mN1cvjS+P+vMS2xLDn2hsJcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990044; c=relaxed/simple;
	bh=3mrPt0k6oW37kVZVWbgrQe36tlhm9WafzeCVJIhfXxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhKajoKyEnEv8B5L5KGAczNiPAt1clWx+ga+PjVlG/Q/4lrHWLcTlWgvtU7+Fa+UP+feNn0anBnq6V+T/vRN7hfGPtfC2qbf0gJeqOpuA1gq5LZZk76+EminnOXwU0k3w4j2aZ23QyPPNcHPB2ZGvYYWKYl7NR3WhrBgZGPTo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBWJYBmg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754990043; x=1786526043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3mrPt0k6oW37kVZVWbgrQe36tlhm9WafzeCVJIhfXxE=;
  b=nBWJYBmgB+EcROEe17MUBannMjeyZ04Qud6IA+sXEu+GZf+ldO2LpQ/Q
   4wsrSh5ACHQopzhz4VN4i+1oTejtDI80/Klg2sStqf3TDD6KzAjqJgZw7
   uhUx8Tv02BhHRFaKtknr+Wqxaotq8Ha3NU29YMFHc7gwG1ySVsKmE+mR/
   rbEAPVJCrcwaLNsczTysmN50b0XfWPaKTOi2CFNASkCofbroFwwZuf50L
   /fTCFRG6ea82gwRVXbGsVoQlDwA3BWM3kwUoV7uOm980uFICEY/KQ0q7q
   EPe91ni1hLKLf3Oxv/fAD1h2iB2/3eYRAfoB+qQzCOkCPENg8SkmGvbwg
   Q==;
X-CSE-ConnectionGUID: yID9FercTVSMi5OguOhtOg==
X-CSE-MsgGUID: t8AL5RymQM+6gOYU1tz3qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67965352"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67965352"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 02:14:02 -0700
X-CSE-ConnectionGUID: wxjRK0m0SJGHwZm8ovjW8g==
X-CSE-MsgGUID: DmYbdTZ1Qkq8kRQ6zTZidw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166943956"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 02:13:33 -0700
Date: Tue, 12 Aug 2025 12:13:26 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
	ajones@ventanamicro.com, akpm@linux-foundation.org,
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, bfoster@redhat.com,
	binbin.wu@linux.intel.com, brauner@kernel.org,
	catalin.marinas@arm.com, chao.p.peng@intel.com,
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com,
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, graf@amazon.com,
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	kirill.shutemov@intel.com, liam.merwick@oracle.com,
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name,
	maz@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com,
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com,
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com,
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com,
	pvorel@suse.cz, qperret@google.com, quic_cvanscha@quicinc.com,
	quic_eberman@quicinc.com, quic_mnalajal@quicinc.com,
	quic_pderrin@quicinc.com, quic_pheragu@quicinc.com,
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com,
	rientjes@google.com, roypat@amazon.co.uk, rppt@kernel.org,
	seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com,
	thomas.lendacky@amd.com, usama.arif@bytedance.com,
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v2 32/51] KVM: guest_memfd: Support guestmem_hugetlb
 as custom allocator
Message-ID: <aJsFtq-vLmCWHT06@tlindgre-MOBL1>
References: <cover.1747264138.git.ackerleytng@google.com>
 <4d16522293c9a3eacdbe30148b6d6c8ad2eb5908.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d16522293c9a3eacdbe30148b6d6c8ad2eb5908.1747264138.git.ackerleytng@google.com>

Hi,

On Wed, May 14, 2025 at 04:42:11PM -0700, Ackerley Tng wrote:
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -133,3 +133,8 @@ config KVM_GMEM_SHARED_MEM
>         select KVM_GMEM
>         bool
>         prompt "Enables in-place shared memory for guest_memfd"
> +
> +config KVM_GMEM_HUGETLB
> +       select KVM_PRIVATE_MEM
> +       depends on GUESTMEM_HUGETLB
> +       bool "Enables using a custom allocator with guest_memfd, see CONFIG_GUESTMEM_HUGETLB"

For v3, this needs s/KVM_PRIVATE_MEM/KVM_GMEM/ assuming the patches are
based on "KVM: Rename CONFIG_KVM_PRIVATE_MEM to CONFIG_KVM_GMEM".

Also probably good idea to run some make randconfig builds on the series to
check the various Kconfig changes and inline functions for build errors.

Regards,

Tony

