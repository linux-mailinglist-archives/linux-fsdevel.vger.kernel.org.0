Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4231E328
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 00:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhBQXnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 18:43:02 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40259 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhBQXnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613605378; x=1645141378;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3XMlQLb1n4R6svEj1KoGWB5v0OfZhZ5X/s6Yxw9C3HY=;
  b=npnq3ABNxGVFRL1MObVBLVgkFBl+aVmVAuIqQ/l5Y+qhRerDBw2uUlPp
   abIMczVcVYxQ531U63IImRHWMFQ3RPAh/sBJArg4qak66++BV+VCkkBdP
   IH4xjI5GEnTWpciWuqlKkpn9WxdAUAk9IZgRlMhjxDZw561UJlKOZ3COh
   gWp6AoT84uYeCA8ZKKoYaQoqBh4yAeyOCR71q8djUQCmJmlpAQ18wVbXI
   W22y1SoSJTfTSk4EyfmVV522splr6GWCG+Y1RSaYe/Inf2h45kIqCh3hj
   oaBl8QZPPrsQA0tZb4vALxjlJok5o/n1gxNPTBSNC1Bhb6xnq0r7swfCw
   A==;
IronPort-SDR: ErBHwXlYyFFcBH66ywsCr9plYJaZ5xFx2rKUT9aarPGuSPJ6LDLmv+xvur8XEpJiMxGCDo4AZp
 3tLIpwG0gddwztmOMWhewk+PIGIX0gV2gjriTGGi1S+23DI+U6BU+YYQyA//btPWlMq0ATxSPF
 WM7IBBoI5TtWfBWSEIHXjL5Upa5acBcowuDbfi6fhMQp2g/rO+a/uFqIuKrSjlL49sE4IC9dOn
 PfTQ0wH1dlRqAaqSIR9lA+Zqkh2Jz+KBkTR0F07dpZd5bKhthd8MIkPRSg1iisd7/nZyTMI7oc
 vm4=
