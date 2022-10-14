Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7125F5FF4BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 22:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiJNUkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 16:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiJNUjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:39:46 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0ABBECEB;
        Fri, 14 Oct 2022 13:39:14 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id q18so3100956ils.12;
        Fri, 14 Oct 2022 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I2M60nT7NfeWvq3ak/v2N3tIFMmZCLJVdqTc5cp8Xpc=;
        b=I6gJ7IskSZPiBU2Q1TJQ/Ma8kXejg9qi55V3Fj3QjHitxLeEFVvxRHJKmVHr0ybmsa
         f/lZP+Hu09gLoanlzOEODO+n2BYlRnaH34wyfBfPdi5SK3GYcAEu4iA16NGLd9ldm1z7
         EtC3SFQVRv6fTuSO2v0suM81LDqojTi3sGZijXCQyPAA7G5t6DqZhevJQzEojdIulVeX
         cKfQ0q189mU7qF/E/AJvsfiCMGt1uNfpu/0jTQ+kCmVwuelcvwFo/pChdW3RIHkP4/vT
         KQFpsa74fuk/qxuArQ+wdfWDF8QEKhv5ElHGOx7224IC8RlSBoCN/FwsXSMC+xUjgi9u
         e4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2M60nT7NfeWvq3ak/v2N3tIFMmZCLJVdqTc5cp8Xpc=;
        b=rQY4RePmEX/HfF18eEWoSZYumFAjoSd3tI4mpdofuBXfSK2TS5niXyvQKQs10jcfj6
         d0v8CdFeSxoqdvR433nFWO2V4EK1TGwuRZOaCvf9HiTBroL2VxZ7smm6rp5ICE2qgkFv
         6ELqvGGoFWVgc8UVt2EC2iDcBvfCEQiZ9iJXZGaoIR+qpjc9NxNIIlgaNNqxqJLNdlBM
         0/ArmXrLO+VU3S2Fw3fT9xTyiY/XpXPg+epmRZLvWfWyUNMGnCQnPcry0r5v3ah+bBUC
         sx0netIZ4Ux6fp5f0xDetLu74n4cRiygVJ8cTwjNO7X8L7ySGt8nOM0J5avAndyc2lDz
         l5YQ==
X-Gm-Message-State: ACrzQf0Nav82Hnzof26TVdkBAlXp41z4rQIs3G2LUW1Ql54vYjZpNgDS
        wFBe3nFPEjUbyzJDWWXjAYjkCIyrcW2EwvPONnN+t5t6p7A=
X-Google-Smtp-Source: AMsMyM5Can0Irp9kFx+wv2SRI++DMRnZHKowIIiuGGnnpb0qry9EybjOc3WUqIfJNblWZVVzNAta514Kg7Ydywu2Kts=
X-Received: by 2002:a05:6e02:1aab:b0:2fa:80c2:8375 with SMTP id
 l11-20020a056e021aab00b002fa80c28375mr3419698ilv.72.1665779953595; Fri, 14
 Oct 2022 13:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com> <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
In-Reply-To: <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Oct 2022 22:39:02 +0200
Message-ID: <CANiq72khuwOrAGN=CrFUX85UmPdJiZ2yM7_9_su_Zp951BHMMA@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rcvalle@google.com,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 8:35 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Thanks, Miguel. I also talked to Ramon about KCFI earlier this week
> and he expressed interest in helping with rustc support for it. In the

Ah, that is great to hear -- thanks a lot to you both! (Cc'ing Ramon)

> meanwhile, I think we can just add a depends on !CFI_CLANG to avoid
> issues here.

ACK, thanks -- if you want to send the patch, please feel free to do so.

Cheers,
Miguel
