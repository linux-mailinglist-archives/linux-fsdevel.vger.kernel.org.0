Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D253E6BC80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfGQMkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 08:40:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46208 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQMkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:40:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so23069400qtn.13;
        Wed, 17 Jul 2019 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+81HBhn1TUwxu9S0B9qtFUuISibjz0/U9PrqDWTTnk=;
        b=XcmxneGOy+2RXDL2AYuXAVZJAiyeHolR4ac1SzJQlQzwrwi+HqWSYoPkVqq9Vqmqg1
         FqUghmpMcUzFuf3FSS4kllx0urGVacAPOsHEEssg1IcCrdVZRwWcHQ0thUX6C1t4cJoL
         vOVr8CY1w5fJWuX4PjxWH/3qfPYVDkhrsa+FNQHmIYdGekpn15GeZDeuiy9HipKh7sJh
         AHKocRO3yKYaTZLEjMvmeWDl1D3ocNZt0VWgNuaxapMwQPRA6H6V64dvA6mG81cJSpNL
         aeJplonp1P4C/Vlc9tUcpxA5HCVp2ra7Vj9yw/aq7skHSfLh4Z2PuuHUmlIKQ9cKj5Od
         nTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+81HBhn1TUwxu9S0B9qtFUuISibjz0/U9PrqDWTTnk=;
        b=nePew7iNL2rzy9UMLP4LX5YR99RKvQ9nCGtbuiO8mgZ36CimFI5C7KqlQ57RTC1Pj0
         SZMppOl8Ec+Tfya1NRLXFK6xfXxS3BXj6TjvST75k6w2l9rEZS51iYX2tJFo3vagU2Qv
         zIXJtb8ws59Kr0x0V3EloJlI2qy0VL2zx+YGBhd7nJiePxo5tCNn1/oy9HUCwOik1Y6h
         brKsVJ+EtB9WbX61PAtOkNc5Q/defhjWNfw4Yck4YktI+DxbrbpmvBZ0eozstZjhlJPh
         phmrLWKZKmVWTN23CWb0Bbkdu4xI9P/ItBYwpyfdRvpVDei18YKlTTEsYXsqvwt2olrv
         t/tQ==
X-Gm-Message-State: APjAAAV2Atavfk9+NHMNpEg3rW+OaTvh6TiHcaP7dkQXr4hokv7RxVPr
        IFXGeph5SSEH/VvinsFYTAk=
X-Google-Smtp-Source: APXvYqzbfxutvFrMV7t1nPl0gN0Fy5aGVu/YO7Xv3MDir0s1nCKm8BxCu8WphxvR5dCLt5lXuy+aag==
X-Received: by 2002:aed:33e6:: with SMTP id v93mr27856811qtd.157.1563367202971;
        Wed, 17 Jul 2019 05:40:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id y67sm11220164qkd.40.2019.07.17.05.40.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 05:40:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E255440340; Wed, 17 Jul 2019 09:39:59 -0300 (-03)
Date:   Wed, 17 Jul 2019 09:39:59 -0300
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, dhowells@redhat.com, firoz.khan@linaro.org,
        stefan@agner.ch, schwidefsky@de.ibm.com, axboe@kernel.dk,
        christian@brauner.io, hare@suse.com, deepa.kernel@gmail.com,
        tycho@tycho.ws, kim.phillips@arm.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tools: Add fchmodat4
Message-ID: <20190717123959.GB24063@kernel.org>
References: <20190717012719.5524-1-palmer@sifive.com>
 <20190717012719.5524-5-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717012719.5524-5-palmer@sifive.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Tue, Jul 16, 2019 at 06:27:19PM -0700, Palmer Dabbelt escreveu:
> I'm not sure why it's necessary to add this explicitly to tools/ as well
> as arch/, but there were a few instances of fspick in here so I blindly
> added fchmodat4 in the same fashion.

The copies in tools/ for these specific files are used to generate a
syscall table used by 'perf trace', and we don't/can't access files
outside of tools/ to build tools/perf/, so we grab a copy and have
checks in place to warn perf developers when those copies get out of
sync.

Its not required that kernel developers update anything in tools, you're
welcomed to do so if you wish tho.

Thanks,

- Arnaldo
 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  tools/include/uapi/asm-generic/unistd.h           | 4 +++-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
> index a87904daf103..36232ea94956 100644
> --- a/tools/include/uapi/asm-generic/unistd.h
> +++ b/tools/include/uapi/asm-generic/unistd.h
> @@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
>  __SYSCALL(__NR_fsmount, sys_fsmount)
>  #define __NR_fspick 433
>  __SYSCALL(__NR_fspick, sys_fspick)
> +#define __NR_fchmodat4 434
> +__SYSCALL(__NR_fchmodat4, sys_fchmodat4)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 434
> +#define __NR_syscalls 435
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index b4e6f9e6204a..b92d5b195e66 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -355,6 +355,7 @@
>  431	common	fsconfig		__x64_sys_fsconfig
>  432	common	fsmount			__x64_sys_fsmount
>  433	common	fspick			__x64_sys_fspick
> +434	common	fchmodat4		__x64_sys_fchmodat4
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> -- 
> 2.21.0

-- 

- Arnaldo
