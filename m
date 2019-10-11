Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82238D3D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 12:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfJKK0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 06:26:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfJKK0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:26:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BAO4Oq013108;
        Fri, 11 Oct 2019 10:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=RCbQWCPP7lHcb8exiNWxq2WV2sbQXnSqSnI0kzbr6PQ=;
 b=aDFfvbEguiVYlSs/2ebtjuV9OtSmNZlRiY+vOYlgT3BITTXZqq6Fgs3vmSYKIEnTWusz
 rMeNkAHfTHfVUueAPbiyPzeb67mz9LuHeX/5y4uRfg+m8S2JWHaFGG6ZmhaWh9dSIr1D
 ZyPykbQkhkGNez+EC6FV5PaOBZXqt3fT1JEmdvT71Fo1n0vt+Mrs4zwOJRppomK26tom
 W3FmfABYwdAEFDRgQ+jjpvMoeY+/8kvwdfheWpnRHjyjFtM4G/+UjJWEhqZ5W+g2JyWo
 8IX4/jywKyFkSbAwaTrtN1K+LS15a0Uqbwsw/l6sUtyZsQ/YFXcSF+MNQRZb+0weInVa 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vekts0eq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 10:26:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BAOx1O121361;
        Fri, 11 Oct 2019 10:26:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vje2xqscj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 10:26:06 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9BAQ31E003053;
        Fri, 11 Oct 2019 10:26:03 GMT
Received: from dhcp-10-175-168-195.vpn.oracle.com (/10.175.168.195)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 03:26:03 -0700
Date:   Fri, 11 Oct 2019 11:25:33 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-191-48.vpn.oracle.com
To:     Brendan Higgins <brendanhiggins@google.com>
cc:     Alan Maguire <alan.maguire@oracle.com>,
        Kees Cook <keescook@chromium.org>,
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
In-Reply-To: <CAFd5g46_6McK06XSrX=EZ9AaYYitQzd2CTvPMX+rPymisDq5uQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1910111105350.21459@dhcp-10-175-191-48.vpn.oracle.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com> <1570546546-549-2-git-send-email-alan.maguire@oracle.com> <20191008213535.GB186342@google.com> <alpine.LRH.2.20.1910091726010.2517@dhcp-10-175-191-127.vpn.oracle.com>
 <CAFd5g46_6McK06XSrX=EZ9AaYYitQzd2CTvPMX+rPymisDq5uQ@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110099
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 11 Oct 2019, Brendan Higgins wrote:

