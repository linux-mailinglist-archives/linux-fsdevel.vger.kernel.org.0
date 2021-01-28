Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535BF306F6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhA1H3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:29:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26864 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhA1H0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818780; x=1643354780;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Fou+4cLJrSCon50d9/Y3lLiRTfP/NjMtM08GVarOK2I=;
  b=lsW8xa/iM+6Fs49Jb6ZeWOS7BZz0ZX9I4XzKvw7qYprczpTP6/nbCI+q
   FMoO0pSjt+cun5SwAaV4TMzvK/6g1oE+vaAoAaTWAsaELVzMjsnSRQWKO
   yC3aopC9EyVkQ7zML0CgkrX2b/ZzAqEY3FVz13v1bWc4s/Z9PtW2Uk6Fm
   06UU6IvwZYk3yrybLacRnfM/Y6KWiwozWK7LdBkyVtKoZjs8KumxO3xw+
   hpePb2tf8bpKB4PIoGpTbmQX/Mx6wco5KZ9W6U+ARmyEmNExV0TQxthSN
   u/LehJJdikeAwU4GpStX/lAnovsVySe9W9eurqwPxVwHn7p49TaMasQ6L
   A==;
IronPort-SDR: 1XO4jceGpXsh5IubGHdLerxe4aeG9SxsSlvvinyZ7xz57Mp/Yn2xXzprrhv/lGRMw7sD89FT+6
 0aDVxAiCPzDc65NGiWOiKo5gxtNSPZKz5mlSA/25VzwvVnfoogtEwKBkNuupemZT6VWxmBVgoz
 1kutj7VUKXVePpFPNy7xf0zdg+eN3kJwPBnQ3H0UcYQsyPV+WI7edJnh+Tc18j4bolIOp7HUx9
 V4l3St9H+gnv0HQImdqL8myuAw+VCjktcivp9mOSzOLzABQ8HsgpcL3yN2K451BrUxmzcCQRu1
 NX8=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158518130"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:25:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPdcK/wrqdrll5sSKfk/tpq+HKxGIlQ0olUV0quQ8r2P/3nkAWU1JEEJynwYK81uPBXyiVe8P/0ReiX0vWx1ysl3aPlfWX/zWMKqDpP3Q5OUw49avJXJH2gTxuUGjO1ciVP4bhrZgRGcJvgcVGiWfncxPWNr4BpcNlSKmoScyPyxO+CsrdP/WJneJ6H0ickT2bAe8XRmNbNkCDwsfGyW0Z0LbNI+jh0D89leTmSOwyP/lyte+GTjeNnQuv3TwgkY8ipQuG5F0C6TnV/hLz2zC8MxcG19vCz2vtGsbqAPOIHDQ1zaNzys+NQGoUOAO83YzvMc1YgQqq42Ugx4+leh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSgQdFikue5ip6XRlyXPzYKx1++P+Hg8uK52x5aYL+k=;
 b=KUUNYeeXKSAbS8LV+b7WXja6brRVaKoFOOm0ujkmkWuJSLPzgus7drFwpT6L7Ot2K4uRF84HiOSSRTJ/a1vz14uMNSrmk+D9cmd4fog2uuZkq8Bg4yioVRqhjkmTj95TPpunAFyXu7wrfwI+6bUToQUict0wo7eAxK2IKlx9ih/NNFUjYgwBtAu2Gc9hsgJ9vjHItWNsy/YUwdnRsmPGo4+Lx7RcpvBVDiWHK/y4ptKzFiztsD/lV909+yhlv4jzL9U/PMYvvQ46Zlbx5vG6kL0q+Dd7XlcNgHHYYN46v11y9UnCCpJz2FcBxuVohCL+wb9/1zfcSBwhN80oplJPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSgQdFikue5ip6XRlyXPzYKx1++P+Hg8uK52x5aYL+k=;
 b=rcbJ6C+1HneLHXguaze5yHNT9VQb6QapqfT7ZimwMdiRf3BlXyrrVQzYvksAWPAeoLwphxgKl+Ck4KCZdN4IwAGa0P2CQi+y7tYyl6GXouJAwGOKdgkHPFo+1nz9iVrAnlGohUMWpVVVahoBL3AsByBgHK6QGOwRfTqnebimXv0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4852.namprd04.prod.outlook.com (2603:10b6:208:59::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Thu, 28 Jan
 2021 07:25:08 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 07:25:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "jth@kernel.org" <jth@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hare@suse.de" <hare@suse.de>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "alex.shi@linux.alibaba.com" <alex.shi@linux.alibaba.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>, "osandov@fb.com" <osandov@fb.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>
Subject: Re: [RFC PATCH 28/34] zonefs: use bio_new
Thread-Topic: [RFC PATCH 28/34] zonefs: use bio_new
Thread-Index: AQHW9UVkomvF2vpeIk+EkJoBWTZvag==
Date:   Thu, 28 Jan 2021 07:25:08 +0000
Message-ID: <BL0PR04MB651467E7A7C6EA542A435DC6E7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
 <20210128071133.60335-29-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 571a2e12-0985-48c6-3f9d-08d8c35dd761
x-ms-traffictypediagnostic: BL0PR04MB4852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB48526F818C0FABCE58FE358FE7BA9@BL0PR04MB4852.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32W9x/cXloQ/0z7DAt7qSsx7G7lrDFeZKKnz06uUAgqmQA0gT3PPCEyknGB3ASTcaW8hMZsSv7e4qBntNlXUHbZ8XUAGPoKPUEg8L3NUMI7uFcJfpKllkC7jh907tv13wKROCFhzy3qIjUrr1qvxVNJbHg4AnaAu7Hd0n9BSJd6ltHb+lx6Kt1Bn0OufCV7+r+cTwGKhQjCwuKOs+4ysKSQ8sW8+mt0qxyYFn2M/rNCmGKkhY8zImLX2a4W554RAzTEia6eb4MM87+6pBC8w1Q2HNfvRcd39MixEiA1EUbkbySsl2l7XWBYBO5mzIk9WQ9arSlUleijKB3OzhzhTK6LyklxSc45/PlQXclMCdkFEDXw4Ertp1VGxUdGU8cRWvDhZS9EfEEXCIfXImgIiA9tufLH1CjNO2bVvXzP6PLtxkgtk9qCm5MMg8XrWcy13k6zxpm3w4mC4P9lE98bhvznAFUhPPMQYCtcaqGBVD8wVrEEVpyd7b42fgd6EvLNMLYC9H3silifIWz/Rg5TpNU9zXgVikI9bgP+aoGCiEFisN+if7JaPfhP5VriRPmet
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(186003)(66476007)(83380400001)(53546011)(5660300002)(66446008)(316002)(8676002)(71200400001)(66556008)(91956017)(86362001)(64756008)(6506007)(2906002)(66946007)(52536014)(7366002)(7406005)(9686003)(33656002)(110136005)(7416002)(55016002)(54906003)(4326008)(76116006)(7696005)(921005)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KUYSxjXYfQyNkYu8LxobzslWgbRrh1Hl0zsXUUsbHOAiFNIp1CHkc7Nx0P0Z?=
 =?us-ascii?Q?86/TnX/TPZp6t3X6c/g7GjztYvohIOlICO4H8k7mNeR7y+CZ3BtbwC7PEo6W?=
 =?us-ascii?Q?HqJHIyObHou2BiSclkZegmCnVRenHuoXxGl5D73K00V1VymVtpakkO57xYsU?=
 =?us-ascii?Q?Ck0cY+BcGGROkuC2MoyqtVOpp/iltPkRzE6GJ9wDOX1598WYiKIvr2y+YmQ+?=
 =?us-ascii?Q?wQwbQRUTninVVh6zv6CkTTAfZTBHB090EUDht5aK+Fo6z/eRCqrS4IlOCGFq?=
 =?us-ascii?Q?498LbIthUnE3rks5RvI2V2xbSQzfsFQhY5vova5SXPsbG/TiZr8HjDcdE2oW?=
 =?us-ascii?Q?8BGJ9GFuH2UrnBhdHujwELLdv6L1T/WlR5cJq/tiDhld5tUhYHzFjjWvNE6c?=
 =?us-ascii?Q?I+VXBTmaxLP14RoKqfP5otrWi3wLf4bycUl7pkHG2CaWA7+0Ez531fX8rOvT?=
 =?us-ascii?Q?cwBmQi02GfJo21WpVkvrl8s38CKqH8j5qJewOxErbbHe0iDj02o7T820Cxzj?=
 =?us-ascii?Q?xCnk763l4wH0f6+ovzE1ZlF3iE7LNGxHlBwqoKcf39VHXx7/AAy1GrT22ApX?=
 =?us-ascii?Q?MgPXcNJ0iSVZtFkZFzM73MhFM1bOuiOO7NGIY/4aAWcEdzhZflqdsD+WsBkL?=
 =?us-ascii?Q?yp43gtW33O9bJEtWIvPn6iuK2yQ3bsRg283jdRUh6QLEtjciruqLGthtvhIy?=
 =?us-ascii?Q?s+Qcu4k/NE4d2HrVekBg/BxoUQUacAxI3FQJlsyVGEJY20k7Q9k0OMh9tvCp?=
 =?us-ascii?Q?qtaZtRNzfpvdZXte5TfUlQMxq5WV2WBBQqcSz1ND4HWP/deex/dHdrNwRKlk?=
 =?us-ascii?Q?djYJIdTki4xpkR5Xk97EgRFyZ8k35H0GsnLJuHCvt6gVnkwWsZ+ztFnhpOd/?=
 =?us-ascii?Q?Y0xM6YlGj/6zQRgzmDTOlwzdb/zAxqF+vxvcQn6Fv/iysP57q5ld+v5t6054?=
 =?us-ascii?Q?LtNzFHBIocUBaYhhkclP8GsmoPTepXiqTfUXqM+B+fDDX1DL9mTRkt9y9Qak?=
 =?us-ascii?Q?Nh8TG/F+F4jszRp6q+6wcfEuAiihnLxXxfrviLvmh8gYVfagv93E5lxVVktd?=
 =?us-ascii?Q?hXXp0Bqmg9I+K4jbZwyXDH49F3B4s9kYdbA1Xhg2QrjeOTNP7nU4t9UFW+4p?=
 =?us-ascii?Q?Jw/JubtNhiONkVlxC0ibXm51hfwOkfGG6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571a2e12-0985-48c6-3f9d-08d8c35dd761
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 07:25:08.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2LVRo+jq8H43Yomo5AbZnE8GRpz0qPYcTtqFQS+Wx0lj+olf9/bMCZK+x9/8XOA2sWiiRbuHCzb/zC8+GMypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4852
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/01/28 16:15, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c | 6 ++----=0A=
>  1 file changed, 2 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index ab68e27bb322..620d67965a22 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -661,6 +661,7 @@ static const struct iomap_dio_ops zonefs_write_dio_op=
s =3D {=0A=
>  =0A=
>  static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_ite=
r *from)=0A=
>  {=0A=
> +	unsigned int op =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
=0A=
I do not see the point of adding this variable since it is used only for th=
e=0A=
bio_new() call. Pass the op value directly.=0A=
=0A=
>  	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>  	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>  	struct block_device *bdev =3D inode->i_sb->s_bdev;=0A=
> @@ -678,15 +679,12 @@ static ssize_t zonefs_file_dio_append(struct kiocb =
*iocb, struct iov_iter *from)=0A=
>  	if (!nr_pages)=0A=
>  		return 0;=0A=
>  =0A=
> -	bio =3D bio_alloc(GFP_NOFS, nr_pages);=0A=
> +	bio =3D bio_new(bdev, zi->i_zsector, op, 0, GFP_NOFS, nr_pages);=0A=
>  	if (!bio)=0A=
>  		return -ENOMEM;=0A=
>  =0A=
> -	bio_set_dev(bio, bdev);=0A=
> -	bio->bi_iter.bi_sector =3D zi->i_zsector;=0A=
>  	bio->bi_write_hint =3D iocb->ki_hint;=0A=
>  	bio->bi_ioprio =3D iocb->ki_ioprio;=0A=
> -	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>  	if (iocb->ki_flags & IOCB_DSYNC)=0A=
>  		bio->bi_opf |=3D REQ_FUA;=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
