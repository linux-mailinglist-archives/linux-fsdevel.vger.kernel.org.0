Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA3832A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfHFNXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 09:23:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55148 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFNXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565097814; x=1596633814;
  h=from:to:cc:subject:date:message-id:references:
   mime-version;
  bh=ZH4iY6OOmFQMHrLPBM8T66zmzFlzASROv69Q5tJlTpM=;
  b=XrfdAYiAqmgsOTA5ly3xxc528qStwDA2eC2rj2w7IVSBpXVMfOXBek/6
   wISc8l4wKng75gWKcpUzQ1mVx7UaH/QBwap02dhKsJKT2EiWkSC8Y8eIN
   /aubZE3t86Lvdt0+K3BGbMSmX0YQBGWu6Ql+DhO4RLIfFtFt2RfyVMQk1
   KR/gZ4gQskHmSv0rogFXGvsfzYqvRqMJ8wy6Z3uPtI4N6BZJ2lawCTRiD
   MATt19437JjDn/HV2yKQewrVcV4z91KgVCDt+08z0S7IvirjBMU+d59TL
   ObZ0CDfqIh2H+Vv1m4hYUKgdx8jZS0U9KfrfAOzcA7R0U1WpTZwotSKS3
   A==;
IronPort-SDR: caawkf2Pq/2D2+RQVCYgeUwab/FylTKeQoVNhcBSrOeBn5s7KRZYussXGQLaehnSixmmg41mEv
 IICO6fnP10mJfAz1b3hmtsp+fT14RI/qhOyAttQp0yZ1Qc+yRrHEH2N3KjS0npOlGzVYIg9nKX
 1qFPF/Z+VnbpLoKuCaxipXFskqgGGSw98KDMDXUuLHk85kJEPpIL2IqXS84KB+g4cupj1yZDwD
 ep5lAjAyYGdC0kmCMxexYD0pO7eVuUZzn8U92y/CseqyAbVaEJm8qoRGQqi7ZfxgJZN1n/Snvy
 0PM=
