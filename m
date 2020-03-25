Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C13192539
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 11:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCYKPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 06:15:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63118 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCYKPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585131313; x=1616667313;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AZVqA6RmlTg8Fq053QJQD9wiWZN6+XZK9agyYCYrqjE=;
  b=I6LLN6sC29tLCjZkQpKoPT61xrb7qzoA1pKSJ64sEULMjL22w0IWpaSz
   btE2v/anLBD2Aw6fgHZrO8mzFsWansTobA80QWNohKpvdq9CCyA/bzySN
   mQSDWDsiWO2yY0TgzQZYw7efbQMv5eLvTWHhDaRHkhwD+TQ2TB/ncTgfd
   T5G2k83oRPdyOsLr8wmQt/DhEMw5IcYbGo9Egec38mWk1iB03ny+yle+h
   HdGAQokJ04Cgu9EgtQ2rNPKEnaNrVw3nXTGaOTB/p7AJYR+UcUGrMZEzg
   G131RwQ6YJpW6482HlalMSDNsJtJ2duCbsbZJwFqVIO4rF+tk/JUJc6LE
   g==;
IronPort-SDR: 3dqIsgURmklZxdm1wu69zRK7yLX6gMT77Z5BQcERpKdHuVtpL0wQn+roS0ZMEC6v/yipGMMvmm
 ftxzOra9lREhfTQ0LAmNPVqkoDgWsOnbqgtTd/b6UvfyccZDaWt+dGsB/flmXWHvEpHphYa0Vy
 ZTOdlsVpK3Cy7AoJYoCs/iaOsgZVRuk0FUEk68pRDKk0IEC7x6e56+BqGzDoF3rNFWnZKvlG98
 l6nbs7yUOBt/z8jwr+BaJcNxuSwOadv5bjJtqfquAu7tyApGaW0LkUS9vPABIwWPYzln6VLVQw
 eJI=
