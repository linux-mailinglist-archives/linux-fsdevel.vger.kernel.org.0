Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF418E8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEIRAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 13:00:40 -0400
Received: from mail-eopbgr730131.outbound.protection.outlook.com ([40.107.73.131]:43744
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbfEIRAk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 13:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj7za5LUnS3zFMMO2i2thSHh33YnaMbus6hUzrCHz70=;
 b=fZyZE9bXek/v+zqeTGXqLsq02pgGpAb5L0pYyehhI2lTcEvVKBRP0xh1kxZysII6cV0BOCxwsZRW3SiCaj6mwLS/bGcMU2DasvsmKLqxpjaeOXzRG55iDYPj3K+mOIoZZsAIgvC6lPNdTvcNDLWMAsyDzOA7QU6+xC0UIAJyCyg=
Received: from BN6PR1301CA0008.namprd13.prod.outlook.com
 (2603:10b6:405:29::21) by BN6PR13MB3122.namprd13.prod.outlook.com
 (2603:10b6:405:7c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.6; Thu, 9 May
 2019 17:00:30 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR1301CA0008.outlook.office365.com
 (2603:10b6:405:29::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.13 via Frontend
 Transport; Thu, 9 May 2019 17:00:30 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.228)
 smtp.mailfrom=sony.com; mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Thu, 9 May 2019 17:00:30 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x49H0S82031039;
        Thu, 9 May 2019 17:00:28 GMT
Received: from USCULXHUB07V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.168])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x49H0QOd029170;
        Thu, 9 May 2019 17:00:26 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB07V.am.sony.com ([146.215.231.168]) with mapi id 14.03.0439.000;
 Thu, 9 May 2019 13:00:26 -0400
From:   <Tim.Bird@sony.com>
To:     <tytso@mit.edu>, <knut.omang@oracle.com>
CC:     <frowand.list@gmail.com>, <gregkh@linuxfoundation.org>,
        <brendanhiggins@google.com>, <keescook@google.com>,
        <kieran.bingham@ideasonboard.com>, <mcgrof@kernel.org>,
        <robh@kernel.org>, <sboyd@kernel.org>, <shuah@kernel.org>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-um@lists.infradead.org>,
        <Alexander.Levin@microsoft.com>, <amir73il@gmail.com>,
        <dan.carpenter@oracle.com>, <dan.j.williams@intel.com>,
        <daniel@ffwll.ch>, <jdike@addtoit.com>, <joel@jms.id.au>,
        <julia.lawall@lip6.fr>, <khilman@baylibre.com>,
        <logang@deltatee.com>, <mpe@ellerman.id.au>, <pmladek@suse.com>,
        <richard@nod.at>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <wfg@linux.intel.com>
Subject: RE: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Thread-Topic: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Thread-Index: AQHVAHIQqLn/HEswekaFpqcd6/u0haZfSAwAgABQOYCAAqpcgIAAFQ4AgAAENICAABKGgIAAjwuAgAAc8oD//+ajQA==
Date:   Thu, 9 May 2019 17:00:08 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
In-Reply-To: <20190509133551.GD29703@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(448002)(13464003)(189003)(199004)(8676002)(426003)(102836004)(14444005)(186003)(37786003)(26005)(30864003)(246002)(70586007)(70206006)(4326008)(47776003)(50466002)(7736002)(305945005)(76176011)(7416002)(7406005)(66066001)(476003)(486006)(126002)(356004)(6666004)(336012)(86362001)(11346002)(46406003)(446003)(33656002)(6116002)(97756001)(72206003)(2876002)(478600001)(229853002)(966005)(23726003)(316002)(8936002)(2171002)(6246003)(8746002)(5660300002)(86152003)(55016002)(6306002)(7696005)(2906002)(55846006)(85326001)(54906003)(110136005)(3846002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR13MB3122;H:usculsndmail01v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail01.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6dc6a46-680d-4910-2f70-08d6d49fd7cd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR13MB3122;
X-MS-TrafficTypeDiagnostic: BN6PR13MB3122:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <BN6PR13MB31225A722ADF51990F09B1A5FD330@BN6PR13MB3122.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 003245E729
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: o9pdhShdV+EHwAY3qJ4cuBvscXWNit4RTatfKlpEOQ7TElks0dUc+Pt6moMO3mNJsFXNtig1dHHxtUU1CxJ+VQ5JH5jGO1E/y0K5abKPlD+QdalWpBcrsmy3G9dNQoW78qynQyXCWIgRnn+31+rLb1au34HIMvzFrIqZIY86FTgVqmvHaiucRssCEErBF7Mgy38kCKU9G0ERMO/o3nGE2claKnLlwT4H70wKpOrYN709cBGQFCyHsr3uyVURcxe9c/QURzCUayGQjpYBMDln15oho1mDgwZRgYtBmAWR6XWKIReP0AyuVQ/a+1E8tn8DRpw1qRN4/KH5b7ZG7iDoMQzo1byfpHWJ5rPqA7IqGQ0gDoTx8Be73UMVPtHalwMqdMATXaUDgd6IRxeTa4vCNTiGGP6fGl2F5B+aiE3+X9w=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2019 17:00:30.3830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dc6a46-680d-4910-2f70-08d6d49fd7cd
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB3122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -----Original Message-----
> From: Theodore Ts'o=20
>=20
> On Thu, May 09, 2019 at 01:52:15PM +0200, Knut Omang wrote:
> > 1) Tests that exercises typically algorithmic or intricate, complex
> >    code with relatively few outside dependencies, or where the
> dependencies
> >    are considered worth mocking, such as the basics of container data
> >    structures or page table code. If I get you right, Ted, the tests
> >    you refer to in this thread are such tests. I believe covering this =
space
> >    is the goal Brendan has in mind for KUnit.
>=20
> Yes, that's correct.  I'd also add that one of the key differences is
> that it sounds like Frank and you are coming from the perspective of
> testing *device drivers* where in general there aren't a lot of
> complex code which is hardware independent.

