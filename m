Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24394DB64D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 20:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438995AbfJQSgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 14:36:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438924AbfJQSgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:36:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIShVv167648;
        Thu, 17 Oct 2019 18:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=KXCK7K+HVpgKFo6yqG9Oi6xMW6GVtioG6jN2lbxNoXg=;
 b=YVqBqzqWwLcjejiKbemOMHuNbI953Li9m7p4NCiwIScM1MEMJWSJnwWQ0EpGKhl4Jx0r
 NuYK1UZQRnzR3WlWnDkGV2Gz3TU0YJUBfxktahMsMjg2QBstOCimCUNIcIjxUbWsr6U/
 uKkwx0NMTq4EshxcvZE6E+vRLEB5o9jyybrWi3m7bG+1g49u+Y6uCTXUEDGIPtI8t9cO
 30g/SD9SdEf+RBq/ZCT/GTQmyDfi+y9UhuB8vLSoKm8QKyOsZgjSdAqSVtYSS/dGza5D
 /XuCXFlicQTK0uWCFftaqTT86HyCJVsCcH4Rpu2GEI0heQtF5gdlKW051rGLco8ZLb2B sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vk7frr33s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:32:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIRxkN038663;
        Thu, 17 Oct 2019 18:32:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vpcm3d2ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:32:37 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9HIWXKm003507;
        Thu, 17 Oct 2019 18:32:33 GMT
