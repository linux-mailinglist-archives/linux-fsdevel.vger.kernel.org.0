Return-Path: <linux-fsdevel+bounces-58230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B57B2B5DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DB324E1E06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBD1DF258;
	Tue, 19 Aug 2025 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CdnDemJi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804743451D0;
	Tue, 19 Aug 2025 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566480; cv=fail; b=RPdPg7pTUzI2HLmOqzFvmuofJaA0iXQWxdHhfC9VDL05Rk66VX0D4lfKoq4Os/y6TaK9t+zRCjbXc4ULhb0d8zffCUZ0NaIriao0bG5anp0x66GHGs7irD0Qdn/prIOBDQD/dTnMGSW6uunI7cjdnUNC1+5pzkz8ypQPPaq0UM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566480; c=relaxed/simple;
	bh=mGQERiaxgFpu1SOz+QoSely0/XF+fAfFnj15ZQs6ZBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=US44dYY1JgShB33y412D9aSoW3yNJLEmNEbKiNn6BO1b6YPsYSqvjXMOW4mV3ueqTkJcUxQ9zpA7N3WpEMv5wHJMoKAmwpRPMC76U8Fx35dLuhdBfqTacKZXqw9DkXHP74zMa4DWGEyw+9qWe0kff3wySo4Jkv+FU9UYRn6/LqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CdnDemJi; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INZJTR017767;
	Tue, 19 Aug 2025 01:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=KeZQxRc
	O241MpXE4Qh3EoZvvw9OmI+YKXppN/6x48DE=; b=CdnDemJiahNIDeyI2agspii
	oix1TyEZf6ipFkvSJ9So7+0WvJqenu+gOJnb/k5clwfjTC5NR+TSUPtN3Z4giQRo
	9XiOmyRRQow8IJV3uNrcjasvkW9ho8gLL3i9J5WL2cMy24CoQGpOHD5TIkgQA17f
	fjegMlxncAysf3BmE9qXwVRFIXFi8V9uVnMM8+s9A89mXxdrAg0vtqXgtx2AwlSf
	J7fO5sSoVq1zIwC+ojekafzDEw4OZ4v3VsaxAosqViauAH6YQ+1Ng7XBICqt9ll6
	AoOB0tc0GvRREp4Nf+TMOjTtKIwbL9Kl9IX3XmxrouQHg0tUTmycs76LksYfnFA=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013054.outbound.protection.outlook.com [40.107.44.54])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 48jgv0abe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 01:21:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBGGSsGnMSuttJbndmvb0X+YoIHAjT6RExJJ8hyDcnZTc+1mQFzDPyXWn92xC8uP/5MH5lOUWFC+fWY9WHAuSP1IYKi9C5OzlelmoUe/XlQ3hW2dYquPfjfHfss2UBKg7O+fdJIIXWSD5NOwTQbdcyJhCKWAMxVTLhtDZjAehZAioDH7uUCfgdhXzl5r8V+yn/X+eCQI/fnUFhzscPCQSjKo/AEA+qyR8aSmpjygslfoqbhsLXxDDxEc9VZ5CaDv26x9l4s6aZxeMZnedeZ6gxDxM5MqDOxT8vf3GiEKNjUxNFAzjla7tLfhy/aN8LlA16txXJzqAOWtU7k9D7GSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeZQxRcO241MpXE4Qh3EoZvvw9OmI+YKXppN/6x48DE=;
 b=Wq49P9ddgfGIOc4JrUzVqsXxJhkKfvGVnyF5IvTEq2Pr8TrerFWBhj12a7xqJ/GgyLCewHpmkR5+xJeFuNN74mXvHOq6UeH17kYz5EUh6/syXGRwZ8ylPRXAPlGIOMp3IWFgPaKLbRG9MUCWFxvmzqbWEpXYcIgQ8aHH3kGd3vsaz75NWUgEY6//eeMFgNhlCF9+XKKqvQ7A7EgloHEPMesFouNY5R2n5d48Wkt2y682kWcBDU40bn4ujfZ51fYgG7n7Je70dL57rX2CcawKP5yjAzskR6X/sgkUNOhqxUFR5yiibCHPsKpgusXEbibkGplgm/4hx61lBlw2X00QEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6582.apcprd04.prod.outlook.com (2603:1096:301:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 01:20:47 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 01:20:47 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Xichao Zhao <zhao.xichao@vivo.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exfat: drop redundant conversion to bool
