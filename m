Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124AD70DB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 01:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfGVXyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 19:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbfGVXyM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:54:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C1320840;
        Mon, 22 Jul 2019 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563839651;
        bh=7riE0sVQmQS5QgS4pP9ptPUvfmyCxgbuxcUzFNIX2L8=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=lMfzRRCskgjYJCyPlokQPKY6jX+VpgCrEwPkMIQvRxf8iOB5wgrS9PjXaN0wjtfWh
         RiuaqfDlvSUHC1e16Pk0GMsnB1H5f28N5075BUdTFeSOe4/ZlQbTkjJF0oMcqI6dyP
         T+b1BFHi89keU/CNeTzd05/B7YC7Rqku9pnyKVeY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
References: <20190712081744.87097-1-brendanhiggins@google.com> <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com> <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com> <20190716175021.9CA412173C@mail.kernel.org> <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com> <20190718175024.C3EC421019@mail.kernel.org> <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com> <20190719000834.GA3228@google.com> <20190722200347.261D3218C9@mail.kernel.org> <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
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
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 16:54:10 -0700
Message-Id: <20190722235411.06C1320840@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-07-22 15:30:49)
> On Mon, Jul 22, 2019 at 1:03 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> >
> > What's the calling context of the assertions and expectations? I still
> > don't like the fact that string stream needs to allocate buffers and
> > throw them into a list somewhere because the calling context matters
> > there.
>=20
> The calling context is the same as before, which is anywhere.

Ok. That's concerning then.

>=20
> > I'd prefer we just wrote directly to the console/log via printk
> > instead. That way things are simple because we use the existing
> > buffering path of printk, but maybe there's some benefit to the string
> > stream that I don't see? Right now it looks like it builds a string and
> > then dumps it to printk so I'm sort of lost what the benefit is over
> > just writing directly with printk.
>=20
> It's just buffering it so the whole string gets printed uninterrupted.
> If we were to print out piecemeal to printk, couldn't we have another
> call to printk come in causing it to garble the KUnit message we are
> in the middle of printing?

Yes, printing piecemeal by calling printk many times could lead to
interleaving of messages if something else comes in such as an interrupt
printing something. Printk has some support to hold "records" but I'm
not sure how that would work here because KERN_CONT talks about only
being used early on in boot code. I haven't looked at printk in detail
though so maybe I'm all wrong and KERN_CONT just works?

Can printk be called once with whatever is in the struct? Otherwise if
this is about making printk into a structured log then maybe printk
isn't the proper solution anyway. Maybe a dev interface should be used
instead that can handle starting and stopping tests (via ioctl) in
addition to reading test results, records, etc. with read() and a
clearing of the records. Then the seqfile API works naturally. All of
this is a bit premature, but it looks like you're going down the path of
making something akin to ftrace that stores binary formatted
assertion/expectation records in a lockless ring buffer that then
formats those records when the user asks for them.

I can imagine someone wanting to write unit tests that check conditions
from a simulated hardirq context via irq works (a driver mock
framework?), so this doesn't seem far off.

