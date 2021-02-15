Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790D331C27F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 20:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBOTec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 14:34:32 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35010 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBOTeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613418389; x=1644954389;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JZNf8iDqTRdLAzHrCQfw7GZDcy6HjgwwEOQKDKVvJso=;
  b=mLfE3GCxyv1Sww1UniyKZ7UvtZknmrHWA5mCdqJwL3DCWuWW3l3WNZhw
   YdEuFxB4d8x8h07tTgRbGi/CClXH9ntPKLEM9agOnWbCtaNqjjcPf6Uqe
   XaJ3Lw263gkaWok+LUaWEHlXjY9WAWgL5/ySdE1/pjDCRNgNZP4PEAuZi
   E2lgKziFXtfbmOSrwk3L3MoEIjWfIBscPxSOI4afKC5Uq0DnbXPTUxanq
   VUL6vojXXZXvj/835OjOYE7UrBXU27wKF+HC6qLr69iLEc+r0ml8wYONU
   x1PvkbfUHCsFoXpPstokDRZgktu++jhkKOPY5gRx2ghiJ+AliK00w+jVu
   A==;
IronPort-SDR: T6JrDboLtGNpqj64WQytDsL8SBSN8Q9FDz+YZk9mhOqfMYfevhgxxH/vCgEFf3rtBmrJfdAKym
 LKCs3NA3/rGIjkpY+IabJEhsGrb5PO4SFLlPloCktLj4m2Puts/2FwOQsamaYW9JNP5nuGD71A
 hJBj+0lNYdL1vQyXfyLAPvixAYERyZlp4ETLsgB/pP04V8hg9RizrzQULO7n6EBlO8CAEqbJ+j
 ggZMKlXZRSH46+bIFKrlRueoAQ2zJJZkraPEy+x5veXHuxTKp9eaxDaeimBglfY5gwTbBuFAul
 C5g=
X-IronPort-AV: E=Sophos;i="5.81,181,1610380800"; 
   d="scan'208";a="264164402"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2021 03:44:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPShWPuD2k3fXp3l9tw6SLKLDd126oIQVPiX9QTt53HDoIuFrtiK5JQDTpKtu3y3S0HfBjc64p9m2qOqxtMxn9OemfaaW0JzCK7+IlZM473KEirs2TI+zK/ic614HOmO2eAnCBX+FuC7MeFmyFyxZGPXK+toWWj4E9FZiprp6Scqxz7cwSNEWwB/t2Weg1ILBIt8Toaj+r6mJygew+kcjQ/ey2jMw3tVxso0kZlov1EZDwk3LFuzMgWgQh6yBKWOjY/utZX5MfJDdqAcuI5mOpncYqjgM1wnd/XMCBKr8Hw6F0eNfSBUc/N5FvHz8jYqgeBZytDQU+NC8mchVv6ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEZ0+ck5Bi1sIDbD+m0GKcQzgeP7oJZ8jKpSfyLdwXA=;
 b=QnkisCK8PnMK3GdEvW3UG74MOZJvwdy6jpym5Krl7MVJSvc7W05gbllYyZJVHC4ohOswH6nqs9m4SW/A0jsFvox9BH+XpWhD6XsW5ckH1nRvOEkNHtklllxrVF4DCFJzbnYkurR8PH8X9eHfNNDw8b05QbqEy+qjp4plh4JKaAoXlnDWvTvDnCugT4WsdCJaUgs8GMVkU/1Ht8YDolzNcweaz/Jt4UCNAxRoTLYgmm1i0zKA5OaWtl5gfHHNbXrylVHvKfYeXWjWk8X1BpUQAkl1RaXFKbdRl6Yt6cFaZIn7o2XLa07a0NuAFatK+yLEhiSE3CGqsSLNXbabASpj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEZ0+ck5Bi1sIDbD+m0GKcQzgeP7oJZ8jKpSfyLdwXA=;
 b=qBA47U61vK1G4cTbS3Xv96u2W16kwiRK9kn60TmVlfGs9TJ9KYwuANbHpqDQtfIVO5pIUmeDIROKtrFwNFfK9bRDOrkeoCnSloenFJ1/8y2euplRFnNAFkvmTTCzQgEe/2cTUeOolJwaUTr4BYuj2CEz/cUM65jpDB7/cyxADLI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5896.namprd04.prod.outlook.com (2603:10b6:a03:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 15 Feb
 2021 19:33:13 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Mon, 15 Feb 2021
 19:33:13 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Hyeongseok Kim <hyeongseok@gmail.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] exfat: add support FITRIM ioctl
