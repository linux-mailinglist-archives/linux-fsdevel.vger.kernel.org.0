Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0026FCBA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEIQs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEIQsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:48:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31A419B3;
        Tue,  9 May 2023 09:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 679926314A;
        Tue,  9 May 2023 16:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADCFC433EF;
        Tue,  9 May 2023 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683650933;
        bh=/5mgumQsRWcCzDVcW6dKY3+mva/nAJpSN1nWmyf57wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkyD9qXGv6gqLuWoxG7a4O/2aL77tF6C4CjEFN5pbY1qgoYmUgdl6YB0ErIZrSbwx
         6l5qij0vpzrKEr0RUgkZgW96SXq5sSiLT7kS1XTwbHyyvAN2nAkOqRQkVA0y4UFbHM
         JFn4bQsYzFSx2fskfwymVNAvXzfy07AsWs3oCQl/bjFs7tZQ0cou2/DHgmN6yArTne
         SdquKQ8yztySUb72ETE7u+Fn/2PVbTHPUKdyY394XjU2uJA4yxP5Z5KM/bl8C0GS+y
         gPIRZcDY9QGNqM/jAAeCJ2E8vAMz9FsIHgEQDZWglWacFL4jIjCx7IYjHOBIqfLuZw
         jAx3PvLiwTjQQ==
Date:   Tue, 9 May 2023 09:48:51 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] mm: page_alloc: remove alloc_contig_dump_pages()
 stub
Message-ID: <20230509164851.GD4135@kernel.org>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
 <20230508071200.123962-7-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508071200.123962-7-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 03:11:54PM +0800, Kefeng Wang wrote:
> DEFINE_DYNAMIC_DEBUG_METADATA and DYNAMIC_DEBUG_BRANCH already has
> stub definitions without dynamic debug feature, remove unnecessary
> alloc_contig_dump_pages() stub.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/page_alloc.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 348dcbaca757..bc453edbad21 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6161,8 +6161,6 @@ int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> -#if defined(CONFIG_DYNAMIC_DEBUG) || \
> -	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
>  static void alloc_contig_dump_pages(struct list_head *page_list)
>  {
> @@ -6176,11 +6174,6 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
>  			dump_page(page, "migration failure");
>  	}
>  }
> -#else
> -static inline void alloc_contig_dump_pages(struct list_head *page_list)
> -{
> -}
> -#endif
>  
>  /* [start, end) must belong to a single zone. */
>  int __alloc_contig_migrate_range(struct compact_control *cc,
> -- 
> 2.35.3
> 
