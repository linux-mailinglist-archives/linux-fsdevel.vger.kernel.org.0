Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1C452DC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 10:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhKPJXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 04:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhKPJXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:23:08 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9435BC061570;
        Tue, 16 Nov 2021 01:20:11 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g17so55443599ybe.13;
        Tue, 16 Nov 2021 01:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uL7Jm6XKmLz/p56XNI662fq3bb8me6XZ7x4DITR1gcM=;
        b=jZZzTgJ6bZHqeQTMZwBHo1tHL+QpNp0zSbUY2IaLa8GfV/fCLv2CAAPTDOyb/I5Kbq
         EvQM7uMSZ7SoQ3wICAlksVWYXrQxhynXQYXgOCb+oEjfStBVNdJePYbbfXk/P9W1wIG1
         4Td7E9XwDpUOlx5BtWkvZs5/jYTSluZi5RiGJJhcmL+niJ1qPgEkFKTwvWMhUmmYTKyq
         HVoSkvi+P0o6/J+YaPjLOecP+BCuUxa4gsrYoWeac8ft7aOLdewtns8PHL5Ffs8oVnYa
         mFh8UehubUEe2MAIERVLQ90yMRH2wtkjkpc9dlOPHuFzFVxfzJKATbVNSi9ZJkMXcEs0
         qJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uL7Jm6XKmLz/p56XNI662fq3bb8me6XZ7x4DITR1gcM=;
        b=3mgML6KPhf7yiPdMdtdzdy4hJpeS7FOs1EwV65DbFVK9di9WTwOI/jaWIQ1vOElsIE
         UQS5SFcsQxxWTcgf9Zs1eb5fT3JO+nxBO+8qLBQnpzgiBDMCquRp62Jq4rd6mfQAqXfR
         1+7NrvB1BQo7f1FgT75XawNbVtMwBP5h0A6/WmSAYaQEhSRORzbMESyjfvI5o/CTMvpM
         raaxzkaDC4b43msGpLHnq3SkLN2HrOAYpHnBHZszLzM1FxfhejcHs0j1P3EVQ9F3GpJI
         M5JuI7UD2arNwLl1cTNDGMWM/5uPJ1Nbb6Nt1aIgaA+/xJ2OuSVtLsUwWLV/OhM6syMY
         o7dw==
X-Gm-Message-State: AOAM533WkBqDGIDResZ43E/fh7lLMK/Jo9d22F4EB+ecXC/rbvZIsBiO
        tyAe0W5NnZoPtB1T0YrAYhKNXXQryzhCBcdxlnA=
X-Google-Smtp-Source: ABdhPJxGHazE9H148jSn/ExpwNjwC0uS4WFxjqOELZgXptruTPWUd7bCD9Q2PpdRxmqGsgNSXy7MsBcsIRGW5FZdYT4=
X-Received: by 2002:a25:71c3:: with SMTP id m186mr6376598ybc.434.1637054410786;
 Tue, 16 Nov 2021 01:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20211027233215.306111-1-alex.popov@linux.com> <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com> <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <22828e84-b34f-7132-c9e9-bb42baf9247b@redhat.com> <cf57fb34-460c-3211-840f-8a5e3d88811a@linux.com>
 <YZNuyssYsAB0ogUD@alley>
In-Reply-To: <YZNuyssYsAB0ogUD@alley>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 16 Nov 2021 10:19:59 +0100
Message-ID: <CAKXUXMxvusD3a4xXsG2Ca-fu1ji-Z7fBvC+1JzKqFQvdXTXXpQ@mail.gmail.com>
Subject: Re: [ELISA Safety Architecture WG] [PATCH v2 0/2] Introduce the
 pkill_on_warn parameter
To:     Petr Mladek <pmladek@suse.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Robert Krutsch <krutsch@gmail.com>,
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
        Kees Cook <keescook@chromium.org>,
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
        Steven Rostedt <rostedt@goodmis.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 9:41 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2021-11-16 10:52:39, Alexander Popov wrote:
> > On 15.11.2021 18:51, Gabriele Paoloni wrote:
> > > On 15/11/2021 14:59, Lukas Bulwahn wrote:
> > > > On Sat, Nov 13, 2021 at 7:14 PM Alexander Popov <alex.popov@linux.com> wrote:
> > > > > On 13.11.2021 00:26, Linus Torvalds wrote:
> > > > > > On Fri, Nov 12, 2021 at 10:52 AM Alexander Popov <alex.popov@linux.com> wrote:
> > > > > Killing the process that hit a kernel warning complies with the Fail-Fast
> > > > > principle [1]. pkill_on_warn sysctl allows the kernel to stop the process when
> > > > > the **first signs** of wrong behavior are detected.
> > > > >
> > > > In summary, I am not supporting pkill_on_warn. I would support the
> > > > other points I mentioned above, i.e., a good enforced policy for use
> > > > of warn() and any investigation to understand the complexity of
> > > > panic() and reducing its complexity if triggered by such an
> > > > investigation.
> > >
> > > Hi Alex
> > >
> > > I also agree with the summary that Lukas gave here. From my experience
> > > the safety system are always guarded by an external flow monitor (e.g. a
> > > watchdog) that triggers in case the safety relevant workloads slows down
> > > or block (for any reason); given this condition of use, a system that
> > > goes into the panic state is always safe, since the watchdog would
> > > trigger and drive the system automatically into safe state.
> > > So I also don't see a clear advantage of having pkill_on_warn();
> > > actually on the flip side it seems to me that such feature could
> > > introduce more risk, as it kills only the threads of the process that
> > > caused the kernel warning whereas the other processes are trusted to
> > > run on a weaker Kernel (does killing the threads of the process that
> > > caused the kernel warning always fix the Kernel condition that lead to
> > > the warning?)
> >
> > Lukas, Gabriele, Robert,
> > Thanks for showing this from the safety point of view.
> >
> > The part about believing in panic() functionality is amazing :)
>
> Nothing is 100% reliable.
>
> With printk() maintainer hat on, the current panic() implementation
> is less reliable because it tries hard to provide some debugging
> information, for example, error message, backtrace, registry,
> flush pending messages on console, crashdump.
>
> See panic() implementation, the reboot is done by emergency_restart().
> The rest is about duping the information.
>
> Well, the information is important. Otherwise, it is really hard to
> fix the problem.
>
> From my experience, especially the access to consoles is not fully
> safe. The reliability might improve a lot when a lockless console
> is used. I guess that using non-volatile memory for the log buffer
> might be even more reliable.
>
> I am not familiar with the code under emergency_restart(). I am not
> sure how reliable it is.
>
> > Yes, safety critical systems depend on the robust ability to restart.
>
> If I wanted to implement a super-reliable panic() I would
> use some external device that would cause power-reset when
> the watched device is not responding.
>

Petr, that is basically the common system design taken.

The whole challenge then remains to show that:

Once panic() was invoked, the watched device does not signal being
alive unintentionally, while the panic() is stuck in its shutdown
routines. That requires having a panic() or other shutdown routine
that still reliably can do something that the kernel routine that
makes the watched device signal does not signal anymore.


Lukas

> Best Regards,
> Petr
>
>
> PS: I do not believe much into the pkill approach as well.
>
>     It is similar to OOM killer. And I always had to restart the
>     system when it was triggered.
>
>     Also kernel is not prepared for the situation that an external
>     code kills a kthread. And kthreads are used by many subsystems
>     to handle work that has to be done asynchronously and/or in
>     process context. And I guess that kthreads are non-trivial
>     source of WARN().
