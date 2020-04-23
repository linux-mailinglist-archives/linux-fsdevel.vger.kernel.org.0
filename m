Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95271B562F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDWHlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:41:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63598 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgDWHln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587627704; x=1619163704;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4raPVwu4P+GG5bj7qpM1TvIZ532ld1U2BWFJgpbwCpI=;
  b=JkQNIhdoq7+VpuB5eFhmxaDmPeqi87Dy1E5FRL56nfxvvKrvJ5nnJhb0
   W2Jp1c1MHPWgf3XMcMr9WkNtqloItTBErcT4vkNfDeW3IUt/8GaBVZ1fU
   OZXXBTR11YbMWCbPZrwcBheDlOsAsuZIqGKE7rVckOPthNl9rilUg9QUx
   I6OlNdHbbepmHzCaGdStLI78dXFfNEyxRRIX/GDqP3Hn7HIzPWQpMiP3u
   FzephA3+Yan/u5TmjGAgtLqpwWKa6p4HDE6uOXVPbsJ+a4AtCJj17QQe0
   Uiq7EzfWT1C14O0sxczE7Z23CUneLHUQn3ELAxxGRmnAH1VGT1qU2LRJN
   A==;
IronPort-SDR: A8ehlZK8A8lbQwhlK9PrIjnYLIvG8wfWK6etsMDz/fgFYGUbikLg2E7xbthIpBNjgwCFTe4Qfv
 KyguUvsWhmBk/Gfqp+CT4X7Qy+1DyRQt+zaTmq/igR86OIJLGzt1CDInCp8YqvppmKdQEYW/yA
 fX/bcalmdN0z0xOZA6cVUCmTQFaMItISqCR2YclqrOcwzAmkhinB8q7quwBdE0RQJ4TSxSa5B3
 VfyKlJRflqujq6Qaq5Oo0WZYPdrkCBNj9eHDqgwj/HLe6yE9k8WKua98t/xgDqdwhko9pG63zB
 SM4=
X-IronPort-AV: E=Sophos;i="5.73,306,1583164800"; 
   d="scan'208";a="140308182"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 15:41:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpiA8DwxdijhEm0D9lBWwAqMTPCVmT2Q0mgCcxYyR1lSRnXSzs3Wf8bKRKxU8kDnxUCB0jPz9+INlhTSckebJBn2bCzaSoQUsuF3XNVSXD04A+E8sWJk1Wu9EgqJl82vKhmxG18FOaN06ApzsKkGldHWc5gD2gVBEUxJWJ30M1CNEvj2ZPUEVM4uxXS0flGYLlNWmVBPGpQnfO6Vn9/81xus8nUv07mBG051/egdREPFLweTy4WHI2I2fQqOl2I9pv++E/qp6f/myroDKaLivmjzKNKK/Rd86JGlww9JK6qeSAPTjcjHHVeKGwLyoAq3QYxN2cVMhbdt3z8zB0Xb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhhxaXjNRAgmAbOW/v1XaHu2mO6dFUz3exhh2puBDKI=;
 b=SL2BgNzHLPjSK8tcxoy5rwoKpIzjAq1LfutXdm7mVI/+7PiOfToh951jZP7Itj1GJY93u5l4MFiBMknZ5lwsXZiHdqxO59BnGhJf8VCer6bX6hOXtbyQJjEQL6b/mhGR0nYZrzi7/RxQo6FRgaKQ4ckgVxeYwtxYXPgiGa5mrZLQI089duHY0+rA+fgyV6GajubN0kU65Yxs3cRY0UgsR37redOEeyyC/oP4z9egp9sQM0HzNoUI4Ij3b3o4Ka/esUi3QCi1ARO+ESw+4uhB3rfrpJQv3saHBwZT9A8g1N0KM1jyVMNJ45RVJ7B/YYEGHMzJ73OHW6TiLrTUfvN/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhhxaXjNRAgmAbOW/v1XaHu2mO6dFUz3exhh2puBDKI=;
 b=Ry2iLaynv1a0LcqolTFIxjdE9E5YDfOwc0ONnFqdtkuKW3No3+RLO7Bt1XILG5fQLwu0xQikL24Emj9EuSZOprMm5AtrNK0uK5e4GpgIdQ6LSS4U3KhRPadX/Q0GEM9o0Lpr+rooE+BdsndCAbFmvmghyBQvdUHUfjHtydrSHvs=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6723.namprd04.prod.outlook.com (2603:10b6:a03:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:41:39 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:41:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] cdrom: factor out a cdrom_multisession helper
