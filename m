Return-Path: <linux-fsdevel+bounces-8044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A882EC32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D27C284337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3C4134A1;
	Tue, 16 Jan 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="DTRwcRjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424B134A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvVAIwf6eafHxw1gClKeZhmN1c3aC1YJ+wsTXRFQu4cm8WsrftD6Pn+j/Xicv2HHa2uJYp3GKcEZ4AEqlivAPg3ONJ2XGsS3bjKAWWd2XhjWYoQXYp/1DTH8uPwRgkZdsbWLG8WMmgJ8jnp7Y13XGXe40CYOnBRTl2MSa2RISlPGuryzn3aSFTKeEND8HVhoQqzUggLQ2BSqZJs91CwmqLh95cMZCurX0UTpgeC2agomnM7kHCAmX0inzl6ucxHmkGeyOEzxjULr3oiWxJ/JJPXl8rqwsqU1hZrO+MVftXHzmmDwk/Ipz/okR6yBFJo86+tAf5XizdOA64Xfe5aJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7612qsnBpX+l1WtzExgO0R8vsNFCBMALQw66xHrrBms=;
 b=T3sHX7z0SdUsHAKFAvb2mNg34sbeCK/Zqw4aRmBZmM8JfK3L7Tbs/Jwl6R8bKGlZ92DG5odeasqnDrZYDoucujjxP2XeHq9EwvKSh29XtpZUaZC6YtW6YA4kKDM3SMAQRlP/C8YNGLnoMBhjyXkdcY8SKWr3TAHCwPPhqP45EMyaiHSHGyHT8eNahq4O4lNSZERzYVHZBr+9kqVdNf00Sn/SPaiXWRl1ueIBkMpxmSH+wW9uDDf/qvidVGXTL5r+az/So3dT6qzgQIaX3GuHAkO2I5dL+jr+p6qUHEsZNiy0rFLP8bg5OANGlbedN48d8f+cBf6mfbUer1V8zAfT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7612qsnBpX+l1WtzExgO0R8vsNFCBMALQw66xHrrBms=;
 b=DTRwcRjnThmoIMvYSDNdTI4c97GkXYXQ4bLPxG9C1FW83zr48GcNrBHBmyXhPJdcUoJc+ySjf+gKjM6s95CryLSA3+6XYLTIJBe7Y+fJTE4WcrzrizFw6xePAr+EWna8LMdHUckNThVhBlv0wbi7XDlxvC5zn5+UHsSP3LLmGxdHU8G0VsmJdVofdLZJW0PD+64RcXOC7alnCBDnTfuBXS3FHipFD97aggFAPAyYiM760TNWC+lEuF95QatFgFkfFUylhQwieDobrktwggSjq88SEW2sUGDTZdcxUJjgeT4uNGJKrYvW9xwcehe+6WaslO6KXGYU4ltD3C/XlWOqDQ==
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com (2603:10a6:20b:254::18)
 by AM9PR06MB7826.eurprd06.prod.outlook.com (2603:10a6:20b:3ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 09:52:14 +0000
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::6306:f08a:57eb:467c]) by AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::6306:f08a:57eb:467c%4]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 09:52:13 +0000
From: Anton Altaparmakov <anton@tuxera.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Christian Brauner <brauner@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-ntfs-dev@lists.sourceforge.net"
	<linux-ntfs-dev@lists.sourceforge.net>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] Remove NTFS classic
Thread-Topic: [PATCH] Remove NTFS classic
Thread-Index: AQHaSGGubysv/D/HZk6IbGzWM3KmuQ==
Date: Tue, 16 Jan 2024 09:52:13 +0000
Message-ID: <46E2F257-7A41-4635-8F24-8CEE6E29C996@tuxera.com>
References: <20240115072025.2071931-1-willy@infradead.org>
 <8a5d4fcb-f6dc-4c7e-a26c-0b0e91430104@tuxera.com>
 <ZaVF72QxQm/cN5yy@casper.infradead.org>
