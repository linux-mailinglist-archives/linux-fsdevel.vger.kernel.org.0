Return-Path: <linux-fsdevel+bounces-76627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLhlNtM4hmmcLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:54:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 028431024B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686AF306D4A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194D4279FD;
	Fri,  6 Feb 2026 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="HKRa7LAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022090.outbound.protection.outlook.com [40.107.200.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F83101DC;
	Fri,  6 Feb 2026 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403911; cv=fail; b=Iy1VGxUE2V65lwb3SAcnWW7PlOfKUmmHjMID9CbRE1Izrf7M3SZg1tdd+8sUS6hbkgf83KiR/v239afxRPHtn+0flcHuHyBAd4GwUXA3ZZSmRNEhJzyIihaeFl69WfQX0Y8NNYRv5o7g/areGqGM1pZ3DDyCX86sl0cqm5Idg3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403911; c=relaxed/simple;
	bh=+h6HfQE8W8H6wCE/qiQ61uwUMj0sAVZFeh3iO+O+rUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzSc+XE1RzYN6TEYJdmuvXucDyG3i77x5RbIuMjnwNkruDQbP8DmPshI3bhyae9ScQuBqvIOfmzzQFPtqbywv7nDW1RSQUIL3klYKN7eNs+9i7jynMxtLlKL/73NCOCvgJa+9JpHeeqUnWwZ7kga1CRbLvK6T30J6CpoP4YIwBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HKRa7LAb; arc=fail smtp.client-ip=40.107.200.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH0KVXJkjpU9QuhyBA28JhoZ9NsPes81i2r/Guih6m257Ii8Uzq2tXDJ88/PRag/GwD5vFTCc7nJm7TDnHEAS5P6LPXlRXy9fOZL+yhKHiJ6QZsfNMKP61Dx2wnlCn52/gx7eXF8R4fdwIR5DuZ5BrYC+5/eC4S2NLvrFIYyODqBGJz+k7HdfhR0wf1ZfAzhxkXvvdkBBMGqrY5MwKyT4ZeGuXeREgJlVPRhPA6xjrfPXnFk0hBLjZHYJBGt6psfb0tOp7TaaIYKaauHI8qtdHCyXCj68Ls3XvRaU+3uoIe6xn7bh10M6PCWkXUXo7fXMDQAaQjsL/I9CG2Lrb62BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayQAoyAXHiav0dq8dQls7PM4YAs50b5YnSoP6gR/Hac=;
 b=f/zFSKazzpkA1cv+SNj9S9YgKVVylHF4OB7iSnw4DcwJtkflVTzVIQMQAaGhyYPXA7ieCX/ljPMIFP5YrusqN4JuwSnJBB9HigckcTeHf48WEdy/vWOWdaLQ2DYGu5STXiTlhafSK2kIedwU4l//PrZEZsX1eR+JlSEWwv9dETB1vkbCETTYUcNlwj5VSaV/51ZGPkqHafVT1f2hPdRdjDCAdQzMQeVCv2OU7j2MiMFCJ35RsBCihjEWpJ6Bt+duemGjZRy98TT4TjpdVnK91I6a/E1wIRdBOmB5Pdiq3Fa6C/t7n1uE2qW+/oOEGzZMNxfLUj2xsTtziQAui3eBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayQAoyAXHiav0dq8dQls7PM4YAs50b5YnSoP6gR/Hac=;
 b=HKRa7LAbzIcRfa+ijG2Hg1iSWfdZrSN1DjJ/eWCqQSnXwbs+UqBgukKizvA8nTI8qaPy2SfzV99tFzMkHM/ajGZKRkgKOBrkgmZACJpubJWo/mogbN6S8c3gASWqFQxjyXSRMO3BOlJR9f6tZ4ZLYA6iVjAEDGLxG9Hi1jBufMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 IA3PR13MB7566.namprd13.prod.outlook.com (2603:10b6:208:541::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Fri, 6 Feb 2026 18:51:48 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 18:51:48 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, <linux-nfs@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] NFSD: Add a key for signing filehandles