X-IronPort-AV: E=Sophos;i="5.64,353,1559491200"; 
   d="c'?scan'208";a="116094113"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 21:23:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhSNxkJwOXiDAnXaPTQIwcUVUXn8H0ZKF/2ia5s4hwffcFo/HZcJdoVFMRkUAidr2ama55jWpj7oemmIvE3Tf3+t45YR8lQl86SySLYCMaWM7ZsLNxDsQSsNjYxawOu+rIVUWZpf6A6Ctxw//pTQ+t64AdoULvjVtW6LYG3+7fnfb8ROS7zNO+5iI7iQ9URF3V4teCrfslvfrZcA/4l9hf9i0BgTMsXHmvX0RYdSDrpCSIaNEA9lIs3ID4peDqgZGfdJYEkjfRGuFu0kYHYvhXvn4eOOOiJYMTrRO5BLceeMecmZn7jSQqrcL2qoQbDTKx7CbdgzFGC1FjtMbJpraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s2h8FbUaUj4GcforUAVibABiFmzPXUudLG5orVtUng=;
 b=RRd5TCmNTBzBBYn4k0ROjbvhNapbHs1Yqj00mi4v/OWjaCmrvB9W0zTNBS+fwz02hFHE7Ql7rH0SG7TKwlHmC3yx4YXwAwhlTNjmrtuxnXHJ0euPX308DFg6/oHJR96eMriBond+nO33iYkYqKS9yKsEnbsi0KE5xCIvFvgIfEVeUgInpM1DgOB1NIYjZeGAe/HIXaWywEHgT9KbsO9IStLpFyMI3nIyr0oP09LJ8GrnUGvOWzCWqcKuqvwa+PSQ/GC8BtwxXePtfeLMwF5PhYPFkqOhPwM+u93A3JwlVPfe9I0lVpN/EtffKY5MNkPgQJSoU15RKHTIDVucL+QZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s2h8FbUaUj4GcforUAVibABiFmzPXUudLG5orVtUng=;
 b=YfkVrdpgbu82eT1Ax3w/Ue/3m/ePONGAX7jObSn7Xw7pYP1GaUJsha5WLQMpz5u77oGEs5qVCd15l4AP+qvCaoNEaQZiLdX9oj5jqlc8UX440eM2OSkIikHTSM79r8kEhscE+pfE3zG30XgWsWEN2Aa8hLi4yayzvvMDLBr6xFw=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3973.namprd04.prod.outlook.com (52.135.215.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 6 Aug 2019 13:23:31 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 13:23:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Tue, 6 Aug 2019 13:23:31 +0000
Message-ID: <BYAPR04MB58168184B3055417B2231A2AE7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
 <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <f3f98663-8f92-c933-c7c0-8db6635e6112@kernel.dk>
 <BYAPR04MB581644536C6EAEA36E3B4912E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816C7D04915AF7B656F900BE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816D1AB6B586FAD664F8D79E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
 <43435418-9d70-ec33-1f2d-c95fb986979c@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05e9f16a-d37a-46d7-4802-08d71a7146a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(49563074)(7193020);SRVR:BYAPR04MB3973;
x-ms-traffictypediagnostic: BYAPR04MB3973:
x-microsoft-antispam-prvs: <BYAPR04MB39737D140161B6811AC9FE4AE7D50@BYAPR04MB3973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(51444003)(199004)(189003)(8676002)(81156014)(99936001)(25786009)(486006)(561944003)(33656002)(66556008)(7736002)(446003)(256004)(5024004)(305945005)(8936002)(54906003)(476003)(4326008)(6246003)(316002)(14444005)(2906002)(64756008)(110136005)(66946007)(66476007)(66616009)(74316002)(66446008)(66066001)(81166006)(102836004)(26005)(53546011)(186003)(6116002)(14454004)(7696005)(76116006)(9686003)(3846002)(52536014)(86362001)(68736007)(55016002)(76176011)(5660300002)(71200400001)(99286004)(6436002)(229853002)(53936002)(478600001)(71190400001)(6506007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3973;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o+pOCTpHQ6VWmRpMRvEOegU3GFsDVyCT7/lOjehD0VhhaTKfli2u3jFvWPAsHueguVTXb45iidqRhClAFqZ9h1FhcPeVV5AvW/SxtvHys8ciY90awlStKFLRoFag9wjQprmR7XeNtv6nILwvAj2cclCFTR9FX2y1pJ9quyAq0HdnWS4wgrJGuIB6UW1Lz0kvNbIGtkSxHpCmljzl2sCt565Ar1gIeuCjuwtxDs0gcKNBFOsDUWfn7raSo4E7OGh8XAwRoVlauLYruvLAyizGYeH+Me8JtHMZiU89OF4G0ahXEqZujrxsSorM3q4RXOLIRG0M/HPWjYRhEZ7Axsx6CNRr/6NQjzpfCt0TEd3LxvhWTnQiQfCFsp80wL8Aj1K2/wSPzc0Gi+O34SXX8jZ+Oyn9Ql3O6uLjqfotU3Nzu0c=
Content-Type: multipart/mixed;
        boundary="_002_BYAPR04MB58168184B3055417B2231A2AE7D50BYAPR04MB5816namp_"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e9f16a-d37a-46d7-4802-08d71a7146a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 13:23:31.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3973
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_BYAPR04MB58168184B3055417B2231A2AE7D50BYAPR04MB5816namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 2019/08/06 13:09, Jens Axboe wrote:=0A=
> On 8/5/19 5:05 PM, Damien Le Moal wrote:=0A=
>> On 2019/08/06 7:05, Damien Le Moal wrote:=0A=
>>> On 2019/08/06 6:59, Damien Le Moal wrote:=0A=
>>>> On 2019/08/06 6:28, Jens Axboe wrote:=0A=
>>>>> On 8/5/19 2:27 PM, Damien Le Moal wrote:=0A=
>>>>>> On 2019/08/06 6:26, Jens Axboe wrote:=0A=
>>>>>>>> In any case, looking again at this code, it looks like there is a=
=0A=
>>>>>>>> problem with dio->size being incremented early, even for fragments=
=0A=
>>>>>>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in=0A=
>>>>>>>> blkdev_bio_end_io(). So an incorrect size can be reported to user=
=0A=
>>>>>>>> space in that case on completion (e.g. large asynchronous no-wait =
dio=0A=
>>>>>>>> that cannot be issued in one go).=0A=
>>>>>>>>=0A=
>>>>>>>> So maybe something like this ? (completely untested)=0A=
>>>>>>>=0A=
>>>>>>> I think that looks pretty good, I like not double accounting with=
=0A=
>>>>>>> this_size and dio->size, and we retain the old style ordering for t=
he=0A=
>>>>>>> ret value.=0A=
>>>>>>=0A=
>>>>>> Do you want a proper patch with real testing backup ? I can send tha=
t=0A=
>>>>>> later today.=0A=
>>>>>=0A=
>>>>> Yeah that'd be great, I like your approach better.=0A=
>>>>>=0A=
>>>>=0A=
>>>> Looking again, I think this is not it yet: dio->size is being referenc=
ed after=0A=
>>>> submit_bio(), so blkdev_bio_end_io() may see the old value if the bio =
completes=0A=
>>>> before dio->size increment. So the use-after-free is still there. And =
since=0A=
>>>> blkdev_bio_end_io() processes completion to user space only when dio->=
ref=0A=
>>>> becomes 0, adding an atomic_inc/dec(&dio->ref) over the loop would not=
 help and=0A=
>>>> does not cover the single BIO case. Any idea how to address this one ?=
=0A=
>>>>=0A=
>>>=0A=
>>> May be add a bio_get/put() over the 2 places that do submit_bio() would=
 work,=0A=
>>> for all cases (single/multi BIO, sync & async). E.g.:=0A=
>>>=0A=
>>> +                       bio_get(bio);=0A=
>>>                          qc =3D submit_bio(bio);=0A=
>>>                          if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
>>>                                  if (!dio->size)=0A=
>>>                                          ret =3D -EAGAIN;=0A=
>>> +                               bio_put(bio);=0A=
>>>                                  goto error;=0A=
>>>                          }=0A=
>>>                          dio->size +=3D bio_size;=0A=
>>> +                       bio_put(bio);=0A=
>>>=0A=
>>> Thoughts ?=0A=
>>>=0A=
>>=0A=
>> That does not work since the reference to dio->size in=0A=
>> blkdev_bio_end_io() depends on atomic_dec_and_test(&dio->ref) which=0A=
>> counts the BIO fragments for the dio (+1 for async multi-bio case). So=
=0A=
>> completion of the last bio can still reference the old value of=0A=
>> dio->size.=0A=
>>=0A=
>> Adding a bio_get/put() on dio->bio ensures that dio stays around, but=0A=
>> does not prevent the use of the wrong dio->size. Adding an additional=0A=
>> atomic_inc/dec(&dio->ref) would prevent that, but we would need to=0A=
>> handle dio completion at the end of __blkdev_direct_IO() if all BIO=0A=
>> fragments already completed at that point. That is a lot more plumbing=
=0A=
>> needed, relying completely on dio->ref for all cases, thus removing=0A=
>> the dio->multi_bio management.=0A=
>>=0A=
>> Something like this:=0A=
> =0A=
> Don't like this, as it adds unnecessary atomics for the sync case.=0A=
> What's wrong with just adjusting dio->size if we get BLK_QC_T_EAGAIN?=0A=
> It's safe to do so, since we're doing the final put later. We just can't=
=0A=
> do it for the normal case of submit_bio() succeeding. Kill the new 'ret'=
=0A=
> usage and return to what we had as well, it's more readable too imho.=0A=
=0A=
Here is what I have so far:=0A=
=0A=
diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
index a6f7c892cb4a..6dd945fdf962 100644=0A=
--- a/fs/block_dev.c=0A=
+++ b/fs/block_dev.c=0A=
@@ -300,7 +300,9 @@ static void blkdev_bio_end_io(struct bio *bio)=0A=
        struct blkdev_dio *dio =3D bio->bi_private;=0A=
        bool should_dirty =3D dio->should_dirty;=0A=
=0A=
-       if (bio->bi_status && !dio->bio.bi_status)=0A=
+       if (bio->bi_status &&=0A=
+           bio->bi_status !=3D BLK_STS_AGAIN &&=0A=
+           !dio->bio.bi_status)=0A=
                dio->bio.bi_status =3D bio->bi_status;=0A=
=0A=
        if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {=0A=
@@ -349,7 +351,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
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
@@ -386,7 +388,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
=0A=
        ret =3D 0;=0A=
        for (;;) {=0A=
-               int err;=0A=
+               unsigned int bio_size;=0A=
=0A=
                bio_set_dev(bio, bdev);=0A=
                bio->bi_iter.bi_sector =3D pos >> 9;=0A=
@@ -395,10 +397,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
*iter, int nr_pages)=0A=
                bio->bi_end_io =3D blkdev_bio_end_io;=0A=
                bio->bi_ioprio =3D iocb->ki_ioprio;=0A=
=0A=
-               err =3D bio_iov_iter_get_pages(bio, iter);=0A=
-               if (unlikely(err)) {=0A=
-                       if (!ret)=0A=
-                               ret =3D err;=0A=
+               ret =3D bio_iov_iter_get_pages(bio, iter);=0A=
+               if (unlikely(ret)) {=0A=
                        bio->bi_status =3D BLK_STS_IOERR;=0A=
                        bio_endio(bio);=0A=
                        break;=0A=
@@ -421,7 +421,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
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
@@ -435,11 +435,11 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
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
@@ -462,15 +462,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
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
+               dio->size +=3D bio_size;=0A=
=0A=
                bio =3D bio_alloc(gfp, nr_pages);=0A=
                if (!bio) {=0A=
-                       if (!ret)=0A=
+                       if (!dio->size)=0A=
                                ret =3D -EAGAIN;=0A=
                        goto error;=0A=
                }=0A=
@@ -496,6 +496,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter=
=0A=
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
This fixes the sync case return value with nowait, but the async case is st=
ill=0A=
wrong as there is a potential use-after-free of dio and dio->size seen by=
=0A=
blkdev_bio_end_io() may not be the uptodate incremented value after submit_=
bio().=0A=
=0A=
And I am stuck. I do not see how to fix this without the extra dio referenc=
e and=0A=
handling of completion of dio->ref decrement also in __blkdev_direct_IO(). =
This=0A=
is the previous proposal I sent that you did not like. This extra ref solut=
ion=0A=
is similar to the iomap direct IO code. Any other idea ?=0A=
=0A=
Also, I am seeing some very weird behavior of submit_bio() with the nowait =
case.=0A=
For very large dio requests, I see submit_bio returning BLK_QC_T_EAGAIN but=
 the=0A=
bio actually going to the drive, which of course does not make sense.=0A=
Another thing I noticed is that REQ_NOWAIT_INLINE is handled for the inline=
=0A=
error return only by blk_mq_make_request(). generic_make_request() is lacki=
ng=0A=
handling of REQ_NOWAIT through bio_wouldblock_error().=0A=
=0A=
I will keep digging into all this, but being on vacation this week, I may b=
e=0A=
very slow.=0A=
=0A=
FYI, attaching to this email the small application I used for testing. Plan=
ning=0A=
to use it for blktests cases.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

--_002_BYAPR04MB58168184B3055417B2231A2AE7D50BYAPR04MB5816namp_
Content-Type: text/plain; name="dio.c"
Content-Description: dio.c
Content-Disposition: attachment; filename="dio.c"; size=4682;
	creation-date="Tue, 06 Aug 2019 13:23:30 GMT";
	modification-date="Tue, 06 Aug 2019 13:23:30 GMT"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKgogKiBDb3B5cmlnaHQg
KEMpIDIwMTkgV2VzdGVybiBEaWdpdGFsIENvcnBvcmF0aW9uIG9yIGl0cyBhZmZpbGlhdGVzLgog
KiBBdXRob3I6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQHdkYy5jb20+CiAqLwojZGVm
aW5lIF9HTlVfU09VUkNFCgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgoj
aW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxlcnJuby5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5
cy9zdGF0Lmg+CiNpbmNsdWRlIDxzeXMvdWlvLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgoj
aW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGxpbnV4L2Fpb19hYmkuaD4KI2luY2x1ZGUgPGxp
bnV4L2ZzLmg+CgpzdGF0aWMgdm9pZCBkaW9fdXNhZ2UoY2hhciAqY21kKQp7CglwcmludGYoIlVz
YWdlOiAlcyBbb3B0aW9uc10gPGRldiBwYXRoPiA8b2Zmc2V0IChCKT4gPHNpemUgKEIpPlxuIiwK
CSAgICAgICBjbWQpOwoJcHJpbnRmKCJPcHRpb25zOlxuIgoJICAgICAgICIgICAgLXJkOiBkbyBy
ZWFkIChkZWZhdWx0KVxuIgoJICAgICAgICIgICAgLXdyOiBkbyB3clxuIgoJICAgICAgICIgICAg
LW5vd2FpdDogVXNlIFJXRl9OT1dBSVQgKGRvIG5vdCB3YWl0IGZvciByZXNvdXJjZXMpLlxuIgoJ
ICAgICAgICIgICAgLWFzeW5jOiBEbyBhc3luY2hyb25vdXMgZGlyZWN0IElPXG4iKTsKfQoKc3Np
emVfdCBwcmVhZHYyKGludCBmZCwgY29uc3Qgc3RydWN0IGlvdmVjICppb3YsIGludCBpb3ZjbnQs
CgkJb2ZmX3Qgb2Zmc2V0LCBpbnQgZmxhZ3MpCnsKCXJldHVybiBzeXNjYWxsKFNZU19wcmVhZHYy
LCBmZCwgaW92LCBpb3ZjbnQsIG9mZnNldCwgMCwgZmxhZ3MpOwp9Cgpzc2l6ZV90IHB3cml0ZXYy
KGludCBmZCwgY29uc3Qgc3RydWN0IGlvdmVjICppb3YsIGludCBpb3ZjbnQsCgkJIG9mZl90IG9m
ZnNldCwgaW50IGZsYWdzKQp7CglyZXR1cm4gc3lzY2FsbChTWVNfcHdyaXRldjIsIGZkLCBpb3Ys
IGlvdmNudCwgb2Zmc2V0LCAwLCBmbGFncyk7Cn0KCnN0YXRpYyB2b2lkIGRpb19zeW5jKGludCBm
ZCwgdm9pZCAqYnVmLCBzaXplX3Qgc2l6ZSwgbG9mZl90IG9mZnNldCwgaW50IGZsYWdzLAoJCSAg
ICAgYm9vbCBkb19yZWFkKQp7Cglzc2l6ZV90IHJldDsKCXN0cnVjdCBpb3ZlYyBpb3YgPSB7CgkJ
Lmlvdl9iYXNlID0gYnVmLAoJCS5pb3ZfbGVuID0gc2l6ZSwKCX07CgoJaWYgKGRvX3JlYWQpCgkJ
cmV0ID0gcHJlYWR2MihmZCwgJmlvdiwgMSwgb2Zmc2V0LCBmbGFncyk7CgllbHNlCgkJcmV0ID0g
cHdyaXRldjIoZmQsICZpb3YsIDEsIG9mZnNldCwgZmxhZ3MpOwoJaWYgKHJldCA8IDApCgkJcmV0
ID0gLWVycm5vOwoKCXByaW50ZigiJXp1ICV6ZFxuIiwgc2l6ZSwgcmV0KTsKfQoKc3RhdGljIGlu
bGluZSBpbnQgaW9fc2V0dXAodW5zaWduZWQgaW50IG5yLCBhaW9fY29udGV4dF90ICpjdHhwKQp7
CglyZXR1cm4gc3lzY2FsbChfX05SX2lvX3NldHVwLCBuciwgY3R4cCk7Cn0KCnN0YXRpYyBpbmxp
bmUgaW50IGlvX2Rlc3Ryb3koYWlvX2NvbnRleHRfdCBjdHgpCnsKCXJldHVybiBzeXNjYWxsKF9f
TlJfaW9fZGVzdHJveSwgY3R4KTsKfQoKc3RhdGljIGlubGluZSBpbnQgaW9fc3VibWl0KGFpb19j
b250ZXh0X3QgY3R4LCBsb25nIG5yLCBzdHJ1Y3QgaW9jYiAqKmlvY2JwcCkKewoJcmV0dXJuIHN5
c2NhbGwoX19OUl9pb19zdWJtaXQsIGN0eCwgbnIsIGlvY2JwcCk7Cn0KCnN0YXRpYyBpbmxpbmUg
aW50IGlvX2dldGV2ZW50cyhhaW9fY29udGV4dF90IGN0eCwgbG9uZyBtaW5fbnIsIGxvbmcgbWF4
X25yLAoJCQkgICAgICAgc3RydWN0IGlvX2V2ZW50ICpldmVudHMsCgkJCSAgICAgICBzdHJ1Y3Qg
dGltZXNwZWMgKnRpbWVvdXQpCnsKCXJldHVybiBzeXNjYWxsKF9fTlJfaW9fZ2V0ZXZlbnRzLCBj
dHgsIG1pbl9uciwgbWF4X25yLCBldmVudHMsIHRpbWVvdXQpOwp9CgpzdGF0aWMgdm9pZCBkaW9f
YXN5bmMoaW50IGZkLCB2b2lkICpidWYsIHNpemVfdCBzaXplLCBsb2ZmX3Qgb2Zmc2V0LCBpbnQg
ZmxhZ3MsCgkJICAgICAgYm9vbCBkb19yZWFkKQp7CglhaW9fY29udGV4dF90IGFpb2N0eDsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICBzdHJ1Y3QgaW9jYiBhaW9jYiwg
KmFpb2NiczsKCXN0cnVjdCBpb19ldmVudCBhaW9ldmVudDsKCXNzaXplX3QgcmV0OwoKCW1lbXNl
dCgmYWlvY3R4LCAwLCBzaXplb2YoYWlvY3R4KSk7CgltZW1zZXQoJmFpb2NiLCAwLCBzaXplb2Yo
YWlvY2IpKTsKCW1lbXNldCgmYWlvZXZlbnQsIDAsIHNpemVvZihhaW9ldmVudCkpOwoKCXJldCA9
IGlvX3NldHVwKDEsICZhaW9jdHgpOwogICAgICAgIGlmIChyZXQgPCAwKSB7CiAgICAgICAgICAg
ICAgICBmcHJpbnRmKHN0ZGVyciwKICAgICAgICAgICAgICAgICAgICAgICAgImlvX3NldHVwIGZh
aWxlZCAlZCAoJXMpXG4iLCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKICAgICAgICAgICAgICAg
IHJldHVybjsKICAgICAgICB9CgoJYWlvY2IuYWlvX2ZpbGRlcyA9IGZkOwoJYWlvY2IuYWlvX2J1
ZiA9ICh1bnNpZ25lZCBsb25nKWJ1ZjsKCWFpb2NiLmFpb19uYnl0ZXMgPSBzaXplOwoJaWYgKGRv
X3JlYWQpCgkJYWlvY2IuYWlvX2xpb19vcGNvZGUgPSBJT0NCX0NNRF9QUkVBRDsKCWVsc2UKCQlh
aW9jYi5haW9fbGlvX29wY29kZSA9IElPQ0JfQ01EX1BXUklURTsKCWFpb2NiLmFpb19yd19mbGFn
cyA9IGZsYWdzOwoJYWlvY2JzID0gJmFpb2NiOwoKCXJldCA9IGlvX3N1Ym1pdChhaW9jdHgsIDEs
ICZhaW9jYnMpOwoJaWYgKHJldCA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgImlvX3N1Ym1pdCBm
YWlsZWQgJWQgKCVzKVxuIiwKCQkJZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CgkJZ290byBvdXQ7
Cgl9CgoJcmV0ID0gaW9fZ2V0ZXZlbnRzKGFpb2N0eCwgMSwgMSwgJmFpb2V2ZW50LCBOVUxMKTsK
ICAgICAgICBpZiAocmV0ICE9IDEpIHsKICAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAi
aW9fZ2V0ZXZlbnRzIGZhaWxlZCAlZCAoJXMpXG4iLAogICAgICAgICAgICAgICAgICAgICAgICBl
cnJubywgc3RyZXJyb3IoZXJybm8pKTsKCQlnb3RvIG91dDsKICAgICAgICB9CgoJcHJpbnRmKCIl
enUgJWxsZFxuIiwgc2l6ZSwgYWlvZXZlbnQucmVzKTsKCm91dDoKCWlvX2Rlc3Ryb3koYWlvY3R4
KTsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7CglpbnQgcmV0LCBmZCwgaSwg
ZmxhZ3MgPSAwOwoJY2hhciAqZGV2X3BhdGg7Cglsb2ZmX3Qgb2Zmc2V0OwoJc2l6ZV90IHNpemU7
Cgl2b2lkICpidWYgPSBOVUxMOwoJYm9vbCBhc3luYyA9IGZhbHNlOwoJYm9vbCBkb19yZWFkID0g
dHJ1ZTsKCWludCBvcGVuX2ZsYWdzID0gT19ESVJFQ1Q7CgoJZm9yIChpID0gMTsgaSA8IGFyZ2M7
IGkrKykgewoJCWlmIChzdHJjbXAoYXJndltpXSwgIi1ub3dhaXQiKSA9PSAwKSB7CgkJCWZsYWdz
ID0gUldGX05PV0FJVDsKCQl9IGVsc2UgaWYgKHN0cmNtcChhcmd2W2ldLCAiLWFzeW5jIikgPT0g
MCkgewoJCQlhc3luYyA9IHRydWU7CgkJfSBlbHNlIGlmIChzdHJjbXAoYXJndltpXSwgIi1yZCIp
ID09IDApIHsKCQkJZG9fcmVhZCA9IHRydWU7CgkJfSBlbHNlIGlmIChzdHJjbXAoYXJndltpXSwg
Ii13ciIpID09IDApIHsKCQkJZG9fcmVhZCA9IGZhbHNlOwoJCX0gZWxzZSBpZiAoYXJndltpXVsw
XSA9PSAnLScpIHsKCQkJZnByaW50ZihzdGRlcnIsICJJbnZhbGlkIG9wdGlvbiAlc1xuIiwgYXJn
dltpXSk7CgkJCXJldHVybiAxOwoJCX0gZWxzZSB7CgkJCWJyZWFrOwoJCX0KCX0KCglpZiAoYXJn
YyAtIGkgIT0gMykgewoJCWRpb191c2FnZShhcmd2WzBdKTsKCQlyZXR1cm4gMTsKCX0KCglkZXZf
cGF0aCA9IGFyZ3ZbaV07CglvZmZzZXQgPSBhdG9sbChhcmd2W2kgKyAxXSk7CglpZiAob2Zmc2V0
IDwgMCkgewoJCWZwcmludGYoc3RkZXJyLCAiSW52YWxpZCBvZmZzZXQgJXNcbiIsIGFyZ3ZbaSAr
IDFdKTsKCQlyZXR1cm4gMTsKCX0KCglzaXplID0gYXRvbGwoYXJndltpICsgMl0pOwoKCWlmIChk
b19yZWFkKQoJCW9wZW5fZmxhZ3MgfD0gT19SRE9OTFk7CgllbHNlCgkJb3Blbl9mbGFncyB8PSBP
X1dST05MWTsKCWZkID0gb3BlbihkZXZfcGF0aCwgb3Blbl9mbGFncywgMCk7CglpZiAoZmQgPCAw
KSB7CgkJZnByaW50ZihzdGRlcnIsICJPcGVuICVzIGZhaWxlZCAlZCAoJXMpXG4iLAoJCQlkZXZf
cGF0aCwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CgkJcmV0dXJuIDE7Cgl9CgoJcmV0ID0gcG9z
aXhfbWVtYWxpZ24oKHZvaWQgKiopICZidWYsIHN5c2NvbmYoX1NDX1BBR0VTSVpFKSwgc2l6ZSk7
CglpZiAocmV0ICE9IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgIkFsbG9jYXRlIGJ1ZmZlciBmYWls
ZWQgJWQgKCVzKVxuIiwKCQkJLXJldCwgc3RyZXJyb3IoLXJldCkpOwoJCXJldCA9IDE7CgkJZ290
byBvdXQ7Cgl9CgoJaWYgKCFhc3luYykKCQlkaW9fc3luYyhmZCwgYnVmLCBzaXplLCBvZmZzZXQs
IGZsYWdzLCBkb19yZWFkKTsKCWVsc2UKCQlkaW9fYXN5bmMoZmQsIGJ1Ziwgc2l6ZSwgb2Zmc2V0
LCBmbGFncywgZG9fcmVhZCk7CgpvdXQ6CgljbG9zZShmZCk7CglmcmVlKGJ1Zik7CgoJcmV0dXJu
IHJldDsKfQo=

--_002_BYAPR04MB58168184B3055417B2231A2AE7D50BYAPR04MB5816namp_--
