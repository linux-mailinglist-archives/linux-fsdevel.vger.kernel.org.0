Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5A35EE84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349743AbhDNHgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 03:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349742AbhDNHgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:36:39 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AD6C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Apr 2021 00:36:17 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 30so9417764qva.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Apr 2021 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GaUGA4fr6Hw6htKmvc7pRm7Mf4SEh3Stb6wYmhoZJYc=;
        b=t0yPWPJIsk9iay3f2CjEur5aS0g5HrDnPX5DO68Ja7IQekWawUZ544b0fSkQYco7be
         vnU8kr7YEkZZt0eiWIBefJDSkXm89cJnISEiJnzeLqJ2gYwCKGkqbmo5OEK6ZIU0/65J
         Z+HFrJbiWfQgfszDKlJzeJHq4TfMBN1/WOyY8irdBKlaajGyw7t2MYab1icBCkowu1DV
         /U4Cz8JuXbckAMNKyI8IMicKc7kS2vcMomPSJLfPMT9t91R3mnL5QAeEtMgJ+Bk4xlGy
         M9FcaRdMqMJw8s8Wb+SgS6ciO+ppLJtYXq7rFqkYcEi39Cur0r+ZoEv5GmOWjAFPN5ly
         6nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GaUGA4fr6Hw6htKmvc7pRm7Mf4SEh3Stb6wYmhoZJYc=;
        b=AW08ILnqytJNOGN5jQsYWs1w6D2JaeKsQR1iLni1Mtvdgoj2puCcZ5e89RB8yemp52
         DCe58n5yifvHTV3y1hxhe6iOIWkPV9X64/uEmoSFoxmlfqca7J80yPVnkLxv3+uq8nrR
         M5DOO/R1w28GxrQYKS58UXHlO5s+PEiPO8EhP/YCQf3wZRs/gOvBYVXr83RIrN+wnLnL
         5x5X+tp7D/qckvVzOi/U450vWm6gO2vZH6SOl7lt5xKmfHJ1FN0lv64P7U7YXOJh39Qp
         DGvmTDWrF+rZSyGhLBmXzZa3IiOHR9yn09VpuAD9KO0U2ZUBWEz2E9hikgzP+SMbX1df
         27QA==
X-Gm-Message-State: AOAM530LGk6yzyovUkWRYQC5V1E5Y1axraGXVmmRIHFPsU6+EV4bfz2i
        i3qfjmXEQlYYCGDPVJGteFpMTQ==
X-Google-Smtp-Source: ABdhPJxl9GxGuvaLQKw76GkIfp3TxDRuj1LQ00uhUWr/sPOtwhRd5P7jxvFf1th4NEo5xR6Mn6Yu4A==
X-Received: by 2002:ad4:4c4a:: with SMTP id cs10mr14099368qvb.14.1618385776565;
        Wed, 14 Apr 2021 00:36:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o29sm1922309qtl.8.2021.04.14.00.36.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Apr 2021 00:36:16 -0700 (PDT)
Date:   Wed, 14 Apr 2021 00:36:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 3/9] userfaultfd/shmem: support minor fault registration
 for shmem
In-Reply-To: <20210413051721.2896915-4-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104132351350.9086@eggly.anvils>
References: <20210413051721.2896915-1-axelrasmussen@google.com> <20210413051721.2896915-4-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Apr 2021, Axel Rasmussen wrote:

> This patch allows shmem-backed VMAs to be registered for minor faults.
> Minor faults are appropriately relayed to userspace in the fault path,
> for VMAs with the relevant flag.
> 
> This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
> minor faults, though, so userspace doesn't yet have a way to resolve
> such faults.

This is a very odd way to divide up the series: an "Intermission"
half way through the implementation of MINOR/CONTINUE: this 3/9
makes little sense without the 4/9 to mm/userfaultfd.c which follows.

But, having said that, I won't object and Peter did not object, and
I don't know of anyone else looking here: it will only give each of
us more trouble to insist on repartitioning the series, and it's the
end state that's far more important to me and to all of us.

And I'll even seize on it, to give myself an intermission after
this one, until tomorrow (when I'll look at 4/9 and 9/9 - but
shall not look at the selftests ones at all).

