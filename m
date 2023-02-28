Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D156A508F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 02:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB1BPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 20:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB1BPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:15:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9216AED
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 17:14:58 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h16so33460692edz.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 17:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677546897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4foDmOd0TidPkdLCFMkrpX/LFzdbPkgPT38RIetMiw=;
        b=WirmihFyrrVXSGptd2y2j1cn22O/wCwpjUfVO4nVTGBhhF/yulKPyU/gJZzLJrwBct
         dXHy3G1t5CuCUB36+n1AuYqeQGvhtYQGgNHOfcb0JYS9Et31ltZPDmWl2vTaXnbSQHV6
         F+1mO8KvPU75JUXQHIOj1uMYsAcBxdSUFHEm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677546897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4foDmOd0TidPkdLCFMkrpX/LFzdbPkgPT38RIetMiw=;
        b=no6pxdAV+Bg9zuTSkKcXHwZjJlRQIgcsLnEkWX1QFwQ8oJNp4xXkdMXAjcnS/EgyYf
         TxyZ8evmcl1AM9wMDpF6SzFygH0Ss/5CtwbwL1jVyUA93BGYcm0T8KfyP0Z+3NqUKRGu
         pAcQgp4xowWb5L+deH6f9eWFD5Z0nAgpvr1tslu0/akuE1NhLV2zg/loga4zlW/codo7
         trCRV5CTi1mqOUd0dhGYKiO3xO9Dc63jSEUAICm67tXz28yNRag7gEwFcQbYXJEwXqhv
         MXbn86UWmjm7Z2MyBcj+oY6kikqXhEIfElP1LCRVf8Fy2hSvjxHPP1SIIE1AQ8Us3sTr
         QL/A==
X-Gm-Message-State: AO0yUKXDIXHI3atqtGI7FRs/zz0Sax+o1LGMK2x8OvaBHn7YCrwfAl+6
        sP2HsKIALNeHXQOvfYOXpDmRQyfgsVGiHPeeahg=
X-Google-Smtp-Source: AK7set8XHDRtjEeDib5VWMi7zgOOCuod1oruF9fQq1GQaW0grrrIgueKmYoTL4vRZUTro1t2yzwfhQ==
X-Received: by 2002:a17:907:3e24:b0:8aa:1f89:122e with SMTP id hp36-20020a1709073e2400b008aa1f89122emr946712ejc.39.1677546896620;
        Mon, 27 Feb 2023 17:14:56 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id cw18-20020a170906c79200b008e22978b98bsm3917374ejb.61.2023.02.27.17.14.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 17:14:56 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id eg37so33347054edb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 17:14:55 -0800 (PST)
X-Received: by 2002:a17:906:79a:b0:8b8:aef3:f2a9 with SMTP id
 l26-20020a170906079a00b008b8aef3f2a9mr323832ejc.0.1677546895540; Mon, 27 Feb
 2023 17:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com>
In-Reply-To: <20230125155557.37816-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 17:14:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
Message-ID: <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>, Serge Hallyn <serge@hallyn.com>
Cc:     viro@zeniv.linux.org.uk, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
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

On Wed, Jan 25, 2023 at 7:56=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> +static inline bool cap_isidentical(const kernel_cap_t a, const kernel_ca=
p_t b)
> +{
> +       unsigned __capi;
> +       CAP_FOR_EACH_U32(__capi) {
> +               if (a.cap[__capi] !=3D b.cap[__capi])
> +                       return false;
> +       }
> +       return true;
> +}
> +

Side note, and this is not really related to this particular patch
other than because it just brought up the issue once more..

Our "kernel_cap_t" thing is disgusting.

It's been a structure containing

        __u32 cap[_KERNEL_CAPABILITY_U32S];

basically forever, and it's not likely to change in the future. I
would object to any crazy capability expansion, considering how
useless and painful they've been anyway, and I don't think anybody
really is even remotely planning anything like that anyway.

And what is _KERNEL_CAPABILITY_U32S anyway? It's the "third version"
of that size:

  #define _KERNEL_CAPABILITY_U32S    _LINUX_CAPABILITY_U32S_3

which happens to be the same number as the second version of said
#define, which happens to be "2".

In other words, that fancy array is just 64 bits. And we'd probably be
better off just treating it as such, and just doing

        typedef u64 kernel_cap_t;

since we have to do the special "convert from user space format"
_anyway_, and this isn't something that is shared to user space as-is.

Then that "cap_isidentical()" would literally be just "a =3D=3D b" instead
of us playing games with for-loops that are just two wide, and a
compiler that may or may not realize.

It would literally remove some of the insanity in <linux/capability.h>
- look for CAP_TO_MASK() and CAP_TO_INDEX and CAP_FS_MASK_B0 and
CAP_FS_MASK_B1 and just plain ugliness that comes from this entirely
historical oddity.

Yes, yes, we started out having it be a single-word array, and yes,
the code is written to think that it might some day be expanded past
the two words it then in 2008 it expanded to two words and 64 bits.
And now, fifteen years later, we use 40 of those 64 bits, and
hopefully we'll never add another one.

So we have historical reasons for why our kernel_cap_t is so odd. But
it *is* odd.

Hmm?

             Linus
