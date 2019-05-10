Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1409F19BD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 12:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEJKpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 06:45:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44080 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727251AbfEJKpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 06:45:17 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4AAhcGQ005268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 06:43:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8AE2E420024; Fri, 10 May 2019 06:43:38 -0400 (EDT)
Date:   Fri, 10 May 2019 06:43:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190510104338.GB6889@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
        sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <78e4d46e-6212-9871-51d6-dd2126f39d45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e4d46e-6212-9871-51d6-dd2126f39d45@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 10:11:01PM -0700, Frank Rowand wrote:
> >> You *can* run in-kernel test using modules; but there is no framework
> >> for the in-kernel code found in the test modules, which means each of
> >> the in-kernel code has to create their own in-kernel test
> >> infrastructure.
> 
> The kselftest in-kernel tests follow a common pattern.  As such, there
> is a framework.

So we may have different definitions of "framework".  In my book, code
reuse by "cut and paste" does not make a framework.  Could they be
rewritten to *use* a framework, whether it be KTF or KUnit?  Sure!
But they are not using a framework *today*.

> This next two paragraphs you ignored entirely in your reply:
> 
> > Why create an entire new subsystem (KUnit) when you can add a header
> > file (and .c code as appropriate) that outputs the proper TAP formatted
> > results from kselftest kernel test modules?

And you keep ignoring my main observation, which is that spinning up a
VM, letting systemd start, mounting a root file system, etc., is all
unnecessary overhead which takes time.  This is important to me,
because developer velocity is extremely important if you are doing
test driven development.

Yes, you can manually unload a module, recompile the module, somehow
get the module back into the VM (perhaps by using virtio-9p), and then
reloading the module with the in-kernel test code, and the restart the
test.  BUT: (a) even if it is faster, it requires a lot of manual
steps, and would be very hard to automate, and (b) if the test code
ever OOPS or triggers a lockdep warning, you will need to restart the
VM, and so this involves all of the VM restart overhead, plus trying
to automate determining when you actually do need to restart the VM
versus unloading and reloading the module.   It's clunky.

Being able to do the equivalent of "make && make check" is a really
big deal.  And "make check" needs to go fast.

You keep ignore this point, perhaps because you don't care about this
issue?  Which is fine, and why we may just need to agree to disagree.

Cheers,

						- Ted

P.S.  Running scripts is Turing-equivalent, so it's self-evident that
*anything* you can do with other test frameworks you can somehow do in
kselftests.  That argument doesn't impress me, and why I do consider
it quite flippant.  (Heck, /bin/vi is Turing equivalent so we could
use vi to as a kernel test framework.  Or we could use emacs.  Let's
not.  :-)

The question is whether it is the most best and most efficient way to
do that testing.  And developer velocity is a really big part of my
evaluation function when judging whether or a test framework is fit
for that purpose.
