Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79025422F1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 19:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhJERYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 13:24:18 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:46920 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234938AbhJERYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:24:17 -0400
X-Greylist: delayed 1417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 13:24:14 EDT
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195GnZIf025817;
        Tue, 5 Oct 2021 16:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=bFq0gUCj+1rZhXMwCeMtZr757fLcC8Pl9kMcvt+8FRw=;
 b=B/qAGZ0zVn9AxTBgv8rXnuDrSGV+LWWQNN7mQz00mnC5RBAJgiy5XWkqR6XXx6/0bRBV
 tQw6qpohUAgVeZt5LdRNHlXxKcFkzNvwHRHHCuEWWXYjMJcrpYLevV7TVIroQsI4kd0z
 jBwztWmW8mU4HKxz5wF+SWunXJks8aB1snX7xnf0ilIaRYmizYCWvDd0rQrsgC5h34ZA
 jdXimUyDkn0unyldqnL/JhxSmrLChPaF0FMBaXnwuHjeipUh2nXyZVyFthicJkCPYxpk
 BRsGVNI9kHFh8Znj11ONOUohMNVk03BVn2DULkP3uEzLt3jIXSDflL9Uttpi9XGemBdX mw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx08-001d1705.pphosted.com with ESMTP id 3bg3sm0v3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 16:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyxLDTl2VeUGkTsjUKM5EAeGzWUaPG6coTRIwwr7Co+t7Mjq7MCrXu+RoZCdsR3FZCnn589FheGKYqm/GUOmDkV+5qj91dajVQQ6c/C+SvVyMFquU8e+RjXobPp2m8B/X1sNH075Arj0e3vCZpTqtPuF0jZsIiC2OuNmRC/9jdX9JW3JIPxC7tSiqNmFCyjswncLtH/VbpPgxxG6pw7JGE5/LR+4ZT+wnogvOiBl/3/5Ab7CpFccqLpTP+ecLchEHYA9qak7O7KRElrIkWweSWKLciK4IJfi1ZF4dDROxIeT3u1cPofwBfXDNLZVheYa4gYz6v3l5VRNFNABmnRbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFq0gUCj+1rZhXMwCeMtZr757fLcC8Pl9kMcvt+8FRw=;
 b=Tu7bA/exG0Q8i6PR/Nw2/cs51RZLzr88i/SwDFu78KTOhz9B/q5SS6Ko9GRwpooMpIQPrIkyHIUJnrl29IEAAlxEWsVfl0tw3dAUYDAtHZuatIXKv8APx8ePr6w9u9tSM7YRaPAfceMvH2EdDIZbHv70RyHJZCK5wMwfbpHTguhMJSaaBO0CYm3aK7krJ4x7o7V5NFX8xnl+KypDQWW+lymUm9eSIhZJ6fuOYh1uOZOSo/v0kemnS/HWKDEINjKTcC+b36TMyTLEATRkZ3JVexrt+m/D2GCAxAIwDFpiWi4ggrMFmkotoRcGUc34zMOCnHsAxScmMTmSUGJnu9GP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BY5PR13MB4455.namprd13.prod.outlook.com (2603:10b6:a03:1d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.12; Tue, 5 Oct
 2021 16:57:56 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::f544:a41:f814:7be9]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::f544:a41:f814:7be9%6]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 16:57:56 +0000
From:   <Tim.Bird@sony.com>
To:     <gregkh@linuxfoundation.org>, <mcgrof@kernel.org>
CC:     <tj@kernel.org>, <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <jeyu@kernel.org>, <shuah@kernel.org>, <bvanassche@acm.org>,
        <dan.j.williams@intel.com>, <joe@perches.com>,
        <tglx@linutronix.de>, <keescook@chromium.org>,
        <rostedt@goodmis.org>, <linux-spdx@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 03/12] selftests: add tests_sysfs module
