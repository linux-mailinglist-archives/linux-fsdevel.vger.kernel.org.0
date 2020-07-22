Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7EE229A2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgGVOcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 10:32:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22601 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgGVOca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595428350; x=1626964350;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PuoDC017WeeuiJvZB02eCzGu3ROWuDo8Ht1IM1oE98k=;
  b=qpA11iX1qfaN341XQPRUdPv6SwYtQODDMBvRj0aiemFtEOvX6JU7gymb
   CgU919fhJi4ek+T6kD9dMdCD4pm9HjlrlQFy5sM+Y2h66eGyQhr6w6/QC
   F03bMz1bdsBNS1wnsCk2X8//szeoRc5iP+2Q0IG/y8TEcOeZQc0lzloWX
   Zny9I6eor11KEXhJFvqMgFakiTxpfu2wTEVeecYKb2f+IbYkAxY4wTRbR
   DBMGvDSZdharPxI0YuCpbDaGoUz1bJN8ZUrngFUvvG6wwEigC1+7cyRhD
   RyxnZFYfdaSI01XkIODAz1zYo9d1/Rn+EgGRCJ6f7ApMfbtMyAPIukEQr
   A==;
IronPort-SDR: YchkogHDAhlkvvwfvfFRvCGdosErwV+qc6HV1ath0uu7WyeHsn//tgqel7Z2I9ZnCMjMi7ZiPT
 lkM3bPJcgDsfKoMq270cIIQoNOrffIVglGbG9IUjB4IKv6UwJRnkkpCXrsLAhdx0UNTeA3/O/F
 TI5EadLTK5Z653bmdhhw7u3+NkOyME72vWAD4g8mZAzNnsJDVCOPN6NBnCNXCyJrkxKTIvv6z8
 6bk8eM7a491xzb0OxqwppRDN6Nc0mk3A959W+a+fkvZ2xKZhuU/OLlE72a0xQDd/++ZICol8fJ
 fek=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; 
   d="scan'208";a="143211681"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 22:32:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEXVoMcEPWfu2Ob8ZBBos/pWr5Ee+pskHvUn/tBHMxS61x8bLZ9n9YuVmAbL8m+XYeSzn3PCR8ZckICZMoSgYNqQHIRA+q1bgXq8MaVGeBropeAHaqrZfR+C9BN9Tsf0yE4kQI4n/qErlJFndfWYY2DX+HRZgEmX4biFYNOsdV32AZ00vRbKBqya2dg5rTgkQ+m5cRCMJRLZ7dZhR3rgYnYFWRRKudAl4p2hjwWNENgjmA6jRg6zMz0rtn46PhMJco2SzgYQy9gMJ3Cf3fhJDM1B6xdoeigVrJQZjCchhL4q8h4ARYHcpm6k14bY572y7nxzO9USAg7ZaLfttL3akQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxk+DhQ+SuMEvg14K0d1ydh9/tjs9QeWow4ivS+olHo=;
 b=myusQPypYcEo88pxie+PfGqdNleYBv0e1p/AhNKQm6IM8kxxp10btvDo/jUl4a0zK7wIp3E0HuEgnPkqj5vlhJHwuLY2lXLL6MR2zBcH6ys7vap/sdcbJKJp0jNiG5J8yKHjj3l/fQpuG/iQk98A8np9rwErTppWJ1iIWurvDSwKakBiJX8pUEORsGZXPEPX2CwSLxnxphEH54FTSAIFdtfYHM+c0RJvEhBAb/I10REhOwLgucHAZyBCTalCzhGgFV7cwzZnyv9E7KDKh0dtj167V6SBoX07aPebE4ln8k+/F/mGtKTW8ZR6ZdKOUGBDhY5Ixcg20lepEfBj+6PtyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxk+DhQ+SuMEvg14K0d1ydh9/tjs9QeWow4ivS+olHo=;
 b=aERQETBnLPqAvrUXLQXm8Kyvbl7nB2/y0onBM64mkHsJ7h34coEfGWjuhRFhHHNSeyr6Sz0RcAqRfHURf4XbTgSxSxrvrLX2r67eymmcFCFFouly4F+f2gb9Bz1pDJO0nUyP9SLBmTe6Z6GdGJ8rfdjZKW0iLunjLkolNS+pGEI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 22 Jul
 2020 14:32:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 14:32:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Topic: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Index: AQHWXpitifll0c+NqUqXemZ9Ae0oAA==
