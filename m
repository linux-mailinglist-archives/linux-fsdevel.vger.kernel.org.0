Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383C647835D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 03:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhLQCsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 21:48:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20538 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLQCsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639709332; x=1671245332;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WDkjhn3ZZYYHA8EI7birF9IN1NVUIY5ZLJz1zp4kYO0=;
  b=GUybCn7ufyH0GRMWnEcmErM8b/dkXnjon5u03Ee0n2/yCe4oxIjerpXP
   h00+qtUfoI0GpatRWN9xMxDmFYgAYrfIGXcY/0idsOMl4+D3Ml7hYUXj0
   LwdAq57wdYdPIv3H+4AjcW3MiTYkax/TRPFVQqXz9q4h09585IVuZCXSb
   WsYZ7tKMMN9a0N2+LMwXfLtqcfeJSlmwX/uwlBuXKNDxSBE1PasZT/EEa
   27qBUCaCpLDL5J1tRrUip5CmAF7WoqjYVbcCHhz7d7O56TO5V8sVRc1qc
   87G6TflnKTL/5CINMncjRextIZp2ihWaLrokVdjEMaiGOYwce9aOBo5x8
   A==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="193267795"
Received: from mail-bn8nam08lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 10:48:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtR8lfjpCxRiWx9lqGYU4ExgKiYjjvqKEGe/hlbl0GJU7Ezwnhh0CZSZddQU16aKheXKW2kkGM6LttZfSq8lCjOca1W4+sGqv8U9DVXu1ZXfdAtpO/DNfFdWtxRT0daKMutobu4yJyIuNl02fAsiWz/qhDek8ARFJSj8Q8ssi7j+cQbm1ob974fHHmZZASaBcdicBAsdWcQZoFUm62jPNuYYDHcr7GVMF86zPygm01n0zAYhN2Og5LDp6fEZM6XTTi7MqGNF7xmOKCYYZjhMfRhGC3NgTX6kDHbjgp1TUjs3a6U7dPkdo2V2toZyWJ+E065YBbVbhp7WK+J4aM9jHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jknrMOHkQmW15mQ1B+CZi4L/mZw0II75jW8ndup0ycE=;
 b=Dfq9VZqrfs0c5cyjV1MaDtkz3z4JFVyR2bBGyIhzBJylBJzbg5e079DOfmGPAuXxs7bYfd3WvzRRAArmWtOcdjOlCkRwwOlNhvuXiRxL+Q+fC9c2RqNFNXD4aMx9KRtWre/FCkZ+O33zGpcpSHnjh0snvNm/aa3b6Y5jAznmHv7lxfJWzjiRVj02yZmD/qWHJKBg+ypevhv1cIl/2fKBXEerHqwImIdZDw4OUqC9XJtmuLC08rX6NOB795NLewcrVtYAS0fjRyOoWyybSBhKuxfDUFFexTUZbuvyK+BB4Bm4ltnJj3PWSfYcIAOCaQoiHrlTcY1o1TrJBmG85yCk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jknrMOHkQmW15mQ1B+CZi4L/mZw0II75jW8ndup0ycE=;
 b=rIUSTfzKi0AgdnCD/VTTdR115WPywLk0us7AGD/SEtrsJLE2DEfbZ2yxX25T6RC0fU0lJR3qpU2lGs/XHNg/JdZjJMZeVWF/l6s6ag4j92MjtnL0zL2UxWqkbb0tFoUKwBV7zBWn14Xqzuc0YztnvYsvofZ04Yjl+JISoE+nXC0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8245.namprd04.prod.outlook.com (2603:10b6:a03:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Fri, 17 Dec
 2021 02:48:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7067:b7ba:4fdf:d3af]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7067:b7ba:4fdf:d3af%5]) with mapi id 15.20.4801.014; Fri, 17 Dec 2021
 02:48:52 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: add MODULE_ALIAS_FS
Thread-Topic: [PATCH] zonefs: add MODULE_ALIAS_FS
Thread-Index: AQHX8u1DK99thaG/ikuWAYcjeeAYuqw19ssAgAAEmgA=
Date:   Fri, 17 Dec 2021 02:48:52 +0000
Message-ID: <20211217024852.6ydrtho54enm264i@naota-xeon>
References: <20211217022403.2327027-1-naohiro.aota@wdc.com>
 <997919f5-7745-d15c-6c17-fddd2865e4d6@opensource.wdc.com>
