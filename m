Return-Path: <linux-fsdevel+bounces-74961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG4JBAp8cWm0HwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:23:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACAD604AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E82516A3805
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262F934F47C;
	Thu, 22 Jan 2026 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="UYv9gOu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020109.outbound.protection.outlook.com [40.93.198.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAB2D73B1;
	Thu, 22 Jan 2026 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044983; cv=fail; b=rZm+VH4Pa1PsXb9kSXsNqmF+Z5tCLIMMt1/G4leAN3laaWFQX111WApzoJF7u51qYxlFYie6N3kGvEn8+yvOQRS2hYvzBAD+NYjro60R20M4/aYUfsJye7XTasj2/VRIxqwVxt4nQM8XdIdH3Yj2E+j6YgwWGyr0XkuZU1K5wQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044983; c=relaxed/simple;
	bh=ULVwcUJ+8DKkaEVfCy1TosJkOOMfl2yRbHYAIO/BR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TS/HMSWZq7/nWdCnRVDJA1QNeLtZm04e+yotwcKdfQF3ucoVQDt7hC14ODY3KDEH4QhY4xYeBZUIfimEO1HS380PTYUPh/7ND1xYcJi/dykMx3F6PSfHXv17aqv0eJTa3FVsCFrGq7rUCG8BsfPQsuZMOjtF843pBhG7k5re+GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=UYv9gOu1; arc=fail smtp.client-ip=40.93.198.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdL6xe+ReX2HTmq0yjN8aj2cjAFJspWD8nDb2fe9camllhq6pa2uwK6FFyMdGrIWW3wEXfCELDz2gC5SmGkAws0U/XoL+PvTjbdHO4mnSgEDREliixDEyFCxqr20a5oAS7pF5z1+BQ1kHp22dW7tb2yaHFTR8m9ByY0B6sUNLGwIFg0Sd1idke5ZWwhyoTb+MQigzJviy83Co1tFlsD0Y5S5Kpimof0vWwfHKd4whaj099v42W56nIsFFVLY9WEOntP6+XYlf/PxfjSXVD0RzmoqWWR3cdgFioT6CWsjTm7YDBULmdAk10TXQ2jsrDhljeppmV++yEmz/yPenLbuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F0/yeHlJ6r0sfo8yZ3H7l1uR5rLelFU2gSCpjjWFKs=;
 b=HjtSTqPL6/trtLAh+WOJrjdwOiQGfc0UXP1CX97muP0TwhG+rDwHGQQ3Q3XQs/3HNTf/m0xmomUr4dFrX8GEx9Ms7uamZhj6TTRvc+YlJrCsKiQjLDtUSXodW3XP5tmOaosQFZAs8WkXkjXxYIZB4iPJHbBhwLOGcEIyeas2U5JRAd6PYiKRr6c+Lz5/IR1fMAGrzLYfft2ePFKk5kEEFXM79cs27Idb+M6pvxtJH9/5h5vbQH5XSoysz9OY0bDzQZ617tYzLcR2pz9Os585qNtqnX+S31VV8ShYkRzfusQLedAZUzpGGZqy7iH9LPoa/BqUG8dxwiLkWgULCmjYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F0/yeHlJ6r0sfo8yZ3H7l1uR5rLelFU2gSCpjjWFKs=;
 b=UYv9gOu1VWFmqVVEymUBUSQH/YUY9iscvWpM7rsIRmxfvIfkBjORMhvAu3Q04QGv/ML1vaq6T1hItOr5f36NAecrojtH9VojUiuEXXF2VadlH4PWolpoacE8+mwjlksbnITEGzXkkiPmeF4taOO8iOFLbbLrcsoFaQEuOi4gyoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS1PR13MB6876.namprd13.prod.outlook.com (2603:10b6:8:1ef::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Thu, 22 Jan 2026 01:22:55 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 01:22:55 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Date: Wed, 21 Jan 2026 20:22:51 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <DC80A9CE-C98B-4D03-889F-90F477065FB1@hammerspace.com>
In-Reply-To: <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
 <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::26) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS1PR13MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 480bdc04-f221-4028-1e79-08de5954c519
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dsNhP9CsNv6wqCPW7fculJyhSXQ5NEs8b4E52QUyhDtNbxme++3sXo1DPwFR?=
 =?us-ascii?Q?ol8mscNOoDoT47dM7JXFgKDrvEXhqL2vaIpfg/OZ949BtliqZ9SxG6QfoAKo?=
 =?us-ascii?Q?CSgJD3gIEyZSUoZft7MtqJ95YoAoB+vN4wpdYd9DseAvhF1HthVXpfeMkwEh?=
 =?us-ascii?Q?Bya3qqxuywcqVHSN2kC6EVF50FwjKTtU2HOK4D3hhifnHnKeIl0q1bdKGRQz?=
 =?us-ascii?Q?/3H10Gwfv39ZBhZTJqe0wENiiGB0SyWrx46MHFVXeDQb1jRKSewiA9FsUtaz?=
 =?us-ascii?Q?rUeqdOAdlQ8jjeowxRkPmf98AB1QbXsxCSPOqFfGQj/SWypaAdC3Sztx4qof?=
 =?us-ascii?Q?hf8nGjKSnsACPo6vBXdZKBPfjQIQk3tQewDMaCYdkomng4lVgyX44B/+I3Me?=
 =?us-ascii?Q?v63+vofOUL2f6Iytydl/VndnFfBN/ItJqo80nXCbN0nolUBrnR/rWowbnold?=
 =?us-ascii?Q?SokjZbaTN9iL+Qx6Sr84f4T058RhtOJIy0bzpZAUfhHJxBigdt4DZx9YqDsq?=
 =?us-ascii?Q?AejQLmbe8Z/+ht94WzEonhqYpobYfomvAlzwQihES4Dlu///NAJog/xnuLiK?=
 =?us-ascii?Q?KS7IrPs11T9FXs9YAo8J9wL9Q1N7kXciBY+u0zysXpih7SxKsQU5z+qMv4g8?=
 =?us-ascii?Q?KgHfxIKZumx78i1gZEn2Na9QYCDwzBJotXKcLmJm1ud4mcGyiJGcoB5VN5pf?=
 =?us-ascii?Q?q+z2EAE/DLyqlANbbfosw+nKGDj64DLzQpv751+aY8esCEUPuuICqQS6TowA?=
 =?us-ascii?Q?OT3ZZZmkUGVHHt9aKbb60WPPrzqSWW1KmEN2uIkRoX7MNPMn32bMu1OSYP+r?=
 =?us-ascii?Q?uJPs1s2hcPgLvp/0bTIPXu8EunJAn7E6w67d2Npz3sHZnFnEilDJuBjZVUh+?=
 =?us-ascii?Q?fqiySe4n457hFBshBU7MaW2wk5C3q49MCSANunPDDg9lLLMojdITt2DMcWOV?=
 =?us-ascii?Q?Al9axM2TqYglDcg3b1V/Fnm6P3uy1TVHb2LClvqRk8fed4HzoYmzkuPzXrwA?=
 =?us-ascii?Q?Pv0SVydp1Bj6SDT283XpXKx/3LLqiHN9X8PUGDYIA+u6TUq6AJ+Ax4PvDX+/?=
 =?us-ascii?Q?qvCifl+kZCy1GSYM3kktFBgg95/jEJXWNUmpxAbNs+gqsUYyO2HIUOVdp0zp?=
 =?us-ascii?Q?0cxQX+CLh9Zwe6A0N+cpHckuXumlcqnGZqs6FoosQ3G2kBAKea+fZTPnKXMe?=
 =?us-ascii?Q?Xhm9Tqb2aRfKKgVjCeeoB5Sfc6JJO4MTYZVY3wYiTL7ozh3Lrhu4LWo5a0lz?=
 =?us-ascii?Q?bEBnY9bhsOn9NpzEnlwxVSJgixA8lscIqoViorJE9jX0A7Ytqi65uKTi21gm?=
 =?us-ascii?Q?Rucr6oRWmWh6P8Wb0M/UTKR7uUtg2C8mV36sonk2A2UR4MoRbHPqZN0XuTv4?=
 =?us-ascii?Q?ik28dsJrFuptPdQTAwCuvuKIYVuM5cQFTHvacu+yh5wBCa7dxsIHI4NCMtPF?=
 =?us-ascii?Q?2T6DqwjSqIPajaN00VDVk0j03Kab35ryx/7a92MhVG0WxQxaw4KKinKj9/ko?=
 =?us-ascii?Q?uukQlp2YjHE+qp07yjPY+H4CDW76VH1A1ENh4Z++4GidT3cKXYN6p3qUBjVW?=
 =?us-ascii?Q?iPOR1sHDPz7w6QH3eZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjnS9lVsjQG6j3g40K+gjwxSCV76gszueJ84enxkyUbuHL/lV4lnpy1tp+e9?=
 =?us-ascii?Q?7w4jekGryJgA6f/Er8sYcOJ5c1Jwnw29xYI3qzCgGdc9hWpoBY4iYtGnKe9m?=
 =?us-ascii?Q?/10XSNfTuZ0YbEEzAEE3s2kG6IffZL8ewE02W0jM2f0DlspTYdpjdyOmcx+v?=
 =?us-ascii?Q?xkmQOu4ZsrEcOplOBvo4fpVe9qbzT3W4o0s9jexdlpKR4bYksE1j9mH5tfs6?=
 =?us-ascii?Q?8EKYirmKlAtnkAKaEHd/KRdvBTNK9zD0N4JvLoI97Wsc+VVPAhxNkZfBpLSl?=
 =?us-ascii?Q?HcGEDF2W8sPWx5API0r21AH+C09PlU0ETd0eUU15cDIk0GdNgz6YLho+RRWJ?=
 =?us-ascii?Q?kPL8rgZctaa7PbDMUDN8wPT3AwBhr0IFJSW2KZEl0xH/rXefWW7gGHdJuNQO?=
 =?us-ascii?Q?kEpoB6iMGYaGYNp12GNlrV2zrm7/bNj0taRRJ7lQWsCscAGjz0IcWNkTHxgq?=
 =?us-ascii?Q?9QvImnL5mEM98iF0CJs9ECj+0yyweV6Uc5Jm8YnjpUT5NCVajKOkYjAJKiT/?=
 =?us-ascii?Q?acM+Cw5pIq8gD9Ik8Lw4rQbCZKC82MjN/8NTkUs81psuWXGDhfWNujJd5Ip8?=
 =?us-ascii?Q?OUOUGRO2olimk2cajMAwq8tjdnrp4idouXXlaNsbp24kjCpgZ6eUxyH6koMt?=
 =?us-ascii?Q?rGCSBPO1aCUjMRrLVxvaUKkqa+nQzJ8QTvfcBKmJI+X6DNpTS6WsY8IiACPX?=
 =?us-ascii?Q?kqw/SaixRIjAXM717S5Wo+NwN3MCjgu6rwQ23CBPhT0+hRgQxYKm7FY/Rg77?=
 =?us-ascii?Q?rguwBmZ4wcYVLcAZmJOoHMpnH6IT0SgWe5fNHN4HrxXgN6VH8UBjenxWKCTY?=
 =?us-ascii?Q?itvvYaHvLOx2ypByMcCkdJ2eoLGUf3nJ12aJq1DaNbKN0KG+lFYOvUIZoNYD?=
 =?us-ascii?Q?hxFUCcWkN5XNXqQzopChi8V86GtyIAvHYFTDQSveCVGehOWj9ETtLkHMaC8F?=
 =?us-ascii?Q?ECLaCePcCjqLlWKrf9oErXHGY/BkjaWiDLl7elLOXKp4l5reUwb5AnRQQ6vR?=
 =?us-ascii?Q?xG8+6AoRq/Dy6NVqmcisYYjmRjqtdFeqBlavyg2ZFvh7xl/i5wHHfYdTIZOU?=
 =?us-ascii?Q?djqvYahvrWa7AqOin61fvJxcGSqwLlkFXxx0gYl2N3PF2dMHGU6GcanBg7aG?=
 =?us-ascii?Q?X+Rn9EAShwc6iFs+PwQ7fKdkmvtZ7wwxOp5sK3yLxVg7DP7guDrPkItBs62q?=
 =?us-ascii?Q?JTzjlw+FaOoN8kFrtl2e8mtP0PQwMdeQBFj5O3jOwqflnkToT3u6GYPstnMO?=
 =?us-ascii?Q?1cm0Y48aUlIWKuSitWyWHnDF9H2JAjDN0cEe5j5RTexHqaVpCVGAEDpwq5wj?=
 =?us-ascii?Q?oTtBkMvIoOZ9nDOEtYvkF4gJ2HkdWHG5knpY1BVvsjHNPry/c/ulbyFq4ZWQ?=
 =?us-ascii?Q?m4rQjZBVdg5nvc/BV1dBnMl0sbTrDacUpRmOY9Fe34O6zKYI0+BqoZuL2KZ7?=
 =?us-ascii?Q?84jQ/OjHqUjXlx8SZ11OGPV0P93kHP1GZ6NsJ0U5tDyVo2JPKRYzbUIIM7dy?=
 =?us-ascii?Q?N1vNf2vwfyXqUgAsY/sxvbDEFiEeFxCS2s83rs2m9gBzi8MVOgaEWED0BXIM?=
 =?us-ascii?Q?3lMzO03Cgou78OmFKiGo9H5tfghJeiRpdO8UsgK+HW43hfpd7f5RXIZVkvuv?=
 =?us-ascii?Q?Oj6oDi1SQdMN9gNOoKi1+7/uyHzB5iRNTX7xsaLInm7DdJPNsURaYlGMYC1g?=
 =?us-ascii?Q?uleCO9JNZxqwpJ7XpwSB7FnEdZ38V5Ri0fV+gX9alfJ0f04wqAMWK01qECL1?=
 =?us-ascii?Q?li3IikI9ZWDU1jgTOyyexhvFCPU1jZE=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480bdc04-f221-4028-1e79-08de5954c519
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 01:22:55.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9IRDa4dniZVG62nSlA6GO+C75+1MFpbEj9u15+hr/l1aCtCX9XXKTSNRCs7sWnLQvJDopw0EkiBbM3Vs2BIf59o7v7tIGTD3pjkngSpIG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB6876
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74961-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 9ACAD604AC
X-Rspamd-Action: no action

On 21 Jan 2026, at 18:55, Chuck Lever wrote:

> On 1/21/26 5:56 PM, Benjamin Coddington wrote:
>> On 21 Jan 2026, at 17:17, Chuck Lever wrote:
>>
>>> On 1/21/26 3:54 PM, Benjamin Coddington wrote:
>>>> On 21 Jan 2026, at 15:43, Chuck Lever wrote:
>>>>
>>>>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>>>>>> A future patch will enable NFSD to sign filehandles by appending a M=
essage
>>>>>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bi=
t key
>>>>>> that can persist across reboots.  A persisted key allows the server =
to
>>>>>> accept filehandles after a restart.  Enable NFSD to be configured wi=
th this
>>>>>> key via both the netlink and nfsd filesystem interfaces.
>>>>>>
>>>>>> Since key changes will break existing filehandles, the key can only =
be set
>>>>>> once.  After it has been set any attempts to set it will return -EEX=
IST.
>>>>>>
>>>>>> Link:
>>>>>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hamm=
erspace.com
>>>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>>>> ---
>>>>>>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>>>>>>  fs/nfsd/netlink.c                     |  5 +-
>>>>>>  fs/nfsd/netns.h                       |  2 +
>>>>>>  fs/nfsd/nfsctl.c                      | 94 ++++++++++++++++++++++++=
+++
>>>>>>  fs/nfsd/trace.h                       | 25 +++++++
>>>>>>  include/uapi/linux/nfsd_netlink.h     |  1 +
>>>>>>  6 files changed, 131 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/netlink/specs/nfsd.yaml
>>>>>> b/Documentation/netlink/specs/nfsd.yaml
>>>>>> index badb2fe57c98..d348648033d9 100644
>>>>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>>>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>>>>> @@ -81,6 +81,11 @@ attribute-sets:
>>>>>>        -
>>>>>>          name: min-threads
>>>>>>          type: u32
>>>>>> +      -
>>>>>> +        name: fh-key
>>>>>> +        type: binary
>>>>>> +        checks:
>>>>>> +            exact-len: 16
>>>>>>    -
>>>>>>      name: version
>>>>>>      attributes:
>>>>>> @@ -163,6 +168,7 @@ operations:
>>>>>>              - leasetime
>>>>>>              - scope
>>>>>>              - min-threads
>>>>>> +            - fh-key
>>>>>>      -
>>>>>>        name: threads-get
>>>>>>        doc: get the number of running threads
>>>>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>>>>> index 887525964451..81c943345d13 100644
>>>>>> --- a/fs/nfsd/netlink.c
>>>>>> +++ b/fs/nfsd/netlink.c
>>>>>> @@ -24,12 +24,13 @@ const struct nla_policy
>>>>>> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] =3D {
>>>>>>  };
>>>>>>
>>>>>>  /* NFSD_CMD_THREADS_SET - do */
>>>>>> -static const struct nla_policy
>>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] =3D {
>>>>>> +static const struct nla_policy
>>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] =3D {
>>>>>>  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
>>>>>>  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
>>>>>>  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
>>>>>>  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
>>>>>>  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
>>>>>> +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
>>>>>>  };
>>>>>>
>>>>>>  /* NFSD_CMD_VERSION_SET - do */
>>>>>> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] =
=3D {
>>>>>>  		.cmd		=3D NFSD_CMD_THREADS_SET,
>>>>>>  		.doit		=3D nfsd_nl_threads_set_doit,
>>>>>>  		.policy		=3D nfsd_threads_set_nl_policy,
>>>>>> -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
>>>>>> +		.maxattr	=3D NFSD_A_SERVER_FH_KEY,
>>>>>>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>>>  	},
>>>>>>  	{
>>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>>> index 9fa600602658..c8ed733240a0 100644
>>>>>> --- a/fs/nfsd/netns.h
>>>>>> +++ b/fs/nfsd/netns.h
>>>>>> @@ -16,6 +16,7 @@
>>>>>>  #include <linux/percpu-refcount.h>
>>>>>>  #include <linux/siphash.h>
>>>>>>  #include <linux/sunrpc/stats.h>
>>>>>> +#include <linux/siphash.h>
>>>>>>
>>>>>>  /* Hash tables for nfs4_clientid state */
>>>>>>  #define CLIENT_HASH_BITS                 4
>>>>>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>>>>>  	spinlock_t              local_clients_lock;
>>>>>>  	struct list_head	local_clients;
>>>>>>  #endif
>>>>>> +	siphash_key_t		*fh_key;
>>>>>>  };
>>>>>>
>>>>>>  /* Simple check to find out if a given net was properly initialized=
 */
