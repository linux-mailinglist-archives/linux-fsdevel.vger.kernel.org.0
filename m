Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB8E18957
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 13:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEILzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 07:55:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40118 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfEILzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 07:55:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49BhXiK035955;
        Thu, 9 May 2019 11:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=gg3Y5VCySPKtxUHkrDHjoNwU5vy2eC4csPWWlbbJ8cU=;
 b=Tci6MOI4XpYQJJX3nkl5kQckg2JxLZKQinmSowqBukGIWd/P3Vtb/l1zYSHK5OrtneqM
 5/8tuqi9CYCxs9dhrTIyYhznJk6vkCml3NKYxKS/tLDkVJb7w+aSqNrTJ5fLNz0hLA9O
 d/I7sf8g4h472ilMMxO/jUq/gx1+rqYgoUr0oYssfbAt4xOVGZOEbkbuM3OIWNSk6NMJ
 S4ZWcUKVVG5pkz+FoKUqZ9pYDcND8rmQGOubwvUGvnH7TMrBL6+qhVwa1r2ojA5QgRKT
 ocFo45GNdn4G3RuQsBv55FhXD+jA2l7UjkL+BbHilSWKm2m+lPFr06S1LXYPAvfT0LHU 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s94bga7hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 11:52:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49Bp6Qq194507;
        Thu, 9 May 2019 11:52:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2s94bar2sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 11:52:37 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49BqMD5002325;
        Thu, 9 May 2019 11:52:22 GMT
Received: from abi.no.oracle.com (/141.143.213.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 04:52:22 -0700
Message-ID: <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Knut Omang <knut.omang@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
Date:   Thu, 09 May 2019 13:52:15 +0200
In-Reply-To: <20190509032017.GA29703@mit.edu>
References: <20190501230126.229218-1-brendanhiggins@google.com>
         <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
         <20190507080119.GB28121@kroah.com>
         <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
         <20190509015856.GB7031@mit.edu>
         <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
         <20190509032017.GA29703@mit.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090072
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090072
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-05-08 at 23:20 -0400, Theodore Ts'o wrote:
> On Wed, May 08, 2019 at 07:13:59PM -0700, Frank Rowand wrote:
> > > If you want to use vice grips as a hammer, screwdriver, monkey wrench,
> > > etc.  there's nothing stopping you from doing that.  But it's not fair
> > > to object to other people who might want to use better tools.
> > > 
> > > The reality is that we have a lot of testing tools.  It's not just
> > > kselftests.  There is xfstests for file system code, blktests for
> > > block layer tests, etc.   We use the right tool for the right job.
> > 
> > More specious arguments.
> 
> Well, *I* don't think they are specious; so I think we're going to
> have to agree to disagree.

Looking at both Frank's and Ted's arguments here, I don't think you 
really disagree, I just think you are having different classes of tests in mind.

In my view it's useful to think in terms of two main categories of 
interesting unit tests for kernel code (using the term "unit test" pragmatically):

1) Tests that exercises typically algorithmic or intricate, complex
   code with relatively few outside dependencies, or where the dependencies 
   are considered worth mocking, such as the basics of container data 
   structures or page table code. If I get you right, Ted, the tests 
   you refer to in this thread are such tests. I believe covering this space 
   is the goal Brendan has in mind for KUnit.

2) Tests that exercises interaction between a module under test and other 
   parts of the kernel, such as testing intricacies of the interaction of 
   a driver or file system with the rest of the kernel, and with hardware, 
   whether that is real hardware or a model/emulation. 
   Using your testing needs as example again, Ted, from my shallow understanding,
   you have such needs within the context of xfstests (https://github.com/tytso/xfstests)

To 1) I agree with Frank in that the problem with using UML is that you still have to
relate to the complexity of a kernel run time system, while what you really want for these
types of tests is just to compile a couple of kernel source files in a normal user land
context, to allow the use of Valgrind and other user space tools on the code. The
challenge is to get the code compiled in such an environment as it usually relies on
subtle kernel macros and definitions, which is why UML seems like such an attractive
solution. Like Frank I really see no big difference from a testing and debugging 
perspective of UML versus running inside a Qemu/KVM process, and I think I have an idea 
for a better solution: 

In the early phases of the SIF project which mention below, I did a lot of experimentation around this. My biggest challenge then was to test the driver
implementation of the pages table handling of an Intel page table compatible on-device 
MMU, using a mix of page sizes, but with a few subtle limitations in the hardware. With some efforts of code generation and heavy automated use of
compiler feedback, I was able 
to do that to great satisfaction, as it probably saved the project a lot of time in 
debugging, and myself a lot of pain :)

To 2) most of the current xfstests (if not all?) are user space tests that do not use 
extra test specific kernel code, or test specific changes to the modules under test (am I 
right, Ted?) and I believe that's just as it should be: if something can be exercised well enough from user space, then that's the easier approach. 

However sometimes the test cannot be made easily without interacting directly 
with internal kernel interfaces, or having such interaction would greatly simplify or
increase the precision of the test. This need was the initial motivation for us to make 
KTF (https://github.com/oracle/ktf, http://heim.ifi.uio.no/~knuto/ktf/index.html) which we are working on to adapt to fit naturally and in the right way
as a kernel patch set.

We developed the SIF infiniband HCA driver
(https://github.com/oracle/linux-uek/tree/uek4/qu7/drivers/infiniband/hw/sif)
and associated user level libraries in what I like to call a "pragmatically test driven" 
way. At the end of the project we had quite a few unit tests, but only a small fraction of them were KTF tests, most of the testing needs were covered
by user land unit tests, 
and higher level application testing.

To you Frank, and your concern about having to learn yet another tool with it's own set of syntax, I completely agree with you. We definitely would want
to minimize the need to 
learn new ways, which is why I think it is important to see the whole complex of unit
testing together, and at least make sure it works in a unified and efficient way from a
syntax and operational way. 

With KTF we focus on trying to make kernel testing as similar and integrated with user
space tests as possible, using similar test macros, and also to not reinvent more wheels than necessary by basing reporting and test execution on
existing user land tools.
KTF integrates with Googletest for this functionality. This also makes the reporting format discussion here irrelevant for KTF, as KTF supports whatever
reporting format the user land tool supports - Googletest for instance naturally supports pluggable reporting implementations, and there already seems
to be a TAP reporting extension out there (I haven't tried it yet though)

Using and relating to an existing user land framework allows us to have a set of 
tests that works the same way from a user/developer perspective, 
but some of them are kernel only tests, some are ordinary user land 
tests, exercising system call boundaries and other kernel
interfaces, and some are what we call "hybrid", where parts of 
the test run in user mode and parts in kernel mode.

I hope we can discuss this complex in more detail, for instance at the testing 
and fuzzing workshop at LPC later this year, where I have proposed a topic for it.

Thanks,
Knut




