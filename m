Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EDDA1D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 01:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405326AbfJPXBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 19:01:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38391 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389689AbfJPXBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:01:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so123779pgt.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I9WFsrimijjIQTTTvra2DRi53E6Nf4wu24Q/ZNw7Ij4=;
        b=GA4zg9r+Cze4L83PgF54iQR1EoR0TvqpiljILydNHik/A9gDCrBlrbIwnXifE0ZvdU
         n5b1V5dRJRWR6k3MYabH6tFFosuk16xAjG8EFLxusOikLtrktJni40LSnvkr2upVRhzE
         lgBceHPvww0z5Nhdg637voAiMDIxJsHK+saTAKPpIK15ZhrBmDA42AjTw3b2FcTOTvZh
         kFaEq2dHrTAw/KOOWSlngsj9NC7F4Ss+2QUfOqKdCorUJ+mil7FQX8WNhrC0pvbcIjuS
         dsKR5n/L7/4ftxh/BUQ5EaqXAX9vgIuhl+GXD4pY4sFJCPcR7E484kBl/as2/ETsyWOI
         KRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I9WFsrimijjIQTTTvra2DRi53E6Nf4wu24Q/ZNw7Ij4=;
        b=YXLpuPV27N+SrKFsXYD1O2tmM/ISVKYKWr1aG+JHip+G+SmqKeDfbgS8x2t1cTBmL0
         1Npakv+Ku7BF0TUe12gK1q/BtOI9wEGzTUtSPr6eHrceHGhJzfdI0sAZxRDKBrDUzF13
         HU7nIaU60vnWGGJcS8YO766qPiNCZxO2a1QajaaQ01W87mvs0JBXO4mC077e+NS7mzOo
         bEU10ajlLnlCtYny8iTDpTcG67ekf/nI050W8JXbsUTu+6Pcqe4S8sJoN/10rLcPM//a
         0+W+Q/Y1QCGS1Fq9UbEtMAPvWyHOHMYxyI85jt35mkAO8mRIKKbhs1Me6AJYEnwEJ57j
         DZ0A==
X-Gm-Message-State: APjAAAXzwi97ly0Z8Y3N12bo74pp1TXKdf1tijxmSqPy6KPJG+medtXp
        k5BhxZuN4KtVz6LK2loAqAAjfg==
X-Google-Smtp-Source: APXvYqxy7dlCISkd8kX9c+KN64/gjeSFBDq0yKJ98CSKO5cWiWTZtyhVjbFpKdLFfIh2N39OMz5wZQ==
X-Received: by 2002:a17:90a:3706:: with SMTP id u6mr443281pjb.107.1571266882056;
        Wed, 16 Oct 2019 16:01:22 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id 69sm97530pgh.47.2019.10.16.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:01:21 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:01:16 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v2 linux-kselftest-test 1/3] kunit: allow kunit tests to
 be loaded as a module
Message-ID: <20191016230116.GA82401@google.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <1570546546-549-2-git-send-email-alan.maguire@oracle.com>
 <20191008213535.GB186342@google.com>
 <alpine.LRH.2.20.1910091726010.2517@dhcp-10-175-191-127.vpn.oracle.com>
 <CAFd5g46_6McK06XSrX=EZ9AaYYitQzd2CTvPMX+rPymisDq5uQ@mail.gmail.com>
 <alpine.LRH.2.20.1910111105350.21459@dhcp-10-175-191-48.vpn.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1910111105350.21459@dhcp-10-175-191-48.vpn.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:25:33AM +0100, Alan Maguire wrote:
> On Fri, 11 Oct 2019, Brendan Higgins wrote:
> 
> > Sorry for the delayed reply. I will be on vacation until Wednesday,
> > October 16th.
> > 
> > On Wed, Oct 9, 2019 at 9:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > On Tue, 8 Oct 2019, Brendan Higgins wrote:
> > >
> > > > On Tue, Oct 08, 2019 at 03:55:44PM +0100, Alan Maguire wrote:
> > [...]
> > > > > diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> > > > > index e6d17aa..e4f3a97 100644
> > > > > --- a/lib/kunit/string-stream.c
> > > > > +++ b/lib/kunit/string-stream.c
> > > > > @@ -100,6 +100,7 @@ int string_stream_vadd(struct string_stream *stream,
> > > > >
> > > > >     return 0;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(string_stream_vadd);
> > > >
> > > > Is this actually needed by anything other than lib/kunit/test.c right
> > > > now? Maybe we should move the include file into the kunit/ directory to
> > > > hide these so no one else can use them.
> > > >
> > >
> > > I tried this, and it's the right answer I think but it exposes
> > > a problem with symbol visibility when kunit is compiled as a module.
> > > More on this below...
> > >
> > > > >  int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> > > > >  {
> > > > > @@ -112,6 +113,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> > > > >
> > > > >     return result;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(string_stream_add);
> > > > [...]
> > > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > > index c83c0fa..e7896f1 100644
> > > > > --- a/lib/kunit/test.c
> > > > > +++ b/lib/kunit/test.c
> > > > [...]
> > > > > @@ -50,6 +51,7 @@ static unsigned long kunit_test_timeout(void)
> > > > >      * For more background on this topic, see:
> > > > >      * https://mike-bland.com/2011/11/01/small-medium-large.html
> > > > >      */
> > > > > +#ifndef MODULE
> > > >
> > > > Why is this block of code "ifndef MODULE"?
> > > >
> > >
> > > Symbol visibility is the problem again; sysctl_hung_task_timeout_secs
> > > isn't exported so when kunit is a module it can't find the symbol.
> > >
> > > I think I saw Kees mentioned something about symbol lookup too; in KTF
> > > Knut solved this by defining ktf_find_symbol(). I'd suggest we may need a
> > > kunit_find_symbol() with a function signature

Based on what you said below, I think the kunit_find_symbol() may have
value for writing tests; however, I do not think it is the right way to
handle resources needed by test.c. I think exporting the symbols in this
case is the lesser of the two evils.

I am still suprised that you need to export a symbol that is getting
compiled into and is only used by the kunit module. In fact, I think I
found an example in the kernel where someone else managed this. Checkout
stp_policy_node_priv(). Looks like the symbol is used here[1] and is
defined here[2]. You can see here[3] and here[4] that the files end up
in the same module. Do you mind taking a look why it works for stm, but
not here?

> > I thought we were just talking about exposing symbols for linking
> > outside of a compilation unit (static vs. not static); nevertheless, I
> > think you are right that it is relevant here. Kees, thoughts?
> > 
> > > void *kunit_find_symbol(const char *modname, const char *symbol_name);
> > >
> > > ...which does a [module_]kallsyms_lookup_sym().
> > >
> > > If the above makes sense I can look at adding it as a patch (and adding
> > > a test of it of course!). What do you think?
> > 
> > So that won't work if you are trying to link against a symbol not in a
> > module, right? Also, it won't work against a static symbol, right?
> > 
> 
> Nope, works in both cases with the proviso that we need to use an

Nifty! That sounds great!

> alternative name for symbols when compiling built-in.  For example

Can you elaborate on "need[ing] to use an alternative name"?

> in the case of the string-stream tests, we'd use a test init callback
> to initialize used symbols:
> 
> static int string_stream_test_init(struct kunit *test)
> {
>         _alloc_string_stream = kunit_find_symbol("alloc_string_stream");
>         _string_stream_add = kunit_find_symbol("string_stream_add");
>         _string_stream_get_string = kunit_find_symbol("string_stream_get_string");
>         _string_stream_is_empty = kunit_find_symbol("string_stream_is_empty");
>         if (IS_ERR(_alloc_string_stream) ||
>             IS_ERR(_string_stream_add) ||
>             IS_ERR(_string_stream_get_string) ||
>             IS_ERR(_string_stream_is_empty))
>                 return EINVAL;
>         return 0;
> } 
> 
> I've tested this when string-stream-test is compiled built-in and as a 
> module.  We can of course create a wrapper macro to handle these 
> assignments.

I've got mixed feelings on this. On one hand, that has the potential to
solve a lot of problems with visibility and modules in a way that
doesn't immediately cause code under test to change in undesirable ways.
On the other hand, I feel that this has the potential to be really prone
to breakage. It would be much nicer if the compiler could tell you that
your symbol changed rather than having to wait until you run the test.
Just having the test tell you that a symbol doesn't exist anymore would
be mildly annoying, but having the signature of the symbol change could
get downright frustrating using this method.

> To illustrate further here's the test cases I'd propose adding to 
> test-test.c with the changes. 
> 
> In the first case we're grabbing the "modules" variable from the kernel,
> and in the second we're grabbing a static symbol from the test-test.ko
> module (when it is compiled as a module):
> 
> /*
>  * Find non-exported kernel symbol; we use the modules list as a safe
>  * choice that should always be present.
>  */
> static void kunit_find_symbol_kernel(struct kunit *test)
> {
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kunit_find_symbol("modules"));
> }
> 
> #ifdef MODULE
> /*
>  * If we are compiled as a module, use this module for lookup.
>  */
> static void kunit_find_symbol_module(struct kunit *test)
> {
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test,
>                                      kunit_find_symbol("kunit_find_symbol_kernel"));
> }
> #endif
> 
>  
> > Even so, I think it is pretty wonky to expect users to either a)
> > export any symbol name to be tested,
> 
> Absolutely not, I'd never advocate that.  Nothing should need to change in 

Cool. Looks like we are on the same page then :-)

> the component under test simply to facilitate testing, especially if 
> there's a way the test framework can work around it.

I would say it depends. I think it is fine to ask people to write code
in such a manner that makes it more testable. From my experience, this
generally leads to better quality code.

Nevertheless, I agree from the perspective that suddenly having to
export symbol names for no good reason is not something we should make
users do.

> > or b) have to access them via
> > kunit_find_symbol.  I think it is fine to have some tests that cannot
> > be compiled as modules, if there is no other user friendly way to make
> > this work in those cases.
> 
> That's fine, and I agree in some cases it's unworkable, but there are 
> going to be a lot of tristate componenets we'd like to test, and 
> restricting testing of those by requiring CONFIG_FOO=y seems like a 
> limitation too.  In practice I've found symbol lookup isn't needed 
> extensively for test development.  For cases where the weight of symbol 
> lookup is too heavy the tests can simply stay built-in - the non-exported 
> nature of the symbols is probably suggesting something about the nature of 
> the interface that makes that a more natural choice anyway.  However for 
> other cases I think there's value to having something like this feature.

I think that makes sense.

So, I don't think the symbol lookup is needed for this patchset. I think
all the symbols that you use should *probably* be exported at worse
since they are used by the core kunit library stuff.

Nevertheless, I have a test coming down the pipeline for which this
could be a potential solution. I will CC you on the test when I send it.

> Of course there may be better ways to realize the functionality than what 
> I'm proposing.

Cheers!

[1] https://elixir.bootlin.com/linux/v5.3.6/source/drivers/hwtracing/stm/core.c#L322
[2] https://elixir.bootlin.com/linux/v5.3.6/source/drivers/hwtracing/stm/policy.c#L40
[3] https://elixir.bootlin.com/linux/v5.3.6/source/drivers/hwtracing/stm/Makefile#L4
[4] https://elixir.bootlin.com/linux/v5.3.6/source/drivers/hwtracing/stm/Kconfig#L3
