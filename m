Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB85B1BBD18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgD1MJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 08:09:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26630 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgD1MJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588075769; x=1619611769;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FOpviM8uNetDJFietTREJlLSBSvpN/B1zXCqXC/ySqo=;
  b=qe2U6Ni+NUBQDg/n/cB0o4gr1ei2QlbpCVn22idettpvgbBLf0li39V4
   /B499NJtEnj90dbwBRjP21IvxpiL8/OTV0vDzj2ff9muCkPCw5rPzn3Yl
   7g9kl/3k2rRNvKvRhSxZ+pSxQiSaJnO2dhrhv1RhsL4X7VNTC9d5MZQfg
   Ha5FWniaztEnLfUbV+LjCIRTgMSe9hoeaJluKuApUk8ExsydOiuBRd6yQ
   q+pvCBTZ28I/0OzL7ejBDu9BtTtwu+yVwRv7An1H8zb+JHn/9P6dq9tM4
   1Tzx/EQf29vdC15qPyW4YWIG5B1qBexPKl5054FPcxNpJiXxm08BntFJv
   A==;
IronPort-SDR: v9hnqgsDS9vBhktyGhE5m2HWojjjmW23Q9kPlAn1MK18ZO3q7FitON60NY9rRRTIsBHE1sRj44
 +9B/+Lo/k3zPVXngM6F8mODVXmey41CMYjs0GReXX+t02OmhI67D+94PUlqrUbOq5WCfv/pVb3
 Py73k4JjJQgiQyg/KLrSKfeNKBx6/jXk2Qsbw7wKOTr9UcjHN6nCUKGycI34hzW8rT+0Bz3o0i
 C8VStha4C3WTBoFHBlqcVz5QvCjQU5WUrgBtvfzfSxAkBMDGoppSz0c0wIsPtEFSGoRaVwhiiW
 3xo=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="137780825"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 20:09:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHPfPQ69NWO093zTWmqTVcm5zwDHfTizCBobn8mc8XZJJiBYR8p4bDUuhF3FoFz+gm9SfUeZ176Bhez2qpX5rlGfQYWkt5gP98pVztkSNs4ex2sMwVzQlJOSmFUYKm6q+32s71hCpfEEaIZNJMOPz8qlbOKOr43pIbZQ74IIhCnjOzuPrC8UoG/BQjNEwYbsnVZZiHzSRGFTtbY7yJMxYkFS7isjYEvV6Rf7lvDGqLTbKsWA3bbARLId17NsjLEzqJXiMTvz1FKn5+/NcWswgdW3tvGSO5qBBgk+Weovn7dV7hMnGGW9cmJnHYVRstZPSOSd8kudoNSbg0NRzNkksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DY2/UnGCiGqOsKuDhUUl6xbEyJ+5TVGFHPsxGtQIyQ=;
 b=PD7i78XE5Ucw+xIdF3EnZVPFeNDbnNqQj7zr+K7M3+PiJFlzguMswv+vyxwDALJtc2XOs1vKNiq1XCvjx4xzoFzT4TQNV02F4MQNpD00pCOkm8BnMrCJxXYDPPvpkQjlFBpIeqs27USQzKTd43zfu3ujnbkTLpOVvLfkofBWRUNV1HZn7PcoyHmtNAgpYq9DVWQPYDEVGMptxtYhNFeoEWrNkqz47Y92lC9Pp0JX96sZ7qm4sJlrXdlGRAEPC6n9GEY3VGwoDQfi6L4eKjuwn1MsUqu1Lcv5TZfWpwBmV1OjMZcMueJUPvBMZWyD+y+9b7igcO3PjW8d1diQf6m4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DY2/UnGCiGqOsKuDhUUl6xbEyJ+5TVGFHPsxGtQIyQ=;
 b=eHsqOhPRD01ZRiSazIOFS4fi15FZOtLLhjioxr3VXY9wpVNYrXdTpNyjQAWJyslgzdNPIOOduFTGSNOygpdNegajmeUk/6JyOAcLCs5PHxYpXOrUDh+Z9GfbKm3sswhupsLMzwEf7n7Ylk8SFrp4QYyK8jTYznU1dVSpyN4vKQU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3534.namprd04.prod.outlook.com
 (2603:10b6:803:46::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 12:09:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 12:09:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 08/11] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v9 08/11] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWHUpHPEc86QPehUWDtQprdg76tQ==
