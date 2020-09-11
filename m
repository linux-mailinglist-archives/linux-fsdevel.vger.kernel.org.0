Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6709026588D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 07:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgIKFF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 01:05:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52080 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgIKFFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599800724; x=1631336724;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=474T9UTZqsNs4xGyy0K8+PInB2QIQw7FVKOWjxYmt1E=;
  b=GIL9Bx97+205MwUj+OTV69koXgNVY98r9yC7+sGYxoMo6ND/KK6XpNQD
   6EikHGRuvx/pLBSgSeOAqbFR2w+qk15mXviFwNyfbAeJMo34RLVVld6sh
   g0ThdFExuQLHuwIXwErwtNDANqlz8HSZP8L4oVj3HVLUJsXLmW5OkxW/x
   32tdMpmPksT5yusA3CgkbK4BLkzR6XGjB716h0pmCGN7JNOWUQRYuqig3
   nUtKToiCjI2jy3+eIZ4ohxsXH/RwCU3R69Qo4p5ajOodBF/iYqaTKUZ/W
   2RdgdSvoMLx86nAQUZ0ijQvupxF1SWUZii1BQF8rUmOA4+PSgymfNsE3L
   Q==;
IronPort-SDR: FCeeIHPrcKYMOCkPIvj5nOKghlNozTLy01uO5sD8VQ/R9iw/tP4O0UEIIwLyT3wDOndUtEu7s9
 yVu6IYoKc+iSoVIPa6QS8pjqmQvfM4bJbcLB9sR24BZIERx23ZPHHgREQUeI4qmv4+cP8JVJ3Q
 9MH3V11aRxXNYYeh+wy6sk1beSz8aGfy/20p5MQPy+fG7EzPqDiDa6eWHM9IcZM7XdYm7IJUeJ
 CD4bJwDaTfESUl+Ewa3L32vMDoxSNPULuhpyaeT3c2LB1t7GLzHewbSc0E8GqpWIOn9/9knfM4
 2xw=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="256698374"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 13:05:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRgvAskkOv3QHzn0BvjlWYi9BKojlu8jrCmb4I7mjzDU3A1VD9x62SjHmlzuOkz5lWVDoir2TYI1flXQty2ZQCEkTQqGaUlkS5OgmcPWdKbSyxNuflWIo6MmPl2HeFuUkr+t89yNP/boQUbeQ0tmkmUqC7jo9wWqN2Vlt+har2iKzaahTcgyCQ5Qj2lgISa4pl/q1+9h12JaKQD3xnQIFASI4PeoSSuzmekDK631TJGkzbw4G3OpsNrN++FteC0JXgIhDR48IWiAv6i01AwHWD4duCQD5yrbgoAx60hJa27i7lXS7NE86y1udodx+RnMhacJKoa49i8FoQGx9Wspwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bse/bjpZd1KE9HeOoC1CDbVqoy7/xLkon8COfowz6sU=;
 b=FV2mAVTOwlEwJS8cgsrbJczMbeA89OprLxXXHJtlGp7+DKiSplynyzH93NFdJ+3DR6JTzGQDcDnXo4vFt3GEKYdDpUfrGs7NYr38utNZD62xu8I9hY37hojbIsaSoW2TvVc06MaQtayIZwNM6U2nW7NYENFULXS7iv8SS/Ctcz0vMU3rWVUFViABDAz79WvI3YMTD7X+soV/wN3FM3ApplXCNl2w5j+qjmXVyQP7LSH2JYTmueBof9Wa/iBXYQJcgnywv9gnlfhK+vbi2m2LyWqq9jDql3/u/DftGiI4m0RonzwOUa/qoZkTqYUgxttCrItT+H96NCRuapiEnvqgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bse/bjpZd1KE9HeOoC1CDbVqoy7/xLkon8COfowz6sU=;
 b=KzpjXpe2oTBO+0SJ3B4S02tfK1FPru9dyrleYVWfWkpEebZoH2D0Ta1ot4phOUnBaypUCPwJAM4ruwtnqDfAY/mBe6VCfhboJfucuVPcC4PFeWH+KzoC0Y3q5CPQwPu9aVLd4FRuDE8BTPjLxak3eKsosDOG8FoP+PRjuHT7m7s=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0425.namprd04.prod.outlook.com (2603:10b6:903:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 05:05:19 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 05:05:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] zonefs: provide zonefs_io_error variant that can
 be called with i_truncate_mutex held
Thread-Topic: [PATCH v4 2/4] zonefs: provide zonefs_io_error variant that can
 be called with i_truncate_mutex held
Thread-Index: AQHWh3/3V1sMJ8582E6Yqx1ZaFGM3w==
Date:   Fri, 11 Sep 2020 05:05:19 +0000
Message-ID: <CY4PR04MB375191672451DED79B0D7775E7240@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
 <20200910143744.17295-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:dc48:bbfc:f5cc:32c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e59e217c-1502-4843-03da-08d8561047b3
