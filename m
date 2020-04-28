Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC241BB5F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 07:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgD1Fm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 01:42:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26879 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgD1Fm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588052548; x=1619588548;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p6XHROs5R2vY+T/Bta83r8GvvBfdzC2fhcXygACQgvY=;
  b=ZRmL+6WwFXWqpc8fVWVQ2Un6yPY7I/du3/HL/JlnXkRrju+s2SwOkqrg
   n7aBdGgEbp/g5dfePTlQm8CqRuFm2Z3JsflVz/5ebFexRK9MU/gavVh0U
   PTs7B2fEe5zBOFIqUTBrVGBRSr2LTPRDR/JPUEg0wr2rfPxkbddrKJOrm
   9UJegbK0L/lyB2yHFKsW8Wj1OIXyGE1TdTRoCJFRaSAIe5FJ4DtgxziHr
   m3glhJJO1t657bz6aLgJGTV0hFo2wyGUF+YzWuBjZ7P+91wb02dtz2aYh
   YlfLFi/XmXBU3AovVm2/z7nA1nwRstUsZf23+B8aBPHsBgG5JCv26cR2c
   g==;
IronPort-SDR: eGM/qmShgAzMkgMJ9XbIi7K01Ypm7nbcNuQ+Lju5M2jUW3t6LAdb7eRG+Elub+1GgbkrmYPhnj
 E34y26xWoiUpmLVKVjfi9g5sY+i68nnLhj6JTK8fhDbBaClF48aTgfHwX3DejGmIraGeelTUzO
 sXSUbAGnOCRXMfMLiTlZ0D3iBIs5loRnp7Mc6hN6fyAaYpHESIRgt5i/eRB+kb/fEk/bHnuT6U
 rtDB4DBfSHyzoybKkdxo1DBYobwRX+MpXtnAKgb0ZDSxUfvb8avSyut3BRWe7B6sdAMEp629VT
 Foc=
