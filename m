Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575393049C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbhAZFYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:24:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44761 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbhAYMKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611576620; x=1643112620;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mYMNmprffRgxsDccq/D5fwm2tgBq3vo6DBP/RVbEnjE=;
  b=StEALu0/E/Ub+JPHePQJbJ86LfFZDyAJs8ps5xoUd/QJYh6yuyzQC1hj
   9C5k0UAceM4Rzp71r3Nn0Sq8LgtelW662fy+pT7tmD/NNPWqe006AsNhf
   9Bfio3y2b5p7VWoSM8+YMRMyC0+8xkSZrG0a7NV3HdtVNSharSN2G6ZaN
   3qKqHOIaGhNJFSKmJ7fyESBvVXDsCmvmTQhh32aPusS3eT1u84ap3l3sN
   BUCSTwk/NJO5g2kJueH9QGPEisjy4jVwht6eA0COZRIs0I8nsM3h065oD
   8nEyvqHa26i/aK7ERRFOZqgHaA3z7DQCDnPyMWAC8Uek6cyYgDyIwu5lo
   Q==;
IronPort-SDR: k8rNAjUH2x1ZZfUGcpwSM5o7f+tCsoVfcjuUjVvekbjzcehrMKNA/Ys4m4UaTakOEznfMJ4em+
 bcHPvNb+xUVImaOP4Velh28ITIWGyep8myC9cuU2lyWFR8PqcDArrAMuPrNAxYuCXAqiwv+stu
 SsbCa8z5G5iyJhAylETmpggI7pHX9RK0Gk57YKbADSPv7aWJ6cpMg6eo96efy4X25S6vlTbXMN
 VfJLbGgx7QKtVsXT9eAC7Roj7lOp9PhEVrLF2NEftLzYSIinT4llbWe+B2tlWhO+9pqJoez+OZ
 psc=
