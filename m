Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD491A6D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 08:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfEKGUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 02:20:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41464 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfEKGUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 02:20:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4B6FGZ5010938;
        Sat, 11 May 2019 06:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=ekuvjw4pRx+T6EbkpGPxPGJKcrJMtTY8jFhetlnXDVE=;
 b=mcYx5lde2snrweEEgzRjEYghJw6RjXkuR4fCvNCMr1FxY+HgOoLRVGBS7c9bTUb+Uz8F
 uR5zJO3MZNWNWhlpYHKUCpUtFvluS8xJYG6xdOB4vDe4YfX1k3N4NXW9/lz5oUnyhlOb
 sF2zLc6MXCrqmBDxIkPqzd8fkly0Ns8PvFX4i3ImHXIJt5aixtApiy3feo1IVFmZJnQM
 Bup5U9LP4BgdzV964wnmoY6utq4aTKmT8LTj+ZLp7TrDVLrHWZmcIW6WEiTctOlsp8P9
 HsYtEgeZk721vz7sqcDGfiYRH3boLr8Af31ITgBKAsJKp+7XS6Bo8t/ezMvPvIH14gfS Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sdntt89bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 06:18:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4B6IANU185336;
        Sat, 11 May 2019 06:18:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2sdkgsu7fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 06:18:16 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4B6Hw1o013803;
        Sat, 11 May 2019 06:17:58 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 23:17:58 -0700
