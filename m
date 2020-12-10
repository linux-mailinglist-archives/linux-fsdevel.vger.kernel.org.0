Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFD92D5114
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 03:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgLJCyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 21:54:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54775 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgLJCyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607568881; x=1639104881;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MCgH1jCCR8KudmYrnq2y/xebOG1q2/3Kl6jj1eCK0kg=;
  b=FPzvxO3pkOznxMo/5V6Vto76zj6LsWj5qkopPi5xO0ahjTpHiER9Q640
   0yeVxN9vAGcfAGvp59LvexF6aKr4j55BqaAmFFGIivoyftLy0G0SDZoBi
   Gsq1TiWib1TXiYVLJVSb+pgGJVPaB6s3M750VBzGVG9GAI7t8XpdhswVH
   w/pj9xtM4YcNXkSdl7NbYY+xFfd4TIVu/PJoiYgqgqflNwcQRXFngJpts
   1h4vENc3EA6CcXwojaSa3WoSsbVF+MmEXAluVXa//LlsCe7U0JcLTN808
   L8hrtl6rPXLkj3JTtBrHmRIQnOuEAxyNS5D9+qyiR6pxfK96fySLUeDK0
   Q==;
IronPort-SDR: WW8owUP8ycyMaNTzKLTO6O+LTzdP9PL55Eov9tTGE8d3BcsE1w8p3/B1T/rd+GO2bsAnlLTDvh
 Bo2mM45JbbGnVjhBNLDMWfXAhNZ3R3+YMs3ajWRa2GYWs3zKGx2v/gZq+nCAb4gYpA3fpSwE21
 EL10xfXyCKJEaxhHARit+/CiDeOzA4FwIvUQXtcOGlDKq1EZWLSSiXH8txs2GKObp2TFc47/LV
 9NtjWQNhPZFTFT7J6et9O1nJU+jTnlssYvhQKGmefDo4BEBgEM3CYqBpqT1q2hRdttpFbM0QtR
 ukg=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="154810714"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 10:53:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp7A1h3WVGGvQ5mGKyzfiMKLkpXhkIvekzoIALP8il+Qb7NNK5i+rP9t1AKZdylQx6hIAxo2E1sT0UmOV973Ce7IJ7Vbsi/wRo1n32FXcVxCq39bh75NrgFtP9eyA//i3C+gsLDrQtECJ79xxVyWDopW9QNuuISSC8y8prjPT6qSZnZhDHUxk/1MUjovGHoCPnntKcnSi8Cn5vag7A9AHWfi21DFJe6RHZylB0OhB3zO5H5qpYdp0uYmsX8VZKUbEtK3ghkFtfPe9pCYyqcImt+ojNAN64WPRrLYScCFPjUfzumFvZOESd1KPTjAqunrNpHJXJQqx2BIFC46+hUnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCgH1jCCR8KudmYrnq2y/xebOG1q2/3Kl6jj1eCK0kg=;
 b=Y9NBu7khrwK+aWvhUqs3jQ4bYhAMCPwC39cbsdYHecAsSf8rH6nJnnR3CYBUns/KHtTXuReRG5Lm3lRPU/QLVFtQ6HimG4bV0J4Q5HEhCumJW4AKxp9OLoMf3FCHoiKQzPIXLyWSmFn8jFcCG7wGZVvmKA/QnYWXK51bl1DHkLbT95NW3/PCaCys6dG9P90uVkJs+NESpfYfxKTwLmnw316XDHfNRk0GiwiNIHkmI9MhroFtUAQ5Y1PC8VLub8mO1mLWujNBqinBun3Qhh9IWKgbtYqd+tPX+eUmM1u7f7uHTtLhZ+Jet4m0XHBgMHYYBdxFtojgVUIE8fCSHM3gKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCgH1jCCR8KudmYrnq2y/xebOG1q2/3Kl6jj1eCK0kg=;
 b=LtVXd8kITc/7HkwLpDnDQ0ocm+xNU4ayR0TADOUXnRJSv0g9sUjj/4W/aqsuUO1z3Tdf2o5l7oMb1gvEc1n8oBf5zBgFL4ZE/Be/M8UhBIbb/l9rhYMudv44UrdEnKtMmDfuKpbgN55EahmXYtaUeXi/u+Qp8WkpTkj7GLn4OP8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6899.namprd04.prod.outlook.com (2603:10b6:a03:221::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 02:53:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Thu, 10 Dec 2020
 02:53:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] zonefs: fix page reference and BIO leak
