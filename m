Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0035E91B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 00:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348613AbhDMWjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 18:39:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12864 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348631AbhDMWjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618353538; x=1649889538;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=m043U+KQ2y9D/FzoWEu24UTZ81jiuYIX4LFypTZDgSo=;
  b=BRvbGLK0989OYR3i3RIoENcL/U75cXc2wli8APB06byIbqMjzzdZ5clo
   /k/Xphok2M9WWidn+PR3TnLOLlWU+YhdhdW98lz3PDCG1KTZv11LMJxl2
   dCeTFJGrHLfDC0sT5nXfexWXeJL/4B8w+1uRjpd9XgRqRgJbp4Wb6ACZQ
   dGJMg9MIOWqpSobzEhZyd7rz4vep/JSryBdUyGbRgefALTUxVbHw/J3WG
   ciZn/Ivh4Qqki4UzWSARhQ/7kAfD7YKZfZnywRtZWXetpSXBGxBQ7oUeE
   ncEJi6IrfJ4wEHMpng7rRlQDhXXj6yZA7f9dqQMEC1qJBxmaXj9xBDLws
   w==;
IronPort-SDR: HBG4NPbWO2/uxH0WHZLvV7xfO1EfoBhVZUCktr3Z2V9eg4ZCEL2pb3LK74FmYENDJOU9adBadn
 jW/2koPE8hi1TfHYpauOdXlc0Ny64e3DPKNcBgabfQaGZQbUS8j69Snf74/I0ZYF60gNZ1p1EQ
 RUYbYCxSno1zA2rm9PtC4cZZbwh6kPbXBMgagiFK33tZNAJ/K74xSW6MJXPlaxtcZq7YP1kRa4
 WTEOz+EFx+8+HGb0uC5tfK3JEdoeuTOAXScbpF7yfPJar/cHUiEsAzskxODhzAHS1vWsO85dq6
 p7c=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; 
   d="scan'208";a="165427105"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 06:38:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XenI33ti/BI1a6+vdV+9+L4XfsdbdXmyf63GJjSoSVt84KOLMZ2k9ADy6TKx7a7lyeyHsvgoqwrJHuS1qL/Hdx3OIYbPt/ePg35YoRbQqsvkUpz3z9F3flPuGbaStc37m/pXJDRxDSa+T1ANQa9es2g2P82fomnIQsl0xbVS9TEgnyA0XizQVSV3Qj0p/XFh3mbHAV1ozL8JlOmLEAtyrYNmwWdijqeeIdhi1oQ04DpITahtDW85yxSGUMe/oD6gqumsHzuMdAyo+eUNtq1SDAnCBiIJoBpd/hTpvMqNtnIr1Rt5mFUV6MZyRP80oHR13wHW9P0rPDR4ICqlNe2d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fffUciYYj9kYmEtrjMEZ01VKPIEwGX7CcPiXOxF4G/Q=;
 b=T5NCL92BnW0KwpA6BuoJdpRfKrZZTu4Ycp362Lak5mIMonX2h22BQzskDvAq/R6NlFChsVqSYrv8jbghwMijvb5m2PVpaqFj7dx0SugC5kO37QlVX2Y0DHrWuymTOgrRswfOZmJMtxMQ6G7GXt89WSdMjHBWGBExC5G9nXdsGHiq+nitbpvB2GP9APDNM9H1SEoyo8ZIMPoTQFyGyRcrzm9rm1pBqQtpjpdD+V4Ne/VQdpyiGk7akPMIqtVQaN+uaMiGE9ygIGyYE1H/yL/X3Zq1mHRSHKO6ZZJTo7oKEOLskIF0bdXv8hwTsUFmZn2qYl1BN46ZJMz5p70NZ1Jofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fffUciYYj9kYmEtrjMEZ01VKPIEwGX7CcPiXOxF4G/Q=;
 b=Ez9UREMPc0L1FLAytFx/4KzRhYWzSEFIsaKLfLw5hzGmwp6AiYpscS4fCupuHUE6du0UfRPcyhDTPOil7fGZ+xLz0SmwFglCC6CO3zaGLtaghHwK9d6R+v/sranGHoE16qagLRxeJCiS49QUQTKq4ZktKVM9TC1jwzGjtP5n1Jc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4740.namprd04.prod.outlook.com (2603:10b6:208:43::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 22:38:37 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:38:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 1/3] blkid: implement zone-aware probing