In-Reply-To: <ZaVF72QxQm/cN5yy@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR06MB7239:EE_|AM9PR06MB7826:EE_
x-ms-office365-filtering-correlation-id: e52a04c6-94a4-43c4-9267-08dc1678d10e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OM1JIXmpwZi2BpcZf/wkHf6jjx+iDGz9EqCgqNtd/vPwWrfDMfc+6lTaIE+5pYGwB31bjMWGUZnfR1nloUxv6WM0zXmaS2LJR9QojLBfdhZkQ0zDkwqRTazJ4gWzEEZPLojdoBBW3FgAcYnDgKZdiYO0bQty760SHBKA1S40oCzHmzflg398KXEiFOEC32f6SFOPLPAN0Y4MPDz4S84IoWY5W0q5/2g2iouWxthIpVbMmb8CpWYjrv/k9MEPZrN7aMLfCFoVRwYVbjBE5Oli0gvFCwknZzrCTm8qdSTcC7ZpjeGpxn0hdTWS5/rNOxkTN0acPBOmvUtNUjJXeYQcHUlLpZbcI4iqqPe4QOGu/gjA3i8lSo/OqVctOSy2jyQSDW6D2hBERS8uqv5KKhtDpFTpiY3BlFvSk2OCjHTH+A60x/fpql2jHqcB3Wipck0jr0JMqV0WkRquODZKQvCKGqbZ+GY/ohhezaHkbUvGnNfWQ1lNTtr7X+KlyC4sMRh431smrvNdYQJj5hL5qL3SRjRFmbaxWMuRUScq5TGU4xjSp5grfUmC/5ZbbFQBKoegQ4o8pycY7Ok67I8PxyTZCPDGGM89DEPBX38MHuXyuFQd0RG5cZ+11ukjfHJJ1maV5HaDIg9hcuqBW7K2XtqQUA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7239.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39830400003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(122000001)(38100700002)(38070700009)(36756003)(33656002)(86362001)(76116006)(91956017)(54906003)(316002)(64756008)(66476007)(66556008)(66946007)(66446008)(6916009)(2906002)(4326008)(8676002)(8936002)(5660300002)(71200400001)(2616005)(26005)(6486002)(966005)(478600001)(53546011)(6506007)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6/zm+7NHyWEw20UqZQWEAD22ReunBRKZ7HKAi2LywNwAQqSQ4GS4op2VtAEl?=
 =?us-ascii?Q?Y102ylK0yf7S3Ys7RaVWMCEU0tUTrmwEge6EKewULxGUj7e+uxYQfPC/F6XF?=
 =?us-ascii?Q?+Vr9VvFxcoCdEJBUt+LvpV5wRQ6PsiEwAuQP0dkYrqaTMZBrvpMw1whUYgyK?=
 =?us-ascii?Q?8tUWwLlD6HOLjjUnSX3xW0PNLYHT12cAeBqXaoPQk3P8PRAgYgxy39yi/gB3?=
 =?us-ascii?Q?zD/d4OF6yI15j9KlzyIsn0Q35Gq65DNd0o957oD7Y28AcP02vYELQ5aRwFQT?=
 =?us-ascii?Q?O81RisLaohYRMIfjLUzyxyu1+YeP02jzJESCMzi85YAZEpWIUIjXxguPjdQ5?=
 =?us-ascii?Q?BReaIXB+c8KxRvsEl0ZDMoS23XSviashsv1cMsg5w06Tsy4Ze22PpPnGFCCD?=
 =?us-ascii?Q?jH2stMsVnH8R3m9TIFxVChPZakomgOOA6ELTq89MFAGqAkv19y9tgorJLxX4?=
 =?us-ascii?Q?FqZ7bOSad6dPwxogG0IeaOaFIf9sbBNOwSOdrvthXnp+RQUn5/50QwwyqOhp?=
 =?us-ascii?Q?i6Jd68Vi47ph7Ov4lJNNNmH3sKx5LkiO1JG/yf81GpYDcqV9HCaD2cN93n9M?=
 =?us-ascii?Q?a6N1maWEQXU4Rg9EdD8Nxuyq1ythjwymGrs+brtHsnqwEpXnriypP9+LIp9w?=
 =?us-ascii?Q?5RE8/dxL0g9c7AY40UAHwrQsKvZGL+hOVY5q8YdX6dulYFKeV2aLWkTRc7H4?=
 =?us-ascii?Q?M8wAMMH2n3hkcV2eEaq/SvZOgCH7bj9nFElxHXsT4ikdInkOCS8rhudsDbdT?=
 =?us-ascii?Q?4f0mpXgDPsmD+POwigFfzXwI+8PvB16ONKgSpqRWqrg+UKRaG9x07zJSRUhV?=
 =?us-ascii?Q?QooXnebLD/0Y5tA3EG7da/oO5G/xutJxEnEDNlf77env9KHv+zG5SanQMhiv?=
 =?us-ascii?Q?CPIyecnsOw+8NvpfkRZ5ueyMRDqbvUGDoToZK0RqB0W0xf/CdhZIUvna9nbg?=
 =?us-ascii?Q?IQLlwsoZeAzr1IqvUhu2EdIiQ2acxiTIY3BftNHEYOkSOaUANgb+LveAeAE5?=
 =?us-ascii?Q?zglGJMbz39pbRQEW63IL6NjWdcBBlb4CdPhjvrtlhfqf7oig296PnJA0Usrt?=
 =?us-ascii?Q?Q/pIbjLpUVGMuOekfuH/bJfOX7WMBGF4WNdwLysMBZK+WFaG8cZH6C1+fKbp?=
 =?us-ascii?Q?+IlQXysjIBilfR9qsimtuni8lmyQS836Y3KaKj9iVWYR1s64rrPawj3xMI9p?=
 =?us-ascii?Q?6/JFjsp1yxR6ikKR/NBrN7meM95f3R8Im530fQWQYxYaHyJd9pUb4FC4/O4D?=
 =?us-ascii?Q?BbqcUHV5shUfjmrKoY8SxVKobLI0wkV1ZKzbeRsHxr3J55DwO/dj3HPalWW1?=
 =?us-ascii?Q?uJAQVFrlMtl5lroybHzOVryLpOtR49urUOCL9eFw6cqH0trmjRufzyt/wqvJ?=
 =?us-ascii?Q?6x5G6bRKp/B6W1Qon0vEKM3Vhe3rNuJu71YdDxTivy4Ube7EI/O8jaVV3CY1?=
 =?us-ascii?Q?lRSM8GhHTJ0cdYOt2l7yMclhR5qAe3Kj5TorkfHD8U6IAXZDjxsl/QfOKNjB?=
 =?us-ascii?Q?LIBi9zpZVew0dyq3IJ/vnRpoR6gWj2UbO4TLwxGwUe9M8BzbdxNKNtFiSOrS?=
 =?us-ascii?Q?pyF5PEEnWyBoKF7LLjQpngKREIeEPkzvHvj5gRDA?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90CD320404670F418FE9A96CBAE1CCB5@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e52a04c6-94a4-43c4-9267-08dc1678d10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 09:52:13.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXc16xSJpHRHcg3uei0JffM+j1HNAKCnrfrPvLqeY6US49o3Ax8xJ8pwI2ftSC1to2rcjuRiBiQCEeAGl5o9zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7826

