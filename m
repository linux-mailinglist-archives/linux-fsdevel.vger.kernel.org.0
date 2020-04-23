Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E791B5611
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgDWHlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:41:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19762 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgDWHlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587627664; x=1619163664;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0/POSmkwr2oHePniK8x5FMw8VXx3cYejE6zS1/IRdm8=;
  b=eCmCf3ECZY2dA6aCFjEBpdp5IyFhE2konlEnlQ0bcDwn+1LYMmeeuZsM
   3rZxV2Ngd4UsXVaJXySMhvC8dYjtc0cPMdvv/qMc1ybgKK0OCiqgc16nE
   Xi93ab5ty5jEzHpUYX9FGJjovbTedFnWJTFkawbitoyvtzjBQ1xffP3qi
   J4x4QimKQdlgTteMszE7jjrtCLKgsSg+mYavyU5szg5WCEPSXNl+9d77k
   Yl8alvK5KdA7ndSiO7aaj156L/JhUWmmCAW1hIcaqRPSmmnk4bYrmYtZZ
   G8WtS+xgbP3kSzrgHP6sKUmjA+FZw9w7lT7ebGdjYJJhwtEK9kda8bMqf
   Q==;
IronPort-SDR: 6yD7o0yDf+bDk7LQ0MgAeNYGgdEbCpOnLnV1mG1HHEnTJ0aqUiCGVwO9wO0a2kpSFB7Q3aw56f
 0hEA+HjzPaaQ44QPSk4+GUkMCwo8u5f91WLRvu+Wsi80OXUVDZD/b257JY6hIAoERhfQbb+CKE
 WgZzcpspMjPt3gkkMd/64k2USiSJKrOGXkvmBx09XDxDKPiaJs9v2jCWUi3F43D/0UORp3pfVB
 LZ5t73q3rNAXbv7noZRf8aBxLuUyzXGPPhkmFSWBZ4jegimiLlybd4zhe4u3lRHXgoPFs+MCjz
 fbM=
X-IronPort-AV: E=Sophos;i="5.73,306,1583164800"; 
   d="scan'208";a="136261975"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 15:41:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYNoQoNhAc661BSoXh0KMib653uCP1X/dj1hFBOL64UlEz2CkAZ1fCC8+Jxjkb1Sgua9bI9Gso+PJoJdO6Zaf4zJvawuimtVQQGwXkGM7/6vtkzIgfDbBAPhV6yQLccYOYqak0yzxtnf34VCemOAPnuyBHpvp2Hbz/S9HzohwajMEDW7HV7ijku7jkeoftDi9u0Q+o/VjpE8uDXyUy9/vQCPYPCkS5FEuZNh7Spp7AxNrjxOjnTGVwR4lCMScfj6HvDiFNqQi2vyW0R5Awp8Vm6yWBflhPb58cy6RWXgsBzouTs7npWOgCJLuHNclWZJLsGrmbIjwo6uOdQi7QP54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AOcDA8Y/zPRjhgsa5GexEZnArT1QaWtZlVNJyQiFls=;
 b=aQqheUvYdY2+IlWkOTi5lePA7m3VCmVQqyCbFx0WmGtcJx288533iYiAh6J32C9BETdvF68xQlIH6AUuWZWw/XlFaprWf2JsJFMK8xO8B9k7DDdgAPSp/66aWyNS6NOM47+Na3l0WrmxCleGKM5q3WYVLI/JbayyS7aH2KtGtwBjZmHUEKbZa5ZtetqOTwcm5/zvWVmOWZqO6oejj5ETkQWgF8RWxikxLH9UZY74IrN4A0d/Cg29bK2hvtXqgNYLvrN8O+uQ8jXcUDkTd7A5LUaKRPMsG23hfJ7QMzPs2KSPBeAcz/lHhcpcISH4Bx09J3tkQczb3dQZ5HuU82EI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AOcDA8Y/zPRjhgsa5GexEZnArT1QaWtZlVNJyQiFls=;
 b=AOXLn4t81EPO6jMcJvXZhwrezg8e5iMlgdiD9fcFRkLxdAdSsVIYgQjaabJPWOnXfJNXDywmjT4RrmshjJ0oMXtSCb1vrf/KMM2r21zw1QevbOXA+WtmAjlY4Yk1uG5BA9v2wWC5DReppRLJwB6bNR+xQChgNPgXOCCpESSPUgo=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7076.namprd04.prod.outlook.com (2603:10b6:a03:222::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 07:41:02 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:41:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] ide-cd: rename cdrom_read_tocentry
