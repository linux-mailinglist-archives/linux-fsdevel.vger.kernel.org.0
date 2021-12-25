Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD347F2FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Dec 2021 11:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhLYKgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Dec 2021 05:36:07 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:46825 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhLYKgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:36:06 -0500
Received: by mail-ua1-f43.google.com with SMTP id 30so18600668uag.13;
        Sat, 25 Dec 2021 02:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSqSuMuP1GC9zuDtXwCcS1k5lJH6Ajg56eS0dRt9IM8=;
        b=Pms/GE/5CD7rgHExdwFv6+gOtbNA/SaBCo4KMlzBWIIbaLTDHOAb9ErCFcX3c02MXE
         8btmTuHz6mEylZyNrVd49oG5Jes5hNg1UvERfzhRJZIdaQbTbeIee8uHNIzqd5HJN1V8
         ddteujHYcpQcd7nsIhHkRcw85XcXH1WmvuxotRXe8b6E5UIXwcJ8OgkqVP4vhIXIf0to
         Q4ALlSIaI/A8NSlqiSz2wic1T/gMdmy0ZXAG6HEXplfJ+gyfDiFwTVJDbB4xJqWTQ/rL
         OPYkoPjqukq6/1jG3nCLfIrHpUGcH4P1+F2SqPqSDYw97P3MOKzvvD+1xjdC2w3J6HLG
         Ka+A==
X-Gm-Message-State: AOAM531o4gK1CLfxckVbUZ0BVkdeph2G9X2aqJo0qX6AyYOhTBUDDbJr
        3N/o4AdKMd5KO2XS6ENm1FrwE+JGPcystQ==
X-Google-Smtp-Source: ABdhPJwI2Ec9NQHfGojFI5MM10AYxO7BHlp9FJuU8sn3S4JK9g62KEpnCbrHZOuEJ+Y7uao7FyCm/g==
X-Received: by 2002:a05:6102:b04:: with SMTP id b4mr2819364vst.61.1640428565121;
        Sat, 25 Dec 2021 02:36:05 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id p12sm2036914uae.18.2021.12.25.02.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Dec 2021 02:36:04 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id p37so18661544uae.8;
        Sat, 25 Dec 2021 02:36:04 -0800 (PST)
X-Received: by 2002:a67:c81c:: with SMTP id u28mr2771847vsk.38.1640428563782;
 Sat, 25 Dec 2021 02:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20211224062246.1258487-1-hch@lst.de> <20211224062246.1258487-2-hch@lst.de>
In-Reply-To: <20211224062246.1258487-2-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 25 Dec 2021 11:35:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWcfnALb7G-5yiEZ-_s3gG_5NXgffk+hCcv24aFojwObQ@mail.gmail.com>
Message-ID: <CAMuHMdWcfnALb7G-5yiEZ-_s3gG_5NXgffk+hCcv24aFojwObQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: remove cleancache
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 25, 2021 at 2:41 AM Christoph Hellwig <hch@lst.de> wrote:
> The cleancache subsystem is unused since the removal of Xen tmem driver
> in commit 814bbf49dcd0 ("xen: remove tmem driver").
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/configs/amiga_defconfig    |   1 -
>  arch/m68k/configs/apollo_defconfig   |   1 -
>  arch/m68k/configs/atari_defconfig    |   1 -
>  arch/m68k/configs/bvme6000_defconfig |   1 -
>  arch/m68k/configs/hp300_defconfig    |   1 -
>  arch/m68k/configs/mac_defconfig      |   1 -
>  arch/m68k/configs/multi_defconfig    |   1 -
>  arch/m68k/configs/mvme147_defconfig  |   1 -
>  arch/m68k/configs/mvme16x_defconfig  |   1 -
>  arch/m68k/configs/q40_defconfig      |   1 -
>  arch/m68k/configs/sun3_defconfig     |   1 -
>  arch/m68k/configs/sun3x_defconfig    |   1 -

Although this would be removed during the next refresh anyway:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -444,28 +444,6 @@ config USE_PERCPU_NUMA_NODE_ID
>  config HAVE_SETUP_PER_CPU_AREA
>         bool
>
> -config CLEANCACHE
> -       bool "Enable cleancache driver to cache clean pages if tmem is present"
> -       help
> -         Cleancache can be thought of as a page-granularity victim cache
> -         for clean pages that the kernel's pageframe replacement algorithm
> -         (PFRA) would like to keep around, but can't since there isn't enough
> -         memory.  So when the PFRA "evicts" a page, it first attempts to use
> -         cleancache code to put the data contained in that page into
> -         "transcendent memory", memory that is not directly accessible or
> -         addressable by the kernel and is of unknown and possibly
> -         time-varying size.  And when a cleancache-enabled
> -         filesystem wishes to access a page in a file on disk, it first
> -         checks cleancache to see if it already contains it; if it does,
> -         the page is copied into the kernel and a disk access is avoided.
> -         When a transcendent memory driver is available (such as zcache or
> -         Xen transcendent memory), a significant I/O reduction
> -         may be achieved.  When none is available, all cleancache calls
> -         are reduced to a single pointer-compare-against-NULL resulting
> -         in a negligible performance hit.
> -
> -         If unsure, say Y to enable cleancache

Ah, the joy of good advice...

> -
>  config FRONTSWAP
>         bool "Enable frontswap to cache swap pages if tmem is present"
>         depends on SWAP

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
