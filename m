Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613F8452C51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 09:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKPIEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 03:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhKPIE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:04:27 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3DFC061570;
        Tue, 16 Nov 2021 00:01:30 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id s186so54978228yba.12;
        Tue, 16 Nov 2021 00:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+T6XK8FIB+LZn0bxtNBWPmVOIcqiKDktRRtbRmo1oaA=;
        b=IJsqxnbikTYAjhyFfXUp2P4C0SUzw+nJHTGtgM0wZJUciCU5Gy3ucoA1beymsmWJLE
         RLMAOG2XvHS+6WYCE/CoQh9sNCuf7sJN52fHLtjjlMNeTR2yn43oggse5rxG1Hab7lc0
         a5Tz3tJ5v/4ZzhMQ5D/6SV2SNSmprKOUTzjS+Y7w8HF61PqeOmXY70PF3cl7wOGe5bOD
         pDNVrf9RtoWbvPcJFoHnvAKOLAXFk/CFIK6ABlfJlfwCC6nsCsBbbDTLeNoP7qwfRkFL
         HNzjqpC+LSvctHt/SSrMQtHJtgo0NxVXn5CUvIUrsG5ecbz7yIu/s8HggxswYam0s65R
         rfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T6XK8FIB+LZn0bxtNBWPmVOIcqiKDktRRtbRmo1oaA=;
        b=4RbZxku70i336aCrNC39Mr5qT9bEj868rjLX/+rEYpt5YssdPrWLjlxR5Dx8hDf6UT
         B72wYAN2Zf3JkaRApUgDStx85+1N3ubmiBr+3ASNB12A0dqiS6UK958xXrCLH2f1d7Iz
         0MbEc/CNpltkyGyKVQ5In3NY6KaRjolm1IyWjDGiBh8ov404tk6ruup4FvsU1vqDa+yI
         rcgYWZFi4QYvfBeHf4DRYyNozPHPVAZyHGDKdvU+CdsL9XkjAylkHu5JlaApK1/DHgmf
         7LkFQ21USfxjkJGC2es8u5mJUbMHEeCaT9rzkqjX/CZQZmB8GzofGVyCLQwVsK0HvE8I
         QoMQ==
X-Gm-Message-State: AOAM530vt7HV1d9x0GVY0HPGdTlMwEsPzPuhOce1kKKZdXmCkxhM95KG
        Xm2WeHlRNiuOeqVsoWONFHlgl/u1IIcKDRb6qYs=
X-Google-Smtp-Source: ABdhPJxdu/R2v5T0CToHQSaQwshPblewLn7lsYZk5zCJ0IzLSiis/Hq6uQjzSVekq28rE3E6HMJyNT0J+wR6BF+k4rc=
X-Received: by 2002:a25:3787:: with SMTP id e129mr5784440yba.91.1637049689367;
 Tue, 16 Nov 2021 00:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20211027233215.306111-1-alex.popov@linux.com> <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com> <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
 <22828e84-b34f-7132-c9e9-bb42baf9247b@redhat.com> <cf57fb34-460c-3211-840f-8a5e3d88811a@linux.com>
In-Reply-To: <cf57fb34-460c-3211-840f-8a5e3d88811a@linux.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 16 Nov 2021 09:01:17 +0100
Message-ID: <CAKXUXMzRAkCPQuJJ8b5p1Fi+c-YKgXwP4pU9pUJdWaPpRXbPaQ@mail.gmail.com>
Subject: Re: [ELISA Safety Architecture WG] [PATCH v2 0/2] Introduce the
 pkill_on_warn parameter
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Gabriele Paoloni <gpaoloni@redhat.com>,
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
        Petr Mladek <pmladek@suse.com>,
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

