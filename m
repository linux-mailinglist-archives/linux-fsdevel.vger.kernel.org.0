Return-Path: <linux-fsdevel+bounces-79584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL6jJaGvqmm6VQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 11:42:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7BB21F074
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 11:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEEA93073DB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C62B34AAE9;
	Fri,  6 Mar 2026 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJbvRGyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFC3254B3;
	Fri,  6 Mar 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793577; cv=none; b=eCZqG6GpwoHgvx4JXM1uHzcpHgmI3AIOy3YuT8B7B9dy3/4CoR9U5/EvCIizHZ2Is+RP9Y7DACHx1jp6UUs5Hg3BBJSN7PbcW0XlPvKlfLVGD1/NShB4v6/Id+4vKTpk21CTAq56zyL1N2RcTuueXFf5rMLMWYsyvXlgrMK3khg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793577; c=relaxed/simple;
	bh=HWwbH/t+EtL/YKU6xmIeyjMDydOLWAaX0fFteuDV06s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBXLwKlIMcGzKcyicCtpFV4qjP1iWX+W9URUhJRwyWMSdkohm9b3Z6JWMERZT/yBSIr3ztZm8m8CK0tgp9lkjnIAul44RqrsWfc93fpAWrOcRRjWvvHhtwWu5sD5ay9r+ohIOLLt9Y12Jgr9KEVCxpCAmmbY8Jony/hx59CSn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJbvRGyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A179C4CEF7;
	Fri,  6 Mar 2026 10:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772793577;
	bh=HWwbH/t+EtL/YKU6xmIeyjMDydOLWAaX0fFteuDV06s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJbvRGynfZrP5aroIZ/D3g6XrllqG61UIy10x+vwEaV39i30AtfmvOcyfoi7v2mmW
	 y1Xnm+jB8AVRruQHrKncfbXDv3cZCHtTsMg0V+5BJ7RcZkzKKtj1BtMp2DY9j/jgbE
	 NK17i2s8TexnEXLGLKX9dIJP4F3t5Zr12krew+KlKhFjw3nuWhg4J5egqTMyU7ahis
	 tmHibWMx54gZVJiQ2oP3a/DO2978orcPz/qhBfev0C1IqolbZFGTuObSQHf+NXqNq3
	 ioidRrZCulU4LmNtsTf6SPvIbGaVav9Of0y+QC2a7CDCiiWDHZi6N7VuExHwhqa928
	 6z9cpEMXTEWPQ==
Date: Fri, 6 Mar 2026 10:39:34 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Usama Arif <usamaarif642@gmail.com>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] docs: filesystems: clarify KernelPageSize vs.
 MMUPageSize in smaps
