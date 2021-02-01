Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BD30A633
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 12:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhBALHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 06:07:45 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:1333 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhBALHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612177658; x=1643713658;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GtlMTryiH870Ycetc3Y9P3oPb8zEFlbQfXUlweuhdAU=;
  b=hJeQXGt+4vOa8EzSSmoplszZHjcIxUC4MMYh5kmqZl26LJQQadiu5OOC
   gmcEsWTIw3tbgWD4znRwrXcRYmbfQclo0WJ1T6EZyXk+qGes+HQT76FnQ
   XVWt3YHAZawMUGcdSFOwAV1Kj/aXxHM7o2SqOoBenVdRnIMDmk2Mh4IC/
   W8Yr8iuQ4ZQvAVcaeXBtzzsiuQhZm7gpxGp3WKsh1tg/yyFusQP4RD6YK
   wKpzmCmcYAVarW2UnY+azWRZ1L+KswD4J8DHk+RJoIcJpbBvpc3egqkAm
   P+ufOc8K6CeYhjB4A16fzX261t1lf6XwmOka1uUu7t5mOEVZLIVk8Q/va
   g==;
IronPort-SDR: rwp1M/3pgejCsRHP/XVunaTeJtXUeiu0uxh7Fud6XNG4NqgxEl7hmT0tE/FxEZ5FHHYYXy6/BG
 r5UcCtDYcZOoX6dq+fd598p86iw/ewOSd/tSs3o9lEQj0lhuKLKbjK3KeTbDsfRmG9ecvYnKXp
 B/xJasO89pS00XgI6Rb0rUtD6TMW4HoZucvc319HXFx9M/WqtOvt+wwilI/0u7vl2RYzSUppu/
 gRxfXuKez23dF6G5fUm61KPldA2rb8xHzhplfkTdNWHBozbZ91cFl1L8OeENEzdNq+WroQ+J0j
 Hrw=
X-IronPort-AV: E=Sophos;i="5.79,392,1602518400"; 
   d="scan'208";a="159988945"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 19:06:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/76hPN5sr0u5B9kFEZV1ddEwrvcR4wGDKDwk049ROuSiQr0wUq3SPPNaWxr77sALb1YZUNdIFqdew7ELD3en3gVFo5FDegSZ6DxhpT9XRkkkV0kxcHVxixWfvPPa3MJ45Wd6vVp0mLbuZB51v7xXViiKYYxe2S7uwpgrlQB9q0erzGCDY3LxVigw/BMS6c0VEyvRB3zzjG0rARuo+7JuOkHtZppI2SDZ450SGV9hRIaGAZTK5dKNe6GIHjBxnIanI7IoLqmank8ZnM3Cl7rBHY5Dh0bNegiRsBsma09FV6ok+X0+4IvfK/2CiuJwh18hxQ7vYGtsv8R9DBOICWs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o11i+1c9lfBzsYA9kObwCI+XiziWfZVuGcDZrUogzUU=;
 b=LE87qu4SgX1gQ9d6DAf5Q652pHmMQaU0bI+B7XkuKudfwvTYD1PfqvFLUE1UtXHCaI6xhAsltqj+2B8FZBWQbSRzr1IvCkOMDB9zKCQvZjAY76aPv7FrpZKLRDssWdJVsUVORHEFKrzoD7x7AVdcG2TsWj2Q942OvDpUP4dg/c31gF3OhzMBn38+OIFdX7cOyTElbuwH3YN0NhkGV+gfafK394j/Vsoir4/i7jHxjdC3wLIYlfU4wgWnFrxVmDip1HgyHQiWNjemJZYbZMt8DRrmIvW7OBhngiE9kNLcEmB5Ahzcxx//J7GSoSyeV8hmzWoZdeRc97aMySe2gk2MNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o11i+1c9lfBzsYA9kObwCI+XiziWfZVuGcDZrUogzUU=;
 b=0Luv0aTZq1Slr78FPcvgttuLrhIgBnpb7NDK4ZIsGbd52DUNHHLw4G7a1WyvMVgWL0XqJbwaBtyCJyXSHmSWW8xo34nYDfRAmEYsYBidJ3817ioFgm78DpXaCdga5BhCVit1Ffy5rCuRfZBPz5u7TOEzVXPi1BXRF91PAbfbnUU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4927.namprd04.prod.outlook.com
 (2603:10b6:805:93::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 11:06:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 11:06:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 08/42] btrfs: allow zoned mode on non-zoned block
 devices
