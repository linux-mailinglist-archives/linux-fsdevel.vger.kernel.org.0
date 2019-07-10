Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A064316
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfGJHu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 03:50:28 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:39969 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGJHu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:50:28 -0400
X-Greylist: delayed 13803 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 03:50:26 EDT
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x6A7o7gU011246;
        Wed, 10 Jul 2019 16:50:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x6A7o7gU011246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562745009;
        bh=PI9vAU5DZ4pm8uk/LZDalZiWfwOYBnqaRPHYLckDX4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2ywnhCcubslCMSbok4IBv2KIwYYqycUeH9Fwg0llimITGc4zPiTGerLyfmaMQrNV5
         rDxkdY495X8MVqN2HoEjSorCUfBBBQ7t93zy9AyUGZYED22v6iTckBKJuCI6FNAqRE
         tP4PPd+lv/bd1r26mSgrjzCY8RGygqLA+N/rpizoOwd+oXgO6D1ac17Wi4qejEN0sI
         qZcj6ydHehdgIIL196Wa+DhvxponFcCP9CtvEpW18hBIKnecNcuPyM1IxZtTOb+mfK
         nWSzNS9p3dARp+57OVA40vl4ErUur84kMHuZc2i+Y9RzbA6iRZ/U/yBk/QmiJP+1XL
         DZ/QsXKwdQ3tQ==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id y16so913078vsc.3;
        Wed, 10 Jul 2019 00:50:08 -0700 (PDT)
X-Gm-Message-State: APjAAAXq6Zfo/bl5Ax8s/9oCZ9uPl/2nn3UCzTanTDXMnQORu4rwNUca
        7tj9tSWWDsp62yjCzfYluzlfl/vF3W63GylhW8I=
X-Google-Smtp-Source: APXvYqw2lrh+5DK/jJwMNeRrzarB0aSECJBPOWsWFIa2/e5Dx+WrHYOuiqBpjnzOBa000Fw4cKQimfq9Auvs/nIayt0=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr17019011vsd.215.1562745007249;
 Wed, 10 Jul 2019 00:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com> <20190710071508.173491-7-brendanhiggins@google.com>
In-Reply-To: <20190710071508.173491-7-brendanhiggins@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Jul 2019 16:49:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASywq+RhEisuPbqOjFoBh7WNvMEgy55iacizrgNB-uBfA@mail.gmail.com>
Message-ID: <CAK7LNASywq+RhEisuPbqOjFoBh7WNvMEgy55iacizrgNB-uBfA@mail.gmail.com>
Subject: Re: [PATCH v8 06/18] kbuild: enable building KUnit
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

On Wed, Jul 10, 2019 at 4:16 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> KUnit is a new unit testing framework for the kernel and when used is
> built into the kernel as a part of it. Add KUnit to the root Kconfig and
> Makefile to allow it to be actually built.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Please feel free to replace this with:

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> Cc: Michal Marek <michal.lkml@markovi.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>



-- 
Best Regards
Masahiro Yamada
