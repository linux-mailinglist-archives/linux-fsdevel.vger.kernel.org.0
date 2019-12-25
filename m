Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9612A690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 08:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfLYHUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 02:20:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53766 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLYHUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 02:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577258405; x=1608794405;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fH+Jq6U7bPb2MKWRBn5Dl/Sisl+BG+gxaDejNRBmhkc=;
  b=Yl+/2aOIyNn79fDBvcbBayX1JldWyBoi1ktaitLg02IIiA18Y6Q1fZVK
   emvKSMNVw0q1/fXdnDylU2NHhFGUfmi0t3ywtlb4Kdm2kCSmAL+niHzKs
   X7xs2eheb0hkHz7LvQyN11HhCfItIEN5Nlq2x35UkZORHZXxt0dVgmXO/
   BnGJlJuDoIXKSvZ4oYtz5UR9CkL08riz8bQBo8x2lfHWOjj3qiR1o8MEm
   UjSQmL0UGxbNYS47TcHJ7NRoH1ECDCXP1KVN3PT0TfEmnaEfpKytfP4k7
   Im/C3GG400BkLr+nuvvlE+GjTAn3qNgIy8fXd9c3TPG1WaOu32uOXPFgV
   w==;
IronPort-SDR: ItP0j8B+v5mW48sjpiDNHwpLEEH50RWLL04wkBtQvzWNjIt7Umve5qT4CoNh+eptEEHiIZW6It
 BzZPLOuBAscvt2BlNaSMcuqxLg6cjXGvDPMicuI2N8wjzboJVaSBJS0DvqSAGUJRyG+REz9KrU
 InWNTwFanpyRjulMB5Pv2j2RR3rEiVItOSm/amhfP7awkLs6j9a4ed6HpvdUxFNt1LEHq+9D8c
 GoJTLp6T+VHXt6yT/IBjQCHBHYuVH/BJRInqtSmpo8dhTdQGBhI0SXsKFlglLMmDP6SPh9zvRc
 1Mc=
X-IronPort-AV: E=Sophos;i="5.69,353,1571673600"; 
   d="scan'208";a="126862484"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2019 15:20:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boejPbtlUJXvVRmJMWzADmjR3EIkqom2VDHEgAaJ4Akoxwa4doc9DGtLRQ87+Mh73Y/xJ+nG/dOyErSTDWwlweNiXffTgzYZxeMyjphl3GcGDAGrsfHVEUl1zIImBYPhsoqFV3qvmo07smuQf7c0lFyCSMPNfExZ9vww6fHzafZNgaW5294KDgBCuaA3pPWEe5pRzcWx5foBnYcqT+wVHb6IuyUBB/2OBT1MeuQ0FMEst4XuotSRv4GQanayTONX9p9VpVRCfveI/+Y7SUW1Wf0tFO5LoAk68bVltXn2S0mKPagvYDx8QUb6ly2A01cEYTwVUk3XQ6XwQC+C4uSQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoi8qYKLknjMZtAhAIDrHbrfiTDRf6Sic3qmYlIM5eY=;
 b=N+A3NUFdUfG7yXjv7bIKbsMbqm/BltByZqjoeE2E9/lOlYtltA580m1j2PqJQGdg5bFggkBdAV+prXKDsbg5O1iNvEcKWcKQkNkFfNRSjn8wXB5wEjONv4C39i/PpuGEC1mSldSqHEyTLgNwflfuI/xcz9ml4vFdYqIajdRRCr1vEdjA5g7FZJs/ro6EHaLs4aFYus4WcmzuiHrTN1AZUyFswAL418QICtck+Zf/x2RiakbTLLHWqgniDBadtSCql1jTtPm88o7SBX31bt91mb0KzYC4uh6XkmT72SnM04skLgXGGGEIb8PQb8xwO5Zul7SU0cKc2ROq8ux4uBvJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoi8qYKLknjMZtAhAIDrHbrfiTDRf6Sic3qmYlIM5eY=;
 b=mIgrkrl3tTZjE2pkHnm/mLwjqhtKMUVhjV/VOPP3HAtsb2zCa0ET/sarQ6Bgv7wCUlBBsUAd5eKv7zcZmZX0GpoaOQlcR4YpLyYanWvoR2RZ16OMbboaFBPdcYcTV+8SbvWPScXwJKcJj2KV5eoQLF6CW943iQtWzTzEwNe/uxk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4392.namprd04.prod.outlook.com (20.176.251.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 25 Dec 2019 07:20:03 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2581.007; Wed, 25 Dec 2019
 07:20:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v3 1/2] fs: New zonefs file system
