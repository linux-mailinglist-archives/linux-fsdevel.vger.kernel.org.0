Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A275CDA63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 04:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfJGCGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 22:06:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44203 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfJGCGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 22:06:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so11835396ljj.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 19:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qiUHylA1kcZKMZORFgPfl/Wwk8TxgMqTrPx6EUI34c=;
        b=SQ1klqasMPWiAPOUygJMVdAoW7sOImnFa+ky/otsy+obDuwpTyXXbJfsrm9ITmXxRc
         iFffZqz66qKnniup6bIqMecKZCOQ9QI2qE8ok/fmyCOPS8Z+F6Dbw0tviLzaoBA7V7uo
         4G6lDiYzHKNBbLSRX2ny8sOlnMYEJSsjOrb3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qiUHylA1kcZKMZORFgPfl/Wwk8TxgMqTrPx6EUI34c=;
        b=O1OhX8b0T6ZIAXpFPOmuvNAJcBvJzWSnEd9JQ0EX79U3zORgnoy1v/HhaoMK1WaZ+s
         oWLj9G+JOqDk/BbLgtSjgFm2NxpRltonUlWHd1srJMee3kZZrGdHVuhMUKgo6hlAzvYC
         dVahVdCr1EHsaxrFACnCgtd1d5cZoejYGU0ETF7x1sFNzVf7emNbvwhor5guqOdXgCsB
         2Bv3KnFb+Xr9a90BUES7QoEUIghhErnXkAfLC0GTT1w1UjNd69WWqeLNDMxl4DJjJcHU
         kbtmW1kLTlhyAZghvggKGEataWP17NRTxXgt4SDARHw6bGr1hfEW00EXdHC3BpGcJsqB
         tFIg==
X-Gm-Message-State: APjAAAWW8Y7zTWjLh6CQ4SEe9JxKf2s2lFqNEeDyznjxcViwidh7/TUi
        ELHE4UJZyKKyOmfUHpumUS/nCBgKv54=
X-Google-Smtp-Source: APXvYqwnTRCw/rs9mxM9XkikaD7ZYkb8QdxH+Y8cusBJNNSCXvCtoA2OeiFfMZPjBu6LrJOFGInipQ==
X-Received: by 2002:a2e:9584:: with SMTP id w4mr16496554ljh.145.1570413997540;
        Sun, 06 Oct 2019 19:06:37 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id c15sm2816992ljf.1.2019.10.06.19.06.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 19:06:36 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id d1so11837625ljl.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 19:06:36 -0700 (PDT)
X-Received: by 2002:a2e:7611:: with SMTP id r17mr11961696ljc.133.1570413995847;
 Sun, 06 Oct 2019 19:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
In-Reply-To: <20191007012437.GK26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 19:06:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
Message-ID: <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 6, 2019 at 6:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Ugh...  I wonder if it would be better to lift STAC/CLAC out of
> raw_copy_to_user(), rather than trying to reinvent its guts
> in readdir.c...

Yeah, I suspect that's the best option.

Do something like

 - lift STAC/CLAC out of raw_copy_to_user

 - rename it to unsafe_copy_to_user

 - create a new raw_copy_to_user that is just unsafe_copy_to_user()
with the STAC/CLAC around it.

and the end result would actually be cleanert than what we have now
(which duplicates that STAC/CLAC for each size case etc).

And then for the "architecture doesn't have user_access_begin/end()"
fallback case, we just do

   #define unsafe_copy_to_user raw_copy_to_user

and the only slight painpoint is that we need to deal with that
copy_user_generic() case too.

We'd have to mark it uaccess_safe in objtool (but we already have that
__memcpy_mcsafe and csum_partial_copy_generic, os it all makes sense),
and we'd have to make all the other copy_user_generic() cases then do
the CLAC/STAC dance too or something.

ANYWAY.  As mentioned, I'm not actually all that worried about this all.

I could easily also just see the filldir() copy do an extra

#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
    if (len && (1 & (uint_ptr_t)dst)) .. copy byte ..
    if (len > 1 && (2 & (uint_ptr_t)dst)) .. copy word ..
    if (len > 3 && (4 & (uint_ptr_t)dst) && sizeof(unsigned long) > 4)
.. copy dword ..
#endif

at the start to align the destination.

The filldir code is actually somewhat unusual in that it deals with
pretty small strings on average, so just doing this might be more
efficient anyway.

So that doesn't worry me. Multiple ways to solve that part.

The "uhhuh, unaligned accesses cause more than performance problems" -
that's what worries me.

            Linus
