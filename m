Return-Path: <linux-fsdevel+bounces-1131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63A77D614D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 07:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B8AB21243
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 05:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687E8125CC;
	Wed, 25 Oct 2023 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="CtP3+TzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6352D61D;
	Wed, 25 Oct 2023 05:47:01 +0000 (UTC)
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DA6132;
	Tue, 24 Oct 2023 22:46:58 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id A2366176EDE;
	Wed, 25 Oct 2023 07:46:53 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1698212815; bh=Fzoj7znzln2FKzFSy7EkpghoFnNQo2dDFbO99KLMZ1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CtP3+TzS8CkcsgomgnQyRoews1e8kSXl6tIW6PP+WD6S7jUaZvG8SXzQc1jmk8G/E
	 JVGgfluKh0ZFUK69XkviXYUoLMWoBpqXlVoj+g6o/MkSwFYRcIsZLf2UD15izjtD5O
	 kIGiSxnG7PwSuFgbt2n28YOlyxAV82uWECuofceWuVNOjzkxb4AaY4+WFBA+e2vMWB
	 NHze7yHWtky0MHvjo2j/KSUzOPtgQfip6wsqvb/kxwmblgqsZUBvu3YcB7TydoTx/f
	 od6AL+VJNBPeFBQ+Wl5U3hQwxkVjP/CL3Nje1qTpGnTV0EZy4vR8Cy+BODfM5l08H6
	 ifCvvmhseikqA==
Date: Wed, 25 Oct 2023 07:46:52 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Suren Baghdasaryan <surenb@google.com>, Neil Brown <neilb@suse.de>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
 vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, peterx@redhat.com, david@redhat.com, axboe@kernel.dk,
 mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com,
 vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v2 06/39] mm: enumerate all gfp flags
Message-ID: <20231025074652.44bc0eb4@meshulam.tesarici.cz>
In-Reply-To: <20231024134637.3120277-7-surenb@google.com>
References: <20231024134637.3120277-1-surenb@google.com>
	<20231024134637.3120277-7-surenb@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Oct 2023 06:46:03 -0700
Suren Baghdasaryan <surenb@google.com> wrote:

> Introduce GFP bits enumeration to let compiler track the number of used
> bits (which depends on the config options) instead of hardcoding them.
> That simplifies __GFP_BITS_SHIFT calculation.
> Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/gfp_types.h | 90 +++++++++++++++++++++++++++------------
>  1 file changed, 62 insertions(+), 28 deletions(-)
>=20
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 6583a58670c5..3fbe624763d9 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -21,44 +21,78 @@ typedef unsigned int __bitwise gfp_t;
>   * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
>   */
> =20
> +enum {
> +	___GFP_DMA_BIT,
> +	___GFP_HIGHMEM_BIT,
> +	___GFP_DMA32_BIT,
> +	___GFP_MOVABLE_BIT,
> +	___GFP_RECLAIMABLE_BIT,
> +	___GFP_HIGH_BIT,
> +	___GFP_IO_BIT,
> +	___GFP_FS_BIT,
> +	___GFP_ZERO_BIT,
> +	___GFP_UNUSED_BIT,	/* 0x200u unused */
> +	___GFP_DIRECT_RECLAIM_BIT,
> +	___GFP_KSWAPD_RECLAIM_BIT,
> +	___GFP_WRITE_BIT,
> +	___GFP_NOWARN_BIT,
> +	___GFP_RETRY_MAYFAIL_BIT,
> +	___GFP_NOFAIL_BIT,
> +	___GFP_NORETRY_BIT,
> +	___GFP_MEMALLOC_BIT,
> +	___GFP_COMP_BIT,
> +	___GFP_NOMEMALLOC_BIT,
> +	___GFP_HARDWALL_BIT,
> +	___GFP_THISNODE_BIT,
> +	___GFP_ACCOUNT_BIT,
> +	___GFP_ZEROTAGS_BIT,
> +#ifdef CONFIG_KASAN_HW_TAGS
> +	___GFP_SKIP_ZERO_BIT,
> +	___GFP_SKIP_KASAN_BIT,
> +#endif
> +#ifdef CONFIG_LOCKDEP
> +	___GFP_NOLOCKDEP_BIT,
> +#endif
> +	___GFP_LAST_BIT
> +};
> +
>  /* Plain integer GFP bitmasks. Do not use this directly. */
> -#define ___GFP_DMA		0x01u
> -#define ___GFP_HIGHMEM		0x02u
> -#define ___GFP_DMA32		0x04u
> -#define ___GFP_MOVABLE		0x08u
> -#define ___GFP_RECLAIMABLE	0x10u
> -#define ___GFP_HIGH		0x20u
> -#define ___GFP_IO		0x40u
> -#define ___GFP_FS		0x80u
> -#define ___GFP_ZERO		0x100u
> +#define ___GFP_DMA		BIT(___GFP_DMA_BIT)
> +#define ___GFP_HIGHMEM		BIT(___GFP_HIGHMEM_BIT)
> +#define ___GFP_DMA32		BIT(___GFP_DMA32_BIT)
> +#define ___GFP_MOVABLE		BIT(___GFP_MOVABLE_BIT)
> +#define ___GFP_RECLAIMABLE	BIT(___GFP_RECLAIMABLE_BIT)
> +#define ___GFP_HIGH		BIT(___GFP_HIGH_BIT)
> +#define ___GFP_IO		BIT(___GFP_IO_BIT)
> +#define ___GFP_FS		BIT(___GFP_FS_BIT)
> +#define ___GFP_ZERO		BIT(___GFP_ZERO_BIT)
>  /* 0x200u unused */

