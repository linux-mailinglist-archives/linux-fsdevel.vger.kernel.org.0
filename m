Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6517C123C3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 02:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLRBJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 20:09:46 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22968 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLRBJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576631386; x=1608167386;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IvWAgzgX0edM4UljXrS5sCD5mjLMWFD4weoDyfvih6I=;
  b=AtwhYM04TorCJfMlIb+/WJwmPg5Ay8MGhsMEK3lSlxBzjGAONuz0W8g8
   CHvVNWSCPBMYmy98YI4wlDmV3RjYBl8DOp8acrBpq4gxioRc+ZhIne8Ks
   apw0K26pyDBwOQUdgaTWfj2+kzmEuZLeRugicP0yCJAxY3zBHgkLMcKjf
   lFZMcqs58OuCe84x7gfYozoM+cXDotQNpDx9N1/xDdolDOtF7Dk0W7tMe
   SiM1QSopOcgqAYX9h1YNcKA1MB0IiylZKk+6qZvHTd70pSm74w7du1VUO
   zSsZcAH5PUm2QwyK5dQmAFnAZxu1UeHa3n/qNIsfSbmvjlj1bLRXSj4V0
   w==;
IronPort-SDR: 5IsRiZAnJdCrx8SEIEZcouEmFi+nxHK12hWTSobDiEHA4kOEYB4RzOKc3EML3v5BVPD6qelVJd
 7ubBb+LWygrq/+6ypAyZ2EaoZcL8BUa/knx/G9ULcKC6s5L+QY7QqLxUAMoHOMfbfvEs3pyvCd
 EB+eJxY6OvZ9PapUrY/egOfz6GiSKMeUSRMWlwBZ9aMDJhlqi13RNBN86Rxrkqk55XiZFu8d1I
 qWUpjUswF7BkhYLqzImaViEmASGmlz5FD1Gwe1PnliFOnvgoAZZQMPnyfFeksB3C+w/3vuDFFE
 JgI=
X-IronPort-AV: E=Sophos;i="5.69,327,1571673600"; 
   d="scan'208";a="127213640"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 09:09:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx+YThsOHzMO0Mf2+/UwFyJr8C8+AsZ/IeWOS44fJJxuIOc0XWhr4NemEh7w/IrIlCMGmxsFixo7HbKyt6d6sQPD5ZY8DXkigQ+iDvaz7fRmCp9iD8Mscb+Jf07D4E6OI7/T5A4KVCvG/f648Ew05iHwnolKLdfPKLZ0kevd+wLPljGoR6oYPSN2PmWw2semOhPmw6QXRg+sa9xki5O/Yc0NRHmR4Zo2hXYNPpP2Ych8JwKDmd2XX2nK8v5SAFmyRrip1APDfYsUILdE7slAoy1ns8Hx1yXxM/k4x7fJ49FJNOGyn/UQtBXkcPMbXWghtJb2ck5+bA6kTleV49UK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvWAgzgX0edM4UljXrS5sCD5mjLMWFD4weoDyfvih6I=;
 b=BkhSLKup485+f/zjhv0nDVkcwLmd6s6Npg1wo3Fhbj35CYQpyCzKK2RezGEh4WUq/dpeIoTRSOxAJcTTfjbkGu6198jQ95YAsIqeXHx4cwhBLyj8ig9v0TI96xDO1B0i+1k5uqGWjMbnvzy9TBHCADFpWYrwXmuLz+eyOI15TnXH2pJqGYxF6cZfYJte2JIcamtsPvCKoAwuqksZa+QR6ZkSsT8o+59dYD9RPWuZ9OeIZ6plT+Lx/ddHAK0CeyhRfH06RV85pB6uATU1GyAfrt3iMFxltnWBcwXJJN3gCTSA/MVHRLi5jeV02aZRcp3LRN3sPynEPRQm2NVXaW4UFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvWAgzgX0edM4UljXrS5sCD5mjLMWFD4weoDyfvih6I=;
 b=ifQoZTLzsblmOsz323m0KR1cEDyYlKVWjFxfjcsMoMM+t7sRu2gWnWpMS8bbBYD/apgmzS68PAACARqyGH02XxVAmaWnvgwFzL+zNJJBLaAmMq0rgowjLdeew6AKMREZceDTNtkUnjxA+463kKvteG24ZVnyXFM2Mv8+BWDGiqU=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4103.namprd04.prod.outlook.com (52.135.214.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 01:09:43 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 01:09:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] New zonefs file system
