Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09A1A1D3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 10:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgDHIOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 04:14:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47977 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgDHIOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586333663; x=1617869663;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=u+6bGZWubC6o1JX63UsmTFvVa6+SnSIXYuUX+RF+/qg=;
  b=Kwb4ThfBV0JEs8TzlEYWaV6rPvjGOpH1QdUW4yO3LfAFcG7iYDEiWhxl
   yR7BSzMCJusMcquV8iF8qORFnd9cfi3POM9lTYrwRpRHQwRSNY1eiragJ
   SKlDnuQyuCe06d/5EjM4jkCVgnx3F3iR62TF7iBRFmJ52n5DEPzUhIBFe
   02mQp/0Gt9G0gvNZSiLyW6aQghRERgopx4QSTV2XcBgcWlp6PXEkX2XQk
   TjBRGPPlgi0sSN6AQj1lSVfZTAKuCyfNhd3lMOfUrF2iHbgeOHEmoidYK
   yh1oacnnMpP+PpM9yvOQGD/a4M8ILBwQOBEIPyNeaV7RaEGm5s+SO5mjM
   w==;
IronPort-SDR: 2dts6gPfqprhD9mKxkKB5dfh+zmAuGA+ZUktWRFr3KSx/6qyxHVNkwm8nuP6rP1tjju/wA6+It
 j0c5oy44rUAnumFu6AOkwkbFes6DULgFoTqZtzAeGpuDriEf9g/Xsk4hgvozZAy6UCxraBAf/j
 d+E/w1AL/aIXnsCyvcVR2xe6gm2DJuLNn5pa3xI5Rt3fMMfbLujM/S42c320DptvVQzHsX3NZh
 /dF6vunXXWNeYJiTCtHCjqAjLwM6kop8eFsSCK+moS6FHp8TFRlROywllDlG/zhIyzm3mFbrws
 z+4=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; 
   d="scan'208";a="136297478"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 16:14:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYSxYiP0LMrJz8TieZlTwuy1vudlEgkmHdCD6iRKRBMIgsX+fXuEF14oqBIRS9zlRTkRNnlOZ1CKo61qp208l81qQqoehJtzlECTuinNWZJ3JygdyPHZm79QI64sLyMFDbK3kWDqSGP1z234P5SuUtLq4cIPXRc0tWaHD10+I6UXmBEZD7QogJVPTVJjgfhruQb5uXPLHw4kssrry6oaOVqJy0kFA1xe1Omij/j2JZiT118sCaZIBgd0pmYaNKzM4Hp489i8ZpCBfsTpG8RhDzUVDYLK8DNRJtmhft0FqfvoOYSNWLRGGu7rl/CU021GNR+hVDkuusfDq+RHHUAwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g5CnGbVHl1DVHiNg4YXRD+vBd170yP/byueaccB8aU=;
 b=nUQ7DpPeOuQlJhPGeYxEn/dXfKQhEsDFnkRakcvXuyzEQ5l5P6mW89mWPtV7ggZXh9bgvO54KNGjiEd10heP66NTsbjfhV9u7opjPi2drTnl7Mq49zlD04OWnrpjjsQcxLkaXeQu9b8YgAkEjfBHKNpCl5Xa7RrvNS3MY/QmHO3caXuTFPxtL3v+w82W46aNHknhZA2qdAOMYasZ5kDQJvWme2+GU+8FvxXHBP1YTzzBxDEErlCSQT/2wHncyNMpHM1vEBdPjx7D/e6m+qHEW7JpdPdPH81Z7FI7DLx/J6AYHg9amaPaLI9kpu9zYIy3ryCIB2AB7byHK70iZTHPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g5CnGbVHl1DVHiNg4YXRD+vBd170yP/byueaccB8aU=;
 b=mnS9lmxxGxwoWRwP+i4w6z4yipA8/uhLs9QJAVZRIEt3CbBoMYb/BGh/BUA0tnmzR1YiKO7RL8f6GFGzNk+qFHWkdf8EsBV8Gpsw1j/a0VJ35KELrOUTLTEBgOXbNrig+Z6/1TvgB9iYsXJKz8VAPFErw2qTvzVJH8hW7PXpTGM=
