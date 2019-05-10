Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E728619CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEJLi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 07:38:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50472 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfEJLi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 07:38:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ABYWes171319;
        Fri, 10 May 2019 11:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=uItGwRyuCRl9mmMVE4L1Nw0evDm9cO6EMsr+QrxE1/A=;
 b=k9cS+0ywWXeSgoEi0SAQbHlb06pfmBXrzpN+ls/IsTNn3NUiveSsZY4BwlTdkXuBhr2O
 BeVLun70BPgzomOjtFsyxVthxh3p2vFt/I/E7Q1j9wOLWPLSZz6dVmpPbF6Yg0JXk6Vy
 O9OWRCAAx1S3v8cmGJHsE8EtAcga21uP6q2J1VCRNiyaRz4qkX10C43O4e+PCjo4J741
 klmLg6mOyBPai16avfiHB+DfTrOH/kdgdzjj5YgWWy3fPZtrfLK9ighSM0JC4uiNrQQQ
 3gat1JBOOTEZpYUAlbbdc7W3Q2Xz9q9L+fqVoRIkkGahlP3vK6YVdAY4XOnhrSX5Key1 tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s94bggf39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 11:37:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ABbGD5078991;
        Fri, 10 May 2019 11:37:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2scpy67a12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 11:37:19 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4ABb2aY018536;
        Fri, 10 May 2019 11:37:02 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 04:37:01 -0700
Message-ID: <0a1659f2abb2cba109ba588e4a87bda252c57be6.camel@oracle.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tim.Bird@sony.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, sboyd@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Date:   Fri, 10 May 2019 13:36:54 +0200
In-Reply-To: <CAKMK7uFd1xUx8u3xWLwifVSq4OEnMO4S-m0hESe68UzONXnMFg@mail.gmail.com>
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
         <20190509233043.GC20877@mit.edu>
         <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
         <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
         <a1b88d5add15d43de0468c32d9a2427629337abb.camel@oracle.com>
         <CAKMK7uFd1xUx8u3xWLwifVSq4OEnMO4S-m0hESe68UzONXnMFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100082
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100082
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-05-10 at 10:12 +0200, Daniel Vetter wrote:
> On Fri, May 10, 2019 at 7:49 AM Knut Omang <knut.omang@oracle.com> wrote:
> >
> > On Thu, 2019-05-09 at 22:18 -0700, Frank Rowand wrote:
> > > On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
> > > >
> > > >
> > > > On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
> > > >> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
> > > >>>
> > > >>> The second item, arguably, does have significant overlap with kselftest.
> > > >>> Whether you are running short tests in a light weight UML environment or
> > > >>> higher level tests in an heavier VM the two could be using the same
> > > >>> framework for writing or defining in-kernel tests. It *may* also be valuable
> > > >>> for some people to be able to run all the UML tests in the heavy VM
> > > >>> environment along side other higher level tests.
> > > >>>
> > > >>> Looking at the selftests tree in the repo, we already have similar items to
> > > >>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
> > > >>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
> > > >>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
> > > >>>
> > > >>> However, the number of users of this harness appears to be quite small. Most
> > > >>> of the code in the selftests tree seems to be a random mismash of scripts
> > > >>> and userspace code so it's not hard to see it as something completely
> > > >>> different from the new Kunit:
> > > >>>
> > > >>> $ git grep --files-with-matches kselftest_harness.h *
> > > >>
> > > >> To the extent that we can unify how tests are written, I agree that
> > > >> this would be a good thing.  However, you should note that
> > > >> kselftest_harness.h is currently assums that it will be included in
> > > >> userspace programs.  This is most obviously seen if you look closely
> > > >> at the functions defined in the header files which makes calls to
> > > >> fork(), abort() and fprintf().
> > > >
> > > > Ah, yes. I obviously did not dig deep enough. Using kunit for
> > > > in-kernel tests and kselftest_harness for userspace tests seems like
> > > > a sensible line to draw to me. Trying to unify kernel and userspace
> > > > here sounds like it could be difficult so it's probably not worth
> > > > forcing the issue unless someone wants to do some really fancy work
> > > > to get it done.
> > > >
> > > > Based on some of the other commenters, I was under the impression
> > > > that kselftests had in-kernel tests but I'm not sure where or if they
> > > > exist.
> > >
> > > YES, kselftest has in-kernel tests.  (Excuse the shouting...)
> > >
> > > Here is a likely list of them in the kernel source tree:
> > >
> > > $ grep module_init lib/test_*.c
> > > lib/test_bitfield.c:module_init(test_bitfields)
> > > lib/test_bitmap.c:module_init(test_bitmap_init);
> > > lib/test_bpf.c:module_init(test_bpf_init);
> > > lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
> > > lib/test_firmware.c:module_init(test_firmware_init);
> > > lib/test_hash.c:module_init(test_hash_init);  /* Does everything */
> > > lib/test_hexdump.c:module_init(test_hexdump_init);
> > > lib/test_ida.c:module_init(ida_checks);
> > > lib/test_kasan.c:module_init(kmalloc_tests_init);
> > > lib/test_list_sort.c:module_init(list_sort_test);
> > > lib/test_memcat_p.c:module_init(test_memcat_p_init);
> > > lib/test_module.c:static int __init test_module_init(void)
> > > lib/test_module.c:module_init(test_module_init);
> > > lib/test_objagg.c:module_init(test_objagg_init);
> > > lib/test_overflow.c:static int __init test_module_init(void)
> > > lib/test_overflow.c:module_init(test_module_init);
> > > lib/test_parman.c:module_init(test_parman_init);
> > > lib/test_printf.c:module_init(test_printf_init);
> > > lib/test_rhashtable.c:module_init(test_rht_init);
> > > lib/test_siphash.c:module_init(siphash_test_init);
> > > lib/test_sort.c:module_init(test_sort_init);
> > > lib/test_stackinit.c:module_init(test_stackinit_init);
> > > lib/test_static_key_base.c:module_init(test_static_key_base_init);
> > > lib/test_static_keys.c:module_init(test_static_key_init);
> > > lib/test_string.c:module_init(string_selftest_init);
> > > lib/test_ubsan.c:module_init(test_ubsan_init);
> > > lib/test_user_copy.c:module_init(test_user_copy_init);
> > > lib/test_uuid.c:module_init(test_uuid_init);
> > > lib/test_vmalloc.c:module_init(vmalloc_test_init)
> > > lib/test_xarray.c:module_init(xarray_checks);
> > >
> > >
> > > > If they do exists, it seems like it would make sense to
> > > > convert those to kunit and have Kunit tests run-able in a VM or
> > > > baremetal instance.
> > >
> > > They already run in a VM.
> > >
> > > They already run on bare metal.
> > >
> > > They already run in UML.
> > >
> > > This is not to say that KUnit does not make sense.  But I'm still trying
> > > to get a better description of the KUnit features (and there are
> > > some).
> >
> > FYI, I have a master student who looks at converting some of these to KTF, such as for
> > instance the XArray tests, which lended themselves quite good to a semi-automated
> > conversion.
> >
> > The result is also a somewhat more compact code as well as the flexibility
> > provided by the Googletest executor and the KTF frameworks, such as running selected
> > tests, output formatting, debugging features etc.
> 
> So is KTF already in upstream? 

