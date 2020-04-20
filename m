Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223D71AFF73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 03:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDTBIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 21:08:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18854 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDTBIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587344918; x=1618880918;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aFx/U2UHt8O6d97wBJ13JRhb5xK4YMmUvB1XfR7nG+8=;
  b=mOVBoL2PGQsfD+VyjS8f8Ysbe6Ys9Z+3j17YuEgr09J9+eQExIlbBOFf
   3Sc58wFmzsA5TwCME6/ty4mhMP2xog+d9m+bV8QZHZnTJTmaP44udoyvC
   bMB6dO/3f536G0SQv5gEEj2pLMIMfTtLah8QJlS6QU9e7fizoDfjvG5ek
   8aQHddSvZgYWzR1HBWf0mf7y/cbaKpgGftyKavHfl+9jzRrzqMcLl1A0F
   bXvqgesIPtj2Gls2Oopm9DHl3a/1BCJUc+Wf0/fIsqphIB+bBvI7t9pa8
   zKwr92MLxdSkj4PR/PTg71vDDaCddH/At97HLjFOHLMSOk95U3UggDf/E
   g==;
IronPort-SDR: 79s9nCIyP0F49PbcLT/x6ZJLsIdMwpA2LFl/O67tfXJvh3xnQdL1pOIj3ZdPwjTlQ2A0LS5lOf
 IMg1bjsgVxsY5jfwaiyTyvytsOy4P5dzK1GCnj9xQWJ94PF8OTapr12YViKMcIFQCMqPFzg0S2
 9VaD0X1tHtgjyF/24LtmsLOdC0VLoBu78spDI98Q0jfiwmiJvqEaOSXN9xEBdlR4gwrrPDweDh
 2a26kw9ZVg72U2Y5yAg/cJE8B9nREka86QkTzFmxvdbRReSnEZd8qHcy10V7eXoownjGMYeLKw
 8DQ=
