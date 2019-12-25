Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC2B12A5EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 06:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLYFCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 00:02:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6072 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfLYFCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 00:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577250152; x=1608786152;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oONZc9MhB0kHYIdh9mqwfZowDIZyUMDiKkyfmUhRzw0=;
  b=Q92gmcpQmFZJ5zWkvObKvKL6emYZlb8rxUxb5ocCDJ5ovQqTBlYhoC/F
   lnIxgda2WSVXwRJ+15sTGCVpbJdzBft2BFYV2wAufLsS0pFRmyJhkBvcm
   uIukISQHFJ0p7+lpJqv6cuCl/+p5ZKVCXOM8GUWT+T4ec5WWAV/kT/73D
   QpapbOdVRll1RZt6yG5Pb36F4T1KD1cmopiUxYkLL6oqqawqmInQbgImA
   Cc5i7nh+MctIfhlD+O5XrjWTh+3Hsge91sXanrg9bAhglmuIb+UTLd6gm
   Hj8bA4hQs6qdF3sgxwIwLfDRVklLfJTslbqy2HBX/D9W30qcHKEkzldRB
   w==;
IronPort-SDR: +HtJaTYRZb4npHAgfr+stM6FK1tu1s6kW+kvGcFZtZHI2MUJQkqy5/ZeichihfW1VWhfFs2KQ/
 WPzFmBXr6PnFd6ylicx9z9bcqHarrG6w65jwuzXo4Ppl87tr4FmwE7F+p8PyZmSriml9yyy7oj
 Ld+fHzUbpi6T7+JJm3uvcH+7btnJTCW9SjfiuA+52U2/1DTkKZ2uW5JfXsR71S7mf3MDq4Z+xL
 Je6rXVKKxU9LI9tOR4lFG/rZBHPxvJ3FalF8+nGd73t2sitrJN34DYL6Rdr4WqDurzgExi09DA
 5R4=
X-IronPort-AV: E=Sophos;i="5.69,353,1571673600"; 
   d="scan'208";a="130534541"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2019 13:02:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN9ifJYXRDNyzv9r62Bx+tXIg1S5Z4xtjSBMvqBZ2rYBIh3pC6naT1xESf+7ZVbldHdPMiluCtJfmTHs7dwxW39XNPGq+UAx0ZGkLJNm9Vx2SH5VVRszQPjesY9CjQyUYgDJjNU169l4FEEpBDKRBBUOvorgCMfcyvZzNXrFYxEH1R02cW5Z2d6PBuGRppLE80GLOm2KfvolD2vs86xbj35+iv13nrNk/+Kkc24KzPtEfX6FgjuXqQ55izgRwmaYfpFDKjJ3bnHDAaryEm/AWpI90Rezr17GZDoppz7nr4JhHAlQ4RWHhnk637DtZA+CMfqR96v42TtzQUgsSc/xmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjQRVCMxwhjCD7c2JSOmZG+yZ9QUpzqdsa58qc4oIMs=;
 b=Au9qKckseeV7Mc07feno4xB5edJHTiE0Ib6vcsPllK/psFCmmKKwjsGsXUFzcDlVKIEom5WApe4JzC8jfcGox13Oe82tAwAkXUCn0aYl5unzF6ME3Ze4Pv6gOBk5jn5SFSlJE7pc+HseF0Q87kHjXdIQQNBhJLl09SqSGlavFuyapq13fINp3D06/07M8z86NAMf3O56sbv82vakwUwUfKENGjHU4UuEXbH9Hs9K9YMZhUFbW6D1Hz44TbJGRMPRzsF4HWpYvxTEFsp3ZbXTuUnnBnTKAdaWItUrad7ciaTEwxADhtQwoth+RcnXRF6vAkF50W7GcMNvNDjea7H6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjQRVCMxwhjCD7c2JSOmZG+yZ9QUpzqdsa58qc4oIMs=;
 b=foSkttUlu4ifmMR/kuUAV6fCom1kQ8Ll6tqKAM9u/RDMm5JmDv50QIS2qwh/HUStYtLFTVQLhzcP8vxWbqupcyP6W6bFKhv8OAxT1/JiCKxzXPETXLdDwphf5nYaDaEEJm3c220FPriz9PEjypKNnZAQw4fPk8+6QMX9VIVPJK4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4869.namprd04.prod.outlook.com (52.135.236.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.20; Wed, 25 Dec 2019 05:02:29 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2581.007; Wed, 25 Dec 2019
 05:02:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v2 1/2] fs: New zonefs file system
Thread-Index: AQHVtwKAJkM7crdOGk6pusveV6ToBA==
Date:   Wed, 25 Dec 2019 05:02:28 +0000
Message-ID: <BYAPR04MB5816C2F5625DC5B534BF050EE7280@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191220065528.317947-1-damien.lemoal@wdc.com>
 <20191220065528.317947-2-damien.lemoal@wdc.com>
 <20191220223624.GC7476@magnolia>
 <BYAPR04MB581661F7C2103E8F35EEDAA0E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191224042557.GW7489@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d019ba1e-7917-4310-5931-08d788f7a442
