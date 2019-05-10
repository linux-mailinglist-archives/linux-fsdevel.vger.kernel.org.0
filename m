Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25764196EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 05:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfEJDEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 23:04:46 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48677 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfEJDEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 23:04:45 -0400
X-Greylist: delayed 42282 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2019 23:04:43 EDT
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x4A34XGX005393;
        Fri, 10 May 2019 12:04:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x4A34XGX005393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557457474;
        bh=DYJ0GRwyv9LQw+wYut+AKlESUHW5OcD/mZsMQ0v23g4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jupzuktqIfQz0vJS1GaSpRqu2LQlIojIZ6l/TI0jmjH+y1VkJRBs89e7uRAv6B1Ef
         uHXWjQCyh3QM1FLLkbOfmNDmcIDMv3Oq/FlPK1nJiwjkiN5C9tudnBuh0F8evz5qm8
         ZorME1HYwlKxsObBT8LwUNg5l1Fi86fQ7ffUtVkUvXf1TvrufFpYms99rIymu6dL/K
         hIlycbAJXfNN986oEc9iUdGhQ9gZ5CSC7yKV9BeU183dZd8/MJ0EQhq+4AgJe2J6jP
         TyF0SLqvX8D3dQhEIQDaNOjnh/QC3NF0r7D48IC/P5jvWFHuMVUbINwaFq0DbE19/a
         SQYZWBc5p+oIQ==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id r195so1138772vke.0;
        Thu, 09 May 2019 20:04:34 -0700 (PDT)
X-Gm-Message-State: APjAAAXPoLeBAjMKgvMs+7lHCRTpm9Hq0dTQmmpAFWkoH4tUhr5WR/3F
        J7W+aIcHDbWUKKSwAH8vslzCIpnSnNqVTr2rDMc=
X-Google-Smtp-Source: APXvYqy2m1+g4N+7CIk2iyVkz9i+viWE9nsO8OqKDhs3ADzAs5NWYmvIdraov4KIA0ibHwe/v+Jg8QmbzOy0PS2UyFc=
X-Received: by 2002:a1f:d585:: with SMTP id m127mr3859437vkg.34.1557457473272;
 Thu, 09 May 2019 20:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com> <20190501230126.229218-7-brendanhiggins@google.com>
In-Reply-To: <20190501230126.229218-7-brendanhiggins@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 May 2019 12:03:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
Message-ID: <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] kbuild: enable building KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        kieran.bingham@ideasonboard.com,
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
        <linux-kselftest@vger.kernel.org>, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim Bird <Tim.Bird@sony.com>, amir73il@gmail.com,
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
        Richard Weinberger <richard@nod.at>, rientjes@google.com,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add KUnit to root Kconfig and Makefile allowing it to actually be built.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

You need to make sure
to not break git-bisect'abililty.


With this commit, I see build error.

  CC      kunit/test.o
kunit/test.c:11:10: fatal error: os.h: No such file or directory
 #include <os.h>
          ^~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
make: *** [Makefile;1763: kunit/] Error 2








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
> index 2b99679148dc7..77368f498d84c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -969,7 +969,7 @@ endif
>  PHONY += prepare0
>
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> +core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
>
>  vmlinux-dirs   := $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
>                      $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> --
> 2.21.0.593.g511ec345e18-goog
>


-- 
Best Regards
Masahiro Yamada