Message-ID: <b3dd7e40149184f5823b66764a20dee3c9905ed1.camel@oracle.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     Frank Rowand <frowand.list@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Date:   Sat, 11 May 2019 08:17:47 +0200
In-Reply-To: <ccec4818-1b9d-2554-e0e4-433eba659c8e@gmail.com>
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
         <CAFd5g47Fvafwgh15JNfxSBRf5qqG2z+V+XGAB2cJtNnHFTiFfQ@mail.gmail.com>
         <1781164863be8d21a7e1890ae6dfee9be101d0a0.camel@oracle.com>
         <CAFd5g46fn4nB-nd27-qj8BoC2h-dTCa=WMGoFNhgXDXY0xOdeg@mail.gmail.com>
         <ccec4818-1b9d-2554-e0e4-433eba659c8e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9253 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905110042
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9253 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905110042
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-05-10 at 15:18 -0700, Frank Rowand wrote:
> On 5/10/19 1:54 PM, Brendan Higgins wrote:
> > On Fri, May 10, 2019 at 5:13 AM Knut Omang <knut.omang@oracle.com> wrote:
> >> On Fri, 2019-05-10 at 03:23 -0700, Brendan Higgins wrote:
> >>>> On Fri, May 10, 2019 at 7:49 AM Knut Omang <knut.omang@oracle.com> wrote:
> >>>>>
> >>>>> On Thu, 2019-05-09 at 22:18 -0700, Frank Rowand wrote:
> >>>>>> On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
> >>>>>>>> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
> >>>>>>>>>
> >>>>>>>>> The second item, arguably, does have significant overlap with kselftest.
> >>>>>>>>> Whether you are running short tests in a light weight UML environment or
> >>>>>>>>> higher level tests in an heavier VM the two could be using the same
> >>>>>>>>> framework for writing or defining in-kernel tests. It *may* also be valuable
> >>>>>>>>> for some people to be able to run all the UML tests in the heavy VM
> >>>>>>>>> environment along side other higher level tests.
> >>>>>>>>>
> >>>>>>>>> Looking at the selftests tree in the repo, we already have similar items to
> >>>>>>>>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
> >>>>>>>>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
> >>>>>>>>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
> >>>>>>>>>
> >>>>>>>>> However, the number of users of this harness appears to be quite small. Most
> >>>>>>>>> of the code in the selftests tree seems to be a random mismash of scripts
> >>>>>>>>> and userspace code so it's not hard to see it as something completely
> >>>>>>>>> different from the new Kunit:
> >>>>>>>>>
> >>>>>>>>> $ git grep --files-with-matches kselftest_harness.h *
> >>>>>>>>
> >>>>>>>> To the extent that we can unify how tests are written, I agree that
> >>>>>>>> this would be a good thing.  However, you should note that
> >>>>>>>> kselftest_harness.h is currently assums that it will be included in
> >>>>>>>> userspace programs.  This is most obviously seen if you look closely
> >>>>>>>> at the functions defined in the header files which makes calls to
> >>>>>>>> fork(), abort() and fprintf().
> >>>>>>>
> >>>>>>> Ah, yes. I obviously did not dig deep enough. Using kunit for
> >>>>>>> in-kernel tests and kselftest_harness for userspace tests seems like
> >>>>>>> a sensible line to draw to me. Trying to unify kernel and userspace
> >>>>>>> here sounds like it could be difficult so it's probably not worth
> >>>>>>> forcing the issue unless someone wants to do some really fancy work
> >>>>>>> to get it done.
> >>>>>>>
> >>>>>>> Based on some of the other commenters, I was under the impression
> >>>>>>> that kselftests had in-kernel tests but I'm not sure where or if they
> >>>>>>> exist.
> >>>>>>
> >>>>>> YES, kselftest has in-kernel tests.  (Excuse the shouting...)
> >>>>>>
> >>>>>> Here is a likely list of them in the kernel source tree:
> >>>>>>
> >>>>>> $ grep module_init lib/test_*.c
> >>>>>> lib/test_bitfield.c:module_init(test_bitfields)
> >>>>>> lib/test_bitmap.c:module_init(test_bitmap_init);
> >>>>>> lib/test_bpf.c:module_init(test_bpf_init);
> >>>>>> lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
> >>>>>> lib/test_firmware.c:module_init(test_firmware_init);
> >>>>>> lib/test_hash.c:module_init(test_hash_init);  /* Does everything */
> >>>>>> lib/test_hexdump.c:module_init(test_hexdump_init);
> >>>>>> lib/test_ida.c:module_init(ida_checks);
> >>>>>> lib/test_kasan.c:module_init(kmalloc_tests_init);
> >>>>>> lib/test_list_sort.c:module_init(list_sort_test);
> >>>>>> lib/test_memcat_p.c:module_init(test_memcat_p_init);
> >>>>>> lib/test_module.c:static int __init test_module_init(void)
> >>>>>> lib/test_module.c:module_init(test_module_init);
> >>>>>> lib/test_objagg.c:module_init(test_objagg_init);
> >>>>>> lib/test_overflow.c:static int __init test_module_init(void)
> >>>>>> lib/test_overflow.c:module_init(test_module_init);
> >>>>>> lib/test_parman.c:module_init(test_parman_init);
> >>>>>> lib/test_printf.c:module_init(test_printf_init);
> >>>>>> lib/test_rhashtable.c:module_init(test_rht_init);
> >>>>>> lib/test_siphash.c:module_init(siphash_test_init);
> >>>>>> lib/test_sort.c:module_init(test_sort_init);
> >>>>>> lib/test_stackinit.c:module_init(test_stackinit_init);
> >>>>>> lib/test_static_key_base.c:module_init(test_static_key_base_init);
> >>>>>> lib/test_static_keys.c:module_init(test_static_key_init);
> >>>>>> lib/test_string.c:module_init(string_selftest_init);
> >>>>>> lib/test_ubsan.c:module_init(test_ubsan_init);
> >>>>>> lib/test_user_copy.c:module_init(test_user_copy_init);
> >>>>>> lib/test_uuid.c:module_init(test_uuid_init);
> >>>>>> lib/test_vmalloc.c:module_init(vmalloc_test_init)
> >>>>>> lib/test_xarray.c:module_init(xarray_checks);
> >>>>>>
> >>>>>>
> >>>>>>> If they do exists, it seems like it would make sense to
> >>>>>>> convert those to kunit and have Kunit tests run-able in a VM or
> >>>>>>> baremetal instance.
> >>>>>>
> >>>>>> They already run in a VM.
> >>>>>>
> >>>>>> They already run on bare metal.
> >>>>>>
> >>>>>> They already run in UML.
> >>>>>>
> >>>>>> This is not to say that KUnit does not make sense.  But I'm still trying
> >>>>>> to get a better description of the KUnit features (and there are
> >>>>>> some).
> >>>>>
> >>>>> FYI, I have a master student who looks at converting some of these to KTF, such as
> >>> for
> >>>>> instance the XArray tests, which lended themselves quite good to a semi-automated
> >>>>> conversion.
> >>>>>
> >>>>> The result is also a somewhat more compact code as well as the flexibility
> >>>>> provided by the Googletest executor and the KTF frameworks, such as running
> selected
> >>>>> tests, output formatting, debugging features etc.
> >>>>
> >>>> So is KTF already in upstream? Or is the plan to unify the KTF and
> >>>
> >>> I am not certain about KTF's upstream plans, but I assume that Knut
> >>> would have CC'ed me on the thread if he had started working on it.
> >>
> >> You are on the Github watcher list for KTF?
> > 
> > Yep! I have been since LPC in 2017.
> > 
> >> Quite a few of the commits there are preparatory for a forthcoming kernel patch set.
> >> I'll of course CC: you on the patch set when we send it to the list.
> > 
> > Awesome! I appreciate it.
> > 
> >>
> >>>> Kunit in-kernel test harnesses? Because there's tons of these
> >>>
> >>> No, no plan. Knut and I talked about this a good while ago and it
> >>> seemed that we had pretty fundamentally different approaches both in
> >>> terms of implementation and end goal. Combining them seemed pretty
> >>> infeasible, at least from a technical perspective. Anyway, I am sure
> >>> Knut would like to give him perspective on the matter and I don't want
> >>> to say too much without first giving him a chance to chime in on the
> >>> matter.
> >>
> >> I need more time to study KUnit details to say, but from a 10k feet perspective:
> >> I think at least there's a potential for some API unification, in using the same
> macro
> >> names. How about removing the KUNIT_ prefix to the test macros ;-) ?
> > 
> > Heh, heh. That's actually the way I had it in the earliest versions of
> > KUnit! But that was pretty much the very first thing everyone
> > complained about. I think I went from no prefix (like you are
> > suggesting) to TEST_* before the first version of the RFC at the
> > request of several people I was kicking the idea around with, and then
> > I think I was asked to go from TEST_* to KUNIT_* in the very first
> > revision of the RFC.
> > 
> > In short, I am sympathetic to your suggestion, but I think that is
> > non-negotiable at this point. The community has a clear policy in
> > place on the matter, and at this point I would really prefer not to
> > change all the symbol names again.
> 
> This would not be the first time that a patch submitter has been
> told "do B instead of A" for version 1, then told "do C instead of
> B" for version 2, then told "do A instead of C" for the final version.
> 
> It sucks, but it happens.