Thread-Topic: [PATCH v2] zonefs: fix page reference and BIO leak
Thread-Index: AQHWzpWDuEsJFUUV00S0T6HLSBrBFg==
Date:   Thu, 10 Dec 2020 02:53:32 +0000
Message-ID: <BYAPR04MB496596DD3B8B7B123BDD7DB786CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201210013828.417576-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1feb431-b34a-468c-f574-08d89cb6c820
x-ms-traffictypediagnostic: BY5PR04MB6899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6899746F6401ECAEB4DB9B1786CB0@BY5PR04MB6899.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPW6d8+JWfToDUxIEpLvMrX44KanmcGa9CbAPLq+93MwxWQINoeg1eFlyGKgQbbFERqXbwzHTJCbwYveFHR9qW1QMC5zm2lqw/C3pjzg2LSxB+GX9WLxfJ8QD1GlZ7p5On1eifQ2MNagmSqTvKqa/2SAfPYzUigOBYyEiEw5fPqJ00vo9uOmkXiNszxnyiVI+ZTFZVWyu0ORSV5usr9L2Jr5LEkmrYVrFa2WknG9fJtn0U4SghEAlzklXqztPcU5E7YpxJlAFHamEprljDykX3BptdXY1nn+cNlO/aBz4c6A0Qh9sP2zEE8YN9E+gKTa5lUMddhJ/xjMuyu3/1dWOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(66446008)(66556008)(66476007)(66946007)(52536014)(4326008)(4744005)(186003)(71200400001)(508600001)(26005)(64756008)(33656002)(83380400001)(2906002)(86362001)(6506007)(7696005)(53546011)(5660300002)(8936002)(76116006)(54906003)(110136005)(55016002)(9686003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?85mr9Wd68u2W0FyrZmmQJ44dc8U0nsjYKe4l89h+a12sPANscHWIqdPDadBA?=
 =?us-ascii?Q?UNlz2fGQyj0+w6FxYiJBw6eXvbcLnsdxkrrDwXBCSjcmMDH2Ra/Y8IDCYhsR?=
 =?us-ascii?Q?fwObRpZOPM3gG+DsJfC5G/EXHICsgPO8OFTveQ10k7vkSweLBIZiRAFMiLBg?=
 =?us-ascii?Q?a+yvT43J8ViPJm4PnkEoCiUBeKjv58jSyzdPfK/xkZvImqVjP6avV+Bk2x68?=
 =?us-ascii?Q?l8510R7HEhPV+pONqWeEbMykf/3aSLkhn/MmEUXBHE3RqJQl5WgREgyt5MQB?=
 =?us-ascii?Q?aFQeEnKQShWSD/kUdUsosem6urlZ1HbmbWm2UgSfXiAavNjg2vq/PimuuWaN?=
 =?us-ascii?Q?fUbQiz5r6nV8cNXm4AXyoazuTI2j3Zm3WFJT777OT7bRq38NI6t0eOe9oqex?=
 =?us-ascii?Q?OZPQJu8w1wKdxjmMyzzrZ4GWn2avz5GypKfBhx0Xeg1qOwxnBP6m1MK3zEhR?=
 =?us-ascii?Q?q7Rsi3ieZ1weypyfk2QMYLOC1mb2CeBlPWjud8NQyyUWHsSHgG3dCQa+Ruek?=
 =?us-ascii?Q?nvanj7TtgzsQ+X0NKgUZITtL+eqiUemTo4DDOWfMgLLb3j75csU+uNYMuQ5D?=
 =?us-ascii?Q?M5RT28yOviBvuzyISOGrUhBe++9jRNjmlQul4f/VMzKzR/wD/8OCEpGeJcGY?=
 =?us-ascii?Q?XZXTNoUNYKu+H5b5vJ+RQ72pPNVNv5W8T8FzWlfnsqzLHuFXETA+OcFAAKQ1?=
 =?us-ascii?Q?vnuuVSPWcsviaoMKESTlvzQ0ZzCR5ZPvG9sh2yA04UHvsUMnqBouQk285O3J?=
 =?us-ascii?Q?6HOpAaurZfYRaYA9y6eDQ9UtE/bv066tsFvF5bvvygNGwtZl0vdAZ3czv5Me?=
 =?us-ascii?Q?lUs4t/HGZP3ifJ3YynmHzf2FAw7EzSmPrvginW6icaJJSlOi8zIj3eStFzGJ?=
 =?us-ascii?Q?eBPcM6Iq98s3EOnMHYrAw3ZoJxp4O1fZriwg00cIZzVLjLFpU/5EOiGTnqn3?=
 =?us-ascii?Q?hUBkZu+tw8XWl4xnUyQChdi4P46l1tqohz3DKi2O4B+6wwC/p5KeDF7qGrOE?=
 =?us-ascii?Q?htQW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1feb431-b34a-468c-f574-08d89cb6c820
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 02:53:32.6880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLuAISjddpf89KF6Qm00qimR9YQQFy+++HrR2uxR5fx8Cm/7PB74x1b6vbBWW03H7YhZWeQUMDGvxfmZiOlo0m50fgSwlrbkX90cGFK2MOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6899
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/9/20 17:41, Damien Le Moal wrote:=0A=
> In zonefs_file_dio_append(), the pages obtained using=0A=
> bio_iov_iter_get_pages() are not released on completion of the=0A=
> REQ_OP_APPEND BIO, nor when bio_iov_iter_get_pages() fails.=0A=
> Furthermore, a call to bio_put() is missing when=0A=
> bio_iov_iter_get_pages() fails.=0A=
>=0A=
> Fix these resource leaks by adding BIO resource release code (bio_put()i=
=0A=
I think extra 'i' above needs to be removed at the time of applying the=0A=
patch.=0A=
> and bio_release_pages()) at the end of the function after the BIO=0A=
> execution and add a jump to this resource cleanup code in case of=0A=
> bio_iov_iter_get_pages() failure.=0A=
>=0A=
> While at it, also fix the call to task_io_account_write() to be passed=0A=
> the correct BIO size instead of bio_iov_iter_get_pages() return value.=0A=
>=0A=
> Reported-by: Christoph Hellwig <hch@lst.de>=0A=
> Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
