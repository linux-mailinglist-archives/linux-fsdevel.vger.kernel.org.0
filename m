Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9884033E21D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 00:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCPXaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 19:30:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35723 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCPXaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615937414; x=1647473414;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LIT7VoqiN5RPT6cSSgDdHiY644uQIvQdKeEy8rpOVcQ=;
  b=dJRuqLDhjqjyznUrZIn6pL+7VvHh2JtmURmmIpmMoDm3zFbvOEDwDfys
   p8M3488gaoQ0AdbXYDBH6p5A+uNUHB74hAXmr7vN8UNJlzSXhgg0D4OdK
   O+gOJHfa5+qk2uu02JyssYLX/pcUOxfQnKYPoFKwGfqUv03QiwPqGQwuA
   9SLy316LSWZx5V80EGJsErODwq7wVIVRg4sKx3bKYmImomBn1F0pYnMJW
   EmMMABHgdIERQXZfekHYpOZzmdLIsXTRTMGbW9hGkSqBaqvECqfxv/o4u
   GTsBN5Ye0TBdAWA6JguixOy+4e/DKJRLXU3oETMDa0QVw7Jo54/a8uUbA
   A==;
IronPort-SDR: LqX1K+g1NkwVxsxlpEfI5hT9Pav1Xzj9hzL/RjkRNzXhfltRwArRvTEzWF8pqkY8UkAvPprq2M
 jMYmHob0c3CFWP42SonuHy2bKnJmQlNkW7U/BZOi+rgjktyqVZGpXB1EWACsq/SEkdnOxoYzAb
 KQoePpjcu9oS30tpMo4rDNghrZ/QbqEXouOxeP96RkZWZJAsn/LR43ySWMM9sK4PUT0Is5N3yW
 vxezzlt2yACTLZy/whjAQrEEIIpxH+AmcaElc8RKxMAVqLGCRjC31Vs+e1F8p2eHR7X/g3ddkp
 o8Q=
X-IronPort-AV: E=Sophos;i="5.81,254,1610380800"; 
   d="scan'208";a="273028708"