Hi Matthew,

> On 15 Jan 2024, at 14:49, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jan 15, 2024 at 11:00:35AM +0000, Anton Altaparmakov wrote:
>> Hi Matthew,
>>=20
>> On 15/01/2024 07:20, Matthew Wilcox (Oracle) wrote:
>>> The replacement, NTFS3, was merged over two years ago.  It is now time =
to
>>> remove the original from the tree as it is the last user of several API=
s,
>>> and it is not worth changing.
>>=20
>> It was my impression that people are complaining ntfs3 is causing a whol=
e
>> lot of problems including corrupting people's data.  Also, it appears th=
e
>> maintainer has basically disappeared after it got merged.
>=20
> I'm not terribly happy with how the maintainer behaves either, but
> you've also been missing in action for nine years (if we're counting
> code authored by you) or two years (if a R-b is enough).
>=20
> According to your documentation, you don't support creating new files
> or directories, so I'd suggest that your code has never been put through
> the xfstests wringer in the way that ntfs3 has.
>=20
>> Also, which APIs are you referring to?  I can take a look into those.
>=20
> The biggest one for me is the folio work.  Everywhere in your code that
> use a struct page needs to be converted to a struct folio.  Support for
> large folios is optional, and I wouldn't bother trying to add that.
> Take a look at, eg, nilfs2, ext4, ext2, iomap, NFS, AFS for some
> filesystems which have been (at least mostly) converted.
>=20
> Any functions in mm/folio-compat.c should no longer be called.
>=20
> If we're being really ambitious, filesystems should stop using the
> buffer cache and switch to using iomap.  There's a lot of work going
> on and unmaintained filesystems are holding us back.

Thanks.  I would have been happy to do that but it seems everyone else pref=
ers to remove it so I have given my ack for that instead...

Best regards,

Anton

--=20
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer


