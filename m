Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E9CC6B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 01:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfJDXwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 19:52:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37523 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfJDXwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:52:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so2846184pgi.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 16:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcHN5cpuf6HpMyzE/JY4AhaHdZhoO4XBzATDbA0jQMo=;
        b=p7+dFuiZsziG+/e4IFX0rnW9SeflAmpaFKbEye7G4M1ebE6V8LeScytbqmMKERZtR5
         QjRbiuO/aToN8Or4WR9FYXEhSUYMDU1KJIn32SoOozMI77zF8vOjIzvvJABxh84RZR4C
         LlqSCR6sGDe79xZesgkxmXJeuJitrXFE1GdKXTKr6FLzSDlwKRRjm9ro2En4XOPnrsrV
         xLsx/eNVyd83B5NslZmLyCoW4U/8f74vR2BiTHdskJQYP0m+HIjZr9Gl8VnrLSnaKHoe
         M710bTEav+D5XHd2wKySIJSZ3eNrQ+KbhUxPLsZfRYOkqO1iB3sLZMsPtKh3vaYk8nMz
         tTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcHN5cpuf6HpMyzE/JY4AhaHdZhoO4XBzATDbA0jQMo=;
        b=tkFJ623zTKNV1Ko0ytyI/qsMjSKXRAMV6tCPVpqc7rOvornVxiv0IggP0f9YLizZx8
         INN8JHqcP+vnKxUICCvEbAuTu3wdbIW2Sovs8RbKhPZpO/AKPUL0dB+0uTAm/px4eYQH
         s2o6BFGc68OTvzKT6XBBdKWAkc3qWJpvU4HoOAb/smkveCXW5dptRcHMPNrwtQr2cGRm
         B7QOtfAt6pF0D/06yih4nP5K483RJdvMklEaDBxkLgS9rVvRcL5tKIO0Wc+8ecS9Femu
         uGOCwQfp4bf5ydwuhrL9C6WBZNh3Vxlrx9XXIJrQgd0Dh7YfZ5/jwWdSyPC9HyUuUUv0
         RJLw==
X-Gm-Message-State: APjAAAUPfit5U+xQOxoQJyFGtxN3VAZc8ZqBzHoRCxXUEFLZ/WkBb7uz
        SUU/WFRAnEyP9xCAgK4rwTkWz3TpCBwwfKAnxJohnA==
X-Google-Smtp-Source: APXvYqzN4VO3fXIRGyWeog6vTVGJnv5zTfx/ZRo8Xl3+1qWVt0nnbDwusWqIpAgUbEoU+x2bu2ZOdOWkMBCWH4UJxNQ=
X-Received: by 2002:a63:ba47:: with SMTP id l7mr17842240pgu.201.1570233137464;
 Fri, 04 Oct 2019 16:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu> <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
In-Reply-To: <20191004232955.GC12012@mit.edu>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 4 Oct 2019 16:52:06 -0700
Message-ID: <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     shuah <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Fri, Oct 4, 2019 at 4:30 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Oct 04, 2019 at 04:47:09PM -0600, shuah wrote:
> > > However, if I encourage arbitrary tests/improvements into my KUnit
> > > branch, it further diverges away from torvalds/master, and is more
> > > likely that there will be a merge conflict or issue that is not related
> > > to the core KUnit changes that will cause the whole thing to be
> > > rejected again in v5.5.
> >
> > The idea is that the new development will happen based on kunit in
> > linux-kselftest next. It will work just fine. As we accepts patches,
> > they will go on top of kunit that is in linux-next now.
>
> I don't see how this would work.  If I add unit tests to ext4, they
> would be in fs/ext4.  And to the extent that I need to add test mocks
> to allow the unit tests to work, they will involve changes to existing
> files in fs/ext4.  I can't put them in the ext4.git tree without
> pulling in the kunit changes into the ext4 git tree.  And if they ext4
> unit tests land in the kunit tree, it would be a receipe for large
> numbers of merge conflicts.

That's where I was originally coming from.

So here's a dumb idea: what if we merged KUnit through the ext4 tree?
I imagine that could potentially get very confusing when we go back to
sending changes in through the kselftest tree, but at least it means
that ext4 can use it in the meantime, which means that it at least
gets to be useful to one group of people. Also, since Ted seems pretty
keen on using this, I imagine it is much more likely to produce real
world, immediately useful tests not written by me (I'm not being lazy,
I just think it is better to get other people's experiences other than
my own).

Thoughts?