Received: from mail-mw2nam08lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 07:30:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddzIwu4Kq8N0NylvFGjtnzvmwUSOiRgZIhhsjYDyHPHaKal8txRjRajkiB0eE/fbKh1R8K0EDQZ/Qkf9wphYppkQ5L9Der24DA3zlnsoTy0wd80/XtmeL71qxyfH20Nk1xD5c7NV7fiD9vz2ikZS2W2t66nVN2o8xoKJrtglSabk9QoL2b5xp+aBjtA7axTMOR0TLX9SnSpt+HDb2ev6KpPStXWvKGttmPGWs73G/9RzR8KQwZLq89+ckJI19lhl3aOf0B4KDJ3Lsxy0fs3hlidRiKVdRIoWm4InwRPON90A2fd2wOwlzyBDyWm4jGYV0T13pbUmLlkeu7xfsvW5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrDsjC2SxVXsxV3u0AhCCWPGiLiutzS4lqOOg8mxmJ0=;
 b=U/OSFLtFoP/+tobTg0MCIm8rfqRUq0YoQEIUfAZzOZ/mjHWpbi7+x3XnTLbApOudae/VULBDDOB2co8EPnvxhPuRlTrWq/1AKq2dKdV2ngOGfM5dBBEHFYi5SFa2iPIDtdmnt69DTK6KTN4IwbmbGIqBvW6f2RJ9zH153sJi/NDETvbTyKjq0XbIxvXTnmOB96ZEaD6GUFqZI5Bjdn06cumooTePUTyvMmcl7DR2mNtxWz26k3gFtYta3bEf0QlFOmwzQfzWKg5TGisSQjvC6iWqqMJlVheyWyBlAjATE5rQA3/tSQQnWPdASuSFoi2kkLGPR/bCjcSSb+eX9zSEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrDsjC2SxVXsxV3u0AhCCWPGiLiutzS4lqOOg8mxmJ0=;
 b=SprtGDdwE26QBO9wbSVCb0miDA8j0vv7kffDjkwEwJA8LCuPZY5+sPbWI09km+F+v67iB6NaMm6yBebfkjOmyRc1z62ZgTa6FtjKiKwPn5Xj/l8d25FvqHt/3aYiuAf/hTjJiPqXe/iXnJCa3uUbOcXoImVh1eOF+1xBVuPjSGY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6448.namprd04.prod.outlook.com (2603:10b6:208:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 23:30:11 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 23:30:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chao Yu <yuchao0@huawei.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "jth@kernel.org" <jth@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
Subject: Re: [PATCH] zonefs: fix to update .i_wr_refcnt correctly in
 zonefs_open_zone()
Thread-Topic: [PATCH] zonefs: fix to update .i_wr_refcnt correctly in
 zonefs_open_zone()
Thread-Index: AQHXGmAzbymjLrf+6Uyg2qboovgmbA==
Date:   Tue, 16 Mar 2021 23:30:10 +0000
Message-ID: <BL0PR04MB65145B310933D52C432DA7BAE76B9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210316123026.115473-1-yuchao0@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d8f9:73e8:b1d8:d796]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7f1867b-3046-41d4-e0f4-08d8e8d3715c
x-ms-traffictypediagnostic: MN2PR04MB6448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6448E4744406DDFE01C7A2DFE76B9@MN2PR04MB6448.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6s8vcMx1zoiLGx00FlaPE+rECRh4qQP4VQjALvnkz7VZE5aS/Doa/mqLMyMUFat9S7HQ6jYCdD4QKmL1yPwBowMuW+eeBFgYf5sKLAuOJwoEa4DxYd5TnMr8PdTjQKl2xiTlG9Xt1viDWVAtdc7dr+7A/YetX9rCXYoNqnxxKENlbdwOaXMzp/OpnNRvg3e92o1gbxehRBFMzuna8yhIbq4vNPby3aVGX8VEziztilSP8mBxRJi7k3oF+Qo0MyOxe6RzbSPAn0cvXadRb/UQYIcxpPRGWr6g6tmo6npruTQM5ZbsX0BqkEy/OVEx1mIdVYeN8INHJXN8FBrYpplrl1JQmseT94EbnFZfz+MjciYx0shCcYR2oDfXfrSMmnPyk2TCLHBj/JVxZmr9WlvEfCIZxsulu1BVeJJXELFlKhJz5p2sjMitHo05sacERf37sBnOEBVCUt9Oox4rqtATd1yr23ObRdPHIhGH7ftqOycNXQiKO2inUjr94NSfmGzSutZhPceHSVyK56hQYY3/hE7y6C592+FJ0y9K4fc5ChFGlYzf//pjogr0/a2C+/J3oBDKJrVqv6anYwmA5pD1cXYIy5DqJZfO+nVhU2NychLq9Yb7qov0YD+3Yz4pm3rE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8936002)(53546011)(316002)(83380400001)(110136005)(186003)(64756008)(66476007)(66446008)(8676002)(66556008)(6506007)(91956017)(478600001)(66946007)(71200400001)(33656002)(55016002)(7696005)(52536014)(2906002)(5660300002)(9686003)(54906003)(86362001)(4326008)(76116006)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Fnh1kzvAaLVFqhDXDJmncge0FYgY0SeyKLZs8P19quKTT4YT5OPaZuHDtUrb?=
 =?us-ascii?Q?o/tGUa/sHVZOzX7WAkLJP6Ye3JdPZtZBzoExbeU2j15CqDQfgCFxJM65o2zf?=
 =?us-ascii?Q?35KoTcHhZEnVcEICvHbwPhzFZZHiSTVEZ9IcXdRmC6UCbFUHA6Vu/D8JbDHs?=
 =?us-ascii?Q?5abQHUmmMNL9yCp2fLOuI6gnEMUiee82VwKbow6E5nlG4//U5ej+cNHX4d95?=
 =?us-ascii?Q?mHvn4z16osBQcM4L3nQKHrQvIJAq6e+1XTfXAtMewCukfjUxYIMYhhSCDYxf?=
 =?us-ascii?Q?bLJMbiMD2myMdZKLIBlGAwgPGGL9W5YgMvpLgiTK2oYGBk8h2c/V6pTuj3Zv?=
 =?us-ascii?Q?V1U0ckz+z9I55ysEHUKnlBmpr3My8lR11G0HWExVFHkaXHKPHKmp2ySgwLmG?=
 =?us-ascii?Q?WwIAsvy/ss9TOv8GuYosCrIjtGHzaDUAZbpPaR/SqID4Ui8wfZK9Pj7QAL4u?=
 =?us-ascii?Q?BhM1RKdz8Q6MHarIbC0eF99cz4RigA2kQMmPJQGflkBnPZKh1efnwskJIH6L?=
 =?us-ascii?Q?1aLROhPUAEDidkJf00HkkmT9tDIdVptt7NivOeDo8DDvtMqg3+p/63AHAmHo?=
 =?us-ascii?Q?HyGcSAcSAaJdtvVQ6Lr/fAuqfowgZMxLvZhGhwdjrA4/yTcyRkLJZRdD7tJl?=
 =?us-ascii?Q?ZyPL/t5R8TaB1YrZNpa27WiU9gY5ER4MahwTcjnZRlK69kLYrD/pS9A1zfWj?=
 =?us-ascii?Q?uUgfu20UllrnXNdvpnDMG5KxXdGSWn9bZXbfRIp2dS32Uv3vuLw4MqmVSV8c?=
 =?us-ascii?Q?F8HnvY2NbQjOb7Ww3RqOQ0NWiZmodOFw82Vdf8HqJ+CP3EFc40mDv56XTAhd?=
 =?us-ascii?Q?HtcXHIbiYcEYf09liQZ/nW0R3DekSmUxhK+p04PjvjT4gqsrdFrJpNoJc5Um?=
 =?us-ascii?Q?4DG/tyXMl/5BdpTZpaVHHuQWdwoO07JzAYJtl6Mf97SMgaHX2yyQfCPCDuo/?=
 =?us-ascii?Q?H2mQUdUQtUBra4i/iczUmzIzaKTDeAlxfqRR7UNYyajHaJ59gwUVzwzP8Br7?=
 =?us-ascii?Q?BVLT6CSaid39VAn+MrR5k3usGcNhfMlho4m8pEKIRByzFjVFiKbRYq/IT2m7?=
 =?us-ascii?Q?2JbrNVwr4zZC7MEcpNIzkuYBaZA5AIimfrAvXhCKP3D96sY2yfauw/mwAbtY?=
 =?us-ascii?Q?kpKK5WkMs/ra/nPXfgzUIYirCHlvA0mQQdHjfDq5/EMzxUer0PuTaLxAlNpE?=
 =?us-ascii?Q?ALlI8NMx5ohES1jAf81eArbnW5MGIjwrhHUNNjad/g+H4JnfFoi+Zq/TArM7?=
 =?us-ascii?Q?70dDlpRkMNrdVay6G0lVpA1unVGU5rXrjPX+93c1/kJVFPONumdXWXX5UZjp?=
 =?us-ascii?Q?ygM1RUpnMYNKvZwpfP5pAmNpZJHtrcV2At5mL7/wzw2D2twIuHQcfxtt2RKi?=
 =?us-ascii?Q?s+KJiwQLmmZbvRIPXf7889ERuBWTJlOWSWqhNdCNd4DpSAc5SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f1867b-3046-41d4-e0f4-08d8e8d3715c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 23:30:10.9416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcotxIYLMegyTqxOBP3FRsrOmkpfIZjvXG9XMjZEjqawK9G6zh2lnWQEh7hrqlzdAx53yRGK9NyUgynSU/IjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6448
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/16 21:30, Chao Yu wrote:=0A=
> In zonefs_open_zone(), if opened zone count is larger than=0A=
> .s_max_open_zones threshold, we missed to recover .i_wr_refcnt,=0A=
> fix this.=0A=
> =0A=
> Fixes: b5c00e975779 ("zonefs: open/close zone on file open/close")=0A=
> Signed-off-by: Chao Yu <yuchao0@huawei.com>=0A=
> ---=0A=
>  fs/zonefs/super.c | 6 +++---=0A=
>  1 file changed, 3 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 0fe76f376dee..be6b99f7de74 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -966,8 +966,7 @@ static int zonefs_open_zone(struct inode *inode)=0A=
>  =0A=
>  	mutex_lock(&zi->i_truncate_mutex);=0A=
>  =0A=
> -	zi->i_wr_refcnt++;=0A=
> -	if (zi->i_wr_refcnt =3D=3D 1) {=0A=
> +	if (zi->i_wr_refcnt =3D=3D 0) {=0A=
=0A=
Nit: if (!zi->i_wr_refcnt) ? I can change that when applying.=0A=
=0A=
>  =0A=
>  		if (atomic_inc_return(&sbi->s_open_zones) > sbi->s_max_open_zones) {=
=0A=
>  			atomic_dec(&sbi->s_open_zones);=0A=
> @@ -978,7 +977,6 @@ static int zonefs_open_zone(struct inode *inode)=0A=
>  		if (i_size_read(inode) < zi->i_max_size) {=0A=
>  			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);=0A=
>  			if (ret) {=0A=
> -				zi->i_wr_refcnt--;=0A=
>  				atomic_dec(&sbi->s_open_zones);=0A=
>  				goto unlock;=0A=
>  			}=0A=
> @@ -986,6 +984,8 @@ static int zonefs_open_zone(struct inode *inode)=0A=
>  		}=0A=
>  	}=0A=
>  =0A=
> +	zi->i_wr_refcnt++;=0A=
> +=0A=
>  unlock:=0A=
>  	mutex_unlock(&zi->i_truncate_mutex);=0A=
>  =0A=
> =0A=
=0A=
Good catch ! Will apply this and check zonefs test suite as this bug went=
=0A=
undetected.=0A=
=0A=
Thanks.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
