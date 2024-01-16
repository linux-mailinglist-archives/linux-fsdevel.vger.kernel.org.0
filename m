Return-Path: <linux-fsdevel+bounces-8054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99BA82EDC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E219D1C23270
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867A1B967;
	Tue, 16 Jan 2024 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="EKWR/Kme"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2139.outbound.protection.outlook.com [40.107.21.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C71B94D
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0tPgLEgm8+fsuQNdcEoYnSZd6zm7Fp6HjF4rng24VK+OVtoOd2dKpfxKCkVR5SqpoWzeQtApkOuIXfcfx5ADePXBRPQUp6skjBCKgFWtk/0KA5f7Az016VwBMrudY8ENMTuFVH+oDxTJ/w1KYMbIRsNKELWY+X3wNu8Dg82EL9mxhWI0Ru1ph/kOmUdstM5cfiKgwPHsuxxbcn/dqkaO5WUr+oPHjdOWPI2YjjJ9nGwrGAnk4rCVTNuAlSytNoqHqf2ycfgtpWLYAI0IKt+o/h4Y292bCo1X7OEGrweoGfghw0A2mrRmQTL+nfzyRoQGwue77CVdPWfr7iWFnjkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2ghqPNGqWw6LeEcFYLiQrfhf775QrVCwdm3euzaNn4=;
 b=iCF3Hhp8I1T109tBszEo7pDpWU9mdUdM2YxWmxA5WDeSlpHocPcGsfB48skhHXhB8EVViYoC4CcOhuA7MsQGmm+cNv6Ik0DIDOtpZH3iO3Ojh2anBA6j+4vM5JvVY/eyzBWVjxlgeKWmVfqUJ5BDhZRzccRA4XIW3vOiUsy7p9JD7wDj2nfopbBBB1IQYmGBC0ZPgdxj3+TMTdy4C8ugbLyP2Ll3O6B6hUdx0hpNZKs2FrGIr8cwNv82uYtnnytuAsgo0nuYKbRsdYKM86DshBfYtwfXbZYsPjM5HzFYrNMqLpvvr/n1Hiwthtnl1fdY97AaFwCk/cRwp6VrCDsBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2ghqPNGqWw6LeEcFYLiQrfhf775QrVCwdm3euzaNn4=;
 b=EKWR/Kme7mkjyp+a7S0lQxg+gqOW/upOQ9DMhGimBy4dO/qhape2/rT31L1mo5gpSIEwnSPTzcmkKwQIabJVIopx+dgBKlkVEjOMMqmMKgOX3lqdgY84PioO5ipcJqQPxxMIQMnnmw7WzEz6KavvimagOPAs76HsstCk3Y8UZQr09vEQOJKfHtyc+sr2fVKjXlsQATiHQX4TowqVDmB5e5ZITawWe4EGt2URG55e+IL5n1vpOaOittWY4PeEK+oJvhCqDZ+N9uGMNfOZpl2x0cKmlAdROzrEXBolKOgRtsXsbaHcuMcHV/ulFG86ggIZku9wzXFXNqsJxDUYqRqTTw==
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com (2603:10a6:20b:254::18)
 by PAXPR06MB7997.eurprd06.prod.outlook.com (2603:10a6:102:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 11:32:37 +0000
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::6306:f08a:57eb:467c]) by AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::6306:f08a:57eb:467c%4]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 11:32:37 +0000
From: Anton Altaparmakov <anton@tuxera.com>
To: Christian Brauner <brauner@kernel.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Linux FS-devel Mailing
 List <linux-fsdevel@vger.kernel.org>, "linux-ntfs-dev@lists.sourceforge.net"
	<linux-ntfs-dev@lists.sourceforge.net>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] Remove NTFS classic
Thread-Topic: [PATCH] Remove NTFS classic
Thread-Index: AQHaSGGfEiUWkRrnEEiuiqZRoPZdx7DcR0iAgAAHWAA=
Date: Tue, 16 Jan 2024 11:32:37 +0000
Message-ID: <5056D55B-C421-4E83-A076-308857D5F26D@tuxera.com>
References: <20240115072025.2071931-1-willy@infradead.org>
 <20240116-fernbedienung-vorwort-a21384fd7962@brauner>
 <1B634C72-9768-43E9-93B6-3396CBAA958E@tuxera.com>
 <20240116-gutgesinnt-autodidaktisch-d1ac1d2f8253@brauner>
