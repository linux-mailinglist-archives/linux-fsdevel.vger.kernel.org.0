Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6519209D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 06:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCYF1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 01:27:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:65251 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYF1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585114061; x=1616650061;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ye2NAkKQBlZlQ1ZbR3MTWRJcqUz0Q0qDeXlWpKqk9VE=;
  b=Z7qLWBO66innBsDsS0W9jzvEs5dcDsCwA4+0KT1BHYDnvp/M+QxNc5LF
   z7unOuqsxEurdQoNX9cHWu6Utx+RgzkM1u4l0mJQLqfxof0g4FlhSugF6
   ZUEt2Ok10E5AykBofKn8HAGv/7Tq5umkcBeFIbzVvyta1Ut6Yj1qeqRcD
   ne5Dd2GoPMnAlNcchn78+oszwVIjsKyAARQNXQNuc9BIBSw05S4yM9V/K
   dK5K4VR0HeAd35R6us/GawME+Lvm+nwDgx5PI8MdgUokqfsSteLkyuvqb
   kV6djPFQNGpAkeklo5PQauNY0eMmzGVgMnaTGM8GfwPhn1SAiklo1iWDT
   Q==;
IronPort-SDR: qvZs9VlS57sCB993X/Hs+5KpYk9Hz6ubaeay1u+6D88YRXS0YCotfYBzPokhsDHiiUrWDuwFAY
 kumHfZ8BZa89vSPMuswko+Ac/ePkxk3HItyS7NmxgGHXZU7XRbHlmH80W1fT8sZDt+KIZU5n7l
 /2Zmq7EGfrQDBT7hKB5/PxP4RVYe1BzuEPaPpxfXjEkpHEVVUcs0BRyZaBaPCh1JheVTSirmXq
 2M3HaEpzNMrol1c28XLR80EAiZ12NuJmJDbT1MBlG2hnPiHea4szkewaSo+PJxDpAUZALELjwi
 bzo=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="134889020"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 13:27:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is91NPmHEuaJEUEoJvb6ygT9eH/Ewrf2rcM8sph67clU0GOp9ZwAhmNG4SxjfkczseLIc61MyX2VTZeqGBRvoO775bbBe4QNwtGs/5+hQ/o87OXJPWXUPN99jwDiZmbjHzsX/GXduA8UDrFhb31AKUNET+6TWp8vPhiJEVHjmm2+5eQhzdYC6j0T38IZ7mHWNzYkvQDwgOhVkmCvTtcTjZHzf/Wk5QCNeYd9v0gK62z2mNMJeuSrX3y4I/fu4vB7yXKrg5qr9fStD/pqUnRCrnF2M6++j0pwrQ2vl9VU3KgB3REg4ct9S13DWwo/LgdPToYIyDg6W86aAC1sAtWSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx1AkGD6fAqnAa12WEEz9X5AYufrBmTVtyDDcCM44Ps=;
 b=CKQso2Z/5zNrBxcND+v29IhjAgT+PyIal0rOxs0u7NRGePiamilhdFJSlFUGbOSuqgzVPzdlbjSnT9ja7fTOQwnWxQfHtqnXYaWgb3Z3z71h/9du+YQ+w6dbNOaylr68Xp1cbr5+swQvCqaEox2/8bY/LKPIfcEeY4Bw8Q7B/cMUHWQPInosGOEWmhz4iahdKBpduOpWSvo57s2KGyQKDJ61E0CyGgbM5wrdyhC15GlIEc2DPmOMk6AZiji2t8EgiqjRhYw4vsUFsUAWjx0k1Nwt+mU4TG4ZK4bOjuDRdBp4FrQzxwxt225Bl0CFfbyiZb1h9+c7Veha/vVs0H0JxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx1AkGD6fAqnAa12WEEz9X5AYufrBmTVtyDDcCM44Ps=;
 b=ZDLsqVP0rM1W6m5WFoJ70vqo4sA//ENm4eL/9OH3jBVAKapsCUpzT5pLyNr03zWdNzwiveboVmSH4hr3qM9oBqqOOMT5qJrROHlVpMWMuRo+8GoLnOKoK9JjIPiaH1zg/J7H3myw16KFTQM/uAoxgZ+VfwLdLdK/mRxHUTZikfs=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2280.namprd04.prod.outlook.com (2603:10b6:102:e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 05:27:38 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 05:27:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Topic: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Index: AQHWAfBwIA62KDxQPU+QCf/8uspjMw==
