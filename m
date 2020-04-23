Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2D1B561B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgDWHlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:41:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60208 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgDWHlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587627680; x=1619163680;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mufLU23stVOiOHq+VHBnnyA/Ezqdo9vTOQHF7wrV5Fg=;
  b=JdfjsW7FpyB+uhVPXS/YgmU7zI+TOosDMwqkoA9pw1oC854NPCN5xcJo
   M2+xh7/K/bDuXV8lMHlLT4ocDHeuDiUjpgkS2GWWPduZ3SYdstFnsxbhb
   ZrKjQlYzffgLuJ3knlt2xuCF9PEJN46u1nHTO3bnzTAkKSvH+vIQdZ0JS
   UAnvzRE1O8t0Z1VBCP7g6pQK4oxqWgciye2I9F+ImkH6jqSYZlLICSH4C
   5J47OW3mrk5Rbr+MQ2xfuWCaveAXLrpb1Uazlgat3k059VeU7jsVqy2i4
   9yOHElQMyLm/HeymgZ82yah04V7zmxPvqkxWn7Y8jDAenC5Ep7FHlqWfC
   w==;
IronPort-SDR: ebBvlPJaLlcsdlK9ei/sHdl0Sw4hCftLzwzYPLnG9cfvYlmqHdf6LrShJUrbua5Vjnezmb0Q7a
 jw5p+94HLlwjFTquVMZ7kVsuulnvtd1mY36BNGvolY/wIINiwciKjKNPuODhcYiuuR4cIZRNvV
 bWuTCkfX3GULveSubKUfM4Ac0/NDjj0K8jzmZh3uxNShpaNQ8aP8GR8vPxNFvouRqHupeNYqNp
 cjgoiJh+cuVPTuHjEQELQD5y0wvqT+5MEozCrcNZ8cbYQT157KC4+/vWo2IKtkM3yID5LyXrOo
 KMM=
X-IronPort-AV: E=Sophos;i="5.73,306,1583164800"; 
   d="scan'208";a="244686277"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 15:41:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR0eMaYcScHB4NEjywRM5Uo3a5IyKMV+kdG00QYOAJKM3VIfiyHSrr5R7ylZ3bg3/q9iLWtghnecVjekyOP492S+3TywedlISGTEsXgTMXta1UVZgAdzoB00QXpK9y5LbCPgCeU3Y1+fRuA0qwsA0iyD4M/OM00BWri6yd/xCk7FpKecIODJ2P1hp71FfUDJCaHoRgx8ODxikao9VoeoPdM1j6Ed8NyqO/u6/qaMYWdKW32mQfGqe/IV95CKQe8+Ls/w63nuZBSNoLqXs7o/FJZ2n8WDsC8HDBWdHuvZAzE+SwvYNSNJkvJxf+6IitBPVGN8Szw8vHWTGzGlHP5P/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gvKykOMpPqOSrhFmQw5nmH5JMyQcSK1YoxMOfvA8rg=;
 b=PsYXkrNuWHdr/2cH130x4OOZKsKOM2UXfJGq89dP2Jg08D7Ji8T8dTWBuZZRWxydyPkH4MkiqMpeXarOJpRln30ro8FkC3OdWY6ZPrUQHr7M/OonqdD7G8atRgOE/PkXQ965vW0MGgQ4Iz00OfAxlR6+PtPkkrSPHj8oi9J+Z9ark60tgK71TyPnvMM2mOziu2JawlB+UC0eOoK57PB5umYL4BKf9SQKPUbF9HaLpto6ypi5WUA2mrIUNW/MM7YE5HnECRCTKssfLXc9/VFXvliZRneJynjzqn3VSgVtTBGyoLXrrbbPPoOu19t/ukR1daABnepsEX/xbIRjIj/4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gvKykOMpPqOSrhFmQw5nmH5JMyQcSK1YoxMOfvA8rg=;
 b=QO/t1mXJ69d0UEdfW2VMLZXVmacEJklwK/4SopUAAa3nmS3Id6QY4RWQA326fTE4BdjX0fBg70JsM+aUAJLEfbdtae5jZOztJP1PfZ0BYF2kvoHALiG1PosIph0nnv0pYbBvmPdFq2QMThf1TTBy3u7Ab14xg0t+b4LlwPpF7S4=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7076.namprd04.prod.outlook.com (2603:10b6:a03:222::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 07:41:18 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:41:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] cdrom: factor out a cdrom_read_tocentry helper
