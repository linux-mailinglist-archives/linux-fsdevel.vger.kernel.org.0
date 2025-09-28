Return-Path: <linux-fsdevel+bounces-62939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64300BA6658
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 04:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21E43B4AAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 02:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7212472BA;
	Sun, 28 Sep 2025 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="R2hGtX5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1034BA3B
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759026361; cv=fail; b=W2Nt1j5GVXhXaAgsa2/iVNH8JPTzZ5gtoJ8t/wmDGMnkvtB6PLfkzS9mp3HfvAf+L+NGwAXlXQFzAExbworI8Uv/uob5giUDPXF/Rxb7J+PSN7cUfg138lxnEqfOcmdTCU5/Cy1bp8n32nUpfEAuOrYTI4qDu8iJ1CcO589vXl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759026361; c=relaxed/simple;
	bh=l/ndNSbdW+uOXsDJ9rm7YtGod/WUshGxFgNxUw+WCQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLWu43O1OPGP7r+4nrk7lB1fey+vJlE+2b0GQeYXfwb2bYd3lNJ1fjDvAnDbKVVCjJGfpbIbYxRS/yAMdBpVk1Z3kmdTQl1v69b/GaPezPJ/qNayCJHbJg2T4zIXTpd8XkO/zbpvhEaIgWBzj+FNQ5AyrpeI1vIFlhPiI8UGwLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=R2hGtX5y; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S1tHan031784;
	Sun, 28 Sep 2025 02:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=3FfAX1V
	DnbX52QVWSPz7qsuF1PpRrRTlLrl7KmYuMPg=; b=R2hGtX5ycrWeYubGVpaC+7f
	F8gSA1xt28KZSXHOTp7uLH6YeVitYysBN6Igx0OV9pxb+Mz2Jh5Dw3eHv6OFtIg3
	niNPMmXQ1rhdz3f9IWANlgVoDKCywKqUEqR/+twzI9SMdHO/i+PFheJmyPGiFyj0
	kURpL02n4RpV7KQxQzOTYxOOw6q7U9RVNLru19rlRqjaOR0Wv265UuOB5Tw4JFho
	4ZM7RfacgTSeL/+cLHqCf/JN+7uVNrapEuSk4Q4eQAsW5nmK6YGDMqwg6p4Y/3sF
	pCADN2WaydXM/HMKjl67SI9k06gfmtotlQGV/tAS4bIgmvKWoSNDEHCv6/x9Xqw=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012025.outbound.protection.outlook.com [40.107.75.25])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 49e6swgr71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Sep 2025 02:04:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHbHdQr1v8P59A6G4tilDICjMtC9WkYIbqZ00UUrzW87EuMFqFZvRd1+1PJXF6MpEp/vYqs1dM9kZY7tSxA4Fup1CJuGexWc0QNzQz+ij/+eS+XBaed7I7gGLPs/T4VrZrO6dyuB6ACutMg/tZGh08yV/03E79hmt6A0iNCjQdO4mAQxuzigrnRIpVZ031wWf2+AP+pcIdLZ5uCqyej2l+UlA2iMJzKzepAEmP4oOBwzkQj2kXEJKVz0URx/lgeGS0pLeDJc0JmCS6h/ue7zMgc7mNMrzJWWH77T1QKLpPBmegqI42QU333EvQiaxjbh7Jn0lB83Bs86WM3hqm2rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FfAX1VDnbX52QVWSPz7qsuF1PpRrRTlLrl7KmYuMPg=;
 b=UFhGPVj3xN/27nNV+SpVlSfdO4r9JiqzARh2L4KHCBjK2IQaeaL/dUz9+sfgkBUYSHIi0Cx59kOuQjCM/zqLR6bURDJz+bDNqxJnp8uru2E70OHZes2DfBDEtD2z+WdobZaIhbYL1YX2YmbwIpCsubhcNORnWnWeWAQmZP64WQ0H/LlRlzanKKB0o29CWIZx7rx60ZzcyDarbSl/F4yVIsTARGGlWECb5CEMgaVoKU8dWpryk73/8n02zgc2qv5kfxiv/thwgOAqu0jCDAXARZPM6JgDdiBRjWdiNPiVwz236gMBgHLu+YD54qNVgmkkrncrEImCCENlzeHwV9sI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6334.apcprd04.prod.outlook.com (2603:1096:301:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 02:04:01 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%7]) with mapi id 15.20.9137.018; Sun, 28 Sep 2025
 02:04:01 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com"
	<syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] exfat: combine iocharset and utf8 option setup