Thread-Topic: [PATCH v8 03/12] selftests: add tests_sysfs module
Thread-Index: AQHXs74tItgg1rfm00mmBKYUROs6y6vEf8UAgAArAZA=
Date:   Tue, 5 Oct 2021 16:57:55 +0000
Message-ID: <BYAPR13MB2503180449E0863CFD4672F5FDAF9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-4-mcgrof@kernel.org> <YVxeTvKkYs938g94@kroah.com>
In-Reply-To: <YVxeTvKkYs938g94@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcaf89cc-738e-498a-a50f-08d98821473f
x-ms-traffictypediagnostic: BY5PR13MB4455:
x-microsoft-antispam-prvs: <BY5PR13MB44557ABC8CDDDB570A0813B6FDAF9@BY5PR13MB4455.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OodLZs6s01a9+4yb3m0yojogOzxScmtOWoxP3IfGkJtaTgtiLg+myi3lIU7tkwAMAuXf6R+VM39UM15dIQRgh9B74GD2r3DGjH76Nyqydglh2MujWQAH/3+f03NgsXr3NNkWpcFrN/5VKHO6aLYgMnVEHjhsrCnGW7JKf+Dq/eOuUv3ozob9htAdxqvqWmftXqb3BYsmUMSMWSn0UdB9lkMFe9MucqBs5I2uz7HHWFad0s1FZCpmPH/+WeaPSHBOd9tIsNm1tMoKbO8/XSyE56K4Eqn3FXNV9LME0lMP8gLc2HOgC2TgQEyzDADO7QWnfhM36BHovuSkkIppSDipK02RzJE5+J2zo1mnoqAQtAxFqQkYOa6a0oMOf/e0S4oVV033AuJchzziUM/0HDQm3V4f9ArOgpQfbgIoOejBK0l2zeIJSHWdEOyoFvuVuJfjyLh5Z+s2mdVE3+xefi/zuNQAfbvXs0trqRpTmAa1w7ECiZ0VHLvF63bNGarPP6420cD3mlaWSvTMT6R14rcx3SeFxG9qa8xbI9pvYtjGfq851cCop7p3nBP9i2zk44kWirDJjvjMF75cwNv5SXhNctrm0lLNRZj0zNo9+1/UwVfaOCS4U4aqCtDkeGKkEtLN43Q0WwJ0Q+hHvkIbcmXU+4WX3RBvOxu97Pacf5sxHRUrUIHTVa3+nFq3Zke22skvTMgSamD1N5mVs1/2sh4x00AIaWSNCXKvkI0TMTQ95/VoWaxe7a3K2rPyHC7FeG2CigYPG0Js/AOi+gPao7Kx1c/zU3FlQx+mll8I6At6e4/+FmwO39tifQZJZkxvV2ZE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(52536014)(6506007)(64756008)(53546011)(66476007)(26005)(55016002)(66446008)(9686003)(8936002)(186003)(5660300002)(7416002)(4326008)(7696005)(38070700005)(8676002)(86362001)(38100700002)(966005)(122000001)(508600001)(110136005)(54906003)(316002)(71200400001)(83380400001)(76116006)(2906002)(66946007)(33656002)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9YZlHFC5BrHJ7pC2ntWfXdxuexsli+3htodJcsUnhisAIcScgzuj4zLqW0cn?=
 =?us-ascii?Q?z4kPIW7QoQ7Fk7Qf6+v9lAeQgVzvNc0uTz7OswKdyOgHKEDUKpFKtxF3Q/LJ?=
 =?us-ascii?Q?EERbDYEkhvLzuuC623pfjR5P1AmTtIdGiQP1KRI7ZGSDuG4G3gaoWI1Nz3oP?=
 =?us-ascii?Q?chKusI1+UeKcrhnwzwyBJH3rRwCsEB/pJAHf+mr8wvnHYP8SnafDJ5gmpIlS?=
 =?us-ascii?Q?esBUHIuxwUj+vwAvQMKAGtVgEEXCsGENQmeoIVLNLlZP7YXx8qhr/T71bens?=
 =?us-ascii?Q?ABCezZg0NIwAiQEGlN35LIXp+Bfo3PVW5Smz137Hj9SUjtSw3fhbnYDJm2Wt?=
 =?us-ascii?Q?PsIdFYcEjhFFayjGxU506zJWPgaZjsH5VMb01n7n8tN/OaAHLtfo3ziS2KpF?=
 =?us-ascii?Q?6PFtPxlhATfx1xnTjL4n+4U3Kr3OsjfHYh34c22FZjO7rfhBpLLRZB+gcSSf?=
 =?us-ascii?Q?66smtVVyb+CQnXOiDjkrhnVkxBcVvoEsaefI5nJkL9bAkX4axjdl77GRT1zM?=
 =?us-ascii?Q?pxxxU013p8gE+UcByTBTcZiTDm707orWKYLUmv4lX4AN89xqsu0Voc2CCBSt?=
 =?us-ascii?Q?21qfbtqAhaFuiZxUQT8tfFHeCCwux+QoCqSuMS39W+GxKKhSperhBbB05eaG?=
 =?us-ascii?Q?CJjGE8x5Yi+l+RCemYfJgA2x28OJoeEWCpQS9Cj0iyhnCf6AkMGBovwMIQWb?=
 =?us-ascii?Q?LPT4WLMz+O6Szx4wpYrmMOIWbgXYTerCDcx31ZFYrBiVDKE3uYNNtznxZCGo?=
 =?us-ascii?Q?ypxjzdih/jpgOmvm5+yqzR/LTst2yJsivldghaNLiV8YctwAMoiYSGoLG5WF?=
 =?us-ascii?Q?rCfkdrTf4AJg9xrBxpp3+8VOKQdoIEZO2mVD2+T+X2YlIRVkb4lg8JQZVLP+?=
 =?us-ascii?Q?xolspMSYWB3VpMk/WJd7kscfuwd1PtD5VafWpPzr8aM08y6f80ZRSl4Bhmhh?=
 =?us-ascii?Q?yldMcaL2HtEkrHhRXVBlvHrJ2OOK/sTbpovWFrY3Wuxb0QxJHQejX+GYtNKV?=
 =?us-ascii?Q?GKwLq4Dhx9IyCwg8beBVE91FXd4Rh+sX50KYb4KnowR271KfDXJJlEMBpsU/?=
 =?us-ascii?Q?rX8d5Sj/SVoUbAp8OZh23jEmt+OfPfxCXIshfoiz7gUdUnYp88pUP9ZKt6HO?=
 =?us-ascii?Q?SI9TQhU09FKxczDaeo9O47wRxeivaZR+ET4ialyHWa82F/vhc5yo3TgWpHND?=
 =?us-ascii?Q?2zyCUBAPhl55U7cUgzMvLicNRCM4EwPvmZonPGB2JzT4jEbuGh6+UNP6wrsA?=
 =?us-ascii?Q?VTmZcL8WlUbxPwcRg9Rf61FtBYE6CJ/9NyIe/ek5A6xUEQiOHJ2akDf6o3LT?=
 =?us-ascii?Q?fDXubILr6aGTANWKDSYw2DrP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaf89cc-738e-498a-a50f-08d98821473f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 16:57:55.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJMrV12k30eNAm1sFG++4jZuHUspmtP82pTHORpKt+u+WkhL+fw5zHRff7fAeDV10MkAggewImJioSOhxkcrwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4455
