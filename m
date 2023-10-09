Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3017BE66D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377227AbjJIQb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376996AbjJIQb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:31:27 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A6B6;
        Mon,  9 Oct 2023 09:31:25 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7ad24b3aaso4990367b3.2;
        Mon, 09 Oct 2023 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696869085; x=1697473885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eze8ie+K0Fy5Qmq0xuinAFfSz+bncxmLAfx+2FZzmLY=;
        b=fh0Iwjkp3lUPfApI9wvmu3/DeF6vSshCH0DaX4/iIqQcje/GmQTbSkPRSQXrlesMhO
         5Y2Mg++TwPyaZdO4EsNkplLTBHlzm7BZUA5lYYbWHHqaMEyPdiOzFGqS+88T5qvK8NXZ
         YbA75pDu67NXLXU7YOlpBbiKjMDTwxZCSW0EYxhXQWL0ifl5IG1QYljbOcfSkqsgkNCw
         CHxJ60iE23KYf7WfLnfrWtaBw/BjgjlQy3FJhVXuswCrajCTj382fGdD48Ocr3f0Sx9d
         mctnpHNpfPSUH5UiV8AqBmpXvqMMGgBjFTnjLqXgUR0lrM7z5LQxNLDRYmkRTuQ9ntp/
         XV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869085; x=1697473885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eze8ie+K0Fy5Qmq0xuinAFfSz+bncxmLAfx+2FZzmLY=;
        b=aFvAtjPbppvg0hNd1YaVHoS3f2XU8Yg6rrfXwbWYBUcb5H6xT6znQ9+FgieagZXXF4
         ZliKoB3G5MyWrNZScCCPZvrKrJLjcS5itbW/ebk4EwSABXH3NrJDRd9dIkoARlZSGMaE
         YrdYJUeNpp9mhI3p0nh/fsLy+FZU5RQntfTK5gbbAbm0fn9H6QLP8v7SImsLner9QN1S
         ZLZsHUlmD9pWNO2h0fxRZeuzm+jDalOhT6DFn3H4RyVXvPRixQ4/XFShTM+bUf8PU+Dn
         DDAuwA31HTuG7HXUM7uVSL5ZOZjyFRF9341gOP0TBOzJW5ummLwEBb8GaR6bXBLZdkP3
         cYsw==
X-Gm-Message-State: AOJu0Yw+1NZxylhtr7SMZzjyBeu8Hs0GgtMQlQoxGGb+GojyT75Q3ZuK
        2HpmPoUgrrMntReFvLoW5/1ea8xpfnlduKNuYro=
X-Google-Smtp-Source: AGHT+IEhdF0N385lZK+iiOZdfMf/GK//ZQJ8Uqf3c6acgxf6nsox+0RfhDnEpvWZr4UyD76HUprix5445+z4ukZOq2A=
X-Received: by 2002:a81:a1ca:0:b0:5a7:b516:6eab with SMTP id
 y193-20020a81a1ca000000b005a7b5166eabmr598674ywg.15.1696869084836; Mon, 09
 Oct 2023 09:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <CANiq72khuwOrAGN=CrFUX85UmPdJiZ2yM7_9_su_Zp951BHMMA@mail.gmail.com> <CAGSQo00gJsE+mQObeK4NNGDYLpZDDAZsREr15JcjD8Fo0E4pkw@mail.gmail.com>
In-Reply-To: <CAGSQo00gJsE+mQObeK4NNGDYLpZDDAZsREr15JcjD8Fo0E4pkw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Oct 2023 18:31:13 +0200
Message-ID: <CANiq72kK6ppBE7j=z7uua1cJMKaLoR5U3NUAZXT5MrNEs9ZhfQ@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Matthew Maurer <mmaurer@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 9, 2023 at 6:01=E2=80=AFPM Matthew Maurer <mmaurer@google.com> =
wrote:
>
> If the IBT part would be helpful by itself immediately, I can split
> that out - it's only the KCFI portion that won't currently work.

Thanks Matthew. I don't think we are in a rush, but if it is not too
much work to split it, that would be great, instead of adding the
restriction.

For retthunk, by the way, I forgot to mention to Greg above that (in
the original discussion with PeterZ) that I did a quick test back then
to hack the equivalent of `-mfunction-return=3Dthunk-extern` into
`rustc` to show that the compiler could use it via LLVM (by passing
the attribute in the IR). At least at a basic level it seemed to work:
I got a userspace program to count the times that it went through the
return thunk. I didn't try to do anything on the kernel side, but at
least for the compiler side, it seemed OK. So it may be way easier (on
the compiler side) than the CFI work?

Cheers,
Miguel