> Sorry for the delayed reply. I will be on vacation until Wednesday,
> October 16th.
> 
> On Wed, Oct 9, 2019 at 9:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On Tue, 8 Oct 2019, Brendan Higgins wrote:
> >
> > > On Tue, Oct 08, 2019 at 03:55:44PM +0100, Alan Maguire wrote:
> [...]
> > > > diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> > > > index e6d17aa..e4f3a97 100644
> > > > --- a/lib/kunit/string-stream.c
> > > > +++ b/lib/kunit/string-stream.c
> > > > @@ -100,6 +100,7 @@ int string_stream_vadd(struct string_stream *stream,
> > > >
> > > >     return 0;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(string_stream_vadd);
> > >
> > > Is this actually needed by anything other than lib/kunit/test.c right
> > > now? Maybe we should move the include file into the kunit/ directory to
> > > hide these so no one else can use them.
> > >
> >
> > I tried this, and it's the right answer I think but it exposes
> > a problem with symbol visibility when kunit is compiled as a module.
> > More on this below...
> >
> > > >  int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> > > >  {
> > > > @@ -112,6 +113,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> > > >
> > > >     return result;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(string_stream_add);
> > > [...]
> > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > index c83c0fa..e7896f1 100644
> > > > --- a/lib/kunit/test.c
> > > > +++ b/lib/kunit/test.c
> > > [...]
> > > > @@ -50,6 +51,7 @@ static unsigned long kunit_test_timeout(void)
> > > >      * For more background on this topic, see:
> > > >      * https://mike-bland.com/2011/11/01/small-medium-large.html
> > > >      */
> > > > +#ifndef MODULE
> > >
> > > Why is this block of code "ifndef MODULE"?
> > >
> >
> > Symbol visibility is the problem again; sysctl_hung_task_timeout_secs
> > isn't exported so when kunit is a module it can't find the symbol.
> >
> > I think I saw Kees mentioned something about symbol lookup too; in KTF
> > Knut solved this by defining ktf_find_symbol(). I'd suggest we may need a
> > kunit_find_symbol() with a function signature
> 
> I thought we were just talking about exposing symbols for linking
> outside of a compilation unit (static vs. not static); nevertheless, I
> think you are right that it is relevant here. Kees, thoughts?
> 
> > void *kunit_find_symbol(const char *modname, const char *symbol_name);
> >
> > ...which does a [module_]kallsyms_lookup_sym().
> >
> > If the above makes sense I can look at adding it as a patch (and adding
> > a test of it of course!). What do you think?
> 
> So that won't work if you are trying to link against a symbol not in a
> module, right? Also, it won't work against a static symbol, right?
> 

Nope, works in both cases with the proviso that we need to use an 
alternative name for symbols when compiling built-in.  For example
in the case of the string-stream tests, we'd use a test init callback
to initialize used symbols:

static int string_stream_test_init(struct kunit *test)
{
        _alloc_string_stream = kunit_find_symbol("alloc_string_stream");
        _string_stream_add = kunit_find_symbol("string_stream_add");
        _string_stream_get_string = kunit_find_symbol("string_stream_get_string");
        _string_stream_is_empty = kunit_find_symbol("string_stream_is_empty");
        if (IS_ERR(_alloc_string_stream) ||
            IS_ERR(_string_stream_add) ||
            IS_ERR(_string_stream_get_string) ||
            IS_ERR(_string_stream_is_empty))
                return EINVAL;
        return 0;
} 

I've tested this when string-stream-test is compiled built-in and as a 
module.  We can of course create a wrapper macro to handle these 
assignments.

To illustrate further here's the test cases I'd propose adding to 
test-test.c with the changes. 

In the first case we're grabbing the "modules" variable from the kernel,
and in the second we're grabbing a static symbol from the test-test.ko
module (when it is compiled as a module):

/*
 * Find non-exported kernel symbol; we use the modules list as a safe
 * choice that should always be present.
 */
static void kunit_find_symbol_kernel(struct kunit *test)
{
        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kunit_find_symbol("modules"));
}

#ifdef MODULE
/*
 * If we are compiled as a module, use this module for lookup.
 */
static void kunit_find_symbol_module(struct kunit *test)
{
        KUNIT_ASSERT_NOT_ERR_OR_NULL(test,
                                     kunit_find_symbol("kunit_find_symbol_kernel"));
}
#endif

 
> Even so, I think it is pretty wonky to expect users to either a)
> export any symbol name to be tested,

Absolutely not, I'd never advocate that.  Nothing should need to change in 
the component under test simply to facilitate testing, especially if 
there's a way the test framework can work around it.

> or b) have to access them via
> kunit_find_symbol.  I think it is fine to have some tests that cannot
> be compiled as modules, if there is no other user friendly way to make
> this work in those cases.

That's fine, and I agree in some cases it's unworkable, but there are 
going to be a lot of tristate componenets we'd like to test, and 
restricting testing of those by requiring CONFIG_FOO=y seems like a 
limitation too.  In practice I've found symbol lookup isn't needed 
extensively for test development.  For cases where the weight of symbol 
lookup is too heavy the tests can simply stay built-in - the non-exported 
nature of the symbols is probably suggesting something about the nature of 
the interface that makes that a more natural choice anyway.  However for 
other cases I think there's value to having something like this feature.
Of course there may be better ways to realize the functionality than what 
I'm proposing.

Thanks!

Alan 

