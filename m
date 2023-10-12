Return-Path: <linux-fsdevel+bounces-205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB127C78F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EB01C21054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599AE3FB0E;
	Thu, 12 Oct 2023 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pbb2LIet"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7033B28A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 21:59:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E5BB
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697147990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCgGmN6rbBlBcfZkH9Ef+4Bf9pNJ71OtGq2z2U8QBXo=;
	b=Pbb2LIetKqEd4e5e3WQWPf/ffTbD+kwCNlQ1sAE84rLCf7AbrrnxujGWvly7XaFbD2OrY/
	NWorQZ6Lmr7nGk8kmZJae5w7Zd8R/QEB+Dqg82QE+KaT8Er0WyIdj6usSyG3vJcIpaSGZa
	BBKg/2YQoACqDfLNeybhvXQJxbqavg4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-O4IWwx0wP5K6ouIZgYbXKA-1; Thu, 12 Oct 2023 17:59:39 -0400
X-MC-Unique: O4IWwx0wP5K6ouIZgYbXKA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41810d0d8c2so3912791cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 14:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697147979; x=1697752779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCgGmN6rbBlBcfZkH9Ef+4Bf9pNJ71OtGq2z2U8QBXo=;
        b=gWd0eUnatmh7Ji5tYXoHWW5a9sj9WjhIAa1ka/59l2geXGS8pD4mbx3O0uD1nUbc6A
         5lPDtTRfQftkjxX/1nCp894Eaz96vRZ+DYR+QPP2ehZ4fRLFY1e3A0tpo6ppBF4kEK2u
         M2GnLtxsNDUZK3ybbn7eF9O6goabjygDN9sPvsuhV5orvKLLdL4K+S01BwZ79zpoEIwO
         5N9EdivWhOhtnAS1v0k+5Ri9zR5IgnTb2FS6d8Y6r6TRcVJRNbhyHU4gLqQcMMHdOF8b
         QPIUsTSGxsZDC0AI0RRoJAGS3wwIQRWOiuHMkhOZwUlMX0bI37cmxM/5OGSIKjDNy/mm
         XfsQ==
X-Gm-Message-State: AOJu0YxeqHCDOff/CZ3p5eG7/rBFWfzgyHbWioI6qGhxZtKHzKsXy4t9
	deoDF8MMUSUFnfg0thMwmu0b/gC/ggSzPZx9j/Q56Lk2B0J1/Mv+Bi3wqyXzeGQLK1rcWRlQDbX
	O2SwHOd/o3PXBPnoEjJp3C6q9BA==
X-Received: by 2002:a05:6214:2303:b0:65d:486:25c6 with SMTP id gc3-20020a056214230300b0065d048625c6mr26913842qvb.3.1697147978484;
        Thu, 12 Oct 2023 14:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5Yqkh1j3hx7gaVqxJWW0arvsJVLxYr2Sp6lG6vJsFc2w5gkhkP7XPxLD0zzo2Wr6lU8eIyA==
X-Received: by 2002:a05:6214:2303:b0:65d:486:25c6 with SMTP id gc3-20020a056214230300b0065d048625c6mr26913824qvb.3.1697147977849;
        Thu, 12 Oct 2023 14:59:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ec3-20020ad44e63000000b0065862497fd2sm132379qvb.22.2023.10.12.14.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:59:37 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:59:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
	david@redhat.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZShsQzKvQDZW+rRM@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009064230.2952396-3-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 08, 2023 at 11:42:27PM -0700, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> Implement the uABI of UFFDIO_MOVE ioctl.
> UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the application
> needs pages to be allocated [1]. However, with UFFDIO_MOVE, if pages are
> available (in userspace) for recycling, as is usually the case in heap
> compaction algorithms, then we can avoid the page allocation and memcpy
> (done by UFFDIO_COPY). Also, since the pages are recycled in the
> userspace, we avoid the need to release (via madvise) the pages back to
> the kernel [2].
> We see over 40% reduction (on a Google pixel 6 device) in the compacting
> thread’s completion time by using UFFDIO_MOVE vs. UFFDIO_COPY. This was
> measured using a benchmark that emulates a heap compaction implementation
> using userfaultfd (to allow concurrent accesses by application threads).
> More details of the usecase are explained in [2].
> Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> touching them within the same vma. Today, it can only be done by mremap,
> however it forces splitting the vma.
> 
> [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aarcange@redhat.com/
> [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> 
> Update for the ioctl_userfaultfd(2)  manpage:
> 
>    UFFDIO_MOVE
>        (Since Linux xxx)  Move a continuous memory chunk into the
>        userfault registered range and optionally wake up the blocked
>        thread. The source and destination addresses and the number of
>        bytes to move are specified by the src, dst, and len fields of
>        the uffdio_move structure pointed to by argp:
> 
>            struct uffdio_move {
>                __u64 dst;    /* Destination of move */
>                __u64 src;    /* Source of move */
>                __u64 len;    /* Number of bytes to move */
>                __u64 mode;   /* Flags controlling behavior of move */
>                __s64 move;   /* Number of bytes moved, or negated error */
>            };
> 
>        The following value may be bitwise ORed in mode to change the
>        behavior of the UFFDIO_MOVE operation:
> 
>        UFFDIO_MOVE_MODE_DONTWAKE
>               Do not wake up the thread that waits for page-fault
>               resolution
> 
>        UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
>               Allow holes in the source virtual range that is being moved.
>               When not specified, the holes will result in ENOENT error.
>               When specified, the holes will be accounted as successfully
>               moved memory. This is mostly useful to move hugepage aligned
>               virtual regions without knowing if there are transparent
>               hugepages in the regions or not, but preventing the risk of
>               having to split the hugepage during the operation.
> 
>        The move field is used by the kernel to return the number of
>        bytes that was actually moved, or an error (a negated errno-
>        style value).  If the value returned in move doesn't match the
>        value that was specified in len, the operation fails with the
>        error EAGAIN.  The move field is output-only; it is not read by
>        the UFFDIO_MOVE operation.
> 
>        The operation may fail for various reasons. Usually, remapping of
>        pages that are not exclusive to the given process fail; once KSM
>        might deduplicate pages or fork() COW-shares pages during fork()
>        with child processes, they are no longer exclusive. Further, the
>        kernel might only perform lightweight checks for detecting whether
>        the pages are exclusive, and return -EBUSY in case that check fails.
>        To make the operation more likely to succeed, KSM should be
>        disabled, fork() should be avoided or MADV_DONTFORK should be
>        configured for the source VMA before fork().
> 
>        This ioctl(2) operation returns 0 on success.  In this case, the
>        entire area was moved.  On error, -1 is returned and errno is
>        set to indicate the error.  Possible errors include:
> 
>        EAGAIN The number of bytes moved (i.e., the value returned in
>               the move field) does not equal the value that was
>               specified in the len field.
> 
>        EINVAL Either dst or len was not a multiple of the system page
>               size, or the range specified by src and len or dst and len
>               was invalid.
> 
>        EINVAL An invalid bit was specified in the mode field.
> 
>        ENOENT
>               The source virtual memory range has unmapped holes and
>               UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
> 
>        EEXIST
>               The destination virtual memory range is fully or partially
>               mapped.
> 
>        EBUSY
>               The pages in the source virtual memory range are not
>               exclusive to the process. The kernel might only perform
>               lightweight checks for detecting whether the pages are
>               exclusive. To make the operation more likely to succeed,
>               KSM should be disabled, fork() should be avoided or
>               MADV_DONTFORK should be configured for the source virtual
>               memory area before fork().
> 
>        ENOMEM Allocating memory needed for the operation failed.
> 
>        ESRCH
>               The faulting process has exited at the time of a

Nit pick comment for future man page: there's no faulting process in this
context. Perhaps "target process"?

>               UFFDIO_MOVE operation.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst |   3 +
>  fs/userfaultfd.c                             |  63 ++
>  include/linux/rmap.h                         |   5 +
>  include/linux/userfaultfd_k.h                |  12 +
>  include/uapi/linux/userfaultfd.h             |  29 +-
>  mm/huge_memory.c                             | 138 +++++
>  mm/khugepaged.c                              |   3 +
>  mm/rmap.c                                    |   6 +
>  mm/userfaultfd.c                             | 602 +++++++++++++++++++
>  9 files changed, 860 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 203e26da5f92..e5cc8848dcb3 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -113,6 +113,9 @@ events, except page fault notifications, may be generated:
>    areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
>    support for shmem virtual memory areas.
>  
> +- ``UFFD_FEATURE_MOVE`` indicates that the kernel supports moving an
> +  existing page contents from userspace.
> +
>  The userland application should set the feature flags it intends to use
>  when invoking the ``UFFDIO_API`` ioctl, to request that those features be
>  enabled if supported.
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index a7c6ef764e63..ac52e0f99a69 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2039,6 +2039,66 @@ static inline unsigned int uffd_ctx_features(__u64 user_features)
>  	return (unsigned int)user_features | UFFD_FEATURE_INITIALIZED;
>  }
>  
> +static int userfaultfd_remap(struct userfaultfd_ctx *ctx,
> +			     unsigned long arg)

If we do want to rename from REMAP to MOVE, we'd better rename the
functions too, as "remap" still exists all over the place..

> +{
> +	__s64 ret;
> +	struct uffdio_move uffdio_move;
> +	struct uffdio_move __user *user_uffdio_move;
> +	struct userfaultfd_wake_range range;
> +
> +	user_uffdio_move = (struct uffdio_move __user *) arg;
> +
> +	ret = -EAGAIN;
> +	if (atomic_read(&ctx->mmap_changing))
> +		goto out;

I didn't notice this before, but I think we need to re-check this after
taking target mm's mmap read lock..

maybe we'd want to pass in ctx* into remap_pages(), more reasoning below.

> +
> +	ret = -EFAULT;
> +	if (copy_from_user(&uffdio_move, user_uffdio_move,
> +			   /* don't copy "remap" last field */

s/remap/move/

> +			   sizeof(uffdio_move)-sizeof(__s64)))
> +		goto out;
> +
> +	ret = validate_range(ctx->mm, uffdio_move.dst, uffdio_move.len);
> +	if (ret)
> +		goto out;
> +
> +	ret = validate_range(current->mm, uffdio_move.src, uffdio_move.len);
> +	if (ret)
> +		goto out;
> +
> +	ret = -EINVAL;
> +	if (uffdio_move.mode & ~(UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES|
> +				  UFFDIO_MOVE_MODE_DONTWAKE))
> +		goto out;
> +
> +	if (mmget_not_zero(ctx->mm)) {
> +		ret = remap_pages(ctx->mm, current->mm,
> +				  uffdio_move.dst, uffdio_move.src,
> +				  uffdio_move.len, uffdio_move.mode);
> +		mmput(ctx->mm);
> +	} else {
> +		return -ESRCH;
> +	}
> +
> +	if (unlikely(put_user(ret, &user_uffdio_move->move)))
> +		return -EFAULT;
> +	if (ret < 0)
> +		goto out;
> +
> +	/* len == 0 would wake all */
> +	BUG_ON(!ret);
> +	range.len = ret;
> +	if (!(uffdio_move.mode & UFFDIO_MOVE_MODE_DONTWAKE)) {
> +		range.start = uffdio_move.dst;
> +		wake_userfault(ctx, &range);
> +	}
> +	ret = range.len == uffdio_move.len ? 0 : -EAGAIN;
> +
> +out:
> +	return ret;
> +}
> +
>  /*
>   * userland asks for a certain API version and we return which bits
>   * and ioctl commands are implemented in this kernel for such API
> @@ -2131,6 +2191,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
>  	case UFFDIO_ZEROPAGE:
>  		ret = userfaultfd_zeropage(ctx, arg);
>  		break;
> +	case UFFDIO_MOVE:
> +		ret = userfaultfd_remap(ctx, arg);
> +		break;
>  	case UFFDIO_WRITEPROTECT:
>  		ret = userfaultfd_writeprotect(ctx, arg);
>  		break;
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b26fe858fd44..8034eda972e5 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -121,6 +121,11 @@ static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
>  	down_write(&anon_vma->root->rwsem);
>  }
>  
> +static inline int anon_vma_trylock_write(struct anon_vma *anon_vma)
> +{
> +	return down_write_trylock(&anon_vma->root->rwsem);
> +}
> +
>  static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
>  {
>  	up_write(&anon_vma->root->rwsem);
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index f2dc19f40d05..ce8d20b57e8c 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -93,6 +93,18 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
>  extern long uffd_wp_range(struct vm_area_struct *vma,
>  			  unsigned long start, unsigned long len, bool enable_wp);
>  
> +/* remap_pages */
> +void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> +void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +		    unsigned long dst_start, unsigned long src_start,
> +		    unsigned long len, __u64 flags);
> +int remap_pages_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +			 pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
> +			 struct vm_area_struct *dst_vma,
> +			 struct vm_area_struct *src_vma,
> +			 unsigned long dst_addr, unsigned long src_addr);
> +
>  /* mm helpers */
>  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>  					struct vm_userfaultfd_ctx vm_ctx)
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 0dbc81015018..2841e4ea8f2c 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -41,7 +41,8 @@
>  			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
>  			   UFFD_FEATURE_WP_UNPOPULATED |	\
>  			   UFFD_FEATURE_POISON |		\
> -			   UFFD_FEATURE_WP_ASYNC)
> +			   UFFD_FEATURE_WP_ASYNC |		\
> +			   UFFD_FEATURE_MOVE)
>  #define UFFD_API_IOCTLS				\
>  	((__u64)1 << _UFFDIO_REGISTER |		\
>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -50,6 +51,7 @@
>  	((__u64)1 << _UFFDIO_WAKE |		\
>  	 (__u64)1 << _UFFDIO_COPY |		\
>  	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
> +	 (__u64)1 << _UFFDIO_MOVE |		\
>  	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
>  	 (__u64)1 << _UFFDIO_CONTINUE |		\
>  	 (__u64)1 << _UFFDIO_POISON)
> @@ -73,6 +75,7 @@
>  #define _UFFDIO_WAKE			(0x02)
>  #define _UFFDIO_COPY			(0x03)
>  #define _UFFDIO_ZEROPAGE		(0x04)
> +#define _UFFDIO_MOVE			(0x05)
>  #define _UFFDIO_WRITEPROTECT		(0x06)
>  #define _UFFDIO_CONTINUE		(0x07)
>  #define _UFFDIO_POISON			(0x08)
> @@ -92,6 +95,8 @@
>  				      struct uffdio_copy)
>  #define UFFDIO_ZEROPAGE		_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,	\
>  				      struct uffdio_zeropage)
> +#define UFFDIO_MOVE		_IOWR(UFFDIO, _UFFDIO_MOVE,	\
> +				      struct uffdio_move)
>  #define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
>  				      struct uffdio_writeprotect)
>  #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
> @@ -222,6 +227,9 @@ struct uffdio_api {
>  	 * asynchronous mode is supported in which the write fault is
>  	 * automatically resolved and write-protection is un-set.
>  	 * It implies UFFD_FEATURE_WP_UNPOPULATED.
> +	 *
> +	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
> +	 * existing page contents from userspace.
>  	 */
>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
> @@ -239,6 +247,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
>  #define UFFD_FEATURE_POISON			(1<<14)
>  #define UFFD_FEATURE_WP_ASYNC			(1<<15)
> +#define UFFD_FEATURE_MOVE			(1<<16)
>  	__u64 features;
>  
>  	__u64 ioctls;
> @@ -347,6 +356,24 @@ struct uffdio_poison {
>  	__s64 updated;
>  };
>  
> +struct uffdio_move {
> +	__u64 dst;
> +	__u64 src;
> +	__u64 len;
> +	/*
> +	 * Especially if used to atomically remove memory from the
> +	 * address space the wake on the dst range is not needed.
> +	 */
> +#define UFFDIO_MOVE_MODE_DONTWAKE		((__u64)1<<0)
> +#define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES	((__u64)1<<1)
> +	__u64 mode;
> +	/*
> +	 * "move" is written by the ioctl and must be at the end: the
> +	 * copy_from_user will not read the last 8 bytes.
> +	 */
> +	__s64 move;
> +};
> +
>  /*
>   * Flags for the userfaultfd(2) system call itself.
>   */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9656be95a542..6fac5c3d66e6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2086,6 +2086,144 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_USERFAULTFD
> +/*
> + * The PT lock for src_pmd and the mmap_lock for reading are held by
> + * the caller, but it must return after releasing the
> + * page_table_lock. Just move the page from src_pmd to dst_pmd if possible.
> + * Return zero if succeeded in moving the page, -EAGAIN if it needs to be
> + * repeated by the caller, or other errors in case of failure.
> + */
> +int remap_pages_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +			 pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
> +			 struct vm_area_struct *dst_vma,
> +			 struct vm_area_struct *src_vma,
> +			 unsigned long dst_addr, unsigned long src_addr)
> +{
> +	pmd_t _dst_pmd, src_pmdval;
> +	struct page *src_page;
> +	struct folio *src_folio;
> +	struct anon_vma *src_anon_vma;
> +	spinlock_t *src_ptl, *dst_ptl;
> +	pgtable_t src_pgtable, dst_pgtable;
> +	struct mmu_notifier_range range;
> +	int err = 0;
> +
> +	src_pmdval = *src_pmd;
> +	src_ptl = pmd_lockptr(src_mm, src_pmd);
> +
> +	lockdep_assert_held(src_ptl);
> +	mmap_assert_locked(src_mm);
> +	mmap_assert_locked(dst_mm);
> +
> +	BUG_ON(!pmd_none(dst_pmdval));
> +	BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> +	BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> +
> +	if (!pmd_trans_huge(src_pmdval)) {
> +		spin_unlock(src_ptl);
> +		if (is_pmd_migration_entry(src_pmdval)) {
> +			pmd_migration_entry_wait(src_mm, &src_pmdval);
> +			return -EAGAIN;
> +		}
> +		return -ENOENT;
> +	}
> +
> +	src_page = pmd_page(src_pmdval);
> +	if (unlikely(!PageAnonExclusive(src_page))) {
> +		spin_unlock(src_ptl);
> +		return -EBUSY;
> +	}
> +
> +	src_folio = page_folio(src_page);
> +	folio_get(src_folio);
> +	spin_unlock(src_ptl);
> +
> +	/* preallocate dst_pgtable if needed */
> +	if (dst_mm != src_mm) {
> +		dst_pgtable = pte_alloc_one(dst_mm);
> +		if (unlikely(!dst_pgtable)) {
> +			err = -ENOMEM;
> +			goto put_folio;
> +		}
> +	} else {
> +		dst_pgtable = NULL;
> +	}
> +

IIUC Lokesh's comment applies here, we probably need the
flush_cache_range(), not for x86 but for the other ones..

cachetlb.rst:

        Next, we have the cache flushing interfaces.  In general, when Linux
        is changing an existing virtual-->physical mapping to a new value,
        the sequence will be in one of the following forms::

	1) flush_cache_mm(mm);
	   change_all_page_tables_of(mm);
	   flush_tlb_mm(mm);

	2) flush_cache_range(vma, start, end);
	   change_range_of_page_tables(mm, start, end);
	   flush_tlb_range(vma, start, end);

	3) flush_cache_page(vma, addr, pfn);
	   set_pte(pte_pointer, new_pte_val);
	   flush_tlb_page(vma, addr);

> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm, src_addr,
> +				src_addr + HPAGE_PMD_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +
> +	folio_lock(src_folio);
> +
> +	/*
> +	 * split_huge_page walks the anon_vma chain without the page
> +	 * lock. Serialize against it with the anon_vma lock, the page
> +	 * lock is not enough.
> +	 */
> +	src_anon_vma = folio_get_anon_vma(src_folio);
> +	if (!src_anon_vma) {
> +		err = -EAGAIN;
> +		goto unlock_folio;
> +	}
> +	anon_vma_lock_write(src_anon_vma);
> +
> +	dst_ptl = pmd_lockptr(dst_mm, dst_pmd);
> +	double_pt_lock(src_ptl, dst_ptl);
> +	if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
> +		     !pmd_same(*dst_pmd, dst_pmdval))) {
> +		double_pt_unlock(src_ptl, dst_ptl);
> +		err = -EAGAIN;
> +		goto put_anon_vma;
> +	}
> +	if (!PageAnonExclusive(&src_folio->page)) {
> +		double_pt_unlock(src_ptl, dst_ptl);
> +		err = -EBUSY;
> +		goto put_anon_vma;
> +	}
> +
> +	BUG_ON(!folio_test_head(src_folio));
> +	BUG_ON(!folio_test_anon(src_folio));
> +
> +	folio_move_anon_rmap(src_folio, dst_vma);
> +	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +
> +	src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
> +	_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
> +	_dst_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);