Thread-Topic: [PATCH v2] exfat: combine iocharset and utf8 option setup
Thread-Index: AQHcLvs7qCKYHQXEv0upHuFHS5nkPrSn1pHK
Date: Sun, 28 Sep 2025 02:04:01 +0000
Message-ID:
 <PUZPR04MB631693629BCE735F5C5BBDC48118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250926153522.922821-1-ekffu200098@gmail.com>
In-Reply-To: <20250926153522.922821-1-ekffu200098@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6334:EE_
x-ms-office365-filtering-correlation-id: c31035db-e5b0-4674-e604-08ddfe334b3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?IspsdfOB6ELNGCuUjILjz9vrnjHxbAqjnt+TPYq43iNvvKnBdBN5ZzGbZ+?=
 =?iso-8859-1?Q?jZgTZdbWYpwBOLQl/oA+/4leku1AugoIuLLwYI7MPmgtKawh1iRiSvrWl4?=
 =?iso-8859-1?Q?HiQZqNJ51momvevXkgEyB+s/S/rANwDknO0oaVrwWf9FTggpaNSV5rFitu?=
 =?iso-8859-1?Q?uxuu6fw1bdk6nDgLccNm+uewSLSmCIdPdtqj/7soANF8L/E846iwf6OUMM?=
 =?iso-8859-1?Q?aGkLOiI90/+jrSaLNTSbLiJWQi/rAer3JEQVqf/cSibuLP7mHeMlJqZ1cM?=
 =?iso-8859-1?Q?PwQ+ofS/ifFr/oN+3nVWIL9EifaTQigiviAiQiGkAkDASIIb23irG+xSQ1?=
 =?iso-8859-1?Q?Lslq40GaMqVDHS8dI7lfsgVNDsGXIGmf0xoMFi+SvsQ6i/fzbRY0jsvYJW?=
 =?iso-8859-1?Q?v5ucqlcc5Bhsb6atUwO3X796ZuoWDJ3VqhZb122XGE++opZFhco8lQ3G2Q?=
 =?iso-8859-1?Q?kAWgaTAdldoKlgMwxUnirEwBmM8otMYpA/6wTb/N77aRZXpXVJe3uMmVki?=
 =?iso-8859-1?Q?mWvutDSr+onQ5OmG6BmOtYT4QzIP1pbn2iyRkMHPjHLKEueuSRF5tOwGrO?=
 =?iso-8859-1?Q?pBz12k32xF4yTaIYb52jkGEvkd4njMbppMkAU2fiuRnkxAB1O6bOHpdSxH?=
 =?iso-8859-1?Q?RAJ3Zr0YNpOXWJer2lfYL24EiZsbIu7LZLU+UOM1PfnoaTkE/W6No/CvRq?=
 =?iso-8859-1?Q?yNVynhw3RU6x4l1gmpEeiFzmGNGOjlghjG/uLaQIef/IvU5WX+8CXyBkHH?=
 =?iso-8859-1?Q?RYzjxhryWvK7LWzvfHjiIsNuArViVlD7EGK8dgs5jBZyWLX+tcbnyMGcrk?=
 =?iso-8859-1?Q?tOfMQcNUguOXS7cQMTVZCn2SffZHw6qgi2hif4dUuyocmmkxs5R99y/CVU?=
 =?iso-8859-1?Q?NN6d8lemuHwCJ4aEsy9pxmpGI05Wy+l/wzlj2AWh8ZVpAmBfQu5ppxcGCy?=
 =?iso-8859-1?Q?QgDcUKr0F2I1k0lcZ+8NgsEKLO0U+HYuvY4EKt7IrA1D07W0B6oL2LYyNv?=
 =?iso-8859-1?Q?N7CHKq2zCjPC7IgFwszNeTQBH0ToI+ChyFFt9ZNzmKKLEXxZrwPITj4JIN?=
 =?iso-8859-1?Q?SRYXjY6e5kfc9jg6Y3Ks+yd4LeIZli2534QuLishMeCfB8Sf+/vzUQV4Ni?=
 =?iso-8859-1?Q?kjWiM7HKD7j7cVWAwktc2Ry2ki6oU/B5QyCeCU4SZB4fI4yJQ5UKS+URWW?=
 =?iso-8859-1?Q?zgxN8qWHBB/435chRH9XrfKtrO7rxgSRdnVf7gAkAshFoCt6hjTlR6exxN?=
 =?iso-8859-1?Q?eHKCYWVf4shIVveqb3o5nemMPRafavxdcTsk1zVvrAOXMSE0dtZTOPU3zh?=
 =?iso-8859-1?Q?N1a4CAjMWH3aQuap6ln3G4w0WjCKuEg9RFY3mu+LDgpaN4L63/7SyWxGcX?=
 =?iso-8859-1?Q?f0tA7EbC5ULnA6mdnkXbelpqNo/2kwDi+gmf+hQeTAvGQlPzPX8HYjEjJo?=
 =?iso-8859-1?Q?noEXwG0CxCfceDoJ143D9HLapr3hMZqpD/yzMu+llURhziiJEuCoJiw3tB?=
 =?iso-8859-1?Q?eL+yLYtKEq574vE1WFjIh4TadNYvI1VbYVlJDtE3QjzA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NztEmFXVJH5MkysrzqIjYs38aaS38GLryYnNKMRs4/HiBdx5WP/6cZIL/m?=
 =?iso-8859-1?Q?Q4d2uJVCGPo67HCN1hiqW2nQ2er3pWXafxjhEEGUAMOJl5hVRkvHANOXfT?=
 =?iso-8859-1?Q?VhSkUio1VP0Ke6wBIb/xoy+GVMr1Uzwbsk/JiaYCjHnptsGRSKb0roinC1?=
 =?iso-8859-1?Q?VdX8U9UEYWHX8mKMM4z4Oy6hTPaDqkf8slPSpxVs6PzSzUpGF/t9akcmCp?=
 =?iso-8859-1?Q?w18UmAPSmZKVArI4oHx1bWDhbYuHdGcjpgUh/Kv4muDFIA+PgNgb5YYif4?=
 =?iso-8859-1?Q?SAnpUX0jBlwtHIfY10UME9OTlLyQmZ9qmRXafeVarQDeOx6jtV6lec5EUw?=
 =?iso-8859-1?Q?Qj0p3HKvKjsThfUYZRQh2p6fLaEVW0SXvuyPrkglNC97XdQc1S1m3CNh0E?=
 =?iso-8859-1?Q?XBFfve7Nq2s6dGWUcfXIQ+nqcqyzp1H+eXVmwVhgtSACSybHPildWJZMTC?=
 =?iso-8859-1?Q?NUcmcwxM+5xhzeY8q9MA5I2Zc5rcKplvZFXLd52WDXv1Xkw8BUOROYdFAX?=
 =?iso-8859-1?Q?DknJKODkPegu3a98JHOaZf9m1/JomY24KFGRmg6Oy21ooWjDWlPKas0IwJ?=
 =?iso-8859-1?Q?7H2kFO2kqYKUsNqTRgQRwjuMXz5/g1sY4VAX+jj9fKR/SIdijfNVCu3b8X?=
 =?iso-8859-1?Q?LXeBA3MeMG3hd473lfDjHL/fpQm+SnMyM57awhlPBgQ77URJ/SlJiV13E2?=
 =?iso-8859-1?Q?8yphrUspRJIGpHrljb5vLGAFNDbBbjTIhGB7uA7EGGENOO27SfUh6onCXg?=
 =?iso-8859-1?Q?EfF/F9Hpil5IOXFM1xOX0MU2MbGy8NjgF4F6FqBAWeCuesbuWayBN0oI6T?=
 =?iso-8859-1?Q?TBlgBBbfbs9xUejaV7DUtvuB5R1x0z27zn6wz/+1Ec8TZpoSeNOT9Qsrpc?=
 =?iso-8859-1?Q?gU3yiJhRwYI3FLTSdS82u7YC3vlFGbHaJJimnnqmodAv++/rEsik4gMPCQ?=
 =?iso-8859-1?Q?p+nMCry7LxvUV7y97oytBGr4A431TYyvrVOUAHAc48DVo2HJDWh2N+wW2H?=
 =?iso-8859-1?Q?NUJitK9d2EdV8TQkhHruobSx5+139qYPTPmfulJVjogp24r+qRpbaXKpn2?=
 =?iso-8859-1?Q?x/nWcLJTwTlJLyQWnVyHoBsiUdzQdYmnUgNdu4VOZczAwiliukw3V3P4Hs?=
 =?iso-8859-1?Q?VqIo8M+7f+LIMYQyQhlJfPD7Eq6BCngFcvtsNcI9Mx95+pSWRMbJzUAZKF?=
 =?iso-8859-1?Q?f7oxtu/xN02vLzyvghEaRzwwhllx1oB2L853Z6kAmG9P1woRkwD5ESFmlR?=
 =?iso-8859-1?Q?fFT+DhwSBJbpnvJWu472gs51WUtQAlL0EUqC+SAW43kiie5ts6mrooTt9s?=
 =?iso-8859-1?Q?gM9QndMi61p5fr2XvaUM6RBG8641ow0hWYAWJx8l6UZ37i3vrzDQtldrNt?=
 =?iso-8859-1?Q?FO9TghRV9SoxgkMY7hLrqOYC3EEjtF2FGG5aykOOt7yDoNSm6kCmrykK2x?=
 =?iso-8859-1?Q?TEXUyT5pSn5sVX31ck69Np1HVOWHOHi76HX+VOXzTYmX8oSIJD05Y9SVbt?=
 =?iso-8859-1?Q?vzzNpgEvhIgd8o3OpC/eaAaxUOt6VNdXfviG+QE/d5gPGsxr1iF3J6jj1H?=
 =?iso-8859-1?Q?5aV90ajBn4gDG2DsoMQ2cHkr4XZsaxb21d+eukGT/iFKx3lP355vgT0SFY?=
 =?iso-8859-1?Q?9qEgLwSzk4nOG/DF39mYB7iPkkaDRwpVzUSoTDEF+VB2LUAIRKtWSZmQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BBkH4hiahGe/Tmz8iPW81gGbZEd6B3C8icfqRet6XEgalYZ52aA/O6v+p+ccpkAToyxzMN8vADLeBWshyLaoIZMCSqBg5YluH2M/9RiodnvxWBB3ll3s9LfAzvQ80iTN00Lt935rantms4pIYaOuVjLiZfmpA1AoMZtGOe/6SYX5A1cd/rYNNPbziTBrejz2hWzedBY+eaWNHjwy6d73BAONIrypJcUTHCBiKVELMVhLLRFTW+pdt/eGDk9c0pdItgArfI1po0UUwMuJHe8hvJOquMmHQ6J8uNgQp6p6GYqDOs0DCSSPW8w6Z19kyiX9VBB2eW4ejk1LEzsKbUmD3RBC1MyGtLzGst0WzMT0jUc7kzRZI2SU/t3rBZ+mGM/7MOhIQUWP54+BMCNaUDk5joTSymMhWjsCDfCW84umnxocsEMZgHaFkQP000b3KYAC86p/fBVXfAwvhxlFbTU6kncayjHfZQduXRWUII/ognvTJAORcTUYr8Ye9p1LZDff0z7gh8c382HIzEBhUuX+edXt4SGKjllAjPdVBMBt72NiT0k4gSrnYTYmsIOEMsFwoxyJbM02/atnPE8fY3vPQTBJ7wKsC91RyRM2AsJdwvVNK40+LQGCXX3B2FTLlvv/
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31035db-e5b0-4674-e604-08ddfe334b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 02:04:01.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7Y3sThNmQtVy0jVhZImmTZog7Kswfjamh8n+H2oJGH5MwHYqFhjVrBYnd+fKWuNbiT1a5DoAt4NjwXaATjuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6334
X-Authority-Analysis: v=2.4 cv=Ro/I7SmK c=1 sm=1 tr=0 ts=68d897a3 cx=c_pps a=xo9RDX1PyNGQga/faIJz1w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=z6gsHLkEAAAA:8 a=Kzfy7N_7Fwza50EVX6IA:9 a=wPNLvfGTeEIA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-GUID: t4_xa-3Qk6qYCku6GarEx1xip2djDlv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNiBTYWx0ZWRfX5dONuPky3v7z Kgli1PXn94/hwBvOzGPo78EsQ3LZmHd7Va6rBpjK0sHV0KINnPFD24lOw4uX9jpFFCUpDGl2kDq aJyBT965ea6On5oPZDVwnp21bpezbeZE1/rL8RvAOiX+wjMUBjrgrptw7ntitWnODR5McUOTzjw
 Cs1WGbdGVCtinf2ISywd+C9pTlbNg/nMzlUwo38BzhntfypxoKi51vKmYNn6FKZX2aKiaXU0QCN 5vp4nvaQLjnsDrWVnQQWsUSgP7h1mGobGIF8z0MJXVxHiYh5Q1+Lfktf/bp8H+QOEPcValMJtLM J/WTZ2NZZ56f1OqDzjtV+sXmtUo5+dtOBHj7ewQtnilknzMzjau21OnpKxP0JOHtKcBDzakI6KP
 ZoWFrBNc2fo6MsaL+iSfLs6kcXJagg==
