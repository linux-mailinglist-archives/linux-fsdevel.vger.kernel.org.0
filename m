Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F18452D62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 09:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhKPJAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 04:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhKPJAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:00:39 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CB2C061570;
        Tue, 16 Nov 2021 00:57:41 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id u60so55317143ybi.9;
        Tue, 16 Nov 2021 00:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fArE1d3Ulykml4CgLbAJBmsnXKMaBKmi+cka7s12SBg=;
        b=qZh4d7ufoMlh5QZR9cyM9/ddtzbSL2TmEVwCAX95NMlhNd5MAOhMGfSY7glHz/kM35
         4+oNv9sFAnrtWD22RT/iCf+OVUvS7jBsLYlBcKZibDKdrc6SZhLZ6MXcpNbGMK7zwjUU
         IeHGIEOj6VHcfcRWucDx3Ntjlk27TT+joR0/UdOhyCYqOABts9r7zWIPQo2ooCoK0X2r
         N0niQsSYlDNFiGSxSd8XHwL3mBKujcHc/Lif6yYv9NK0Ly+Rb8+QzqGLH8pNkndNPX+o
         WWpKDoszQqlLgt6ejGVoPUWlEkqY/q5H2qbmCwwqeeBByyWTU4pPRyibhJ88N/7LhXNM
         fMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fArE1d3Ulykml4CgLbAJBmsnXKMaBKmi+cka7s12SBg=;
        b=GZSAATLYbH/6yg5770xfuSlBIongU+z+r/wzvGbiPPKpMP2JHR6ktsc+s3txdhKGTz
         qKMjgZy7m4WOzwORjjdI4EXfaf8r0PRQA6r8OLXYkoTmeT1JVLssLp6P9wexl11cWEQC
         TVVPOzgw4fk0k8y6lcUbzeoS+FRki9Y/okplfoEn18ch3D1+EdQII/eUGsZi+ywTasJf
         ckWggmf9pYqE9WqBGbLTfCNNKDSTqYOf8zmNk0bgSU3qzo6df5nMykyD+0WW8XSp8N0Z
         sa4jXeJ0XQiT+8cxjGVs3aXR6Qj46DJHRKOSP3Pv9oNsYpFovI8kANZ9aTnpiJRfguVx
         MdCA==
X-Gm-Message-State: AOAM531NFmvZ2TyNofh0d+g6xL0KSTdLPRdMPeK8c92ScLvseDNscko3
        cS1wPKEpY7u9JuxMJMeCtnEkOHht2wMPrR/i13M=
X-Google-Smtp-Source: ABdhPJxfFAVkOZNzOziDBttm9KDunA8P0GQbNKqKUE387cNuKoKqYunYpWbm15kx9wqKWRxobW74MXXVzuM4for8PxA=
X-Received: by 2002:a25:34d5:: with SMTP id b204mr6119397yba.154.1637053060362;
 Tue, 16 Nov 2021 00:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20211027233215.306111-1-alex.popov@linux.com> <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com> <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <20211115110649.4f9cb390@gandalf.local.home> <380a8fd0-d7c3-2487-7cd5-e6fc6e7693d9@csgroup.eu>
In-Reply-To: <380a8fd0-d7c3-2487-7cd5-e6fc6e7693d9@csgroup.eu>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 16 Nov 2021 09:57:28 +0100
Message-ID: <CAKXUXMxqg3MpwBMUSrjNS222C=MptrLiE5VXTVpVwXSQjSgKrA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Popov <alex.popov@linux.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 7:37 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 15/11/2021 =C3=A0 17:06, Steven Rostedt a =C3=A9crit :
> > On Mon, 15 Nov 2021 14:59:57 +0100
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> >> 1. Allow a reasonably configured kernel to boot and run with
> >> panic_on_warn set. Warnings should only be raised when something is
> >> not configured as the developers expect it or the kernel is put into a
> >> state that generally is _unexpected_ and has been exposed little to
> >> the critical thought of the developer, to testing efforts and use in
> >> other systems in the wild. Warnings should not be used for something
> >> informative, which still allows the kernel to continue running in a
> >> proper way in a generally expected environment. Up to my knowledge,
> >> there are some kernels in production that run with panic_on_warn; so,
> >> IMHO, this requirement is generally accepted (we might of course
> >
> > To me, WARN*() is the same as BUG*(). If it gets hit, it's a bug in the
> > kernel and needs to be fixed. I have several WARN*() calls in my code, =
and
> > it's all because the algorithms used is expected to prevent the conditi=
on
> > in the warning from happening. If the warning triggers, it means either=
 that
> > the algorithm is wrong or my assumption about the algorithm is wrong. I=
n
> > either case, the kernel needs to be updated. All my tests fail if a WAR=
N*()
> > gets hit (anywhere in the kernel, not just my own).
> >
> > After reading all the replies and thinking about this more, I find the
> > pkill_on_warning actually worse than not doing anything. If you are
> > concerned about exploits from warnings, the only real solution is a
> > panic_on_warning. Yes, it brings down the system, but really, it has to=
 be
> > brought down anyway, because it is in need of a kernel update.
> >
>
> We also have LIVEPATCH to avoid bringing down the system for a kernel
> update, don't we ? So I wouldn't expect bringing down a vital system
> just for a WARN.
>
> As far as I understand from
> https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bu=
g-on,
> WARN() and WARN_ON() are meant to deal with those situations as
> gracefull as possible, allowing the system to continue running the best
> it can until a human controled action is taken.
>
> So I'd expect the WARN/WARN_ON to be handled and I agree that that
> pkill_on_warning seems dangerous and unrelevant, probably more dangerous
> than doing nothing, especially as the WARN may trigger for a reason
> which has nothing to do with the running thread.
>

Christophe,

I agree with a reasonable goal that WARN() should allow users "to deal
with those situations as gracefull as possible, allowing the system to
continue running the best it can until a human controled action is
taken."

However, that makes me wonder even more: what does the system after a
WARN() invocation still need to provide as properly working
functionality, so that the human can take action, and how can the
kernel indicate to the whole user applications that a certain
functionality is not working anymore and how adaptive can those user
application really be here? Making that explicit for every WARN()
invocation seems to be tricky and probably also quite error-prone. So,
in the end, after a WARN(), you end up running a system where you have
this uncomfortable feeling of a running system where some things work
and some things do not and it might be insecure (the whole system
security concept is invalidated, because security features do not
work, security holes are opened etc.) or other surprises happen.

The panic_on_warn implements a simple policy of that "run as graceful
as possible": We assume stopping the kernel is _graceful_, and we just
assume that the functionality "panic shuts down the system" still
works properly after any WARN() invocation. Once the system is shut
down, the human can take action and switch it into some (remote)
diagnostic mode for further analysis and repair.

I am wondering if that policy and that assumption holds for all WARN()
invocations in the kernel? I would hope that we can answer this
question, which is much simpler than getting the precise answer on
"what as graceful as possible actually means".

Lukas
