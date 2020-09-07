Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1507725F1C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 04:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgIGCzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 22:55:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6870 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIGCzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 22:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599447345; x=1630983345;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WOyuekED8AJmn2BU3nJUFyyHxxDhIdzUK3B7zLv64Vk=;
  b=VxlxYM0Wi+XjepjkH6rSSkZkR/RO3zIAxIRTXhhXCaTuBfvGN7ldxegD
   b5Hyral2EdhrKhiWDjYWC2MIJ1RQmJF82/44u/s6CoVlXGoS43jSjFHJT
   qXjeA1vn3rpt1IKv89EwxPn9VEjXcmnJPRrui85Ewn18inPye3l5XWX4K
   fLEBgNX+gX1b5+fZrttsIqCz5dsmt+I6uPi7Hx4sIU881GUDQcofvg/mN
   EIF05dLln4GZlWqyYc/9sMRS5tRDb01sPq9QLh/xZFZrnVi+pAMaDjtOt
   RmBrIVajA8otJIHBekIqH2aBuSe6MWlEWNbTTwevfdy67N0KwlZG7ytps
   g==;
IronPort-SDR: ZtC3DlCXfEFVRR1jeg1PHkAnZ6Ccfr4tJO3SlpAIUIoztEOnbuwGcZvTtDFg6fjgP8F7BnIRVm
 sY2ByO2EL33VHR7WJJk15wsdfx351KTQb2qWm9F0n60MdOSwYNhbilFcSWKysHojBZ63po/oXL
 UXq+qyYBlGk2FNTwsWe4+4l7N7YDpg0WcwBNF2c049Srp8DXoBrXvTQpIfDCO31vD+LsImDWZS
 vmwwYdE2OL6UxSQzTTar/7Ewvnd3mtpu8q03b/NBjAxr70hVjNd39q+dKUnBlAaOCxlysdTKWH
 Cak=
X-IronPort-AV: E=Sophos;i="5.76,400,1592841600"; 
   d="scan'208";a="151054249"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 10:55:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA8I1lIX5Qo89lg401wHfHAMI3kmWz/J3A+V+VgYPzLfB1ULKH61kxQygOIqOFnM6CFf7beQ5EqugMGNUWO9prxat8fG0wO74oUNeRQE0aJB5qV3mjVb1+bqlMNkoxGLv5fSEZfco+SjpSSe11VcgV0EoSOlkF64kZ7c4nzBHuGmbqZCfKPpqo4M8g+lf30NJUTWksRpSK0Z0FEAhcpjUhxedBMFaz+JA9hZ4KSGbtbpmtQ0b+hBWE/aShb7A4mCTd8ll9+q+woW4latTEGPrkYGsO73a0VJWbkljR7tfoMhaOXDJK3TW+kKkJ50M51xNodjC+URhdpu3yawSjl6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS6SAInjkGI7HvNyfSiAvfnUFApNkDvJqQieKBkuEfA=;
 b=hySo771K98BQe8qeXwMjCK8bEjT86hPyGVB+MkSbWEplYCv9dJTwUx4afc3iQzUPb7f/crbB2VSBAISyygEZHSaCJL2CnWcfhkQPRvGRZLocne0BxsmUzcorsbc4bGrzkgGHEMZTT1rShqtpOtcsBHKBX8q1wdDPXjAmRDmLnKvglUw54cWP5W5gk/9u+LFrN/bi95++Hxiq8QlWdKbtx7C6wdJPjJqi+IYHj6jVdNOjrQdKDzOMNakz4fxVXu1hAJxmoxz+oBHUIDz0dq0KrZ4YSiaeP2b8OQR7Kpp5/djRDFd9+21kAoKjFMc0+fBGn+2hDKvZd3PdgUdkq0ukLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS6SAInjkGI7HvNyfSiAvfnUFApNkDvJqQieKBkuEfA=;
 b=UaVAFlZjiwCpj2+lZ917ioCCfiUR4Tun3ZGnD136By/waAl/oXMDYTqbSZjS7TSnDi3GBJBB/GwW2PxG79DRWjSHNdMT1uetjJ1GWSBvtWzn7mH53C1VBBeXy/EdSKWZDdO4sE/keoad0SHX859LLG5dQzUcN9w9fVYFug0Hyhs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2219.namprd04.prod.outlook.com (2a01:111:e400:c611::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 7 Sep
 2020 02:55:41 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 02:55:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/3] zonefs: introduce helper for zone management
Thread-Topic: [PATCH 1/3] zonefs: introduce helper for zone management
Thread-Index: AQHWgq3WseWrECsruUO1A3dYaWP6/w==
Date:   Mon, 7 Sep 2020 02:55:41 +0000
Message-ID: <CY4PR04MB3751ABC297A6CECAD198E21DE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
 <20200904112328.28887-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2cd0:86fe:82f2:c566]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9560cbbc-3f86-4416-0679-08d852d98223
