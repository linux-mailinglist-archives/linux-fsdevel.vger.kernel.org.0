Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565E85D9F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 02:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfGCA6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 20:58:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39114 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfGCA6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:58:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so599484oig.6;
        Tue, 02 Jul 2019 17:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DtQmDM1bjxYXcqNKxDIhe3kpTPPYxiOv+5lbfQfOZdE=;
        b=rdNe1uBrDpAhqLxbcDYjpTEaSwGuI+OGS7FawePaNtE4XaFxFX9LZRkySKagywu96E
         5elS2OlM2+9SQgOMAHfPsD14tq/9GPSsyXTBQ3v1vpiNeL6mut71AVMzDUmgoKvcaFjG
         ZkG0TM63qOs8T6VRpCXd6HLvZitCUOj8H6AqM607XGa9sNMZxcj5Tj3Dgs6HVZi8+ESR
         xkOnd3jnmRURIOnkuqQO34Ubry6C0J+SGZG6KYYpQEfIBOlBi11jTR0PdknRRl+Zli6X
         R2bK6l6wqZo8BNKUpi7f8TOuuWmeQSAPLRaOIjTworkSmjVLbbO8vJl2DBuaJCC4r6ZZ
         FONQ==
X-Gm-Message-State: APjAAAUu5rtSqVJRCWOmfmBKZQ6UUYSPd1ThQtxFvCoFJrs/jqDCbwzs
        OVV69Bmzj+Eqt4CMigJrY+ILGKuHCGs=
X-Google-Smtp-Source: APXvYqxgfIVc55JlioUk1yKtSLmO9ntomZUFE6/lH8QIzZr758B9lCLwgU+mAmopE2kMlm4WWSK35A==
X-Received: by 2002:a63:f342:: with SMTP id t2mr30570356pgj.83.1562101035558;
        Tue, 02 Jul 2019 13:57:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d26sm16963231pfn.29.2019.07.02.13.57.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 13:57:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DC91A40251; Tue,  2 Jul 2019 20:57:12 +0000 (UTC)
Date:   Tue, 2 Jul 2019 20:57:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
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
Subject: Re: [PATCH v5 07/18] kunit: test: add initial tests
Message-ID: <20190702205712.GS19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-8-brendanhiggins@google.com>
 <20190625232249.GS19023@42.do-not-panic.com>
 <CAFd5g46mnd=a0OqFCx0hOHX+DxW+5yA2LXH5Q0gEg8yUZK=4FA@mail.gmail.com>
 <CAFd5g46=7OQDREdLDTiMgVWq-Xj2zfOw8cRhPJEihSbO89MDyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46=7OQDREdLDTiMgVWq-Xj2zfOw8cRhPJEihSbO89MDyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 02, 2019 at 10:52:50AM -0700, Brendan Higgins wrote:
> On Wed, Jun 26, 2019 at 12:53 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Tue, Jun 25, 2019 at 4:22 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 01:26:02AM -0700, Brendan Higgins wrote:
> > > > diff --git a/kunit/example-test.c b/kunit/example-test.c
> > > > new file mode 100644
> > > > index 0000000000000..f44b8ece488bb
> > > > --- /dev/null
> > > > +++ b/kunit/example-test.c
> > >
> > > <-- snip -->
> > >
> > > > +/*
> > > > + * This defines a suite or grouping of tests.
> > > > + *
> > > > + * Test cases are defined as belonging to the suite by adding them to
> > > > + * `kunit_cases`.
> > > > + *
> > > > + * Often it is desirable to run some function which will set up things which
> > > > + * will be used by every test; this is accomplished with an `init` function
> > > > + * which runs before each test case is invoked. Similarly, an `exit` function
> > > > + * may be specified which runs after every test case and can be used to for
> > > > + * cleanup. For clarity, running tests in a test module would behave as follows:
> > > > + *
> > >
> > > To be clear this is not the kernel module init, but rather the kunit
> > > module init. I think using kmodule would make this clearer to a reader.
> >
> > Seems reasonable. Will fix in next revision.
> >
> > > > + * module.init(test);
> > > > + * module.test_case[0](test);
> > > > + * module.exit(test);
> > > > + * module.init(test);
> > > > + * module.test_case[1](test);
> > > > + * module.exit(test);
> > > > + * ...;
> > > > + */
> 
> Do you think it might be clearer yet to rename `struct kunit_module
> *module;` to `struct kunit_suite *suite;`?

Yes. Definitely. Or struct kunit_test. Up to you.

  Luis
