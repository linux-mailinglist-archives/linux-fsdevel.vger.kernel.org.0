Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A92D70F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 08:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394050AbgLKH1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 02:27:47 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21868 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391088AbgLKH1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607671651; x=1639207651;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hlNScCgUl4dAr6uki2h8hK6DrCHhuxwmd+owEJwdU7g=;
  b=VG98E+gtYTIwHka5IWjQu7AfdrL29BvQEzsDGmmsda8kOgcAGewE3Rvr
   8wmA0a1cAOt83SBw3CfDKGiaXh1docsISQU0VF8V0m4SHcob+Am48p7lh
   lQzykjhKEV29zR9CrnR562j0oA5kXFLzorM0qgPAusINBNY3kiJbE8v+m
   /C/Z2nNastyCxwmBjPDCBMXUShwzayvdS5p/LZxoUg6MnbSgLPeJB/FAq
   brse9dIyc4Qm2PAaQn5rTl66RAMpoXr85jaCH3ugAKk4UYCk7kvnz7VfD
   sBKid25RkJoePOCqfZFEw5ay7bW4Py6IkQMQ5makWBTTMtDmDjPQlH1DS
   g==;
IronPort-SDR: 4PzSFzNdxw4/EPb6jjYtK9qSN0q5fBz9NYhw8h+0ieIrAzDkA946ZyUvS9rQ1InE4fb4PyIDSj
 cArKfQdy2MZ8vZquvWhf4N4Xb/yQzkAiKETmAL+8tQkYfPHsjUMZe9DxI82wptqwQtzuowty/b
 eIuT+tRJBUdC2IplhDO4dJS4M028/Iig2dA+t9Dq+KNk2gDytbLouxrQaNhZfXI1d0sHeWF0/g
 XdxFo8E16W9w5IfWeR7SmyvOax9JBMoFaHz1+tqrwBIJyI/1BgzGzhBzjtnjhmNhxCAEfGPMsC
 dWo=
