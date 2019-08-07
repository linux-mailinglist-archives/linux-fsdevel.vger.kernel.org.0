Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7833848C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 11:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfHGJnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 05:43:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39821 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfHGJnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565170979; x=1596706979;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NSYF7nYk1w4jNnGVXZdRtabuz7q8HvA1Q2tRs3/CEdk=;
  b=MMA01xK7x378p7mnTivAa246CageS3iu7rV/hcImJsTqqElRDC8Fgx7+
   Rc3NISI4VJ5AEGqklttkJ+6Iw8TTaXN8/3bxb5joqdBKFPnnRJe7zD8Dj
   G2xr5zn3AGfIbP/HIwX/a1Kmxc3TnInze1h9G8OY+JPVnP/WTRYgT/TdR
   74ibCouCNUIP+VcTe3BP4OcmLTNSJs6qI0W+ATEhtqR496R15tZZvCuUD
   tjoPHebxiNMnnsnWD0L917jCyKMUq7DbDUDKkJOKbNobeJUHb9TO6EpT4
   k9yq/+th9Wm2ML6HbbhUnbUIyr+10ox7EqFSGQef2vinLuI1ffQBYcoL1
   w==;
IronPort-SDR: uMaDpRW1tAu0yBJsed9GligAhkVR21Ssyc4lUkK1fjx9TfdEalKfMvqzOzBcOL2KKwdF1CnASh
 mc1KjG4Siz3v65O/aj5+0s0cH/BLi+TloTR0Fmjy60K8Cl7BeDIOAjmG16OUTbyTh+8xrp0/qM
 vQDuEuD/zCisYD8lrM96Ec3sYlvPW1o68+5TgR/wS+Na8S8OZamx9mPgEn7wVJGZhhlWmlmeCE
 03U3R5l4ZoiQjPXBQiremO7OM3i+TmVItp1qPd6aThAfAWmtvB8cB3WDenr02qVYppkO3YaEgY
 djU=
X-IronPort-AV: E=Sophos;i="5.64,357,1559491200"; 
   d="scan'208";a="115231216"
