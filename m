Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407EBCC693
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 01:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfJDXbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 19:31:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57293 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbfJDXbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:31:39 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x94NTuAQ024308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Oct 2019 19:29:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CCF8D42088C; Fri,  4 Oct 2019 19:29:55 -0400 (EDT)
Date:   Fri, 4 Oct 2019 19:29:55 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     shuah <shuah@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        kieran.bingham@ideasonboard.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, robh@kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
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
        Sasha Levin <Alexander.Levin@microsoft.com>, Tim.Bird@sony.com,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20191004232955.GC12012@mit.edu>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu>
 <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
 <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 04, 2019 at 04:47:09PM -0600, shuah wrote:
> > However, if I encourage arbitrary tests/improvements into my KUnit
> > branch, it further diverges away from torvalds/master, and is more
> > likely that there will be a merge conflict or issue that is not related
> > to the core KUnit changes that will cause the whole thing to be
> > rejected again in v5.5.
> 
> The idea is that the new development will happen based on kunit in
> linux-kselftest next. It will work just fine. As we accepts patches,
> they will go on top of kunit that is in linux-next now.

I don't see how this would work.  If I add unit tests to ext4, they
would be in fs/ext4.  And to the extent that I need to add test mocks
to allow the unit tests to work, they will involve changes to existing
files in fs/ext4.  I can't put them in the ext4.git tree without
pulling in the kunit changes into the ext4 git tree.  And if they ext4
unit tests land in the kunit tree, it would be a receipe for large
numbers of merge conflicts.

						- Ted
