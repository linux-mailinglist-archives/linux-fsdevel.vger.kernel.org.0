Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC4837F06C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 02:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhEMAiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 20:38:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38052 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245420AbhEMAfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 20:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620866078; x=1652402078;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jAe1MbaRE1Nw7wagUrN3RWiGqwec2wwHJxFy/ctdU9o=;
  b=Az56mtMtO6x5s5XQEkVliD+3YTci5/RCRZUlERk0HKVHs3nYbjwrhHBD
   EHv/mBBzk5Zad3hGs+XLHXMfXog5eVK/pUD12xVPuuMAJSmw4mZhkO4ue
   4u/4cvxUUNGMC2d2b6KRYpGreWeOur/VFj8v/UPepa8u1cl8OX7TQ6ZbE
   dUEfDcrpUN+nNbCHoy7wHBcbnXp0orEFGmWBp3v7qyLegvj/acaULrxLo
   RTG2WDgr6k0L7GYJDU0cf8UgqsVP7cnK966+aCQz1mRE3Bx+JIaTG6qwJ
   Ada+D6kujWJVt+hty6XQmEQJRTP1agrPuCB3jcTHm5FhXjz5QcRatfjQY
   w==;
IronPort-SDR: yO/o7iCgxwsHqdEJqwojD4psSV6AxyaqP1Kkh1O0/YrxuS/pk7OCeAZ2dTG4y4TmzvJ66F6AeB
 0cTydn7YjOKA8i3fBPsypCd2ojHg1/c1INjnd5m9lAumzRiCFUxhpzKmp9Nce6ZfAh11o2tUxp
 TtvdcidZpZaXeqsPhTJhTVCRdIiZnC1R8RHXVtSvVuWAgi8gKfTjDAaJvokC7EaeuJcolM2QOA
 Rr/wnAywcg+IfPi/oUYnWalC31wEhOFjizYP2H4pRRxHpigDBsIu883zSylGfZBkIYCecX4F4B
 v8k=
X-IronPort-AV: E=Sophos;i="5.82,295,1613404800"; 
   d="scan'208";a="168538232"
Received: from mail-bn8nam08lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2021 08:34:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kecoKkiV8yVM1KXMG62Hsw0SFeJQeK1ht+fNKFxw7939eUod7/E7IEk8FYcHtgS1jjUsWp4j68YB0AQuS2TYhm0sp/DhxM2brzv319WI5XMW5rXERVHAh/1xpwTfXegAWlkPniW9H7jZpRqAscsun5O12yphcJvUTiOYtvy6lZ3fBiHhWtAkIbofdbk4Hgu8f5lnr6f+ByAYRf5eY5BXhhu5mQQIDkEMYIQDvHAhf6RSEAbdv3u2+tEjYIehkdrwlw5f2fiiuw6i11c5Du0lh/LHS9NUuqpymFR7RK3u5ZkG51SwFBLZzJHNSBH4jlelazDhAC8P2w9pMrnHHWFaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anHHAbPrbiGRmJszWJ2DjbgMiQlyg1MODOcEQtk2Hfk=;
 b=N1HrgtD4JUi0foWGSOtccDONIeZkp513On3RSCqrfYkyO81gzMO1Y6f8VNxA8nP1QLQlFNqNq20y+Sh5ZPto7/Dx8ZqP4y5Lcv6VKKvwF518ZfThur1/m1RUsDe/zyUmi8mdCqCA516/rm7JZf9MZx+H+r/BTy1shOfSYCo4zA7JVdldQviQUztCJIiCLlhBGJ4NH7GoMpX9PowYSJseeH68vlbGH2hlIyVcW9yg2MAO/act7rmkhhL1lm+MbNgeBYM8n1rjY6jmaWXplvPjViKkp3Bq9/c3Wy18TgCy6GrhHzQW4NNMbjrZ8lCW8ezGk7R9voc9RWCZDzOpDOseSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anHHAbPrbiGRmJszWJ2DjbgMiQlyg1MODOcEQtk2Hfk=;
 b=nfGDeSuQ1qCGvbl/xJtkKZNwL3smXh1Y7E5nLFgtNxySKM4foy7HB7SxTTyIWCOZIyFmSo/N7LtSTLFpcq5V2bDSntbUBgWIYwfGfOaZ7X5m6agzTMbyWTPm63ScMs/13ex3cd5+8HyFMtRERV+Hqd/dntyMCR5rjAqc0/VWA6U=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0813.namprd04.prod.outlook.com (2603:10b6:3:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 00:34:33 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 00:34:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 07/11] zonefs: Convert to using invalidate_lock
