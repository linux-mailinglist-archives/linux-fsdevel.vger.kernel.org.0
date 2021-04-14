Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6679835F10E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 11:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347649AbhDNJtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 05:49:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55115 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhDNJtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618393759; x=1649929759;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=n4cEi53oI0/TXYMkqS5gZJL518F78Zn9jV+N046zOCE=;
  b=iNbCxn4LL29Z9Fy77w5GIkNB+cnO3OJnPhHiekTmc7lB3LLNTVj69Y/X
   O6Rhz6ibothrppFQPTB2LqT6vlzw+XRQLRYexODkHsylWtraTS71i2yNZ
   19HdI7hpqaLkeyaoOAzk3IeCsk0qOMuROEG7rH5Gaj9TuDLbJnLqafOy+
   O89Pcv2UHH5FO1ttmpQM7uctMEQIiwvT7E43aeGHybzF+paYMvf94xuPv
   O4MG+UDvcWDSYQBn8odE0TcU6qsMvYChJRC4Wm8UkKaeM+4s2OUL9s5eI
   V+ejcfKcxaKyFNjYvTRxChCKcNF9r1TuNbBcODSLU52S6VSmyhublG4Xt
   A==;
IronPort-SDR: /9LBHWJlSpHKxkWvyqxTmA8FXUjA6KTcBI+sT0ICiZDMRMLvi7jVpO6jIVL5OzmOazk/xEjIsk
 ESsrqM9WUpqHLku3Zy2F9/LFF7l3IVkaUyIhABhCGAMOO+qvMYJPioekgmHyD5F6Y4XfELmmw4
 /KiTNx3gmjRpsiFEH5og71TdDNfo1KWuVaAkHe2YpvIQ3ikqydg6iQYbp46C7NeEISFI/5Zi+h
 Jua5YJD4vV+zDCLS2U+K7fXQEFwEGChfrjZa6MvcV0KeuJMhrbkJ/8KdFdWQVqMCtYA62seaJ/
 A+U=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="275668905"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 17:49:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+a22fmq5hrNN+Ms0ZrRLlOhkC//SQIrG5dpBCRNEFlIfqSya9V703Vz3XmnvsqS/xmEUYhec5ZkRxpxiCLoUmW98EG359PpoXe9QSmVusx0tg/B1Mzb7V1rsexCAuDvHwj/ZCGEdOlviZ78KFr7i/wYidvmAcJsNmq/kAfTl1/Ga6UNd2uR0Q9w/Zs1TnNd2GZ/K58DZbg1+eWyL67pPZqxRYk4++V/fn3waUMmOGBJKhnil+rWxYCZepTWzNHNHlra2iDllyx2FtPKmVtd3sE0+yr2/yK1AL35Wz9iQjuFY57JtPvcjXfyE9omBEqJpy5Hk/tujSq7j3CKlAPaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Vtam+c/kpbde12oPMu5v/1TMGXtizAOmGe2kCRHvs=;
 b=oSIM92XOr/ycHa+CVHDoVWqOSOsbOYJwZRpyrvGfxt3WiclT6SQXCQRR9/YKwVd1IrVAGe8HTFBvKeZ3UGed4qFlFZvr+OTT9GwGup+mn6M4zXpPvzPQfPknGeelcWvQZm/w7YU1Xgu2mp2xxX/6iCBMEpz0IjgRl+Om3A2bPYIkpvmrdP7rW0JQdPOKVZgMVyb2zr2o3gp5JqlzkEMGDI2o6FNni1q0Bw+M47WzYjQ/W8cC6AJEc+olL9+0vfT/tZb20JDhfMRYzx3MHF05mMwl8faDTSRWYHSSz/RSu2tOBNAJcYbVwrAnN2sKSJycEiuOEpFhA1oTOtYBk+nZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Vtam+c/kpbde12oPMu5v/1TMGXtizAOmGe2kCRHvs=;
 b=A0Cd7f98XPjm6S+2Fah6vqV7dT2U5LH8AjxnCgwuIJgBmGkPmQwZCFi2eRaZo0GHK48uOghMjTcTR74M/NJyXXxg6m/YpGczNkggc6G+O+6AzNWCs1/kfgzjHVt3QkLvUjg+Bv/gVN0ZmJocC8Gf3Huolquhh8W45wv07MMZs9U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7190.namprd04.prod.outlook.com (2603:10b6:510:1f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 09:49:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:49:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 2/3] blkid: add magic and probing for zoned btrfs
