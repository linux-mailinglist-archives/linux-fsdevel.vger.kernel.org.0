Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E145CEB85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJGSL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 14:11:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36735 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:11:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so9967042lff.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSXG+xP1mD1UZGXg2TTq5r4dUsztpjrAAtm+apLCkB0=;
        b=T9+n4Uy8+vBXnVgYXqxACSICel9I1qrO3WM1rG9o1zxB4y8+nglyP7so9RqnUS9cQ8
         DPynUXscIFi1WYKoG9zr1emFzkpLyTp2BRuohwDJ1ouK6+mq/bC+2eV4h1P0P5G2vHiB
         f45dnjMv5AzSxoSBKOdXSpYYKUfiyQB6mH0fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSXG+xP1mD1UZGXg2TTq5r4dUsztpjrAAtm+apLCkB0=;
        b=GjMyCEwl8EFlrREHmJ2iP8YwNR/ujZy3jijakLQlAYJeOHhtx2GwSx4sQjNx2DK5R3
         3XSwqqqTGzjreIR2dB3VPogqAtb8DtRieffC9W0NlEzYdcCL4Je2l1Q5+VTAcXwC9Sfp
         gUwJVIHvwz3eujwJm+XqIU8ZftbZ4qYIGPGSgTvtrYJEIiRRUHFqWvDYuoNuR2Oz5szr
         oBMpeTziWM93cfkGYsHk0WaAwD3ELXJDDa6KTUBJjViXdyplh/7fTxIEFrkxqRKxTkJB
         V0VQ3FawjoFya5IIKS/w0JQSZbXaPJ9N99p8i/dr1X1Q6INC5nlUMyxoIPHPPlJw+cTs
         Bs1Q==
X-Gm-Message-State: APjAAAU06O8Z+gkAUUC9+F41j75daT5zYTUNVMKL+p7csK/PzvIiKiI6
        uONrf04yjhjCS09NWWZlsVMJhjJ8Dyc=
X-Google-Smtp-Source: APXvYqz+iEPYRml7J1K24ZyUPUMUwGIUIr+RNEqc84u4JiLJKJQymL9QhI8PZuuOuvAo/gc6mcjU5g==
X-Received: by 2002:a19:c709:: with SMTP id x9mr17893590lff.20.1570471886533;
        Mon, 07 Oct 2019 11:11:26 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y26sm4034037ljj.90.2019.10.07.11.11.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:11:25 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id n14so14672983ljj.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 11:11:25 -0700 (PDT)
X-Received: by 2002:a2e:9556:: with SMTP id t22mr19099733ljh.97.1570471885049;
 Mon, 07 Oct 2019 11:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <c58c2a8a5366409abd4169d10a58196a@AcuMS.aculab.com>
In-Reply-To: <c58c2a8a5366409abd4169d10a58196a@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 11:11:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjF2fkhuN8N-MnTwvzNig83XdQK50nir8oieF7jV6Om=A@mail.gmail.com>
Message-ID: <CAHk-=wjF2fkhuN8N-MnTwvzNig83XdQK50nir8oieF7jV6Om=A@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     David Laight <David.Laight@aculab.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 7, 2019 at 8:40 AM David Laight <David.Laight@aculab.com> wrote:
>
> You don't really want an extra access_ok() for every 'word' of a copy.

Yes you do.

> Some copies have to be done a word at a time.

Completely immaterial. If you can't see the access_ok() close to the
__get/put_user(), you have a bug.

Plus the access_ok() is cheap. The real cost is the STAC/CLAC.

So stop with the access_ok() "optimizations". They are broken garbage.

Really.

I've been very close to just removing __get_user/__put_user several
times, exactly because people do completely the wrong thing with them
- not speeding code up, but making it unsafe and buggy.

The new "user_access_begin/end()" model is much better, but it also
has actual STATIC checking that there are no function calls etc inside
th4e region, so it forces you to do the loop properly and tightly, and
not the incorrect "I checked the range somewhere else, now I'm doing
an unsafe copy".

And it actually speeds things up, unlike the access_ok() games.

               Linus
