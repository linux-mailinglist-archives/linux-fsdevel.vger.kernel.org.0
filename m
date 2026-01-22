Return-Path: <linux-fsdevel+bounces-75140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEbGG2NwcmlpkwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:45:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7806CA39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03CD9300BE34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F436F43C;
	Thu, 22 Jan 2026 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bynxUhsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020141.outbound.protection.outlook.com [52.101.61.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741F33EB09;
	Thu, 22 Jan 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106073; cv=fail; b=QLImRz9SGVIFeIbYiCNBQCB9aPkje45H2xnjm8fFnRz4iJGhUouDORSX6ID6kZmojBM3Yr+8aKTlsDO+vc0wDw/p1aESTq+4U+5jxss/c9Z1NRM9vuWVS3bTpTbMgtnavvID2JAe9WMqTdMzIhBghnwvWHSvKi7lmM80VSOL/nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106073; c=relaxed/simple;
	bh=7h9cUM+u2DGhkwVms1LpI1A/soeoZvh9SdgOrS8AYqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OU662xuXkYx83v4+ZrNt2lp0DmBzVgieLKqAOY8l3Mi8NeU8m4oIX1I3nU+nunx+kk9WoF3dFkvo2sSPac/F9NTU5z4CCnTOEsCRQY6XPQV6BJslciaXvLl/QSUw5jsIuLj+Y1b0LsMWFE6U8GnuJV7nz5+8ANu7Ijs9OHXcgdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bynxUhsN; arc=fail smtp.client-ip=52.101.61.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aralh2oiH8jpszWrOv4brC8t7R6HVvTt0rjhKQZ5/aGhFJqz4qO9Kj0DIbhzgmKs+tevRXD3dh/UYscafsymNsZYb0NhO2IIsZ0Pjfk2bDsS9m7jNWExKHhr28q4qE3nI09IljsGng66ZKQW9t2FicGJYw6mFHUS2Gl0oHWro8PdwddiVZ+KCtDewQ68t6ElZJY+InCO8W933MPN7zXjdA99cPzOsprRFMZ7IgbJcgNuUoL5fgwuhGu6lDrk1yCQBOocZLPg1CKIN1Ol2qtLk1LpjkwaHUdlohcFVz3xNxTtNYl1bjKECnywxK7J9zE+lsS4PPMX6rcUZnXqIr2UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKQieWv11kx1+zo8X6obUb3zCUoF+45GazLJnDNAtPM=;
 b=U3GJ3g9qzLbZfSIdvcoazoE5SwCQAxnlQzXCRL2RD+K3S23fSon9XkILYdC44FfKeR/AdjsDadJwBa710CZssN7YrP+AOfKnu31xslr2oIiyW1yUpx1mmUZkE51zMvBkoQQBQXSO6WdQpM5mfTPu9eECPR9zhwGL5jMecXIoYF8xQgvOhB71Q6UD0IgmFwpARIvE4J+GWGICfZ2n580SO9ShrlCGII3u6lDGK8U744a3aByLtfSZg+haAp/TBPwmneEwFW/dMwR73W27FsGdmKU4rOlw1yG/ZmlWLQEk9RfGl0dW1r/LhL3/zb4LsfrCXY5MWUpzakPiz3Rx6uiyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKQieWv11kx1+zo8X6obUb3zCUoF+45GazLJnDNAtPM=;
 b=bynxUhsNKsyHnbJKVTIR+/KLpCONYCgGxITsyu4d4Jm0E4mdrRqJjJVil+KaP9IAcFgSvSUiesPzXvCObE4AC5hnSRcS+p/YUc2kDwsAENpVATQXWaxgd7fSMKKlyTN6Xp186VcXl+Gvpz5zPSwRuPLLm0Iwwj8bRYrjxKVPTWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA1PR13MB4863.namprd13.prod.outlook.com (2603:10b6:806:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 18:20:52 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 18:20:52 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Date: Thu, 22 Jan 2026 13:20:42 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <6D390E12-0EF1-4830-A67F-9C8614E924B7@hammerspace.com>
In-Reply-To: <b4b88c29299dde052a8864e7104a40eb616a26ad.camel@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
 <b4b88c29299dde052a8864e7104a40eb616a26ad.camel@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA1PR13MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: c589fea0-b63e-4b3d-d8d0-08de59e2f63b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ZT5l2C48EMv7rEqf+/dONPpnuG4AjX52taE2Sh3BDq+fJvhzwndM4wiAcvb?=
 =?us-ascii?Q?HXK0sYNfWD69NaALShPrgK0NKMGHxVWxrm9K1SE+HYv91wrAa+mlocIqUUZP?=
 =?us-ascii?Q?b4lYEr6VfxM1gN/P/fhu9dkkdd26LyVlE4ef6xZWsHy7ZBqCROglYE0Hrb82?=
 =?us-ascii?Q?7IJBYwzgN5ku/cj4AM7wuYZQa9DW9yAf0+34vFdxPoK1Zltps/jjd33I+Pbz?=
 =?us-ascii?Q?4Vf7JSntxTq/+2PC96XwfFHGG1b1aE01O8nbSOWvPD59SrFjebMr/3+t9vop?=
 =?us-ascii?Q?7+bexY21pCwfKyXvaZj5aAi/iiEJx0DINL8QxPDLclmIWqALUN+SGvtvsHYK?=
 =?us-ascii?Q?A1cM65YaeI9XbGJFOzwvy/lNbGZg8SeJS0XZZBBbjU0AsEU7ux9XUp4Apk/w?=
 =?us-ascii?Q?AXurNkBT6f5gSX8N3uCkWbiS2NZPRicnK5IJuk9iFDGSaXffrvbybrXqN+gn?=
 =?us-ascii?Q?51iDMJJJbGdos1mtQYUQPkhaYSqYmZWtHT0GsjhLXU3A2NHogU5j5PulAjP6?=
 =?us-ascii?Q?1Ab/YHW2lgurQRtcYW2kyFLNOq8m41HCNZjNlFuS2fzmk5myXIKvBSuzvTp5?=
 =?us-ascii?Q?yBzUKEeXP7rx/G5Z6dSp+HaOkoS44rtmFgrkh50tlRNsiygIY8BHWhr5VgC6?=
 =?us-ascii?Q?XwF4bNgd4sisnnaXWXmI8szZTfcifuXLOX4xJMPPXSq/CWIIwQB6AxRq+Dl9?=
 =?us-ascii?Q?zpIj35P5k2V2gFmJVp8bG61aQK6j8XP5wMtDhk9FAilFru1qf1VeuMjIKb3n?=
 =?us-ascii?Q?GPBdrYctap9OLtS0XpkiUZbqrwRdLknxeqDVaoX1tEVHv1x6VU/aRHbr1yTm?=
 =?us-ascii?Q?IQt25isdyCDcMPNk6Zjb9MXqJ7GTYZVNGzi/fgffLM7IgCOE+SmgfeG5fJZM?=
 =?us-ascii?Q?oTAYb0JzSO4AeGmVGYVMm4DZTEDA/PynJ9oQbCmdp8dv4TMeLGL4tZeT6G3b?=
 =?us-ascii?Q?Zd7dUSPJ2sHVL2BSjoa5n8UktfqTM2VW26EYGIT49LVXEk//JkWUONKeQSJe?=
 =?us-ascii?Q?pYogsyr0ZMQSo9ZUEYFQaRePGxx0F8+IYRuxBpK1uu55u1HR3ha3MamGSdPn?=
 =?us-ascii?Q?xv0b7/Yd6w3ipr1NKFv9mRvKq1FaCAAFohaY7VT98kdesANvsW55Jx/H+vE5?=
 =?us-ascii?Q?eYE1oCk+gvpfNQ2YJgmWkhq2Y20DGVxl4fD2c5mxYFhtaU4vo0CoH9EZUgXQ?=
 =?us-ascii?Q?dLuHFM/5Amr81HG3vJCUQ0sUHlkk/yQAIxiJWGjeu49cTW+rzrhqF8FM9msO?=
 =?us-ascii?Q?PF0R6F3KsWkrgt9izwh2T939PIQR4tK1TxXzAKi/0biLeaZlynpex/n14Qom?=
 =?us-ascii?Q?DzXaa37lLiDdDPwUfIWg3FoLmxv8pS0tkyPGFQ/ITznDNXo20VyUbQ0os0NH?=
 =?us-ascii?Q?PnJRlzYRaTsgi53f0ANKyaHaDUvmButBUCxBi5UR/pAiq9ELzfZg7X7OEPH5?=
 =?us-ascii?Q?c9e36ZXWYnvk05MLiegXRCwqcmdLZ1DjNqzY27VuRm7RxwK34cqg0pd33T7S?=
 =?us-ascii?Q?KDqa69MNg1Jq7jeAWuzSs9fogCxDYvYJt/qMc5QZVC6f8VEcR781/EJAJ8ot?=
 =?us-ascii?Q?6Q7V97uIk8SVTHEbVtA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p8J/shjSE1KBmgQqMjqBlIV6ODcUamMFF4bmqDUrwZu8Tg7XfHxfZ7kd6BNN?=
 =?us-ascii?Q?pqDEF62XUqObIGPkvwwridjFWDgyQXmTeKHQN1UDX4Q7XreXLEnOu4EJexiF?=
 =?us-ascii?Q?t8x9tFLPPJxwMvWvznM27fhBwAvMP8ui24c8XMt6EmKCzYfXexPFeoiUV/zx?=
 =?us-ascii?Q?57GjoKE6pSHJY5uuGItWnSOx5Ivg8tSaGFMrRlizgwFDcevQ9noVlIYAAHUy?=
 =?us-ascii?Q?vu4Ivq0e1EW0VDRxiyTCWzcj2pTY+4f5GmdnnA7oBnQZD+IbhAxYE7yyCNgh?=
 =?us-ascii?Q?GWSOBLQVS8AwIM1Tkc0SedOOPqcwfGmg2Ma8NwRlCibnlRaX2cBXhmPeXazp?=
 =?us-ascii?Q?ZLLOXALpXujD1n+CmOAGeidHl+MGYh3HTHXG1Pslv0He06lTEYR/PZm0mawx?=
 =?us-ascii?Q?GQmvRTb8pAnsQopRj5rvWvpxCqYBIWyRPAWzVDif1Y/dTgbb7PhflJTh3iD3?=
 =?us-ascii?Q?d5P9yjo58Q1v6RqJRCOAPcJtnC9qF/zwB26qf2whBrpbVaOlKnAx51wDVtNn?=
 =?us-ascii?Q?LNVFveX3XRkzeYQcaIcErr3Yp9Gd01R0IAQYnZbJDLhnkard3Bi3X1/NUHOv?=
 =?us-ascii?Q?BOzdfidA8i6gIR1DKdlwZbr5gJsA4HHKzhRKpliy5wahy69x2wmnTZWLFQEm?=
 =?us-ascii?Q?H2zJv5XlaXzIihoibzzsN98NA7B6Y7Vchf70tJz4AQe59XYmlSVfT5Zg7lqh?=
 =?us-ascii?Q?UNL8giN+Ur7SPNvWwWEwPkdKMf2WktaASMFJtKKzT6vSTa81LvU3PqQTIuTX?=
 =?us-ascii?Q?zXDx+5eB4+3vfiZNWgj79uX217yjLAROTlLJ+kRRAPsydiqBGMWykUVDrOl4?=
 =?us-ascii?Q?zQGpiyufFlIDFuuZDPYCOnJiSNpt6dIHY5bTiZuN+Qb+oipkSqU5+AoI8yEK?=
 =?us-ascii?Q?kHTX1q3JgbwC/LKCjPjRHiCEygTp4x7Cs6593VFDkpdtYCFNDOpWTVdLjdUc?=
 =?us-ascii?Q?1qOSSPeRmelXZNhGERycizEuiTv1Z212OuNxJhkMhu/vkC9gqBy7M1tqw5KE?=
 =?us-ascii?Q?4Q05hqppmevCn1ozd9lnZ77FfoWec7qz2H7419Gad0LUTAMxRNHwPJN/nOH4?=
 =?us-ascii?Q?N0+da/4ckm1AtVIWqHdiVDg7aLrHjZmCVXQJjgFMWlPZZ6MXWqyE9/q5xh93?=
 =?us-ascii?Q?fozFNfnEG4hHPoJnq3yGK5moJKNO4T+8EeoLSxcQzETy/XkQTg4qcghrhTxc?=
 =?us-ascii?Q?mPW0tQBtqxUnyMQmaSA9MXMJYtOy2lJbBoa08M7CI/v0a4fDz5Dyo5CHQWWA?=
 =?us-ascii?Q?rxGCtlJzIi/zfNEEvURB6gzZPzeJxUE4ksdpCIL3ZPx/2579s4QnHouV++QE?=
 =?us-ascii?Q?7SQIMJ03ZCZFsvv+8BAzrZDpsIQ3Z/GbvyJllyQzVtW6dDEiLIgfPgop7p6n?=
 =?us-ascii?Q?4PLj3zuJI6W++yV8skR/6dnh2hvIbHBmXV4c07FLVkcwO7SvUYwhRYqBqACr?=
 =?us-ascii?Q?/fo2XKJFY7ACIDjlgdS2ZT+vZZp4X1vTRSe8y1vZiAoWHc3PxcOMjn76ukH8?=
 =?us-ascii?Q?OmKOt/RIjWuACJyua39rSL6SNUMuR7W4Q94C/RIdOAp7E3ZdaavDS3wCOctN?=
 =?us-ascii?Q?HOP48xicfhYcI1Qoust1gXP6t9GX44VP3066/IxhucMBDvjdHX5jot3j9Lk0?=
 =?us-ascii?Q?XfMwhF0fJHnI403+SMAuzJhscpqEyO2bb9dzIZhl8n7vZI93tQoqDqnd/kDw?=
 =?us-ascii?Q?Mhn+72V23ym2ki+lzUVvoIDmSmebsTamNp3vdb8zC7ufqgv9OysgtoHUOeCL?=
 =?us-ascii?Q?obVmFWhCFQ9j4UYV476UUBZttQLNm94=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c589fea0-b63e-4b3d-d8d0-08de59e2f63b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 18:20:46.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlJVYWcYeR4HrQ2lhICa++KoOYHpr1UzycFYbhgoIktK8olyGFAjW8gq/5LpZRS/2KW9B7DRQPjb2vLtkVmkNRvZTweWYNKu9L78OCT2U9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4863
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75140-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 8F7806CA39
X-Rspamd-Action: no action

On 22 Jan 2026, at 7:38, Jeff Layton wrote:

> On Wed, 2026-01-21 at 17:56 -0500, Benjamin Coddington wrote:
>>
>> Adding instructions to unload the nfsd module would be full of footguns,
>> depend on other features/modules and config options, and guaranteed to
>> quickly be out of date.  It might be enough to say the system should be
>> restarted.  The only reason for replacing the key is (as you've said) that
>> it was compromised.  That should be rare and serious enough to justify
>> restarting the server.
>>
>
> This sounds like crazy-pants talk.
>
> Why do we need to unload nfsd.ko to change the key? Also, what will you
> do about folks who don't build nfsd as a module?
>
> Personally, I think just disallowing key changes while the nfs server
> is running should be sufficient. If someone wants to shut down the
> threads and then change the key on the next startup, then I don't see
> why that shouldn't be allowed.

Sounds good.  Chuck are you alright with this?

> We'll want to document _why_ you generally wouldn't want to do that,
> but in the case of a compromised key, it might be necessary.

Ben

