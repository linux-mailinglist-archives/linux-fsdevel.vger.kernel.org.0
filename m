Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901694E848C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 23:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiCZWjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 18:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiCZWji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 18:39:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D611CFC6
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 15:37:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h7so19006666lfl.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdYgy+BZM/qprtUrSJtz2sLcoAPvMOpRAnQOyOkfks0=;
        b=Jw6DrHMuxeWP0GsAMFasqVTu7gc9fm8+5bPEimBbfJItCEfvOpQ/SAoW7oVnVF8h1a
         zyOY7FXwzMtDYPN/IqO7UjNlKkJDjQVO/UdkwXT3p6KGmfYsyTyFgPP620KyAmS8NxFK
         XxdhThFmIC2+Ii7SVeQvHg685M9picsPpRRLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdYgy+BZM/qprtUrSJtz2sLcoAPvMOpRAnQOyOkfks0=;
        b=j3X9s2yk1+LGOfr3pYvfjfvcW8ywn1i7em/o6yotNOZdhUQ3map+fYiEewJFSfesjE
         biGiOvzvb45aSIhBMsbtMfb+04pYIRiofFlpmk8gcaJP4KejwQ8pPxG+aMQlTJptJP+0
         cAlzwio5xgNgxB4Ca7HuugzJcrIk+BOQ1Sh3lnJM69XAONpp/q5pKXlQ41erjpya5QaA
         6mMKypmRf2UdLG9SPNKqe/IBSMABb2LT/9nxhw5000JkF6PBYV8C9qFlEAmU7TzMh64P
         5qhDu4n8gFwWlMIjcxTpIwtWKxMLuXW4CXIjwcKSEvba485EhmVW5BbO7JiHsVEM+Tea
         +yvw==
X-Gm-Message-State: AOAM530nV45UUPSnJtzUKtomDfTMEGZLwYNX7oyP4zY4BXaNNMTPEO+m
        RfdITk9LWHjW1Q+4D7yBCoS8tx0kOKS7eNgP1TU=
X-Google-Smtp-Source: ABdhPJxQ9BQfO9ZrdJ674+r8PzXRraEEvtmHAOr3rRFJJ++I3xyqHTbcvjsQNjhNv9oh3nFTzQC0ew==
X-Received: by 2002:ac2:4c42:0:b0:448:622e:5e81 with SMTP id o2-20020ac24c42000000b00448622e5e81mr13728820lfk.425.1648334276707;
        Sat, 26 Mar 2022 15:37:56 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z26-20020ac2419a000000b004484bf6d1e6sm1187417lfh.233.2022.03.26.15.37.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 15:37:55 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id r22so14606819ljd.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 15:37:54 -0700 (PDT)
X-Received: by 2002:a2e:a790:0:b0:249:906a:c6f1 with SMTP id
 c16-20020a2ea790000000b00249906ac6f1mr13650380ljf.164.1648334274351; Sat, 26
 Mar 2022 15:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <c7fcaccf-7ac0-fae8-3f41-d6552b689a70@ispras.ru>
 <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
In-Reply-To: <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 15:37:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
Message-ID: <CAHk-=wgiTa-Cf+CyChsSHe-zrsps=GMwsEqFE3b_cgWUjxUSmw@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Mar 26, 2022 at 3:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but maybe I'm missing something.

Side note: the thing I'm _definitely_ missing is context for this patch.

I'm seeing "4/4" in the subject, but I can't find 1-3.

And the patch most definitely doesn't apply as-is, because that
'add_byte' logic that it removes lines around doesn't exist in my tree
at least.

And I _do_ think that regardless of anything else, having those
calculations use BITS_PER_BYTE - as if byte level operations were
valid - is misleading.

I do find something dodgy: alloc_fdtable().

That function very much tries to keep things to that multiple of
BITS_PER_LONG, and even has a comment to that effect, but I wonder if
it is broken.

In particular, that

  nr = ... | (BITS_PER_LONG - 1)) + 1;

case is only done for the "nr > sysctl_nr_open" case. The other case
*DOES* align things up, but not necessarily sufficiently, in that it
does

        nr /= (1024 / sizeof(struct file *));
        nr = roundup_pow_of_two(nr + 1);
        nr *= (1024 / sizeof(struct file *));

and I think that despite the round-up, it could easily be a smaller
power-of-two than BITS_PER_LONG.

So I think that code _intended_ for things to always be a multiple of
BITS_PER_LONG, but I'm not convinced it is.

It would be a good idea to just make it very explicit that it's
properly aligned, using

    --- a/fs/file.c
    +++ b/fs/file.c
    @@ -111,7 +111,8 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
         * bitmaps handling below becomes unpleasant, to put it mildly...
         */
        if (unlikely(nr > sysctl_nr_open))
    -           nr = ((sysctl_nr_open - 1) | (BITS_PER_LONG - 1)) + 1;
    +           nr = sysctl_nr_open;
    +   nr = ALIGN(nr, BITS_PER_LONG);

        fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL_ACCOUNT);
        if (!fdt)

although that would perhaps break the whole "we try to allocate in
comfortable page-tuned chunks" code, so that obvious patch may be
doing non-obvious bad things.

Maybe it's the roundup_pow_of_two() that should be fixed to be that
proper BITS_PER_LONG alignment instead?

And related to this all, we do have that BITS_PER_BYTE thing in a few
places, and they are all a bit dodgy:

 - copy_fd_bitmaps() uses BITS_PER_BYTE, but I do think that all the
values it operates on _should_ be BITS_PER_LONG aligned

 - alloc_fdtable() again does "2 * nr / BITS_PER_BYTE" for the bitmap
allocations

and we should make really really sure that we're always doing
BITS_PER_LONG, and that alloc_fdtable() calculation should be checked.

Hmm?

                   Linus
