Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10EC6FCD9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 20:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjEISTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEISTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 14:19:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C717E56;
        Tue,  9 May 2023 11:19:40 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643990c5319so4369403b3a.2;
        Tue, 09 May 2023 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683656380; x=1686248380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr7aYgFfnebTNe43NSbQgISdpDw8C+mxTxNrTLAJ2Kk=;
        b=ENRi9U7dHBzfbj5dYi+GdPIUl/OjAXCC4Rwdfcx2K43OeLVCpBVCKuRJX22b9IYZY6
         5oQFvlMJapMGSNqZLbRGyH1WX6HywEiTl9f5hBZmVyiTC1zshKefrcBeearnH1YY7OZd
         8G6KsRsMwqHm6uWcrEQcVUkBh3PyXz9+3IC3IehUxfomD2hD7odbZWkYL6OEF3CTYpaW
         uNjkm7yDdYRsyjR1VLzNivJBRyE3vufUOadgKVtmTKdilP2tvhd2QE6+QbK0pO7XDJjA
         3CEdkK4YBFBoZM/yhak9LtdlKdSZ4rSwx5wW3k3KQAlhFMFKI2z9+kuem99EYirBiY7Z
         6Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656380; x=1686248380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr7aYgFfnebTNe43NSbQgISdpDw8C+mxTxNrTLAJ2Kk=;
        b=lsODb/HpVwYqQylrUO3EpB728y/CdzDeYRMqdHNgoaQ0h1EQ/cq19DJWl/oydl6BBK
         HeV38arI1JkweUGKMBbHqGlzI6uZCfNZQ5EM0xK91DgdVAPje1lvOQ5X7k52gtGtuwL6
         VhKOdISE5CriHmNtyIDgt7bVjDrkd2AXEOoDE7I8ezLT0Pq3blYhD1oED1w/rzXh7Z1m
         Qf6NZ8c3By79o3fVM1TtlOzTTwlLCXmsDwvOOV+86J51syTyl/4naWX+eSt0r0+i46LD
         ZA5YrSvCVFWRUzrCl804OfdCzE/G1+8+blOqL7RB4cyfEDo+w4i598tQ4fXo1Yx/Bdry
         oK1Q==
X-Gm-Message-State: AC+VfDyuGOY1LQKZ2y+ZZz1f6khkpKVtcrZHul3+/3qOc5Ay8KpMZavR
        4iQ1iOS83kaEc3VsWZf+9XQ=
X-Google-Smtp-Source: ACHHUZ41jqjPjF2CraRnJ3hPLebjg5fr6OD0bBojCpKd7hrN5OidIm8BVjgmxkS7Hgbmodb7kk8pXg==
X-Received: by 2002:a05:6a20:548a:b0:101:a9b4:a4b8 with SMTP id i10-20020a056a20548a00b00101a9b4a4b8mr1279435pzk.57.1683656379762;
        Tue, 09 May 2023 11:19:39 -0700 (PDT)
Received: from localhost ([2001:4958:15a0:30:3c22:a6a6:f3a4:12ce])
        by smtp.gmail.com with ESMTPSA id v6-20020a63d546000000b004fbd91d9716sm1656756pgi.15.2023.05.09.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:19:39 -0700 (PDT)
Date:   Tue, 9 May 2023 11:19:38 -0700
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZFqOukfefifbfHMb@murray>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-8-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
>
> This is needed for bcachefs, which dynamically generates per-btree node
> unpack functions.

Small nits -

Would be good to refer to the original patch that removed it,
i.e. 7a0e27b2a0ce ("mm: remove vmalloc_exec") something like 'patch
... folded vmalloc_exec() into its one user, however bcachefs requires this
as well so revert'.

Would also be good to mention that you are now exporting the function which
the original didn't appear to do.

>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: linux-mm@kvack.org

Another nit: I'm a vmalloc reviewer so would be good to get cc'd too :)
(forgivable mistake as very recent change!)

> ---
>  include/linux/vmalloc.h |  1 +
>  kernel/module/main.c    |  4 +---
>  mm/nommu.c              | 18 ++++++++++++++++++
>  mm/vmalloc.c            | 21 +++++++++++++++++++++
>  4 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 69250efa03..ff147fe115 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -145,6 +145,7 @@ extern void *vzalloc(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_user(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
> +extern void *vmalloc_exec(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
>  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
>  extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
>  extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d3be89de70..9eaa89e84c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1607,9 +1607,7 @@ static void dynamic_debug_remove(struct module *mod, struct _ddebug_info *dyndbg
>
>  void * __weak module_alloc(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> -			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> -			NUMA_NO_NODE, __builtin_return_address(0));
> +	return vmalloc_exec(size, GFP_KERNEL);
>  }
>
>  bool __weak module_init_section(const char *name)
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 57ba243c6a..8d9ab19e39 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -280,6 +280,24 @@ void *vzalloc_node(unsigned long size, int node)
>  }
>  EXPORT_SYMBOL(vzalloc_node);
>
> +/**
> + *	vmalloc_exec  -  allocate virtually contiguous, executable memory
> + *	@size:		allocation size
> + *
> + *	Kernel-internal function to allocate enough pages to cover @size
> + *	the page level allocator and map them into contiguous and
> + *	executable kernel virtual space.
> + *
> + *	For tight control over page level allocator and protection flags
> + *	use __vmalloc() instead.
> + */
> +
> +void *vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> +{
> +	return __vmalloc(size, gfp_mask);
> +}
> +EXPORT_SYMBOL_GPL(vmalloc_exec);
> +
>  /**
>   * vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
>   *	@size:		allocation size
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 31ff782d36..2ebb9ea7f0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3401,6 +3401,27 @@ void *vzalloc_node(unsigned long size, int node)
>  }
>  EXPORT_SYMBOL(vzalloc_node);
>
> +/**
> + * vmalloc_exec - allocate virtually contiguous, executable memory
> + * @size:	  allocation size
> + *
> + * Kernel-internal function to allocate enough pages to cover @size
> + * the page level allocator and map them into contiguous and
> + * executable kernel virtual space.
> + *
> + * For tight control over page level allocator and protection flags
> + * use __vmalloc() instead.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
> +void *vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +			gfp_mask, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> +			NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +EXPORT_SYMBOL_GPL(vmalloc_exec);
> +
>  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
>  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
>  #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
> --
> 2.40.1
>

Otherwise lgtm, feel free to add:

Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
