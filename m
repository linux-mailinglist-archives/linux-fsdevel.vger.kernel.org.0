Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23BDB75C03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 02:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGZAUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 20:20:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45632 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfGZAUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:20:53 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so101116693ioc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2019 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wVoyay7NO1Taf0v9T8BEjNVHV5CQV4op2+u8nOtjKhg=;
        b=jToOEjgrbrybRXQICjzzQLCzC6a+oGnvytylhhSA9uxtg6WnH51O9ifLdSV6bfGMfa
         q8niV4muBTTLsVTSbcEIiUpVX+Amr5OSrKkakw3SIsgJ8wNsZyQBOkBDr2dbL5g7FM01
         G/XkE2FByaeoL8V88ESwf2TAB2YZjUSsL0fYgL45Wj4T/V0LKEidele78SCI55EuL/J/
         sYl0p5itnLMSTOYg3+6E06sl9nRstqfUkqQp7Rox6hXNDgUyeGkR886lLScN+95mjm/T
         aOi3Bf5eztl/MGmlss1eZVgOtDl8Lkje5E83dmFr4AAMVpQxweZF/aXyNxTquIa66KkV
         3ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wVoyay7NO1Taf0v9T8BEjNVHV5CQV4op2+u8nOtjKhg=;
        b=RnAYNXHwZCqzXgeBPho0+HRo/6Et3Gf/2vJSv+4NMWA/b6RHx34ouVc/rgYMR+5vm4
         uuIJNG/em0vJpCFATss/X9ub5+jUJZlOBDZFpqoHQRwVXvTCjEOXn6nkZU/i43sNXYHT
         //1Y6xNOHPmRGtD2tjNYrAQ4ge9BZ4WoG6+EjUYkxVTbEVUukPz1zkR1u1jwDEkQnTS/
         hafN4g6o00pnLmq2AjUwNLCUByqLZvIyztNEvHpBWk3S9ElUmwV5GYrl/cg3lEptHw4A
         ubPxLqHbjFiPF2Ij/GKD4rC5VZOpKoPnIG08vbl30oSiOPs5MlGM6WyMnddWO1jOQL2z
         j0pw==
X-Gm-Message-State: APjAAAU2u9bvcV2L2DOzJCiiYzvFTy8d28nsd1qW9WWZawZQjClbeiCt
        U7WioqhieejZ1DpnZPEMiTiclw==
X-Google-Smtp-Source: APXvYqwip5nwThbcgJqNtgafvdfTP5pQ2Oo0kmQagV/oOYV3+6lQkCabaIgCA6ODx3NeYEb64i78TA==
X-Received: by 2002:a6b:f80e:: with SMTP id o14mr15217081ioh.1.1564100452408;
        Thu, 25 Jul 2019 17:20:52 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id 20sm54026778iog.62.2019.07.25.17.20.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 17:20:51 -0700 (PDT)
Date:   Thu, 25 Jul 2019 17:20:50 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alexandre Ghiti <alex@ghiti.fr>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Cashman <dcashman@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH REBASE v4 14/14] riscv: Make mmap allocation top-down by
 default
In-Reply-To: <20190724055850.6232-15-alex@ghiti.fr>
Message-ID: <alpine.DEB.2.21.9999.1907251655310.32766@viisi.sifive.com>
References: <20190724055850.6232-1-alex@ghiti.fr> <20190724055850.6232-15-alex@ghiti.fr>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexandre,

I have a few questions about this patch.  Sorry to be dense here ...

On Wed, 24 Jul 2019, Alexandre Ghiti wrote:

> In order to avoid wasting user address space by using bottom-up mmap
> allocation scheme, prefer top-down scheme when possible.
> 
> Before:
> root@qemuriscv64:~# cat /proc/self/maps
> 00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
> 00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
> 00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
> 00018000-00039000 rw-p 00000000 00:00 0          [heap]
> 1555556000-155556d000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
> 155556d000-155556e000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
> 155556e000-155556f000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
> 155556f000-1555570000 rw-p 00000000 00:00 0
> 1555570000-1555572000 r-xp 00000000 00:00 0      [vdso]
> 1555574000-1555576000 rw-p 00000000 00:00 0
> 1555576000-1555674000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
> 1555674000-1555678000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
> 1555678000-155567a000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
> 155567a000-15556a0000 rw-p 00000000 00:00 0
> 3fffb90000-3fffbb1000 rw-p 00000000 00:00 0      [stack]
> 
> After:
> root@qemuriscv64:~# cat /proc/self/maps
> 00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
> 00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
> 00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
> 2de81000-2dea2000 rw-p 00000000 00:00 0          [heap]
> 3ff7eb6000-3ff7ed8000 rw-p 00000000 00:00 0
> 3ff7ed8000-3ff7fd6000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fd6000-3ff7fda000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fda000-3ff7fdc000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
> 3ff7fdc000-3ff7fe2000 rw-p 00000000 00:00 0
> 3ff7fe4000-3ff7fe6000 r-xp 00000000 00:00 0      [vdso]
> 3ff7fe6000-3ff7ffd000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
> 3ff7ffd000-3ff7ffe000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
> 3ff7ffe000-3ff7fff000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
> 3ff7fff000-3ff8000000 rw-p 00000000 00:00 0
> 3fff888000-3fff8a9000 rw-p 00000000 00:00 0      [stack]
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/riscv/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 59a4727ecd6c..6a63973873fd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -54,6 +54,17 @@ config RISCV
>  	select EDAC_SUPPORT
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> +	select HAVE_ARCH_MMAP_RND_BITS
> +
> +config ARCH_MMAP_RND_BITS_MIN
> +	default 18

Could you help me understand the rationale behind this constant?

> +
> +# max bits determined by the following formula:
> +#  VA_BITS - PAGE_SHIFT - 3

I realize that these lines are probably copied from arch/arm64/Kconfig.  
But the rationale behind the "- 3" is not immediately obvious.  This 
apparently originates from commit 8f0d3aa9de57 ("arm64: mm: support 
ARCH_MMAP_RND_BITS"). Can you provide any additional context here?

> +config ARCH_MMAP_RND_BITS_MAX
> +	default 33 if 64BIT # SV48 based

The rationale here is clear for Sv48, per the above formula:

   (48 - 12 - 3) = 33

> +	default 18

However, here it is less clear to me.  For Sv39, shouldn't this be

   (39 - 12 - 3) = 24

?  And what about Sv32?
 

- Paul
