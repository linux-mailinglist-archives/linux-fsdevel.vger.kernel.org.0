Return-Path: <linux-fsdevel+bounces-45-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA67C4D54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614511C20F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520C1A70E;
	Wed, 11 Oct 2023 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xoK9v6Aq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zzSLTWf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B651A704
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:35:35 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8FA93;
	Wed, 11 Oct 2023 01:35:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 647541FDE0;
	Wed, 11 Oct 2023 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697013332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQCMhVkGK0KEiWJk03Hrnl55AUUio//OS/Yw6YhNLx4=;
	b=xoK9v6AqjGyzyqqdwNNonK4Yq8cpD7QWWHef2vCkdTA3qiZdRHsad9OmHUs0Zi7sBiUhrn
	/eN3BxdfWSeU9O/3RbOi/7axgr1UPi2Y/coG7NJ25kspc3FOBirsdAcRx8PLl5o4ihRhTg
	NK6mUZcAadIflI/RsmdtWetg3GOI3Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697013332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQCMhVkGK0KEiWJk03Hrnl55AUUio//OS/Yw6YhNLx4=;
	b=zzSLTWf5sedJ06koAas/MG68a62y0FI4RA1N9u6JUFy8QeH9I0gheB7LeQuWmFFCe/7yHH
	g+snkQ2RK4Qzd5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42DCB138EF;
	Wed, 11 Oct 2023 08:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qiF0D1ReJmXAJAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Wed, 11 Oct 2023 08:35:32 +0000
Message-ID: <7b94fcb3-9ffe-1fc8-3f9d-6a7176069aeb@suse.cz>
Date: Wed, 11 Oct 2023 10:35:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] mm: abstract the vma_merge()/split_vma() pattern
 for mprotect() et al.
To: Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-fsdevel@vger.kernel.org
References: <cover.1696929425.git.lstoakes@gmail.com>
 <b9bf27ff9ac19985f9ce966b83a7dbbe25a31f9d.1696929425.git.lstoakes@gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b9bf27ff9ac19985f9ce966b83a7dbbe25a31f9d.1696929425.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 20:23, Lorenzo Stoakes wrote:
> mprotect() and other functions which change VMA parameters over a range
> each employ a pattern of:-
> 
> 1. Attempt to merge the range with adjacent VMAs.
> 2. If this fails, and the range spans a subset of the VMA, split it
>    accordingly.
> 
> This is open-coded and duplicated in each case. Also in each case most of
> the parameters passed to vma_merge() remain the same.
> 
> Create a new function, vma_modify(), which abstracts this operation,
> accepting only those parameters which can be changed.
> 
> To avoid the mess of invoking each function call with unnecessary
> parameters, create inline wrapper functions for each of the modify
> operations, parameterised only by what is required to perform the action.
> 
> We can also significantly simplify the logic - by returning the VMA if we
> split (or merged VMA if we do not) we no longer need specific handling for
> merge/split cases in any of the call sites.
> 
> Note that the userfaultfd_release() case works even though it does not
> split VMAs - since start is set to vma->vm_start and end is set to
> vma->vm_end, the split logic does not trigger.
> 
> In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
> - vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
> instance, this invocation will remain unchanged.
> 
> We eliminate a VM_WARN_ON() in mprotect_fixup() as this simply asserts that
> vma_merge() correctly ensures that flags remain the same, something that is
> already checked in is_mergeable_vma() and elsewhere, and in any case is not
> specific to mprotect().
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/userfaultfd.c   | 71 +++++++++++++---------------------------------
>  include/linux/mm.h | 60 +++++++++++++++++++++++++++++++++++++++
>  mm/madvise.c       | 26 +++--------------
>  mm/mempolicy.c     | 26 ++---------------
>  mm/mlock.c         | 25 +++-------------
>  mm/mmap.c          | 48 +++++++++++++++++++++++++++++++
>  mm/mprotect.c      | 29 +++----------------
>  7 files changed, 142 insertions(+), 143 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index a7c6ef764e63..911ab5740a52 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c

<snip>

> @@ -1671,26 +1651,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			uffd_wp_range(vma, start, vma_end - start, false);
>  
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, pgoff,
> -				 vma_policy(vma),
> -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> -		if (prev) {
> -			vma = prev;
> -			goto next;
> -		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> +					    new_flags, NULL_VM_UFFD_CTX);
> +		if (IS_ERR(vma)) {
> +			ret = PTR_ERR(prev);

This needs to be PTR_ERR(vma)? Probably v2 leftover.

> +			break;
>  		}
> -	next:
> +
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and


