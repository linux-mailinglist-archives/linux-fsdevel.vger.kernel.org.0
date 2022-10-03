Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED125F2797
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 04:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJCCEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 22:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJCCEj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 22:04:39 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ABEFF4;
        Sun,  2 Oct 2022 19:04:37 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y189so5312222iof.5;
        Sun, 02 Oct 2022 19:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=lbUBLwLrU+qNu9qKx+IuhKwkfyVt1vaaIOK0cPSiuDg=;
        b=HioAWnuOfe/FTNbLJL3xtog2XmNCRt3JV4vjJCHLn9bcukhXukL3J+iUzT4mRbvCYw
         cpyDCaVDR0jip5ywnHSP7OQrhxaFTe3Sogqb2uBJxP2KAE0xh8FNKiP6qD1EGmbawJeu
         psAmHfd4YryOosDz0caKncABwhAPRCHcHJh/cm1zPfp5/UxfTZNUCKuoFMsr/8Nyxopm
         yUhp3qhnczAf1rcJxUJELG3PMsepwNBL2S9a4iqXK1d21YoLKWALOIn+6QIJgg2K0aT0
         6E1TOEz118QCOMD2OXlt5GkMqsp2ggrv9wWqBvSvQd89wSbcXrFyWblKNdwv0J2bAY4u
         686Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lbUBLwLrU+qNu9qKx+IuhKwkfyVt1vaaIOK0cPSiuDg=;
        b=e3/mGiQFz0Z8uAlJKslHbsWwflAlrI+OMkdBY4aUZBLdSCV+RwArC/p6jFaLIg8F53
         oXqFF4xhzQ4/1klz2L2/L1ppRwzTfktwCoOav3EgzE22YfRcmBEQDh3QopPaXetRGql5
         sxpI1FGTAFmO0wRb89MUxo3DUCt7MbgXztuxB1iiWkvoXDRpE1D1u/lwl6vd8vfvFLnd
         nEW7FKTqpywUJ5j2W9b5Hfv9k6je8Gnu+O2Pc2Co7TL+jCkKrVnS4OCVDQsUp4gWwf6p
         yh4rJjBXnU/mgOU+2J8uy+R8e0Vuvi1flitpo1sBmNFKrIDryLeBbHsKY3zjaSBhrzk0
         9j5A==
X-Gm-Message-State: ACrzQf3aLrj9HNI3SMc9zPE9a3VvLqXVEcaCIjUw7Ir9Lk0Q1irbzOit
        PNIWRqzsNl/UmOWoU1Gj4VM=
X-Google-Smtp-Source: AMsMyM45RfWeewKTijr68Piu9khnc2TzINnr1EIijRFvUbrW+VICxCrtRBi8yB6EXpEJycSHe42Tlg==
X-Received: by 2002:a02:a682:0:b0:34c:14fc:b490 with SMTP id j2-20020a02a682000000b0034c14fcb490mr9437006jam.196.1664762676359;
        Sun, 02 Oct 2022 19:04:36 -0700 (PDT)
Received: from smtpclient.apple ([75.104.65.53])
        by smtp.gmail.com with ESMTPSA id o21-20020a02c6b5000000b0035ada363720sm3710373jan.23.2022.10.02.19.03.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2022 19:04:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
From:   comex <comexk@gmail.com>
In-Reply-To: <YysdZIGp13ye0D4z@boqun-archlinux>
Date:   Sun, 2 Oct 2022 22:03:22 -0400
Cc:     Gary Guo <gary@garyguo.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        ark.email@gmail.com, bjorn3_gh@protonmail.com, bobo1239@web.de,
        bonifaido@gmail.com, davidgow@google.com, dev@niklasmohrin.de,
        dsosnowski@dsosnowski.pl, foxhlchen@gmail.com,
        geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@kloenk.de, milan@mdaverde.com,
        mjmouse9999@gmail.com, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, thesven73@gmail.com,
        viktor@v-gar.de, Andreas Hindborg <andreas.hindborg@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF630FE4-8DDB-43AE-A2B3-1708E260062A@gmail.com>
