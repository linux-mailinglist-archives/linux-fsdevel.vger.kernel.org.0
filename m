Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00BB18B384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 13:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCSMhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 08:37:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36391 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgCSMhJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:37:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48jmcx72fhz9txpt;
        Thu, 19 Mar 2020 13:37:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qPKgnd8p; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 73Jdkf_Zz9r3; Thu, 19 Mar 2020 13:37:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48jmcx5r95z9txn7;
        Thu, 19 Mar 2020 13:37:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584621425; bh=1l8seTHHmExwEDOIcnw6yPPOnKc59tjApU1N0ParQfA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qPKgnd8pWHAz0ALEh0DXg6kUaXlRtuCDj39r0To7+ErwNFGf2pV6MacAucHN+F7u2
         A5AWzbgfYDKjjoOIk6Ym4cu/bJsjEvuJYH+NkkLsOi/fQuhkPlf7nH+YnPljevNc8P
         ZQfJ8SdwY7WktUk9WiQ8Nn8BN/SHGVmZxEU+hkXE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 255868B84E;
        Thu, 19 Mar 2020 13:37:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BHYaNWr09YCd; Thu, 19 Mar 2020 13:37:07 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 028D78B769;
        Thu, 19 Mar 2020 13:37:04 +0100 (CET)
Subject: Re: [PATCH v11 0/8] Disable compat cruft on ppc64le v11
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584620202.git.msuchanek@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c5f30914-4d0c-5437-e8c4-9d62d08061e1@c-s.fr>
Date:   Thu, 19 Mar 2020 13:36:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1584620202.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You sent it twice ? Any difference between the two dispatch ?

Christophe

Le 19/03/2020 à 13:19, Michal Suchanek a écrit :
> Less code means less bugs so add a knob to skip the compat stuff.
> 
> Changes in v2: saner CONFIG_COMPAT ifdefs
> Changes in v3:
>   - change llseek to 32bit instead of builing it unconditionally in fs
>   - clanup the makefile conditionals
>   - remove some ifdefs or convert to IS_DEFINED where possible
> Changes in v4:
>   - cleanup is_32bit_task and current_is_64bit
>   - more makefile cleanup
> Changes in v5:
>   - more current_is_64bit cleanup
>   - split off callchain.c 32bit and 64bit parts
> Changes in v6:
>   - cleanup makefile after split
>   - consolidate read_user_stack_32
>   - fix some checkpatch warnings
> Changes in v7:
>   - add back __ARCH_WANT_SYS_LLSEEK to fix build with llseek
>   - remove leftover hunk
>   - add review tags
> Changes in v8:
>   - consolidate valid_user_sp to fix it in the split callchain.c
>   - fix build errors/warnings with PPC64 !COMPAT and PPC32
> Changes in v9:
>   - remove current_is_64bit()
> Chanegs in v10:
>   - rebase, sent together with the syscall cleanup
> Changes in v11:
>   - rebase
>   - add MAINTAINERS pattern for ppc perf
> 
> Michal Suchanek (8):
>    powerpc: Add back __ARCH_WANT_SYS_LLSEEK macro
>    powerpc: move common register copy functions from signal_32.c to
>      signal.c
>    powerpc/perf: consolidate read_user_stack_32
>    powerpc/perf: consolidate valid_user_sp
>    powerpc/64: make buildable without CONFIG_COMPAT
>    powerpc/64: Make COMPAT user-selectable disabled on littleendian by
>      default.
>    powerpc/perf: split callchain.c by bitness
>    MAINTAINERS: perf: Add pattern that matches ppc perf to the perf
>      entry.
> 
>   MAINTAINERS                            |   2 +
>   arch/powerpc/Kconfig                   |   5 +-
>   arch/powerpc/include/asm/thread_info.h |   4 +-
>   arch/powerpc/include/asm/unistd.h      |   1 +
>   arch/powerpc/kernel/Makefile           |   6 +-
>   arch/powerpc/kernel/entry_64.S         |   2 +
>   arch/powerpc/kernel/signal.c           | 144 +++++++++-
>   arch/powerpc/kernel/signal_32.c        | 140 ----------
>   arch/powerpc/kernel/syscall_64.c       |   6 +-
>   arch/powerpc/kernel/vdso.c             |   3 +-
>   arch/powerpc/perf/Makefile             |   5 +-
>   arch/powerpc/perf/callchain.c          | 356 +------------------------
>   arch/powerpc/perf/callchain.h          |  20 ++
>   arch/powerpc/perf/callchain_32.c       | 196 ++++++++++++++
>   arch/powerpc/perf/callchain_64.c       | 174 ++++++++++++
>   fs/read_write.c                        |   3 +-
>   16 files changed, 556 insertions(+), 511 deletions(-)
>   create mode 100644 arch/powerpc/perf/callchain.h
>   create mode 100644 arch/powerpc/perf/callchain_32.c
>   create mode 100644 arch/powerpc/perf/callchain_64.c
> 
