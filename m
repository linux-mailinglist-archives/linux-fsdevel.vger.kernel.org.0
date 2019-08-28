Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD3A02A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 15:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfH1NIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 09:08:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11462 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfH1NIv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:08:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46JQzg3kGdz9txhj;
        Wed, 28 Aug 2019 15:08:47 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Y5B6obTo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id r64Uwv1Lynu4; Wed, 28 Aug 2019 15:08:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46JQzg2ZmBz9txgj;
        Wed, 28 Aug 2019 15:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566997727; bh=+Ru/YcnPxN7Wge10zCE6AYHla18pP5X9f7nBPFpgkac=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y5B6obToOkjP4Ff8if0UsMGPSgW6lRVj2736s0QlPDJjUckmNBtKUkIgZmSvatPsf
         aoDQdtUuVkVJG2eHXxen8MfR7pCBI9lp7oZu2we1qegqNLnervO1Mhyx7wIC5Gngxa
         +EiYZAfDaYDJx0IMzSlW5C003iNTDs411BdWYf88=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C02748B895;
        Wed, 28 Aug 2019 15:08:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nx4I442IqYD8; Wed, 28 Aug 2019 15:08:48 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FFB28B885;
        Wed, 28 Aug 2019 15:08:48 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] Disable compat cruft on ppc64le v2
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1566987936.git.msuchanek@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <dbc5abde-ea15-be43-1fdb-d16052c19e03@c-s.fr>
Date:   Wed, 28 Aug 2019 13:08:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1566987936.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 08/28/2019 10:30 AM, Michal Suchanek wrote:
> With endian switch disabled by default the ppc64le compat supports
> ppc32le only which is something next to nobody has binaries for.
> 
> Less code means less bugs so drop the compat stuff.
> 
> I am not particularly sure about the best way to resolve the llseek
> situation. I don't see anything in the syscal tables making it
> 32bit-only so I suppose it should be available on 64bit as well.
> 
> This is tested on ppc64le top of

Really ?

I get a build failure with ppc64_defconfig + LITTLE_ENDIAN :

   CC      arch/powerpc/kernel/signal.o
arch/powerpc/kernel/signal.c: In function 'do_signal':
arch/powerpc/kernel/signal.c:250:6: error: unused variable 'is32' 
[-Werror=unused-variable]
   int is32 = is_32bit_task();
       ^~~~
cc1: all warnings being treated as errors
make[3]: *** [arch/powerpc/kernel/signal.o] Error 1

Christophe

> 
> https://patchwork.ozlabs.org/cover/1153556/
> 
> Changes in v2: saner CONFIG_COMPAT ifdefs
> 
> Thanks
> 
> Michal
> 
> Michal Suchanek (4):
>    fs: always build llseek.
>    powerpc: move common register copy functions from signal_32.c to
>      signal.c
>    powerpc/64: make buildable without CONFIG_COMPAT
>    powerpc/64: Disable COMPAT if littleendian.
> 
>   arch/powerpc/Kconfig               |   2 +-
>   arch/powerpc/include/asm/syscall.h |   2 +
>   arch/powerpc/kernel/Makefile       |  15 ++-
>   arch/powerpc/kernel/entry_64.S     |   2 +
>   arch/powerpc/kernel/signal.c       | 146 ++++++++++++++++++++++++++++-
>   arch/powerpc/kernel/signal_32.c    | 140 ---------------------------
>   arch/powerpc/kernel/syscall_64.c   |   5 +-
>   arch/powerpc/kernel/vdso.c         |   4 +-
>   arch/powerpc/perf/callchain.c      |  14 ++-
>   fs/read_write.c                    |   2 -
>   10 files changed, 177 insertions(+), 155 deletions(-)
> 
