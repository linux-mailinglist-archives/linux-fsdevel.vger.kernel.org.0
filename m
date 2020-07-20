Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A5225EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGTMgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 08:36:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:3713 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgGTMgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595248636; x=1626784636;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2HPAYElkIi31+6yGb1qDjYMY4Lua12KbzJ0vt3coiks=;
  b=QvO/vSVAIDM/vjlbx3GWRxRognH6U5JACJyXwtoVDffUbT5KOX5brD+X
   0uvZ3EU+oCP8xE89pwjG2Dd5Cy1a4UTUoQ/ndtLq7TMoNCwBw9iB6n2+i
   PPg/yQ3BLnhAhX/TOnJm5PwvkGOGMKKkmb4llPQ+QsbMiIMVAinfcXv2U
   1muONqlRsY0lcPFm0fXPhuPf1qtkx28RWRJSJLMV3lxQKK23JBbv0AfCL
   lpZ2UVx2Lkle/yiAKn50nTGfrhLnGRonAMugEG8jE9CIX+z65pS2UmELB
   8Ed6nlktiGfIpLTdPgx2ytltoT7AE2m2quzWvRVGYget5Xv5Nl5egFQPk
   g==;
IronPort-SDR: m6B4LSbIjpCjBoSMhoc38Tq6P00X2ympYLWI8fSLRWp/NPGpj+klBFozVH3q/gr7xKYTjmLQ3c
 4ML2Qkehv/6rxpUAM1lcTvJfI3rwuvGTkPw/GdydzX25RHUh+egItWwDgFeWZ9a5QxzkVtRgl0
 ZGlToJgxFjWwBuaIf/DVaEm6d8HpCMi4Y52HGHqTeZ+u9+ZPDCOumgLCt+8kdCPQ8gsz3I69GO
 dH1g8Yc0bOZhizg/5R21AsF5iVvHQO9ClN+QwSNXdSsTb2/L4uxxyplYT6FFE9J6UyWQr1Mcm7
 lY8=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="245952049"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 20:37:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOMps3cS+VEYpaJH8IgE2ZsXBSoZeHUgmbZDbVLAiVSfyNrMX6Xbpe/RFoAf7f/8y7sfgs6MpA8jjk5bYasJpXoQ8hDXegxkxBhKxxB3okTTL5cN9MZ2FzDSicTYMUoIpREL70m15yYWblgIkcuxpAA/gcf/QzQB68yA19zJfDHod6SLzrAo8mGcvQAlTTANN2ZDSJy02iBOojRba1H0XXdYPO/X023D49d33OLt5fip1pcBwIvUxuM41B9CY7NAgPSfCYj6FDsLwuyLNji8p90f7rglbq7+gBommHsK97mRzeU350Lu2IhyU8KjDiGSEh/FFGrhoWiSLcXk17e0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POQTI5LzCfEYw5IeAU4PnvAf95mpn9yGff4/C4Eu2DQ=;
 b=k9Jg9US/JjOXkysGaTfuIc7zg+RaUu9DNKHueNee7eZTwNXkBYX0c5QiMbGRQR/cqEMk+vmDO5z0Fr6oMFKzFVi9uqXCr3VMnpmu3J7sPhbs7R75Nse4mTfLZ8S5pF/x5M7cm82jj9eOeaYvaxE/TNDXFbHy64VIO3ZdpyVX9g3qVDKxTzn4VrI6uFmdB2tNfdK5RkVFk0vq5mQXcAkC7WAuMwf6QQ6LO49ZzdBQRgoG8aoLhCtMAPx3GFh19C1SgGuezSfp/ug1/f3b+ZXUqAF6TPHmOGZHL3YN6sr7yNqQIyPK4letlVUtYhxsl0sCJmbo8xokHltOs4cSR1iTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POQTI5LzCfEYw5IeAU4PnvAf95mpn9yGff4/C4Eu2DQ=;
 b=xwMSogvZBB+ZvTmZ+Rzgqq7qPEqrO3lmxGBvYLjqWY8Fi6buaSlx7gFA9FcbbeGGbWglNYEy2mpo+xLlIM8P0jr3qGaJvvfd/petB18MtTl+OlJLi0WYdryGvgImLjoDcl8aIafGqibsGKtabYkXzi2lMQGwxoz+4g9OxwxDiCU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4398.namprd04.prod.outlook.com
 (2603:10b6:805:32::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 20 Jul
 2020 12:36:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 12:36:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] zonefs: add zone-capacity support