Date:   Tue, 28 Apr 2020 12:09:25 +0000
Message-ID: <SN4PR0401MB35985B7C08A21C15DBD515299BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
 <20200428104605.8143-9-johannes.thumshirn@wdc.com>
 <92524364-fdd2-c386-9ac4-e4cbb73751f0@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7074c332-c124-4620-26e3-08d7eb6cfea1
x-ms-traffictypediagnostic: SN4PR0401MB3534:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3534176E50B81FBB54DFAB3E9BAC0@SN4PR0401MB3534.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39850400004)(136003)(346002)(396003)(26005)(52536014)(54906003)(86362001)(5660300002)(2906002)(110136005)(316002)(53546011)(8936002)(66446008)(6506007)(478600001)(8676002)(66556008)(64756008)(71200400001)(33656002)(91956017)(9686003)(186003)(66476007)(76116006)(66946007)(81156014)(7696005)(55016002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DWmduR/KPcycahIbSecOi2XwcEC6Re/3YgDOI+ut/MAlCqk51PyTGPOeTenU+5JBFHX8miZC+XJxP/i7Vi7JWFBd8Jrqfhtr0WhUe6zZgXK2E1GvlCcX5G0SAjyLAxJAx4BH2Ou8LPTq8z1uqELLU+DzYtuVVNMt2ChU49b5waERt7GeYCrVcecfhCHLacfveL6sfRUBuHdk4gXDOyM6Yf+Q/MGKqgzFuysZ8TD1ZSIc3aq6+7Js2s4NSeiN7KYHuRBTmB2BohV84GZ4k0OYU1y8pJSy50thGNBCNe4d/Ng7+KdQ2aDntJRuNP2M0DZbz4Yt5tHsbpZmTO2KMFG0bJtfJbhlHcKwtjfGocxinzn5/EX1nIdSnNlenF+5OwvZM099sJweKaUKAcKtPn8uzO1Oa54c8QQggwq/bDGQcLffb3CbfA3qUgYwyUfpx217
x-ms-exchange-antispam-messagedata: VGAEieBFM1h2gD2jEUWKgFOJ/TVlCgMumMimKYid6ZPQMSiMTH5PVRSakvbKg8RecTNhGxGHsEHdDux9dlSC8Z7GD0d4IZpJ4jADpmRQBSrk7M/URQzjCW9AlAmKfgQcPH2DazAr6O7Qjgbe3XAgWhKavXmIEFdq324LaCiqGm1AR7WkS4W7Ati0lZUsJVeH0F5FYwN5VP++XBcxWGLLs5TjBJFuaSsOcQX4MNRydfC3O9J/5fc3ygINi9jt4l3gAptBs80ENydURYV0U/O/Fek6Q2w9ZelW4VsKC+9A3s5gnMlpnccLY68KnZHWRKs8e2ACu9SrhAqkg3rI2/kWxjZ1Lmmi0bt9Z6ix+Z1Lx+2cTF1BdlZhX+ofrECYXhtHNnCkheFWaSEJG1jlMa/l314bO/dxDkzIFhD3fR6klhL7bvUBHFnp/fZYfcP2CG9OT2+BXQRd6b6d5WvA0vURPDn/2Q/Xg2T93PphuAewV+5p4qU+g+OHUpEVDxPawPbiVhX5OJYLIdjnN2OhaeQhVymXOclomZv2+frivOhiQk5qSuYmQvMRvawe6YjfXxIWZrZfr3P4XZVVCVZzKBKPwf5YkfbMYJKC89eAbBbOEo5+llKAYmbM2C6farsFPGrPXekK3qrqYA1Gc1kOHYATBbFw3KdXDES65BX1auC3BjfBF0RXMEgoshFxQA0pQtA3UfSI30D0KnhWaIH1A8wPItFG4uPIg/aoiE4iF8MCe46rVs0b5yommJuOKATLan7s/7++TlskahGKnQYKSjiu2Bq+BL9xoAz6MGDCD4z2TNE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7074c332-c124-4620-26e3-08d7eb6cfea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 12:09:25.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cb7EYOWsYJKJOSHRkiHhvpw8WKi/0U9cT9tuS1EksnST/SbfLx3qLA3lIR/NCzvIlxSFU7R136tEOTKLa16DMIs4PraoInPn5rUxXNiQZNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3534
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/04/2020 13:42, Hannes Reinecke wrote:=0A=
[...]=0A=
>> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h=0A=
>> index 50fff0bf8c8e..6009311105ef 100644=0A=
>> --- a/drivers/scsi/sd.h=0A=
>> +++ b/drivers/scsi/sd.h=0A=
>> @@ -79,6 +79,12 @@ struct scsi_disk {=0A=
>>    	u32		zones_optimal_open;=0A=
>>    	u32		zones_optimal_nonseq;=0A=
>>    	u32		zones_max_open;=0A=
>> +	u32		*zones_wp_ofst;=0A=
>> +	spinlock_t	zones_wp_ofst_lock;=0A=
>> +	u32		*rev_wp_ofst;=0A=
>> +	struct mutex	rev_mutex;=0A=
>> +	struct work_struct zone_wp_ofst_work;=0A=
>> +	char		*zone_wp_update_buf;=0A=
>>    #endif=0A=
>>    	atomic_t	openers;=0A=
>>    	sector_t	capacity;	/* size in logical blocks */=0A=
> =0A=
> 'zones_wp_ofst' ?=0A=
> =0A=
> Please replace the cryptic 'ofst' with 'offset'; those three additional=
=0A=
> characters don't really make a difference ...=0A=
=0A=
'zones_wp_ofst' was good to maintain the 80 chars limit and not end up =0A=
with broken up lines, because we crossed the limit. I'll have a look if =0A=
we can make it 'zones_wp_offset' without uglifying the code.=0A=
=0A=
[...]=0A=
=0A=
>> @@ -396,11 +633,67 @@ static int sd_zbc_check_capacity(struct scsi_disk =
*sdkp, unsigned char *buf,=0A=
>>    	return 0;=0A=
>>    }=0A=
>>    =0A=
>> +static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)=0A=
>> +{=0A=
>> +	struct scsi_disk *sdkp =3D scsi_disk(disk);=0A=
>> +=0A=
>> +	swap(sdkp->zones_wp_ofst, sdkp->rev_wp_ofst);=0A=
>> +}=0A=
>> +=0A=
>> +static int sd_zbc_revalidate_zones(struct scsi_disk *sdkp,=0A=
>> +				   u32 zone_blocks,=0A=
>> +				   unsigned int nr_zones)=0A=
>> +{=0A=
>> +	struct gendisk *disk =3D sdkp->disk;=0A=
>> +	int ret =3D 0;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Make sure revalidate zones are serialized to ensure exclusive=0A=
>> +	 * updates of the scsi disk data.=0A=
>> +	 */=0A=
>> +	mutex_lock(&sdkp->rev_mutex);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Revalidate the disk zones to update the device request queue zone=
=0A=
>> +	 * bitmaps and the zone write pointer offset array. Do this only once=
=0A=
>> +	 * the device capacity is set on the second revalidate execution for=
=0A=
>> +	 * disk scan or if something changed when executing a normal revalidat=
e.=0A=
>> +	 */=0A=
>> +	if (sdkp->first_scan) {=0A=
>> +		sdkp->zone_blocks =3D zone_blocks;=0A=
>> +		sdkp->nr_zones =3D nr_zones;=0A=
>> +		goto unlock;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (sdkp->zone_blocks =3D=3D zone_blocks &&=0A=
>> +	    sdkp->nr_zones =3D=3D nr_zones &&=0A=
>> +	    disk->queue->nr_zones =3D=3D nr_zones)=0A=
>> +		goto unlock;=0A=
>> +=0A=
>> +	sdkp->rev_wp_ofst =3D kvcalloc(nr_zones, sizeof(u32), GFP_NOIO);=0A=
>> +	if (!sdkp->rev_wp_ofst) {=0A=
>> +		ret =3D -ENOMEM;=0A=
>> +		goto unlock;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb);=
=0A=
>> +=0A=
>> +	kvfree(sdkp->rev_wp_ofst);=0A=
>> +	sdkp->rev_wp_ofst =3D NULL;=0A=
>> +=0A=
>> +unlock:=0A=
>> +	mutex_unlock(&sdkp->rev_mutex);=0A=
> =0A=
> I don't really understand this.=0A=
> Passing a callback is fine if things happen asynchronously, and you=0A=
> wouldn't know from the calling context when that happened. Ok.=0A=
> But the above code definitely assumes that blk_revalidate_disk_zones()=0A=
> will be completed upon return, otherwise we'll get a nice crash in the=0A=
> callback function as the 'rev' pointer is invalid.=0A=
> But _if_ blk_revalidata_disk_zones() has completed upon return we might=
=0A=
> as well kill the callback, have the ->rev_wp_ofst a local variable ans=0A=
> simply the whole thing.=0A=
=0A=
Sorry but I don't understand your comment. If in =0A=
blk_revalidate_disk_zones() returns an error, all that happens is that =0A=
we free the rev_wp_ofst pointer and return the error to the caller.=0A=
=0A=
And looking at blk_revalidate_disk_zones() itself, I can't see a code =0A=
path that calls the callback if something went wrong:=0A=
=0A=
noio_flag =3D memalloc_noio_save(); =0A=
 =0A=
=0A=
ret =3D disk->fops->report_zones(disk, 0, UINT_MAX, =0A=
 =0A=
=0A=
                                blk_revalidate_zone_cb, &args); =0A=
 =0A=
=0A=
memalloc_noio_restore(noio_flag); =0A=
 =0A=
=0A=
 =0A=
 =0A=
=0A=
/*=0A=
  * Install the new bitmaps and update nr_zones only once the queue is =0A=
 =0A=
=0A=
  * stopped and all I/Os are completed (i.e. a scheduler is not =0A=
 =0A=
=0A=
  * referencing the bitmaps).=0A=
  */=0A=
blk_mq_freeze_queue(q); =0A=
 =0A=
=0A=
if (ret >=3D 0) { =0A=
 =0A=
=0A=
         blk_queue_chunk_sectors(q, args.zone_sectors); =0A=
 =0A=
=0A=
         q->nr_zones =3D args.nr_zones; =0A=
 =0A=
=0A=
         swap(q->seq_zones_wlock, args.seq_zones_wlock); =0A=
 =0A=
=0A=
         swap(q->conv_zones_bitmap, args.conv_zones_bitmap); =0A=
 =0A=
=0A=
         if (update_driver_data)=0A=
                 update_driver_data(disk); =0A=
 =0A=
=0A=
         ret =3D 0; =0A=
 =0A=
=0A=
} else {=0A=
         pr_warn("%s: failed to revalidate zones\n", disk->disk_name); =0A=
 =0A=
=0A=
         blk_queue_free_zone_bitmaps(q);=0A=
}=0A=
blk_mq_unfreeze_queue(q);=0A=
=0A=
And even *iff* the callback would be executed, we would have:=0A=
static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)=0A=
{=0A=
         struct scsi_disk *sdkp =3D scsi_disk(disk); =0A=
 =0A=
=0A=
=0A=
         swap(sdkp->zones_wp_ofst, sdkp->rev_wp_ofst);=0A=
}=0A=
=0A=
I.e. we exchange some pointers. I can't see a possible crash here, we're =
=0A=
not accessing anything.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
