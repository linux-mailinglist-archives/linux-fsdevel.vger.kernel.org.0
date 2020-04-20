Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B73A1AFF32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 02:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDTAa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 20:30:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6793 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgDTAa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587342628; x=1618878628;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5w4iKUMd5pOkbT+/JrUp/hTx9oyfznwgTBiRvJ4qKek=;
  b=AEaP0j/54FYa3olZPEVvmf64wIrSUb8QHj1SIrJYwIfZ8iwbCk2NdkSl
   LxN3cSL6aOY502xFB214d0SjMJU9HHKr9SSdfUiWkN/hCVrTY3eiSPXQA
   gPa5K1Do5+oIj9UAv5WxGR2vt8Q+lMG7coBC5hnmQqv/A5C0o6utdWXj/
   0Xs2aBU3rlX0szRVwrUvlvfqgWZ6w3vXfvKopGjeS23VaRmILU4CwgIf5
   fRlZ8uv1YsucVpDJ9pKDLVLwrR7W3QqhLUgMEy5p+OesoKSpCiuQhPN7r
   EuIRB1/DR/fLr/1s2dCM9TIIzbX2M2u2pAsJZgLhV7QQhBvbgAyhofvVT
   A==;
IronPort-SDR: ziltQbtDjJB5xopbmRE8DAD4o4SEEklqSJaQ1wpLyoD7vhTHtNDaZ9Hj37Kpsu8Z4lG3/TWBSx
 6QNie3JbkAJFwniQczXR1ioMoqIZ0iv3cexiKvCqQbLZsByaHHW8CB9kVU3GGMyZBDff1XWON7
 EU9KSt+kHhmLzOqOPxTQC40QrcVZFs+pBPjk9S59M+zsJk0WNzGKfnC9/5Wnex+RVi+ai2QP1K
 LVkyuxhBms8pXqnrqkUYFpQiIDx5py4+AT6XES7M0Ax+w759MSBFrMizs1jYnUwWEF1bU24hNd
 +NQ=
