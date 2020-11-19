Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0042B8DB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 09:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgKSIia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 03:38:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27341 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgKSIia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605775613; x=1637311613;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PvdM8cICbPu2EB5bo2tpOLO3uAxCKWF9GbviickAV4qnqYAz67A154bP
   SV+NsmbE1YnJTj0YVnRlmoYagceGRCrP5RltzimA+pTaqJzduvNYcM8R5
   OvrsFBmmma+gNf8iqN/RNSapVKXwmm2JZEyJlImVZsz9idvbsKJlRDEP7
   CNAYMBMKw7iAymzYV8yc4mpWa5umok/CBNwmDse2eZR9yrYZaCGK1/OsL
   Y0crZ42j7LXJe29SamTNHaLLb/dze1V/GSaHWk0X0UCRQAkfX8ZqdkH02
   1UAAPDlpLOtYQKASH7r9RzDzg3Ssd1ibrc5mJaEDfzTXe78wBOMxx/M8i
   w==;
IronPort-SDR: 7kpecrLv1R+8Tn0CZmRF0yo+J7M5rxF63VVhvXMSVXhy0xPzBwLW9bRZ41RPQuFsLSPhrVgW2p
 Ynmljzaf5ROHMcakCa4XZ803Oubb8Irxuh0L0eAU6Q3z9Iwc6As0Dl5TYLU6rbLuzPURdwfoA9
 NBgF12olrN1laUNt5lJ46l/dLw+0nysf5AujmAWQE82XSaJMG8kn4XSl2u4WsXgxhx/Nq370hC
 DitD+xK1g8tiQSf/o/AMAAeHvZSa61iucXxhtjNy7psFUfQ8rmros+lKLLePsDMOIFyMc5QpEv
 Lp0=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="256563203"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 16:46:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUgnkraW+QYBqlXscVDNm1LVigFNdyHDXXPvENUQgvpzI8jpbi49DkIamXUsdYjH18fPlELdfRHAWLyFKuv1yf0rE/YWP/dN9CYYn7Z5CMe1FDdehH/6S1vPoPjNpWZ8OKDeucOl3z8z0OTX8mcQYk/PLeFaI61upG7yYSE4Y/EEzb34bEThcqM17Q7EImAs9cKnx3D96Xwx93iTRuFGt6G3hzUolYbtCfZC0WEHwwsNUIr9JHDpe3uF8dcXFRU231iWLzQFcp7XgeAugOZWXiUU6UIo6MX+QDyDK0UuyvXgTkk9svG0CPTRDnyDvUjZC2xqkMzxgu+LcAn9RsUt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ItdyS/TYh8LPv67rajQBVzLUBGeouOrjcTOxHEi0TQ5rON6NwcJTPIr/bskDEqGdKokt78i29jmuj/KoKmrszHkGvWOra4lAOKkpOqm5CbN8fJEwKMIqevR/KobKt1YxNpjxNBquyc2jTlfxT55B3VKOXWhFGcaora93Qdx6XbIG13/H5r5temmK4Jasa7lKTmy/CiFn0P0AnmSfMn2yYpbG2YllHgl4D3OtHaZ94V1574QFzIjcAhvM/CwbPnH08dW7TrK+ydG+QnSDIJUHjPfBUR0+4uCGwJWubshwG2Tz4Dzb2GBywmsSY3Cu8EBPw32FVQd7g2la4iohjx1udw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=0H5T2i43HPmpwn6z/c6M16KEb8JBBxQZZCug2FlTzcCTFev3Xixb1d1NAnH9FSwDFd6Bl7ZPS+rSMe/nSLRTaEEda2hOeTbUYAxhpnuTT9RG/c8OrxG2Ta+Siw2nepSNMUEvPzirHrQB3YgVRjWylAOMw/u5s5G9OneGk2UeyXU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 08:38:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 08:38:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 07/20] init: refactor name_to_dev_t
Thread-Topic: [PATCH 07/20] init: refactor name_to_dev_t
Thread-Index: AQHWvYgrYc1Qp0WgLEOTR53TfvPOSQ==
Date:   Thu, 19 Nov 2020 08:38:26 +0000
Message-ID: <SN4PR0401MB35988935BAEBEC04C143EE759BE00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:851e:5636:4e29:3e2e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b730e505-bdff-4d92-45ab-08d88c667bb5
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-microsoft-antispam-prvs: <SN6PR04MB4862C4EF0AEAA7A94CCC4D829BE00@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AYG6BnQlsuGA/acLvLJgD7cGr5/O+puH6AbW6Ju3ilicmeE2aoZVRwEBcJL8W8aHpanaHc8PRJyDum4B+H0jOgvDGD/rMvmlvtImEIktxVkuLuNFT4HUZNSHcSRjPusPZ2bo2XYdTh67fWzZvTAifSG9aOSwEKW9qAqJ5Y9aZZakuYlci1SV9LfPN05lKXRvygjeF/dKLfMFLrF3VwM3p4NNFkQwm6nLHd7nkqQtdj6Bq6P0EiGGhjJNs6jSXIUm+1kPjv2Euhf1k1OC92gcVCDrIY/6DjeLROMeEDlDPTIhaI8sR+zJZNo4tIxjgPes0DLo2qwiUKhorvU5EmOKrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(8936002)(71200400001)(19618925003)(4326008)(33656002)(7416002)(9686003)(55016002)(66946007)(76116006)(478600001)(66476007)(66446008)(64756008)(86362001)(54906003)(66556008)(91956017)(52536014)(558084003)(2906002)(186003)(8676002)(4270600006)(7696005)(316002)(6506007)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hA8+VzTCyu88zqp8ByagDd0VV9gn8kSx4RCMDL80KLf+qsSjq+JJ+bxL7h9DgMh0ZwH1/Hhzz24dfWQK6FvSCu2N2pODdFcZpmexlWvb43BEP7St9yobdcngjk3Lx23YjM1HMbAHTeBb0P7l1ZVhUM0+3BzwYQ3epRmAQhV+fdYJtfD4FNERaTCynw7pFA5B0GmOG2LWvsgbGA+FQ28CWZwmZ8HSz2yVlxB7oMiEt4oyfqDxdbDak+pMRivWO9tR1DX1RHpX1/lRr/ItsnPk2dguWy4anHW7zaImw/O6IIZT4sv3HbDpyH8j3bFI+Pi48foAdx8OazbcByGmP7l8WbieradKMX+tM+ZGCCqcwEW50guJ1Vnjpz+t7iXwUcvB3nW6FTXSjv+ERovMxV50QWObbeA6ZNDNMaucAYyMMejfC1z6KRC2TbfwNvBkfeynbCLY7kQj9a7md0DpP6tNT7E25J72eXrv6hhVxYOqxhvsNZnxZg1FpUlbkL5GRDCxaFgFofYR3IdLVebcBnr50AAiTO/o9WggMNLecfIc+ppyFZbur8YLgkersC1lMcL9QSzbG213UNIp6RuVTy/+FJlzDX9Gi27/XvknejmLj8VqY07T9dFYVsQZPclrWxlG0L889mu5DAIedBfF3TaUy2uAMoLTbmL2OsDxEH7c0w+XTm9Hqpv7dBhgiDMriKT2BXIVJXnQfgXxZHOaHgeBAw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b730e505-bdff-4d92-45ab-08d88c667bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 08:38:26.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUJKjc+O7Uc5n1gkeDg58OBnuesd0SrFF3yd4avvUfbb7H6fsgi8DwfU5idErUdSk0MYdyD7R2wm2ECOP3+WegiNVulxDiOK0nUj9qsmyKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