Ummm.  Not to speak for Frank, but he's representing the device tree
layer, which I'd argue sits exactly at the intersection of testing device d=
rivers
AND lots of complex code which is hardware independent.  So maybe his
case is special.

> After all, the vast
> majority of device drivers are primarily interface code to hardware,
> with as much as possible abstracted away to common code.  (Take, for
> example, the model of the SCSI layer; or all of the kobject code.)
>=20
> > 2) Tests that exercises interaction between a module under test and oth=
er
> >    parts of the kernel, such as testing intricacies of the interaction =
of
> >    a driver or file system with the rest of the kernel, and with hardwa=
re,
> >    whether that is real hardware or a model/emulation.
> >    Using your testing needs as example again, Ted, from my shallow
> understanding,
> >    you have such needs within the context of xfstests
> (https://github.com/tytso/xfstests)
>=20
> Well, upstream is for xfstests is git://git.kernel.org/pub/scm/fs/xfs/xfs=
tests-
> dev.git
>=20
> The test framework where I can run 20 hours worth of xfstests
> (multiple file system features enabled, multiple mount options, etc.)
> in 3 hours of wall clock time using multiple cloud VM is something
> called gce-xfstests.
>=20
> I also have kvm-xfstests, which optimizes low test latency, where I
> want to run a one or a small number of tests with a minimum of
> overhead --- gce startup and shutdown is around 2 minutes, where as
> kvm startup and shutdown is about 7 seconds.  As far as I'm concerned,
> 7 seconds is still too slow, but that's the best I've been able to do
> given all of the other things I want a test framework to do, including
> archiving test results, parsing the test results so it's easy to
> interpret, etc.  Both kvm-xfstests and gce-xfstests are located at:
>=20
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>=20
> So if Frank's primary argument is "too many frameworks", it's already
> too late.  The block layer has blktests has a seprate framework,
> called blktests --- and yeah, it's a bit painful to launch or learn
> how to set things up.
>=20
> That's why I added support to run blktests using gce-xfstests and
> kvm-xfstests, so that "gce-xfstests --blktests" or "kvm-xfstests
> --xfstests" will pluck a kernel from your build tree, and launch at
> test appliance VM using that kernel and run the block layer tests.
>=20
> The point is we *already* have multiple test frameworks, which are
> optimized for testing different parts of the kernel.  And if you plan
> to do a lot of work in these parts of the kernel, you're going to have
> to learn how to use some other test framework other than kselftest.
> Sorry, that's just the way it goes.
>=20
> Of course, I'll accept trivial patches that haven't been tested using
> xfstests --- but that's because I can trivially run the smoke test for
> you.  Of course, if I get a lot of patches from a contributor which
> cause test regressions, I'll treat them much like someone who
> contribute patches which fail to build.  I'll apply pressure to the
> contributor to actually build test, or run a ten minute kvm-xfstests
> smoke test.  Part of the reason why I feel comfortable to do this is
> it's really easy to run the smoke test.  There are pre-compiled test
> appliances, and a lot of documentation:
>=20
> https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-
> quickstart.md
>=20
> This is why I have close to zero sympathy to Frank's complaint that
> extra test frameworks are a bad thing.  To me, that's whining.  I've
> done a huge amount of work to meet contributors more than half-way.
> The insistence that "There Must Be One", ala the Highlander movie, is
> IMHO so wrong that it's not even close.  Is it really that hard to do
> a "git pull", download a test appliance, set up a config file to tell
> kvm-xfstests where to find your build tree, and then run "kvm-xfstests
> --smoke" or "gce-xfstests --smoke"?  Cry me a river.

Handling these types of things that are not "really that hard to do" is
exactly what meta-frameworks like KCI, Fuego, and LKFT are for.
For a core developer in a sub-system, having them learn a particular
specialized framework is OK.  However, for someone doing integration
testing of the kernel (not a core developer
in a particular subsystem), having lots of different frameworks turns
into death by a thousand cuts.  But we're working to fix that.
(Which reminds me that I have an outstanding action item to add an xfstest
test definition to Fuego. :-) )