x-ms-traffictypediagnostic: BYAPR04MB4869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB486947C333CFD01297453C71E7280@BYAPR04MB4869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(54094003)(189003)(199004)(55674003)(8676002)(52536014)(66556008)(2906002)(9686003)(81156014)(71200400001)(316002)(81166006)(5660300002)(66446008)(66476007)(33656002)(64756008)(76116006)(91956017)(86362001)(66946007)(7696005)(26005)(8936002)(4326008)(54906003)(55016002)(478600001)(53546011)(186003)(6506007)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4869;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CCL6K7ENWB7nas0YJMCtNeW06Y975GJWEiyvmoizUswZVemwabb6vgVJyv7e3KaTHWD4nLXuNarFzOoeup1r66AHGUN1UDBxNBWv765wtICHDeeL+ybJmA8zUq7NUCvIRBiESMAurexzkEGWqU1zWTjS20ACJ5vq2vGeQhGV7PberydqDy/7UTCMFvEWhtWrzaGMYUuw8y4fZRuo9OI7Jd6RSm7J/SlHmPIaw3vVyVj+P1m+ubsRXBW1womQUXpXPSe1oxOgSvaWTtUzyvv6NZJNRG2j8FbkxKyjV/sCR8PbcErSB//oDGdryBHeE/yWD65UygsUGhhbifNjaPKUjNnVIVG61ZVSRSASdACX7rjYsZ8/mtKVO3vRRw//He/oM7gm4pVgaYgwM5DiKc2KauaiMJtcbmUtvEP/+ioiobMlN09izdKUYKKqYgSEWut02ZddLikd/yRqcw4pSpLSu+1K7G0sLvICvuXYhgtbO/Dln+x3m2We6HSgejDYRGVkTI7RA4LqOP6CUUaYxh2BRw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d019ba1e-7917-4310-5931-08d788f7a442
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 05:02:28.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaklMSVgIlIo9ZaUqj/QeHXvlxS3zPsDu3hNH0FDdDLs2n+K82pQL6RXI3mdZ6N1ikYVTkYWiUZSI4fni9jDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4869
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick,=0A=
=0A=
On 2019/12/24 13:28, Darrick J. Wong wrote:=0A=
>> [...]=0A=
>>>> +=0A=
>>>> +static int zonefs_get_zone_info(struct zonefs_zone_data *zd)=0A=
>>>> +{=0A=
>>>> +	struct block_device *bdev =3D zd->sb->s_bdev;=0A=
>>>> +	int ret;=0A=
>>>> +=0A=
>>>> +	zd->zones =3D kvcalloc(blkdev_nr_zones(bdev->bd_disk),=0A=
>>>> +			     sizeof(struct blk_zone), GFP_KERNEL);=0A=
>>>=0A=
>>> Hmm, so one 64-byte blk_zone structure for each zone on the disk?=0A=
>>>=0A=
>>> I have a 14TB SMR disk with ~459,000x 32M zones on it.  That's going to=
=0A=
>>> require a contiguous 30MB memory allocation to hold all the zone=0A=
>>> information.  Even your 15T drive from the commit message will need a=
=0A=
>>> contiguous 3.8MB memory allocation for all the zone info.=0A=
>>>=0A=
>>> I wonder if each zone should really be allocated separately and then=0A=
>>> indexed with an xarray or something like that to reduce the chance of=
=0A=
>>> failure when memory is fragmented or tight.=0A=
>>>=0A=
>>> That could be subsequent work though, since in the meantime that just=
=0A=
>>> makes zonefs mounts more likely to run out of memory and fail.  I=0A=
>>> suppose you don't hang on to the huge allocation for very long.=0A=
>>=0A=
>> No, this memory allocation is only for mount. It is dropped as soon as=
=0A=
>> all the zone file inodes are created. Furthermore, this allocation is a=
=0A=
>> kvalloc, not a kmalloc. So there is no memory continuity requirement.=0A=
>> This is only an array of structures and that is not used to do IOs for=
=0A=
>> the report zone itself.=0A=
>>=0A=
>> I debated trying to optimize (I mean reducing the mount temporary memory=
=0A=
>> use) by processing mount in small chunks of zones instead of all zones=
=0A=
>> in one go. I kept simple, but rather brutal, approach to keep the code=
=0A=
>> simple. This can be rewritten and optimized at any time if we see=0A=
>> problems appearing.=0A=
> =0A=
> <nod> vmalloc space is quite limited on 32-bit platforms, so that's the=
=0A=
> most likely place you'll get complaints.=0A=
=0A=
Yes, agreed. But the main use case for host-managed zoned drives (HDDs=0A=
or SSDs) being enterprise servers, 32-bits arch are unlikely to be an=0A=
issue. So for now, if there is no strong opposition, I would like to=0A=
keep the initialization as it is and revisit later if problems are reported=
.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
