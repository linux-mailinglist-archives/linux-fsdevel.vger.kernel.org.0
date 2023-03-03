Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426EE6AA0DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 22:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCCVKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 16:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjCCVJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:09:51 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2311B62D9B;
        Fri,  3 Mar 2023 13:09:45 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id y184so2789122oiy.8;
        Fri, 03 Mar 2023 13:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677877784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj3D0bfvOLWOuIuZ/qODED5yK5G7S3fF6CiSL+ecQPo=;
        b=jusnkVmqUVn8BpkeS3wcTVdmD3nxUKwSxwRd5AINGAUtUNhzB2gTteVtP56gKT2Rla
         G7zMprADCjK7S2827s53fX/tp3/yI+IfMJ4W/BSYs9xqCBjg7T1l+Umzxfw7aCu/nr8D
         CiA09CoHTqH18B2Yu9voZ6ESLA+z3pX2Aa4w++TRhvIIihBJeUblCiywjw8UxN43UiSF
         moHB56uXIfZeZ72aYiBt3r86yhTumXCnJ5a1pHccV60iVOUfiKdqj1YiCOLxWZzag01O
         TdXNfdCiDwz5tvZHsF421frel03ADCK6bUScrAysNxUyZkMuQrE63iaWUkGHrk0mIICo
         YOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677877784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj3D0bfvOLWOuIuZ/qODED5yK5G7S3fF6CiSL+ecQPo=;
        b=VFEwmqFBKn+ySPjccxGiY0dZhhxTu5SFZoZRYLqKiCKyLYW82ZnfbJjTIKaMPREK+D
         k3So4WtdK2Efvh1/wBzZBSqKS4Cb5Msucs7f1svNnCXpZa5B0/P8KdJCdsUlkLgVbwZu
         PhVAjD9ArOaPv8ukrthGn2P4kZXqm+njgAOzkx5uhpFCe2dUhP9zp7JIdoNZuieGOyOp
         /q/iZ8OQczMwjB1CXEP4zlL385IcGZFIiaLtZCiA9lP4Ve4IUszDnuxsLwonNCx0E/GN
         yoUlo9vNFmOn/e1kEQzYHG3EQLRNRu9qMoyQZ/I/hV2T3Xh80Qmb/Em7Wpwtd1Y9h5wN
         mcvg==
X-Gm-Message-State: AO0yUKVFS/m0gNVK6Ntyj1WWatIhPWYBzl9Aik+mESvARGL+kEmFHoCz
        hFra8QtF5+3fuEiFNjZO8NcfQfYtvF1UJkebSIY=
X-Google-Smtp-Source: AK7set+lv0o0V2rKWQs7DvncmnsJ+v43LjjTV15LKpUl42YJfJazb3W7NZuB6NmCG0wlS2lnai3p3IKi79M0Ludekfs=
X-Received: by 2002:a54:4612:0:b0:37f:953b:f235 with SMTP id
 p18-20020a544612000000b0037f953bf235mr1057917oip.11.1677877784547; Fri, 03
 Mar 2023 13:09:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:31f:b0:4c2:d201:fe1f with HTTP; Fri, 3 Mar 2023
 13:09:43 -0800 (PST)
In-Reply-To: <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
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
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com> <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 3 Mar 2023 22:09:43 +0100
Message-ID: <CAGudoHGEOGJtcXFL2LVphNMpe38h3u4XT=PJZbc84Gka_h+tCg@mail.gmail.com>
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
> On Fri, Mar 3, 2023 at 12:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
>>
>> I think there is a systemic problem which comes with the kzalloc API
>
> Well, it's not necessarily the API that is bad, but the implementation.
>
> We could easily make kzalloc() with a constant size just expand to
> kmalloc+memset, and get the behavior you want.
>
> We already do magical things for "find the right slab bucket" part of
> kmalloc too for constant sizes. It's changed over the years, but that
> policy goes back a long long time. See
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?=
id=3D95203fe78007f9ab3aebb96606473ae18c00a5a8
>
> from the BK history tree.
>
> Exactly because some things are worth optimizing for when the size is
> known at compile time.
>
> Maybe just extending kzalloc() similarly? Trivial and entirely untested
> patch:
>
>    --- a/include/linux/slab.h
>    +++ b/include/linux/slab.h
>    @@ -717,6 +717,12 @@ static inline void *kmem_cache_zalloc(struct
> kmem_cache *k, gfp_t flags)
>      */
>     static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
>     {
>    +    if (__builtin_constant_p(size)) {
>    +            void *ret =3D kmalloc(size, flags);
>    +            if (ret)
>    +                    memset(ret, 0, size);
>    +            return ret;
>    +    }
>         return kmalloc(size, flags | __GFP_ZERO);
>     }
>
> This may well be part of what has changed over the years. People have
> done a *lot* of pseudo-automated "kmalloc+memset -> kzalloc" code
> simplification. And in the process we've lost a lot of good
> optimizations.

I was about to write that kzalloc can use automagic treatment. I made
a change of similar sort years back in FreeBSD
https://cgit.freebsd.org/src/commit/?id=3D34c538c3560591a3856e85988b0b5eefd=
de53b0c

The crux of the comment though was not about kzalloc (another
brainfart, apologies), but kmem_cache_zalloc -- that one is kind of
screwed as is.

Perhaps it would be unscrewed if calls could be converted to something
in the lines of kmem_cache_zalloc_ptr(cachep, flags, returnobj);

so this from __alloc_file:
        struct file *f;
	int error;

	f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
        if (unlikely(!f))
		return ERR_PTR(-ENOMEM);

could be:
	if (unlikely(!kmem_cache_zalloc_ptr(filp_cachep, GFP_KERNEL, f))
		return ERR_PTR(-ENOMEM);

... where the macro rolls with similar treatment to the one you pasted
for kzalloc. and assigns to f.

if this sounds acceptable coccinelle could be used to do a sweep

I don't have a good name for it.

--=20
Mateusz Guzik <mjguzik gmail.com>
