Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E573225B005
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgIBPsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:48:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61583 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgIBPrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061659; x=1630597659;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=pgQgsgl5xKk48BtF/8tMXvPTF9HZRzl11yjWki54gXMu2s+3KQ8BrmI3
   ohRneP7BE92psRfPeikRkK3gQSvckybO20PVlfrZ8YGYqVS8O7ogxoJ63
   DLMIXDFNNgMPV6OIYrChWebuF8Z5R3jxaprp7QT1fW2Tj1IvKWK9NAvtA
   EZCOqrvDluJyPM77s47jlYAlTjQNC3eaNdHHe0P2Q/fg9LPKIu8cKtp/5
   uNtETOijdPPGnqdaKx2X1nC0FTrgvctxkzQPjC9aMuzIDFxarEbC7t5I1
   CdEXk+SY0vBfRG+XcF7Cp4ANr4wl1A2cEyzrevXpchw0b03+ebgbP8HKA
   g==;
IronPort-SDR: B0uWa6Qxz5ZtjFaDz70FMSPv/KeYBdkInP/2UPv7rs1uiOB9GLvc7x80tuHj/fQD8OYKNZ/nwk
 h7ifF1VCM7Xbr5MH0Js1RgBFPQDPF562tTmaUYGKP8i1jehIIatJFI0bzfhgOvLHedKIkVUe2W
 dUg/JeyhF9eUvb7rYfJo3wx+aaW8xtLir5NaFnSBrMy6K8UteDP+IVlsA3tn8VdX42LTcnuo/d
 vvcgl202UqJax2/pU/7g6NAjnZavA4VM4TFdZhp83+8CQWl5c3IAbkwaqK1RdO2S+fuW544o1w
 woU=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="249683061"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:47:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT39A1ny8naSsAywazFLDuAz8V4r/QHkvRAJJR+n7NXs72zs5NT5NLFidUl04B0JH2NM7qtJwQ7JoXg2PwRc8ScqYTABGS4Ab2siXYdXIZ5hzHPzquQWVK9IsLscCCqTkWIYWHyyC1ApeYCxJ7rHIB8Q52indNuoEGRSfjWS6r1RU6cXq8/OMQY5gVippaJ3mAH+591TMoz8AxWzM6B9KPGViMg12sI3KL+HEP1J8SRDVS7a3rPRunN3Pqp0h6M8ylsgFp0IPwPwgL2+skguhx0elMjrvIOe3EtAOCb17jUXcaKSo+sJHRuXDYP5CouR4JDKNcUQnDvNXz2nbg6EHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fOHlQcRaxCQ1Iws2JdT+KDmWFxzqRJV1yz8gvDgNS6jG34SU1Hf9tttSfNvLOTF0XuAndIPwxrK3XlE6GPR2J6OF3Gct/tYns4rxV1QhmfEj4BfwlwqvSTD9bRqYaqMnQnuFrcLYFoInhLXYb9IIGwYlZLXyM7uodrQRTgpBxFMSD5nqXzbVHFUeolwuX/fjrhAInTUSE70OTG18+y2XuQqNDQjKA7Nta0FZAUHKTDVFj8UFxQSQbottSMON29/9pEINMV2RlYbKWw+y6O73Wktbe9aVXLs91PwsE2w3dxuQiwR//Yxafjp+QiuMQgaJdPHQHQcUeGzFeuLtcrgnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ttjnDOcQE6QgnDlm77OL5eDdzNpitHR4JDP+kuRGydp+RcY7SAT8xrH+5BXJR0JVwqW5LDrXo9tD0ONK3pd6nKKkJLLigBbf0TbPVEWYVGhBbbeP6yCPQ9WA0hz8q3LwgZJL/oM+IMWRCMCzAalBdAiS8BDnHb/DSX5mih0qIKo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3886.namprd04.prod.outlook.com
 (2603:10b6:805:44::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 15:47:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:47:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 12/19] ide-cd: use bdev_check_media_changed
