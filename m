Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9536530126F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 03:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbhAWCvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 21:51:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45787 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbhAWCve (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611370294; x=1642906294;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3XclkR8L9i0FGb3L0ElSvIwlZkppnoPbiWyWoN09pm4=;
  b=Fn7KsHP55MdvMdmJo2h9hRjIylvQTcD4Wu63jTA40zx+HNYjh4LmqDtd
   4aR+ZzHR73xuQx9n2Ox9J1VhVRXreL4DV49yec11Wg0opkvB64I4TIRpq
   Cx3xAha3YmC5Irp4whAHyJY3rP+w6IDpRbw4NZsMFt3GrtJj2I9NHlGFV
   S46C07vRpCtmNAxMQ7bGwRAZdFVVS/OaAQqr3nyXXZEh5Xt6xI5TAELv6
   fnKNPZWoRMnKfhlBFnnGop5MocAxdnYU4iIvZGOuF4OshMM9zM3qWgxOG
   HZxVL42+OVh4UgTdX+SgbAX1QwZ7Bvb++6rwDYnUCBtUZDW2j5cEO2LaD
   Q==;
IronPort-SDR: ZKfX+E9pjYGSvXE6C/h54AJmMkWY4b9iwxK/f5YxL4vsudyLeqYLkl8W6uDc7+qH/DQ2AZfh1c
 7VZdRjlS66r0zG8JroRLYpeLSEutEhTYxI0k4Eiqd6OAlgEuz3g6Oymq7FfKXgFfl7N9rnjBBS
 Q382pTdqtZAynanWDxSkzvoOQEUoQZuWU/c4dHarTsWSImveJRVaihtccxTckmlYHbZE/FXhvB
 q9rM/SRgDlyT7lUFJFINkFe4HuPdQP6G77gAaGp0xRKBUcRgdnVqH40Ha7EI2FTMYIK0mfDUec
 /r8=
X-IronPort-AV: E=Sophos;i="5.79,368,1602518400"; 
   d="scan'208";a="158138568"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2021 10:50:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbkGrZ+rFVz335vMEgFas7Is4GnST03BSkP6We5ctHQl4Rao1WIkc59ydVdlPmSWQadk4gb0d7vt5Ae9hq2w4CiCvojRRNoo3nAFA8Fj/TVJ/srIiMN6FrYgdkhxrJEHa7dRAnyryFZMQG6VaFo7fiDXEFAExxwOJXVDkayU7RIDCd31SWeMp15IGPP4CJ9z7wtv9Bnq4tQaQBOWG/S6BZqnM04r7BaPOrQR1ksW5LXl8HlNECe59rzATe1Rh8bx+UP6HLsSV4LdIuL3BPyoYZcs3h9eMaBWLqoT/Q1LgVUa3PrIOjeki18A/M+sZoS/nUb8wCglRc7ssvP7nwI5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XclkR8L9i0FGb3L0ElSvIwlZkppnoPbiWyWoN09pm4=;
 b=PVb7mao9JLpf0UjN30jo5HBUS9mjAjCvVTeH7Pt6XEEn9+me+0VT7irhkcxejkgOzubq4W+CQ77W/VpksoED5XJ9ITil6vZcTy6xS9d60oXRdewn1yanpb7SoGT0lxuS/r97MiuX20JGGzEsA8ptBHV+ErxMmKTYGUBv72nGjWSJgBVBgILxwnFLmZr01iinusT6nDyl7UA7pdDTSNywX8pla5ET8hZyGuuajx+E1c87+xlPBSY0DFX6JKFUXsMWczWluGSaTyHkAxwapSJgzXC9JjB1acGUWsiNHd4zUWQc0QMJIa29gAXDfPKZLyGB40mvmGRbK5nW2qOIQao3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XclkR8L9i0FGb3L0ElSvIwlZkppnoPbiWyWoN09pm4=;
 b=DicMMMT/1WQlxOLqhNussyeJMhm+1Xs17yr4Ovt+cRGr8G/6VkalBVdmghwESK255l04LpkS+mI6wsGk7GlMXCZVGFwUQElM/aGsyZGVkTpdjqB7oYWTZj4/uM9U+KSAn21psGOruxYmJxNnh+J3L1wQYGEOEXOz2XFLvplLboU=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6188.namprd04.prod.outlook.com (2603:10b6:5:12c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Sat, 23 Jan 2021 02:50:23 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3763.017; Sat, 23 Jan 2021
 02:50:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v13 01/42] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v13 01/42] block: add bio_add_zone_append_page