Message-ID: <5d01642d-1b39-48fe-870f-a261930aa3f7@lucifer.local>
References: <20260306081916.38872-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306081916.38872-1-david@kernel.org>
X-Rspamd-Queue-Id: 3B7BB21F074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79584-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,nvidia.com,linux.dev,kernel.org,linux-foundation.org,oracle.com,linux.alibaba.com,redhat.com,arm.com,lwn.net,linuxfoundation.org,gmail.com,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:19:16AM +0100, David Hildenbrand (Arm) wrote:
> There was recently some confusion around THPs and the interaction with
> KernelPageSize / MMUPageSize. Historically, these entries always
> correspond to the smallest size we could encounter, not any current
> usage of transparent huge pages or larger sizes used by the MMU.
>
> Ever since we added THP support many, many years ago, these entries
> would keep reporting the smallest (fallback) granularity in a VMA.
>
> For this reason, they default to PAGE_SIZE for all VMAs except for
> VMAs where we have the guarantee that the system and the MMU will
> always use larger page sizes. hugetlb, for example, exposes a custom
> vm_ops->pagesize callback to handle that. Similarly, dax/device
> exposes a custom vm_ops->pagesize callback and provides similar
> guarantees.
>
> Let's clarify the historical meaning of KernelPageSize / MMUPageSize,
> and point at "AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped"
> regarding PMD entries.
>
> While at it, document "FilePmdMapped", clarify what the "AnonHugePages"
> and "ShmemPmdMapped" entries really mean, and make it clear that there
> are no other entries for other THP/folio sizes or mappings.
>
> Also drop the duplicate "KernelPageSize" and "MMUPageSize" entries in
> the example.
>
> Link: https://lore.kernel.org/all/20260225232708.87833-1-ak@linux.intel.com/
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reads great now, thanks very much! So:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>
> v1 -> v2:
> * Some rewording and clarifications
> * Drop duplicate entries in the example
>
> ---
>  Documentation/filesystems/proc.rst | 40 +++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index b0c0d1b45b99..e2d22a424dcd 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -464,26 +464,37 @@ Memory Area, or VMA) there is a series of lines such as the following::
>      KSM:                   0 kB
>      LazyFree:              0 kB
>      AnonHugePages:         0 kB
> +    FilePmdMapped:         0 kB
>      ShmemPmdMapped:        0 kB
>      Shared_Hugetlb:        0 kB
>      Private_Hugetlb:       0 kB
>      Swap:                  0 kB
>      SwapPss:               0 kB
> -    KernelPageSize:        4 kB
> -    MMUPageSize:           4 kB
>      Locked:                0 kB
>      THPeligible:           0
>      VmFlags: rd ex mr mw me dw
>
>  The first of these lines shows the same information as is displayed for
>  the mapping in /proc/PID/maps.  Following lines show the size of the
> -mapping (size); the size of each page allocated when backing a VMA
> -(KernelPageSize), which is usually the same as the size in the page table
> -entries; the page size used by the MMU when backing a VMA (in most cases,
> -the same as KernelPageSize); the amount of the mapping that is currently
> -resident in RAM (RSS); the process's proportional share of this mapping
> -(PSS); and the number of clean and dirty shared and private pages in the
> -mapping.
> +mapping (size); the smallest possible page size allocated when backing a
> +VMA (KernelPageSize), which is the granularity in which VMA modifications
> +can be performed; the smallest possible page size that could be used by the
> +MMU (MMUPageSize) when backing a VMA; the amount of the mapping that is
> +currently resident in RAM (RSS); the process's proportional share of this
> +mapping (PSS); and the number of clean and dirty shared and private pages
> +in the mapping.
> +
> +"KernelPageSize" always corresponds to "MMUPageSize", except when a larger
> +kernel page size is emulated on a system with a smaller page size used by the
> +MMU, which is the case for some PPC64 setups with hugetlb.  Furthermore,
> +"KernelPageSize" and "MMUPageSize" always correspond to the smallest
> +possible granularity (fallback) that can be encountered in a VMA throughout
> +its lifetime.  These values are not affected by Transparent Huge Pages
> +being in effect, or any usage of larger MMU page sizes (either through
> +architectural huge-page mappings or other explicit/implicit coalescing of
> +virtual ranges performed by the MMU).  "AnonHugePages", "ShmemPmdMapped" and
> +"FilePmdMapped" provide insight into the usage of PMD-level architectural
> +huge-page mappings.
>
>  The "proportional set size" (PSS) of a process is the count of pages it has
>  in memory, where each page is divided by the number of processes sharing it.
> @@ -528,10 +539,15 @@ pressure if the memory is clean. Please note that the printed value might
>  be lower than the real value due to optimizations used in the current
>  implementation. If this is not desirable please file a bug report.
>
> -"AnonHugePages" shows the amount of memory backed by transparent hugepage.
> +"AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped" show the amount of
> +memory backed by Transparent Huge Pages that are currently mapped by
> +architectural huge-page mappings at the PMD level. "AnonHugePages"
> +corresponds to memory that does not belong to a file, "ShmemPmdMapped" to
> +shared memory (shmem/tmpfs) and "FilePmdMapped" to file-backed memory
> +(excluding shmem/tmpfs).
>
> -"ShmemPmdMapped" shows the amount of shared (shmem/tmpfs) memory backed by
> -huge pages.
> +There are no dedicated entries for Transparent Huge Pages (or similar concepts)
> +that are not mapped by architectural huge-page mappings at the PMD level.
>
>  "Shared_Hugetlb" and "Private_Hugetlb" show the amounts of memory backed by
>  hugetlbfs page which is *not* counted in "RSS" or "PSS" field for historical
> --
> 2.43.0
>