Thread-Topic: [PATCH 1/3] blkid: implement zone-aware probing
Thread-Index: AQHXMLHjRBi0NiGi+U+DEQuVix0PGA==
Date:   Tue, 13 Apr 2021 22:38:37 +0000
Message-ID: <BL0PR04MB65142AE5036A0B15E82B8FA8E74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210413221051.2600455-1-naohiro.aota@wdc.com>
 <20210413221051.2600455-2-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7d52:2cf9:7a90:aa92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5e2a8db-0c54-497f-2c6a-08d8fecce133
x-ms-traffictypediagnostic: BL0PR04MB4740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB47407616E32458C51F755310E74F9@BL0PR04MB4740.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:119;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6V/xMUR80N9NepF/C/kjLtfzHeJVR97RX3a1Dgb6aCt2eS39so9nh/3xS4FJDxgxCzYs19BCurdJ+XQKv5CFtujHqyUZpX8GLqJ703S37ZinTZS/wX6oxa7fJ/XhLu5H+vGQSu7bwEoF2SA3SdXfc2DAofW7OQH4amYuoVK5dRjlWiRRSrGlTUgijKbT5h+N6xtfocgDPN2C6zNLWvQzqPTFc5BQMCdQwwPhvPrbf1q5Eb3zLPK3X1U/N0/+pArZMMAbwho3VYWsintDeEBnJzFnlDYGICKmj8cjsocy6ZfCmsYaZD8/26MIacrpSneZ11SMhDXIzakEWQV5CcdoRShVJtamTUo3aeXg/VdQ6kVS9sgLftrg1w68piR7jtx9Kc2t2sFt/YXbc6hFoqpwDfj5YZy7PZGXB+Y2GIhsv99VF3Oz2XlJvSnvTB1Wnkyng+p5KmliKLHQc+6YubDeDImG5a16RbTxbmggB5zZIbMsjeGp3JeovpvdYjOH/bEvAtmLcfcJ0p379Uqt4fZG0og8KRV4bgnu9n8GFgmq0k5mlF/+2KxUM9EWt35LRMK/GjkJhfX9ZJ9eLObM+SHuTdKUoesTpI4/Vc+JpF+4GwM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(478600001)(2906002)(55016002)(66946007)(76116006)(110136005)(54906003)(66446008)(91956017)(122000001)(9686003)(8936002)(5660300002)(7696005)(83380400001)(71200400001)(316002)(38100700002)(33656002)(8676002)(66556008)(53546011)(6506007)(4326008)(86362001)(186003)(64756008)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PRiJowd8YI3V3ngSNC+ao53qJPY2+PEnWH4PhvELdYvqUvmIo2XKIsglzJap?=
 =?us-ascii?Q?qVwdhDePCIr/2+G0FrShtxivMDwb+4lm0shydVmPKzSojrS4jKg/4iia3SGw?=
 =?us-ascii?Q?BboxbIXQR+FlMy//+Scy2x+praPlR7mpNtAGDIljOGIyIdKs8N05dSV+blJx?=
 =?us-ascii?Q?YSpKXX7Bb7tMB/JRb6X9iQat+qGJ3jNmg8dd3lXpT3HdTXGhxFgd8ziaxQWS?=
 =?us-ascii?Q?8FTvnLl+aN0ch2Fdm8oOfPuxhi3p7CLckAWelQlcOP3ewtXAh0IL9NE5xu8K?=
 =?us-ascii?Q?RX6zx94oNgZIfr2hC5TqLL6By5/8RY+8OFhuQPkhoql0uXRbxFvvB6V9p16j?=
 =?us-ascii?Q?AUVTbTBSSHhJi09YepnCDCjoHLBAIM6qkj/ttOx3hPpFN9Zu9gyu1i5M8SVj?=
 =?us-ascii?Q?VsKx5kKqm/cVXg3wlJ3NIH9Y5GVYbbK8+DzgkTvazWL5vKeGFKR63RrSDEiz?=
 =?us-ascii?Q?qR+03o30hbq4gSvNRsQew+9J1Li+Lg1mPg/zxztq3u+Vtsuu+ldKClKK6oT+?=
 =?us-ascii?Q?Jd3tmSH88Oxt8Im2AuBsRdonlQ1cRIpviOkKKb4fpFbtUccn8Qv8aRJHKy+i?=
 =?us-ascii?Q?SToUgM1PNal/sAa0o4WF7iAkOtnwMGMEVCoRUdifi53j5QcQxa3FSrM7uB9u?=
 =?us-ascii?Q?KXvDO4lBgY9iT5yfFquA8gUvXI6GMQOSyZMUDL5XDuje7i7bgQAz6uTnqPgV?=
 =?us-ascii?Q?zYhNw1yTJ3oGO9J1AOoa/DFGzrFRTMpcYVYtOtJWmzKwD7e+E0LlhDa5bS6R?=
 =?us-ascii?Q?VU0ZBFW4WYkv1B5E4g5M9XxnFolT3cYVg6a0M4zH12E4r7NocZmLwc6mUw78?=
 =?us-ascii?Q?FBU8aJLaajiltA5K+rVreQo87LXoIDasclcZDm9+2yGj+WgH0iMj7UDMfQGS?=
 =?us-ascii?Q?SOFwQ4CgTq9lziXL/SAqVJyjVbe8402hOgWOR63OZecoc9bZ/PNtWoB+lSJf?=
 =?us-ascii?Q?A6+TIOCwCb7e8qQb3PcGGWAVJ4BtLNwDNiiOhRpnW1/mVFTy5N+pD0GoY8t+?=
 =?us-ascii?Q?jiWhp/tx1YrX0wGGyoKZt184kLQv9kJydFxwhwhZKSYOwZv7+vO3MXmpfjH8?=
 =?us-ascii?Q?TcY1VP6Fe5sX3+at2b3zwroAg875M6ZhSiWFLCVgLiG02LYM6CYitgtB93fe?=
 =?us-ascii?Q?Klx3lVJ2+aYtXTEs7kyncScAtEFB88/aW6xvso0+pILvxPS+f2j/Zf/65oSX?=
 =?us-ascii?Q?kpqjEqiNipSvDN0MKmOnVnuDCuvxORfquvQM7uxNB39VeH7vaIZo4zZ5QA6K?=
 =?us-ascii?Q?AjuZHIUa/9GVbdEFh+Xna641nDLCLt2YdMv9i4YT68ro0+bm4ghwwePBE0yh?=
 =?us-ascii?Q?u6dS+FNKhwb2Gkom3ujl4tlSoGbs6+lI87Fjc8TbAG+/YxRQMYOfT7Noiprj?=
 =?us-ascii?Q?mdjH3F1Jc3p028hANlSEZvbASg1WW3ggIbdBsTb9THTXlcVEDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e2a8db-0c54-497f-2c6a-08d8fecce133
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 22:38:37.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl7BACTVkCIKaOxCxADTHVmSsArWkCSfEvEmCWaDa8nLyFgwsq172ztM+d9IbIj1bJYVAoN+xOHcQhpymO+JYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4740
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/14 7:11, Naohiro Aota wrote:=0A=
> This patch makes libblkid zone-aware. It can probe the magic located at=
=0A=
> some offset from the beginning of some specific zone of a device.=0A=
> =0A=
> Ths patch introduces some new fields to struct blkid_idmag. They indicate=
=0A=
> the magic location is placed related to a zone, and the offset in the zon=
e.=0A=
> =0A=
> Also, this commit introduces `zone_size` to struct blkid_struct_probe. It=
=0A=
> stores the size of zones of a device.=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>  configure.ac          |  1 +=0A=
>  libblkid/src/blkidP.h |  5 +++++=0A=
>  libblkid/src/probe.c  | 26 ++++++++++++++++++++++++--=0A=
>  3 files changed, 30 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/configure.ac b/configure.ac=0A=
> index bebb4085425a..52b164e834db 100644=0A=
> --- a/configure.ac=0A=
> +++ b/configure.ac=0A=
> @@ -302,6 +302,7 @@ AC_CHECK_HEADERS([ \=0A=
>  	lastlog.h \=0A=
>  	libutil.h \=0A=
>  	linux/btrfs.h \=0A=
> +	linux/blkzoned.h \=0A=
>  	linux/capability.h \=0A=
>  	linux/cdrom.h \=0A=
>  	linux/falloc.h \=0A=
> diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h=0A=
> index a3fe6748a969..e3a160aa97c0 100644=0A=
> --- a/libblkid/src/blkidP.h=0A=
> +++ b/libblkid/src/blkidP.h=0A=
> @@ -150,6 +150,10 @@ struct blkid_idmag=0A=
>  	const char	*hoff;		/* hint which contains byte offset to kboff */=0A=
>  	long		kboff;		/* kilobyte offset of superblock */=0A=
>  	unsigned int	sboff;		/* byte offset within superblock */=0A=
> +=0A=
> +	int		is_zoned;	/* indicate magic location is calcluated based on zone p=
osition  */=0A=
> +	long		zonenum;	/* zone number which has superblock */=0A=
> +	long		kboff_inzone;	/* kilobyte offset of superblock in a zone */=0A=
>  };=0A=
>  =0A=
>  /*=0A=
> @@ -206,6 +210,7 @@ struct blkid_struct_probe=0A=
>  	dev_t			disk_devno;	/* devno of the whole-disk or 0 */=0A=
>  	unsigned int		blkssz;		/* sector size (BLKSSZGET ioctl) */=0A=
>  	mode_t			mode;		/* struct stat.sb_mode */=0A=
> +	uint64_t		zone_size;	/* zone size (BLKGETZONESZ ioctl) */=0A=
>  =0A=
>  	int			flags;		/* private library flags */=0A=
>  	int			prob_flags;	/* always zeroized by blkid_do_*() */=0A=
> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c=0A=
> index a47a8720d4ac..102766e57aa0 100644=0A=
> --- a/libblkid/src/probe.c=0A=
> +++ b/libblkid/src/probe.c=0A=
> @@ -94,6 +94,9 @@=0A=
>  #ifdef HAVE_LINUX_CDROM_H=0A=
>  #include <linux/cdrom.h>=0A=
>  #endif=0A=
> +#ifdef HAVE_LINUX_BLKZONED_H=0A=
> +#include <linux/blkzoned.h>=0A=
> +#endif=0A=
>  #ifdef HAVE_SYS_STAT_H=0A=
>  #include <sys/stat.h>=0A=
>  #endif=0A=
> @@ -871,6 +874,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,=0A=
>  #ifdef CDROM_GET_CAPABILITY=0A=
>  	long last_written =3D 0;=0A=
>  #endif=0A=
> +	uint32_t zone_size_sector;=0A=
=0A=
Move this declaration under the # ifdef HAVE_LINUX_BLKZONED_H where it is u=
sed=0A=
below ?=0A=
=0A=
>  =0A=
>  	blkid_reset_probe(pr);=0A=
>  	blkid_probe_reset_buffers(pr);=0A=
> @@ -897,6 +901,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,=0A=
>  	pr->wipe_off =3D 0;=0A=
>  	pr->wipe_size =3D 0;=0A=
>  	pr->wipe_chain =3D NULL;=0A=
> +	pr->zone_size =3D 0;=0A=
>  =0A=
>  	if (fd < 0)=0A=
>  		return 1;=0A=
> @@ -996,6 +1001,11 @@ int blkid_probe_set_device(blkid_probe pr, int fd,=
=0A=
>  #endif=0A=
>  	free(dm_uuid);=0A=
>  =0A=
> +# ifdef HAVE_LINUX_BLKZONED_H=0A=
> +	if (S_ISBLK(sb.st_mode) && !ioctl(pr->fd, BLKGETZONESZ, &zone_size_sect=
or))=0A=
> +		pr->zone_size =3D zone_size_sector << 9;=0A=
> +# endif=0A=
=0A=
So something like:=0A=
=0A=
# ifdef HAVE_LINUX_BLKZONED_H=0A=
	if (S_ISBLK(sb.st_mode)) {=0A=
		 uint32_t zone_size_sector;=0A=
=0A=
		if (!ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector))=0A=
			pr->zone_size =3D zone_size_sector << 9;=0A=
	}=0A=
# endif=0A=
=0A=
Otherwise, you probably will get a compiler warning as zone_size_sector wil=
l be=0A=
unused if HAVE_LINUX_BLKZONED_H is false.=0A=
=0A=
> +=0A=
>  	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=3D%"PRIu64", size=
=3D%"PRIu64"",=0A=
>  				pr->off, pr->size));=0A=
>  	DBG(LOWPROBE, ul_debug("whole-disk: %s, regfile: %s",=0A=
> @@ -1064,12 +1074,24 @@ int blkid_probe_get_idmag(blkid_probe pr, const s=
truct blkid_idinfo *id,=0A=
>  	/* try to detect by magic string */=0A=
>  	while(mag && mag->magic) {=0A=
>  		unsigned char *buf;=0A=
> +		uint64_t kboff;=0A=
>  		uint64_t hint_offset;=0A=
>  =0A=
>  		if (!mag->hoff || blkid_probe_get_hint(pr, mag->hoff, &hint_offset) < =
0)=0A=
>  			hint_offset =3D 0;=0A=
>  =0A=
> -		off =3D hint_offset + ((mag->kboff + (mag->sboff >> 10)) << 10);=0A=
> +		/* If the magic is for zoned device, skip non-zoned device */=0A=
> +		if (mag->is_zoned && !pr->zone_size) {=0A=
> +			mag++;=0A=
> +			continue;=0A=
> +		}=0A=
> +=0A=
> +		if (!mag->is_zoned)=0A=
> +			kboff =3D mag->kboff;=0A=
> +		else=0A=
> +			kboff =3D ((mag->zonenum * pr->zone_size) >> 10) + mag->kboff_inzone;=
=0A=
> +=0A=
> +		off =3D hint_offset + ((kboff + (mag->sboff >> 10)) << 10);=0A=
>  		buf =3D blkid_probe_get_buffer(pr, off, 1024);=0A=
>  =0A=
>  		if (!buf && errno)=0A=
> @@ -1079,7 +1101,7 @@ int blkid_probe_get_idmag(blkid_probe pr, const str=
uct blkid_idinfo *id,=0A=
>  				buf + (mag->sboff & 0x3ff), mag->len)) {=0A=
>  =0A=
>  			DBG(LOWPROBE, ul_debug("\tmagic sboff=3D%u, kboff=3D%ld",=0A=
> -				mag->sboff, mag->kboff));=0A=
> +				mag->sboff, kboff));=0A=
>  			if (offset)=0A=
>  				*offset =3D off + (mag->sboff & 0x3ff);=0A=
>  			if (res)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
