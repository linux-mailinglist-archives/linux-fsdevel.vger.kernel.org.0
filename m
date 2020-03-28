Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE901964AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 10:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgC1JCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 05:02:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22868 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgC1JCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585386186; x=1616922186;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3v4vD6jwb82z1fco87zxKkxCBvvrSL4V36O5BSWlGmQ=;
  b=FLR/SqlmqJo/jh7s25gYcRg8lbtOYOdM452SdLyJjjeyLs/jQnU0zkVx
   Miqo/t9sKk0Dw3ikSr2x7GI4xRH2UPKcIqczHPU/02X6aH+kvStQyQ0Lp
   tWxSdlYc2fhaxaRwHiQQ1+u26f955/Qb+bSBaMnImMey1bKMDgTlofCoi
   1YfYwCIW+ywElgySXuanDoQmJdo5L+fXyJxJRHra6Ul52h1zfFPaMMiWd
   qd+it5TI3tHNpFiHxJaDQYjydCoatsavIy4yutq3iEDJZWezoU/h+F85J
   gGUBiLO/MHd+FV9DmGD8J3bKQh1Uw6G7iNhqydoOPEQcT7BmPuAioHe2a
   w==;
IronPort-SDR: ZU1Xarr7ufIX1VXnBO3ypt4tE2dMzYSXt3We1ou4rJ7ZiseQypnmrV985BoAHh3i0rtNtlYohH
 J1hH/x5eXWNeMBcd9r/BQueVx70YIll1KIpHeabHbBUTkpek70t+S5vg+1haGw1tuSZtEUushM
 PPUNhqEL8ABei9sYOb1fRyyPCtMsUebE08rQ0882RW4hHvdG7eqCkEc4yOXofqppKr8eaooPE2
 pi3A0pdezoXYmIEKYOG1MGm2znza+0jjkbTIOPdEUVXw5m1FWzwpS6bIGMsCSKAtEEtPMHKE/Z
 yyg=
