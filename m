Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0741E2D3FC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 11:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgLIKRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 05:17:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46895 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgLIKRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607509054; x=1639045054;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L3VhnLrpEtcXzXlTjJLVKin7VcEjzsS9OIDbEyXlEfc=;
  b=Geh0HorS9gj9EcqiOwK+XU9fS0RzaPs14ywVfvByG2ZSiWNKyC3fIfra
   s8DYMZrFI6OaORgw4tzXsezcE7hV1Lutv92n5n6VVKpfL2rEyQGhMNNIk
   /0zq/B+UZ48k3jI9w7dzM7SAiXoNXT0u6G//0FhgsnErkuN7NiGyeXeDO
   4tuGuH0Fq4MjzO94dogLyhzLu/gKpj1g1qkMlb+Bze1j5IncSCHBbgfAr
   SnVQEplFuuUDMKE5zAjbTqFTKLakh8r9jotyGszMVwJhSoPGi5dGb26J0
   22LbZsdyiPn9d+QDA5UkUwaG2vS18wiucRhprOJdrP0eV038v5A/aKqY6
   w==;
IronPort-SDR: Wls4ANb6HWW7fNODZ8DPMjtzFYiHiBY8bKQqJUTx74aRbNa7UhbOT7MSraYrkOETt/VTPP6/h7
 JPsop6dShRMKloXw+wb2c6WikVu0gp0jcFwV1R19yL2PCNm+xXLrsBSqGVKrEycU+iKn84dYiW
 7oA7f0vPn57SioGiIPRoqUivRpxIjpofoXa6JLTPvfkltieSphgotPyKG0ucAB7n2TrlessBEH
 o9vljq9KHtd1kDDYCi9Ad3CGCIeK8RM7sVEpGESCQbuwbfRV/d/ZbmHYklXihK5+N0GIDNryKs
 Oak=