Date: Fri, 06 Feb 2026 13:51:44 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <6758BBFF-6A47-4C8F-9F15-B42366E1E110@hammerspace.com>
In-Reply-To: <35697253-D872-40B1-85F3-3FD707F0E8C6@hammerspace.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
 <09698b80d78c7c0a8709967f0f3cf103b3ddad9d.1770390036.git.bcodding@hammerspace.com>
 <88c1ea24-2223-4a80-afb0-89c7272dd440@app.fastmail.com>
 <35697253-D872-40B1-85F3-3FD707F0E8C6@hammerspace.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|IA3PR13MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab467f5-f1ff-488f-cc9d-08de65b0c87e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s92gW0G7FYWBqcXGt9yl50Awxi/YqjlZkgq4Jy3dgdDY14iWAjW68XjQ8fFh?=
 =?us-ascii?Q?hfv9hpF/dJUN0A5zGz6MR8kNY7XfCkQ8dwvpVWz+MfyUnp/JA0i70smaegkH?=
 =?us-ascii?Q?Y1c9gStvJE0Kdp5XhD0Y7the1IfjfLCktPN7YXxH6Rgv6HiUOweKa8RgLvuS?=
 =?us-ascii?Q?eQNgwOJv8/7fBAZnzyLT/e/1odPof+VhdpXdBp/wYTwvTkpRfU1MQexlF0rd?=
 =?us-ascii?Q?EaJfCvPRcA3H4z9ogh5qYpJStwC22QKVX32PlDVXySNC9U2SyPWR0arc3wTa?=
 =?us-ascii?Q?ns4zvkmntzO35X96xN56WPFCEjIXl1VGlshBkzzBwx4CM76xbf1pOU3wLT9y?=
 =?us-ascii?Q?ry+ShFcNLGcIY946oKMPbSenzRn4TfeT8E4Hvo8nNAI9ZQBIEoQtjbnA+pHw?=
 =?us-ascii?Q?Qdm4bPXh7BQ7ZAPcv382u75wWycQKab1/EkZWA7B4c6m31ZqUNXCDsuOve8d?=
 =?us-ascii?Q?b4gdCpobu8GCqXaSHyGNembnv36cB4CcJBSBjdG7OJFhBnAPlAdhsGtGhZHD?=
 =?us-ascii?Q?Lgdm+GsWsW43vM3VqAlOpZveR7DdX1WsAjd/KCaEn54pf84gbjxy/v9smAzm?=
 =?us-ascii?Q?z9hSivV0Jd9ww0u91u0/VTKiQhitjpzjEs58kaRJc5qLD6DlLh6Y/XGzE1Gw?=
 =?us-ascii?Q?9cuyAMKH+rIDaisKif9kaOITZP/DOQxK3J9Sg3KrSeHcwZf7nL9dw+d/Ej78?=
 =?us-ascii?Q?2d7sb5mFJoVfzWacIifkbeNDteii1GQ/PF7/XN8cUto00SBB8x1oQJNzk23C?=
 =?us-ascii?Q?aP3JAhuUy8YZuXIujvg4cg600B5My24MnpIrgK+7jHZ0ThiI3cG737zRQ4pB?=
 =?us-ascii?Q?Vp3KtQAMGjnLbmBz7G7dIzomOoTRz7OhniY2qNp0cMGvH8sg8fq7w56bfvfs?=
 =?us-ascii?Q?8GF6v8lwyISUABgJAPqB2WTkG18GG8zSuRFmyeupyE0djzjh/9To85jwnxzU?=
 =?us-ascii?Q?9V/wunsaKaC8QpXHevdqdYDr9AgHv4UViu5iAkYDCVpudaxNkJMogur+jOhH?=
 =?us-ascii?Q?IrIoQMLQ4mIFKgl+r92VOn2zZTgMMSNxerXH5CeZAiurGjBHVL9MtgAu+68g?=
 =?us-ascii?Q?SdmsLrKX61nC3cfxKt0336xtcKjgQ1Gm3IpFeG8zkuVkMchwiQXxQ+rg0XCq?=
 =?us-ascii?Q?1Jc9w5ig0J2W1XFXm6qfBH3InvVoLJlZVAFeXUYwDbNaQL/XI2lHyzfzXUqb?=
 =?us-ascii?Q?4fu+wxSv6dhj6Mf1xwnPxajLHkxPAaahS1/tJGHSvZBoNyU25Lq8a7zVZi0n?=
 =?us-ascii?Q?ssEC7Es71SD1iL3ga+dWl8CqG6RDlZZcF/NAd8k4L32ToLP/hV9QO5OdBoNW?=
 =?us-ascii?Q?T8RX0WFsS+cFU6PoN//SijwUWvuT/dHxda3gB8ks0PKqpnydch3q3e+vy3tQ?=
 =?us-ascii?Q?XqbEl9yllfFJHYBOQsdR/KkEFrb3jryY8Kr1L4m/ikai4FXIET5t7cUDKW9T?=
 =?us-ascii?Q?aWRfsS3D4I3XDaECgNH2vQPW1vIMgqrBXPJay++b2JKzbGVT2bbUpP2dPOYm?=
 =?us-ascii?Q?iKFgy6UztzQ+aiOyFMDUyG9UkSIs/56kLB9/XPPOUJHiPCKRJNrBk2X1cYmQ?=
 =?us-ascii?Q?1Fpp7D048pobrMO3mIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hhbRFBir2eqNomPIqdejtf0EDzS3ipRV3dT9bxRdcwmTAogUNgTmFyHFF9AZ?=
 =?us-ascii?Q?4Vhv8zoST4/2J2W4BnT6z1K7we10gO72O3ci9EQzW7u1IdT9RlXLFwSiWIqM?=
 =?us-ascii?Q?rzi9d9sGsEvN3xrSgAEt1jB0JZTRcNBylqgDxmovNawOG0uhzL8lwdnkciNz?=
 =?us-ascii?Q?t9MpRaDi7XGpCFd2OLIp63BImkuKbpW+9A1FbJg/HgbghnM7bwZg5h/EiTYA?=
 =?us-ascii?Q?WegnwJkFrODqSyy5dKACRj23aVkdC9TgUQyDbQ/mAaNpmpLv1D/XZlqky001?=
 =?us-ascii?Q?z4qqh02mpLJUZhTC6KGtqzh2iODV/UjM312qc0DoTwKPl/U5ijArb222nrwK?=
 =?us-ascii?Q?oUfkVhNu9opHSxL/vbohiRAh5Y/+kzkV9H8dV0DvCuzWHCLbj+ZZsLq1XKw/?=
 =?us-ascii?Q?vlBd1udDTHoxEOqQT9Iil4tFRWkC7HmGjX6ekV+Siew+S+BZckRK1s+WPLU8?=
 =?us-ascii?Q?AtnyhrFre2y+2hG3mRcpNLQOpJ2FifuB7+n33q2AuoL1Ks/8HVnkp4ofvBai?=
 =?us-ascii?Q?d4p8ijkpTtBK2qlzWnDgpbccDNrfTVqQI1uRmB8VY2eLWEwh16swisXLsq12?=
 =?us-ascii?Q?LLNT93zEDlGdpcWsnbVkhb6TLcc6+jE8iVd9rb1N17bYeWUOhdYzAGaOrTTH?=
 =?us-ascii?Q?O8y2M14l+tMKmG0ZVdMo94XC9oqG4c45eTsQ8dReYB8OV8EORK/pWIGZxLDD?=
 =?us-ascii?Q?gOTFFojnNpGyv7Or/mwhYDv14ZHSwKx+ZdOCJ0BH3X0GkuNPWBorWHlMDN4o?=
 =?us-ascii?Q?BIWl+YKoGGI3nY22MtcG8T0Ovsyw/UzTm7OLV0mSWTEMIareioIW+aAcbs1Y?=
 =?us-ascii?Q?YZCNGB0v3y6FLZdUYCNMX+9s6pzRHVXgBntiSVZrzrEqcxRT2dpxkVUHSWWD?=
 =?us-ascii?Q?+CtgNK2kuqAEEUO7mWBX8aOJPGnLFxY73PxK7hoJkF7yKTnFjHyhrS6SFjfF?=
 =?us-ascii?Q?x7XAkVol8kpJmI5DK5HohXHSH58F4GoflXrBFB364OhVUyx0i6LrgggEsf4+?=
 =?us-ascii?Q?IIMlb/hHNwduGuYj5+ZRlXJnQWdsvRNn70kKgVlkxiOxuD+ifuz2azIhGIYM?=
 =?us-ascii?Q?h4idRdc4PnSxK6MXhq5AyT8nBm5SpEDRugEw+y/zLofgK4dxHSqKYv0jqWzp?=
 =?us-ascii?Q?LyVFPPCS8H90TXDsGww0CNRHe7YGYoHk2UY9oQzQxCiqyhzCmwIpWZ536uqo?=
 =?us-ascii?Q?VGZkE/n/ftXzQCGDAlKHFV+sj8j/WIM1DcnUKmGQRWd8TpuHlcHhLr4lmBMk?=
 =?us-ascii?Q?/ngZhHl5JgDU0BWoIWkZHOogsKMFHxwgsURLoTd2kcPNx3M6qr9HTjJgeHfN?=
 =?us-ascii?Q?+/ZZeceZYfsJfUNZ3B5Zi9SDO3Ipd1athqeVGRLfORIrqqElHN35G5HlshZC?=
 =?us-ascii?Q?lWZUEO5OEs3ZRlZWkqBrU5tZB+h2DohHUV3OSQEZOvq6TlliusUVwINc9ray?=
 =?us-ascii?Q?Flic0WBF24h3wrG4cD66+y9ddpjMA4tsTHfJwBpTs45+rbHWP45hqLskU9GI?=
 =?us-ascii?Q?/bGPXOCu6awyeDQvBU3RurVu0vsuiFv3LBzdQVhN/tGEIPjiUvNL/HVLn+JI?=
 =?us-ascii?Q?gN4egPEXOM4eLunaEAzy1T2VtIIkPmFEAy5Bn/taJrEibVeygkb1kIgEo8w0?=
 =?us-ascii?Q?UtdxyHIuKoj7IGwmhbu0FN2HkHVo8r+L2jFMt9VP3Ei9ENMlBF52yePaZbUQ?=
 =?us-ascii?Q?W2jRnAtII4pFwmoSaIWfo4rykdEv8Y9dQ9yk9m30SikGXgXsUMsjbzYEMn0S?=
 =?us-ascii?Q?rLZUub3+Afn/S1qKnSYggzW6WIFVjMc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab467f5-f1ff-488f-cc9d-08de65b0c87e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 18:51:48.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OR1uZHaCDO/YbCCDpf0msSUfdPoKCDtddHpP8rrAcHMeGiqHHYlV7e5YsI9C4Xnkeq5BtyV+lfxEfDfc9KDhtYzLEd+AdtgN47+KuIUCMRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB7566
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
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76627-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 028431024B4
X-Rspamd-Action: no action