Thread-Topic: [PATCH 07/11] zonefs: Convert to using invalidate_lock
Thread-Index: AQHXRzU+qXklL5tXkka8lKRMD3f5wg==
Date:   Thu, 13 May 2021 00:34:33 +0000
Message-ID: <DM6PR04MB70813581E891647A893FE741E7519@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-7-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:dbc:763e:6fbc:5b5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f8a851b-a28b-477d-0fa4-08d915a6e13a
x-ms-traffictypediagnostic: DM5PR04MB0813:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM5PR04MB08134D0F0545A4ECD3D5B6ADE7519@DM5PR04MB0813.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gyfTusqq1svA5stoPogo4LcwpoIP60ewdwTnQQmIAZwWcACtXomhgyMk34XxNym0/DLnnMPnTxhZB7QV1R5Jjy5zhKFhggw0ZeXiOyUYwi8lyQUHnfTRVU1TCboGTZTNY464jpYnMIwNATPLlZutIGk3k6MiF97jZ2VqwCJy7gn3AJHPvnRGEj+O1paj4yRuqF+pJBm9A8yIlupoFnNd6WmI3qbImASX3BLNSsr0uUeuG+J4OuoNggVJcvL47rfqXnN0/ojOrgU70N7I8r9RJKQb/ERkC4EW1yhbCkRJrSyqcXPLpZ47ELV6ZqHLFyCFQREliuDx7gLAP/nTQlk44EfWEzqf4CH7PE+lEMMGpRFd521h3Cx4/yVBSFHfhL1vDwLvfqUdCXAHs0iiq9gIXWbyPoLrvL35n0gAWKWN5Ex/W2GRws1szHVYeyDCugLSfsqxGNLvJLDIPgahw+Z2YmKz8lCkNwkk35Y7QBVXx9QlxyyclZSErrBf2tM6jXbjqXI4O3hoHUcsc4w022UfuWOHKYNJzZzT6iWVgnvqY7NlMvHXDb9FtsAqr5gucAzbiMKR8JyxLdSzgnD8BXSM/cIBmunESPdltVkQe4i5RGY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(64756008)(66476007)(6506007)(91956017)(186003)(7696005)(52536014)(5660300002)(66556008)(54906003)(86362001)(110136005)(66446008)(316002)(76116006)(66946007)(71200400001)(478600001)(122000001)(38100700002)(2906002)(53546011)(9686003)(55016002)(33656002)(83380400001)(4326008)(8676002)(8936002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xVvSD4j7elIy6AE6R7OrcMscjfG8m+h/9thVsuQSeQ3JIYi79tjqJF/GHmAM?=
 =?us-ascii?Q?YifAUYHcK1LaH7H+Im+DudduLroyhkhcFoAiaGQnFRSOLROa/PicDM3kWJXr?=
 =?us-ascii?Q?B/hOH9QrNcWWGSefqabSb8m3nNCXn7s+M5VtpsDAoB3GHPNPD4a9YXS26qEv?=
 =?us-ascii?Q?jZyCBrj5E97uOCnUJfib4JgZeMDYNBRvOe5eOvB/YaP5I9410RHazrgaohTw?=
 =?us-ascii?Q?7tKsxlL8royHcvB0JJH7wME7V2TcubRnIewX1Ftgn/DazX3fdccyJTaABdWG?=
 =?us-ascii?Q?eNU6vXm4rGCvFgj/LUEcInivtBJ7TPo2pJV3c9kFYIT7FnYKKtHYrb2OSwet?=
 =?us-ascii?Q?RTwTGYeoXYTqNk+jnFTN4wLUjGvzmiNPUWV8l43ocOT4bhlOdAIJU6ZMengl?=
 =?us-ascii?Q?ao7xklc6wZ0hX+xgFBj0BCj+vVK2LKElrqAhMIMazXBpytNvx4/1vlcF0OXB?=
 =?us-ascii?Q?o7WsSIPd6kMgyj5baw2hd3C09Y41q2tOina/9jKjpQ/sPt5OpaotQrYL774b?=
 =?us-ascii?Q?OWs18ecfj2r23pDOKKCOH3n22Ey9abDPxnpPX2O1eO3NKnvcbsfQFc3Q6DT7?=
 =?us-ascii?Q?GCaD1EFZIWiOeu6LZ4Mw9JvYq7GIEMlaNLoQxxyMFVLC49PGTKBytxppuCC3?=
 =?us-ascii?Q?RCO1fPt4YdthYuW3MyEoMSTAbBNnA+iVWzBuwtkISupqU+6y9f439AAK/0dT?=
 =?us-ascii?Q?CVHvmsWp2hVrzuHyM3Rs5p86AvkwTltoyc/QFI7tiwaI+N9wuRwzX1+7CmQq?=
 =?us-ascii?Q?UnB8v7eK+YxiSve2BiaQFaJU5ElvmR+6u6axedq0dv5IsRupOjssku7dC2vB?=
 =?us-ascii?Q?32mbMEXDG6ysYGrP+JZkdHm8+WeNrQ/Q1dcllEey4tpSE/hk0MdNiyURkWW4?=
 =?us-ascii?Q?BzhVhFrxo89J8ZiSvc9N61yWmjKEtLPbe+BROGTowOtPVwhiFad41X7ojZU1?=
 =?us-ascii?Q?N1QkEL8MuC4zmhLaVB+I8os0SPlPwVxslDBu91W5CArLRFdzQoOlHPVxnbZP?=
 =?us-ascii?Q?GQYhU/WMa/kb3EY7KFQNtihF509FDP8Se5YhCOH3jFZhCBbkFz3YfM7jOj5L?=
 =?us-ascii?Q?xXyiKmBRtBPNRvW/3M9I/47ny+8T3eV5/o3fxXzV1Pj8ZdEDQRepNk97wL7b?=
 =?us-ascii?Q?GwTPS9Ueq1+L7vn2BTRd6tYB3YQVqwX/1qSgxNgcN014TEUY2DEI1w0ZkFFB?=
 =?us-ascii?Q?yqM9XZf5hsoA7ojVoM++16aCf1JVk3+X9q2Ww+UD1BHMPCk+hwEa3mIrVnrK?=
 =?us-ascii?Q?QhhzPtP3gn9yiSNR8IuZXAq2zxSPu6rBHlEHLQyDi7lGzH+opR4S0skKwG71?=
 =?us-ascii?Q?TNf5v93/48V3pN7FHDWpZMpuWFmsFC5Vddx6RiV6Si7DFcOQbDWMFf1xPvUX?=
 =?us-ascii?Q?qVbi6+L4XvHI/1rfKeBsH3bIXAZvyklmaR/i+Mlkiy08uc0apA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8a851b-a28b-477d-0fa4-08d915a6e13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 00:34:33.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltRJzvAvGXVvXjosAbmERv3AR4aVfhIA0oPp1ciTNez8X2y2+9Tx03D3+9r1TbAqKhL6mr0XkfkNfnRS9mme4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0813
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/05/12 22:46, Jan Kara wrote:=0A=
> Use invalidate_lock instead of zonefs' private i_mmap_sem. The intended=
=0A=
> purpose is exactly the same.=0A=
> =0A=
> CC: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> CC: Johannes Thumshirn <jth@kernel.org>=0A=
> CC: <linux-fsdevel@vger.kernel.org>=0A=
> Signed-off-by: Jan Kara <jack@suse.cz>=0A=
> ---=0A=
>  fs/zonefs/super.c  | 23 +++++------------------=0A=
>  fs/zonefs/zonefs.h |  7 +++----=0A=
>  2 files changed, 8 insertions(+), 22 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index cd145d318b17..da2e95d98677 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -462,7 +462,7 @@ static int zonefs_file_truncate(struct inode *inode, =
loff_t isize)=0A=
>  	inode_dio_wait(inode);=0A=
>  =0A=
>  	/* Serialize against page faults */=0A=
> -	down_write(&zi->i_mmap_sem);=0A=
> +	down_write(&inode->i_mapping->invalidate_lock);=0A=
>  =0A=
>  	/* Serialize against zonefs_iomap_begin() */=0A=
>  	mutex_lock(&zi->i_truncate_mutex);=0A=
> @@ -500,7 +500,7 @@ static int zonefs_file_truncate(struct inode *inode, =
loff_t isize)=0A=
>  =0A=
>  unlock:=0A=
>  	mutex_unlock(&zi->i_truncate_mutex);=0A=
> -	up_write(&zi->i_mmap_sem);=0A=
> +	up_write(&inode->i_mapping->invalidate_lock);=0A=
>  =0A=
>  	return ret;=0A=
>  }=0A=
> @@ -575,18 +575,6 @@ static int zonefs_file_fsync(struct file *file, loff=
_t start, loff_t end,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> -static vm_fault_t zonefs_filemap_fault(struct vm_fault *vmf)=0A=
> -{=0A=
> -	struct zonefs_inode_info *zi =3D ZONEFS_I(file_inode(vmf->vma->vm_file)=
);=0A=
> -	vm_fault_t ret;=0A=
> -=0A=
> -	down_read(&zi->i_mmap_sem);=0A=
> -	ret =3D filemap_fault(vmf);=0A=
> -	up_read(&zi->i_mmap_sem);=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
>  static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)=0A=
>  {=0A=
>  	struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
> @@ -607,16 +595,16 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struc=
t vm_fault *vmf)=0A=
>  	file_update_time(vmf->vma->vm_file);=0A=
>  =0A=
>  	/* Serialize against truncates */=0A=
> -	down_read(&zi->i_mmap_sem);=0A=
> +	down_read(&inode->i_mapping->invalidate_lock);=0A=
>  	ret =3D iomap_page_mkwrite(vmf, &zonefs_iomap_ops);=0A=
> -	up_read(&zi->i_mmap_sem);=0A=
> +	up_read(&inode->i_mapping->invalidate_lock);=0A=
>  =0A=
>  	sb_end_pagefault(inode->i_sb);=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
>  static const struct vm_operations_struct zonefs_file_vm_ops =3D {=0A=
> -	.fault		=3D zonefs_filemap_fault,=0A=
> +	.fault		=3D filemap_fault,=0A=
>  	.map_pages	=3D filemap_map_pages,=0A=
>  	.page_mkwrite	=3D zonefs_filemap_page_mkwrite,=0A=
>  };=0A=
> @@ -1158,7 +1146,6 @@ static struct inode *zonefs_alloc_inode(struct supe=
r_block *sb)=0A=
>  =0A=
>  	inode_init_once(&zi->i_vnode);=0A=
>  	mutex_init(&zi->i_truncate_mutex);=0A=
> -	init_rwsem(&zi->i_mmap_sem);=0A=
>  	zi->i_wr_refcnt =3D 0;=0A=
>  =0A=
>  	return &zi->i_vnode;=0A=
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h=0A=
> index 51141907097c..7b147907c328 100644=0A=
> --- a/fs/zonefs/zonefs.h=0A=
> +++ b/fs/zonefs/zonefs.h=0A=
> @@ -70,12 +70,11 @@ struct zonefs_inode_info {=0A=
>  	 * and changes to the inode private data, and in particular changes to=
=0A=
>  	 * a sequential file size on completion of direct IO writes.=0A=
>  	 * Serialization of mmap read IOs with truncate and syscall IO=0A=
> -	 * operations is done with i_mmap_sem in addition to i_truncate_mutex.=
=0A=
> -	 * Only zonefs_seq_file_truncate() takes both lock (i_mmap_sem first,=
=0A=
> -	 * i_truncate_mutex second).=0A=
> +	 * operations is done with invalidate_lock in addition to=0A=
> +	 * i_truncate_mutex.  Only zonefs_seq_file_truncate() takes both lock=
=0A=
> +	 * (invalidate_lock first, i_truncate_mutex second).=0A=
>  	 */=0A=
>  	struct mutex		i_truncate_mutex;=0A=
> -	struct rw_semaphore	i_mmap_sem;=0A=
>  =0A=
>  	/* guarded by i_truncate_mutex */=0A=
>  	unsigned int		i_wr_refcnt;=0A=
> =0A=
=0A=
Looks OK to me for zonefs. This is a nice cleanup.=0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
