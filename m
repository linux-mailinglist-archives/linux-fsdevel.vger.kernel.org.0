Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4011BA38A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgD0M12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 08:27:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10950 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgD0M11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587990447; x=1619526447;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vzUMp9uGjlyk3iKkgJlPMRCeex/udb1207wkWLzRbak=;
  b=cuc3CKr6eFpIj3FCoCWEfah+n4n0UTXU8z3gfqJIu6LsaiH0vAcZUxUp
   zP1gOoGsPukQWtc8dk5eeb2mgVyNATDqCSMmHhnPCeo7m3cxKTHSrQf0m
   2SgaCNdCwpBEnM/QPu8l7aDVoakmG2/uW1ayhYxH4EYUGvLQ2QhFJ1iTJ
   +gFZ6JHHNbs9/17sJB1ZU997l+/RsNjJ2MewKenrRybhZ74VCOCVzS280
   o4c1q2fLfXvR3xphNjkv6hrfFdoKlKA8qmWzptb+Pr3/01UtTynuzJuHG
   UBYnIUaIMKeVgzk/Oo914mLbGEcZMALUVoRhup8nNQ69PT2jg9nzsZc0k
   w==;
IronPort-SDR: NWjAUiKt2SkljUmAAdvsZ+TttWATXX4fd0Z6lA9V6xuYx2cXU8A44fxnMxvYbGiOlOyMdoLih8
 YrACWKCBWzIbI6yNP5QERvR055nQ3xNQlql3KVEakfqMy9tW8SNhIUMsuNdcmrWFgjvxU/jXDA
 3RzuXj/VS0zP7B/Hg7wHAvrthpIwIaA/kyD2/Bmwrp4pzle2i6rDY6j3ec/CnrQvhVMlNgpx5S
 xmnOTmp2xeuujRyVy+qPdKknOpvNLZQXEi7TSx/Pc9NddLeZNW+u9VqFVVZFBOnFf+MpLyWD3e
 UeM=
X-IronPort-AV: E=Sophos;i="5.73,324,1583164800"; 
   d="scan'208";a="137681658"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 20:27:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8itklzMnUejlLnDpm+uIs7aPTxcr3ZBCt1w8ij6IrWY/aznUOF7w9GMZagnFpaw7useCAzMMGUalEY5PZk73aa9wfWooyx7k5nhQ37/4d30DMdNfkliDB4aph8UGQObSevrjQWJuF7q7VpU9p3Do0qQii8Q99awsRTpib4qgIkTW8MxQUNK28XjgbtF4hoOVAYfLdJbTpuQqaFtCET3SYW/vBqlNAiVXBQ0b6Xb9SIMiga8gEvzFx+rjZeUgUZ8ZEHJiX6sJm62Tzm8x5PqUy9tbWk9009Yc+rY1DG7biLQaXzqW/wH0Bbc/mEEdIlc2G090YhMz8mTHx0wwIWelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di8FisENOVp1olBqCeFZYsHNldyXBlw7iyyq7DhgFBE=;
 b=kjdY5ckciq1EsAmjMrH0ZIfpvDpLjf5jZrwkknI+ioggsPadWg3onx4ohZ+nw7IKhUxFGzKPyTYXa2L3Akp3ey/T1OIyZv7R9VATNaNY8/E3FodUhpCPtqAba9BTxo+dbrqcgjr72HwbvVo6ZRJnFnhmkRvLdoIuRIg4GF8q4l7PkWVjQX3p0Z2SoNJuIcN+6EAAFT4Z7MbhLPGIQKaUFP0KaCQDxGR8sgOiHYrNRQxxfR4lgI9pbxlzww5e4unW3Gn3uYSkgHz6mTs6EG2uoevUYRr+sg3Nxs2UGSo0w9x66WAjD6QXqjU1i4KvFERk4qEAwjkxBKn/6KE0VuDYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di8FisENOVp1olBqCeFZYsHNldyXBlw7iyyq7DhgFBE=;
 b=sHRZOI821Ceia615D2YxN7AaZRCbfBfOM28ZDYslNLxMiTUG/whvGg9U77DdxXOYdwCTtgOcB2fBaAkloET2STk6iFOm2A8CXwU0MThfyarQUVjqtHH9FMai1ut2hJKwHxGS/4+JKG4UyZhaW8rDdrqzbqg5SXUMb3f0WpPlNCE=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6802.namprd04.prod.outlook.com (2603:10b6:a03:22d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 12:27:22 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 12:27:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v8 11/11] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Thread-Topic: [PATCH v8 11/11] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Thread-Index: AQHWHIePKKkLPktH40GjbCNe+t97OA==
Date:   Mon, 27 Apr 2020 12:27:22 +0000
Message-ID: <BY5PR04MB690081ACD742297F8AD6404EE7AF0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
 <20200427113153.31246-12-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1252529a-1806-4b5b-05f7-08d7eaa65627
