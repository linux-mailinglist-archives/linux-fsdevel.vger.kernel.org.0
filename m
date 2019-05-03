Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11391270D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 07:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfECFSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 01:18:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41210 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfECFSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 01:18:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id g8so4248225otl.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 22:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcYMhvle0qn3Vbr1jw5wZlfwobq39YCNyqpLb7cb7Ao=;
        b=vMgoD4BZW5GJfaQp5wHB4n5Uh0dHYfDvtMT6no12+p0edzsKljaBNtH2QSDc0E6VzT
         LcuVJrv7cdGqX7U8FfKi5bagOC/nhHdsiKYsGPft1mReUq108TVFisXe9TJrijP3ncN9
         v39q83CXeT5lkt4WLd/fwqU8g5riscYutv4Dl0z3LH4QLnkrqcMdMPzrzbEAqplHU0Uu
         m3PA8EGRjwXV1jBeELzeCCKDGehqdroKwQf1lX98y7iQ89oh7pPsirzbD3JpTdCcD6Pl
         9jznQM6AV2RqS1bTQE7nMwTk67da6P41iEI1afzG3TYud6oBdVc8/EIcpi2ctCF9A2Zz
         QXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcYMhvle0qn3Vbr1jw5wZlfwobq39YCNyqpLb7cb7Ao=;
        b=pyz4YezdR8KlcXOz1pqxsA8+Cdn9KU/4d/6lpjeKoW28i5bVC7r7oMe8tKhZG1DRVo
         x1MipuShITD7a7cGfZQukH4ue3qE67FmGvDVOdZhQnt9pFStpdwu7yYFNeQ/ZPYv6CRw
         Aftb2ko6KnCP3Iee5TqsaJcLkYWOFkEtUyHBnPmpOfcV48l57lZO3gsfRtNrJHycdfAc
         2r+BhsLCENB9/PE49Zp4E2WxKaJ21byNhg2sFqViPiII5hbKH8avScUqvyoLIpHAER6z
         i4Tj/2dEmkTb/4d8Wzek7IYdSW6yuFMJcBMLbITbP49YnvbBdCNXtFG2i+NN+mo2lt/q
         ERHA==
X-Gm-Message-State: APjAAAUW9RpGFHSz/54Ie4Yd5RCOJNCNL7YiGOaUZ8/yACYZtA5mkAVu
        hNg6aNT5haAn8Gc/kn+zoPZ++he8KULsbU5WT8pAaA==
X-Google-Smtp-Source: APXvYqyA2rSR/zhocpuvfAEjnR+/hEY11wb5Z34WyJg2tb2IGWD/sjsI629/w4anWfW9OX32ft4Cf8TKrI7DL3H8Uik=
X-Received: by 2002:a05:6830:204a:: with SMTP id f10mr4960513otp.83.1556860714114;
 Thu, 02 May 2019 22:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-8-brendanhiggins@google.com> <d4934565-9b41-880e-3bbe-984224b50fac@kernel.org>
In-Reply-To: <d4934565-9b41-880e-3bbe-984224b50fac@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 2 May 2019 22:18:22 -0700
Message-ID: <CAFd5g44ex8B71K78V7-kRqcRw18Jou_c0KFtTR7wBpArw+P+MQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] kunit: test: add initial tests
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 6:27 PM shuah <shuah@kernel.org> wrote:
>
> On 5/1/19 5:01 PM, Brendan Higgins wrote:
> > Add a test for string stream along with a simpler example.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >   kunit/Kconfig              | 12 ++++++
> >   kunit/Makefile             |  4 ++
> >   kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
> >   kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
> >   4 files changed, 165 insertions(+)
> >   create mode 100644 kunit/example-test.c
> >   create mode 100644 kunit/string-stream-test.c
> >
> > diff --git a/kunit/Kconfig b/kunit/Kconfig
> > index 64480092b2c24..5cb500355c873 100644
> > --- a/kunit/Kconfig
> > +++ b/kunit/Kconfig
> > @@ -13,4 +13,16 @@ config KUNIT
> >         special hardware. For more information, please see
> >         Documentation/kunit/
> >
> > +config KUNIT_TEST
> > +     bool "KUnit test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables KUnit test to test KUnit.
> > +
>
> Please add a bit more information on what this config option
> does. Why should user care to enable it?
>
> > +config KUNIT_EXAMPLE_TEST
> > +     bool "Example test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables example KUnit test to demo features of KUnit.
> > +
>
> Same here.

Sounds reasonable. Will fix in the next revision.

< snip >

Thanks!
