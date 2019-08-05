Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D135482693
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 23:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHEVIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 17:08:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36897 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565039329; x=1596575329;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FmklnGXSQ/VDNHP+cACm0T5dygTS9PJBTt/WOHhw+30=;
  b=gPVnsJvLqSh5zUUwdxlKrzcmkzFBG7pgCIgbrKdj3UC3I+Lb71AapjB5
   7LcZG0c78BKr6j717pFhigtkfWZAhBlKGdEi1BKiVkr8IfnT2ItYShaYk
   0RNU3qGM6SGdwa25JcajB5eZNPL/cthV/7lIT1aH29c/I2peMkGuByGwz
   2wBhoya/TziF8+kpsJU86hqZVcpj6wbGvSanxJH8LVjYTYPgEyhx12Q+s
   gGBkEqwkuHoo1n+tC9Xsqi/dga6LgGpX9JsbIaKJYNVLaE9sPZVcLoFUZ
   TzCvjcBfGwVEF0Ed3tAv5RkpvjmuChaEfuemcai0OI7BkjDsPF8hiwYpz
   g==;
IronPort-SDR: dYQa8zVBy0dX1OrQsmbaCUWjeovO9HO2r72FLtZL4Cwvm21YWGFXLDaisafAEo4oofpAboVc2g
 dGWWnwxigGgVgFkmnWicCssUdfK3yIgSzej9dKaUZc9WwC5N9vJpG32Sf2KqzGSBefw5k1jY8X
 kAv39Ips7wUfW8WspV2fSpJiQ5OqrmS3Bp1N7udlde6yqsmZHrxFY0PLT7/FqP06PfBpFZ0vVw
 5H9yKQ/+OhGBG5S3zWT/HZLlMK5kHJhVF4Mbd00VTW38DqkA+ih+cSgDIh2dNaRIcEBLX8T86N
 ME4=
X-IronPort-AV: E=Sophos;i="5.64,350,1559491200"; 
   d="scan'208";a="116658221"