>>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>>> index 30caefb2522f..e59639efcf5c 100644
>>>>>> --- a/fs/nfsd/nfsctl.c
>>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>>> @@ -49,6 +49,7 @@ enum {
>>>>>>  	NFSD_Ports,
>>>>>>  	NFSD_MaxBlkSize,
>>>>>>  	NFSD_MinThreads,
>>>>>> +	NFSD_Fh_Key,
>>>>>>  	NFSD_Filecache,
>>>>>>  	NFSD_Leasetime,
>>>>>>  	NFSD_Gracetime,
>>>>>> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file, c=
har
>>>>>> *buf, size_t size);
>>>>>>  static ssize_t write_ports(struct file *file, char *buf, size_t siz=
e);
>>>>>>  static ssize_t write_maxblksize(struct file *file, char *buf, size_=
t
>>>>>> size);
>>>>>>  static ssize_t write_minthreads(struct file *file, char *buf, size_=
t
>>>>>> size);
>>>>>> +static ssize_t write_fh_key(struct file *file, char *buf, size_t si=
ze);
>>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>>  static ssize_t write_leasetime(struct file *file, char *buf, size_t
>>>>>> size);
>>>>>>  static ssize_t write_gracetime(struct file *file, char *buf, size_t
>>>>>> size);
>>>>>> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *,
>>>>>> char *, size_t) =3D {
>>>>>>  	[NFSD_Ports] =3D write_ports,
>>>>>>  	[NFSD_MaxBlkSize] =3D write_maxblksize,
>>>>>>  	[NFSD_MinThreads] =3D write_minthreads,
>>>>>> +	[NFSD_Fh_Key] =3D write_fh_key,
>>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>>  	[NFSD_Leasetime] =3D write_leasetime,
>>>>>>  	[NFSD_Gracetime] =3D write_gracetime,
>>>>>> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *fi=
le,
>>>>>> char *buf, size_t size)
>>>>>>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads=
);
>>>>>>  }
>>>>>>
>>>>>> +/*
>>>>>> + * write_fh_key - Set or report the current NFS filehandle key, the=
 key
>>>>>> + * 		can only be set once, else -EEXIST because changing the key
>>>>>> + * 		will break existing filehandles.
>>>>>
>>>>> Do you really need both a /proc/fs/nfsd API and a netlink API? I
>>>>> think one or the other would be sufficient, unless you have
>>>>> something else in mind (in which case, please elaborate in the
>>>>> patch description).
>>>>
>>>> Yes, some distros use one or the other.  Some try to use both!  Until =
you
>>>> guys deprecate one of the interfaces I think we're stuck expanding the=
m
>>>> both.
>>>
>>> Neil has said he wants to keep /proc/fs/nfsd rather indefinitely, and
>>> we have publicly stated we will add only to netlink unless it's
>>> unavoidable. I prefer not growing the legacy API.
>>
>> Having both is more complete, and doesn't introduce any conflicts or
>> problems.
>
> That doesn't tell me why you need it. It just says you want things to
> be "tidy".
>
>
>>> We generally don't backport new features like this one to stable
>>> kernels, so IMO tucking this into only netlink is defensible.
>>
>> Why only netlink for this one besides your preference?
>
> You might be channeling one of your kids there.

That's unnecessary.

> As I stated before: we have said we don't want to continue adding
> new APIs to procfs. It's not just NFSD that prefers this, it's a long
> term project across the kernel. If you have a clear technical reason
> that a new procfs API is needed, let's hear it.

You've just added one to your nfsd-testing branch two weeks ago that you
asked me to rebase onto.

>> There's a very good reason for both interfaces - there's been no work to
>> deprecate the old interface or co-ordination with distros to ensure they
>> have fully adopted the netlink interface.  Up until now new features hav=
e
>> been added to both interfaces.
>
> I'm not seeing how this is a strong and specific argument for including
> a procfs version of this specific interface. It's still saying "tidy" to
> me and not explaining why we must have the extra clutter.
>
> An example of a strong technical reason would be "We have legacy user
> space applications that expect to find this API in procfs."

The systemd startup for the nfs-server in RHEL falls back to rpc.nfsd on
nfsdctl failure.  Without the additional interface you can have systems tha=
t
start the nfs-server via rpc.nfsd without setting the key - exactly the
situation you're so adamant should never happen in your below argument..

>>> The procfs API has the ordering requirement that Jeff pointed out. I
>>> don't think it's a safe API to allow the server to start up without
>>> setting the key first. The netlink API provides a better guarantee
>>> there.
>>
>> It is harmless to allow the server to start up without setting the
>> key first.  The server will refuse to give out filehandles for "sign_fh"
>> exports and emit a warning in the log, so "safety" is the wrong word.
>
> Sounds like it will cause spurious stale file handles, which will kill
> applications on NFS mounts.

^^ here.

Ben

