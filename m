Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7736AC4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 08:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhDZGl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 02:41:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19029 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhDZGlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619419244; x=1650955244;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hnxL51SdrZbrsLECwIdqsRy6ECvLUw+SJI77Yhs+RS4=;
  b=jlbEiG4m2N+2fy3LxU1GnWG+pdh/rvx+Hl7D9Xex3IJw+1RKtoDIfkKq
   9mNgblNv7CB0LJlZHzGSSlLhGMLRy8X8dnUZLsAtNDbED1X+Z/G++VN0e
   KA+r2bBz98+rKvRefFRRtdRs+LROvt7tDjuw5MfkKSknR/vt7I/qsvXLm
   6141cZsQWhcfBuzOCYIGJzZIoEcW2N/BnS1zABtOXl7UB2KLgN1styJBh
   N17di4hzZi7J+52WBxZz386nWeZxp25W8dHuQ65tDvACq4MOgeVGPJhNd
   8SvN/qoJ2kIrDLX1vjrF8Ep6n2mOeZkjB0TLOY3Z59rJ6J0n5yyWkSA+Z
   w==;
IronPort-SDR: Q2/+ldAcM6xscVQHcG+pHfYCPJNQ7chQGcKFlkAaj3TT48ZjIz5k66GDFviPUZ1CeJkOjwiAMY
 HnQ9c1n1qJhElBWf0RxITChvuayp9AXQC0teVvHtJqb6Dc2BV5pYa8kaWceQ2MKD2+L4yVOc2O
 nvnir1NzU8SvEAs2yVmyFOT1oZpKtPbvjgTQmvBV32HzQw3WazbLL/YfVVrP6K/6MVdqusXMTJ
 5yLvUuwzlWPO4R6r2uhC/AO6Gf/Le0abe8CLJJ3pgWOal1qNM/fX+67Kq6ryfxG5svFyN4mMtn
 vlY=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="277244729"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:40:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFdP0h6J0vRe5rg6iIiXc8CqNtlYzKoiCz4j8IUbJap3QtaC5NlCJ3byPpj6B1QyfZXE84Sa/8o43ByOa2rinw1VUlCb7JKAmSoxp/pPZVtr1ckuHgBBw+0NSjnfm66FcCyVWFx5a+0KRA4mORHHU7npamFCSJvMcdHTMdIC15+MAaAkr4NpEfcIAGqtrM9rELY3x7nffKH5r5/wFM/9/JLWxh8bZGY6rjZT3BdfEZD3/ZQm/cFqZ+zIrFkwopM6+TGk5KqTqQv3zT9LYGT4iNfd7XDkVT5jHXlnO7qJ4uHpMKovOOzXWaMw/JtBqh2JjLwnGx6NqK5Gr/hTAJsH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLfj4fRr2pc0Me9wKO19hRK3gy7ak+6xLvB3Nvv5SEw=;
 b=YY+c8D0E8CYnzT9zMiRqI9RYY7Skhzwflj7+ppYhMDff6lqYvHcfoxW5pR9jhBevdftpYzd21U/waJZ97xuZ+xEj4me9LlMWvbEU5ziwszw11GMr0izNDY1rOD4jNu7jpTn/6rAzfYEK46WuJoZeRxOiqkwPayiTtXrDpEKA8gSNSPIGy25oFaBdNtfxZGToAKhklQSQjOrqXo70T7LNsrY5lE3fnt9SwjRRy/K+yqnLTJX0PgKKkV5AT5I0lzk2r/Ro9s5WkHCwkhRtn+EABdEcY11ABumCMoUwLqZej1WXNrlqeH/lHnNbBq9WcP2GQHoCf0/zH1yYIGc9wXpilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLfj4fRr2pc0Me9wKO19hRK3gy7ak+6xLvB3Nvv5SEw=;
 b=XzEFr/O2B91eP9HkOSYYsLiXv31nqhZoTXLHXaWko9jm/4q3P5NLlgLtxrpwhKAhP8pqWUOKNKlVrGYewegR+WQnKc+sWxv//ZDXfuvXg4af/7TkOpYLSgxoe6wwFAcxqnYxnlAaX321RG09lzqywz15wt5ldYdHW497kukHy6c=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4529.namprd04.prod.outlook.com (2603:10b6:208:4b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 06:40:27 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 06:40:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 06/12] zonefs: Convert to using invalidate_lock
