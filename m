Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06E935F089
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 11:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhDNJPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 05:15:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52801 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhDNJPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618391701; x=1649927701;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8nmqdCtyQi6feMk5PiQ2iNIx7u79IB34UjqFU2n22dw=;
  b=gLLPqZYtg0TlAtNDjZbikX3VCFuYmK7aHsyUer05Ou9vhM3vfYchtRbR
   GMo7tIrGnoGiPMEsBt+WwgVpDwveoWJFkfhKdmDQnXRALKkqHpMQieRys
   jO9BtZnaUFSZfT5qKxAf3kvllKiPgntoAELYA0dffxHoWcCAmxmuOwD8K
   rjOxAluKxGqvNP4+tIzXCp7PfDkg2MlATyqMEjIRWxKkvNJ7glq57dZUb
   X1gOZLa71E5XhsZ+C9xQrzh5bMNQ+3XZ1Bh7qAjJEVvHoVr+j9OSW/VT6
   oFGcAJek1/HaUPoVEAFv0dtc862oT/a/6ofVD4bqb83FrRabiEFBYOzmN
   g==;
IronPort-SDR: btruPBVtvN8OZ8rrTqy43P7M0GEWB/SbHpo+72Iv18VDcv7fXP2cxLmeZYWWCHNVwk2PrU9ckq
 DrttkJhG3v1uGnwmtz6zCz3aKZwXKLMElsRFZK1sMUXhpdipsW/gtGyswNAPzgY0ATZoG7U6eG
 NpBcMOglVeeSbgyRuyijevl8ll5fsnmLTIRKHqmQHi1xtMptSnDfFoPeMmvqrv8s9VXAk/xq04
 8yYx5AW/en5t6SlFAYMoI8cbBpR5vGsHf0DBNN5IlW5yiPJpZllfsR4TqFJqhUDsYn6NdSyJdi
 Lxw=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="169260508"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 17:14:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qpb8Be3z+yefaRFKsu6sivxgWq0KsRXK01GmM9ZIDvoH+1HaRwqhgIngm/L2aViyayHAZsh7HoIgtY2qM8s5c2yS9ETY8oCV+ekqLoFPk9J2d3BmblcCGpdZEH+ag7MKurwseqsaOMA3iCARCZPX8wuAk1OAYSDCwvBSeFjR+irTQFjY262OF29WM4+1MwqGOr9+dEBy/51/Uwr/ng1RpZvMvbH4touM4a5wznNG5cUlPSL0RzyL05JgckxjUZYaBntvtZCp/KabwM7roKOsp5YMMJQdn+bzwsdfa3UiebTFbi1iLQa4wK1kA+Xm1z3jucgNeRTHGMCuxmQ3dd+ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOy7WdbLGfxkn7aDx4AFN578aSjd4jtE29xhDvFfaNQ=;
 b=U/QmEThvaMU3o+sLA6jKLwOjVLLFONqfViQGHaIvfmKAfE3yOmiws2LV0nKq1g4U8HvyJ/iyEIb7hZEilGG7hrDBmnRyQgRJ3nAOyN0cnztwdgd+RwStbz+CMrANUidXGaoIbw22VVWeuIDCpCebDeykII9pI7kygglrxS3aiuj7gXCnR70rKRMFB7S/tCiK+WpdockGB+8j1eoWf2Tv6/wFyxZ509KfPEywyKW/CGhYD3zpxLS1wXGtCZCBawYkemM4ArqZHp6q1zpzbkJKU7yfTheBobmqgu44VaEGOP/XaeEPLe9rEEsyd4acv56uA0b6jicaAanMTuSsTIY3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOy7WdbLGfxkn7aDx4AFN578aSjd4jtE29xhDvFfaNQ=;
 b=b4bDC/lI7wNPLEdC2tVBDxYNW9BYQZ+JSuoeEwKWUA7ivU+FjIcmx5NRHdU2aUpTsfdjFy/MPQK5jLnEdCmmkxqO6HrgRMa/SUeSbU83S3l+x3VEVJ25UVYteGTXV1TXeKt2iOk1GWy9j34iqZilo4syRnLMsHhllB9xAE/vZZw=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6638.namprd04.prod.outlook.com (2603:10b6:208:1e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 09:14:58 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 09:14:58 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/3] blkid: implement zone-aware probing
