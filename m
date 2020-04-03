Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0819D12E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbgDCH07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 03:26:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15717 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbgDCH07 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:26:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48ts282dk9z9vBLM;
        Fri,  3 Apr 2020 09:26:56 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ptRdg/eo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id q7_0R8FodDcJ; Fri,  3 Apr 2020 09:26:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48ts281Ly7z9vBLL;
        Fri,  3 Apr 2020 09:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585898816; bh=G/gE+3SR1+TZN2RTMUhJh+L+wYW4d0v6JEe81BP7dDo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ptRdg/eo9tW40fi+LHGtu5aDnwLwI2aX5PP7bewfPrpMSzpgGlJvE1yeNnHxxyqSR
         2tQhGDeucgvb4b2+NyrAETGvtbXpRvazSbkKpkouiR7rDWL6307CWs+C8BTSEh2dHv
         exsrh+i4rtv0rLsI/kvEbENe44ABNAZpCM/aIT3M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 064FF8B943;
        Fri,  3 Apr 2020 09:26:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wpdS4NRykvtP; Fri,  3 Apr 2020 09:26:56 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BABD88B75B;
        Fri,  3 Apr 2020 09:26:54 +0200 (CEST)
Subject: Re: [PATCH v11 0/8] Disable compat cruft on ppc64le v11
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Michal Suchanek <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584620202.git.msuchanek@suse.de>
 <1585898335.tckaz04a6x.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1e00a725-9710-2b80-4aff-2f284b31d2e5@c-s.fr>
Date:   Fri, 3 Apr 2020 09:26:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585898335.tckaz04a6x.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 03/04/2020 à 09:25, Nicholas Piggin a écrit :
> Michal Suchanek's on March 19, 2020 10:19 pm:
>> Less code means less bugs so add a knob to skip the compat stuff.
>>
>> Changes in v2: saner CONFIG_COMPAT ifdefs
>> Changes in v3:
>>   - change llseek to 32bit instead of builing it unconditionally in fs
>>   - clanup the makefile conditionals
>>   - remove some ifdefs or convert to IS_DEFINED where possible
>> Changes in v4:
>>   - cleanup is_32bit_task and current_is_64bit
>>   - more makefile cleanup
>> Changes in v5:
>>   - more current_is_64bit cleanup
>>   - split off callchain.c 32bit and 64bit parts
>> Changes in v6:
>>   - cleanup makefile after split
>>   - consolidate read_user_stack_32
>>   - fix some checkpatch warnings
>> Changes in v7:
>>   - add back __ARCH_WANT_SYS_LLSEEK to fix build with llseek
>>   - remove leftover hunk
>>   - add review tags
>> Changes in v8:
>>   - consolidate valid_user_sp to fix it in the split callchain.c
>>   - fix build errors/warnings with PPC64 !COMPAT and PPC32
>> Changes in v9:
>>   - remove current_is_64bit()
>> Chanegs in v10:
>>   - rebase, sent together with the syscall cleanup
>> Changes in v11:
>>   - rebase
>>   - add MAINTAINERS pattern for ppc perf
> 
> These all look good to me. I had some minor comment about one patch but
> not really a big deal and there were more cleanups on top of it, so I
> don't mind if it's merged as is.
> 
> Actually I think we have a bit of stack reading fixes for 64s radix now
> (not a bug fix as such, but we don't need the hash fault logic in radix),
> so if I get around to that I can propose the changes in that series.
> 

As far as I can see, there is a v12

Christophe