x-ms-traffictypediagnostic: BY5PR04MB6802:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB68027B725F7046BA08CDC18AE7AF0@BY5PR04MB6802.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(316002)(81156014)(54906003)(53546011)(8936002)(9686003)(55016002)(33656002)(6506007)(52536014)(8676002)(478600001)(110136005)(76116006)(66446008)(2906002)(4326008)(86362001)(7696005)(66476007)(66556008)(66946007)(5660300002)(186003)(71200400001)(64756008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c+fVWHxD6Tq8NYOI1bg9DHULUdA+05NtHj9gjNzJD87HpSByOQIusnucU+2UuUjkJRdH90/qUmfJ23gUM7lJ0OJHmFi3gLTts+MmnUymGYQx3iPOIbS+9uIMjxKCCCMtL8YUOQV2NU1VsRAxcOog5AwMyP28UCAwB9EEY3U6FcesIRBoAqH3HXf4aYd+NbOnczDawPRo8m6nWugjyf1h08jjDh17QkGCpt59LpLmgRRYz4Ls6b708hzxTTZdVcxggNTaInloZF0l86N0CidFgZDk8sFRMS4cGV0aX8OP6HhNJfAGMvih1W9OigbS+cESUu6aIMbN5Rd1yydXGgyDCjNnFZB17GIbKHXCWvbAl8c1fiSFwXrv2HZXqfIvfJYUknk4s9d2Ef+3SbwJM7iKu4lLeHPS5UAmQ0ErawN+h7iDsZ4g3lCwbPE5JGC90o6O
x-ms-exchange-antispam-messagedata: 6KB5DqEVYPaomE0KWHZVMLZLnvd/CVsM411kdq403d/LG54CM1qN3pdP1sq2U3N42zVCsudyDEyHXOmlG8NTCXMrTfQa/F1op2vZKsNqtd5SUSKyMjKbvPIaKuk7u4SKIO70tFVXYxm0qCDnrINXWv1PEF7VLEQnkB4EpdQosdFwYjbmU/PrEp7KsPRtnNklO5mD4Xa38fBtqvL0Z6evcDTuiaTxQESMplurK5e9bPv/HxNjx3sFe3UGNUzLV5poLfD2LuAIDzBsqayDkv9Ddm5TQQ9XsK+AViLrqSnjpEYg0sdpP9iX9MJmysIvoJh75wr0IelwDs+KRPpgxiL3Zgh6WCfNW/xiNnrTYyz9TWtdnCgHEZmeBt505rb6+1aD1yMpIfFFxFyQ59s2IGjHKbNTgK3u4nuDmPYXW3KBinttTcCbJitTuXyOTv/QHR0gbZFYetXIbPyiAchpgNmAgLzgZl7j6CCK6XmJGZnZOh3kiIZhZNTXYINUWxPKXUm4Zjh3A6y2QuUvu67DTzSTQUaZj13uwa1QZk49yBph3yMDLg5Yu8VyjpPgcyfwoQcnrfyObxSP8MdQYmCt13YRAfbTw8OhyT2bSZAVtvWU8Vol+AYmHV+f585A2SwjkGHFjqPfFydZ0+Ot28dLGJA/aVNuJoNj4XTaH9GbXfoMkhabjmvlZXbQADnkjgPc8883CKgrU1r/YmqHU7u31+l2hmXtqxHgAVU+wmC14umAZ1hUaeKR0+tb5H2OpOqt3MYMC0SAwMRiaYMzp4YT4/yI1QxMd0Y6SU/RuJ/ZoFauhYI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1252529a-1806-4b5b-05f7-08d7eaa65627
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 12:27:22.5480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGhifadKEA0YiRREB9urmwxxkDgUsl+5fj/6CFtm5XgkErOkvp4sNvpND18aPW2/XhJtqJToPJbLcKP85Px9qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6802
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/27 20:32, Johannes Thumshirn wrote:=0A=
> Synchronous direct I/O to a sequential write only zone can be issued usin=
g=0A=
> the new REQ_OP_ZONE_APPEND request operation. As dispatching multiple=0A=
> BIOs can potentially result in reordering, we cannot support asynchronous=
=0A=
> IO via this interface.=0A=
> =0A=
> We also can only dispatch up to queue_max_zone_append_sectors() via the=
=0A=
> new zone-append method and have to return a short write back to user-spac=
e=0A=
> in case an IO larger than queue_max_zone_append_sectors() has been issued=
.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c | 80 ++++++++++++++++++++++++++++++++++++++++++-----=
=0A=
>  1 file changed, 72 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 3ce9829a6936..0bf7009f50a2 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -20,6 +20,7 @@=0A=
>  #include <linux/mman.h>=0A=
>  #include <linux/sched/mm.h>=0A=
>  #include <linux/crc32.h>=0A=
> +#include <linux/task_io_accounting_ops.h>=0A=
>  =0A=
>  #include "zonefs.h"=0A=
>  =0A=
> @@ -596,6 +597,61 @@ static const struct iomap_dio_ops zonefs_write_dio_o=
ps =3D {=0A=
>  	.end_io			=3D zonefs_file_write_dio_end_io,=0A=
>  };=0A=
>  =0A=
> +static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_ite=
r *from)=0A=
> +{=0A=
> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +	struct block_device *bdev =3D inode->i_sb->s_bdev;=0A=
> +	unsigned int max;=0A=
> +	struct bio *bio;=0A=
> +	ssize_t size;=0A=
> +	int nr_pages;=0A=
> +	ssize_t ret;=0A=
> +=0A=
> +	nr_pages =3D iov_iter_npages(from, BIO_MAX_PAGES);=0A=
> +	if (!nr_pages)=0A=
> +		return 0;=0A=
> +=0A=
> +	max =3D queue_max_zone_append_sectors(bdev_get_queue(bdev));=0A=
> +	max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);=0A=
> +	iov_iter_truncate(from, max);=0A=
> +=0A=
> +	bio =3D bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);=0A=
> +	if (!bio)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	bio_set_dev(bio, bdev);=0A=
> +	bio->bi_iter.bi_sector =3D zi->i_zsector;=0A=
> +	bio->bi_write_hint =3D iocb->ki_hint;=0A=
> +	bio->bi_ioprio =3D iocb->ki_ioprio;=0A=
> +	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
> +	if (iocb->ki_flags & IOCB_DSYNC)=0A=
> +		bio->bi_opf |=3D REQ_FUA;=0A=
> +=0A=
> +	ret =3D bio_iov_iter_get_pages(bio, from);=0A=
> +	if (unlikely(ret)) {=0A=
> +		bio_io_error(bio);=0A=
> +		return ret;=0A=
> +	}=0A=
> +	size =3D bio->bi_iter.bi_size;=0A=
> +	task_io_account_write(ret);=0A=
> +=0A=
> +	if (iocb->ki_flags & IOCB_HIPRI)=0A=
> +		bio_set_polled(bio, iocb);=0A=
> +=0A=
> +	ret =3D submit_bio_wait(bio);=0A=
> +=0A=
> +	bio_put(bio);=0A=
> +=0A=
> +	zonefs_file_write_dio_end_io(iocb, size, ret, 0);=0A=
> +	if (ret >=3D 0) {=0A=
> +		iocb->ki_pos +=3D size;=0A=
> +		return size;=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Handle direct writes. For sequential zone files, this is the only pos=
sible=0A=
>   * write path. For these files, check that the user is issuing writes=0A=
> @@ -611,6 +667,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)=0A=
>  	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>  	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>  	struct super_block *sb =3D inode->i_sb;=0A=
> +	bool sync =3D is_sync_kiocb(iocb);=0A=
> +	bool append =3D false;=0A=
>  	size_t count;=0A=
>  	ssize_t ret;=0A=
>  =0A=
> @@ -619,7 +677,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)=0A=
>  	 * as this can cause write reordering (e.g. the first aio gets EAGAIN=
=0A=
>  	 * on the inode lock but the second goes through but is now unaligned).=
=0A=
>  	 */=0A=
> -	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb) &&=0A=
> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !sync &&=0A=
>  	    (iocb->ki_flags & IOCB_NOWAIT))=0A=
>  		return -EOPNOTSUPP;=0A=
>  =0A=
> @@ -643,16 +701,22 @@ static ssize_t zonefs_file_dio_write(struct kiocb *=
iocb, struct iov_iter *from)=0A=
>  	}=0A=
>  =0A=
>  	/* Enforce sequential writes (append only) in sequential zones */=0A=
> -	mutex_lock(&zi->i_truncate_mutex);=0A=
> -	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && iocb->ki_pos !=3D zi->i_wpof=
fset) {=0A=
> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ) {=0A=
> +		mutex_lock(&zi->i_truncate_mutex);=0A=
> +		if (iocb->ki_pos !=3D zi->i_wpoffset) {=0A=
> +			mutex_unlock(&zi->i_truncate_mutex);=0A=
> +			ret =3D -EINVAL;=0A=
> +			goto inode_unlock;=0A=
> +		}=0A=
>  		mutex_unlock(&zi->i_truncate_mutex);=0A=
> -		ret =3D -EINVAL;=0A=
> -		goto inode_unlock;=0A=
> +		append =3D sync;=0A=
>  	}=0A=
> -	mutex_unlock(&zi->i_truncate_mutex);=0A=
>  =0A=
> -	ret =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops,=0A=
> -			   &zonefs_write_dio_ops, is_sync_kiocb(iocb));=0A=
> +	if (append)=0A=
> +		ret =3D zonefs_file_dio_append(iocb, from);=0A=
> +	else=0A=
> +		ret =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops,=0A=
> +				   &zonefs_write_dio_ops, sync);=0A=
>  	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>  	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {=0A=
>  		if (ret > 0)=0A=
> =0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