On 6 Feb 2026, at 12:52, Benjamin Coddington wrote:

> On 6 Feb 2026, at 12:38, Chuck Lever wrote:
>
>> On Fri, Feb 6, 2026, at 10:09 AM, Benjamin Coddington wrote:
>>> A future patch will enable NFSD to sign filehandles by appending a Me=
ssage
>>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit=
 key
>>> that can persist across reboots.  A persisted key allows the server t=
o
>>> accept filehandles after a restart.  Enable NFSD to be configured wit=
h this
>>> key the netlink interface.
>>>
>>> Link:
>>> https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hamme=
rspace.com
>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>> ---
>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index a58eb1adac0f..55af3e403750 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_bu=
ff *skb,
>>>  	return ret;
>>>  }
>>>
>>> +/**
>>> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
>>> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
>>> + * @nn: nfsd_net
>>> + *
>>> + * Callers should hold nfsd_mutex, returns 0 on success or negative
>>> errno.
>>> + */
>>> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct
>>> nfsd_net *nn)
>>> +{
>>> +	siphash_key_t *fh_key =3D nn->fh_key;
>>> +
>>> +	if (nla_len(attr) !=3D sizeof(siphash_key_t))
>>> +		return -EINVAL;
>>> +
>>> +	if (!fh_key) {
>>> +		fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
>>> +		if (!fh_key)
>>> +			return -ENOMEM;
>>> +		nn->fh_key =3D fh_key;
>>> +	}
>>> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
>>> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
>>
>> put_unaligned_le64() takes a value as its first argument and a
>> destination pointer as its second.  These two lines write the
>> contents of fh_key->key[0] into the nlattr buffer rather than
>> reading userspace data into the key.
>>
>> On the first call, fh_key was just kmalloc'd and contains
>> uninitialized heap data, so the key is never populated from
>> userspace input.
>>
>> Additionally, both lines reference key[0] -- the second should
>> reference key[1] and write to an offset of nla_data(attr).
>>
>> The correct form, following the pattern in
>> fscrypt_derive_siphash_key(), would be something like:
>>
>>     fh_key->key[0] =3D get_unaligned_le64(nla_data(attr));
>>     fh_key->key[1] =3D get_unaligned_le64(nla_data(attr) + 8);
>
> Yes- thanks Chuck, I really messed this one up.. somehow sending out th=
e
> wrong version.

I think nla_data() returns void* - and we want to ensure that void* + 8
moves 8 bytes.  Isn't this a GCC extension that assumes void* + 1 moves o=
ne byte?

ISTR other conversations about this with you, is it maybe safer to do
something like this?

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 55af3e403750..f05e2829d032 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1581,6 +1581,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
 static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net=
 *nn)
 {
        siphash_key_t *fh_key =3D nn->fh_key;
+       u8 *data;

        if (nla_len(attr) !=3D sizeof(siphash_key_t))
                return -EINVAL;
@@ -1591,8 +1592,10 @@ static int nfsd_nl_fh_key_set(const struct nlattr =
*attr, struct nfsd_net *nn)
                        return -ENOMEM;
                nn->fh_key =3D fh_key;
        }
-       put_unaligned_le64(fh_key->key[0], nla_data(attr));
-       put_unaligned_le64(fh_key->key[0], nla_data(attr));
+
+       data =3D nla_data(attr);
+       fh_key->key[0] =3D get_unaligned_le64(data);
+       fh_key->key[1] =3D get_unaligned_le64(data + 8);
        return 0;
 }

Ben

