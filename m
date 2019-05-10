Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE719BB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEJKeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 06:34:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36234 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfEJKeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 06:34:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so4186227oia.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5i4JvNF6NE98fRMKxmZ6W6+U1GIOfAXdGdvVU9jpjk=;
        b=nGd+cWkGzEXpGtZkuP9oYYd4GvoVDkXbYEKFNyvJGe431T1PPUpkS/xcdVyU93/oC+
         iOY/sgkoPSzzreHzKz9kgEHxhJHg1jJT8nh/GBB77UaWYZ2cmcii9Cf0IBR0PkuXrFU2
         X2zcaWr/4tLTgZ0RLrGMyhMI1p7cfpR2FessPvThJmqe71Qb5xQZDjgKunaL0C5W2w2E
         x4thQ7WxDuTbLul4U5kX4SSYFL36trckMOrHWRhsmbpzjo17LECFKM9VLEYLBlSkUN9W
         WbwCW0njc6inKI9wGkqJbW4iWV889QBYK+bjWkcnAcu6ZIOkfieUOoCuotJ9MJZnAWKM
         Rhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5i4JvNF6NE98fRMKxmZ6W6+U1GIOfAXdGdvVU9jpjk=;
        b=X0txRscCERpu+9P+V8FCeiJyvH2Q0/vFfwHUVpp+atvX3ApQ9wHJHzWeM2D+X/MAWR
         GUBF4PzrWL+dJ35FJ0uCjZex2rpJ0z0Z78vyMjmVHJn4wQFh4ZZbTmhY9sNBDfZcsjEH
         7mioC3zmw9eAeTP4MSn4xygwom8QBRqlM2TXM6r+f4kv23J2M+at/R3EMrRFzo7No982
         CRSMCRQuatHAgnv6gkqgPKmHsGsMatAyFoNtB2DcX37JEBZWKTm/g3nQJa2AnH+TmTZe
         OB8+YORnEXdv+TLaWe4ewirvf66j2JU6EK4QVLdbLkHneWXzxbSVxQ+oqtVd9oLXn0bp
         OajQ==
X-Gm-Message-State: APjAAAVeYxdeNyyAPMT0vszlBHXIOyqiY4Ztm5r2Wnky4JX8Pz1NLLv1
        T/K5NK73t9Ivg57RGCkeeCiJiu745OIEQWfAJ2TDSw==
X-Google-Smtp-Source: APXvYqw3UEwomNcXxGCJaZ//T6xFRuS5gGaGa2izLjE212DrWEolETcTjMzpUq+WB1E+1p0WPdjF9j5Z9zciCUj1NAM=
X-Received: by 2002:aca:43d5:: with SMTP id q204mr4754067oia.100.1557484443394;
 Fri, 10 May 2019 03:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-7-brendanhiggins@google.com> <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
 <CAFd5g47BNZ0gRz4SXb37XjyXF_LyNZrSmoqDbzaaCUrTg3O7Yg@mail.gmail.com> <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
In-Reply-To: <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 10 May 2019 03:33:52 -0700
Message-ID: <CAFd5g46dE78f3bx33Sv-CPNx9i8VV=v0Ezwytp8eiQU1MzWbbQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] kbuild: enable building KUnit
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Cc: Shuah Khan" <shuah@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Tim Bird <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Fri, May 10, 2019 at 7:27 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > > On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > Add KUnit to root Kconfig and Makefile allowing it to actually be built.
> > > >
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > >
> > > You need to make sure
> > > to not break git-bisect'abililty.
> > >
> > >
> > > With this commit, I see build error.
> > >
> > >   CC      kunit/test.o
> > > kunit/test.c:11:10: fatal error: os.h: No such file or directory
> > >  #include <os.h>
> > >           ^~~~~~
> > > compilation terminated.
> > > make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
> > > make: *** [Makefile;1763: kunit/] Error 2
> >
> > Nice catch! That header shouldn't even be in there.
> >
> > Sorry about that. I will have it fixed in the next revision.
>
>
> BTW, I applied whole of this series
> to my kernel.org repository.
>
> 0day bot started to report issues.
> I hope several reports reached you,
> and they are useful to fix your code.

Yep, I have received several. They are very helpful.

I greatly appreciate it.

Thanks!
