Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A2041454C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 11:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhIVJhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 05:37:42 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbhIVJhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:37:40 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MvKGv-1mke2z2qrh-00rJOX; Wed, 22 Sep 2021 11:36:08 +0200
Received: by mail-wr1-f46.google.com with SMTP id u18so4891243wrg.5;
        Wed, 22 Sep 2021 02:36:08 -0700 (PDT)
X-Gm-Message-State: AOAM533cNokXKeivlFWQu63N4hKhYioHpwbRhcJag3IFKL7DtZXHcL4H
        HZhEKZ93HH6+ZISnH+FpQbO3jJiG5WhMB04iEic=
X-Google-Smtp-Source: ABdhPJwsfHOtthBHhMYj7RntawREErl/gNXDh2elD51lflVYSeYX0WIWYL6DcBkNwC3VMpYByIJ66yyH/mg7lRlO9Aw=
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr9469852wmj.1.1632303368159;
 Wed, 22 Sep 2021 02:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210921130127.24131-1-rpalethorpe@suse.com> <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
 <87o88mkor1.fsf@suse.de> <87lf3qkk72.fsf@suse.de> <87ilytkngp.fsf@suse.de>
In-Reply-To: <87ilytkngp.fsf@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Sep 2021 11:35:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
Message-ID: <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
Subject: Re: ia32 signed long treated as x64 unsigned int by __ia32_sys*
To:     rpalethorpe@suse.de
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:E43EkxaNqQt7a2EM5CvjQOmodQJGkqkdhWvhc8juHYmhiMLs4Go
 IbW2+sxjzL/v+bC1TjAJuIAJkvdkRqWtshmTuomY7ZXc4o8TmFFU0jTFc/0kcBONtdpCpKJ
 pdAnuhXJ3zkNyIbgsEOVQsBVzc/mcKL19ZBTjVFljj4yr6sGgPYcxQEbZWvB5T4YGuZIcsP
 IWPoea3HhM7oHPTuEX28Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xvRax+mwGJw=:F6N9qx/RxiNv53T3WxYNF+
 ESYy2Ly22uoI5wtNsnX1caZ8vLs0xTbPQ4mt6qhqT8uKdSH8xxS/Q9cSVzXpswJ1hbGAICua7
 4FFj9lPkMO7M4hhObm/7JgNHYj1dw/OMC4RgtVijl3JvcUOe3pCefKawuXw9urpV3QDrjMXkl
 KsZv+rZ0PvgqfGy4gTFM4WT6UO+Mghzq3vbVGsL5gqix+/G45x4hmzSAtXkJx7mu1fyV1iXb7
 A18UV43st6++EZfGsNZdCY7qMzxBedGPKLCo7E2ENR8rvqJRmoNEhUGchijYbAs8Dp+Gc2rtM
 Ww1auVOXnUjJXnbDSxZI2PMtVl0Kc0HIqo0JCGKgB5qPxbRUBfXn6o2/aGl3YNSepJ5B20xHE
 kfM65QH2A9FzeJk6a5DcGq4/nDfR/1phOQomZY3SCQFs/ksPA4a7VPg7jmDw4cb2Flkf8ZYcK
 GR6CQmMTe9F48TKuuYStvKBmcbURkrSgVz5PoDZmIOsEk/3V7cG/2XTLqOkkI5A9wuKYhe/pi
 fQTw5Jj/HMTEB0VGWIamya1XPXm/EP8TAnjSzDN31OFOjqMHVw2LWkUUCtsYjNrPAkpueAoha
 Ne6Bp/jV4Fn+G3h0WDBeK8jnxVrYcScG9uDHzVED7GjQvZLcbBcmXR6pwdwkQvtbGPIXgXWTz
 S0UcmWsf10UTl/mnHamlBgUwa8SAkldmAEbAbrWbF3o4CzORYOp1rWRbX294qbEH2wEgQNvKu
 xodc0t9pS0FRSDkEKZ86rcJaWNDqy/0W9jVlRDnJDtoag94fh77LrJiVuAgy3RoQdTvzCeSMZ
 X8yacmFqIm4pPIvUd+h2OhxXovwiUOLSjnkTxq6hBgt+oneLkcRhjTh0VoyfxALHtlUC7mx40
 9sJUWPo7OK4y1Mi8VoSg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:46 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> Richard Palethorpe <rpalethorpe@suse.de> writes:

> >
> > Then the output is:
> >
> > [   11.252268] io_pgetevents(f7f19000, 4294967295, 1, ...)
> > [   11.252401] comparing 4294967295 <= 1
> > io_pgetevents02.c:114: TPASS: invalid min_nr: io_pgetevents() failed as expected: EINVAL (22)
> > [   11.252610] io_pgetevents(f7f19000, 1, 4294967295, ...)
> > [   11.252748] comparing 1 <= 4294967295
> > io_pgetevents02.c:103: TFAIL: invalid max_nr: io_pgetevents() passed unexpectedly
>
> and below is the macro expansion for the automatically generated 32bit to
> 64bit io_pgetevents. I believe it is casting u32 to s64, which appears
> to mean there is no sign extension. I don't know if this is the expected
> behaviour?

Thank you for digging through this, I meant to already reply once more yesterday
but didn't get around to that.

>     __typeof(__builtin_choose_expr(
>         (__builtin_types_compatible_p(typeof((long)0), typeof(0LL)) ||
>          __builtin_types_compatible_p(typeof((long)0), typeof(0ULL))),
>         0LL, 0L)) min_nr,
>     __typeof(__builtin_choose_expr(
>         (__builtin_types_compatible_p(typeof((long)0), typeof(0LL)) ||
>          __builtin_types_compatible_p(typeof((long)0), typeof(0ULL))),
>         0LL, 0L)) nr,

The part that I remembered is in arch/s390/include/asm/syscall_wrapper.h,
which uses this version instead:

#define __SC_COMPAT_CAST(t, a)                                          \
({                                                                      \
        long __ReS = a;                                                 \
                                                                        \
        BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&              \
                     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t) &&           \
                     !__TYPE_IS_LL(t));                                 \
        if (__TYPE_IS_L(t))                                             \
                __ReS = (s32)a;                                         \
        if (__TYPE_IS_UL(t))                                            \
                __ReS = (u32)a;                                         \
        if (__TYPE_IS_PTR(t))                                           \
                __ReS = a & 0x7fffffff;                                 \
        if (__TYPE_IS_LL(t))                                            \
                return -ENOSYS;                                         \
        (t)__ReS;                                                       \
})

This also takes care of s390-specific pointer conversion, which is the
reason for needing an architecture-specific wrapper, but I suppose the
handling of signed arguments as done in s390 should also be done
everywhere else.

I also noticed that only x86 and s390 even have separate entry
points for normal syscalls when called in compat mode, while
the others all just zero the upper halves of the registers in the
low-level entry code and then call the native entry point.

        Arnd