X-IronPort-AV: E=Sophos;i="5.72,315,1580745600"; 
   d="scan'208";a="236001052"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 17:03:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llpF4GSa721km32CJs6ZCdX/2s1ev1QdLSSJ4EUMywSrZ160QD2geq4okQOh7h1QzlKbeiVpAVTUY9NHw9vfpr4Kswt03jGVoLCtFBbjyyb6EzKyyaoFo1kuf8WJcdB2wuJBPdN4KWA9zH8Xm8UEOjtFAPDmrZMugQPv4DqTvdRCGjuWA6rVw2MKk5kKDPRKZL26tCRDYTw/hcWQykWYf3+zbdtfSBxWjYfHD0DTUD0NUGinFwU4j6F9WxHMcSBQd1wj9XdItEve2eBEdJs4Gxr9Aj0EcJwTcoM4ZinLnJV3oG5eUJr8pbS5bu5+ruSFqssxaMs+bEJJlsWj0WBPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLV1umbDFWyOPveADr44nhaAb4rO6pNi6EQOzMnERY4=;
 b=NjezUtczfavzEESi0VmIYUl8hwNQO55QyOgl9phEzH+vrwBNURm3N4uHEAw1Vxuv41QuOVq3vYKihzXC9MUo7IktTLVBG4BGiCC/qOYx+vA7WBluGX684LQIBFzTk5zaSm7DUMUso12MwO8vRBK819nLfzfmI+zf1zC4+X6c5LbF9V1a6rWuOLOmO4/D91jADuiP5j3yuZSDR+bGAopX89p8zALTgmPhb824qTQuMT+PrI1yzRtawres8RTvzi9dXCatty5raTYehLNZ+H4ecJM8sI+s/fTyx7Jnv3MKEuUmxOxtPAPNZdLFU1LfiDTFho0H+2efUMkUFb7rmvVnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLV1umbDFWyOPveADr44nhaAb4rO6pNi6EQOzMnERY4=;
 b=wBafHylzxmwmYr6d0z2jQX9gKtbpYg8UaybdGdmtOR9RlHSp8DLu7HhwRvdN4nkCUBCcnsDp5oKuX+QDMnusg9Cimwj7jnBIK1jDfUOsww/wNhojXzuADY2iHSZ+e1BrzAA6QXTg9hY19c30qc6Ag7Vff3EzclHCfUbqwKiw518=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2373.namprd04.prod.outlook.com (2603:10b6:102:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Sat, 28 Mar
 2020 09:02:43 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Sat, 28 Mar 2020
 09:02:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v3 06/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWBFfTgI8rxzWhnkGqyEIWCxLs0g==
Date:   Sat, 28 Mar 2020 09:02:43 +0000
Message-ID: <CO2PR04MB23439D41B94F7D76D72CE3BCE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-7-johannes.thumshirn@wdc.com>
 <20200328085106.GA22315@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e5ed538-9ecc-4f4e-6dc9-08d7d2f6c6f4
x-ms-traffictypediagnostic: CO2PR04MB2373:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2373C79F5FF04ED7C7ED7852E7CD0@CO2PR04MB2373.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR04MB2343.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(9686003)(4326008)(53546011)(81166006)(316002)(8676002)(186003)(81156014)(7696005)(55016002)(6506007)(54906003)(110136005)(26005)(8936002)(2906002)(91956017)(5660300002)(71200400001)(33656002)(6636002)(66946007)(66446008)(86362001)(478600001)(52536014)(66476007)(66556008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFA9gdV89gSlWHRH4arHKmZ64B2k79PgPOetFOtA9EgDy0bJ7r5JSsEFievtis0vIJxjQOnGzdIcSI/+xGicI9cmbS8cUjmChUelcjmRTKOYeeCwx/52CdJBp0NH2yUr22x68NGzTFJTPAgyRuPxgu/QABIDmxmQN2xKFfFhdLmuSB9GgrvGI30wdeh7k0YH2GP1MWT/rWRQ1pDlKsBLsPSr3rh9ldDzgUC6KSDE9ADFDxtNxGAEmZJNTC98a+5hLe/gCvP+bZeRgFkRNd6EuX2Pl739RALFJE/mf6uJDmph7SaSw2NHabEJghbKq4XKtVT+cQHt+hEz+5Il+svUf+mShjRv6dYB3U76odaQpvBGVSBAQzvdWZ+3RzLv8/eJI4nSGZCdbc0IOaV4NzCo/KKSZslmpC3LMYjsYyB0v+PQkg6yXaJJTqF2fve7PPVD
x-ms-exchange-antispam-messagedata: yQK2QrbO8ryaZf4gY6wN9rRlvNrv4/i4pzN7hG2QBN5oiZvejxTrWhiSZt/GZ2t7A0n7P5KLIuzD8bjN+nFxspAkrJw9+zdAM0h7Znu8iGAhppHNwqWhPr+ZmaxKUCBifxiQkhxMIEVynX54eSj50g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5ed538-9ecc-4f4e-6dc9-08d7d2f6c6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 09:02:43.6360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KxUX1vbgQRa4qCLYsUSG7YQS9yIO1U4nJVLwJw07X6EhCOx59Xbg1Hc5oQBac4DQcJVvDpTHbLRyj/XoZx6Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2373
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/28 17:51, Christoph Hellwig wrote:=0A=
>> Since zone reset and finish operations can be issued concurrently with=
=0A=
>> writes and zone append requests, ensure a coherent update of the zone=0A=
>> write pointer offsets by also write locking the target zones for these=
=0A=
>> zone management requests.=0A=
> =0A=
> While they can be issued concurrently you can't expect sane behavior=0A=
> in that case.  So I'm not sure why we need the zone write lock in this=0A=
> case.=0A=
=0A=
The behavior will certainly not be sane for the buggy application doing wri=
tes=0A=
and resets to the same zone concurrently (I have debugged that several time=
 in=0A=
the field). So I am not worried about that at all. The zone write lock here=
 is=0A=
still used to make sure the wp cache stays in sync with the drive. Without =
it,=0A=
we could have races on completion update of the wp and get out of sync.=0A=
=0A=
> =0A=
>> +++ b/drivers/scsi/sd.c=0A=
>> @@ -1215,6 +1215,12 @@ static blk_status_t sd_setup_read_write_cmnd(stru=
ct scsi_cmnd *cmd)=0A=
>>  	else=0A=
>>  		protect =3D 0;=0A=
>>  =0A=
>> +	if (req_op(rq) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>> +		ret =3D sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);=0A=
>> +		if (ret)=0A=
>> +			return ret;=0A=
>> +	}=0A=
> =0A=
> I'd move this up a few lines to keep all the PI related code together.=0A=
> =0A=
>> +#define SD_ZBC_INVALID_WP_OFST	~(0u)=0A=
>> +#define SD_ZBC_UPDATING_WP_OFST	(SD_ZBC_INVALID_WP_OFST - 1)=0A=
> =0A=
> Given that this goes into the seq_zones_wp_ofst shouldn't the block=0A=
> layer define these values?=0A=
=0A=
We could, at least the first one. The second one is really something that c=
ould=0A=
be considered completely driver dependent since other drivers doing this=0A=
emulation may handle the updating state differently.=0A=
=0A=
Since this is the only driver where this is needed, may be we can keep this=
 here=0A=
for now ?=0A=
=0A=
> =0A=
>> +struct sd_zbc_zone_work {=0A=
>> +	struct work_struct work;=0A=
>> +	struct scsi_disk *sdkp;=0A=
>> +	unsigned int zno;=0A=
>> +	char buf[SD_BUF_SIZE];=0A=
>> +};=0A=
> =0A=
> Wouldn't it make sense to have one work_struct per scsi device and batch=
=0A=
> updates?  That is also query a decenent sized buffer with a bunch of=0A=
> zones and update them all at once?  Also given that the other write=0A=
> pointer caching code is in the block layer, why is this in SCSI?=0A=
=0A=
Again, because we thought this is driver dependent in the sense that other=
=0A=
drivers may want to handle invalid WP entries differently. Also, I think th=
at=0A=
one work struct per device may be an overkill. This is for error recovery a=
nd on=0A=
a normal healthy systems, write errors are rare.=0A=
=0A=
> =0A=
>> +	spin_lock_bh(&sdkp->zone_wp_ofst_lock);=0A=
>> +=0A=
>> +	wp_ofst =3D rq->q->seq_zones_wp_ofst[zno];=0A=
>> +=0A=
>> +	if (wp_ofst =3D=3D SD_ZBC_UPDATING_WP_OFST) {=0A=
>> +		/* Write pointer offset update in progress: ask for a requeue */=0A=
>> +		ret =3D BLK_STS_RESOURCE;=0A=
>> +		goto err;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (wp_ofst =3D=3D SD_ZBC_INVALID_WP_OFST) {=0A=
>> +		/* Invalid write pointer offset: trigger an update from disk */=0A=
>> +		ret =3D sd_zbc_update_wp_ofst(sdkp, zno);=0A=
>> +		goto err;=0A=
>> +	}=0A=
>> +=0A=
>> +	wp_ofst =3D sectors_to_logical(sdkp->device, wp_ofst);=0A=
>> +	if (wp_ofst + nr_blocks > sdkp->zone_blocks) {=0A=
>> +		ret =3D BLK_STS_IOERR;=0A=
>> +		goto err;=0A=
>> +	}=0A=
>> +=0A=
>> +	/* Set the LBA for the write command used to emulate zone append */=0A=
>> +	*lba +=3D wp_ofst;=0A=
>> +=0A=
>> +	spin_unlock_bh(&sdkp->zone_wp_ofst_lock);=0A=
> =0A=
> This seems like a really good use case for cmpxchg.  But I guess=0A=
> premature optimization is the root of all evil, so let's keep this in=0A=
> mind for later.=0A=
=0A=
OK.=0A=
=0A=
> =0A=
>> +	/*=0A=
>> +	 * For zone append, the zone was locked in sd_zbc_prepare_zone_append(=
).=0A=
>> +	 * For zone reset and zone finish, the zone was locked in=0A=
>> +	 * sd_zbc_setup_zone_mgmt_cmnd().=0A=
>> +	 * For regular writes, the zone is unlocked by the block layer elevato=
r.=0A=
>> +	 */=0A=
>> +	return req_op(rq) =3D=3D REQ_OP_ZONE_APPEND ||=0A=
>> +		req_op(rq) =3D=3D REQ_OP_ZONE_RESET ||=0A=
>> +		req_op(rq) =3D=3D REQ_OP_ZONE_FINISH;=0A=
>> +}=0A=
>> +=0A=
>> +static bool sd_zbc_need_zone_wp_update(struct request *rq)=0A=
>> +{=0A=
>> +	if (req_op(rq) =3D=3D REQ_OP_WRITE ||=0A=
>> +	    req_op(rq) =3D=3D REQ_OP_WRITE_ZEROES ||=0A=
>> +	    req_op(rq) =3D=3D REQ_OP_WRITE_SAME)=0A=
>> +		return blk_rq_zone_is_seq(rq);=0A=
>> +=0A=
>> +	if (req_op(rq) =3D=3D REQ_OP_ZONE_RESET_ALL)=0A=
>> +		return true;=0A=
>> +=0A=
>> +	return sd_zbc_zone_needs_write_unlock(rq);=0A=
> =0A=
> To me all this would look cleaner with a switch statement:=0A=
> =0A=
> static bool sd_zbc_need_zone_wp_update(struct request *rq)=0A=
> =0A=
> 	switch (req_op(rq)) {=0A=
> 	case REQ_OP_ZONE_APPEND:=0A=
> 	case REQ_OP_ZONE_FINISH:=0A=
> 	case REQ_OP_ZONE_RESET:=0A=
> 	case REQ_OP_ZONE_RESET_ALL:=0A=
> 		return true;=0A=
> 	case REQ_OP_WRITE:=0A=
> 	case REQ_OP_WRITE_ZEROES:=0A=
> 	case REQ_OP_WRITE_SAME:=0A=
> 		return blk_rq_zone_is_seq(rq);=0A=
> 	default:=0A=
> 		return false;=0A=
> 	}=0A=
> }=0A=
=0A=
Yes, it looks better this way.=0A=
=0A=
> =0A=
>> +	if (!sd_zbc_need_zone_wp_update(rq))=0A=
>> +		goto unlock_zone;=0A=
> =0A=
> Split the wp update into a little helper?=0A=
=0A=
Yes. And if we move the spinlock to the block layer as you suggest below, t=
hen=0A=
we can have that helper generic in blk-zoned.c too.=0A=
=0A=
> =0A=
>> +void sd_zbc_init_disk(struct scsi_disk *sdkp)=0A=
>> +{=0A=
>> +	if (!sd_is_zoned(sdkp))=0A=
>> +		return;=0A=
>> +=0A=
>> +	spin_lock_init(&sdkp->zone_wp_ofst_lock);=0A=
> =0A=
> Shouldn't this lock also go into the block code where the cached=0A=
> write pointer lives?=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
