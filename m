Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE54508F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhKOPzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 10:55:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232372AbhKOPyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636991513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bARiWFzSqYKuP0Ns4vE+EPidwg1BEOivkLvH/D29Daw=;
        b=TuGd/r1EI3fWDQV/bQZiYgPBcpoOl2u7oNCn11II1BTiTYqX/K6q6HYbw/VT2zdn971+d+
        8PaOqePNcJLhCqkKncBX/sePMWTKGay4akLezBGkT9HDVsX/GGEVwWx9fli8ICty1hJYWZ
        RHP0vA9CvlVgcU3oEio3+89RS4MxDnQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-iEj25OJPNOWz4y8BStvwyg-1; Mon, 15 Nov 2021 10:51:51 -0500
X-MC-Unique: iEj25OJPNOWz4y8BStvwyg-1
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso14461969edj.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 07:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bARiWFzSqYKuP0Ns4vE+EPidwg1BEOivkLvH/D29Daw=;
        b=GvxgRtuG2lRurtfyAhx6GRGnPcl72v7Qf3EKIRu5Yd5LgRx0SRxHWbqe5J7lwe5B01
         Yg77Ck8s5YVnB+cnO8dmWFff5LwYSxgCWxFX1S0bDgwD6xN7ePipoGEzdnoYzkqMKsNe
         Sm00yrF53jqPa11yfl9rlcfn+ufTbg9kKhdJ2oEp9c/VADdRTDxBCgi5elSUpH+NPW8A
         ZPYw/KjQBY1sLSXiTqP/AYjFvtqkIWlM+g1CkazY1T2zm386LEtcz8bHKimv0a7JUwgm
         Y0vYqGFInICet2J5hfBrhmQxOZxzqjVYl5hw6+T3rpKmPL+u0coX0T6ZvJmrJvqpFOCn
         gubQ==
X-Gm-Message-State: AOAM531pxNRIC5RFuSvHSzn56NgD741r83GrhuRITE6cBCE0uyQ5aWyE
        pfxHqL+bLZylE1WN19H7qQa30YQoPo3kY/d+pTCSatjiG2Akb0Zfc9FUfnjZzufTEx1ZeXPJSfC
        NpfWPQxE26IJEGFqgb6gU9aE/Cg==
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr56756819edd.291.1636991510373;
        Mon, 15 Nov 2021 07:51:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGMnQu7V7jGlmHYqyueX9jxsgYuIN1h2kHXuTfwBgHVc2ufyxq4nknuuYxsuqe2wjeS5YJNw==
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr56756750edd.291.1636991510041;
        Mon, 15 Nov 2021 07:51:50 -0800 (PST)
Received: from ?IPV6:2001:b07:646c:22c6:db53:7a2b:ef3c:adb0? ([2001:b07:646c:22c6:db53:7a2b:ef3c:adb0])
        by smtp.gmail.com with ESMTPSA id g12sm7876129edz.68.2021.11.15.07.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 07:51:49 -0800 (PST)
Message-ID: <22828e84-b34f-7132-c9e9-bb42baf9247b@redhat.com>
Date:   Mon, 15 Nov 2021 16:51:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [ELISA Safety Architecture WG] [PATCH v2 0/2] Introduce the
 pkill_on_warn parameter
Content-Language: en-GB
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexander Popov <alex.popov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
 <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
 <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