Thread-Topic: [PATCH v2 1/3] blkid: implement zone-aware probing
Thread-Index: AQHXMM42hYonSOiXg0yjdiztXW2lbg==
Date:   Wed, 14 Apr 2021 09:14:57 +0000
Message-ID: <BL0PR04MB6514E5E804A132A3E6BFBDEAE74E9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-2-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38dc:3578:4d0f:a943]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a90d2ba-44e6-40e9-558c-08d8ff25c674
x-ms-traffictypediagnostic: MN2PR04MB6638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB66386E00D1DEFC5FCF981E4BE74E9@MN2PR04MB6638.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OAQWs183pErrSssb49UnJMAYTwbmvICpUCrEcI1d4yMrNtdX1JAWOSFaxOu5LnUEK5zFXSU5w/i4SJbF2IZueVhgMmX/wD54Xj6681kmPha9dMK4x7I+zmlRTqratYt6ExoZyjNdi/iu4V9aLtwwGVGuM0tDHSaGT3T4/g5YTlctl1h5x0/p5QFJS9E7m1/OPWSm2UUpcYISN0CQTpUzsqUdt7ADoClAMJVgZPnf4vZUlnc5Vtg+lyCZSt5DLrzkc4HGbOgFGBf9MMmfeV961P9q6LYdVp+NR2+JRd0wuuOu4BXRZaYJkpQo6WSosWWjEOdtwqpFSgKaF79LvbXs3kl8X3q1YIvdzkL+eVTNnQ+IOOFW0p+0kTFtUD3PJVQuM36D+v0CItjbchYXyCh3FrkWmKaUFiriqWjCtKqViOjozUVzDUwuk3i4no/2NdH+hYOHYhlUvl7PLO6diHmmWrihtjGq2v5wn1TcewqIYG4imiLTjNq0QzCbmmMdLNYQIec5Uf3sHZQWbz4XKHCNlvFu8M0kIVw7Jhf5Lxz6XultdmqHpkGMyuM3sJINZuEmWSoDFG35zkJIK0dDxfl+Y0oj0QUcbG7dF7sJaRJdjso=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(5660300002)(52536014)(54906003)(186003)(110136005)(66946007)(478600001)(64756008)(83380400001)(316002)(66476007)(38100700002)(91956017)(33656002)(9686003)(2906002)(86362001)(66556008)(66446008)(4326008)(8936002)(76116006)(122000001)(53546011)(6506007)(71200400001)(55016002)(7696005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VVhpXu4EndJTa8+xqoEwfaJd/Iq09JT19T+Cd6RsaM9W1JW5liqnEKjzIVyk?=
 =?us-ascii?Q?XibrWKDVFNCKUXES59vXp25lT3Kgg8mi+HpXlyDEQJ6iC+rx71i8odwB3XZ8?=
 =?us-ascii?Q?kDj/u19xAYCThWkMHLChZiZ5JHOAT+5Tu64xLDK1qHiUg1OBzKbAzM1Pwpak?=
 =?us-ascii?Q?HQ3NVuHptGCzX46rZkHj9bnEJW9h+++6/U6IJzKBco8PjSnI1MFJZdpa9rlg?=
 =?us-ascii?Q?qe9WNXafsfMClsyBLENZzeBg7l+dPVnwOba6AGA4HMmx9JNdyqQvsOts2bz7?=
 =?us-ascii?Q?1WqB+eqZFipffHj9zPeuYUcpzVfjJSUN1AAlUu3dhbwgsSDS62+T2Nl10bZE?=
 =?us-ascii?Q?qIbaj6Imz03dxylWs/sibB3mdxQswgBSaQ+PyEbZU8qOB1PYtCF4linvRjW1?=
 =?us-ascii?Q?3BskJwoYFtbqfoiyfEzGu2n/Ye0mNe31lXcVw1UpodVHk0WvnrMrz3x36rSe?=
 =?us-ascii?Q?3j1UXWlDgF7HxBWS0HFMUg++hl+bvFTwmaqk1cw1S3Mi3mM3HiC7Dc8NOBOD?=
 =?us-ascii?Q?XAUFO9/hAahsmr/MVvYr1TrlBD+NRfOlS+roTU5zYpnQp26vd11Dv0r4yv02?=
 =?us-ascii?Q?pzjBJoaNHokSopgmawlewFW6W+NjzQDf51BY7LTGBHqWH8rWqNpQN8ie28nq?=
 =?us-ascii?Q?c4G9ZJbOexn4MWIxQ7qyvysv+krW7+o5rbyTYlSfFwm+j5HRSLHxrXmGiFqK?=
 =?us-ascii?Q?p/L1DlHDfWaMlldQHKyAYywAHKrBIouMLFxIBzX8KiOTNmd5aqHxbb9JaxF7?=
 =?us-ascii?Q?UMwSO/kP9XDBtqwF/7uNJINWH4GN68Sdo+NtI1gsqT+g+tVayT976nMweDdj?=
 =?us-ascii?Q?OrCW6vW9LKpq+AO7tfpmCpyYffqDi9IiS15xKlPWlDMVXd1h5eXRvJwdFIaz?=
 =?us-ascii?Q?j9aEiqI9Ft34sKa4OuhGTbdoaIL4R52FNE2JX8NoeXRWzWSxkk0hFFb+azqZ?=
 =?us-ascii?Q?sVbScvP1JuJE4HejmJW+EkPsMBCilJc6vjQYQUzyj/PXGvRvLVj71h1xi/x2?=
 =?us-ascii?Q?9stRVSTNS9zXuXlQOBEK/IzD/q69aAynd42TrKquDoNCnXTJrZ0oQVSa3pFn?=
 =?us-ascii?Q?/SB12IsHV9+2PdeZ4bs0Trv68072LbLfhNA3iIfa98sj93bXVNdxxEdGksH9?=
 =?us-ascii?Q?183V0yQsLYK/qYqZOgX03k03383pkaqDQXUC8teV87zSI+Qeomdd8TJe40n9?=
 =?us-ascii?Q?jxc5WSzm1cYckh7p/x1AUz2JUqFgZ+6qxYaDvt1w4Tgy8R190LXmIGqQnem2?=
 =?us-ascii?Q?TmgEK8zgOiurPQtIcHJK9z77e05yvZEKFPKPvJPWJ53PD76M1LSx2rCsv0rX?=
 =?us-ascii?Q?iHeUKTxoXT6SFDHvF2lIdtsTvz/n08I4/6nuFSoSOllsYLfdU/zae6G8Htj9?=
 =?us-ascii?Q?+w+NfjnYZwpsQwETqZ7cQbSOBONVLb7hsaGRD4+YK22ywyZWoQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a90d2ba-44e6-40e9-558c-08d8ff25c674
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:14:57.8921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLaIzwDaIZu2Pa1F2cBr3IbvPDOX1YL+bFhUL4T5pHtwbb7XJcbUFtL82+MYxR869ptf8ZGQype1dFSq5kXuMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6638
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/14 10:33, Naohiro Aota wrote:=0A=
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
>  libblkid/src/probe.c  | 29 +++++++++++++++++++++++++++--=0A=
>  3 files changed, 33 insertions(+), 2 deletions(-)=0A=
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
> index a47a8720d4ac..9d180aab5242 100644=0A=
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
> @@ -897,6 +900,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,=0A=
>  	pr->wipe_off =3D 0;=0A=
>  	pr->wipe_size =3D 0;=0A=
>  	pr->wipe_chain =3D NULL;=0A=
> +	pr->zone_size =3D 0;=0A=
>  =0A=
>  	if (fd < 0)=0A=
>  		return 1;=0A=
> @@ -996,6 +1000,15 @@ int blkid_probe_set_device(blkid_probe pr, int fd,=
=0A=
>  #endif=0A=
>  	free(dm_uuid);=0A=
>  =0A=
> +# ifdef HAVE_LINUX_BLKZONED_H=0A=
> +	if (S_ISBLK(sb.st_mode)) {=0A=
> +		uint32_t zone_size_sector;=0A=
> +=0A=
> +		if (!ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector))=0A=
> +			pr->zone_size =3D zone_size_sector << 9;=0A=
> +	}=0A=
> +# endif=0A=
> +=0A=
>  	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=3D%"PRIu64", size=
=3D%"PRIu64"",=0A=
>  				pr->off, pr->size));=0A=
>  	DBG(LOWPROBE, ul_debug("whole-disk: %s, regfile: %s",=0A=
> @@ -1064,12 +1077,24 @@ int blkid_probe_get_idmag(blkid_probe pr, const s=
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
> @@ -1079,7 +1104,7 @@ int blkid_probe_get_idmag(blkid_probe pr, const str=
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
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