Thread-Topic: [PATCH 06/12] zonefs: Convert to using invalidate_lock
Thread-Index: AQHXOGZZ/7j0X47Imk+n7AaZaIcldg==
Date:   Mon, 26 Apr 2021 06:40:27 +0000
Message-ID: <BL0PR04MB651475DE7CA7465849D821D5E7429@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423173018.23133-6-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5163:d51b:668d:bedf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b49db8-d850-45f2-6ffe-08d9087e2d88
x-ms-traffictypediagnostic: BL0PR04MB4529:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BL0PR04MB4529A5BEA7C207CAE8AED050E7429@BL0PR04MB4529.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: To7enibfRriqP96jZauebLTti5PVg5SxL75TuRcRoTTGivfRMa4zst5c4mIzcZhXy0f/jk3ZmeyXPV0A+U02kzl37EydbEtzbsWKHMjczj89jXly/XxXM7KGnzyCs6bFfiM0e2/K9NwEVk9KiSWcMd18KwALS7kou4FYBZrTlJDKIiX2FrBiFLIKGmNYB7rFqyVj9Fco3Kcbh63HbDGQHpzha/ESDrKheZdbXsjswFhSCw+xSWQ1XtfVh1GqoO+foxTaZfzR9g8/HQXR0hfoc1/QyYCwtwL01InZ2BHv7PzBGpNKG8paPr3zzUY+OEiYoOnwUdvsRioFUdRK9PgLpXqi8Xkym+ApcL8ib018fO9sot+YkTVBN053dnbv3KHwA/BzgUZINa1E0s36eUE4DeLv+XGFZN2fRMy1p0sjZAW0qlD7p4cOFLz2WhJg0aWH3AQRYSaClDQ3+fUF+U2nBvv59geLIfae54UKSqOrcHHO+6m8EHl8B2vDPzIekhxWvjnzf9q4dSkpQzhC6xCfmijK0SJl+xI3ePQ9pRWVRnu9RMxc7WkDzXbpgoehIKUgG13u8npmiK3KVUPo/U4O29rqjTOTWvI+kt9hhOHB4uI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(186003)(2906002)(478600001)(9686003)(38100700002)(55016002)(6506007)(86362001)(53546011)(66946007)(122000001)(33656002)(66556008)(66446008)(5660300002)(8676002)(316002)(64756008)(7696005)(76116006)(66476007)(52536014)(4326008)(83380400001)(91956017)(54906003)(110136005)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HOuKF5ks5A5QWg0M2DlpF0mzf9Hjenqd3HkGQVADmCGcODbDT5G/EwLrSNrx?=
 =?us-ascii?Q?yp6LoPtHD++WSpkTI7YF+467z2KbuqAmV77jgo+JVEOLJ/GWImSp+AFvLFwl?=
 =?us-ascii?Q?j3W/ULINnaG2eYQIJj+Z7EDtzoscZQhUL+pIzPnGXq1Jyf0fTGERjBMV6UU+?=
 =?us-ascii?Q?iYaBLcWEgwtcTXT2HVLoz9Dc1F/1bD+uJqgsa9roZ1fgbVo7/55sY49pO7f2?=
 =?us-ascii?Q?4A2WE5w7HPqznaX3+8koAU/v3WrmWm0NxdM9FCRdk/rttyekDbVodahAsT2t?=
 =?us-ascii?Q?OyEkY1oJY4lqVQ/spIBBlxiYY5K+VNxuPJ4SDZvxLWUJGYooeJh27p41y3CK?=
 =?us-ascii?Q?q5/jlZzC4guSZTvpNbcsdeAgxkKFpCSD/u5CjiU2XIPZ4YDYY99sTuKwDvTu?=
 =?us-ascii?Q?ufgbUJ8AUIPVBTGb6nDkzYxykh/V4I4664USnGgaaIpieI4ExP63QQk4jxeC?=
 =?us-ascii?Q?iEu+tM1PtOO0dbZh80nNofG4zT88Yt4H4qhKZlAbLTBkqdQxVKk75oS+FasI?=
 =?us-ascii?Q?60Qp9ecuxcCuPZvb8TsC6jPwe8CP+tDA+pIWTSuzd1yPb0AZS+Ol78OIS54l?=
 =?us-ascii?Q?XnnOiYiT/9tBUe+X5EDyDUeaQUukTYxBO7BlX5v1t7EgQH4s0nQkfa01UBBE?=
 =?us-ascii?Q?xe/x6EccCNlws6+iERpYWrvFe1xpHg2NO+mz+HUyYMIe23tENjEXkJgL7pG7?=
 =?us-ascii?Q?TCQrutHakgNGvALUdElJiiR0KXhGdaT2EIr1gUwPUGCYJ9Al825EiOqCWP1A?=
 =?us-ascii?Q?AbjCHr3c532WGQQwDkdZGu5EC9vcF3zGJcqA5ziSwtrAwMx4DbjXWmYAj+RD?=
 =?us-ascii?Q?oonEo7hTPyOS7oyPKuZ2yOnc4wIx4+2kCKGM0xBEjJwbW+7Fl3YeJ3tO2mLT?=
 =?us-ascii?Q?marBdjnwIAVbWLuskaFifyNgc1vgAgIrYt/qLIkJK/zut5v+n5q74gggw13z?=
 =?us-ascii?Q?7zg42GfT3fW1ghv5BMVoq+qjkYLeVGniMt/fPAA3b6ts1nH9SobTBulNxZDk?=
 =?us-ascii?Q?50ps3Fd0eaKegIIWS4sLTFkBk4FBEO1ELMkEZhJmFKF4S2z80TyUt0Vu0vXm?=
 =?us-ascii?Q?yagL+M+eYlgzaL61FqK8cNki9wyRmX9ii0mdVqKN//C12s6XOW2f7xzp5PeR?=
 =?us-ascii?Q?CoXU82GINdWRe69KPG62h60WseZDvCiXg/cLRc8D7odhTJ9FTHG0lMt08EMM?=
 =?us-ascii?Q?4nTRE3ali89dCQSTL24EDupAFGfnQnoWxbiO+j8cczzUZez7yQhBNpUGUXS4?=
 =?us-ascii?Q?YlfTQjqbLX7UltVRi/Go2gPlEBJEzyERpq6cIycHE9G5CB36qWChJzNCkGrR?=
 =?us-ascii?Q?t3VtOTIkSm+EkpNutKr6KMETH+DaqgHHFxXL3iN8/gnwLynbDGXJKw25Ycip?=
 =?us-ascii?Q?d8jM42DoywdPnHSDgLivjKXx56FS/2JdvzhUXW4YiVgAEKFucA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b49db8-d850-45f2-6ffe-08d9087e2d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 06:40:27.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cL3vrw4nkP0eEfIWGs+rlMRQPXfzRSZvfwgT4Ox6VxC5JqIwFfCxd/LaxjV4dYGEIgM+Mvkm4L/C0XaSlmg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4529
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/24 2:30, Jan Kara wrote:=0A=
> Use invalidate_lock instead of zonefs' private i_mmap_sem. The intended=
=0A=
> purpose is exactly the same. By this conversion we also fix a race=0A=
> between hole punching and read(2) / readahead(2) paths that can lead to=
=0A=
> stale page cache contents.=0A=
=0A=
zonefs does not support hole punching since the blocks of a file are determ=
ined=0A=
by the device zone configuration and cannot change, ever. So I think you ca=
n=0A=
remove the second sentence above.=0A=
=0A=
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
> index 049e36c69ed7..60ac5587c880 100644=0A=
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
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