Thread-Topic: [PATCH] exfat: drop redundant conversion to bool
Thread-Index: AQHcECJ7ZqfQ0Y3OPEe/47/6mQyy4bRpKfW9
Date: Tue, 19 Aug 2025 01:20:47 +0000
Message-ID:
 <PUZPR04MB6316487B10F6F2F62C0249598130A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250818092815.556750-1-zhao.xichao@vivo.com>
In-Reply-To: <20250818092815.556750-1-zhao.xichao@vivo.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6582:EE_
x-ms-office365-filtering-correlation-id: 77b78e98-02f5-4095-5621-08dddebea080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PA26CJBpibtxoAEmh8gXdctWYDxBoMoStAzWwnYqvcSbsbMHE5ppRraq4M?=
 =?iso-8859-1?Q?ew3rbC2opcIe3f3AfM0NaXIVStWFMHyXqKK+kfGNNijASg0jIeo7/tf511?=
 =?iso-8859-1?Q?O2hstZK6gKJ7NSQUvATdhMsescZBTsVVWdBfXqEbKjhzGa1rLpdU+w6dvI?=
 =?iso-8859-1?Q?+Hj7FacHnWImf3kSXI6MuaA8hieW5F7V6j0yPWhI1fjMQy+G5OmxVHP/PR?=
 =?iso-8859-1?Q?SRc3LNcY/D85Rgmdx9JXIv5rvyyXXyIyRpWSDFpiQ0qt9KTcmxZktBtKbO?=
 =?iso-8859-1?Q?zhxnNwlewqcZJddkWeh4QJdAzAyA06+qOuEAesW4Ez05xEBMFjxONIrL43?=
 =?iso-8859-1?Q?bh8Fm665YAOrHfOYCvZJcVp5xE2ch+2ATnbKlGtcyrp8MEYxkR9bUVyNyA?=
 =?iso-8859-1?Q?JZnvHLmhW+s5gNw/votpayxTmV2ttxurXarXuP+R8fonM+FGAWsUKY3kBa?=
 =?iso-8859-1?Q?hNYpomACy+mhtkNBc9azhX66sh2tRzmtaFKmdcHKQeb3gDW62M8zBkm5tn?=
 =?iso-8859-1?Q?P5g6F1J1OTWTrVLFZleXrcnnLxFDNwuNpBPie9t9R1GrD2j7OEIf7v+tjC?=
 =?iso-8859-1?Q?IYg5RlF6L0Rp4L20MhOWqCz6uued5yuKFp6JEJqGJuy6KFtXrqx3NqFRrV?=
 =?iso-8859-1?Q?K0jxlNP2CLfSF5XsbXG8VEWGgpUn+MmfXJ5HVzF1xOZeeI+M34Iad/MAr2?=
 =?iso-8859-1?Q?s48bp1EKeaxOYvzC1zjrvOhaGX0Pemom4TRnXPfaOqiAdm2qfzYWrxFrmn?=
 =?iso-8859-1?Q?aDSQndfX8UVCGThU9acrblz9R/0PSeKvcTwsMQjNJWW9zwHnGcqDytNj+V?=
 =?iso-8859-1?Q?N4kN6HuQOcw6xFhQCTM7ZTdgPd9ByJ9pgboRgsofUbuq1NfkB46ZwO3SfP?=
 =?iso-8859-1?Q?xU20m9Hr8ZK9PtOym4z5Ny8oY9qYdjYbqfxhN17fPOhoLxFl5sTFADezGp?=
 =?iso-8859-1?Q?vHJhnm9dnAupJbUxV39uQw+ps1bzZswuSmR/t+jp+jo3yDuLxtncXukuX/?=
 =?iso-8859-1?Q?geuTszpfjL7WbqmXEAo0ibLCxOAub8b8Zb8Vix8umYKqpDsvdbG2ASOVz3?=
 =?iso-8859-1?Q?+uiuI4aC24CODZVcFjUz31d2rivd2P+EyvrorsRcCJXblQOJmlZJXsf8g+?=
 =?iso-8859-1?Q?iJYUxjWCvUF8krPbT7Xk7i4gybAqEITEHBoEIum+mC0/yvOVZsFOOsivD0?=
 =?iso-8859-1?Q?5cKZ0g3+NmWAFs5bGCPNQGbNq4Hpac4O/x0z8Xmf1xe7dTV5MvrwfqdR0m?=
 =?iso-8859-1?Q?KFnCnVhBIVZOxlD8rs2laVT+sTS+cRkvrUK/93Kt0crS1l/du0M6ipFIs9?=
 =?iso-8859-1?Q?gAR56uu3gy1fb9uk4Hv3wGYw7KKJd5X7PEUg55lCAsG5aNu5Vfs5rnxMMQ?=
 =?iso-8859-1?Q?ldw1OLu8pAWSVPJ8C9beKL+9keW2FtgD1shXyaisIIWSEFi3lv3C8mDfgW?=
 =?iso-8859-1?Q?iZT4qrpXAP08wHt8TjOPNvOc6IFJiutKGiEtYBFVuuKPtqMUlOZcI4TXJ7?=
 =?iso-8859-1?Q?akLqOxoQHkWPXtOPY+v2NPKxt71P4NKc1Ib7PzwZmRmw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2raGMYrvSHmTu7Bwg5YS+hchTozXucZPrMrCsH57MRgiRPqPrKdISgYL/p?=
 =?iso-8859-1?Q?pi7MrTfORd4OvGhfyoybzUpIpyCLNnYnJHrtH5kadqwtV02GfGmjcOBvic?=
 =?iso-8859-1?Q?7UbhydRAcZVQheS3cR0Bsty//p+0rAL1dhqD+x6Zs+5uIsrCQlL7jxLOdG?=
 =?iso-8859-1?Q?7Fa+X4j4Ir3zzp9UDToKzVp/eb66QwuPcUajKcyWgUrxaLIN45WoyBCE/a?=
 =?iso-8859-1?Q?JLHZYlNBaeyPzGEHr6KZGqhSTqVeMdDGVpymTS959KRiqBT68jqbTkQ2hY?=
 =?iso-8859-1?Q?KTxiUyoLBGDfghCIxEl1u8u+MhPKooHDc5fL76f/d9C+4YbTcu+4zqF8Lv?=
 =?iso-8859-1?Q?WChK+1r5U1r9n4u22kdAneD/DQ/KsgpvzeG9WMd731/gU2atN7u8Ms1mhX?=
 =?iso-8859-1?Q?hQjLbCkhRfFfGQ8qmEdw2c6wCrLwSUkAbz/Y20fdtejGi/XlUWkX9qrzNc?=
 =?iso-8859-1?Q?94sTEy0RAZ6UKlmpw2QTJ7QbFlQcTXOkwCP+Dc6WrdgD38Hf82pBn8FTaZ?=
 =?iso-8859-1?Q?2zHTKSk/IPa/OouVzah5t2M6LPLi6+wL+GYzQ1N3S256VhySrltuGLyW7d?=
 =?iso-8859-1?Q?gaNUrkfmaGQNDmjPnQATSs4T7mjXKEEdGyY66slEaT+gKldv0BYKeF+9ib?=
 =?iso-8859-1?Q?x4unjD39tFKxlXXGlFt2F9vdJumCSdjBNADFNDYqiKKDocRwMkJHeewzvw?=
 =?iso-8859-1?Q?axsqhVUKFKgdKWA3ny9980aaDFY6G55PZahHLWEvSomhiIa13QJJV4hVoj?=
 =?iso-8859-1?Q?mFSYuK3J+0T9+LVY060q9uvRLU7kYXUu1unqfvioJhPQZDbgMQHCX4Zw6o?=
 =?iso-8859-1?Q?cTMZXqmt0ugmylYDQ2knYIIDLfHTkMGUjZKAiOeOWPfbFFtOXyTbVjiMsI?=
 =?iso-8859-1?Q?LYvewMVvwI1rxuUZN78C+khPVh7q0Gf4wSg9Ck4VlL8nFSNO0DQBwXJs2Z?=
 =?iso-8859-1?Q?99EJduO1a2HsYxko80I8pGHOJEavBi5x9N8hXqRpopElTlfeP2aSuLAqvs?=
 =?iso-8859-1?Q?4R6vB7NZ+QXIvhCWdgCFvMliz4cPLE2mkUQxiGmzOcH5WsHvOkz6je/aGZ?=
 =?iso-8859-1?Q?Dt2C1XjoLEXrNfnHINhdlq8PxM2vWBbBA0VLtWjBrQkbhL62EDluDYreYg?=
 =?iso-8859-1?Q?eYeBsbYPMj0OA4SF5hmniHxCdz1vefswbZY3o00JMle3f8uuCzdKlkuA8y?=
 =?iso-8859-1?Q?dvH3xsJ+oBqeiiwdSqXo3adeKC2O1YALITmuoDlQoYE+NWdR1zrRBUeGYk?=
 =?iso-8859-1?Q?gfH9osHHYkcKuXMBjemxMshr3jzFONzM57q40Hyq16lf6P4J8azFxSlmDD?=
 =?iso-8859-1?Q?JkipXJqBsGbljR/J+NSQe4p4Yp0Ug+b/GMcBUgUO5DS/1Y6/ekYxU+tKi1?=
 =?iso-8859-1?Q?o44pLbAcI5ktwyvTjw3sQnNTtwQD2nn33vFNW3+ErMobFSoKcSvw2viz0e?=
 =?iso-8859-1?Q?zStkQG91vdJI0rEsWlGSm9U5U5593sQuoIKROykkIt6xCTnbJ29qYNysFO?=
 =?iso-8859-1?Q?wP9bd4INgM2p2c+kIGIWGin5EsdPbPoU9h+oUcOY0u+aFNFn33FVv6DKvB?=
 =?iso-8859-1?Q?mbFyicSugN5fTPCoC+DNGGiJIBEG+JdjhsE/Y6SUdrbAFiu6RCXdxFhucT?=
 =?iso-8859-1?Q?0Sx1jNzvKphO7z6osVuVOrttf6r6fKCiV5cq8mr4xQICN+w3lL2fXzYU1r?=
 =?iso-8859-1?Q?IWMro0jt7JLFKqtUCmk=3D?=
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
	xeI+O2ZzuwDLQMBoP3HsuTkaCIv253tg/Z/atzNC3YnSaEbjxYpM50sadVQXK4EWfC8w6kkSM3dyTAVfTHDuvLgEK9wim/Nf5OnKoL+wqrqeo1SFSuHBVKGG0HX4Z/Pg7DaNNN5O8WaAOb01QuwM7oBy8e7CEtdS149PihYVLC3vydieRTOc02XOHEIcBUSlbIH7YMKsVuhj/lk/815kZJ4rHuu0et52wvNLmjNJlIj/mqRRiO9JKJ3ArheJxCHq9NAyDWtOxKKrs3iaCxiJdweESTDszSkcJoBBcgYsLZjH3/Knq0GKE7AxWxYpZOulwiGoKfYYfs9UtecgQFSiCYf9t1nXe0GKB/ePrX5CWq8Knvdb0Tyx+kNp5f7Qc2Rd19xLjrclKqEfM0kOpzeZS1eA9DYsDXkf+qgq03oZ/Mxt2yaRhwqMynTldVMrX8rW+YoUEm/i2OpzFX7xQBLDHRR/8kfTa+cc2SXNNznJuNAQn/Och/xIw257vSMXegMzrKf8CVvqyZcB05v/MTfolbgeBS0dc9axBK/LoyXvggSAImCTsQv4CaUAQTdjagVV/eM/TMqY2xSOrvUT8M6ksRrMV7vviJ/nQgEBml98C4JdGCF5nvixycDfqayyM4Nv
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b78e98-02f5-4095-5621-08dddebea080
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 01:20:47.3878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ft+Yobq62LjsZ1+d3CNNyf24mREioZpx0d38rW1naASoHhmijhYtUwbkf0YSZ5bzvZtMUW97wBI6pO2UuCAqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6582
X-Proofpoint-ORIG-GUID: Yp2nAbUNYqdWsRhL7BXZsw5VJZqhtAk1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxOSBTYWx0ZWRfX0ZDz9o+MNui+ Lqq8P3Q/4qaEtKxB/rHPOG670TKYBuXc0U78v7njZPs6ePK23RffUYBwjHlcn+1T4508vWyzMGA gDaEznzSfOJqMNr6kdCWJJnMhslIXgTgFd+M6bzk9bc8J3Jlcx8J5vyImHDeq344NA/NmrYf/Nh
 Hw74a45lCgcmtfJb6iuwJOEGSqr/qDMQYH+3nMGi2cEWzeMGd4knqjuItyjghoX0J7n+uSRHs+X SlUa3SGyKUMmwI9g9Ao5jnkkOOFpBmRUOWfq8lHhkfbCay00BX+hfZhcqUL+BVCeOXW2AEijtfn ltT6i0ahdGzn3a2tPKhqqFqvVofCPONf5pOYBEKtNMhRx0R4xrFY0afORFJLNH5Cbpg1jx6kQ99 2PoCZ73A
X-Proofpoint-GUID: Yp2nAbUNYqdWsRhL7BXZsw5VJZqhtAk1
X-Authority-Analysis: v=2.4 cv=EZTIQOmC c=1 sm=1 tr=0 ts=68a3d17d cx=c_pps a=XGx4pVl+Z3fbdeBOhh1HLw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=1WtWmnkvAAAA:8 a=PBW8ILOAHC6i8a6gHb8A:9 a=wPNLvfGTeEIA:10
X-Sony-Outbound-GUID: Yp2nAbUNYqdWsRhL7BXZsw5VJZqhtAk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01

> The result of integer comparison already evaluates to bool. No need for=
=0A=
> explicit conversion.=0A=
> =0A=
> No functional impact.=0A=
> =0A=
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>=0A=
> ---=0A=
>  fs/exfat/inode.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c=0A=
> index c10844e1e16c..f9501c3a3666 100644=0A=
> --- a/fs/exfat/inode.c=0A=
> +++ b/fs/exfat/inode.c=0A=
> @@ -25,7 +25,7 @@ int __exfat_write_inode(struct inode *inode, int sync)=
=0A=
>         struct super_block *sb =3D inode->i_sb;=0A=
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
>         struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
> -       bool is_dir =3D (ei->type =3D=3D TYPE_DIR) ? true : false;=0A=
> +       bool is_dir =3D (ei->type =3D=3D TYPE_DIR);=0A=
>         struct timespec64 ts;=0A=
> =0A=
>         if (inode->i_ino =3D=3D EXFAT_ROOT_INO)=0A=
=0A=
The following two if statements both check whether the directory is the roo=
t. =0A=
Can we remove the second if statement? I don't know its background.=0A=
=0A=
        if (inode->i_ino =3D=3D EXFAT_ROOT_INO)=0A=
                return 0;=0A=
=0A=
        if (is_dir && ei->dir.dir =3D=3D sbi->root_dir && ei->entry =3D=3D =
-1) =0A=
                return 0;=0A=

