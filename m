Return-Path: <linux-fsdevel+bounces-54334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2196AFE1DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 10:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20674189380A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA023C4EC;
	Wed,  9 Jul 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="XX6tE8mN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEEB2222C3;
	Wed,  9 Jul 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048256; cv=none; b=MvyIuoHtxQkKV75frKMJB6PFZkgs/LPrRxEOEvBmgei+9dN7NTnelN1caxrZza86eGUUgrHMqFIxsbFECdQ+udw4FPqa/jadY2yByyby0RDgyWl0uPh4McT19BzPN+UYlb5kOL9xSOWzEeYWwU+dmqIXVUx+YjIpgU7ZTL3ZzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048256; c=relaxed/simple;
	bh=4dvYtEbOtmwJ+1IDZR1sB8eZS1Ly2JkBVTnZJvK2PIQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VynYzggDkhbBGBUlE+hdwkt22HMwOjBl3qj7CTiLzf4icX9im4M+XYg0pWhJnsCUJJACpUvhWmfSNbC+WOMdsfkjTzFZ1aEjwRdTxLgAQj92DxFwuRAIM8fjOdwZtEaTvfH5kfzdhVJmuEXDFfA2tT3UWsuQycAnooFkfCGL0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=XX6tE8mN; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bcVqT1NHrz9v7v;
	Wed,  9 Jul 2025 10:04:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752048245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALSg0QD8uRphF8/oxSCVKyEeBf8l1V1KzIwjcnUWqG4=;
	b=XX6tE8mNF+WRKfctp233Q8R5d91TxrSW4Wp3rGRmG54yh6tmy+CFbWrPNd+Zxh3E6r61oW
	AAO6pSiq3hgyjQoPgOTVlYVSaYOYmU0sHh464sOvk/a8L4wxIviL21atL97v2h7wb+4qQT
	N1dgVpUunhtHFZt8zr1YzsAVmBchkWdqzASoGoLxpiMma+IRXD7ZxSjyIEcwkYGIGdv9/C
	NoumHmmkQIUWS37PTQQuspEbghG9yPS8SeNO8KamONfeHEG/6kw/Zbmw+35SnHmKojck1Q
	L9EpOxY1u8Z3e0xocCbgBoOKqGbTR/enWahc5qCdqO4Uj9URDKeGtsDgMOkhgw==
Message-ID: <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
Date: Wed, 9 Jul 2025 10:03:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pankaj Raghav <kernel@pankajraghav.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Zi Yan <ziy@nvidia.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
Content-Language: en-US
In-Reply-To: <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zi,

>> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate the huge_zero_folio via 
>> memblock, and it will never be freed.
> 
> Do the above users want a PMD sized zero page or a 2MB zero page? Because on systems with non 
> 4KB base page size, e.g., ARM64 with 64KB base page, PMD size is different. ARM64 with 64KB base 
> page has 512MB PMD sized pages. Having STATIC_PMD_ZERO_PAGE means losing half GB memory. I am 
> not sure if it is acceptable.
> 

That is a good point. My intial RFC patches allocated 2M instead of a PMD sized
page.

But later David wanted to reuse the memory we allocate here with huge_zero_folio. So
if this config is enabled, we simply just use the same pointer for huge_zero_folio.

Since that happened, I decided to go with PMD sized page.

This config is still opt in and I would expect the users with 64k page size systems to not enable
this.

But to make sure we don't enable this for those architecture, I could do a per-arch opt in with
something like this[1] that I did in my previous patch:

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 340e5468980e..c3a9d136ec0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -153,6 +153,7 @@ config X86
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
 	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_HAS_STATIC_PMD_ZERO_PAGE	if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select BUILDTIME_TABLE_SORT


diff --git a/mm/Kconfig b/mm/Kconfig
index 781be3240e21..fd1c51995029 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -826,6 +826,19 @@ config ARCH_WANTS_THP_SWAP
 config MM_ID
 	def_bool n

+config ARCH_HAS_STATIC_PMD_ZERO_PAGE
+	def_bool n
+
+config STATIC_PMD_ZERO_PAGE
+	bool "Allocate a PMD page for zeroing"
+	depends on ARCH_HAS_STATIC_PMD_ZERO_PAGE
<snip>

Let me know your thoughts.

[1] https://lore.kernel.org/linux-mm/20250612105100.59144-4-p.raghav@samsung.com/#Z31mm:Kconfig
--
Pankaj

