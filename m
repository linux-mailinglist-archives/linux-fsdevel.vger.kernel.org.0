Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7A5BD874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 01:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiISXur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 19:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiISXun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:50:43 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE83D5AA;
        Mon, 19 Sep 2022 16:50:42 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id 129so1274325vsi.10;
        Mon, 19 Sep 2022 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ObiI1LOvSQ4K2EeOpgqHdRP+Ejyw75lzaoql9+78EQw=;
        b=o1e8CwLVOAi5voveJYTXKQBivySosunePQf6lLcfMAKrUL+kkkMM4llV+JLgrqI8hO
         YY0qZJet1SROegPN+MIUIYRwOUff4zcGx/lHeZ14UW2GqvRonKt9OSIijW1m4slo95eV
         HuWSZfk0L1Da9W3AqZZxuN2YIt3UvVuVz00QLn3DonOKsZQLZ2XCf0PGF0XMPOu/Hw1W
         KBAcgmUjtdwcK7t8mGz1Wp4J0RTLZeSxRbLXBZpNYAJ0LQbiNemhNzGEwytSlf3oyI3q
         Coa3v4pETrcKRg3cDg3PNZhmXdbf1uyq+TCw5GP70LOHTIvN1N3XWZzJPfp7ks25N2Mq
         e+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ObiI1LOvSQ4K2EeOpgqHdRP+Ejyw75lzaoql9+78EQw=;
        b=hAE27Ep5Gc7XJ2URMK3NPUmx6TfRt5rZ1nS6RN0perTCqJmmjr66Lx5SzHZplTuKBz
         aJ/M52ShDPggrhS2TT0x2I6aDJTqFzoFahcFH+qDWvGdFJKmKKHGWy/ez2X70IUWS9kE
         OO7nRiuWEJ5C9PLVNuz9seY9480nfpCXPs+T5WO6bxGp/+geHWAsi8JoNcHRxcJ65nWm
         lZSKY0mxpUs3ymqbmP+nU7zSR6B6xp3iKoxYwyfTMHo/SkPveLQ9jhpiidip3xgTTgl1
         HV2zC58zXx2N9YQVFmWKu53W5beOB45BAe4D8vFwINdYVNHROWBryfJzatjlGj0IJyji
         Hlzw==
X-Gm-Message-State: ACrzQf2hSlWH/gC5pv+mY3SobkuX8eVL3rhNXRjuJ2r798HDzgrzniTX
        U2j4iJTpFAMpo0sN9NzExdyld+BdmBip+5HXPmU=
X-Google-Smtp-Source: AMsMyM5zBGpRWRRHjTEoNolL3My3hxRKT0jP2qArok4XQ9uH1DWogS6Ia6l6+6eb6Gzq6R+TDYGOhVjHliPybwGdbio=
X-Received: by 2002:a67:ac45:0:b0:388:a1ff:7e89 with SMTP id
 n5-20020a67ac45000000b00388a1ff7e89mr7771043vsh.42.1663631441184; Mon, 19 Sep
 2022 16:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-13-ojeda@kernel.org> <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org> <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
 <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
 <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
 <YyivY6WIl/ahZQqy@wedsonaf-dev> <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
 <Yyjut3MHooCwzHRc@wedsonaf-dev> <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
In-Reply-To: <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
From:   Alex Gaynor <alex.gaynor@gmail.com>
Date:   Mon, 19 Sep 2022 19:50:29 -0400
Message-ID: <CAFRnB2VPpLSMqQwFPEjZhde8+-c6LLms54QkMt+wZPjOTULESw@mail.gmail.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        ark.email@gmail.com, bjorn3_gh@protonmail.com, bobo1239@web.de,
        bonifaido@gmail.com, boqun.feng@gmail.com, davidgow@google.com,
        dev@niklasmohrin.de, dsosnowski@dsosnowski.pl, foxhlchen@gmail.com,
        gary@garyguo.net, geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.falkowski@samsung.com,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, viktor@v-gar.de,
        Andreas Hindborg <andreas.hindborg@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think there is some amount of talking past each other here.

