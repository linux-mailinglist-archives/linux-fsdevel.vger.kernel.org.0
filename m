Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D932063FC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 06:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfGJEAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 00:00:25 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:63681 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfGJEAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 00:00:25 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x6A407t3006697;
        Wed, 10 Jul 2019 13:00:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x6A407t3006697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562731208;
        bh=KknRHaSkhBMpTs1BmzD59wJGTvSH88jZgscNwiE3MlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zcv8Y/m8P8X292YdVCGzvjt8eh3zKthkL/tKU8hgl0+kZFK/TCidt2YnUJeXwRY2C
         53gnnvfR1V5a/tZ3oft3dU87Wv/na0I6Cs7CUbLYQQ/tTgfsks7h1YrnLQlPvFedYE
         CUXVrkPfqD5VgYstJJ7CydXBopsxsIxYrwFsxgwx6d60uk5NaU0HmmUFrWcRa0Ma+X
         JP4vrMHlCl+oWvWoNYTtWzS8BRJaI99Vvewq8PDOryzMVp2NXYrBOU+OgPSCXtaQVR
         iBpoKf4mR5G2BIwMVbOsyg7IXjsTJdhgiZepcEUeuFghjpTnMBJ19Lf/0+rRb7AENC
         me1vWrlscZvww==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id m8so625105vsj.0;
        Tue, 09 Jul 2019 21:00:08 -0700 (PDT)
X-Gm-Message-State: APjAAAUOzUg7dewpDpaEaEwdms+J+YjUAAAn+8Q5wRx/H0vBF2T/33CF
        O4/8l42f2KO7ypeZySrTpPfE7/o10ZbDtcOBLrA=
X-Google-Smtp-Source: APXvYqzEJesQV2n3K1HZLU8Wx1IHWCC1QIw58D6BP7vlVU/X0PRT9+zSoni+Ubl8ut/dwkZUzYEjYnFrduUZ0sj9y38=
X-Received: by 2002:a67:f495:: with SMTP id o21mr16708917vsn.54.1562731207027;
 Tue, 09 Jul 2019 21:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com> <20190709063023.251446-7-brendanhiggins@google.com>
In-Reply-To: <20190709063023.251446-7-brendanhiggins@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Jul 2019 12:59:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATx30AhZ51xozde=nO06-8UzuC0M9nfZXrqkyfmEFdu5w@mail.gmail.com>
Message-ID: <CAK7LNATx30AhZ51xozde=nO06-8UzuC0M9nfZXrqkyfmEFdu5w@mail.gmail.com>
Subject: Re: [PATCH v7 06/18] kbuild: enable building KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
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

On Tue, Jul 9, 2019 at 3:34 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> KUnit is a new unit testing framework for the kernel and when used is
> built into the kernel as a part of it. Add KUnit to the root Kconfig and
> Makefile to allow it to be actually built.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  Kconfig  | 2 ++
>  Makefile | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Kconfig b/Kconfig
> index 48a80beab6853..10428501edb78 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -30,3 +30,5 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>
>  source "lib/Kconfig.debug"
> +
> +source "kunit/Kconfig"
> diff --git a/Makefile b/Makefile
> index 3e4868a6498b2..60cf4f0813e0d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -991,7 +991,7 @@ endif
>  PHONY += prepare0
>
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> +core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
>
>  vmlinux-dirs   := $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
>                      $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> --
> 2.22.0.410.gd8fdbe21b5-goog


This is so trivial, and do not need to get ack from me.

Just a nit.


When CONFIG_KUNIT is disable, is there any point in descending into kunit/ ?

core-$(CONFIG_KUNIT) += kunit/

... might be useful to skip kunit/ entirely.

If you look at the top-level Makefile, some entries are doing this:


init-y          := init/
drivers-y       := drivers/ sound/
drivers-$(CONFIG_SAMPLES) += samples/
drivers-$(CONFIG_KERNEL_HEADER_TEST) += include/
net-y           := net/
libs-y          := lib/
core-y          := usr/





--
Best Regards
Masahiro Yamada
