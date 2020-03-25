Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5131C1920A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 06:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgCYFi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 01:38:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34083 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYFi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585114737; x=1616650737;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JLwJEkxyjp+Ja5aoLp2sOGzn7/UAGWkx3Tcdszmtffg=;
  b=pxRS3Om+fI21iVf9zY1vBg+tLikoezth9lKsl77tK4/6Z5HzTq9F26Z3
   neHno8fKIZQDdDuqu/7dh+m2uTQDuoifjf/kH0v5Gua7aVuGQx42abKEa
   0jXrWok8b2BQIIkb4dcIkUZpXexU6PEkR3GVfvrC1UWYLYS2OmfsvsI8j
   UlnYimXXjgrkI+eERYOoiwmgSXODXqRehJADg4Id8vXs2osYV8grOO2Ee
   pnWlGtKeW8TWKfTtXcFmySPvzDlsRP4YskVFUFpMO16GqxgSJPrWUra6i
   Tyfp02NKKdnXIEc7EU00PYl7nG5oEbFHa3awNQCkJfxsX6o76SkV3e3uq
   w==;
IronPort-SDR: qpVYa4LltWN3P1t03u55Y/0N6EOPmwT3BjSx3svOdny7uOnySNs2NNUt9ZGUT34SmBoWH+2+XE
 h6YcJBgyjnRmKTCWDK6cfoh98cTO9Jxbzkub24MII74jMpdaadL6+oWNITKAn0WLX3gsPJiHBy
 HkNwy2mtaDq1adqWm3k5jWuM7wQtYptXTRZbQLKPQN0Mndqj61jT9Vy99YR8L8IafyE44+/egF
 bceLTL0HHKx4hmoSfl2wqOjXinhwuHbsRKgqmRTTejDHSRjN13h7ugpzElGEwfrxAGS09TiuFw
 2y4=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="235661408"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 13:38:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvRnmGtfglov7Po23Sjbobn05Wvb/mPcN79TDYHvPV8ePaxypxv93xdhL9T3SSuSMcghpb8hnBH6XNM+oaVohq/SpAm1p6sF+tf4yBQ4SCNgNbqF8Ny/Mi7oXsycObDZUWR7WVlvIf0KFhj8AF+ROfwCWbhsC79pGfvvla9gyXmGyc+1vcUzY2wXl2/9S0Ku+9FVjdYZ/iB9+StbDDr7VAAX72/y0m2yNmhQqWNuJ8iFE5ciUUFeWk9JZ73sn87cC1lsy+kSjl6x8xYjrE5cRT7PC8rfluu1EPv5jYsPAWI0kAydiL4XJYRIIaDsUWzOSmln+Bet5pQEr3cXRhonqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55wzhfBM1OFznbdWS9+MP4g/xnR4JYGU75reDUTfDDo=;
 b=RAbb9Ecb8cQOLD2CG6jpjVu5Qh+VCQXZqaGmi/6jErMeBuY7j0zfoUwHZHARUabKJJb0BqS1cjY3HzN/GStGz2PZq5yqcAWIn4Iv5InF9rUvH/O/qrEmVjwQViaNI3p80DQNb9c37QAR64frvmA9siy6uKADo/9IqckIOcbg0dD2zgm6Q+DHKduAw9JGGGmlot4uxjqzQMkmRk69LZWiXM0EgoZBvgmz4mFwc59n6I9fdWBlQwlvqiXBo1OlfLhW2OkBlyExHB64J418VwucSssEu6mivXsM4FCnYGkZNUQovmW+oXj7BE80AEUiXRVPMR3oP0fmiHdTx0DtLxCB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55wzhfBM1OFznbdWS9+MP4g/xnR4JYGU75reDUTfDDo=;
 b=nmAozD2XwpIv2xSo/XN+LzNRxEmupk1MhxNU4ck44LOhRR0BhhxoRa0lN+LQNfoYJsgnVMxlYSaQTO9t9/GrZZeCXCKVIw87j9rmmSY0lLf/uDmKoPI3f2KtlxbaZa2C1Ut8zNQEu/LxCWeBqexa/iTxaLHniPkzBiQanxs4M8I=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2263.namprd04.prod.outlook.com (2603:10b6:102:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Wed, 25 Mar
 2020 05:38:53 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 05:38:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Topic: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Index: AQHWAfBwIA62KDxQPU+QCf/8uspjMw==
Date:   Wed, 25 Mar 2020 05:38:53 +0000
Message-ID: <CO2PR04MB234355E7714F0845A8D75CEDE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324224552.GI10737@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74d93374-2191-4cb0-0ab2-08d7d07ecdc4
x-ms-traffictypediagnostic: CO2PR04MB2263:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB226384885E447B5040F2E435E7CE0@CO2PR04MB2263.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(52536014)(66946007)(91956017)(66446008)(64756008)(66556008)(76116006)(66476007)(71200400001)(26005)(5660300002)(110136005)(33656002)(316002)(186003)(53546011)(6506007)(86362001)(8936002)(7696005)(8676002)(81166006)(81156014)(6636002)(2906002)(54906003)(4326008)(9686003)(55016002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2263;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYbM5Y3Ecx6YoOeEnUhD9/bRTMwCKyMtni3uaxn8XlvcaGzRWHRs8yzYHo/3lu+6mewMxmnFrYh5+iDdXhet9FqCcvqdRx2IjNTw0jPMa/c+5b7QWLLiphoQ20nu2XEsoB2MYP9jesiE1MRMAUmLta2Lecta+yr+Xg99n+fKs7inNlwthcfYuhRb7kaxVPa6MlF89iU+NzCfRKaaISN4S4r4TgXku6mvvCLKRzh4IShg609pt68LG0xnf9epYshhoxoa8I2ndiahuIAdT9P3D2sixkoV0dUzmO5wnc6oHSpLKt3gqY9skA+HfJDdmfOC6KC4RG1cVDmPl8HGVHjjU7hk+z8qP644Z0X4MpVFk9mFCiNzPYzlFUa69sdjeqh/gZbnFbdq57m1dztXrYUsH/mj5BBfi9SfcvSbHqLATAgeI2v14fBoKNCZmDr4IuRv
x-ms-exchange-antispam-messagedata: RKqtI97ujocmPLTSfGSvoyv2CmEiwJ5MaAJmqFUX/ARV79rDsVhSxulPzqmGzvwUiswZ85Lp7lLyiytaRNH8ugFk67IBWS7KRQIIhQytm1Aww6YkWz7aqKiD85ScKAlT9wPLjEPsWcrSlPowk4EWxA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d93374-2191-4cb0-0ab2-08d7d07ecdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 05:38:53.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5rfDyXdCwwceWReoi86q1Dm4rpfbTTMWF851TSeWAZwPlovV4RGVee9ec20d20qhAGfP2h+e1RC0MWyHv0LpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2263
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/25 7:46, Dave Chinner wrote:=0A=
> On Wed, Mar 25, 2020 at 12:24:53AM +0900, Johannes Thumshirn wrote:=0A=
>> Use REQ_OP_ZONE_APPEND for direct I/O write BIOs, instead of REQ_OP_WRIT=
E=0A=
>> if the file-system requests it. The file system can make this request=0A=
>> by setting the new flag IOCB_ZONE_APPEND for a direct I/O kiocb before=
=0A=
>> calling iompa_dio_rw(). Using this information, this function propagates=
=0A=
>> the zone append flag using IOMAP_ZONE_APPEND to the file system=0A=
>> iomap_begin() method. The BIOs submitted for the zone append DIO will be=
=0A=
>> set to use the REQ_OP_ZONE_APPEND operation.=0A=
>>=0A=
>> Since zone append operations cannot be split, the iomap_apply() and=0A=
>> iomap_dio_rw() internal loops are executed only once, which may result=
=0A=
>> in short writes.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/iomap/direct-io.c  | 80 ++++++++++++++++++++++++++++++++++++-------=
=0A=
>>  include/linux/fs.h    |  1 +=0A=
>>  include/linux/iomap.h | 22 ++++++------=0A=
>>  3 files changed, 79 insertions(+), 24 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c=0A=
>> index 23837926c0c5..b3e2aadce72f 100644=0A=
>> --- a/fs/iomap/direct-io.c=0A=
>> +++ b/fs/iomap/direct-io.c=0A=
>> @@ -17,6 +17,7 @@=0A=
>>   * Private flags for iomap_dio, must not overlap with the public ones i=
n=0A=
>>   * iomap.h:=0A=
>>   */=0A=
>> +#define IOMAP_DIO_ZONE_APPEND	(1 << 27)=0A=
>>  #define IOMAP_DIO_WRITE_FUA	(1 << 28)=0A=
>>  #define IOMAP_DIO_NEED_SYNC	(1 << 29)=0A=
>>  #define IOMAP_DIO_WRITE		(1 << 30)=0A=
>> @@ -39,6 +40,7 @@ struct iomap_dio {=0A=
>>  			struct task_struct	*waiter;=0A=
>>  			struct request_queue	*last_queue;=0A=
>>  			blk_qc_t		cookie;=0A=
>> +			sector_t		sector;=0A=
>>  		} submit;=0A=
>>  =0A=
>>  		/* used for aio completion: */=0A=
>> @@ -151,6 +153,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)=0A=
>>  	if (bio->bi_status)=0A=
>>  		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));=0A=
>>  =0A=
>> +	if (dio->flags & IOMAP_DIO_ZONE_APPEND)=0A=
>> +		dio->submit.sector =3D bio->bi_iter.bi_sector;=0A=
>> +=0A=
>>  	if (atomic_dec_and_test(&dio->ref)) {=0A=
>>  		if (dio->wait_for_completion) {=0A=
>>  			struct task_struct *waiter =3D dio->submit.waiter;=0A=
>> @@ -194,6 +199,21 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap =
*iomap, loff_t pos,=0A=
>>  	iomap_dio_submit_bio(dio, iomap, bio);=0A=
>>  }=0A=
>>  =0A=
>> +static sector_t=0A=
>> +iomap_dio_bio_sector(struct iomap_dio *dio, struct iomap *iomap, loff_t=
 pos)=0A=
>> +{=0A=
>> +	sector_t sector =3D iomap_sector(iomap, pos);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For zone append writes, the BIO needs to point at the start of the=
=0A=
>> +	 * zone to append to.=0A=
>> +	 */=0A=
>> +	if (dio->flags & IOMAP_DIO_ZONE_APPEND)=0A=
>> +		sector =3D ALIGN_DOWN(sector, bdev_zone_sectors(iomap->bdev));=0A=
>> +=0A=
>> +	return sector;=0A=
>> +}=0A=
> =0A=
> This seems to me like it should be done by the ->iomap_begin=0A=
> implementation when mapping the IO. I don't see why this needs to be=0A=
> specially handled by the iomap dio code.=0A=
=0A=
Fair point. However, iomap_sector() does not simply return iomap->addr >> 9=
. So=0A=
that means that in iomap_begin, the mapping address and offset returned nee=
ds to=0A=
account for the iomap_sector() calculation, i.e.=0A=
=0A=
(iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT=0A=
=0A=
which does not result in a very obvious values for iomap address and offset=
.=0A=
Well I guess for zone append we simply need to set=0A=
iomap->offset =3D pos;=0A=
and=0A=
iomap->addr =3D zone start sector;=0A=
and that would then work. This however look fragile to me.=0A=
=0A=
> =0A=
>> +=0A=
>>  static loff_t=0A=
>>  iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,=0A=
>>  		struct iomap_dio *dio, struct iomap *iomap)=0A=
>> @@ -204,6 +224,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos,=
 loff_t length,=0A=
>>  	struct bio *bio;=0A=
>>  	bool need_zeroout =3D false;=0A=
>>  	bool use_fua =3D false;=0A=
>> +	bool zone_append =3D false;=0A=
>>  	int nr_pages, ret =3D 0;=0A=
>>  	size_t copied =3D 0;=0A=
>>  	size_t orig_count;=0A=
>> @@ -235,6 +256,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos,=
 loff_t length,=0A=
>>  			use_fua =3D true;=0A=
>>  	}=0A=
>>  =0A=
>> +	if (dio->flags & IOMAP_DIO_ZONE_APPEND)=0A=
>> +		zone_append =3D true;=0A=
>> +=0A=
>>  	/*=0A=
>>  	 * Save the original count and trim the iter to just the extent we=0A=
>>  	 * are operating on right now.  The iter will be re-expanded once=0A=
>> @@ -266,12 +290,28 @@ iomap_dio_bio_actor(struct inode *inode, loff_t po=
s, loff_t length,=0A=
>>  =0A=
>>  		bio =3D bio_alloc(GFP_KERNEL, nr_pages);=0A=
>>  		bio_set_dev(bio, iomap->bdev);=0A=
>> -		bio->bi_iter.bi_sector =3D iomap_sector(iomap, pos);=0A=
>> +		bio->bi_iter.bi_sector =3D iomap_dio_bio_sector(dio, iomap, pos);=0A=
>>  		bio->bi_write_hint =3D dio->iocb->ki_hint;=0A=
>>  		bio->bi_ioprio =3D dio->iocb->ki_ioprio;=0A=
>>  		bio->bi_private =3D dio;=0A=
>>  		bio->bi_end_io =3D iomap_dio_bio_end_io;=0A=
>>  =0A=
>> +		if (dio->flags & IOMAP_DIO_WRITE) {=0A=
>> +			bio->bi_opf =3D REQ_SYNC | REQ_IDLE;=0A=
>> +			if (zone_append)=0A=
>> +				bio->bi_opf |=3D REQ_OP_ZONE_APPEND;=0A=
>> +			else=0A=
>> +				bio->bi_opf |=3D REQ_OP_WRITE;=0A=
>> +			if (use_fua)=0A=
>> +				bio->bi_opf |=3D REQ_FUA;=0A=
>> +			else=0A=
>> +				dio->flags &=3D ~IOMAP_DIO_WRITE_FUA;=0A=
>> +		} else {=0A=
>> +			bio->bi_opf =3D REQ_OP_READ;=0A=
>> +			if (dio->flags & IOMAP_DIO_DIRTY)=0A=
>> +				bio_set_pages_dirty(bio);=0A=
>> +		}=0A=
> =0A=
> Why move all this code? If it's needed, please split it into a=0A=
> separate patchi to separate it from the new functionality...=0A=
=0A=
The BIO add page in bio_iov_iter_get_pages() needs to know that the BIO is =
a=0A=
zone append to stop adding pages before the BIO grows too large and result =
in a=0A=
split when it is submitted. So bio->bi_opf needs to be set before calling=
=0A=
bio_iov_iter_get_pages(). So this change is related to the new functionalit=
y.=0A=
But I guess it is OK to do it regardless of the BIO operation.=0A=
=0A=
> =0A=
>> +=0A=
>>  		ret =3D bio_iov_iter_get_pages(bio, dio->submit.iter);=0A=
>>  		if (unlikely(ret)) {=0A=
>>  			/*=0A=
>> @@ -284,19 +324,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t po=
s, loff_t length,=0A=
>>  			goto zero_tail;=0A=
>>  		}=0A=
>>  =0A=
>> -		n =3D bio->bi_iter.bi_size;=0A=
>> -		if (dio->flags & IOMAP_DIO_WRITE) {=0A=
>> -			bio->bi_opf =3D REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;=0A=
>> -			if (use_fua)=0A=
>> -				bio->bi_opf |=3D REQ_FUA;=0A=
>> -			else=0A=
>> -				dio->flags &=3D ~IOMAP_DIO_WRITE_FUA;=0A=
>> +		if (dio->flags & IOMAP_DIO_WRITE)=0A=
>>  			task_io_account_write(n);=0A=
>> -		} else {=0A=
>> -			bio->bi_opf =3D REQ_OP_READ;=0A=
>> -			if (dio->flags & IOMAP_DIO_DIRTY)=0A=
>> -				bio_set_pages_dirty(bio);=0A=
>> -		}=0A=
>> +=0A=
>> +		n =3D bio->bi_iter.bi_size;=0A=
>>  =0A=
>>  		dio->size +=3D n;=0A=
>>  		pos +=3D n;=0A=
>> @@ -304,6 +335,15 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos=
, loff_t length,=0A=
>>  =0A=
>>  		nr_pages =3D iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);=0A=
>>  		iomap_dio_submit_bio(dio, iomap, bio);=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * Issuing multiple BIOs for a large zone append write can=0A=
>> +		 * result in reordering of the write fragments and to data=0A=
>> +		 * corruption. So always stop after the first BIO is issued.=0A=
>> +		 */=0A=
>> +		if (zone_append)=0A=
>> +			break;=0A=
> =0A=
> I don't think this sort of functionality should be tied to "zone=0A=
> append". If there is a need for "issue a single (short) bio only" it=0A=
> should be a flag to iomap_dio_rw() set by the filesystem, which can=0A=
> then handle the short read/write that is returned.=0A=
=0A=
Yes, that would be cleaner.=0A=
=0A=
> =0A=
>> +		/*=0A=
>> +		 * Zone append writes cannot be split and be shorted. Break=0A=
>> +		 * here to let the user know instead of sending more IOs which=0A=
>> +		 * could get reordered and corrupt the written data.=0A=
>> +		 */=0A=
>> +		if (flags & IOMAP_ZONE_APPEND)=0A=
>> +			break;=0A=
> =0A=
> ditto.=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Dave.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