X-IronPort-AV: E=Sophos;i="5.72,304,1580745600"; 
   d="scan'208";a="133896589"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 18:15:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBiOfCDcO+GlXnesfGI9F426jZ3Me3sAx7COwLtewYmk2S4VOcsF68Hs38z5zIHUv42zpLLJ/Co8JRn+9QqW6N890dIpKpoGN4l0m3lWx5t5XuVUdUCTlVq8KlBkq5ADMaX8ui6zsIwJSmh8CAbUyqhwZHvxlZ3RuulqBYz4kZbQEzr67Ey1kylqOYjV6lQQakM+BC3Q09TITub4kyTwDLeWb7qBF5B3knv/AdDMlVDDuwX5hxuyYtyk93M70X/Vfa71af867LQqYCGgGNc5AkeKb5efO0xSEjIhA0IHITqNKN8FKMwROSstiJYjccrukb0IP2oNBWS9+RuDKFuXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mDcCA00tr31iefPVRzt+aXfb3TdrXs1MIdi7VDKWwM=;
 b=SuG/UdlaTeEzYcQ8Z5wQOxurmZ8S6/F2KnEDI7EyaHbA0+WEJgIe02PsBPBKcbj81PMDBGWJ+9QB0Gu31smDY1RnVQvJZiMYxKFh1ioVeU7zTDRJ6onrN6Jwx3ZLmiMejnFv4sJQTK/InmBR1HYiDK8+lnLC3dtIyoW/B/G4mnYOt2aZqpZtmIiJGgzkav3N7sGaOHqdVwO64xNxjmWbnrPtWNDQbANy0bDgrLUyKekGyco/OrKasbg15VsG0aUBGHLJckw10hdugC1EovVFAJTv1fvgk5FHFWdo08XWbCtte1fiu/2XUvZySMz1pO102iGaG3HNuJ/s1DrsPnNywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mDcCA00tr31iefPVRzt+aXfb3TdrXs1MIdi7VDKWwM=;
 b=byMlhMvMukLdqhWhLJqRqwvMpDejTyra9D9f+63gtTgd6Fb6NVaMGzSDAZnk3F+wyViJVMmk21KFFcAP55A9um+2hPSNNyvw/Z/hBVLJMnTNBiDUlL5aAnw7IWacVFhmempTp/RMQY4XZHR+h3HRUb2fELwUF2IUCAybzvs5DqY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3712.namprd04.prod.outlook.com
 (2603:10b6:803:49::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 10:15:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2835.017; Wed, 25 Mar 2020
 10:15:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Topic: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Index: AQHWAfBwrmUQROWSvUa2jUG+SCcnLQ==
Date:   Wed, 25 Mar 2020 10:15:10 +0000
Message-ID: <SN4PR0401MB3598C48C5748081BF26AF98F9BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324154131.GA32087@infradead.org>
 <SN4PR0401MB35980056EFCD6D0003463F939BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200325094828.GA20415@infradead.org>
 <CO2PR04MB2343F14FFF07D76BF7CE9D10E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <20200325100145.GB20415@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99e04e9b-8a6f-4486-ada4-08d7d0a566c2
x-ms-traffictypediagnostic: SN4PR0401MB3712:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3712725010ED58BA0D845C1C9BCE0@SN4PR0401MB3712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(4744005)(5660300002)(110136005)(54906003)(6636002)(76116006)(52536014)(316002)(9686003)(91956017)(8676002)(55016002)(8936002)(33656002)(81156014)(66556008)(81166006)(64756008)(66476007)(66946007)(4326008)(66446008)(53546011)(186003)(478600001)(71200400001)(7696005)(86362001)(26005)(2906002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3712;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5qd7C9EZkgDxJ8A0ZCyf0eOKbxJyonnDlBUheNe+mGd+FLt7/mmFWq2DwSbEWaWa8MjM6yvLGs6TUUeyiE9B9MSVfXe+FcIe+/MMcy3pKGjblIHjQ1TYEQHuABGQ8pnrsWI9KcWVDGEyAbv4c0AjRIDqVx1N5GL2mM497X7ns4xtpoCrtE9nKAjh5ghtK5rFrW5nQ0lq/CyfHOzq7jS6BA4U4dZIETpyw/ywzcPpXoRhwOFlD+m3Ay6Ujl6xhhErt4GjMQoJLGwsdFBw3y4o9YRuoW3UZaEbBtYaXm9S5Mgk9lp8Jd3TvdAbY6ov2Irx8BYmb0IEF0UmF9A9jR3KNupn2dJnjTKhJ/3oSMzsEiFCwoWv9rfNfxGgIDujWFCa0pvdtoGZHIlV0zqfWmnL6Bff7QfoY01pwRwfCoNgARvdvtjO1+5jZuCRAKfvdXk/
x-ms-exchange-antispam-messagedata: e2U+e3HW3kmT6crS68pIItkIlkpfoim4am5i2csqjdMlEz4VMM3j7lwLsoaEjcq+tZB6k4P+pcyz5ALziWW5HNwmEGGEq8eM58tWAbmMt+RWlFcPuzbU46GhnqDzPFo+1j5kHpBo/CvMy3q0W1805g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e04e9b-8a6f-4486-ada4-08d7d0a566c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:15:10.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rqkf5/aXW1clqRIfY+fMcY9XQdMRasVL1giJf1rSqykawSk5IHQnADNWrCDUwiOUQIYyJS+XqJFviDzSeEeV5AgJtqdEWsa9rsN8G22URg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3712
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/03/2020 11:01, hch@infradead.org wrote:=0A=
> I thought of recording the location in ->iomap_end (and in fact=0A=
> had a prototype for that), but that is not going to work for AIO of=0A=
> course.  So yes, we'll need some way to have per-extent completion=0A=
> callbacks.=0A=
=0A=
OK let's postpone iomap then and handle zone-append directly in zonefs =0A=
for now.=0A=
=0A=