Thread-Index: AQHW8IdLf0pDgmmWhUSc59BsHZKVgQ==
Date:   Sat, 23 Jan 2021 02:50:23 +0000
Message-ID: <DM6PR04MB49724F6C4B6BF2C9DF7B904886BF0@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <94eb00fce052ef7c64a45b067a86904d174e92fb.1611295439.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:89ac:da1d:fcc3:58a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29a0b746-ad21-4f5f-c02b-08d8bf49a148
x-ms-traffictypediagnostic: DM6PR04MB6188:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6188EB4AC72563C01749D88F86BF9@DM6PR04MB6188.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCZYUkpIpEAlzyMvyxD3MJaMHli0ETWgP03QccPwPBMdhg4wG85tzUHkGo1EuL0NjSCmsHlZ/iBXTK9lOamwoeiA5St+0uAvX4VGMQfzraUTaVxeNduHxn9ITzIkpMxrwmdPqoUWzt4R8SxzFDk42FRtdCxmSvJko5pjOQxBrISYvacgT4OQXdyQ7fgqkmiQMasA9HEQO48TQ3XQoEwG4MMY2AJ1/c4XIbfN22w6GPnCSdykJdLTKvvgV0wzT4L9ViMfTA85ZBX9Jhpl4SPVm4RV2RdyCeR50eKFfjzhk8I7Ibl3GAzyftG/9WkFIPK9VeodNgNlvJwc7JEV7IlRYlNxgOqhQypFWQ1q2IlEXuEbvvkWiiyuXwFMYwEWQcpap8M7Q2CqALHIxzxDHR46lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(4744005)(5660300002)(33656002)(71200400001)(186003)(66476007)(8936002)(66556008)(52536014)(8676002)(66946007)(64756008)(66446008)(4326008)(86362001)(91956017)(478600001)(316002)(110136005)(6506007)(9686003)(53546011)(54906003)(7696005)(2906002)(76116006)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gS56mlfPzygFKF7aS5gI7yVkw6PJv4fpRmcClodRxaDsM2FEPz+EpkQ/8HjL?=
 =?us-ascii?Q?nwgmugnfY/X1nIherkpC7Y449nRVg/5kYycdBb5Jn2OJ1QIS98OhF58eJkzz?=
 =?us-ascii?Q?K+BSvFyV+haJ2ZKl8pIhSy4PQbQd+TkxnafHX6YRdN1YUQoXEZaiafGXlwNQ?=
 =?us-ascii?Q?QCD/WNj8KWDeElSL1WItNhXEx7xl/iFWdV80okYbMEmshU/6uR1QAwkCUP+g?=
 =?us-ascii?Q?KTb+edkwRWVwncjpHXi6UxlmzHTES/5wx91Yfzh1QitZKV/HHcDX5afxLl/6?=
 =?us-ascii?Q?AtMGpSEfJLFC1GCqbf0ftVDKNKL+g+7ntD3uIA/LcdvyB2LRYJRmCTy3amla?=
 =?us-ascii?Q?2TgLz7YF40UtOh1rP54g69Obl+8K3st5W4LBfMuH1+yObjZWcbusm8aaQGjX?=
 =?us-ascii?Q?VlGrkZcHzWD2kX3a19GTdIakSAWfgDmmdN2/ZZLQcXGgU4b/UgNXjE1UzLsR?=
 =?us-ascii?Q?dcfir/3hsmZy2txR1yJ51aX37RIvSBDKW37m8MtfluVVD2tsc3bepd3LpDHv?=
 =?us-ascii?Q?vLpYCALYi7LvuwnV4lHXAMjPDWswks4ubaVyO3TZTL9oXBmdxbQtpGyummlk?=
 =?us-ascii?Q?EuhiI32AvYdSrQnKcHYrEEP5vL0wuz6Kl/zO+xqazgM8sFSehR6rQWR7Vj4L?=
 =?us-ascii?Q?W4009ED+J4TFXfk0WNZdL/fHmJmw56kYcrQPa8LfIVa4Iz1sqkAc2FT8QeBY?=
 =?us-ascii?Q?yZFiEcIDAQQdkE94dXTvlsOg8w7wronIkakZd3+rrEDae2nU/ayRq8WKrOyO?=
 =?us-ascii?Q?txxSxATAKHwW8dZNc4658QCZamzexdCXw2WH7dalwl+vlZP/uxSyn76Vt/n+?=
 =?us-ascii?Q?lnBd/fjx6gFJUULsrB39Xai+W7Aw2opgcq4A5lwVI7GX63XNVKIoKO/DTbqS?=
 =?us-ascii?Q?VlXhaSwBok7TH4hcSJUFxGAVF5RAmEoztFQ+WtKJyq9Ck1w8Pyuosb3MMJVH?=
 =?us-ascii?Q?fC1KGX2WVMwTPdieqRsfyP3AL00tvdgkyalpSf06wNnSlYc5oZ4PUrQ4un+A?=
 =?us-ascii?Q?1x9hU7uBm5VTuTh56D52ibH23rNRDwPFrRTsPs8Q4kAFOATxMN/XwE4CVOa+?=
 =?us-ascii?Q?y+4RIlOZGZ6/7M9V59GbsTSMSdf9+VoWt33xc5ynW85xWvRQGHl5lyNtoAhd?=
 =?us-ascii?Q?Y4ALIuYlerQ81zK00HszY8Zc0m0s39TcUA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a0b746-ad21-4f5f-c02b-08d8bf49a148
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 02:50:23.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRh4nfrRpD8CpWWSKg2TGj2ssy1JwYtySJaW3llZa1BZlADErdAA/G4Osp7jotozmvcfbbuHBceb/SGbM5Az+gpjFVnwnp2VsJIpiy2m2Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6188
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/21 10:24 PM, Naohiro Aota wrote:=0A=
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>=0A=
> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which=
=0A=
> is intended to be used by file systems that directly add pages to a bio=
=0A=
> instead of using bio_iov_iter_get_pages().=0A=
>=0A=
> Cc: Jens Axboe <axboe@kernel.dk>=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
