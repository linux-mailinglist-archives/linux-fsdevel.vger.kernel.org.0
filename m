Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09B5196498
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 09:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgC1Ivg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 04:51:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18490 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC1Ivf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585385496; x=1616921496;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DOcxowQwAaFSUWIPXAX49MBLOu4DFNmW/DG/kaxWSOk=;
  b=OtcnkVB8javMqydR+WVH7SjmGDT6mCbEBRUJ5ghlOTwIGzilXLu97LAs
   heccvHcrcmopVXnHFFl3weOgrcGSW76y1cozdA1Yer/obrrZ3PA+oQKGa
   IT8DeOrz6Y0MB5l28HCmS7nAK3FRuSPjPgryJrjRW/RyRgm+H0QgfdOv/
   aen5zkS3Hy5iWVcam3ASpRoJWc4Ir2sdp8dUOajxiZIMJKDNNHbVYulNd
   S/xcV1utqFWBH1LpbqP9onuTSQ3WYpi0o2Z5q9sNUhDCD04fLFkDCCldb
   iODsVfhIYHQq8zyNZ13fHQwfjQ7n/Ca19rKz4YF0qE1I2tBgAbMeuAVwn
   A==;
IronPort-SDR: IeiCeWGs5gt03K1MJ+URtsGdTyWeRxmEIkgNSktfDfF73SKBXflT27K50P2IAT65ZqM+YISKqr
 kRr0vufpLym5sKchYfkSiuyptTQEKh8SGVUd4UpH8fvkA8cLHzf2XMmQK/BKcxcQcTg6YmD6Wx
 +RObqH1eGq9/DtnmeOGEMr1GF5WB8uZOkNFPpClJ9eUf+SBJj03q7xUcUADvX4O4OR83A/WTIn
 sxPZVJO4ECinqfzu3r3sFSu3G23A4DeXjj2sKXRjow3R4VfvGFUSjUr/fkZT4YxdwXmIHsCgvu
 H14=
