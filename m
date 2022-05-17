Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B395299EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiEQGxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiEQGxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 02:53:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F91A65BA;
        Mon, 16 May 2022 23:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652770423; x=1684306423;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oxPv5N0G6Xhg0ubu1+t3qO4u4+QrZ6+dnf+QjjZAPBY=;
  b=EdTwTyLDdK1HXoaN3FuGkau5PHspQd1ExuIsKyea5WE+qE0P3fhOBjNX
   R50we8VyB9Pv/8wHnRVzYpQbuiGJb2BIz8snRaUpqXLLwQ02vYMpClsvV
   v6W7ThpwRLWTSQpj2ojUbHRfafMGa4KiLmanWL7sBxYWKQE/tLuXWccdH
   wsnwd4asbo6quMIC0fTqxu9dQoS4TbD3ZON0uCAFFWRlpb552cP0gOKSe
   9ZM7Om0YyF5nmwpwOgibrAALeYDHCEz+7I7CUzMZ9Q8jAyedEgMvPhgdV
   YbFutyODUr9typrZ5gog8dK9bfHr8EIhpI0dEScTxLD/WvUdAqHGpUvHU
   g==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="312507637"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 14:53:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOu7wIt2FX7mtc5DKYn9ddilG61UVvTjqLN1FD7cMZVGtnVi23Jpty7i6RoMXjb/DK5KTCVIRnGKYh5r+59a5OGZTiYOdnBKCybVkQyRxxzJb8aQHoIJzK7ndMu/YlYGHFzmqhKLXfHZL/CICltgNPh/VlhveZibgpFIUlAbUhNuhxJCD7IzKXAV7oROq2YjLzCyJFz6z2rRpkVKF1D8TZAdMDIAqXWOtbz8vD4C+h4FtzgN7+XaqzjpW7dZ0CaOY1BVybTgntoKPqEnaRpuQKa63mbsdYO1dYzL99hfWVAYuUyRJkrVkuKfEb8EOAc/96SBv+4XGwXGAcG2j9Y0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGKC8DLDIXK6Ux/sykPCFqrsl+Wf0pjneqPaOudJyEw=;
 b=C2r5BtZKt+Qg8YLIJm7/6ETv+sIbrotZdj2GUvNTfQ+9fFyYIEF2QTdCTf6bycdR8MZjePqtLgjyXwiR3Ud1ItkvagpmvnxY/nR0GjtTgB0tp1E+k7F29VU2mVkGUcCrB00fIUybLdDXZcyp3+F8QKu6t3ZXgA2PoopDAh913geW7Va+wGf56XQDa/f9BzCZEzFakk8EYPuAYT7a+F5s7HCkHRvniEARTQlMAitJRa4y7o0xuMk9ujDnfgTozEraS7uWXWDRA1BOR9QGnZCv7cLDcC0AQmTYYo0OkLojg2JUkAaZnOuN6T4qIzxrIMKj1hBsaO8zp+oPJYMdIHu21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGKC8DLDIXK6Ux/sykPCFqrsl+Wf0pjneqPaOudJyEw=;
 b=fFDsQMSIGeSn7VXsIWBL/4br/utF+LC3ahBmBbmvyu8qf7w14SdJ7dHIhTWT/e75NdaCZ9z8mpRjdNNAFK/jIXwOmgB1QMyE7KWdjNup1m7mISQQer422d9AzjmcqOUZa/8AXTYVI4n7Pu5vi4d7kkuVDJfFZn3VGDSXHES7u7Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5337.namprd04.prod.outlook.com (2603:10b6:5:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 06:53:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 06:53:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 06/13] btrfs: zoned: Make sb_zone_number function non
 power of 2 compatible
Thread-Topic: [PATCH v4 06/13] btrfs: zoned: Make sb_zone_number function non
 power of 2 compatible
Thread-Index: AQHYaUWnfgxv+u/BDkiy20kzzzkazg==
Date:   Tue, 17 May 2022 06:53:40 +0000
Message-ID: <PH0PR04MB741673F9764EFCA93F1932809BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165427eucas1p1cfd87ca44ec314ea1d2ddc8ece7259f9@eucas1p1.samsung.com>
 <20220516165416.171196-7-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 883b5050-2326-41ad-b1de-08da37d1f9f0
