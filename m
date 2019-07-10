Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 899816427B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGJHTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 03:19:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39112 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJHTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:19:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so777477pgi.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfz7M1UfeMHHXZWoXYgXDdb2h4DdykfBMsEUwpNEPMQ=;
        b=l6WF16GVYe5eCc/5x8O8KdIpdGxyu4cFn2VT370ERVLkliFZoRrSfvp79LhBQiNSIN
         Fc3VEBYfnK22TfTFupWFCOy7wIIOmCBSmWzp151VVHjXiu08YEAd1cUyMwfMhn+dU/bF
         UHlZhZc0wk0wQTnNlXcS52uWXZ0GmfQuDPOS9e4OHx48QXa6/or/tZHQSVGwKXE40j8J
         tydITPKv4HnEgptGj8+2KN4wvn2CgD7bTL5YD2VkAUKcTMoyzgx29qn2jFdugUlBv9P8
         +GIsXjY1xdI2IPhRGGizyMRas0HBWbQ4T3n7MZP9ykXTcG22rpDfaxe6v7izwrk4jBVj
         l8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfz7M1UfeMHHXZWoXYgXDdb2h4DdykfBMsEUwpNEPMQ=;
        b=gw7g16E8jzXunjnMhOnufDvFhzu3F2Lf3OPglYqWEpxQmvE1XI/l4CzzjfwM9rwhWH
         YfP2frZk6cb0Us3+jB/v/3yUXsM1S9DMsjQXTz7pFhyGhQiN7hZCDBRSbcUQiYVz+2hx
         MsmFAdAZrN+qmZ/aH4Klm+mcQ8ELlL+fxs/9kZ5N4V0mZEjbPizAItogH4Cp9tByrMMF
         5d+nXlM3xO+yuy9G8qSIclWvLYdC6SfOH8hULJrezd2oCtDndv/A+DsdQYbD4+Yj3p0j
         Gme7yqG3NnSLFskPGgDFWj9GsWeKpmACdrFqqhKmxv7mW/M+d9iscn95PhDAcD1sT/UX
         z76w==
X-Gm-Message-State: APjAAAVzUKScfh6YesRzyny3L1M5qT1cNwBIY/8oT0i9IxtndE6uCxtI
        qNFDhWSnri1oRRQ+v2gECX5yFEg6L7WycY2FYxmn4A==
X-Google-Smtp-Source: APXvYqxygjuZUTtP3o1i+spSO/ODX76iUOPUnBSEPfKtnKohaqyGP7q59QAPXICI+tZgCfUcyvNAo+y5G+f5zV4sog8=
X-Received: by 2002:a17:90a:ab0d:: with SMTP id m13mr4975325pjq.84.1562743158492;
 Wed, 10 Jul 2019 00:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-7-brendanhiggins@google.com> <CAK7LNATx30AhZ51xozde=nO06-8UzuC0M9nfZXrqkyfmEFdu5w@mail.gmail.com>
In-Reply-To: <CAK7LNATx30AhZ51xozde=nO06-8UzuC0M9nfZXrqkyfmEFdu5w@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 10 Jul 2019 00:19:06 -0700
Message-ID: <CAFd5g479H3pS9preU6-oCnN5adwBPDe4zQkiFPatKPbxpT5r6w@mail.gmail.com>
Subject: Re: [PATCH v7 06/18] kbuild: enable building KUnit
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Cc: Shuah Khan" <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, DTML <devicetree@vger.kernel.org>,
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
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 9, 2019 at 9:00 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Jul 9, 2019 at 3:34 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > KUnit is a new unit testing framework for the kernel and when used is
> > built into the kernel as a part of it. Add KUnit to the root Kconfig and
> > Makefile to allow it to be actually built.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> >  Kconfig  | 2 ++
> >  Makefile | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Kconfig b/Kconfig
> > index 48a80beab6853..10428501edb78 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -30,3 +30,5 @@ source "crypto/Kconfig"
> >  source "lib/Kconfig"
> >
> >  source "lib/Kconfig.debug"
> > +
> > +source "kunit/Kconfig"
> > diff --git a/Makefile b/Makefile
> > index 3e4868a6498b2..60cf4f0813e0d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -991,7 +991,7 @@ endif
> >  PHONY += prepare0
> >
> >  ifeq ($(KBUILD_EXTMOD),)
> > -core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> > +core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
> >
> >  vmlinux-dirs   := $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
> >                      $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
>
>
> This is so trivial, and do not need to get ack from me.

Oh, sorry about that.

> Just a nit.
>
>
> When CONFIG_KUNIT is disable, is there any point in descending into kunit/ ?
>
> core-$(CONFIG_KUNIT) += kunit/
>
> ... might be useful to skip kunit/ entirely.

Makes sense. I just sent out a new change that does this.

Thanks!

> If you look at the top-level Makefile, some entries are doing this:
>
>
> init-y          := init/
> drivers-y       := drivers/ sound/
> drivers-$(CONFIG_SAMPLES) += samples/
> drivers-$(CONFIG_KERNEL_HEADER_TEST) += include/
> net-y           := net/
> libs-y          := lib/
> core-y          := usr/
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
