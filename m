Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9E1982F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 07:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfEJFuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 01:50:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48710 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfEJFun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 01:50:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4A5YSCp094435;
        Fri, 10 May 2019 05:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=mW6USFzHD2GNOTvWz0gHOZzcMZNk/gcomd2yEIGo/qM=;
 b=oMgzP39/zn9jTWtr4ZiWiucH1bX+nBrXDsJ1Um7eoYKYZoPl7NmBc8y/sAZcow59DGMz
 K5meobDtbihRLjIWL24N2VTDNodLvROj4EON466lGJDKi+bfDNjpgtrq2mvre+SXyzEg
 D7723EvhLzq4O/oVdeHwWN0HayCNzdbmU7tBIsg1lLytWGQkUwhRZYzwsjUk/XPse8kU
 s1OY0Clpp5Ap2wsCGieAVjLepkRTL3eClJxAs/VS2s7KRzVHxaWjV3TocUtn2vAAF0HA
 N7hqPh47ZrkbCYXXnpvxKjuZWp1S9v9MgCTOGsxy/eCgtnyNXF6DeR7RV2ss7T2gpToW fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s94b6evn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 05:48:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4A5lxlR058431;
        Fri, 10 May 2019 05:48:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2sagyvn2nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 05:48:58 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4A5mhCU004058;
        Fri, 10 May 2019 05:48:43 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 22:48:43 -0700
Message-ID: <a1b88d5add15d43de0468c32d9a2427629337abb.camel@oracle.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     Frank Rowand <frowand.list@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tim.Bird@sony.com,
        gregkh@linuxfoundation.org, brendanhiggins@google.com,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
Date:   Fri, 10 May 2019 07:48:35 +0200
In-Reply-To: <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100041
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100040
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-05-09 at 22:18 -0700, Frank Rowand wrote:
> On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
> > 
> > 
> > On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
> >> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
> >>>
> >>> The second item, arguably, does have significant overlap with kselftest.
> >>> Whether you are running short tests in a light weight UML environment or
> >>> higher level tests in an heavier VM the two could be using the same
> >>> framework for writing or defining in-kernel tests. It *may* also be valuable
> >>> for some people to be able to run all the UML tests in the heavy VM
> >>> environment along side other higher level tests.
> >>>
> >>> Looking at the selftests tree in the repo, we already have similar items to
> >>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
> >>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
> >>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
> >>>
> >>> However, the number of users of this harness appears to be quite small. Most
> >>> of the code in the selftests tree seems to be a random mismash of scripts
> >>> and userspace code so it's not hard to see it as something completely
> >>> different from the new Kunit:
> >>>
> >>> $ git grep --files-with-matches kselftest_harness.h *
> >>
> >> To the extent that we can unify how tests are written, I agree that
> >> this would be a good thing.  However, you should note that
> >> kselftest_harness.h is currently assums that it will be included in
> >> userspace programs.  This is most obviously seen if you look closely
> >> at the functions defined in the header files which makes calls to
> >> fork(), abort() and fprintf().
> > 
> > Ah, yes. I obviously did not dig deep enough. Using kunit for
> > in-kernel tests and kselftest_harness for userspace tests seems like
> > a sensible line to draw to me. Trying to unify kernel and userspace
> > here sounds like it could be difficult so it's probably not worth
> > forcing the issue unless someone wants to do some really fancy work
> > to get it done.
> > 
> > Based on some of the other commenters, I was under the impression
> > that kselftests had in-kernel tests but I'm not sure where or if they
> > exist.
> 
> YES, kselftest has in-kernel tests.  (Excuse the shouting...)
> 
> Here is a likely list of them in the kernel source tree:
> 
> $ grep module_init lib/test_*.c
> lib/test_bitfield.c:module_init(test_bitfields)
> lib/test_bitmap.c:module_init(test_bitmap_init);
> lib/test_bpf.c:module_init(test_bpf_init);
> lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
> lib/test_firmware.c:module_init(test_firmware_init);
> lib/test_hash.c:module_init(test_hash_init);	/* Does everything */
> lib/test_hexdump.c:module_init(test_hexdump_init);
> lib/test_ida.c:module_init(ida_checks);
> lib/test_kasan.c:module_init(kmalloc_tests_init);
> lib/test_list_sort.c:module_init(list_sort_test);
> lib/test_memcat_p.c:module_init(test_memcat_p_init);
> lib/test_module.c:static int __init test_module_init(void)
> lib/test_module.c:module_init(test_module_init);
> lib/test_objagg.c:module_init(test_objagg_init);
> lib/test_overflow.c:static int __init test_module_init(void)
> lib/test_overflow.c:module_init(test_module_init);
> lib/test_parman.c:module_init(test_parman_init);
> lib/test_printf.c:module_init(test_printf_init);
> lib/test_rhashtable.c:module_init(test_rht_init);
> lib/test_siphash.c:module_init(siphash_test_init);
> lib/test_sort.c:module_init(test_sort_init);
> lib/test_stackinit.c:module_init(test_stackinit_init);
> lib/test_static_key_base.c:module_init(test_static_key_base_init);
> lib/test_static_keys.c:module_init(test_static_key_init);
> lib/test_string.c:module_init(string_selftest_init);
> lib/test_ubsan.c:module_init(test_ubsan_init);
> lib/test_user_copy.c:module_init(test_user_copy_init);
> lib/test_uuid.c:module_init(test_uuid_init);
> lib/test_vmalloc.c:module_init(vmalloc_test_init)
> lib/test_xarray.c:module_init(xarray_checks);
> 
> 
> > If they do exists, it seems like it would make sense to
> > convert those to kunit and have Kunit tests run-able in a VM or
> > baremetal instance.
> 
> They already run in a VM.
> 
> They already run on bare metal.
> 
> They already run in UML.
> 
> This is not to say that KUnit does not make sense.  But I'm still trying
> to get a better description of the KUnit features (and there are
> some).

FYI, I have a master student who looks at converting some of these to KTF, such as for
instance the XArray tests, which lended themselves quite good to a semi-automated
conversion. 

The result is also a somewhat more compact code as well as the flexibility 
provided by the Googletest executor and the KTF frameworks, such as running selected
tests, output formatting, debugging features etc.

Knut

> -Frank

