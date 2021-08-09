Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833573E47C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhHIOiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:38:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5139 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbhHIOhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628519845; x=1660055845;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=IPN1pzxctyYC5S1XBcxyQNi/m4XayLfVwXW9rUgKFMRcdJrWNyhusXaW
   9XFZuqtclJMhdp7p17cBwOww0e+TiSjxpwElJQfyVMO7V24v6QxTXJWMQ
   Pzw8oL4svmQpby9HWPq2kRj7nmZkSPDRdiik3GbeNJCDT+bzTengdN3xK
   hUJZwigZ7TcThj/LXGxXZZeH2V97i2IQYAVcI013d6/+4SvhtFgViwKpE
   Q8iMTo+aPjodmC1mCdUmel+LNaRsmq5WcK2AD/pFOZcM7SB7yzBBqGAuF
   O+zvud1Nq5ghNiqqsec/80EkLoc7MUcoFCdz59Ke+0QadolC7vqEkkT8H
   w==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="280533723"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 22:37:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Makv22MxE+ffcUX6Uq4K6xmGyw2vcMvBZPo/63GpFuHssnHDeM3Pd1/G2poV1bPvocCLiUpvW3c4n218/edZjidm6LiA/J+2/DXO3ZAoWwjNbi/vgncsLuRyNqZHSNi89quNNZXyvRBhauf8ffOmdzVg12Gc1B9MlLqpKJswdicyKfv/Bhl+Xa2QmN5+iTUN/u4bgrrp0wfenkcNwiNPUcKn2mD6RUIqYAR92MX1AieQmyVJKFX+rnCMzYVyoXqQXNaStO9Q8w8dI4TskSFJpfL3Z47CKuBMStoVGYW+bhzJBWvQUuiX7O9cvP+TzLYxz4Hi1RuaS3JYZPpNw2oG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Qe5XdbjGZlr1zcRsJ4VIPo1/y1zi6xOp3BO9fxjKlsbNpRKiAu71G6bj24OLfUiU+3pOQ/bIKUGFDEtlC4Qggyprf9guL7Vl2pkvZCyrOHCJTi55/z09/K/bMUNUcEZGwlGHUiakDtZTt731qscm83GfNTWcxo2gBv6p7OkHPvChQDRPPVh5yKy+ktA+9xVQaO0fZNEG3gwl7LKga8LhoxXjRBmVl5v0xM9oo+tVaOxccWhdTLG6By4YINcP19JKe0vOPnkQLUTkvMMR05BLBfMlRpoei6A1g2D68fxBCzjJICVNZK5N5V6aiCsWTNTWYjOeCMK6Yb4IHuYT9k19pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qL238W4phnzZid2rmDxNjfcmEZGxlH5Xuz65IsuZJvrHgSCXT3o8lTHWjwG44Og6zyDN7B3twfi4wJq+Mx1yFErrn01GLRTtIac+jP5ol6qL9R0FoTivUkKvEA8iZ+q2dCKdQvYXSo1/gbbUg7NOGFd+b85uqfcScCFH9LS2LqU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7176.namprd04.prod.outlook.com (2603:10b6:510:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Mon, 9 Aug
 2021 14:37:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:37:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] block: add a queue_has_disk helper
