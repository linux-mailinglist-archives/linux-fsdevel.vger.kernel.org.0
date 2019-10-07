Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133E5CEC05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 20:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfJGSg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 14:36:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40883 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJGSgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:36:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id m61so9589330qte.7;
        Mon, 07 Oct 2019 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXL8J/OQJmreiyptvpgxHievcJo6KOM1a1ady8Gq0qE=;
        b=cgP9FKCa+Rmg1fTWx4Msi4HhEyQYM8Leky4PtPKPdo9NVLQNF7g+tQice2NdsF1wle
         7dMOsp5hA0jBv4ORML7x3lEzYii1kVHIj43FMVWOP7GiA83bcRuJCWAQAaAD9VMiPrvr
         Q4TlQdpN5rBvYAGZzCI8xZtC0U28TWXpzW0r38zOei3eZDv+iAhBrWsDAkVKaAODQrx0
         dm5G/+su7Y2HRKWxoFPFq9b1JFxMLf40knrHIHJjUdysI2s9YJSHzeuBh8+A3P33RZ12
         oMjBE6ZB562H0IZx8QoH5hbAdYn4ah4LsJ0gVqNjUzOWIqn3nyvY7+KSV3YUZKDgNKDK
         v1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXL8J/OQJmreiyptvpgxHievcJo6KOM1a1ady8Gq0qE=;
        b=BjKfLIbtxA9rSmyNR7lGC9QPxwgB+HxZ1ZydLRFeSAXN/DBL5XsJgdv23IjPd6Aa42
         lKcmFeEsbOJcwIauEDzDKn12k3EN/YYGYOQpJKiM8SHn4279Sj5wy20lvNAgRybw61Lf
         oYFig1eLb6oDnwrLc5U4RLWKcVsxotHtRsrd1wBvw7YaXHztL/N+H0qemHXjvN0/PhFG
         qRjpPbZAsYHx5Y68ysz6l0v9guCBe/ApO/3NQmsGRdAI7fsltmF6figwW0QCfyBzUtsL
         VKC6cSVplHPZzWe056WDhVBKkEqJ+9IDBqZpayQSSwFa7EIlHkHQIwOu3HjrG6rpRFfA
         OLHQ==
X-Gm-Message-State: APjAAAVYR9Ld45rNtvDHSzNB5YYFGH6yR1Mdl/VPwC3UgMMI3AuEHVO7
        EgmecaPi/QVEYqIQ/iZ9shykGNACM5D2l9xh5ZF2QnMJ
X-Google-Smtp-Source: APXvYqy70SsUjoYiUVpnHDEy2rjlLPhOO4kwSxJXoIqnTOLmTqH8ik5f+3V4sa/1uDzyb0En521XO1kijR4HgNI3kqI=
X-Received: by 2002:ac8:2aaf:: with SMTP id b44mr32435987qta.359.1570473414763;
 Mon, 07 Oct 2019 11:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
In-Reply-To: <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Mon, 7 Oct 2019 11:36:43 -0700
Message-ID: <CA+8MBb+VKk0aQZaJ+tMbFV7+s37HrQ6pzy4sHDAA3yqS-3nVwA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 7, 2019 at 11:28 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Oct 6, 2019 at 8:11 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > >
> > > The last two should just do user_access_begin()/user_access_end()
> > > instead of access_ok().  __copy_to_user_inatomic() has very few callers as well:
> >
> > Yeah, good points.
>
> Looking at it some more this morning, I think it's actually pretty painful.

Late to this party ,,, but my ia64 console today is full of:

irqbalance(5244): unaligned access to 0x2000000800042f9b, ip=0xa0000001002fef90
irqbalance(5244): unaligned access to 0x2000000800042fbb, ip=0xa0000001002fef90
irqbalance(5244): unaligned access to 0x2000000800042fdb, ip=0xa0000001002fef90
irqbalance(5244): unaligned access to 0x2000000800042ffb, ip=0xa0000001002fef90
irqbalance(5244): unaligned access to 0x200000080004301b, ip=0xa0000001002fef90
ia64_handle_unaligned: 95 callbacks suppressed
irqbalance(5244): unaligned access to 0x2000000800042f9b, ip=0xa0000001002fef90
irqbalance(5244): unaligned access to 0x2000000800042fbb, ip=0xa0000001002fef90
irqbalance(5244): unaligned access to 0x2000000800042fdb, ip=0xa0000001002fef90
irqbalance(5244): unaligned access to 0x2000000800042ffb, ip=0xa0000001002fef90
irqbalance(5244): unaligned access to 0x200000080004301b, ip=0xa0000001002fef90
ia64_handle_unaligned: 95 callbacks suppressed

Those ip's point into filldir64()

-Tony