This comment can be also removed here, because it is already stated
above with the definition of ___GFP_UNUSED_BIT.

Then again, I think that the GFP bits have never been compacted after
Neil Brown removed __GFP_ATOMIC with commit 2973d8229b78 simply because
that would mean changing definitions of all subsequent GFP flags. FWIW
I am not aware of any code that would depend on the numeric value of
___GFP_* macros, so this patch seems like a good opportunity to change
the numbering and get rid of this unused 0x200u altogether.

@Neil: I have added you to the conversation in case you want to correct
my understanding of the unused bit.

Other than that LGTM.

Petr T

> -#define ___GFP_DIRECT_RECLAIM	0x400u
> -#define ___GFP_KSWAPD_RECLAIM	0x800u
> -#define ___GFP_WRITE		0x1000u
> -#define ___GFP_NOWARN		0x2000u
> -#define ___GFP_RETRY_MAYFAIL	0x4000u
> -#define ___GFP_NOFAIL		0x8000u
> -#define ___GFP_NORETRY		0x10000u
> -#define ___GFP_MEMALLOC		0x20000u
> -#define ___GFP_COMP		0x40000u
> -#define ___GFP_NOMEMALLOC	0x80000u
> -#define ___GFP_HARDWALL		0x100000u
> -#define ___GFP_THISNODE		0x200000u
> -#define ___GFP_ACCOUNT		0x400000u
> -#define ___GFP_ZEROTAGS		0x800000u
> +#define ___GFP_DIRECT_RECLAIM	BIT(___GFP_DIRECT_RECLAIM_BIT)
> +#define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
> +#define ___GFP_WRITE		BIT(___GFP_WRITE_BIT)
> +#define ___GFP_NOWARN		BIT(___GFP_NOWARN_BIT)
> +#define ___GFP_RETRY_MAYFAIL	BIT(___GFP_RETRY_MAYFAIL_BIT)
> +#define ___GFP_NOFAIL		BIT(___GFP_NOFAIL_BIT)
> +#define ___GFP_NORETRY		BIT(___GFP_NORETRY_BIT)
> +#define ___GFP_MEMALLOC		BIT(___GFP_MEMALLOC_BIT)
> +#define ___GFP_COMP		BIT(___GFP_COMP_BIT)
> +#define ___GFP_NOMEMALLOC	BIT(___GFP_NOMEMALLOC_BIT)
> +#define ___GFP_HARDWALL		BIT(___GFP_HARDWALL_BIT)
> +#define ___GFP_THISNODE		BIT(___GFP_THISNODE_BIT)
> +#define ___GFP_ACCOUNT		BIT(___GFP_ACCOUNT_BIT)
> +#define ___GFP_ZEROTAGS		BIT(___GFP_ZEROTAGS_BIT)
>  #ifdef CONFIG_KASAN_HW_TAGS
> -#define ___GFP_SKIP_ZERO	0x1000000u
> -#define ___GFP_SKIP_KASAN	0x2000000u
> +#define ___GFP_SKIP_ZERO	BIT(___GFP_SKIP_ZERO_BIT)
> +#define ___GFP_SKIP_KASAN	BIT(___GFP_SKIP_KASAN_BIT)
>  #else
>  #define ___GFP_SKIP_ZERO	0
>  #define ___GFP_SKIP_KASAN	0
>  #endif
>  #ifdef CONFIG_LOCKDEP
> -#define ___GFP_NOLOCKDEP	0x4000000u
> +#define ___GFP_NOLOCKDEP	BIT(___GFP_NOLOCKDEP_BIT)
>  #else
>  #define ___GFP_NOLOCKDEP	0
>  #endif
> -/* If the above are modified, __GFP_BITS_SHIFT may need updating */
> =20
>  /*
>   * Physical address zone modifiers (see linux/mmzone.h - low four bits)
> @@ -249,7 +283,7 @@ typedef unsigned int __bitwise gfp_t;
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> =20
>  /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT ___GFP_LAST_BIT
>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
> =20
>  /**


