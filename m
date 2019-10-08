Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE4BD02E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJHVfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 17:35:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44626 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfJHVfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:35:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so145025pfn.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2019 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KGh1LAlQix7XM3buDCxUXeBsipn44ZcZivUAyJ5/VQU=;
        b=ERY1dO71RhJnkTCoIulvXTSkX4SgyB7/+r1p4FDR7jpOBmoj7yup0pf4+0yF/zJ9RS
         W5oBL9qNkNRkCmwXItZNj8oUo36z/Kcqfs7bKASiJLBgPJ1KxwtEzf+GEd0hYeL9HsHf
         50jhpSMn1LpqJG2r2Cp87I1uGX2HmEuboCofkwQgMHVJtMfP87ONkAjxAzoSNQygAgHx
         1V22KBIoOkXTOYLaIMLKnkRqAGtYpmKaroRboopDeKIP+RNBAEnEmnvabsRCCHnMRcEX
         Dwduss/phn7S/yP6yUZt3Z8EBFpE3LTCJKZ4JZXbVvdcSD7y4exoa3zLtmrs652jhkrz
         GlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KGh1LAlQix7XM3buDCxUXeBsipn44ZcZivUAyJ5/VQU=;
        b=N/JWap7rDr1jvcfxOGNnYix50Cd/Vq0nKUj+9/65vO2WgYOmKTR/rgPPVz5H9+lzu7
         LLuBGrHZpksmT1nteWhuHAekkUFOlELFTp0nuemwtO2j1O1+F2oI7RZE3IB4CJQOqEoq
         cH8UW4BmopB291yyYAPrdFoF9jFLxBmDNm/3ZU4HGZITedfd3wsXcoIAzywyoOIKPI/F
         cVLoytv/MjSOf58wUSjscSRV0Qv/rqVx+jzHpX/yqLPH3gzEttvqW8utOPuxH2KhjQq4
         Op17a1ROyfk/tSNXuwnBgxQQDpjcED/uH9IDyb9fVIP9t4qBuoICfU9M9GfAs1XxfRDY
         fLpA==
X-Gm-Message-State: APjAAAUtWCQWoV2yyXqRU0KEtiF86PN/L1ahleYyslwqYtA5Y4zdZ6+T
        UE4eFdTzFgFXmH88N2oxDy3+IQ==
X-Google-Smtp-Source: APXvYqwo1rsNnnCYLNqw9NvChcBU7Ndou7YNE02hQiXApIsV7UZDpI2MjLecjRYjjOg6hjIFwLrkig==
X-Received: by 2002:a62:750d:: with SMTP id q13mr73352pfc.58.1570570540615;
        Tue, 08 Oct 2019 14:35:40 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id c125sm76724pfa.107.2019.10.08.14.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 14:35:39 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:35:35 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v2 linux-kselftest-test 1/3] kunit: allow kunit tests to
 be loaded as a module
