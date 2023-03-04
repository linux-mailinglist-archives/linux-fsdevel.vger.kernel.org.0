Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE56AAC6E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 21:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCDUbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 15:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDUbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:31:46 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E51B337;
        Sat,  4 Mar 2023 12:31:45 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id m25-20020a05683026d900b006941a2838caso3328589otu.7;
        Sat, 04 Mar 2023 12:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677961904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBZ9TdI3H8EHG8S5N68m+4DMM2P908Pu3RnTF3gt/Ps=;
        b=ZRrymc8g09fTKIEDLGufpNxGr6xMqEUhca2lduAU6pkeU2/Lb61i0aFs+7sRn5MBa8
         pzd3nYs4hjF0P0K7bWR32gEu13j+roHajai+7yaqAWHozJF2U18p8gerQWYXLxKpavA0
         tDRF7zxYrzq01GOJ9H4sPjAFap3Bptn0Eq6M5vxLOi+KDX+oM+G8vQCVex1NT0ZpS5gZ
         7JHXa/hf2Bewps13wgdUAJVP986i/87ctBTLehoGh41ZzS36twQ2cYPm695i5e/O/JMg
         OjkzVf+wVpyAVSzmKiF3ie9yl0z7pGvi4cigHrQFzhP6pSi4TmDE2GyXlyinmg6yI5hX
         Z4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677961904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBZ9TdI3H8EHG8S5N68m+4DMM2P908Pu3RnTF3gt/Ps=;
        b=mm3oFTDhYU/VMOs5AOQ4cvz3WehmYX3sjfrWS2zzfoZ8sxLvCfGjxP0FWikEtMaFnz
         0NJuuZEhmElRWSHPrXCQsBjwoWNXLd+0Y7EXLZfVVvYN3aea9s5NnmxsH/oYDKDmyZNy
         /ia9638PYbtREP6dabYvNCdVqlFJchNNFlCJ75yFBYUHcyDPvNwbRZ3zGGfoTG+40+TT
         ylGa1gPS62kMkLfVkNFIHTdfJXEfD484UrVxa1VUOaBevdP6kUNfwenm7tXVGdiq/G+7
         +b0rSX/Ro1ccx5XLxzV05RY+RaKLilmweWjmFzO5wZ5bqhD7y+OXrUjMqqbkYkP2PLTQ
         xS1Q==
X-Gm-Message-State: AO0yUKUlnQSdS/teXRmDJg3qFnMwWGWhdWQ4TwQBV+qf4ybO/ECTD/tA
        d/cBsY5HSsW4dZqwuB9iau3DBjxBQof6Eylu9RI=
X-Google-Smtp-Source: AK7set9YQPl1ixGJsobgdhQQA0HOeujgmISWyUYo3TnahYiDIb+GEKKaDN9lrCzu8SJDjAEe/aXxDfTVUYyD0Pk0jzg=
X-Received: by 2002:a9d:7cd5:0:b0:693:bdd8:7b32 with SMTP id
 r21-20020a9d7cd5000000b00693bdd87b32mr1761883otn.3.1677961904325; Sat, 04 Mar
 2023 12:31:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:31f:b0:4c2:d201:fe1f with HTTP; Sat, 4 Mar 2023
 12:31:43 -0800 (PST)
In-Reply-To: <CAGudoHH8t9_5iLd8FsTW4PBZ+_vGad3YAd8K=n=SrRtnWHm49Q@mail.gmail.com>
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
 <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com> <CAGudoHH8t9_5iLd8FsTW4PBZ+_vGad3YAd8K=n=SrRtnWHm49Q@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 4 Mar 2023 21:31:43 +0100
Message-ID: <CAGudoHFPr4+vfqufWiscRXqSRAuZM=S8H7QsZbiLrG+s1OWm1w@mail.gmail.com>
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

