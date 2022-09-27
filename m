Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB45EC826
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiI0Piv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiI0Pid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:38:33 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F251CE15E;
        Tue, 27 Sep 2022 08:37:02 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id m66so10005929vsm.12;
        Tue, 27 Sep 2022 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TUGMZoFYFoHDZJYWzaIuE6u06usrctQB8r3AoeeFKDk=;
        b=lYb4nELxXqmlc7EGzml+Eu3QkgdG8gCYbaYfSADphVKjQKUWjdiiBEuNR90lhN/sou
         VNISjYxkC/VQlbZUkEj32sI0PymuhWR3C5r/r7tNcHc/GDv7zhdtjH+hrgUwTU15bR7s
         S/wuQiNw2bszt+WguK8q1I73PmRtZpjls1GKHtdE8/yMzTnIBAWRu3TAyig95OC2vx2q
         Bn4slTdpyOi4lEYSQP3T78YJmrX6+ayRYr5qe1yxdwzFcNBLR0aFlmy2TRBsvZ0tvBrA
         6Exxs/xPGEmocwv4D2MLnwaOYtuvKgutzCG2gKPCVD/k0Kyt9qUKd2tJemQIoIgy/5fn
         22LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TUGMZoFYFoHDZJYWzaIuE6u06usrctQB8r3AoeeFKDk=;
        b=qZXqdYDGbFFbHJB+2mtzsog9ipbNKE+0V4iWetsO0GxLsTL231GRx/rqUUMYY0wPXu
         BUXpt5yqgAEnMKiKeKh2xuuAqLxLGn1Vyr0KojnwxP7i9KsftJ6h0WgDm7NgzVvH7/eV
         g2WZP//qzm1yMU1ykyeBDSYVBEPOn9pQUHpcfB8TcHdWS6KFPspBwKQSQlnCgu3CbthV
         rJ008rtDbfAgOdmFU+FNAjU1EMlKtx0u5GVBBf6PFoXq4YY7xRF/5lGpOzZ0AhUoktcL
         iviqAE52XfO5wqQ2m7LIc07c5SXM1q5KiiL6bgak38XoHfo+ucEIGWc6P15XTmBsPk7L
         8GWQ==
X-Gm-Message-State: ACrzQf16vRNorxk7cWW86eHhUqpusM6Qov9F77HoU7SAxy6DMElEoT5A
        TeH6Q8B3oVrajJ7Yq2K/cHANkknDIov7vaQoyKI=
X-Google-Smtp-Source: AMsMyM4JbqyS7Au1A2OS5ukPgae3HmiQQlrlrFqB/B0i2xbbGYgaJjH0G4opluTkSfFVKEzgewSeceuVaimuAavWrGY=
X-Received: by 2002:a67:fc44:0:b0:398:30ac:1c95 with SMTP id
 p4-20020a67fc44000000b0039830ac1c95mr11484950vsq.16.1664292979806; Tue, 27
 Sep 2022 08:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-13-ojeda@kernel.org>
 <YzMVLkr3ZlbENMcG@kroah.com>
In-Reply-To: <YzMVLkr3ZlbENMcG@kroah.com>
From:   Alex Gaynor <alex.gaynor@gmail.com>
Date:   Tue, 27 Sep 2022 10:36:08 -0500
Message-ID: <CAFRnB2W2SjmN9Z5XqLncRz-Bs4XbUcw734oLx0u9wso0jZ-YEA@mail.gmail.com>
Subject: Re: [PATCH v10 12/27] rust: add `kernel` crate
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?UTF-8?Q?L=C3=A9o_Lanteri_Thauvin?= <leseulartichaut@gmail.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        =?UTF-8?B?TsOhbmRvciBJc3R2w6FuIEtyw6Fjc2Vy?= <bonifaido@gmail.com>,
        David Gow <davidgow@google.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
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

On Tue, Sep 27, 2022 at 10:22 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 27, 2022 at 03:14:43PM +0200, Miguel Ojeda wrote:
> > +unsafe impl GlobalAlloc for KernelAllocator {
> > +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> > +        // `krealloc()` is used instead of `kmalloc()` because the latter is
> > +        // an inline function and cannot be bound to as a result.
> > +        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
>
> This feels "odd" to me.  Why not just use __kmalloc() instead of
> krealloc()?  I think that will get you the same kasan tracking, and
> should be a tiny bit faster (1-2 less function calls).
>

This may literally be the oldest code in the project :-). To the best
of my recollection, it's krealloc simply because that seemed like a
public API that worked. I don't think it even occurred to use to look
at __kmalloc.

> I guess it probably doesn't matter right now, just curious, and not a
> big deal at all.
>
> Other minor comments:
>
>
> > +/// Contains the C-compatible error codes.
> > +pub mod code {
> > +    /// Out of memory.
> > +    pub const ENOMEM: super::Error = super::Error(-(crate::bindings::ENOMEM as i32));
> > +}
>
> You'll be adding other error values here over time, right?
>

Yes -- this is the most minimal set that's needed for the initial
patch set. The full branch has every error constant bound.

>
> > +/// A [`Result`] with an [`Error`] error type.
> > +///
> > +/// To be used as the return type for functions that may fail.
> > +///
> > +/// # Error codes in C and Rust
> > +///
> > +/// In C, it is common that functions indicate success or failure through
> > +/// their return value; modifying or returning extra data through non-`const`
> > +/// pointer parameters. In particular, in the kernel, functions that may fail
> > +/// typically return an `int` that represents a generic error code. We model
> > +/// those as [`Error`].
> > +///
> > +/// In Rust, it is idiomatic to model functions that may fail as returning
> > +/// a [`Result`]. Since in the kernel many functions return an error code,
> > +/// [`Result`] is a type alias for a [`core::result::Result`] that uses
> > +/// [`Error`] as its error type.
> > +///
> > +/// Note that even if a function does not return anything when it succeeds,
> > +/// it should still be modeled as returning a `Result` rather than
> > +/// just an [`Error`].
> > +pub type Result<T = ()> = core::result::Result<T, Error>;
>
> What about functions that do have return functions of:
>         >= 0 number of bytes read/written/consumed/whatever
>         < 0  error code
>
> Would that use Result or Error as a type?  Or is it best just to not try
> to model that mess in Rust calls? :)
>

We'd model that as a `Result<usize>`. Negative values would become
`Err(EWHATEVER)` and non-negative values would be `Ok(n)`. Then at the
boundaries of Rust/C code we'd convert as appropriate.

> > +macro_rules! pr_info (
> > +    ($($arg:tt)*) => (
> > +        $crate::print_macro!($crate::print::format_strings::INFO, $($arg)*)
> > +    )
> > +);
>
> In the long run, using "raw" print macros like this is usually not the
> thing to do.  Drivers always have a device to reference the message to,
> and other things like filesystems and subsystems have a prefix to use as
> well.
>
> Hopefully not many will use these as-is and we can wrap them properly
> later on.
>
> Then there's the whole dynamic debug stuff, but that's a different
> topic.
>
> Anyway, all looks sane to me, sorry for the noise:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cheers,
Alex

-- 
All that is necessary for evil to succeed is for good people to do nothing.
