Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D949B2F51EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 19:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbhAMSYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 13:24:24 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7415 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbhAMSYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610562263; x=1642098263;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=shm7D8uAvOAILpeMB5LJ18mMdf/3LmhurtgxhX7uFtY=;
  b=IZxD/UGHbPA2LdhQUUfMmFvsVwZsnRdCEQzyQmVwOsd8XykTpsI1hukN
   GLbJ9qfrhquoSLboLaDpI+DnFUy/tBvHIw//3s9iYOFSQzfJPG7YKK0s+
   m4JAh96E3yuXQ3080QUJZvWno7RGG0tsDI0Ebp5EtxUlYXDAQ2v+8W9KO
   WWzzrJC6VnswQAA4ASX3/iMh6rUIFapiZAxCL+RfZ4nxm8jB0khF5uBCF
   IBrbt/ufFU1y6arKIsXgar0uedu0uwHTRDx6rywbxDPLhtai0kPTe7s8k
   hrEpTJqfU+t9EasEMDl80pcUuGHLmjdiI+xbtCwgEp041qlG5Vc5l5K+m
   g==;
IronPort-SDR: qtsaCHXucI8jA7xVlK9yDeSzUXpbqaijB6wD4vqo2iumxGzBK1hyMeFtebes1O2157BHK+aL/0
 nfSRCDhxYXQirhlBCeB5YWx5+iKC9dPfVNU/4VoZe48qvKv8hKQ/20NCz4uizDxhtJba/IG/cm
 jDX37hDJxLJD56zj89mqszwiPW7Tna/NCVZw2t2hGFiBNR6gg74f/W9BoI9e0XfkWRVLzUfbAs
 9yf8uAEfG44H4tlcfePbEsIaqEbscvtysKBDwAJY55CLUVsNdnJwU+Z4wJFoRMXRxUVpe0bBPZ
 46E=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; 
   d="scan'208";a="157350123"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 02:23:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP8/aBiifpb7YHmJjipttBQvYQolW4n2m3DKGMg2Qrb9jqGBpRB90qMLRBBJ6vttScchd+8iZ7oo7xlpAUkdf6igSYGWsYx33qzMaHQkxNW453lIGc+ee/ZKejXkE5zSC4Hd/9TsyeeTPFq+xJUkMgdg0jWQOGwVFytGz8fyHzUvWd0moM6/GOm1JoSER7IHJTjQwWkpfgdwRBQKZFq24JWwMohoK8PLHUNYgtjDcomJ7KTntLtQSViHk8RLL6r5XYRNBNwwDZvgXP8ojvsreOgVwgB5f039okFhaJwtEpHIoNMMOL25qNqHOIcvNBVBCME9o4x2guZ3+xwPzLMk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvbwITBK+rNfLwDBaIpx7/8hanyy7+QRL+hr3cfhiZY=;
 b=kHgTvbaiqoNXasLZ8h7MyEg7A/saB+kpZZppfCW/GAVfDM8BDKKSvWvtufXDhcHU6YcXVX3PEQkbt0pPZr64cfHJYYo4fhBroaHPqKFaL++3fzF8NNjvCjHXWFQjV7fgnrKL6L7ZgS9IsdTkYUIlIVGMSG+mx0OWLQp4XY7JRQAV3SznOeWbzoN8cBJIJ3OgKaScRujdQPtNncMzd7RefTAugKuY6VQAjZksa2GL5yjouCgYku48hWTzHlTI+0rF65RxzuIid1jQ95PWlNvjysHspyjYAhNvV8fJSebI50CqRvCd2qw/+orntTnHnsI2iEPOdTWh38AW65Uz3X4K+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvbwITBK+rNfLwDBaIpx7/8hanyy7+QRL+hr3cfhiZY=;
 b=uZcPKxKguigEr3LTiH6FGsCfB4thmBF0REcE8isF6hZe3cmaKiVULg1GY+iWDAerKkJDBklhdxdCN7ZNRNvB+CezRmOMTv7CPB3Oty3DAO2UXGblahKQnpX94hh6IDWsfwGmwPNFNGjkxuY8u6aTTJCBpaXiVgSXdmd6LeCqr1Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3967.namprd04.prod.outlook.com
 (2603:10b6:805:49::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 18:23:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 18:23:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 08/40] btrfs: emulated zoned mode on non-zoned devices
Thread-Topic: [PATCH v11 08/40] btrfs: emulated zoned mode on non-zoned
 devices
Thread-Index: AQHW2BWcUYX4xLVlc0uHppav6ENdEw==
Date:   Wed, 13 Jan 2021 18:23:16 +0000
Message-ID: <SN4PR0401MB3598901190835E3C72A505749BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1608515994.git.naohiro.aota@wdc.com>
 <e2bcb873196a16b05d5757cd8087900d4f464347.1608608848.git.naohiro.aota@wdc.com>
 <20210113175843.GV6430@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:c8b:c088:e383:ecf6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50704f65-d59f-4378-c028-08d8b7f04bf5
