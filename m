Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA582C40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 09:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfHFHFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 03:05:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49145 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbfHFHFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565075150; x=1596611150;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=o/KISqIe0mmWI1mH1xgLB5XVlI8P5/4irUJlkT6/X4E=;
  b=UNG4miHmZqp/k0onWwJJ99QsMTGM2ji1qSGPhIyD0mt5BUlw1eZ9qcUT
   Dn6xUHrNbx5DUeyna/jx+K8+a3LlqDKA18q28efRNwccgSo8vm7Fni3Lh
   OTHWgYU8emnHZ1LkZBk/7Z6XTCKnVEwlewKwmzYAThUgt9EZR83skRgVk
   MIPeIbJSv+iLevH5TAAePArlsFMy5K/YMWhkz4yNg8XfyUU98Q9b26H/v
   O/9lFFtwTc7hXqONKarZaGqvgziwjP9u4N6wEv+EYlqxezToow5eQZtss
   Bp6akewYLztPPNqBJ7hf1TAKA0P2xT4L4bmhZscNExQhQk53TE5I8ZeRa
   Q==;
IronPort-SDR: AJ0nAfoSkM0LucqIcef0H30883n5+sCuyhagEedvQdjSZ/rKhJmCr7a4Bq1p62sNYO6VvivzxQ
 St8RZs1w5+tDt6LTnjjLB6Nc3qjTDhd3Xu/ylImNUVXWpBtG1JPLlMNooZYRirgumBFBbTdw1n
 EHQ7jEgfRGylf+wj6a7oMeB6WUGGjVqkKtGL83uZGGOQF71fif0FzuSw9boQnmqhScU5OseuvA
 O8bFFOyX7lImv7Lkgu9xvKjp7AKELevvuLhQJUJVZmG9i0J7qYmd0sds6aSjXpQJP5+UElNWjk
 sro=
X-IronPort-AV: E=Sophos;i="5.64,352,1559491200"; 
   d="scan'208";a="215369241"
