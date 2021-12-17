Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448644785C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 08:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhLQHzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 02:55:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49039 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLQHzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639727705; x=1671263705;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mZaJrUWy2B11py6ozt/6IIqKC4MJheX9N4JQmeucLQY=;
  b=JwQlV94Nv+HZRPfvc4e389yCDY/X5RHpDfjUofhvABAEiAh2wTSnFh+d
   AWvh2jUS+aoh8CvIKEDMZuZGCUGz9bBI/P3KtjZ56EyTnJfq+9JrAFDUU
   DDgA9d7rcOCh4Oo0l5DoZCn/C6tKiq5EbWuW7Rfa0NxVSc6JTfZSr8ixA
   deOd4bN9/eSanbZKZevTxZhc0zaqd0OTqoo2bxPDeujs2rC2FakW+qx1w
   Gitda57xHSXiRhf4XE32PlZKrFNNrpjJknsFRFKNj2R5Lml09e8SBRmjD
   LBCNoWelRoZ4IEUk14xLDWiLvXBJ/pvgntrh7RlHwPxQwjuAkdCRijowG
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="189509303"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 15:55:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ6LfLwCx48T/wf8tBbqEO/z5kggI8Wt+vgRGEx7pwW4kGHPowMnVKhlgTtR7b+pFdzE4XRZfdK6Bqc9fjBfOwWKUWSr508sPNrKuCWlB/t5m4JJI7xk5W7mQebOFUfdo1K6qtHW5Unu/2SNVTuFaLcE5HOyB0JiEeAHeDCZMJFrxS81m9XFTEw2CRUVlDvESoPRljVc6QP17SNl4aeCpi+RFiJM3JI4yZQxZnaARO2isQBqjisNEljTSQztc5UN8ZeRnldkfV4UBhAadeciHdtIdlctLMwsJWU3CW8x91HHHx1Z1VYF1gPS952v44CE8HgT8KycQfHMmiqut52iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZaJrUWy2B11py6ozt/6IIqKC4MJheX9N4JQmeucLQY=;
 b=oEY0tF+CCkv0qjoUBeumGlo+EU0kbl9RGumOxbXLslelayWkFLpzKnEbPCrlW8+XIXUsuN1sCACfATy50wUyLxzioTqtAwDvmdwwjNpQ+wh7cfca6WGcL+5Otf/+xiRsv7THrV0/pw7i3WLiAZWO67Ra4UWfa0qWZY3Kxa7fuY9c56mqS3Ad3OfVel+3NDTcO0kE2//gzDx9XU7CFzCAIKm45cqzXUBdR3NqmDSLARglT6b4Z27LeNUDGcibWBmQTVKTD7f7SGHAaPXkwXfj94bwebRKjHu1RUa3wlVxNa9YH/O6m9+EeCWAQjW/siHIPuF2u0IW5SwNsSi8Allo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZaJrUWy2B11py6ozt/6IIqKC4MJheX9N4JQmeucLQY=;
 b=Tcn3wXjwsDO+VE8hut9PwQZILz3LUGPNouJz1sPyAizwCEtcZCmcu5fY0OHp6Mc+5ZlMv+B2od8qtUJ4iwFR0vXm5qOpFDKlTi8Vmr9TIryDEkZbVQ2cEK0tBaaRZxGAm4yplc+7xXPX34eKBGtxc/kBA00iSbtTaF1R4QNhXx8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7304.namprd04.prod.outlook.com (2603:10b6:510:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 07:55:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 07:55:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] zonefs: add MODULE_ALIAS_FS
