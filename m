Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762AA82858
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 02:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfHFAFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 20:05:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61606 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfHFAFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565049953; x=1596585953;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wWcA01sZnJBKe3S8OqqFT6SQHApyi1rnh3nah3D+wi4=;
  b=aGa+1J1fF5SyyU7xh9b48aDKq4Nk1x/P37VXYQDyYNy7TCFwhHp93ZGt
   BPSfRErMCHTKk7XVlN3p4jiMogB4pnBiJGKRj6dSeVngy9LtP+ykgJidH
   oYIctTqi4cDLTes+BJEa3HSgBWX2/rbWGAQbgqnsXYi1SqFdQ+iuYR4w9
   JZWReNSw4vj51DMpyGejgOO9F4zCvDBMHq1h+KL/tsCPMLYL2TEEpiSn7
   PyRdaWgGBxFQL/+lwE8P97ZdeqKRJHHkNIdW6G/hbXgfeDPdTu4xKVOh9
   82D/GYcqbtuRvQ8Y39tyqUU9dQEGSPfa0FKnUvBPkMrqcICCNi7oyfKHB
   Q==;
IronPort-SDR: 2MZrjgNW0KsKACv+2xheMexFroy+aCfuGDOAQfYBUK6Nlcku6jImZYKpKqwpEsQeUrq31OVvkQ
 O2pNEiHlBkeoF7sVdQELFalAKhKQUeKocha6dApGFiGGVbDsVrN4CjZYiNPsbZOCn3XLoSA4xB
 5VinGzKWmqbP6nGucN+479g0h5SHvKTfZtVW6LBBqd/hLAdI2zz1Eej7B1vA0K/WxFZd2TGxQl
 5fh7YRzGLN3o0V2fKvoccr75l9m4CEX9077PPYps6Um3gnfPMx8uR8ya64P20mhFfcJRC6fSba
 yqM=
X-IronPort-AV: E=Sophos;i="5.64,350,1559491200"; 
   d="scan'208";a="116042603"