Thread-Topic: [PATCH 3/7] cdrom: factor out a cdrom_read_tocentry helper
Thread-Index: AQHWGT77oq3lF2gDFEqy0zN3qm+k1A==
Date:   Thu, 23 Apr 2020 07:41:18 +0000
Message-ID: <BY5PR04MB6900ABB062D1941B97EA8F3EE7D30@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb2bb0a2-045e-4afb-a4a7-08d7e759b5f0
x-ms-traffictypediagnostic: BY5PR04MB7076:
x-microsoft-antispam-prvs: <BY5PR04MB70768401A281031EEC9FD914E7D30@BY5PR04MB7076.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(52536014)(8936002)(66476007)(33656002)(7416002)(5660300002)(81156014)(86362001)(316002)(64756008)(66556008)(186003)(66446008)(8676002)(110136005)(66946007)(26005)(4326008)(76116006)(9686003)(54906003)(6506007)(55016002)(53546011)(2906002)(7696005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FNbQYspY/fdrQ/R+oVICW9kZ5LGQEvQaPmsXiIK1qvooFzmwSFwexnLe6ykCL5Y//qXj8uLHXSd26ZB+psgquZr2F388JoBMauB7F/GX7+V0VYT0i1CsEsTfw+DRi/yYzUlNXwWccg3zbBuzFBAfTlBsAhLuucmVkeEglsXeKHemPK0YMSsYyjg9OPA4r4aFl+k3iWrqPTtmqdamZ0HEpI0/pZw19rsn46Y3WfNq56U4aIjluduFR6C7H8ftycfgwTsd9ybx/3aUzFFLGAEBg3y0dsib94fBqvFTdYdZsI/+BpI2AMLOIitH7vZ+BUz4jyk9Ef3Jm31+PHcmJPze3n+N0QJFWA06BLj5M8z1aiXKJkahOQ4KELtzvq4CiPrU/ueOiOv0Ejg99EYExXjw7qdeeKUipyr7THub32pGaQ26QzM/Gu9ryEPO63GISmYj
x-ms-exchange-antispam-messagedata: 4uhxaEzfXAuy3wMB25t1K3Y80WLB60PALddCMIkB3eVPh6iVyXzTCqXD4EuI8uHKfGY7jWjIIBkBU2fHpBkpxOgrfI/hNDcrZdDbnY9U00h13PhXlG92qfkH4JIZmAeecvmJDShBW7G5kTniu/WTiA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2bb0a2-045e-4afb-a4a7-08d7e759b5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:41:18.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebzzItZs6cvcHSZUMUvEMwbdSz6k9dOk7UcZ4/wMK3UG/I0cBL3Y2qrjSChUcO2CVGvqdFYYg4d2M/5W/FON7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7076
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/23 16:15, Christoph Hellwig wrote:=0A=
> Factor out a version of the CDROMREADTOCENTRY ioctl handler that can=0A=
> be called directly from kernel space.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  drivers/cdrom/cdrom.c | 39 ++++++++++++++++++++++-----------------=0A=
>  include/linux/cdrom.h |  3 +++=0A=
>  2 files changed, 25 insertions(+), 17 deletions(-)=0A=
> =0A=
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c=0A=
> index a1d2112fd283..c91d1e138214 100644=0A=
> --- a/drivers/cdrom/cdrom.c=0A=
> +++ b/drivers/cdrom/cdrom.c=0A=
> @@ -2666,32 +2666,37 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_d=
evice_info *cdi,=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +int cdrom_read_tocentry(struct cdrom_device_info *cdi,=0A=
> +		struct cdrom_tocentry *entry)=0A=
> +{=0A=
> +	u8 requested_format =3D entry->cdte_format;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (requested_format !=3D CDROM_MSF && requested_format !=3D CDROM_LBA)=
=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	/* make interface to low-level uniform */=0A=
> +	entry->cdte_format =3D CDROM_MSF;=0A=
> +	ret =3D cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, entry);=0A=
> +	if (!ret)=0A=
> +		sanitize_format(&entry->cdte_addr, &entry->cdte_format,=0A=
> +				requested_format);=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(cdrom_read_tocentry);=0A=
> +=0A=
>  static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,=0A=
>  		void __user *argp)=0A=
>  {=0A=
>  	struct cdrom_tocentry entry;=0A=
> -	u8 requested_format;=0A=
>  	int ret;=0A=
>  =0A=
> -	/* cd_dbg(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */=0A=
> -=0A=
>  	if (copy_from_user(&entry, argp, sizeof(entry)))=0A=
>  		return -EFAULT;=0A=
> -=0A=
> -	requested_format =3D entry.cdte_format;=0A=
> -	if (requested_format !=3D CDROM_MSF && requested_format !=3D CDROM_LBA)=
=0A=
> -		return -EINVAL;=0A=
> -	/* make interface to low-level uniform */=0A=
> -	entry.cdte_format =3D CDROM_MSF;=0A=
> -	ret =3D cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &entry);=0A=
> -	if (ret)=0A=
> -		return ret;=0A=
> -	sanitize_format(&entry.cdte_addr, &entry.cdte_format, requested_format)=
;=0A=
> -=0A=
> -	if (copy_to_user(argp, &entry, sizeof(entry)))=0A=
> +	ret =3D cdrom_read_tocentry(cdi, &entry);=0A=
> +	if (!ret && copy_to_user(argp, &entry, sizeof(entry)))=0A=
>  		return -EFAULT;=0A=
> -	/* cd_dbg(CD_DO_IOCTL, "CDROMREADTOCENTRY successful\n"); */=0A=
> -	return 0;=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  static int cdrom_ioctl_play_msf(struct cdrom_device_info *cdi,=0A=
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h=0A=
> index 4f74ce050253..008c4d79fa33 100644=0A=
> --- a/include/linux/cdrom.h=0A=
> +++ b/include/linux/cdrom.h=0A=
> @@ -94,6 +94,9 @@ struct cdrom_device_ops {=0A=
>  			       struct packet_command *);=0A=
>  };=0A=
>  =0A=
> +int cdrom_read_tocentry(struct cdrom_device_info *cdi,=0A=
> +		struct cdrom_tocentry *entry);=0A=
> +=0A=
>  /* the general block_device operations structure: */=0A=
>  extern int cdrom_open(struct cdrom_device_info *cdi, struct block_device=
 *bdev,=0A=
>  			fmode_t mode);=0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