References: <YyivY6WIl/ahZQqy@wedsonaf-dev>
 <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
 <Yyjut3MHooCwzHRc@wedsonaf-dev>
 <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
 <CAFRnB2VPpLSMqQwFPEjZhde8+-c6LLms54QkMt+wZPjOTULESw@mail.gmail.com>
 <CAHk-=wiyD6KqZN8jFkMHPRPxrbyJEUDRP6+WaH9Q9hjDB5i1zg@mail.gmail.com>
 <CAHk-=wj6sDFk8ZXSEKUMj-J9zfrMSSO3jhBEaveVaJSUpr=O=w@mail.gmail.com>
 <87a66uxcpc.fsf@email.froward.int.ebiederm.org>
 <20220920233947.0000345c@garyguo.net>
 <C85081E7-99CB-421F-AA3D-60326A5181EB@gmail.com>
 <YysdZIGp13ye0D4z@boqun-archlinux>
To:     Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> On the other hand, it ought to be feasible to implement that kind of
>> =E2=80=99negative reasoning' as a custom lint.  It might not work as =
well as
>> something built into the language, but it should work decently well,
>> and could serve as a prototype for a future built-in feature.
>=20
> Interesting, do you have an example somewhere?
>=20
> Regards,
> Boqun

After some searching, I found this, which someone wrote several years =
ago for a
very similar purpose:

https://github.com/thepowersgang/tag_safe/

> This is a linter designed originally for use with a kernel, where =
functions
> need to be marked as "IRQ safe" (meaning they are safe to call within =
an IRQ
> handler, and handle the case where they may interrupt themselves).

> If a function is annotated with #[req_safe(ident)] (where ident can be
> anything, and defines the type of safety) this linter will check that =
all
> functions called by that function are either annotated with the same
> annotation or #[is_safe(ident)], OR they do not call functions with =
the
> reverse #[is_unsafe(ident)] annotation.

Note that the code won't work as-is with recent rustc.  rustc's API for =
custom
lints is not stable, and in fact rustc has deprecated linter plugins =
entirely
[1], though there are alternative approaches to using custom lints [2].  =
Still,
it's a good example of the approach.

One fundamental caveat is that it doesn't seem to have the =
sophistication
needed to be sound with respect to indirect calls.

For example, suppose you have a function that fetches a callback from =
some
structure and calls it.  Whether this function is IRQ-safe depends on =
whether
the callback is expected to be IRQ-safe, so in order to safety-check =
this, you
would need an annotation on either the callback field or the function =
pointer
type.  This is more complex than just putting annotations on function
definitions.

Or suppose you have the following code:

    fn foo() {
        bar(|| do_something_not_irq_safe());
    }

If `foo` is expected to be IRQ-safe, this may or may not be sound, =
depending on
whether `bar` calls the callback immediately or saves it for later.  If =
`bar`
saves it for later, then it could be marked unconditionally IRQ-safe.  =
But if
`bar` calls it immediately, then it's neither IRQ-safe nor IRQ-unsafe, =
but
effectively generic over IRQ safety.  You could pessimistically mark it
IRQ-unsafe, but Rust has tons of basic helper methods that accept =
callbacks and
call them immediately; not being able to use any of them in an IRQ-safe =
context
would be quite limiting.

In short, a fully sound approach requires not just checking which =
functions
call which, but having some kind of integration with the type system.  =
This is
the kind of issue that I was thinking of when I said a custom lint may =
not work
as well as something built into the language.

However, I do think it's *possible* to handle it soundly from a lint,
especially if it focuses on typical use cases and relies on manual =
annotations
for the rest.  Alternately, even an unsound lint would be a good first =
step.
It wouldn't really comport with Rust's ethos of making safety guarantees
ironclad rather than heuristic, but it would serve as a good proof of =
concept
for a future language feature, while likely being helpful in practice in =
the
short term.

[1] https://github.com/rust-lang/rust/pull/64675/files
[2] =
https://www.trailofbits.com/post/write-rust-lints-without-forking-clippy