Most of this is okay, except the mm/shmem.c part; and I've just now
realized that somewhere (whether in this patch or separately) there
needs to be an update to Documentation/admin-guide/mm/userfaultfd.rst
(admin-guide? how weird, but not this series' business to correct).

> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c                 |  6 +++---
>  include/uapi/linux/userfaultfd.h |  7 ++++++-
>  mm/memory.c                      |  8 +++++---
>  mm/shmem.c                       | 10 +++++++++-
>  4 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 14f92285d04f..9f3b8684cf3c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>  	}
>  
>  	if (vm_flags & VM_UFFD_MINOR) {
> -		/* FIXME: Add minor fault interception for shmem. */
> -		if (!is_vm_hugetlb_page(vma))
> +		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
>  			return false;
>  	}
>  
> @@ -1941,7 +1940,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>  	/* report all available features and ioctls to userland */
>  	uffdio_api.features = UFFD_API_FEATURES;
>  #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> -	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
> +	uffdio_api.features &=
> +		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
>  #endif
>  	uffdio_api.ioctls = UFFD_API_IOCTLS;
>  	ret = -EFAULT;
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index bafbeb1a2624..159a74e9564f 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -31,7 +31,8 @@
>  			   UFFD_FEATURE_MISSING_SHMEM |		\
>  			   UFFD_FEATURE_SIGBUS |		\
>  			   UFFD_FEATURE_THREAD_ID |		\
> -			   UFFD_FEATURE_MINOR_HUGETLBFS)
> +			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
> +			   UFFD_FEATURE_MINOR_SHMEM)
>  #define UFFD_API_IOCTLS				\
>  	((__u64)1 << _UFFDIO_REGISTER |		\
>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -185,6 +186,9 @@ struct uffdio_api {
>  	 * UFFD_FEATURE_MINOR_HUGETLBFS indicates that minor faults
>  	 * can be intercepted (via REGISTER_MODE_MINOR) for
>  	 * hugetlbfs-backed pages.
> +	 *
> +	 * UFFD_FEATURE_MINOR_SHMEM indicates the same support as
> +	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for shmem-backed pages instead.
>  	 */
>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
> @@ -196,6 +200,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_SIGBUS			(1<<7)
>  #define UFFD_FEATURE_THREAD_ID			(1<<8)
>  #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
> +#define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>  	__u64 features;
>  
>  	__u64 ioctls;
> diff --git a/mm/memory.c b/mm/memory.c
> index 4e358601c5d6..cc71a445c76c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3972,9 +3972,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  	 * something).
>  	 */
>  	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
> -		ret = do_fault_around(vmf);
> -		if (ret)
> -			return ret;
> +		if (likely(!userfaultfd_minor(vmf->vma))) {
> +			ret = do_fault_around(vmf);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	ret = __do_fault(vmf);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b72c55aa07fc..3f48cb5e8404 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1785,7 +1785,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>   * vm. If we swap it in we mark it dirty since we also free the swap
>   * entry since a page cannot live in both the swap and page cache.
>   *
> - * vmf and fault_type are only supplied by shmem_fault:
> + * vma, vmf, and fault_type are only supplied by shmem_fault:
>   * otherwise they are NULL.
>   */
>  static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> @@ -1820,6 +1820,14 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  
>  	page = pagecache_get_page(mapping, index,
>  					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
> +
> +	if (page && vma && userfaultfd_minor(vma)) {
> +		unlock_page(page);
> +		put_page(page);
> +		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> +		return 0;
> +	}
> +

Okay, Peter persuaded you to move that up here: where indeed it
does look better than the earlier "swapped" version.

But will crash on swap as it's currently written: it needs to say
		if (!xa_is_value(page)) {
			unlock_page(page);
			put_page(page);
		}

I did say before that it's more robust to return from the swap
case after doing the shmem_swapin_page(). But I might be slowly
realizing that the ioctl to add the pte (in 4/9) will do its
shmem_getpage_gfp(), and that will bring in the swap if user
did not already do so: so I was wrong to claim more robustness
the other way, this placement should be fine. I think.

>  	if (xa_is_value(page)) {
>  		error = shmem_swapin_page(inode, index, &page,
>  					  sgp, gfp, vma, fault_type);
> -- 
> 2.31.1.295.g9ea45b61b8-goog
