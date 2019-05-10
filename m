Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A119BAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfEJKbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 06:31:18 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:61229 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEJKbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 06:31:18 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x4AAV0nX025786;
        Fri, 10 May 2019 19:31:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x4AAV0nX025786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557484261;
        bh=3yJH+cglIjNQq6vK0eeyN++1KXd8VHZRN7FQJbPltS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QtaJmXuQJy7hctD/ahVAN5XPHN224n6/gqws6nJ/VotVw6eA+8vTJU3kSagTwyS1q
         DGlLyHog02uWurOxIIxKgcK7nayyO+bQha19Z/412N0ccdltUzKhcnlvU54r3rL2ZF
         /7yd3DaXEV3ThV74ZGgPMcATUIr2d8phlFXtq9OT03ColTy+eKxoiuz5y1uKzLvpMZ
         ALUOCKcCEOwtobtUg0Fk/k9pSf7fatmDB/w+cjz1n7pCZUkVL0J76Ro+TKCQTrlXnb
         Xi83Kavt+o++04Nbfu9iLvu2nvO+HmNfTEUZUgWP/kFkOPfZVl7zyvl75HUdzL9IoH
         xywoa2weFn44A==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id d128so3311706vsc.10;
        Fri, 10 May 2019 03:31:01 -0700 (PDT)
X-Gm-Message-State: APjAAAXAtq4hLI7cHC/L5E2Mt7UahArg08a1UXZYvwt9dkkw4ZCcR3QR
        XIzWfFmpO3xGvqSjUXI2sh4f1gSH31yf+4Diy3U=
X-Google-Smtp-Source: APXvYqxQg+YuYHeAdyD+cmoEqdlV9x3SqXv2NvZ+DbME3bD71rpckfASo32QB3ghErivNtiJLmZIR4uDTrUdlUap+zw=
X-Received: by 2002:a67:f109:: with SMTP id n9mr5064876vsk.181.1557484260150;
 Fri, 10 May 2019 03:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-7-brendanhiggins@google.com> <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
 <CAFd5g47BNZ0gRz4SXb37XjyXF_LyNZrSmoqDbzaaCUrTg3O7Yg@mail.gmail.com>
In-Reply-To: <CAFd5g47BNZ0gRz4SXb37XjyXF_LyNZrSmoqDbzaaCUrTg3O7Yg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 May 2019 19:30:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
Message-ID: <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] kbuild: enable building KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
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

On Fri, May 10, 2019 at 7:27 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> > On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Add KUnit to root Kconfig and Makefile allowing it to actually be built.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > You need to make sure
> > to not break git-bisect'abililty.
> >
> >
> > With this commit, I see build error.
> >
> >   CC      kunit/test.o
> > kunit/test.c:11:10: fatal error: os.h: No such file or directory
> >  #include <os.h>
> >           ^~~~~~
> > compilation terminated.
> > make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
> > make: *** [Makefile;1763: kunit/] Error 2
>
> Nice catch! That header shouldn't even be in there.
>
> Sorry about that. I will have it fixed in the next revision.


BTW, I applied whole of this series
to my kernel.org repository.

0day bot started to report issues.
I hope several reports reached you,
and they are useful to fix your code.


-- 
Best Regards
Masahiro Yamada
