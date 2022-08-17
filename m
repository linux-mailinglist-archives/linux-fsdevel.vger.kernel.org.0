Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C757F59792B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiHQVpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiHQVpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:45:05 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03392BE9;
        Wed, 17 Aug 2022 14:45:05 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b15so1543663ilq.10;
        Wed, 17 Aug 2022 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hqPY2bWNSe1h3tWbXlYngNPrG0p/kfGLsCdfVK78MFI=;
        b=cGqW6rVasObtQsUV/c8llXl8xfXdgIHgRbk7MNRkRT8n9qvUBbsfy4TX9iSWzcLy1S
         m405YSVexBQ1hZJokK9RFBTjm4PdSpGeeqgElviaVDL61mgH8XfgnQnhfS0y5YX887ER
         xwLJ/2prnfwUOO7qCIXpmGM9DHhwYNr9b83/hfNiejVZuWrL/KZv0+Lm3tFBalqThEIx
         x0+klab/reQmAgFujuTX7RE0wLeZl8aHRPNgHfBIQTshWakYBLl4o7CetX/dgWw69MlG
         pIKRsqSIxOIx+/5/jTA/dN/TJBYU1FWYVCCOkWAJXjaV58c1RVGewpXTymCTK7rf3mBp
         PjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hqPY2bWNSe1h3tWbXlYngNPrG0p/kfGLsCdfVK78MFI=;
        b=pbw5NBmKxj6k1eOhS8DnSSUsjPQZoqtHEiNcHSkfazkarijdF6aNOZ14QYzSiceD54
         ay71KV3fv5yJaFTke6hzRVmn66E2mkWwtoudJTs4F9MlXxre3AEtkm6f0HZZvJOSewi0
         fDk+PTY+sfuIp99ZPfqAcBLwM4R7fGVZ2mHZkBZxFpRrnlCHt9iHpMPepbsBLqnlNiTO
         rMd7oxp0Ib6EYgx10/oEa/1/8v3X0Z4yF1MF+nMazhNMnXqpzPkrsALhdplbtACjrW83
         q5I0UtITARgV+DSUPezPS6lJ2LHVsVX7o13URXySwdgn7++lydDZ2k14BekRYjmzRG09
         OP7w==
X-Gm-Message-State: ACgBeo2rs8LHVpKl+MGedFLH2waLn2N7XCGNOPcggMIkb/tYDHpFvRKT
        G7Q0z2p86I20ga6RNnqmU5bQ5PZI9dVQ9S5kNrI=
X-Google-Smtp-Source: AA6agR4XEXjy1xaMB0ItJfvW2/aWI6G4ET12/EM3Wr/bjN5BL+UqmTKR50jgK9cAknp8bCs96oNZz1olMLXEHdRWNlU=
X-Received: by 2002:a05:6e02:1c26:b0:2e0:d8eb:22d6 with SMTP id
 m6-20020a056e021c2600b002e0d8eb22d6mr56869ilh.151.1660772704425; Wed, 17 Aug
 2022 14:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-7-ojeda@kernel.org>
 <202208171240.8B10053B9D@keescook> <CANiq72nR2eAeKrY6v=hnjUjvwfecMsSC6eXTwaei6ecnHjia8g@mail.gmail.com>
 <202208171331.FAACB5AD8@keescook>
In-Reply-To: <202208171331.FAACB5AD8@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 23:44:53 +0200
Message-ID: <CANiq72=6nzbMR1e=7HUAotPk-L00h0YO3-oYrtKy2BLcHVDTEw@mail.gmail.com>
Subject: Re: [PATCH v9 06/27] rust: add C helpers
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Wei Liu <wei.liu@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:34 PM Kees Cook <keescook@chromium.org> wrote:
>
> Gotcha -- it's for the implicit situations (e.g. -C overflow-checks=on),

Yeah, exactly.

> nothing is expected to explicitly call the Rust panic handler?

If by explicitly you mean calling `panic!()`, then in the `kernel`
crate in the v9 patches there is none.

Though we may want to call it in the future (we have 4 instances in
the full code not submitted here, e.g. for mismatching an independent
lock guard with its owner). They can be avoided depending on how we
want the design to be and, I guess, what the "Rust panic" policy will
finally be (i.e. `BUG()` or something softer).

Outside the `kernel` crate, there are also instances in proc macros
and Rust hostprogs/scripts (compilation-time in the host), in the
`alloc` crate (compiled-out) and in the `compiler_builtins` crate (for
e.g. `u128` support that eventually we would like to not see
compiled-in).

Cheers,
Miguel
