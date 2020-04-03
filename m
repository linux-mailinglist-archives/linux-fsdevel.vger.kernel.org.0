Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A129519D128
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 09:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbgDCHZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 03:25:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38965 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbgDCHZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:25:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id k18so2379385pll.6;
        Fri, 03 Apr 2020 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=gWN2/l3Nk/lqsKPF1eViKQ9o9AZt+XSnO9fYcexJ5do=;
        b=i3oPTvsH5TefcZSZ/s6cffxKNlmPapTR0Q18gP6u0mf/PMRHwDbL2wMinlbhvtjzE9
         KMyVIR96vM2c4ZYzaRNYjWN2UL+Dd+CnEUla7XPaBIMJ/hslJUXLoqHnMKXgJfJC9IAp
         OWDPIN7DJ5qcvEKf2xLRfjwt1xPzCT3PfRjdbUbFXzbRM2Lb4wXi9irkzkWffxvnc5/F
         KB8eJVttUWM3vacwK3+R777MHdc+WXvEqYKX1ZvYy5AL6Y45SbW/W9WZN1ICx/edWvmk
         cLVPOd0BXu7Au8JXVDcwD5lTyHkgsWxs4z96cAVY0rv4QN5ptCxTRrZQkCNYJSUEJyyn
         L6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=gWN2/l3Nk/lqsKPF1eViKQ9o9AZt+XSnO9fYcexJ5do=;
        b=KI7zYHQF47F20DM41plCmPVjO8jw6hFthvmD303ZRILTfDxKiCBi39fFxogdqYESO0
         2vZP5GdTnegMRSCV+mdDwm9yY3zu5i2rZj2HphOdLRsPpArkflURmZIiuevoq4LyLQGq
         pGGb1OVqwu0G75xaPpkDK7eRbF3nxVdaXNfTOOhMKmiIqxy8+EOIlEu/E1W7v/V5JpwQ
         xE4TA4nRzn2BqHFqIeB3fBHR2FfRRV1ENnhfYyc9VrGze+rbqO8wl7VkfmEFpk3lRNL4
         c6dzljWUhrzfs1E3uLpAeMzZBmeLNZFDHAZNfMMlm0m6wBaAklMXhX7XsL1xNv1xhVhh
         jRdA==
X-Gm-Message-State: AGi0PuaSITHjAdJU8n9VkyTRkM5WbjzbdSfcHa/PzvtdEU8DE9VNpeT+
        JVvhK6Piq9ASihBlJCs89Q0=
X-Google-Smtp-Source: APiQypLvOn0Dugjcw4rcQbIFXLiJdhks1PnmfqUpwNAhu3DD4RMhhi5GkyAqP+L0q44XeXBvYh6XbQ==
X-Received: by 2002:a17:90a:35ce:: with SMTP id r72mr8190743pjb.126.1585898719557;
        Fri, 03 Apr 2020 00:25:19 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id l190sm5103624pfl.212.2020.04.03.00.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:25:18 -0700 (PDT)
Date:   Fri, 03 Apr 2020 17:25:13 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v11 0/8] Disable compat cruft on ppc64le v11
To:     linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
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
In-Reply-To: <cover.1584620202.git.msuchanek@suse.de>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585898335.tckaz04a6x.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Suchanek's on March 19, 2020 10:19 pm:
> Less code means less bugs so add a knob to skip the compat stuff.
>=20
> Changes in v2: saner CONFIG_COMPAT ifdefs
> Changes in v3:
>  - change llseek to 32bit instead of builing it unconditionally in fs
>  - clanup the makefile conditionals
>  - remove some ifdefs or convert to IS_DEFINED where possible
> Changes in v4:
>  - cleanup is_32bit_task and current_is_64bit
>  - more makefile cleanup
> Changes in v5:
>  - more current_is_64bit cleanup
>  - split off callchain.c 32bit and 64bit parts
> Changes in v6:
>  - cleanup makefile after split
>  - consolidate read_user_stack_32
>  - fix some checkpatch warnings
> Changes in v7:
>  - add back __ARCH_WANT_SYS_LLSEEK to fix build with llseek
>  - remove leftover hunk
>  - add review tags
> Changes in v8:
>  - consolidate valid_user_sp to fix it in the split callchain.c
>  - fix build errors/warnings with PPC64 !COMPAT and PPC32
> Changes in v9:
>  - remove current_is_64bit()
> Chanegs in v10:
>  - rebase, sent together with the syscall cleanup
> Changes in v11:
>  - rebase
>  - add MAINTAINERS pattern for ppc perf

These all look good to me. I had some minor comment about one patch but=20
not really a big deal and there were more cleanups on top of it, so I=20
don't mind if it's merged as is.

Actually I think we have a bit of stack reading fixes for 64s radix now
(not a bug fix as such, but we don't need the hash fault logic in radix),
so if I get around to that I can propose the changes in that series.

Thanks,
Nick
=
