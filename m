Return-Path: <linux-fsdevel+bounces-75109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CAKAdRZcmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:09:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B478D6AD9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68CC030932FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F0366577;
	Thu, 22 Jan 2026 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EYNdPUBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020108.outbound.protection.outlook.com [52.101.193.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0942C11D5;
	Thu, 22 Jan 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099494; cv=fail; b=OqFkjGGJkmQe7QcvpEUdX36Tf43N4Dh54aVzAGa30plFVH/NnaOvz6vmv6wVa/29iGqyQmqFWzsjcCuf0XOsRxAXcM7bt4Rc0VOIuq3dMm8IiUad3AS5iinsCrE5T+aqSMmdWwQ0zK3B77AqnfAq7YWe9Sb13KaPTVvrghpekGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099494; c=relaxed/simple;
	bh=CKGCm6MXhxO7IYn+Bw26Pphu1vni+5o5usMTKocKnv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JE4CFTYvjOeV9aG9P1nD/8ZlHFUTrYOtYZOIfhL97c58M6olZu3XhRMG1EL+v/iKvmpmCss7BEalAwoSS9K3da0BKUiOBlRqVfHxcKp/ga3IZFxtMEJl4PyzZR7TrlPsHRuBxGDk8NtBJgfBdt3EyJq79RTH1os8DtArisGXVeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EYNdPUBy; arc=fail smtp.client-ip=52.101.193.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWyykGj8g3+umK3fckJ5zB5eVmHYZ3w57FDbRD0iz374cqRqEa40nnaK59qHosMtw2hj2PlRLptC1zM7bcz6wp8vb96fB399cWrbDDTn+Q2Jb8XOTdcfQvSqBq4dnVzXmvR4A55ABGsu360A98fY++TflibEQiHvomoa9EKzztp25QlDGxYGPnlB/gRmFfKjwfFNbtIRt12Pb1PSJwpD29Gi2rWgzZy//80gq2WDVZlCE4IriWYlq6zU1ChCcYwV7kaDPl0KbpQJJrnBFvDuEbYq1MJSgi3ACj4M2oYXFeGc4oW0/CSN8ti0Qf25YQyP1opGkc/OGCN4wSUxWj85/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbpdxPwT5cc2/7rpGJPJTL6A9n2+Bjy1BOfKbNoSl8k=;
 b=YG0n4bdpB4UZD3rRd/Vr0HmQpPGaqnQ8Id3nN/Na1LlffZzM25shHavJeF8zZYq0dEd6WjMbekZbNy3v8+0MJN86uJ+rk3PmNUSwRpY/dU+r7tgGTNl67+XY7LGYgLeqzYBlojDavlwyKTZQh/GUlp7TZ+Tv/6wBQVuuK23sZdUk2quJ4PHbHVuqRhImz9L5Mh9QkQjTQHuE/nYNhzE1heYSAEbFVFMYIA9xrI8GApN0GHZxWkY5iYH2m5/dX4VTel74CppVZkulkht/2ZGRKB/Wv/GaEX9VjsqT/Sa4EH6bb94cCcdAwJx64iJrzILg0y7hMdQQ8J18VlP5pZwnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbpdxPwT5cc2/7rpGJPJTL6A9n2+Bjy1BOfKbNoSl8k=;
 b=EYNdPUByEYzqfbENyM/IDkagW/Zd6UrvFuZnaewDnpDdukB/S3uAcpmSRdxPDhSs+fwORFvjOnzPifqUtgN62JPNTFwI+QmIIuweF6c2MZCRw+eCeaTlftXG4LzIs+EYGq8oADjxbuWxKKnlBvfPNo6Q7BlxKu/sfdtPW76sQQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 PH0PR13MB5518.namprd13.prod.outlook.com (2603:10b6:510:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Thu, 22 Jan
 2026 16:31:16 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 16:31:15 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 2/3] NFSD/export: Add sign_fh export option
Date: Thu, 22 Jan 2026 11:31:11 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <0597653E-1984-4D2B-9A47-9BAE3A8E7A8B@hammerspace.com>
In-Reply-To: <801018d9115ea8abb214eaa74d5000c6f7f758a4.camel@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <7202a379d564fc1be6d2bfbf4da85c40418d9b07.1769026777.git.bcodding@hammerspace.com>
 <801018d9115ea8abb214eaa74d5000c6f7f758a4.camel@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH8P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::15) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|PH0PR13MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: e49ed53d-bdf6-4c7b-d77b-08de59d3a9cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWtiz6QFj4wLUq381Wn8VBXkP0JU4Jk2mqh6lBfkK5UB6wiyYirJPbTwGZAx?=
 =?us-ascii?Q?I2q3heTEHZgj0VAB2/1xphnfvoBoavz1kS4RWm4hUNK+oSj6mDFoWL0LaX8h?=
 =?us-ascii?Q?nhrm3GSQROfcKPtsRijuRcBTvAt3S09wqJIapP+jJFlU5L+EnAmaE178y9ZD?=
 =?us-ascii?Q?aJYs9dMC3i0STlw0filUWtwRYBTSPMiHsE6IqC+BRSsnvQPpnlpvj+2fWLAQ?=
 =?us-ascii?Q?4Tr0IPXcJfBqX7ARZKcr9KDd20mBJ09upR+bmcQxbRcU9fMiDnYRMufLRHWs?=
 =?us-ascii?Q?7siZiffw11GUU7C8P7dpqvuv1MaumSEvatQpIP1pcF3FdGmHxoVvgWJjKtqV?=
 =?us-ascii?Q?aupbRlvWi4QVHuNJvNzgbSYl2iBt+Ha+oJixxcoaOXrZyi6zYfkeqvlAwf7r?=
 =?us-ascii?Q?1k4E7eeMZsWA6lh0/7DhgWK1sfKs8dFDIeYU9rS3bE7hyxHMtUqRhimxn/+J?=
 =?us-ascii?Q?8mU8Z/AGGNhWQgUkST3AYhrVUBES2nq48k50qplnrmtOTMQrrz4bkvFraHHJ?=
 =?us-ascii?Q?E+UHnhqTIaDkKT9UUVwzN4bs3PaxxurWvy0LdN91vCLX5Mu0cTCuEgBEAcY+?=
 =?us-ascii?Q?K3IkzYbsHFiqvoPG4jDt9YZLpeBkc5neZNlGvJjWkqQlFoGBrrjXnUHjXcpm?=
 =?us-ascii?Q?OXaGuAkqXDC0dLWfVPjAdEg7qBcI7RA4EZyc8M/5K2EXALmNogjCYhW/R4jQ?=
 =?us-ascii?Q?v8IBsvg3bWYLK0cVEztyRFtwRQ8xrnyA5mqGjpYQf4Et0B/mEJAV53fvqSvg?=
 =?us-ascii?Q?AT29mSVdYIIUEH6GndUNkmEpqKYzptCOjmvgiBQ/ece38V3WEFt1eEyBwBkD?=
 =?us-ascii?Q?m4zCNkYs8nLEjAP226e0jVdynOURhQ97w8A2yL+3LotrKIBONoIbmh/pPw6H?=
 =?us-ascii?Q?vTGP2UKWdp5xq7ssMdTxD1k0x4Q4A8YWeM2AFnkGAd7PM+9Invd9vVABBrXC?=
 =?us-ascii?Q?wp5I77urOCjERBkHVUcDXybEwh5++nEJ4hQMrx7EcTkitGYL2oKZlyJRGzJ6?=
 =?us-ascii?Q?vIjbWdRQJyeuL9JItPZWB/tf9jdgEl4osHwl+0PqUX2IqVnLMDwD/h1ZNT7I?=
 =?us-ascii?Q?Un3rshzOkmI6FA5bkiLSrE6Nkj7CZSd18NhDYDQJrmIA0dvUSWfDz+NX3LbE?=
 =?us-ascii?Q?PuQbT90ZUSIJmZJZOw4ILLa7H5sIpbbCxWwiP+fTXAC0HNSJutz5ZKHi+uZQ?=
 =?us-ascii?Q?Ph9nGAnyH2pTWcahobK4HNV6UkUX9PK+RIJhskcXWBbgIsN5WEfePCUukucd?=
 =?us-ascii?Q?J/A0gbeQlWmLW1Dq1YGHVAw8lMeqnK7y6z6HerWBm8t2E0Y22PJ29TCLHbVg?=
 =?us-ascii?Q?KpRc+dDsErEe+xw6CLNFc/KpczCh07ALsaD7YOpioPMY/jL3W0zwUP5w48qp?=
 =?us-ascii?Q?E308aiZ4Vjpvd+Ln+zwexwty/ORoszqAcWADMzEqlQY+46vzowbj7Eg7QohV?=
 =?us-ascii?Q?DCtE7ZFrct7Ts5gGDjDywNNQcyS2ngnFSDkONzj0Tl5TNFg1dlF32ZRnxi+6?=
 =?us-ascii?Q?mUVzUJR55a1MqYQOIZ4x1IEWxu+5v8Pn/5GZ9icndPsSc2BKO+sLVsuygSsm?=
 =?us-ascii?Q?N27niN9mlxue896Mkfg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2HLbKOOZ+Ln98+scHgiyqLhOByzjUDIYPne4wNkqvbz4SCJdf20tovmKOizo?=
 =?us-ascii?Q?AmuT+ivqWwETR1mcsWIbFclvkQtmOgQ5REEJxluJLa6M6aSKtA3P20/zHLYF?=
 =?us-ascii?Q?3tA+BHjA8Ldlrq89RT9B6RcarN6lduInE45Y3Pw8uk4gqskfJevSU+AhP0Kn?=
 =?us-ascii?Q?y/kJdskQM9DLY0vFWXMUbBUsrOEhjRbSggyG34tkFknN68vWePa22g60v/6H?=
 =?us-ascii?Q?Jmf2KtpIL8yUtEmIAQdHAiQkjSOfZaFIib68lbEO5NP2whAm4sfPc6FwpTgG?=
 =?us-ascii?Q?JTEqO1TkmYa1aFbt9c+asRTmkUvgtPA4LeLyUO02bGbgCJ7l4DUrikfrlGvW?=
 =?us-ascii?Q?BQjooZv6+OfuvnL2hY7yHEvQ1Dijyt0PUCZrMwnpJ5WytDqk/53AAJ3F2IxX?=
 =?us-ascii?Q?hNygWQSjhJE86vWOHpC2JakA4BTnP879bjI/cQX6s28GpcnI7SLCrz4o9yqv?=
 =?us-ascii?Q?6CR0kIZJvO6Bf+KXIZ4X1+SwA9rQh9brBqoEFCg2pGSjrlAeUAtWM0rQEW0w?=
 =?us-ascii?Q?g1EWpPDL5aYhcytI0kE2LmorCeggGbmjRJ8qBIlTOIT/sf7u2O/XG7FR+o0R?=
 =?us-ascii?Q?2zT9P3tGDMOCYvrrHwa+rtr+Ja20F7nA2l4gcqjrrA76L417bYZLPUyA2U0x?=
 =?us-ascii?Q?eC65cVzjhX5//V3dQYD0EAhfhfR5Wkk53uF5StGB5r8X4EkeyFNw40F51wkW?=
 =?us-ascii?Q?dNFRlsuZteR4SQX7gi+74J3NIRgEyi0BtRwCoTWCLxXUuwpfvVx7M4rK0zu7?=
 =?us-ascii?Q?CwaopOhokIB3+Wm3r5IgqQ57pX8VQiL+xsl68Qb5LEjvYtnN65zYGvyy0gkX?=
 =?us-ascii?Q?v02yCCaQIa3gnMZCP7wxqGkQpbDeeQ2fpF++W+b54Y4PBWeULsk3weRjlPJh?=
 =?us-ascii?Q?J3zHz+0tp6WxatJl4XCEZJ30bEZXB/1E1HMO1CaflPR6vALQVoOCwWIAhK1h?=
 =?us-ascii?Q?fdjbwFbEFOfNqhkFtef3bC0Bu+ExoAedw0U8yNxqR3FZ38Vx+Z5EZ7JdSqjD?=
 =?us-ascii?Q?AzCLOv4W4e4i8OTMSfKk7hR0gfU6u87cj5oW9pBFlqz+adJLZ4Uknqy5pEY+?=
 =?us-ascii?Q?+x3xbSPl2bf/k9mPb5pFE5JRUj0jGLgRctW4Mdb8VBtxT73mMxGtPUax+fra?=
 =?us-ascii?Q?rn6sJuv17PczOE8pLRjo9yidF8WxTPv+IeJMD7sAUwwT0xuzpSVz/hxfmUOd?=
 =?us-ascii?Q?QUKlQhYVQidepDSG15RWw5B1t4pxUqE0sOP4mlM/swYLpEMDFx/u2Wcn0gvl?=
 =?us-ascii?Q?o6OsENu2F7ROdvzpNUn+4Ea/dEksGqeWCOnia8NKMf0rODCFxGbyP6zZsKdf?=
 =?us-ascii?Q?LfyidXnwI3kV/s8Ojk2fTTKQYa2EVFXtHkTcC9mQrZ13KdXnX0aSum+Uh9x5?=
 =?us-ascii?Q?Vjb8akc6tpu09yVVN4ehMWT4Ay/yt+PsXrwd1X3SglppTyc/cIch8YyPK2e/?=
 =?us-ascii?Q?Q5D98MYGScLNAUaKFVOMqvdy6qbVfrTYg3tnh3g/nPnG+AYR1T8yiHEEbDG4?=
 =?us-ascii?Q?ChOa63OTTvrfbK2cL+8WVoXl2qrF5w0Swo+uMhEdX5uRvmfYOmfq3fFHDJ5L?=
 =?us-ascii?Q?EYgTSBUfim4vNEUabpgCeHMGN4ahvBZ6/WNO6NCIehpooBnP8A1Q+UlhlT5Y?=
 =?us-ascii?Q?BdNZ5/XAsAE2HqRdE8PmuXZW0YXZouLZnCX2efgoGziWJhj2CeMgeRbVQOSu?=
 =?us-ascii?Q?3xtjSzB9p37tjm6Tp2BSJz9deErJFp5XJmzZulPV/b7f2IV/I3vo4JwMIUwa?=
 =?us-ascii?Q?v/iAabELl2f9MsuEeID6tkptijpK4G4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49ed53d-bdf6-4c7b-d77b-08de59d3a9cb
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:31:15.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnzyU+I9qMwDFN6OjkWIcltT7DRnDSB7WRdX3N8wT5ASwotwO+2px+Qs/sxBWWtGWJoWi7jrwzLvV0HQ3pkAbmrGrRX0aNwbXURZvR5f4II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5518
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,brown.name,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75109-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: B478D6AD9E
X-Rspamd-Action: no action