On Tue, Nov 16, 2021 at 8:52 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 15.11.2021 18:51, Gabriele Paoloni wrote:
> >
> >
> > On 15/11/2021 14:59, Lukas Bulwahn wrote:
> >> On Sat, Nov 13, 2021 at 7:14 PM Alexander Popov <alex.popov@linux.com> wrote:
> >>>
> >>> On 13.11.2021 00:26, Linus Torvalds wrote:
> >>>> On Fri, Nov 12, 2021 at 10:52 AM Alexander Popov <alex.popov@linux.com> wrote:
> >>>>>
> >>>>> Hello everyone!
> >>>>> Friendly ping for your feedback.
> >>>>
> >>>> I still haven't heard a compelling _reason_ for this all, and why
> >>>> anybody should ever use this or care?
> >>>
> >>> Ok, to sum up:
> >>>
> >>> Killing the process that hit a kernel warning complies with the Fail-Fast
> >>> principle [1]. pkill_on_warn sysctl allows the kernel to stop the process when
> >>> the **first signs** of wrong behavior are detected.
> >>>
> >>> By default, the Linux kernel ignores a warning and proceeds the execution from
> >>> the flawed state. That is opposite to the Fail-Fast principle.
> >>> A kernel warning may be followed by memory corruption or other negative effects,
> >>> like in CVE-2019-18683 exploit [2] or many other cases detected by the SyzScope
> >>> project [3]. pkill_on_warn would prevent the system from the errors going after
> >>> a warning in the process context.
> >>>
> >>> At the same time, pkill_on_warn does not kill the entire system like
> >>> panic_on_warn. That is the middle way of handling kernel warnings.
> >>> Linus, it's similar to your BUG_ON() policy [4]. The process hitting BUG_ON() is
> >>> killed, and the system proceeds to work. pkill_on_warn just brings a similar
> >>> policy to WARN_ON() handling.
> >>>
> >>> I believe that many Linux distros (which don't hit WARN_ON() here and there)
> >>> will enable pkill_on_warn because it's reasonable from the safety and security
> >>> points of view.
> >>>
> >>> And I'm sure that the ELISA project by the Linux Foundation (Enabling Linux In
> >>> Safety Applications [5]) would support the pkill_on_warn sysctl.
> >>> [Adding people from this project to CC]
> >>>
> >>> I hope that I managed to show the rationale.
> >>>
> >>
> >> Alex, officially and formally, I cannot talk for the ELISA project
> >> (Enabling Linux In Safety Applications) by the Linux Foundation and I
> >> do not think there is anyone that can confidently do so on such a
> >> detailed technical aspect that you are raising here, and as the
> >> various participants in the ELISA Project have not really agreed on
> >> such a technical aspect being one way or the other and I would not see
> >> that happening quickly. However, I have spent quite some years on the
> >> topic on "what is the right and important topics for using Linux in
> >> safety applications"; so here are my five cents:
> >>
> >> One of the general assumptions about safety applications and safety
> >> systems is that the malfunction of a function within a system is more
> >> critical, i.e., more likely to cause harm to people, directly or
> >> indirectly, than the unavailability of the system. So, before
> >> "something potentially unexpected happens"---which can have arbitrary
> >> effects and hence effects difficult to foresee and control---, it is
> >> better to just shutdown/silence the system, i.e., design a fail-safe
> >> or fail-silent system, as the effect of shutdown is pretty easily
> >> foreseeable during the overall system design and you could think about
> >> what the overall system does, when the kernel crashes the usual way.
> >>
> >> So, that brings us to what a user would expect from the kernel in a
> >> safety-critical system: Shutdown on any event that is unexpected.
> >>
> >> Here, I currently see panic_on_warn as the closest existing feature to
> >> indicate any event that is unexpected and to shutdown the system. That
> >> requires two things for the kernel development:
> >>
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
> >> discuss the one or other use of warn) and is not too much to ask for.
> >>
> >> 2. Really ensure that the system shuts down when it hits warn and
> >> panic. That requires that the execution path for warn() and panic() is
> >> not overly complicated (stuffed with various bells and whistles).
> >> Otherwise, warn() and panic() could fail in various complex ways and
> >> potentially keep the system running, although it should be shut down.
> >> Some people in the ELISA Project looked a bit into why they believe
> >> panic() shuts down a system but I have not seen a good system analysis
> >> and argument why any third person could be convinced that panic()
> >> works under all circumstances where it is invoked or that at least,
> >> the circumstances under which panic really works is properly
> >> documented. That is a central aspect for using Linux in a
> >> reasonably-designed safety-critical system. That is possibly also
> >> relevant for security, as you might see an attacker obtain information
> >> because it was possible to "block" the kernel shutting down after
> >> invoking panic() and hence, the attacker could obtain certain
> >> information that was only possible because 1. the system got into an
> >> inconsistent state, 2. it was detected by some check leading to warn()
> >> or panic(), and 3. the system's security engineers assumed that the
> >> system must have been shutting down at that point, as panic() was
> >> invoked, and hence, this would be disallowing a lot of further
> >> operations or some specific operations that the attacker would need to
> >> trigger in that inconsistent state to obtain information.
> >>
> >> To your feature, Alex, I do not see the need to have any refined
> >> handling of killing a specific process when the kernel warns; stopping
> >> the whole system is the better and more predictable thing to do. I
> >> would prefer if systems, which have those high-integrity requirements,
> >> e.g., in a highly secure---where stopping any unintended information
> >> flow matters more than availability---or in fail-silent environments
> >> in safety systems, can use panic_on_warn. That should address your
> >> concern above of handling certain CVEs as well.
> >>
> >> In summary, I am not supporting pkill_on_warn. I would support the
> >> other points I mentioned above, i.e., a good enforced policy for use
> >> of warn() and any investigation to understand the complexity of
> >> panic() and reducing its complexity if triggered by such an
> >> investigation.
> >
> > Hi Alex
> >
> > I also agree with the summary that Lukas gave here. From my experience
> > the safety system are always guarded by an external flow monitor (e.g. a
> > watchdog) that triggers in case the safety relevant workloads slows down
> > or block (for any reason); given this condition of use, a system that
> > goes into the panic state is always safe, since the watchdog would
> > trigger and drive the system automatically into safe state.
> > So I also don't see a clear advantage of having pkill_on_warn();
> > actually on the flip side it seems to me that such feature could
> > introduce more risk, as it kills only the threads of the process that
> > caused the kernel warning whereas the other processes are trusted to
> > run on a weaker Kernel (does killing the threads of the process that
> > caused the kernel warning always fix the Kernel condition that lead to
> > the warning?)
>
> Lukas, Gabriele, Robert,
> Thanks for showing this from the safety point of view.
>
> The part about believing in panic() functionality is amazing :)
> Yes, safety critical systems depend on the robust ability to restart.
>

Well, there is really a lot of thought and willingness for engineering
effort to address the fact there must be high confidence that the
shutdown with panic() really works.

The proper start and restart of the kernel is actually another
issue... but there various sanity checks are possible before the
system switches into a mode that could potentially harm people (cause
physical damage, directly or indirectly).

Lukas

> Best regards,
> Alexander
