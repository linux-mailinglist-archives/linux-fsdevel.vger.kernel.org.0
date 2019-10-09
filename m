Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BBD143A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfJIQik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 12:38:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43138 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbfJIQij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:38:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99GOErC181153;
        Wed, 9 Oct 2019 16:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=WuKv1QsjRp4tTuG2TpUYHzro1gAW9j7CGX0cX2UY0Uo=;
 b=IYjx9gveAlZM0E6IP/mJiR8gYABs/9vIJxw55nR8tNkNqynNK1plpFes/gKIuecP4Fx7
 cKsl/jyuztv4T0Pt2rlTiQX4vTHgEED949410XBO9ipq8n6FoJZcKHBeCzThcRS1grVW
 dh60Ymr9D6icg2kRxe1fl9lOPxi0uKn8izJfI2bVgSvnpedDH2aKFHyteVLbCEflkDMR
 zC8GdVh5goSBVNyx+nq5IrCN3emSJ3wsaNWZ63Py9/UgcxBY1hNwHT8xHPHsoFK87Xep
 8HMYG+82oLmhQAu7Bn1bW+OF7OW/S6QgZYVJNrDm1wJG5woXMgClH9Ie14+tEE9q6ucB BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vek4qnw9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 16:36:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99GNZwl088166;
        Wed, 9 Oct 2019 16:36:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vh8k13exh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 16:36:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x99GaAbW014088;
        Wed, 9 Oct 2019 16:36:10 GMT