Thread-Topic: [PATCH 2/2] exfat: add support FITRIM ioctl
Thread-Index: AQHXA1MGBqI38WrzyEuQdLGPmIADTQ==
Date:   Mon, 15 Feb 2021 19:33:13 +0000
Message-ID: <BYAPR04MB4965FC5CBAF7DB2BA1DA4FB886889@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210215042411.119392-1-hyeongseok@gmail.com>
 <20210215042411.119392-2-hyeongseok@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c2d5061-517d-482e-e8dd-08d8d1e88917
x-ms-traffictypediagnostic: BYAPR04MB5896:
x-microsoft-antispam-prvs: <BYAPR04MB589645A6D080FFD4B1FCCE7086889@BYAPR04MB5896.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogJ2NIOOh6RPjlNRHCXnDr7VAJEphhNyARrWcDBmtTUPfnFkDcsze3EhF0Iut/z5vsb1ZFvPeUwS7dD46qBHjY/Tmp/EFSOms3BJcrr8RYDv92wvIbgaCCEDHJOpzUULzmC3UdeOV3mZDTxrMP9wVTvnnMpDyN2vCZiMJHMOjWdVehOFllxvDKjA7mDoD5RIrfTK1DlPiJQ3TvtKoDSO+8m33CUfTuZL92tUn0x4kze2wYwcAiVbFR44sOCXsPIZpJAZtxsspHKJPkOkDRNhBcDr6XGa1L0+8NhoUzM9IuTwKIVoPamkkvn0cPHISkTr7YKoa2xQ8xKPtrDxihO09qh+bTD6U7jqHiWftTq1Vni0xrvi2t07h5uvbhwmbH76eMXRFytczzUM3lOLGcGPVeMg4toZJAaBReV5kjj3OzT8A/UcaNOyhbDVjzMYhMTXxx/yT8f3eacXOvns9EuRcHfHvhsNWYWtNNTR+tP5G0YV7c834FrVlfm2t2mQf8qJSRYXg8YAqozQdHzPxgSdPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(8936002)(6506007)(53546011)(55016002)(9686003)(71200400001)(2906002)(66476007)(26005)(86362001)(33656002)(5660300002)(64756008)(478600001)(66556008)(66446008)(186003)(8676002)(110136005)(52536014)(83380400001)(4326008)(66946007)(316002)(76116006)(7696005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OTu8DF31sLGzepA+JOBP6PXyIYLUv7YSmNCO9eZttt1LdZHMtcWxrs1Pwf2w?=
 =?us-ascii?Q?sbBqisWJamsELszsZT3HX205xQ2Cb05TfQ1vAF4wmQUwhsx4U6tLnhR4mhbv?=
 =?us-ascii?Q?C2K2svOrgM0PjSrb30iQs8ydyd/8U5gL2zC4NlFGQw+9dO+Y/PVRQM5yJx1Z?=
 =?us-ascii?Q?nmiJCp7VGP3KZyqGrf5R+sh+3b3W3CT4bQx2IWC6l77vFsgFw81q/g4WA/CX?=
 =?us-ascii?Q?Dj+8J7N7m09QaTAnyVDjb8SH8IbxEy00EsjTdO2cAlosKeNXbFRWM1CEv65G?=
 =?us-ascii?Q?8WUuyaQogmYFkzv8tY38SWAwsTfFfHQWDGtg+pX7YuBSWifIIKENZS7G39Dm?=
 =?us-ascii?Q?mYbgmxjkHAdQvRdHmsxhuVpRBxRaEcO18UYGmjYostdgs8+fAgoCTfePs2Jy?=
 =?us-ascii?Q?h0Xz8TXHtYCzHGCPGvtZiQkHRo3mQ9euF+6lwDIiHsdgvYcE/DmD+3MEQZO7?=
 =?us-ascii?Q?+QeT9AB+328tmqVsmfUBeXuIQRAHRJco8weiaNCh45ajuA7R2lv+hWHoMWrq?=
 =?us-ascii?Q?4qHunu8NBHV+z4r8vsYxeQJWSLLe7bXBKKhJ8aeV6tvsbBAA3ALEFeFDJ9VA?=
 =?us-ascii?Q?MlQapemGQ01mGpBabGOLjgDRIK/U9VRqLvmJpH4EVz+Ivlr7FYQ5q9ZFfQuj?=
 =?us-ascii?Q?28sJ/5s8lE5HnFKvhWr0Q4L6kDCb809+0DHcHjuTTe/yC+s5R8JCwZCCoLk8?=
 =?us-ascii?Q?mbZEylBBOGFSpIofFfAESRnifKJHIYHhLxaycz2fylMwLiZsrDChSjKu8H+I?=
 =?us-ascii?Q?YSDBhm4jSuTqBajgtUeTM4/G9F4tzrJQEmtGEkXsELQ67alnrj8/QYRqjtbP?=
 =?us-ascii?Q?JLE7qXsXWZH41NhXOIX8XqmXrBdFJV0xWeSfvMZX8VMHOXcLi0/zNvnil7CB?=
 =?us-ascii?Q?0LkkQ8I2LnR2xZAldy8uCyTQme/oGTWXtKGHCU+tH3ABj2DXIm0HjqXyjWhy?=
 =?us-ascii?Q?aTIaCaYRvgc55niehlp5n4SQDHYeNBPigk3tliINL6JwDhv4sKq7ocyNyseN?=
 =?us-ascii?Q?iN6Tsh8V6EejrRdHHT49jSYrLI1PEio8Rrr6i66Ka0zcDrYCrByk9y6XG/At?=
 =?us-ascii?Q?Sfx0QmfcUod8vZeTaSn5Z67LNOUHKl6XLROXsNfgpJAXBLUMvU5K8wJ/KWB5?=
 =?us-ascii?Q?BW8Hq4ENCA0GyR+SnzXaIstoydcTV/brCzwLh8t7IiMbXpmKSkyqQz79P2DU?=
 =?us-ascii?Q?bW8Rnr6Aw6uhYIWMmTwvY4b7BO73PjVZv5zEpY2hUFpMgTnXe6UfWR8bbMr3?=
 =?us-ascii?Q?zs4FOp2zfQwlqQkwkpa134cjH8bVnrsnPKR2lsDY16FwvEe8rnYSQCccwZye?=
 =?us-ascii?Q?Wvkrxl9wC/Dl5zNPESH8UegL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2d5061-517d-482e-e8dd-08d8d1e88917
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 19:33:13.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZsrNeflYFxYQbl5xM8XD5Lr5wkNsWb4N7EyevdFPCkEfVveaVXlLpe5n3gzvmZJdHqS5r5VkAFc0oDgzeN/zFuH1s6m4tj8B3x8NTyeW4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5896
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/21 20:28, Hyeongseok Kim wrote:=0A=
> add FITRIM ioctl to support trimming mounted filesystem=0A=
>=0A=
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>=0A=
> ---=0A=
>  fs/exfat/balloc.c   | 89 +++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  fs/exfat/exfat_fs.h |  1 +=0A=
>  fs/exfat/file.c     | 33 +++++++++++++++++=0A=
>  3 files changed, 123 insertions(+)=0A=
>=0A=
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c=0A=
> index 761c79c3a4ba..edd0f6912e8e 100644=0A=
> --- a/fs/exfat/balloc.c=0A=
> +++ b/fs/exfat/balloc.c=0A=
> @@ -273,3 +273,92 @@ int exfat_count_used_clusters(struct super_block *sb=
, unsigned int *ret_count)=0A=
>  	*ret_count =3D count;=0A=
>  	return 0;=0A=
>  }=0A=
> +=0A=
> +int exfat_trim_fs(struct inode *inode, struct fstrim_range *range)=0A=
> +{=0A=
> +	struct super_block *sb =3D inode->i_sb;=0A=
Reverse tree style for function variable declaration would be nice which yo=
u=0A=
partially have it here.=0A=
> +	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +	u64 clu_start, clu_end, trim_minlen, trimmed_total =3D 0;=0A=
> +	unsigned int trim_begin, trim_end, count;=0A=
> +	unsigned int next_free_clu;=0A=
> +	int err =3D 0;=0A=
> +=0A=
> +	clu_start =3D max_t(u64, range->start >> sbi->cluster_size_bits,=0A=
> +				EXFAT_FIRST_CLUSTER);=0A=
> +	clu_end =3D clu_start + (range->len >> sbi->cluster_size_bits) - 1;=0A=
> +	trim_minlen =3D range->minlen >> sbi->cluster_size_bits;=0A=
> +=0A=
> +	if (clu_start >=3D sbi->num_clusters || range->len < sbi->cluster_size)=
=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	if (clu_end >=3D sbi->num_clusters)=0A=
> +		clu_end =3D sbi->num_clusters - 1;=0A=
> +=0A=
> +	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);=0A=
> +=0A=
> +	trim_begin =3D trim_end =3D exfat_find_free_bitmap(sb, clu_start);=0A=
> +	if (trim_begin =3D=3D EXFAT_EOF_CLUSTER)=0A=
> +		goto unlock;=0A=
> +=0A=
> +	next_free_clu =3D exfat_find_free_bitmap(sb, trim_end + 1);=0A=
> +	if (next_free_clu =3D=3D EXFAT_EOF_CLUSTER)=0A=
> +		goto unlock;=0A=
> +=0A=
> +	do {=0A=
> +		if (next_free_clu =3D=3D trim_end + 1)=0A=
> +			/* extend trim range for continuous free cluster */=0A=
> +			trim_end++;=0A=
> +		else {=0A=
> +			/* trim current range if it's larger than trim_minlen */=0A=
> +			count =3D trim_end - trim_begin + 1;=0A=
> +			if (count >=3D trim_minlen) {=0A=
> +				err =3D sb_issue_discard(sb,=0A=
> +					exfat_cluster_to_sector(sbi, trim_begin),=0A=
> +					count * sbi->sect_per_clus, GFP_NOFS, 0);=0A=
You are specifying the last argument as 0 to sb_issue_disacrd() i.e.=0A=
flags =3D=3D 0 this will propagate to :-=0A=
=0A=
sb_issue_discard()=0A=
    blkdev_issue_discard()=0A=
        __blkdev__issue_discard()=0A=
=0A=
Now blkdev_issue_disacrd() returns -ENOTSUPP in 3 cases :-=0A=
=0A=
1. If flags arg is set to BLKDEV_DISCARD_SECURE and queue doesn't support=
=0A=
   secure erase. In this case you have not set BLKDEV_DISCARD_SECURE that.=
=0A=
   So it should not return -EOPNOTSUPP.=0A=
2. If queue doesn't support discard. In this case caller of this function=
=0A=
   already set that. So it should not return -EOPNOTSUPP.=0A=
3. If q->limits.discard_granularity is not but LLD which I think caller of=
=0A=
   this function already used that to calculate the range->minlen.=0A=
=0A=
If above is true then err will not have value of -EOPNOTSUPP ?=0A=
=0A=
> +				if (err && err !=3D -EOPNOTSUPP)=0A=
> +					goto unlock;=0A=
> +				if (!err)=0A=
> +					trimmed_total +=3D count;=0A=
> +			}=0A=
> +=0A=
> +			/* set next start point of the free hole */=0A=
> +			trim_begin =3D trim_end =3D next_free_clu;=0A=
> +		}=0A=
> +=0A=
> +		if (next_free_clu >=3D clu_end)=0A=
> +			break;=0A=
> +=0A=
> +		if (fatal_signal_pending(current)) {=0A=
> +			err =3D -ERESTARTSYS;=0A=
> +			goto unlock;=0A=
> +		}=0A=
> +=0A=
> +		if (need_resched()) {=0A=
> +			mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);=0A=
sb_issue_discard() ->blkdev_issue_discard() will call cond_resced().=0A=
1. The check for need_resched() will ever be true since=0A=
blkdev_issue_discard()=0A=
   is already calling cond_sched() ?=0A=
2. If so do you still need to drop the mutex before calling=0A=
   sb_issue_discard() ?=0A=
> +			cond_resched();=0A=
> +			mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);=0A=
> +		}=0A=
> +=0A=
> +		next_free_clu =3D exfat_find_free_bitmap(sb, next_free_clu + 1);=0A=
> +=0A=
> +	} while (next_free_clu !=3D EXFAT_EOF_CLUSTER &&=0A=
> +			next_free_clu > trim_end);=0A=
> +=0A=
> +	/* try to trim remainder */=0A=
> +	count =3D trim_end - trim_begin + 1;=0A=
> +	if (count >=3D trim_minlen) {=0A=
> +		err =3D sb_issue_discard(sb, exfat_cluster_to_sector(sbi, trim_begin),=
=0A=
> +			count * sbi->sect_per_clus, GFP_NOFS, 0);=0A=
> +		if (err && err !=3D -EOPNOTSUPP)=0A=
> +			goto unlock;=0A=
> +=0A=
> +		if (!err)=0A=
> +			trimmed_total +=3D count;=0A=
> +	}=0A=
> +=0A=
> +unlock:=0A=
> +	mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);=0A=
> +	range->len =3D trimmed_total << sbi->cluster_size_bits;=0A=
> +=0A=
> +	return err;=0A=
> +}=0A=
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
> index a183021ae31d..e050aea0b639 100644=0A=
> --- a/fs/exfat/exfat_fs.h=0A=
> +++ b/fs/exfat/exfat_fs.h=0A=
> @@ -411,6 +411,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned in=
t clu);=0A=
>  void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync=
);=0A=
>  unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int=
 clu);=0A=
