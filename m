Return-Path: <linux-fsdevel+bounces-79474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBuGNMlfqWnj6QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:49:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8977A20FF83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1300D3072A53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F97A37A485;
	Thu,  5 Mar 2026 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8iMxX5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90436404A;
	Thu,  5 Mar 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707620; cv=none; b=eMppiopIZ493GYJYhm5+fo+1o/2qRs2cYwlxvGb/tZTt65bPE47DnghQvfhWhPBzOxf6icRuJ+KiBedcyJuXYpCxQguPT8K86+qWu2XS+Y0sn3Bre1bzzq9i0nCIfROAm9F/z7Ws2lr8O6oRRVlI7nvYRtAVXuD8BBCSTEH4ul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707620; c=relaxed/simple;
	bh=fKOrLuMwio1ZP0YPBsS9inqCOMrl5JjAkwjIp9f4jAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz792yI0dSzqxKQPOLLzAcJzuj/T81LvPkcLxLPYthB/7Bsd5NgfYnDA72L7PSU5FEkoWwRFGeGMcZBNuIqyXQpKenfKpjbX7p7BR0TsWIhzsoUG3SsEM1Pn2n2LGfG/RsVae0YiuaPXUZCTeHETEvWx45PXojcHmFTAAlvQGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8iMxX5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A19C116C6;
	Thu,  5 Mar 2026 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707620;
	bh=fKOrLuMwio1ZP0YPBsS9inqCOMrl5JjAkwjIp9f4jAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8iMxX5nSzneOSi9DkWzhHtCk3Bken5y71jhO21gleP/c48oYbeayMLPMHsuL12JA
	 wF94j45h8dI+3TNWOoFhQspiV32f2HKTRjYN1NFX7eWGSjyJ66KA+WrrZstwjrHCP6
	 p3f0Wfu8IX7Sy1s+jLr4AGoI5oJfRQFN9DMLGyyRjW4AQoHnMhNBSFdh71iEdfsT7n
	 2lmqiBbKrnynCaD1Y6GsxPJq0EO8HTAwOnWoXOOMhBTJpPJJe/FBnCCocCfxn73LRI
	 nV2+QniAS3KN6RQEeKnoVoaRlR4X2EpYY6ZW+ogBDifX1F25fQ8U5dUgxnJKQ5kWVJ
	 m1etZQ4+03aBQ==
Date: Thu, 5 Mar 2026 10:46:57 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Usama Arif <usamaarif642@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1] docs: filesystems: clarify KernelPageSize vs.
 MMUPageSize in smaps
Message-ID: <b24be8c2-32d3-4e3e-9fbf-8a0068c360d6@lucifer.local>
References: <20260304155636.77433-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304155636.77433-1-david@kernel.org>
X-Rspamd-Queue-Id: 8977A20FF83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79474-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,kernel.org,linux.dev,lwn.net,linuxfoundation.org,gmail.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 04:56:36PM +0100, David Hildenbrand (Arm) wrote:
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
> Link: https://lore.kernel.org/all/20260225232708.87833-1-ak@linux.intel.com/
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

Overall this is great, some various nits and comments below so we can tweak it.

Cheers, Lorenzo

> ---
>  Documentation/filesystems/proc.rst | 37 ++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index b0c0d1b45b99..0f67e47528fc 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -464,6 +464,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
>      KSM:                   0 kB
>      LazyFree:              0 kB
>      AnonHugePages:         0 kB
> +    FilePmdMapped:         0 kB
>      ShmemPmdMapped:        0 kB
>      Shared_Hugetlb:        0 kB
>      Private_Hugetlb:       0 kB
> @@ -477,13 +478,25 @@ Memory Area, or VMA) there is a series of lines such as the following::
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
> +mapping (size); the smallest possible page size allocated when
> +backing a VMA (KernelPageSize), which is the granularity in which VMA
> +modifications can be performed; the smallest possible page size that could
> +be used by the MMU (MMUPageSize) when backing a VMA; the amount of the

Is it worth retaining 'in most cases the same as KernelPageSize' here?

Ah wait you dedicate a whole paragraph after this to tha :)

> +mapping that is currently resident in RAM (RSS); the process's proportional
> +share of this mapping (PSS); and the number of clean and dirty shared and
> +private pages in the mapping.
> +
> +Historically, the "KernelPageSize" always corresponds to the "MMUPageSize",
> +except when a larger kernel page size is emulated on a system with a smaller

NIT: is -> was, as historically implies past tense.

But it's maybe better to say:

+Historically, the "KernelPageSize" has always corresponded to the "MMUPageSize",

And:

+except when a larger kernel page size is being emulated on a system with a smaller

> +page size used by the MMU, which was the case for PPC64 in the past.
> +Further, "KernelPageSize" and "MMUPageSize" always correspond to the

NIT: Further -> Furthermore

> +smallest possible granularity (fallback) that could be encountered in a

could be -> can be

Since we are really talking about the current situation, even if this, is
effect, a legacy thing.

> +VMA throughout its lifetime.  These values are not affected by any current
> +transparent grouping of pages by Linux (Transparent Huge Pages) or any

'transparent grouping of pages' reads a bit weirdly.

Maybe simplify to:

+These values are not affected by Transparent Huge Pages being in effect, or any...

> +current usage of larger MMU page sizes (either through architectural

NIT: current usage -> usage

> +huge-page mappings or other transparent groupings done by the MMU).

Again I think 'transparent groupings' is a bit unclear. Perhaps instead:

+huge-page mappings or other explicit or implicit coalescing of virtual ranges
+performed by the MMU).

?

> +"AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped" provide insight into
> +the usage of some architectural huge-page mappings.

Is 'some' necessary here? Seems to make it a bit vague.

>
>  The "proportional set size" (PSS) of a process is the count of pages it has
>  in memory, where each page is divided by the number of processes sharing it.
> @@ -528,10 +541,14 @@ pressure if the memory is clean. Please note that the printed value might
>  be lower than the real value due to optimizations used in the current
>  implementation. If this is not desirable please file a bug report.
>
> -"AnonHugePages" shows the amount of memory backed by transparent hugepage.
> +"AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped" show the amount of
> +memory backed by transparent hugepages that are currently mapped through
> +architectural huge-page mappings (PMD). "AnonHugePages" corresponds to memory

'mapped through architectural huge-page mappings (PMD)' reads a bit strangely to
me,

Perhaps 'mapped by transparent huge pages at a PMD page table level' instead?

> +that does not belong to a file, "ShmemPmdMapped" to shared memory (shmem/tmpfs)
> +and "FilePmdMapped" to file-backed memory (excluding shmem/tmpfs).
>
> -"ShmemPmdMapped" shows the amount of shared (shmem/tmpfs) memory backed by
> -huge pages.
> +There are no dedicated entries for transparent huge pages (or similar concepts)
> +that are not mapped through architectural huge-page mappings (PMD).

similarly, perhaps better as 'are not mapped by transparent huge pages at a PMD
page table level'?

>
>  "Shared_Hugetlb" and "Private_Hugetlb" show the amounts of memory backed by
>  hugetlbfs page which is *not* counted in "RSS" or "PSS" field for historical
> --
> 2.43.0
>

