Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293FCB14D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfILTgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 15:36:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62609 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfILTgP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 15:36:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Tpsn4QMNz9v0pL;
        Thu, 12 Sep 2019 21:36:13 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=gv+WFv1U; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id J5bNDFEMqLjf; Thu, 12 Sep 2019 21:36:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Tpsn34m8z9v0pK;
        Thu, 12 Sep 2019 21:36:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568316973; bh=3005fFALxPHkIgmwYjyZh5cupLYw+PaJ1yJpj72f8pE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gv+WFv1UUUdoduI6PNXpBDgMfVKDJz/EHrx+xBJWrm2UEIEu0irwlwNqyTDfMKq6o
         QpERIiUVj0m2BOGxGBhV9r5+cYOiiBn8mZv0NjykHqUii2432l4gaRt6ts+zimUBx7
         HnH9vIMbJcfV16Ac30eVTO0zmGFugNRO4OHeG5lI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E0C68B954;
        Thu, 12 Sep 2019 21:36:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id danhXIFBhZhB; Thu, 12 Sep 2019 21:36:13 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4AA408B949;
        Thu, 12 Sep 2019 21:36:12 +0200 (CEST)
Subject: Re: [PATCH v8 5/7] powerpc/64: make buildable without CONFIG_COMPAT
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Diana Craciun <diana.craciun@nxp.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1568306311.git.msuchanek@suse.de>
 <039ed7ac686927fe169241ac72225a258d95ccfc.1568306311.git.msuchanek@suse.de>
 <9973bf6b-f1b9-c778-bd88-ed41e45ca126@c-s.fr>
 <20190912202604.14a73423@kitsune.suse.cz>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <758324b9-203b-ec4b-affc-a30aefc9ea23@c-s.fr>
Date:   Thu, 12 Sep 2019 21:36:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190912202604.14a73423@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 12/09/2019 à 20:26, Michal Suchánek a écrit :
> On Thu, 12 Sep 2019 20:02:16 +0200
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> Le 12/09/2019 à 19:26, Michal Suchanek a écrit :
>>> There are numerous references to 32bit functions in generic and 64bit
>>> code so ifdef them out.
>>>
>>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>>> ---
>>> v2:
>>> - fix 32bit ifdef condition in signal.c
>>> - simplify the compat ifdef condition in vdso.c - 64bit is redundant
>>> - simplify the compat ifdef condition in callchain.c - 64bit is redundant
>>> v3:
>>> - use IS_ENABLED and maybe_unused where possible
>>> - do not ifdef declarations
>>> - clean up Makefile
>>> v4:
>>> - further makefile cleanup
>>> - simplify is_32bit_task conditions
>>> - avoid ifdef in condition by using return
>>> v5:
>>> - avoid unreachable code on 32bit
>>> - make is_current_64bit constant on !COMPAT
>>> - add stub perf_callchain_user_32 to avoid some ifdefs
>>> v6:
>>> - consolidate current_is_64bit
>>> v7:
>>> - remove leftover perf_callchain_user_32 stub from previous series version
>>> v8:
>>> - fix build again - too trigger-happy with stub removal
>>> - remove a vdso.c hunk that causes warning according to kbuild test robot
>>> ---
>>>    arch/powerpc/include/asm/thread_info.h |  4 +--
>>>    arch/powerpc/kernel/Makefile           |  7 ++---
>>>    arch/powerpc/kernel/entry_64.S         |  2 ++
>>>    arch/powerpc/kernel/signal.c           |  3 +-
>>>    arch/powerpc/kernel/syscall_64.c       |  6 ++--
>>>    arch/powerpc/kernel/vdso.c             |  3 +-
>>>    arch/powerpc/perf/callchain.c          | 39 ++++++++++++++------------
>>>    7 files changed, 33 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
>>> index 8e1d0195ac36..c128d8a48ea3 100644
>>> --- a/arch/powerpc/include/asm/thread_info.h
>>> +++ b/arch/powerpc/include/asm/thread_info.h
>>> @@ -144,10 +144,10 @@ static inline bool test_thread_local_flags(unsigned int flags)
>>>    	return (ti->local_flags & flags) != 0;
>>>    }
>>>    
>>> -#ifdef CONFIG_PPC64
>>> +#ifdef CONFIG_COMPAT
>>>    #define is_32bit_task()	(test_thread_flag(TIF_32BIT))
>>>    #else
>>> -#define is_32bit_task()	(1)
>>> +#define is_32bit_task()	(IS_ENABLED(CONFIG_PPC32))
>>>    #endif
>>>    
>>>    #if defined(CONFIG_PPC64)
>>
>> [...]
>>
>>> +static inline int current_is_64bit(void)
>>> +{
>>> +	if (!IS_ENABLED(CONFIG_COMPAT))
>>> +		return IS_ENABLED(CONFIG_PPC64);
>>> +	/*
>>> +	 * We can't use test_thread_flag() here because we may be on an
>>> +	 * interrupt stack, and the thread flags don't get copied over
>>> +	 * from the thread_info on the main stack to the interrupt stack.
>>> +	 */
>>> +	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
>>> +}
>>
>>
>> Since at least commit ed1cd6deb013 ("powerpc: Activate
>> CONFIG_THREAD_INFO_IN_TASK")
>> [https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed1cd6d]
>> the above comment is wrong and current_is_64bit() is equivalent to
>> !is_32bit_task()
>>
>> See https://github.com/linuxppc/issues/issues/275
>>
>> Christophe
> 
> I aim at changing the code as little as possible here. A separate patch
> on top removing this function would be ok?

Yes I agree. By making prior to this patch a separate patch which drops 
current_is_64bit() would be good. And it would reduce the size of this 
patch by approximately one third.

Christophe

> 
> Thanks
> 
> Michal
> 
