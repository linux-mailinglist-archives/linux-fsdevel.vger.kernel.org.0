Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0677A6F444D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 14:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjEBMwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjEBMwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 08:52:44 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 05:52:40 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D3658D;
        Tue,  2 May 2023 05:52:39 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 0369514C1AA;
        Tue,  2 May 2023 14:35:32 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1683030933; bh=20jqHRbdtEj8ppcmNyyd7rJFAO2W2GN7oe2dWzqRVvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pvJgyuySDoLJG+kmwFC037D7WTQlrRk1f6tAP/S5DF4yRvNHQRW7/ahkCIvO3leti
         5pobEX0K/+x571RACLufXczVdwrcYtazeu1Un/KOB0R9qIQe+mbom2Tj1dGjq/4TLv
         dMPoj1HfCNA3A6O+iuXmXP2dOAaZTi2u5PLNFZA8btd9bxu/eJtNxHjRyjED7MKRCT
         TvmcQpmwIA0/Fl5ghTvDBzGW7yklDbxwUOtz8JQeVZryBJk3NhMCMDl5Vz+TXpCoch
         0RTOINsN038OoKKSythJat+YPJ8wlE0LZVvUegvmuhW+eFACY68/wfeoQtRtWKJXkt
         1DtPmRcDAWu7Q==
Date:   Tue, 2 May 2023 14:35:30 +0200
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 03/40] fs: Convert alloc_inode_sb() to a macro
Message-ID: <20230502143530.1586e287@meshulam.tesarici.cz>
In-Reply-To: <20230501165450.15352-4-surenb@google.com>
References: <20230501165450.15352-1-surenb@google.com>
        <20230501165450.15352-4-surenb@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  1 May 2023 09:54:13 -0700
Suren Baghdasaryan <surenb@google.com> wrote:

> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> We're introducing alloc tagging, which tracks memory allocations by
> callsite. Converting alloc_inode_sb() to a macro means allocations will
> be tracked by its caller, which is a bit more useful.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> ---
>  include/linux/fs.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 21a981680856..4905ce14db0b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2699,11 +2699,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
>   * This must be used for allocating filesystems specific inodes to set
>   * up the inode reclaim context correctly.
>   */
> -static inline void *
> -alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
> -{
> -	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
> -}
> +#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)

Honestly, I don't like this change. In general, pre-processor macros
are ugly and error-prone.

Besides, it works for you only because __kmem_cache_alloc_lru() is
declared __always_inline (unless CONFIG_SLUB_TINY is defined, but then
you probably don't want the tracking either). In any case, it's going
to be difficult for people to understand why and how this works.

If the actual caller of alloc_inode_sb() is needed, I'd rather add it
as a parameter and pass down _RET_IP_ explicitly here.

Just my two cents,
Petr T