Thread-Topic: [PATCH v2 2/3] blkid: add magic and probing for zoned btrfs
Thread-Index: AQHXMM432TQSXNk4gk2f4sglYES6FA==
Date:   Wed, 14 Apr 2021 09:49:08 +0000
Message-ID: <PH0PR04MB7416CD7CF75F0EBFCC8488229B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-3-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 997c2468-74eb-4afe-6496-08d8ff2a8ce6
x-ms-traffictypediagnostic: PH0PR04MB7190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB719040A78DE62309CA4848EB9B4E9@PH0PR04MB7190.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7z9k2kSsOyZQTDJNvzIbHjFrPWpukG25msZAZ9OAPVPK6cvNhCzFkDMNkBZS96QfDRnPtfvXkLtkJ2aUViua4RpHmy0i9vZnjnuMKzIZywVjEBKuUV/4z+sD00IkhRx+KSKa7pttRQ1b8o0ujhnDGK5oAthgZFDTV+n0VUsVQGTCC/kNHfcj+WmHoCgouu3M9m6pGUTjQpMTeOeoQg+jogKNC1v5nn/rV1gYMtmJ1L3/rR7bEo0AJvNzJTbj2KGxOF7Hz/L3rise3C1+dqo0OTENObk3Mu4QdzrzBR+Cjz9n6b0VySqEDZCqLvPyl+Xd8NOBQG6SJIvqhbP4a2+Cj7k/gz/FLdXM5XBhdoL3gPOTTwYBwTnVhral5cEMm76mPOFoKMOjXQ5rZbdFPYn4oywxcy7kBH0AQFCj4Vkp/+mf9WGBjD/01Y8G4XlSwQg7+JVRjSgJYVfAVz4nhYKlI1pfI35FfvJi8sRwf4E4Hc4Xb+af105HTTwpzFaLVskQ6WQJQ6X0PblzQWPWYhCZ0pIX1kJ45gTLpxGGupnjo2z8ogk4UxoqORM0DlqYnsjw0lfH6kNcjsiUiDd4sxUDHuNEyypgWvtoWw9IXkfPeb9HdKuNRfhuCW1GeqnecxIVtGECLc6Jjp6FmJ2vG6wRkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(53546011)(4326008)(71200400001)(52536014)(6506007)(2906002)(186003)(478600001)(66446008)(8936002)(55016002)(122000001)(33656002)(9686003)(26005)(38100700002)(8676002)(5660300002)(66476007)(7696005)(316002)(83380400001)(76116006)(86362001)(66556008)(54906003)(110136005)(64756008)(66946007)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s8fp34QaAhzgxXXxo2IpSHCItc0JYisCSTr9B3V8CbFICJk8Rzksny1RefrG?=
 =?us-ascii?Q?C+DtPKC/lTlkx974sNYhRtNo/pnXQBERXA6rELVxg/R+ukbGjycNBFm8irEb?=
 =?us-ascii?Q?TJdh8xSbl7PiV8s4qeomumwXS1PD78h6zbNdRLX9BFUbqqMJkN6bN7/Pvaey?=
 =?us-ascii?Q?mrS3GfK2aVuk5A+l64AdstHWLelzum0KXwT+FB4qD3W7ZRqyl0oo/z7kOwzm?=
 =?us-ascii?Q?HyJIMILFumFR9u1jSU6v6PK+UAy+wov6FCqS0b4Dn9JNxqFinURZc/PguosC?=
 =?us-ascii?Q?n6eOGD/IdRWhVT23EA/zY+hSJKJCG9ciLppUAmangZ5zl8Szj5c++YHofw5O?=
 =?us-ascii?Q?mz2fbVROdkUBLztzE7ToIvTqpj2CvPEyFimsm78g5UwtO2/n+59VdsbJYEV3?=
 =?us-ascii?Q?IA90RuV1E8AN1LSehxUyZeVqbIx46UPIS1aGUrGSWUbmpD6XsCl9BRtdfPH6?=
 =?us-ascii?Q?hnAjGcJb4BML2jgPUNjbDnw8FAxoBixCs13M1+gw79NUcDo3JzGiDUzPJjve?=
 =?us-ascii?Q?0F8//td6ttTVyfIbF6vJN6AAuQTAWk8f4Yjhl9vnTD+GQcN+vDIw42C08lKK?=
 =?us-ascii?Q?WXb0MJCPBFI5iv8YuoGXbTVjbvM3PMgLFAbpP+e5QCcZ8uU6ra2NVBkrL0TJ?=
 =?us-ascii?Q?NSsyBQTDxaQQ90xyF5Fl2txUKOw0Qi6xPF4AEtzzyeMW7aMGHC+3ciijKRdn?=
 =?us-ascii?Q?Kx8MS2O6lY3JWSeOCcKXihKp9Oe6qAjbrXyknwmSk4/VmAK2tY7WGTw+zoaL?=
 =?us-ascii?Q?X7TV0JLQc7tidzPV6vF7zBiU+/H5f8/+yNOw5sp2t18W9hS9FI++K/S1AIKL?=
 =?us-ascii?Q?033rwab527tuZoAWAJ7o3SFP3n1DJl6FI2I1UvHPsgMsVrw6dAbzGxdqkPSc?=
 =?us-ascii?Q?KS0aEe/oyDsWeSXTMccf8gO/jS5YV+3sH/ODfbn9zv+nhea4mjhBFj0U/njZ?=
 =?us-ascii?Q?v5747L9qOWUQ6GQvOBfSrSyQ6h4n9P7g5mNbhbv2SY2v6GR10tBHcQjCzod5?=
 =?us-ascii?Q?4yYzwhwClwxvHyoI3W8JIHYfHzzMceiiTVYWx4jpt2tddjiuHl5PEHZRG8kt?=
 =?us-ascii?Q?dE86cM2CdhCAmO4Tprhi+ah5Y/QXVZVb+uqFPWrLy4nxsyuR5aTdJlo/jlj8?=
 =?us-ascii?Q?+cmL8RsGrWNlEZP/5SEps4qRUw8np9qj56QuLTfnhhLs4Oum3lVKtz9lng3g?=
 =?us-ascii?Q?1WSFwA1JdLuCEQbT4gnJaKp7zxRhRAuwgzHT8r0wzQHEPtcaBvGp8HiUE2rC?=
 =?us-ascii?Q?sZF/G8Z31OTqmOtnSaMjaHnfPR0haXib2eHE1xf89pUYR94LM3wR0SIla7hm?=
 =?us-ascii?Q?7FBvsQ4aztpmdpsZ0NxkxYwR3u6vOFt50nZ3QDNbX64fGg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997c2468-74eb-4afe-6496-08d8ff2a8ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:49:08.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tAM9iQVeydCcYzdHBj0z8GbabpKkw52s+SQ0y9BaMRpoIs5rJAdtXqLTor/PrwP8QYxeozgEbVdU/lmlSV3miJtmCPvRIBnHQeN+7uDK70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7190
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/04/2021 03:33, Naohiro Aota wrote:=0A=
> This commit adds zone-aware magics and probing functions for zoned btrfs.=
=0A=
> =0A=
> Superblock (and its copies) is the only data structure in btrfs with a=0A=
=0A=
The superblock?=0A=
=0A=
> fixed location on a device. Since we cannot overwrite in a sequential wri=
te=0A=
=0A=
cannot do overwrites=0A=
=0A=
> required zone, we cannot place superblock in the zone.=0A=
=0A=
the superblock=0A=
=0A=
> =0A=
> Thus, zoned btrfs use superblock log writing to update superblock on=0A=
=0A=
Thus, zoned btrfs uses superblock log writing to update superblocks on=0A=
=0A=
> sequential write required zones. It uses two zones as a circular buffer t=
o=0A=
> write updated superblocks. Once the first zone is filled up, start writin=
g=0A=
> into the second buffer. When both zones are filled up and before start=0A=
=0A=
starting to write=0A=
=0A=
> writing to the first zone again, it reset the first zone.=0A=
> =0A=
> We can determine the position of the latest superblock by reading write=
=0A=
=0A=
reading the write pointer=0A=
=0A=
> pointer information from a device. One corner case is when both zones are=
=0A=
> full. For this situation, we read out the last superblock of each zone an=
d=0A=
> compare them to determine which zone is older.=0A=
> =0A=
> The magics can detect a superblock magic ("_BHRfs_M") at the beginning of=
=0A=
> zone #0 or zone #1 to see if it is zoned btrfs. When both zones are fille=
d=0A=
> up, zoned btrfs reset the first zone to write a new superblock. If btrfs=
=0A=
=0A=
=0A=
resets=0A=
=0A=
> crash at the moment, we do not see a superblock at zone #0. Thus, we need=
=0A=
=0A=
crashes=0A=
=0A=
> to check not only zone #0 but also zone #1.=0A=
> =0A=
> It also supports temporary magic ("!BHRfS_M") in zone #0. The mkfs.btrfs=
=0A=
=0A=
the temporary magic [...]. Mkfs.btrfs=0A=
=0A=
[...]=0A=
=0A=
> +	 * Log position:=0A=
> +	 *   *: Special case, no superblock is written=0A=
> +	 *   0: Use write pointer of zones[0]=0A=
> +	 *   1: Use write pointer of zones[1]=0A=
> +	 *   C: Compare super blcoks from zones[0] and zones[1], use the latest=
=0A=
                        blocks ~^=0A=
=0A=
[...]=0A=
=0A=
> +	rep_size =3D sizeof(struct blk_zone_report) + sizeof(struct blk_zone) *=
 2;=0A=
> +	rep =3D malloc(rep_size);=0A=
> +	if (!rep)=0A=
> +		return -errno;=0A=
> +=0A=
> +	memset(rep, 0, rep_size);=0A=
=0A=
I think Damien already pointed this out, but that's a good opportunity for =
calloc().=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
