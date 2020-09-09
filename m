Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF88262EC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 14:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgIIMxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 08:53:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57682 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgIIMww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599655979; x=1631191979;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=u6c/hI6L3rF0EO782n/1l6GnUk26CpSUutqZb34lgdQ=;
  b=OXEGRKQKeeyVX+C9Jo97ShXaaT3lOy052DGbhPQ/jyzKrCFpPt4n1pKy
   3PI+Ft6Yt7aKOoJfOw7Vspsne8ocbIOvyOf0GK736AiIvyKMUttlqGuvK
   n0/rldz6uktdD/B8efaY7vkKOMY5VHep7Ppn92qw9CAlnZ6TvAxkhXZ0g
   bc/K/b7Zvb0GS3++4yZ7gxRTzft8FlkVQBItd4wkGWm4AgpwNTaKSlUtl
   2QZJrf3Vcnebz0ZDFVfsl0lRQVzivyOmWgg3rIVe4dEB4PoYU3CjUSQ6R
   /0+RePVHZ+B4maYXQxB0qGy66BAjixXYCGNcZYtdtC22qUA+YEfIJNnzx
   w==;
IronPort-SDR: wm//FojgYY9xhImViSq5HSbYCBE/GiAYUZCJ3lH575Td16yBc3ZDPVE7LPrkSc0wSEdZC7+1x7
 2zY64PJEdAQvP2Btmx09pPyx0gxIyQE5n+swFFJkxScDJvi5ub76OsGONu1h1NPsjRSDCMGIcG
 IHbEaIjOXb8cWHtdm4yLH/DiJYEm6k0+kRNbQMqqUOhYXg8MeZlg2u4SaztAOX4+f3jNNx51Fv
 mNfgaKl3J1SsKc5KZttAjYpIpr6IKC8haPMHVj7KM4Wbru4K5jNqE/xtHlnTZaoZbu/Q5M/Cdr
 D+0=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="250224706"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 20:52:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP7uXBC0MY4ttW0/QHzjolR8TMZv7bkLr1gEies9JAr/SApR+2n81RC3TdKpBIPHC5qoROn++mWk3yCECHaTP/tHPhpKLu6QkNxIOAC7xCEtA4w5p4W0NYIDTOVSUUWjh4wL4Kxxawc0SoZ9pKyISWCHt/F9I5n2203mso8cVo7BiUhnOp5n4L3Jhff3j8K1eBJkaRQjkoGz6iFWd3Vp9NqrvE+ir+Ly1HumO6a0U8VZ5EsyT/ShjGCX5v2RnF7PiAr+VJT2ILiLQJOz83rMD0m8DrlFQfLV3EpRqS7LdIz8ov++36RHjnEYLSQCajOzY0MMgNQqyGoBctJAZpzVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMgZel1GcFR7eK8lq58PoFwr+6CwKUrFVYM9r8WFlPE=;
 b=jEHSmfvj5H6uDM1cR/2La055N9TRsCoCRHpk4zOWJ+m/TYtWfuNXdL8Rus8sM/eBwDz/wxPf3UI5LdOFu7PXDo3UgcGeqjZaX1cy3TkRVMyf6pQC2GIgF8a6kkshph1NEaF4u9PaotXEvPRvzhlaJLpLNvFUg0NggBOjoYMfOtZjJ28jTRSgcsUJ+Ie3FcsYs6yizC97nYCJstULIFdSa5Zeyd67hXRrk81Bziv83z4ewJ5KqU66HX4+nRokCFXwAXn+YrjVvaFLJgw0Nj1aOsxXHrAGDGIzGCXjTd6qgaXtLCSRLPbuGtuAECwLfNa1vRYSqtzgyRkv0SVJdWAdtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMgZel1GcFR7eK8lq58PoFwr+6CwKUrFVYM9r8WFlPE=;
 b=JIhXyBw01RmcAtsfoL1J82kvBBz89OGScgaJ+7LAYfx2ubi+A7pcLBbodFYCb42kuDSoZKt3JbIIC8070CuY/HsrRg2toebNzN/gayefxC3DauI4COyVrQZpBgSwEO9v/exQoritm3BZAEKGlS8/4INFy5poBY17j1nqp5PAE2M=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 12:52:20 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 12:52:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] zonefs: document the explicit-open mount option
