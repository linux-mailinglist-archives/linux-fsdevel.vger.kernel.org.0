Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7733ABC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 07:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCOGrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 02:47:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23344 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhCOGq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615790818; x=1647326818;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PKJQA8YHL/ypu9sSVlBpdGCEVIrMx2SEm1P1X1iQhUM=;
  b=ZikS4q1Cu5WIwuOh6JdW4v3JRkNGAukF0Eunz9i6piuLi+v/buHxSPRJ
   Ypl7S0oMJdGwYZYGwHamQ4N/+CSTdeujUku21P0Y541o5R/Xji0tQ1sGg
   lCFTEZjmBYkXURyV0fEBf+8+v0abh4JllNQSulAmLLBN8Dt6tcBaK+btb
   HVDOqv1/Tt5sJX2NnBTfWMyqZrze8tYU64XGCn6EI/FEcQKi8zpTKhEUV
   ybZN69OwK45GvMQ+Tmpy8VYSdajP/ITJRCotf7Mz61QgnncPq3mk/2e65
   a9dioR16mBQB+rthj6Rry3BD5awpk8ZX+Sy5Gy+4zlYxJPgOd7p79GKGp
   Q==;
IronPort-SDR: jU1MuE0H6F9aG759l34+mLpFc39DAbZMq411jE/ovuwvqacq9r/KZf6nvnTwgJepCjTnqc1cO4
 UQJoYVteXMxJ7jCU9PsqEBY6bRkE3t+OeL92GQ5y96w70szDUiOqVX5dU9+LHFzASViBRXhrjf
 Htq0jMFDladNNdwNskiNZ9q6mTeHE1+faq83nPNq4hU2SVDng6ypVOOM7Xwazcd2YymC4Xw/Qn
 3bkxH6T5JEVe3z7zAD1UvGN6g84FU8MkINU4hppJmEYvLpuG+sUclpUlJNhFOA+yOBii3iXQb2
 tXY=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="162156360"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 14:46:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh+wR55toiS3hyZutjjleaH45sBYNhoQNq5djF6zvLwaYMs1XXXLPQAuCEL94tcbMZm8tnghGMdY+izdH24jEFPpLp96S8H9KN1uG+Ym484sLJGRX+y9fOdIb4b5an7oQT0OF+qgG0Bpt06pgU/qlYsDyu+RMyRewRWMKi8+E6M2QvHtUikW7x4JWoRRANHnfKUP22zdsgoK38hiOmz1dhe4sj4Sbl/gcDJTbh0DSQoF2YKcv4FnImAuXblBNC0zcYpb9uWSaxYpfABn3T46CGCjiH/PAeTSl28KaAWNwFs3UQx+Tgjvq8GR2xJfdk2FS7xan8+p5fjQBvke8F7W8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKJQA8YHL/ypu9sSVlBpdGCEVIrMx2SEm1P1X1iQhUM=;
 b=h9Btdi/eZ+AB05fF1u3OTL6hxsVJO8yOGE4OQ31b/8mFmLEJGwCAoWSwK9Jb/7e4tbVe/Xo5tNqctkp/6yo5J3NJPOnIuPwIypv5wMnv4t8a0QvxZuylsHz0uYymFiZOX6aYTOMrpNVjpADeGxY8uikLw+KUE1CYHvZcWoXZAfp7FKQwAyM5UTtAPlJYmALCnvRe9QCldiPaG+gmvKLW4zLvl+GxDXgzkRIjRWL9XDeVNe46m491fT0ja+EXxLZkntFlG/IjGtGYLVOLe+KbXNULd+LouG8PE0Y30lKc99Ets89tyNUQQ2AQhYXtaM3qpFT49ZpffXmoGv6XJLuRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKJQA8YHL/ypu9sSVlBpdGCEVIrMx2SEm1P1X1iQhUM=;
 b=m/gXpk5fPLoGkuhHwF8CJ1OvLRMJXxUqbwH4zEmqORlPcA3xT0dmeVsLBt9RrAQ5P9QCVJg8EXoRVQOE7FrBVm5MXOxYx/8EaWMQ1bGdkw9UkS1oJM/yrenKPu/otNEUMMf4zd6mLfeyW4dKDhPDJSQa5VLxWohZm04tyJz+rHY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7734.namprd04.prod.outlook.com (2603:10b6:510:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 06:46:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 06:46:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] zonefs: prevent use of seq files as swap file
