Return-Path: <linux-fsdevel+bounces-9096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3513383E1F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B684C1F25CAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B122309;
	Fri, 26 Jan 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B/1ENm8v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z1G3HdUj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27B210F3;
	Fri, 26 Jan 2024 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295087; cv=fail; b=cr2gbhoaxlN2gdu3QYZjylrCaEC8b6rFNgrowbHrerJ/WTuvnsCu8dfev6hn2QySmNSiAgzeOMo6UHrlnNLw9FghqAInWU6qkzl4WjNTtkczidzUf47Nuv5AGdlTmWY8A2GiCTkj4EQ6/Gs6jgdTZa0KWygfx4ZKhY+jkJFfN9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295087; c=relaxed/simple;
	bh=iMS3EWs6zkO/NLOmu4LLnw7b4csfJJDeFTcRYTUeGws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAeu5gqOUBm5hz+3NHImsX6+vpyCHH6Vl4gh9bm2x0uOwVIj4fxoahySOwh6BuLg2w3AKPznOrGBrnNumsGZMgoKCPJTsi/RIGAKCrWp4ugXlZO0VPF4ZEvjrEfpcM+LYnW2DeqJGRetgbDcMJV1cDYqxggORwfNW6BtEc8NZ/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B/1ENm8v; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Z1G3HdUj; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706295084; x=1737831084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iMS3EWs6zkO/NLOmu4LLnw7b4csfJJDeFTcRYTUeGws=;
  b=B/1ENm8v6u8jqRfOXUuudNaGdi7cmQtLHfCNxIiVos2rs7MZ5wsUj3OG
   /JDJYu9SHRcq4Cx8On4ces8mDOT3n0BeRQ/bLFha5cP3Dx7f9WpJxOSiS
   2+YJ7rbKZuXXMI6gPcnays9u54KYyQk5YMUifWRajKytTUhNUm5xkEuTh
   0nrx61O57xHiAaelLif8fMyErWWwwMfeDf2R4DSYTxKem84liHYYP0zzX
   EBlamYKv/FzTje8DUfRPHQOVGZujrKion3P2SsOIRIGNUV7mi8GJHMZGT
   LtMZStyq9ezcfpcnV5cp6hb1cRuseZ6F11fKCP7xFzxR1XTpwic2pooqF
   w==;
X-CSE-ConnectionGUID: c2S82bcVT+u+kDkYbHmiHQ==
X-CSE-MsgGUID: M0ljXcFkQ0W4Lfb+AcXDnA==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7770922"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2024 02:51:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhXzRxkGEBxRIRCW/ra6pMWI1zur8UrQuMVYEfPIs0bgP3ENYRdOvGYlLyblY41ZjoaXhdHDSiq4wQ10Ut4HDynARkKJeXPlEtZb5tIlifocuixFmYCo68gqrMnmS/9ZwlY5pTTCN1mVQz9diI5USU+gLPfdSPHBmVETt6S7aYXQI4btElXmQiP3Nx7/PllPMD5hJoNtvMY+4XzV1eN/QryOd1gN6hzISfjYkPSrpP2cmwEwV1p7x5KIWKyWJqlW2ECtHjiVnGpSeR7TXWU2Mi3d7KcsLk4EeG1FS60U0aOTINruosS93mkEaMo6pLKXXNSLekERQfRnBOoMNg90wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxH4q1vYtzCHX2hSo3XrJ/5isbzr5V2RbE/cOSCm0VQ=;
 b=Xpdneszlv0VuJVbJxqaqtjbyDH33HKM03/NxQc+xDvtu4xDaFFn564A2dqFYmEfJXijD/zvc5qudR2TM3axQuJw+CxL+q2398nC9KCP+ka2VF65/Amc5NmZd42Tu4JTRCfMhDRRU8BwZOmbyBnsX3LlB33kLZqaJGJZoc/tRHaV/Y8XgzN2augi7fTb1MuVysI3apunoq9+5tpx3QFKcgoSuyBFozSPxConN7SQUDwE4JF/Mp7GMXlh1KJ8IHXHT1zikdsfoRPJQJc+ZH9VtmY+wlpiVWtzChp2ndjxLobol9kqpLtKC8ZMAGIq2oNJYRZ9Gsi7qa+0LC+6CH8gb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxH4q1vYtzCHX2hSo3XrJ/5isbzr5V2RbE/cOSCm0VQ=;
 b=Z1G3HdUjPCNZTcU4yGh6IjCoENnVOIoQct/8UQHWEU7P5g2IDYsMWhcsncSR4eXbGqJccYM3ffbeYHJh37oM0EQyf77l9r79dAu1OTZlnkraaXWT/U4CwH+LzXbKVfRzviUqiaaIhanQh037Fc3VPjJpZCfPdnqJup/ueDOfz/o=
