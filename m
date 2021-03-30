Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F03534ED42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhC3QMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhC3QLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:11:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD1EC061762
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 09:11:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i26so24554473lfl.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C8dE4OXU10SnPyXITHR/58I6zNw62T8uKepw6EopNXA=;
        b=hTYivTzSYfmEeO5VzKxrvnXqui4y3yPgMEEBDH7vKOanpymLhfmDI4XX46b63dB9Yc
         qLVchprkXlFscZmdBKGu9phv6uNnZraKGS+QuDb9kIJGWVGQMQ6pTWtfMalxtyZql8Va
         PJM768PLObXAsOL9BIQsjJYrJAX4qIjzNRo/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C8dE4OXU10SnPyXITHR/58I6zNw62T8uKepw6EopNXA=;
        b=FN5PXTepg3aBDzQTX8ZJaFki75oAs1wZhAqOeUPmS+36F+tag6nWjm6Myk6jjtd7N2
         B1/Fsus/MjJ8EuyTLmfJFuM9zG7sIonWdjJM7IWDz4YfD6mJAFsGGZQNq71vs8Zr5WkO
         mtf5hbul4BoWZhPNlkMLppotsf8Ym004p9mZqAWB2fHUzS4eWAGUsZIT3vyRyO3KygaA
         LeRkEHtxjuMnjZ12SMo32HFgZ8xX7UjcJMsZ0i3pVUSZe4zayDeFky9InvtCANxRYm9N
         ut0uonfued0jGOgw8A+42yC0JWP1W+dAuyjBdpfYi3ZhaP7cr0aL1xhoPXycG/t7OvRn
         LOQQ==
X-Gm-Message-State: AOAM533BHKbmHkXNT2sgtApEAjQTL98GqpXHFejUuqCMjMwSLdZidjUe
        SdMSPzMg0Ut+JzsCHIb5lovhX2YkvsRY9dH9
X-Google-Smtp-Source: ABdhPJzIcueEpgqBPZoMVHJdVZ5yE/gmi7ZxlQ8JF/PXRpsbyblu42tMeesP3Umt635m6r4FVI+fVA==
X-Received: by 2002:a05:6512:3a2:: with SMTP id v2mr19628450lfp.575.1617120701599;
        Tue, 30 Mar 2021 09:11:41 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d8sm2219785lfa.49.2021.03.30.09.11.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 09:11:40 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id d13so3632249lfg.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 09:11:40 -0700 (PDT)
X-Received: by 2002:ac2:4250:: with SMTP id m16mr19284588lfl.40.1617120699723;
 Tue, 30 Mar 2021 09:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <m1blc1gxdx.fsf@fess.ebiederm.org> <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
 <m1r1kwdyo0.fsf@fess.ebiederm.org> <CALCv0x0FQN+LSUkJaSsV=MCjpFokfgHeqSTHYOTpzA6cOyvQoA@mail.gmail.com>
 <e52b2625-8d33-c081-adeb-f92f64ca1e8e@wanyeetech.com> <CALCv0x29Dvs2R=Hg9FebGUFZpd+vN1Lzz2N6a2Zohgo47ZhsGg@mail.gmail.com>
 <05dc921e-da71-4e71-6132-736eccd35680@wanyeetech.com>
In-Reply-To: <05dc921e-da71-4e71-6132-736eccd35680@wanyeetech.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Mar 2021 09:11:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHhEQW52FYV+J68Z+OZd5tUPv=Fa_o06n9Jj5J4wJU4w@mail.gmail.com>
Message-ID: <CAHk-=whHhEQW52FYV+J68Z+OZd5tUPv=Fa_o06n9Jj5J4wJU4w@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 9:56 PM Zhou Yanjie <zhouyanjie@wanyeetech.com> wro=
te:
>
> On 2021/3/29 =E4=B8=8A=E5=8D=8810:48, Ilya Lipnitskiy wrote:
> >
> > Try:
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c8e357627318..1fd753245369 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -166,7 +166,7 @@ static int __init init_zero_pfn(void)
> >          zero_pfn =3D page_to_pfn(ZERO_PAGE(0));
> >          return 0;
> >   }
> > -core_initcall(init_zero_pfn);
> > +early_initcall(init_zero_pfn);
>
> It works, thanks!

Looks good to me - init_zero_pfn() can be called early, because it
depends on paging_init() will should have happened long before any
initcalls in setup_arch().

Ilya, mind sending a signed-off version with a nice commit message,
and I'll apply it.

             Linus