On 3/4/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 3/3/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Fri, Mar 3, 2023 at 12:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
>>>
>>> I think there is a systemic problem which comes with the kzalloc API
>>
>> Well, it's not necessarily the API that is bad, but the implementation.
>>
>> We could easily make kzalloc() with a constant size just expand to
>> kmalloc+memset, and get the behavior you want.
>>
>> We already do magical things for "find the right slab bucket" part of
>> kmalloc too for constant sizes. It's changed over the years, but that
>> policy goes back a long long time. See
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/=
?id=3D95203fe78007f9ab3aebb96606473ae18c00a5a8
>>
>> from the BK history tree.
>>
>> Exactly because some things are worth optimizing for when the size is
>> known at compile time.
>>
>> Maybe just extending kzalloc() similarly? Trivial and entirely untested
>> patch:
>>
>>    --- a/include/linux/slab.h
>>    +++ b/include/linux/slab.h
>>    @@ -717,6 +717,12 @@ static inline void *kmem_cache_zalloc(struct
>> kmem_cache *k, gfp_t flags)
>>      */
>>     static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags=
)
>>     {
>>    +    if (__builtin_constant_p(size)) {
>>    +            void *ret =3D kmalloc(size, flags);
>>    +            if (ret)
>>    +                    memset(ret, 0, size);
>>    +            return ret;
>>    +    }
>>         return kmalloc(size, flags | __GFP_ZERO);
>>     }
>>
>
> So I played with this and have a rather nasty summary. Bullet points:
> 1. patched kzalloc does not reduce memsets calls during kernel build
> 2. patched kmem_cache_zalloc_ptr + 2 consumers converted *does* drop
> it significantly (36150671 -> 14414454)
> 3. ... inline memset generated by gcc sucks by resorting to rep stosq
> around 48 bytes
> 4. memsets not sorted out have sizes not known at compilation time and
> are not necessarily perf bugs on their own [read: would benefit from
> faster memset]
>
> Onto the the meat:
>
> I patched the kernel with a slightly tweaked version of the above:
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45af70315a94..7abb5490690f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -717,6 +717,12 @@ static inline void *kmem_cache_zalloc(struct
> kmem_cache *k, gfp_t flags)
>   */
>  static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
>  {
> +       if (__builtin_constant_p(size)) {
> +               void *ret =3D kmalloc(size, flags);
> +               if (likely(ret))
> +                       memset(ret, 0, size);
> +               return ret;
> +       }
>         return kmalloc(size, flags | __GFP_ZERO);
>  }
>
> and verified it indeed zeroes inline:
>
> void kztest(void)
> {
>         void *ptr;
>
>         ptr =3D kzalloc(32, GFP_KERNEL);
>         if (unlikely(!ptr))
>                 return;
>         memsettest_rec(ptr);
> }
>
> $ objdump --disassemble=3Dkztest vmlinux
> [snip]
> call   ffffffff8135e130 <kmalloc_trace>
> test   %rax,%rax
> je     ffffffff81447d5f <kztest+0x4f>
> movq   $0x0,(%rax)
> mov    %rax,%rdi
> movq   $0x0,0x8(%rax)
> movq   $0x0,0x10(%rax)
> movq   $0x0,0x18(%rax)
> call   ffffffff81454060 <memsettest_rec>
> [snip]
>
> This did *NOT* lead to reduction of memset calls when building the kernel=
.
>
> I verified few cases by hand, it is all either kmem_cache_zalloc or
> explicitly added memsets with sizes not known at compilation time.
>
> Two most frequent callers:
> @[
>     memset+5
>     __alloc_file+40
>     alloc_empty_file+73
>     path_openat+77
>     do_filp_open+182
>     do_sys_openat2+159
>     __x64_sys_openat+89
>     do_syscall_64+93
>     entry_SYSCALL_64_after_hwframe+114
> ]: 11028994
> @[
>     memset+5
>     security_file_alloc+45
>     __alloc_file+89
>     alloc_empty_file+73
>     path_openat+77
>     do_filp_open+182
>     do_sys_openat2+159
>     __x64_sys_openat+89
>     do_syscall_64+93
>     entry_SYSCALL_64_after_hwframe+114
> ]: 11028994
>
> My wip addition is:
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45af70315a94..12b5b02ef3d3 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -710,6 +710,17 @@ static inline void *kmem_cache_zalloc(struct
> kmem_cache *k, gfp_t flags)
>         return kmem_cache_alloc(k, flags | __GFP_ZERO);
>  }
>
> +#define kmem_cache_zalloc_ptr(k, f, retp) ({                           \
> +       __typeof(retp) _retp =3D kmem_cache_alloc(k, f);                 =
 \
