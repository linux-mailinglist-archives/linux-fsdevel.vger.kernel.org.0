Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C076AAC7E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 21:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCDUs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 15:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDUs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:48:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D0CA3A
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 12:48:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u9so23684716edd.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677962905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn2gZXKlQFGR+IhNp/0q9B10wC8MYWo3Xkj5MLWqjns=;
        b=dJtwGIMLUvRVLfyftU83pXDQ7ZHeelQh9GKUmyXSKtJeY3w4b312g5jt3ZndGIk/1O
         o7cFw1LXjGZtGD940+EOSfSvH8B4OsfTM9OHbsFssJ2p0NL2mORe0tL+ByQcH0geWJwy
         EM3CjLMmA/BxyrLWut5Hg5wT7BCb4ocNQoaAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677962905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn2gZXKlQFGR+IhNp/0q9B10wC8MYWo3Xkj5MLWqjns=;
        b=yPlQJ/v1WqbyA3OozByIepulTFo622agTQVA4W/Y/ZKHKYwvbA3VEANprNo1HJ2iKO
         AqZoLNq264NREYXLIENkYOaLDystb+sKrYMeZyLE2ekqbiqs36E+t8xIXKs0Os+A1ahW
         zeURX5HXFCz7kBF/xmLLjTi2fZrz50iz5vjeNzNoQMxELN8j57qLR+4CPJ2XO5vdnMpH
         Npk/40ItOa8dQnA0y+DSY7N0sCWrwXDb8QoXqk4rIUzN2AZWB4zOFqXlQV64Jhh63W2Q
         yyegptxIgtVc0HBxGti4Hdi47GLJ4FBdOj+z71pwjsl5z5v2ph8DZRZo1Q72kfCRVYU5
         yqpw==
X-Gm-Message-State: AO0yUKV+QVA+ImD0HJijveE0MwE52Wz/XPOAKkho7WgRxqZP/d0r6CN8
        vqKBYDvVRcxywfFwdybqzu566NvKHU+NPGVH2xRZcQ==
X-Google-Smtp-Source: AK7set+Uqhi6zCK0JkF1sNgpw5AMBXKabXDUwrFDSURh4KwRal/pRakqxZFYRxV7L/foTKEHjGh0fQ==
X-Received: by 2002:a05:6402:5154:b0:4af:5aa1:6646 with SMTP id n20-20020a056402515400b004af5aa16646mr5417094edd.14.1677962905085;
        Sat, 04 Mar 2023 12:48:25 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id h30-20020a50cdde000000b004c10b4f9ebesm2816562edj.15.2023.03.04.12.48.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 12:48:24 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id i34so23580772eda.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 12:48:23 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr2818736eju.0.1677962903549; Sat, 04 Mar
 2023 12:48:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
 <CAGudoHH8t9_5iLd8FsTW4PBZ+_vGad3YAd8K=n=SrRtnWHm49Q@mail.gmail.com> <CAGudoHFPr4+vfqufWiscRXqSRAuZM=S8H7QsZbiLrG+s1OWm1w@mail.gmail.com>
In-Reply-To: <CAGudoHFPr4+vfqufWiscRXqSRAuZM=S8H7QsZbiLrG+s1OWm1w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 12:48:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh17G6zo6Rfut++SHzDgXdvtrupfSX+bNL08v=LpHU0Lg@mail.gmail.com>
Message-ID: <CAHk-=wh17G6zo6Rfut++SHzDgXdvtrupfSX+bNL08v=LpHU0Lg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>, Borislav Petkov <bp@suse.de>
Cc:     Alexander Potapenko <glider@google.com>,
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

On Sat, Mar 4, 2023 at 12:31=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Good news: gcc provides a lot of control as to how it inlines string
> ops, most notably:
>        -mstringop-strategy=3Dalg

Note that any static decision is always going to be crap somewhere.
You can make it do the "optimal" thing for any particular machine, but
I consider that to be just garbage.

What I would actually like to see is the compiler always generate an
out-of-line call for the "big enough to not just do inline trivially"
case, but do so with the "rep stosb/movsb" calling convention.

Then we'd just mark those with objdump, and patch it up dynamically to
either use the right out-of-line memset/memcpy function, *or* just
replace it entirely with 'rep stosb' inline.

Because the cores that do this right *do* exist, despite your hatred
of the rep string instructions. At least Borislav claims that the
modern AMD cores do better with 'rep stosb'.

In particular, see what we do for 'clear_user()', where we effectively
can do the above (because unlike memset, we control it entirely). See
commit 0db7058e8e23 ("x86/clear_user: Make it faster").

Once we'd have that kind of infrastructure, we could then control
exactly what 'memset()' does.

And I note that we should probably have added Borislav to the cc when
memset came up, exactly because he's been looking at it anyway. Even
if AMD seems to have slightly different optimization rules than Intel
cores probably do. But again, that only emphasizes the whole "we
should not have a static choice here".

                 Linus