X-IronPort-AV: E=Sophos;i="5.73,326,1583164800"; 
   d="scan'208";a="245093512"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 13:42:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyROSQVTnCpXA/VTnA5RqHvXdj2r+HlCOWCzneXoMVLuhpZNHoOGadA1fayhRKu6O0B+mkFEiZGl3822JwWubgBDkMtzfgQ81sVj3utTb90eanb0mQmp7A2dSrMBKF9zINGQmTmx+WGSf2FTM7e+9RHYCldUmrMvx03Lk9+1uF4i/1ngqgeUV+0+CM5fk6V3eRNQTk/qr7TLf07hNXaWh8noztpbBt7z7w2z/kNPGknWwn6RYS4a57vEnP5T1zNGIeW9vEFwwz5IkpPF4i6UaLi+q1Mmr1KT+HPcJCbP3BcMQrOJxEuyW6acqhhFKwkLnHd1VKAEFpNfir5rGkHn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQmbuAMVTrvgs/LnFzl2xtUNPD5qIU7OC3UteY6effM=;
 b=Mlx3E7mUJqlgNi+kb7eDRIg28knL8I8iAI7tAI8/lV3Daa9Qdl8QGMyaYJKAe1nR8GP8PI6GTddpsNHElssV3L8p/38rccXrj03Tzd+wXzwpn62UwX7/qXHMUpTIjN6zXWwhRKOxvtZrtu1FBnNA3zvmR04DeK9v38y/zwTrwEzNbNxcpsPqHEgNVTfl1Ki4VootDxV7S8vyp/nKeNrMwJBq1stg+3FodQxTC+4lUHXvFw2DnHOFjJKde18gnPuGdM0vwBlBkhjg1/mLLj6m4ECvfnLD7tweWReNxFEuyxDq9psFQkGapOfPQOBRCv/NUIwKN9j1F9BKKMWQjIAuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQmbuAMVTrvgs/LnFzl2xtUNPD5qIU7OC3UteY6effM=;
 b=zhiKyLEOm4wz/5HABWnejUmDIhuza8By5qL5IBFLmENHFGjT+tCJk3Ey4k9hPnzvCnTfVXDR6vYB+9aTmuyMh/DBDDfXVkcaobqtK6MG5Js8gINyiIXRaxq/Mxnzfz+Yj25YrpuyW1h2UOkI7ryPFH0Yqi7wYXjOLrYwRSbjEBo=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6312.namprd04.prod.outlook.com (2603:10b6:a03:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 05:42:26 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 05:42:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 04/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v8 04/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWHIeBLn24nPOrv0iNo6hVPuHK6A==
Date:   Tue, 28 Apr 2020 05:42:26 +0000
Message-ID: <BY5PR04MB6900A5127B0D262F1D817E4EE7AC0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
 <20200427113153.31246-5-johannes.thumshirn@wdc.com>
 <b0b44bd9-3047-b9e8-9635-ec5837844263@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d498c7d8-77fa-46af-e813-08d7eb36eeb1
x-ms-traffictypediagnostic: BY5PR04MB6312:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6312172EFBAFE7E123230A70E7AC0@BY5PR04MB6312.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(9686003)(55016002)(4326008)(8676002)(81156014)(5660300002)(8936002)(2906002)(53546011)(71200400001)(52536014)(86362001)(33656002)(186003)(478600001)(26005)(316002)(66946007)(76116006)(64756008)(54906003)(6506007)(7696005)(66476007)(110136005)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwpSsPP4EhRC2da4SnWyEvzL9vwQc25FSqNcBeazaxemJ4IV/mMXygQwiwZNRe6r19MbHcLCp/ugH8hJ6aBFDirDr18LFBR2vR4kizO4kLRh3PoYkdMcsc+1Ca/j1k5e0QuSor1eSZd9lxAeS2HrZtQGNO6vvobmXL+nP5I0aT5CNcIfX9WIT9LbnlNUeP2G2SGs9TqnOI9apAhPDz8EbTYsqQ2/OOyzklvl4TNEZg9yM4Ky5p0d7spGT73vfMFKGcjK2m4NP7B5AgXrw0NLIwiLjto34XBgZn+sWUaO6caqR5mCc6QTdSAKu4LgoKVtDgack2xPCDixGShkRfv7U2h/mROybF3D6C/S2uUaP0w40Yxtf8Mfn7y9lxTMhPYU0wKPRP6pTjqnU8odH0Cj6gJ1mZwxP/OoG130qp1TWORC62WSl0yRhXBa+qQLNivw
x-ms-exchange-antispam-messagedata: wij1ja5RE/FzJO4B8Jgq5OufAuCUA2h/asCavn7lESVizkSjXp/4fgKTEAdKu98eEKWKxwGzCpui9a1+qRvDTurmjtsFPWXsQT6/8RYPwm1df2/hFEvExfiTfBrq047mi5jXvfBJj4/fLrcqUr8jtkvUy/nsxWbIl4/pUpkAXekhdrS79IoVMOD+SCe3Z6YFEVaK4/ltDuFMl4HtDGAtlKt/0WchyloV6NdmIeoAfEINDV3Tv9z0kKpngDXUreqUim8TmrcZh/r67bJdxKXLagA31D5oBq01KXZKLzl2Px/VOkBImM51z6fFEgiOJaAPYRDc103SbJxF8P4A7tbZ6C/1YFvOlelRbCW1FBN8ztNopUzBkZtxym0Y+y/wdCO7IW6LRbZRRO6ICShXPvdS60C9tYTlME+eqMIBHHAPigQZ9b54lpKn5leL5uvewgslF/Z7wrJaWOaRNRCr3CVgKnvlZyHOlwPDahmnJTBmSmBbgsohHvObM0Fjw7yJPh94BtKYMuydcKVXpiq7tRKG+YHA8V5GP0Bzr2oDhtPndKFpUnv1Ued4Qe+wJbbMcOFwXTbPaliaGJXQvVDnZ8Aq2mAq+0klGSFaL/ViFggh1a53dYN2RM8n9OToD0l2Iak8VtcWW9fG5MrYRwfgr2DW5Ppa0KAU9MZ4SI6i7XSFjNzQR7c/9xpuOqoWhcIYzhfZ/E5lm6zutriUaMaOtytD3KFDW994MO5+Nj8xJKu1XIw9aPGG7SgH+OFh7TecpBBTXk/Xp5YJTqf0TVmPTQwkV92zXxOY2SE8LhW5HKzzfZI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d498c7d8-77fa-46af-e813-08d7eb36eeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 05:42:26.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4/kevt1fQ7O46yLTfQYlvBVVgGiIeggzRpkMVTk3Jc6h4jU0YlN8ZpqS3CVRzBnvwwm5aQjsYhEyhz+RP1k6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6312
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/28 14:20, Bart Van Assche wrote:=0A=
> On 2020-04-27 04:31, Johannes Thumshirn wrote:=0A=
>> +/*=0A=
>> + * Check write append to a zoned block device.=0A=
>> + */=0A=
>> +static inline blk_status_t blk_check_zone_append(struct request_queue *=
q,=0A=
>> +						 struct bio *bio)=0A=
>> +{=0A=
>> +	sector_t pos =3D bio->bi_iter.bi_sector;=0A=
>> +	int nr_sectors =3D bio_sectors(bio);=0A=
>> +=0A=
>> +	/* Only applicable to zoned block devices */=0A=
>> +	if (!blk_queue_is_zoned(q))=0A=
>> +		return BLK_STS_NOTSUPP;=0A=
>> +=0A=
>> +	/* The bio sector must point to the start of a sequential zone */=0A=
>> +	if (pos & (blk_queue_zone_sectors(q) - 1) ||=0A=
>> +	    !blk_queue_zone_is_seq(q, pos))=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be=0A=
>> +	 * split and could result in non-contiguous sectors being written in=
=0A=
>> +	 * different zones.=0A=
>> +	 */=0A=
>> +	if (blk_queue_zone_no(q, pos) !=3D blk_queue_zone_no(q, pos + nr_secto=
rs))=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +=0A=
>> +	/* Make sure the BIO is small enough and will not get split */=0A=
>> +	if (nr_sectors > q->limits.max_zone_append_sectors)=0A=
>> +		return BLK_STS_IOERR;=0A=
>> +=0A=
>> +	bio->bi_opf |=3D REQ_NOMERGE;=0A=
>> +=0A=
>> +	return BLK_STS_OK;=0A=
>> +}=0A=
> =0A=
> Since the above function has not changed compared to v7, I will repeat=0A=
> my question about this function. Since 'pos' refers to the start of a=0A=
> zone, is the "blk_queue_zone_no(q, pos) !=3D blk_queue_zone_no(q, pos +=
=0A=
> nr_sectors)" check identical to nr_sectors < q->limits.chunk_sectors?=0A=
=0A=
Bart, I think I already answered... But writing again an answer to your=0A=
question, I realized that you are correct. My previous answer was: no, the =
tests=0A=
are not equivalent. But thinking again about this, since the block layer BI=
UO=0A=
splitting code will decide on BIO split or not based on pos+nr_sectors exce=
eding=0A=
the zone size or not, yes, the first test is not necessary.=0A=
=0A=
We can reduce this to only testing that nr_sectors does not exceed=0A=
q->limits.max_zone_append_sectors since we already tested pos alignment to =
the=0A=
zone start.=0A=
=0A=
> Since q->limits.max_zone_append_sectors is guaranteed to be less than or=
=0A=
> equal to the size of a zone, does that mean that the check=0A=
> "blk_queue_zone_no(q, pos) !=3D blk_queue_zone_no(q, pos + nr_sectors)" i=
s=0A=
> superfluous?=0A=
=0A=
Yes, it is.=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