Last time the conclusion is we leverage can_change_pmd_writable(), no?

> +	set_pmd_at(dst_mm, dst_addr, dst_pmd, _dst_pmd);
> +
> +	src_pgtable = pgtable_trans_huge_withdraw(src_mm, src_pmd);
> +	if (dst_pgtable) {
> +		pgtable_trans_huge_deposit(dst_mm, dst_pmd, dst_pgtable);
> +		pte_free(src_mm, src_pgtable);
> +		dst_pgtable = NULL;
> +
> +		mm_inc_nr_ptes(dst_mm);
> +		mm_dec_nr_ptes(src_mm);
> +		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +		add_mm_counter(src_mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> +	} else {
> +		pgtable_trans_huge_deposit(dst_mm, dst_pmd, src_pgtable);
> +	}
> +	double_pt_unlock(src_ptl, dst_ptl);
> +
> +put_anon_vma:
> +	anon_vma_unlock_write(src_anon_vma);
> +	put_anon_vma(src_anon_vma);
> +unlock_folio:
> +	/* unblock rmap walks */
> +	folio_unlock(src_folio);
> +	mmu_notifier_invalidate_range_end(&range);
> +	if (dst_pgtable)
> +		pte_free(dst_mm, dst_pgtable);
> +put_folio:
> +	folio_put(src_folio);
> +
> +	return err;
> +}
> +#endif /* CONFIG_USERFAULTFD */
> +
>  /*
>   * Returns page table lock pointer if a given pmd maps a thp, NULL otherwise.
>   *
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2b5c0321d96b..0c1ee7172852 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1136,6 +1136,9 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * Prevent all access to pagetables with the exception of
>  	 * gup_fast later handled by the ptep_clear_flush and the VM
>  	 * handled by the anon_vma lock + PG_lock.
> +	 *
> +	 * UFFDIO_MOVE is prevented to race as well thanks to the
> +	 * mmap_lock.
>  	 */
>  	mmap_write_lock(mm);
>  	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f9ddc50269d2..a5919cac9a08 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -490,6 +490,12 @@ void __init anon_vma_init(void)
>   * page_remove_rmap() that the anon_vma pointer from page->mapping is valid
>   * if there is a mapcount, we can dereference the anon_vma after observing
>   * those.
> + *
> + * NOTE: the caller should normally hold folio lock when calling this.  If
> + * not, the caller needs to double check the anon_vma didn't change after
> + * taking the anon_vma lock for either read or write (UFFDIO_MOVE can modify it
> + * concurrently without folio lock protection). See folio_lock_anon_vma_read()
> + * which has already covered that, and comment above remap_pages().
>   */
>  struct anon_vma *folio_get_anon_vma(struct folio *folio)
>  {
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 96d9eae5c7cc..45ce1a8b8ab9 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -842,3 +842,605 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  	mmap_read_unlock(dst_mm);
>  	return err;
>  }
> +
> +
> +void double_pt_lock(spinlock_t *ptl1,
> +		    spinlock_t *ptl2)
> +	__acquires(ptl1)
> +	__acquires(ptl2)
> +{
> +	spinlock_t *ptl_tmp;
> +
> +	if (ptl1 > ptl2) {
> +		/* exchange ptl1 and ptl2 */
> +		ptl_tmp = ptl1;
> +		ptl1 = ptl2;
> +		ptl2 = ptl_tmp;
> +	}
> +	/* lock in virtual address order to avoid lock inversion */
> +	spin_lock(ptl1);
> +	if (ptl1 != ptl2)
> +		spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
> +	else
> +		__acquire(ptl2);
> +}
> +
> +void double_pt_unlock(spinlock_t *ptl1,
> +		      spinlock_t *ptl2)
> +	__releases(ptl1)
> +	__releases(ptl2)
> +{
> +	spin_unlock(ptl1);
> +	if (ptl1 != ptl2)
> +		spin_unlock(ptl2);
> +	else
> +		__release(ptl2);
> +}
> +
> +
> +static int remap_present_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +			     struct vm_area_struct *dst_vma,
> +			     struct vm_area_struct *src_vma,
> +			     unsigned long dst_addr, unsigned long src_addr,
> +			     pte_t *dst_pte, pte_t *src_pte,
> +			     pte_t orig_dst_pte, pte_t orig_src_pte,
> +			     spinlock_t *dst_ptl, spinlock_t *src_ptl,
> +			     struct folio *src_folio)
> +{
> +	double_pt_lock(dst_ptl, src_ptl);
> +
> +	if (!pte_same(*src_pte, orig_src_pte) ||
> +	    !pte_same(*dst_pte, orig_dst_pte)) {
> +		double_pt_unlock(dst_ptl, src_ptl);
> +		return -EAGAIN;
> +	}
> +	if (folio_test_large(src_folio) ||
> +	    !PageAnonExclusive(&src_folio->page)) {
> +		double_pt_unlock(dst_ptl, src_ptl);
> +		return -EBUSY;
> +	}
> +
> +	BUG_ON(!folio_test_anon(src_folio));
> +
> +	folio_move_anon_rmap(src_folio, dst_vma);
> +	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +
> +	orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
> +	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
> +	orig_dst_pte = maybe_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);

can_change_pte_writable()?

> +
> +	set_pte_at(dst_mm, dst_addr, dst_pte, orig_dst_pte);
> +
> +	if (dst_mm != src_mm) {
> +		inc_mm_counter(dst_mm, MM_ANONPAGES);
> +		dec_mm_counter(src_mm, MM_ANONPAGES);
> +	}
> +
> +	double_pt_unlock(dst_ptl, src_ptl);
> +
> +	return 0;
> +}
> +
> +static int remap_swap_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +			  unsigned long dst_addr, unsigned long src_addr,
> +			  pte_t *dst_pte, pte_t *src_pte,
> +			  pte_t orig_dst_pte, pte_t orig_src_pte,
> +			  spinlock_t *dst_ptl, spinlock_t *src_ptl)
> +{
> +	if (!pte_swp_exclusive(orig_src_pte))
> +		return -EBUSY;
> +
> +	double_pt_lock(dst_ptl, src_ptl);
> +
> +	if (!pte_same(*src_pte, orig_src_pte) ||
> +	    !pte_same(*dst_pte, orig_dst_pte)) {
> +		double_pt_unlock(dst_ptl, src_ptl);
> +		return -EAGAIN;
> +	}
> +
> +	orig_src_pte = ptep_get_and_clear(src_mm, src_addr, src_pte);
> +	set_pte_at(dst_mm, dst_addr, dst_pte, orig_src_pte);
> +
> +	if (dst_mm != src_mm) {
> +		inc_mm_counter(dst_mm, MM_SWAPENTS);
> +		dec_mm_counter(src_mm, MM_SWAPENTS);
> +	}
> +
> +	double_pt_unlock(dst_ptl, src_ptl);
> +
> +	return 0;
> +}
> +
> +/*
> + * The mmap_lock for reading is held by the caller. Just move the page
> + * from src_pmd to dst_pmd if possible, and return true if succeeded
> + * in moving the page.
> + */
> +static int remap_pages_pte(struct mm_struct *dst_mm,
> +			   struct mm_struct *src_mm,
> +			   pmd_t *dst_pmd,
> +			   pmd_t *src_pmd,
> +			   struct vm_area_struct *dst_vma,
> +			   struct vm_area_struct *src_vma,
> +			   unsigned long dst_addr,
> +			   unsigned long src_addr,
> +			   __u64 mode)
> +{
> +	swp_entry_t entry;
> +	pte_t orig_src_pte, orig_dst_pte;
> +	pte_t src_folio_pte;
> +	spinlock_t *src_ptl, *dst_ptl;
> +	pte_t *src_pte = NULL;
> +	pte_t *dst_pte = NULL;
> +
> +	struct folio *src_folio = NULL;
> +	struct anon_vma *src_anon_vma = NULL;
> +	struct mmu_notifier_range range;
> +	int err = 0;
> +

Same flush_cache_range().

> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm,
> +				src_addr, src_addr + PAGE_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +retry:
> +	dst_pte = pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &dst_ptl);
> +
> +	/* Retry if a huge pmd materialized from under us */
> +	if (unlikely(!dst_pte)) {
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
> +	src_pte = pte_offset_map_nolock(src_mm, src_pmd, src_addr, &src_ptl);
> +
> +	/*
> +	 * We held the mmap_lock for reading so MADV_DONTNEED
> +	 * can zap transparent huge pages under us, or the
> +	 * transparent huge page fault can establish new
> +	 * transparent huge pages under us.
> +	 */
> +	if (unlikely(!src_pte)) {
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
> +	BUG_ON(pmd_none(*dst_pmd));
> +	BUG_ON(pmd_none(*src_pmd));
> +	BUG_ON(pmd_trans_huge(*dst_pmd));
> +	BUG_ON(pmd_trans_huge(*src_pmd));
> +
> +	spin_lock(dst_ptl);
> +	orig_dst_pte = *dst_pte;
> +	spin_unlock(dst_ptl);
> +	if (!pte_none(orig_dst_pte)) {
> +		err = -EEXIST;
> +		goto out;
> +	}
> +
> +	spin_lock(src_ptl);
> +	orig_src_pte = *src_pte;
> +	spin_unlock(src_ptl);
> +	if (pte_none(orig_src_pte)) {
> +		if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
> +			err = -ENOENT;
> +		else /* nothing to do to remap a hole */
> +			err = 0;
> +		goto out;
> +	}
> +
> +	/* If PTE changed after we locked the folio them start over */
> +	if (src_folio && unlikely(!pte_same(src_folio_pte, orig_src_pte))) {
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
> +	if (pte_present(orig_src_pte)) {
> +		/*
> +		 * Pin and lock both source folio and anon_vma. Since we are in
> +		 * RCU read section, we can't block, so on contention have to
> +		 * unmap the ptes, obtain the lock and retry.
> +		 */
> +		if (!src_folio) {
> +			struct folio *folio;
> +
> +			/*
> +			 * Pin the page while holding the lock to be sure the
> +			 * page isn't freed under us
> +			 */
> +			spin_lock(src_ptl);
> +			if (!pte_same(orig_src_pte, *src_pte)) {
> +				spin_unlock(src_ptl);
> +				err = -EAGAIN;
> +				goto out;
> +			}
> +
> +			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
> +			if (!folio || folio_test_large(folio) ||
> +			    !PageAnonExclusive(&folio->page)) {
> +				spin_unlock(src_ptl);
> +				err = -EBUSY;
> +				goto out;
> +			}
> +
> +			folio_get(folio);
> +			src_folio = folio;
> +			src_folio_pte = orig_src_pte;
> +			spin_unlock(src_ptl);
> +
> +			if (!folio_trylock(src_folio)) {
> +				pte_unmap(&orig_src_pte);
> +				pte_unmap(&orig_dst_pte);
> +				src_pte = dst_pte = NULL;
> +				/* now we can block and wait */
> +				folio_lock(src_folio);
> +				goto retry;
> +			}
> +		}
> +
> +		if (!src_anon_vma) {
> +			/*
> +			 * folio_referenced walks the anon_vma chain
> +			 * without the folio lock. Serialize against it with
> +			 * the anon_vma lock, the folio lock is not enough.
> +			 */
> +			src_anon_vma = folio_get_anon_vma(src_folio);
> +			if (!src_anon_vma) {
> +				/* page was unmapped from under us */
> +				err = -EAGAIN;
> +				goto out;
> +			}
> +			if (!anon_vma_trylock_write(src_anon_vma)) {
> +				pte_unmap(&orig_src_pte);
> +				pte_unmap(&orig_dst_pte);
> +				src_pte = dst_pte = NULL;
> +				/* now we can block and wait */
> +				anon_vma_lock_write(src_anon_vma);
> +				goto retry;
> +			}
> +		}
> +
> +		err = remap_present_pte(dst_mm, src_mm,  dst_vma, src_vma,
> +					dst_addr, src_addr, dst_pte, src_pte,
> +					orig_dst_pte, orig_src_pte,
> +					dst_ptl, src_ptl, src_folio);
> +	} else {
> +		entry = pte_to_swp_entry(orig_src_pte);
> +		if (non_swap_entry(entry)) {
> +			if (is_migration_entry(entry)) {
> +				pte_unmap(&orig_src_pte);
> +				pte_unmap(&orig_dst_pte);
> +				src_pte = dst_pte = NULL;
> +				migration_entry_wait(src_mm, src_pmd,
> +						     src_addr);
> +				err = -EAGAIN;
> +			} else
> +				err = -EFAULT;
> +			goto out;
> +		}
> +
> +		err = remap_swap_pte(dst_mm, src_mm, dst_addr, src_addr,
> +				     dst_pte, src_pte,
> +				     orig_dst_pte, orig_src_pte,
> +				     dst_ptl, src_ptl);
> +	}
> +
> +out:
> +	if (src_anon_vma) {
> +		anon_vma_unlock_write(src_anon_vma);
> +		put_anon_vma(src_anon_vma);
> +	}
> +	if (src_folio) {
> +		folio_unlock(src_folio);
> +		folio_put(src_folio);
> +	}
> +	if (dst_pte)
> +		pte_unmap(dst_pte);
> +	if (src_pte)
> +		pte_unmap(src_pte);
> +	mmu_notifier_invalidate_range_end(&range);
> +
> +	return err;
> +}
> +
> +static int validate_remap_areas(struct vm_area_struct *src_vma,

s/remap/move/

> +				struct vm_area_struct *dst_vma)
> +{
> +	/* Only allow remapping if both have the same access and protection */

s/remap/move/

PS: I'll stop comment on renamings.. but please have a look over the whole
patch..

> +	if ((src_vma->vm_flags & VM_ACCESS_FLAGS) != (dst_vma->vm_flags & VM_ACCESS_FLAGS) ||
> +	    pgprot_val(src_vma->vm_page_prot) != pgprot_val(dst_vma->vm_page_prot))
> +		return -EINVAL;
> +
> +	/* Only allow remapping if both are mlocked or both aren't */
> +	if ((src_vma->vm_flags & VM_LOCKED) != (dst_vma->vm_flags & VM_LOCKED))
> +		return -EINVAL;
> +
> +	if (!(src_vma->vm_flags & VM_WRITE) || !(dst_vma->vm_flags & VM_WRITE))
> +		return -EINVAL;
> +
> +	/*
> +	 * Be strict and only allow remap_pages if either the src or
> +	 * dst range is registered in the userfaultfd to prevent
> +	 * userland errors going unnoticed. As far as the VM
> +	 * consistency is concerned, it would be perfectly safe to
> +	 * remove this check, but there's no useful usage for
> +	 * remap_pages ouside of userfaultfd registered ranges. This
> +	 * is after all why it is an ioctl belonging to the
> +	 * userfaultfd and not a syscall.
> +	 *
> +	 * Allow both vmas to be registered in the userfaultfd, just
> +	 * in case somebody finds a way to make such a case useful.
> +	 * Normally only one of the two vmas would be registered in
> +	 * the userfaultfd.
> +	 */
> +	if (!dst_vma->vm_userfaultfd_ctx.ctx &&
> +	    !src_vma->vm_userfaultfd_ctx.ctx)
> +		return -EINVAL;

When rethinking this, I'm wondering whether we should make it strict.

The problem is, src/dst is not equal in this case.  We got dst_mm from the
uffd context passed in, so we know at least dst_mm has something registered
onto this uffd we're working on, no matter it's the dst_vma or not.  It'll
be weird if dst_vma is not registered to the uffd context we're using right
now..

Then, can we have a case where src vma is registered with uffd, then dest
vma is not?  It sounds really weird, since dest mm needs to be registered
to uffd anyway.  It sounds to me the interface is a bit loose and unclear.

I'm thinking a more reasonable way to safe check this: we model UFFDIO_MOVE
the same way as UFFDIO_COPY/CONTINUE/... where we always assumed the uffd
context is the target (uffd registration required), while current mm is
always the source (no uffd registration required).

It also means "dropping current page" does not require privilege (here
UFFDIO_MOVE is the same as DONTNEED, per discussed), while "installing a
page into the pgtable" does require some privilege (where privilege granted
by the uffd itself).

Then it means something like:

  if (!dst_vma->vm_userfaultfd_ctx.ctx ||
      dst_vma->vm_userfaultfd_ctx.ctx != ctx)
          return -EINVAL;

Here ctx should be passed over from upper.

What do you think?

PS: it seems current uffd ioctls are not double checking the vma's ctx is
the same as the ctx that the ioctl is operating on.. but it seems we should
do that for all.  I'll think more about it..

> +
> +	/*
> +	 * FIXME: only allow remapping across anonymous vmas,
> +	 * tmpfs should be added.
> +	 */
> +	if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
> +		return -EINVAL;
> +
> +	/*
> +	 * Ensure the dst_vma has a anon_vma or this page
> +	 * would get a NULL anon_vma when moved in the
> +	 * dst_vma.
> +	 */
> +	if (unlikely(anon_vma_prepare(dst_vma)))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/**
> + * remap_pages - remap arbitrary anonymous pages of an existing vma
> + * @dst_start: start of the destination virtual memory range
> + * @src_start: start of the source virtual memory range
> + * @len: length of the virtual memory range
> + *
> + * remap_pages() remaps arbitrary anonymous pages atomically in zero
> + * copy. It only works on non shared anonymous pages because those can
> + * be relocated without generating non linear anon_vmas in the rmap
> + * code.
> + *
> + * It provides a zero copy mechanism to handle userspace page faults.
> + * The source vma pages should have mapcount == 1, which can be
> + * enforced by using madvise(MADV_DONTFORK) on src vma.
> + *
> + * The thread receiving the page during the userland page fault
> + * will receive the faulting page in the source vma through the network,
> + * storage or any other I/O device (MADV_DONTFORK in the source vma
> + * avoids remap_pages() to fail with -EBUSY if the process forks before
> + * remap_pages() is called), then it will call remap_pages() to map the
> + * page in the faulting address in the destination vma.
> + *
> + * This userfaultfd command works purely via pagetables, so it's the
> + * most efficient way to move physical non shared anonymous pages
> + * across different virtual addresses. Unlike mremap()/mmap()/munmap()
> + * it does not create any new vmas. The mapping in the destination
> + * address is atomic.
> + *
> + * It only works if the vma protection bits are identical from the
> + * source and destination vma.
> + *
> + * It can remap non shared anonymous pages within the same vma too.
> + *
> + * If the source virtual memory range has any unmapped holes, or if
> + * the destination virtual memory range is not a whole unmapped hole,
> + * remap_pages() will fail respectively with -ENOENT or -EEXIST. This
> + * provides a very strict behavior to avoid any chance of memory
> + * corruption going unnoticed if there are userland race conditions.
> + * Only one thread should resolve the userland page fault at any given
> + * time for any given faulting address. This means that if two threads
> + * try to both call remap_pages() on the same destination address at the
> + * same time, the second thread will get an explicit error from this
> + * command.
> + *
> + * The command retval will return "len" is successful. The command
> + * however can be interrupted by fatal signals or errors. If
> + * interrupted it will return the number of bytes successfully
> + * remapped before the interruption if any, or the negative error if
> + * none. It will never return zero. Either it will return an error or
> + * an amount of bytes successfully moved. If the retval reports a
> + * "short" remap, the remap_pages() command should be repeated by
> + * userland with src+retval, dst+reval, len-retval if it wants to know
> + * about the error that interrupted it.
> + *
> + * The UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES flag can be specified to
> + * prevent -ENOENT errors to materialize if there are holes in the
> + * source virtual range that is being remapped. The holes will be
> + * accounted as successfully remapped in the retval of the
> + * command. This is mostly useful to remap hugepage naturally aligned
> + * virtual regions without knowing if there are transparent hugepage
> + * in the regions or not, but preventing the risk of having to split
> + * the hugepmd during the remap.
> + *
> + * If there's any rmap walk that is taking the anon_vma locks without
> + * first obtaining the folio lock (the only current instance is
> + * folio_referenced), they will have to verify if the folio->mapping
> + * has changed after taking the anon_vma lock. If it changed they
> + * should release the lock and retry obtaining a new anon_vma, because
> + * it means the anon_vma was changed by remap_pages() before the lock
> + * could be obtained. This is the only additional complexity added to
> + * the rmap code to provide this anonymous page remapping functionality.
> + */
> +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +		    unsigned long dst_start, unsigned long src_start,
> +		    unsigned long len, __u64 mode)
> +{
> +	struct vm_area_struct *src_vma, *dst_vma;
> +	unsigned long src_addr, dst_addr;
> +	pmd_t *src_pmd, *dst_pmd;
> +	long err = -EINVAL;
> +	ssize_t moved = 0;
> +
> +	/*
> +	 * Sanitize the command parameters:
> +	 */
> +	BUG_ON(src_start & ~PAGE_MASK);
> +	BUG_ON(dst_start & ~PAGE_MASK);
> +	BUG_ON(len & ~PAGE_MASK);
> +
> +	/* Does the address range wrap, or is the span zero-sized? */
> +	BUG_ON(src_start + len <= src_start);
> +	BUG_ON(dst_start + len <= dst_start);
> +
> +	/*
> +	 * Because these are read sempahores there's no risk of lock
> +	 * inversion.
> +	 */
> +	mmap_read_lock(dst_mm);
> +	if (dst_mm != src_mm)
> +		mmap_read_lock(src_mm);
> +
> +	/*
> +	 * Make sure the vma is not shared, that the src and dst remap
> +	 * ranges are both valid and fully within a single existing
> +	 * vma.
> +	 */
> +	src_vma = find_vma(src_mm, src_start);
> +	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> +		goto out;
> +	if (src_start < src_vma->vm_start ||
> +	    src_start + len > src_vma->vm_end)
> +		goto out;
> +
> +	dst_vma = find_vma(dst_mm, dst_start);
> +	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> +		goto out;
> +	if (dst_start < dst_vma->vm_start ||
> +	    dst_start + len > dst_vma->vm_end)
> +		goto out;
> +
> +	err = validate_remap_areas(src_vma, dst_vma);
> +	if (err)
> +		goto out;
> +
> +	for (src_addr = src_start, dst_addr = dst_start;
> +	     src_addr < src_start + len;) {
> +		spinlock_t *ptl;
> +		pmd_t dst_pmdval;
> +		unsigned long step_size;
> +
> +		BUG_ON(dst_addr >= dst_start + len);
> +		/*
> +		 * Below works because anonymous area would not have a
> +		 * transparent huge PUD. If file-backed support is added,
> +		 * that case would need to be handled here.
> +		 */
> +		src_pmd = mm_find_pmd(src_mm, src_addr);
> +		if (unlikely(!src_pmd)) {
> +			if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
> +				err = -ENOENT;
> +				break;
> +			}
> +			src_pmd = mm_alloc_pmd(src_mm, src_addr);
> +			if (unlikely(!src_pmd)) {
> +				err = -ENOMEM;
> +				break;
> +			}
> +		}
> +		dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
> +		if (unlikely(!dst_pmd)) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		dst_pmdval = pmdp_get_lockless(dst_pmd);
> +		/*
> +		 * If the dst_pmd is mapped as THP don't override it and just
> +		 * be strict. If dst_pmd changes into TPH after this check, the
> +		 * remap_pages_huge_pmd() will detect the change and retry
> +		 * while remap_pages_pte() will detect the change and fail.
> +		 */
> +		if (unlikely(pmd_trans_huge(dst_pmdval))) {
> +			err = -EEXIST;
> +			break;
> +		}
> +
> +		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> +		if (ptl) {
> +			if (pmd_devmap(*src_pmd)) {
> +				spin_unlock(ptl);
> +				err = -ENOENT;
> +				break;
> +			}
> +
> +			/*
> +			 * Check if we can move the pmd without
> +			 * splitting it. First check the address
> +			 * alignment to be the same in src/dst.  These
> +			 * checks don't actually need the PT lock but
> +			 * it's good to do it here to optimize this
> +			 * block away at build time if
> +			 * CONFIG_TRANSPARENT_HUGEPAGE is not set.
> +			 */
> +			if ((src_addr & ~HPAGE_PMD_MASK) || (dst_addr & ~HPAGE_PMD_MASK) ||
> +			    src_start + len - src_addr < HPAGE_PMD_SIZE || !pmd_none(dst_pmdval)) {
> +				spin_unlock(ptl);
> +				split_huge_pmd(src_vma, src_pmd, src_addr);
> +				continue;
> +			}
> +
> +			err = remap_pages_huge_pmd(dst_mm, src_mm,
> +						   dst_pmd, src_pmd,
> +						   dst_pmdval,
> +						   dst_vma, src_vma,
> +						   dst_addr, src_addr);
> +			step_size = HPAGE_PMD_SIZE;
> +		} else {
> +			if (pmd_none(*src_pmd)) {
> +				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
> +					err = -ENOENT;
> +					break;
> +				}
> +				if (unlikely(__pte_alloc(src_mm, src_pmd))) {
> +					err = -ENOMEM;
> +					break;
> +				}
> +			}
> +
> +			if (unlikely(pte_alloc(dst_mm, dst_pmd))) {
> +				err = -ENOMEM;
> +				break;
> +			}
> +
> +			err = remap_pages_pte(dst_mm, src_mm,
> +					      dst_pmd, src_pmd,
> +					      dst_vma, src_vma,
> +					      dst_addr, src_addr,
> +					      mode);
> +			step_size = PAGE_SIZE;
> +		}
> +
> +		cond_resched();
> +
> +		if (fatal_signal_pending(current)) {
> +			/* Do not override an error */
> +			if (!err || err == -EAGAIN)
> +				err = -EINTR;
> +			break;
> +		}
> +
> +		if (err) {
> +			if (err == -EAGAIN)
> +				continue;
> +			break;
> +		}
> +
> +		/* Proceed to the next page */
> +		dst_addr += step_size;
> +		src_addr += step_size;
> +		moved += step_size;
> +	}
> +
> +out:
> +	mmap_read_unlock(dst_mm);
> +	if (dst_mm != src_mm)
> +		mmap_read_unlock(src_mm);
> +	BUG_ON(moved < 0);
> +	BUG_ON(err > 0);
> +	BUG_ON(!moved && !err);
> +	return moved ? moved : err;
> +}
> -- 
> 2.42.0.609.gbb76f46606-goog
> 

-- 
Peter Xu


