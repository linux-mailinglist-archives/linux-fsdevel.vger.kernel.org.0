Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31D55B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFYWdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 18:33:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43390 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfFYWdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:33:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so133340pgv.10;
        Tue, 25 Jun 2019 15:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TnzcHfb/rGR5D/vErJu8w17aFeeUcfwDXLuZxpFdgZc=;
        b=rNVLR2LDpP8KAQuszWLfab1CJ9gXccbXmSDxzPyAeTL3JIPvljZWiiRYzz/i6H743/
         TxnaB1vUVgTE+fcI5I4L5yXaetDkjWBc4fa7QZzjtDkX37hbEVE+Mv8wxt+1YPPhZ7iw
         qrPQ/U5PNWOziks8EzD7jGwqK/S1DlixOuiEBasaPh9bRvvMAJJhFzjvJInkpFjuwqFQ
         PzHITMs8V1MgjLPkwQsEfJVqojTjDLQfScJvbiXdErj/zv5BA3ECvLcNR7etZMU0zaLA
         ebSl4H2FueURFNZnqnj5/CmerH8Mywg1MRbyEjDe43xPAS8vNYBx7LAuWX79drGCazPF
         zdPQ==
X-Gm-Message-State: APjAAAVNqmYSdo4AzoRGu7VqCyayqtHpfhhKjEQgWUQiX73Y78zNNfah
        F+W+Hhe0i9GS11WR3P5MJAE=
X-Google-Smtp-Source: APXvYqz8tePzVjq6qydlXc6fHsQtBqVBfz39DV20JLDT6sqkzfdOgtSxbEsBu2vrr4nNjRf5f7IpUg==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr267009pjz.140.1561501994728;
        Tue, 25 Jun 2019 15:33:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p67sm23643298pfg.124.2019.06.25.15.33.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 15:33:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CD044401EB; Tue, 25 Jun 2019 22:33:12 +0000 (UTC)
Date:   Tue, 25 Jun 2019 22:33:12 +0000
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
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190625223312.GP19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-2-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:25:56AM -0700, Brendan Higgins wrote:
> +/**
> + * module_test() - used to register a &struct kunit_module with KUnit.
> + * @module: a statically allocated &struct kunit_module.
> + *
> + * Registers @module with the test framework. See &struct kunit_module for more
> + * information.
> + */
> +#define module_test(module) \
> +		static int module_kunit_init##module(void) \
> +		{ \
> +			return kunit_run_tests(&module); \
> +		} \
> +		late_initcall(module_kunit_init##module)

Becuase late_initcall() is used, if these modules are built-in, this
would preclude the ability to test things prior to this part of the
kernel under UML or whatever architecture runs the tests. So, this
limits the scope of testing. Small detail but the scope whould be
documented.

> +static void kunit_print_tap_version(void)
> +{
> +	if (!kunit_has_printed_tap_version) {
> +		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");

What is this TAP thing? Why should we care what version it is on?
Why are we printing this?

> +		kunit_has_printed_tap_version = true;
> +	}
> +}
> +
> +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> +{
> +	struct kunit_case *test_case;
> +	size_t len = 0;
> +
> +	for (test_case = test_cases; test_case->run_case; test_case++)

If we make the last test case NULL, we'd just check for test_case here,
and save ourselves an extra few bytes per test module. Any reason why
the last test case cannot be NULL?

> +void kunit_init_test(struct kunit *test, const char *name)
> +{
> +	spin_lock_init(&test->lock);
> +	test->name = name;
> +	test->success = true;
> +}
> +
> +/*
> + * Performs all logic to run a test case.
> + */
> +static void kunit_run_case(struct kunit_module *module,
> +			   struct kunit_case *test_case)
> +{
> +	struct kunit test;
> +	int ret = 0;
> +
> +	kunit_init_test(&test, test_case->name);
> +
> +	if (module->init) {
> +		ret = module->init(&test);

I believe if we used struct kunit_module *kmodule it would be much
clearer who's init this is.

  Luis