X-Proofpoint-ORIG-GUID: t4_xa-3Qk6qYCku6GarEx1xip2djDlv9
X-Sony-Outbound-GUID: t4_xa-3Qk6qYCku6GarEx1xip2djDlv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_01,2025-09-26_01,2025-03-28_01

On Sat, 27 Sep 2025 00:35:22 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> w=
rote:=0A=
> Currently, exfat utf8 mount option depends on the iocharset option=0A=
> value. After exfat remount, utf8 option may become inconsistent with=0A=
> iocharset option.=0A=
> =0A=
> If the options are inconsistent; (specifically, iocharset=3Dutf8 but=0A=
> utf8=3D0) readdir may reference uninitalized NLS, leading to a null=0A=
> pointer dereference.=0A=
> =0A=
> Extract and combine utf8/iocharset setup logic into exfat_set_iocharset()=
.=0A=
> Then Replace iocharset setup logic to exfat_set_iocharset to prevent=0A=
> utf8/iocharset option inconsistentcy after remount.=0A=
> =0A=
> Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com=0A=
> Closes: https://syzkaller.appspot.com/bug?extid=3D3e9cb93e3c5f90d28e19=0A=
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>=0A=
> Fixes: acab02ffcd6b ("exfat: support modifying mount options via remount"=
)=0A=
> Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com=0A=
> ---=0A=
> Changes from v1 [1]=0A=
> - extract utf8/iocharset setup logic to tiny function=0A=
> - apply utf8/iocharset setup to exfat_init_fs_context()=0A=
> =0A=
> [1] https://lore.kernel.org/all/20250925184040.692919-1-ekffu200098@gmail=
.com/=0A=
=0A=
Looks good to me.=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
=0A=
> ---=0A=
>  fs/exfat/super.c | 24 +++++++++++++++---------=0A=
>  1 file changed, 15 insertions(+), 9 deletions(-)=0A=
> =0A=
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
> index e1cffa46eb73..7f9592856bf7 100644=0A=
> --- a/fs/exfat/super.c=0A=
> +++ b/fs/exfat/super.c=0A=
> @@ -31,6 +31,16 @@ static void exfat_free_iocharset(struct exfat_sb_info =
*sbi)=0A=
>  		kfree(sbi->options.iocharset);=0A=
>  }=0A=
>  =0A=
> +static void exfat_set_iocharset(struct exfat_mount_options *opts,=0A=
> +				char *iocharset)=0A=
> +{=0A=
> +	opts->iocharset =3D iocharset;=0A=
> +	if (!strcmp(opts->iocharset, "utf8"))=0A=
> +		opts->utf8 =3D 1;=0A=
> +	else=0A=
> +		opts->utf8 =3D 0;=0A=
> +}=0A=
> +=0A=
>  static void exfat_put_super(struct super_block *sb)=0A=
>  {=0A=
>  	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> @@ -292,7 +302,7 @@ static int exfat_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)=0A=
>  		break;=0A=
>  	case Opt_charset:=0A=
>  		exfat_free_iocharset(sbi);=0A=
> -		opts->iocharset =3D param->string;=0A=
> +		exfat_set_iocharset(opts, param->string);=0A=
>  		param->string =3D NULL;=0A=
>  		break;=0A=
>  	case Opt_errors:=0A=
> @@ -664,8 +674,8 @@ static int exfat_fill_super(struct super_block *sb, s=
truct fs_context *fc)=0A=
>  	/* set up enough so that it can read an inode */=0A=
>  	exfat_hash_init(sb);=0A=
>  =0A=
> -	if (!strcmp(sbi->options.iocharset, "utf8"))=0A=
> -		opts->utf8 =3D 1;=0A=
> +	if (sbi->options.utf8)=0A=
> +		set_default_d_op(sb, &exfat_utf8_dentry_ops);=0A=
>  	else {=0A=
>  		sbi->nls_io =3D load_nls(sbi->options.iocharset);=0A=
>  		if (!sbi->nls_io) {=0A=
> @@ -674,12 +684,8 @@ static int exfat_fill_super(struct super_block *sb, =
struct fs_context *fc)=0A=
>  			err =3D -EINVAL;=0A=
>  			goto free_table;=0A=
>  		}=0A=
> -	}=0A=
> -=0A=
> -	if (sbi->options.utf8)=0A=
> -		set_default_d_op(sb, &exfat_utf8_dentry_ops);=0A=
> -	else=0A=
>  		set_default_d_op(sb, &exfat_dentry_ops);=0A=
> +	}=0A=
>  =0A=
>  	root_inode =3D new_inode(sb);=0A=
>  	if (!root_inode) {=0A=
> @@ -809,8 +815,8 @@ static int exfat_init_fs_context(struct fs_context *f=
c)=0A=
>  	sbi->options.fs_fmask =3D current->fs->umask;=0A=
>  	sbi->options.fs_dmask =3D current->fs->umask;=0A=
>  	sbi->options.allow_utime =3D -1;=0A=
> -	sbi->options.iocharset =3D exfat_default_iocharset;=0A=
>  	sbi->options.errors =3D EXFAT_ERRORS_RO;=0A=
> +	exfat_set_iocharset(&sbi->options, exfat_default_iocharset);=0A=
>  =0A=
>  	fc->s_fs_info =3D sbi;=0A=
>  	fc->ops =3D &exfat_context_ops;=0A=
> -- =0A=
> 2.43.0=0A=