X-IronPort-AV: E=Sophos;i="5.72,405,1580745600"; 
   d="scan'208";a="135670088"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 08:30:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjO2zOpF0nUaOpRSLtGq2K0+s82kgGWOgR0YAoHCavtnyDEnyUy89VkhCPWmbhhqyv6EqKMLDcN6R+pOLFGc0DGiYFSWAS82b0oLYgwpshBcazvZTrBixhDwHCNdKiOjLlw4ATMZ8W8wTGbtg3DWpqqffgFolhQrj/6opqcO6x3m2WUPC4mZI4px9lexHYwdBL5dxf3Z23Q9kl3JwN65bYvMrHWgkxfXe1HX/BpESZVFiKbsahPy9dfZF6/RUlldfhCQyIbghmx+Em++nE2pz8CdcOF6CSCGtYya46fGOPr4lGh0SCDyRA0w8rP6rCqS4BVNyOqHHL+7r4Rhq7+/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EW7nt5imk5r3ZGLai5c30tBYnnlGZfyTC9EQUem/N8=;
 b=WOpcZddi3hgTucuq7n1nY9WmKeHjl6zX1gGgxFOWpNpdDlaR9yltnK/AnsW9AuqLbdwrc9tNbx9x2bTzOUqesXNwRR7LxugKkxW9iXFUl8LCYukRMbI6ZLyTYLuCyraAbaoaRsvox3wMeHgW/RqCYW/6GqgHdydoS+p+KyNO/QUNsZeT2lRpcx/rem7eDglR8X4/eeBzHZe3VFA4JCvBfXFXkGytq5wkT4NCPLs1hFAd4UI46wPVD88JcNNt64j4qonZAFjTXEysMd14d69h7zOyBbXPK43HUsF52GXNKTDXcDuSGVb4Hb9ZSSd+9y2ALXUFd3H08CHd59cAXPuXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EW7nt5imk5r3ZGLai5c30tBYnnlGZfyTC9EQUem/N8=;
 b=dyJGtxOPm4Q0UXYFhpWyflgwkxNhEoc1fpeax9DylT3fOavwfY4WymVEmOf5pvpnSrW9e3iL9Plyoys3gt7CcGwBivModDClmk/0z7oavsJNqzVN3s7U2qRe6eLGnqUmKButh9Zd+rF1hiq+HOnU57vIpKpXMFRk7dP7JpzJGcY=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6817.namprd04.prod.outlook.com (2603:10b6:a03:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 00:30:25 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 00:30:25 +0000
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
Date:   Mon, 20 Apr 2020 00:30:25 +0000
Message-ID: <BY5PR04MB6900E3323E8FB58C8AB42D24E7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-5-johannes.thumshirn@wdc.com>
 <373bc820-95f2-5728-c102-c4ca9fa8eea5@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 411871c7-c76d-47fa-e3eb-08d7e4c20533
x-ms-traffictypediagnostic: BY5PR04MB6817:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB68175B46C48A6866A8F82C30E7D40@BY5PR04MB6817.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(53546011)(26005)(71200400001)(110136005)(7696005)(54906003)(33656002)(316002)(76116006)(66446008)(52536014)(66556008)(186003)(9686003)(64756008)(4326008)(6506007)(55016002)(66476007)(66946007)(478600001)(81156014)(8676002)(7416002)(8936002)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlwC+iXXiWm9G2dXYudeD7XSW3B4P3u459gX8ZYpcpHpIfTUn5DakpQo1dUwoNAn3JTxPpi8v6AIKCFz8H56FJOwks7lWxS3jEr9ylNF6N9lIQcA/DbarKOINVk8CHYgO0VDxgwenRAGaOf3mgXNnCZt2dgZVrtBHuyjmnMBZ+fEb+XumJr6pQUcWA4VHYvN+HN00uEfGZwWkUY1bWrJE7SbhiqjnZbtZRrBQex1alv4w+vjHOhYBQMlE2yWX4kKmL6dubZrMNgf+5t0WtK1QBD4vDzx4GTbUNjlSmk6hioiBY6TrYPP+1GJvel6jwYetEGYWP/RHV0ltk/zwBTXkVgsU6m9UyPPVoJf1U0cyV7W08OIQ6RloU7RgJpoKh64nX7zSRj30XzqpX4YfKo7MRDAThVVfS48JTeq8IDMmwGlNUohQTANf97oOeyQLqbD
x-ms-exchange-antispam-messagedata: /2sPc35hsyMpJpd+zCZyuak4ijrGXjXN34IfrdRD+a4IxgNU67OduYZSJlAdnn99afA9mRIdwudiGcayzKgzaiKXDIo56q+1SYkLkLV/66M4Mo9sm1UCsfgNVBX7XBK29mgtZ2/zf+3pfReVh/rGpw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411871c7-c76d-47fa-e3eb-08d7e4c20533
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 00:30:25.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJgJlntOHaguVQ9E6C+pSbil1/ovLe0wLbE2KQORHGFnY1l4cFBkkc+xbYvhrcaK4mZeYehOGKGil3YsovMHLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6817
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/19 1:46, Bart Van Assche wrote:=0A=
> On 2020-04-17 05:15, Johannes Thumshirn wrote:=0A=
>> From: Keith Busch <kbusch@kernel.org>=0A=
>>=0A=
>> Define REQ_OP_ZONE_APPEND to append-write sectors to a zone of a zoned=
=0A=
>> block device. This is a no-merge write operation.=0A=
>>=0A=
>> A zone append write BIO must:=0A=
>> * Target a zoned block device=0A=
>> * Have a sector position indicating the start sector of the target zone=
=0A=
> =0A=
> Why the start sector instead of any sector in the target zone? Wouldn't=
=0A=
> the latter make it easier to write software that uses REQ_OP_ZONE_APPEND?=
=0A=
=0A=
We could do that, but we choose to have the interface match that of other z=
one=0A=
operations (e.g. REQ_OP_ZONE_RESET/OPEN/CLOSE/FINISH) which also require th=
e=0A=
zone start sector.=0A=
=0A=
>> * The target zone must be a sequential write zone=0A=
>> * The BIO must not cross a zone boundary=0A=
>> * The BIO size must not be split to ensure that a single range of LBAs=
=0A=
>>   is written with a single command.=0A=
> =0A=
> "BIO size must" -> "BIO must"?=0A=
> =0A=
>> diff --git a/block/bio.c b/block/bio.c=0A=
>> index 0f0e337e46b4..97baadc6d964 100644=0A=
>> --- a/block/bio.c=0A=
>> +++ b/block/bio.c=0A=
>> @@ -1006,7 +1006,7 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)=0A=
>>  				put_page(page);=0A=
>>  		} else {=0A=
>>  			if (WARN_ON_ONCE(bio_full(bio, len)))=0A=
>> -                                return -EINVAL;=0A=
>> +				 return -EINVAL;=0A=
>>  			__bio_add_page(bio, page, len, offset);=0A=
>>  		}=0A=
>>  		offset =3D 0;=0A=
> =0A=
> Has the 'return' statement been indented correctly? I see a tab and a=0A=
> space in front of that statement instead of only a tab.=0A=
> =0A=
>> @@ -1451,6 +1501,10 @@ struct bio *bio_split(struct bio *bio, int sector=
s,=0A=
>>  	BUG_ON(sectors <=3D 0);=0A=
>>  	BUG_ON(sectors >=3D bio_sectors(bio));=0A=
>>  =0A=
>> +	/* Zone append commands cannot be split */=0A=
>> +	if (WARN_ON_ONCE(bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND))=0A=
>> +		return NULL;=0A=
>> +=0A=
>>  	split =3D bio_clone_fast(bio, gfp, bs);=0A=
>>  	if (!split)=0A=
>>  		return NULL;=0A=
> =0A=
> Zone append commands -> Zone append bio's?=0A=
> =0A=
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
> =0A=
> Can the above statement be simplified into the following?=0A=
> =0A=
> 	if (nr_sectors > q->limits.chunk_sectors)=0A=
> 		return BLK_STS_IOERR;=0A=
=0A=
That would be equivalent only if the zone is empty. If the zone is not empt=
y, we=0A=
need to check that the zone append request does not cross over to the next =
zone,=0A=
which would result in the BIO being split by the block layer.=0A=
=0A=
> =0A=
>> +	/* Make sure the BIO is small enough and will not get split */=0A=
>> +	if (nr_sectors > q->limits.max_zone_append_sectors)=0A=
>> +		return BLK_STS_IOERR;=0A=
> =0A=
> Do we really need a new request queue limit parameter? In which cases=0A=
> will max_zone_append_sectors differ from the zone size?=0A=
=0A=
Yes it can differ from the zone size. On real hardware, max_zone_append_sec=
tors=0A=
will most of the time be equal to max_hw_sectors_kb. But it could be smalle=
r=0A=
than that too. For the host, since a zone append is a write, it is also sub=
ject=0A=
to the max_sector_kb limit and cannot exceed that value.=0A=
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
