Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513E56F443C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjEBMuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjEBMuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 08:50:35 -0400
X-Greylist: delayed 161 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 05:50:21 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4AC59E7;
        Tue,  2 May 2023 05:50:20 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 11C1F14D391;
        Tue,  2 May 2023 14:50:16 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1683031817; bh=7Jx1V6HXo4qXXJ5gzNb9WgNbQl2iBAjQx92+mbN9mcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LdYat1pxvtqHcsyEsr0xSmJ80I9UQQAdwuWNsIlmRhcDv+RP+JqFNQRT+nYc9G7uP
         dXPpgO79Zyo5DI2T6iRH+RieaWMoILvCo+t0ga1IpmjPazX2dudxt9IHa/Q1eVW8Rh
         npJAxuinpIG3jaAdl3urTCU5KvJB8xckJUgufKO4oRJxNsCTGApQSCpiehfAf9XW2g
         55qZn04dxosxPP6JwtR/XcAxhlpiWK6SFfOBMCcvmnxf+hMduxm0neIM19D6X3o7mp
         /hFiYxv9D35v34aGYGGZPSYkcyumwUEB7pS25ZX4SffsQ4FOhXKIFk8+GhJJd8+bil
         9cEFx4TVmGUMg==
Date:   Tue, 2 May 2023 14:50:14 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 09/40] mm: introduce __GFP_NO_OBJ_EXT flag to
 selectively prevent slabobj_ext creation
Message-ID: <20230502145014.24b28e64@meshulam.tesarici.cz>
In-Reply-To: <20230501165450.15352-10-surenb@google.com>
References: <20230501165450.15352-1-surenb@google.com>
        <20230501165450.15352-10-surenb@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  1 May 2023 09:54:19 -0700
Suren Baghdasaryan <surenb@google.com> wrote:

> Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
> when allocating slabobj_ext on a slab.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/gfp_types.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 6583a58670c5..aab1959130f9 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -53,8 +53,13 @@ typedef unsigned int __bitwise gfp_t;
>  #define ___GFP_SKIP_ZERO	0
>  #define ___GFP_SKIP_KASAN	0
>  #endif
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +#define ___GFP_NO_OBJ_EXT       0x4000000u
> +#else
> +#define ___GFP_NO_OBJ_EXT       0
> +#endif
>  #ifdef CONFIG_LOCKDEP
> -#define ___GFP_NOLOCKDEP	0x4000000u
> +#define ___GFP_NOLOCKDEP	0x8000000u

So now we have two flags that depend on config options, but the first
one is always allocated in fact. I wonder if you could use an enum to
let the compiler allocate bits. Something similar to what Muchun Song
did with section flags.

See commit ed7802dd48f7a507213cbb95bb4c6f1fe134eb5d for reference.

>  #else
>  #define ___GFP_NOLOCKDEP	0
>  #endif
> @@ -99,12 +104,15 @@ typedef unsigned int __bitwise gfp_t;
>   * node with no fallbacks or placement policy enforcements.
>   *
>   * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
> + *
> + * %__GFP_NO_OBJ_EXT causes slab allocation to have no object
> extension. */
>  #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
>  #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
>  #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
>  #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
>  #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
> +#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
>  
>  /**
>   * DOC: Watermark modifiers
> @@ -249,7 +257,7 @@ typedef unsigned int __bitwise gfp_t;
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>  
>  /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))

If the above suggestion is implemented, this could be changed to
something like __GFP_LAST_BIT (the enum's last identifier).

Petr T
