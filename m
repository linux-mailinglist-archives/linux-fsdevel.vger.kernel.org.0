Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95D25AEF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgIBP3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:29:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6218 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgIBPZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599060304; x=1630596304;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=TYUCwox4mTo4ySGXeofvaUhiGrgqqX9UOsOiOiyocwa67TQFmpjCkWb9
   1IaXjzj6TpKEsoB10FgUjaRhkqcY4l7k8HDsHbl/6c0fS6ZzlpfycUVnx
   fNcpu7SMtL3wvz1bbk5tCRSKrLOHkZ1gq3jbpsWthjfWJfb3P0sqNevaZ
   a8r586SPsDtMPgqzR3LjQD5D9tlMmSwRnfJbI18kY5HgKpuRivsGCqPPz
   LRRTVOB2WSidiRdmS7kX5xBtzm2gEPlQQFhfU4tFXUNIaV9jRhbRNbbfi
   8tSLv7FSouylX5AzRQJM29Cw0g/6V1qb8PIv5gU4DormFAJJAzCNww9t/
   Q==;
IronPort-SDR: ZBbAUPenMn+ytTD1+bDbQC2AhmRnNJ1KJq+8Kl4eNXiSXe7ZStfJXze9p4R/Z8eP9M8BGFPB/G
 RQd3ZSNGL3Yi6dZbK00sur0oGWL8e6d+sszospbM/u9BnHvHp0YntNHyKqxO4Ug1AZ2rgf2hQi
 16iIwRRvOx2iiPI+KrIkmRjB86ni5FpIJThKgS5Kztz468pYZ5DlxH9LUCfoaBcQHvMpoENECS
 ZI+vHDi3jQwQpL1KOhdlyp556PZh+9OovMSdTyNqFurWThwkhUyKSdW4guJRBuSV/yn4ctLBmQ
 fTY=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="150760263"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:24:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDFSJWo5U5uW0071hnlRGRZCWsYYoEvUHJ1Lj9/g6ehhgpqmdcHxlhllOIcFIPSQj2Z3RH80chxRNxHhIs73DXEQoctfeknI2ijBzYPVLk8Je7ahbLHF8HuarWBIIjJVQBdELrVHwrjAjDNMebi7ctAWIsPTkOrrAWFvJRga1EmsaT+bNo4yjfvbIyo+y4wmBdcHjtofGRHoU5Jr68pMZ8Q586L0Yf7lG/B2WYFFVWH51SJF37QrJakTPSVSNbRKwng+YJ0Dry9/ZsxgUosmUJVIVjsE8Me2uXDAV7wO+kRZcsoI8rAsHshDUgaf3yZAJb+uNlm8zeH2QvD8++5ziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IySUSGLrsKvOjcDDqtrLGfWM9OEVT0ckuK6yI9bMEu/hc9iT1PfeEIugjRVnO6Cotzs1N4tRK57vu71+QBr7vFjq2FfNAwyBkbaJKWB1quQHTsEVXZlWNniH0GTCdPFE/yF572AIrpWqr2F7zGqORAa62PvwRJV4Amjm9T+Bs5IkVs9EB7U/s9JJE0rI2ACORLSt+7lCy3S4o/BiMqd8OG5ojO9u2s11XmYPa7OpUPUjexAqCFddte+RY0tbfQ24sJURG24BOY3vgUonLJcpC9bbnO0uOUQlskzIogFgqnTfoCz+PQbhASeg0oM8cKGky3KawLChr8VR9fu3W+4Kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RmLMexsr63hNqnwhKnJPpkUz0Sj5LjI59ddiOjxaoJRnwVBmHBGdOcJOcECG7sg2mJ27uT2/PUKeZDEKb7kjntgIiDW9/82h+Q7F3pxvm1p8MTKsStfCbEJcBzLBHLB5PZiNVvVyi4mbKoG9vIMql8NzAxCtLTYpmP7izpQxH+E=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 15:24:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:24:39 +0000
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
Subject: Re: [PATCH 04/19] floppy: use bdev_check_media_change
Thread-Topic: [PATCH 04/19] floppy: use bdev_check_media_change
Thread-Index: AQHWgTQMdY22DogrRE+XphQq0renYQ==
Date:   Wed, 2 Sep 2020 15:24:39 +0000
Message-ID: <SN4PR0401MB35982192F35579A6B487EECE9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a846bd3-c68b-4270-9755-08d84f544f44
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-microsoft-antispam-prvs: <SN4PR0401MB36793EE2B17B449273A42E149B2F0@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZLriCRvFtx2yWIglYlTZyPzesPWZqYxxoxSYy1RObVBiof/0pbRw2e1iD1dmxHxy3TicKw83CsCl/GPlF1p9U38vbKsmCeKThkfeg1Sy6/8FSivhhtmertHHejzI1S4LwPSfnBwI6rrUtE1Qw5dDb5g31WtCwkL4C80M6VHxDJgDaOL4u4WvyVWOFveoWRjkS66zLcbV52HwywrrJbr6T45fYuD8u5NEFs7Lre9kT1ZEKxeZRGWTP6Ac+xKLFcs+JlT3KP7lRHrTS+A+cy5V4l2MV8Ho64Z85v/CyUkjAXBAIJ9V4jVLMwG9zyRvQjqsJ0W+7Q1JWPuk0mBt9C/xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(396003)(366004)(8936002)(86362001)(76116006)(52536014)(91956017)(66476007)(66556008)(33656002)(66946007)(71200400001)(5660300002)(4326008)(66446008)(64756008)(7696005)(316002)(558084003)(54906003)(110136005)(7416002)(8676002)(186003)(19618925003)(478600001)(4270600006)(6506007)(55016002)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2sx8UtjjLAr/68EpndtxVX+X4lAGVRid0f0OjetQsFzSuiZ7yfSTYbhvcghKpT/K47q80wPsEeVruYnsbSFh1xidv+OnliW7my+/nxbIjTy1GfJik1BVkF38WcnQBGvbaw1jzjjQGbSZdijKTNIH8cmMgfbVw6AQFrt3/A4Gj/xKJdqTWgRSK+EkhY567NvX3X3ojuJO0FeTpEV4AnYVxiPfuWvzOeHssEp9pGOrY38UHRBcjUE7rQHPIwgcUri506enIsqENY990aLVmxFftWOviEsYbAr60qNHeagXG+JTS4HY8yAAPYvRnChC/oXduYZKaJotJpdjsD/AAuH5m58OQdK1v58nd4jjkygJaqC6x75ZmAD3NhlpoNcob6h7wvJf7XinTO+PmyoN4u0B93EmjcHFBHXnL7j1YBLNASbC4nfi5NWn0oJ4HDdaeHeZSdnG3wWfQOikE62YR3uFNIV2tN7q1vdzUNFeQMNd7GqN3wFeKXepEnnAlDEPhB65pBhNsYyLnCapuGXG43HqwX+XdzyJh0+zK5I+xRrBtJa4Ku2Iz3ld3s2seuo3HtGeMiMmAUn74GeeHRELnyRk1NOaHe3cFx0RqfbDW9iFdsYrne7tqDUD0FP3VERpjTj5jBJgDgNO4WKdrqY6AscJoyVOGJMaL+GRTlPyfFhvhLpNLQIBAafVeTuwt6oDjk7uBqHl/mJ67lKKAgHXAvdfiA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a846bd3-c68b-4270-9755-08d84f544f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:24:39.6658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlarJBzYgLLzI8LbjKqT+WhKFDXf6aM5JGoDbq+MVlUbhqK3Yv3GKVKlEE9XLCCzGpLKeeqM1dBPGgua4Qwl+OWv+InSVHhijJmut5ed1kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