Date:   Wed, 22 Jul 2020 14:32:26 +0000
Message-ID: <SN4PR0401MB3598D4B6188B031D7C8191329B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <CGME20200720132131epcas5p390f6f8a13696a3f54ef906d8ce8cc0ea@epcas5p3.samsung.com>
 <20200720132118.10934-3-johannes.thumshirn@wdc.com>
 <20200721122724.GA17629@test-zns>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b49b304e-75d1-415f-59d3-08d82e4c0e9b
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3597D100DBC1127A7B4496E79B790@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bet3t+gaVVPYY+R96o6qIJ1u0joPLcr8X4QQnFRC5DYC2SSNt8B5ae3KBkS1zi6NC9Lx6M1ac47mKBEGTGlCVQqZfjd1Wi5aBz7cQKbRhgISD2mcy0aq/T6QLLAi/v7vcv1DP5GUw14AqbPmMwU8gyQUqCrftgs/bZihhzC80pzUqKz3lKuKJ8EXnWwV0JsJONfIN3VqQ+rCiLIQ28sEyRELIgN6agQD7q9zJUXMjDuGPBT6J/EQMXnTfpnompja9Gh2L8SFM5K9vxP6NJd5xzlHP4GMlOlSjdTVW5bA9mgbhyZvimLktSh9x+mbnBlcq14+UHt6j3HjWR371Pojsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(7696005)(52536014)(478600001)(86362001)(316002)(71200400001)(83380400001)(4326008)(54906003)(5660300002)(26005)(6916009)(53546011)(6506007)(66476007)(66946007)(64756008)(76116006)(91956017)(66446008)(66556008)(9686003)(186003)(33656002)(55016002)(2906002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sx81vTrkmwI6ka+HX3r7wA+2gS9xHjmjlduK961DKSB4dzmMV6ChJKPrXUEgSkqQvds/AN6eAlIZAgaNqVHvF71EN1tQeBLsxWieRtC/UNVS3vmGaUo/d+J3JAo9dLVb9P4c7F15Sk/cfCVYC0T/ft7wrYfWdru0RCmoAQH2Pb+LOHazSfET/fQ3T769WyoNgWYvfbJmcJfPqAy/WViV60f8fzyJFzYIUUxh5I/CdIOnc7s64iaY2BAdJx0Rrhq3NEfaTp5bg6w1hP4dJt+nW36PKAq0NjUnIkM6UGRiInDGv3ih4x+XqqJ98Hw/wEXwr77AKeZjvl8lpZSodk2Qy2v5lwsLDCexlCecS2XJ4pjdlO43hpnx8CEJwv3NuZDz+kwma2z1+9RIKxCDrFxnZmtnJMU/4gKNiuc8UT/ncfePW8k5auyjPp0ip2GFcoX/O4tFEE+zINVUngd/aROrSOrenxtcj4mz8meKuM7lwwULi9JdffYdudrDLWGlhUqF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49b304e-75d1-415f-59d3-08d82e4c0e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 14:32:26.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9XHT9dvaXeSp49yf7EM/KGSVT1hh72ptzfZZTSF+/S2k9B+DUFsOe8+gpUWCQqarc9IhqQ5WXPvGo123h1m0l+g1XPT/ixATZ6L7Bfjm9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/07/2020 15:02, Kanchan Joshi wrote:=0A=
> On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:=0A=
>> If we get an async I/O iocb with an O_APPEND or RWF_APPEND flag set,=0A=
>> submit it using REQ_OP_ZONE_APPEND to the block layer.=0A=
>>=0A=
>> As an REQ_OP_ZONE_APPEND bio must not be split, this does come with an=
=0A=
>> additional constraint, namely the buffer submitted to zonefs must not be=
=0A=
>> bigger than the max zone append size of the underlying device. For=0A=
>> synchronous I/O we don't care about this constraint as we can return sho=
rt=0A=
>> writes, for AIO we need to return an error on too big buffers.=0A=
> =0A=
> I wonder what part of the patch implements that constraint on large=0A=
> buffer and avoids short-write.=0A=
> Existing code seems to trim iov_iter in the outset. =0A=
> =0A=
>         max =3D queue_max_zone_append_sectors(bdev_get_queue(bdev));=0A=
>         max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize)=
;=0A=
>         iov_iter_truncate(from, max);=0A=
=0A=
This actually needs a 'if (sync)' before the iov_iter_truncate() you're rig=
ht.=0A=
=0A=
> =0A=
> This will prevent large-buffer seeing that error, and will lead to partia=
l write.=0A=
> =0A=
>> On a successful completion, the position the data is written to is=0A=
>> returned via AIO's res2 field to the calling application.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>> fs/zonefs/super.c  | 143 +++++++++++++++++++++++++++++++++++++++------=
=0A=
>> fs/zonefs/zonefs.h |   3 +=0A=
>> 2 files changed, 128 insertions(+), 18 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
>> index 5832e9f69268..f155a658675b 100644=0A=
>> --- a/fs/zonefs/super.c=0A=
>> +++ b/fs/zonefs/super.c=0A=
>> @@ -24,6 +24,8 @@=0A=
>>=0A=
>> #include "zonefs.h"=0A=
>>=0A=
>> +static struct bio_set zonefs_dio_bio_set;=0A=
>> +=0A=
>> static inline int zonefs_zone_mgmt(struct zonefs_inode_info *zi,=0A=
>> 				   enum req_opf op)=0A=
>> {=0A=
>> @@ -700,16 +702,71 @@ static const struct iomap_dio_ops zonefs_write_dio=
_ops =3D {=0A=
>> 	.end_io			=3D zonefs_file_write_dio_end_io,=0A=
>> };=0A=
>>=0A=
>> +struct zonefs_dio {=0A=
>> +	struct kiocb		*iocb;=0A=
>> +	struct task_struct	*waiter;=0A=
>> +	int			error;=0A=
>> +	struct work_struct	work;=0A=
>> +	size_t			size;=0A=
>> +	u64			sector;=0A=
>> +	struct completion	completion;=0A=
>> +	struct bio		bio;=0A=
>> +};=0A=
> =0A=
> How about this (will save 32 bytes) - =0A=
> +struct zonefs_dio {=0A=
> +       struct kiocb            *iocb;=0A=
> +       struct task_struct      *waiter;=0A=
> +       int                     error;=0A=
> +	union {=0A=
> +       	struct work_struct      work;   //only for async IO=0A=
> +       	struct completion       completion; //only for sync IO=0A=
> +	};=0A=
> +       size_t                  size;=0A=
> +       u64                     sector;=0A=
> +       struct bio              bio;=0A=
> +};=0A=
> And dio->error field is not required.=0A=
> I see it being used at one place -=0A=
> +       ret =3D zonefs_file_write_dio_end_io(iocb, dio->size,=0A=
> +                                          dio->error, 0);=0A=
> Here error-code can be picked from dio->bio.=0A=
> =0A=
=0A=
Indeed, did that and also removed the unused completion from =0A=
zonefs_dio and made a union of work and waiter.=0A=
=0A=