X-IronPort-AV: E=Sophos;i="5.72,405,1580745600"; 
   d="scan'208";a="140025855"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 09:08:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGzPQhv/5JHjOjccBZ4xmh3EK77NmiuGKPTxb916HW+2dur7ZChKOWrtYkBE47YAhYPGC275WYE9bxofVbKgW8A3n0Pa/VOL26SBfltmPsZ12cOoWqGxgBDELx3rcRNMZTMhzaG8jGgpylWGor7y2HhW70CmFYCuCOidckYrUbIUxRE0e/qwgA/mQIipQUprQZPdPLo7JUmTh+/bPkdjC3j5r3Zk+m+fmIlI3HkSMKnpGn4k9avOpPN48Py3ySlFitWbJF1VI+Trx9i0sEUJesdirCWdseRs3/BZp/KA1cmpdGBKgo6lUQJy8QqRq98edW+x3nWwtgvhzMLN1T5Q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neYuzgrowI1QRGRo82mFDWJ1VsZQDDIZIj6sKj6vhcI=;
 b=R55oPQDqiSxeXKGptvjqqsRWdQLfBJhS7p6CA6l7GmEND0HDs09dwd+16BH8Bw12NkUEzLyve7J30NYcnO0y08/3Rl4wFk7sQlYBgsN1jyWsOOB5GnBY0PONeo3jLeTyOz1zbEGBZKl0H9QTZiqju36jc6hjrAz1w2Fmkm/N76lrJD6v6RpkStM6Ome28G+KfNWpLZNc79+W+/O+l70D9t8ZB4GSEbu5vXftkpnpenZ1wd4Y8tvZog005H2tosCLoB3hAvWboIjgXnPHyTKRPKvqu7E+6/YnYQvJ73LrCQnVW19fEsQgsc45Et0mpac5aBCQkBYJ8J9KV9T3Ej/DyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neYuzgrowI1QRGRo82mFDWJ1VsZQDDIZIj6sKj6vhcI=;
 b=UlAem4xnh/Cetmg+WU3aQgdLM4Jup95wUchwG50uC4Ttm0SxW+f8K6dnD/+jBWkhr7LbaDZt388WI7AiWsW0Kb6BR2oZUrJcuBQ3+sxZUxom6Ss6kRUNFX7IQ321wiWeH/nFlbGIWQ3xywbiuSdSV3FciGVYj6VOfFrH1/rgyOw=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 01:08:36 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 01:08:36 +0000
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
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v7 04/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWFLH0yWL8pGyKl0SNb/Gw4FckZw==
Date:   Mon, 20 Apr 2020 01:08:36 +0000
Message-ID: <BY5PR04MB69003987010FE6865D3EC8A8E7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-5-johannes.thumshirn@wdc.com>
 <373bc820-95f2-5728-c102-c4ca9fa8eea5@acm.org>
 <BY5PR04MB6900E3323E8FB58C8AB42D24E7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
 <af522aee-365b-a65e-ce40-a8f66bbc7d63@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ae2ac1b-b43c-4dc5-3028-08d7e4c75ac2
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB65494D62B77B928B4026B4A8E7D40@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(55016002)(8676002)(71200400001)(478600001)(7696005)(4326008)(81156014)(9686003)(8936002)(26005)(53546011)(6506007)(33656002)(5660300002)(66946007)(186003)(76116006)(66476007)(66556008)(54906003)(64756008)(66446008)(110136005)(52536014)(316002)(86362001)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jks2BYA/anJm3djVYbIbG7t4MrV3ZW/mCe1Ksl7ZCuhYLN9/mOF3h/tqU752wykR+J/KqKAB/gbeQreq9sURLLoIbrdImd5LXlWaVSDf4Xpmbn02119h+AW3Zw8IGDuHdsdI5KjezSJj5Oqg2Mlp5WW21MgHZXk8jZzFldz1CpBr4BRLGXd+kINUEfqnrIhEBkZILBFWA2HmMg7nubUxz5i23jQvpxxCEc/9jKDt4wMKibpReDTsPtEEhjWUmalv0nQerbfU/YpAVeUkYvoiX23c6GrRf2rNM+0hS4QiUTDcpVlJv8e1uFQuUOl8wo0fn3BNVybIt1hPy5lBn7xv7nDlqklIaa2mQQkY4VoarkG5gkReuS9bE6S1GbO1DnPCzORwmjLjGwZz1YwCdFZAP2t0xthL+IShkm6lHp9MmAxbcqed/DKjehRHa5F64cMb
x-ms-exchange-antispam-messagedata: uUp3SKKFFnyZEj4yGjfggXGBeQJKrtAekeEhvLV1day1aX5DyjdkHawoOVr35lnOve8gcj5aERQAUyvVuxwUglbA/vvN/04engT61tk25X1EIrDOJyQ6XKnmPIhdRVYCnpvg8LEjn0uZy6hjTETm2Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae2ac1b-b43c-4dc5-3028-08d7e4c75ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 01:08:36.6423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHfkzQdTQD62qt75YVEhPse953MgoVONctNGpD0zRZeeEMb2GDwXt/2r/OP3WroZQKVkArR8qSGa1GFmlrUsag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/20 9:49, Bart Van Assche wrote:=0A=
> On 4/19/20 5:30 PM, Damien Le Moal wrote:=0A=
>> On 2020/04/19 1:46, Bart Van Assche wrote:=0A=
>>> On 2020-04-17 05:15, Johannes Thumshirn wrote:=0A=
>>>> From: Keith Busch <kbusch@kernel.org>=0A=
>>>> +/*=0A=
>>>> + * Check write append to a zoned block device.=0A=
>>>> + */=0A=
>>>> +static inline blk_status_t blk_check_zone_append(struct request_queue=
 *q,=0A=
>>>> +						 struct bio *bio)=0A=
>>>> +{=0A=
>>>> +	sector_t pos =3D bio->bi_iter.bi_sector;=0A=
>>>> +	int nr_sectors =3D bio_sectors(bio);=0A=
>>>> +=0A=
>>>> +	/* Only applicable to zoned block devices */=0A=
>>>> +	if (!blk_queue_is_zoned(q))=0A=
>>>> +		return BLK_STS_NOTSUPP;=0A=
>>>> +=0A=
>>>> +	/* The bio sector must point to the start of a sequential zone */=0A=
>>>> +	if (pos & (blk_queue_zone_sectors(q) - 1) ||=0A=
>>>> +	    !blk_queue_zone_is_seq(q, pos))=0A=
>>>> +		return BLK_STS_IOERR;=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be=
=0A=
>>>> +	 * split and could result in non-contiguous sectors being written in=
=0A=
>>>> +	 * different zones.=0A=
>>>> +	 */=0A=
>>>> +	if (blk_queue_zone_no(q, pos) !=3D blk_queue_zone_no(q, pos + nr_sec=
tors))=0A=
>>>> +		return BLK_STS_IOERR;=0A=
>>>=0A=
>>> Can the above statement be simplified into the following?=0A=
>>>=0A=
>>> 	if (nr_sectors > q->limits.chunk_sectors)=0A=
>>> 		return BLK_STS_IOERR;=0A=
>>=0A=
>> That would be equivalent only if the zone is empty. If the zone is not e=
mpty, we=0A=
>> need to check that the zone append request does not cross over to the ne=
xt zone,=0A=
>> which would result in the BIO being split by the block layer.=0A=
> =0A=
> At the start of blk_check_zone_append() function there is a check that =
=0A=
> 'pos' is aligned with a zone boundary. How can 'pos' at the same time =0A=
> represent a zone boundary and the exact offset at which the write will =
=0A=
> happen? I do not understand this.=0A=
=0A=
pos indicates the zone to be written, not the actual position the data will=
 be=0A=
written to. The actual position will be determined by the drive when it rec=
eives=0A=
the zone append command. That position will be, of course, the zone write=
=0A=
pointer which the drive manages. The actual position the data was written t=
o is=0A=
returned by the drive and passed along in the IO stack using bio->bi_iter.b=
i_sector.=0A=
=0A=
Example: A thread sends a 4KB zone append writes to a zone starting at sect=
or Z=0A=
with a write pointer value of W. On submission, bio->bi_iter.bi_sector must=
 be=0A=
equal to Z. On completion, bio->bi_iter.bi_sector will be W. If another zon=
e=0A=
append is sent, again bio->bi_iter.bi_sector must be equal to Z and on=0A=
completion, bio->bi_iter.bi_sector will be equal to W+8 (since 4KB have bee=
n=0A=
written with the previous zone append).=0A=
=0A=
Zone append allows an  application to send writes to any zone without knowi=
ng=0A=
the zone write pointer. The only think the user needs to know is if the zon=
e has=0A=
enough free space or not. For a file system, this changes the current class=
ic=0A=
model of (a) allocate blocks, write allocated blocks, commit metadata, to=
=0A=
something like (b) pick a target zone with free space, write blocks, mark u=
sed=0A=
blocks as allocated, commit metadata.=0A=
=0A=
> =0A=
>>>> +	/* Make sure the BIO is small enough and will not get split */=0A=
>>>> +	if (nr_sectors > q->limits.max_zone_append_sectors)=0A=
>>>> +		return BLK_STS_IOERR;=0A=
>>>=0A=
>>> Do we really need a new request queue limit parameter? In which cases=
=0A=
>>> will max_zone_append_sectors differ from the zone size?=0A=
>>=0A=
>> Yes it can differ from the zone size. On real hardware, max_zone_append_=
sectors=0A=
>> will most of the time be equal to max_hw_sectors_kb. But it could be sma=
ller=0A=
>> than that too. For the host, since a zone append is a write, it is also =
subject=0A=
>> to the max_sector_kb limit and cannot exceed that value.=0A=
> =0A=
> Would it be possible to use min(max_hw_sectors, zone_size) instead of =0A=
> introducing a new user-visible parameter?=0A=
=0A=
For scsi emulation, that is what is being used to set max_zone_append_secto=
rs.=0A=
But that value may not be appropriate for a ZNS NVMe device as that device =
may=0A=
have different constraints for regular writes and zone append writes.=0A=
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
