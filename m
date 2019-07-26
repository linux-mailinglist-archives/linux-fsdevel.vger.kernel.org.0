Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B38A772A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 22:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGZURQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 16:17:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39483 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfGZURP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:17:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so25270631pgi.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 13:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j/IRcBqVskGgCakuPtG7Hutcm/XW9ghuXgQa4VWoPlM=;
        b=LK/US9WbkyS77sGoAMWZy8gc2tGLtDUIhGi4KMKrm9oXRfVinKUyR1ssB6V7E0lSPF
         t/FBIGuDdkXVBs+1IGdLW0u4vU7EhC8ye6/SumBvlCByTHKDzSPQANwc2+Cz5KG93322
         DxJth4doKg55yaBKLnxxhquhCyOPSzH0DfcrLstq3TIPdIfoqLAhdPV2sW/jW5uOEgZh
         9dNoVlQg4Fd0RgDO2d3e7R3Sc/NQM7WAwGpOyVBMibzfmrm1SxYT0p4MtOVewLloU9/U
         dg8autDLELzhHkbhQ0F+N69b27WnOJG4toZ032w1oSfL/RGxxCMWWcFDcxTzJ3oZGhWY
         RzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j/IRcBqVskGgCakuPtG7Hutcm/XW9ghuXgQa4VWoPlM=;
        b=hmtBKWTdOAucC0JmWLx6l9knoOWV5yKTiQYRK8/tEUK49qrB09vSI1XFHEV87UgHoJ
         9lsQBU+8XlABFMXfg8Kzx6LIWkUW93UT+tx6POi92Dvk8Ku47GDtYyzqKKEzcy/tO1fp
         nVOX8ThZC5Odp1jpVDpzqkiSFvwozLtIiLiyfDxiLsK4lwOdCl9+223P4d+gwBoHBwtC
         4WeiKJ/XzDXlxfWPAt6XTVR5/3yZTjFX0kIBOfsntu7SGJA4cyyvTNhwUm1Kz0nfzgSn
         SeTdNpGhWfbMtgLmnVvTbhI0VO4HFa+p5OW/u95e4PBpFhEQIWCl0iFcFmAng58asuwh
         OOKg==
X-Gm-Message-State: APjAAAU4q5FOk0E/pXmyXA2AJYJp+F1d6j5JJKHoNPLlmAJoq+9bP4H0
        ppoyUry0E1CNSgNBKBQsOPJ62w==
X-Google-Smtp-Source: APXvYqwxUiBPlc83U36uwiE/oXy5nDvLjq7p224Nm5j2u8JgOtNcB6axsTT2TqGR7rpxgANLPkrqZg==
X-Received: by 2002:a17:90a:220a:: with SMTP id c10mr101547847pje.33.1564172234495;
        Fri, 26 Jul 2019 13:17:14 -0700 (PDT)
Received: from sspatil-workstation.mtv.corp.google.com ([2620:15c:211:0:fb21:5c58:d6bc:4bef])
        by smtp.gmail.com with ESMTPSA id s185sm80459064pgs.67.2019.07.26.13.17.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 13:17:12 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:17:10 -0700
From:   sspatil@google.com
To:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        adobriyan@gmail.com, akpm@linux-foundation.org, bgregg@netflix.com,
        chansen3@cisco.com, dancol@google.com, fmayer@google.com,
        joaodias@google.com, joelaf@google.com, corbet@lwn.net,
        keescook@chromium.org, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rppt@linux.ibm.com, minchan@kernel.org, namhyung@google.com,
        guro@fb.com, sfr@canb.auug.org.au, surenb@google.com,
        tkjos@google.com, vdavydov.dev@gmail.com, vbabka@suse.cz,
        wvw@google.com, sspatil+mutt@google.com
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, joaodias@google.com, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        tkjos@google.com, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v3 2/2] doc: Update documentation for page_idle virtual
 address indexing
