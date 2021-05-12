Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CD37BB51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhELKyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 06:54:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39105 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhELKyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 06:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620816825; x=1652352825;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9YnhHsF53WDmLrg9HL1bqQjwHNnPA2TsLObBiaXKSEY=;
  b=r43F/gCTURCe5ASBNXaa14I2oXTeQC0n1niaThfmKpj0dl7QZGtysz7b
   kPvWBGYrRmaSXUte52gj0VwrJY7rIJL9Tkr5oxac68Q02EOgWW0s8VNjc
   FY15vLGQAV0XU9bQ7lqVqxzApevGcO2ipU5Jm+/EjIBWRXqZka406og29
   m+gFMNAfBF4sBOv9KZfw2f8iU+I9voN3qA+kqfoh36NBRLeK54pFoeTpJ
   y2d4nhK741tjyw96oO6kl8IzFWmh7DFMGeEq5RvN29b39exonFVc0A9Y8
   b+Ykoo+Q3FPiMTXScxRt030dj3XD7KfHoJqqSQcn3tyXikq/w/pGyV97/
   Q==;
IronPort-SDR: tlWWrbpNc72q3BMvebXSvIrcXrLBPAQc83DJEb/ib/tmJJw95sQUtddDGheAVH93nOfVSZ7lLa
 5GtDfulNxaApGbQzh1PZqNGzYrcW+B20glFojZcsBQ6BNdwqhNocWcNTcGi859rxwHIKIEzZK7
 gyLN36WK+KdcvBDgOpcvdp4dVc6Subj3WuMhkRnfla2JtGW5h/5Pjnh7lIt7N2OhewPaIBH9d1
 ZCAvt/Av8FS9wmhALxOLj9TrMfb2Amlr3heTHggaBTeFZ1dZzIrA1IYMkdGXcyaZkn5Ub4Zf/S
 8vY=
X-IronPort-AV: E=Sophos;i="5.82,293,1613404800"; 
   d="scan'208";a="271862324"
