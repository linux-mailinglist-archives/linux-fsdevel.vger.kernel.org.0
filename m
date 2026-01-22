Return-Path: <linux-fsdevel+bounces-74959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEn4Jo54cWkJHwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:08:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 678E8602FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FCA23C6AF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCF9331218;
	Thu, 22 Jan 2026 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZObQNd8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023140.outbound.protection.outlook.com [40.107.201.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F71643B;
	Thu, 22 Jan 2026 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044097; cv=fail; b=TFpjm/dpJBMn9VkrJMVSzh5lVIi/pWP8xlLmV9cwcx9EiTlqZRJWMBOxdK6I5S71TK+raP0xITZm4vOom8X9KcsYsVaufsbsrerMPhGnkqP0xBKgQPl5tamKYkeiMORTtMH4Isl1EknjtJo0HOY+fRplLVqEO6j6Rp3XsPBO2Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044097; c=relaxed/simple;
	bh=jD1eS5NGjlVT5dXmm4dWQtiYlx7QKZEHV2CYpjpx1e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xzz8P2iu+ihfBsonecRzL6itFtK7nVJtfmCtgVVxp9SGDxWRmOnAVE2oqN+a4mthTarIuTnKnhRI20IkMTC8VRyxBSdmwd7oMg9n2HdrujaK6C9EHEDT5lzhBItxbP2iEXbfo5F5HeXAUOuOjTyeLLFraJgrmOlXU6q4Ib4BbhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZObQNd8U; arc=fail smtp.client-ip=40.107.201.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFuE6jGuYqeRxLK7HgPdK8gXZY56x0eMBGIZeQrnKeFGYmIFqVWGfXPHw/4ccEoj4A7UQbCVt/rXIJbtufGVtIllEcSstWeKF+qWfT/dZdKvIaSkYP0QpI8XX8F2cSJK7gkg5ylT3kOCHQYAHn7ezkZhhG8Jq/J30MVa8gl0a+ltAtSbtERrRThsWddxunCw6sCoYMT1Gc99vrJWU/IDd9BSwo32LVHIOd5ov63V7E5zYfNgYuAcB8NNUVJ+PxOP9yYedN0i+2X/P31K9bzNCMJd+ZBdxvvYvlch5RZjMNTF0iH2s6lccZErzYcsXXvTvP/b6YqGP++7oqASmWboXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzs7Vk2rzwQvlUk7LYqBKEEK0hAgNET3HSWsyErsaZA=;
 b=bJt6xK2rNZB0o3AhTMety9mTHsPGSd6sbk0OUesjWxLp/LqE2bMvDP8/wJ4kBrpFJpSB1fyF3ty+OuJjku4lsqgc59NQ+7sTETcWqLIk4ogkCiypNWYYDBQ+6OJmRDUJGCjJ450xNfK+2+zsYMWmu2S524TRCuHQCDxlcqGZXiImuZJhS0nwxCTv96DCPGbmqKqkIBw3aGkPquqQcsEpPT7INag5i2jZtmjA4PWp/rxu053xbpO1CBtyCkIRvyKp/dgOAs+dBOnA50eGFDnHiuLaOYH5Tj7mD6CZlutsCdZw7gYbEQiXY7z1cEnJSRaZL/EDLzXpng+QacEQ7yrwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzs7Vk2rzwQvlUk7LYqBKEEK0hAgNET3HSWsyErsaZA=;
 b=ZObQNd8U/xBbB+iWnaMBg9DpWoe9TnMCiq6cJkpys19HL88LZCsBlTmocuf9vYoqlIkRGJhSy39Vy/pPmAXRP52AppYnmA1ZyZdKSev5JPbpC6PlVuDp3YE9i3HitlzHyCyvXrUNx21acnwCim2vtsK8AkKnhBC7KTTUeNa3kuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM4PR13MB5884.namprd13.prod.outlook.com (2603:10b6:8:4f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Thu, 22 Jan 2026 01:08:11 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 01:08:09 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Date: Wed, 21 Jan 2026 20:08:05 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <9A2DB68D-4336-4564-A3C1-71D507C0C5F7@hammerspace.com>
In-Reply-To: <20260122005112.GA946159@google.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <20260122005112.GA946159@google.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::29) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM4PR13MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8842e7b8-22ca-403d-7169-08de5952b504
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4k34R1SZ53GOv2+M0hhmIj0QpBafpI2AfqJAH/Xj1kI8PttpmSCT0J3jowms?=
 =?us-ascii?Q?/02j9VtS4+ET0uHHvof0vYIa5dXOZZu3XrcRWasrHCLso8jdlmpyom4S+/08?=
 =?us-ascii?Q?Qbe41WUvJioAv4lD0jRSd8yGD6u0BSpnot/W9qTr5OLzf13I0+fR74JahGA0?=
 =?us-ascii?Q?w3lSDeVt09MDhAFOaw0K1JjSUVAp4g4VY+sAcRWrHmidN6qMxXechL5OokRO?=
 =?us-ascii?Q?jG2lwQMguoZSAlhuDGwV53tIujxNKI/cpOr5jbaxXKec5i/yE5nIKi0OSexR?=
 =?us-ascii?Q?ng6dYZRBiQPBgscCm4gNvRUS4OpTbh8MXJtF7fbR8BaDSdReaK97WMoJWPn9?=
 =?us-ascii?Q?M5ixzvb2RjjZUwRo1UKjvLRtKkQ6b0dNxd7Z9DSnj/Lc/OR4sJl//Jp62J9M?=
 =?us-ascii?Q?4uylfnm6MayRGd7Y7ANNlOzUQpm0SZ7kQNZIR7ToV2GAUC8KmKbZpWsboEpr?=
 =?us-ascii?Q?3h7wW5vVExrhCCBNcTwSFScSfe+GaaqW8Lma82fRr8RnZSK0/wbkgbhaHljC?=
 =?us-ascii?Q?2HAPZybYcpl3zHzoCS6+ftiRmZNiTaAUZrHzTx2NoTKcVlOwmMieFA8eZziu?=
 =?us-ascii?Q?38PYcHrOH0HuWFGw63XtH3Qhi8maKXqQNDFt+jIQA9BiYZEZBjIKSMJZmeiD?=
 =?us-ascii?Q?w0spdMA2OJFIYUgMYoruPzc+2UihjoXyszlA4V2+OTyH+fnrD8IGR4tscoiK?=
 =?us-ascii?Q?oJ8mWnEKmvuvAUYEsksmMXp0NNLEBkImEmH7p2+hF9+epx5MwUT7QylwfZXk?=
 =?us-ascii?Q?EC0neuYIFycUiQ0V25YQFKYgkp3snOlPRZKVMWexaWzYJljwFWwFzhV0PKSP?=
 =?us-ascii?Q?7X3NXkXWGvR7Z0/cAUduBWdBWF5Yd5V2xEbDAXkB1S3aw9ZKnsnpkejJ7IG6?=
 =?us-ascii?Q?RuQELq4/cD6jw8ZXFlvqj7Qyk96QggUjNKL5xWZVqChA9I3qCUw0nFeCcWMB?=
 =?us-ascii?Q?M7i4+VA8jnbvtCrW2SLCeoER/ZF5d3efkmVtG0+gOyGrTGKy+cI1YWpw+YvG?=
 =?us-ascii?Q?ED2vinUR/ure0WmwSKlyuMC1IlezCpQa1s4+Ghwk3EHQ53brjSanD3eodfAA?=
 =?us-ascii?Q?1joYVbaTD01bYmyEeixLLLUqJJoFa3U1sDOw74tCa6lpr4Rm8g+7ithKKmkh?=
 =?us-ascii?Q?ygdBzLQz2vVIHi93d39/JHhZLa960nfo5y7A/bHXn+N2PU75/aFBjejgdiL5?=
 =?us-ascii?Q?ZgvYRpZW2tP1c/s+SwMjkvOwKQ2m3/nCPScr5BZvnOh3iIdFDFkw1msWcm7Y?=
 =?us-ascii?Q?wB/NrB988AIGVaC9W9y/alNcrfHeH/d7blF2Lxo/SsdSioIqd0GCrcXhIHsg?=
 =?us-ascii?Q?tftpArPthaQ40pkfrOuS4ysjwplw5nkGhSG2bMLSCw8eK8Z32usO+/zyMg/t?=
 =?us-ascii?Q?XDmREntXlu74Sm8PfX/eivy/+bMjJsr6p0t0tTH5/VHU+Z24myz3DYPhwUem?=
 =?us-ascii?Q?JcXLp6+eUzZ4yanHRbWOflzT0srU1T2+j0IfbId7eQtNwPMQiVigwbzmtwmn?=
 =?us-ascii?Q?At9HQr9o+uICcDZ4Y/Ad6oCWdjm/xqq3geDumQ1Ntm6Ds1omWQzybGeHYadm?=
 =?us-ascii?Q?NlhkQ2su9HAlA2YuQ5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kkj8K0k+XvoLLW6XQRi1ECEjBpmzE0rLL+jSJlHgUhCH7Iy+SzPuz4BVs7b0?=
 =?us-ascii?Q?fqCqOxl4joC/Ww4sRRTjMYSJddt87s75zkguWUaQHcv9rPvh3T/TMv8kMCkf?=
 =?us-ascii?Q?3J0yPI0s/IHp5a7lzyZBxR8sjuSiPj7esBwKSiYv8hs+1uc7I6oiUE3ctWlZ?=
 =?us-ascii?Q?uWK3SzzODJMBuhj+3TWbD05Qdyxeg2td3/SzRf9X9TlZbuH+m4WneqCXExXA?=
 =?us-ascii?Q?2N2dq4x2HNDW6ladF5AMWm2ry6aKoCuWF0v7Ux2FWFTiNnqY7zE7JFi55k7I?=
 =?us-ascii?Q?qHVGMdtadsXpVa5wULyoJr27g7WZcJ0CBWbDj5tjSNAEMaKf2l9Fw7tf+HQF?=
 =?us-ascii?Q?HHi65YsKRPYYj1T3f6lApFado+je4t+ojASDYjW/wE3LUxHvpMjuHcPiCpsD?=
 =?us-ascii?Q?fOZ7c9BxFvBmHpL8/L751BNft+a6nhnl2jj6tEIadrVu2vWG5XxrqA+VwIpI?=
 =?us-ascii?Q?m4Ndyz68bFPcUaiCNII033YzlwTNiXzik6A+27/Xda9yObs52SaTwmkivOb2?=
 =?us-ascii?Q?vy5WRjCJ3jBcvQRX0nCOvuFM8QDkenPO9rzA2TKaLyp8BiCwLaA2qA6bKA6M?=
 =?us-ascii?Q?tKSO9DIO58K7RnnbC8nyuf412oXw3KxzWnD9g3IHiuEeY0dzj0Qxj9T7sgAj?=
 =?us-ascii?Q?T0J2rh5hNVS23iG1U116ipiHlwn/iGPbldTtbmM3tbC/u8AMxo3WGL+rkmjz?=
 =?us-ascii?Q?lP53f/9gkIv15e4Lij6HYs7YwTQXmMryrjwdW9LOsMvzUkh+z7QeJBlyzsnX?=
 =?us-ascii?Q?zZA7uEfW1o+XbsRk4GUagl51gmgr7Ig8z3arXXtUmDcH6Ck9TBaCIZJ4aWid?=
 =?us-ascii?Q?oWcrDxdadONRtDIQRpcM+yFD1FjwMac9C3xOZLwXxkSKspp0coUPpchOP44i?=
 =?us-ascii?Q?0ZmHaqJS+CA4XqGWEIWG8cQJtGyv9vdu12ufqn2OzWM+ovqqIrrPeBl96k+R?=
 =?us-ascii?Q?IDv1oaDRa0xt7/eiQ8cNwzDJ1z4Iurr20OGrNy6inVj2MzgKY9deh/yyZDm6?=
 =?us-ascii?Q?GInCG+9nu9wYpINmaRqJIVhCuU8swfNrv7IwO90W4MVJS36E6SecwsHyJ2Hf?=
 =?us-ascii?Q?r9uvPpa4R9RWDRUbZ7VpuhVIOKFuVcC1uW+6IBp8EGAw6mGri4fbuquMqwiR?=
 =?us-ascii?Q?sVizSykLgFtGCw49EvdMoVOC5EKEmR3Ei/fT7UfmHp9XDJhd47eyLkSn8O20?=
 =?us-ascii?Q?4jBvRXoQSoC9qN/tdibdWyu8UG7A1dmo0n1ertdJEl++BNM/3jndjPBgaGIV?=
 =?us-ascii?Q?fAJtbjqKHyAcuAdqKuI1Xh2I09YGGPbaa6OhrAmbWXy214PnI1xfPfOOjayL?=
 =?us-ascii?Q?3hRW5FTLdWXxRZ6A3IaqilYUiqb82yD+k0UJrgyRLWqyyoPaXuz8rAtp/NJq?=
 =?us-ascii?Q?e1/cuel2NR7pxzH2AV0RcsW+5n6UU/Ex/CpnE/e+da93wG+7PnpIC1VQQdCg?=
 =?us-ascii?Q?YxNDKdAUsRauMaq6hA4oHzCA1zUGGhn+3O9aIxGFYvkHD0MAhPwnLw2cxAUi?=
 =?us-ascii?Q?W9OrshaSg0ujRSMiX8upWCmn56eiLXwuyxwXsYEBhfdsDeNVCTXVUZD3W/tk?=
 =?us-ascii?Q?StXVRpnek9AduxToBe4B6wnvZt2AQQpgCodmWdNhYJw7mxRLNW7dJyyLgdLT?=
 =?us-ascii?Q?prEWxXSgXQ+5BZisSeXboEGGy39A7XpQBeE5xnQwgwDwICv1+qICDTuBM2nv?=
 =?us-ascii?Q?1ylDD3jVD4ytyb5F3IMz+W6hyuM3Kcou4laB6l14LSJcSj1biGmDUUk/+u+z?=
 =?us-ascii?Q?LGDIAtRWMhKX/eO0VfmL9U6cCEOHAYA=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8842e7b8-22ca-403d-7169-08de5952b504
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 01:08:09.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zB2LeBGF0W0sZoLwHJ7qVJCyypjZrAvzra+PuDmrY74rQvORRL6mTG9IfC185gObkLRKcvWk7phNuaff3SpVQspH3BemqJLmmQMZ9XtIW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR13MB5884
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
	TAGGED_FROM(0.00)[bounces-74959-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 678E8602FA
X-Rspamd-Action: no action

On 21 Jan 2026, at 19:51, Eric Biggers wrote:

> On Wed, Jan 21, 2026 at 03:24:16PM -0500, Benjamin Coddington wrote:
>> +		sip_fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
>> +		if (!sip_fh_key) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		memcpy(sip_fh_key, &uuid_fh_key, sizeof(siphash_key_t));
>
> Note that siphash_key_t consists of a pair of native-endian u64's:
>
>     typedef struct {
>             u64 key[2];
>     } siphash_key_t;
>
> If you copy a byte array into it, the result will differ on little
> endian vs. big endian CPUs.
>
> You may want to do le64_to_cpus() on each u64, like what
> fscrypt_derive_siphash_key() does.

Great catch - thanks Eric.

Ben

