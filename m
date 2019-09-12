Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C29B1439
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 20:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfILSCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 14:02:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60862 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfILSCi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 14:02:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Tmnm4x1wz9vKGl;
        Thu, 12 Sep 2019 20:02:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=G9zsPVjG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Z4yIP08vdkdA; Thu, 12 Sep 2019 20:02:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Tmnm3kSRz9vKGk;
        Thu, 12 Sep 2019 20:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568311356; bh=NFdlx0RD60sqIRtqy0ISiwk5jmIOLD1S2ylFqmlItwg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G9zsPVjGyTbwj/0TtOyp+K4d2xAyJlKA0MFGs8bZ4BUHyIQx8rjdAozN0fctwIv7T
         uruc/ujdTUA9gKbXHZfPKS2J7ppJhuugRCGpbafyeTrSar7Ob3oqlYeJq7glpWLC99
         syNZb/KFkcTn4bu0KMcDqRSvSUvsPJhOPU7DutGI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9F8C8B958;
        Thu, 12 Sep 2019 20:02:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TdWyQOorlr1s; Thu, 12 Sep 2019 20:02:33 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E2D978B95E;
        Thu, 12 Sep 2019 20:02:16 +0200 (CEST)
Subject: Re: [PATCH v8 5/7] powerpc/64: make buildable without CONFIG_COMPAT
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Diana Craciun <diana.craciun@nxp.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1568306311.git.msuchanek@suse.de>
 <039ed7ac686927fe169241ac72225a258d95ccfc.1568306311.git.msuchanek@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9973bf6b-f1b9-c778-bd88-ed41e45ca126@c-s.fr>
Date:   Thu, 12 Sep 2019 20:02:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <039ed7ac686927fe169241ac72225a258d95ccfc.1568306311.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 12/09/2019 à 19:26, Michal Suchanek a écrit :
> There are numerous references to 32bit functions in generic and 64bit
> code so ifdef them out.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2:
> - fix 32bit ifdef condition in signal.c
> - simplify the compat ifdef condition in vdso.c - 64bit is redundant
> - simplify the compat ifdef condition in callchain.c - 64bit is redundant
> v3:
> - use IS_ENABLED and maybe_unused where possible
> - do not ifdef declarations
> - clean up Makefile
> v4:
> - further makefile cleanup
> - simplify is_32bit_task conditions
> - avoid ifdef in condition by using return
> v5:
> - avoid unreachable code on 32bit
> - make is_current_64bit constant on !COMPAT
> - add stub perf_callchain_user_32 to avoid some ifdefs
> v6:
> - consolidate current_is_64bit
> v7:
> - remove leftover perf_callchain_user_32 stub from previous series version
> v8:
> - fix build again - too trigger-happy with stub removal
> - remove a vdso.c hunk that causes warning according to kbuild test robot
> ---
>   arch/powerpc/include/asm/thread_info.h |  4 +--
>   arch/powerpc/kernel/Makefile           |  7 ++---
>   arch/powerpc/kernel/entry_64.S         |  2 ++
>   arch/powerpc/kernel/signal.c           |  3 +-
>   arch/powerpc/kernel/syscall_64.c       |  6 ++--
>   arch/powerpc/kernel/vdso.c             |  3 +-
>   arch/powerpc/perf/callchain.c          | 39 ++++++++++++++------------
>   7 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 8e1d0195ac36..c128d8a48ea3 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -144,10 +144,10 @@ static inline bool test_thread_local_flags(unsigned int flags)
>   	return (ti->local_flags & flags) != 0;
>   }
>   
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_COMPAT
>   #define is_32bit_task()	(test_thread_flag(TIF_32BIT))
>   #else
> -#define is_32bit_task()	(1)
> +#define is_32bit_task()	(IS_ENABLED(CONFIG_PPC32))
>   #endif
>   
>   #if defined(CONFIG_PPC64)

[...]

> +static inline int current_is_64bit(void)
> +{
> +	if (!IS_ENABLED(CONFIG_COMPAT))
> +		return IS_ENABLED(CONFIG_PPC64);
> +	/*
> +	 * We can't use test_thread_flag() here because we may be on an
> +	 * interrupt stack, and the thread flags don't get copied over
> +	 * from the thread_info on the main stack to the interrupt stack.
> +	 */
> +	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
> +}


Since at least commit ed1cd6deb013 ("powerpc: Activate 
CONFIG_THREAD_INFO_IN_TASK") 
[https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed1cd6d] 
the above comment is wrong and current_is_64bit() is equivalent to 
!is_32bit_task()

See https://github.com/linuxppc/issues/issues/275

Christophe
