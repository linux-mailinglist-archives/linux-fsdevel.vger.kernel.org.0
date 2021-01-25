Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EF3023CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 11:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbhAYKlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 05:41:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58812 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbhAYKje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611571759; x=1643107759;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ufgi/gm/+klQQE6N7sCRfoge72DLc5YeeXesESSthgk=;
  b=aJAjnSUGGjg8fCD3wsQw3SuZwgZrf6qmyX7fkz0buaJr3fRIIQQ6Dl1g
   6jknd3Y0T17uslAw45IMvQquT+3AHSB8hz6AoTSoDwdm1A4FhOAdyUkdf
   k8pxguGbttW7CLw7393riFqBCIQpiztcPLNCfbi3DTjuBItoxuJw32UXw
   j2ZiZwiWVRP4Q9lTP0jJvg8UQBrEAa1iD8vP0kT9OHwUxsu5wZH1hap5Y
   nMFD6pJDQGokJPbTbicRBq9GG4yKrKwV6sUDIf/FFZC9BeK3E3rbM6ZP3
   DjmDKJwVEmoQANwEVul1CS1PwYCQTxXys3vq1xC9ov5mfqj8k8t3x5A/z
   g==;
IronPort-SDR: 2WICECgF0O13pT0Y3I3rquduzR528W+4IZ117HxqXGbPrDEy7H3vG2UXqgXjgAgOkHvL7Keprl
 HEmaq+3T4xEODSRaJxQEYfbxfW99RqIY1fV1C8SrshMiLXMZIFYoc6VD93eFrehnO2O1Rk5NZi
 ZAAGg2wffC9hccH1RIUgQCzx2jmuC81yPYqkeBBn0t45TYT6QCmw/8kdBpUT0x5nJCi3e1Km6o
 WGfA7AMqgkhsNZptd9wgDxs7Ud1kD1bDW8CRoJzaPeS1WGR6zsSkYGOYwk0bHSqSbJ7Tf9/e12
 h7Q=