Thread-Topic: [PATCH 12/19] ide-cd: use bdev_check_media_changed
Thread-Index: AQHWgTf3PmNLrab4VU+j1SQRgo0d6g==
Date:   Wed, 2 Sep 2020 15:47:16 +0000
Message-ID: <SN4PR0401MB35989B6BD2A66BF40234650B9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ba6b4e8-668c-4c8e-3aff-08d84f5777b2
x-ms-traffictypediagnostic: SN6PR04MB3886:
x-microsoft-antispam-prvs: <SN6PR04MB38864BCC550BBD658DF61BFF9B2F0@SN6PR04MB3886.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vcKxSHHY9NBu82gQjw8fDIvvoxJKMMs4SzpQNZnQXE4Q0gBtP+68OgoabLH4mAdvrmmMfadb4UQ+y7dnV+j6jngXZTMIXgMrHCpmfmyGmoBlC+qgOrq1FOwXK3YcGRz81OXFEfkHh+x7h7M7H/lyMt/SJwcM15XvzJ0V4UoSWbwzsFEMexQjSxfVOloNQnsw/Q/hPIGtfrf5Vtzt1lSpaZJWSgLIlINDTC6B8mHFERxmvQDkp4le4KisZTh7xKXZ1ptdDY1MKufMWDpGped9AJ7LCWpxvIpkYdIkhafaUAQxfKNyaaaOTMrkI5yzKIloTo5iUrwKdbi5KNjYGnBKMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(33656002)(8936002)(9686003)(7416002)(52536014)(4270600006)(71200400001)(4326008)(6506007)(186003)(19618925003)(5660300002)(55016002)(8676002)(7696005)(66446008)(316002)(558084003)(2906002)(478600001)(64756008)(66476007)(54906003)(66946007)(86362001)(66556008)(110136005)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: onUXIU7UtbzkjyIu6Y2if4VMDpg8SdM7FdtqY0Lh6FWaZN3Q5XWTIe+cduiSj/jWXAJfn39/0WQm1NnMHxJ66AAYi2fogBEaMkJeYFWFKwlgppK/XjtBmbA2hdLWTvqnXbjVFpPr1RgA6C3qYTBesBYFTOqyGPMOp7WBhmbAA10WWRlAnqpyjNNGfYKpO5+xRdkb+PP0XnvyQt1QgF4UzyG7gBHWJMJam7BlBBeqB3G+mj1ZYRctFcGxjb4/dOB+7qhlFoAVCZ/QJZpu/XoFFHJqqdvSisIoE3WNtmBlOM1OMPOJj6m4Jr4rSU7hcQgmpSvtdGEQl+CyvdiXpntCoYy/QxRqK7MUkkTX/RT62MsjWTSIFFM/vEBHb6Q4zDokpsrAOj3aSrlqbY/iVWzC9FehumbjgWPayXS9SOLKna4kwILm1OOyhXXBnS0unvHhfDUav+vR9TR14wuyZnUvEU9rxB1a/EjKg446H8YxRrb/LyN3u2KGDNHTLkbTqtJSVjHzPd67f3uT4ATP9h15/QpDAZR7j5yLnYiBj7gM5vY2KNYytcd8GsZdmWoiYhEXWTEAHqCOr4irTohktQL2P/HyLIlXuh3p2lxUAymWbOXtjFeXnRB6VRQsGxzFGYZjNbtajiKbEoK4IuqC1STB9o4IO8vIO6Ggrt6KNFaGOVoTQbdbGwxQFGmMP9urVUWONxNeu3k8yxb0FzO1wn4HvQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba6b4e8-668c-4c8e-3aff-08d84f5777b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:47:16.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDKQfAGWVLBVPqdPTjVQazV2yiw0wB32nr3IJAPyQ3vtmhx2B3L2BiEIFHHzlYwpwrUYgFT/TXCY6s+DmGyYTgwokk6+RSI3fx6w97v5/wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3886
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
