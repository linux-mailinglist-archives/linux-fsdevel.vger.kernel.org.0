Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE46AA02B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCCThG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 14:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjCCThF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:37:05 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D613539;
        Fri,  3 Mar 2023 11:37:04 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17264e9b575so4140494fac.9;
        Fri, 03 Mar 2023 11:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677872223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pzUND4iuq7GnN5gzAmvO0nJR5Ui+dwLXQZup9TEriM=;
        b=nwrcENTeMsfyM10BoCtZAsE5dsWINLYy+/peW5X3VB2cyObgG+0Y7GsdcgPKgvaQ3H
         O2Pmeyxf7CBIdewsoFYGkhbKZnjKf7vnFHjR7ml/QXhyAuusnZhOPKQ0bEQQiiOOwtqE
         wk7ZnOJukxy5GIKRmA1DOQjGzETprGhU9WUV+CcQlW76Jn8ha7r/EZ1JZfaekV/dWzlH
         AH/T3YzrO5m5/eGlcmoqog0k4xP5dt480PMABWztWvIhgrqb2Bu2F92AAe6D1ITfV4YL
         GT+wVIxPDbcgxk/qhkUWxBKM6ORMQXI0Ei52Fidyw+CYc+vIsp90t5LqvTpm6z0itI9u
         nYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677872223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pzUND4iuq7GnN5gzAmvO0nJR5Ui+dwLXQZup9TEriM=;
        b=w/Xq8Kj4HWfY/VzxBXhiOXqIqcEDKXEXBxPBWpN1r2rBZyfINN/4F1WsTJG90fUWDD
         W2tEfO0MV1EhAAJsjqTTsIAt6OGdHCmDk7In0X8jus4E822jG6wQXangsriFUKu2VV1E
         YC9d0XlsmMxUZ0gfJqrl4JxM5yHlPgu/lvD2iZb5ixKcwJqN+Gj6NcStAukt2XpZS0hh
         JBYfem1kH5JV9XWJn69Sm3PaStRTPKab3HOgI9l9BFiWQvymNgjC6XVi8HJe7A7WrQTj
         tv+9CjANWT1YPncZInvtzdjXeMS2zU1dlOO83RhVcgIG4U7XmU/EajYGMmRo3iPzwQUz
         AysQ==
X-Gm-Message-State: AO0yUKUVHrIZOdcTb0LP86MxsRAbqE0UIFTwf1/ha5d+Wq47bIrWbZwt
        oIU/q2gt1TsKPKxbygpEo1bKl7fAreCDCTZPVFo=
X-Google-Smtp-Source: AK7set+vc7qQFS8tYuy19A2TD5yGnVhGYzlKzqXrNZv3TcqyvkXzIvTJ/tvoZYo1DTT09cKe4zO8q5iaq4iBYdxcqlw=
X-Received: by 2002:a05:6870:5ab3:b0:176:69f4:d98a with SMTP id
 dt51-20020a0568705ab300b0017669f4d98amr834247oab.11.1677872222831; Fri, 03
 Mar 2023 11:37:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:31f:b0:4c2:d201:fe1f with HTTP; Fri, 3 Mar 2023
 11:37:02 -0800 (PST)
In-Reply-To: <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com> <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 3 Mar 2023 20:37:02 +0100
Message-ID: <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
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

On 3/3/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, Mar 3, 2023 at 9:39=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>>
>> So the key is: memset is underperforming at least on x86-64 for
>> certain sizes and the init-on-alloc thingy makes it used significantly
>> more, exacerbating the problem
>
> One reason that the kernel memset isn't as optimized as memcpy, is
> simply because under normal circumstances it shouldn't be *used* that
> much outside of page clearing and constant-sized structure
> initialization.
>

I mentioned in the previous e-mail that memset is used a lot even
without the problematic opt and even have shown size distribution of
what's getting passed there.

You made me curious how usage compares to memcpy, so I checked 'make'
in kernel dir once again.

I stress the init-on-alloc opt is *OFF*:
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set

# bpftrace -e 'kprobe:memset,kprobe:memcpy { @[probe] =3D count(); }'
[snip]
@[kprobe:memcpy]: 6948498
@[kprobe:memset]: 36150671

iow memset is used about 7 times as much as memcpy when building the
kernel. If it matters I'm building on top of
2eb29d59ddf02e39774abfb60b2030b0b7e27c1f (reasonably fresh master).

> So this is literally a problem with pointless automated memset,
> introduced by that hardening option. And hardening people generally
> simply don't care about performance, and the people who _do _care
> about performance usually don't enable the known-expensive crazy
> stuff.
>
> Honestly, I think the INIT_ONCE stuff is actively detrimental, and
> only hides issues (and in this case adds its own). So I can't but help
> to say "don't do that then". I think it's literally stupid to clear
> allocations by default.
>

Questioning usability of the entire thing was on the menu in what I
intended to write, but I did not read entire public discussion so
perhaps I missed a crucial insight.

> I'm not opposed to improving memset, but honestly, if the argument is
> based on the stupid hardening behavior, I really think *that* needs to
> be fixed first.
>

It is not. The argument is that this is a core primitive, used a lot
with sizes where rep stos is detrimental to its performance. There is
no urgency, but eventually someone(tm) should sort it out. For
$reasons I don't want to do it myself.

I do bring it up in the context of the init-on-alloc machinery because
it disfigures whatever results are obtained testing on x86-64 -- they
can get exactly the same effect for much smaller cost, consequently
they should have interest in sorting this out.

General point though was that the work should have sanity-checked
performance of the primitive it relies on, instead of assuming it is
~optimal. I'm guilty of this mistake myself, so not going to throw
stones.

--=20
Mateusz Guzik <mjguzik gmail.com>