X-IronPort-AV: E=Sophos;i="5.79,373,1602518400"; 
   d="scan'208";a="268610985"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2021 20:08:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKhEZcmVmeYeVNDDVgm9fTgzeB5dCpjmRCYZZxp3qNfJ6FizL25xrn4eQi4uOVBQPHWjcqbrEKSX+arBWd3+xwM1fMc4Gy93ZQOh+9Jm5XfIV4JzDIMScSVUyDPbBr6r10PLaBO1UQQwd45M+yerdqfasPFYdo6o2P3NfI1HuOAwaOU46rdBT4/r2hbNNtA0+i1vDs779GUvbXJQtKoxb/E22OkSQKXRYCgwLxfUu8ZHgifmjd8m5O+dUJrPT9Ov0mRv2E8HANzYOn2wL75/LE7ZO6SVVmI1YtDKqSZ8R1bp6qwWx2g/zYLtfZgyLdutE9WQB7B064dd2BwO/K5pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwzktgcK6Azz0y1eOX/ExI0uMqFQMnjv5RYc9e0BaOs=;
 b=aIENCXIsEEYMqdLpdiEoCLsjKOaH/b4vXZMOdQWbhFVxWthBtjvgT4nXGM3gdId8eoq/7vkZmodQGM0Z6pO8b7a2d0qsUlXuZeR2fCz2FirzxWrTgQy1Q5G8ZenYQd9/8cOYQtd3n6Gap63MkKeOcIQumuAIaakzva22/2WllrRSNu3xHd6fdpbJrcDFXIejbXlZvef1KZqj5KtUqojEmjdCl8r2Tw1khHLgmrLhZLffepbWDyexhvxVzBMipEOCDoLADlx2V5CBViyEH/ggcyMeJpOrpO5N1SVXlLvdL58NyZITFnYDQ0PcwsK3HMWr0y1qFoMK/3QiRO1ffTKodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwzktgcK6Azz0y1eOX/ExI0uMqFQMnjv5RYc9e0BaOs=;
 b=Lc/lz/CWXRXZTt/b3lsZseyy1PWkj8osqezZNBwe8fBE8w21ieAiep+EPoem9zv8/rSfu5Vmx9xfhQ1TMnLaS/t35i4GAkk3TGJixcMCb9MkLFxH0VLZjAx7wSUm3acziGZCIAM5BnlTasrYBTb5x/o9/k0XNgawYkf7cK8dzf4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4781.namprd04.prod.outlook.com
 (2603:10b6:805:b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 12:08:03 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 12:08:03 +0000
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
Subject: Re: [PATCH v13 13/42] btrfs: track unusable bytes for zones
Thread-Topic: [PATCH v13 13/42] btrfs: track unusable bytes for zones
Thread-Index: AQHW8IkI4np8096mREKqp6/IhMqn7A==
Date:   Mon, 25 Jan 2021 12:08:03 +0000
Message-ID: <SN4PR0401MB359837624196B22907D655A59BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <b949ad399801a5c5c5a07cafcb259b6151e66e48.1611295439.git.naohiro.aota@wdc.com>
 <7f676b7d-ab80-5dc1-6fbf-ed29e4bf4512@toxicpanda.com>
 <SN4PR0401MB3598871C917A824777BBA6649BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b589e811-636b-4259-3729-08d8c129de12
x-ms-traffictypediagnostic: SN6PR04MB4781:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4781335EFA734F74F50223159BBD9@SN6PR04MB4781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDOJjtUlvpllE/kBpe+Q9Xf6WHuXNIVKJkhufQdaFB+GwennMG2GMeSM3yOLeSdprwzy7YKZ0Zr9MIAKFRs/KF4BPZaDhyXauNPI9aCsNTXFBd+K+xxKsHP+Nccsf1O4rimodk1UPVxChWsZAH29z32qIjdvwfZxjZ2nzfh+OIIeTcZcFn4s7u2r84SS1vMSFDcHF3WQGAMk7ODe/5ey1ecnqU+NQieyEdbM/BACUcS+1DpUy/m1dLnyo7FaFoDI+LBsbSF4ppyJn1wnSkdbszxI1QwWRYlb6Z1lot5PFdhbhMCsLA7Sptw8rWoB2m6Ep8k6MoHNeg9Xqmia++KrwX8Epj60CC9aZpyqJv+gNPritdANiGlpW/JVlwvXFBdHKuugTgu+DnScTDhtSv6yzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(64756008)(52536014)(66946007)(9686003)(55016002)(66476007)(86362001)(186003)(478600001)(91956017)(76116006)(66556008)(110136005)(5660300002)(54906003)(7696005)(66446008)(316002)(8936002)(33656002)(71200400001)(2906002)(4744005)(26005)(8676002)(6506007)(53546011)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gn7/Hrm8DNQXjZv6SfCA1n9uAswXTjqZlpwwYS4FIahyFVvJ8RNReYH2PnLJ?=
 =?us-ascii?Q?gyvIdnlW9ThEkOCc35U3UAqpz2WKBr5RIAyBRNnxaJaRy8fHPjcNtuiwyUzc?=
 =?us-ascii?Q?GcBaOZ82rbAH8t3mF7uHIgrOdE1QqatAN4uaSibd5VrdAwFGEpVNXr3artlD?=
 =?us-ascii?Q?fbX597d9vM6eBFiaMbBHEr/q/CZuS3edFvZXZyqMHC0LfQtvBOVyI29lHfQT?=
 =?us-ascii?Q?bM8vMcvbWXuT4opVS9F+lRy1rpzEUCKlBXa+h/lin2+O3NLSiWRXAme8GebP?=
 =?us-ascii?Q?wkqD6D7w5QaypC30GZTGUIA6pWeqagwe6TPHhUMEAP2bJfPBSE/g4K+PL+K1?=
 =?us-ascii?Q?8RoH/FztAJsySZ9F6+w0baAEt/JJJuxOoG8XaWbRh5GR+hwtD0DBy4nR8RTa?=
 =?us-ascii?Q?PF2YlYQDXtmIdf+nlK0k8ncNNx9ET+SjVk5q/6T6iBuh4JqRaLpNPIeyUmXi?=
 =?us-ascii?Q?Op2C3FUI2mopEp3+eY5+LnE2U7QGoMR7uvNGJcXGZ7cfmseHIZSh3iXMjWmc?=
 =?us-ascii?Q?nBBCiTAGKKZNOS734dKVNH0qLRuHqN5IPeVE7RvOCSar+QxQrCdaL8PQi+SO?=
 =?us-ascii?Q?eBiEYbSmHWOsGQATVy9iudi+e5ikU2BZGTbpxgqokHWtvL9CYtZabp9zEU0A?=
 =?us-ascii?Q?2GbWkMTlU9O8gk5MrJpMSa8mAIqi0pJV6evGrBrxNVAW5I27iW5HAjH3/n4v?=
 =?us-ascii?Q?mZg8sXFVOWAHM39SAy5Yjrly4NAyU0YsXVOqqjiwo0C5veXCeCGr3FS0dvSr?=
 =?us-ascii?Q?uk3G1Uj3E4thgSEBbDlB9z71LHerP1baJiJY6a8zL0tdaIpmUC3KVWCPAuid?=
 =?us-ascii?Q?UCKzZU/Imcwpp47OA125vpFc+rjItUqzrZSBznVtrxEOUZL13tt1ZcwD/KUb?=
 =?us-ascii?Q?FRRJjgzxPC9y/x35bFr/QagJNj8APmh1IvcvnPZVjyKMGp6abDeOhKAfGF9W?=
 =?us-ascii?Q?A/6tUkwY9+GtrQP/HOUpYyq1WVqgrGme6GgQJbi9yJQkoTg3GArUuZu80LdF?=
 =?us-ascii?Q?pw2pZDq/x/S0RPpkp7VNWvmsuOxidf8q8Yfs5vCh6HqmvmbKrtsl8Za/QrP/?=
 =?us-ascii?Q?Ls6IbARQ6pZk1wWOJo4qT6Hn0IepDA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b589e811-636b-4259-3729-08d8c129de12
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 12:08:03.5671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoEgueStxW+ctZhddzp6ptCpt3iRJ1HUG22KG0oxRBPrGsWfDZisey0GO/l4HaKmRw93XqZDCzQv7NJCcGYHbgJ3B25P+h7T1OmptaStk14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4781
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/01/2021 11:37, Johannes Thumshirn wrote:=0A=
>>> +	if (btrfs_is_zoned(fs_info))=0A=
>>> +		return NULL;=0A=
>>> +=0A=
>> This is unrelated to the rest of the changes, seems like something that =
was just =0A=
>> missed?  Should probably be in its own patch.=0A=
> Hmm probably belongs to another patch, just need to find to which.=0A=
> =0A=
=0A=
OK fetch_cluster_info() is only called by prepare_allocation_clustered(),=
=0A=
which as the name implies is only called for clustered and not for zoned =
=0A=
allocations. So let's get rid of the hunk entirely.=0A=
=0A=
=0A=
