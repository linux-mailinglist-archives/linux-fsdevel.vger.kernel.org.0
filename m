Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20147301FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 01:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbhAXX7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 18:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbhAXX7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:59:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848E2C061756
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 15:58:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so6484881plh.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 15:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=sxDwfnXEerJ6Ap/Q1ZpbffkeUM8AptFoTvsd0C6Q/kU=;
        b=qNz69BrUzBkJ8ftoRNmFpuzCXZgxSpIzj8E3ktc0PU3k7PPfxCkWPg54CuQKJG3mLW
         yBVe/9sHtGmRt+ibX9VxGFsFZJQ0hnAPrj3FX2ohv02pmr9OsfKLXvmWnBX+GcG476Un
         1UPg4EAqZvU4+vvm6MVXfTs88aqs4wMpQN0539CIHnoigzLaOaKHhz26lWGFZ7bMRtsX
         IZKEsOhBt15yJGELFBh7t7g9MUwfz4dIXgkX3Tz2BMBPU0JUKn0V1Bk19dfsmaNvffU1
         etAFuuSlj2HbzDutByLZSnyHxJKy0b1O30vgtswm7ngQiXuaptsggRFUfBRlXh573FkA
         Wj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=sxDwfnXEerJ6Ap/Q1ZpbffkeUM8AptFoTvsd0C6Q/kU=;
        b=m3DHB1EFXaRqwe+M5frOy6PCZAvbXHDybxuC2Pu1Utx7CcYEVB5gqbVZ3HrI5c5YNf
         JGPsnrjPCIc6R+5CHamlQU0/59DhCudybkS8ZtX4sG2iG83MtN2/RoyHLmmvQacLkh3H
         u7419eQY+tSgoGzYpvqpjrDfsTw7TjE66hro1VSUvdxgiovK34uyR/gwi3JABr/GS+cQ
         NpMZKXPH61fNOtiyz4bwzWj54YgcLF7vEaWAvlE9h/MNg30qcYHmpkCz7tKcgnd659Kk
         Pp14LUxBk3zxECwV1WabIQ4v3H+m9tbwQ6fJWx1gxqa8jDRQLCXMXS3EN+Cpd1OwMebF
         4Hpw==
X-Gm-Message-State: AOAM530uwaFEAQtlMYvoy60Apy1hn7sGTvD6mMu4HiyFTYWJueYE5YHJ
        sj9M6f/JtVYCNGsmvrLJcX/J0w==
X-Google-Smtp-Source: ABdhPJy+E/G7UOngkUomksN0tFh5EcMppFPn0aGGQmMUEzvwWpJOcQItJIbh74Unizkx3EpltPrVkg==
X-Received: by 2002:a17:902:443:b029:dc:1aa4:28f0 with SMTP id 61-20020a1709020443b02900dc1aa428f0mr8522387ple.4.1611532704849;
        Sun, 24 Jan 2021 15:58:24 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a188sm15617958pfb.108.2021.01.24.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 15:58:23 -0800 (PST)
Date:   Sun, 24 Jan 2021 15:58:23 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, willy@infradead.org, osalvador@suse.de,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 02/12] mm: hugetlb: introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
In-Reply-To: <20210117151053.24600-3-songmuchun@bytedance.com>
Message-ID: <472a58b9-12cb-3c3-d132-13dbae5174f0@google.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com> <20210117151053.24600-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 17 Jan 2021, Muchun Song wrote:

> The HUGETLB_PAGE_FREE_VMEMMAP option is used to enable the freeing
> of unnecessary vmemmap associated with HugeTLB pages. The config
> option is introduced early so that supporting code can be written
> to depend on the option. The initial version of the code only
> provides support for x86-64.
> 
> Like other code which frees vmemmap, this config option depends on
> HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
> used to register bootmem info. Therefore, make sure
> register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
> is defined.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  arch/x86/mm/init_64.c |  2 +-
>  fs/Kconfig            | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 0a45f062826e..0435bee2e172 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
>  
>  static void __init register_page_bootmem_info(void)
>  {
> -#ifdef CONFIG_NUMA
> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
>  	int i;
>  
>  	for_each_online_node(i)
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 976e8b9033c4..e7c4c2a79311 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,6 +245,24 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +config HUGETLB_PAGE_FREE_VMEMMAP
> +	def_bool HUGETLB_PAGE

I'm not sure I understand the rationale for providing this help text if 
this is def_bool depending on CONFIG_HUGETLB_PAGE.  Are you intending that 
this is actually configurable and we want to provide guidance to the admin 
on when to disable it (which it currently doesn't)?  If not, why have the 
help text?

> +	depends on X86_64
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on HAVE_BOOTMEM_INFO_NODE
> +	help
> +	  The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
> +	  some vmemmap pages associated with pre-allocated HugeTLB pages.
> +	  For example, on X86_64 6 vmemmap pages of size 4KB each can be
> +	  saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
> +	  each can be saved for each 1GB HugeTLB page.
> +
> +	  When a HugeTLB page is allocated or freed, the vmemmap array
> +	  representing the range associated with the page will need to be
> +	  remapped.  When a page is allocated, vmemmap pages are freed
> +	  after remapping.  When a page is freed, previously discarded
> +	  vmemmap pages must be allocated before remapping.
> +
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
>  
