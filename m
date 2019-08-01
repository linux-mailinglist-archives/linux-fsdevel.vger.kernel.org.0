Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843DC7E4AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbfHAVOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 17:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731215AbfHAVOt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:14:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3D7206A2;
        Thu,  1 Aug 2019 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564694087;
        bh=n0IdgFG7Kos2nGnJ4DnkR9p1y4CCyIbJ6ZBAUiBNpN4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mCeQAbdwzIbwLPOijpChQVFo4UiYoSWfSZsIgfoIrNYNDT1t+cF6inHSpvwbpaWEE
         h3a75ihCGxnVfKz0yO5MH+8Z55L0rleQ67pJQ89uiV1jYfk7eCIm+wLogdHeiGG1J2
         0oPUv74xqN1E4K+r3Bcp5gj1D6bBbIkaOl5oR1Jc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g473iFfvBnJs2pcwuJYgY+DpgD6RLzyDFL1otUuScgKUag@mail.gmail.com>
References: <20190716175021.9CA412173C@mail.kernel.org> <20190719000834.GA3228@google.com> <20190722200347.261D3218C9@mail.kernel.org> <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com> <20190722235411.06C1320840@mail.kernel.org> <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz> <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com> <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz> <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com> <CAFd5g473iFfvBnJs2pcwuJYgY+DpgD6RLzyDFL1otUuScgKUag@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>, Jeff Dike <jdike@addtoit.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Vetter <daniel@ffwll.ch>,
        Amir Goldstein <amir73il@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@google.com>,
        David Rientjes <rientjes@google.com>,
        kunit-dev@googlegroups.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        wfg@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Knut Omang <knut.omang@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        John Ogness <john.ogness@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 14:14:46 -0700
Message-Id: <20190801211447.6D3D7206A2@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-01 11:59:57)
> On Thu, Aug 1, 2019 at 11:55 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Fri, Jul 26, 2019 at 1:31 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > > To be honest I do not fully understand KUnit design. I am not
> > > completely sure how the tested code is isolated from the running
> > > system. Namely, I do not know if the tested code shares
> > > the same locks with the system running the test.
> >
> > No worries, I don't expect printk to be the hang up in those cases. It
> > sounds like KUnit has a long way to evolve before printk is going to
> > be a limitation.
>=20
> So Stephen, what do you think?
>=20
> Do you want me to go forward with the new kunit_assert API wrapping
> the string_stream as I have it now? Would you prefer to punt this to a
> later patch? Or would you prefer something else?
>=20

I like the struct based approach. If anything, it can be adjusted to
make the code throw some records into a spinlock later on and delay the
formatting of the assertion if need be. Can you resend with that
approach? I don't think I'll have any more comments after that.

