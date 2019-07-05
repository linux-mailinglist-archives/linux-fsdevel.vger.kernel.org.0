Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F032460C1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGEUPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:15:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41268 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEUPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:15:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so1390585pls.8;
        Fri, 05 Jul 2019 13:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dg5Yvvp7NUrUvKeik0ledTLe2yGcHUO+ZrIPV2huI9Y=;
        b=OzdFfcxvGnOCcXkAWwlO88u1j0z3dwlju31oMxPQLPOZ+n3HTlc9/3RNiBVymt6WjZ
         E343Nc2AfX2XFDO0jS9FCIZ10WFbDmirMIW3xQiN+CUgP9a+SrhuQtiVZBGwxI1D45B8
         fZE+T8B5M6sithJT8ew/njhUS8QtiiDj8fN5/Z9yzYi4hmW85MSXtuBeA/p17sOChy2i
         J3x8p4Q9SxWXaljLVBxGJvnYev9uWFYlZ6dkPfIyFEs82mzDRkF+7mD7r1kTz1uzkpm+
         +G6z6sekGN1SDwlRrQEt1ypneM2enRmEsGH4GjfMpmNL2IiH3hOTvZFxOUxVlMwmFVI8
         x6KQ==
X-Gm-Message-State: APjAAAViU5T0hbMXOxOVKtAMjnBdAZLdeqzQKDB7QB91U+rw5HUSwln5
        acNpqtSsq9tDZb6AmtdPw3Q=
X-Google-Smtp-Source: APXvYqzH7c1mrZ0zttAPULzlg8jVTTmmhx/hVeHeJnG9PaMmHS0LdOn+bNDKbdY4NLyOIl1o3kOldA==
X-Received: by 2002:a17:902:2865:: with SMTP id e92mr7552625plb.264.1562357707679;
        Fri, 05 Jul 2019 13:15:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 10sm17424980pfb.30.2019.07.05.13.15.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 13:15:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C552E40190; Fri,  5 Jul 2019 20:15:05 +0000 (UTC)
Date:   Fri, 5 Jul 2019 20:15:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, peterz@infradead.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        rdunlap@infradead.org, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v6 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190705201505.GA19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-2-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 05:35:58PM -0700, Brendan Higgins wrote:
> Add core facilities for defining unit tests; this provides a common way
> to define test cases, functions that execute code which is under test
> and determine whether the code under test behaves as expected; this also
> provides a way to group together related test cases in test suites (here
> we call them test_modules).
> 
> Just define test cases and how to execute them for now; setting
> expectations on code will be defined later.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

But a nitpick below, I think that can be fixed later with a follow up
patch.

> +/**
> + * struct kunit - represents a running instance of a test.
> + * @priv: for user to store arbitrary data. Commonly used to pass data created
> + * in the init function (see &struct kunit_suite).
> + *
> + * Used to store information about the current context under which the test is
> + * running. Most of this data is private and should only be accessed indirectly
> + * via public functions; the one exception is @priv which can be used by the
> + * test writer to store arbitrary data.
> + *
> + * A brief note on locking:
> + *
> + * First off, we need to lock because in certain cases a user may want to use an
> + * expectation in a thread other than the thread that the test case is running
> + * in.

This as a prefix to the struct without a lock seems odd. It would be
clearer I think if you'd explain here what locking mechanism we decided
to use and why it suffices today.

> +/**
> + * suite_test() - used to register a &struct kunit_suite with KUnit.

You mean kunit_test_suite()?

> + * @suite: a statically allocated &struct kunit_suite.
> + *
> + * Registers @suite with the test framework. See &struct kunit_suite for more
> + * information.
> + *
> + * NOTE: Currently KUnit tests are all run as late_initcalls; this means that
> + * they cannot test anything where tests must run at a different init phase. One
> + * significant restriction resulting from this is that KUnit cannot reliably
> + * test anything that is initialize in the late_init phase.
                            initialize prior to the late init phase.


That is, this is useless to test things running early.

> + *
> + * TODO(brendanhiggins@google.com): Don't run all KUnit tests as late_initcalls.
> + * I have some future work planned to dispatch all KUnit tests from the same
> + * place, and at the very least to do so after everything else is definitely
> + * initialized.

TODOs are odd to be adding to documentation, this is just not common
place practice. The NOTE should suffice for you.

  Luis