Received: from CH2PR04MB6902.namprd04.prod.outlook.com (2603:10b6:610:a3::24)
 by CH2PR04MB7048.namprd04.prod.outlook.com (2603:10b6:610:98::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Wed, 8 Apr
 2020 08:14:21 +0000
Received: from CH2PR04MB6902.namprd04.prod.outlook.com
 ([fe80::b54c:8c9b:da45:2034]) by CH2PR04MB6902.namprd04.prod.outlook.com
 ([fe80::b54c:8c9b:da45:2034%5]) with mapi id 15.20.2878.014; Wed, 8 Apr 2020
 08:14:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v4 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWCaCApqSIFxwPt0GJDDBZAJt2rw==
Date:   Wed, 8 Apr 2020 08:14:21 +0000
Message-ID: <CH2PR04MB6902DCA5A70BBC48B66951E3E7C00@CH2PR04MB6902.namprd04.prod.outlook.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-8-johannes.thumshirn@wdc.com>
 <20200407170501.GF13893@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a64ab021-1e47-4f78-9d0c-08d7db94d76f
x-ms-traffictypediagnostic: CH2PR04MB7048:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB70482806D95D9714BEF91D6CE7C00@CH2PR04MB7048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6902.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(6506007)(5660300002)(7696005)(9686003)(81166007)(2906002)(55016002)(26005)(52536014)(66476007)(66946007)(64756008)(4326008)(478600001)(71200400001)(8936002)(66556008)(186003)(53546011)(81156014)(316002)(110136005)(91956017)(76116006)(54906003)(86362001)(66446008)(6636002)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4WlfM4k45JKpw31sTyaBQJGOiivLCbydN5Z4IDgGWCSY/v48lOR+EbayD+tFg9zHSs978R2L6pwey50+hYk5azazWyCD8BaWCRBqV2PHIIktMLXcAOHSR7kI9TsxHB0Gy0g5fy0V/JWtkUR9zoXRxummGeuq/qjFAsXHN/wsAMEGtH99zdLSXVPP0BmkrBvwewsMoXuvd0FtKjhBE5BjjB3yttnpTSPsTCRSgBa29mm+E22Lhd7zzDdpTYHTRaREpTmU+huedO5mub4rV2zC9lnbw1rNZ0fzfyhroN71c9UfORq+Qzt3vkgJieH5WdMrtRG0zqPhBHL+WNzBSugocuYWLWIRxCjtqRgFt30H448+jGVlVUieuyMyvR3yEmu6arq+KK+Hy3EgkT9r97uKmWHuee3975U6TbgemxSSOnM7T1SeS68fTwWmLiILQvw
x-ms-exchange-antispam-messagedata: FHJfCE2ZxjTrRLmRH283Vq1ICYaJ4AOwbl0AeBHyOTHhxjupIm1250fj+qrtkJEqaRIY+IpC8PnV6kBs/V1NhgIDYIj+GKw4CC8bgv2x1AO1Krv/Dn8tc3rJfl5nB92SooGTbWtdkBArguFtG3PuBA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64ab021-1e47-4f78-9d0c-08d7db94d76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 08:14:21.1347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSCDAr32XwRRV9e4FuhdUbLnDv5+wbQz2fiyyP9qXreCln9s7lXRviVBH4IT28f7JMVQFXd/I+W9TO7Y/rsf2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7048
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/08 2:05, Christoph Hellwig wrote:=0A=
[...]=0A=
>> +	/* Only zone reset and zone finish need zone write locking */=0A=
>> +	if (op !=3D ZO_RESET_WRITE_POINTER && op !=3D ZO_FINISH_ZONE)=0A=
>> +		return BLK_STS_OK;=0A=
>> +=0A=
>> +	if (all) {=0A=
>> +		/* We do not write lock all zones for an all zone reset */=0A=
>> +		if (op =3D=3D ZO_RESET_WRITE_POINTER)=0A=
>> +			return BLK_STS_OK;=0A=
>> +=0A=
>> +		/* Finishing all zones is not supported */=0A=
>> +		return BLK_STS_IOERR;=0A=
> =0A=
> I still find different locking rules for the all vs individual zone=0A=
> operations weird.=0A=
> =0A=
=0A=
This is to avoid taking the zone write lock for 10s of thousands of zones, =
one=0A=
at a time. That would be too heavy.=0A=
=0A=
As we discussed before, if the user is not well behaving and issuing writes=
 and=0A=
zone reset/finish simultaneously for the same zone, errors will likely happ=
en=0A=
with or without the zone write locking being used on the reset/finish side.=
 So I=0A=
think we can safely remove the zone locking for reset and finish of a singl=
e=0A=
zone. If an error happens, the error recovery report zone will update the w=
p=0A=
offset. All we need is the spinlock for the wp_ofst update. So we can clean=
 this=0A=
up further and have this locking difference you point out going away.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
