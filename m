Return-Path: <linux-fsdevel+bounces-66848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65FC2D674
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 18:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA76D4EFF31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEBF31A7FF;
	Mon,  3 Nov 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJhFr/4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F313316196;
	Mon,  3 Nov 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189998; cv=none; b=D9kypK7NoH4wycShFzhc3sTcXzjcxw1i11rhX/jKWIRZICIXorW4CbDlpEtOvyG88d18ig0PKxIEZ8BCbnCiDYggO+mJgygj58GneRpZCHkYjhAQc+wZELQn0HS4a75igQUZGebFUdx9bjOd2e1mFXe4nxi0+4P8YRu+sROy2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189998; c=relaxed/simple;
	bh=Nfuy/Y5/u2wXbohcwDnEdJwCaH6aPns6pDI6CT+NKiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIr7gBgf3rre9xnfgcZHDW8yZKWqPgy10zhp/tld0VxiL5U85I8l13fEOGK0xkpsCb3mboyMcMIIz8Edke39t2fLdiMzTJ9BZOzmI83G+MvlFgQOuhNjPuboPuoH3UhfP23lLEACCdiSnLBN7fJ22sH2AGhkH2co+rs4nAvo5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJhFr/4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DACC4CEFD;
	Mon,  3 Nov 2025 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189997;
	bh=Nfuy/Y5/u2wXbohcwDnEdJwCaH6aPns6pDI6CT+NKiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jJhFr/4QOzl07oYJgTxRVXnu7lH/ADPT5cwLT8TT0RAqTTwD8y7szPqcE45ge8DS3
	 JiB/kaIEV/Fpep2QN3jnRLPozz0+3jDHsMz9xCiiC5WJVUXUKtkm/yLNjDJ4jOlD9C
	 yqlEQXnjfHZMSDuZUnDIcyzWqVC8UhurlXx0UJE9WbFeKFaUPjHTOc/eE4uf80j75e
	 bsp1fsSgNxIM5Bk9gAqLrfwSaIhTS1c3NXbg/FmzOV5aVrOVvYa/oxNVKDsCtYwSMk
	 9jSbYnjSZYhjx5b+yvioev2VaOq/I6LTAN/TqRkthfpZeMAbJA9SK49h30Z2muZ8bO
	 PABGgddLWtCzw==
Message-ID: <6c34ce4e-1212-4dd0-8b7c-6af952dda3cb@kernel.org>
Date: Mon, 3 Nov 2025 18:13:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] mm/selftests: add max_vma_count tests
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: rostedt@goodmis.org, hughd@google.com, kernel-team@android.com,
 android-mm@google.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251028212528.681081-1-kaleshsingh@google.com>
 <20251028212528.681081-3-kaleshsingh@google.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251028212528.681081-3-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 22:24, Kalesh Singh wrote:
> Add a new selftest to verify that the max VMA count limit is correctly
> enforced.
> 
> This test suite checks that various VMA operations (mmap, mprotect,
> munmap, mremap) succeed or fail as expected when the number of VMAs is
> close to the sysctl_max_map_count limit.
> 
> The test works by first creating a large number of VMAs to bring the
> process close to the limit, and then performing various operations that
> may or may not create new VMAs. The test then verifies that the
> operations that would exceed the limit fail, and that the operations
> that do not exceed the limit succeed.
> 
> NOTE: munmap is special as it's allowed to temporarily exceed the limit
> by one for splits as this will decrease back to the limit once the unmap
> succeeds.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

[...]

No capacity to review the tests in detail :(

> +
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index d9173f2312b7..a85db61e6a92 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -49,6 +49,8 @@ separated by spaces:
>   	test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
>   - madv_populate
>   	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
> +- max_vma_count
> +	tests for max vma_count
>   - memfd_secret
>   	test memfd_secret(2)
>   - process_mrelease
> @@ -426,6 +428,9 @@ fi # VADDR64
>   # vmalloc stability smoke test
>   CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
>   
> +# test operations against max vma count limit
> +CATEGORY="max_vma_count" run_test ./max_vma_count_tests

I'd just call it CATEGORY="vma" or "vma_handling".

Which makes me wodnering whether "vma_merge" falls into the same category.

Smalls like mremap test is similar.

Point is that "CATEGORY" stops being really useful if we end up having a 
separate category for each test, right? :)

-- 
Cheers

David

