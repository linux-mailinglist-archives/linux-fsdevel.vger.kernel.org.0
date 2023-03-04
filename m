Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684AB6AAC9A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCDVD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 16:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCDVD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 16:03:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDBCD33C
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 13:03:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s11so23640915edy.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 13:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677963805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc3ttMvepwzFWVo6udVksEFHtSzqK6XOPV7RiZqfde4=;
        b=OVRr1Xtm41f/Vcw9KhdqRl13hClLRcHXk2rZiZ3Qck7HP1jNEgIxGULY0Sb4GJVFGd
         bH8EektFMUsW3uMwDxV5gDamyvJvjxzHGLRA6Ivi2/gmB7JwTmFgoqcrPQgyVOAD5T6j
         A5eLHbfnfikk+mTusCd/h+LXQwxlc4pPJ9tXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677963805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc3ttMvepwzFWVo6udVksEFHtSzqK6XOPV7RiZqfde4=;
        b=flsv1T8PDlzUx0r4YPC12az1eAzpc1m4eH7K0v5/TiM38z5Oi5B0VaiY8Lzw2q8yHh
         QUCzbV7UXFWj7AdTg0sa8LrysVkfgr3+u9g6pfnKAf5C4JwN3zyTBW2sKLdOoy5yZqW9
         basFkkYcdEj2qACJvKiPwkP5q9CNiozvkf2VQcqg20BDwd5v+V+iBbrd/P9ZABMrsmsA
         n93wSLUv3SISFYJNLssLFtTqBFftV/GhGEKHu/Lp3nIgS1QKNN7JJYiT/gEAk5YqcOQG
         1BQyvJaDbgrb4gMW586NjWxN6BXbAISuw93Auzbz6Toiw5iYo1Cxr3wocKqytnn5iFW3
         T8gA==
X-Gm-Message-State: AO0yUKWDgXSJ529+6NHZgtXNPnO/WQgkbTG8O3xEjldtUq35pGPFz+gK
        PQbEL3nt+BpdpLfmojcOsKEutAAA73e9UvthT7sobQ==
X-Google-Smtp-Source: AK7set9KiMELkjOIO9y6lKHbsVLHezRtAFy/BtK8hWNG0B7xdxwLBi+KUweXjEX6wikGON8z0pSqIA==
X-Received: by 2002:a17:907:d28:b0:8e9:9e13:9290 with SMTP id gn40-20020a1709070d2800b008e99e139290mr8068822ejc.27.1677963804949;
        Sat, 04 Mar 2023 13:03:24 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id ca5-20020a170906a3c500b008bc2c2134c5sm2415380ejb.216.2023.03.04.13.03.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 13:03:24 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id o12so23613370edb.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 13:03:24 -0800 (PST)
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr2890993ejb.0.1677963804011; Sat, 04 Mar
 2023 13:03:24 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop> <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
In-Reply-To: <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 13:03:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgaJdaKCDaVa0B1wGKYHjnnQMYpf91ze-fTvCdMMchNFg@mail.gmail.com>
Message-ID: <CAHk-=wgaJdaKCDaVa0B1wGKYHjnnQMYpf91ze-fTvCdMMchNFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 4, 2023 at 1:01=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Silly useless cases are just that - silly and useless. They should not
> be arguments for the real cases then being optimized and simplified.

There's a missing "not" above, that was hopefully obvious from the
context: "They should not be arguments for the real cases then NOT
being optimized and simplified"

               Linus