On 22 Jan 2026, at 11:02, Jeff Layton wrote:

> On Wed, 2026-01-21 at 15:24 -0500, Benjamin Coddington wrote:
>> In order to signal that filehandles on this export should be signed, add=
 a
>> "sign_fh" export option.  Filehandle signing can help the server defend
>> against certain filehandle guessing attacks.
>>
>> Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future pa=
tch
>> NFSD uses this signal to append a MAC onto filehandles for that export.
>>
>> While we're in here, tidy a few stray expflags to more closely align to =
the
>> export flag order.
>>
>> Link: https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@ha=
mmerspace.com
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  fs/nfsd/export.c                 | 5 +++--
>>  include/uapi/linux/nfsd/export.h | 4 ++--
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index 2a1499f2ad19..19c7a91c5373 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
>> @@ -1349,13 +1349,14 @@ static struct flags {
>>  	{ NFSEXP_ASYNC, {"async", "sync"}},
>>  	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
>>  	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
>> +	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
>> +	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
>>  	{ NFSEXP_NOHIDE, {"nohide", ""}},
>> -	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
>>  	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
>>  	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
>> +	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
>>  	{ NFSEXP_V4ROOT, {"v4root", ""}},
>>  	{ NFSEXP_PNFS, {"pnfs", ""}},
>> -	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
>>  	{ 0, {"", ""}}
>>  };
>>
>> diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/=
export.h
>> index a73ca3703abb..de647cf166c3 100644
>> --- a/include/uapi/linux/nfsd/export.h
>> +++ b/include/uapi/linux/nfsd/export.h
>> @@ -34,7 +34,7 @@
>>  #define NFSEXP_GATHERED_WRITES	0x0020
>>  #define NFSEXP_NOREADDIRPLUS    0x0040
>>  #define NFSEXP_SECURITY_LABEL	0x0080
>> -/* 0x100 currently unused */
>> +#define NFSEXP_SIGN_FH		0x0100
>>  #define NFSEXP_NOHIDE		0x0200
>>  #define NFSEXP_NOSUBTREECHECK	0x0400
>>  #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - j=
ust trust */
>> @@ -55,7 +55,7 @@
>>  #define NFSEXP_PNFS		0x20000
>>
>>  /* All flags that we claim to support.  (Note we don't support NOACL.) =
*/
>> -#define NFSEXP_ALLFLAGS		0x3FEFF
>> +#define NFSEXP_ALLFLAGS		0x3FFFF
>>
>>  /* The flags that may vary depending on security flavor: */
>>  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>
> One thing that needs to be understood and documented is how things will
> behave when this flag changes. For instance:
>
> Support we start with sign_fh enabled, and client gets a signed
> filehandle. The server then reboots and the export options change such
> that sign_fh is disabled. What happens when the client tries to present
> that fh to the server? Does it ignore the signature (since sign_fh is
> now disabled), or does it reject the filehandle because it's not
> expecting a signature?

That's great question - right now it will first look up the export, see tha=
t
NFSEXP_SIGN_FH is not set, then bypass verifying (and truncating) the MAC
from the end of the filehadle before sending the filehandle off to exportfs
- the end result will be will be -ESTALE.

Would it be a good idea to allow the server to see that the filehandle has
FH_AT_MAC set, and just trim off the MAC without verifying it?  That would
allow the signed fh to still function on that export.

Might need to audit the cases where fh_match() is used in that case, or mak=
e
fh_match() signed-aware.  I'm less familiar with those cases, but I can loo=
k
into them.

Ben