Received: from mail-sn1nam01lp2058.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.58])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 15:05:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBZdvC0e+BgivSPuFb3ybdE+E8aS9gXNk1rNJ1v4OFiTbyf1LhDsaVoakn+pGdbxxIeemNnEb6GXvh2vtJ6+TC7r7LzxcJgIM9O/mKDRPiRa5cflJckCyWaSWYhG0OXWCbGXnUAGiB2QoHTejxor18bLNzn7b/NRvYwRJdN41uKzeMfovShqeD3WkxPsFCnZPOgDuYjHaGsPiuK0srRNCsQssj9IyZxhY6MeQd846IfufKH5Uah1Sc8SKDHe1slY4FmxKt1/OUUSE00MQvppEmvg9fF3EvpZPrqcXNaYI705vcPyNlSDwk4gEJVFxuZtDswhbqkCuEqCrGyzRsT78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cK4EKkG+mFqUXkOUmbLIuQaKFNEZMKJa+3wmfs7caU=;
 b=H+usBK0N+uKH7jy9q+vrg2jV+v615qm4SkN0j82FQTDhaBvQ3EvMZ9CZO35tPE2YZcsG9amiDzRbiC1mC6mI/kNw/r1FENPAHAH1GGVUuLzzJ4CEj64XPg2YhwqueR3qyeN0knVpv2kI1ZP3ImQOdalEfUD7Brkh2abpaKUCQ/SSKIpKZd79WDSGB9aPfem1fJlrm1iknUTnAR9aw16QLox6UXgpP430VowHDCU6ZXknFC+EEUm1O+R+N0LkgrU4slGtYcHLdedQ3RYGtrvY9jmw+FkHjEUXTQAT3rGz/ew5ON1J5MExdnrvUbzXcQpQ+4fqucO5IrtolZvejj1KUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cK4EKkG+mFqUXkOUmbLIuQaKFNEZMKJa+3wmfs7caU=;
 b=krPrG1M/CZ8tR7hkkU5E61i2zMc5PjFJCE2d9hAwNetr5XpOivpprtNgibMuQfMCItXE8hUesCWEUzrAdoBzyB8B1Kpn6pc6N93fi8Uq4Jx7Gy6PxK9/ozCh3zqemBMvQtFmLOCFCToFwrORYeakm0iHX2+tQbYyX1ojdU5xutc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3991.namprd04.prod.outlook.com (52.135.215.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 6 Aug 2019 07:05:03 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 07:05:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Tue, 6 Aug 2019 07:05:03 +0000
Message-ID: <BYAPR04MB5816811245DDC55429D6D146E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
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
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9517572-737b-49ac-6648-08d71a3c67d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB3991;
x-ms-traffictypediagnostic: BYAPR04MB3991:
x-microsoft-antispam-prvs: <BYAPR04MB3991297A97E27645CDBE04A3E7D50@BYAPR04MB3991.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(51444003)(199004)(189003)(14444005)(6506007)(64756008)(478600001)(66446008)(53546011)(305945005)(74316002)(76116006)(68736007)(186003)(6436002)(3846002)(6116002)(66476007)(66556008)(102836004)(14454004)(81166006)(55016002)(446003)(86362001)(71200400001)(256004)(54906003)(7736002)(33656002)(25786009)(110136005)(316002)(66946007)(6246003)(71190400001)(8936002)(7696005)(486006)(2906002)(66066001)(476003)(5660300002)(53936002)(99286004)(26005)(8676002)(229853002)(52536014)(9686003)(76176011)(4326008)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3991;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cssQCzfEQayXEQlSzM6+afkhPI+2mLDw3PU7IchWFJi/aNfLyI+BuJSRrrtK07w1naKnWbWrOqA3OZzIYW4elzuczpY/pHef65fbl4m46Z6C6hchJjPTt0dDSmueb8k0HQoZlBM9Ov5hIBclgURV5JS1WVagqosC79q+3O/RJisK3pdFR13tfftXBtiW4uxlSbG/DnBcqhkrYy6Y0Ikj2LlF/ebS5h9vOxZX0KGSBq6bXWl6Uc8Ca4lf0aNAx7MqZmpJZz/jx7rLX6paBeeS+AK70yEUmG/czNq7r0kTQS5FPedR3YmxBsUM20ndaANlJM1N6MNzsN2RcF43Pas+zKna2LOvJ6U0VY34KDGk6lCSi1SDJm8zV7dwrYgUSTUtiXkwm9HK+RBsg5JBSfC8vKx0NGWMDNRo2e14JhA2/VI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9517572-737b-49ac-6648-08d71a3c67d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 07:05:03.7939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3991
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
> =0A=
> Totally untested...=0A=
> =0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index a6f7c892cb4a..131e2e0582a6 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  	loff_t pos =3D iocb->ki_pos;=0A=
>  	blk_qc_t qc =3D BLK_QC_T_NONE;=0A=
>  	gfp_t gfp;=0A=
> -	ssize_t ret;=0A=
> +	int ret;=0A=
>  =0A=
>  	if ((pos | iov_iter_alignment(iter)) &=0A=
>  	    (bdev_logical_block_size(bdev) - 1))=0A=
> @@ -386,8 +386,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  =0A=
>  	ret =3D 0;=0A=
>  	for (;;) {=0A=
> -		int err;=0A=
> -=0A=
>  		bio_set_dev(bio, bdev);=0A=
>  		bio->bi_iter.bi_sector =3D pos >> 9;=0A=
>  		bio->bi_write_hint =3D iocb->ki_hint;=0A=
> @@ -395,10 +393,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_it=
er *iter, int nr_pages)=0A=
>  		bio->bi_end_io =3D blkdev_bio_end_io;=0A=
>  		bio->bi_ioprio =3D iocb->ki_ioprio;=0A=
>  =0A=
> -		err =3D bio_iov_iter_get_pages(bio, iter);=0A=
> -		if (unlikely(err)) {=0A=
> -			if (!ret)=0A=
> -				ret =3D err;=0A=
> +		ret =3D bio_iov_iter_get_pages(bio, iter);=0A=
> +		if (unlikely(ret)) {=0A=
>  			bio->bi_status =3D BLK_STS_IOERR;=0A=
>  			bio_endio(bio);=0A=
>  			break;=0A=
> @@ -421,7 +417,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  		if (nowait)=0A=
>  			bio->bi_opf |=3D (REQ_NOWAIT | REQ_NOWAIT_INLINE);=0A=
>  =0A=
> -		dio->size +=3D bio->bi_iter.bi_size;=0A=
>  		pos +=3D bio->bi_iter.bi_size;=0A=
>  =0A=
>  		nr_pages =3D iov_iter_npages(iter, BIO_MAX_PAGES);=0A=
> @@ -433,13 +428,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_i=
ter *iter, int nr_pages)=0A=
>  				polled =3D true;=0A=
>  			}=0A=
>  =0A=
> +			dio->size +=3D bio->bi_iter.bi_size;=0A=
>  			qc =3D submit_bio(bio);=0A=
>  			if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
> -				if (!ret)=0A=
> -					ret =3D -EAGAIN;=0A=
> +				dio->size -=3D bio->bi_iter.bi_size;=0A=
=0A=
ref after free of bio here. Easy to fix though. Also, with this, the bio_en=
dio()=0A=
call within submit_bio() for the EAGAIN failure will see a dio->size too la=
rge,=0A=
including this failed bio. So this does not work.=0A=
=0A=
One thing I do not 100% sure is the nowait case with a fragmented dio: if t=
he=0A=
processing stops on a BLK_QC_T_EAGAIN, the code in blkdev_bio_end_io() will=
=0A=
complete the iocb with -EAGAIN, while this code (submission path) will retu=
rn=0A=
the amount of submitted bytes for the dio (short read or write). So for now=
ait=0A=
&& is_sync case, this means that preadv2/pwritev2 would always get -EAGAIN=
=0A=
instead of the partial read/write achieved. For the nowait && !is_sync case=
,=0A=
similarly, aio_return() would always return -EAGAIN too even if a partial=
=0A=
read/write was done. Or am I missing something ? Checking again the man pag=
es,=0A=
this does not look like the described behavior.=0A=
=0A=
If this analysis is correct, I think the proper fix cannot be done only in=
=0A=
__blkdev_direct_IO(). blkdev_bio_end_io() needs to change too. Basically, I=
=0A=
think the "dio->size -=3D bio->bi_iter.bi_size" needs to go into=0A=
blkdev_bio_end_io() and a test added to see if dio->size is 0 (then complet=
e=0A=
with -EAGAIN) or not (then partial completion).=0A=
Starting testing something now with these changes in blkdev_bio_end_io().=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