Received: from dhcp-10-175-191-127.vpn.oracle.com (/10.175.191.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 16:36:10 +0000
Date:   Wed, 9 Oct 2019 17:35:51 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-191-127.vpn.oracle.com
To:     Brendan Higgins <brendanhiggins@google.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
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
In-Reply-To: <20191008213535.GB186342@google.com>
Message-ID: <alpine.LRH.2.20.1910091726010.2517@dhcp-10-175-191-127.vpn.oracle.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com> <1570546546-549-2-git-send-email-alan.maguire@oracle.com> <20191008213535.GB186342@google.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090146
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Oct 2019, Brendan Higgins wrote:

> On Tue, Oct 08, 2019 at 03:55:44PM +0100, Alan Maguire wrote:
> > as tests are added to kunit, it will become less feasible to execute
> > all built tests together.  By supporting modular tests we provide
> > a simple way to do selective execution on a running system; specifying
> > 
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_EXAMPLE_TEST=m
> > 
> > ...means we can simply "insmod example-test.ko" to run the tests.
> > 
> > To achieve this we need to
> > 
> > o export the required symbols in kunit
> > o support a new way of declaring test suites.  Because a module cannot
> >   do multiple late_initcall()s, we provide a kunit_test_suites() macro
> >   to declare multiple suites within the same module at once.
> > 
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > 
> > ---
> >  include/kunit/test.h           | 30 +++++++++++++++++++++++-------
> >  kernel/sysctl-test.c           |  6 +++++-
> >  lib/Kconfig.debug              |  4 ++--
> >  lib/kunit/Kconfig              |  4 ++--
> >  lib/kunit/assert.c             |  8 ++++++++
> >  lib/kunit/example-test.c       |  6 +++++-
> >  lib/kunit/string-stream-test.c |  9 +++++++--
> >  lib/kunit/string-stream.c      |  7 +++++++
> >  lib/kunit/test-test.c          |  8 ++++++--
> >  lib/kunit/test.c               |  8 ++++++++
> >  lib/kunit/try-catch.c          |  8 ++++++--
> >  11 files changed, 79 insertions(+), 19 deletions(-)
> > 
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index dba4830..9fc6c1b 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -12,6 +12,7 @@
> >  #include <kunit/assert.h>
> >  #include <kunit/try-catch.h>
> >  #include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  
> > @@ -204,24 +205,39 @@ struct kunit {
> >   * Registers @suite with the test framework. See &struct kunit_suite for
> >   * more information.
> >   *
> > - * NOTE: Currently KUnit tests are all run as late_initcalls; this means
> > + * When builtin,  KUnit tests are all run as late_initcalls; this means
> >   * that they cannot test anything where tests must run at a different init
> >   * phase. One significant restriction resulting from this is that KUnit
> >   * cannot reliably test anything that is initialize in the late_init phase;
> >   * another is that KUnit is useless to test things that need to be run in
> >   * an earlier init phase.
> >   *
> > + * An alternative is to build the tests as a module.  Because modules
> > + * do not support multiple late_initcall()s, we need to initialize an
> > + * array of suites for a module.
> > + *
> >   * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
> >   * late_initcalls.  I have some future work planned to dispatch all KUnit
> >   * tests from the same place, and at the very least to do so after
> >   * everything else is definitely initialized.
> >   */
> > -#define kunit_test_suite(suite)						       \
> > -	static int kunit_suite_init##suite(void)			       \
> > -	{								       \
> > -		return kunit_run_tests(&suite);				       \
> > -	}								       \
> > -	late_initcall(kunit_suite_init##suite)
> > +#define kunit_test_suites(...)						\
> > +	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
> > +	static int kunit_test_suites_init(void)				\
> > +	{								\
> > +		unsigned int i;						\
> > +		for (i = 0; suites[i] != NULL; i++)			\
> > +			kunit_run_tests(suites[i]);			\
> > +		return 0;						\
> > +	}								\
> > +	late_initcall(kunit_test_suites_init);				\
> > +	static void __exit kunit_test_suites_exit(void)			\
> > +	{								\
> > +		return;							\
> > +	}								\
> > +	module_exit(kunit_test_suites_exit)
> > +
> > +#define	kunit_test_suite(suite)	kunit_test_suites(suite)
> 
> I think it is fine to just rename this kunit_test_suites.
> 

Will do.

> >  /*
> >   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
> > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > index 2a63241..15161c5 100644
> > --- a/kernel/sysctl-test.c
> > +++ b/kernel/sysctl-test.c
> > @@ -389,4 +389,8 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
> >  	.test_cases = sysctl_test_cases,
> >  };
> >  
> > -kunit_test_suite(sysctl_test_suite);
> > +kunit_test_suite(&sysctl_test_suite);
> > +
> > +#ifdef MODULE
> > +MODULE_LICENSE("GPL");
> > +#endif /* MODULE */
> 
> Here and elsewhere: the "ifdef/endif MODULE" should not be necessary.
> 

Will fix, thanks!

> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index a3017a5..f9f411a6 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1951,10 +1951,10 @@ config TEST_SYSCTL
> >  	  If unsure, say N.
> >  
> >  config SYSCTL_KUNIT_TEST
> > -	bool "KUnit test for sysctl"
> > +	tristate "KUnit test for sysctl"
> >  	depends on KUNIT
> >  	help
> > -	  This builds the proc sysctl unit test, which runs on boot.
> > +	  This builds the proc sysctl unit test, which runs on boot/module load.
> >  	  Tests the API contract and implementation correctness of sysctl.
> >  	  For more information on KUnit and unit tests in general please refer
> >  	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> [...]
> > diff --git a/lib/kunit/example-test.c b/lib/kunit/example-test.c
> > index f64a829..6c6a408 100644
> > --- a/lib/kunit/example-test.c
> > +++ b/lib/kunit/example-test.c
> > @@ -85,4 +85,8 @@ static int example_test_init(struct kunit *test)
> >   * This registers the above test suite telling KUnit that this is a suite of
> >   * tests that need to be run.
> >   */
> > -kunit_test_suite(example_test_suite);
> > +kunit_test_suite(&example_test_suite);
> > +
> > +#ifdef MODULE
> > +MODULE_LICENSE("GPL");
> > +#endif /* MODULE */
> 
> nit: The "ifdef/endif MODULE" should not be necessary.
> 
> > diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> > index 76cc05e..7a3e7a0 100644
> > --- a/lib/kunit/string-stream-test.c
> > +++ b/lib/kunit/string-stream-test.c
> > @@ -45,8 +45,13 @@ static void string_stream_test_get_string(struct kunit *test)
> >  	{}
> >  };
> >  
> > -static struct kunit_suite string_stream_test_suite = {
> > +struct kunit_suite string_stream_test_suite = {
> >  	.name = "string-stream-test",
> >  	.test_cases = string_stream_test_cases
> >  };
> > -kunit_test_suite(string_stream_test_suite);
> > +
> > +kunit_test_suite(&string_stream_test_suite);
> > +
> > +#ifdef MODULE
> > +MODULE_LICENSE("GPL");
> > +#endif /* MODULE */
> > diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> > index e6d17aa..e4f3a97 100644
> > --- a/lib/kunit/string-stream.c
> > +++ b/lib/kunit/string-stream.c
> > @@ -100,6 +100,7 @@ int string_stream_vadd(struct string_stream *stream,
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(string_stream_vadd);
> 
> Is this actually needed by anything other than lib/kunit/test.c right
> now? Maybe we should move the include file into the kunit/ directory to
> hide these so no one else can use them.
>

I tried this, and it's the right answer I think but it exposes
a problem with symbol visibility when kunit is compiled as a module.
More on this below...
 
> >  int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> >  {
> > @@ -112,6 +113,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> >  
> >  	return result;
> >  }
> > +EXPORT_SYMBOL_GPL(string_stream_add);
> [...]
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index c83c0fa..e7896f1 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> [...]
> > @@ -50,6 +51,7 @@ static unsigned long kunit_test_timeout(void)
> >  	 * For more background on this topic, see:
> >  	 * https://mike-bland.com/2011/11/01/small-medium-large.html
> >  	 */
> > +#ifndef MODULE
> 
> Why is this block of code "ifndef MODULE"?
>

Symbol visibility is the problem again; sysctl_hung_task_timeout_secs
isn't exported so when kunit is a module it can't find the symbol.

I think I saw Kees mentioned something about symbol lookup too; in KTF 
Knut solved this by defining ktf_find_symbol(). I'd suggest we may need a 
kunit_find_symbol() with a function signature

void *kunit_find_symbol(const char *modname, const char *symbol_name);

...which does a [module_]kallsyms_lookup_sym().

If the above makes sense I can look at adding it as a patch (and adding
a test of it of course!). What do you think?

> >  	if (sysctl_hung_task_timeout_secs) {
> >  		/*
> >  		 * If sysctl_hung_task is active, just set the timeout to some
> > @@ -60,9 +62,9 @@ static unsigned long kunit_test_timeout(void)
> >  		 */
> >  		timeout_msecs = (sysctl_hung_task_timeout_secs - 1) *
> >  				MSEC_PER_SEC;
> > -	} else {
> > +	} else
> > +#endif
> >  		timeout_msecs = 300 * MSEC_PER_SEC; /* 5 min */
> > -	}
> >  
> >  	return timeout_msecs;
> >  }
> > @@ -106,6 +108,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> >  
> >  	try_catch->catch(try_catch->context);
> >  }
> > +EXPORT_SYMBOL_GPL(kunit_try_catch_run);
> >  
> >  void kunit_try_catch_init(struct kunit_try_catch *try_catch,
> >  			  struct kunit *test,
> > @@ -116,3 +119,4 @@ void kunit_try_catch_init(struct kunit_try_catch *try_catch,
> >  	try_catch->try = try;
> >  	try_catch->catch = catch;
> >  }
> > +EXPORT_SYMBOL_GPL(kunit_try_catch_init);
> 
> This code should also probably be hidden from outside of kunit/.
> 

Sure, will do.

Thanks again for the review!

Alan
