Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300228B1DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHMH7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 03:59:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37045 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfHMH7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:59:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id bj8so1936027plb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5R0Mn+kXy6miNBPjF2nukdlARFsEwajrrqyvCbZs0pA=;
        b=ElNxu9XWCw3bi/ATpZFZYjmD1lNIywxKKFS5/SHJ+NwUixjR7oQpJwrCG6C82nHfPy
         YE8W4U4AeTrAMqQ2pXMKDLv0qv25tWwlR4csBdCEP98WPeUFvsBeDL1m4hdGu9A+ggXq
         rIp38mmbymsY1BBKpvxm+hERpjOI6axxwbcZj1V8AikaF+Z1aQ1dWRUa9wjwGG01d9h8
         sKGT9tDrSb5EvJwPrCnDwx2/CHTHsgoyEks8OTr6XOvgVMfyBNDjqNOfEiBRGJ6z8hZW
         ZIB+cqqvARstSDttQQKSBm5mxEfD8wl+hAodt9NBsSLUg9+gEPC8zU5ZICyW930HwyEc
         VCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5R0Mn+kXy6miNBPjF2nukdlARFsEwajrrqyvCbZs0pA=;
        b=QjQDF6VvVSRwCiKHxCYyyG73ymLgUkqva3nzY/QAgtmxJ3PG3tp0YuRmvA9qUtjLYV
         EN54aY38ffgNDmhYJiGvono9xIA0CzwBwF4MO6VXA4eUp2q9PZOVvp3tIxG6Ik6vVtpG
         o4+Znk1XMH602t+DRZP/75s6eQa3JEoWgcAOph09zeFccatH3mV1tMl/Ht7fphXT21+i
         U3+2SKYWc2NH8hUELs3ocEePB3mCoDQJMTcZWclemHO3JLklwquCmvgUb/nZX1FVrI5b
         x8tDARtEhbF7/3eohrRb/ChlIXXLPV+JQH5QPUKxmp/qZ5GvDfPK2dpqa2sFRAFmbEhM
         56xg==
X-Gm-Message-State: APjAAAXvQmHvP4mt5nqZ90n7DeDt3potkFy4R0/Zdq99TBkPDAW5gDj5
        f1Qpvr1Mr9RQimP2qeqbIZJtMEFWkhXaYcqHycJP3w==
X-Google-Smtp-Source: APXvYqyvbUK5kDHossVyHcMfS13gJpm82JS1lGa4QkU7lNSWK1exa+MkZF0H451Y+v9ozGPzr6jJly+0fJd6rna7v9Y=
X-Received: by 2002:a17:902:169:: with SMTP id 96mr23827974plb.297.1565683169131;
 Tue, 13 Aug 2019 00:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-15-brendanhiggins@google.com> <20190813043859.661F82054F@mail.kernel.org>
In-Reply-To: <20190813043859.661F82054F@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 13 Aug 2019 00:59:18 -0700
Message-ID: <CAFd5g44wUOhmxr3r+-LR_igePMjtaRrtT5jGdqPJgb0xPdf+Ag@mail.gmail.com>
Subject: Re: [PATCH v12 14/18] kunit: defconfig: add defconfigs for building
 KUnit tests
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 9:39 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 11:24:17)
> > diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
> > new file mode 100644
> > index 0000000000000..bfe49689038f1
> > --- /dev/null
> > +++ b/arch/um/configs/kunit_defconfig
> > @@ -0,0 +1,8 @@
> > +CONFIG_OF=y
> > +CONFIG_OF_UNITTEST=y
> > +CONFIG_OF_OVERLAY=y
> > +CONFIG_I2C=y
> > +CONFIG_I2C_MUX=y
> > +CONFIG_KUNIT=y
> > +CONFIG_KUNIT_TEST=y
> > +CONFIG_KUNIT_EXAMPLE_TEST=y
> > diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> > new file mode 100644
> > index 0000000000000..bfe49689038f1
> > --- /dev/null
> > +++ b/tools/testing/kunit/configs/all_tests.config
> > @@ -0,0 +1,8 @@
> > +CONFIG_OF=y
> > +CONFIG_OF_UNITTEST=y
> > +CONFIG_OF_OVERLAY=y
> > +CONFIG_I2C=y
> > +CONFIG_I2C_MUX=y
>
> Are these above config options necessary? I don't think they're part of
> the patch series anymore so it looks odd to enable the OF unittests and
> i2c configs.

Oh whoops, I forgot that we dropped the OF_UNITTEST from this
patchset. Will fix.

> > +CONFIG_KUNIT=y
> > +CONFIG_KUNIT_TEST=y
> > +CONFIG_KUNIT_EXAMPLE_TEST=y
