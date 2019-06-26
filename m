Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72157418
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfFZWDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 18:03:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33003 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZWDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:03:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so142146pfq.0;
        Wed, 26 Jun 2019 15:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/PNSJ1/n2Sf5XjBVfcC1JCMKtBWU3f+geLh+mw2r8k=;
        b=j7/rOM+cvthbF58ZwyBw0YxHb4PZxAmws9pvjqxbAN/mNcMQuGOc/xll6POP9ZIr7U
         xbcM66TWwY0uM4FZ4/hJIUnY5VnT6bkQUnkXSPRvSfryPNPaDX8q3t2JlgPsFSFBYyC9
         b1Z3fI6bv4avaDePQjHxW/9DtJkz25QiLTPhotLGzkZpglRUbR8x++q0ZdwAnLVQArKs
         hMJpVz+4TllNFOXyXJrAGomTclD24yDyWx6UHxoqkL1zszOkzzFH4aEd38an8xi4iJxk
         ntz43alVLnbSzlz1OFFitV92y88//f3vVxKRLS0hLIj980hrBGq5bRNG3HOjHhq2J2S7
         dOOg==
X-Gm-Message-State: APjAAAX5DguREj6F9/EADpVykAWSwhmxs46d9M1VJnMF3jjyOfBD1ans
        USPoJ5XxQH6YGvKtNSRngzA=
X-Google-Smtp-Source: APXvYqw88JPlk1NMugJQCJe5YC3I+KLyTyrQ1NxeCgEmtlZtT8YwpdCjtZvQ3Q7z9dJOH+5nmM/tbA==
X-Received: by 2002:a63:6cc3:: with SMTP id h186mr215927pgc.292.1561586632642;
        Wed, 26 Jun 2019 15:03:52 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j23sm110168pgb.63.2019.06.26.15.03.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 15:03:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5B297401D0; Wed, 26 Jun 2019 22:03:50 +0000 (UTC)
Date:   Wed, 26 Jun 2019 22:03:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [PATCH v5 13/18] kunit: tool: add Python wrappers for running
 KUnit tests
Message-ID: <20190626220350.GA19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-14-brendanhiggins@google.com>
 <20190626000150.GT19023@42.do-not-panic.com>
 <CAFd5g44kkepB2hZcpYL-NB5ZHYE5tP7W-0yducGCX7Khd9gd9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44kkepB2hZcpYL-NB5ZHYE5tP7W-0yducGCX7Khd9gd9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 01:02:55AM -0700, Brendan Higgins wrote:
> On Tue, Jun 25, 2019 at 5:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Jun 17, 2019 at 01:26:08AM -0700, Brendan Higgins wrote:
> > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
> > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
> > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
> > >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
> > >  create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
> > >  create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig
> >
> > Why are these being added upstream? The commit log does not explain
> > this.
> 
> Oh sorry, those are for testing purposes. I thought that was clear
> from being in the test_data directory. I will reference it in the
> commit log in the next revision.

Still, I don't get it. They seem to be results from a prior run. Why do
we need them for testing purposes?

  Luis