Message-ID: <20190726201710.GA144547@google.com>
References: <20190726152319.134152-1-joel@joelfernandes.org>
 <20190726152319.134152-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726152319.134152-2-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Joel, just a couple of nits for the doc inline below. Other than that,

Reviewed-by: Sandeep Patil <sspatil@google.com>

I'll plan on making changes to Android to use this instead of the pagemap +
page_idle. I think it will also be considerably faster.

On Fri, Jul 26, 2019 at 11:23:19AM -0400, Joel Fernandes (Google) wrote:
> This patch updates the documentation with the new page_idle tracking
> feature which uses virtual address indexing.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../admin-guide/mm/idle_page_tracking.rst     | 43 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
> index df9394fb39c2..1eeac78c94a7 100644
> --- a/Documentation/admin-guide/mm/idle_page_tracking.rst
> +++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
> @@ -19,10 +19,14 @@ It is enabled by CONFIG_IDLE_PAGE_TRACKING=y.
>  
>  User API
>  ========
> +There are 2 ways to access the idle page tracking API. One uses physical
> +address indexing, another uses a simpler virtual address indexing scheme.
>  
> -The idle page tracking API is located at ``/sys/kernel/mm/page_idle``.
> -Currently, it consists of the only read-write file,
> -``/sys/kernel/mm/page_idle/bitmap``.
> +Physical address indexing
> +-------------------------
> +The idle page tracking API for physical address indexing using page frame
> +numbers (PFN) is located at ``/sys/kernel/mm/page_idle``.  Currently, it
> +consists of the only read-write file, ``/sys/kernel/mm/page_idle/bitmap``.
>  
>  The file implements a bitmap where each bit corresponds to a memory page. The
>  bitmap is represented by an array of 8-byte integers, and the page at PFN #i is
> @@ -74,6 +78,31 @@ See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
>  information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
>  ``/proc/kpagecgroup``.
>  
> +Virtual address indexing
> +------------------------
> +The idle page tracking API for virtual address indexing using virtual page
> +frame numbers (VFN) is located at ``/proc/<pid>/page_idle``. It is a bitmap
> +that follows the same semantics as ``/sys/kernel/mm/page_idle/bitmap``
> +except that it uses virtual instead of physical frame numbers.
> +
> +This idle page tracking API does not need deal with PFN so it does not require

s/need//

> +prior lookups of ``pagemap`` in order to find if page is idle or not. This is

s/in order to find if page is idle or not//

> +an advantage on some systems where looking up PFN is considered a security
> +issue.  Also in some cases, this interface could be slightly more reliable to
> +use than physical address indexing, since in physical address indexing, address
> +space changes can occur between reading the ``pagemap`` and reading the
> +``bitmap``, while in virtual address indexing, the process's ``mmap_sem`` is
> +held for the duration of the access.
> +
> +To estimate the amount of pages that are not used by a workload one should:
> +
> + 1. Mark all the workload's pages as idle by setting corresponding bits in
> +    ``/proc/<pid>/page_idle``.
> +
> + 2. Wait until the workload accesses its working set.
> +
> + 3. Read ``/proc/<pid>/page_idle`` and count the number of bits set.
> +
>  .. _impl_details:
>  
>  Implementation Details
> @@ -99,10 +128,10 @@ When a dirty page is written to swap or disk as a result of memory reclaim or
>  exceeding the dirty memory limit, it is not marked referenced.
>  
>  The idle memory tracking feature adds a new page flag, the Idle flag. This flag
> -is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` (see the
> -:ref:`User API <user_api>`
> -section), and cleared automatically whenever a page is referenced as defined
> -above.
> +is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` for physical
> +addressing or by writing to ``/proc/<pid>/page_idle`` for virtual
> +addressing (see the :ref:`User API <user_api>` section), and cleared
> +automatically whenever a page is referenced as defined above.
>  
>  When a page is marked idle, the Accessed bit must be cleared in all PTEs it is
>  mapped to, otherwise we will not be able to detect accesses to the page coming
> -- 
> 2.22.0.709.g102302147b-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