Thread-Topic: [PATCH v14 08/42] btrfs: allow zoned mode on non-zoned block
 devices
Thread-Index: AQHW84qfT+OW1qiyzki09F95xiz15A==
Date:   Mon, 1 Feb 2021 11:06:24 +0000
Message-ID: <SN4PR0401MB359886FC1D6B3B76ABDAA1BF9BB69@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <613da3120ca06ebf470352dbebcbdaa19bf57926.1611627788.git.naohiro.aota@wdc.com>
 <a945d1b6-1001-1c06-82cf-e1ee4a71d9e7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ad4939d-d1fb-4f12-83ef-08d8c6a16a68
x-ms-traffictypediagnostic: SN6PR04MB4927:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4927A63D81B7F31C9D4607A59BB69@SN6PR04MB4927.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zQbZE1Wk45hTO6a/FRS1VUHlrYtlm06H9pSux6uA975FujXNVmNZFNl7j3nAEOX1xTnEZOugY/Efvi7zE6FGRrG4gKPttkf+3yDEmnmIN0BCDYQTcphnv0Tlu63wLdR/vyIDCdPjEyeLrBB9/AtrKSc/UFj27ireG/N26c+pk6ElvBvaBJa4fWbh6kDzPX8d5ab9RmdMODVY6Zwn3p5SGhjKOR0Bs9aclu/iRFBd3k7aarmJZhG/zrXDEX1BdpT3nemXNkM+YxYeufILBQk3Jc4ueUNeM4kX16CIrr8I1rET6JqSuL0Y5xS0OtwzSHmjU7gzUOlxlw8jrSNoh37VM6jcillwFvHbU1s8/dCVMrNelT6XruLoeTjqGysJHbVOsJ9s5HExkpj/7oteX+Tfg+qVbJlqHlNVOgeb7Mx5oZmON4iFhVfUZwv51dJc7vKYiH5cJjEFcPUU1RqbFymohYxTvwaUMQHDIawfqLU5ekMG/4Y38oF8YYq9dVk8h8rBRC1ytKIKhDX38YkVcQXuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(110136005)(66946007)(316002)(186003)(4326008)(71200400001)(76116006)(7696005)(91956017)(66556008)(2906002)(64756008)(66476007)(66446008)(86362001)(478600001)(55016002)(9686003)(53546011)(6506007)(54906003)(8936002)(52536014)(5660300002)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Pqth+FegFd1aYB1CbpaRVjMzzQ3diMpT+iJMjND8vcJ1GeLSb1lCuU9U4q3w?=
 =?us-ascii?Q?hNJ5zLOdUd9dvO/FpMJ79u5AOXMdB9ViPqaF3Im0pA8w3miNv1DtAGOzZnLO?=
 =?us-ascii?Q?Q3fGGKsyV3d9hQ58MbwojbvvzDpwQp+a2rseMejmKG05TNUiLYzva+CXx0DF?=
 =?us-ascii?Q?1P5+zchFoarfTLcfgsUVWu6MiGjl0hsHr3zIpadm4T3yHq0nvvAvDIEDHv/+?=
 =?us-ascii?Q?flc3XkXhwdjTwgms5GOTDP11I9GsXVf+H5wrfITuq0FdgMwR1tEe4mQsQ/jQ?=
 =?us-ascii?Q?aclkCbWGKZ29tAj4wNnI2MuOZYMclPxN9sb3YCfwxAxKs0KurdDgs5AY07Vu?=
 =?us-ascii?Q?r8UyNFbyzc5uZNSO8PqJ6etaw3JJnYeFiCTOHorGe7mLN/M8J7NMojC1CJFT?=
 =?us-ascii?Q?dcFP1AFVzoXkTp01rHgFlFy1a0CddQ168K7EqioqlLGVrMic4FmKHl3Aq5v8?=
 =?us-ascii?Q?ivTrRCW//Rqta0aWN5F3inBJjNovUyA7SAfE/nik3j1qTq6yysSRyXAoE2q2?=
 =?us-ascii?Q?PZyRu1rxd0LjPbXILMzxMNaTV980ZFIvM/Y7SNccm58y+6RlCWD0CwXGlzjJ?=
 =?us-ascii?Q?yEW534ahdCDVz0zH273MpUPB+N2d5mzQdZzs9cpVuLMrK7R5eaIWvT4WzvHu?=
 =?us-ascii?Q?IAEHh3AGX9bzO/IEh+yXrB5l2ko+IlIloOq62qzChx5+Y+9svAKECwz/jRTb?=
 =?us-ascii?Q?3668AgT7aLZRNsQmsfxXf7+ldOGIpesU5Db2h1MxdeO0hYmIE27VzVpWYfpz?=
 =?us-ascii?Q?+O/Cu9ngscDi+4JH17z+wR1PzuAn9YyESgwM3ULDdRxO2tAEK0q+LIE/TGUV?=
 =?us-ascii?Q?9cR6ibPfflikSFRwGkUuch9owhuqvWUYEUu0R3bkUMYnT4rNbFf1pXB46Yn1?=
 =?us-ascii?Q?Rz6YozClIG7oOeQDux0wwF73cwmW4LwngJ1y79NUJ0gIDw9IKsGUeDwu+TVY?=
 =?us-ascii?Q?kXx4auYNJ4scKP45SHJpDZRr9gOtoaPDdr7c41Y+9v1kIcNlZA4DMDA4vBgD?=
 =?us-ascii?Q?RWeA214+8ctrRqDxXrz1J4LW22KGHJ7bYqFnpYIIAyzmpyPfyuVQ2iIqhkJq?=
 =?us-ascii?Q?6UumgOWT5nmeVdpeQIzGNilv5siLeATzhSmuw+5DVSdY3Np5rbiQupp/ehdu?=
 =?us-ascii?Q?O0to4f4XBaDgGQl83mjkTu9wd0+fYvEPTA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad4939d-d1fb-4f12-83ef-08d8c6a16a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 11:06:24.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giGYT1DVem+n1ivRZh7SjUcP5HZ+tuK4uTDP8k6d+XoNh+md2X24GqYLc8IEvu+T2SeIMBc8n4TTzD9iZQ8jK7O/d+pfHmIt2QQz3QNCX3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4927
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31/01/2021 02:20, Anand Jain wrote:=0A=
>> +static int emulate_report_zones(struct btrfs_device *device, u64 pos,=
=0A=
>> +				struct blk_zone *zones, unsigned int nr_zones)=0A=
>> +{=0A=
>> +	const sector_t zone_sectors =3D=0A=
>> +		device->fs_info->zone_size >> SECTOR_SHIFT;=0A=
>> +	sector_t bdev_size =3D bdev_nr_sectors(device->bdev);=0A=
>> +	unsigned int i;=0A=
>> +=0A=
>> +	pos >>=3D SECTOR_SHIFT;=0A=
>> +	for (i =3D 0; i < nr_zones; i++) {=0A=
>> +		zones[i].start =3D i * zone_sectors + pos;=0A=
>> +		zones[i].len =3D zone_sectors;=0A=
>> +		zones[i].capacity =3D zone_sectors;=0A=
>> +		zones[i].wp =3D zones[i].start + zone_sectors;=0A=
> I missed something.=0A=
> Hmm, why write-point is again at a zone_sector offset from the start? =0A=
> Should it be just...=0A=
> =0A=
>   zones[i].wp =3D zones[i].start;=0A=
> =0A=
> Also, a typo is below.=0A=
> =0A=
>> +		zones[i].type =3D BLK_ZONE_TYPE_CONVENTIONAL;=0A=
>> +		zones[i].cond =3D BLK_ZONE_COND_NOT_WP;=0A=
>> +=0A=
=0A=
It doesn't really matter. The emulation code emulates conventional zones,=
=0A=
which don't have a write pointer. A read drive will report a wp value of -1=
=0A=
AFAIR. null_blk uses the zone's end so we opted for this as well in the emu=
lation=0A=
code, hence also the 'zones[i].cond =3D BLK_ZONE_COND_NOT_WP;' line.=0A=
=0A=
Hope this helps,=0A=
	Johannes=0A=