Thread-Topic: [PATCH v2] zonefs: add MODULE_ALIAS_FS
Thread-Index: AQHX8xtl6RY3SBVPH06xJzl2I6/hYw==
Date:   Fri, 17 Dec 2021 07:55:02 +0000
Message-ID: <PH0PR04MB7416337E4FB0C30013F294B09B789@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211217061545.2843674-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2445e5d0-cdde-4c1c-f467-08d9c1328866
x-ms-traffictypediagnostic: PH0PR04MB7304:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7304C733CF28F398EB4C276F9B789@PH0PR04MB7304.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dp+VfBoOFsZin8HGwx0r8CBtnQkwW7Ql1dGdNsyLvTvnMUY1S1vjkBde8QZak7O4WjBtE4EFDKubx2ZmlIj7/snVOVazwC0mVat2t9qeOSgsipxmhpc7Qix384RSfl/i0iH5wnZs4bpiLeiYdfc+MuppcIohSxPCUy5VW3mZ2Phc2j8OBcBo5qD4PsfA2C5eSwO9/sgnfh2PRhMEGSwcselubOEJrZ6sDoPqowfUqSvbLq8GF6kAltUGt0vQYeLNWJwN2Z41JirX/+1RYsRqSJfHmuQTWNejW8IHgwB+Dy2qb25qqylQcxiik+MEyz13pj9qWAInzH/bGQXKTY7rxyh9vLyrPuzjJXR+3bbbW9sYuPTYU0Wl6AbB5MZuWNKz+Z1cgM/aJIXho7Dubdh/4OxumV92Ojd5eedaPRhMctpe2zE8ZHSPHGtL9OXKvAO4ayYoLbNE3HkZdDo14idbelk0JA1LuqR7FWb76hcg0i39d1asbETVXi+ho4lhQcEpTD8vYSaCQXXCBtsQM/I8A/OpJZBnu0YojA1JasCSGHE/VcDLvqUYy2F9RqB4bMHyU0x0kppTijTZKfqe1wEmbWHKBZFnt/BS0W9Wgr9wsGj89Cbyl8gWVm9aLiE4q+7oVEXMAuTVpCgM01QZFIJjzPCDPDckue0NSx/9Z+uQYM8FXWnjlmo2kZw7PIqlCgIq164PHX71uKfqBTtk+j0AmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(9686003)(6636002)(38070700005)(8936002)(7696005)(53546011)(6506007)(54906003)(110136005)(4326008)(8676002)(558084003)(86362001)(66556008)(66946007)(66446008)(508600001)(64756008)(55016003)(66476007)(82960400001)(5660300002)(2906002)(122000001)(38100700002)(91956017)(33656002)(186003)(76116006)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t6vqCoXNPPkV0MZ+AidtU9AmAF/syAJEZFyZm/E5TzaueAWrgBPPilXIBejE?=
 =?us-ascii?Q?xPezOF0vTWu8f6MJshS/wOMfz3z+k3rMPLE4y8/F0EwEtNM9L8Mv1FBJeal6?=
 =?us-ascii?Q?IJwCZueuBBGRAK2/QEse3K9jbu0NTvckSHvkJz9hdNWxlsHKDI6dmLbMHJtT?=
 =?us-ascii?Q?viEWCVssPjbyBLv6lSLdo3JDyEpXaUQ9Zygvj8P2wfKTBLS6V/Vn/QbLl3eU?=
 =?us-ascii?Q?ORLYvXn8eRVUFNd1vAWklDTLDmGzXEeGslb6Xv9x5Yjm1I/VARL1WccZXFUC?=
 =?us-ascii?Q?BlJYY1CeBAuLAUyRkDc6p8KrzN6DtQGRUM734DHO7v91PLRDogeDXoytBDSg?=
 =?us-ascii?Q?CS84iOynVOg38Tr5F6NUIJEXGq5qvrKH1oAKj1w4sGjEyBmmygKRwRVA0/Mi?=
 =?us-ascii?Q?DtOmqih5Vx6EAtRVKPr4qmJ6Jv7hpAyaOHK4j9u2JH66dh7Y+s0kSIA+xgtZ?=
 =?us-ascii?Q?7WMoYzMe+XNQEAoqS+2GGFFJXzlwISfLPvxU82Zb5jE+fpN9/QuvufAb+9zH?=
 =?us-ascii?Q?t8odpbcnXKc5WkQVO5ur4fRqN/PUOwrFiI7f+f/DTfBWQpImcGgw3B+Zl6RY?=
 =?us-ascii?Q?pfNXHcd0LI+SQGmfytxqYeCanfxPTxCFF2fqOAQ8LggaCIvKID5kzdZZu4qf?=
 =?us-ascii?Q?KnQZ/zdSLBf5ytIDvVADRx6TuPXkWu/8mvgYQgncvtFtS4MhhShotdAGvywA?=
 =?us-ascii?Q?nhTtysqSkZYN55QbCWFnWb8/sfNx14WdeRp82x0NbyFlr0U7KIQJmsL4A2vl?=
 =?us-ascii?Q?nCpWbdl49nFez0TXMdsMdKijKhv0ut+ZLs5coq9hx9GhWiMMIJqZXCdfzjoz?=
 =?us-ascii?Q?WFyMILh3iQ6p52x8NdGBKWwvstltNNMUPqiGNCi20TMLZDsFyX871cZdH5qV?=
 =?us-ascii?Q?wUsJsUj4oSWM6sQLYHlGCn8uqu8QJTgN/qlqLkGjLLi0dmr8lGcqsbHi/jUd?=
 =?us-ascii?Q?6UlsJ08GYnAAMnp0dLbIf8nTkuGbYuzHIVcqJ1UI6Upet/2b5EF6RCwwzUwa?=
 =?us-ascii?Q?eHLqd2APObPAbrSchHwfy8tr0KrUg65PumCTwFYQrHLNIli+7I04z6HTOgE1?=
 =?us-ascii?Q?BwdWeQZWFGor5YQcZzxidmVhebo77GtLV1LRFGqSXWwuszrWV5+N5m8P+U6z?=
 =?us-ascii?Q?pn8QbRZR3k65kvnPEhG82OloNo9uQo2FAvcbaUYbcsnyGhC+PjvVApyVBR6m?=
 =?us-ascii?Q?b60P3HSCh4+57Fbtj5vTYjiSRttjrHX5I6tNov4nqsjRQeUaeNq5Jzxflrhq?=
 =?us-ascii?Q?Fau8iXEZOdjUwBIHncbcvodCynIqkZyUNbSjZch7HKjlyfEEsjwFj6pNoyZX?=
 =?us-ascii?Q?ujQTcL6nDIqdiyjQXmF2Q2D7fm/b/tPFYPWA6ckUwzizr76sxIVl12QLYwHb?=
 =?us-ascii?Q?YfiZUo8o4+13Th5j9OjezZUVfHIruAVaa/IKqq46Zjp4MakwKkywyaPgnWJd?=
 =?us-ascii?Q?FM7kJ4G2Ug3EBCPmvxbCojbfp0MNTRTnUfeYelcOYlZBQqlDtKEDcUJ+3NWm?=
 =?us-ascii?Q?lymvSrsGm38NvJwKpHC15UkGiHb+JbaQwjC0f5Xx+q4BiT9ea/2NX0Wi0o2I?=
 =?us-ascii?Q?T9Zip5BnjGWbHiNhiNzBovnGzMsLP7elZNT9xHUU+5v9XroU/IzvLUCR1Bc7?=
 =?us-ascii?Q?RbAj2oYyi90D2jthzJbx3ZJpBoSmbwTba5JPBwu63GT2M+LsivdRs6RV0oR2?=
 =?us-ascii?Q?2u+erLNGRhEdK+ZYK7s1HpsWzljdUSNVlwBJgeRby1jGF6CnECnKHESnZvWk?=
 =?us-ascii?Q?n/ychUpUh66a9d/9b5mtjU7nROcYkTE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2445e5d0-cdde-4c1c-f467-08d9c1328866
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 07:55:02.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEjgdEWqe1NGCm3QyNrt1OjuycEHMiEiA9V1i0PuCmQmFMeZ4s/k0C9gM8+Q2moVzTxvY7kWMLne+ZWDqRzuo0X/4/c6iUjnrsPen97cFPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7304
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/12/2021 07:15, Naohiro Aota wrote:=0A=
> Add MODULE_ALIAS_FS() to load the module automatically when you do "mount=
=0A=
> -t zonefs".=0A=
> =0A=
> Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")=0A=
> Cc: stable <stable@vger.kernel.org> # 5.6+=0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <jth@kernel.org>=0A=