Sorry, I must have overlooked the B instead of A instance - otherwise 
I would have objected against it - in addition to the recognizability 
and portability issue I think it is important that these primitives are
not unnecessary long since they will be written a *lot* of times if things go 
our way.

And the reason for using unique names elsewhere is to be able to co-exist with
other components with the same needs. In the case of tests, I believe they are 
in a different category, they are not supposed to be part of production kernels,
and we want them to be used all over, that should warrant having the ASSERT_ and EXPECT_
prefixes "reserved" for the purpose, so I would urge some pragmatism here!

> As an aside, can you point to where the "clear policy in place" is
> documented, and what the policy is?
> 
> -Frank
> 
> 
> >> That would make the names shorter, saving typing when writing tests, and storage ;-)
> >> and also make the names more similar to KTF's, and those of user land unit test
> > 
> > You mean the Googletest/Googlemock expectations/assertions?
> > 
> > It's a great library (with not so great a name), but unfortunately it
> > is written in C++, which I think pretty much counts it out here.

Using a similar syntax is a good thing, since it makes it easier for people
who write tests in user land frameworks to contribute to the kernel tests.
And if, lets say, someone later comes up with a way to run the KUnit tests in "real" 
user land within Googletest ;-) then less editing would be needed..

> >> frameworks? Also it will make it possible to have functions compiling both with KTF
> and
> >> KUnit, facilitating moving code between the two.
> > 
> > I think that would be cool, but again, I don't think this will be
> > possible with Googletest/Googlemock.

I was thinking of moves between KUnit tests and KTF tests, kernel code only.
Some test functions may easily be usable both in a "pure" mocking environment
and in an integrated setting with hardware/driver/userspace dependencies.

> >>
> >> Also the string stream facilities of KUnit looks interesting to share.
> > 
> > I am glad you think so!
> > 
> > If your biggest concern on my side is test macro names (which I think
> > is a no-go as I mentioned above), I think we should be in pretty good
> > shape once you are ready to move forward. Besides, I have a lot more
> > KUnit patches coming after this: landing this patchset is just the
> > beginning. So how about we keep moving forward on this patchset?

I think the importance of a well thought through 
test API definition is not to be underestimated 
- the sooner we can unify and establish a common base, the better, 
I think.

My other concern is, as mentioned earlier, whether UML is really that 
different from just running in a VM wrt debugging support, and that 
there exists a better approach based on automatically generating 
an environment where the test code and the source under test 
can be compiled in a normal user land program. But it seems 
there are enough clients of the UML approach to justify it 
as a lightweight entry. We want to make it easy and inexcusable 
not to test the code, having a low bar of entry is certainly good. 
Other than that, I really would need to spend some more time with 
the details on KUnit to verify my so far fairly 
shallow observations!

Thanks,
Knut