x-ms-traffictypediagnostic: SN6PR04MB3967:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB3967CB24465B74E5FBD94A029BA90@SN6PR04MB3967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uV4MMzFGheqKzY6Usf4XNMWKNlpmTBttGnF8EL+Hs1D2XBhZNEdJd1f0kYgBe/j9/dVBPjyerMqfQf/zG03p9aavWjVCfN0kFAM9PbbN3CH0pkemfaXz8+nyNAE8+ZJiUcOWoTvrDJ1/VlpqNTcNJ7ZnraZxMhCS7+vgiYHtjQiDkFSGnOz8O7gQ6kpG4pcsn3VB7BC7yuZYLUI/NBl8tHfRVxMJni2y58D+aN917DiyIRWTV86u3ZtImHF10/251yXbYWobHeNE2t9XV8Hzy56fC3fYZxHdxvKLjVMa02rRh6LdOzxBcu/MYsWklQfEHr16AOmBfLl4FTZEYPZvMHQR6wfFVFxpOYP0UknmcDURN3BmW1KDNKrAY7zZXvTtrLU4Jw7hb5VQPEGcc/ic8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(6636002)(4744005)(55016002)(9686003)(52536014)(66446008)(33656002)(8936002)(5660300002)(86362001)(316002)(8676002)(7696005)(478600001)(110136005)(64756008)(6506007)(54906003)(71200400001)(53546011)(66556008)(66476007)(4326008)(91956017)(186003)(2906002)(66946007)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JiZF4gfKL95uyRIf8yoTwLZAVcpQsP99n+QnwGkDuWn7hKX6Zofg3celOtUk?=
 =?us-ascii?Q?8mvfSjF51JUpqdAIlYSSypjQ+4qMkL9V0cIYudTl8sUMySLsYUSiTVfZNOgE?=
 =?us-ascii?Q?71TLhzpndpjBglx9aORXDc5JjH0u9r0fZhF3kkX13dT4+Tll8P3cxjFj1vqs?=
 =?us-ascii?Q?7vCpIdgIsQRH8xHdB7WWbcjWNVbMtg/1bTU7kK5HODI4X9di4oHTn7+MuYO9?=
 =?us-ascii?Q?kyZQ09YGDlEjrJ4nlpGRJNnBZpNoJgTNEYVKjcXhUQsCX55tGw3JtB3Lbru4?=
 =?us-ascii?Q?jLp6jbX4esOSa5xbZwdoF+lP7EqM+4QbFSJoE53hRmPI/lTHb8jDEmc4uRKs?=
 =?us-ascii?Q?a4B0NTE0MxvOgqhc+mHJAE/ZpSOyCQOyvqkvHAKeslgRipBJE2oCImCiprJF?=
 =?us-ascii?Q?Kuc4Shg4WwkaY2FAmqcJb33p9WQ6mgzkABXyFJH0XPoYRcz5zqIoeKERku9N?=
 =?us-ascii?Q?hTFOp0Fa2OUFVahnV4ZxIB3jNdAlMy0iExw/+KJu4Om6ddFlnbiPEnJoguXc?=
 =?us-ascii?Q?256qjIcj0oGkepNnerYiVNbs+5+JadGJo+peyh0b6hmw5ocHFvisvPZjoAwg?=
 =?us-ascii?Q?hrPgYcE20+i5tnrSc94fu2RL1NZVlFJYvDL+5fPgjhPZRSDDo/MHHulF6Um2?=
 =?us-ascii?Q?19q5T/LJj/IHatB3gPuLIplsEmeaK8q/VWv8OCVDc3eLrqVO+0zT899oUIDn?=
 =?us-ascii?Q?g5RP0bFm44SPhX53erOluUrmqfzvshnlxEP82dOLBeMlS9h97jIn9h424Gs5?=
 =?us-ascii?Q?2T1n0nAmMpxcRnbsPmSwh5SvgFhdErPxbbwfLq2XmyEjb9zCzLq3zvHDuWsw?=
 =?us-ascii?Q?Pm6souQvMyZ1GpIPY6nKJuGB0nA5gVH3iZXQQisiZd3mcREaxkvEVAP2Ai0F?=
 =?us-ascii?Q?wZqOlR+bMMYu70wzxJ5eqLeEPnRdltC9iK316lQ9qKT+e8dhuLugzLc/jwUU?=
 =?us-ascii?Q?ml3I9WgTvW0Kgb9ZPbTOJiXNRlZhxdmL/JvKBoJONBE2guInb695mmDN5N/i?=
 =?us-ascii?Q?Q3vbmUHtIrjnpWrQrUbdXgSSVVI0bACc8orKZ26/mH4dPNbn7gxAqGo99zoG?=
 =?us-ascii?Q?BTMVbNTB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50704f65-d59f-4378-c028-08d8b7f04bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 18:23:16.5986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7xPR2cOiINVxBRTWNCHwWxJb001mYTaLJ/Gl2xJB36QqCFvL8tKfwOFRFwajKpehmFK+gUnBjxAMHPazCWexOn+mvgjvhPMtOSyEmCrWl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3967
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/01/2021 19:00, David Sterba wrote:=0A=
> so what changed that it's fine to use device->fs_info now while it was=0A=
> not before?=0A=
=0A=
The time when we call btrfs_get_dev_zone_info() in "btrfs: defer loading=0A=
zone info after opening trees". =0A=
=0A=
From the commit message:=0A=
=0A=
"The current call site of btrfs_get_dev_zone_info() during the mount proces=
s=0A=
is earlier than reading the trees, so we can't slice a regular device to=0A=
conventional zones. This patch defers the loading of zone info to=0A=
open_ctree() to load the emulated zone size from a device extent."=0A=
    =0A=
Hope this clarifies your concerns.=0A=
