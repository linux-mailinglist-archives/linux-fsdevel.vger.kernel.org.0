Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD20452DA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 10:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhKPJP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 04:15:27 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36476 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhKPJPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:15:22 -0500
Received: by mail-wr1-f42.google.com with SMTP id s13so36195422wrb.3;
        Tue, 16 Nov 2021 01:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fmDWsP6HIgDPZm0jsUsVahurpJpoutIi09vI45Vo0Wc=;
        b=DLZBj9CxGdBdst0XrxoHuh8eHAS1Xo9ffnOi1dW3aI71J9xK4p6n+1OYe/vJ7552Q7
         WP/OnSnvp+h7EmLbfXoMZa2OYEZfIU3dT9dPBJySPOgfc+TwLt6g6GTxvJwB5PoG0A1O
         KKvcIP0gAqujBwVpM4s2hXg3c9QuzDpyyLQMfjWSBPtHp3TtvkcUvVd5TpclHvOy5Zuu
         3/Ib+PeSdCZMCrOCLzXZ1NSWEoljsCvfnssD1I/aEvtzupBo0uXSIOgVhTavT7QVNyTI
         U5V8zeoB87Jo9DdQmtKDj4DxV6J3xf+cflyFiJpoSZ+qyZkl6srgqd1hEcAYazcI7ZyF
         uDgg==
X-Gm-Message-State: AOAM532QRameECK8OYq3eod6S1tlxrXS3xwU0pwmJ9mJks1KbboxGCG9
        pFhgUZjPnDK4VLXU9oSohzI=
X-Google-Smtp-Source: ABdhPJxepms+HgoLFwnuhBFNqrvUhvNh4mcd7Wey0CxKrcVKLj1+P9n2pR6lZtm0ajXnCX83PK/xuw==
X-Received: by 2002:adf:d4c2:: with SMTP id w2mr7481224wrk.225.1637053944102;
        Tue, 16 Nov 2021 01:12:24 -0800 (PST)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id o3sm1995591wms.10.2021.11.16.01.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:12:23 -0800 (PST)
Message-ID: <59534db5-b251-c0c8-791f-58aca5c00a2b@linux.com>
Date:   Tue, 16 Nov 2021 12:12:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
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
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
 <202111151116.933184F716@keescook>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <202111151116.933184F716@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.11.2021 01:06, Kees Cook wrote:
> Hmm, yes. What it originally boiled down to, which is why Linus first
> objected to BUG(), was that we don't know what other parts of the system
> have been disrupted. The best example is just that of locking: if we
> BUG() or do_exit() in the middle of holding a lock, we'll wreck whatever
> subsystem that was attached to. Without a deterministic system state
> unwinder, there really isn't a "safe" way to just stop a kernel thread.
> 
> With this pkill_on_warn, we avoid the BUG problem (since the thread of
> execution continues and stops at an 'expected' place: the signal
> handler).
> 
> However, now we have the newer objection from Linus, which is one of
> attribution: the WARN might be hit during an "unrelated" thread of
> execution and "current" gets blamed, etc. And beyond that, if we take
> down a portion of userspace, what in userspace may be destabilized? In
> theory, we get a case where any required daemons would be restarted by
> init, but that's not "known".
> 
> The safest version of this I can think of is for processes to opt into
> this mitigation. That would also cover the "special cases" we've seen
> exposed too. i.e. init and kthreads would not opt in.
> 
> However, that's a lot to implement when Marco's tracing suggestion might
> be sufficient and policy could be entirely implemented in userspace. It
> could be as simple as this (totally untested):

I don't think that this userspace warning handling can work as pkill_on_warn.

1. The kernel code execution continues after WARN_ON(), it will not wait some 
userspace daemon that is polling trace events. That's not different from 
ignoring and having all negative effects after WARN_ON().

2. This userspace policy will miss WARN_ON_ONCE(), WARN_ONCE() and 
WARN_TAINT_ONCE() after the first hit.


Oh, wait...
I got a crazy idea that may bring more consistency in the error handling mess.

What if the Linux kernel had a LSM module responsible for error handling policy?
That would require adding LSM hooks to BUG*(), WARN*(), KERN_EMERG, etc.
In such LSM policy we can decide immediately how to react on the kernel error.
We can even decide depending on the subsystem and things like that.

(idea for brainstorming)

Best regards,
Alexander