Thread-Topic: [PATCH v3 1/2] zonefs: add zone-capacity support
Thread-Index: AQHWXpFi8pl8WzgsQ0OYfYLUQoaJjQ==
Date:   Mon, 20 Jul 2020 12:36:49 +0000
Message-ID: <SN4PR0401MB3598A4C053BAD3B93BB873D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200720122903.6221-1-johannes.thumshirn@wdc.com>
 <20200720122903.6221-2-johannes.thumshirn@wdc.com>
 <CY4PR04MB37519A139219C1D788BCA048E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e373550-a8ce-4d65-d540-08d82ca992af
x-ms-traffictypediagnostic: SN6PR04MB4398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB43987B6ED6BF15375D7E82EF9B7B0@SN6PR04MB4398.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1HYGqQULGF70GfV5zyp9Pz+vnT+4gPq2mWjuEvaEmr+UvzgBUQJVcx5x9rxO7UTj+a+3TVX0dTSuZyjpmOaR8uC5QgYZHwGwtMJTn0Ir5m4T/DkvjejS5JZXcdtCdLVOgg5aKBeNM+PVJm8y9zL8JTNOQtoipI1yjPXnNoQ3qCf9ZhVB4C2GyPSFQEo5bLVjGJ+1Re6I08/wx3rq69yqe9iWkohUEHvL9yjCX6f8Cf4ddRYjYRmYk7a31OG8JSvihSE/d3eDkLDClXDGKpB5dOo5LN5J2V47MdIIJWporWB6HicucdlvoqH1mqXaAdKBboJTs6fW/QCfOixb8vLaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(186003)(9686003)(4326008)(2906002)(6862004)(53546011)(6506007)(478600001)(33656002)(26005)(55016002)(7696005)(66476007)(66556008)(64756008)(66446008)(66946007)(5660300002)(52536014)(86362001)(91956017)(4744005)(8936002)(76116006)(71200400001)(316002)(6636002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MzvXHP3vzR5Z34X/Zkh3u8vxQw43U91ugk0Ykwz6Wu6UMvZ8VGfqKQK24bkv1Lv+yyxK6mDufw6PdNlzFShv6pWkmLE6WzGB+oVNQ1OA2H6h+qmLdy+ifESvMwbqPVSp3HIxxnE5dRZGr9DAWoFZSS2i/ih1otIgc2KWpskmyD7YcgHtLq1uOmckTaNq1ByJKq76oSLKSnOmM3iisGHijNwtbBvxpCjvIe2N+hEXMRnuFQozeoMVnAynRtxLxSet95SG0hhAxvECq28Uxth0+yKswIgAcbJmUvRVQu0HUGqhi9U5CN21GDJkYfPMTMF9xJIOak7wha4rBOaSanM4W2GhhzaGCj6fKIeyv/Io6QtDdyROhDLuB5hWmJdwLKxLkY+6D3k1qhOxUGZvYZAnFEo+F4ibgubr0JWwoVJVExtfZex6wREv1XVEbYXaHYXxzGxsAuT8uQ1AqJYCDd0Zf0UTlZYnGM1LFCYUH8V87ztsCYh1VlaTkmqErX60sOJA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e373550-a8ce-4d65-d540-08d82ca992af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 12:36:49.3738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJ2MReN8nLcsjPfvS+dAJry1/e09662zsh2DbwPyE3fUHzLdrGZmzbn9w1C52GBwDZQ6fjZGZldesEAryUvrlqW5izTcbwwt+FziBmlDeJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4398
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/07/2020 14:34, Damien Le Moal wrote:=0A=
[...]=0A=
>> +				zone->capacity +=3D next->capacity;=0A=
>>  				if (next->cond =3D=3D BLK_ZONE_COND_READONLY &&=0A=
>>  				    zone->cond !=3D BLK_ZONE_COND_OFFLINE)=0A=
>>  					zone->cond =3D BLK_ZONE_COND_READONLY;=0A=
>>  				else if (next->cond =3D=3D BLK_ZONE_COND_OFFLINE)=0A=
>>  					zone->cond =3D BLK_ZONE_COND_OFFLINE;=0A=
>>  			}=0A=
>> +			if (zone->capacity !=3D zone->len) {=0A=
>> +				zonefs_err(sb, "Invalid conventional zone capacity\n");=0A=
>> +				ret =3D -EINVAL;=0A=
> =0A=
> Need "goto free;" here. Forgot it too in the code snippet I sent..=0A=
> =0A=
=0A=
Oh right sorry for missing it.=0A=