X-IronPort-AV: E=Sophos;i="5.78,410,1599494400"; 
   d="scan'208";a="265089850"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2020 15:26:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/ZK2e7/iJY5E8/k/GmHdRaYMweGDnY8cUngXhP/EL7NdDE3Gvv8mUXJHJZvmzSqIZ+W+9PHLNLAh623daqH11OkcgqlZ0btxXx2hvgEqu4+nCcrJtNr2fWKd7qBSJllnD0zGvtX5N32g3XhNoHs4RHP9IMyEkeItLDMkrub48BKUAylVzx4WW6XdyWJIMcrx/RTe+oOH9Cw1odCPvMv0Kf2DiHDeuZq4Q3+VLnHDLeqkgI1gs6LyJXrGRvtvpgdynGMHEKGLw4WM2W6payprlur0jXQMsKCMrpvIDqh/98AqCa2YoM8iDl7x0Guclxl/AMmcDjaxP8QM3C71kwitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsEhrp/FtfPsjApokUheEXGU2ZDVVuZkT7FsSB5V85g=;
 b=c7QHj6AZuL7l4mlmmiZCYjd5vAkIpVq8BpdHYOCDUFm9p4Blqap01JvA82avwYrzrIj/ZOlwhd140eJo+zmcrFysdUjNFI1M4s71kq3ipEWASEv1Ih+P3lvzW3RxPZ0jgaXpnEEwQiawLq3ThoTYC1kjebyANij5HaXGmlq70+n58mjfVnPgGbyVkX6U7QwJqpijMpniOv2jpvpUvmQB1ut5bF6wDOMlNcIRq7eevtPiF6Az1lGZYjd0IzGO5Vj+S3dKcjjN4ODnbsi76M19/cNyKIR0rDwfnlEhGLRmEUFrPYfcNiZRzrSAIOBWAT2tmMYk7z/aS959jQof62crig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsEhrp/FtfPsjApokUheEXGU2ZDVVuZkT7FsSB5V85g=;
 b=JNhr5V5+SRJBEMA2DYjBxenHpooQR42JiiyQmAe8frEXM3y4oK2Ol4nRN/zGulD41PjmnHCApQaO4QYg7SeyCorf+3qRD+YdVVqf7xkV1zOkMPTmOwQmh5dG0x464BFRu+Lf0Xa9QYJLxNiE3iRjftDQl0ETI0FsKx0XSHc47uI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4237.namprd04.prod.outlook.com
 (2603:10b6:805:30::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 07:26:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Fri, 11 Dec 2020
 07:26:18 +0000
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
Date:   Fri, 11 Dec 2020 07:26:18 +0000
Message-ID: <SN4PR0401MB35982E109738ABE8A093315C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201209093138.GA3970@infradead.org>
 <SN4PR0401MB3598A4DA5A6E8F67DFB070859BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201209101030.GA14302@infradead.org>
 <SN4PR0401MB35980273F346A1B2685D1D0F9BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB35987F45DC6237FC6680CCB49BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c73e3e4-f6ec-4206-6c40-08d89da60d25
x-ms-traffictypediagnostic: SN6PR04MB4237:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB42370D1782F53830A38A47C69BCA0@SN6PR04MB4237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3M8hnFMhGtye7TYf2TQjHxZIaCZF21DoJFuRREtS+tL4o1pIeqmCE48TOVjtcnaPkOMicrXK/u7SawCosSZgQK9dP9nzVmK9ZIZyCinSGmjQs8kTLjcWWicpIbaTvPSg6DJ2HEeiJpK0p4lmuUE1vpsqfBEsaJExK3pIvXwHnYuoHy4aPq7o4k5NpykFPILYAnWj98gICn1eFvlEmimglISUVMoGEeScdi4Hu7tj0JfUYA/C/gXNL/7uCoe/06QCwdt/c1y1jp8snIWxLdXV1WjOYULsIaQ9Pms0O/t0K+MCEqEaPYl4Q/5Ska1kra78Np28cjSwzircUaOK9wocg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(71200400001)(91956017)(66476007)(76116006)(33656002)(52536014)(508600001)(86362001)(83380400001)(4326008)(186003)(6506007)(6916009)(53546011)(9686003)(55016002)(26005)(66946007)(66556008)(7696005)(66446008)(8936002)(54906003)(5660300002)(2906002)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YIUCjRrIm7kqsgzfvsNWDReTpmU8kXLLRsEiPTEbnZiNCuWfBlkREoecG9Cg?=
 =?us-ascii?Q?ETjDfZBNMbMoizLfPlC8hHCRvZR2m3zqJruxsdnO8zjHhgIEstypbEmtL7UW?=
 =?us-ascii?Q?fycWx3jHgrbJvIA4FIRUa8Xg/HuqT9El1/Jk3VLZ5MLo8QJAeJ8/rN99s2+L?=
 =?us-ascii?Q?Ces9O3Ty0zEuc049ByLAxSW1WIPcIkZqONmAkkftF3ghy++8joC6bYFUaHlt?=
 =?us-ascii?Q?9Qgiz6J1sn67/oEK7gBUNTXcLZtlkEB+on+gWIPO/UvruXKH5mdfVTFJoKvj?=
 =?us-ascii?Q?9bvSyVBvREvcXgTiR/5lcR7rOnwCj+i8jmib/OPHdEar0527n+h9fIJHWl0D?=
 =?us-ascii?Q?36y65C6idK8lXIJy7CQ2/jHAdUlwxIcXMp2XGvRGDX63jg/XpCF2XkM6qPnk?=
 =?us-ascii?Q?RtFD9tBF50yzWyEo67STCYTKZiHpBcGgf8zbdnL1TMAjVxWf37miCxbgX8XQ?=
 =?us-ascii?Q?7Ov5i47+Vryz90o0zKxaWfwRm7s/e3L/R/RgSk9L7wq1iSmsXbPzkprpMM1c?=
 =?us-ascii?Q?2U3iz2Rls+1HuodsoRgDcYKIQSuk1+CwVuvog5D3MWvnggdGLIt2sqlJhe/3?=
 =?us-ascii?Q?yPQrxBNQpbJ/MsWAqbXMwbiHeNpnOWJMonvMWJ8SR1dlFWwDFG6jKcfRPbk8?=
 =?us-ascii?Q?2ZCE08YkTxWNzlAImahWVQ0YpnmE8K/gmb+WXOL5M/FcpR+ZsHQwfcDgwnZO?=
 =?us-ascii?Q?alJ674JSy9uGsWnwRfCB167ySIdVuRa4tq7DnNFrd+FB1um80EvPOMsfQLfP?=
 =?us-ascii?Q?7LYtdQaaeUnvrzgnhrioTWskOjguIeOqeSRZ8AgfL6TpVPLiv0Z87qMRGOGw?=
 =?us-ascii?Q?Qu9fz4BKLO0KLk/2P+EeGuMPuLxc/XEpW6nkL1sJE8VEU778id5ZXStqEvPc?=
 =?us-ascii?Q?vrxFn0DJseal59wNNLIwKbsLW2kKxogYYzFN8+MnnNzXJAGrK3Gk+/p6Q4hK?=
 =?us-ascii?Q?t9Owem+6eIaS4vETRG9UO3KK9b1gPLYC67S5e4XauJllpciDiw8MSPKJiNv+?=
 =?us-ascii?Q?5JcZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c73e3e4-f6ec-4206-6c40-08d89da60d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 07:26:18.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNpcP3jorfOoXZXEMzFq6RraHafOu58+8Brms5+vVSlYILaqIMNGEdvaoIUG8emX+VvpJLHxef3O9oVe5Jon4Wu/ThHOjuJstDzxjKSLSZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4237
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/12/2020 14:41, Johannes Thumshirn wrote:=0A=
> On 09/12/2020 11:18, Johannes Thumshirn wrote:=0A=
>> On 09/12/2020 11:10, hch@infradead.org wrote:=0A=
>>> On Wed, Dec 09, 2020 at 10:08:53AM +0000, Johannes Thumshirn wrote:=0A=
>>>> On 09/12/2020 10:34, Christoph Hellwig wrote:=0A=
>>>>> Btw, another thing I noticed:=0A=
>>>>>=0A=
>>>>> when using io_uring to submit a write to btrfs that ends up using Zon=
e=0A=
>>>>> Append we'll hit the=0A=
>>>>>=0A=
>>>>> 	if (WARN_ON_ONCE(is_bvec))=0A=
>>>>> 		return -EINVAL;=0A=
>>>>>=0A=
>>>>> case in bio_iov_iter_get_pages with the changes in this series.=0A=
>>>>=0A=
>>>> Yes this warning is totally bogus. It was in there from the beginning =
of the=0A=
>>>> zone-append series and I have no idea why I didn't kill it.=0A=
>>>>=0A=
>>>> IIRC Chaitanya had a patch in his nvmet zoned series removing it.=0A=
>>>=0A=
>>> Yes, but it is wrong.  What we need is a version of=0A=
>>> __bio_iov_bvec_add_pages that takes the hardware limits into account.=
=0A=
>>>=0A=
>>=0A=
>> Ah now I understand the situation, I'm on it.=0A=
>>=0A=
> =0A=
> OK got something, just need to test it.=0A=
> =0A=
=0A=
I just ran tests with my solution and to verify it worked as expected I ran=
 the=0A=
test without it. Interestingly the WARN_ON() didn't trigger for me. Here's =
the=0A=
fio command line I've used:=0A=
=0A=
fio --ioengine io_uring --rw readwrite --bs 1M --size 1G --time_based   \=
=0A=
    --runtime 1m --filename /mnt/test/io_uring --name io_uring-test     \=
=0A=
    --direct 1 --numjobs $NPROC=0A=
=0A=
=0A=
I did verify it's using zone append though.=0A=
=0A=
What did you use to trigger the warning?=0A=