Received: from mail-by2nam05lp2056.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.56])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 08:05:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3Yh4bBwIlv2IHEqm9ymw7bLnZ9GNYfACFmTBz2yNncTjjO+Hv+vOM/khTs3mw8ijja2Cg84YU/QB/bngQs12ZljdhKfZiS6V+Gw41lmAJSGMhDMXs4iQyKSkVFkAZ8bSfiaFXPfQWoU4VbCUWmVa+fbnuB6RRJoKbw2xvfClKLCCEltSKIQSmzazEpY2j2KNhBj6H8gX9+m6NbNKLvsb+rQQj2cCxy6LToDcYk92lJYEpIDpWNMwLKbbjQ0dXvLSTTXAKODtCO0k61ID+q75TBxu7ElsaoyclDb5605TEiWJRapWgocu5HZCrHAS7nC0+j1MEACHUG4LCtSy2Y04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spxe6EdylDh8ItZy1eAroCkZZLLCbxerVaPy7Mz0kes=;
 b=LAYaoM7hCTx5kGeZLV7IN8dzML68dj6TbWR3/hsK2lI8R79KvcFRSVcOKAbhHZKDMM+9xpavFciWpUcrcnOLdhpHy6H5gfP5KalLB5ZkfP0xfbX7U3/EWpGdwsf//Hc40fJbI9w1JCmvn6Hs+50MbER9T9kMyLmjDsAIfCqHHNUcIfZEiBy9J5Rz8KngKtZHyLFfZhPEDSiLztJrf0tnYJls+pwwr7NlI3E8WDyrJIh6Jue3rhLsirQuJ/pS29Gh0ZyNbIVt2yV/CJhnjmUMOTvZZyz+e60ycmBxbc1geQCzKYtbAfkDZdTIddURR7G0/He/gPkCCCyMwJnbwG5VkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spxe6EdylDh8ItZy1eAroCkZZLLCbxerVaPy7Mz0kes=;
 b=znJJisYX+NobSzWjbtpv8Shqod83YH2P3P4FKFSpJ/CcltjNbl9apryqjEqMD3fDgC3hBMGGiCyqQJvMhsIw1R6cZALUcW8xEaHV7U4hEVstxlWEqGBvvNVqBL2hpKgWPxNLvDe849hcW92QP+noxL1PbSraIF0LdI9zGdY8JG4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4805.namprd04.prod.outlook.com (52.135.240.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 00:05:51 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 00:05:51 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Tue, 6 Aug 2019 00:05:51 +0000
Message-ID: <BYAPR04MB5816D1AB6B586FAD664F8D79E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
 <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <f3f98663-8f92-c933-c7c0-8db6635e6112@kernel.dk>
 <BYAPR04MB581644536C6EAEA36E3B4912E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816C7D04915AF7B656F900BE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14b915b0-fa46-4315-ff6a-08d71a01d7df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4805;
x-ms-traffictypediagnostic: BYAPR04MB4805:
x-microsoft-antispam-prvs: <BYAPR04MB4805DFDB34009C25211C772CE7D50@BYAPR04MB4805.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(51444003)(86362001)(229853002)(25786009)(476003)(53546011)(6506007)(76116006)(14454004)(7696005)(7736002)(4326008)(6246003)(102836004)(68736007)(316002)(81156014)(8936002)(110136005)(305945005)(66946007)(5660300002)(74316002)(71200400001)(9686003)(3846002)(52536014)(71190400001)(6116002)(76176011)(186003)(99286004)(6436002)(55016002)(66066001)(53936002)(256004)(66556008)(446003)(486006)(66446008)(8676002)(2906002)(478600001)(54906003)(66476007)(81166006)(64756008)(26005)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4805;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5mZBaHdCtcLiyX1mRLVoBgcTySlNSEPaM5tOxEQFvrzBkFgBUil78M7FpM7rGFqj+HbK69KYP8APra0kvZIwCxW5E4y7toAbtKtSdjpfRBmxGyHNyoWbkCJxRszalpAf+Sz6LoK8VmVjYCPhoUqVeMUiscU8hAteRt3Q3I7rSoiF87REvEwi+Ow5BBNhCQ0njaBG3qJUyzfhrD2vovMkZfIMNI28a7GHXxXJ0YIYRg2YMk4qzseb6bHOu2vGZsCD3zCfoCVntOEHGUjCddVVSnXl/Bo/1zveC/JsVW93IXuADoF4F3hNE4m8T7y2Q4MTBQxk+3ZzMx0WVZ9xFR4Zdi1udwM7gFUsBDWpZObQG2amRxQpIU7AOPwWsseFzCbTUYr8+H2kYr1LWkf7msGIDVYccBJYLEpZDNAsXT6Scvw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b915b0-fa46-4315-ff6a-08d71a01d7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 00:05:51.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4805
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/06 7:05, Damien Le Moal wrote:=0A=
> On 2019/08/06 6:59, Damien Le Moal wrote:=0A=
>> On 2019/08/06 6:28, Jens Axboe wrote:=0A=
>>> On 8/5/19 2:27 PM, Damien Le Moal wrote:=0A=
>>>> On 2019/08/06 6:26, Jens Axboe wrote:=0A=
>>>>>> In any case, looking again at this code, it looks like there is a=0A=
>>>>>> problem with dio->size being incremented early, even for fragments=
=0A=
>>>>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in=0A=
>>>>>> blkdev_bio_end_io(). So an incorrect size can be reported to user=0A=
>>>>>> space in that case on completion (e.g. large asynchronous no-wait di=
o=0A=
>>>>>> that cannot be issued in one go).=0A=
>>>>>>=0A=
>>>>>> So maybe something like this ? (completely untested)=0A=
>>>>>=0A=
>>>>> I think that looks pretty good, I like not double accounting with=0A=
>>>>> this_size and dio->size, and we retain the old style ordering for the=
=0A=
>>>>> ret value.=0A=
>>>>=0A=
>>>> Do you want a proper patch with real testing backup ? I can send that=
=0A=
>>>> later today.=0A=
>>>=0A=
>>> Yeah that'd be great, I like your approach better.=0A=
>>>=0A=
>>=0A=
>> Looking again, I think this is not it yet: dio->size is being referenced=
 after=0A=
>> submit_bio(), so blkdev_bio_end_io() may see the old value if the bio co=
mpletes=0A=
>> before dio->size increment. So the use-after-free is still there. And si=
nce=0A=
>> blkdev_bio_end_io() processes completion to user space only when dio->re=
f=0A=
>> becomes 0, adding an atomic_inc/dec(&dio->ref) over the loop would not h=
elp and=0A=
>> does not cover the single BIO case. Any idea how to address this one ?=
=0A=
>>=0A=
> =0A=
> May be add a bio_get/put() over the 2 places that do submit_bio() would w=
ork,=0A=
> for all cases (single/multi BIO, sync & async). E.g.:=0A=
> =0A=
> +                       bio_get(bio);=0A=
>                         qc =3D submit_bio(bio);=0A=
>                         if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
>                                 if (!dio->size)=0A=
>                                         ret =3D -EAGAIN;=0A=
> +                               bio_put(bio);=0A=
>                                 goto error;=0A=
>                         }=0A=
>                         dio->size +=3D bio_size;=0A=
> +                       bio_put(bio);=0A=
> =0A=
> Thoughts ?=0A=
> =0A=
=0A=
That does not work since the reference to dio->size in blkdev_bio_end_io()=
=0A=
depends on atomic_dec_and_test(&dio->ref) which counts the BIO fragments fo=
r the=0A=
dio (+1 for async multi-bio case). So completion of the last bio can still=
=0A=
reference the old value of dio->size.=0A=
=0A=
Adding a bio_get/put() on dio->bio ensures that dio stays around, but does =
not=0A=
prevent the use of the wrong dio->size. Adding an additional=0A=
atomic_inc/dec(&dio->ref) would prevent that, but we would need to handle d=
io=0A=
completion at the end of __blkdev_direct_IO() if all BIO fragments already=
=0A=
completed at that point. That is a lot more plumbing needed, relying comple=
tely=0A=
on dio->ref for all cases, thus removing the dio->multi_bio management.=0A=
=0A=
Something like this:=0A=
=0A=
diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
index a6f7c892cb4a..51d36baa367c 100644=0A=
--- a/fs/block_dev.c=0A=
+++ b/fs/block_dev.c=0A=
@@ -279,7 +279,6 @@ struct blkdev_dio {=0A=
        };=0A=
        size_t                  size;=0A=
        atomic_t                ref;=0A=