>=20
> There are already multiple test frameworks, and if you expect to do a
> lot of work in a particular subsystem, you'll be expected to use the
> Maintainer's choice of tests.  Deal with it.  We do this so we can
> scale to the number of contributors we have in our subsystem.

This seems to me to be exactly backwards.  You scale your contributors
by making it easier for them, which means adopting something already
well-know or established - not by being different.

I understand your vise grip metaphor, and agree with you.  In my opinion
kselftest and kunit are optimized for different things, and are different t=
ools
in the Linux kernel testing toolbox.  But if you start having too many tool=
s, or
the tools are too specialized, there are less people familiar with them and
ready to use them to help contribute.

>=20
> > To 1) I agree with Frank in that the problem with using UML is that you=
 still
> have to
> > relate to the complexity of a kernel run time system, while what you re=
ally
> want for these
> > types of tests is just to compile a couple of kernel source files in a =
normal
> user land
> > context, to allow the use of Valgrind and other user space tools on the
> code.
>=20
> "Just compiling a couple of kernel source files in a normal user land"
> is much harder than you think.  It requires writing vast numbers of
> mocking functions --- for a file system I would have to simulate the
> block device layer, large portions of the VFS layer, the scheduler and
> the locking layer if I want to test locking bugs, etc., etc.  In
> practice, UML itself is serving as mocking layer, by its mere
> existence.  So when Frank says that KUnit doesn't provide any mocking
> functions, I don't at all agree.  Using KUnit and UML makes testing
> internal interfaces *far* simpler, especially if the comparison is
> "just compile some kernel source files as part of a userspace test
> program".

I had one thing I wanted to ask about here.  You said previously that
you plan to use KUnit to test a complicated but hardware independent
part of the filesystem code.  If you test only via UML, will that give you
coverage for non-x86 platforms? More specifically, will you get coverage
for 32-bit, for big-endian as well as little-endian, for weird architecture=
s?
It seems like the software for these complicated sections of code is
subject to regressions due to toolchain issues as much as from coding error=
s.
That's why I was initially turned off when I  heard that KUnit only planned
to support UML and not cross-compilation.

I'm not sure what the status is of UML for all the weird embedded processor=
s
that get only cross-compiled and not natively-compiled, but there are multi=
ple
reasons why UML is less commonly used in the embedded space.
=20
> Perhaps your and Frank's experience is different --- perhaps that can
> be explained by your past experience and interest in testing device
> drivers as opposed to file systems.
>=20
> The other thing I'd add is that at least for me, a really important
> consideration is how quickly we can run tests.  I consider
> minimization of developer friction (e.g., all you need to do is
> running "make ; kvm-xfstests --smoke" to run tests), and maximizing
> developer velocity to be high priority goals.  Developer velocity is
> how quickly can you run the tests; ideally, less than 5-10 seconds.
>=20
> And that's the other reason why I consider unit tests to be a
> complement to integration tests.  "gce-xfstests --smoke" takes 10-15
> minutes.  If I can have unit tests which takes 5-15 seconds for a
> smoke test of the specific part of ext4 that I am modifying (and often
> with much better coverage than integration tests from userspace),
> that's at really big deal.  I can do this for e2fsprogs; but if I have
> to launch a VM, the VM overhead pretty much eats all or most of that
> time budget right there.
>=20
> From looking at your documentation of KTF, you are targetting the use
> case of continuous testing.  That's a different testing scenario than
> what I'm describing; with continuous testing, overhead measured in
> minutes or even tens of minutes is not a big deal.  But if you are
> trying to do real-time testing as part of your development process ---
> *real* Test Driven Development, then test latency is a really big
> deal.
>=20
> I'll grant that for people who are working on device drivers where
> architecture dependencies are a big deal, building for an architecture
> where you can run in a virtual environment or using test hardware is
> going to be a better way to go.  And Brendan has said he's willing to
> look at adapting KUnit so it can be built for use in a virtual
> environment to accomodate your requirements.

This might solve my cross-compile needs, so that's good.

>=20
> As far as I'm concerned, however, I would *not* be interested in KTF
> unless you could demonstrate to me that launching at test VM, somehow
> getting the kernel modules copied into the VM, and running the tests
> as kernel modules, has zero overhead compared to using UML.
>=20
> Ultimately, I'm a pragmatist.  If KTF serves your needs best, good for
> you.  If other approaches are better for other parts of the kernel,
> let's not try to impose a strict "There Must Be Only One" religion.
> That's already not true today, and for good reason.  There are many
> different kinds of kernel code, and many different types of test
> philosophies.  Trying to force all kernel testing into a single
> Procrustean Bed is simply not productive.

Had to look up "Procrustean Bed" - great phrase.  :-)

I'm not of the opinion that there must only be one test framework
in the kernel. But we should avoid unnecessary multiplication. Every
person is going to have a different idea for where the line of necessity
is drawn.  My own opinion is that what KUnit is adding is different enough
from kselftest, that it's a valuable addition. =20

 -- Tim