Message-ID: <20191008213535.GB186342@google.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <1570546546-549-2-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570546546-549-2-git-send-email-alan.maguire@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:55:44PM +0100, Alan Maguire wrote:
> as tests are added to kunit, it will become less feasible to execute
> all built tests together.  By supporting modular tests we provide
> a simple way to do selective execution on a running system; specifying
> 
> CONFIG_KUNIT=y
> CONFIG_KUNIT_EXAMPLE_TEST=m
> 
> ...means we can simply "insmod example-test.ko" to run the tests.
> 
> To achieve this we need to
> 
> o export the required symbols in kunit
> o support a new way of declaring test suites.  Because a module cannot
>   do multiple late_initcall()s, we provide a kunit_test_suites() macro
>   to declare multiple suites within the same module at once.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> 
> ---
>  include/kunit/test.h           | 30 +++++++++++++++++++++++-------
>  kernel/sysctl-test.c           |  6 +++++-
>  lib/Kconfig.debug              |  4 ++--
>  lib/kunit/Kconfig              |  4 ++--
>  lib/kunit/assert.c             |  8 ++++++++
>  lib/kunit/example-test.c       |  6 +++++-
>  lib/kunit/string-stream-test.c |  9 +++++++--
>  lib/kunit/string-stream.c      |  7 +++++++
>  lib/kunit/test-test.c          |  8 ++++++--
>  lib/kunit/test.c               |  8 ++++++++
>  lib/kunit/try-catch.c          |  8 ++++++--
>  11 files changed, 79 insertions(+), 19 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index dba4830..9fc6c1b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -12,6 +12,7 @@
>  #include <kunit/assert.h>
>  #include <kunit/try-catch.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> @@ -204,24 +205,39 @@ struct kunit {
>   * Registers @suite with the test framework. See &struct kunit_suite for
>   * more information.
>   *
> - * NOTE: Currently KUnit tests are all run as late_initcalls; this means
> + * When builtin,  KUnit tests are all run as late_initcalls; this means
>   * that they cannot test anything where tests must run at a different init
>   * phase. One significant restriction resulting from this is that KUnit
>   * cannot reliably test anything that is initialize in the late_init phase;
>   * another is that KUnit is useless to test things that need to be run in
>   * an earlier init phase.
>   *
> + * An alternative is to build the tests as a module.  Because modules
> + * do not support multiple late_initcall()s, we need to initialize an
> + * array of suites for a module.
> + *
>   * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
>   * late_initcalls.  I have some future work planned to dispatch all KUnit
>   * tests from the same place, and at the very least to do so after
>   * everything else is definitely initialized.
>   */
> -#define kunit_test_suite(suite)						       \
> -	static int kunit_suite_init##suite(void)			       \
> -	{								       \
> -		return kunit_run_tests(&suite);				       \
> -	}								       \
> -	late_initcall(kunit_suite_init##suite)
> +#define kunit_test_suites(...)						\
> +	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
> +	static int kunit_test_suites_init(void)				\
> +	{								\
> +		unsigned int i;						\
> +		for (i = 0; suites[i] != NULL; i++)			\
> +			kunit_run_tests(suites[i]);			\
> +		return 0;						\
> +	}								\
> +	late_initcall(kunit_test_suites_init);				\
> +	static void __exit kunit_test_suites_exit(void)			\
> +	{								\
> +		return;							\
> +	}								\
> +	module_exit(kunit_test_suites_exit)
> +
> +#define	kunit_test_suite(suite)	kunit_test_suites(suite)

I think it is fine to just rename this kunit_test_suites.

>  /*
>   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> index 2a63241..15161c5 100644
> --- a/kernel/sysctl-test.c
> +++ b/kernel/sysctl-test.c
> @@ -389,4 +389,8 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
>  	.test_cases = sysctl_test_cases,
>  };
>  
> -kunit_test_suite(sysctl_test_suite);
> +kunit_test_suite(&sysctl_test_suite);
> +
> +#ifdef MODULE
> +MODULE_LICENSE("GPL");
> +#endif /* MODULE */

Here and elsewhere: the "ifdef/endif MODULE" should not be necessary.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a3017a5..f9f411a6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1951,10 +1951,10 @@ config TEST_SYSCTL
>  	  If unsure, say N.
>  
>  config SYSCTL_KUNIT_TEST
> -	bool "KUnit test for sysctl"
> +	tristate "KUnit test for sysctl"
>  	depends on KUNIT
>  	help
> -	  This builds the proc sysctl unit test, which runs on boot.
> +	  This builds the proc sysctl unit test, which runs on boot/module load.
>  	  Tests the API contract and implementation correctness of sysctl.
>  	  For more information on KUnit and unit tests in general please refer
>  	  to the KUnit documentation in Documentation/dev-tools/kunit/.
[...]
> diff --git a/lib/kunit/example-test.c b/lib/kunit/example-test.c
> index f64a829..6c6a408 100644
> --- a/lib/kunit/example-test.c
> +++ b/lib/kunit/example-test.c
> @@ -85,4 +85,8 @@ static int example_test_init(struct kunit *test)
>   * This registers the above test suite telling KUnit that this is a suite of
>   * tests that need to be run.
>   */
> -kunit_test_suite(example_test_suite);
> +kunit_test_suite(&example_test_suite);
> +
> +#ifdef MODULE
> +MODULE_LICENSE("GPL");
> +#endif /* MODULE */

nit: The "ifdef/endif MODULE" should not be necessary.

> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 76cc05e..7a3e7a0 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -45,8 +45,13 @@ static void string_stream_test_get_string(struct kunit *test)
>  	{}
>  };
>  
> -static struct kunit_suite string_stream_test_suite = {
> +struct kunit_suite string_stream_test_suite = {
>  	.name = "string-stream-test",
>  	.test_cases = string_stream_test_cases
>  };
> -kunit_test_suite(string_stream_test_suite);
> +
> +kunit_test_suite(&string_stream_test_suite);
> +
> +#ifdef MODULE
> +MODULE_LICENSE("GPL");
> +#endif /* MODULE */
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index e6d17aa..e4f3a97 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -100,6 +100,7 @@ int string_stream_vadd(struct string_stream *stream,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(string_stream_vadd);

Is this actually needed by anything other than lib/kunit/test.c right
now? Maybe we should move the include file into the kunit/ directory to
hide these so no one else can use them.

>  int string_stream_add(struct string_stream *stream, const char *fmt, ...)
>  {
> @@ -112,6 +113,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
>  
>  	return result;
>  }
> +EXPORT_SYMBOL_GPL(string_stream_add);
[...]
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c83c0fa..e7896f1 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
[...]
> @@ -50,6 +51,7 @@ static unsigned long kunit_test_timeout(void)
>  	 * For more background on this topic, see:
>  	 * https://mike-bland.com/2011/11/01/small-medium-large.html
>  	 */
> +#ifndef MODULE

Why is this block of code "ifndef MODULE"?

>  	if (sysctl_hung_task_timeout_secs) {
>  		/*
>  		 * If sysctl_hung_task is active, just set the timeout to some
> @@ -60,9 +62,9 @@ static unsigned long kunit_test_timeout(void)
>  		 */
>  		timeout_msecs = (sysctl_hung_task_timeout_secs - 1) *
>  				MSEC_PER_SEC;
> -	} else {
> +	} else
> +#endif
>  		timeout_msecs = 300 * MSEC_PER_SEC; /* 5 min */
> -	}
>  
>  	return timeout_msecs;
>  }
> @@ -106,6 +108,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
>  
>  	try_catch->catch(try_catch->context);
>  }
> +EXPORT_SYMBOL_GPL(kunit_try_catch_run);
>  
>  void kunit_try_catch_init(struct kunit_try_catch *try_catch,
>  			  struct kunit *test,
> @@ -116,3 +119,4 @@ void kunit_try_catch_init(struct kunit_try_catch *try_catch,
>  	try_catch->try = try;
>  	try_catch->catch = catch;
>  }
> +EXPORT_SYMBOL_GPL(kunit_try_catch_init);

This code should also probably be hidden from outside of kunit/.
