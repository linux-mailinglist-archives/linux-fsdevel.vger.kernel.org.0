Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E392F322B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 14:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbhALNtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 08:49:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40206 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbhALNtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610460289; x=1641996289;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UCjSUM3EbNK9Uiwj8ng4m5Wcqst/t7yTmsn/cRjMGlo=;
  b=qul7pMegv47dlpmXN4MrVoiIRG4EkGewGzXJuSeZQyQY51cm674ZfkqM
   NEUH03oXqo0kX4eFXucsHGCShq0vJq0TAHaUiiZAO5wZWyLKFJlucDWPd
   6SiOA3WzFYo/upEsoaUOim61IznJZ98opjVTkcOZaWzTRPdNW788L8bmB
   9svZt5RhZE94Y+KGmDbstw9HPTzG623A3jB42nTRKXPc8JXVMLz4k8DJ2
   hSgmvUMe9SInoIyow3HAxiweP/em/qT4RXI53ibEtjLB/5TojOLcHtRvR
   7hEBQ31VvSBAiTjddPAfzjxL7N5g+TWW7dalkh8m964zMap7CCLjoHkJb
   Q==;
IronPort-SDR: h6/an+elC+j8wQuCWPbZqClK3DvZcBydpCFDkyErG6ntyt+lIskrUW4y0CTJL4BSFGY8uZujuk
 UTdH58Mk7rLafCeYASxOpJLQHK3Svlt439OuKZFjuyM/dZFiAwh44NXzf1f0/xwuHwv84TBNpe
 Sbw6mWKdZ1wByXKt7SPdksnpTEauFzSqJgnR/FJBHaoQMQDUVsUOePs+VOgPUWqtyfIEdD01yK
 biPZknhtsJGN2WIse+iXL6+emaEbMZZEdZs0EhNwUNAN77bX5b8myhlY/fbR0e6Fxh/V3LoiPY
 7ZU=
X-IronPort-AV: E=Sophos;i="5.79,341,1602518400"; 
   d="scan'208";a="261140653"
Received: from mail-bn8nam08lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 22:03:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWxPF3H2N++1Zav146hXLmmer2d1FZfb3NzxBnWnYjMa20s6HDNuUm+oeDRS8YOrS9P+caxLxmM/iQ6UWmVy8ev/i62okDpWtIz8y5BkRExJER7KR+RYb+zfJiJ4DCZv3vYjMtC63t+F7sqcxCjIrn9TIq2s37oaZgGwV7ENhLrEfLOoZlUUfGUgsmFmGx6QWa420OlXA5h95LxUIRatyDa67zcSgT4iFb9+D3GnTdzEG25fxiFYZLalKawNCWIz4y9K0CK4IhrK/KKnm8aiT7eKC0tfsKFXBHnNhgIDoBRyfKPl1unvCzdO0mMk1S27n/Ul8UU6NGWVaJLal9m5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyZljLbHzuxsN3FjNofOyPEJ63QOoLRXgDXZedxhsGE=;
 b=WKSRd111q1TjvsczD80VlV6Jum6i3F2iIfEuZZ5MfWmwSL1HhmTyrpJl5xrjr33jsLLpasX7C0X0hMD3hmzkLzYssSdM9sSQGCsH/Ik4XKutD65g7FCRki3Ej6vbTzRCpRsJiqRkg5LEx0EAf1gfhmdcInmOHYnsmyd/fRx8H4lz0S7f0bgNszeGubhH9QTKzEPY76cDwajamKNy2mQ83k7M89gMuSDieLQkkKTCyWwQqH81HuyBKB2PZZp8tXuUGrT4BuebVyfwUPmbRdfu06rCAsrqfE2Id5xrmnkHe/wNdPbzhzaR6duKtpxX3NE1P3qxdZI08E5tMN7GjtN71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyZljLbHzuxsN3FjNofOyPEJ63QOoLRXgDXZedxhsGE=;
 b=tFXrgpMvKxyblyIwQyhYdXrwQEaX5hcwzwotcR/kUMLgwgoVpPUWmOc+tpiEhI5nyC7O8dIGj/iEZmNVBBv31wVBs+Gfma7gFT5unjEZhvp7ruqtTFFMe5z/rufBF0bQHtSiDcUV12JId1wVCrQUPg8mjr+1TugFYukB4cLBnoI=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB4698.namprd04.prod.outlook.com (2603:10b6:5:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 13:48:11 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::61b3:1707:5b14:6b59]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::61b3:1707:5b14:6b59%5]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 13:48:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 01/40] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v11 01/40] block: add bio_add_zone_append_page
Thread-Index: AQHW2BWZvPW5wHn7UUGeLnRkjRGHMg==
Date:   Tue, 12 Jan 2021 13:48:10 +0000
Message-ID: <DM5PR0401MB3591058581A93F24D8C357349BAA0@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <cover.1608515994.git.naohiro.aota@wdc.com>
 <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <20201222133547.GC5099@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:38c1:d5fb:3079:ba93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8f9880d-8426-4ddd-3c63-08d8b700b376
