Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC68A4FCF02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 07:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348282AbiDLFkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 01:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiDLFki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:40:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F263298E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 22:38:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p10so30229545lfa.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 22:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ll/XCn4eT+mWamanV6qNk4+X9BXYFUW6oQ8MurM5uWk=;
        b=fgDQtBam00x6nb34pezhr9TPAf1bSvMtM9E7e+7/EJFJ0nDM4iVhYJw44irfk6xwVf
         a/rZdmHC8yHQm0YKrnUgWgtnnIIt+39mjQLGJjZI9WcmYGULNEqjt8ngp9lF9MPtXJid
         4JXvtH94CmaNaA67XvUEW5RqzRlX4VH/u8qsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ll/XCn4eT+mWamanV6qNk4+X9BXYFUW6oQ8MurM5uWk=;
        b=tb1SCbrK3fn2H1FyRkLuWYQMQWICTMNODGx5ZvekpYZgiWZkJNPmbwVa41TMj3KiIj
         PtDJaPA+vFCe26XQSClGQOjC1TlarMcJu2VsiDQGzj14k2GJNkhiWwN+BzV/dbDOnTps
         SHGmPoDWWgsu5OXmDCjKV4mINNwI6YbYzf4v+R0GBB8/aE9ZLQGV4IfK9L7XaaezFiRh
         8APyBiVnRLg0wj2t95U6pFaqoEJ1dbliJEn2zgozdDmYstO7yaVyazha2zDtyCVxegJJ
         1RVY47e9xQnJh+8HFxiCdbFLCzNaZ7qd0lRWJZUlcpBQQvCxLtMDe4mltixxmG+7dH4B
         fKXQ==
X-Gm-Message-State: AOAM530blDhwhYW/UqoDgASA2bezwHvlFUvaqXZ5DqUAUwJuCt8VDkGi
        chhIXxqixqObOrKLZFoEqx24eBHffzy0pGS6
X-Google-Smtp-Source: ABdhPJxRqzHrjZ5xBGu4VMrr5LuEcHFh0rhxkbPHpvTxhFukOngK37hOET7wDtVcnvuJWaAfbGlWSg==
X-Received: by 2002:a05:6512:2252:b0:44a:3038:cbc with SMTP id i18-20020a056512225200b0044a30380cbcmr23973922lfu.252.1649741900173;
        Mon, 11 Apr 2022 22:38:20 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m8-20020a194348000000b0046bae58249asm350829lfj.212.2022.04.11.22.38.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 22:38:19 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id bq30so17528763lfb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 22:38:19 -0700 (PDT)
X-Received: by 2002:ac2:5483:0:b0:46b:9dc3:cdd4 with SMTP id
 t3-20020ac25483000000b0046b9dc3cdd4mr8854787lfk.542.1649741899091; Mon, 11
 Apr 2022 22:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com> <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Apr 2022 19:37:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
Message-ID: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 7:13 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Should we perhaps hash the number, take 16 bits of the hash and hope
> than the collision won't happen?

That would "work", but I think it would be incredibly annoying to
users with basically random results.

I think the solution is to just put the bits in the high bits. Yes,
they might be masked off if people use 'MAJOR()' to pick them out, but
the common "compare st_dev and st_ino" model at least works. That's
the one that wants unique numbers.

> For me, the failure happens in cp_compat_stat (I have a 64-bit kernel). In
> struct compat_stat in arch/x86/include/asm/compat.h, st_dev and st_rdev
> are compat_dev_t which is 16-bit. But they are followed by 16-bit
> paddings, so they could be extended.

Ok, that actually looks like a bug.

The compat structure should match the native structure.  Those "u16
__padX" fields seem to be just a symptom of the bug.

The only user of that compat_stat structure is the kernel, so that
should just be fixed.

Of course, who knows what the libraries have done, so user space could
still have screwed up.

> If you have a native 32-bit kernel, it uses 'struct stat' defined at the
> beginning of arch/x86/include/uapi/asm/stat.h that has 32-bit st_dev and
> st_rdev.

Correct. It's literally the compat structure that has no basis in reality.

Or it might be some truly ancient thing, but I really don't think so.

Regardless, if we fill in the high 16 bits of that field, in the
_worst_ case things will act as if your patch had been applied, but in
any sane case you'll have that working "unique st_dev" thing.

I'd love to actually use the better "modern" 64-bit encoding (12+20
bits, or whatever it is we do, too lazy to look it up), but hey, that
historical thing is what it is.

Realistically, nobody uses it. Apparently your OpenWatcom use is also
really just fairly theoretical, not some "this app is used by people
and doesn't work with a filesystem on NVMe".

                 Linus