Thread-Topic: [PATCH 1/2] zonefs: prevent use of seq files as swap file
Thread-Index: AQHXGU4w0q6lLwnOrEikLo692WiJgw==
Date:   Mon, 15 Mar 2021 06:46:57 +0000
Message-ID: <PH0PR04MB7416B66AA60FAAE2B48CCEBA9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210315034919.87980-1-damien.lemoal@wdc.com>
 <20210315034919.87980-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:6d29:9a36:82c2:4644]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66bca69a-9d7f-40ee-f443-08d8e77e20bc
x-ms-traffictypediagnostic: PH0PR04MB7734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB773403068E20A9344FCC1A679B6C9@PH0PR04MB7734.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9iS/IBIjtgiQ3g4G3tXLPJdUl8zfMxdZcoYshgJvjYoXonDvj2BZsrfN+3HWjl2YCaFyRpC7VYW+2x9wa+HgiGFnUg4y5aJnZtv51Fsj3qXS3ZvT8G9GD+bSRjzK7zEwnDTdAa8cEHX8ThAyLbzOijtR/VmbzNtX6K3tmnyPYMBzKxtyMp2DaX1IgX74QR7R9Ud08MUDVRdGXambS/qcN2H26URoMnI56pSAyxyzlrUritITiZD/aIpaupEeukODzUKd4TjvsAYyM6Juwfv+r7EiUrWaEUVYMs6Y5ydd4fuGCFgetEMfCbnKQ9wUnOM0aLjdtMomeo8KKsF5KeCWYOOVILjOZ8PNZJ8CwhnOq2L3Y3vvOHhBIOHt3KujZw50UvF+jylL1Nu4DnEZyHy3QjTeFUxXewM0gKOTwJCxmfZ3CAexvrtN5X8kB5DZKsTlDhS4j48CoM7nr0v8mW2s3Pj4VtuNVBULv4qjOBs0hB3q/qS0b9sfXqZKzRkIUZ5KPdc6aluq9tUSSFxbschEbfhqc8uId5OFHP1Ixz1WuZuHaN9CG/R6cu9wJTbn+F/+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(86362001)(110136005)(8936002)(66446008)(33656002)(64756008)(186003)(66556008)(6506007)(66946007)(66476007)(55016002)(478600001)(4744005)(9686003)(8676002)(52536014)(2906002)(5660300002)(316002)(53546011)(7696005)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mebaZItv/wSpujzCFPTafzyS9S/PKh/c/jAFaZZNBYb5KX2TP6ULyD6wzcGM?=
 =?us-ascii?Q?nPskNPoOkkkxb/CwwCTAKMQHuBh1DW5SuMhsEHauBzaohRy4sIPAruh1Qw9f?=
 =?us-ascii?Q?5D8YRuXsQIYBFBw4nG8bRvcXEOu9v5s1IX0FaFONPewOYFZ4VwV22A0OrhiH?=
 =?us-ascii?Q?nJENYQfAYF+2ENhkYkdiwFuSgNKIrqH1LE25KgYDK0XY32PCUl6Pgb8mrkMU?=
 =?us-ascii?Q?dRTThxzo6GeKQfDn8qQY/TI11Oi2hUs53rfd8YTw6DGSbdsftPjReAfh7HJA?=
 =?us-ascii?Q?qM4C3X44BzGjfwgiCdk7IjVi55xxVJKcxgYcOfgF3Gf2U5gjKwg/S6/vlMkJ?=
 =?us-ascii?Q?Shse5vRSycHjXAhweltWrtSejT7XTJSB2aHhRjqDeI7NFVkJeFsTsLBz8vbW?=
 =?us-ascii?Q?vc8kX1e1gT8o08C8YC6DaBoakIsA6FLc5JeuGmYA5HQkj1+5WWsAc6B9v+8d?=
 =?us-ascii?Q?rYy+Y3ye+Ne9Ogm8ViSrSBWZdLbzvwqO4HKMV8QP9hRcQrYQNf4fORT/0hNP?=
 =?us-ascii?Q?GhbwzBlUaHdoPWjDP/RfyUokeneXf9mBKeXIto/GD3otxMTpij2CZOm2RZEp?=
 =?us-ascii?Q?kUFVtLrOxOtgmsMQ5+/OtOOseuoj8dkGu+8ZwV95c9U0kkyYRIeoSfZAvByU?=
 =?us-ascii?Q?B7hKYLf+2DzfjX2tGpz0Fxi5V5aenXJmHr73ZlK2CJDrxAn3yUH9PZ4SHzZm?=
 =?us-ascii?Q?qUa/A+JB3P5GbhCLceUgj/71YCciaJ+n8WcPjsS3rs/oLPQL590w3lZbuFqb?=
 =?us-ascii?Q?srI75aizAheknC6mbkKKz1CNg5AvxJbq96UhfZf28+nZaX0fE3QFbzwFo2HB?=
 =?us-ascii?Q?gX0P9gsLuuudXvlzICdILsBL+kadsJPaQohH0FJYAowwWxgB5I3NjPBPJqVo?=
 =?us-ascii?Q?zUczL/VnTr73aZqIjUXM2KMHog5cJ3lxolC+X+SM6jhjp5hXtdRBFjqTVpiJ?=
 =?us-ascii?Q?z0i6S2H+iRZsm6rd3napYkbLxTDdCQNGh+GeXkBEH4nueQU3S3p9VEcAQE+C?=
 =?us-ascii?Q?92cnwgM8Nw62kRWqeFZlPo75ZxyEV7xwnpk3OJLHvsbNDFHpEMaPJAgn3C+3?=
 =?us-ascii?Q?7JV/NlTYE4+9RATRwTqUqB8raFDbwKnsScFIEOqziaGNisAKDVY/ThKrY3YT?=
 =?us-ascii?Q?JGcWayAaA5gxsFx06WSA1+7615Ydcv96KVAP+sJ5mXkXNul+tDwkQ4o+pq4O?=
 =?us-ascii?Q?NkrG0Isqa1NbFIYZmZD/vd4v4b6n/pfuByi/bheZ+aCcSd7dCybzY4rnR+6q?=
 =?us-ascii?Q?lL82DDYXAy+XOzMrI681Vs+6lmZVihgK0EkHx+tUTgPvzIbkoQ6ikMxyo/qO?=
 =?us-ascii?Q?AcdvTY20oNMey5O5/D11nOJnkilFtJqdfEpo4KnOTRkyXj4Onx4U5/zvkC09?=
 =?us-ascii?Q?Syh7HWFjwVuAYo8Jy0GkQS6qtqq5tUi4ICB2k1ziNQV1E69cTQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bca69a-9d7f-40ee-f443-08d8e77e20bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 06:46:57.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAlwW222Ap3ZxaEEFokUoqjkTnNelLn1u2Zo+LP3H1im8uKc5B1aLNRirIYjujZVFghmok7cGWBw7IJg1ErmQjNP6PQNPsuM/2OKkODcDuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7734
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/03/2021 04:49, Damien Le Moal wrote:=0A=
> The sequential write constraint of sequential zone file prevent their=0A=
> use as swap files. Only allow conventional zone files to be used as swap=
=0A=
> files.=0A=
=0A=
That would be super useful to test in in zonefs tests as well. I can take=
=0A=
care if you want.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