No..

> Or is the plan to unify the KTF and
> Kunit in-kernel test harnesses? 

Since KTF delegates reporting and test running to user space - reporting is based on
netlink communication with the user land frontend (Googletest based, but can in principle
be ported to any user land framework if need be) - little specific test harness features
are needed for KTF, so there's little if no direct overlap with the infrastructure in
kselftests (as far as I understand, I'd like to spend more time on the details there..)

> Because there's tons of these
> in-kernel unit tests already, and every merge we get more (Frank's
> list didn't even look into drivers or anywhere else, e.g. it's missing
> the locking self tests I worked on in the past), and a more structured
> approach would really be good.

That's been my thinking too. Having a unified way to gradually move to would benefit
anyone who needs to relate to these tests in that there will be less to learn.
But that would be a long term evolutionary goal of course.

Also I think each of these test suites/sets would benefit from being more available for
running even in kernels not made specifically for testing, and I think using the module
structure and a lean, common module (ktf.ko) as a library for the tests, but no
"polluting" of the "production" kernel code with anything else, is a kind of a policy that
comes implicitly with KTF that can make it easier to maintain a sort of standard
"language" for writing kernel tests. 

Wrt KTF, we're working on making a suitable patch set for the kernel,
but also have projects running internally that uses KTF as a standalone git repository,
and that inspires new features and other changes, as well as a growing set of tests. 
I want to make sure we find a good candidate kernel integration that can coexist nicely
with the separate git repo version without becoming too much of a back/forward porting
challenge.

Knut

> -Daniel

