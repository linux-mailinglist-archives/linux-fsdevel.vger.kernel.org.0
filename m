Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382CEB9AF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404978AbfITXw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:52:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44977 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392750AbfITXw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:52:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id q15so3912379pll.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eg0Go6Vco6zmrMokIuCHT90eNcEj+1gkgwUozbRoOU=;
        b=C3ZFMMtvPf81TgLhiSeEgf2YDVeBRSaHW0FNEf+k4vFeia1DmItLwfEBHoOIfODtlF
         gEyN20SdH4KLHWwmhavoas54tR7qUqGUNdwwesdSM+wK3SyllrG5IxRh96WXtnnrfY7d
         pWKppGT1A1o2nr1VJ5fMakqYDf8QR5Hd9B9Tr6251H/ZqxARqyg4FG/IYVzwg6lZHgw9
         KjiL/8lm/frPH5jhCZqRRWZnbSsN2mWbWgq5azfITpuYNj1mNqmc8FRarPSRhSul8KEc
         RmmD1CROxNKOEtIbX+4Fprl/YK9aZC0HXh6DiK9VVU/3W0qEmA2PmqxFFb9ET+vFYLUq
         AVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eg0Go6Vco6zmrMokIuCHT90eNcEj+1gkgwUozbRoOU=;
        b=cf29gu1HX6rx/Td2UK87u8UNYRb2QLmdaUECJeoM0mYqHatbXfwPy35Iupppl3mHRC
         kjYrBtbrgwBh8jMAsRBWjDJgk8SPTfwpvcNo9jS5rMFofP8+6anyU2OVl9ntUN0+0hF1
         XSFvsFf1yl3vEOEsPMnK1z8ZDpaXZIxkh3SJ3GDym5N1B1+wNYu/kn8yV+FiCtulC0qx
         LSjCyH+jcZJlfUFJl/CCkm7JPdHwqSTfze82SwhyYjYAXrkTNiDlXvhaTiJtvow8dAn2
         kuY5pRVhn/sJQV4tsCMZEOAIp18cXFFuFAUnldRlkK6WVQgvhP2Um0a2OlmlfnSop6el
         pbQg==
X-Gm-Message-State: APjAAAX3igiCnNEsmGHc1UpOlt/4b7y9+qvZcZXSrBeW0I98uPK0CE98
        cddy68NcVEYrnuvbAUtzE2l9qzve5+cMxDMFIY7pHg==
X-Google-Smtp-Source: APXvYqxVNfOs4Ho/5kXpPZVj8oP5ezLhr8UaD2UCudmwUKwPDFfSFY4+sFjwQIeK+urY5OGR284WgAH5zN0eWfy9OQU=
X-Received: by 2002:a17:902:169:: with SMTP id 96mr18912291plb.297.1569023545999;
 Fri, 20 Sep 2019 16:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
 <20190920231923.141900-7-brendanhiggins@google.com> <20190920233600.48BBA20644@mail.kernel.org>
 <CAFd5g46pndA_gOD9i8M5e5fb8x4mSL9mcgMDujN7XufeFs8bmQ@mail.gmail.com>
In-Reply-To: <CAFd5g46pndA_gOD9i8M5e5fb8x4mSL9mcgMDujN7XufeFs8bmQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 20 Sep 2019 16:52:14 -0700
Message-ID: <CAFd5g44E9Z=wRLarzcirAMudQ5=_3d4gnYfAwM9T2XB+sr+_qg@mail.gmail.com>
Subject: Re: [PATCH v16 06/19] lib: enable building KUnit in lib/
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 20, 2019 at 4:44 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Sep 20, 2019 at 4:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-09-20 16:19:10)
> > > KUnit is a new unit testing framework for the kernel and when used is
> > > built into the kernel as a part of it. Add KUnit to the lib Kconfig and
> > > Makefile to allow it to be actually built.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > ---
> > >  lib/Kconfig.debug | 2 ++
> > >  lib/Makefile      | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 5960e2980a8a..5870fbe11e9b 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -2144,4 +2144,6 @@ config IO_STRICT_DEVMEM
> > >
> > >  source "arch/$(SRCARCH)/Kconfig.debug"
> > >
> > > +source "lib/kunit/Kconfig"
> > > +
> >
> > Perhaps this should go by the "Runtime Testing" part? Before or after.

Now I am actually thinking that it should be a menuconfig...

> > >  endmenu # Kernel hacking
