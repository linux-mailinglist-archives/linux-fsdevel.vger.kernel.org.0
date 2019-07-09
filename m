Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E6563A6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGISBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 14:01:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33654 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGISBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:01:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so4884616pfq.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2019 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUg57n/8w7Mlx4FSaThva6QRBMRQrC57aji70HqhlTs=;
        b=u9enlrUFhNo6CpHlrQV/HgMnM2prP/1x9AkLcEyZIZZ95VhPysZXNdVgTxFeHrQSyj
         D854QOHx1OOVg+bK1q0GL9M26yGnhrklGjHFU0YlePfBqyn8fol1vLU/0tJs5NO+XWNV
         6Qg4G47Yz8EAu+oXnFu1Mzex0KXUQSkc3dP89G7ycpwdK6vtjyVs4n/CA1F66BOgluWi
         cGrmqcEgZcaKnQ36vda5DA3xHSSM91ST4LQMohLGersiVfBM4MAAfBua5GuHtjmb28bv
         cNHp7EXFv/Be9TyDKlfByNT+SveMU7rOne9AoLQN+azT38ic+R4kxi1lUa+FZPUqI2ob
         eorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUg57n/8w7Mlx4FSaThva6QRBMRQrC57aji70HqhlTs=;
        b=NPsQzLETUCW4WKXwrUHarJncuMDeAY6QTrPbiXPGW+yW8leRg5uWid5ut35fkk3NSC
         h1aYkh5iCRzIgm66USzR9O+AhDrLgg1wg4Sw16UMDFjgkyMkEHFSy5CIB5ut0iqtKT/n
         fCmJIQtvHjxmpDMQDQ+7HTtv9YvTOBZKG7vaAc8NngS2EzNql1Zv6J18Ud9yoY4XiQxu
         D0h1R3zUpGbP7+95tHEpl4krciVgkCIdcCeUR8uvkN/Po1zlitoq++ROKOfHRKHpaK8T
         BF4YGSBlJuFkA6ED4UvFRyHzie29QtZKbK3uiGPXxQgxnXFHKdECPRuLjvq94ZfU6Rg4
         4n/A==
X-Gm-Message-State: APjAAAW8n+XMyrQxL3uEGsbmyCdqKOMog6Q6ZY09mSvIV6DgLw6T2FjB
        VVEbBeZxuDTXq/DekpB7Ys/yJy/ygMT6zfwEen3tUQ==
X-Google-Smtp-Source: APXvYqw4HCjsVl+Amh2Teet2qtkXvGz99b/JiD+OyiCx/6U5M9oVU+FrejKuChE3TPRj4OZE1ZrjIBxXffNmybu5Pvg=
X-Received: by 2002:a63:205f:: with SMTP id r31mr32165059pgm.159.1562695307162;
 Tue, 09 Jul 2019 11:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-17-brendanhiggins@google.com> <7cc417dd-036f-7dc1-6814-b1fdac810f03@kernel.org>
In-Reply-To: <7cc417dd-036f-7dc1-6814-b1fdac810f03@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Jul 2019 11:01:35 -0700
Message-ID: <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
Subject: Re: [PATCH v7 16/18] MAINTAINERS: add entry for KUnit the unit
 testing framework
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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

On Tue, Jul 9, 2019 at 7:53 AM shuah <shuah@kernel.org> wrote:
>
> On 7/9/19 12:30 AM, Brendan Higgins wrote:
> > Add myself as maintainer of KUnit, the Linux kernel's unit testing
> > framework.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> >   MAINTAINERS | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 677ef41cb012c..48d04d180a988 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8599,6 +8599,17 @@ S:     Maintained
> >   F:  tools/testing/selftests/
> >   F:  Documentation/dev-tools/kselftest*
> >
> > +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> > +M:   Brendan Higgins <brendanhiggins@google.com>
> > +L:   linux-kselftest@vger.kernel.org
> > +L:   kunit-dev@googlegroups.com
> > +W:   https://google.github.io/kunit-docs/third_party/kernel/docs/
> > +S:   Maintained
> > +F:   Documentation/dev-tools/kunit/
> > +F:   include/kunit/
> > +F:   kunit/
> > +F:   tools/testing/kunit/
> > +
> >   KERNEL USERMODE HELPER
> >   M:  Luis Chamberlain <mcgrof@kernel.org>
> >   L:  linux-kernel@vger.kernel.org
> >
>
> Thanks Brendan.
>
> I am good with this. I can take KUnit patches through kselftest
> with your Ack.

My acknowledgement? Sure! I thought we already agreed to that.

Also, do we need an ack from Masahiro or Michal for the Kbuild patch
[PATCH v7 06/18]? And an ack from Josh or Peter for the objtool patch
[PATCH v7 08/18]?

Greg and Logan gave me a Reviewed-by for the Kbuild patch, so maybe
that's fine, but I don't have any reviews or acks for the objtool
patch.

Thanks!
