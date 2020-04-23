Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44061B5643
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgDWHmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:42:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63706 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDWHmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587627775; x=1619163775;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2PktgVK7G4b2hru15nWm2Yju3vkOndym0gFnN5I+4XM=;
  b=LKo6xvFVCWO033RDohoFbBf4TEdUUivmBNlQKkAE5gk/AXJBqNtaaUbj
   FX0AtNT78TVH9zqMnTaKeVqZgat3MwMu2xJEAMzu2nZtV/m7JlXv9LNLN
   escrIChG+oMyc+iH6c6rZeBBUcJ3jsH4sfDmCsqbtxDojvU2hlczdrQCe
   yW4mcphU3qJ89iNu/CW5s6stgd10kF5rVPy0IHMU5BP6vYx1XFreN3Gru
   FXMoAuTOuu4C+zE4EZtwDm96jikdBNBZZDxcNKcrttyub4z6fLvkqcAqH
   S4ApWa9/P6jGuBUkpCzzrM+LoofHf15HNF2WD+/KTn2JKBrZuGK64oP11
   w==;
IronPort-SDR: /vi5WztUK5wWR2ypaGxc9s9hLpq9abtf9CJjtsDAtkfQgGg+u6DjN8CCml4jcDPLilG3qIfuRj
 yYJKkXNCxDDS8v+Vo9AoxNe+XGyYBvKFzZicsRt94ZQgOhP1qP3sg6AktrNCIf9AIKtf9vAtFS
 46tJKUmThVUy7HaYqyA6pD7HiAcliAoY4x8606CwJ9P3gm3lELSzT1lvoEcAwSZ005OOTo3ylq
 sDK4nN31LcnT/D4HtI8b9iRI6lcIlcXcMkg0aiaIwQEa3V6bRwm8FsujwBXrBIAwti4S/4jvsZ
 cYE=
X-IronPort-AV: E=Sophos;i="5.73,306,1583164800"; 
   d="scan'208";a="140308265"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 15:42:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIPVpN+RBaX71jc4h4PkhTu7T8pegPH4bABU8k43aZNp5ZSPGI2Ku3CJz/LBI99QaIa+LXfKT/3ExzABzvV+7yWFyhC1Iul9auwvfGgaiWia2wX1RYsddCifyfAq4pont0xiFKpNTH5l7WDWy7rOtLpTKvCWaeV573nM/m//9yHSGzk5WbDr6VVua4qzGuSZsz20TgruURvvPEnpH5YznbhLRPnn9wk7mgYUzqtFK0rOGluiWYthia+7igsz44TnsMOtI/muc5tsq+jk+4ummuBd6aA7KqVtzSudW9/eDQg8C8YP/J5Ng865/MLMsWf+4oSQ8xmesCp9YHexQvMa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POIjMU+aBPe+hNwFXUiKw1Ynp4Uz097HUkWcm0SFWng=;
 b=dLYgoYDwWR+eHTrUiJrENSnrwcSiRWCGupfAXlNcqlo1D2Y6tD+OrmFJz3dfCuEhc+zXWasezKTc8E/B1VAzEYn5K62SXK4Z8zl/N0QpNogeiTHCCQTlWlCSsCXuqSVOYayX18vHxxAcyPe9daAprXBBKROx0YdKeXh1abiqMvdcxqLu/a+mKkc1eOaVx9tMywL9Ml9K6mbsubUBqvy1Bqh5RbDkh1pClLb9laxVG1fT9CwCpTXgo7vLARqzJNpRKNXmNX9EAloicfXi+Ukqo4kHSsOSEqozkFYcWNb/oY6ed7/w3La/005KQ1d4SthtJF4E63eYZzJSOj8gnbZZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POIjMU+aBPe+hNwFXUiKw1Ynp4Uz097HUkWcm0SFWng=;
 b=XXL77A5pBFEzdpB72GSj6yK2co3rOI9liLyewcn37NCkY9mKv2BqR/w38kpZncM1+vvfR80ReYQvNEomcxaTHPynsdx8A1EzFcOhTjN/2CwY1TUqLjnwwuOYD7mJ4c3UqHe3r/dL/hwDJj5rLXDvUTC0aVCMGia54rYQdtfthWs=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6723.namprd04.prod.outlook.com (2603:10b6:a03:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:42:52 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:42:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] isofs: stop using ioctl_by_bdev
