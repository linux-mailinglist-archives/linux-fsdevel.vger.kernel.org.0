Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB121195B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 01:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEIXcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 19:32:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38430 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726108AbfEIXcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 19:32:24 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x49NUiJg006219
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 May 2019 19:30:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AC36A420024; Thu,  9 May 2019 19:30:43 -0400 (EDT)
Date:   Thu, 9 May 2019 19:30:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        brendanhiggins@google.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, dan.j.williams@intel.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190509233043.GC20877@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Logan Gunthorpe <logang@deltatee.com>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        brendanhiggins@google.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
        sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
References: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
> 
> The second item, arguably, does have significant overlap with kselftest.
> Whether you are running short tests in a light weight UML environment or
> higher level tests in an heavier VM the two could be using the same
> framework for writing or defining in-kernel tests. It *may* also be valuable
> for some people to be able to run all the UML tests in the heavy VM
> environment along side other higher level tests.
> 
> Looking at the selftests tree in the repo, we already have similar items to
> what Kunit is adding as I described in point (2) above. kselftest_harness.h
> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
> 
> However, the number of users of this harness appears to be quite small. Most
> of the code in the selftests tree seems to be a random mismash of scripts
> and userspace code so it's not hard to see it as something completely
> different from the new Kunit:
> 
> $ git grep --files-with-matches kselftest_harness.h *

To the extent that we can unify how tests are written, I agree that
this would be a good thing.  However, you should note that
kselftest_harness.h is currently assums that it will be included in
userspace programs.  This is most obviously seen if you look closely
at the functions defined in the header files which makes calls to
fork(), abort() and fprintf().

So Kunit can't reuse kselftest_harness.h unmodified.  And whether or
not the actual implementation of the header file can be reused or
refactored, making the unit tests use the same or similar syntax would
be a good thing.

Cheers,

						- Ted