Thread-Topic: [PATCH 3/5] block: add a queue_has_disk helper
Thread-Index: AQHXjSnOdysBShbFU0OZNjYfYqw0DQ==
Date:   Mon, 9 Aug 2021 14:37:21 +0000
Message-ID: <PH0PR04MB7416972333C98625F217B2419BF69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b3a8c22-c29d-4e2d-ad28-08d95b433268
x-ms-traffictypediagnostic: PH0PR04MB7176:
x-microsoft-antispam-prvs: <PH0PR04MB7176BEDE1ED5D189427E93999BF69@PH0PR04MB7176.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uepsaoFvV8GsxUvm4V7NIeiWs5054iYwAyIKOv2jG5tZQ8C7XExuGD1jqIoVb3fzRcuk2UgUZ4zchGm0gJ8d3YciVm4JA/uGf+YX4VFsugsSBh6ietrz3CQ55MowyWq5ofyAv2Mz5hmzNfY65oJN8WInJ+fxYV97UNpldUJPXqFO6FWrT0v4RZBVDhN8mTz93pY1KNUFT2NTwagZ+Cct7EGVGKlanSWq50Q/h7EBciDV6BbUWmSaLju6Oz5GM/ghADVGj4QLqikqeAIfYRsG5q8WCoxiUVURUuF98XIgrk2Vtr7G+b+dfCaucP0+zXj/RUQKRa+znDgR+dwI7i/LrH/a3dP4UnELN8hUwxbgi/izRjtKYvXHnbHOYV97XiXWBfLMzfVy/OSJfXWPzF8ezZtkpzY4SsdyS2ITgZKz8sodZBVNBk+3jOgG0cmpqP0og/9ORe5R3DE5KDGs8P/J4q+NMTq7d1gV3zIs/Da/0jLfSSmdttPonqt1zKKtWYhjF8v+bLqmXgpcPFSEEIep49H1480Y6l6aitOT2LQ4PiEJO4D3/PRcdpJ9L/wWh6vVi5hCb3s4qgKCC3+eoi8aj1qQl3K6Vz9H2RvdzF/HQd2ZW7M0sISkdFIDbGRj4eanopfqr4mAmy5Ejdx6tEH6QAw0IS6E6HPAyrUXwRZO3Nvt7VeTwOfwmzXH/M8mx8nuKg+PQEMZ397v+uxyY7rR5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(2906002)(7696005)(4270600006)(52536014)(19618925003)(86362001)(186003)(54906003)(55016002)(33656002)(71200400001)(38100700002)(66446008)(5660300002)(66556008)(66476007)(508600001)(64756008)(76116006)(558084003)(316002)(66946007)(8676002)(38070700005)(8936002)(4326008)(110136005)(122000001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8i6KLbXv+p8BxYq+q2u/jztOiySGOzqH2vts2tKtV97xpnIFohoCtDQLpn/c?=
 =?us-ascii?Q?zSzXwWA5bF+ZwZ8NUFzVSYgQsMa1w9OPZSlWGSDSutqgatvWjLjux+vCeuR9?=
 =?us-ascii?Q?pZrdKFGIZcYxoVs9nPHHn7Bi+vReu5EtcKiY5QOuNT5b/QTFCMHbKqo9WJPU?=
 =?us-ascii?Q?HnTzezmJiqeSWwnqGaCeMsyZtb+KC5p3U8rEbcGPi16ttRcYpxi6D2zgp/r9?=
 =?us-ascii?Q?5Eau5XuZwBH7d4QF5ImEN3loXThqyZEnKVuOTWyGQjaX8PiLKHl5C8Bq1BTg?=
 =?us-ascii?Q?UApbdMpQzawi0Lrwh5080Rg1/hNXrx9+Q8XGKeijqComYi9AHh55Hg2rYJzq?=
 =?us-ascii?Q?8lS5H+5QUsSB5ogH8kBXPqEsihS0J/kHdym04lPKyuHav+lCL/6h2vEwnjBV?=
 =?us-ascii?Q?Apr+6aliU9N8HCgYgwC3jqzaUVQ0yOKWCDgZuu7efcvwC0K0bib7wxkj/LaH?=
 =?us-ascii?Q?2dDZGZF3dm4EPrAZ6w55fW4PRV4vFN8QeuFasGukmtnrftV9sGZ7o1fw/fx/?=
 =?us-ascii?Q?LReaRw5Ryvyaq+kblqEZLqKB8+ggrQMoDnHa39GbAgacNut+LET6uFQbyVDF?=
 =?us-ascii?Q?zq2XeH3+fke+ChFP8O0SLZpZqkPUMLWSHXJG3Zz1cPfqfULX8mDOo6UHaHHJ?=
 =?us-ascii?Q?N72qMRbYOr0PvQt8rCzYC9VT7NqnJuVJoaxn6Laxl6kBlAnC6+lhOKZZIUhX?=
 =?us-ascii?Q?6OU16TU76/89DuGU+49XLrWgKfBtv7tQlRWWkwmtPrqFekcK5lZ4yN50H0/G?=
 =?us-ascii?Q?XglHeUuFytqLFWIeWPvJKEhR+FC3XsLQMiV62SGWF48VJemrwBstEnXurzyd?=
 =?us-ascii?Q?SICnRDro6zGN9fkFhD/AaowlnHfjc/MDvrIXJBw9ETbbACzWy9ECIgMBFD4o?=
 =?us-ascii?Q?6WKgToMg4+3GofuHbKst3IFqeonTQQrsb9wG+gRt3F7iJhK70mdNftoatbcr?=
 =?us-ascii?Q?h0k5mbjypUf64Ytui1+Ti165BX5RqEgaXMR1EN0xWigkAf17uZg/xRUFu1sQ?=
 =?us-ascii?Q?ZkiHWFbHFcP19R/zdS+UJ3K2ZS8SWX88lmoh0UxBGeBA8xJUt7jVpJzJArm6?=
 =?us-ascii?Q?DInEwEFnJsEV64ywdn9TOwfApTGFCl3TkljYBMaziLNC5aON/T2fQzjWzY/A?=
 =?us-ascii?Q?kSbbS9oRm7J0JgwrQFA5dLjATmSeEKhygDS937Bwwlz65aQfc9/V62NRbjTx?=
 =?us-ascii?Q?STcQLW/48pAqFc+2bcTwHJ1YTb03cmJKu9bYOrDtmxxjM732x1dT0hHBGI/3?=
 =?us-ascii?Q?P/vq56oKowTM7gx/i2/y2FhUf48z0wy5wPHbhh9+exV0YtUfhcMaZA9jUyj6?=
 =?us-ascii?Q?JDxDEJ5HjidvwmzWdV6P/vqCzvekiVeSJDZAwlhPvWKBC364R5fMOrnSba8N?=
 =?us-ascii?Q?kZzGGAWw3RvnnkC96PDQ9MtKJ9KkjUdUbPCMcDUAkgA8c3KCFQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3a8c22-c29d-4e2d-ad28-08d95b433268
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:37:21.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b46CwMa07D9Ebw7jN5n3DQTww4Tydo1tFdVAF8bXru5NyGusmd9PmIafEr0u1ci2kecEq5Iaa4mr2d0dZm2QGxNvsxcoYtllXd8janRJUak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7176
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
