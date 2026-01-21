Return-Path: <linux-fsdevel+bounces-74933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKXXHjNacWnLGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:58:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0CF5F2D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFB09940808
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EC344B666;
	Wed, 21 Jan 2026 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="QBIuBcGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021135.outbound.protection.outlook.com [52.101.52.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF33AA1A9;
	Wed, 21 Jan 2026 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036173; cv=fail; b=os785IOS52wISUhbw7qIjvY27jk4ILd8DG1RsFEdA6SUyHh37zGyLae0dDaJ6UcLM+BhqPsHnY+gchRh30hL9sDpZ52sqMz99puvKV91Eg0X9FwhOClUK7E/kPZLfMGFsED+ZnSCb2J4rUNUbudQ5kCD+OSte993M97s+52mGJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036173; c=relaxed/simple;
	bh=rF6DWhjlLqSuER0viH/2Y7ki6cRBeOHluDYfKS7l1u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHjeeobJulxZ1dUP5D7a7xrVJwOUjJroVoLySluMOV23ee+GFKCPYMy423pIsgZyJF7dApIdJCfzu5v5QBUCrCJHwMxXiBLD9gZ3kW6AcmNrm3lHAL+Kv4K/mOyGbopszcEh65u6zhL0R4hRMMAuZ3jNOnZrXFAWeZ2JEc+jqTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=QBIuBcGd; arc=fail smtp.client-ip=52.101.52.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUCblazWavK0Mr1ZVOoHnTWB8b+57Kid5VJ2DtQwntxrNpFlohmIARmuCcdI8EZTEBnirl5oUao/fT1e4oKW9nyzjWYhTAA2F1IH45hDiFvSPZDEEsyLOd9v7RYMM4C4tVZslt1PQ31U1O/E6mj+/TqhD49hlZmAOdPh5cthNq7rX+aE4hxlXWulckLM0U/6cX/OATkbtprGnPzM5iyR8Ad97Vdxmn+KuezKmp3RCykOpQmiF2TkO+HdUTuV1UXypxZbzT2qrtbg5V5xWQwMzzZpCaIpq7HNKW3IQN0Qpkz33jbjfkPTXGOM9qL5oOKQAPFNIkmLDuyL+YdZ7BRouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9IINvg6zddGjPBy18lXdbh+s/1ezMHdOW27o5LJM+A=;
 b=nz/304MqqKk8mXS1CrVQFpBi3LiaGMBn+GNC/WEaOUgKBXQPxLB7uoX0qttS6I4MWZTf0mNxpvGFDL+12skhuZAwvuqY6znXc249Bq9FdE60HgG+81g1P0pDuUtS2C4ix2ShZkh7cTud3vmh0lYVjbTUWtCe0WWb9DCht0oPEk3LBXHBJVFIQ3wXwadEHC31u8DikLQedzzbilwAVbnUg69e2SDWmP9Ze5nWhMDw8PaG2dnW9M2jvumXeqnNF6XWOAJ/VaxsjpS6Yz4NLl0tqa4SVrgbfAHajD3/AmOXVgQjP7gWZddRyPoVZtzryBITf22ATLK36KCirtZYYcBaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9IINvg6zddGjPBy18lXdbh+s/1ezMHdOW27o5LJM+A=;
 b=QBIuBcGdGv02EODf/gSOJErzjWdaAzKwB3ibRmRy/84IH26GiDxSFYCKtzz/6JpieQRABpURB3YEPWbPGQUjCtz6GvHSlC+SahX9Xkqsnj/rBhFvvtK3CD9S6iazQm8WPDfFGw8m1w3p/eE/ZFiHT916KPxxLhYfwFWP/+Fp97Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA1PR13MB7702.namprd13.prod.outlook.com (2603:10b6:806:4c3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 22:56:06 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 22:56:05 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Date: Wed, 21 Jan 2026 17:56:00 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
In-Reply-To: <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::13) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA1PR13MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d037d9-9523-4079-e363-08de5940415e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SISPljp3Vew00XTGrdh4ChFdXbwfHsE2D1zqv5yDbVekgUCjRcxdK8Qbj5lp?=
 =?us-ascii?Q?cNhBbwBCdb5DtQR68rUjP4F4AOTHGgzbrSxFCngRhQt9IClslBha63NJ/G0N?=
 =?us-ascii?Q?1m5tMz0Q57IDejZBzETjJFhb37gBFP/kJFs3PggkQGcKF3pWfrzW2+TwsQdZ?=
 =?us-ascii?Q?77rUhfQdp/6hxDhG+8/tPxOC8XoZ1SSpDpGp4Q+WjVERxcztSOWRbqOY+2Zi?=
 =?us-ascii?Q?T0hYbBFelK/z+gEDUvtvLt9S2iYj1QI7gx+wfGJHVxZ9AVqbh9UdVFvyndfT?=
 =?us-ascii?Q?lulFexUFh+MXq2bhQSw87I1UzIIs1ssAm3jxB93JZSxmKPXtDbJbXHAnFCrq?=
 =?us-ascii?Q?K+svduyjHhOC2NOx3pOAtEnUt0XX9eV1Pm19pRtZ5mwZq59IeS0yquxzZaoE?=
 =?us-ascii?Q?fmrgQpd/29aMCVdliudHpJHW1/Y3OTLmiKXh0CH1g0Wyhdm95GI+zeYEPfVE?=
 =?us-ascii?Q?xZo8iYyVJpnkf+zef1RYgTXA6g4KLfbgrZL9qX44EpJNmjEnDbx1VnlmUZTZ?=
 =?us-ascii?Q?lIQkPO2xZvRRSfAXQqXA2eM9P3Ne3q/AR0uMarl/2+BoBgtBCRad2/UqWgGs?=
 =?us-ascii?Q?4HRZ9jXYVOdJ9PSobw2X8fl5vm3NGjSBb6w41Ao/ltyuHzJwrYAFbnXfQmIb?=
 =?us-ascii?Q?FjlAIim2MLw75FZwTt9JE3SPq8EtP5cOZ67VUjVI1RhvxUrx3Q4gyMVhagB4?=
 =?us-ascii?Q?eCa3TOUlFixT1iuxEIzVBUjNnmGA+OE3BaGe1HNnwLDE+PH5VTGTEdiBjcuO?=
 =?us-ascii?Q?MFDNulT4NRxPmCndaLvYKYjiMjnTDVrlaKVrqcpBlAHBraL13pXJVZtmE4Li?=
 =?us-ascii?Q?o6EvkTHpzH4jEXW8xXJdWUX3G6c1JN7CY3q404uGsY+l5HpPg0pRNlHAQ/aZ?=
 =?us-ascii?Q?a+ELCBfSYwmizqDAOr6IYHc38ugIvG4RjnyNsv6qgP1qGw7cxfLKoXp7Unqo?=
 =?us-ascii?Q?IzayIJqxXpcg9IGrOuq7nPM4jyGSMmeUMlBckNYoSugQNX2RZsxFQiUjDKpl?=
 =?us-ascii?Q?YoUS+g45lbWiLJ08SBK7PznPcj1OIDAN4v7rBZnwz4ixD8e02Wubo7vjrw+T?=
 =?us-ascii?Q?P0moyD8onQmkXk6PSSZ5MyM6vKXMR75Hm0SZWZ99oMUVYKLjNslymYiwpoY3?=
 =?us-ascii?Q?HpKP7cAFrShUmqlOnDPBUiTC7qo5tu4tB/OZ/Ch5+kfrpMLzJzDbxqhhnjiv?=
 =?us-ascii?Q?Hls2sG0ofMLOz6LZfz0zPRDaqsTtLDwruvOPqotJcaa+OoXgTpDnOukqXNno?=
 =?us-ascii?Q?CQG7WS63C3DSMPMJfqvujRXW2RUd8UerNZ13eTG05T98yWZQZEdFoJnSjApd?=
 =?us-ascii?Q?TYyzwPc9W/ja+zBpMl/ogK9AUdUSBN33a9Qv46rU1SRYeVeJcRojAWMcpnTz?=
 =?us-ascii?Q?hE29B7M+quMfawGF078/zGRA5GFEvMta3zMQvMpsiVUOhR2t38/x4AQ865/r?=
 =?us-ascii?Q?99ea4zDgZCKkJeULALCN8ZH/aadKqGJ2HSI/6ItuuxmPMrbOoMfuuoq/Qk4A?=
 =?us-ascii?Q?wG3VECC8jbXCuzvNXgzuNOTrES4z93yz5UqvI9zHlrtjXN1xXpi9pkRql8Eb?=
 =?us-ascii?Q?aHxiojplAOKRB8UkB3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XhM3gNG8J/pi0uIQPUx2HTjEM9GBWnW6o1sypuEpE86WhzsRGIEWUyc1fQE?=
 =?us-ascii?Q?I1w+dGK7lBH8Omunh7PjYA/Z45G8PHoYFUreBWXuojH9EQ1EBlxw6HHY5P60?=
 =?us-ascii?Q?dBa6vOmJ7fj2iRyNSOIIR4pMIgjQYC+4R3+vQKYEBpDDMGmDyv5YOR0ywmwB?=
 =?us-ascii?Q?u1zjrqutu4/sNpdKden0zqdq7W0teN8VfiO/xPUU5rPJ1XtzzM/ZduAYPq39?=
 =?us-ascii?Q?mHxU7md0NrpSiBEPCwCFv1D1Ea+HoDJ6/X60HirZiO/5a+kToCkHkJC93AYN?=
 =?us-ascii?Q?2w0vWXrlXs6z4W3SeNj5EwlDqcTkNu37h4C3lujAwQBj4WOCMw8iOAXLFcJP?=
 =?us-ascii?Q?WQeqXF6piSEPnjSLeb+lbjCNKIUam397KuVpXi/piprQFuRc6hAcmQ/435CJ?=
 =?us-ascii?Q?3ZRCsPw4TS5EqcVh+DVPsiQKSI2pqvNE0sLLWqueN9C/2+BHVdfO+crajUxo?=
 =?us-ascii?Q?SmKJLiNC955cgvSSZUzNVMyyOiaVFyyMGlSY90wUF3934i83IodQCNrVWvXc?=
 =?us-ascii?Q?AnWvXwth93PBM83yrlmZY8eKTda3qH+B0JYQec6D1hXlmuaW6+ppLjP0YEXd?=
 =?us-ascii?Q?DLvWwJJA7U8MzlnNMEPCdxEN3eCFNM5s26a+QMRNglzEdE3ZZzoKF6wkOrwK?=
 =?us-ascii?Q?CwYSZ77plTT7SS6TBsXXIMnQLmjJqJpjCqy9meZXJObfWzEzSfnfoHM21pyh?=
 =?us-ascii?Q?UwbunI0Pl67szOi6kCb36Wbb963rQd61zCuqu/nDrCVuKxzF+ir8NYLUYZ8V?=
 =?us-ascii?Q?+8ne6xPfXkubMVti6DJ1jSCkKGvYsGYN1+kZKsC1bKRVrVz/ps1D+y9uAkHc?=
 =?us-ascii?Q?ZEFIp6CLaieApiNNaKk/QYmb8lUEDTb/n7Vz2LpG1zFxQAKEzzoEmVR3Ecr3?=
 =?us-ascii?Q?//WGltOBMMmjJH9q6HLHMN1J9O38AWpM99VDma9ttTyUWE/3Y+t2f2mYyJ/k?=
 =?us-ascii?Q?WHdZkuzzmKAcZjBBpnM3ZSqwMh0oQLKxwrNwswfqiXod4CtWo6I8R1vOlQFS?=
 =?us-ascii?Q?UvF9VQf+M+z3n7p+f7SAtdBiLYzuNsrdqnFf/8GiMrkS8QTtkankaiHSFTkN?=
 =?us-ascii?Q?dcyO3lQCNsmQZNErEaguVfQKi/MZwWfXa+scct3v7V5eQ+NtY4n6ym59hdnh?=
 =?us-ascii?Q?6ZEvTZtyZCrtMJBWoAAjKonJmNSDYeoBg1+nsmMTpUF1ZLltXwUhICE+yIjf?=
 =?us-ascii?Q?/jSAXVyWWiggPWlRIwyHcUMCZ9S7Uk2XA7YKrojRVSgqfoZfuATCF7s7yP1q?=
 =?us-ascii?Q?csYDNhj3ntgerKhWsdMPz4NOlsgBTXF+9Ow3c8J55PQH40V7aiLjArxIOVDR?=
 =?us-ascii?Q?Gak6cDf+R8UY8dNgRvpBS+Pt8dKcN/bV4xMAxh3UiqwsJYEbIFnj6UAF2usY?=
 =?us-ascii?Q?VDmEvardgOWBUvpfZx4jEglHVk00VaKiHDX8KQCLLO1MUqbfEuki9tFgybqJ?=
 =?us-ascii?Q?siYQ57HrE4ha8yy2r6FhPEMSVnyQg2G1Q/wQ6kXlmnKJS7M6zKX+RrnvfHXb?=
 =?us-ascii?Q?Oz3HIlOBReYs8MaMKEJksFOLKHa2kGgcIABDX5P9gcM1Tg1CEfEjXWLl2PIp?=
 =?us-ascii?Q?wW5jg+YgyoNq3ix7pwKJz2FkZao8CPNn2TWFnSsIGtNIbvsd1JmCv0Hk1U20?=
 =?us-ascii?Q?jz9VXmZqYRYiO59NlraU/0II58K8bwAd1jFUJXRmbZHgddqvE/Iymd9xg0C+?=
 =?us-ascii?Q?veD7QQjO5yYsCRdv668WrW1+884nqqN4b9W4voJpEoTbQKWXm3FjbkL/gAqT?=
 =?us-ascii?Q?h2zUo3oyHWU6trhNlOqpH6lSdfVpjZc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d037d9-9523-4079-e363-08de5940415e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:56:04.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuqrfHu+/ozpe4KAuBRDfM3FF7DLw5SZjNQXogZYok5YjWZUrf3svhsfnoFjD/gAGFusFTh3WGQzQki8IEVjHHxmTafpm8B8VGECGlgn8EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB7702
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
	TAGGED_FROM(0.00)[bounces-74933-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 2E0CF5F2D8
X-Rspamd-Action: no action

On 21 Jan 2026, at 17:17, Chuck Lever wrote:

> On 1/21/26 3:54 PM, Benjamin Coddington wrote:
>> On 21 Jan 2026, at 15:43, Chuck Lever wrote:
>>
>>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>>>> A future patch will enable NFSD to sign filehandles by appending a Mes=
sage
>>>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit =
key
>>>> that can persist across reboots.  A persisted key allows the server to
>>>> accept filehandles after a restart.  Enable NFSD to be configured with=
 this
>>>> key via both the netlink and nfsd filesystem interfaces.
>>>>
>>>> Since key changes will break existing filehandles, the key can only be=
 set
>>>> once.  After it has been set any attempts to set it will return -EEXIS=
T.
>>>>
>>>> Link:
>>>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammer=
space.com
>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>> ---
>>>>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>>>>  fs/nfsd/netlink.c                     |  5 +-
>>>>  fs/nfsd/netns.h                       |  2 +
>>>>  fs/nfsd/nfsctl.c                      | 94 ++++++++++++++++++++++++++=
+
>>>>  fs/nfsd/trace.h                       | 25 +++++++
>>>>  include/uapi/linux/nfsd_netlink.h     |  1 +
>>>>  6 files changed, 131 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/netlink/specs/nfsd.yaml
>>>> b/Documentation/netlink/specs/nfsd.yaml
>>>> index badb2fe57c98..d348648033d9 100644
>>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>>> @@ -81,6 +81,11 @@ attribute-sets:
>>>>        -
>>>>          name: min-threads
>>>>          type: u32
>>>> +      -
>>>> +        name: fh-key
>>>> +        type: binary
>>>> +        checks:
>>>> +            exact-len: 16
>>>>    -
>>>>      name: version
>>>>      attributes:
>>>> @@ -163,6 +168,7 @@ operations:
>>>>              - leasetime
>>>>              - scope
>>>>              - min-threads
>>>> +            - fh-key
>>>>      -
>>>>        name: threads-get
>>>>        doc: get the number of running threads
>>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>>> index 887525964451..81c943345d13 100644
>>>> --- a/fs/nfsd/netlink.c
>>>> +++ b/fs/nfsd/netlink.c
>>>> @@ -24,12 +24,13 @@ const struct nla_policy
>>>> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] =3D {
>>>>  };
>>>>
>>>>  /* NFSD_CMD_THREADS_SET - do */
>>>> -static const struct nla_policy
>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] =3D {
>>>> +static const struct nla_policy
>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] =3D {
>>>>  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
>>>>  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
>>>>  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
>>>>  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
>>>>  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
>>>> +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
>>>>  };
>>>>
>>>>  /* NFSD_CMD_VERSION_SET - do */
>>>> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
>>>>  		.cmd		=3D NFSD_CMD_THREADS_SET,
>>>>  		.doit		=3D nfsd_nl_threads_set_doit,
>>>>  		.policy		=3D nfsd_threads_set_nl_policy,
>>>> -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
>>>> +		.maxattr	=3D NFSD_A_SERVER_FH_KEY,
>>>>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>  	},
>>>>  	{
>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>> index 9fa600602658..c8ed733240a0 100644
>>>> --- a/fs/nfsd/netns.h
>>>> +++ b/fs/nfsd/netns.h
>>>> @@ -16,6 +16,7 @@
>>>>  #include <linux/percpu-refcount.h>
>>>>  #include <linux/siphash.h>
>>>>  #include <linux/sunrpc/stats.h>
>>>> +#include <linux/siphash.h>
>>>>
>>>>  /* Hash tables for nfs4_clientid state */
>>>>  #define CLIENT_HASH_BITS                 4
>>>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>>>  	spinlock_t              local_clients_lock;
>>>>  	struct list_head	local_clients;
>>>>  #endif
>>>> +	siphash_key_t		*fh_key;
>>>>  };
>>>>
>>>>  /* Simple check to find out if a given net was properly initialized *=
/
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index 30caefb2522f..e59639efcf5c 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -49,6 +49,7 @@ enum {
>>>>  	NFSD_Ports,
>>>>  	NFSD_MaxBlkSize,
>>>>  	NFSD_MinThreads,
>>>> +	NFSD_Fh_Key,
>>>>  	NFSD_Filecache,
>>>>  	NFSD_Leasetime,
>>>>  	NFSD_Gracetime,
>>>> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file, cha=
r
>>>> *buf, size_t size);
>>>>  static ssize_t write_ports(struct file *file, char *buf, size_t size)=
;
>>>>  static ssize_t write_maxblksize(struct file *file, char *buf, size_t
>>>> size);
>>>>  static ssize_t write_minthreads(struct file *file, char *buf, size_t
>>>> size);
>>>> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size=
);
>>>>  #ifdef CONFIG_NFSD_V4
>>>>  static ssize_t write_leasetime(struct file *file, char *buf, size_t
>>>> size);
>>>>  static ssize_t write_gracetime(struct file *file, char *buf, size_t
>>>> size);
>>>> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *,
>>>> char *, size_t) =3D {
>>>>  	[NFSD_Ports] =3D write_ports,
>>>>  	[NFSD_MaxBlkSize] =3D write_maxblksize,
>>>>  	[NFSD_MinThreads] =3D write_minthreads,
>>>> +	[NFSD_Fh_Key] =3D write_fh_key,
>>>>  #ifdef CONFIG_NFSD_V4
>>>>  	[NFSD_Leasetime] =3D write_leasetime,
>>>>  	[NFSD_Gracetime] =3D write_gracetime,
>>>> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *file=
,
>>>> char *buf, size_t size)
>>>>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
>>>>  }
>>>>
>>>> +/*
>>>> + * write_fh_key - Set or report the current NFS filehandle key, the k=
ey
>>>> + * 		can only be set once, else -EEXIST because changing the key
>>>> + * 		will break existing filehandles.
>>>
>>> Do you really need both a /proc/fs/nfsd API and a netlink API? I
>>> think one or the other would be sufficient, unless you have
>>> something else in mind (in which case, please elaborate in the
>>> patch description).
>>
>> Yes, some distros use one or the other.  Some try to use both!  Until yo=
u
>> guys deprecate one of the interfaces I think we're stuck expanding them
>> both.
>
> Neil has said he wants to keep /proc/fs/nfsd rather indefinitely, and
> we have publicly stated we will add only to netlink unless it's
> unavoidable. I prefer not growing the legacy API.

Having both is more complete, and doesn't introduce any conflicts or
problems.

> We generally don't backport new features like this one to stable
> kernels, so IMO tucking this into only netlink is defensible.

Why only netlink for this one besides your preference?

There's a very good reason for both interfaces - there's been no work to
deprecate the old interface or co-ordination with distros to ensure they
have fully adopted the netlink interface.  Up until now new features have
been added to both interfaces.

> The procfs API has the ordering requirement that Jeff pointed out. I
> don't think it's a safe API to allow the server to start up without
> setting the key first. The netlink API provides a better guarantee
> there.

It is harmless to allow the server to start up without setting the
key first.  The server will refuse to give out filehandles for "sign_fh"
exports and emit a warning in the log, so "safety" is the wrong word.

>>> Also "set once" seems to be ambiguous. Is it "set once" per NFSD
>>> module load, one per system boot epoch, or set once, _ever_ ?
>>
>> Once per nfsd module load - I can clarify next time.
>>
>>> While it's good UX safety to prevent reseting the key, there are
>>> going to be cases where it is both needed and safe to replace the
>>> FH signing key. Have you considered providing a key rotation
>>> mechanism or a recipe to do so?
>>
>> I've considered it, but we do not need it at this point.
>
> I disagree: Admins will need to know how to replace an FH key that was
> compromised. At the very least your docs should explain how to do that
> safely.

Ok, I can add documentation for how to replace the key.

>> The key can
>> be replaced today by restarting the server, and you really need to know =
what
>> you're doing if you want to replace it.  Writing extra code to help some=
one
>> that knows isn't really going to help them.  If a need appears for this,=
 the
>> work can get done.
>
> I cleverly said "a key rotation mechanism _or_ a recipe" so if it's
> something you prefer only to document, let's take that route.
>
> Ensuring all clients have unmounted and then unloading nfsd.ko before
> setting a fresh key is a lot of juggling. That should be enough to
> prevent an FH key change by accident.

Adding instructions to unload the nfsd module would be full of footguns,
depend on other features/modules and config options, and guaranteed to
quickly be out of date.  It might be enough to say the system should be
restarted.  The only reason for replacing the key is (as you've said) that
it was compromised.  That should be rare and serious enough to justify
restarting the server.

Ben