X-IronPort-AV: E=Sophos;i="5.81,185,1610380800"; 
   d="scan'208";a="164697054"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 07:41:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEdiM6Br/aYYZyy+LwLCmlxqpmNrBi3uxxlVsCH0q5+gUj9qLh3+lqRxAPErSjnxQqrWrG7Ve1oyFjyXtTsklMYVyl/0kN+Y+2oQGdbGxSeMK3Hb/Bcl9sdkvfxfeDQa/Jup+j2SRjgaRcOSIVzwyMeVT40/XHek8EOCXiQvsWO/4Lb0m7Crd4vPJTWAVTRfTOJoTN1kp2H3NQ7jUM9yKIM7zvfgA6LZG8C4fALx3FavNgzsvJFFVvyGSyCndjTJw3P4/790av4g+Q3B4Lsh5j3XsRvsZcirZFPLMUh6QWVCQLxFSvpEF3Hg8sObIbfEn3j1GlVN4M6B1R9VmkTOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0uqRBsTAEANO3j4Iwdn/mkokT9q8lgMnIB1NUtwpaE=;
 b=SLOHbhsXwDKhlNtPVKPp33IM/GmDJoxO16izKvTUqjmTd65gAUucUt1mc7XkKJ86NI5bMKxpBdA+qQp/ooCvP9KQQJmDwIeaofhkZBx5tJzokklk8MfVHgpdYx2hud4+zMuOMcvIgksV4onaX0hWFU8raNvrLXtoz1hnocD9yN9A9cmOrrjPMM1RWJkGYMjbP28oyVjqRLbM3INL+gWIGjz1rPuA3mtd0/jGXbPTwyypS/fQmaflTYfrxittWUjTWyvMdtbCUfUhvtRqOKxEH0U7f2EFScBqBWUsnkFfGz61KIBYXyFt7e75VAemrR0w6yG1GSs+G/niTqDiCo8EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0uqRBsTAEANO3j4Iwdn/mkokT9q8lgMnIB1NUtwpaE=;
 b=IrOGLPCmdUUW2ulWWRPKp9k9vIbTsvnRSH61i9693vtar/lFPrHoErKe0IjN1Awhev28AMxXu3fWrUpuubN3dyN48ZL6Y+Ns6fOyvaMKOC14ha/vdhQ6q/nvvWdlxpqViL+hk0vGqdmXthvBis3DhLwfPmlMk2C/MVBA9h2vUVU=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4529.namprd04.prod.outlook.com (2603:10b6:208:4b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Wed, 17 Feb
 2021 23:41:52 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 23:41:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: Fix file size of zones in full condition
Thread-Topic: [PATCH] zonefs: Fix file size of zones in full condition
Thread-Index: AQHXBRNqti8uzp8DsUKKhMSCYZZgEQ==
Date:   Wed, 17 Feb 2021 23:41:52 +0000
Message-ID: <BL0PR04MB651446594B654329EE392477E7869@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210217095811.2517221-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:75c0:49b:2210:beaf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5355e759-b1f1-4dbc-19c5-08d8d39d9a4c
x-ms-traffictypediagnostic: BL0PR04MB4529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4529DAE94C76DF31D30FE8D0E7869@BL0PR04MB4529.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1UFeU3oewxujZ2RSPU78OkN0d7T2ufgKwuXFDJRjR93mvgkVX3tT8YxkMowmv7kKvjeYjn9AF7qIhBL2Ll9fUQV2BkynzJiey5YxMkFJvf3QjCjITDXtp3pw4vqRKU6Ih8RH4CZZsQGVVyMLpl3wTO4iEVV8W+vAjbAtvMbVFqW0rWO1n2Ry2jpWDc2sqUoZXDHyECxH3oY0ps7TAKCoKci6FOVUse6q/XeHnhsfjF6M/qW7x3XiiWRxjCvJHTP1uNKNoM7wdedL1P97Cin84genMzpcbSueC5DQiN6E06vtSaOUyCGQwmDEsMzwm/p8HYxoDTLPyXwJMKksrdn4f+CcOh7soKkF1iV5c3bPDmcyQChb3To7h6a3yGZXLf0EkM+d3/UhWHSCp5qJySbId4mq94ahzmtNnWkIl/2VOgbiGEEHKAyxwZS4FRYnEdfRhEbZYc2q79rli0b3GJzgW4L9scrb0IR3/XmXhjIMBSLYS2Vw5LZdjo+79OHS2KCIZIXmc19p/OZYAjLvJNbyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(2906002)(52536014)(316002)(33656002)(66556008)(64756008)(54906003)(71200400001)(8936002)(186003)(4326008)(66476007)(66946007)(478600001)(66446008)(6862004)(91956017)(86362001)(7696005)(8676002)(6636002)(83380400001)(5660300002)(6506007)(76116006)(55016002)(9686003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dZtRkXBzjPHAwbt2Dru75e6e7VUUi3w16iiwGuFQl3L3LFO6SIfILKt4gr2L?=
 =?us-ascii?Q?pHrbIP96xSgp43ns3ZemQWbwS8CJUu+k38bdPA1cNmspEItCq2WFaiARFvW0?=
 =?us-ascii?Q?sPKd3Z2MLZC6UWdknTDzAv8ch9GGdxBKzPIDSg7rhFKW352jsa11NkcIT4GL?=
 =?us-ascii?Q?Ho0FVvbm6St1FmutSkMP1uHOquGAK3zBV92cupHjCsG/ZMg5HMgPqEoPKkEp?=
 =?us-ascii?Q?L8X0ZrM5uc+BuEFL4fUN2LnHrzgF0hmRVY4OOBOcz/ypGOj38Awu8jrlMvcM?=
 =?us-ascii?Q?yoxgLTF24XEdkeJzZgYZC32aTF73jpAc3PjUD7O81Hs8s9D8fSGxkjQGyzM7?=
 =?us-ascii?Q?M26Co0pv7ZN+5+QtY01iZWK+TvZuR9I+3/sjkExXJ2pEE+kqmMGah9Xey2Ui?=
 =?us-ascii?Q?Nb34LIcb+LccTGqUwZ6tpES8on6f02pQk/4gbmLDXS4z2nfCe9CfpiC2Nd2C?=
 =?us-ascii?Q?rENk9PRTXVH9XcCYvhrkUmFOfPJBbKSd47L8XFTHeU2xGqUutc2Z5axF5bNu?=
 =?us-ascii?Q?0nzsKQenXd5ZBnQxcNH8KLaramqFWof+u2qONK73uFdQ75Oie5COX9Yd9qgZ?=
 =?us-ascii?Q?TzDSgD4pWQlgKCqVB7FIN0ecXaiDpRItDDDYhGYj1Ap/vo3YYpZuxwT1sBtk?=
 =?us-ascii?Q?UHBIs0yIt8bizjp5GDjuRMOkQXgtMT7FCB2pKgYuZ8l+XNcZ+7rFHYhbm4KS?=
 =?us-ascii?Q?yqYoQFAJmcxJg/FOb080GaKx4tl+p26RXHTIS0Q8SPCkUry2qtjNvnkXrCra?=
 =?us-ascii?Q?ZUM8veQf1k3RTEFPz5H5FRqrg40TagoV8YxUnCSilev8wtmEfRQE8vvCnu4y?=
 =?us-ascii?Q?dh4PfTvXc1yxxpOpx/YBqt6DNGnrrrcYZGtlZd84SLA2bGT+7Cy1YYxRA1GD?=
 =?us-ascii?Q?d064sQiEBiXHpz35iIIarbmB3BTSNqGMUPbi8X+PR0RYW2SoR8AJzo4afwAw?=
 =?us-ascii?Q?YUj5eJxzxWZKdGPQI4CHOuDgiEx5c7zGAFEwPnRn20i5ZxAyL0wev4Jgtp7N?=
 =?us-ascii?Q?K37v+2dAWggkcfmZH3XoJjcMk0hPKmnkB08+57J4LOPwolvACPfYltrdwrp/?=
 =?us-ascii?Q?kykz9wE8llflNWq0yLf1MH3Xx0pjkd1I/ubiBRBmlf+bslhaCvOCj0xlxMXv?=
 =?us-ascii?Q?hFViSfvCcBscld+ouaaHaPMBcEeyhPfinXEZm20Qmtc5LyWF6totIYcaY4+k?=
 =?us-ascii?Q?lvV4Cmk/uEDlBwMS+z7duj5Q0wqENlQLk2Entp50wQv4ktb1r8w5W3hH52hB?=
 =?us-ascii?Q?iLB7eKWZX3lVYkwjKWuTPqLvE3vZQmL9yyByAHqJsMaqKDSp1/KmLGx2dogI?=
 =?us-ascii?Q?6se3DKHx1W7H0hBRK9d+WAdo+31bglmYMWw5MzHCbPE33BkRgp0o2/Tepn43?=
 =?us-ascii?Q?fpriabjZidMc/1YZGNbPl+P4159kQsPZYLrnddfMXTzHx0c0pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5355e759-b1f1-4dbc-19c5-08d8d39d9a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 23:41:52.3814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBAWkhOsU5GQPsNuK/ltgI+qah5YHpk0ZBhfdXpGb5fV/gyYCrTnj7rMg9aKL+2D/aPUAYz6a2xhtXW5lh1J3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4529
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/17 18:58, Shin'ichiro Kawasaki wrote:=0A=
> Per ZBC/ZAC/ZNS specifications, write pointers may not have valid values=
=0A=
> when zones are in full condition. However, when zonefs mounts a zoned=0A=
> block device, zonefs refers write pointers to set file size even when=0A=
> the zones are in full condition. This results in wrong file size. To fix=
=0A=
> this, refer maximum file size in place of write pointers for zones in=0A=
> full condition.=0A=
> =0A=
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
> Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")=0A=
> Cc: <stable@vger.kernel.org> # 5.6+=0A=
> ---=0A=
>  fs/zonefs/super.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index bec47f2d074b..3fe933b1010c 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -250,6 +250,9 @@ static loff_t zonefs_check_zone_condition(struct inod=
e *inode,=0A=
>  		}=0A=
>  		inode->i_mode &=3D ~0222;=0A=
>  		return i_size_read(inode);=0A=
> +	case BLK_ZONE_COND_FULL:=0A=
> +		/* The write pointer of full zones is invalid. */=0A=
> +		return zi->i_max_size;=0A=
>  	default:=0A=
>  		if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)=0A=
>  			return zi->i_max_size;=0A=
> =0A=
=0A=
Applied to for-5.12. Thanks !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
