Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4E21443F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 08:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgGDGEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 02:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgGDGEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 02:04:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E0C061794
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2020 23:04:09 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id k18so30546967qke.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2020 23:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3uTkGXCAk+3Dr7vFnMZldoI9/Xu0K+I5So+JvZVt7wE=;
        b=dIqRlaErH4Y7zKvejrBLSR/B+YkZXI5vdPMrudh/dYE310ga4jdpGQFobhwmyy2gWM
         biGPOnmnrK4NU3P3qtLrSG/oC/k/SMccPJvFdJyMte0Uv1Qr2uzWMdbHyRkJF1O04pEt
         hSRY9GSO2DlZJ9Is3ADoPrDahyDpB44lHyVFuEFh/YMzWK8Cwhc03m8eequlkv9Eiu+s
         5vEPGLdJJlndvxLPbozrzfnvorPNEnUrbrBwj0Ai1iLk2noJPm7qJmI+XYtOr7b4CCzD
         7RJdG9DdP2zPU5KOaSfMouwEP0iEG5Pl+aFgdZ7Fkq1zt6fi4SJ4Jf5qqUtveMzv/lqd
         j6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3uTkGXCAk+3Dr7vFnMZldoI9/Xu0K+I5So+JvZVt7wE=;
        b=F+DF++iwCuYJb63Amjm7GEFN0ciOoOipjjx7NTFfQysRZHS/dPF8s+2DSu+UdTaUUk
         fzOsrBwYEtceuVHcVH8s5Cludk48uA4ozcvgGpVfKCZpTwiCvMHK8C29qfsW9oVSr2xz
         Hz1Ir5D9+vkOF04JL6MSHiJp9BsVPkxc88sMzRlclUJ5MfF/kADC4mLV52LaN9ztbWaB
         8LCGujHwvhOQPOIKbRxWFxkslvO+CvwsMibKguYXw1wClnkPpyVvBKl9yMOuhmdmKV+l
         v/ReznftLyxVAj3zbrSVPiY1zF6PRHmCSB/X0W2qbYBktqsR8PIWGHZzlD1IWtFtONWG
         ODWw==
X-Gm-Message-State: AOAM5307D2bzY9cubxL80eVzXCd9hmGW58U/87xrPKI5qvc12E58utrZ
        TAd8sMONzTkCX9Zk2G/nsp0A+w==
X-Google-Smtp-Source: ABdhPJwgA4+MO/5bqb1Xtep0chOWAEMChUr7hxcnAlsU6M0jd3LkZi8JBGv+rmzWYfC2MHQ2h+HPOw==
X-Received: by 2002:a05:620a:2002:: with SMTP id c2mr18790432qka.35.1593842647186;
        Fri, 03 Jul 2020 23:04:07 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t138sm12151124qka.15.2020.07.03.23.04.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2020 23:04:06 -0700 (PDT)
Date:   Fri, 3 Jul 2020 23:03:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Chengguang Xu <cgxu519@mykernel.net>
cc:     akpm@linux-foundation.org, dxu@dxuuu.xyz, chris@chrisdown.name,
        adilger@dilger.ca, gregkh@linuxfoundation.org, tj@kernel.org,
        viro@zeniv.linux.org.uk, hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs/xattr: mm/shmem: kernfs: release simple xattr
 entry in a right way
In-Reply-To: <20200704051608.15043-1-cgxu519@mykernel.net>
Message-ID: <alpine.LSU.2.11.2007032300270.1238@eggly.anvils>
References: <20200704051608.15043-1-cgxu519@mykernel.net>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 4 Jul 2020, Chengguang Xu wrote:

> After commit fdc85222d58e ("kernfs: kvmalloc xattr value
> instead of kmalloc"), simple xattr entry is allocated with
> kvmalloc() instead of kmalloc(), so we should release it
> with kvfree() instead of kfree().
> 
> Cc: stable@vger.kernel.org # v5.7
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Hugh Dickins <hughd@google.com>
> Fixes: fdc85222d58e ("kernfs: kvmalloc xattr value instead of kmalloc")
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Good catch, thank you:
Acked-by: Hugh Dickins <hughd@google.com>

> ---
> v1->v2:
> - Fix freeing issue in simple_xattrs_free().
> - Change patch subject.
> 
>  include/linux/xattr.h | 3 ++-
>  mm/shmem.c            | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 47eaa34f8761..c5afaf8ca7a2 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/spinlock.h>
> +#include <linux/mm.h>
>  #include <uapi/linux/xattr.h>
>  
>  struct inode;
> @@ -94,7 +95,7 @@ static inline void simple_xattrs_free(struct simple_xattrs *xattrs)
>  
>  	list_for_each_entry_safe(xattr, node, &xattrs->head, list) {
>  		kfree(xattr->name);
> -		kfree(xattr);
> +		kvfree(xattr);
>  	}
>  }
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a0dbe62f8042..b2abca3f7f33 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3178,7 +3178,7 @@ static int shmem_initxattrs(struct inode *inode,
>  		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
>  					  GFP_KERNEL);
>  		if (!new_xattr->name) {
> -			kfree(new_xattr);
> +			kvfree(new_xattr);
>  			return -ENOMEM;
>  		}
>  
> -- 
> 2.20.1
> 
> 
> 
> 