Thread-Index: AQHVuf7BpC1bTe1k6UmgztFIqbNKpA==
Date:   Wed, 25 Dec 2019 07:20:02 +0000
Message-ID: <BYAPR04MB58167AD3E7519632746CDE72E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-2-damien.lemoal@wdc.com>
 <20191224044001.GA2982727@magnolia>
 <BYAPR04MB5816B3322FD95BD987A982C1E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eaa23faf-f90e-4727-f443-08d7890adbff
x-ms-traffictypediagnostic: BYAPR04MB4392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB43921CC3521865AE4CE761A0E7280@BYAPR04MB4392.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(2906002)(316002)(186003)(9686003)(4326008)(5660300002)(8936002)(81156014)(8676002)(81166006)(55016002)(86362001)(26005)(71200400001)(53546011)(6506007)(76116006)(66556008)(91956017)(64756008)(478600001)(66946007)(7696005)(54906003)(66446008)(6916009)(66476007)(52536014)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4392;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFSQsCbahM7ot0qVTsYJe4OaE+YvSuMJFvbv79WxgEIHWNuWj2/BGx9GlcBu2WrUHcFEhkAxp5vlj9twhwxfIhKDCw9I79oUFFzXuQHMHojji7rYTeCNVuKfuOVDRnbJXn3i78HywJWxmDu3+mk8hOGF4VIhJvy6/GtBs6l5n3Y9WShLjaK8u1gLz5I8PK4tBQSP4Ncq9gCHRoajczwUt6TIWY16ZW09HbIN6/eNyuwlhn0ZBYmyKx0mgtml0+dAuzH1Xt8at5Bz8lvipLeM+hi3kpgByx1orOAoUz8XZ7ePB/U4XF5hu2K/rc3CWJw8xZxnN2JS1j4/ln8+/q0Wc0dXdkloH2zSo48xwJ944ZSxhjo1yCKuUOIZ9Ejy9fWC62BtJCTV7Ckn31F7Utu0GmzyrNX/elwJO+MLke2puAU1vT2FMr0/XtfD4gczPR9k
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa23faf-f90e-4727-f443-08d7890adbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 07:20:02.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTlE7MqCdNkKnPi1lUZpyXeDPkJeGXqlLBlUr7MvCYSwf0vIBNUURorhAPB0zJrj+oE0H1fhfNzmO7RUPOi1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4392
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/25 15:05, Damien Le Moal wrote:=0A=
>>> +		inode->i_mode =3D S_IFREG;=0A=
>>=0A=
>> i_mode &=3D ~S_IRWXUGO; ?=0A=
> =0A=
> Yes, indeed that is better. checkpatch.pl does spit out a warning if one=
=0A=
> uses the S_Ixxx macros though. See below.=0A=
=0A=
Please disregard this comment. checkpatch is fine. For some reasons I=0A=
had warnings in the past but they are now gone. So using the macros=0A=
instead of the harder to read hard-coded values.=0A=
=0A=
> =0A=
>>=0A=
>> Note that clearing the mode flags won't prevent programs with an=0A=
>> existing writable fd from being able to call write().  I'd imagine that=
=0A=
>> they'd hit EIO pretty fast though, so that might not matter.=0A=
>>=0A=
>>> +		zone->wp =3D zone->start;=0A=
>>> +	} else if (zone->cond =3D=3D BLK_ZONE_COND_READONLY) {=0A=
>>> +		inode->i_flags |=3D S_IMMUTABLE;=0A=
>>> +		inode->i_mode &=3D ~(0222); /* S_IWUGO */=0A=
>>=0A=
>> Might as well just use S_IWUGO directly here?=0A=
=0A=
Yes, I did in v4.=0A=
=0A=
> Because checkpatch spits out a warning if I do. I would prefer using the=
=0A=
> macro as I find it much easier to read. Should I just ignore checkpatch=
=0A=
> warning ?=0A=
=0A=
My mistake. No warnings :)=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
