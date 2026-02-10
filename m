Return-Path: <linux-fsdevel+bounces-76890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM4lK16di2k3XAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:04:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91211F3EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 762AF307CE82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36BA3385A5;
	Tue, 10 Feb 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="SbGm5NLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022072.outbound.protection.outlook.com [40.107.209.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43813358B8;
	Tue, 10 Feb 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757208; cv=fail; b=LcV5CiE2Pc3SKygpzvKxv2eORe8ZMYuzLcDPae4rHWVRalrjSfdJeyirgxfagM43E8Yj8X6X1tvl3bk1GthDAgMhrpafX1x8WZwf6n9WLOhK28N+V44nHq7udsds9omzSFPWRXSlBGi/44q3M7IeSCyRjq6lj/5jFLnpSYah2TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757208; c=relaxed/simple;
	bh=u49Sd1EVscVViyR7ffXjwcQANQM6mo5qdPF0WudvQbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tol77gqtVSRZ3xr/yfYUsNJyxzE+RxNkdBeAEcT9BqkmziRPtIJCXmRWlAhZsKeKFMgZOEgXCji4yvtVEwSZcM5qu5Yju+65+TGQuoozKwvZvlR0FugzztpKJsJyA03aOSRXphgdnFjRRt/Zsftce/C/JEqmBruZlzCpD8qTx/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=SbGm5NLL; arc=fail smtp.client-ip=40.107.209.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0GSkchCiSbO6do5KNcNNdnJMT3xU/PyTIlhBOLpPlypDKW+37536ekPfV79MKNLYCFrRsOhWZ5LMrjnqsrT4rfURQgcfy8LizT1epQDi+sdrAFlOfCvZhxyLyWplJrih19UBJ15S7CksklU5cwSAIYQBvhfFxUom0Yk8/M4bWa9wY73znuEWZGbcoFtG1K0YmCuuebiLx457UO3wUgrJDGZuxgAPWO3Jqgvvw6loC8dLN00NvdhGG1ynSiBkDehIBt1lvcRo4mvuAnQn84y/JhDusNjraWxI5SbqVSz7ueEhW7NUImCa679tF7g5lWb7P/qXw7fYBXuQrwZUAZrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bE3r/zxbj6riYe1a8zy6zIXyPwaIvIx8XSGxitdJ8g=;
 b=qAfQn+hI6q01PGXzfxN9duNQBogOt2u15XpNik5PZNNHXADxJP0cmj5qBrvSmMQ/8ppQid1iTNa6LNEpizAmdaRVSm054JfxCMpDsMdaBNGxS3ZNoiYGVKW7ffBiygjxpLFC/+LGJB12cUQSACZW6FA/R+/6gsP5RigpUIKwZVbdy1syH2VNKb+moB3aase3C9Tb+8m0K698pI+aTNY9YghRYWd5jqtnvsYPF1iqNgite+Jc0YosOmirZ2sYw9BvLMnt13MBBi7lK9N9N0qLa/OAKCyHkOGYRigDkp9jgfIkhAxDBVlcSTk8FhwBvtK1T3U8hRsA3yNO36hP6wa3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bE3r/zxbj6riYe1a8zy6zIXyPwaIvIx8XSGxitdJ8g=;
 b=SbGm5NLLL3RAV83iZ7lfnbtQ/8ObBoZ7kk/2SwYcvDYs7BIoXwwLkSaMBbIlERnVJpDLDjm2ZeIPU7S8EdCQJ5TCqjlWsJmo5TxwT4B4pdqzTK5Hma8sxFBLEDHHwo+942K49nNzfY+H8W4/echprVNYeRaNw2PXVug1fYGLTzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB5869.namprd13.prod.outlook.com (2603:10b6:a03:437::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 21:00:02 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 21:00:00 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, <linux-nfs@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] NFSD: Add a key for signing filehandles
