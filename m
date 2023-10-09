Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD437BE5B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377082AbjJIQBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjJIQBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:01:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEA89F
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 09:01:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so16314a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696867271; x=1697472071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy5f8ORtjUWrgt6sYe3zAtjW8P0Slkj5alaIenUuvkA=;
        b=aKrtAd/apyvDwBTXOL2x+4v9FYk4wHTVm4maaxcAbTlxsn94pIijPz8X+b6ePHkKHU
         KAaZK3Fcrjv1yTSxumGjzV2Sbzf0vujyKm15Ydm3/YWwrfbesw4MwinrmBodxn5gywn7
         p6gpu3Vz/3MzwFppNPt1T0ZDmOKTG6W4SQN/CigA4JA3w/42nlj07+VP7gKWGoh73V3N
         p62D+HvdSlhYsd/I4zrxHRbfw26ruG2T7VRysjliyDQVSSyRx/euuha62wj+d6B55sez
         o5uXOJQfYOmlQ5FvFg1pwbrAcm4+DuuGFM0IB40Svk0JypLZKcsimph1gkUJgH5d/i+a
         3YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867272; x=1697472072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy5f8ORtjUWrgt6sYe3zAtjW8P0Slkj5alaIenUuvkA=;
        b=VFcrA3ZZ90FKJBsj4UJX/fF6abuUtrmVxHUxtte5BNwc4LuK51l11TxqOnfqaWYGj1
         TALEqNycVIM0814guSrcDoNq5iEaBVwVYpaOpUpSJAc/X4mEVglOIIKB6XMi92Out5K+
         ImhjWMhtaP1xWiYD+7Z0f+eMNpiNGv7cGEvCXdzbWXbtkYiURzUAYHKkWTgVksGsYzt8
         e6w/eA0QEIr3NXw12QUyLS3KGYsMLzrxqDZ1Rx+OahKZjYSChzLr7U90smncvXDQcuNS
         cxrluUITSn3bdIWpm0RWVxHzNp4Kv5eZfLMYu9XpD4lmR/AzX0XhRD6DFMXOrai/XD/9
         YMtQ==
X-Gm-Message-State: AOJu0Yxg778O5AG07+eWYyCtdONuc/rDVDECEGDYjfXBn8mQ/LpyWYVd
        gEyqtMFFR1zq6OLcf2g/K6sW2JVfuxgb0zgEl6IpNQ==
X-Google-Smtp-Source: AGHT+IHMBy+3dUtNsP01KGzd8vcaNjxx/WJQdaZekS0DI0TUctsOfctSoMaVeTw3eiPY4I0DEmZh1AWM2/zlPyQ93IQ=
X-Received: by 2002:a50:9fa4:0:b0:538:5f9e:f0fc with SMTP id
 c33-20020a509fa4000000b005385f9ef0fcmr404150edf.0.1696867271482; Mon, 09 Oct
 2023 09:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com> <CANiq72khuwOrAGN=CrFUX85UmPdJiZ2yM7_9_su_Zp951BHMMA@mail.gmail.com>
In-Reply-To: <CANiq72khuwOrAGN=CrFUX85UmPdJiZ2yM7_9_su_Zp951BHMMA@mail.gmail.com>
From:   Matthew Maurer <mmaurer@google.com>
Date:   Mon, 9 Oct 2023 09:00:58 -0700
Message-ID: <CAGSQo00gJsE+mQObeK4NNGDYLpZDDAZsREr15JcjD8Fo0E4pkw@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>, rcvalle@google.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have a patchset enabling support for both KCFI and IBT in the
kernel, but it uses changes not yet landed in stable rustc, which is
why I haven't sent it to the list yet:
https://github.com/Rust-for-Linux/linux/pull/1034

We've backported the changes to rustc that need to be present onto the
Android copy of the compiler, but it will take 6-12 weeks for them to
hit stable rustc, which is what general Linux is using.

If the IBT part would be helpful by itself immediately, I can split
that out - it's only the KCFI portion that won't currently work.

On Fri, Oct 14, 2022 at 1:40=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Oct 14, 2022 at 8:35 PM Sami Tolvanen <samitolvanen@google.com> w=
rote:
> >
> > Thanks, Miguel. I also talked to Ramon about KCFI earlier this week
> > and he expressed interest in helping with rustc support for it. In the
>
> Ah, that is great to hear -- thanks a lot to you both! (Cc'ing Ramon)
>
> > meanwhile, I think we can just add a depends on !CFI_CLANG to avoid
> > issues here.
>
> ACK, thanks -- if you want to send the patch, please feel free to do so.
>
> Cheers,
> Miguel