Thread-Topic: [PATCH 0/2] New zonefs file system
Thread-Index: AQHVsRth1IpCuMwSZ02s8MNISyP74A==
Date:   Wed, 18 Dec 2019 01:09:43 +0000
Message-ID: <BYAPR04MB58162DEB58C1D262E20A708FE7530@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
 <20191216093557.2vackj7qakk2jngd@orion>
 <20191216094241.til4qae4ihzi7ors@orion.redhat.com>
 <BYAPR04MB5816894E05A9334C122E785DE7500@BYAPR04MB5816.namprd04.prod.outlook.com>
 <3565a0e7-b9ba-4f32-9f4b-3387f0a379a1@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6111d838-6945-4530-0b30-08d78356f742
x-ms-traffictypediagnostic: BYAPR04MB4103:
x-microsoft-antispam-prvs: <BYAPR04MB41030DF06837610D6E7C6A47E7530@BYAPR04MB4103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(64756008)(66446008)(66946007)(66556008)(86362001)(91956017)(55016002)(9686003)(5660300002)(186003)(53546011)(66476007)(76116006)(26005)(6506007)(81156014)(8676002)(33656002)(71200400001)(478600001)(81166006)(52536014)(7696005)(110136005)(8936002)(316002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4103;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzFKJzu0Qa2wsaxH3V3cYZYTBkEVHgS7eHxYN6+/RWdMOz7Y4Pz2sAQjC3X8bslHbwvw6UzMljuWJSDmwr5p13OIuOo4CKjYKBFCBcIyY8AnkyBzI0d9Q9QlpQQ3z/tLtXb+P9LG3+ym4sGasqsYd1EQ611kjO/YyaiTobgwVcbeneDdyODgr1k+g07hPH2IV2+yvXXHofOvbsv6/SSR+N8FYcQJTG43KSyTmEPn0A4SMuEd8RZdR3C0zAd07vPXTThO2oTJPMpwPSxpu0ikLAhj1S8C+9yxfQ6fu7hjwHF4M8TRdEIws8ufyvyLRaQ+3JID+vkhfGpTMnlQiUSsOkhJwJORumDiu339JVz4eyP6i2mHw66jp408+7VVEjb+zPrKCWEC3K1bL83wPzroGApdwZv2pVT8Ocx3eDFTacQc4ajGv0o5myv2S6n57F7I
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6111d838-6945-4530-0b30-08d78356f742
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 01:09:43.3302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wru6PRfUpzPWQAR7opRIbkuGTyqHLDMIs5/a+jWRh/qUGXVjHDojN8wycJTpPIT/r5YF+En+ptARI4lcxEHcRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4103
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/17 22:05, Enrico Weigelt, metux IT consult wrote:=0A=
> On 17.12.19 01:26, Damien Le Moal wrote:=0A=
> =0A=
> Hi,=0A=
> =0A=
>> On the SSD front, NVMe Zoned Namespace standard is still a draft and=0A=
>> being worked on be the NVMe committee and no devices are available on=0A=
>> the market yet.=0A=
> =0A=
> anybody here who can tell why this could be useful ?=0A=
=0A=
To reduce device costs thanks to less flash over provisioning needed=0A=
(leading to higher usable capacities), simpler device firmware FTL=0A=
(leading to lower DRAM needs, so lower power and less heat) and higher=0A=
predictability of IO latencies.=0A=
=0A=
Yes, there is the sequential write constraint (that's the "no free=0A=
lunch" part of the picture), but many workloads can accommodate this=0A=
constraint (any video streaming application, sensor logging, etc...)=0A=
=0A=
> Can erase blocks made be so enourmously huge and is there really a huge=
=0A=
> gain in doing so, which makes any practical difference ?=0A=
=0A=
Making the erase block enormous would likely lead to enormous zone=0A=
sizes, which is generally not desired as that becomes very costly if the=0A=
application/user needs to do GC on the zones. A balance is generally=0A=
reached here between HW media needs and usability.=0A=
=0A=
> Oh, BTW, since the write semantics seem so similar, why not treating=0A=
> them similar to raw flashes ?=0A=
=0A=
This is the OpenChannel SSD model. This exists and is supported by Linux=0A=
(lightnvm). This model is however more complex due to the plethora of=0A=
parameters that the host can/needs to control. The zone model is much=0A=
simpler and its application to NVMe with Zoned Namespace fits very well=0A=
into the block IO stack work that was done for SMR since kernel 4.10.=0A=
=0A=
Another reason for choosing ZNS over OCSSD is that device vendors can=0A=
actually give guarantees for devices sold as the device firmware retains=0A=
control over the the flash cells health management, which is much less=0A=
the case for OCSSD (the device health depends much more on what the user=0A=
is doing).=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