Date: Tue, 10 Feb 2026 15:59:57 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <37BC9BD7-7014-402B-BEB6-BBDFFDEFAAD1@hammerspace.com>
In-Reply-To: <8C8698B2-B07B-4191-A9ED-8D3E64742D70@hammerspace.com>
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <945449ed749872851596a58830d890a7c8b2a9c0.1770660136.git.bcodding@hammerspace.com>
 <961be2e7-6149-4777-b324-1470b77f8696@oracle.com>
 <D37AD3C9-A137-4E41-B34B-8ADFB1582F23@hammerspace.com>
 <51ecc417-2f97-4939-a1fb-af7d23d44640@app.fastmail.com>
 <8C8698B2-B07B-4191-A9ED-8D3E64742D70@hammerspace.com>
Content-Type: text/plain
X-ClientProxiedBy: IA4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::15) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SJ0PR13MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: b521041e-0939-41d1-893e-08de68e75a75
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NWsrfH4bpn9a8j9G0Y8QHVyfyonkiCzyot0jDI6hksgH4m/q7/jUKJGZEPu6?=
 =?us-ascii?Q?lO0MYva9mZakDDvVhQmyCHET8nESY4701F0Gclc0mZ/dTchcRKtsl5cryo/m?=
 =?us-ascii?Q?PSyQtA28gEh++BBdj9yPsboidILvZSjnxSThoseidk7hnSlldPMyegocyUAH?=
 =?us-ascii?Q?MDk+WBP+9Ms7dQwexmIvT89XfDK7BPH7y6mbORJjUc5spQZ35fYSZkZYNUyV?=
 =?us-ascii?Q?sxhVicT0GhKzAm6y+b7FQHhGormtV8HZLPJhX9qwrTOwGDpa4BTUaY+DY6NX?=
 =?us-ascii?Q?b0TRoJQjBsnZuZhYggNoTf6k7nq0iVmYNM9Jvum1m9f67RgkE5Rz/mRW1U9/?=
 =?us-ascii?Q?3QX+S/n3eL2Lan+Ze6Ogd9xwW7ExD5BO60dkgC2XAJCdC0EiyeOyqq0GKoVb?=
 =?us-ascii?Q?5/EaIVPeSk4kJP/DNNsw8TmLo4NgIRzniIC+5bUeorMze+6QFJxXcdVOQZdM?=
 =?us-ascii?Q?FFfToeLPQXnuddAItImskDUb0OizlghdRtKmAzrijbUY9lHz7ieuUlnhUPxA?=
 =?us-ascii?Q?iu8XikYf5si1jhWQD1mRL99E6y11BYIihIubYxOt/dMXqkWiIwINpgFQHKg8?=
 =?us-ascii?Q?D9OaC9jMIA5gVbQ/VD7Ildq1KHjI4NUZoZFjAs34lybAPezwsVsvI3IAMQd7?=
 =?us-ascii?Q?oiNbEd1RA057zXakZZ1sjyKlB9L6iEOm9aIwyDpudmtnZJCima7bQev9n11L?=
 =?us-ascii?Q?1IIDY6azSXCMJ6T0TLmPigEBkIELwjsAB4PhpaSdIY7ZDibsC/+utCy62aTi?=
 =?us-ascii?Q?ve8nVby+h6IgPpqa8m2Jlp3IFmhUWDjzs62YAytY1XbqQAyy1UkrV9lVUHj7?=
 =?us-ascii?Q?mClGCZfj550FOPQBz3woKvqNRTPTgYjVelt9rKLDZEemBGMTfS95e9Z2Sq6L?=
 =?us-ascii?Q?dEmCVxyzpJVyJ+/deoWm/2RoZWe/h7W3vKjfXqXbjKR4a1HkcETYhpPSSD+6?=
 =?us-ascii?Q?0KnMk1QJDFeSnsCyYPeQtfRNRGvPSVpzAZBYLc/SP/3V5iux1ZcLDPH2Idre?=
 =?us-ascii?Q?gXhAlE3Q3u03w2ALTeWSRfAvQnfvKCL+DcFY3uX6J/GHLhqPqfqfHjtJIN2u?=
 =?us-ascii?Q?ggUHX63Y08BXPLBo1tFGgxFKNwTB+tyLazDIUZeutz91FdJQqPzVMglNlJqL?=
 =?us-ascii?Q?BscgpwteEgZ680epKNDSSyydJvheOGqmpBMy3FjJBCMHxWWZ8jOaqT5Oj5zL?=
 =?us-ascii?Q?tlE91nTWc2hn6yzAL8yX+nBe9uYcKFfJrr15m6B4M6EqwQCoiGBo+UpnIhv8?=
 =?us-ascii?Q?8VRax3ACZDdUZXJfqzO/Qd63GrVIujxxHGCdYN3XR4jBYF2vjhKc9TJ82ooe?=
 =?us-ascii?Q?QaQApbrxPzXzCzHVgcaiiuCFp6KlgSuH/hGrEoD6JPPHFc3q2YoTVXPSRUU7?=
 =?us-ascii?Q?rQ4xBxKQcZek/Txz3EDyaF20oLsbN5s5kz81x9HVMlrfsBhnUNNtiJ6TrSLC?=
 =?us-ascii?Q?Abts9D9sMAZTLUjXsYybJVSDyA3UHScU9i0FITw5O/ykEjeoc40eNq6TVEHm?=
 =?us-ascii?Q?rgzIwBigO03mfZi9UnaLQUqRB/nVY5ow51sN6lGF9WBXOJj4Ez2oTxXK1aET?=
 =?us-ascii?Q?G/OsTUCdgL8GvKKJmz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIStqMk6E9AMgyMrb41sBabD0UwrD5+B0BtQmvl156bKf3Hff63pZPQ/4jB9?=
 =?us-ascii?Q?YFyuDad3eSXV6H+xHIpmEuUma9cbkb5XgczUvCW6NrStYbHPLkNFRYXj0d7+?=
 =?us-ascii?Q?axXV+MO+dWRa8Cm33sZ3raV7rPX7k1EkTKIdntphC92vL61Bpg3N6Hdj1j9d?=
 =?us-ascii?Q?/tdJmF5IzJoRsnpEp5LSZk+qVxAg+WdUsen6lykhY51xpqHmxZazMRiHpEvP?=
 =?us-ascii?Q?iSvtzCJtu0TjNyYC9fiUZF4h+lXYM5VDHYNoyZMy6TLjFJ38PtBdlL3zrl9/?=
 =?us-ascii?Q?ixqK47I3G78xlQGddA5+fWdiOfD80qcUp/zFrPk/Fo9cmrL4kqxZYmrKo8zN?=
 =?us-ascii?Q?CodVrSvsM3gO/ldGgCVrD7mz9hl1cDI73GYqkld9i5vVuaiVHMdZxlz8Gdjr?=
 =?us-ascii?Q?6pea8yfbElWo5fW9i+J2AxWhQdhK/E9R8vjwr8TEBwh+lS1Wp2//JcBBUHxL?=
 =?us-ascii?Q?NMmMg91r3bQUeGrA0cvlq6BeTSYZTarfPNv2UwPVJ6c2u+G8W6pVX3Q1R9w1?=
 =?us-ascii?Q?yJLPbTwffRL71lL1uaDmU16ika/THWStTP4QpbiOEhVbV9jvn/QjrPBw1khy?=
 =?us-ascii?Q?kGOb/GY1KvI/BWIMQvfZpZF2TzGBNDxIdz6jf2EFPE9hKgJhpdungkb/C6hz?=
 =?us-ascii?Q?fQXmPfgofCokN5zuHdxS0baGCrPaTsmn7+3lmqHwMCBVORvH1pG68JhPoLUu?=
 =?us-ascii?Q?wv6VnRY+gPWZv5x/Ej266t5VctHyE7Y0RZzow6hRKyuvNQC0k3QTWBmMX3WR?=
 =?us-ascii?Q?YmdO8v3kfWZxxwfNaJXIFUY7jeWCJRdOdetKWNlS/RmOONe6nXsp81W5rL1i?=
 =?us-ascii?Q?YtX0ZdC1HkkV8MHxrFGEswCgGMH/YLMcSih0bic5rCCNWfWx780/e/OLcFPc?=
 =?us-ascii?Q?YK+wRDwgrBsnSs4yGHux2oPn++PCxgp9RAO1fTOR2IGp3aIfmmHdwuv+g5QO?=
 =?us-ascii?Q?VEJZg0YuDQ4x2BRKZLw/qmckFXFox4g8/yCUPDrzQQH/bsePHaBnCtk7r9I7?=
 =?us-ascii?Q?fmz160iNjQN7XpHjYKsR1UahwP82yt3GVmhgUG3u9SwN8qYpDQKw1RdB7m1P?=
 =?us-ascii?Q?tuy54gcQx7DqwfXigTI4DGLsZ9uAWj/JzNDINOpF8lr+lNiJb7WM0W6Of0fB?=
 =?us-ascii?Q?wlmtny0xVRfhxIhV9A9bNeqzNNhLQwopeiiphFCXM422SOl537MRUtaA9dnq?=
 =?us-ascii?Q?DVSJWK7N88QLP28PI9lFjGmnD8udJ22wGUZVNFT2FrespMb7L6MfxjXvlZcM?=
 =?us-ascii?Q?uTJ5psOUrRJC1XyTqyN5Gml1dBMeuF9mg5MhUil/MmuYen4sUJNFAJM25IEq?=
 =?us-ascii?Q?4yjXyA29b0/S/s0BLzH9pfwpwjkjXe0HZYHsaW2K+KWz+uzQh43JpywaDN9O?=
 =?us-ascii?Q?3KTuSM47hbeT499VxafZ9j02tJmpdP3IPVZDmFHNs2srkJR/jDqVu13j0WDW?=
 =?us-ascii?Q?OZl/aA3J7JfXSiii0/e5XH5HJmBPxetcfI7214kh5uQ1DEtp/zyuoJWpXH96?=
 =?us-ascii?Q?oyMc4pweWFM393d8Q7+IKYE/UfhKmFUDMTr1JARCxffgxEndRL51YfDMfy3d?=
 =?us-ascii?Q?/nelyMXIuA7KtnbKS+EbtAVc4w/SbRTMaxPBeWy9VBw7Edsu6N71Yv6RwWz6?=
 =?us-ascii?Q?dzqWKLuF6PQwcZrxWaT/ywS8Ize4rwJLvAMCOg8DamvNjqV/IVfovZM98B4y?=
 =?us-ascii?Q?6VdVRsj7kJsROTo7DHbpBwCFr0YpjWzFZWUYOPXJqvU7Zu2DpVFPrP8I8fNj?=
 =?us-ascii?Q?bYp5U6hkXiQ7DjqtCMK02Zsyp6tLZg0=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b521041e-0939-41d1-893e-08de68e75a75
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:00:00.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9GMyidzrbtpgRbWxYEF88caZooBRLa1BENsYDbbB3uLRULLGs3aBxBDa4ZucQe5UTNrAzIgsslexx97NhlYSS98VuV0Fio1oacyB2VTjIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5869
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76890-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F91211F3EC
X-Rspamd-Action: no action

On 10 Feb 2026, at 12:21, Benjamin Coddington wrote:

> On 10 Feb 2026, at 12:03, Chuck Lever wrote:
>
>> On Tue, Feb 10, 2026, at 11:46 AM, Benjamin Coddington wrote:
>>> On 9 Feb 2026, at 15:29, Chuck Lever wrote:
>>>
>>
>>> Let me know what you want to see here, we can hash the key again (like we do
>>> with pointer hashing), or just remove it altogether.
>>
>> Yeah, I was thinking of hashing it for display, but then that
>> loses the ability to confirm the key's actual value. Another
>> option is to leave the trace point in for the initial merge,
>> but add a comment that says "to be removed" so that when we
>> have confidence key setting is working reliably, it can be
>> made more secure by removing the key from the trace record.
>
> Could just redact half of it too..  that could serve both purposes until we
> pull the whole tracepoint.

Thinking about this a bit more - it matters a lot less what the key actually
is, and much more what the key is compared to the last start or if the key
is actually getting set to a non-zero value.

I'll probably submit to just do the same crc_hash on it that we do to
filehandles, and if we still want to rip out the tracepoint later that's
what we can do.

Ben