Received: from mail-by2nam03lp2058.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.58])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2019 17:42:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftYgF2PvZbaHMPRLq6xsd7sZWqOGPnQEvG1VB6HV3dkAs/41dMRgMvEeR9ZgBUd6SqkBV5A1mMc/RRTyoK38d0A3AYxPBPAnN1KILDevaIScZCPeKzxILpx3y7mRUYymo+//d7dOPwt9RLEoKb/1g3jfAIYvvPNV9huR1vxLE7LMm406+nLPIurO07ZJ8dShLe/D4WqrCbiAKlN79wYP1lXcfpKLQrlKLDY+vedVdPbW6uyKeER4w8+CI4dg8K9s4AAHTBLbbcd0O4TvAlqL7aWvycZ+03OaBXuuaTwtZThXzhdGvROo4xxmEeldkDqWgTARYIzq+J6Y2i/9LMznig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhBso0v8Uq97JpP+5zphI1ISJZZGN7Vg5tzvv3eYO38=;
 b=EA4SS9Y8RPqFE6QH2ozZtXNJcYMsSQraootjYjVpp/eRGWMYaH4SQGYBRTZvCqejcTgDmiaVV5MYpgR17g7EtQXbfdma4cwri1A9VZ5UClMDhD8SgyizVxZfr4gsx6XOVVLZS/9Vdg9jy36+Kg33gyHR5RZwSomNJiB8cuLY134XrFWe+xZVmSuuR5jcWLdSIQDA+/k0HF4tTlhJpLJK5DS7yIgdxgiboxaSidAX1ZzJhLUgywnhUT8jS8L6vPLxT6SOE9KU9TRdiogM9LD/NgkO6ttaVcxnu850Qx1M0UditdCTcuRFPV8aVAL1MdaLBat0hQbCF99F3In3zABItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhBso0v8Uq97JpP+5zphI1ISJZZGN7Vg5tzvv3eYO38=;
 b=azZpLVMNGXg6nvko+WWFZdkEekmVeUd+8ddf2KW/upblfLr73rUmsPlLUXGEwDQnEnSdnRvNwKBpNxd9IknsMkYevcgpme9dSD/eyo5TuvvkwMjK5f/gizkBqthYLWVKwYmuquFdkNVHOru9brMNyN1sDhspi3tZ3BYeD19aiFs=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3976.namprd04.prod.outlook.com (52.135.215.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 7 Aug 2019 09:42:57 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 09:42:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Wed, 7 Aug 2019 09:42:57 +0000
Message-ID: <BYAPR04MB581648AC018B9D932DAB3B15E7D40@BYAPR04MB5816.namprd04.prod.outlook.com>
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
 <BYAPR04MB5816811245DDC55429D6D146E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
 <e8d0653b-fdc5-e04c-641e-24b5cf859f3f@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8b79bd0-d75d-45e8-aac1-08d71b1ba102
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3976;
x-ms-traffictypediagnostic: BYAPR04MB3976:
x-microsoft-antispam-prvs: <BYAPR04MB39763142FF0FBA95AA8C42C5E7D40@BYAPR04MB3976.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(51444003)(7736002)(229853002)(74316002)(305945005)(86362001)(55016002)(9686003)(25786009)(6436002)(6246003)(8936002)(4326008)(81166006)(68736007)(8676002)(66446008)(91956017)(76116006)(66946007)(53936002)(71190400001)(71200400001)(52536014)(5660300002)(33656002)(81156014)(3846002)(6116002)(66556008)(64756008)(66476007)(316002)(54906003)(110136005)(76176011)(7696005)(99286004)(53546011)(66066001)(186003)(6506007)(446003)(486006)(476003)(14454004)(102836004)(26005)(2906002)(478600001)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3976;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NQSZ12+0/3PymqrmnU7czTPlTnQumyX07cSRNcwtpST6IGaQLzFf9VOO06P7NSoEJDeEeqssPlJ8Ry6BBv9MSu4LXiBpiJ5WsVnUoRitZqH4kUuLVnGSqvqQcRzeiu8J/SFwhhDVza+TTeCGZ0mKL8szaRJ1zYNG2B4Mi1VvFAr+bosi1TxiSiaYiN9BAfRwRI9THvc9lh7xfFPtp94ZTUdzaIFvCrZjeQMuEGkN8N94BjQ0auCxPB3Eo6PGTby3C/MeqU96Xz8FFEtbvM+dn2Mj8QbyAz5x7lHdIxYYce/9it6c58/lz7bRHT9MaNOQNd2TiqlJHAXqoiKoWRlI+7j1qDvgbtCYoXkT7Lq50SVULGUWakMiqxoBpv4dqLa2ZU2SiOe/ZT/tnA83Vkt92j5hKTc+anLn+/CnFI+zG4g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b79bd0-d75d-45e8-aac1-08d71b1ba102
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 09:42:57.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3976
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/06 22:34, Jens Axboe wrote:=0A=
> On 8/6/19 12:05 AM, Damien Le Moal wrote:=0A=
>> On 2019/08/06 13:09, Jens Axboe wrote:=0A=
>>> On 8/5/19 5:05 PM, Damien Le Moal wrote:=0A=
>>>> On 2019/08/06 7:05, Damien Le Moal wrote:=0A=
>>>>> On 2019/08/06 6:59, Damien Le Moal wrote:=0A=
>>>>>> On 2019/08/06 6:28, Jens Axboe wrote:=0A=
>>>>>>> On 8/5/19 2:27 PM, Damien Le Moal wrote:=0A=
>>>>>>>> On 2019/08/06 6:26, Jens Axboe wrote:=0A=
>>>>>>>>>> In any case, looking again at this code, it looks like there is =
a=0A=
>>>>>>>>>> problem with dio->size being incremented early, even for fragmen=
ts=0A=
>>>>>>>>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in=0A=
>>>>>>>>>> blkdev_bio_end_io(). So an incorrect size can be reported to use=
r=0A=
>>>>>>>>>> space in that case on completion (e.g. large asynchronous no-wai=
t dio=0A=
>>>>>>>>>> that cannot be issued in one go).=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> So maybe something like this ? (completely untested)=0A=
>>>>>>>>>=0A=
>>>>>>>>> I think that looks pretty good, I like not double accounting with=
=0A=
>>>>>>>>> this_size and dio->size, and we retain the old style ordering for=
 the=0A=
>>>>>>>>> ret value.=0A=
>>>>>>>>=0A=
>>>>>>>> Do you want a proper patch with real testing backup ? I can send t=
hat=0A=
>>>>>>>> later today.=0A=
>>>>>>>=0A=
>>>>>>> Yeah that'd be great, I like your approach better.=0A=
>>>>>>>=0A=
>>>>>>=0A=
>>>>>> Looking again, I think this is not it yet: dio->size is being refere=
nced after=0A=
>>>>>> submit_bio(), so blkdev_bio_end_io() may see the old value if the bi=
o completes=0A=
>>>>>> before dio->size increment. So the use-after-free is still there. An=
d since=0A=
>>>>>> blkdev_bio_end_io() processes completion to user space only when dio=
->ref=0A=
>>>>>> becomes 0, adding an atomic_inc/dec(&dio->ref) over the loop would n=
ot help and=0A=
>>>>>> does not cover the single BIO case. Any idea how to address this one=
 ?=0A=
>>>>>>=0A=
>>>>>=0A=
>>>>> May be add a bio_get/put() over the 2 places that do submit_bio() wou=
ld work,=0A=
>>>>> for all cases (single/multi BIO, sync & async). E.g.:=0A=
>>>>>=0A=
>>>>> +                       bio_get(bio);=0A=
>>>>>                           qc =3D submit_bio(bio);=0A=
>>>>>                           if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
>>>>>                                   if (!dio->size)=0A=
>>>>>                                           ret =3D -EAGAIN;=0A=
>>>>> +                               bio_put(bio);=0A=
>>>>>                                   goto error;=0A=
>>>>>                           }=0A=
>>>>>                           dio->size +=3D bio_size;=0A=
>>>>> +                       bio_put(bio);=0A=
>>>>>=0A=
>>>>> Thoughts ?=0A=
>>>>>=0A=
>>>>=0A=
>>>> That does not work since the reference to dio->size in=0A=
>>>> blkdev_bio_end_io() depends on atomic_dec_and_test(&dio->ref) which=0A=
>>>> counts the BIO fragments for the dio (+1 for async multi-bio case). So=
=0A=
>>>> completion of the last bio can still reference the old value of=0A=
>>>> dio->size.=0A=
>>>>=0A=
>>>> Adding a bio_get/put() on dio->bio ensures that dio stays around, but=
=0A=
>>>> does not prevent the use of the wrong dio->size. Adding an additional=
=0A=
>>>> atomic_inc/dec(&dio->ref) would prevent that, but we would need to=0A=
>>>> handle dio completion at the end of __blkdev_direct_IO() if all BIO=0A=
>>>> fragments already completed at that point. That is a lot more plumbing=
=0A=
>>>> needed, relying completely on dio->ref for all cases, thus removing=0A=
>>>> the dio->multi_bio management.=0A=
>>>>=0A=
>>>> Something like this:=0A=
>>>=0A=
>>> Don't like this, as it adds unnecessary atomics for the sync case.=0A=
>>> What's wrong with just adjusting dio->size if we get BLK_QC_T_EAGAIN?=
=0A=
>>> It's safe to do so, since we're doing the final put later. We just can'=
t=0A=
>>> do it for the normal case of submit_bio() succeeding. Kill the new 'ret=
'=0A=
>>> usage and return to what we had as well, it's more readable too imho.=
=0A=
>>>=0A=
>>> Totally untested...=0A=
>>>=0A=
>>> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
>>> index a6f7c892cb4a..131e2e0582a6 100644=0A=
>>> --- a/fs/block_dev.c=0A=
>>> +++ b/fs/block_dev.c=0A=
>>> @@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_i=
ter *iter, int nr_pages)=0A=
>>>   	loff_t pos =3D iocb->ki_pos;=0A=
>>>   	blk_qc_t qc =3D BLK_QC_T_NONE;=0A=
>>>   	gfp_t gfp;=0A=
>>> -	ssize_t ret;=0A=
>>> +	int ret;=0A=
>>>   =0A=
>>>   	if ((pos | iov_iter_alignment(iter)) &=0A=
>>>   	    (bdev_logical_block_size(bdev) - 1))=0A=
>>> @@ -386,8 +386,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_i=
ter *iter, int nr_pages)=0A=
>>>   =0A=
>>>   	ret =3D 0;=0A=
>>>   	for (;;) {=0A=
>>> -		int err;=0A=
>>> -=0A=
>>>   		bio_set_dev(bio, bdev);=0A=
>>>   		bio->bi_iter.bi_sector =3D pos >> 9;=0A=
>>>   		bio->bi_write_hint =3D iocb->ki_hint;=0A=
>>> @@ -395,10 +393,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_=
iter *iter, int nr_pages)=0A=
>>>   		bio->bi_end_io =3D blkdev_bio_end_io;=0A=
>>>   		bio->bi_ioprio =3D iocb->ki_ioprio;=0A=
>>>   =0A=
>>> -		err =3D bio_iov_iter_get_pages(bio, iter);=0A=
>>> -		if (unlikely(err)) {=0A=
>>> -			if (!ret)=0A=
>>> -				ret =3D err;=0A=
>>> +		ret =3D bio_iov_iter_get_pages(bio, iter);=0A=
>>> +		if (unlikely(ret)) {=0A=
>>>   			bio->bi_status =3D BLK_STS_IOERR;=0A=
>>>   			bio_endio(bio);=0A=
>>>   			break;=0A=
>>> @@ -421,7 +417,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_i=
ter *iter, int nr_pages)=0A=
>>>   		if (nowait)=0A=
>>>   			bio->bi_opf |=3D (REQ_NOWAIT | REQ_NOWAIT_INLINE);=0A=
>>>   =0A=
>>> -		dio->size +=3D bio->bi_iter.bi_size;=0A=
>>>   		pos +=3D bio->bi_iter.bi_size;=0A=
>>>   =0A=
>>>   		nr_pages =3D iov_iter_npages(iter, BIO_MAX_PAGES);=0A=
>>> @@ -433,13 +428,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov=
_iter *iter, int nr_pages)=0A=
>>>   				polled =3D true;=0A=
>>>   			}=0A=
>>>   =0A=
>>> +			dio->size +=3D bio->bi_iter.bi_size;=0A=
>>>   			qc =3D submit_bio(bio);=0A=
>>>   			if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
>>> -				if (!ret)=0A=
>>> -					ret =3D -EAGAIN;=0A=
>>> +				dio->size -=3D bio->bi_iter.bi_size;=0A=
>>=0A=
>> ref after free of bio here. Easy to fix though. Also, with this, the=0A=
>> bio_endio() call within submit_bio() for the EAGAIN failure will see a=
=0A=
>> dio->size too large, including this failed bio. So this does not work.=
=0A=
> =0A=
> There's no ref after free here - if BLK_QC_T_EAGAIN is being returned,=0A=
> the bio has not been freed. There's no calling bio_endio() for that=0A=
> case.=0A=
> =0A=
> For dio->size, it doesn't matter. If we get the error here, bio_endio()=
=0A=
> was never called. And if the submission is successful, we use dio->size=
=0A=
> for the success case.=0A=
> =0A=
=0A=
OK. Got it (I checked REQ_NOWAIT_INLINE, I should have done this earlier !)=
.=0A=
=0A=
But, unless I am missing something again, there are 2 other problems though=
:=0A=
1) I do not see a bio_put() for the bio submission failure with BLK_QC_T_EA=
GAIN.=0A=
2) If the submission failure is for a bio fragment of a multi-bio dio, dio-=
>ref=0A=
for this failed bio will never be decremented, so the dio will never comple=
te.=0A=
=0A=
I am still trying to get a reliable way to generate BLK_QC_T_EAGAIN submit_=
bio()=0A=
failures for testing. Any hint on how to do this ? I tried setting qd to 1 =
and=0A=
nr_requests to the minimum 4 and generate a lot of load on the test disk, b=
ut=0A=
never got BLK_QC_T_EAGAIN.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
