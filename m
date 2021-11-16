Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D17452B12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 07:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhKPGks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 01:40:48 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:44381 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234438AbhKPGkd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:40:33 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Htbvw6xyhz9sSH;
        Tue, 16 Nov 2021 07:37:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YIPFZjdwqqfE; Tue, 16 Nov 2021 07:37:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Htbvw5wGbz9sSC;
        Tue, 16 Nov 2021 07:37:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B49D48B77A;
        Tue, 16 Nov 2021 07:37:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EAtlP181_aWQ; Tue, 16 Nov 2021 07:37:32 +0100 (CET)
Received: from [192.168.234.8] (unknown [192.168.234.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DDAF8B763;
        Tue, 16 Nov 2021 07:37:30 +0100 (CET)
Message-ID: <380a8fd0-d7c3-2487-7cd5-e6fc6e7693d9@csgroup.eu>
Date:   Tue, 16 Nov 2021 07:37:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Content-Language: fr-FR
To:     Steven Rostedt <rostedt@goodmis.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org,
        main@lists.elisa.tech, safety-architecture@lists.elisa.tech,
        devel@lists.elisa.tech, Shuah Khan <shuah@kernel.org>
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <20211115110649.4f9cb390@gandalf.local.home>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20211115110649.4f9cb390@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 15/11/2021 à 17:06, Steven Rostedt a écrit :
> On Mon, 15 Nov 2021 14:59:57 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
>> 1. Allow a reasonably configured kernel to boot and run with
>> panic_on_warn set. Warnings should only be raised when something is
>> not configured as the developers expect it or the kernel is put into a
>> state that generally is _unexpected_ and has been exposed little to
>> the critical thought of the developer, to testing efforts and use in
>> other systems in the wild. Warnings should not be used for something
>> informative, which still allows the kernel to continue running in a
>> proper way in a generally expected environment. Up to my knowledge,
>> there are some kernels in production that run with panic_on_warn; so,
>> IMHO, this requirement is generally accepted (we might of course
> 
> To me, WARN*() is the same as BUG*(). If it gets hit, it's a bug in the
> kernel and needs to be fixed. I have several WARN*() calls in my code, and
> it's all because the algorithms used is expected to prevent the condition
> in the warning from happening. If the warning triggers, it means either that
> the algorithm is wrong or my assumption about the algorithm is wrong. In
> either case, the kernel needs to be updated. All my tests fail if a WARN*()
> gets hit (anywhere in the kernel, not just my own).
> 
> After reading all the replies and thinking about this more, I find the
> pkill_on_warning actually worse than not doing anything. If you are
> concerned about exploits from warnings, the only real solution is a
> panic_on_warning. Yes, it brings down the system, but really, it has to be
> brought down anyway, because it is in need of a kernel update.
> 

We also have LIVEPATCH to avoid bringing down the system for a kernel 
update, don't we ? So I wouldn't expect bringing down a vital system 
just for a WARN.

As far as I understand from 
https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on, 
WARN() and WARN_ON() are meant to deal with those situations as 
gracefull as possible, allowing the system to continue running the best 
it can until a human controled action is taken.

So I'd expect the WARN/WARN_ON to be handled and I agree that that 
pkill_on_warning seems dangerous and unrelevant, probably more dangerous 
than doing nothing, especially as the WARN may trigger for a reason 
which has nothing to do with the running thread.

Christophe
