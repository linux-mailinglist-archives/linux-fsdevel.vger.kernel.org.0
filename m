Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F89546DD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 21:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350546AbiFJT5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350559AbiFJT5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:57:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58824252B4
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 12:57:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id me5so70844ejb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbo3zuKroI+lcNB8l3G6lMyG5+hX2/wCqhfxWwpR/X8=;
        b=e1a8+X4a2G8T9dfZsWM/hcMF1VbORV4FgyWhAbnoonR+yibE4kSmap/LSDsz+dipp/
         YrpOVVXJJe9pigepdLX44KVYvp16Lb8Jp0p1bCbmNcrypmmLkx2CPWMgpUIYfGECnyVH
         MEbH5mprQzZ3KzhylqpoHWRRtQ3NbcVyWVuBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbo3zuKroI+lcNB8l3G6lMyG5+hX2/wCqhfxWwpR/X8=;
        b=HeTaVC118Fv6JdsKqCpaaAK3AcRO7DzOU4EOt/eg0Va3P2UNDCc5f8KaKuMPkY5/ms
         9eBi2oAAnoqV5Js43xcUxNVl9ufWNW953UF0E+/8F07Lj8cazLDIZvStM438tV3AOGLW
         RO3rrsA3df4UZGVUVvrKonVs7zcpLp2cs2Y4caMP3DRNFd2/yObO8VU+PkPCAlCRhSzR
         v9lu1k4e+WrjXx61LKA8hGf0+h2LbivdETt9r2It+F9JcESLK/TMTk3yfiRAztMm7XMZ
         XzoDH8pmRMlQl44JFNT0miHQ7Q9vfJFZvX0LN3mw9QLvQEj7k8zrzi442cMnrB6mK7X5
         CBmg==
X-Gm-Message-State: AOAM531m11v4f10bD8PsrGIBbpHZDLTq80hYjgJyvo/rChw/kN5k+RSf
        UEKknZscyNZenHRwTck+9W5f0B5l3TdgdCmzEKA=
X-Google-Smtp-Source: ABdhPJxNUoxIZE2CLe2VdW+JacpF13b4KOwMDqrxXgjn67RpLFwKS9FVlGhATPl0Yom+thBJ6tZWfw==
X-Received: by 2002:a17:907:2d29:b0:70e:8b1c:c3f0 with SMTP id gs41-20020a1709072d2900b0070e8b1cc3f0mr35329372ejc.37.1654891025622;
        Fri, 10 Jun 2022 12:57:05 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170906f6cd00b006febc86b8besm12422372ejb.117.2022.06.10.12.57.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 12:57:05 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id o8so9984149wro.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 12:57:04 -0700 (PDT)
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id
 u3-20020a5d6da3000000b00219bcdd97cdmr8497919wrs.274.1654891024619; Fri, 10
 Jun 2022 12:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <YqOZ3v68HrM9LI//@casper.infradead.org>
In-Reply-To: <YqOZ3v68HrM9LI//@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jun 2022 12:56:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyexxiFw5N+TtE5kUk4iF4LaNoY3Pzj7aZcj6Msp+tOg@mail.gmail.com>
Message-ID: <CAHk-=wiyexxiFw5N+TtE5kUk4iF4LaNoY3Pzj7aZcj6Msp+tOg@mail.gmail.com>
Subject: Re: [GIT PULL] Folio fixes for 5.19
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:22 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>  - Don't release a folio while it's still locked

Ugh.

I *hate* this patch. It's just incredibly broken.

Yes, I've pulled this, but I have looked at that readahead_folio()
function before, and I have despised it before, but this patch really
drove home how incredibly broken that function is.

Honestly, readahead_folio() returns a folio *AFTER* it has dropped the
ref to that folio.

That's broken to start with. It's not only really wrong to say "here's
a pointer, and by the way, you don't actually hold a ref to it any
more".

It's doubly broken because it's *very* different from the similarly
named readahead_page() that doesn't have that fundamental interface
bug.

But it's now *extra* broken now that you realize that the dropping of
the ref was very very wrong, so you re-get the ref. WTF?

As far as I can tell, ALL THE OTHER users of this broken function fall
into two categories:

 (a) they are broken (see the exact same broken pattern in
fs/erofs/fscache.c, for example)

 (b) they only use the thing as a boolean

Anyway, I've pulled this, but I really seriously object to that
completely mis-designed function.

Please send me a follow-up patch that fixes it by just making the
*callers* drop the refcount, instead of doing it incorrectly inside
readahead_folio().

Alternatively, make "readahead_folio()" just return a boolean - so
that the (b) case situation can continue the use this function - and
create a new function that just exposes __readahead_folio() without
this broken "drop refcount" behavior).

Or explain why that "drop and retake ref" isn't

 (a) completely broken and racy

 (b) inefficient

 (c) returning a non-ref'd folio pointer is horribly broken interface
to begin with

because right now it's just disgusting in so many ways and this bug is
just the last drop for me.

                 Linus