x-ms-traffictypediagnostic: DM6PR04MB5337:EE_
x-microsoft-antispam-prvs: <DM6PR04MB5337CFDE45BDDDA2230668489BCE9@DM6PR04MB5337.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDpNr5HzpLRyrCme5FwTGIGoQbbjLN8Wk0xZDmtOvyI5p7TDOrvvurK4XBfPU7HuLh6YcUYY6ODAwfzpVC8sE6RPu1Pb677LP74m/vUXIIeedh0E5kS0x+pGRNC3GdgmN1Ay5gwtGLczBkeFZlc5OLg+9C4vqnfzw2VP2iTrGxMmFnXfEborE/QUpRZUd0a8V6PveAUSHhYKm6L9wYglkbKKHWICuFT1C6Qrc7cLTtyEQ1x5/O27Y0ws6QKJxS07CzlZDLedfpZ5FJ1edN7FbSOo+XZKUfipUdaiDk2RTMipfvUVAyBOVvNIVgHJf6zFyXzZhdE08f0+6+pA6stqlDGvJHyaFiEd7T74bCgYyLZjHlEwSIFVoAvsylSGduCf1hM9EKGHoVd473jsnZLL6drwe5OEzjrugqt+hxIQdfvS604bllKlDnnzyzM1QkpltE4IMLvW8rm9fSZGCrBPJ++OsyDrjn9Bqdie8fv8gqc6f9BGooJY2viMITMmahWpiJmwKg2drOYTt3PF34WG9FceFKU3/QtVqKQ2CNcEgrUZjsW5BU4gtdh8lcyBlGnGKpZfopn4zgu5GZrDMlwxH6x07C3oq0spCOfpZt4oir/1vleGC0QxG6JO1AhHUZmK31WkvfOZe5i9YJvvoLv9s4/N4TMcr5uV9bznPeshUxVX9JP2BD29/pikrI0v88lehBH05a0COXfsHKOedBKSvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(186003)(38070700005)(38100700002)(82960400001)(53546011)(66476007)(5660300002)(33656002)(4326008)(7416002)(55016003)(2906002)(52536014)(4744005)(8936002)(110136005)(66446008)(86362001)(54906003)(71200400001)(7696005)(91956017)(8676002)(6506007)(9686003)(66946007)(76116006)(64756008)(66556008)(316002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ot6Frx+D7LF9ROH4NIBfvSsW/jPWplk9rG4i3xC9nNksOr2f9C8ui3kCacG?=
 =?us-ascii?Q?evHhnxPim+8449MFXNdNZMdjL3YzSCY7majK2FqWwW3FcaEMDAPzIBnotwdY?=
 =?us-ascii?Q?/+ppZ0E5lJqsBexNBfXJGUYfFX1AUp0UwcXF4PGrdmUY4wAc5VotuGf1g151?=
 =?us-ascii?Q?IZf01U6L9H3lth4FFM6qvIwye2juf0vuLnmdt0QzPHqTxMdNiCsAmsbPAxmC?=
 =?us-ascii?Q?z761X5r5mWjnMvlO4tdZGN++6b+JdQy7v+z/Ti/9hII+027UUmc1LBa5MsE1?=
 =?us-ascii?Q?nej4BpWe76kv8qIFI8/CjKuypSQG3Wucpkf1e1gQ7D/bXH8YR3QAptJrqkCU?=
 =?us-ascii?Q?Xk5Cuq1Ab3V06ATJ0zo8GZMHAqyB7KlOIDIi+DO0nM6mqSKKNpytW2TJFag4?=
 =?us-ascii?Q?anxD1KVY2tbYAblHAc8NE3QECm5LrfNr/0bW0afQ/BMhSyj/ryJzY9ZuKgEa?=
 =?us-ascii?Q?9i6lv00oMfJEr5n1VoXXjxNLTfsS461BgAM11x3cwvHK4e5ivNewioc6gQV7?=
 =?us-ascii?Q?dBlejXapDpkqvMxgH9aWHCuJMkOgZFpS73IKxv+2hbhyTZQR0Ajed1vSIEj4?=
 =?us-ascii?Q?EPfH8U0r9Poql61LxZzkr28SqkxqYczt9NsXJTAWBoyeseNa974TaN3GmyNV?=
 =?us-ascii?Q?O/Ca1ez2Tz5vo5abuhQJZcWOxFos8silW7KHduT9hvt0hl0lWgSEovsqeVC2?=
 =?us-ascii?Q?Yr0bLV3B0tXKs+08m5RXBXtle5lYB6or6fPyLlF8tb56hKqUqdEmgyx9rnwk?=
 =?us-ascii?Q?r9ObM6kKlf837oMQzeD717hBLTgm6xUbkTQHM9R0xUdoklzVSlL2X6gltzKf?=
 =?us-ascii?Q?0nF7vB6MFmK8ABj+0c2VCHzYLylRqTZ1/gde4fkbVdHGHrFBUzrZrCQI0daU?=
 =?us-ascii?Q?BfwFn9U3kn7O+NsUNaH7zjdqMb7Uj6bgVFNNmbEw9yKvcfCoJW0DqYbF1uM9?=
 =?us-ascii?Q?hdrRzyAI2QgPX8i3Ly0EghOxJOAARR0cBgMSXkNPbD+8bX/T99zBTQSMkpuL?=
 =?us-ascii?Q?X69pZFidRKsGBh17dnDIBwf2hjqcJNRu0iwRUv7d5mCIj5yXZrOwJwFJkDdv?=
 =?us-ascii?Q?dxG9rCaPhPh78acHe35ehruqpYi16zmmOiC96p0BmayXxOD49dV/k0sSnh/s?=
 =?us-ascii?Q?I0DAKp8d7nUgiGA/ajS5h474xolrtSkXb//iU8o8V00gvamQgKGOMit+QkCe?=
 =?us-ascii?Q?MScP92fd1x9DUFPr3Xfl5QGHvNUp64hpW27j7jF3T6c+TIGESq621Q3M1jhs?=
 =?us-ascii?Q?0PBmZIHzkVYC41AlKQuUbA39B0uSVFELB5SM475+4dEahsNL74mk2+iCyGZe?=
 =?us-ascii?Q?IrCdS33xav/Z7R8ID2Y5Vaeqia4TejKmAgVXb0wqFcS73gBGT3wKCsnSgLTY?=
 =?us-ascii?Q?oNLww4ryvlESMHzhFwdBAQC5ohassbd5VuWRssDGJVY7zyZdlpSyhlG03Eaz?=
 =?us-ascii?Q?+GNm6v4B5FnN3jY5FpIIF41J0xrMDYZPF3mlPkXZTFqSmxtMbtHVZKFgmNJD?=
 =?us-ascii?Q?NilXvhScagGJV6i59qa38gFVWK8+aF5IHdWbKIHDIRvj6p3nsNLZJDfk2djW?=
 =?us-ascii?Q?YszeABB3CFAMMBx+aO3IqJ97Z4RExS4q/4M+5PxQFPQgcq+kSRbD+9jnpPa6?=
 =?us-ascii?Q?eEsYIlOqxyYr0ZwZU7kXMwAvU0vBw71bnEtradotKLm221l/Cg/IHkgO94+1?=
 =?us-ascii?Q?gRqb/NPxIne4rJh3KNeRYZ+69SKMFPvcCQewdVY1xi+606bywNgJYwf24Qz9?=
 =?us-ascii?Q?XOVFdDyEzibqjFmTWTbtL1kpmwE5ruatxX2fofeQ8voa6C2GB14PzRSzxGvE?=
x-ms-exchange-antispam-messagedata-1: ajreH7aLRyqHTJIkwRTJxnz29tvgNl9nUzwTyDqADyFYMyI2onl963AF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883b5050-2326-41ad-b1de-08da37d1f9f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 06:53:40.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wqm/sFYx+iNsRlhyo7IvZ6/835EFHPrVZMx6wHK0RuxnIJlGXvfw/IlGQtqpBFpFFt3NzMvikciCM7JKwp7uZQX0zrR01tBk+GgjSzjVDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5337
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16/05/2022 18:54, Pankaj Raghav wrote:=0A=
>  	/* Cache the sb zone number */=0A=
>  	for (i =3D 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {=0A=
>  		zone_info->sb_zone_location[i] =3D=0A=
> -			sb_zone_number(zone_info->zone_size_shift, i);=0A=
> +			sb_zone_number(bdev, i);=0A=
=0A=
I think this easily fits on one line now, doesn't it? But given David's=0A=
statement, it'll probably can go away anyways.=0A=
