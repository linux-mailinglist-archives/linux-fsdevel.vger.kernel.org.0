Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A46BE890
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 12:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCQLuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCQLuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E801B422B;
        Fri, 17 Mar 2023 04:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21DFEB82560;
        Fri, 17 Mar 2023 11:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8165DC433D2;
        Fri, 17 Mar 2023 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679053807;
        bh=T8NNfXFxQwO5AYO7a1OktwX6XNNJlHxRWVwZujDSwwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3tBAQGWyF+d/xztZGv8w2CJOXhMijhJ4Da4wdAf/DGrDr25vdbpQor3X0mjKeUoA
         EJAx3W+NLy0rFxU0oLEJVZyZPdpjcfKTe90OZL7MA1MB5qwW+YpJi6NzhnwdvqHows
         OlJuLWMlWh0AYgxV038lxwTtg3BZ4IVAO/Qe41OVIlyHwVa+F1UtjZ7pwC9Pxck2P9
         ubkv23es+XVnoLL2NfqNwJ0TnWlU5ZCvQGfLM/gFp8kxDQgXtVgVzaCJFrgVGOFPzM
         EyVrtvSRLfz6oSyETvktfPDkVXIOxQBg25BXOJBaX3Bxk2xem/ZYHjO+Mclq9iVrAI
         ACIk3ZQqFNVpw==
Date:   Fri, 17 Mar 2023 13:49:53 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-doc@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH v2 1/6] mm/slob: remove CONFIG_SLOB
Message-ID: <ZBRT4Q24y1vvioIY@kernel.org>
References: <20230317104307.29328-1-vbabka@suse.cz>
 <20230317104307.29328-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317104307.29328-2-vbabka@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:43:02AM +0100, Vlastimil Babka wrote:
> Remove SLOB from Kconfig and Makefile. Everything under #ifdef
> CONFIG_SLOB, and mm/slob.c is now dead code.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  init/Kconfig               |  2 +-
>  kernel/configs/tiny.config |  1 -
>  mm/Kconfig                 | 22 ----------------------
>  mm/Makefile                |  2 --
>  4 files changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 1fb5f313d18f..72ac3f66bc27 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -973,7 +973,7 @@ config MEMCG
>  
>  config MEMCG_KMEM
>  	bool
> -	depends on MEMCG && !SLOB
> +	depends on MEMCG
>  	default y
>  
>  config BLK_CGROUP
> diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
> index c2f9c912df1c..144b2bd86b14 100644
> --- a/kernel/configs/tiny.config
> +++ b/kernel/configs/tiny.config
> @@ -7,6 +7,5 @@ CONFIG_KERNEL_XZ=y
>  # CONFIG_KERNEL_LZO is not set
>  # CONFIG_KERNEL_LZ4 is not set
>  # CONFIG_SLAB is not set
> -# CONFIG_SLOB_DEPRECATED is not set
>  CONFIG_SLUB=y
>  CONFIG_SLUB_TINY=y
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4751031f3f05..669399ab693c 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -238,30 +238,8 @@ config SLUB
>  	   and has enhanced diagnostics. SLUB is the default choice for
>  	   a slab allocator.
>  
> -config SLOB_DEPRECATED
> -	depends on EXPERT
> -	bool "SLOB (Simple Allocator - DEPRECATED)"
> -	depends on !PREEMPT_RT
> -	help
> -	   Deprecated and scheduled for removal in a few cycles. SLUB
> -	   recommended as replacement. CONFIG_SLUB_TINY can be considered
> -	   on systems with 16MB or less RAM.
> -
> -	   If you need SLOB to stay, please contact linux-mm@kvack.org and
> -	   people listed in the SLAB ALLOCATOR section of MAINTAINERS file,
> -	   with your use case.
> -
> -	   SLOB replaces the stock allocator with a drastically simpler
> -	   allocator. SLOB is generally more space efficient but
> -	   does not perform as well on large systems.
> -
>  endchoice
>  
> -config SLOB
> -	bool
> -	default y
> -	depends on SLOB_DEPRECATED
> -
>  config SLUB_TINY
>  	bool "Configure SLUB for minimal memory footprint"
>  	depends on SLUB && EXPERT
> diff --git a/mm/Makefile b/mm/Makefile
> index 8e105e5b3e29..e347958fc6b2 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -22,7 +22,6 @@ KCSAN_INSTRUMENT_BARRIERS := y
>  # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
>  # free pages, or a task is migrated between nodes.
>  KCOV_INSTRUMENT_slab_common.o := n
> -KCOV_INSTRUMENT_slob.o := n
>  KCOV_INSTRUMENT_slab.o := n
>  KCOV_INSTRUMENT_slub.o := n
>  KCOV_INSTRUMENT_page_alloc.o := n
> @@ -81,7 +80,6 @@ obj-$(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	+= hugetlb_vmemmap.o
>  obj-$(CONFIG_NUMA) 	+= mempolicy.o
>  obj-$(CONFIG_SPARSEMEM)	+= sparse.o
>  obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
> -obj-$(CONFIG_SLOB) += slob.o
>  obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
>  obj-$(CONFIG_KSM) += ksm.o
>  obj-$(CONFIG_PAGE_POISONING) += page_poison.o
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