Received: from mail-by2nam03lp2055.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.55])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 05:08:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzygory3Pr4qI3OEfG/e+tjlflXvPpt2Hu2UnhMA3v1qQ8zjUoXOnJjfNQFThTsDmoqze8+4kKomyJaz1zuO9V3ftF64WVCPuH98+nJ2BC+hjXCAxY2Rvg8P/VvP78/mN0XwfUzdtjSmOyyy2TmKhSqEey5xplm2GcIOGFrjS2OAUUgk60/XiQCgvdcvhEmpW4/d2uKR06FPIaYywXGYn9pKTr6HHjcSDL0DpgvI1vTO/e9G1wvrllElF+3ugdWVbWPzXRe3V16YzUvDYNV6OoAmDv8MnazjwSgdOZZ62wKLfEd8tiKD6uGsrzY92F6MaiNbVtafy9i5xGdpOF9/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIA6yJ31bqh3e7tbEdpm6AbYizDEFTQOe3YuRYj+0m0=;
 b=gj2ANfjj5xYQFNzl4o0YuOJD4QPiQrB4ixHoXHUen2HFv/D+26b7rJQ/DOu0yrShQrpSCu8qzTq+UHvZQs4L0YM0k5/HUzcXxZyEU+BxU+BRYNUGiE5QsM81K7mal+9iZe3/O1QzmpKVfapWmYqvEFu5IV/eBzURBuvLFLYgnU1+Ol9slp+P4BOb1tZ9RNKo+YPrVwJcmJMti4g5FZaBZJwEXhP2v8yhy7h+ocbo1phz2YH1Cu04YlkhxJQ9b7yAl3p1CJJGCcsiD5kw4egqbeFLRIO5y73bYSS+aWPjKOPGfFVAqnrzgqDylu5RK49KXGigo4x9r2RtaVzdIgRv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIA6yJ31bqh3e7tbEdpm6AbYizDEFTQOe3YuRYj+0m0=;
 b=lIphvg491HI4iaMQbjyQsKWDV4J6YDC73fONG6B05z+FMzEqAzeLVAltPgLH1wklwvxkdwk4hBnrnKF/oqkYaRADgVlkvObsY5Ld/eiwwfeUUk25IMYV5K9FTJbcakuvef0Iyy3N+UCwAiIWvatAq6JycDtfNCfxBCyctnwzBgo=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4917.namprd04.prod.outlook.com (52.135.232.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 5 Aug 2019 21:08:47 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 21:08:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Mon, 5 Aug 2019 21:08:47 +0000
Message-ID: <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d7aa539-8513-4d9c-2771-08d719e91bac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4917;
x-ms-traffictypediagnostic: BYAPR04MB4917:
x-microsoft-antispam-prvs: <BYAPR04MB4917F40C0A47841E750CC866E7DA0@BYAPR04MB4917.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(7696005)(74316002)(25786009)(229853002)(478600001)(26005)(5660300002)(71200400001)(66946007)(52536014)(68736007)(81156014)(8676002)(64756008)(81166006)(76116006)(71190400001)(76176011)(110136005)(66556008)(256004)(186003)(33656002)(102836004)(6116002)(476003)(9686003)(4326008)(99286004)(7736002)(54906003)(8936002)(66066001)(6436002)(316002)(55016002)(14444005)(486006)(86362001)(3846002)(6246003)(2906002)(446003)(14454004)(6506007)(53936002)(66476007)(305945005)(53546011)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4917;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JoEG+8XEj++dUwOc0KvNoAUPuyuaGDlkDGKTPKbFZRhKgii57utvGf8AmNRvjEt0wcI8IQw/YW1VoJ5HS+TpbPoPe7ZANvVUg8X+3erPpLsCf5k1nTAJUkt4bPOBOrQzyCxA6R01Dr3QgSrZm17VApBc1y0ZBkkI5rvdVuYq4IPmxFIS0Dv1xJq328z0eRgEkno0rnTd4ZU+m+CVwY6zMCtRiRvGkdXEtHTeqobTgzaYjYzf3RLAuuk3DC48VD+Vhe2XE/e4QGXSOSaTLsZcUrkPWqc2XgKcVwGUYuPdnvxRXHWY4noK+oOJpNnvqzaPlTlV335Ux/CL26u/0NKIMpUlcAywKsHQQhgtqotRtUgh1MhC5JIYdLzyDio/VEAQtik++X3+gMx1xdngHGjx40uh1JSaUWcGo7cAlFtDnkE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7aa539-8513-4d9c-2771-08d719e91bac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 21:08:47.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4917
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/06 5:31, Jens Axboe wrote:=0A=
> On 8/5/19 11:31 AM, Jens Axboe wrote:=0A=
>> On 8/5/19 11:15 AM, Darrick J. Wong wrote:=0A=
>>> Hi Damien,=0A=
>>>=0A=
>>> I noticed a regression in xfs/747 (an unreleased xfstest for the=0A=
>>> xfs_scrub media scanning feature) on 5.3-rc3.  I'll condense that down=
=0A=
>>> to a simpler reproducer:=0A=
>>>=0A=
>>> # dmsetup table=0A=
>>> error-test: 0 209 linear 8:48 0=0A=
>>> error-test: 209 1 error=0A=
>>> error-test: 210 6446894 linear 8:48 210=0A=
>>>=0A=
>>> Basically we have a ~3G /dev/sdd and we set up device mapper to fail IO=
=0A=
>>> for sector 209 and to pass the io to the scsi device everywhere else.=
=0A=
>>>=0A=
>>> On 5.3-rc3, performing a directio pread of this range with a < 1M buffe=
r=0A=
>>> (in other words, a request for fewer than MAX_BIO_PAGES bytes) yields=
=0A=
>>> EIO like you'd expect:=0A=
>>>=0A=
>>> # strace -e pread64 xfs_io -d -c 'pread -b 1024k 0k 1120k' /dev/mapper/=
error-test=0A=
>>> pread64(3, 0x7f880e1c7000, 1048576, 0)  =3D -1 EIO (Input/output error)=
=0A=
>>> pread: Input/output error=0A=
>>> +++ exited with 0 +++=0A=
>>>=0A=
>>> But doing it with a larger buffer succeeds(!):=0A=
>>>=0A=
>>> # strace -e pread64 xfs_io -d -c 'pread -b 2048k 0k 1120k' /dev/mapper/=
error-test=0A=
>>> pread64(3, "XFSB\0\0\20\0\0\0\0\0\0\fL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0"..., 1146880, 0) =3D 1146880=0A=
>>> read 1146880/1146880 bytes at offset 0=0A=
>>> 1 MiB, 1 ops; 0.0009 sec (1.124 GiB/sec and 1052.6316 ops/sec)=0A=
>>> +++ exited with 0 +++=0A=
>>>=0A=
>>> (Note that the part of the buffer corresponding to the dm-error area is=
=0A=
>>> uninitialized)=0A=
>>>=0A=
>>> On 5.3-rc2, both commands would fail with EIO like you'd expect.  The=
=0A=
>>> only change between rc2 and rc3 is commit 0eb6ddfb865c ("block: Fix=0A=
>>> __blkdev_direct_IO() for bio fragments").=0A=
>>>=0A=
>>> AFAICT we end up in __blkdev_direct_IO with a 1120K buffer, which gets=
=0A=
>>> split into two bios: one for the first BIO_MAX_PAGES worth of data (1MB=
)=0A=
>>> and a second one for the 96k after that.=0A=
>>>=0A=
>>> I think the problem is that every time we submit a bio, we increase ret=
=0A=
>>> by the size of that bio, but at the time we do that we have no idea if=
=0A=
>>> the bio is going to succeed or not.  At the end of the function we do:=
=0A=
>>>=0A=
>>> 	if (!ret)=0A=
>>> 		ret =3D blk_status_to_errno(dio->bio.bi_status);=0A=
>>>=0A=
>>> Which means that we only pick up the IO error if we haven't already set=
=0A=
>>> ret.  I suppose that was useful for being able to return a short read,=
=0A=
>>> but now that we always increment ret by the size of the bio, we act lik=
e=0A=
>>> the whole buffer was read.  I tried a -rc2 kernel and found that 40% of=
=0A=
>>> the time I'd get an EIO and the rest of the time I got a short read.=0A=
>>>=0A=
>>> Not sure where to go from here, but something's not right...=0A=
>>=0A=
>> I'll take a look.=0A=
> =0A=
> How about this? The old code did:=0A=
> =0A=
> 	if (!ret)=0A=
> 		ret =3D blk_status_to_errno(dio->bio.bi_status);=0A=
> 	if (likely(!ret))=0A=
> 		ret =3D dio->size;=0A=
> =0A=
> where 'ret' was just tracking the error. With 'ret' now being the=0A=
> positive IO size, we should overwrite it if ret is >=3D 0, not just if=0A=
> it's zero.=0A=
> =0A=
> Also kill a use-after-free.=0A=
> =0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index a6f7c892cb4a..67c8e87c9481 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -386,6 +386,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  =0A=
>  	ret =3D 0;=0A=
>  	for (;;) {=0A=
> +		ssize_t this_size;=0A=
>  		int err;=0A=
>  =0A=
>  		bio_set_dev(bio, bdev);=0A=
> @@ -433,13 +434,14 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_i=
ter *iter, int nr_pages)=0A=
>  				polled =3D true;=0A=
>  			}=0A=
>  =0A=
> +			this_size =3D bio->bi_iter.bi_size;=0A=
>  			qc =3D submit_bio(bio);=0A=
>  			if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
>  				if (!ret)=0A=
>  					ret =3D -EAGAIN;=0A=
>  				goto error;=0A=
>  			}=0A=
> -			ret =3D dio->size;=0A=
> +			ret +=3D this_size;=0A=
>  =0A=
>  			if (polled)=0A=
>  				WRITE_ONCE(iocb->ki_cookie, qc);=0A=
> @@ -460,13 +462,14 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_i=
ter *iter, int nr_pages)=0A=
>  			atomic_inc(&dio->ref);=0A=
>  		}=0A=
>  =0A=
> +		this_size =3D bio->bi_iter.bi_size;=0A=
>  		qc =3D submit_bio(bio);=0A=
>  		if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
>  			if (!ret)=0A=
>  				ret =3D -EAGAIN;=0A=
>  			goto error;=0A=
>  		}=0A=
> -		ret =3D dio->size;=0A=
> +		ret +=3D this_size;=0A=
>  =0A=
>  		bio =3D bio_alloc(gfp, nr_pages);=0A=
>  		if (!bio) {=0A=
> @@ -494,7 +497,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  	__set_current_state(TASK_RUNNING);=0A=
>  =0A=
>  out:=0A=
> -	if (!ret)=0A=
> +	if (ret >=3D 0)=0A=
>  		ret =3D blk_status_to_errno(dio->bio.bi_status);=0A=
>  =0A=
>  	bio_put(&dio->bio);=0A=
> =0A=
=0A=
Jens,=0A=
=0A=
I would set "this_size" when dio->size is being incremented though, to avoi=
d=0A=
repeating it.=0A=
=0A=
		if (nowait)=0A=
			bio->bi_opf |=3D (REQ_NOWAIT | REQ_NOWAIT_INLINE);=0A=
=0A=
+		this_size =3D bio->bi_iter.bi_size;=0A=
-		dio->size +=3D bio->bi_iter.bi_size;=0A=
+		dio->size +=3D this_size;=0A=
		pos +=3D bio->bi_iter.bi_size;=0A=
=0A=
In any case, looking again at this code, it looks like there is a problem w=
ith=0A=
dio->size being incremented early, even for fragments that get BLK_QC_T_EAG=
AIN,=0A=
because dio->size is being used in blkdev_bio_end_io(). So an incorrect siz=
e can=0A=
be reported to user space in that case on completion (e.g. large asynchrono=
us=0A=
no-wait dio that cannot be issued in one go).=0A=
=0A=
So maybe something like this ? (completely untested)=0A=
=0A=
diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
index 75cc7f424b3a..77714e03c21e 100644=0A=
--- a/fs/block_dev.c=0A=
+++ b/fs/block_dev.c=0A=
@@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
        loff_t pos =3D iocb->ki_pos;=0A=
        blk_qc_t qc =3D BLK_QC_T_NONE;=0A=
        gfp_t gfp;=0A=
-       ssize_t ret;=0A=
+       ssize_t ret =3D 0;=0A=
=0A=
        if ((pos | iov_iter_alignment(iter)) &=0A=
            (bdev_logical_block_size(bdev) - 1))=0A=
@@ -386,6 +386,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
=0A=
        ret =3D 0;=0A=
        for (;;) {=0A=
+               size_t this_size;=0A=
                int err;=0A=
=0A=
                bio_set_dev(bio, bdev);=0A=
@@ -421,7 +422,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
                if (nowait)=0A=
                        bio->bi_opf |=3D (REQ_NOWAIT | REQ_NOWAIT_INLINE);=
=0A=
=0A=
-               dio->size +=3D bio->bi_iter.bi_size;=0A=
+               this_size =3D bio->bi_iter.bi_size;=0A=
                pos +=3D bio->bi_iter.bi_size;=0A=
=0A=
                nr_pages =3D iov_iter_npages(iter, BIO_MAX_PAGES);=0A=
@@ -435,11 +436,11 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r=0A=
*iter, int nr_pages)=0A=
=0A=
                        qc =3D submit_bio(bio);=0A=
                        if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
-                               if (!ret)=0A=
+                               if (!dio->size)=0A=
                                        ret =3D -EAGAIN;=0A=
                                goto error;=0A=
                        }=0A=