Rust's rules are that a function that's safe must not exhibit UB, no
matter what arguments they're called with. This can be done with
static checking or dynamic checking, with obvious trade offs between
the two.

We've had pretty good success, thus far, modeling various kernel
subsystems with APIs that follow this rule. But when there's not a
good way, consistent with the kernel's idioms, to expose a kernel API
in Rust that's safe, that doesn't mean it's impossible! In those cases
we expose an `unsafe fn` in Rust. This means that the caller (e.g.,
driver code) needs to ensure it meets the required pre-conditions for
calling that function.

This is how we square the circle of: How do we prioritize the kernel's
goals, while also staying consistent with Rust's notion of safety?

Wedson's point is that, when possible, finding ways to expose safe
functions is better, since it puts less of a burden on driver authors.
But, sadly, we all know we won't be able to find them in all
circumstances -- we just want to have it as a goal to find them
whenever possible.

Regards,
Alex

On Mon, Sep 19, 2022 at 7:40 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 19, 2022 at 3:35 PM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> >
> > No one is talking about absolute safety guarantees. I am talking about
> > specific ones that Rust makes: these are well-documented and formally
> > defined.
>
> If you cannot get over the fact that the kernel may have other
> requirements that trump any language standards, we really can't work
> together.
>
> Those Rust rules may make sense in other environments. But the kernel
> really does have hard requirements that you continue to limp along
> even if some fundamental rule has been violated. Exactly because
> there's often no separate environment outside the kernel that can deal
> with it.
>
> End result: a compiler - or language infrastructure - that says "my
> rules are so ingrained that I cannot do that" is not one that is valid
> for kernel work.
>
> This is not really any different from the whole notion of "allocation
> failures cannot panic" that Rust people seemed to readily understand
> is a major kernel requirement, and that the kernel needed a graceful
> failure return instead of a hard panic.
>
> Also note that the kernel is perfectly willing to say "I will use
> compiler flags that disable certain guarantees". We do it all the
> time.
>
> For example, the C standard has a lot of "the compiler is allowed to
> make this assumption". And then we disagree with those, and so "kernel
> C" is different.
>
> For example, the standard says that dereferencing a NULL pointer is
> undefined behavior, so a C compiler can see a dereference of a pointer
> to be a guarantee that said pointer isn't NULL, and remove any
> subsequent NULL pointer tests.
>
> That turns out to be one of those "obviously true in a perfect world,
> but problematic in a real world with bugs", and we tell the compiler
> to not do that by passing it the '-fno-delete-null-pointer-checks'
> flag, because the compiler _depending_ on undefined behavior and
> changing code generation in the build ends up being a really bad idea
> from a security standpoint.
>
> Now, in C, most of these kinds of things come from the C standard
> being very lax, and having much too many "this is undefined behavior"
> rules. So in almost all cases we end up saying "we want the
> well-defined implementation, not the 'strictly speaking, the language
> specs allows the compiler to do Xyz".
>
> Rust comes from a different direction than C, and it may well be that
> we very much need some of the rules to be relaxed.
>
> And hey, Rust people do know about "sometimes the rules have to be
> relaxed". When it comes to integer overflows etc, there's a
> "overflow-checks" flag, typically used for debug vs release builds.
>
> The kernel has similar issues where sometimes you might want the
> strict checking (lockdep etc), and sometimes you may end up being less
> strict and miss a few rules (eg "we don't maintain a preempt count for
> this config, so we can't check RCU mode violations").
>
> > But I won't give up on Rust guarantees just yet, I'll try to find
> > ergonomic ways to enforce them at compile time.
>
> I think that compile-time static checking is wonderful, and as much as
> possible should be done 100% statically so that people cannot write
> incorrect programs.
>
> But we all know that static checking is limited, and then the amount
> of dynamic checking for violations is often something that will have
> to depend on environment flags, because it may come with an exorbitant
> price in the checking.
>
> Exactly like integer overflow checking.
>
>                  Linus



-- 
All that is necessary for evil to succeed is for good people to do nothing.