Received: from MWHPR04MB1040.namprd04.prod.outlook.com (2603:10b6:301:3d::18)
 by SA2PR04MB7593.namprd04.prod.outlook.com (2603:10b6:806:14b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 18:51:03 +0000
Received: from MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::f955:275b:3305:4440]) by MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::f955:275b:3305:4440%7]) with mapi id 15.20.7202.035; Fri, 26 Jan 2024
 18:51:03 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, Damien Le
 Moal <dlemoal@kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, Linus Walleij
	<linus.walleij@linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhaoyang Huang
	<huangzhaoyang@gmail.com>, "steve.kang@unisoc.com" <steve.kang@unisoc.com>
Subject: Re: [PATCHv4 1/1] block: introduce content activity based ioprio
Thread-Topic: [PATCHv4 1/1] block: introduce content activity based ioprio
Thread-Index: AQHaUFBnGykW+CDLBEeg2i74DPeGorDscJWA
Date: Fri, 26 Jan 2024 18:51:03 +0000
Message-ID: <ZbP/FRGfkBrtAm7y@x1-carbon>
References: <20240126120800.3410349-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240126120800.3410349-1-zhaoyang.huang@unisoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB1040:EE_|SA2PR04MB7593:EE_
x-ms-office365-filtering-correlation-id: e09ba746-748f-4f05-d326-08dc1e9fbf14
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7x3pk8eob8tDggpPzoEx83R88FmZ7nuzZAceusyVYAxhb4GQgJ9x9olVflYlW6QLQWJ0pMsTJCNAx2FO6Ovv3M6Hjra4pKLXNZUYggOQfN85X6Tq3FC7ybcl1SUghwx4PzbdLh4xR8ps6/b41qYfgbZJFeaoNob6CJT6p37RgoChnzstn8bF+jtDqFADZDlvgCzODHWaItb+ofw0i5qcmMsrRKpmVdOzHJIhAcRZCCClD/SdMLSmX1XaeW5WGn7yuDoX4BpzSQSzr0eyL8Vr+A3zp1MywRKAFnd+M6GhHGagREvdDObf4GR25BpoXKldWtilL+CrMkVZBJw1ewgvlhU7tItc1m15klWnSnErN1K0B1I6Ej6qabxOUSUdua0V2d7t/5t6lIR+Ji/coZ/BPE/bu2S7OsybqqrDJ+SBCskfnu/fjgZke/wCoIiKgX4zCn1bn/i1r3qF+HkX0065bBsdxZmBReRVs3iBTASCmMWlL5DA+UU8smqRuXkBtbV4sTwGGPxonuxG6DLirXjiwsh7ORA3s783TxKHzSJFZIprDhoJBjLLgHpC01VV7ZMOJUbJRIEYWs+h/HUX7Pc2RL6GKn6BiMesEwMw0Z1uLPeCiHB5ANJRsqLV89Fxnj4C
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR04MB1040.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(82960400001)(86362001)(38070700009)(122000001)(33716001)(38100700002)(26005)(9686003)(6512007)(6486002)(6916009)(6506007)(66946007)(4744005)(2906002)(478600001)(66476007)(54906003)(91956017)(76116006)(316002)(66446008)(64756008)(71200400001)(4326008)(66556008)(5660300002)(8936002)(7416002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ghhiS+2iRG/nVLyPdGXkv0aCsXaWQGbRRPgPYyi9ehxERvu7pMfeCyXmTW9B?=
 =?us-ascii?Q?QSIhSff5z4p8nXfwsOLWUqtN8u7sBr51sMoUr0MS3AlkIzhC4R4V3XZo2PZe?=
 =?us-ascii?Q?KmQFpDEake4awf/pael442ml27ec686aNPU8gNZ+cDNeMRhA2cwJ9p2BZTi9?=
 =?us-ascii?Q?8EWJnqpaus0ye5wPh7Q+NyPtLW7FffTNLFP2jOEAdXaFXFFr6qtni6XmuHhZ?=
 =?us-ascii?Q?Duq942Ibyh4/f17sGnhvG5RjjVYwxsx678E/WjpBxuzi+fvL198vHdpxN7xv?=
 =?us-ascii?Q?QdxJu9ZSIOMQyAlhaPUsHcacrjXzGugvmeSINGoZawto3QQU4kXogGs8Q2Ow?=
 =?us-ascii?Q?nsqFvl4MdDG+4R3ICfDBq/lgnCFW7gx5IlZ99CulOuCQszAIX07JKiI7RSuw?=
 =?us-ascii?Q?+SamaWx3FiRW8mvtVaEdQ1Im0ufxsZFZLyXoMZf25y2xWYfYxViSycSAmvXc?=
 =?us-ascii?Q?/zNyvhpNm45WtBVa/QXW4VXpWvVU0g3l0TWTiC/UgtDcakxvwX9jItv10c4B?=
 =?us-ascii?Q?WBwT9G8SHW4ufTaBdVr8vI8wO8TutI8+RBmdNlmi/rLJ60h3h55x3zE/xVND?=
 =?us-ascii?Q?RDAxxQyQtcGXGh5bYw5sWkGQxf6aAPFli+Ni5lLu8nZrUdSTJaI3AO/7w7lB?=
 =?us-ascii?Q?GFYh31tLDC5/Nz1wypJ8lnh4IrUGNPTBmyyTak5bq7lrUSghNYMVl9QgG7ev?=
 =?us-ascii?Q?S4Y5vfh1RUQ7OgNJpHJT701fkZbMqld+DC1dP0/LW7vGxtZNhHmh7EI/FNh0?=
 =?us-ascii?Q?x6nASb590JxHON7EX0JtMXv+Qwekj311kb+qbWMveZN7XjpAd9C6EYJid4U2?=
 =?us-ascii?Q?GWFVIJDeo/1RDnQzeze+ABzkU/j+if0GWqPmA7mCcT3Q0urNAVAtEyxPJ9x3?=
 =?us-ascii?Q?LLFcOD1/ERnhZo40YfCfaKHaBM8VHDteNrw7A4wjHJlZpscRNNjWShUx2wOK?=
 =?us-ascii?Q?wE9VRlZU5YBFlOaO24BBoBt5Rka1Jo/Et16CrU6/F9bQFy2/UDY78Kc6SPao?=
 =?us-ascii?Q?RWSGTj7fpi6S6VEzdhSNIW507AFFzGdRQUq/4cdfVpVmbdo3rhEK2tswcjzY?=
 =?us-ascii?Q?gSIe6PbtuZ3ySzofCLJIbsb+24NZ91MvPUoHwNmt1lHi0oQDT5709t8k6de+?=
 =?us-ascii?Q?wYdjwdf35Gp+139858LAj/viOZWOPWAGlY9a5eOYk3fc0lMC13LMFe6crSRL?=
 =?us-ascii?Q?BerrxGufo4A+C1vdGOaTMYQjpRVV/ZUIddeSI53zksvduAx/7TF4TjvFsLcX?=
 =?us-ascii?Q?q0ab0jY3stspckc0l97VpvIHzZcoBGFOmroP8icxJTQbN3tQ2epGhy/0fcON?=
 =?us-ascii?Q?utnrqZON2iJjWXbWDLfbNni+Zuo6L7eUOv0bsN/sSs1/Trve30kBvaa+tVfo?=
 =?us-ascii?Q?MdEd8FYS5MbIDP1BoBYm5bRE+gCFFwd8RV7RTUYSgpU238btYV3NfLQCXNr6?=
 =?us-ascii?Q?pGm7O/ak0zsf/ic1IKpzbqm7trAqB40yjzCODbWHMubvehbHpjidzaav4Jx2?=
 =?us-ascii?Q?yTpxzMoiRuOTy5iuoZdjn1A43IeWYc/G+pJub74aipD8hZh3aZCYMfltAmFM?=
 =?us-ascii?Q?tnpHEsxrzNZxGxh8MJBtUdOcMBIOvcbK+i1z5iOfbl+/HGKF15xb1rDXRT5b?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B173C9B9FAE8C447A01184D8188A8F4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m8wmnPqls3qUZ/ai0gPNtAmbLn5Ka4ObZ/LR8x8PLUDwNUCzogGDoWpI9wcINzFan0uWrW7i2Qonq7kuVd0Rsg9NGQgRTGn3Ch/xqbL2coPCnI59lC6HLGEm7Dhu6ut/TrlUGazVnrkRlLGklsSUlxNiXIa1jfXDrlN57x/Jw8j7LpfcHwqW1D8RONx85NIsVh9QhxB3m43ok8REqi+cZiU4O7UudoMVTQHTLQg6V9Bzc0kmEfIWD2N4GRITITRfwoojL3ELTa6iytIFsJ6wCOnrWmCSZnLbcTwuA/qls0inx9syd+mY/KgBTfabSGEPsM2lfIcZVsBFKSV5nXhJ8sg5QmG72IfOUvE6jZe0Arg4UHw90VNtY3wcB+Re6N9fn7ZNgHxC/R3HCT2HSOKfBgfJg43Nf94xraIY48vip6xt+vHM/J7Lx9j+YQx5gh+EbcSypuXxI+1pVBEHh2tE9A2SWUe3tFR9YT0C44v1JB7UtPz7wpdFLsz/MGGfYFvhhu1L/ed9c42nsLaWFAGQVv6OVjdElTUum24zNzZCxmCtet6i7ComTzGrZcAhIqB+9N2/vg0HJSvHZzGJpeYU6VtWQAoiLjaVWz8PQX0q3uO8jt/1Yr552h1FikOsE5hM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB1040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09ba746-748f-4f05-d326-08dc1e9fbf14
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 18:51:03.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qvw5hCM3earYEWfKGrg1GnSElRjenythNCwEMXP4zvMkVDV8CksVo0UCQyFyhJc8QZMreApRFCbpKC06dp8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593

On Fri, Jan 26, 2024 at 08:08:00PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

(snip)

> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -71,12 +71,24 @@ enum {
>   * class and level.
>   */
>  #define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
> +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> +#define IOPRIO_HINT_NR_BITS		3
> +#else
>  #define IOPRIO_HINT_NR_BITS		10
> +#endif

Remember, this is a uapi header.
The ABI cannot be one way if a certain Kconfig is set,
but another way if that same Kconfig is not set.

What could go wrong? :)


Kind regards,
Niklas=