Thread-Topic: [PATCH 2/7] ide-cd: rename cdrom_read_tocentry
Thread-Index: AQHWGT798MX6FeAfwkaUCw/6MK5hLg==
Date:   Thu, 23 Apr 2020 07:41:02 +0000
Message-ID: <BY5PR04MB6900BB75766839E435B5B472E7D30@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: adcd9026-56e1-4081-da2c-08d7e759ac8a
x-ms-traffictypediagnostic: BY5PR04MB7076:
x-microsoft-antispam-prvs: <BY5PR04MB7076E793264C657A79FB3C86E7D30@BY5PR04MB7076.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(52536014)(8936002)(66476007)(33656002)(7416002)(5660300002)(81156014)(86362001)(316002)(64756008)(66556008)(186003)(66446008)(8676002)(110136005)(66946007)(26005)(4326008)(76116006)(9686003)(54906003)(6506007)(55016002)(53546011)(2906002)(7696005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Tpt/vmBwyiG7VQNbuGE5wIGajeBzdPPQ6cM7bg0P9AA559hAUd/VEvzBu4FcsxV+O//q1WDoTBRS0XDK7Bx0XovxuybxIyLMoWd9bqBm95VVk3qGN2WcwzNV+/VoI/GSDicHGl0GbwHaU7M124bAl9t+rLuPsI4OOS3h6OsMNPYAuJh9x+wXHoZnOSwbyIZc76vf7IDhEXjR7RSlt6EYhMQ6HUZDSAyLdJKZIkeAEgDjZjV41HboSkfZJ8MIxMPWs4mzNk8QR12NcmuFoj2en062vY3Vno0zfxeA+oVjB4RSiobAsQO42aQKkfccsWIj7vMDJh2r9rA8Rs+p6NEpPaBjJAuVMowHzV03aL2x3uphibOUBejvMFFfrmdoPmRk/X6u4aJksU9wfbooCCGMQmpCDaMuPipmV0TtSPso3C95INw+nSJqDG1EaeiVvVj
x-ms-exchange-antispam-messagedata: Lb/dUtv5wdiRRN0o7yk+jafDh9KVMSGoiLAKWsoj69fy+XYgyFLMJ/38brBNXx0ysuLVSzG0qNpZnxm0kb6Vwn1060FamJLz//R1bOPMBDwh048LShhdTfeHaxUTzhD6XspWCmWel5L+uuxpKobNig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcd9026-56e1-4081-da2c-08d7e759ac8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:41:02.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guvGmuu9Fkv1PbbZFbTqvWSgODOKSiUbAbAa950MMSC/c0+2RA5g06810Kzqup1pIWKYl8rMhg2b9sYGWGkzcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7076
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/23 16:15, Christoph Hellwig wrote:=0A=
> Give the cdrom_read_tocentry function and ide_ prefix to not conflict=0A=
> with the soon to be added generic function.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  drivers/ide/ide-cd.c | 14 +++++++-------=0A=
>  1 file changed, 7 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c=0A=
> index 40e124eb918a..7f17f8303988 100644=0A=
> --- a/drivers/ide/ide-cd.c=0A=
> +++ b/drivers/ide/ide-cd.c=0A=
> @@ -1034,8 +1034,8 @@ static int cdrom_read_capacity(ide_drive_t *drive, =
unsigned long *capacity,=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> -static int cdrom_read_tocentry(ide_drive_t *drive, int trackno, int msf_=
flag,=0A=
> -				int format, char *buf, int buflen)=0A=
> +static int ide_cdrom_read_tocentry(ide_drive_t *drive, int trackno,=0A=
> +		int msf_flag, int format, char *buf, int buflen)=0A=
>  {=0A=
>  	unsigned char cmd[BLK_MAX_CDB];=0A=
>  =0A=
> @@ -1104,7 +1104,7 @@ int ide_cd_read_toc(ide_drive_t *drive)=0A=
>  				     sectors_per_frame << SECTOR_SHIFT);=0A=
>  =0A=
>  	/* first read just the header, so we know how long the TOC is */=0A=
> -	stat =3D cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,=0A=
> +	stat =3D ide_cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,=0A=
>  				    sizeof(struct atapi_toc_header));=0A=
>  	if (stat)=0A=
>  		return stat;=0A=
> @@ -1121,7 +1121,7 @@ int ide_cd_read_toc(ide_drive_t *drive)=0A=
>  		ntracks =3D MAX_TRACKS;=0A=
>  =0A=
>  	/* now read the whole schmeer */=0A=
> -	stat =3D cdrom_read_tocentry(drive, toc->hdr.first_track, 1, 0,=0A=
> +	stat =3D ide_cdrom_read_tocentry(drive, toc->hdr.first_track, 1, 0,=0A=
>  				  (char *)&toc->hdr,=0A=
>  				   sizeof(struct atapi_toc_header) +=0A=
>  				   (ntracks + 1) *=0A=
> @@ -1141,7 +1141,7 @@ int ide_cd_read_toc(ide_drive_t *drive)=0A=
>  		 * Heiko Ei=DFfeldt.=0A=
>  		 */=0A=
>  		ntracks =3D 0;=0A=
> -		stat =3D cdrom_read_tocentry(drive, CDROM_LEADOUT, 1, 0,=0A=
> +		stat =3D ide_cdrom_read_tocentry(drive, CDROM_LEADOUT, 1, 0,=0A=
>  					   (char *)&toc->hdr,=0A=
>  					   sizeof(struct atapi_toc_header) +=0A=
>  					   (ntracks + 1) *=0A=
> @@ -1181,7 +1181,7 @@ int ide_cd_read_toc(ide_drive_t *drive)=0A=
>  =0A=
>  	if (toc->hdr.first_track !=3D CDROM_LEADOUT) {=0A=
>  		/* read the multisession information */=0A=
> -		stat =3D cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,=0A=
> +		stat =3D ide_cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,=0A=
>  					   sizeof(ms_tmp));=0A=
>  		if (stat)=0A=
>  			return stat;=0A=
> @@ -1195,7 +1195,7 @@ int ide_cd_read_toc(ide_drive_t *drive)=0A=
>  =0A=
>  	if (drive->atapi_flags & IDE_AFLAG_TOCADDR_AS_BCD) {=0A=
>  		/* re-read multisession information using MSF format */=0A=
> -		stat =3D cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,=0A=
> +		stat =3D ide_cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,=0A=
>  					   sizeof(ms_tmp));=0A=
>  		if (stat)=0A=
>  			return stat;=0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
