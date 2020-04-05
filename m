Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9491219E819
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Apr 2020 02:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDEAkk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 20:40:40 -0400
Received: from ozlabs.org ([203.11.71.1]:58645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgDEAkk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 20:40:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48vvwG0Lq0z9sP7;
        Sun,  5 Apr 2020 10:40:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1586047237;
        bh=Ecetm/FWyw23pFJR9aYjHEPKZAqW0as9jZfLtutKHZE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FOJ3IBC7mc8ibpgD0O6posipCUoBslj9lRk5uELexERCZFzS7zW9CSUb8ptsk096b
         +lQHDU2ACBxl75V60QihE/lrq5o4dLFUN51Y3pcnaknvfuqfNUkhA53TyO+is2N5P/
         AdZNo2eMg7ctXOPrnOsM0xsZcTRQCldx24KBrG0TodRKbhNJlrXdoyxvJh6C+fTRDm
         J174SpN5e7RaOOFXOIcPKC1agC94ZT8tRlERZ1/pqZ84Wj6qv+A0Y8s6y31ZVZznKP
         hc0MWFUe0Sg5/QOTVHcvh8FPvuV1yoeTNmD9UMUXlx0A0eurI5b0nILo816HxWGSfe
         I1xQhSMZyMSSg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
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
        Namhyung Kim <namhyung@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v11 0/8] Disable compat cruft on ppc64le v11
In-Reply-To: <1585906885.3dbukubyr8.astroid@bobo.none>
References: <20200225173541.1549955-1-npiggin@gmail.com> <cover.1584620202.git.msuchanek@suse.de> <1585898335.tckaz04a6x.astroid@bobo.none> <1e00a725-9710-2b80-4aff-2f284b31d2e5@c-s.fr> <1585906885.3dbukubyr8.astroid@bobo.none>
Date:   Sun, 05 Apr 2020 10:40:38 +1000
Message-ID: <87k12usr21.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Christophe Leroy's on April 3, 2020 5:26 pm:
>> Le 03/04/2020 =C3=A0 09:25, Nicholas Piggin a =C3=A9crit=C2=A0:
>>> Michal Suchanek's on March 19, 2020 10:19 pm:
>>>> Less code means less bugs so add a knob to skip the compat stuff.
>>>>
>>>> Changes in v2: saner CONFIG_COMPAT ifdefs
>>>> Changes in v3:
>>>>   - change llseek to 32bit instead of builing it unconditionally in fs
>>>>   - clanup the makefile conditionals
>>>>   - remove some ifdefs or convert to IS_DEFINED where possible
>>>> Changes in v4:
>>>>   - cleanup is_32bit_task and current_is_64bit
>>>>   - more makefile cleanup
>>>> Changes in v5:
>>>>   - more current_is_64bit cleanup
>>>>   - split off callchain.c 32bit and 64bit parts
>>>> Changes in v6:
>>>>   - cleanup makefile after split
>>>>   - consolidate read_user_stack_32
>>>>   - fix some checkpatch warnings
>>>> Changes in v7:
>>>>   - add back __ARCH_WANT_SYS_LLSEEK to fix build with llseek
>>>>   - remove leftover hunk
>>>>   - add review tags
>>>> Changes in v8:
>>>>   - consolidate valid_user_sp to fix it in the split callchain.c
>>>>   - fix build errors/warnings with PPC64 !COMPAT and PPC32
>>>> Changes in v9:
>>>>   - remove current_is_64bit()
>>>> Chanegs in v10:
>>>>   - rebase, sent together with the syscall cleanup
>>>> Changes in v11:
>>>>   - rebase
>>>>   - add MAINTAINERS pattern for ppc perf
>>>=20
>>> These all look good to me. I had some minor comment about one patch but
>>> not really a big deal and there were more cleanups on top of it, so I
>>> don't mind if it's merged as is.
>>>=20
>>> Actually I think we have a bit of stack reading fixes for 64s radix now
>>> (not a bug fix as such, but we don't need the hash fault logic in radix=
),
>>> so if I get around to that I can propose the changes in that series.
>>>=20
>>=20
>> As far as I can see, there is a v12
>
> For the most part I was looking at the patches in mpe's next-test
> tree on github, if that's the v12 series, same comment applies but
> it's a pretty small nitpick.

Yeah I have v12 in my tree.

This has floated around long enough (our fault), so I'm going to take it
and we can fix anything up later.

cheers