x-ms-traffictypediagnostic: CY4PR04MB0425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB04252C0BEC161250995F2226E7240@CY4PR04MB0425.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HwB2R0a3WkW87DX4CjN3AnUyHzz2/rRPwWoIba4fPlFKcZT8TRYImjDH1wVaiRo5ms36CE/sgkjoZKwZZKjscN6MdeW2jL63HMc5dEwWJn9sSDkhHNxeqjx/Y70K+myUr6Myh5aMSVL/eOoJx+7+hJLSAKJfmp0R6WxMiObMMzvvsQ/CsVUQiVUT226x12tc9W+5KREf8DpaGkb32qJXkzTsXafq0dhWvWjDMlKVstPHaOP49W4wtRwZCH1v8wvUq9gOoIXARRuExLgOokQcOAr6VtJyxYDHIiYqYI+EjKeOZGAOqelLk+GY6dPRljC9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(6636002)(8936002)(478600001)(186003)(4326008)(5660300002)(2906002)(53546011)(316002)(6862004)(86362001)(6506007)(71200400001)(83380400001)(76116006)(66446008)(7696005)(91956017)(66946007)(33656002)(8676002)(52536014)(64756008)(66556008)(66476007)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i8maZJrC26gr62PzILgBXsbdl/qveZO6vfk+0E68hWKJSB/MfSWppDEaEHGOPpxmpAbERScwLL6yVPVvGq+HG8ztOKNCEyauj8xVpuGV54JXklMj9egF4oTfMTgP7xPvXk1sEXRMb0UkGtWo8MwecXFCT5xJrCF/zGBawn+TE5p64CiHbKH7yp/KBusgpl6RKeW/oAomtzGtO1kctDFDSaPrDNJ6RalgjCpaaVY+kcIHkbaNlQJlfMT2ryOwd46TtbKUr4ADkOhxHfNI+jXZ+4GpJpeDN/n87gsYL/bFwglNrDTtkwyX9F36cQgpi1LVCjsiaNzjKY7ijtLXvcg3+omFOXUMIyx6MVlznAFHYbG2WZR/Wws2eQv0a6n/trq3bpLk2Scv4vXF9MBG2/CNGVaAWyn7Sn0s9egiwPI/qdznd8Pucrr+CGtrVyxLCkAbqdAec65Mdv9K869Uu6fhtRrTvvy6ystL9+uJ0pmHSbjRlDWaVLh3FdlMf79IT+oiO2LaTHdBsvXskChr7R9OzJtdxpjgxDqQkCjSw7VLcegPrFdvQJDt0QAYjXZvx7DhjQMjoTq0tMIGEdtIVI5I2vHaVVaf5nX+e0KEuhyVuob3R5pme7EwJ4x1B2+6Flywl/KADborz3GFOjjMTpnA3H2F7VLoXRJwLQC4ZhUeQhwcfLrUX81CZv/Q9JvNx3S+53ldAaLYktPMtrYcanyVxg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59e217c-1502-4843-03da-08d8561047b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 05:05:19.3970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSiqaum4A7pdHKkphkB9/6TDiqKAgzGL6Bh47vxmq2z8jGk3DK2DsUwfZXpCBC6bwPELaNiB+TjmpoSu8gaYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0425
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/10 23:37, Johannes Thumshirn wrote:=0A=
> Subsequent patches need to call zonefs_io_error() with the i_truncate_mut=
ex=0A=
> already held, so factor out the body of zonefs_io_error() into=0A=
> __zonefs_io_error() which can be called from with the i_truncate_mutex=0A=
> held.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c | 25 +++++++++++++++----------=0A=
>  1 file changed, 15 insertions(+), 10 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 6e13a5127b01..3db28a06e1a2 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -341,14 +341,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone,=
 unsigned int idx,=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> -/*=0A=
> - * When an file IO error occurs, check the file zone to see if there is =
a change=0A=
> - * in the zone condition (e.g. offline or read-only). For a failed write=
 to a=0A=
> - * sequential zone, the zone write pointer position must also be checked=
 to=0A=
> - * eventually correct the file size and zonefs inode write pointer offse=
t=0A=
> - * (which can be out of sync with the drive due to partial write failure=
s).=0A=
> - */=0A=
> -static void zonefs_io_error(struct inode *inode, bool write)=0A=
> +static void __zonefs_io_error(struct inode *inode, bool write)=0A=
>  {=0A=
>  	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>  	struct super_block *sb =3D inode->i_sb;=0A=
> @@ -362,8 +355,6 @@ static void zonefs_io_error(struct inode *inode, bool=
 write)=0A=
>  	};=0A=
>  	int ret;=0A=
>  =0A=
> -	mutex_lock(&zi->i_truncate_mutex);=0A=
> -=0A=
>  	/*=0A=
>  	 * Memory allocations in blkdev_report_zones() can trigger a memory=0A=
>  	 * reclaim which may in turn cause a recursion into zonefs as well as=
=0A=
> @@ -379,7 +370,21 @@ static void zonefs_io_error(struct inode *inode, boo=
l write)=0A=
>  		zonefs_err(sb, "Get inode %lu zone information failed %d\n",=0A=
>  			   inode->i_ino, ret);=0A=
>  	memalloc_noio_restore(noio_flag);=0A=
> +}=0A=
>  =0A=
> +/*=0A=
> + * When an file IO error occurs, check the file zone to see if there is =
a change=0A=
> + * in the zone condition (e.g. offline or read-only). For a failed write=
 to a=0A=
> + * sequential zone, the zone write pointer position must also be checked=
 to=0A=
> + * eventually correct the file size and zonefs inode write pointer offse=
t=0A=
> + * (which can be out of sync with the drive due to partial write failure=
s).=0A=
> + */=0A=
=0A=
I would prefer to leave this comment attached to the function body, so=0A=
__zonefs_io_error() now.=0A=
=0A=
> +static void zonefs_io_error(struct inode *inode, bool write)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +=0A=
> +	mutex_lock(&zi->i_truncate_mutex);=0A=
> +	__zonefs_io_error(inode, write);=0A=
>  	mutex_unlock(&zi->i_truncate_mutex);=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Apart from this nit, looks good.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
