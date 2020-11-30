Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632932C80DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 10:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgK3JVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 04:21:52 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50781 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgK3JVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606728676; x=1638264676;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=iPiNzt6z0HM3s7QCpZn4kaWsA1h8HyiE9jEwyXIviHUWPysl8wqWtOvJ
   dmKbx1riAPbjjXmVfumNeauGNV1A5hEfPDyaqMUcn55LW/lfI23zhxE2q
   c76XP1M4aDsg5NgN1+j/8fS/cLTLGf6t+0nag9WD0j7EvS67oV9/J8Pcd
   wO+yumVHUtuUnF7fl4G4bsPJWPBy7x3toKFkr45dDvtV0jEpJ5cF6+JRw
   jyj7A1IWmzgHADU4VdP/m5iOyvByXipjbctIKna08+2lef4cLoTRAEQcd
   JthioTZ52xCHQr/y3LwRNJ7JmU5l7Ljpjmf6wlLig5OrSqtg0yJu0SAta
   g==;
IronPort-SDR: glaJzzFRbn7nTtk7W9c98S8aWKJhl82M3/co7MT23NvOJZCBOnqGx2TiV7VBXVoayw6ADWHeQM
 3fgrxezvWTk8f+8+R+Z68l+adnRfCJTt2+RYdy4+rcZcF2rFlLQnV84u7ai74jxhWwblrjVU4M
 avCuWtbZkrWpEG81gFmrl/ZFRdorolZqdYcNA/pXecY3RW68ZrJmfl2cFhqGqRl0/h/22mA2/T
 a6Vy64NlyjQ6WKiaqa9ndYC1k+sI1yTVYLJOkFkEV+5jHDqXuAJxr9uy0XI5Hw371HOPS6/qU7
 l10=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; 
   d="scan'208";a="257475560"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 17:29:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c21G+UtaD84KefFX/pWw66RfdJkED9te+aQpDl0uuBpiNGiZ6fzZzeT2fvN/JZiw0Kdb1w+ifXz64KrO+qLe8ogU+kUj5MIw5C5Vk65NS5uGYOxc4woYvZYqZ9uMn8FHZVb4nrYytMNEJ5PVjze56F8fA4ZNsI9rlYkJSWYcn3um8C2od6rDkgKMJ05ESqBabDWgiFN2voCBVnwV97bGqf27dBauLBUnYJMzKbD8iwrGuQRFMNXvTBghgm2B2WjnUmbwUTdPSciY/6fQ3eyjNCwwWpA8ZjZqeB5oX8EXTYGmTGFNdfuKtF7WkdH1UDwvCyxA7sK3IP3u0s2m364D8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jD4by/htLOmNkGsHLykleRNc6aP49G2Ek3ZIHRWAJmMicCezLQs8OlM4Kk9LCE/kXhKNsdCYg8N8iJuGdenUHVnPGVJK9JtLR/ZVgiYOfY+bVprS0Rzy1DoLr1FU3bdjy/OVmVkW/UCM3+bj3C7ZJGUGXOJGcSXDX4kTJTjyMHU5mF6p1ANgksD8SFFFymx+Bg01n3PaR6h0tmYji074A3pzgr8QqN6LPSeL+djC7w5NTCDI6+3Sq7Jc7hQr1yEAZXtfulJTj0cspq1qPv+uhx8mKDmoFCNvDHJS3ktd6FgUa6VA4oY68pSaMwZX/cNy95tIaLiWgqUDde9UpaVUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=m/xedFeaRROlC+3mP7DprvFM+Iskq8OLD8XDfMcbjT99rXQD/cq087oXi/dvqRsxig0DRoyIEEkATqoDDs4ucCnXXOe3Q32n7vAYxcP3gEUwd5CvPQDlCOrc8Zm1eUXggx6Vvh1LuQ72RYrxsHDDSarxX0gZhP7iwFPtVFREf8M=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7594.namprd04.prod.outlook.com
 (2603:10b6:806:136::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 09:20:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Mon, 30 Nov 2020
 09:20:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 02/45] filemap: consistently use ->f_mapping over
 ->i_mapping
Thread-Topic: [PATCH 02/45] filemap: consistently use ->f_mapping over
 ->i_mapping
