Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A099CD3BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2019 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfJFQ4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 12:56:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48794 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbfJFQ4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:56:49 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x96GsaNE023214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Oct 2019 12:54:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A922942088C; Sun,  6 Oct 2019 12:54:36 -0400 (EDT)
Date:   Sun, 6 Oct 2019 12:54:36 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Brendan Higgins <brendanhiggins@google.com>
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
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20191006165436.GA29585@mit.edu>
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
 <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
 <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org>
 <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org>
 <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 04, 2019 at 06:18:04PM -0700, Brendan Higgins wrote:
> > Let's talk about current state. Right now kunit is in linux-next and
> > we want to add a few more tests. We will have to coordinate the effort.
> > Once kunit get into mainline, then the need for this coordination goes
> > down.
> 
> Sure, I was just thinking that getting other people to write the tests
> would be better. Since not only is it then useful to someone else, it
> provides the best possible exercise of KUnit.

Well, one thing we *can* do is if (a) if we can create a kselftest
branch which we know is stable and won't change, and (b) we can get
assurances that Linus *will* accept that branch during the next merge
window, those subsystems which want to use kself test can simply pull
it into their tree.

We've done this before in the file system world, when there has been
some common set of changes needed to improve, say, Direct I/O, where
the changes are put into a standalone branch, say, in the xfs tree,
and those file systems which need it as a building block can pull it
into their tree, and then add the changes needed to use those changes
into their file system git tree.  These changes are generally not
terribly controversial, and we've not had to worry about people want
to bikeshed the changes.

There is a risk with doing this of course, which is that if the branch
*is* controversial, or gets bike-shedded for some reason, then Linus
gets upset and any branches which depended on said branch will get
rejected at the next merge window.  Which is the requirement for (a)
and (b) above.  Presumably, the fact that people were unwilling to let
Kunit land during this merge window might will *because* we think more
changes might be pending?

The other thing I suppose I can do is to let the ext4 kunit tests land
in ext4 tree, but with the necessary #ifdef's around things like
"#include <kunit/test.h>" so that the build won't blow up w/o kunit
changes being in the tree that I'm building.  It means I won't be able
to run the tests without creating a test integration branch and
merging in kunit by hand, which will super-annoying, of course.  And
if some of the bike-shedding is in Kunit's interfaces, then that
becomes problematic as well, since any tests that are in ext4.git tree
might change if people want to rename Kunit's publically exported
functions (for example).

> Hey Ted, do you know if that ext4 timestamp test can go in through
> linux-kselftest? It seemed fairly self-contained. Or is that what you
> were saying wouldn't work for you?

Well, I was hoping that we might start creating more tests beyond just
the ext4 timestamp tests....

						- Ted