> +       bool _rv =3D false;                                              =
 \
> +       retp =3D _retp;                                                  =
 \
> +       if (likely(_retp)) {                                            \
> +               memset(_retp, 0, sizeof(*_retp));                       \
> +               _rv =3D true;                                            =
 \
> +       }                                                               \
> +       _rv;                                                            \
> +})
> +
> diff --git a/security/security.c b/security/security.c
> index cf6cc576736f..0f769ede0e54 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -600,8 +600,7 @@ static int lsm_file_alloc(struct file *file)
>                 return 0;
>         }
>
> -       file->f_security =3D kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL=
);
> -       if (file->f_security =3D=3D NULL)
> +       if (!kmem_cache_zalloc_ptr(lsm_file_cache, GFP_KERNEL,
> file->f_security))
>                 return -ENOMEM;
>         return 0;
>  }

This one is actually buggy -- f_security is a void * pointer and
sizeof(*file->f_security) returns just 1. The macro does not have any
safety belts against that -- it should probably check for void * at
compilation time and get a BUG_ON for runtime mismatch. Does not
affect the idea though.

Good news: gcc provides a lot of control as to how it inlines string
ops, most notably:
       -mstringop-strategy=3Dalg
           Override the internal decision heuristic for the particular
algorithm to use for inlining string
           operations.  The allowed values for alg are:

           rep_byte
           rep_4byte
           rep_8byte
               Expand using i386 "rep" prefix of the specified size.

           byte_loop
           loop
           unrolled_loop
               Expand into an inline loop.

           libcall
               Always use a library call.

I'm going to play with it and send something more presentable.

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 372653b92617..8e0dabf9530e 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -136,8 +136,7 @@ static struct file *__alloc_file(int flags, const
> struct cred *cred)
>         struct file *f;
>         int error;
>
> -       f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> -       if (unlikely(!f))
> +       if (!kmem_cache_zalloc_ptr(filp_cachep, GFP_KERNEL, f))
>                 return ERR_PTR(-ENOMEM);
>
>         f->f_cred =3D get_cred(cred);
>
> As mentioned above it cuts total calls in more than half.
>
> The problem is it is it rolls with rep stosq way too easily, partially
> defeating the point of inlining anything. clang does not have this
> problem.
>
> Take a look at __alloc_file:
> [snip]
> mov    0x19cab05(%rip),%rdi        # ffffffff82df4318 <filp_cachep>
> call   ffffffff813dd610 <kmem_cache_alloc>
> test   %rax,%rax
> je     ffffffff814298b7 <__alloc_file+0xc7>
> mov    %rax,%r12
> mov    $0x1d,%ecx
> xor    %eax,%eax
> mov    %r12,%rdi
> rep stos %rax,%es:(%rdi)
> [/snip]
>
> Here is a sample consumer which can't help but have a variable size --
> select, used by gmake:
> @[
>     memset+5
>     do_pselect.constprop.0+202
>     __x64_sys_pselect6+101
>     do_syscall_64+93
>     entry_SYSCALL_64_after_hwframe+114
> ]: 13160
>
> In conclusion:
> 1. fixing up memsets is worthwhile regardless of what happens to its
> current consumers -- not all of them are necessarily doing something
> wrong
> 2. inlining memset can be a pessimization vs non-plain-erms memset as
> evidenced above. will have to figure out how to convince gcc to be
> less eager to use it.
>
> Sometimes I hate computers.
>
> --
> Mateusz Guzik <mjguzik gmail.com>
>


--=20
Mateusz Guzik <mjguzik gmail.com>
