Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565EF2F299C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 09:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbhALIBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 03:01:38 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5230 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbhALIBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610438496; x=1641974496;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eTQPXAGuWyqklN+TxkgKO23Jy1/xLrJysE+o7+z5GUI=;
  b=niKkt4KjR48W+kmvJPd4US9WaQ8VVq7k3PrMAIBJCZzfkK5zyYei1A2l
   Re/rbQLCkDMLUBQvzVwOOyWCOzHDEhW2wV1lIZSwIcEK4zFGUIYhkRudI
   5WhlIQhd816fFdZV2Av5Ib6zkb/EYEJ+MhffOSXQQpXF6BsIkUSMg+VAK
   KJJQuBG0bqGApACbmrqsMwO5et4j8jHE1HzZJECRg+sJ2TejjsTKh22Kv
   dWR3UZEb2hlHg+SrpEImD6PECycbeVCAVgpNkPhLa6tR+g8sslJh4sIqz
   bjXkuIv53ZEn5nWACu/Li0YL4PMUTm5gCxikZ9RHeJXlC0yY/Y27ATljX
   Q==;
IronPort-SDR: yFx0wOqXU5ppFzOBPZiHXLEfgo5TCRI4uLumXUxlCW/yJ9fKEJiJhnpUgPN/1Ov5WR6QVDNYOi
 FVfebwAI718T8djKjBlnl9lDd0O7KCMZNSmN91D8c6QFw6KAxGWjMEGBDNWfVFX/fRIDdjx29i
 hA2C2zDGffepNncLu9Tb8yHS8Haa+wjIOvpZiG8+EyY6s2U74nu+8dVyNZ4ow4C7gFo1TrKkgu
 dsVEWMQGoMW1mq3KGJJzJwtixV3YmRguCStKPa/BVEkOAgn7vS8hbRXWkUb1iAFYhxiZ9QfXZN
 jF0=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="157222553"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 16:00:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUAZv05aVPBSc5d+RfdKpIHNMKib3pDAWVm5McRHi9swpfk7G/Suyo5dF2xmGsRnMqQJCEPes/WzVjL3AxZ2N3qwJ3pHDTVQyLAGmFJZbzbr43TAwbKXWy4LU5hBTvjSXUVDQIe1Tfc791Ex6q3IktG1Nrx3suFpzeq72wX28I3ysd09RAkIIL7AeGiMsD96A8577p+fWWbbmorvkMdJNBFGCeOStd39z5YIDE+RCGH0SgXcgIWnJ4jmHtpFgKCliOSByZY/ir5cr1beEPdB8GVWHA6bDY4LyjUz9WkNdditFg2E/vYvg0i6wN7a+JV7DTqR8z/6TM0QeDD36JmAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otayXSJYip5yGy9kwwQP7AHlzT4FiDlgdriaOPsq8VI=;
 b=CnKW3GkpAL08b3tBa5HPI89v3xoqdewt1CEtcSNQtw822BLSnPfqFzQpGqZumpFEsWN/H1AYvW2tunyirrovTHjB6GG1N8xJAl+YliahWEhVIXx8zdWBjPV017kP3S4YEkC5BKbywaKM4NZSvm2OuksFbGCRFteU0mB0qnhd3zwuGMCD+GpVlq8EwVPl1B9qRmtlq2NFJHdDbrnYEXjrO0Fo/ACuzprG9i9SLv5mEgAxa8midYvtQqKenoh0bbNEArqld3gUJvAmUFIrg/LIISfy/JPFhrfvBcxxnmLAWsEI6BmsFRrzAnHHi2+JuKnvfuplDNGYskpwUjznwshxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otayXSJYip5yGy9kwwQP7AHlzT4FiDlgdriaOPsq8VI=;
 b=Wzw54DE7b57IYA0NKptBwhDgKOx3EHOgA0d4fUQU6Io+peoR1cn9W1Mef0itePOfuxeLAR2TZi3QMGL7ZyEPnuPLFNqMQTK8PY2jm9ITgcFylPwxINP6Qreos61tLL8ht4jnnKZO87+MKWkci9dwjT+UJDNE6Ylf6BgagUm96V0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5005.namprd04.prod.outlook.com
 (2603:10b6:805:92::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 08:00:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 08:00:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 06/40] btrfs: do not load fs_info->zoned from incompat
 flag
Thread-Topic: [PATCH v11 06/40] btrfs: do not load fs_info->zoned from
 incompat flag
Thread-Index: AQHW2BWbQR6+38xOa0ScNv4LDkuxTQ==
Date:   Tue, 12 Jan 2021 08:00:28 +0000
Message-ID: <SN4PR0401MB3598A3273BF314B7A7B9D7BC9BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <fb24b16fb695d521254f92d70241246f859ffa36.1608608848.git.naohiro.aota@wdc.com>
 <21c01c81-22fd-437f-4e41-ce4563d71dc9@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:480d:3d08:9ab6:e110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e180ab4f-9e8f-488f-7e0b-08d8b6d020b1