In-Reply-To: <20240116-gutgesinnt-autodidaktisch-d1ac1d2f8253@brauner>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR06MB7239:EE_|PAXPR06MB7997:EE_
x-ms-office365-filtering-correlation-id: 0f64dc1f-e52b-49ba-4922-08dc1686d768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5WxyINDTqmWzZNVmMMLW/Z+ED6vUuz00XfYWGZjeEII6uI2XqLIxmjilYdQz00Xl59xAa3yf3hBbXyjKsXenUxlkvmum+xPBzocGunGC3WpmNTGlZTzIll2GhpB8Z4mhs9aRWQSvbSeHiKqHCsgz0Wx0Js0Vp0PaRViVR0DCIU7MKxmWmY80lj1OK9FQC4N5Z/R/hTl8OSH4OljF1TLA8sO0IGyBiO4LIZxHAvh9gxoYuu6AokzAlWJEIFDnt16wpbZzBnOLvdFImOrnlVONTgNRreR73iFNzpAK2R5fgUpYbGkVJVul/RgRjZyolgG7N/8T1LQ035SComXqp9RldqomVueSIPWNEDAHTxXIgkArgz/oZTlzVq/bWyfFCdQdRKk5/iybU8WTeUsR8MYiYs3JRs3lLEhNeKrmoRQ49v90yLaZFCtREKsvcatjzmxOLF75nwcZ/OjBQS02gqrto3S0a9CqYWhsdWW7oh5xuNe1xrRQvRbdSWGfKxpFeB3ITDY8u7LXTJM684pHw9SMAqxnHtwEkCRhB51MH3l9Opcz7UjmJgdPL55o9L/vegi5wdR2IvayuY1zFosl0vjyV0WTwreqq2CUj2lYklRuQ6794iZzHBzrI50h5x2aDjfeAGwF/dxAhHNzJ0xvQXkHsw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7239.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(122000001)(86362001)(38100700002)(2616005)(26005)(36756003)(33656002)(38070700009)(83380400001)(6512007)(6506007)(966005)(316002)(6486002)(4744005)(54906003)(66476007)(53546011)(91956017)(66556008)(64756008)(66446008)(66946007)(76116006)(6916009)(2906002)(8936002)(8676002)(5660300002)(4326008)(71200400001)(478600001)(41300700001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b+1kajr5WuHcJ71nZeSJLPuNIjWSCb1rnaCsuUcwikj3Bh6C+JKTyUfLqLhz?=
 =?us-ascii?Q?g7Svx03ipz7IiFY38/78vU/eGJMuFNxxdvP2Y4yZv3W+HeThha7D9fsqj21S?=
 =?us-ascii?Q?tcuqtg7XHipC/xTZrk8RpDPrZ+wWVDLBPQYs4YRIFXEynCCc5JC2+zisnpDS?=
 =?us-ascii?Q?Y78/I/buYDk9UCGgnGONg+dWqXlC9I+VmqYFBD3lCzIRWWHYy4klBxh18pV/?=
 =?us-ascii?Q?E8OhgNl+h3siwDDRDlNz9qWGCsaH5chax8R5fdZqRpguEkoGkEQT5fSnufGR?=
 =?us-ascii?Q?L1kFARhWfnF1baNJO/pUferGSXwD8DtvZDzSlfSwtYYFfF9LbgfBp+4T0t6W?=
 =?us-ascii?Q?xpxnPh/Ylo27ojHNTpArojNjae3wQ1EE5A3h5nnXNF/k0v2gh+Fedf/ChxzJ?=
 =?us-ascii?Q?+O0A0xrGViZOrwAxRJMTaoDa+hbkB0HzULl6YA+SoHV15Dk8LdBwqPqkOjf3?=
 =?us-ascii?Q?z5st7TBjLy3wuCwdLEITymhCTSlLsihgl/OeMkLn1OxNGlh28OVnTwElyO/7?=
 =?us-ascii?Q?m/iyRhra6qyNLel94y+6okuQhSl4LurO3Kqwm0O0yoZmxrX+ziOwaLPH7w4a?=
 =?us-ascii?Q?EIUF0TxgBzevM0/eac4h+C5N+hLfjr4+IE04dIz3UXt3lSxLMT2m80anEoP6?=
 =?us-ascii?Q?wls/bOTKF46fZ/LEkO3oVY5hj3/fe9BlTy9GW4nypu76XOyXnh6EBNlJ0whD?=
 =?us-ascii?Q?lfn8aQRhp8L1LNarIuIZjFLsh7MqRU6x7e8VFfnBYtqbuPKeIteQ08Gzegzv?=
 =?us-ascii?Q?N6N34kN0JPwrNNRf3GQRg/qAH+nEpM2+sR66tSUymETd4qzQw5bmD1TTsMRW?=
 =?us-ascii?Q?3tX4SZo8pDL38AQerq8ZaoCWSb2KyBwijXUmHj2+D9Z89M0JCdkS1dJcCkkM?=
 =?us-ascii?Q?8e8M/WLN7DdnXRopQQ+PsMO/pw9sGKDRS0S5jMgEeDPsOcmwXu9kfw7v2C5u?=
 =?us-ascii?Q?Ir2VXlsBHI5MQHguMY1ZH9h/sUxFIpzfQrnf2KToRtvaFu5V60LMlmHojnd3?=
 =?us-ascii?Q?fTmmHSPM9a74u4I6nlWezGrKiFtK9txdAWZMuNEMU/kRxbnWvAymJJ7dRsGU?=
 =?us-ascii?Q?2rpaLmMWB1WdjosGaMu8FjIu+mecqwI2Iq9FEAtyanVn1wIf9RWiBOq52uaD?=
 =?us-ascii?Q?MttfIJwnXDPoIurW0Rw10jbfFJ3pYiAUrE7WD/v6JjE050moPETMZr52Zfij?=
 =?us-ascii?Q?dDqfyzp9P7DoVE0Cc5HIg8chYamEDxyKBR/Et5WrZngD+DeeK6Tcj6+IIMlL?=
 =?us-ascii?Q?Xvn9g99kTZRSaYeNDETxvhF/lC0EWk2kJh5brHRWFfCVNjdKX8fLKku6yKQm?=
 =?us-ascii?Q?JLqvVQ7RqqpmqipN5fdL/CykiLiNxZ3gDBmVIWpeDsw9SQk5Bje+0YGi+Nh3?=
 =?us-ascii?Q?tRnkWxRhUn9eW8OJqRMP9JnTvpH2Gf8phoItdwaQbjjZfWOQJclj1WMAx0Eu?=
 =?us-ascii?Q?B7CvTBN9Sk6NmSl/RYt3jqDSb/QZq1fS9VXNUeF9DBTzhBzgUqnnru48yOyf?=
 =?us-ascii?Q?M24ypUWg+lNZEqI33cKexPb+Dz+ss0VtEtQYLjbYMIZc+hePAudmR5L9VeOq?=
 =?us-ascii?Q?mAbWgRdEYK5HZ3UnwIVyoq/O5StVZraxdulcrIOT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C1DB479CDFF4742A873974943ED4218@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB7239.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f64dc1f-e52b-49ba-4922-08dc1686d768
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 11:32:37.4508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TevyAL1tKtCsg18vj8HF4s9Z9JrcVSKLpRkQyE+am6jE6NBl39lNU9tOpZbydwq3xxnS4lYx10DEFZ7AucM0Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7997

Hi,

> On 16 Jan 2024, at 11:06, Christian Brauner <brauner@kernel.org> wrote:
> On Tue, Jan 16, 2024 at 09:51:47AM +0000, Anton Altaparmakov wrote:
>> It seems there is consensus to remove it so please add:
>=20
> Well, we'll try. This is one of those cases where we might end up not
> being able to do it.

If that happens, I am happy to update the APIs as Matthew detailed but obvi=
ously I do not want to waste my time doing that if it will be removed anywa=
y...

Best regards,

Anton

> But imho this is a case where there's sufficient
> reason to at least try and remove this code precisely because we have an
> alternative implementation that's been around for a while.
>=20
> IOW, this isn't like reiserfs where we're actually getting rid of a
> filesystem completely.

--=20
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer


