Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB05A397FAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 05:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFBDvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 23:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhFBDvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 23:51:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D7C061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 20:49:34 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so243867otu.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 20:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=A1UB9LQpzOU3gj535qtT5dgKaTfrsn+X1UoIyKsIj6I=;
        b=emxWf4lBuoHFeaUBxEKbBFqGQjMrfZ3oOdp5+6x4XLwHxiFuQk0+oT/pN8RvFERFcz
         LaTpwmCyD3mq1i0iCDRu6gX8gyH04PiD7cgBBgPPWOSZhI4BUIKmGm9P1/Ww5hu7rFTP
         PDBPT95U0QQsHZQHN5gucKNLtKQoYN36UKsXz5fzr2FjtKlcK1RjVqffr7BsKqPdKoq+
         7BfDy95CJc1J0b3qhSRzIzuPckxF0oA9UFHn6nQQ+S/SoQRMtUqw5YFPaF3E/Cnpb+vs
         zIyJxgRMMXLPcKI8yN2V0zUVw7MpHkJHtMG3plUWgDlqDdjCZq4k4u72xrS3dH2EI36l
         vKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=A1UB9LQpzOU3gj535qtT5dgKaTfrsn+X1UoIyKsIj6I=;
        b=ElzRdC10g3ciKgoU3XnHDJKBBcn71wqYXkFIOxQZ0Xdpx0LEMLnsXBH5EPoxczDVFQ
         LGmfd+A378pBHePfb3dyK4LODFztZhzdQDVgXZjPOzoBK4hJt4pB2BxB5puaPyQrKVgb
         Cqo4MlrGEBUGAVvQTmEOwNS1QsTSgvIN/VSQHjCdPLLb7MrKruyOwsQr2v166Ylkyc0H
         78rHOKPfajKCUNiDht6bYnbPV9IT1adFBTxg3BvBlEPALGc7q6VmdTdgrz1OZoz6GQ2x
         Dkf1we7ufsLJq3SmGCHNSUXcOC5u2Ftk8csZtSmsrNEoFx0ArPdxBFmPEXcf8gdebxxm
         Oj+w==
X-Gm-Message-State: AOAM533p8SYjQdPw1r4tgnEIlXZmusM7aFopacLXKyJrjcn+VVXPIlKl
        H2HZYyhp+J7lW7vpDyQq4yNtWg==
X-Google-Smtp-Source: ABdhPJz0gwSQn6yj0nzOEBmXU98PR25rV1cL4eHlTqiN7LbZHah3LvWOjICPwk5AcQl1IkmUY3frKg==
X-Received: by 2002:a9d:5a09:: with SMTP id v9mr24009134oth.191.1622605773298;
        Tue, 01 Jun 2021 20:49:33 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e21sm3860325oii.23.2021.06.01.20.49.32
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 20:49:32 -0700 (PDT)
Date:   Tue, 1 Jun 2021 20:49:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Ming Lin <mlin@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem
 read
In-Reply-To: <1622589753-9206-3-git-send-email-mlin@kernel.org>
Message-ID: <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
References: <1622589753-9206-1-git-send-email-mlin@kernel.org> <1622589753-9206-3-git-send-email-mlin@kernel.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 1 Jun 2021, Ming Lin wrote:

> Adds new flag MAP_NOSIGBUS of mmap() to specify the behavior of
> "don't SIGBUS on read beyond i_size". This flag is only allowed
> for read only shmem mapping.
> 
> If you use MAP_NOSIGBUS, and you access pages that don't have a backing
> store, you will get zero pages, and they will NOT BE SYNCHRONIZED with
> the backing store possibly later being updated.
> 
> Any user that uses MAP_NOSIGBUS had better just accept that it's not
> compatible with expanding the shmem backing store later.
> 
> Signed-off-by: Ming Lin <mlin@kernel.org>

I disagree with Linus on this: I think it's a mistake,
and is being targeted at tmpfs to avoid wider scrutiny.
Though I have a more constructive suggestion under your mmap.c mod.

I've added linux-fsdevel and linux-api to the Cc list:
linux-api definitely needed to approve any MAP_NOSIGBUS semantics;
linux-fsdevel shouldn't be affected, but they need to know about it.

The prior discussion on "Sealed memfd & no-fault mmap" is at
https://lore.kernel.org/linux-mm/vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr/

I've not yet seen a response from Simon Ser, as to whether this
kind of "opaque blob of zeroes" implementation would be of any
use to Wayland: you expected it to be a problem, and we shouldn't
waste any time on it if it's not going to be useful to someone.

Maybe there will be other takers (certainly SIGBUS is unpopular).

