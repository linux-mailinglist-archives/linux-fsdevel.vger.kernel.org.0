Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A85FA37C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJJSkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 14:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJJSkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:40:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146E213D6E
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 11:40:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 67so11443876pfz.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=73IFEj8UKp21a0lUf+7fHKRgxbCrQEXIzggPWAc8GZk=;
        b=s7kXX/Nzrao9i8oAWjJPJfckPVhA9J/dx0H9OvPpYn8EN3YVFYh1+K8N8nCs/YRoxb
         xdBl5kox7WPHUktOMOCjrH8sv6Ibzevz1nG94J5UKZjYoXYej2XtK1sVrgAJu2i1N3lz
         DeJ8aNpK0+pZxx5AoJb7TSoPl8CNQzRG9Hcj2n5iymm5KMujta82Kk5mytZZ0LozcXH5
         aBCWhm1d/e9/LBR7cS96NQ6f9z/GAyOrGyr6/BAHiIhAZ3RZixfHzKNyKZtBdaPJJbnx
         Xicf+/S5cz+hcjBzR/rbmbt/KCZL8xRGbGFvvNIZUXXer/Vj1cWzy0ZPnSErrz7DmdWm
         vp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73IFEj8UKp21a0lUf+7fHKRgxbCrQEXIzggPWAc8GZk=;
        b=VKPGW7SmPykgKavHErQ4jfLhYKIg9gszvxbmMLkN/5UdtjcJyDqYz/SAxYY5atTghU
         RFo7dgYAKZHUllkQquW8DWqoMigMin6wVBajR4AbdyQL9r66vrs319gzQMe4fLvS21rh
         C4uRxQ08///CxEktQsktUvg93I3+A24b5eVkFjhLR888ti9zJGgb1sewICAnbOLiTDxv
         xRP1aKx2AJRVizdnwssc6knUB6bAL1rK+9gNuYP/64dscDXBLIgwdYvP7q5arcT1lWsw
         FBAs/CW3FzGFFAQHv7qIorIK1WFV4i5863truZ5MtoL+JTPDdeVC8Rjho2/Rxb+/wn+a
         SjDA==
X-Gm-Message-State: ACrzQf3RwYQh+azYj+gnoknuCQyHEnHZueVe+Ad5u0wJ21RyNUGRlzvt
        BlbBTgYvLIK21xV4yLuhC+75JkpwDpVKz9Qj70l2jg==
X-Google-Smtp-Source: AMsMyM6EDBQwGEdbN7Wbm0jiIRVw6lRI/YWSkiDGiSLzkecxw2vOElVi8XDqpQstg5QnBVRXM9TymdvbvkMuf480wKk=
X-Received: by 2002:aa7:83cd:0:b0:563:5f54:d78c with SMTP id
 j13-20020aa783cd000000b005635f54d78cmr7096497pfn.66.1665427239975; Mon, 10
 Oct 2022 11:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190307090146.1874906-1-arnd@arndb.de> <20221006222124.aabaemy7ofop7ccz@google.com>
 <c646ea1e-c860-41cf-9a8e-9abe541034ff@app.fastmail.com> <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
 <e554eb3c-d065-4aad-b6d2-a12469eaf49c@app.fastmail.com> <CAKwvOdmNiSok3sAMJs2PQLs0yVzOfMTaQTWjyW8q2oc3VF60sw@mail.gmail.com>
In-Reply-To: <CAKwvOdmNiSok3sAMJs2PQLs0yVzOfMTaQTWjyW8q2oc3VF60sw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Oct 2022 11:40:28 -0700
Message-ID: <CAKwvOdmWvDBw9MnO==dZ8i=gqbVPSUuiuRtwKmWuV8uXzJYNww@mail.gmail.com>
Subject: Re: [PATCH] fs/select: avoid clang stack usage warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Paul Kirth <paulkirth@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 7, 2022 at 3:54 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> This seems to be affected by -fno-conserve-stack, a currently gcc-only
> command line flag. If I remove that, then i386 defconfig will inline
> do_select but x86_64 defconfig will not.
>
> I have a sneaking suspicion that -fno-conserve-stack and
> -Wframe-larger-than conspire in GCC to avoid inlining when doing so
> would trip `-Wframe-larger-than` warnings, but it's just a conspiracy
> theory; I haven't read the source.  Probably should implement exactly
> that behavior in LLVM.

Sorry, that should have read `-fconserve-stack` (not `-fno-conserve-stack`).

Playing with:
https://godbolt.org/z/hE67j1Y9G
experimentally, it looks like irrespective of -Wframe-larger-than,
-fconserve-stack will try to avoid inlining callees if their frame
size is 512B or greater for x86-64 targets, and 410B or greater for
32b targets. aarch64 is 410B though, perhaps that's leftover from the
32b ARM port.  There's probably more to the story there though.

> I'll triple check 32b+64b arm configs next week to verify.  But if GCC
> is not inlining do_select into core_sys_select then I think my patch
> https://lore.kernel.org/llvm/20221007201140.1744961-1-ndesaulniers@google.com/
> is on the right track; probably could drop the 32b-only condition and
> make a note of GCC in the commit message.

arm64 does not inline do_select into core_sys_select with
aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
for defconfig.

$ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make -j128 defconfig fs/select.o
$ llvm-objdump -Dr --disassemble-symbols=core_sys_select fs/select.o |
grep do_select
    1a48: 2e fb ff 97  bl 0x700 <do_select>

Same for 32b ARM.
arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110

$ CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm make -j128 defconfig fs/select.o
$ llvm-objdump -Dr --disassemble-symbols=core_sys_select fs/select.o |
grep do_select
    1620: 07 fc ff eb  bl #-4068 <do_select>

Is there a set of configs or different compiler version for which
that's not the case? Perhaps. But it doesn't look like marking
do_select noinline_for_stack changes the default behavior for GCC
builds, which is good.

So it looks like it's just clang being aggressive with inlining since
it doesn't have -fconserve-stack.  I think
https://lore.kernel.org/lkml/20221007201140.1744961-1-ndesaulniers@google.com/
is still on the right track, though I'd remove the 32b only guard for
v2.

Christophe mentioned something about KASAN and GCC. I failed to
reproduce, and didn't see any reports on lore that seemed relevant.
https://lore.kernel.org/lkml/20221010074409.GA20998@lst.de/
I'll wait a day to see if there's more info (a config that reproduces)
before sending a v2 though.

> Also, my colleague Paul just whipped up a neat tool to help debug
> -Wframe-larger-than.
> https://reviews.llvm.org/D135488
> See the output from my run here:
> https://paste.debian.net/1256338/
> It's a very early WIP, but I think it would be incredibly helpful to
> have this, and will probably help us improve Clang's stack usage.

Paul also mentioned that -finline-max-stacksize is a thing, at least for clang.
https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-finline-max-stacksize
Though this only landed recently
https://reviews.llvm.org/rG8564e2fea559 and wont ship until clang-16.
That feels like a large hammer for core_sys_select/do_select; I think
we can use a fine scalpel.  But it might be interesting to use that
with KASAN.
-- 
Thanks,
~Nick Desaulniers
