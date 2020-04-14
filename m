Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94E21A7851
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 12:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438259AbgDNKS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 06:18:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56921 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438250AbgDNKSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586859530; x=1618395530;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6bQZL4TPPaXzlnUHM2wHkTgMubteEFsRfrzlhl75zUQ=;
  b=oU0jmWRjD+vcy7KaRp4vONYTdsf8AoM7/i1D/C5sal/AvnVpzaDlhrnK
   0gxYr47qY4hUbNc+SgePyUHPKBwLJ+DWSTahM1EOLr5baK1pDhtCMLKNT
   sdXODVRZkrIC8x3v4IG1rnylkUx41jSFlsCm8B8nrC190EEZNiGArT8vS
   DUuNZSunK1FA98Uolk6N30Xhc3AyaI4fAaMShGYZqE4N+o5OwgLs1RV5P
   zUDyASE185ukFsSQ4wtcSiy7DiDPnjVfXpUzRcP+uRUIRGm/5A11f63Ld
   tNb0E5OPQ2fA8LPLUAwpFJO6P02ohX835hbjY3DEh+TWphxxJJeAhM+vR
   Q==;
IronPort-SDR: 5MItCoTVDGNjn+9pl6H9cBLNBQCqa1ouHwAuFmX4M8C8ij1K8tWL90S89AvBx2Fg87mfwyYa4q
 i8R0nnztTn6vPIXQGFhA4PJ4z9PI1hI6juEAP1G4l642Q/PECP7g1FgpV3nxKFdMFXGyzZkQ2M
 wdiubQU+Fg6N6NYJCiGOcknYl/18mu/a9L7omYTLDFBV8uJK2UdBAE4/1onXY+izsJfZGBHtAZ
 Z9YJrmKIAiHMG0EbN5936tT/b6FXABeeQSIKM83dx2Sks3BkNFMGCtym/L/906bFWuDB72Iaya
 +lU=