x-ms-traffictypediagnostic: DM6PR04MB4698:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB46989AFF7E0928310A9185149BAA0@DM6PR04MB4698.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dk/slc3mwP0nCG3BEEMZwxiaZGFCS54zhL721lG67Eo3O/5rY0RXrg9b/zChEysrdi+cAesnJx60lY05aYe38Wv69a+IrutCyUK/jlXSRB3em/h/fU+YsjNIdkG/64raLuiZueVh2sqlMAQDBkR77q9ULKGPJFv3gA9O59add2jHUh9cqa0+kWpQg0lLc8czjvyfk3cmL8vU5M3Ei/ki9xrt8L5jvjdI32geXMIQu0NXBYyrxGTBoCAzBKwgkpbUtoNCMixYkYoC23CoXJLAPfmBBgH0pdI1gQmrtJVjASgUevcu6zJA+d9X4MLGUTMeOzkhQsJRA2H/XcKBmWgim6VVMxJdwkMX8ad++vfCmoqk6K917mE70XT81JCFmRgHgaQQ5huMLWeo4wRmJ0spHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39850400004)(346002)(396003)(86362001)(6636002)(8676002)(2906002)(478600001)(9686003)(4744005)(55016002)(8936002)(66946007)(316002)(54906003)(33656002)(5660300002)(76116006)(71200400001)(53546011)(66476007)(52536014)(6506007)(7696005)(186003)(64756008)(66446008)(83380400001)(91956017)(4326008)(66556008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5+ShvLe8KYaqmTxHHnd0/0bq/lQKiNP+HkdrsFjqIWkbLhfg38XuGVJj3poj?=
 =?us-ascii?Q?Hni6Njlx2VK2Gz5KtYCPuLbgQLKzZ5hGsFXOCo6fQept/M2cc+I5f7JwxqOs?=
 =?us-ascii?Q?rx9H1hiukRubOrM6RB503flhVBFfIgs4+PlUO+z5fY/jH12np3QofyebSsDk?=
 =?us-ascii?Q?5G4E3/AElDx/iAAF3BveFN2FgzBZ+FXSaqUQcWM9+6kONtog+U5il+4A0e/1?=
 =?us-ascii?Q?jhY4J7tBJ+6P0teRdFccEIAFX1bRtJ7Eb5IdvMgAo4gr5E1adGOTpXivtu1/?=
 =?us-ascii?Q?N+AbK8nulGQzg8rz3jNOG2Svx8WGNt4q0RiMlLKZj6FXnKJSoaB8ap2JsMSa?=
 =?us-ascii?Q?YO90Q9GoR9qdD460PQwrkQbLbjGvEX5lBo+yUURBaqXrIPGcIgqnminmfKX4?=
 =?us-ascii?Q?/fZg10fgSkWcuB2/2Y+ytKtkHjF8k1OfyRTrWWjwvf2aEdOtQusav1aQSWpo?=
 =?us-ascii?Q?plHsDAuiekxQ7SwU15C74IAw7SDvreixhULmvvCIrc41rElA38spHpz08dGB?=
 =?us-ascii?Q?o2dudCvkcqG3sAtL+sTH5yH0cI5WnDGohOXoj24A35Gm0YLYryufnhzvNhBv?=
 =?us-ascii?Q?9Eqh27tU41jSmAHBKiun/FebGvX8mgWp2vX7hZOHlN2pV3+i6GmF7TvlXBfT?=
 =?us-ascii?Q?d+2Kf/sIqhkoVl6NiikdT0+MkRowMr9zur3PewzzGAO6IxyzZPQfiAq1HKPm?=
 =?us-ascii?Q?SKP/drb6kckZ8PmAUltHT6o+qaxV4sOEQVMs0jfddxY1LDmNY/ZmTj0JfS9+?=
 =?us-ascii?Q?ctMrQmBgQ5aOvCbYwTjJdEBqWxcTqxlPRzaTh9A3T7iP63xwD7LAdCz3j7Wj?=
 =?us-ascii?Q?w44j7gn4WuXQ0y5qTTmsYDLlYQe7w+Fc3VJmo0nbAu3ZL51NYLnWtsrHiNMW?=
 =?us-ascii?Q?2aPeDIUtqm4HNomJrTFiRf2sPcO+cKZ/8k950z/MhCGPPZd6hV4lLLpsUkhh?=
 =?us-ascii?Q?c44wn0RMQafEdsA27r+49LJVcmUC9B3rQdoZdKdqfLE8yFka3qBPOD/6JVGM?=
 =?us-ascii?Q?8NLRoKOUwhMzctkZrlFrVC0NyW/su6+XnXHXStcBYxD+e3GrVh1ks+lIJ4OW?=
 =?us-ascii?Q?Cw9egS1d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f9880d-8426-4ddd-3c63-08d8b700b376
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 13:48:11.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2TL4CtVXVCR5HxIesU3JRRKjTax8UAODcbdmdQB69J7Kj00aJaiEG57h+5KAHXwsqxa0qAZYiNhRaYMgVZALUYLx4lrLgzYEC93M0jhdCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4698
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/12/2020 14:35, Christoph Hellwig wrote:=0A=
>> +int bio_add_zone_append_page(struct bio *bio, struct page *page,=0A=
>> +			     unsigned int len, unsigned int offset)=0A=
>> +{=0A=
>> +	struct request_queue *q;=0A=
>> +	bool same_page =3D false;=0A=
>> +=0A=
>> +	if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_ZONE_APPEND))=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	q =3D bio->bi_disk->queue;=0A=
> =0A=
> I'd still prefer to initialize q at declaration time.=0A=
> =0A=
> But except for this cosmetic nitpick the patch looks good:=0A=
> =0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> =0A=
=0A=
Oops, fixed.=0A=
