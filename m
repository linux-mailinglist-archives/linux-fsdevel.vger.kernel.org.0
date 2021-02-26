Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58BC325CB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZEtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:49:50 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33001 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBZEtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314984; x=1645850984;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hGf47k8GvH3vu27nRanO1J+2rNck08FqQKDqsJaSWpQ=;
  b=bW9ZtHJth0Vaxk8a9I+4o6czfR0FtDyMZeXA3/BizGHcYvLQd0jDyPxu
   vSJY4Fr/teuiGGlaJROccRF1HT4USw31R+wPMqC8f+JVW7Cwte82BKCXk
   yXmfhtx2cfM5Gwf9E/hpblaycq7sHxfcuZsIhSJcUF0fVOeqSwfFp6v0v
   twQ3GEpa2QLABMJfpWjVZLkCeV4fgcNpsZ5LNbJ3mI/Az3b4Wr1IaO1vY
   VWyvASJrgscG7QicUf92HqlnZg47Td3FWP11zoUh1DOy6llKuIeP9261O
   D5BwLewIUfGXTilO5/Y+R9BYsoB0iymR4GlnGvQ+sz0A18fkFaV/1KRnz
   g==;
IronPort-SDR: ZF6J37P6KLV67PbdbxevoGo6g/BtGBMCa5VX3jJCrdehQxHjOi2dGFcBBgm0R0+e7cVIq7E6Nh
 BRUmQWp+IuA4zqaKNMcO2HiaiPdh5kvA5dPJzBfz8VqHt5Jlf+WmOjzWtEH56rcVVSYvgteDHK
 ADe3Y49M93OCyRKbe7m51I6+DxTJBfHgae8EMc+s1dMCXFk7N2F0vUUzgY3LjVV5OTDIg81YDF
 LberXUoQzT107e00ePes8W5rgiY4iQvUjcmLGuoE9JznHkNigNKM86wMOSyGfr4xV7a9bWzPZB
 3FY=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="160844422"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:48:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUn2ulf/thzJT+hkGh1kcKRKtetu30smJbJdrnSJFnMpKCYu26kZMuq9V2j6qE1iTT+h+utXUnMHHrc49knP1AanJyTTBJJ22sFcqrKhuXkK3ls+w8rsTW5PrmAP0vcoDSpCO86mpWgUARmiIO1zIZOTamLGxAqK7Okn6oac51YhN/NAS7BdzD3e+RLVkL3hPNTh/oSXKGG8hz4gQLt6s0vNa1ZfpWh+taTH1OY1JlVaUsem74Zeb9l6MdA7fLhUk7rhmwA0c+yiBuFanDfLCyewuLprbMirjGSub/WnK6geXXNaMPCN/ILiHih+w7RwRKFPnXd9EtPkgwXTGqw2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4fpb/j1Y5SJdf90eecwMLB5NIixNIlYinI341aOc0w=;
 b=XMtdYP6u9lSlub+TS58IW2gXKaMHjNUger8X+/rFpxOE03DmqHcBq83htR5bm2Ysp2qy8745zES5+b1KhV+WjSalumdfn+s1hA6v0ygVrt4vRvFnGZ1/CjAw9NQwzmFrJU0G0g1Rd7VcKrLfrGggBmtQfrFrwuAsGJp7AD10mLKsFqjVX0EvGprs03fqU9FwZPJg+zAt4cQjS48UN6O9OXxA73nXkg8GpzTi20lXgN9xlpgxGbd9Rtw1nUQuaYcyTfe2SlXbH0w+cfubiAdgg4ADRmRnPcqkN5+9lhsAh4upCa/VABFsQue+BtBzzBvcLLn5nBkCtHaQOeflbWOPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4fpb/j1Y5SJdf90eecwMLB5NIixNIlYinI341aOc0w=;
 b=cVDgL9heB/TBDtp4fB8J76VVqXZSbQQ3HRM9g/FW6VWaYcLBnxVLrEPKZfnZxs+I+EmJPoMyY0MTVP4k2dW6ALnmMq4WmQpQc1NoIJFXZTaqO+CoaiAfziX9+tbmUk6xm7w4dg/iQoBWj5ffRr3Jx1zZvuc1OzzRk/yRmE17svo=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4643.namprd04.prod.outlook.com (2603:10b6:208:4c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 04:48:36 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:48:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 11/39] blktrace: update blk_add_trace_rq_requeue()
Thread-Topic: [RFC PATCH 11/39] blktrace: update blk_add_trace_rq_requeue()
Thread-Index: AQHXC0R2YFXMZZq1NkaOo2SEBczm7A==
Date:   Fri, 26 Feb 2021 04:48:36 +0000
Message-ID: <BL0PR04MB65145BC6CF7944B0856E8CA9E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-12-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b5aafba-d493-433d-7a6f-08d8da11c776
x-ms-traffictypediagnostic: BL0PR04MB4643:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB46433A5F80E4C4C0DDE2869BE79D9@BL0PR04MB4643.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4F3zn15MBa0AV0MD2dlPLTeSlux29ebYaeRbzWEu8ZF5FMa+AnwuZZkhlAwmNZSMLQ6iaNnQ3IyWHbOr1uH89cy32Nf4UGVHQXXCVzWV4g/5eOU6br+nzOtnw3k8Y0ZvArVRBqflna4DLAV2jmZxIb1qWnT3G1ka5h8ZLkWHcDKGVlkz7jGyOJQsNiWz2UdnnDN8H2t+IZyzzPMI6EGoDeprBB6S4MgUXkwxlspbvoXHnrAoEuo/m8JgJPG6WUjCKdmxbUnolcxq133Tn6m9ag768XQH4Gk0XQt0VhRgZgbo+vVXT8BPvk4j6zpbJbfkD38EsO8qYVd4WWehzonG2LPBWddhfZIBbwVmuF/kLvQjvajXszZ+GunilXOzSyMh7bLH29pSWaBq2pX6p+KknpiyBDA2PyCBDV4sQpBIUOeDt2ItDNKw0lZCipIeUckLuK37WQnSf3VOEE+Is4wcUohs31QUFldSnktattl4PGBJ0OHPN22iyaKVyzZLHSntGfIUB0jT5YfjjOuMhOTaNVcRO3ybQPu0CX8YvZepQ8kqKx9qYp3r/x5ut5hlCBH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(55016002)(6506007)(33656002)(9686003)(71200400001)(5660300002)(2906002)(186003)(53546011)(4326008)(66446008)(64756008)(478600001)(7416002)(66476007)(76116006)(66946007)(86362001)(91956017)(316002)(921005)(83380400001)(8936002)(54906003)(8676002)(66556008)(7696005)(110136005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NytnygASG9Y6JeMc3vmuMAIAs19pUi3jK6E27oJlVDAwKHkLxEH+rU+AUr1a?=
 =?us-ascii?Q?MnrR5589Ve1uLveaTvTtdc0D1Ld0jEivE0NzN6wtOqj8FBEQsbqrSeXZkNIT?=
 =?us-ascii?Q?bTQDw4L0dW0TCt6s8rVY8e49OXSIa2bGR3GcfBJSEp7jnNWxEpgvAvScVVME?=
 =?us-ascii?Q?h0OjDGka4udbY2j9GjSb73oUVULekffMOPhXPfhGzCGKWJ8r0UQfCPGEsb1G?=
 =?us-ascii?Q?0W7Jkz/6PAimSRH2kRWiLbYlJZV+e736KnVWBDm/uSfDtr4ZkiRWBT7sFvhc?=
 =?us-ascii?Q?SZyupqYfvzCRCLrdr3h75UgLwQCWJJNOTCmJJsv8rUaoAYUA5DrPLn/CK19k?=
 =?us-ascii?Q?yTFDHCLwMtijmLfKHfiaO5qADnYDdzNZ8XAYPQT4nM0uiFurge9YaNs8f0WT?=
 =?us-ascii?Q?4/fsoUmeD6gpej1KOMdxAjzMktuFXpXJOMCV6hYrYVxND27eJpU2Jp4oCIN4?=
 =?us-ascii?Q?w+gXY+5SQWRVh2ksFvLpEsKkK0xNjt0vS3WEcYCAlycPRSGiMbvuf678ldW7?=
 =?us-ascii?Q?7FAlOdMzMlUy+pSheH04xQeABlGhnxyOJWYU1y8MzyjsiNvTHaGNWvsPrk9j?=
 =?us-ascii?Q?kBoAI6YGxGBgzZ7liUCrEqCzW+KBHYeVI1SW5PoCboQNzG+June7FwJ35WK1?=
 =?us-ascii?Q?TMRnDvafab1q8Rl8ssfkZa+PoU44xHWrBqASZUVJOnZc54z2MzX4YUlsK99R?=
 =?us-ascii?Q?dfiYwXiRmprJH6e1eRnpVtsuvJLVXfonXqa/uImx5EzEsc9Q0YF/gfxQf+Q/?=
 =?us-ascii?Q?iU6v9PYtQ9DvZEbIqiNO7fnsGXeKbomuzJ9b4xWxui/GOpZ8UAymqbT3fY6C?=
 =?us-ascii?Q?50cu06c4QVH1S1IjMoinkh7WKghCB7Vw3hpn9qGDjbAGjp/IKojlq3WBURfA?=
 =?us-ascii?Q?is7kHC6E1qpHhuQrl0BfjSZy9rZC1ES0rCafyHqFib5XK06ERMw/noBk0wFl?=
 =?us-ascii?Q?OoNoPrNIdhcK3+Ce7352ObUYdbiN+g7OpZqejAk4snTVbdJoXEjhxtcoMtdu?=
 =?us-ascii?Q?x7UefH0vo9so31X9zD6om8Us+H6Y4bhgKP2IdiNk4pFoB5owsFilhkrXQuUv?=
 =?us-ascii?Q?94q2iSNO5gzwro5yA8yKTX2orj1EuYjzhIaJNURUGrPKo6t1Tqe2J9R/btGM?=
 =?us-ascii?Q?QGa0qCSnimRkESsUrnwMwISDZ/USvDe1bV8jjUnfYwanosqBwU0qNklc4fGM?=
 =?us-ascii?Q?f86lTon0XkVbT4LXXRdUj/uP8wiU2XswWSfN249EimrdxOY0pjcDuJrY31OR?=
 =?us-ascii?Q?yVqNUUP/BFF4p2che5m2rXOnKekilg7Ww7woVH6xlnJ+5TeY4eV7qGQvVo/s?=
 =?us-ascii?Q?MEw3FmrGs91uIdKBnRha/+9NGNyB6HTADsO4GLaMCte7jpRQ5z0TvOSm+BQ1?=
 =?us-ascii?Q?FK/NyNvD0aTaA3w74lVw7tCL8/MxDVKr/fA74q880GbW/WhQ7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5aafba-d493-433d-7a6f-08d8da11c776
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:48:36.7380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uR49bMe0L6eqw0afvj6kNuYJiyH6NKJ+0mOMViVl1/zL7ZME1ClhwI+Nc/u0gon+ylQungEkURncgr+YWfH1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4643
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:04, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 20 +++++++++++++++++++-=0A=
>  1 file changed, 19 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index e1646d74ac9a..8a7fedfac6b3 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1188,7 +1188,25 @@ static void blk_add_trace_rq_merge(void *ignore, s=
truct request *rq)=0A=
>  =0A=
>  static void blk_add_trace_rq_requeue(void *ignore, struct request *rq)=
=0A=
>  {=0A=
> -	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_REQUEUE,=0A=
> +	u64 ta;=0A=
> +	struct blk_trace *bt;=0A=
> +	struct blk_trace_ext *bte;=0A=
> +=0A=
> +	rcu_read_lock();=0A=
> +	bt =3D rcu_dereference(rq->q->blk_trace);=0A=
> +	bte =3D rcu_dereference(rq->q->blk_trace_ext);=0A=
> +	if (likely(!bt) && likely(!bte)) {=0A=
> +		rcu_read_unlock();=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	if (bt) {=0A=
> +		ta =3D BLK_TA_REQUEUE;=0A=
> +	} else if (bte) {=0A=
> +		ta =3D BLK_TA_REQUEUE_EXT;=0A=
> +	}=0A=
> +	rcu_read_unlock();=0A=
> +	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,=0A=
>  			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Same comments as for patch 9.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