From:   Gabriele Paoloni <gpaoloni@redhat.com>
In-Reply-To: <CAKXUXMx5Oi-dNVKB+8E-pdrz+ooELMZf=oT_oGXKFrNWejz=fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 15/11/2021 14:59, Lukas Bulwahn wrote:
> On Sat, Nov 13, 2021 at 7:14 PM Alexander Popov <alex.popov@linux.com> wrote:
>>
>> On 13.11.2021 00:26, Linus Torvalds wrote:
>>> On Fri, Nov 12, 2021 at 10:52 AM Alexander Popov <alex.popov@linux.com> wrote:
>>>>
>>>> Hello everyone!
>>>> Friendly ping for your feedback.
>>>
>>> I still haven't heard a compelling _reason_ for this all, and why
>>> anybody should ever use this or care?
>>
>> Ok, to sum up:
>>
>> Killing the process that hit a kernel warning complies with the Fail-Fast
>> principle [1]. pkill_on_warn sysctl allows the kernel to stop the process when
>> the **first signs** of wrong behavior are detected.
>>
>> By default, the Linux kernel ignores a warning and proceeds the execution from
>> the flawed state. That is opposite to the Fail-Fast principle.
>> A kernel warning may be followed by memory corruption or other negative effects,
>> like in CVE-2019-18683 exploit [2] or many other cases detected by the SyzScope
>> project [3]. pkill_on_warn would prevent the system from the errors going after
>> a warning in the process context.
>>
>> At the same time, pkill_on_warn does not kill the entire system like
>> panic_on_warn. That is the middle way of handling kernel warnings.
>> Linus, it's similar to your BUG_ON() policy [4]. The process hitting BUG_ON() is
>> killed, and the system proceeds to work. pkill_on_warn just brings a similar
>> policy to WARN_ON() handling.
>>
>> I believe that many Linux distros (which don't hit WARN_ON() here and there)
>> will enable pkill_on_warn because it's reasonable from the safety and security
>> points of view.
>>
>> And I'm sure that the ELISA project by the Linux Foundation (Enabling Linux In
>> Safety Applications [5]) would support the pkill_on_warn sysctl.
>> [Adding people from this project to CC]
>>
>> I hope that I managed to show the rationale.
>>
> 
> Alex, officially and formally, I cannot talk for the ELISA project
> (Enabling Linux In Safety Applications) by the Linux Foundation and I
> do not think there is anyone that can confidently do so on such a
> detailed technical aspect that you are raising here, and as the
> various participants in the ELISA Project have not really agreed on
> such a technical aspect being one way or the other and I would not see
> that happening quickly. However, I have spent quite some years on the
> topic on "what is the right and important topics for using Linux in
> safety applications"; so here are my five cents:
> 
> One of the general assumptions about safety applications and safety
> systems is that the malfunction of a function within a system is more
> critical, i.e., more likely to cause harm to people, directly or
> indirectly, than the unavailability of the system. So, before
> "something potentially unexpected happens"---which can have arbitrary
> effects and hence effects difficult to foresee and control---, it is
> better to just shutdown/silence the system, i.e., design a fail-safe
> or fail-silent system, as the effect of shutdown is pretty easily
> foreseeable during the overall system design and you could think about
> what the overall system does, when the kernel crashes the usual way.
> 
> So, that brings us to what a user would expect from the kernel in a
> safety-critical system: Shutdown on any event that is unexpected.
> 
> Here, I currently see panic_on_warn as the closest existing feature to
> indicate any event that is unexpected and to shutdown the system. That
> requires two things for the kernel development:
> 
> 1. Allow a reasonably configured kernel to boot and run with
> panic_on_warn set. Warnings should only be raised when something is
> not configured as the developers expect it or the kernel is put into a
> state that generally is _unexpected_ and has been exposed little to
> the critical thought of the developer, to testing efforts and use in
> other systems in the wild. Warnings should not be used for something
> informative, which still allows the kernel to continue running in a
> proper way in a generally expected environment. Up to my knowledge,
> there are some kernels in production that run with panic_on_warn; so,
> IMHO, this requirement is generally accepted (we might of course
> discuss the one or other use of warn) and is not too much to ask for.
> 
> 2. Really ensure that the system shuts down when it hits warn and
> panic. That requires that the execution path for warn() and panic() is
> not overly complicated (stuffed with various bells and whistles).
> Otherwise, warn() and panic() could fail in various complex ways and
> potentially keep the system running, although it should be shut down.
> Some people in the ELISA Project looked a bit into why they believe
> panic() shuts down a system but I have not seen a good system analysis
> and argument why any third person could be convinced that panic()
> works under all circumstances where it is invoked or that at least,
> the circumstances under which panic really works is properly
> documented. That is a central aspect for using Linux in a
> reasonably-designed safety-critical system. That is possibly also
> relevant for security, as you might see an attacker obtain information
> because it was possible to "block" the kernel shutting down after
> invoking panic() and hence, the attacker could obtain certain
> information that was only possible because 1. the system got into an
> inconsistent state, 2. it was detected by some check leading to warn()
> or panic(), and 3. the system's security engineers assumed that the
> system must have been shutting down at that point, as panic() was
> invoked, and hence, this would be disallowing a lot of further
> operations or some specific operations that the attacker would need to
> trigger in that inconsistent state to obtain information.
> 
> To your feature, Alex, I do not see the need to have any refined
> handling of killing a specific process when the kernel warns; stopping
> the whole system is the better and more predictable thing to do. I
> would prefer if systems, which have those high-integrity requirements,
> e.g., in a highly secure---where stopping any unintended information
> flow matters more than availability---or in fail-silent environments
> in safety systems, can use panic_on_warn. That should address your
> concern above of handling certain CVEs as well.
> 
> In summary, I am not supporting pkill_on_warn. I would support the
> other points I mentioned above, i.e., a good enforced policy for use
> of warn() and any investigation to understand the complexity of
> panic() and reducing its complexity if triggered by such an
> investigation.

Hi Alex

I also agree with the summary that Lukas gave here. From my experience
the safety system are always guarded by an external flow monitor (e.g. a
watchdog) that triggers in case the safety relevant workloads slows down
or block (for any reason); given this condition of use, a system that
goes into the panic state is always safe, since the watchdog would
trigger and drive the system automatically into safe state.
So I also don't see a clear advantage of having pkill_on_warn();
actually on the flip side it seems to me that such feature could
introduce more risk, as it kills only the threads of the process that
caused the kernel warning whereas the other processes are trusted to
run on a weaker Kernel (does killing the threads of the process that
caused the kernel warning always fix the Kernel condition that lead to
the warning?)

Thanks
Gab

> 
> Of course, the listeners and participants in the ELISA Project are
> very, very diverse and still on a steep learning curve, i.e., what
> does the kernel do, how complex are certain aspects in the kernel, and
> what are reasonable system designs that are in reach for
> certification. So, there might be some stakeholders in the ELISA
> Project that consider availability of a Linux system safety-critical,
> i.e., if the system with a Linux kernel is not available, something
> really bad (harmful to people) happens. I personally do not know how
> these stakeholders could (ever) argue the availability of a complex
> system with a Linux kernel, with the availability criteria and the
> needed confidence (evidence and required methods) for exposing anyone
> to such system under our current societal expectations on technical
> systems (you would to need show sufficient investigation of the
> kernel's availability for a certification), but that does not stop
> anyone looking into it... Those stakeholders should really speak for
> themselves, if they see any need for such a refined control of
> "something unexpected happens" (an invocation of warn) and more
> generally what features from the kernel are needed for such systems.
> 
> 
> Lukas
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#629): https://lists.elisa.tech/g/safety-architecture/message/629
> Mute This Topic: https://lists.elisa.tech/mt/87069369/6239706
> Group Owner: safety-architecture+owner@lists.elisa.tech
> Unsubscribe: https://lists.elisa.tech/g/safety-architecture/unsub [gpaoloni@redhat.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