Received: from dhcp-10-175-161-223.vpn.oracle.com (/10.175.161.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:32:33 +0000
Date:   Thu, 17 Oct 2019 19:32:18 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-161-223.vpn.oracle.com
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
In-Reply-To: <20191016230116.GA82401@google.com>
Message-ID: <alpine.LRH.2.20.1910171930410.21739@dhcp-10-175-161-223.vpn.oracle.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com> <1570546546-549-2-git-send-email-alan.maguire@oracle.com> <20191008213535.GB186342@google.com> <alpine.LRH.2.20.1910091726010.2517@dhcp-10-175-191-127.vpn.oracle.com>
 <CAFd5g46_6McK06XSrX=EZ9AaYYitQzd2CTvPMX+rPymisDq5uQ@mail.gmail.com> <alpine.LRH.2.20.1910111105350.21459@dhcp-10-175-191-48.vpn.oracle.com> <20191016230116.GA82401@google.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170165
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Oct 2019, Brendan Higgins wrote:

> On Fri, Oct 11, 2019 at 11:25:33AM +0100, Alan Maguire wrote:
> > On Fri, 11 Oct 2019, Brendan Higgins wrote:
> > 
> > > Sorry for the delayed reply. I will be on vacation until Wednesday,
> > > October 16th.
> > > 
> > > On Wed, Oct 9, 2019 at 9:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >
> > > > On Tue, 8 Oct 2019, Brendan Higgins wrote:
> > > >
> > > > > On Tue, Oct 08, 2019 at 03:55:44PM +0100, Alan Maguire wrote:
> > > [...]
> > > > > > diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> > > > > > index e6d17aa..e4f3a97 100644
> > > > > > --- a/lib/kunit/string-stream.c
> > > > > > +++ b/lib/kunit/string-stream.c
> > > > > > @@ -100,6 +100,7 @@ int string_stream_vadd(struct string_stream *stream,
> > > > > >
> > > > > >     return 0;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL_GPL(string_stream_vadd);
> > > > >
> > > > > Is this actually needed by anything other than lib/kunit/test.c right
> > > > > now? Maybe we should move the include file into the kunit/ directory to
> > > > > hide these so no one else can use them.
> > > > >
> > > >
> > > > I tried this, and it's the right answer I think but it exposes
> > > > a problem with symbol visibility when kunit is compiled as a module.
> > > > More on this below...
> > > >
> > > > > >  int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> > > > > >  {
> > > > > > @@ -112,6 +113,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> > > > > >
> > > > > >     return result;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL_GPL(string_stream_add);
> > > > > [...]
> > > > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > > > index c83c0fa..e7896f1 100644
> > > > > > --- a/lib/kunit/test.c
> > > > > > +++ b/lib/kunit/test.c
> > > > > [...]
> > > > > > @@ -50,6 +51,7 @@ static unsigned long kunit_test_timeout(void)
> > > > > >      * For more background on this topic, see:
> > > > > >      * https://mike-bland.com/2011/11/01/small-medium-large.html
> > > > > >      */
> > > > > > +#ifndef MODULE
> > > > >
> > > > > Why is this block of code "ifndef MODULE"?
> > > > >
> > > >
> > > > Symbol visibility is the problem again; sysctl_hung_task_timeout_secs
> > > > isn't exported so when kunit is a module it can't find the symbol.
> > > >
> > > > I think I saw Kees mentioned something about symbol lookup too; in KTF
> > > > Knut solved this by defining ktf_find_symbol(). I'd suggest we may need a
> > > > kunit_find_symbol() with a function signature
> 
> Based on what you said below, I think the kunit_find_symbol() may have
> value for writing tests; however, I do not think it is the right way to
> handle resources needed by test.c. I think exporting the symbols in this
> case is the lesser of the two evils.
> 

The only symbol we need in core kunit from the kernel when compiling kunit 
as a module is sysctl_hung_task_timeout_secs; it's a core kernel symbol.
There's no issue with symbols within kunit in this case.
 
I've come up with a new way to handle variables and functions in the 
v3 patch set 3 [1] I've sent out. While not being perfect, it attempts to 
satisfy some of the requirements you describe below.   It will generate 
compiler errors if there is a mismatch between local symbol definition and 
the target symbol type.

Symbol variable definitions are handled such that the same symbol name can 
be used; see try-catch.c in patch 5 where we assign 
sysctl_hung_task_timeout_secs.

Unfortunately the same scheme won't work for functions. The reason for 
this is we've already #included a definiton of the function, so if we 
attempt to redefine that same name as a function pointer we get a 
compile-time that we are redefining the symbol.  As a consequence the
approach I took is for us to define a local function pointer and it gets
assigned either to

 - the results of kunit_find_symbol() (module case)
 - the function itself (builtin case)

The latter will trigger a compile-time error if our local definition is 
out of sync.

> I am still suprised that you need to export a symbol that is 
getting
> compiled into and is only used by the kunit module.

see above - kunit needs a non-exported global kernel symbol 
(sysctl_hung_task_timeout_secs).


> In fact, I think I
> found an example in the kernel where someone else managed this. Checkout
> stp_policy_node_priv(). Looks like the symbol is used here[1] and is
> defined here[2]. You can see here[3] and here[4] that the files end up
> in the same module. Do you mind taking a look why it works for stm, but
> not here?
> 
> > > I thought we were just talking about exposing symbols for linking
> > > outside of a compilation unit (static vs. not static); nevertheless, I
> > > think you are right that it is relevant here. Kees, thoughts?
> > > 
> > > > void *kunit_find_symbol(const char *modname, const char *symbol_name);
> > > >
> > > > ...which does a [module_]kallsyms_lookup_sym().
> > > >
> > > > If the above makes sense I can look at adding it as a patch (and adding
> > > > a test of it of course!). What do you think?
> > > 
> > > So that won't work if you are trying to link against a symbol not in a
> > > module, right? Also, it won't work against a static symbol, right?
> > > 
> > 
> > Nope, works in both cases with the proviso that we need to use an
> 
> Nifty! That sounds great!
> 
> > alternative name for symbols when compiling built-in.  For example
> 
> Can you elaborate on "need[ing] to use an alternative name"?
> 

See above and patch 4 in the v3 patchset.

> > in the case of the string-stream tests, we'd use a test init callback
> > to initialize used symbols:
> > 
> > static int string_stream_test_init(struct kunit *test)
> > {
> >         _alloc_string_stream = kunit_find_symbol("alloc_string_stream");
> >         _string_stream_add = kunit_find_symbol("string_stream_add");
> >         _string_stream_get_string = kunit_find_symbol("string_stream_get_string");
> >         _string_stream_is_empty = kunit_find_symbol("string_stream_is_empty");
> >         if (IS_ERR(_alloc_string_stream) ||
> >             IS_ERR(_string_stream_add) ||
> >             IS_ERR(_string_stream_get_string) ||
> >             IS_ERR(_string_stream_is_empty))
> >                 return EINVAL;
> >         return 0;
> > } 
> > 
> > I've tested this when string-stream-test is compiled built-in and as a 
> > module.  We can of course create a wrapper macro to handle these 
> > assignments.
> 
> I've got mixed feelings on this. On one hand, that has the potential to
> solve a lot of problems with visibility and modules in a way that
> doesn't immediately cause code under test to change in undesirable ways.
> On the other hand, I feel that this has the potential to be really prone
> to breakage. It would be much nicer if the compiler could tell you that
> your symbol changed rather than having to wait until you run the test.
> Just having the test tell you that a symbol doesn't exist anymore would
> be mildly annoying, but having the signature of the symbol change could
> get downright frustrating using this method.
> 

See above; if compiled as builtin compiler errors will be generated.

Thanks!

Alan

[1] https://lkml.org/lkml/2019/10/17/801