Received: from mail-mw2nam08lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2021 18:53:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obmfg/XLGv0HjpxmktYLAxabpsff64yost6uBfbujFjX+eJKRo3NYsewr36aY9H/SKkSGmZXOiiHeIUEbX/mKBJ3ulcjKTsNgDfwqz7eM5VxoTlLTQFgpJsI9/2KhaH49OBO51sDhCUQCE1vM0yvgCWZweK4EKH+t9qhohMA4Gx78ppQ4qE6zQViwTHCq+yDjZgka1JeBUAY1Go6SrznKtxDXx7q3nHgXTz6JdrTpi7jDMURc624XEUUm21I1U3xKLpILgdVfcCGz/qY6+GG6wzHFrb7DjutcZQBLCz15KKw3zuycn3WEXVW/Ij2TE06EpFEH8ZkVB6mJQSEOmf4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAuKLowzb7GPkdF5JfdDoK/YcgGGHXq8bg0x96JdTjU=;
 b=IrKNGUoTZVsxZMEMbPaS7n2QM0TKKi70R7IF4J7WzR/LShU/QTucobWLD7jh09bpN18p+YKDBKciwfiRF4ccovT94FvZJOx9VNVa/PvqGgh5YI8+MgBZgE+HWc4qSLGj8iLAKT+ulAay0aFCAJ/JRla1RMy+TgrXC0FnKO5+xvXFK7xt5FstwhhvqPvWKWiizUhIxIiCQPxjZa+4YT/CoKN1k/UoiFV5yYamV3h2s1cUrmrxkszc5Q84fCt3wFW4x7ZKd3kvSzNbACp5kvFqeNyTjVkaccxhzN9vrbnh34+6FLzPmJSBG6Rhuqrvf0u6oryGHlrZ/5aObBk2vsaYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAuKLowzb7GPkdF5JfdDoK/YcgGGHXq8bg0x96JdTjU=;
 b=B0JqM4SLs36745/4FSbydOMSKCghIh19Rws5/O7vjr4qaQZK4fyPTPhTOdQ+khQvoeMtvLY4O93oyDPNs7mQ6zxn1zQzZjHgF2/8hyZ7+2UfKX33ZMe/QHQkndNgXZrha2uXz/UMHe9w5C7zXu5sR77Vyyd4MCX4Ou7/esYExdM=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6777.namprd04.prod.outlook.com (2603:10b6:5:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 10:53:41 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 10:53:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     jinchao <wjc@cdjrlc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: delete useless complex macro definitions
Thread-Topic: [PATCH] zonefs: delete useless complex macro definitions
Thread-Index: AQHXRvpXzmUNWmzonEKBVy+dPeaC9A==
Date:   Wed, 12 May 2021 10:53:41 +0000
Message-ID: <DM6PR04MB7081782ABE1C1295DC0B0A02E7529@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210512064454.59664-1-wjc@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cdjrlc.com; dkim=none (message not signed)
 header.d=none;cdjrlc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f879:b32d:f74e:155a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7509405f-1719-4cb0-e614-08d915343496
x-ms-traffictypediagnostic: DM6PR04MB6777:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB67774763D9763CDE42E120A7E7529@DM6PR04MB6777.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KaCEfkiFtUUT17t/ad9c8P4Ufb8aDO5C0SiyP+L1kHcTmxCx4u7UVyVu6mgI8GdrjwLHS/OOqLn9I2uTV8JkdPabByp/nmXNLNYHB5mSKwYq+pNKFLwonl1hFFBME84kKB8aiLzetazxelfEzriSlVyN9M7JdpSOahFy9BlTsOTrkoq+Yo4FD5f2QIHojPCXlmBoMWlF/RcPXJor1aZ+XSQQ822/Ru+6rdoqTAoeNxtq7WvQ7wlHPOrysaxsK4qPFKH2rIMNfKSmT++X+zFch1DF+jcVY47TSVsGY/st3RkHjaVuhrIZjhhIOJEUw0yr82Wn4C7vOSzwxySZDo20mrAYEo2O4D2NfMnAEZM4CbFy5w3PSNFB6CSWdOX+EQiLRij2+0p4UaCYhksD8G36B7F5FitQd1TTeQY9E6dZfkUBY/FbQ6gBRSAyV2R6VYMedFhOrKs8WvdD3xMFvWyDCdNpIOWG2eng0uXH3VX0/LFts2HU79uJYUIeRnCsM2qEYLtGn5hogLcv92HHUanwXQyuaPZNcOgYxo6LlNWcQpSbWLoUtip+hh5GtiIS8Uk0UUjqgBDV7r2MPfrTpWEcjLTnAPD3rXJIoc94cG1A22o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(9686003)(33656002)(55016002)(38100700002)(66556008)(52536014)(91956017)(76116006)(66476007)(5660300002)(66446008)(66946007)(478600001)(4326008)(64756008)(110136005)(54906003)(316002)(83380400001)(8936002)(6636002)(53546011)(6506007)(8676002)(122000001)(186003)(7696005)(86362001)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xqiTekDc0gKtvO6YC5d496X0gdgQqsA2XsV02U/F0ndhqFkG+hs16aHu+V0+?=
 =?us-ascii?Q?zjOsKiLMx5GztSH2FmjAbz3S4Hy0JuddMyVzvzV4IPJTJGmBs6KddnqOxt/A?=
 =?us-ascii?Q?4cUum7PHEI9VpS+nESkGz5FMqbTqy272fzeZaAaC6j2o2SzMNU2mIYU1QBff?=
 =?us-ascii?Q?9MtH8FKBthbbTpUyVMWmKduoa7sRLAJW8h44AX+Kbq9Cc0w6FDVL75hyYD4n?=
 =?us-ascii?Q?i7J3FmSY8Sd9bHEyLzIk37chd4e0x2rOYNYxZSC51bpLSYXXzB5OBRNz23v1?=
 =?us-ascii?Q?bmwjmQi31tC4TkuDyBNeh7xz1Hakky8ocIsFx5b1yiTqdv+TtYE5K+l6R4rA?=
 =?us-ascii?Q?0tS5tg4cgz4J+rjhNGcEP3GjLVa3Gijny/AmjHHY90eSHbUewyaHax67Nr0r?=
 =?us-ascii?Q?zAPbULhrYWdpCvviCZujMcZg7xPStS41XVs3jmtx0hMN91y5YknDoNcndFqV?=
 =?us-ascii?Q?wURnilWQQhReD+cDVcyEjnYysF615YY1mLM967AozyEIphSrBkPYe7Q+13jo?=
 =?us-ascii?Q?BSD4XxAVg03LBcFtDkt/o3u31lDPJT3qAYfx3rbZCaluJjvUq0lDHRM9AvTO?=
 =?us-ascii?Q?UIfh+MI/6+kJxHsC+z69m8DiKUe5EsVDeelfpElp6MWlS5kH5qOWMBzOQxZy?=
 =?us-ascii?Q?xshj3pL9jYjo8zRzKQQZ9mNWV4NnB8Cvwy2U8U/y3w1uQfqgrCNrKLzDL01R?=
 =?us-ascii?Q?QdtJK+NTn9dgiRNyfPW9mtT84f/Zqv7PZK6lDH7J9GscCUk168VTc8vS2Vk1?=
 =?us-ascii?Q?L2I59wFLfpP8spT5lxTubFz0W6jAAGnpks+LQfdtArOKDxp9gTu0qf11As1R?=
 =?us-ascii?Q?ORxMIudKZ+MrVGkknIOi6HpbJHs5H8pD2f6wrvDVOj8hqwizqhqYt3uLwEnP?=
 =?us-ascii?Q?BfZDfffB9Hz3/TOqj3JnoaeOJ8YTjabx/vxv0jFtopbcDqIkpMkhA3KwHbtE?=
 =?us-ascii?Q?IyIlSR1nBWgX3rlBc+0wg3rlau03V9WYAsDsbhk3ICRpTnSUcrVr4zXcrZZB?=
 =?us-ascii?Q?FyvkGLJeHSUYOvy++4YhpaxFuVDXv5PTIjaupkmZ4o85EPKMQTU5YfAADTpH?=
 =?us-ascii?Q?kiiDHGhA2TtcmhvVqNsgAkaq5e+MrhKIvXYrTJrWYCP5uSY9cOUj/rTz66hr?=
 =?us-ascii?Q?ZIVT+OL1HVXqQEayw2NVd8dvVrodVclU5YCQUlVIIikdh8mDoipSvvLG1Zs/?=
 =?us-ascii?Q?ABS1nbQB8lq+HcX3IdTQK2cWc95JWUOnrIqC2KUFEE+YbxbNEsCHfbKp9J2s?=
 =?us-ascii?Q?n+IXY+m0A/DClvJI7YBMJubyfl2wqNY8QbKW+SLRuwrtil/Wht2H7wldU2uo?=
 =?us-ascii?Q?E5WuzdALh6HBLRPaZZNgPNec6sheWy0jHVBG0NrbnbeCAnIc5Wj7nHpX1/eG?=
 =?us-ascii?Q?iG13wy8QZ+PQMUF0eayK52elTWLw8ycnjFw4QNLHSxVsk9kQ5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7509405f-1719-4cb0-e614-08d915343496
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 10:53:41.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eu/Xpb4eKPql0ZuQ70V1OP7GHc5y2xKLcOSplT29DYP5kfk8X/mIhr4Lwqqk4Hz36BSmyzeR0OXIJtOjH1NQ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6777
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/05/12 15:45, jinchao wrote:=0A=
> Fixes checkpatch.pl error: Macros with complex values should be enclosed=
=0A=
> in parentheses. By deleting the macro definition=0A=
=0A=
I would suggest something like this:=0A=
=0A=
Avoid checkpatch and other static code analyzer warnings about macros with=
=0A=
complex values not being enclosed in parenthesis by removing the show_dev()=
 macro.=0A=
=0A=
> =0A=
> Signed-off-by: jinchao <wjc@cdjrlc.com>=0A=
=0A=
Please sign with your full name. From your other email, reading your name i=
n=0A=
Chinese, if I am not mistaken, it should be:=0A=
=0A=
Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>=0A=
=0A=
> ---=0A=
>  fs/zonefs/trace.h | 7 +++----=0A=
>  1 file changed, 3 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h=0A=
> index 5b0c87d331a1..1f98713774f5 100644=0A=
> --- a/fs/zonefs/trace.h=0A=
> +++ b/fs/zonefs/trace.h=0A=
> @@ -17,7 +17,6 @@=0A=
>  =0A=
>  #include "zonefs.h"=0A=
>  =0A=
> -#define show_dev(dev) (MAJOR(dev), MINOR(dev))=0A=
>  =0A=
>  TRACE_EVENT(zonefs_zone_mgmt,=0A=
>  	    TP_PROTO(struct inode *inode, enum req_opf op),=0A=
> @@ -38,7 +37,7 @@ TRACE_EVENT(zonefs_zone_mgmt,=0A=
>  				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;=0A=
>  	    ),=0A=
>  	    TP_printk("bdev=3D(%d,%d), ino=3D%lu op=3D%s, sector=3D%llu, nr_sec=
tors=3D%llu",=0A=
> -		      show_dev(__entry->dev), (unsigned long)__entry->ino,=0A=
> +		      MAJOR(__entry->dev), MINOR(__entry->dev), (unsigned long)__entry=
->ino,=0A=
>  		      blk_op_str(__entry->op), __entry->sector,=0A=
>  		      __entry->nr_sectors=0A=
>  	    )=0A=
=0A=
Please rewrap the arguments to avoid the long lines. E.g.:=0A=
=0A=
TP_printk("bdev=3D(%d,%d), ino=3D%lu op=3D%s, sector=3D%llu, nr_sectors=3D%=
llu",=0A=
	  MAJOR(__entry->dev), MINOR(__entry->dev),=0A=
	  (unsigned long)__entry->ino,=0A=
	  blk_op_str(__entry->op), __entry->sector,=0A=
	  __entry->nr_sectors=0A=
)=0A=
=0A=
> @@ -64,7 +63,7 @@ TRACE_EVENT(zonefs_file_dio_append,=0A=
>  			   __entry->ret =3D ret;=0A=
>  	    ),=0A=
>  	    TP_printk("bdev=3D(%d, %d), ino=3D%lu, sector=3D%llu, size=3D%zu, w=
poffset=3D%llu, ret=3D%zu",=0A=
> -		      show_dev(__entry->dev), (unsigned long)__entry->ino,=0A=
> +		      MAJOR(__entry->dev), MINOR(__entry->dev), (unsigned long)__entry=
->ino,=0A=
>  		      __entry->sector, __entry->size, __entry->wpoffset,=0A=
>  		      __entry->ret=0A=
>  	    )=0A=
> @@ -88,7 +87,7 @@ TRACE_EVENT(zonefs_iomap_begin,=0A=
>  			   __entry->length =3D iomap->length;=0A=
>  	    ),=0A=
>  	    TP_printk("bdev=3D(%d,%d), ino=3D%lu, addr=3D%llu, offset=3D%llu, l=
ength=3D%llu",=0A=
> -		      show_dev(__entry->dev), (unsigned long)__entry->ino,=0A=
> +		      MAJOR(__entry->dev), MINOR(__entry->dev), (unsigned long)__entry=
->ino,=0A=
>  		      __entry->addr, __entry->offset, __entry->length=0A=
>  	    )=0A=
>  );=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