Thread-Index: AQHWxaGyr+5b4gA+mUCwb/eGRWLwDQ==
Date:   Mon, 30 Nov 2020 09:20:42 +0000
Message-ID: <SN4PR0401MB359813D8023E2251B43B4ADA9BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:2c26:fc00:7c60:29b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 751e6574-9361-457f-762c-08d8951135c5
x-ms-traffictypediagnostic: SA2PR04MB7594:
x-microsoft-antispam-prvs: <SA2PR04MB759492A7E419B97F1D8F7F739BF50@SA2PR04MB7594.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCgbtmaSTyy3DghIPfsx4eWEPuUvYAkkK3CJMebAF9KG1fR4+wE3x/kXVotNX5bW0q+bYjUApAgmG/EtUCrR7Nzn2NV0tpoUoSg/U7RUfBmH8wL/AItJWTZnslA+VUH/6DfCz8H8/G0ZVP4LhRFX2CWmzj6GX8TSLxcwcyhYae0Yu+1BAU+dWZR3FdT4PMDqWcb1CEDtY3VBSOcMZgjjXIcwpUt/+L1FYPi3tpSMDIzt7wW6CrPxjub7HGgwuyinozLnk8t+Sr2/tnZm4amEeFnCF/0QqvVQIpCpmOXEp/NgBWDhtpMqS163YNM2wUPi/E2EOaoBgf+/OFgLr6bkNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(5660300002)(6506007)(478600001)(186003)(4270600006)(558084003)(55016002)(66946007)(66446008)(91956017)(8936002)(9686003)(4326008)(2906002)(64756008)(76116006)(33656002)(19618925003)(71200400001)(52536014)(316002)(110136005)(66476007)(66556008)(86362001)(7696005)(8676002)(7416002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JEMIQOyNoSrdWEla6GFHQ+ytsmJzhNypCj0GGaVTQKlTdAusFiwEgcrHb805?=
 =?us-ascii?Q?9D+pw3ROiXzwtoifQqR5vkt5j/eor1BfvYmGzM0a5aFnH7jThY3/gn7LfA9Z?=
 =?us-ascii?Q?MRdKgx0bKzJsxcAjjlcg/vd2us0YlEtDQ3xADuIq5CabQTTj1tuDq/jO3F9y?=
 =?us-ascii?Q?PZ8rT2ZkJP9TKZ4AoTM4lRfhFFtK/UGtpyczfP6cUAURpGk0u+wJRHlo5cmG?=
 =?us-ascii?Q?c5P4glu3/TdCQCjEJyWMTnQktoQzipilkoe5XGFZ+4/D+rTr/l3nkV3GW+P2?=
 =?us-ascii?Q?Uv1kiUlcKjonIR+Lj1W2yDInjzVAMSJ9M+8uJ7m6Ttfl0eC5O34jnuIUYZ+7?=
 =?us-ascii?Q?/hvrsKtlXEXYPzlASE+yBZ5WdARlgvGM/hxVum7C+B/71WyloD0rmslT7CqW?=
 =?us-ascii?Q?ta/sLB0XKQbhPPHy7EjuLwleytOnmgVkAB8vMyVASkvvEg0aMgFw0a5VDKa3?=
 =?us-ascii?Q?gFlPNPAQIqATzi+B7H4S0Ruijmw1Hxbb7UnXXYqLhdvafve16p8ckP07ACuK?=
 =?us-ascii?Q?lfCJrrgfd8vRJOJLMMyyJ/pU3+14gXsXJNCfKr/jCqqdHivEGpSU8Vb1nc2p?=
 =?us-ascii?Q?vetm7NckLr1ab4rf3W9DFKUp18/5uH0lwe3E0NWdFiwoU34EcYTLaLg56jvE?=
 =?us-ascii?Q?JM3NgPtrYgfCGTlvg/4+o1CSSuiJWfIq9HbQqOrF6TxdRsiTjfvwU4tPL2vY?=
 =?us-ascii?Q?8HnledCWE66D97rozQfzgjOiWcLvH0xcDlxn75g9F8jFIWQfLZcrDCSIZL5+?=
 =?us-ascii?Q?gWV2uX5+4Ogp1Y34TIqrkqLZwS5584A00PmJxlwgkgtYmTrWPPWh0iMyloXp?=
 =?us-ascii?Q?6uX9/CXfZ8S0YPP4SUEV1+Ly5XiMhElytSe7JQL24p6VvTKd01Zs7Lw0Yeq7?=
 =?us-ascii?Q?PmxmWIN1P+Z9bBfS1YAAx/ueAlCwhR5lF973g5hFz2k6HoMmv7mIpx4xBrng?=
 =?us-ascii?Q?TUBtV8Cea1C7RZuvbz9INhFrUci5ooKh0czri0/4gYzI7F1JhMu4TatErG7R?=
 =?us-ascii?Q?uW/CzK7fBBQTHzq1wA+ZLrMIBObJ+y7Ex6gvanDWiKhmuw/5bQeZ4592PTrs?=
 =?us-ascii?Q?cVFYZFN9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751e6574-9361-457f-762c-08d8951135c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 09:20:42.1141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBHBHbzgc5hL+/yxra90vBx/gdwLCOM8ei9yMZF49qzLb2FzdrakCUEatiTS2nyTta3rrhUlGMrK6vr7zKTmPzqy4pBvvxKMLgs5mWN5UVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7594
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
