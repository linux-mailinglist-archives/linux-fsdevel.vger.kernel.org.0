Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E215225ADC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGTJHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:07:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16426 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgGTJHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595236060; x=1626772060;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/S3GhPRWF4dzh8PkTiS3piGo60Skq8PaVabBXwk3w9M=;
  b=TzZ9jupYNL9qeFrAYzqHCCQe9n0S8eYIJVb58wZxhT8fgqbwlJhyvlzK
   r7MOmQCb5Nlxtjggsl6efs1rYPKQjtLoiBC5NjwIC/dmSQPst8ZgXRZDX
   a/UrXidRjHeaDSGXDLmG9PMVPYlOp48bUmD5ut3ck31OxlBe3TIiA7WGh
   IoCI4YpQwWXK3vLWhnUJdDYIJa3Mdu0tzpQyT2VINbvIgg/Nl4p4LU2VT
   MU1Cn7Z1zNiGKaaSNbDPuafjFFC71wVLoUbytL7mvZgWe2WE/feQHW4vf
   0e1QEEJXtpy4KyaY5sf8MyHKyZg0t+p1uSVb19QZ4UJb+dUkZyTtVgmMz
   Q==;
IronPort-SDR: N86Q/Ly69g/JA9aOteF9Phed3KZKctnW1eA+y4CRhAWQdo7kx3Cq8mQdq7Wj2jBnMNjXG0Ewaq
 c5kVThceS3aDgS2yvkjO++lOeueWLs53WWA98UhTo+XXZB24fb9sDXbOeN+9GaNQO86JFGXTPe
 1PuaYOiGnrdkZCcZGceRAd+slcWNBaSNBbPL8sVFMpfD28k4jeY+GEAXWVXX5tXDzfJ0iaMIfk
 m7sHsx1LS+J+1EtSj+i/PgT+xd4+1xCJrmKcj1vKG0wWs+rttiB3JDTHhHnJ/XEp6axRq/k6nt
 JYM=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="252173075"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 17:07:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSlev71DYirQKqHUyT92XkS1ysqDhbejFJYM1hI8kqSqVGNQaHu6677Cy3Lhvkt+j5ofSl5vWGa+0AaB227m+gWbpOwlp8NMYyCBieoLmgNWKG1WQS++BjIlTEsaGW5Bb8V0gRUyywxV7VEDZShBtGfYp4Yv7F9DYsxIxNJKtAxhKGzMXBOSyAXFIa6AXfNc4h/yCwrP2lPO1n+170me2h2/gOus2B+j5XJOQsbC9dvDeQYFuOijwppBFNv/eTK5cnKINVAZIwd4PXlvJaB8gVkM7EjgTBESM+2Z3X3K/RZ+ZiG56fAOxQimbpUtxDzhLqlqePrU4OirCt+z8vpfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOzoVrSWiOjqGE+CMmT2EiskOsXlgDZDeTA6RzHJhd4=;
 b=OWiQd02S6QtTyGLIUvioDrbsIY3RATEXJ8XppAqvBIQ5dCARwE3Fz8E6bEIGYmY8VE45LF9XF9gEZWNGSl6oXt78+7SoaiR78hNkfNiz+PY6CTJlK99kjaEPmf3RiYQAkxV7edcKejMg/r4JFxEqFnAL5LEYlK4O2kY0iyvVmGzvvvC8LI0GGHuyWExAirm+AY/G8bZzj15p04wnfZW9RnGzgf6rLee9/XBnD9kceF6lyfmW6tIlx2Fd/7lt+47xcVycGYMwJBSrTEkAbAU0fwFMgPxTNaNt3+Vdy6msR+mRWCAG8jFBXakuomdvi+w9U5+kUrRdVaK1Wkbc7LGJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOzoVrSWiOjqGE+CMmT2EiskOsXlgDZDeTA6RzHJhd4=;
 b=i+GSv+v5KwWMHNorJ5D4n1hGePWyjFNpb/XoK+d7UccBRYDMoKLliMgs2UGFocYz2F9r81ZetwJ/uvIl15woRVBXfgkbfcuGx3J3HO+5EaMmTbLxr9wSOIy3uOA9+TaTgXyHEc+7bYZy9ey5/khlWsbG1bbrEuPEZCQX/RnCrFM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 09:07:38 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:07:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: count pages after truncating the iterator
