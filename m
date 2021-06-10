Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07343A2134
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 02:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFJASj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 20:18:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJASj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623284203; x=1654820203;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tyOVor99TibK7LC7X8V2prk/n4vdUOii3Ai7O8n/FUs=;
  b=e93ApNwcXrvbTpucx1gXDzLQYXoK6Wyx/11UUjIXf0twTmTndxpMnvwo
   YrKh/CIO04LArbAV0wf96aE3wtsGhFH4usAvyJGQK1IjfobeF5GFM2rpN
   FT6ohbndq4sXwB8McIw443vXlwdGdpgaJvqQ62JpZ1khp7qhTimoALj2S
   E/AvJ8T18laQ3iY1v/OVd9Mz5/VPE6pu318xb1+LxNmaX13CrBXhkxn6H
   zCHL28VkOmBuW7/dreandKQiTgGYXPZBGxl05M5xJdzMO2mCnAeuVGvIb
   SkbwOmg6H0FkM4JvziMKiK7BCcAM7T1upPOxf/D+sbqP8ASOb2Vp0ASyd
   g==;
IronPort-SDR: kuW0YFRuXOvNOfwvcMleaJowtlPkMVxQ9ocukmerPAHwfJeJK39VyTF6qzc47eH1cCrZABJeWe
 kcdAQC0j/OzmaCTFo03EUA22GXdwvz7yPLeBO041SckMop6re7iZawFB3fBkADF3eCdfhigqz3
 75e8SBatvZY5Ap7nYTx4lm8QxZP/qx3+uQt4uDzcnVPejK77vlCeT15kNn/s+r8pyDw2jbQL3m
 UzsJ2Orn0zK9rdO9R8pBM9eIPSG90ejBibQvHnZ8mCKmlWtxnWJzZ3Vz1il2J3/3ZburJsz/Ng
 H4s=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="170646616"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 08:16:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC+VXB81Wr57LQSYKUS4XshIZFuE08QDCac9C9mSMT31dX6IZ7k5cNX1BEk0CnbxeE+0fA5DNVUfNUptk3o6CW43CnwDaR8UOd+4LfIKcOWR/KenEEUsvznBab7G89KoAoH5XohTNFUEx7bvXZ1SbVBt6Y/JkqBdyqMItvlZgMLOaahDLDRHuRlEdnfnUVxBg1tB2muwHM1eULtV+E/bV1pML+VJNxk2QVTH/Pk87n0Ffji6zJc/+j3hoTAyjjJlHXRd4RlU/udjgX1Uwhh07GYRO4YkU5epb/8NhwQRtRd+TAl/vpbzOOK+WhPEOShD4f2eONpyqpDV+t18lPgOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyOVor99TibK7LC7X8V2prk/n4vdUOii3Ai7O8n/FUs=;
 b=bBw/kgpXdYB9MTNgLXi0tr0byDPvMlfxjc1guIErPT8lHsbKdUJ8Wj6MNkxClxcQTLbf8xBRKHl3CFGJJgfZ361ngWsHh/0tG2s0AnShnv2X7RC+Y3PprZ6PQ0eg3khMl+o3+9nwijrRMfTJvUwg829+oKTrb3tEa3ZDGrzRjuVV88R+eD/CKDQdBJH+DCT/HUuMJL2DTAVzMOHuFtpLymCY8ectn9oIAkogukTagb+iEIguhMefluDT03AZb9vxkW4P47eEUIhHeUyrQCq86xHpX8BboEZ4wTtTi6gPoETj7Hg/iyOCvCtlVzZ1BurkPcxUbK7tK7bNta7zumcxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyOVor99TibK7LC7X8V2prk/n4vdUOii3Ai7O8n/FUs=;
 b=o3iEkMcU+04PUtiiXWmZNzBL4zjWRpMNWzEjkT9n5yDpBrKcLEzwpjccCaCkYdUcUUH1EV7ydVLFsWA/2CClH22zp6plm7voKR1wyquZ+0FM8WbaMTRdguog/6wThcv5Urf7yZfTjy550ZEwVQhKNZOLLtMYbNWBXuFRPTyEWyw=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4012.namprd04.prod.outlook.com (2603:10b6:5:b4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 00:16:42 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 00:16:42 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Ric Wheeler <ricwheeler@gmail.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
Thread-Topic: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
Thread-Index: AQHXXR25NbtWiXYbYUGhSi1mXwip3A==
Date:   Thu, 10 Jun 2021 00:16:42 +0000
Message-ID: <DM6PR04MB7081477ECBE0BB4EC27D2C90E7359@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e411edc3-e4ac-4c88-a6b8-08d92ba50654
x-ms-traffictypediagnostic: DM6PR04MB4012:
x-microsoft-antispam-prvs: <DM6PR04MB40121EDAB57589D5F2490C13E7359@DM6PR04MB4012.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gVv+OXZ4vdapQkzNWGDD5zP+oLNTawx3wsEE4NjtqsMD+sxdPFnw7VquQ9qWd5u+F0A3nvIgyRYyehjmem1p/fbZ9YHNSaNuJSdWIFi2Q42N9FMwBUVH9xxO+sd5hkiEK5ku3Ht/HgccUCpGPWsaqvvw4EeFe5zjWJy0rU3Xts5xwFTpiRWao0fqh7FZ+PQAS6ko5antPYQB6x4mkUaXCckxEuMBIHan/OOYtmi1gGq4sHTknrl26yz3qBDDJylzAFdmiaWUmWvr7bSeyM5yIcc8NydvB179RQix7bpLvDqaHPMtLx9yYmi5BKHs1+B2t56JNDSBKUW2IYm71UhNIehTmL4KBGJyYZs6RK8CoxU7toH/LFv07hZXXbEtFjW9yhMdCiuENOsxdzF5uws0LHNi/qd3XLVsV1SoKeuQoBplrmBNQmlxhQ841IARQxt0WSp4D5o/vVQuNH3o2T1ERY1uGVC0fYj5SjYTTD9ANPcIU07rs2O/s1e9GekZqMsuFxjfPKr9g5aMN+HUvn3yeRdeMTfraSpsRa3kK+fEZprIYQLjyCMASH1SbdE4J/z1Rq23fFb1a+KxO7+E/Y0GTd2JibH2pgH8JbjzInmBgm0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(4326008)(83380400001)(2906002)(66476007)(55016002)(6506007)(38100700002)(186003)(122000001)(110136005)(316002)(71200400001)(54906003)(5660300002)(86362001)(478600001)(53546011)(7696005)(8676002)(8936002)(64756008)(9686003)(91956017)(66446008)(66946007)(33656002)(66556008)(26005)(52536014)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kn90gmSB4nhAiHYrFRor/icjknP0TnE++rt/nX8jlDjP/US7dNA115IeW0+S?=
 =?us-ascii?Q?X6eygQMHNjbSXyzIJyEWGTAerIz0U4fui5m8aEWiT6kCcxo+z7okfQfNQE7v?=
 =?us-ascii?Q?2Og+A/jHUd6s0Cpx8rGgppDj2aFn8I/aA+Vg4oocCeavsEyzkD145mU++yB7?=
 =?us-ascii?Q?6l4Tkc55GfGv/vomVnHOzxnozdzvfrRwoBkBZBl771ZckT1KuP6kzgjfc1/R?=
 =?us-ascii?Q?XSsGAmFhvmwbunitidlqRgKhT7Dp0eMF9W/Vs6uSxldak8KFyVz8HZguQMFh?=
 =?us-ascii?Q?umXCV5wwXmzH72YFvoGfz7kZbLQ6x0Oz5ffTy+5OnrccVIi1X4Y/R4QDhX/S?=
 =?us-ascii?Q?yl0TuFb2HSkmmm3IAD5KqgpqE4LtqvwtSDEUhGu6IAH+xn4bi3vrc7R061a1?=
 =?us-ascii?Q?ER9aAiICRVqInmKapg4qpmRR6WU3wj+qLn5BwypvM+xfge9Lhe3iN4upu63K?=
 =?us-ascii?Q?HnbP3J+HBAZt6prpI4Py4whmVlj8LoM2Edntm5wakEgMANpF1QNmw2WT/Hjx?=
 =?us-ascii?Q?EiRGYd3NQlFEnNEEQB8yeNS7jpZ71XrP/hPT+d0DKyGoTgjyz4hC5WyO7xII?=
 =?us-ascii?Q?Zzs2GoBGnwStIOUDG8g0gSV4SnVmid2TYd96HzjYRwlGkNwQGkCg4Q6t7eUd?=
 =?us-ascii?Q?AFvBLc6nvnu9qCSe36XIwS6omRClyDRpmCLof86iABI7Ekcs3SwVzSPgRR35?=
 =?us-ascii?Q?K5j/CCCrPl/1ssbNsp2UxPdNociUVtPIes9cTdKQJwGMWpQ+OtlXR8+kRAI6?=
 =?us-ascii?Q?hxV3aTe3hBi7mLgO43IhgE4NJe5LEeS2IGUImYZofnB7uNt340ytEKRtT4aH?=
 =?us-ascii?Q?TxpplCoDONLVbcTn02BSJ7BSo41g3iq7tlDl6YpcfdCxs2aR2sqgSzV/9ixi?=
 =?us-ascii?Q?hHn3B1IoyuMS7nXZroeKEhnUjDNq4Tusfa63xCQj6+GJD/KIzytJL1ZK635I?=
 =?us-ascii?Q?Sxz71Ha6MgtXWKx33srMGB9oygbWouANcWL2Oi1Sz8Z6mf8kJKSCdFuhqrzQ?=
 =?us-ascii?Q?WJIyfdPFH/1RtZl1xqoMlMqgBlGulW7kp+CG6U8lKpwYwOwFPVE3NoRwKpRh?=
 =?us-ascii?Q?W9BlVqfwn6i1RK8sU8C7QCW7mhUZKXSozudK/NAfuu9uq4SFJUlN3vYpAxHU?=
 =?us-ascii?Q?fmLVOoesx/n52jpRkWM2HeSeJ+Jxcp0Vsb20UpcWikJqGantXy+qWBKLvB8y?=
 =?us-ascii?Q?Yka5gVcW9J2cI0Tqh8jQKvev3+z4czq6hjvnN5jc9iDz6+EXZbs6zmeaSfYU?=
 =?us-ascii?Q?fc1n6ycNl/xYIP+oRcelX2LEwjaM5Feu3SmwkqLGT40H+x/28ij/H8Lrd8Q/?=
 =?us-ascii?Q?FIEe/Dlr1Oqpyzxd7wQilfmsQxxUi0Pgj7T8TzXVs9smng=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e411edc3-e4ac-4c88-a6b8-08d92ba50654
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 00:16:42.4170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/zzG0vT0El9sR6M1/huxy2yL0b5QdsBxsMkhYvdCJ6IJvicCECoYbvdZwuCejgCEopKCF1KNL807OTbbo0uUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4012
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/06/10 3:47, Bart Van Assche wrote:=0A=
> On 6/9/21 11:30 AM, Matthew Wilcox wrote:=0A=
>> maybe you should read the paper.=0A=
>>=0A=
>> " Thiscomparison demonstrates that using F2FS, a flash-friendly file=0A=
>> sys-tem, does not mitigate the wear-out problem, except inasmuch asit=0A=
>> inadvertently rate limitsallI/O to the device"=0A=
> =0A=
> It seems like my email was not clear enough? What I tried to make clear=
=0A=
> is that I think that there is no way to solve the flash wear issue with=
=0A=
> the traditional block interface. I think that F2FS in combination with=0A=
> the zone interface is an effective solution.=0A=
> =0A=
> What is also relevant in this context is that the "Flash drive lifespan=
=0A=
> is a problem" paper was published in 2017. I think that the first=0A=
> commercial SSDs with a zone interface became available at a later time=0A=
> (summer of 2020?).=0A=
=0A=
Yes, zone support in the block layer and f2fs was added with kernel 4.10=0A=
released in Feb 2017. So the authors likely did not consider that as a solu=
tion,=0A=
especially considering that at the time, it was all about SMR HDDs only. No=
w, we=0A=
do have ZNS and things like SD-Express coming which may allow NVMe/ZNS on e=
ven=0A=
the cheapest of consumer devices.=0A=
=0A=
That said, I do not think that f2fs is not yet an ideal solution as is sinc=
e all=0A=
its metadata need update in-place, so are subject to the drive implementati=
on of=0A=
FTL/weir leveling. And the quality of this varies between devices and vendo=
rs...=0A=
=0A=
btrfs zone support improves that as even the super blocks are not updated i=
n=0A=
place on zoned devices. Everything is copy-on-write, sequential write into=
=0A=
zones. While the current block allocator is rather simple for now, it could=
 be=0A=
tweaked to add some weir leveling awareness, eventually (per zone weir leve=
ling=0A=
is something much easier to do inside the drive though, so the host should =
not=0A=
care).=0A=
=0A=
In the context of zoned storage, the discussion could be around how to best=
=0A=
support file systems. Do we keep modifying one file system after another to=
=0A=
support zones, or implement weir leveling ? That is *very* hard to do and=
=0A=
sometimes not reasonably feasible depending on the FS design.=0A=
=0A=
I do remember Dave Chinner talk back in 2018 LSF/MM (was it ?) where he=0A=
discussed the idea of having block allocation moved out of FSes and turned =
into=0A=
a kind of library common to many file systems. In the context of consumer f=
lash=0A=
weir leveling, and eventually zones (likely with some remapping needed), th=
is=0A=
may be something interesting to discuss again.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