X-Proofpoint-ORIG-GUID: EeylVr4NBOriIM-rODFr0fTwLx2nZqSX
X-Proofpoint-GUID: EeylVr4NBOriIM-rODFr0fTwLx2nZqSX
X-Sony-Outbound-GUID: EeylVr4NBOriIM-rODFr0fTwLx2nZqSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_03,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050102
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, October 5, 2021 8:17 AM
> To: Luis Chamberlain <mcgrof@kernel.org>
> Cc: tj@kernel.org; akpm@linux-foundation.org; minchan@kernel.org; jeyu@ke=
rnel.org; shuah@kernel.org; bvanassche@acm.org;
> dan.j.williams@intel.com; joe@perches.com; tglx@linutronix.de; keescook@c=
hromium.org; rostedt@goodmis.org; linux-
> spdx@vger.kernel.org; linux-doc@vger.kernel.org; linux-block@vger.kernel.=
org; linux-fsdevel@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v8 03/12] selftests: add tests_sysfs module
>=20
> On Mon, Sep 27, 2021 at 09:37:56AM -0700, Luis Chamberlain wrote:
> > --- /dev/null
> > +++ b/lib/test_sysfs.c
> > @@ -0,0 +1,921 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> > +/*
> > + * sysfs test driver
> > + *
> > + * Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published by t=
he Free
> > + * Software Foundation; either version 2 of the License, or at your op=
tion any
> > + * later version; or, when distributed separately from the Linux kerne=
l or
> > + * when incorporated into other software packages, subject to the foll=
owing
> > + * license:

This is a very strange license grant, which I'm not sure is covered by any
current SPDX syntax.
" when distributed separately from the Linux kernel or when incorporated in=
to
other software packages, subject to the following license:"

Why would we care about the license used when the code is used in a non-ker=
nel
project?  If it is desired for the code to be available outside the kernel =
under a
different license, then surely the easiest thing is to make it available se=
parately
under that license.  I'm not sure why the kernel needs to carry this licens=
e for
non-kernel use of the code.

I would recommend giving this a GPLv2 SPDX header, and maybe in the comment
at the top of the file put a reference to a git repository where the code c=
an be
obtained under a different license.

Just my 2 cents.
 -- Tim

> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of copyleft-next (version 0.3.1 or later) as publis=
hed
> > + * at http://copyleft-next.org/.
>=20
> Independant of the fact that I don't like sysfs code attempting to be
> accessed in the kernel with licenses other than GPLv2, you do not need
> the license "boilerplate" text at all in files.  That's what the SPDX
> line is for.
>=20
> thanks,
>=20
> greg k-h