-       bool                    multi_bio : 1;=0A=
        bool                    should_dirty : 1;=0A=
        bool                    is_sync : 1;=0A=
        struct bio              bio;=0A=
@@ -295,15 +294,14 @@ static int blkdev_iopoll(struct kiocb *kiocb, bool wa=
it)=0A=
        return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);=0A=
 }=0A=
=0A=
-static void blkdev_bio_end_io(struct bio *bio)=0A=
+static inline void blkdev_get_dio(struct blkdev_dio *dio)=0A=
 {=0A=
-       struct blkdev_dio *dio =3D bio->bi_private;=0A=
-       bool should_dirty =3D dio->should_dirty;=0A=
-=0A=
-       if (bio->bi_status && !dio->bio.bi_status)=0A=
-               dio->bio.bi_status =3D bio->bi_status;=0A=
+       atomic_inc(&dio->ref);=0A=
+}=0A=
=0A=
-       if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {=0A=
+static void blkdev_put_dio(struct blkdev_dio *dio)=0A=
+{=0A=
+       if (atomic_dec_and_test(&dio->ref)) {=0A=
                if (!dio->is_sync) {=0A=
                        struct kiocb *iocb =3D dio->iocb;=0A=
                        ssize_t ret;=0A=
@@ -316,15 +314,25 @@ static void blkdev_bio_end_io(struct bio *bio)=0A=
                        }=0A=
=0A=
                        dio->iocb->ki_complete(iocb, ret, 0);=0A=
-                       if (dio->multi_bio)=0A=
-                               bio_put(&dio->bio);=0A=
                } else {=0A=
                        struct task_struct *waiter =3D dio->waiter;=0A=
=0A=
                        WRITE_ONCE(dio->waiter, NULL);=0A=
                        blk_wake_io_task(waiter);=0A=
                }=0A=
+               bio_put(&dio->bio);=0A=
        }=0A=
+}=0A=
+=0A=
+static void blkdev_bio_end_io(struct bio *bio)=0A=
+{=0A=
+       struct blkdev_dio *dio =3D bio->bi_private;=0A=
+       bool should_dirty =3D dio->should_dirty;=0A=
+=0A=
+       if (bio->bi_status && !dio->bio.bi_status)=0A=
+               dio->bio.bi_status =3D bio->bi_status;=0A=
+=0A=
+       blkdev_put_dio(dio);=0A=
=0A=
        if (should_dirty) {=0A=
                bio_check_pages_dirty(bio);=0A=
@@ -349,7 +357,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
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
@@ -366,17 +374,24 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r=0A=
*iter, int nr_pages)=0A=
=0A=
        dio =3D container_of(bio, struct blkdev_dio, bio);=0A=
        dio->is_sync =3D is_sync =3D is_sync_kiocb(iocb);=0A=
-       if (dio->is_sync) {=0A=
+       if (dio->is_sync)=0A=
                dio->waiter =3D current;=0A=
-               bio_get(bio);=0A=
-       } else {=0A=
+       else=0A=
                dio->iocb =3D iocb;=0A=
-       }=0A=
=0A=
        dio->size =3D 0;=0A=
-       dio->multi_bio =3D false;=0A=
        dio->should_dirty =3D is_read && iter_is_iovec(iter);=0A=
=0A=
+       /*=0A=
+        * Get an extra reference on the first bio to ensure that the dio=
=0A=
+        * structure which is embedded into the first bio stays around for =
AIOs=0A=
+        * and while we are still doing dio->size accounting in the loop be=
low.=0A=
+        * For dio->is_sync case, the extra reference is released on exit o=
f=0A=
+        * this function.=0A=
+        */=0A=
+       bio_get(bio);=0A=
+       blkdev_get_dio(dio);=0A=
+=0A=
        /*=0A=
         * Don't plug for HIPRI/polled IO, as those should go straight=0A=
         * to issue=0A=
@@ -386,6 +401,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
=0A=
        ret =3D 0;=0A=
        for (;;) {=0A=
+               size_t bio_size;=0A=
                int err;=0A=
=0A=
                bio_set_dev(bio, bdev);=0A=
@@ -421,7 +437,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
                if (nowait)=0A=
                        bio->bi_opf |=3D (REQ_NOWAIT | REQ_NOWAIT_INLINE);=
=0A=
=0A=
-               dio->size +=3D bio->bi_iter.bi_size;=0A=
+               bio_size =3D bio->bi_iter.bi_size;=0A=
                pos +=3D bio->bi_iter.bi_size;=0A=
=0A=
                nr_pages =3D iov_iter_npages(iter, BIO_MAX_PAGES);=0A=
=0A=
@@ -435,42 +451,30 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
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
+                       dio->size +=3D bio_size;=0A=
=0A=
                        if (polled)=0A=
                                WRITE_ONCE(iocb->ki_cookie, qc);=0A=
                        break;=0A=
                }=0A=
=0A=
-               if (!dio->multi_bio) {=0A=
-                       /*=0A=
-                        * AIO needs an extra reference to ensure the dio=
=0A=
-                        * structure which is embedded into the first bio=
=0A=
-                        * stays around.=0A=
-                        */=0A=
-                       if (!is_sync)=0A=
-                               bio_get(bio);=0A=
-                       dio->multi_bio =3D true;=0A=
-                       atomic_set(&dio->ref, 2);=0A=
-               } else {=0A=
-                       atomic_inc(&dio->ref);=0A=
-               }=0A=
+               blkdev_get_dio(dio);=0A=
=0A=
                qc =3D submit_bio(bio);=0A=
                if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
-                       if (!ret)=0A=
+                       if (!dio->size)=0A=
                                ret =3D -EAGAIN;=0A=
                        goto error;=0A=
                }=0A=
-               ret =3D dio->size;=0A=
+               dio->size +=3D bio_size;=0A=
=0A=
                bio =3D bio_alloc(gfp, nr_pages);=0A=
                if (!bio) {=0A=
-                       if (!ret)=0A=
+                       if (!dio->size)=0A=
                                ret =3D -EAGAIN;=0A=
                        goto error;=0A=
                }=0A=
@@ -496,8 +500,10 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
 out:=0A=
        if (!ret)=0A=
                ret =3D blk_status_to_errno(dio->bio.bi_status);=0A=
+       if (likely(!ret))=0A=
+               ret =3D dio->size;=0A=
=0A=
-       bio_put(&dio->bio);=0A=
+       blkdev_put_dio(dio);=0A=
        return ret;=0A=
 error:=0A=
        if (!is_poll)=0A=
=0A=
I think that works for all cases. Starting tests. Let me know if you think =
this=0A=
is not appropriate.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