x-ms-traffictypediagnostic: SN6PR04MB5005:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5005CEB86A62DAA1154FC4F59BAA0@SN6PR04MB5005.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VwMdfuI+iAG3bjpVu357VldZ7TC4pu37Psh94G7Z8Eo94/QROvf1sNmNAyDghMI2Z6/M4T0YX/4WWPuHUl6uiOsLkVZTiO2ve/zyExb0Pmc0+LM7KdXxAip1zOM5F+yW8ZokCesVsFISxN/ClK0tancbF+fWcIt+ZIbEcXNHNl10YmjGNPqDIuJ07wP8QPhieIJPCGF2rCzCLkuOgKZWUcwQxyONrtIkV2FFVBZugpkzWWWn/b0vLSB4rLMCQDbURYzorD3bX5C3sqdCjBH0T7ObmwRsYFWea3zTmJKqOqUDIbN/DQBSyIzU9DG2sP9LmVjpwYIGUljRi3nH3lr7nb+f4CooXUVMXRHjkZYAPvF+dwQlYGPymZCLhFNBeyBN0hI+II1us4Jb9mv90ficow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(66446008)(52536014)(64756008)(7696005)(5660300002)(76116006)(66476007)(186003)(86362001)(66556008)(4326008)(66946007)(478600001)(316002)(91956017)(71200400001)(33656002)(558084003)(8676002)(54906003)(2906002)(53546011)(9686003)(8936002)(6506007)(55016002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zx+86QUBZ/RCs4Qgi5qTK5ACsab4abLuYZcOUKIwYDPe11m/qewFhFQhRY3J?=
 =?us-ascii?Q?FKMcC7zLQsPybs40604/OGlK8C/vYVEoNPcPYTlyz+uzZ748KPbh0u6HPXhd?=
 =?us-ascii?Q?OAE9GX4QqbwQm/sgHRnxKnSYVH2wywlPo+H2sLbXpE4OJsX7FTNvIf7Jm/AJ?=
 =?us-ascii?Q?lSVfVERXoDoZpGon/Hp94YmlhJTAMPnNrIVSO7+S3DyUJJjQNg6hf1kP12Mv?=
 =?us-ascii?Q?O07sMXPBtsZQCeljCLkjR9I+E+xtwX5ZJo66Ut+I5kTeZRxav02mCSnmRUqz?=
 =?us-ascii?Q?aXk53zK8miVILvb7BCX6XvDwGktnsY8i3KesdxsQ+jON5CZdoTdEnYag0WS2?=
 =?us-ascii?Q?syXNY1GF/F2V5GmLdMRtQcspW+t+HwKIJoxLnjejfNkrd6GkfyChitnVwz/s?=
 =?us-ascii?Q?rJplBL5NXlpfzml601ezc+ezIxol8MsBOzhdZLAHBiPxndUGahpBX8koAc1Y?=
 =?us-ascii?Q?Z1jxcnV//EJI64XcWQRXh+nh6/sipAmbz9RW5VhzI55aTzGWug5Tx2a4tycz?=
 =?us-ascii?Q?w9gsgBOmk1ykLm8PZaxJTxbPT1gSSh6JySWMmB4qJ4Bt/7lqoJjIsm6TbjK0?=
 =?us-ascii?Q?PyGhexbPws+DRDjPujcNdGOv60ifFix7cZbGpNa1GTqh7jR9HVTYw6EfHeNK?=
 =?us-ascii?Q?j6YkzUS/U7MRjReB/LAny5MJAjlg/X3zG4Emk4U15FJl5MZrppoNW4pdP5z8?=
 =?us-ascii?Q?vJbGTRF+llu91uz4q0GghTzKfkrTnjUV/mcVRlSc1gpIRpL+SMqfX1DDD3yZ?=
 =?us-ascii?Q?xzDRDZ1JCeRPWuRTf32PojVCn8IuLmoZnKphGWo+YjUD/HqmCZRE9NhKYDSA?=
 =?us-ascii?Q?oRU741OzY8kD31vVZb9m9zDdPn22mUGDkBAzacGL/lslj/zZS+eP5RVr2rOm?=
 =?us-ascii?Q?tN501SLXAimMh2TnMIAnPikkXwPpuMsgPNeAS8omCkxjH8lojYYU6aM6Lkw4?=
 =?us-ascii?Q?ct/czL/W3cEd7Ja/icGMkJfT2utESSbRhpWcE492hTNqHg0XeZZ0nD6aY4UQ?=
 =?us-ascii?Q?pHA4tRmAYPPPy4kB8hzlTysqu/9AR6yYoUpSACh26oZYO1O4Hmi8mnoqE3jM?=
 =?us-ascii?Q?QzrM4Ilz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e180ab4f-9e8f-488f-7e0b-08d8b6d020b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 08:00:28.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqOR12HGaYkif35jgp5+tf75XxuKEZa6njGbgcix5P7EHj665iZ4TW3P1QM+x+DwDj2AwG1179svqdz3Mz4yRq7TmIk6HBj4IhSjs17NJrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5005
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/01/2021 21:08, Josef Bacik wrote:=0A=
> May want to take another crack at that changelog, the grammar is way off.=
  The =0A=
> code is fine tho=0A=
=0A=
*doh* sure will do=0A=