Thread-Topic: [PATCH v2 3/3] zonefs: document the explicit-open mount option
Thread-Index: AQHWhpOzLM62FabTm0Wsw7Rc/xpdhw==
Date:   Wed, 9 Sep 2020 12:52:20 +0000
Message-ID: <CY4PR04MB37512BDD36767DD5C03594FDE7260@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
 <20200909102614.40585-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1c31:4ce8:636b:3f7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7617e83-1c72-43fa-b412-08d854bf306a
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB07274112B6FA00B02AE24034E7260@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4yIVU7HEo9QbIzNe3bp7sYTYSquqDjgWwxYAeaYKXrkoQWcJrofUYolFKOcxv54Itr2j8+fnJP5kkppyWhrRWReru60W9ZGjswPpBoe0LeycHS/XrcBIB+0Rk426F9kW18/RBf/0jY6hkAoTbLeV6nb9s7RUHK9kmHtRenyxJSYSLueSUQia5KkE7gkJ1G1l1ucPkcmz2Ky2VYAGRIrTyQv4WBwV1FF4vQhZm42wTvAdhntWQklWKFniKRcbFBLUTF6JFYY432WRgtBvha7Pe433FIpS2ouVnDjhPgZILD5iTMcxbb5jn/P7cAeOg44vqfTWEY3uxJi/vSIqV+CIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(7696005)(66946007)(478600001)(8676002)(186003)(9686003)(55016002)(86362001)(2906002)(83380400001)(4326008)(6862004)(8936002)(6636002)(5660300002)(64756008)(66556008)(33656002)(66476007)(76116006)(66446008)(91956017)(71200400001)(53546011)(316002)(52536014)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Bum7wLQPBpy7a5Pt2tvOdwPX0+1Ry2BcoYKR5SG6qzacZvcg4I+NTl2F5kohJTjLTlYRj/YvU1gaIqcOB8COFXsYdwRE6p01/Ni9jpWzW8/fk5CPMPLQRldpqacT7Jrd/7hYhq4xRT2wNf39KJE57OG+I1lNaMONjwM5UaQY2f8V96PLmqE+7EQJWp8XHqyElND2e178YvEim4q3E9OLzVfQSocTPwSpI1KrcIxv7sTDRK3KOATVFRtSACAAQF/x3kwdX+H8vxUYAfwhCzEiwnf1qQKQOdEolDqqdnpnS1P8dxVi8kbhW21/jwfuk4vUkvlyOIbPYulVTwUYXox9e685m7QIF0XtiR7UY6vQCAFTF4ytg/qrh4BntnwDJnSnt9YZ2gdqPmj1zJVpdswX71VFtkahKL7WTbw891kUH4/QNGc1PK0uEfspDzp1O14O5/66wZFiklWewubePKf/CXeN/6KrDqrLbhX3ZuHnN5BIGebpqkA7TH76KsskJtsqpx3n1Q7CmIUF91TfT9RdQkgVZpvWxcbwBEOFzp02TwiTSq9f+I9N9w3VyHtmUwDLtRm5zoW1oXuQ4cJvwmoKBGlROrmlGocVf1zpFwwxB10+kUyGnMfcSonwLm09g6bZI2U+lyjq97nJPnKdOWteVve6iy+YtkUve0z/+Bzsr5ZVM62eX00eUyC/8YNLTObaEiLs0+xVoBLwbnvdfLispg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7617e83-1c72-43fa-b412-08d854bf306a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 12:52:20.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/X7crfQ0Zd3JypmcvvC4dvr/cO4St36EVrAVz9P8bt7CVQv0VYzPGqSO6USuoPPl8LFn0pV4GoQWaeMJJTS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/09 19:26, Johannes Thumshirn wrote:=0A=
> Document the newly introduced explicit-open mount option.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> ---=0A=
> Changes to v1:=0A=
> - Address Randy's comments=0A=
> ---=0A=
>  Documentation/filesystems/zonefs.rst | 15 +++++++++++++++=0A=
>  1 file changed, 15 insertions(+)=0A=
> =0A=
> diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesys=
tems/zonefs.rst=0A=
> index 6c18bc8ce332..6b213fe9a33e 100644=0A=
> --- a/Documentation/filesystems/zonefs.rst=0A=
> +++ b/Documentation/filesystems/zonefs.rst=0A=
> @@ -326,6 +326,21 @@ discover the amount of data that has been written to=
 the zone. In the case of a=0A=
>  read-only zone discovered at run-time, as indicated in the previous sect=
ion.=0A=
>  The size of the zone file is left unchanged from its last updated value.=
=0A=
>  =0A=
> +A zoned block device (e.g. an NVMe Zoned Namespace device) may have limi=
ts on=0A=
> +the number of zones that can be active, that is, zones that are in the=
=0A=
> +implicit open, explicit open or closed conditions.  This potential limit=
ation=0A=
> +translates into a risk for applications to see write IO errors due to th=
is=0A=
> +limit being exceeded if the zone of a file is not already active when a =
write=0A=
> +request is issued by the user.=0A=
> +=0A=
> +To avoid these potential errors, the "explicit-open" mount option forces=
 zones=0A=
> +to be made active using an open zone command when a file is opened for w=
riting=0A=
> +for the first time. If the zone open command succeeds, the application i=
s then=0A=
> +guaranteed that write requests can be processed. Conversely, the=0A=
> +"explicit-open" mount option will result in a zone close command being i=
ssued=0A=
> +to the device on the last close() of a zone file if the zone is not full=
 nor=0A=
> +empty.=0A=
> +=0A=
>  Zonefs User Space Tools=0A=
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>  =0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