Date:   Wed, 25 Mar 2020 05:27:38 +0000
Message-ID: <CO2PR04MB2343309246F0D413F5C1691CE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324154131.GA32087@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f48d6863-17d4-41e1-6e16-08d7d07d3b6e
x-ms-traffictypediagnostic: CO2PR04MB2280:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2280ED61A514D8A956D1574FE7CE0@CO2PR04MB2280.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(26005)(6506007)(9686003)(7696005)(5660300002)(91956017)(66946007)(64756008)(110136005)(316002)(81156014)(76116006)(8676002)(52536014)(2906002)(66556008)(66476007)(81166006)(66446008)(33656002)(478600001)(71200400001)(186003)(55016002)(54906003)(6636002)(8936002)(86362001)(53546011)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2280;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gt2/SLvWaYibEgUN8JilrZyL8g868n4TGlGXtJ2ir4xYX+KNazUqhhLy1s8OehdTQh5NMG5/exZeJGIy7sKZ6z7yQzoktw69DLneB8Fmu/nkE2v3GPoecQ94h/lhsaIEuyjUbxbTo1zjD8cKREw2ltThNiW8FShnRXr9PupFg7eflucZTbzSINKpLw6b+j6hTzzUpu0XnPWTBbwKQLYOEOZd7LcrpWjjTKqmdRiyTMFAxkdpW+aqdYhFgAx2Dj1LApMQSW5Dmn3oYeaKh8DrvcmrLu83YKfcVd6LVtE+q+9gcT7Pj1Y4dYwoClvzEvOX4xOiVxzpjDbXf2NpjQNtv9yRDQEZaCRBjfXWbAQR7Ot+TvKCZM9aTtu3YtSZPBwXvUfjiVL90klyYv9xB/IGyTrAo7WSPfsx1Wwnsj8x428rfW/qRiWsLDNBnA4pBj2P
x-ms-exchange-antispam-messagedata: S7wo6gLiGfaMxF1n0ktUNd9TjFdJ8rNca7FxShAwI2CtrnQL/LgpksdjoPAjJD2E6Cgh+8oUMHeCMMEOAhdXrHHa4GT7xUhxv0wjBCSKnA9rvu7x7T1r45+HU05BUt5eUi8unnsFoGSNg5GT/filHA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48d6863-17d4-41e1-6e16-08d7d07d3b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 05:27:38.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVQxBYuWoYpstEy+B04mbUjdpdS/aJXsFgG52Cb6iqRl3WnqpxgNBk35xgCruk5iCtwsrxrolSseiUXuRkHHDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2280
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/25 0:41, Christoph Hellwig wrote:=0A=
> On Wed, Mar 25, 2020 at 12:24:53AM +0900, Johannes Thumshirn wrote:=0A=
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
> =0A=
> The submit member in struct iomap_dio is for submit-time information,=0A=
> while this is used in the completion path..=0A=
> =0A=
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
> At least for a normal file system that is absolutely not true.  If=0A=
> zonefs is so special it might be better of just using a slightly tweaked=
=0A=
> copy of blkdev_direct_IO rather than using iomap.=0A=
=0A=
It would be very nice to not have to add this direct BIO use case in zonefs=
=0A=
since that would be only for writes to sequential zones while all other=0A=
operations use iomap. So instead of this, what about using a flag as Dave=
=0A=
suggested (see below comment too) ?=0A=
=0A=
> =0A=
>> @@ -446,6 +486,11 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,=0A=
>>  		flags |=3D IOMAP_WRITE;=0A=
>>  		dio->flags |=3D IOMAP_DIO_WRITE;=0A=
>>  =0A=
>> +		if (iocb->ki_flags & IOCB_ZONE_APPEND) {=0A=
>> +			flags |=3D IOMAP_ZONE_APPEND;=0A=
>> +			dio->flags |=3D IOMAP_DIO_ZONE_APPEND;=0A=
>> +		}=0A=
>> +=0A=
>>  		/* for data sync or sync, we need sync completion processing */=0A=
>>  		if (iocb->ki_flags & IOCB_DSYNC)=0A=
>>  			dio->flags |=3D IOMAP_DIO_NEED_SYNC;=0A=
>> @@ -516,6 +561,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *i=
ter,=0A=
>>  			iov_iter_revert(iter, pos - dio->i_size);=0A=
>>  			break;=0A=
>>  		}=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * Zone append writes cannot be split and be shorted. Break=0A=
>> +		 * here to let the user know instead of sending more IOs which=0A=
>> +		 * could get reordered and corrupt the written data.=0A=
>> +		 */=0A=
>> +		if (flags & IOMAP_ZONE_APPEND)=0A=
>> +			break;=0A=
> =0A=
> But that isn't what we do here.  You exit after a single apply iteration=
=0A=
> which is perfectly fine - at at least for a normal file system, zonefs=0A=
> is rather weird.=0A=
=0A=
The comment is indeed not clear. For the short write, as Dave suggested, we=
=0A=
should have a special flag for it. So would you be OK if we replace this wi=
th=0A=
something like=0A=
=0A=
		if (flags & IOMAP_SHORT_WRITE)=0A=
			break;=0A=
