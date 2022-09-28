Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752B15EDC13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiI1L5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiI1L5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:57:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2F647D2;
        Wed, 28 Sep 2022 04:57:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a80so12326705pfa.4;
        Wed, 28 Sep 2022 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=kTt78o8sw7DrI9PLxyN0n+3tUBa/gb1NqpPxWUB4KCg=;
        b=KLxgcyg2qJUDAGD1546ocHb8zD2jWooEsH9eajCy1V5enFhJ0vDZDVHNomuFEj6HWh
         IKIa43x1gFDU4UnbGndt1qlNHG5Om3aGTlAlbUtBWWMSukv2G3FCwzU+3uiX1S4Iv1Zi
         cGyPGpGG7E/Uwvsua9q2jNYlymXI1NC7Rt66i+sODKVtVwiRBpYAIpALaUvGPClPvtqz
         8bGNEV+YKROfTMty3Mpm4kZjr65dq4/Ufhu55wKYYBbM1y7sJKTEqAnYW8xkJcG/Kv4e
         34O+WOA1GovKCD2U2VCu9l5eeH53JHhtp2xEnrvhD/S/5LQHOBgnpugNVMaCiZJ6uN0A
         4DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kTt78o8sw7DrI9PLxyN0n+3tUBa/gb1NqpPxWUB4KCg=;
        b=I0jC40UTEJodKbWplwr+dgsphetAcb3v7SRR7aqZSdStE5xdQO32O5a9MC1k3/irle
         15jWV9VsC7aUAMWq67fqwPJ6yo1d/uNyO8LROJ/jFgwLFhtnpDYZ/VT+wZvsi/W7oqcW
         Of3ZrwIZlKE4fVt5uxihdVzL5xY22qRWxdffCtV9SqpF5yDs18hXfHGUTDU9I1NbsoiF
         2jN56ZGITLyftgtNQta2Zy19VhtO5l+QjETm6rPtWwhxkSPTpBeJIgiWQuKmbzs8+06e
         aqaaJ5U2XN29v6BbwDfiTw4rRcMO1/xXPjDaxFKA0xF50YACinBWU/bNpVTSm9Xr0gi6
         oBnA==
X-Gm-Message-State: ACrzQf1XTxWUGX5a1DnQ+hCEwNm8WoCppTm7w9PGJEthkqzKiFa7g1GU
        8X6Y33xPQ5t9TWSjFdAxUaoKloC5jtIbvl/hHkU=
X-Google-Smtp-Source: AMsMyM4vgLDLNPomf1ilGGAQV/z0snFyjMbp1+L4a1xwnRIAKJuyvJL77nq2QWriD0JZ3CnNSzaD7wRe+e8Jm5At4tc=
X-Received: by 2002:a05:6a00:3492:b0:540:b30d:8396 with SMTP id
 cp18-20020a056a00349200b00540b30d8396mr34458408pfb.81.1664366252575; Wed, 28
 Sep 2022 04:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-28-ojeda@kernel.org>
 <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl> <202209270818.5BA5AA62@keescook>
 <YzMX91Kq6FzOL9g/@kroah.com> <CANiq72kyW-8Gzeex4UCMqQPCrYyPQni=8ZrRO1dQsUwDmAPedw@mail.gmail.com>
 <202209271710.6DD4B44C@keescook>
In-Reply-To: <202209271710.6DD4B44C@keescook>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 28 Sep 2022 12:57:21 +0100
Message-ID: <CANeycqo3O3yh2ms6vpHkzBLtT7QuCYWeweLq_z9SVygsot43YA@mail.gmail.com>
Subject: Re: [PATCH v10 27/27] MAINTAINERS: Rust
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Stappers <stappers@stappers.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Maciej Falkowski <maciej.falkowski9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Sept 2022 at 01:11, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 27, 2022 at 05:53:12PM +0200, Miguel Ojeda wrote:
> > On Tue, Sep 27, 2022 at 5:34 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > How about just fixing up the emails in these patches, which will keep=
 us
> > > from having bouncing ones for those of us who do not use the .mailmap
> > > file.
> >
> > Sorry about that...
> >
> > One question: if somebody wants to keep the Signed-off-bys and/or Git
> > authorship information using the old email for the patches (except the
> > `MAINTAINERS` entry), is that OK? (e.g. maybe because they did most of
> > the work in their previous company).
>
> IMO, the S-o-b's should stand since they're historical, but fixing
> MAINTAINERS to be up-to-date makes sense.

Our intent wasn't to have a known-invalid email in MAINTAINERS, it was
just my mistake: after leaving Google I updated my email in a lot of
places but missed this one. Apologies for that.

The patch below fixes this:

diff --git a/MAINTAINERS b/MAINTAINERS
index f4e31512bab8..e082270dd285 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17913,7 +17913,7 @@ F:      tools/verification/
 RUST
 M:     Miguel Ojeda <ojeda@kernel.org>
 M:     Alex Gaynor <alex.gaynor@gmail.com>
-M:     Wedson Almeida Filho <wedsonaf@google.com>
+M:     Wedson Almeida Filho <wedsonaf@gmail.com>
 R:     Boqun Feng <boqun.feng@gmail.com>
 R:     Gary Guo <gary@garyguo.net>
 R:     Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

Thanks,
-Wedson