X-IronPort-AV: E=Sophos;i="5.79,373,1602518400"; 
   d="scan'208";a="262247850"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2021 18:46:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcA/6z68P2IBc+P9LoxBcA6ZbMDKsJGb8gh9kk693UngZvRKC6gjTXJmvDpYKRnvDWi3sqG5BKRxk1O/czTSluCPUZLqjvocE2XeVFgsqHudnDw1b5d2Yv1oDTD8Gca5xJyyYBkm1XZ45w8ceee/SvN41hlDonOJxjNWprQhrjSXUtU5C6yZ/uBkBNjfm6rO+uf8etbmwmKXH1GyG5B5GX6G7wTbG47m0wWXfyXkjgnGo9R8B7Q53fEkMuuRV+LzpKNgVm21C0HNu/f9lc8kE7XuG9/jxO3phR5RBSgWx8AhEAT8+fmg1FVdxRhp8RSYSF52s5W7wASuY0nMqZkYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP7yOS/EcR7exqWLTMFmhWdL0f+sUCqvSMspFAke1kU=;
 b=PQh8T1FfwQkAXW6qlZwvHu0ldwutbLrw8u0UsnjoXZXgvhoDkkgbgnS0WFnKcBQqoAAlYoOEA+oFOpLRUmHrQ/a3oKmpHiTXgso2FVXXltekEvd9S0x+2eZa1tR3hX0FHFaMMECBzouYPYBBT+Q+5pim3XdJYoAR+/F5QjYM4xW2QJmbZ9C3BbEeepEgBP8poR77fadHO1VOKGzdB+sFMvE4gKFyssthJM38XglBhNlWJBVTZm+WS90/c20p7sdJzzaKiKuuGwVOCslwFEpIJJ/BRnrF/HXNG4a2xIRdSAM34kQwLGzsds/ihhoc7kfiHuHXNmbdAOumAjR07pjduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP7yOS/EcR7exqWLTMFmhWdL0f+sUCqvSMspFAke1kU=;
 b=fMQH2cXxAO9rS/NoexxfoNWiQtV9g0E65IB1Qp+KXFBptWkx4PTwK0OIa611QNQc/wZP2V50/bxYTjZxo1d9bA0OvNbhqLSIHWatDvhyS12d+CS3JBZ8+jHn0LJlENgisSxZQNJCaG4KZA/+/QSBeUPEi2lCYHJxcHYKsemF8ZU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3885.namprd04.prod.outlook.com
 (2603:10b6:805:48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 10:37:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 10:37:52 +0000
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
Date:   Mon, 25 Jan 2021 10:37:51 +0000
Message-ID: <SN4PR0401MB3598871C917A824777BBA6649BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <b949ad399801a5c5c5a07cafcb259b6151e66e48.1611295439.git.naohiro.aota@wdc.com>
 <7f676b7d-ab80-5dc1-6fbf-ed29e4bf4512@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44bb08a6-088c-4bfe-3dbd-08d8c11d4480
x-ms-traffictypediagnostic: SN6PR04MB3885:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB3885C8328789575D03C172F19BBD9@SN6PR04MB3885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kd3KvHbmH6vjm01aGacAg3JhEQnvkxUExY25dt+1WiiDOBDr8hPsm6uFaTBILAnNNjr34BBSl1mhD3wizZwcqvUKqa7WvMYiMxdRBoW9E5oEzyIlmwT4FQARDefIp2n7RUPynmkaBEnndl8HdBf/iaTLHzJdJhmao6A4uY39l1BG2zZVjdHFFpUsFIm+SIkMfa1thjsuq4Ouc4xKy6Ifs18o/RRJXMGswgFvOLkuOPUumz6oyTETg83q1kh75avXXosP1lQFMJ2tzDclWPfURvOcZiJukuFRlFCKc8k3qM8/IhNGuwpDKNYJ3Uwgd/R3em/JTsiFTlluAn3k2V1mOCTQTXs8mItEUFbO5+QekarLBZoEMc5M2HsYckYnhQUjuM0pKrFMDT8b4JWhYKdWEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(83380400001)(53546011)(6506007)(2906002)(5660300002)(8936002)(66446008)(4326008)(7696005)(33656002)(52536014)(110136005)(186003)(316002)(66946007)(8676002)(55016002)(54906003)(86362001)(9686003)(91956017)(71200400001)(64756008)(66476007)(66556008)(76116006)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?b+AnjqPyVgBWECHgaAfZ3yUY2EEmxVk6a6X9pikqrJcwnqtGMb3mQTa7NwER?=
 =?us-ascii?Q?GdH5MUE5Js+xQU/DKNp08DQlKhMeutriBZcb/RC9DA4XuotS7q06F+bDon1v?=
 =?us-ascii?Q?pLax6eHgixPDTxnw5V38XB7IRizA9o6Gg60T1zGGSNfqq4flaxzq9iO3CS20?=
 =?us-ascii?Q?aEV8TkSqXgJfXlaB8sISMzbgjvqZ7DDoxvts0dcwbKRhdKeDBnBXTyKBdeNc?=
 =?us-ascii?Q?4/jWtZuQQw93p8gCsDEzRvZO/zNy1+/OBPdlcLNtgz6T9EdyYvRhEMiPYiej?=
 =?us-ascii?Q?72xNN2hEMooN/pJhGTBmCR3nszQ7LKnhA1xceBsF1ocp+9bz5+w3Ygy4e1y1?=
 =?us-ascii?Q?EdnP5Kn2QM/5Xv+133N7iOXG03JHCgpRtuoWCE7LIIg4lfxfaMDrnYrmuXh+?=
 =?us-ascii?Q?t80SVKbmRTRG/Tt5X/SvRsdU4IOlaDxUG6u/9RgISCN2nK5mndcH4npm/fEc?=
 =?us-ascii?Q?R81aqjQIVXbBddOVgkxSJ6s2Cn/f6nx/+5ERRWKBeZPvrgLhJq2VTXxqBR/8?=
 =?us-ascii?Q?sP9AqivWkNs7LwCamJCcsnEEeD/Ne1ZjibDfCILuQ6UBDBlmrSS1EcrDaE1i?=
 =?us-ascii?Q?kwDgSTDar3VHHYTSlmQbtRcWHE9O/oKkUhuI329zfXvxhsbKHa8b0lF6Sn0m?=
 =?us-ascii?Q?/Gz+1c6QHE41vwx+fyKsSGsTU1VwSWIT8jPLopBhIdVjfFTE7zgoNsXMZpwS?=
 =?us-ascii?Q?zkovhmTo+RyQ6Ywi/Z/f25Raooz/UtjuFbdXTE9+E18mc9MHQVF8idpeTpi0?=
 =?us-ascii?Q?oYQtbIWI5j/wt9HVfVFX+EKv9joJpZdGMiscUmVXBf/1HcSN0loaTwj88G42?=
 =?us-ascii?Q?3jM2ptaMHKJoCfFp71RYQfqiEevZzrSflmA5BQFf7ZDoFJidtKl0b6aa43Jq?=
 =?us-ascii?Q?tja9scTJscff4J9ltksoAH3p17dxFbr5HJhT8KGdveblL0IvLc4AV8Kjeadc?=
 =?us-ascii?Q?Yz55Y07L3FkDRq5QxjKVJwTNIEkdQPinrLHfmUVDWxaGNzKDwo6ZvJUAM/AW?=
 =?us-ascii?Q?d2pt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bb08a6-088c-4bfe-3dbd-08d8c11d4480
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 10:37:51.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nA89RaC90kza6vffisHYEUp4gZSjy5ir6AADPhQo+Xnf5VxIHTrwYMK8Si2pI/PWPJybshW4LQnUImjBqfYhLS5tdVr7almiOz8D/3BRLkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3885
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/01/2021 16:15, Josef Bacik wrote:=0A=
>> @@ -2725,6 +2726,9 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,=
=0A=
>>   {=0A=
>>   	struct btrfs_free_cluster *ret =3D NULL;=0A=
>>   =0A=
>> +	if (btrfs_is_zoned(fs_info))=0A=
>> +		return NULL;=0A=
>> +=0A=
> =0A=
> This is unrelated to the rest of the changes, seems like something that w=
as just =0A=
> missed?  Should probably be in its own patch.=0A=
=0A=
Hmm probably belongs to another patch, just need to find to which.=0A=
=0A=
> =0A=
>>   	*empty_cluster =3D 0;=0A=
>>   	if (btrfs_mixed_space_info(space_info))=0A=
>>   		return ret;=0A=
>> @@ -2808,7 +2812,11 @@ static int unpin_extent_range(struct btrfs_fs_inf=
o *fs_info,=0A=
>>   		space_info->max_extent_size =3D 0;=0A=
>>   		percpu_counter_add_batch(&space_info->total_bytes_pinned,=0A=
>>   			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);=0A=
>> -		if (cache->ro) {=0A=
>> +		if (btrfs_is_zoned(fs_info)) {=0A=
>> +			/* Need reset before reusing in a zoned block group */=0A=
>> +			space_info->bytes_zone_unusable +=3D len;=0A=
>> +			readonly =3D true;=0A=
>> +		} else if (cache->ro) {=0A=
>>   			space_info->bytes_readonly +=3D len;=0A=
>>   			readonly =3D true;=0A=
>>   		}=0A=
> =0A=
> Is this right?  If we're balancing a block group then it could be marked =
ro and =0A=
> be zoned, so don't we want to account for this in ->bytes_readonly if it'=
s read =0A=
> only?  So probably more correct to do=0A=
> =0A=
> if (cache->ro) {=0A=
> 	/* stuff */=0A=
> } else if (btrfs_is_zoned(fs_info) {=0A=
> 	/* other stuff */=0A=
> }=0A=
> =0A=
=0A=
Fixed=0A=