=0A=
Normal file systems with real block mapping metadata would not need this as=
 they=0A=
can perfectly handle non sequential zone append fragments of a large DIO. B=
ut=0A=
zonefs will need the short writes since it lacks file block mapping metadat=
a.=0A=
=0A=
> =0A=
>> +=0A=
>>  	} while ((count =3D iov_iter_count(iter)) > 0);=0A=
>>  	blk_finish_plug(&plug);=0A=
>>  =0A=
>> diff --git a/include/linux/fs.h b/include/linux/fs.h=0A=
>> index 3cd4fe6b845e..aa4ad705e549 100644=0A=
>> --- a/include/linux/fs.h=0A=
>> +++ b/include/linux/fs.h=0A=
>> @@ -314,6 +314,7 @@ enum rw_hint {=0A=
>>  #define IOCB_SYNC		(1 << 5)=0A=
>>  #define IOCB_WRITE		(1 << 6)=0A=
>>  #define IOCB_NOWAIT		(1 << 7)=0A=
>> +#define IOCB_ZONE_APPEND	(1 << 8)=0A=
> =0A=
> I don't think the iocb is the right interface for passing this=0A=
> kind of information.  We currently pass a bool wait to iomap_dio_rw=0A=
> which really should be flags.  I have a pending patch for that.=0A=
=0A=
Is that patch queued in iomap or xfs tree ? Could you point us to it please=
 ?=0A=
=0A=
> =0A=
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h=0A=
>> index 8b09463dae0d..16c17a79e53d 100644=0A=
>> --- a/include/linux/iomap.h=0A=
>> +++ b/include/linux/iomap.h=0A=
>> @@ -68,7 +68,6 @@ struct vm_fault;=0A=
>>   */=0A=
>>  #define IOMAP_F_PRIVATE		0x1000=0A=
>>  =0A=
>> -=0A=
> =0A=
> Spurious whitespace change.=0A=
> =0A=
>>  /*=0A=
>>   * Magic value for addr:=0A=
>>   */=0A=
>> @@ -95,6 +94,17 @@ iomap_sector(struct iomap *iomap, loff_t pos)=0A=
>>  	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;=0A=
>>  }=0A=
>>  =0A=
>> +/*=0A=
>> + * Flags for iomap_begin / iomap_end.  No flag implies a read.=0A=
>> + */=0A=
>> +#define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */=0A=
>> +#define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */=0A=
>> +#define IOMAP_REPORT		(1 << 2) /* report extent status, e.g. FIEMAP */=
=0A=
>> +#define IOMAP_FAULT		(1 << 3) /* mapping for page fault */=0A=
>> +#define IOMAP_DIRECT		(1 << 4) /* direct I/O */=0A=
>> +#define IOMAP_NOWAIT		(1 << 5) /* do not block */=0A=
>> +#define IOMAP_ZONE_APPEND	(1 << 6) /* Use zone append for writes */=0A=
> =0A=
> Why is this moved around?=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