> ---
>  include/linux/mm.h                     |  2 ++
>  include/linux/mman.h                   |  1 +
>  include/uapi/asm-generic/mman-common.h |  1 +
>  mm/mmap.c                              |  3 +++
>  mm/shmem.c                             | 17 ++++++++++++++++-
>  5 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e9d67bc..5d0e0dc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -373,6 +373,8 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
>  # define VM_UFFD_MINOR		VM_NONE
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  
> +#define VM_NOSIGBUS		VM_FLAGS_BIT(38)	/* Do not SIGBUS on out-of-band shmem read */

"out-of-band shmem read" means nothing to me: "Do not SIGBUS on fault".

> +
>  /* Bits set in the VMA until the stack is in its final location */
>  #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
>  
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index b2cbae9..c966b08 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -154,6 +154,7 @@ static inline bool arch_validate_flags(unsigned long flags)
>  	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +	       _calc_vm_trans(flags, MAP_NOSIGBUS,   VM_NOSIGBUS  ) |
>  	       arch_calc_vm_flag_bits(flags);
>  }
>  
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index f94f65d..55f4be0 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -29,6 +29,7 @@
>  #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
>  #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
>  #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +#define MAP_NOSIGBUS		0x200000	/* do not SIGBUS on out-of-band shmem read */

Ditto.

>  
>  #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
>  					 * uninitialized */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 096bba4..69cd856 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1419,6 +1419,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	if (!len)
>  		return -EINVAL;
>  
> +	if ((flags & MAP_NOSIGBUS) && ((prot & PROT_WRITE) || !shmem_file(file)))
> +		return -EINVAL;
> +

No, for several reasons.

This has nothing to do with shmem really, that's just where this patch
hacks it in - and where you have a first user in mind.  If this goes
forward, please modify mm/memory.c not mm/shmem.c, to make
VM_FAULT_SIGBUS on fault to VM_NOSIGBUS vma do the mapping of zero page.

(prot & PROT_WRITE) tells you about the mmap() flags, but says nothing
about what mprotect() could do later on.  Look out for VM_SHARED and
VM_MAYSHARE and VM_MAYWRITE further down; and beware the else (!file)
block below them, shared anonymous would need more protection too.

Constructive comment: I guess much of my objection to this feature
comes from allowing it in the MAP_SHARED case.  If you restrict it
to MAP_PRIVATE mapping of file, then it's less objectionable, and
you won't have to worry (so much?) about write protection.  Copy
on write is normal there, and it's well established that subsequent
changes in the file will not be shared; you'd just be extending that
behaviour from writes to sigbusy reads.

And by restricting to MAP_PRIVATE, you would allow for adding a
proper MAP_SHARED implementation later, if it's thought useful
(that being the implementation which can subsequently unmap a
zero page to let new page cache be mapped).

>  	/*
>  	 * Does the application expect PROT_READ to imply PROT_EXEC?
>  	 *
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5d46611..5d15b08 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1812,7 +1812,22 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  repeat:
>  	if (sgp <= SGP_CACHE &&
>  	    ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode)) {
> -		return -EINVAL;
> +		if (!vma || !(vma->vm_flags & VM_NOSIGBUS))
> +			return -EINVAL;
> +
> +		vma->vm_flags |= VM_MIXEDMAP;

No.  Presumably you hit the BUG_ON(mmap_read_trylock(vma->vm_mm))
in vm_insert_page(), so decided to modify the vm_flags here: no,
that BUG is saying you need mmap_write_lock() to write vm_flags.

And I have no idea of the ramifications of shmem in a VM_MIXEDMAP
vma; perhaps it works out fine, but I'd have to research that.
I'd rather not.

> +		/*
> +		 * Get zero page for MAP_NOSIGBUS mapping, which isn't
> +                 * coherent wrt shmem contents that are expanded and
> +		 * filled in later.
> +		 */
> +		error = vm_insert_page(vma, (unsigned long)vmf->address,
> +					ZERO_PAGE(0));
> +		if (error)
> +			return error;
> +
> +		*fault_type = VM_FAULT_NOPAGE;
> +		return 0;

But there are other ways in which shmem_getpage_gfp() can fail and
shmem_fault() end up returning VM_FAULT_SIGBUS.  Notably -ENOSPC.
It's trivial for someone to pass the MAP_NOSIGBUS user the fd of a
sparse file in a full filesystem, causing SIGBUS on access despite
MAP_NOSIGBUS.  On shmem or some other filesystem.

I say the VM_FAULT_SIGBUS->map-in-zero-page handling should be back
in mm/memory.c, where it calls ->fault(): where others can review it.

One other thing while it crosses my mind.  You'll need to decide
what truncating or hole-punching the file does to the zero pages
in its userspace mappings.  I may turn out wrong, but I think you'll
find that truncation removes them, but hole-punch leaves them, and
ought to be modified to remove them too (it's a matter of how the
"even_cows" arg to unmap_mapping_range() is treated).

Hugh

>  	}
>  
>  	sbinfo = SHMEM_SB(inode->i_sb);
> -- 
> 1.8.3.1