In-Reply-To: <997919f5-7745-d15c-6c17-fddd2865e4d6@opensource.wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3dbfe52-aef2-492e-1124-08d9c107c2d3
x-ms-traffictypediagnostic: SJ0PR04MB8245:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB82450E1C713129F11B2DFDED8C789@SJ0PR04MB8245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6Yw2BjF9CGqYWJz2mfhH38fzo4BEm/x+s5aylfTrONEdnHjHFOkzARLnGG0R8+TObVUw4hTi4/EQQZJHho52YPltbhQExw7cP/O4gA/UkAy8lAjJrUfyBuTU6sQkp9jzcjCpQU8rZspHd7zDWY6F0OEFSilJkWNB8KC/3f6Amdnj3TExeT7s3SgP0y07ZE3p5IOVkB6g7B34VipNjaWSjRLf4xs0EfU4xiKwzXZ+IgqP6uaitM8Ph+1id8P6xVThHWghhAyhY/BnRHr8rktXV//MldbcNYCPNqOgcAYfLIKoE/WRcZwiDYLmMgfZOUqAcqqIvQ1DeHCFgauhCu2MPvgp1vpSUJG7qHabAe6yGmgSLfL0j/R+DQyiYKnOz/s4YF4L3fx5ddtUgcFJUZtxztg/d0N5t9D1J6qQ97uehJPFUDAuCEqrdesDFC6oULFrhyfM6GAX8tKxu0TPiX0jDPLA/aPXSGR8IJDTGMcP7yAAUZ7h32ZxspUsZhrPPBvDaLaZeHVgBzk1aamdV0tqlRVVyDdG4WmQfcRPTqA4Nixu0r49fU5wHXvmSR6ZS8jZIw8z5hdSdTbZf70hhcgxmMQkSLnkLEtyii97TuT+7Lnxo7744FBu0lLMNN9OtzH4e8c9t4KG1lUM7qw9Bh9/1JyVuV4YWxDVgExroIJ54ICXPKpfapMFHtKlIf6CHNg7OTYdy85HjSm+UweCzBQHxQz0zSEe090WvNlr3WsMlhfZ528Kn2sOe94NtwbWc9x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(66476007)(66556008)(4326008)(122000001)(186003)(1076003)(316002)(91956017)(82960400001)(83380400001)(5660300002)(4744005)(8936002)(33716001)(64756008)(8676002)(86362001)(6862004)(71200400001)(76116006)(26005)(2906002)(66946007)(38100700002)(38070700005)(6486002)(54906003)(6512007)(508600001)(6506007)(66446008)(53546011)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sbejM6H4xZ54eTeisLR/qcB2iQmcplbF78GARjb+00QR40qR31z7ZO60JaNU?=
 =?us-ascii?Q?Titis7/Q3rzj41GOLhLp5VoLSZsuIYNlSwG1b1fRYskzZhsxyXwjhEdng+2v?=
 =?us-ascii?Q?/qUyXFtUyov+k8aM96nHWP/uVusvqHgtaFLgbkQSnbUKhYcrLpT3qs6oUUvw?=
 =?us-ascii?Q?1lpn1TwdNGiIkzqStL6r4eVvuUbcqMIHw/ZRNiryRXLyi+mMHooXaIKYrn1V?=
 =?us-ascii?Q?wa3bvggt1MTicPKBBQqppw+mwj1XmrjVE4IeAitgKCgQncPC35m/lcyxS1n/?=
 =?us-ascii?Q?on8Zd1ZNoimtEiQIzzPjuxqY30nqD3SFAzpPq90+O8L+5uKfhwxVu4ZbnhlD?=
 =?us-ascii?Q?nw9NRs0N2/L1N11ZoMCTkFAnVhOr57RwnfQ0sMP0oMTqKqaWNpw3Fds0k7yQ?=
 =?us-ascii?Q?ueHjRiHWvGp5RVAkWPhf42dpmvauO8iC4iaUD4i5Upf8Bsp0ofIkhKqF56jM?=
 =?us-ascii?Q?HLLlGNP0hXXxpgGPm62xWAWt+fh5YMS6AoeeYEZ1lkn+YKxAyptbQdvryQfJ?=
 =?us-ascii?Q?xaiwVOs9+nwLAc7Wp4Ubm71v2GDQK7PpxM949Cc/AG9I3GUj+t4m14I9DUFu?=
 =?us-ascii?Q?8xSuT+6it0FrBRZv3PXI3PlOlrDW9GT2Ga2ZkK/QwaN/1cvjVZ3Yh3YfrB4p?=
 =?us-ascii?Q?YKsVcqQWYXYSHKB+K12nMSP4rgTTpbhg4OmYBgSuluKubOGNihsI5k9txK2Z?=
 =?us-ascii?Q?wW9eBoFGbUpndoiLOytzk9UT621ej1szsxcXUhTV13jqdw6H97H7Ut86rajR?=
 =?us-ascii?Q?zQ9GWrPhRlIuU59eJzjwBVfCvtOJw8rnl7k2lUIgnswHbuHjS0JudFZV1OAs?=
 =?us-ascii?Q?KRe5wMn0Af5Jzt1qe0S/CXJyrDhBMeK4GbJftEeM+oAtn5AiXqFgu4MLJSxY?=
 =?us-ascii?Q?zb+ChEX+kSj2VAJsWxqwT2y8WmhDDMes36Nm3HLL8CPyNA57CTP7byj0pQhE?=
 =?us-ascii?Q?H69/P3LeWfDZ1b6K1rOA8Wo2NpKAj727gDQYQVDbM+Bwfy0cKJvteWfWoxC9?=
 =?us-ascii?Q?CSmB2cbzj2OJVmCRSrIGjQJvkfDgDemlqEy2Hff8Ow/bJc/5z2MbakFrsQIm?=
 =?us-ascii?Q?NmeF3cet9ifPSp8i0SVvcHBhz28g2+d2MYzAqaedcgm3PISl4QHX1aBN9oyw?=
 =?us-ascii?Q?EnxlDvWUJ3cbwgQ5P1Q/4wswJyPrICsn0mXCHLeCJ85iig27wW3UCY2U/5Eu?=
 =?us-ascii?Q?uTX88k7UhiVdMmikJOMygmq6YIXHJU2CxAiw2FceOnZAP+Ef+Loe1vnr9qRc?=
 =?us-ascii?Q?NuF4X4Qcs5ol94LgTx2CaF/YecpjB4G1GBOHJqnLFXlMHS1doS0zptbacs6h?=
 =?us-ascii?Q?AgGbgo3OfjLP7Y0yZ49ah83GF2bgytGOQEnlueegyDn0WpyrwztWRHnqEytK?=
 =?us-ascii?Q?zZfW8Q49HdE7myPyL/4jrB2/uQ3uRVi5nCOFWaKNV3pv+myQK2Z/XYGIcdB+?=
 =?us-ascii?Q?CpANdij/9Rh6iUQFbJHgk20lRH84xlKltOCDUybe1VpEGXjGVV9+oJYQrEL0?=
 =?us-ascii?Q?6yq0Q74JAIGcHTYw4+9AC4wDrbU6jw5OvZiOJfK8sIm51Kws/0Kru9LoS6Tq?=
 =?us-ascii?Q?vNyzNleZ8CzpTA9euWjZ/+MB6HLr6TjXvsEZXC41UPrSmBn3KREF4+KRY2P8?=
 =?us-ascii?Q?6DrNKGTVwil3+TiW3AWJdIg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <332632CED00B3041B300AFC135F0B3A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dbfe52-aef2-492e-1124-08d9c107c2d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 02:48:52.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlqOhEq77MIUOJQdnJ3niP2ysm4T7ygqsVnz2Lo9wpDq/gMW8vb8+UbQKg0D0cWPbqaaQHaK3xCWDu8g/1dxbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8245
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:32:24AM +0900, Damien Le Moal wrote:
> On 2021/12/17 11:24, Naohiro Aota wrote:
> > Add MODULE_ALIAS_FS() to load the module automatically when you do "mou=
nt
> > -t zonefs".
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>=20
> It is probably a good idea to add a fixes tag and CC stable, no ?

Indeed. I'll add the tags and resend.
Thanks,

> > ---
> >  fs/zonefs/super.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> > index 259ee2bda492..b76dfb310ab6 100644
> > --- a/fs/zonefs/super.c
> > +++ b/fs/zonefs/super.c
> > @@ -1787,5 +1787,6 @@ static void __exit zonefs_exit(void)
> >  MODULE_AUTHOR("Damien Le Moal");
> >  MODULE_DESCRIPTION("Zone file system for zoned block devices");
> >  MODULE_LICENSE("GPL");
> > +MODULE_ALIAS_FS("zonefs");
> >  module_init(zonefs_init);
> >  module_exit(zonefs_exit);
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research=
