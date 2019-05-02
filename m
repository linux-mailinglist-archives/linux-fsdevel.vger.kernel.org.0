Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C459B121C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEBSPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 14:15:20 -0400
Received: from mail-eopbgr710117.outbound.protection.outlook.com ([40.107.71.117]:8421
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbfEBSPT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 14:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu+qU7j1g4e0qKYY8NI+jYs8IDMeXiI9rKB2912aQxk=;
 b=RUlxFd43z0o0UbNfcJc6XxkFUNZRjbE6rDjHopszHC++6umPBCdj0bHYmEu7/iA8OAlvWwEHPLv4Yg1CRE6zRz/uncBnYwU/smDnizFcPa8KTi/iq744WUooeJBhZ48XuxmeUwYKfjzNGNs1IeBdyoq+75fOWCNe+LpZq2kMfXQ=
Received: from DM5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:3:23::33) by
 DM5PR13MB1402.namprd13.prod.outlook.com (2603:10b6:3:124::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.9; Thu, 2 May 2019 18:15:13 +0000
Received: from CY1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by DM5PR13CA0023.outlook.office365.com
 (2603:10b6:3:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.6 via Frontend
 Transport; Thu, 2 May 2019 18:15:13 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.229)
 smtp.mailfrom=sony.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail02v.am.sony.com (160.33.194.229) by
 CY1NAM02FT045.mail.protection.outlook.com (10.152.75.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Thu, 2 May 2019 18:15:10 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail02v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x42IF8nt010260;
        Thu, 2 May 2019 18:15:08 GMT
Received: from USCULXHUB07V.am.sony.com (usculxhub07v.am.sony.com [146.215.231.168])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x42IF6Jm028842;
        Thu, 2 May 2019 18:15:06 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB07V.am.sony.com ([146.215.231.168]) with mapi id 14.03.0439.000;
 Thu, 2 May 2019 14:15:06 -0400
From:   <Tim.Bird@sony.com>
To:     <gregkh@linuxfoundation.org>, <brendanhiggins@google.com>
CC:     <frowand.list@gmail.com>, <keescook@google.com>,
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
        <knut.omang@oracle.com>, <logang@deltatee.com>,
        <mpe@ellerman.id.au>, <pmladek@suse.com>, <richard@nod.at>,
        <rientjes@google.com>, <rostedt@goodmis.org>,
        <wfg@linux.intel.com>, <yzaikin@google.com>
Subject: RE: [PATCH v2 16/17] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Thread-Topic: [PATCH v2 16/17] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Thread-Index: AQHVAHJbh4bzAud+AEekHmLRH8eTgKZX75eAgAA1NbA=
Date:   Thu, 2 May 2019 18:14:53 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF9770A3A0@USCULXMSG01.am.sony.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-17-brendanhiggins@google.com>
 <20190502110347.GE12416@kroah.com>
In-Reply-To: <20190502110347.GE12416@kroah.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.229;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(448002)(199004)(189003)(13464003)(72206003)(478600001)(47776003)(46406003)(37786003)(33656002)(97756001)(86362001)(70206006)(5660300002)(70586007)(356004)(6666004)(102836004)(186003)(426003)(11346002)(446003)(336012)(26005)(476003)(66066001)(55016002)(76176011)(7696005)(229853002)(8676002)(126002)(55846006)(85326001)(246002)(86152003)(8746002)(8936002)(486006)(50466002)(6246003)(7406005)(7416002)(4326008)(6116002)(3846002)(2906002)(110136005)(54906003)(2876002)(316002)(7736002)(305945005)(23726003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1402;H:usculsndmail02v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail02.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2927ae1-d49f-4bad-60b8-08d6cf2a1ea6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR13MB1402;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1402:
X-Microsoft-Antispam-PRVS: <DM5PR13MB140230E0A68E41CAF530C442FD340@DM5PR13MB1402.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0025434D2D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bU7dXAdMkBInmgFf3lbIAW/yrfjtPBT7xmHmRhPy+u/F81wqySYLneMKTgJ9uy6f0YnZlYzBIkUsJAFTKMvemgB8r0n8PpNut2dmxJyH0Tk3YniGZd66ERVNzNrefJVodv/kWUa6hgaki3mMtJp344RiOE+WDa1J6M1g8Xj9npIFmFbrKiNIqwy1kXQ1Nos1+jmUPPhdwmrCrUM652L4NDdpkYmrbJHGyo9Ki1uRlPub4F9xawbOv81NFQPbIr5jHTyV64qs0ySjS1hcXMVutCtRZYsHhbYXhA/h75upZypux1FfLor+rwCD2yUnL3L99DmemLALTzZurd+QM2IHPlRwBxUAIqwKyaM/GkcGTDxtfN/V3xavfSUHvudrqzxUZr4qoNFcRzjn8zuSDnhx4cCFFWZq6LryN47KBRJZgiU=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2019 18:15:10.9314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2927ae1-d49f-4bad-60b8-08d6cf2a1ea6
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.229];Helo=[usculsndmail02v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1402
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Greg KH=20
>=20
> On Wed, May 01, 2019 at 04:01:25PM -0700, Brendan Higgins wrote:
> > From: Iurii Zaikin <yzaikin@google.com>
> >
> > KUnit tests for initialized data behavior of proc_dointvec that is
> > explicitly checked in the code. Includes basic parsing tests including
> > int min/max overflow.
> >
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  kernel/Makefile      |   2 +
> >  kernel/sysctl-test.c | 292
> +++++++++++++++++++++++++++++++++++++++++++
> >  lib/Kconfig.debug    |   6 +
> >  3 files changed, 300 insertions(+)
> >  create mode 100644 kernel/sysctl-test.c
> >
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index 6c57e78817dad..c81a8976b6a4b 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -112,6 +112,8 @@ obj-$(CONFIG_HAS_IOMEM) +=3D iomem.o
> >  obj-$(CONFIG_ZONE_DEVICE) +=3D memremap.o
> >  obj-$(CONFIG_RSEQ) +=3D rseq.o
> >
> > +obj-$(CONFIG_SYSCTL_KUNIT_TEST) +=3D sysctl-test.o
>=20
> You are going to have to have a "standard" naming scheme for test
> modules, are you going to recommend "foo-test" over "test-foo"?  If so,
> that's fine, we should just be consistant and document it somewhere.
>=20
> Personally, I'd prefer "test-foo", but that's just me, naming is hard...

My preference would be "test-foo" as well.  Just my 2 cents.
 -- Tim