Thread-Topic: [PATCH] zonefs: count pages after truncating the iterator
Thread-Index: AQHWW10Zr7uU46NhfkCNdAFLYDBbkA==
Date:   Mon, 20 Jul 2020 09:07:38 +0000
Message-ID: <CY4PR04MB375103032433640A11A7CC6CE77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200716103723.31983-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94eae32f-59e2-4184-e0bd-08d82c8c59ca
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0727CECC2786472206863394E77B0@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:359;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qGer7yO0/C6yTEQARBVkLFbz2085E/KtGMjX0J9tscyZfoM5zgWGiOHgrXc95TeaTOKkYSuK7oHmQMtuSHM1Dk+sLL4gBV1FGDEgQSPmgsiwLBDQABoTZOgcXQ4MjsLV8XKAuuNSR8qr6yxDvFVs7gkBifdRgg4y1mTLSCvclAic56XC8U3kSLRMRamfePPHIhVf05f15QMEp0CWHiWa+Q/uQmuQtGYwuCN/QHGxh0yFqWDsUTYCov1nUAvAd0cBQ/gCrES/h1G6dCEiV7a2XW2+wK8YWL+92XmGJnedsPqlzBQCzgMUTRddxdZGShJwEt+PRJ4PZu7R5h9D4oEcKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(7696005)(4326008)(83380400001)(86362001)(6636002)(76116006)(66476007)(66446008)(66946007)(91956017)(66556008)(64756008)(52536014)(6862004)(2906002)(55016002)(33656002)(9686003)(71200400001)(26005)(5660300002)(53546011)(6506007)(186003)(8936002)(8676002)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CwHjTWydOwyS4vEkQ2d0CZCStSiPSoWrIzGuOuj33FLOGNf9J/mhPCJUi7cjMdsOCKM7FWkT+wli0cDnSpgciJLikl6ncNfdFd6JGxcpF4LHMeUM4Ojzch+BLbzEJh4EjMc/9kMTmuWyNF6MANOqYNrDZTnKTLnP8/RzfT9NThdgySFonhucG2LdBl25ex12mNA4+r7PmrzqfVNumzcbwAj22RDQvjItOACZu+6FwYoPGLHzsLRVNxz0H1vGrn8AxUgScTpBtIGPXQYjMzjPROxntDx7sadhFTGoZtqkfxGBOjobIFWpr3x+0YjMxJSLLlA8VMWq0bpykmr1aK8LlVPfu8dUqe+r5TTUcVWIyCxNhm9US4isuPj1npDxpsqJxeipRXXoc5+ugwSu9LKRJtHROGnH3TpdjOLtu6n4i7dJoi4qb8vW9R/sv1Bl8TCoEB14bPbgPms37Aia5WAGlUb3l3XSZE6YcGsXCh1Q5fSDwXuqkxlGS2OUAEsK4pUT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94eae32f-59e2-4184-e0bd-08d82c8c59ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 09:07:38.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiZDVUIBFDW6b8ygrmLJbkXL2M95O4Q7S+S6O9ZCvIESlFukd5t5wk5kH+fUCFg+d4b57GK0hP0O/uJ0mQHjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/16 19:37, Johannes Thumshirn wrote:=0A=
> Count pages after possible truncating the iterator to the maximum zone=0A=
> append size, not before.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c | 7 ++++---=0A=
>  1 file changed, 4 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 5b7ced5c643b..116bad28cd68 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -607,13 +607,14 @@ static ssize_t zonefs_file_dio_append(struct kiocb =
*iocb, struct iov_iter *from)=0A=
>  	int nr_pages;=0A=
>  	ssize_t ret;=0A=
>  =0A=
> +	max =3D queue_max_zone_append_sectors(bdev_get_queue(bdev));=0A=
> +	max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);=0A=
> +	iov_iter_truncate(from, max);=0A=
> +=0A=
>  	nr_pages =3D iov_iter_npages(from, BIO_MAX_PAGES);=0A=
>  	if (!nr_pages)=0A=
>  		return 0;=0A=
>  =0A=
> -	max =3D queue_max_zone_append_sectors(bdev_get_queue(bdev));=0A=
> -	max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);=0A=
> -	iov_iter_truncate(from, max);=0A=
>  =0A=
>  	bio =3D bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);=0A=
>  	if (!bio)=0A=
> =0A=
=0A=
Applied to for-5.8-fixes, minus the extra blank line before bio_alloc_biose=
t().=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