x-ms-traffictypediagnostic: CY1PR04MB2219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2219651BE44DF3C756348E31E7280@CY1PR04MB2219.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBoNeydZQC1ZeIKckrfKwHKFT+i/utVCXSYBuqfKkcSS0kguooFdIb2dy6ws6gvR5/6myG+sY2s2WNG7DPVsbgy9PEyYwPYw0sKEmwRQ0ObI/oWry+laz5Wrd1ofBO76UjDpoKFRTZyPB6OKxs3zJCzR/0FUMNMNLv3nOxDY/BjVKB7bnmpDGPeXbTwgyUDrQQCkAoGPNyoevPvhNyXVN8LJOafHdMiukaX4RmdOT5c5dDKmj41Qmf/jZrddCE+NfpPRSjMiSvpkw9+F3wDS6vxfkDRcoaXmFb3JyD4H1wFB+jhuGDucQiptrPXCYMD+u5on2hj1nVwqyogzcYsYwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(76116006)(91956017)(6636002)(86362001)(7696005)(8936002)(8676002)(71200400001)(33656002)(186003)(6862004)(9686003)(66476007)(316002)(66946007)(53546011)(83380400001)(6506007)(55016002)(4326008)(5660300002)(52536014)(66446008)(64756008)(66556008)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Wt5i2VtQb8SBvBdIs83nwOYEowA5X8G6shrdiPbbOpKXX0O7sqh/oVpaXvdgcOHZGMZGbzaEl/X58d6WEZ7xHU+p7FTy1/typT5lg/qQ2/BWlnQAkEas5Sjvd/qedXPkNlv30H9HmK5UX9OKY2sGHkIpz/lJv9q/5BJfJkcF6nGXj46P/h4kiARMsHIzI9MsyP1YN0bLgARVtHgrrGt6r3xiLawiF9XeTyFYTAJv88HobQVhFcPbFdZScmtwgcznSwSSX0hjJOUlr0yaYXDG5ln4eCHNg6zwOw2AtKCIOGRgRqdUITT50xBRFs+UPaWG+kp+yKzBvJpVlOTRnXhQFi05iTMbiozjwRrpnLPf4ysO01m1S6+aSoFG54kAPAobOaoX6S+yINSsShpHam8tpZTajOzNRzU51O7kznmMaeykQ+V9/GNVorEMIxOcoX/1kFkmfGaFJzwKtI8exwGdOnPFoABUeTB/E/IUS4O+HgTE4rTqAJzsDso4S/0I/d4rQaMg/GOHfJKf/7GkOaJcARNmiW/bX7zx1jkq+xL7wp9GswU3h2HFgespRAA0jJSQvNTjomiY5Sb/pfgjwkdT4elpWT3JIHWxtxOFLDWN/NFUPT/6X5K1zWOdRf8wCb8jqY3rM+Y0jKthhXb4QRwk9W+D+3EoF4vuyr/HnF1I8MzVObHBexniypzH1+4HHYL8kN53epR3d0cwQ39fKmQQ9w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9560cbbc-3f86-4416-0679-08d852d98223
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 02:55:41.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEnGAYQyReXdKQZu3a1W/Cyh7fTB0OKjEW3N/fZLZDthi4CjRcueXvMwqwHOox5wqtlR7D5EX2HAbT7sRPuqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2219
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/04 20:23, Johannes Thumshirn wrote:=0A=
> Introduce a helper function for sending zone management commands to the=
=0A=
> block device.=0A=
> =0A=
> As zone management commands can change a zone write pointer position=0A=
> reflected in the size of the zone file, this function expects the truncat=
e=0A=
> mutex to be held.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c | 27 +++++++++++++++++++++++----=0A=
>  1 file changed, 23 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 8ec7c8f109d7..9573aebee146 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -24,6 +24,26 @@=0A=
>  =0A=
>  #include "zonefs.h"=0A=
>  =0A=
> +static inline int zonefs_zone_mgmt(struct inode *inode,=0A=
> +				   enum req_opf op)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +	int ret;=0A=
> +=0A=
> +	lockdep_assert_held(&zi->i_truncate_mutex);=0A=
> +=0A=
> +	ret =3D blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,=0A=
> +			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);=0A=
> +	if (ret) {=0A=
> +		zonefs_err(inode->i_sb,=0A=
> +			   "Zone management operation %d at %llu failed %d",=0A=
> +			   op, zi->i_zsector, ret);=0A=
=0A=
Printing blk_op_str() instead of the raw op value would make the message ea=
sier=0A=
to understand.=0A=
=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t=
 length,=0A=
>  			      unsigned int flags, struct iomap *iomap,=0A=
>  			      struct iomap *srcmap)=0A=
> @@ -397,12 +417,11 @@ static int zonefs_file_truncate(struct inode *inode=
, loff_t isize)=0A=
>  	if (isize =3D=3D old_isize)=0A=
>  		goto unlock;=0A=
>  =0A=
> -	ret =3D blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,=0A=
> -			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);=0A=
> +	ret =3D zonefs_zone_mgmt(inode, op);=0A=
>  	if (ret) {=0A=
>  		zonefs_err(inode->i_sb,=0A=
> -			   "Zone management operation at %llu failed %d",=0A=
> -			   zi->i_zsector, ret);=0A=
> +			   "Zone management operation %s at %llu failed %d",=0A=
> +			   blk_op_str(op), zi->i_zsector, ret);=0A=
=0A=
That repeats the error message already printed by zonefs_zone_mgmt(). There=
 is=0A=
no need for this one.=0A=
=0A=
>  		goto unlock;=0A=
>  	}=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