X-IronPort-AV: E=Sophos;i="5.72,382,1580745600"; 
   d="scan'208";a="237701901"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 18:18:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j92pJaitgoEqYyRjWkFuM9rXuMMLCmckESHXdfu1AJYPqk6Xw84YV205Q1Dad5jcxuSOMB/ncuq+MkImigF/rOIQYeW/auAm4lDR+fjutHOuYM68ZgWaRJV09nS/E6gX2rPZq9aA2o/ojlwrq4HkhrpkF0U+XgRn0rHp+P1tlL2Otd2ltXbe9JjyNvVrVFdfBEjQ3c/kyTyhD1MR2udeZL4q3VZnghWR+qZXOSNxjeyfwkItCZccMq00MUjo3H4ZaBiHIefV2/5OKBWKa2dM0vzMuqXFoPVZx40941EfzqjyHnV/meNfCwKEG8/cUTES4/5wjLpa0i2m8+bcyBdMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu4ealQwv9/uIhIXmON2xgvkgrM2Li50pWzEUqeBOqg=;
 b=HgzL8M2RJdv61KKcHm6TdWWJP8VJZXJClRjEG3bA7mkWaKFvi2B2ufmApyG1WSmWZsyB120IVLi7NMuQya43NVDtyIvy8RTDqqvgGyonOjoipdDWsNb8iOHBOPU+0g0PkCtahKS09DOCNRU63X0kqOQq+QDLn2wZoiLq7TRnUq0HaKe5m9MADIqk0X1DrfUBl3uyoiuuQvsEt3cqHVzN5MNXD2ijZYzA/wsGyBoQQXOtuNiOvmPO2tcnOmTE3r0BS5wxhijXyjhpmlHJlJJ3m1ZAkvDuLyZV+B9Gj+aIvg9p9fiB5YhgKpndqj0CwwOOIpWXkg4CaI/YhFUf3Y099Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu4ealQwv9/uIhIXmON2xgvkgrM2Li50pWzEUqeBOqg=;
 b=vmtJ8ar26NbRoBhnXsAhFcGDZ7BEIvVDdq+oLwRWUvUIUFmZdB3JQZTx51905bj7Gxv26EET3obV8l92dlZ3/8yJ16PW4BwVHyF+UDex7LxTKLOFSFVQIwAsAOIvU+DCvMO0GXtKuAgpgrJQPH8uXPIdqK29NSpG5v+HKt0Pe6A=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3648.namprd04.prod.outlook.com
 (2603:10b6:803:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 10:18:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 10:18:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWDo9/7/TsxA+1IEecB4cF8olDQw==
Date:   Tue, 14 Apr 2020 10:18:40 +0000
Message-ID: <SN4PR0401MB35984EF882B0E43E73CEE4729BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-8-johannes.thumshirn@wdc.com>
 <20200410072354.GB13404@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd21b817-2bad-41a2-c6e4-08d7e05d33f4
x-ms-traffictypediagnostic: SN4PR0401MB3648:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB36480650FE73913416AC2C1E9BDA0@SN4PR0401MB3648.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(7696005)(2906002)(53546011)(6506007)(54906003)(81156014)(52536014)(55016002)(8676002)(6916009)(478600001)(33656002)(5660300002)(66946007)(71200400001)(8936002)(186003)(316002)(66556008)(66446008)(9686003)(64756008)(76116006)(91956017)(26005)(66476007)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWXZPNkTGxJwDoQhK0hTTUoWKAJRQIzJfAIO42d41nXJSqA5xe0wGvj+iCdXLq32+ESPEhLzXkeF9ZQIZkk9+hzI3j3aYGErFRwvoRvdhSqOVZ8z6gBqGXr2VADp3A5nRJko8aTrCJwlLGW214Xm5ExfzUrPnUi4IfRp9w6kVH0rh9vseqBbEnetwvxM/KpC4X7XAh8q8WDkHcJQTynHOldDeA30/icw2nXk0xzHizU2pvRhODugnmWFNx8jYkmXvprRBwZgopiTxcjS4NeTvIgu2pGJqaGkuj81Xnj8XcV8TTBygjtkVa+qf8eZdQP7UiQsLXzG6rO1Pa/ADURIbLz0YB518IhwKxYCFGPAHWWzfMWDqUgvbUKlqnsNkTx7FOwQLTAejTIdJuSalANilLdBvmdXNdWwFVC/yBLhGFtLpK1fq4tw1B0xYHkBOZw4
x-ms-exchange-antispam-messagedata: WYsqsz58kUQXBpiNxc+JVJDFTbbCuR83uws8XAH6qdQjOVy4iGcUzYovn/2pQ1lrUWzcE9hTy/xHTHlnq9yEl0gmGjuznRuht1ixStvN/0OjjR9rcpg4pZsolNdQqEKtiFt+esMtYxDXAGo2UJaK4A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd21b817-2bad-41a2-c6e4-08d7e05d33f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 10:18:40.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bx/5qmfuwEw1Qnxv5FLFLiNun/246LyvK4iG2kLqRT00Xr3TtiMD7JjqbW+ejMPl86L5bWzOPtiCY78ihZVQEUC/Pl3vsdNn/2D1g6Flpd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3648
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/04/2020 09:23, Christoph Hellwig wrote:=0A=
>> +	spin_lock_bh(&sdkp->zones_wp_ofst_lock);=0A=
>> +=0A=
>> +	wp_ofst =3D sdkp->zones_wp_ofst[zno];=0A=
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
> =0A=
> Maybe I'm a little too clever for my own sake, but what about something=
=0A=
> like:=0A=
> =0A=
> 	spin_lock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> 	switch (wp_ofst) {=0A=
> 	case SD_ZBC_INVALID_WP_OFST:=0A=
> 		if (scsi_device_get(sdkp->device)) {=0A=
> 			ret =3D BLK_STS_IOERR;=0A=
> 			break;=0A=
> 		}=0A=
> 		sdkp->zones_wp_ofst[zno] =3D SD_ZBC_UPDATING_WP_OFST;=0A=
> 		schedule_work(&sdkp->zone_wp_ofst_work);=0A=
> 		/*FALLTHRU*/=0A=
> 	case SD_ZBC_UPDATING_WP_OFST:=0A=
> 		ret =3D BLK_STS_DEV_RESOURCE;=0A=
> 		break;=0A=
> 	default:=0A=
> 		wp_ofst =3D sectors_to_logical(sdkp->device, wp_ofst);=0A=
> 		if (wp_ofst + nr_blocks > sdkp->zone_blocks) {=0A=
> 			ret =3D BLK_STS_IOERR;=0A=
> 			break;=0A=
> 		}=0A=
> =0A=
> 		*lba +=3D wp_ofst;=0A=
> 	}=0A=
> 	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> 	if (ret)=0A=
> 		blk_req_zone_write_unlock(rq);=0A=
> 	return ret;=0A=
> }=0A=
=0A=
This indeed looks cleaner, I'll throw it into testing.=0A=
=0A=
> =0A=
>>   	int result =3D cmd->result;=0A=
>> @@ -294,7 +543,18 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigne=
d int good_bytes,=0A=
>>   		 * so be quiet about the error.=0A=
>>   		 */=0A=
>>   		rq->rq_flags |=3D RQF_QUIET;=0A=
>> +		goto unlock_zone;=0A=
>>   	}=0A=
>> +=0A=
>> +	if (sd_zbc_need_zone_wp_update(rq))=0A=
>> +		good_bytes =3D sd_zbc_zone_wp_update(cmd, good_bytes);=0A=
>> +=0A=
>> +=0A=
>> +unlock_zone:=0A=
> =0A=
> why not use a good old "else if" here?=0A=
> =0A=
=0A=
Done=0A=