>  int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_=
count);=0A=
> +int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);=0A=
>  =0A=
>  /* file.c */=0A=
>  extern const struct file_operations exfat_file_operations;=0A=
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
> index 679828e7be07..61a64a4d4e6a 100644=0A=
> --- a/fs/exfat/file.c=0A=
> +++ b/fs/exfat/file.c=0A=
> @@ -351,7 +351,40 @@ int exfat_setattr(struct dentry *dentry, struct iatt=
r *attr)=0A=
>  =0A=
>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)=
=0A=
>  {=0A=
> +	struct inode *inode =3D file_inode(filp);=0A=
> +	struct super_block *sb =3D inode->i_sb;=0A=
> +=0A=
>  	switch (cmd) {=0A=
> +	case FITRIM:=0A=
> +	{=0A=
> +		struct request_queue *q =3D bdev_get_queue(sb->s_bdev);=0A=
> +		struct fstrim_range range;=0A=
> +		int ret =3D 0;=0A=
> +=0A=
> +		if (!capable(CAP_SYS_ADMIN))=0A=
> +			return -EPERM;=0A=
> +=0A=
> +		if (!blk_queue_discard(q))=0A=
> +			return -EOPNOTSUPP;=0A=
> +=0A=
> +		if (copy_from_user(&range, (struct fstrim_range __user *)arg,=0A=
> +			sizeof(range)))=0A=
> +			return -EFAULT;=0A=
> +=0A=
> +		range.minlen =3D max_t(unsigned int, range.minlen,=0A=
> +					q->limits.discard_granularity);=0A=
> +=0A=
> +		ret =3D exfat_trim_fs(inode, &range);=0A=
> +		if (ret < 0)=0A=
> +			return ret;=0A=
> +=0A=
> +		if (copy_to_user((struct fstrim_range __user *)arg, &range,=0A=
> +			sizeof(range)))=0A=
> +			return -EFAULT;=0A=
> +=0A=
> +		return 0;=0A=
> +	}=0A=
> +=0A=
Is {} really needed for switch case ?=0A=
Also, code related to FITRIM needs to be moved to a helper otherwise it=0A=
will bloat=0A=
the ioctl function, unless that is the objective here.=0A=
>  	default:=0A=
>  		return -ENOTTY;=0A=
>  	}=0A=
=0A=