X-IronPort-AV: E=Sophos;i="5.78,405,1599494400"; 
   d="scan'208";a="264922305"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2020 18:16:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWov6SXswy+4jQBTI7UPWtlFWa9YtjbS7SrbFz+uUAmE5ZJ0mFGCQHZQGpXcZ+0ULWKkgxtCBO7Ukw8BAgTEdbVTK931yuj5ESDs2JDQ4q3Vh7PcGZ2GSCtGpIFh/LH/0VmrViJM/y5F0h5lCI4m+prPoOuoKTFOrPkAd6x2Mnp9wV3ca8nQynXap3dl9nxUWJ8cJt5Q27HycavI6Pzzmr1ndChQVIBEDI629f5LjM8v3mvyn/k4evQx+lgpfyl8NtIY6q3vwI6QvJvf7u/5jatPll1vkwFcK20vX4PGb4pf/6BHD2LNNDkWJOcTac7fn4+gNlbuKxE1FtjcSwkEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSFdEepkkAQ/asJm6LsLyL71JdcYBHyoy216A8G/W64=;
 b=AQscUjobMdUVRvbjFpFB+jbdpkGtMs39yj0Lqn4yoekZKt1veBPmJZmS7r1izViQIBMAROWTJ6ilGaEkBiCa7n7Q6YkDdPPhdQcLeG4EFZCnRHw3pHZf+/QVSdLFnovPo9GNLpNpxLWk5I28oxW+o3ehYkMOemRDrPZza/E3HeZeRiXvyRS/T74Xu/ef6tH0ACke7z73yNUcSlWbaao6IWvH8UE7ID0tXyeAOlNJadFrkwKwfLOGb+RI8brqGKAUAHshy6KURHS5Nw/ZrS0TJ/TvOL7luuRctUI5eypp5llqpOuGXrDR4iv7Tev7x16tlHAnY9PWJF6+xztuzxwPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSFdEepkkAQ/asJm6LsLyL71JdcYBHyoy216A8G/W64=;
 b=faaclRkyKrUDP19ble4ruhYcerCUNUqU9/1DGXnMqFWpfmqEuVUnOUi7vW6RFggd6SBMxMNkqOv7GNX1dYXzkuWOmZUbGaJJe5prFj4y033ftxh9RiKhTKzpMATpdxayd5rkw0iY/CsRPiFH6tfF/bC/Ja1JM+pJmqQ1yMTA5bI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2239.namprd04.prod.outlook.com
 (2603:10b6:804:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 10:16:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Wed, 9 Dec 2020
 10:16:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHWt1Sb3HZRbzGDlk6Pnuh0g860vw==
Date:   Wed, 9 Dec 2020 10:16:27 +0000
Message-ID: <SN4PR0401MB35980273F346A1B2685D1D0F9BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201209093138.GA3970@infradead.org>
 <SN4PR0401MB3598A4DA5A6E8F67DFB070859BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201209101030.GA14302@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17145c8c-e350-4b8e-5610-08d89c2b7d58
x-ms-traffictypediagnostic: SN2PR04MB2239:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB22392813AB2F7A9971EF02049BCC0@SN2PR04MB2239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0+yftUxIHci3iv7Y9Ydfl8JVRGee8wZ/T9VSxJ6pHsQ4Y6wH9ULNA/bP38Yhn2DZQO6K/JMNbQHXn0plDiwhqfs6fCsfS83kF+8ceCeHPWnlnucXLkB7UZSXMYTmHf24jG9Anrkxh8XW7hzCafsN/aO+MqfHD57w6q4xVVYQ9ylatahTZ39PFDjfMGGZVPYZmCYUktXi4tMNVYyKVlvzEoXTcFeZB4tiNDUnruG/P3cNUc74w8AMYR9h0zONXqIJPGvFTFDbe+vhaPIBnVMKS43m6H4VZ0X7vXjF4YIJNAFUJJgEUp/p++5pCtolSN8LH/Xdn5gVbsCvt/2EEp8OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(54906003)(52536014)(9686003)(66946007)(66446008)(64756008)(8676002)(2906002)(186003)(7696005)(66476007)(4744005)(33656002)(6506007)(26005)(71200400001)(55016002)(91956017)(6916009)(508600001)(83380400001)(66556008)(86362001)(8936002)(53546011)(4326008)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4dDufye6CyYV0x2GHcijYvI0NuF8LXBZ9Zq1DKmg1wAEJeSJdVueapjbsaL0?=
 =?us-ascii?Q?c4qQaLN0aJvyhofnw9Sx8Jo7w0pJbVjGHWDpp17vXVQTc5pyy7UET8t3lIqn?=
 =?us-ascii?Q?9y77RU76zpIVaJkpHCpX4XIJ5/dBthzakWvtTbEv4kgbB4581D7uuA1GMQBU?=
 =?us-ascii?Q?0N48bznHalhcWi7r2ffYgYdlGmRvH40B5btsDAL0PKRUswabDnFDXlNM3M7u?=
 =?us-ascii?Q?xlwN3jhJDuzdHUWINWfMJKEB4148UM3G0/5zgdJ/lfcI3Hr1O8aHnBn919gp?=
 =?us-ascii?Q?dc4dlwQUSF3RgpQ+Kvkuu4PyCe7WIOAb9JSpB/qDR/FqmMs6NBr8tVV54PKO?=
 =?us-ascii?Q?T9vFXNYAsNyR53hloBLBAAIrK8y8ljnZTRgodxhzI17AdvsmZ1r7GT/ar4o1?=
 =?us-ascii?Q?u3CSIT361d4Y2YpyjkM92ETjRC35ABeYiad1TMKgVyQIkXpuov6lXQvrl4Y3?=
 =?us-ascii?Q?F/2SK/XSISWws53wkn5ENA8E3szDKaxTrRvV1zAZvQOmlW9j4DOyPXD9T4Z0?=
 =?us-ascii?Q?31lOJ4jZbyLi5CJgwrYCcEzdOP9qv9kX0EIuyYgMdSzSQIF52GVYzg5Rh6cA?=
 =?us-ascii?Q?+OkOBUEoDJr46tDXH0AtfjwIgOXsWrquHkI5jsqz67WfChyI2TZvl+mvtoeO?=
 =?us-ascii?Q?cqQaipws6KCbjvbB6z3WKQm1CRfLVXfgu350OoqKhQ7PsXiieLTIrB98Z4Bf?=
 =?us-ascii?Q?wJL0wT/Nyq9LFIhrsGwSVm07TREXtoIbDfgv2DGIfaWhbMt4aXUdyDElvM0h?=
 =?us-ascii?Q?d5vvHirgu/UpdgJuMBCDkiE97zDdNJ3W5i4CLA+IK8qtu5Tsemfu5PWVZjVG?=
 =?us-ascii?Q?5tXlKmIYAcMXz0wMdE1WKkhh+NVaSmMRxE++mxK980hfCvzAr4VjT+4liz1B?=
 =?us-ascii?Q?MPb8rIdIW5hjMk0w7BpRZPcLJ2ZfBzz0scY40z7wTJaInaNcRxe3RawrP8U5?=
 =?us-ascii?Q?6r+9in5NoeuqZ7B3MpYGs15fk1k1JvM1sM4cgP4FnBh1c8oEu0eJbPFmZV8/?=
 =?us-ascii?Q?fCcB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17145c8c-e350-4b8e-5610-08d89c2b7d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 10:16:27.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YUfaI1M4ES416g7Pz/Kbjix2w4xRD+Oqjs/wPyspgMibwCpBnBQkvFABS4NWF3CKkw4StslMya9qndO7G4GbrhMV+IUbhmqIR7VYGyV+o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2239
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/12/2020 11:10, hch@infradead.org wrote:=0A=
> On Wed, Dec 09, 2020 at 10:08:53AM +0000, Johannes Thumshirn wrote:=0A=
>> On 09/12/2020 10:34, Christoph Hellwig wrote:=0A=
>>> Btw, another thing I noticed:=0A=
>>>=0A=
>>> when using io_uring to submit a write to btrfs that ends up using Zone=
=0A=
>>> Append we'll hit the=0A=
>>>=0A=
>>> 	if (WARN_ON_ONCE(is_bvec))=0A=
>>> 		return -EINVAL;=0A=
>>>=0A=
>>> case in bio_iov_iter_get_pages with the changes in this series.=0A=
>>=0A=
>> Yes this warning is totally bogus. It was in there from the beginning of=
 the=0A=
>> zone-append series and I have no idea why I didn't kill it.=0A=
>>=0A=
>> IIRC Chaitanya had a patch in his nvmet zoned series removing it.=0A=
> =0A=
> Yes, but it is wrong.  What we need is a version of=0A=
> __bio_iov_bvec_add_pages that takes the hardware limits into account.=0A=
> =0A=
=0A=
Ah now I understand the situation, I'm on it.=0A=