Thread-Topic: [PATCH 6/7] isofs: stop using ioctl_by_bdev
Thread-Index: AQHWGT8MdkHUuDhP1kqEjWykHKN6yQ==
Date:   Thu, 23 Apr 2020 07:42:52 +0000
Message-ID: <BY5PR04MB6900744BDD64A977DE9BFAFAE7D30@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ac01087-1d8d-40ab-d606-08d7e759ee04
x-ms-traffictypediagnostic: BY5PR04MB6723:
x-microsoft-antispam-prvs: <BY5PR04MB67233583A583401D5FCDC02BE7D30@BY5PR04MB6723.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:192;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(7416002)(4326008)(33656002)(2906002)(5660300002)(86362001)(7696005)(64756008)(66556008)(316002)(66476007)(66446008)(52536014)(66946007)(186003)(478600001)(76116006)(6506007)(54906003)(55016002)(110136005)(53546011)(26005)(81156014)(71200400001)(9686003)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blo9Ecm3kJ2/49zpJnnz6hl0n0V1lkTyTWD2/mWmjkTu2aWNN4ZUCXBaFa/MmC/BkolbPvt61n7zxxk2/5htzPgydivo9pojiKoMhYItfsPetfJ1ti2WD14mJQbw8ndR+jPbeENQW1NRxkdAxevbImLGJVLqEu5k19YZwoKjR8lwJYM38aoyWENoZZI8yxgZI9n5JcKeM3JNbwzVLbKz6DPaFt746273Wk5zpOxdEZM8B7DC7p9LQGvsnvMqSKy1mmZ6BljVnxp3LXntGEWAfMbofNO295TujTvXQbvpNcehJdcMY3RYMVIGbcNxkc9pWIEp79hIDSmV2RHC2YViTmnL82ONgHtOsGsqNr7hQIGMBFMGuOpULeZUbocklKcJJZP51Cley62iZv/dUrB3VfvqUGiQNAYcj+IeXygnSAb4B/d6lrtTA+rzrwFnMUwf
x-ms-exchange-antispam-messagedata: UPISYzunsY6B9XZe3WVJciwoyuwrwz4OmCmWhpkjmk9WtYMTtNhwGhwJj9Wkc2jEUoxlF/0+BsMQU2PXbBJibtZXktdKmSo8hLLsZiysLwW9q3mDvZn5QVIC6/OxRTocFPIT5P2TvVThHewJMFuGbg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac01087-1d8d-40ab-d606-08d7e759ee04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:42:52.5991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2u/iY2cr7M8pFQiEcyYagU04B+40zC8SR/waguI89zAkLQ+XTwCN1ne9UqY958KjqfEDUWCg6XR9SNqD8RNPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6723
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/23 16:16, Christoph Hellwig wrote:=0A=
> Instead just call the CD-ROM layer functionality directly, and turn the=
=0A=
> hot mess in isofs_get_last_session into remotely readable code.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  fs/isofs/inode.c | 54 +++++++++++++++++++++++-------------------------=
=0A=
>  1 file changed, 26 insertions(+), 28 deletions(-)=0A=
> =0A=
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c=0A=
> index 62c0462dc89f..fc48923a9b6c 100644=0A=
> --- a/fs/isofs/inode.c=0A=
> +++ b/fs/isofs/inode.c=0A=
> @@ -544,43 +544,41 @@ static int isofs_show_options(struct seq_file *m, s=
truct dentry *root)=0A=
>  =0A=
>  static unsigned int isofs_get_last_session(struct super_block *sb, s32 s=
ession)=0A=
>  {=0A=
> -	struct cdrom_multisession ms_info;=0A=
> -	unsigned int vol_desc_start;=0A=
> -	struct block_device *bdev =3D sb->s_bdev;=0A=
> -	int i;=0A=
> +	struct cdrom_device_info *cdi =3D disk_to_cdi(sb->s_bdev->bd_disk);=0A=
> +	unsigned int vol_desc_start =3D 0;=0A=
>  =0A=
> -	vol_desc_start=3D0;=0A=
> -	ms_info.addr_format=3DCDROM_LBA;=0A=
>  	if (session > 0) {=0A=
> -		struct cdrom_tocentry Te;=0A=
> -		Te.cdte_track=3Dsession;=0A=
> -		Te.cdte_format=3DCDROM_LBA;=0A=
> -		i =3D ioctl_by_bdev(bdev, CDROMREADTOCENTRY, (unsigned long) &Te);=0A=
> -		if (!i) {=0A=
> +		struct cdrom_tocentry te;=0A=
> +=0A=
> +		if (!cdi)=0A=
> +			return -EINVAL;=0A=
> +=0A=
> +		te.cdte_track =3D session;=0A=
> +		te.cdte_format =3D CDROM_LBA;=0A=
> +		if (cdrom_read_tocentry(cdi, &te) =3D=3D 0) {=0A=
>  			printk(KERN_DEBUG "ISOFS: Session %d start %d type %d\n",=0A=
> -				session, Te.cdte_addr.lba,=0A=
> -				Te.cdte_ctrl&CDROM_DATA_TRACK);=0A=
> -			if ((Te.cdte_ctrl&CDROM_DATA_TRACK) =3D=3D 4)=0A=
> -				return Te.cdte_addr.lba;=0A=
> +				session, te.cdte_addr.lba,=0A=
> +				te.cdte_ctrl & CDROM_DATA_TRACK);=0A=
> +			if ((te.cdte_ctrl & CDROM_DATA_TRACK) =3D=3D 4)=0A=
> +				return te.cdte_addr.lba;=0A=
>  		}=0A=
>  =0A=
>  		printk(KERN_ERR "ISOFS: Invalid session number or type of track\n");=
=0A=
>  	}=0A=
> -	i =3D ioctl_by_bdev(bdev, CDROMMULTISESSION, (unsigned long) &ms_info);=
=0A=
> -	if (session > 0)=0A=
> -		printk(KERN_ERR "ISOFS: Invalid session number\n");=0A=
> -#if 0=0A=
> -	printk(KERN_DEBUG "isofs.inode: CDROMMULTISESSION: rc=3D%d\n",i);=0A=
> -	if (i=3D=3D0) {=0A=
> -		printk(KERN_DEBUG "isofs.inode: XA disk: %s\n",ms_info.xa_flag?"yes":"=
no");=0A=
> -		printk(KERN_DEBUG "isofs.inode: vol_desc_start =3D %d\n", ms_info.addr=
.lba);=0A=
> -	}=0A=
> -#endif=0A=
> -	if (i=3D=3D0)=0A=
> +=0A=
> +	if (cdi) {=0A=
> +		struct cdrom_multisession ms_info;=0A=
> +=0A=
> +		ms_info.addr_format =3D CDROM_LBA;=0A=
> +		if (cdrom_multisession(cdi, &ms_info) =3D=3D 0) {=0A=
>  #if WE_OBEY_THE_WRITTEN_STANDARDS=0A=
> -		if (ms_info.xa_flag) /* necessary for a valid ms_info.addr */=0A=
> +			/* necessary for a valid ms_info.addr */=0A=
> +			if (ms_info.xa_flag)=0A=
>  #endif=0A=
> -			vol_desc_start=3Dms_info.addr.lba;=0A=
> +				vol_desc_start =3D ms_info.addr.lba;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
>  	return vol_desc_start;=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