X-IronPort-AV: E=Sophos;i="5.72,315,1580745600"; 
   d="scan'208";a="134178799"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 16:51:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfv4tTLB+Yy7RIR/SqMP3k9XWh7M0nxKBrypuRY3+5pjrHwueOQ5Edk4OSVZFpWlUZOlKXDUlw0GAzN4h+9PNE9sxwzdLlzw/qUXN+eHiXe4ljmawPxMMnsZOWqNlB4vZ66UfiIFpeOlQ8DwIFqp5hOwMOwLc8Mm7fg8KPlceDwJswEV0nmsa7ZIwHBmMZ4hSCO65FR/nComvIhxFXy81RC1AHYWiobSk+qS6hPKeigeEvhDfzUimqFiSylGPT0K4kZNGqLGRxL690orJJuvZeZLW0eYWAKbT8pqqONBvOsx3wA5d2+mcFfKYJEX1WMuD5OBOJ7Qo9aRHRo7lL3bCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJpcNfT10OYnTOlcGRLmDb4QqbPfwGE6cT70hCOHVoE=;
 b=O7g7d4n59WGer86LTUzt7CQXy9X5PD4a8LXhZrxrGIJylYYSC30y0Ah6tFXywKm3sYo0zvE0jHokNo7ana3045R/cHQ96TB8oW7tfiidilMCdArC7iSOUINuEFVnHX0T412L9iS5Qlw9lGjkQpSQfhNxYNmUiljiQWzPb/bu/th+3SwLoI6H3edHdjl5dd+5MP/8kqCJWrDcwNheAS3Np2f9GCG3enMeVg/NdnAwWmtpdFLwDvBOX8aGiudDQ0QDhsMVAAw3b4UJaNJC8ZJ4KZGu3gnLazPounhT9y5IxbcmKAyH2cpuE6EqcMkLm66bN9B6A9m7vhLq0z6AycTxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJpcNfT10OYnTOlcGRLmDb4QqbPfwGE6cT70hCOHVoE=;
 b=b6VVbPWicczXSnJrF1Msz+iCiUz0CcTI1TNK+ADfF8fjMZUYIluvRAh0hDwejmePc2rDgkcHKBvQPwyYNbqo6fv9UHKrl44kAvNAwm5WYwCkJrvPODj1tUJaDc0NDjIQ0l4W/gzMpVy1dMDZVRI2pPiLM/pxKyJGwKaMDpv38S0=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2245.namprd04.prod.outlook.com (2603:10b6:102:6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Sat, 28 Mar
 2020 08:51:27 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Sat, 28 Mar 2020
 08:51:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v3 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Thread-Index: AQHWBFfXQAZoUI98dUW9JveSk7yeXQ==
Date:   Sat, 28 Mar 2020 08:51:27 +0000
Message-ID: <CO2PR04MB2343547B8748378050855B2CE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-9-johannes.thumshirn@wdc.com>
 <20200327172656.GB21347@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5261e7ac-505b-4866-c38f-08d7d2f5340c
x-ms-traffictypediagnostic: CO2PR04MB2245:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB224550349D648F99D1AA039EE7CD0@CO2PR04MB2245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR04MB2343.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(54906003)(110136005)(7696005)(316002)(71200400001)(2906002)(478600001)(4326008)(5660300002)(55016002)(9686003)(66946007)(81166006)(186003)(81156014)(8676002)(33656002)(6636002)(66476007)(66556008)(66446008)(91956017)(76116006)(64756008)(86362001)(8936002)(6506007)(52536014)(26005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBFS8lHQV6YCX2dgkgdS6D+BbG2yDPL3cZqcv7qEDEYa5KYxVFOiXKQPDewQnK7q7MdDQLYG7z2UNd91HvM9a0iuYXZ7P6PwUlc9fPlxzQq05ENxxU/z1bK+c1mjX4VptxVPbt1Zr3E/HLvBkcLd74wZNisSV0SfnW5rtO7tM4dgBzKiyu4mC+K5ukvOSHfzTz1/qrnGFvB2tL3tDKRERVDK7fLLZth4FSZ7Gmc8BNdlUiG7SK99yI2QHw9JkisBgFz+OrGpRqfzE0VFKW8ma281fXnltMKyniIhF1JOj6Skjb7x9jroaNYszINJtn7vQikHqLX1Qz9uGW004DWxcNHAgo+AGe5QUJvrGOqKKTtfIlbJhbHeASehMdRvtCLGZ+7jz36kaGAu8icgOZC5YYDL5/cbh/aAMAte53RDzvsXQYtus8ou7gAMe9dceo32
x-ms-exchange-antispam-messagedata: eKRdPtas73SNQh/C9UDKaX+xA65b9bIWikuywjcYO4hMOv1dCQKxbCWnNMECtu9wFNXy/eILCUTw5DgCApqzxKFq+zFOP/beGe2nibkwkI4ho5v5jMzaJMnnP9Yi+ALP09gVbOYZ4YhOdpXvmzy9xw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5261e7ac-505b-4866-c38f-08d7d2f5340c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 08:51:27.6607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2OJfnNVR5UXDTN3u+DjVukMl5Fl/s1neFCJaJC4fnpipBP9xPSemiT2pzm9n7LDB708hU7NwjH28Dxl5xvfBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2245
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/28 2:26, Christoph Hellwig wrote:=0A=
> On Sat, Mar 28, 2020 at 01:50:10AM +0900, Johannes Thumshirn wrote:=0A=
>> From: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>=0A=
>> Support REQ_OP_ZONE_APPEND requests for zone mode null_blk devices.=0A=
>> Use the internally tracked zone write pointer position as the actual=0A=
>> write position, which is returned using the command request __sector=0A=
>> field in the case of an mq device and using the command BIO sector in=0A=
>> the case of a BIO device. Since the write position is used for data copy=
=0A=
>> in the case of a memory backed device, reverse the order in which=0A=
>> null_handle_zoned() and null_handle_memory_backed() are called to ensure=
=0A=
>> that null_handle_memory_backed() sees the correct write position for=0A=
>> REQ_OP_ZONE_APPEND operations.=0A=
> =0A=
> I think moving null_zone_write earlier actually is a bug-fixd as is=0A=
> as we should not touch memory if the zone condition or write pointer=0A=
> isn't valid for a write.  I'd suggest splitting that out as a bug fix=0A=
> and move it to the start of the series so that Jens can pick it up=0A=
> ASAP.=0A=
=0A=
OK. Will do that.=0A=
=0A=
Johannes,=0A=
=0A=
If you agree, I will send a patch separately for the move of null_handle_zo=
ned()=0A=
before the memcopy. While at it, I think I could also take patch 7 from thi=
s=0A=
series and send it together with the reset all cleanup using req flag. That=
 will=0A=
make a mini series for cleaning & fixing null blk.=0A=
=0A=
> =0A=
> Otherwise this looks good:=0A=
> =0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> =0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
