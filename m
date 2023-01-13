Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0764668B91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 06:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjAMFhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 00:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjAMFge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:36:34 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175C101D;
        Thu, 12 Jan 2023 21:36:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id dw9so19954653pjb.5;
        Thu, 12 Jan 2023 21:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6+pSwox7nvOrX3DcFjVuwZuoLpU/mTInToIx9lpnOk=;
        b=QqJsZWNJ2uhmkCsES7RSyK/45OPE6gk0Ti9FTuENRviNFRQOxZ3CGCAiq6Z2fpIrE7
         DZh65cqk9G1w/Ah7bP+K0q56LCJVZCBzXEk19rws00zlG9C/sMVsmnATblfeMg9OiBz8
         PVf/ubSpG1MWXytZwcpTWDPWRfcDzRemhHuaheMQROx+JJC/7je4SpHIuvEEksnQOt+5
         yGWSLNLC6DVzvw+jkoU1QL7K+1OKrDyt0UeHuv7k46Nr81wzogaxWKJZssNpjtHX6YS2
         G34XyM2uQBuaE+BR/6KJB70UBMqSoqHaGCGaAUoMBZyi6J/CLTtkdvunkmb/XVBJJPki
         7GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t6+pSwox7nvOrX3DcFjVuwZuoLpU/mTInToIx9lpnOk=;
        b=jmp6wE4wEd8++erLdwAg0Enttt96M+PXR7BUAz2TUhCSgfBXVUsMc3ssngq0ImEvpb
         W4oe1BFYnE0XaYMeEGiDjryiZOI4ftvNu5p3Ut055WIkzk2cphLgSgM/UYpuOkTk9sm7
         xtCh1tqwpPo3mCHxdgac0Hsw+ihQF8KnViBw4wQC9Fg/SX0JpLRLUHpeJh9OHcn3Nk9P
         BbD5d7Z6g7KSj7FwcbeC/IHhlfIjm4VzRmjX8O62skVyKg5MP8S5KijQSBYoBz7fhCfg
         gD6s3BRb34I1iemKw8u5bBXqL0Mfpxd9gYZKnmRFdvt5NSZZTGAXtfwhJOZOkqbZxRGH
         D18A==
X-Gm-Message-State: AFqh2kpinsTik/e9ZVPX+hSQtXQ4y/LWjtJdLxS0FmafkEzT4Z8v8iHF
        +f+1t7fXsmX1M09n1PUuOn46/H3wFpk=
X-Google-Smtp-Source: AMrXdXsAusqKnG3jBsLdJrhaGyX+g1MJ5aJKfF+C/Ql9K9ixqRt11Dq+YZPlY+Crg24/8/AWo1EUOg==
X-Received: by 2002:a17:902:8d95:b0:192:8d17:78e0 with SMTP id v21-20020a1709028d9500b001928d1778e0mr56046828plo.42.1673588191816;
        Thu, 12 Jan 2023 21:36:31 -0800 (PST)
Received: from localhost (193-116-88-198.tpgi.com.au. [193.116.88.198])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b00194706d3f25sm360376ple.144.2023.01.12.21.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 21:36:31 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 13 Jan 2023 15:36:10 +1000
Message-Id: <CPQTHRRWI40R.5SDS94D8EFFA@bobo>
Cc:     "Mateusz Guzik" <mjguzik@gmail.com>,
        "linux-arch" <linux-arch@vger.kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>, <tony.luck@intel.com>,
        <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        "Jan Glauber" <jan.glauber@gmail.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.13.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com> <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com> <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo> <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
In-Reply-To: <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri Jan 13, 2023 at 2:15 PM AEST, Linus Torvalds wrote:
> On Thu, Jan 12, 2023 at 9:20 PM Nicholas Piggin <npiggin@gmail.com> wrote=
:
> >
> > Actually what we'd really want is an arch specific implementation of
> > lockref.
>
> The problem is mainly that then you need to generate the asm versions
> of all those different CMPXCHG_LOOP()  variants.
>
> They are all fairly simple, though, and it woudln't be hard to make
> the current lib/lockref.c just be the generic fallback if you don't
> have an arch-specific one.

Yeah, it doesn't look too onerous so it's probably worth seeing what
the code and some numbers look like here.

> And even if you do have the arch-specific LL/SC version, you'd still
> want the generic fallback for the case where a spinlock isn't a single
> word any more (which happens when the spinlock debugging options are
> on).

You're right, good point.

Thanks,
Nick