-                       ret =3D dio->size;=0A=
+                       dio->size +=3D this_size;=0A=
=0A=
                        if (polled)=0A=
                                WRITE_ONCE(iocb->ki_cookie, qc);=0A=
@@ -462,15 +463,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r=0A=
*iter, int nr_pages)=0A=
=0A=
                qc =3D submit_bio(bio);=0A=
                if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
-                       if (!ret)=0A=
+                       if (!dio->size)=0A=
                                ret =3D -EAGAIN;=0A=
                        goto error;=0A=
                }=0A=
-               ret =3D dio->size;=0A=
+               dio->size +=3D this_size;=0A=
=0A=
                bio =3D bio_alloc(gfp, nr_pages);=0A=
                if (!bio) {=0A=
-                       if (!ret)=0A=
+                       if (!dio->size)=0A=
                                ret =3D -EAGAIN;=0A=
                        goto error;=0A=
                }=0A=
@@ -496,10 +497,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r=0A=
*iter, int nr_pages)=0A=
 out:=0A=
        if (!ret)=0A=
                ret =3D blk_status_to_errno(dio->bio.bi_status);=0A=
+       if (likely(!ret))=0A=
+               ret =3D dio->size;=0A=
=0A=
        bio_put(&dio->bio);=0A=
        return ret;=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