Thread-Topic: [PATCH 4/7] cdrom: factor out a cdrom_multisession helper
Thread-Index: AQHWGT8IY44ShEkk+0u8Wg6MTkUiVQ==
Date:   Thu, 23 Apr 2020 07:41:39 +0000
Message-ID: <BY5PR04MB6900C398609A0F6453134767E7D30@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83d35e9f-e524-45e6-8bc3-08d7e759c29e
x-ms-traffictypediagnostic: BY5PR04MB6723:
x-microsoft-antispam-prvs: <BY5PR04MB6723039E28A1D13076A91DEDE7D30@BY5PR04MB6723.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(7416002)(4326008)(33656002)(2906002)(5660300002)(86362001)(7696005)(64756008)(66556008)(316002)(66476007)(66446008)(52536014)(66946007)(186003)(478600001)(76116006)(6506007)(54906003)(55016002)(110136005)(53546011)(26005)(81156014)(71200400001)(9686003)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hp9G9VEGOCFAXOCCSW2n4MerjPaFeXu8rhoDLWGB965AxSqcDQKsEZzkFvebtxR3+0N1Gvcano6oAAUGHCo3TT6K+YhViv1mTITH+iwPlnEEcfpJDPqk+XyM4yMOIjW1BXbUQJnFRTlad/SZAMWVuZ3PgG6/Q0MCCE6//jvpn8wBfkmGSEWSH8XFSw9vfzZaCQ5OnnuZA0s9lsOHpUU+ZbxHvIaNCZws7/+RcL+ZcUTF++fjcabfE4Sj8AFZoY27KKGvB8fAeevJ70i8mpw9flkFbwaX+6vQPtxo8kDV4IdLrJxiEf1AE7rO4rn/uvY9AsUq2e2u3evxNZWFDgaeP3RLPCaJ3REzCNarEtvZhzzM8qG0TH17nZhrHb8qtrT60tcKJAtPx9FNP/QMiR5A4G7gRoN0yfzZR/cZq8pmsYkIMAKuwkLIO0ylMC4DFMI4
x-ms-exchange-antispam-messagedata: RJqR2+Yji5nz3OKz3zme9MXaA4Ay3njE9wPhshxSnEkZpM8ABgPEg5B3T0B4xsxgYY8Dnu8VX0PIxUw2ext10lKp6HeKCS2/jiXy3i2KX0Bp8qEC5lwiO0sb3qxyiUzZAE2kDwpY26dMmdYBBPDtOQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d35e9f-e524-45e6-8bc3-08d7e759c29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:41:39.8106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcZAqjMHE3SZERycql5MHmxRqSH2vvdH4o/OZALefJYYxz0gbDWAS8/SCFo1vxW6eBJiNjZaqkzalwDv9N2wNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6723
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/23 16:15, Christoph Hellwig wrote:=0A=
> Factor out a version of the CDROMMULTISESSION: ioctl handler that can=0A=
> be called directly from kernel space.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  drivers/cdrom/cdrom.c | 41 +++++++++++++++++++++++++----------------=0A=
>  include/linux/cdrom.h |  2 ++=0A=
>  2 files changed, 27 insertions(+), 16 deletions(-)=0A=
> =0A=
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c=0A=
> index c91d1e138214..06896c07b133 100644=0A=
> --- a/drivers/cdrom/cdrom.c=0A=
> +++ b/drivers/cdrom/cdrom.c=0A=
> @@ -2295,37 +2295,46 @@ static int cdrom_read_cdda(struct cdrom_device_in=
fo *cdi, __u8 __user *ubuf,=0A=
>  	return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);	=0A=
>  }=0A=
>  =0A=
> -static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,=0A=
> -		void __user *argp)=0A=
> +int cdrom_multisession(struct cdrom_device_info *cdi,=0A=
> +		struct cdrom_multisession *info)=0A=
>  {=0A=
> -	struct cdrom_multisession ms_info;=0A=
>  	u8 requested_format;=0A=
>  	int ret;=0A=
>  =0A=
> -	cd_dbg(CD_DO_IOCTL, "entering CDROMMULTISESSION\n");=0A=
> -=0A=
>  	if (!(cdi->ops->capability & CDC_MULTI_SESSION))=0A=
>  		return -ENOSYS;=0A=
>  =0A=
> -	if (copy_from_user(&ms_info, argp, sizeof(ms_info)))=0A=
> -		return -EFAULT;=0A=
> -=0A=
> -	requested_format =3D ms_info.addr_format;=0A=
> +	requested_format =3D info->addr_format;=0A=
>  	if (requested_format !=3D CDROM_MSF && requested_format !=3D CDROM_LBA)=
=0A=
>  		return -EINVAL;=0A=
> -	ms_info.addr_format =3D CDROM_LBA;=0A=
> +	info->addr_format =3D CDROM_LBA;=0A=
>  =0A=
> -	ret =3D cdi->ops->get_last_session(cdi, &ms_info);=0A=
> -	if (ret)=0A=
> -		return ret;=0A=
> +	ret =3D cdi->ops->get_last_session(cdi, info);=0A=
> +	if (!ret)=0A=
> +		sanitize_format(&info->addr, &info->addr_format,=0A=
> +				requested_format);=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(cdrom_multisession);=0A=
>  =0A=
> -	sanitize_format(&ms_info.addr, &ms_info.addr_format, requested_format);=
=0A=
> +static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,=0A=
> +		void __user *argp)=0A=
> +{=0A=
> +	struct cdrom_multisession info;=0A=
> +	int ret;=0A=
> +=0A=
> +	cd_dbg(CD_DO_IOCTL, "entering CDROMMULTISESSION\n");=0A=
>  =0A=
> -	if (copy_to_user(argp, &ms_info, sizeof(ms_info)))=0A=
> +	if (copy_from_user(&info, argp, sizeof(info)))=0A=
> +		return -EFAULT;=0A=
> +	ret =3D cdrom_multisession(cdi, &info);=0A=
> +	if (ret)=0A=
> +		return ret;=0A=
> +	if (copy_to_user(argp, &info, sizeof(info)))=0A=
>  		return -EFAULT;=0A=
>  =0A=
>  	cd_dbg(CD_DO_IOCTL, "CDROMMULTISESSION successful\n");=0A=
> -	return 0;=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)=0A=
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h=0A=
> index 008c4d79fa33..8543fa59da72 100644=0A=
> --- a/include/linux/cdrom.h=0A=
> +++ b/include/linux/cdrom.h=0A=
> @@ -94,6 +94,8 @@ struct cdrom_device_ops {=0A=
>  			       struct packet_command *);=0A=
>  };=0A=
>  =0A=
> +int cdrom_multisession(struct cdrom_device_info *cdi,=0A=
> +		struct cdrom_multisession *info);=0A=
>  int cdrom_read_tocentry(struct cdrom_device_info *cdi,=0A=
>  		struct cdrom_tocentry *entry);=0A=
>  =0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
