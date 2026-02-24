Return-Path: <linux-fsdevel+bounces-78304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gh2EvL+nWkETAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:41:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00718C294
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55E1030CD583
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2139630F927;
	Tue, 24 Feb 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XxBHSlmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022104.outbound.protection.outlook.com [40.107.209.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E525F988;
	Tue, 24 Feb 2026 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962083; cv=fail; b=GQXR9McF1+w8zJvydm489iQ6qj0a1NkVs16rm68+EvHbO2LK4Y3VuvwaGpRHyhAPE8sBFnqfTTEHm3lw2jS/hCfAS8M/gtYrCKZ/hJ56zVhOFBP0Tn4ZYGPlzF3FNs+hY4Ya8cI7xUVapYqWlu1h+oC1kltag3v/yAbHrVoFcbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962083; c=relaxed/simple;
	bh=xLzy41oWAp46XPlw/4iOr6dLUmJ+MjW7xBXXOjhYyXg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FeWGJRxo9XELZzvzVqNvEMdu4215vT/W7OERk5uQLPYgvR2eDeBNFcY5LF2RbP/Afr40oKyXsIPVKQfaZ5b3RTGuL/9EC2jKcFyfk+QhzyekyhmUapRM2OmGG/HDF0Uh4eGr0I/kWAqJoI89GXxzS3OGTo+p8bX6+4a4R3OxRpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XxBHSlmL; arc=fail smtp.client-ip=40.107.209.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1bcCVXg0y4AQrL3goUo4T5z9dSu6hltmax3oIl4IKKp1/HQUtz79SksL/jv9MDJJS2UfmkK4azuDib0Dqg2K2id1Jis1kbAnoVV99BeqfaYEqucTibR8GpxWrRof8sKKIA0ijhLqw3tlDhLVFCVBfvg/E9Sem7H3OFw1OrqB5H52L7q/WL4jVYIG0Hr/Lo3tg2H/wMQ/akMx0sUXwP9DL9uaMbM45+p3FbIT6wkEuEXxZ6ocwkDT9x0V8ixGvBGgwK8GEpoZEcyJc9CswDgjH11T7vyNkXeSmUt5ctpXza7p26ygvNX1QWH+SU9uqD2eAyWpsQAS/VGGc0cK3Gn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UlEV/EPn/W4I5rHpCRST5K9nSdLYZDH0kWXP7uX+ss=;
 b=dF8bysaHu8f98ellc9OpCFHaEG/Hkq8vwljr0tReulrMu58AJClJyq+QujgmhFHp0cedAR3R/2L2xhvGp+Udd4IyLKjSAOBK7Oe60ujARX6whZuXrDNzFF+JhY8wVvDoUEbimY3R9rE4FvNOZOgjjYj4lRuQOOVY5HwCOMlBaEist7vGjgdjNlahIzlO2diFffU0LIpPsaWugf+VpPmH4T3dXgf7n0jy9WkfIKjBDu8Bsr1XPqslLEo9mzOIm+pLhCWRnrU4zfnUyT5qf+jmKPPKUyRjtWbgKKVd8k8pEiv2RGhJULpH3XLG/S/wCAN1EjsiMBL3CP8duGIvpEaYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UlEV/EPn/W4I5rHpCRST5K9nSdLYZDH0kWXP7uX+ss=;
 b=XxBHSlmLLda09P8rDae5wT6FReA67DfnCOn1CwaekTEHBYtJucXtWBRqj8KYXxFxBN32leOtN18B2G9ilwgDN/0UjcoU+9NQSrZLK/V4V6m4a/OwR68i5UoLaC7nMK3qLzGGmu7WWQ8Go/WZHhrrygELb3MD3Dh0UbdreOYDhl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB5333.namprd13.prod.outlook.com (2603:10b6:a03:3d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:41:19 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:41:18 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v7 0/3] kNFSD Signed Filehandles
Date: Tue, 24 Feb 2026 14:41:13 -0500
Message-ID: <cover.1771961922.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SJ0PR13MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a0fa57-9a1e-41a7-ca11-08de73dcae4a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/nW4Z3EO8P75RT/Zg9s8XZwy0TNo1EsyzUYzKE7hY2W4CQ7Uw1r23EsDRI/o?=
 =?us-ascii?Q?pPNc17cFtzztJuJXwTE6deAvJq0l6gOvXGJV9bdk4P8Lw+jklTKbyAP6kyMH?=
 =?us-ascii?Q?NEg4oVPE9ghzEwwWVEy528N/NGmMmcoJpCvw3jjqG/pCWhujHiSqDFsz5fyx?=
 =?us-ascii?Q?4Hmk8F3Z4SisEkU8H71C0Y++LPHgWWlvKnk3DrfLQFDq1vzAqVBNAfKPt4uk?=
 =?us-ascii?Q?FWP1sw1ZL09twPxZiGPEfY9DMO9tKdd0mTwykFnEuoutZis1ivOEpgSalTVy?=
 =?us-ascii?Q?KgUQvpnPYYFwiZuNHiC4ijCKV/bYFo8dAcdCg775feM+3UViZNfKjckEsotz?=
 =?us-ascii?Q?bJRQQffflcQRh7qlTColIbPCOw+53RqBhBF965aIj1GF9NFhJCz5PsyYeJ/6?=
 =?us-ascii?Q?9DbyXhY4i/oTsbLd18B7gbYxEUfR1zqDxClRST4UnFGlqgFA1hnbzGuw/X+E?=
 =?us-ascii?Q?NiWJpvongOgqZQNObzcCpjINSvaVdxBdmQ+1sO8JAUt9fEUiofHiltQPpbMe?=
 =?us-ascii?Q?MzAkd/yBnrxZw7WaG5UUN3YglYmT+PItjN5afvxDlhfGj9/z2pyD/S5FjvPV?=
 =?us-ascii?Q?NzNNf2QC1xc91HiCcOEV8zwMTRwRybA89D/N0f+KQT6NdOc0MDrwnTx5Sg1E?=
 =?us-ascii?Q?uY1BkZ02BM/NkbyJtlqoQpA4NlT6iwguljLP/uCtteXQ8G2AUQ8CthMDneQU?=
 =?us-ascii?Q?aPiPJHuTU1leHTV3rDK+WSYtWTWPm/mTJyh+HPdrLNZrHNvVEjVjfNevmPIh?=
 =?us-ascii?Q?m9/X0+tMhJrIOvQfsYMoeLoa3upaMTykXKsHHn1YhPutQvar1IyPsCTyEJ+3?=
 =?us-ascii?Q?mN5FgrZLnZxK1Xf94I/8EZj5bF2geG+1HvQJ2ihxlnw5F4ehgsBQCFxLX/75?=
 =?us-ascii?Q?j0rVXZsB4+fkL4n+nyBX2N+AhkYDmA/IV3ylbLq/xd2AvGGmbN2KMfbKE0kz?=
 =?us-ascii?Q?0yDD742eJGXO3Eqe2H3HugEmHPEquKlWs2gsPgFrtBGOBaC4IOui1z57t1oR?=
 =?us-ascii?Q?vWfram/l5fKEQUxh2Pf79EIbRXGxp9vNNRUjfTWbbNpLmc+w7jXJdvnVAJw7?=
 =?us-ascii?Q?LlJqjeQsRq9gv3wFDvIOaYJNxKMazEEhXmo6y0SFFoBUu6VVZ2ModyVIRCQp?=
 =?us-ascii?Q?uE/+VVXenY5SMpVqD9mDEsxASjK9W+AnwlQTBqrEQSJrjy6Ba1R/0LerR/qb?=
 =?us-ascii?Q?uBYcmDlU6y2QoDBd62f5rebh9AGbcD2CdqzYsdbyx/p5sjCJutlcb8inOoIn?=
 =?us-ascii?Q?Bz28y662E4DrfOzfyKuTrsNIlII+X1kKUXEUnH5U7yr9dlhMW3Wd/MQKfrC5?=
 =?us-ascii?Q?0td8ryaP/VvCR1sXEo7iE38PN7rt2DcThUaytIwKa8xEVXM+dLay5QB/WMcF?=
 =?us-ascii?Q?aqciqBzgK8mVkmyjJsy2D+In32NG2NPmWiqs5GkYF2rB9DFtdHAuPaSKvKrY?=
 =?us-ascii?Q?hiWpKCzVh+9lIA2kii+kENZHrgMNtzxYyGcH8IFwRSlewZc3zS7NTCdt7PVl?=
 =?us-ascii?Q?3gSDs/dD9+OWo7Mj5XdTsWOaZLTN+vNv9wwb/aV90DWTZHSQJ+WddDjIPjp2?=
 =?us-ascii?Q?Ci0ayLNfFdD367q176U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Vgxlu2mBTgPvt+ZeLdYMRvLVdvEB+X7vBAa9THBk4WHxQbF7Dchlp3zseKu?=
 =?us-ascii?Q?PctHZUBHlQMGmXDcsiwd+cQi4q4tMtTCJc06G8Z5+UItXJ3KTjs8ZXu5ctiC?=
 =?us-ascii?Q?EpvZJ7U+0lyPNYPICQHjlcMnTtIOLV2sP13IfFnJYfnGVvCh2BdugBS0W4H1?=
 =?us-ascii?Q?8QagvEp5f8ojTf7lCz9OY+X/s1RSaiJx6s5exUV31Jh3X/L4SV+gr2yjrKlZ?=
 =?us-ascii?Q?T9rOdVc1jaryuJosw3bKXan3H3+O62ZwFqgCWaKJO9BNfmBOUvZETDGSJ8kD?=
 =?us-ascii?Q?7EFlDd8JBuPsZuED3d1OI708ZWyWbCez1xb82of/kazArEMFcROTFiekUZiA?=
 =?us-ascii?Q?grZVcqw8rh4rzrKcfLxX3VQgZZyxkIlSUo95QoPFPTfK3vFdo3ObNmVlIfDH?=
 =?us-ascii?Q?/6s2NdyuKuB0idVBMuVlquDbiNn7LKshG87fEC1e53ctM08TEGpZH0yYLYPY?=
 =?us-ascii?Q?GfXwBkiImMDGBq9w9/evzGJuKFX3IJQCFInHKmHyXpw7xJtRadmFbeAsmGkI?=
 =?us-ascii?Q?qioinFhqccS/FPm7v/lNLCazP5FqU8dcR4VpeOz8EI5f4lhERwo49MYEGNgZ?=
 =?us-ascii?Q?IgNiXRVbbrUo9VztUQomFN2lktQ0Yb2jTCJv5vr68R6tDhB0d0V20D1fvj2+?=
 =?us-ascii?Q?GhrVquxtcxZu9GvOhEL04P79wvW/WxUr6DQHDfMO0ZmBq/TpyvtxghI4yX3E?=
 =?us-ascii?Q?FMidjHwWzxuIZvwylVQm9NB2iyNjnAL3U52aqZaNoyUuPSRSRLPNDRBHuQyJ?=
 =?us-ascii?Q?fQX0ly8ei7eVaGZKDxZZpNX+Li+uOxa4m7l6VQ1azuMuPW1sWbYeULpwMo7C?=
 =?us-ascii?Q?HpydeaZ9e86Hqret4S8x0ieek0hvv/npcJ3T3mT6St3PFNz0NL7AzLEjDMA1?=
 =?us-ascii?Q?340EA3RBNuAjtw1xhf1o7ui/QdMb54Hy9oLsY0sm7a8834SxNgHoDyUHnJlq?=
 =?us-ascii?Q?ITCDt/XaD3sgbPikOsYgj0ca8RdMIT4PKAOk7u6LEFKqIxHYf2oArdSqqFva?=
 =?us-ascii?Q?znSieTnzJARdKV95UFIfrnv9UoF0UDN4X/nq1TDMSymlOKE7Z/1n90RHdg6S?=
 =?us-ascii?Q?RJOwYpZ+G/qY6ROl2fOOcUD3SulQM5ypzH7dji4ESYtFIdPR+X/ZGNM+61ap?=
 =?us-ascii?Q?7WKxN5SrCzEu81R7H3B4BW4FsX5o/gWhGMkjYjw4sItJ3cal3CqdFn35PJuS?=
 =?us-ascii?Q?Vq/4ByFhO+57twmW0cfDy9LDrnCD4+YU/qDGfdtl+PYjmvdtyd4hCc9PljPP?=
 =?us-ascii?Q?abVZGJ4HEcHU6JobvNIu2TA4EZgNVbT7niLIVXF85xJor+QnMkRodSavZJTs?=
 =?us-ascii?Q?2QjGQ5HUZEy2OBLUe3RhxyKQAIwiQM39wd5KN3gBCjOiKXBAdK1lBMP+Bqd7?=
 =?us-ascii?Q?ts5sdR6W22VtL0jW2m/B5fspqk10lczP1TYhcxnpDB0WOb5/3fGvSWTP3Q+U?=
 =?us-ascii?Q?PD50G2sJ//lvz/nQxDg1UubInUL/lSjWW/S7YRuZ4eICsN+/AEdo9zB98gmx?=
 =?us-ascii?Q?+UsX3oCfxzRyCL/oL5rAFI2OVH26mOTIGEgmU7WrcK9+xuUtAoK+ZJYqPi6m?=
 =?us-ascii?Q?xY1ve4JlQhCCkm22yM3d3plH8rRXd3PBtkJzGL2uJCPsRH5191hMXmvFnKHF?=
 =?us-ascii?Q?Y3tEsDPTyVFc1I973a3ArrLRPfG64qfWJlFeEuC9J32Uc7rLc/B13wDFPnPl?=
 =?us-ascii?Q?lzpasoG63U8uC53oHhEmYpORR2jtZ1C7GFt6lTRYLg/iw/2kpMCmIkHnTfWj?=
 =?us-ascii?Q?D0jKAQ4keftM8J3+FUsKjpUSk9FZtFQ=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a0fa57-9a1e-41a7-ca11-08de73dcae4a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:41:18.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgo8yax9UeYz/l/YgKcVz4dBmqTjyyme1WMypllZBtbm1VcYJquY4aYe0Y/juWu05iHht2nkWX/153l2fOjLUUIPoEolHKrne5AYsgBbbv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-78304-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 9A00718C294
X-Rspamd-Action: no action

The following series enables the linux NFS server to add a Message
Authentication Code (MAC) to the filehandles it gives to clients.  This
provides additional protection to the exported filesystem against filehandle
guessing attacks.

Filesystems generate their own filehandles through the export_operation
"encode_fh" and a filehandle provides sufficient access to open a file
without needing to perform a lookup.  A trusted NFS client holding a valid
filehandle can remotely access the corresponding file without reference to
access-path restrictions that might be imposed by the ancestor directories
or the server exports.

In order to acquire a filehandle, you must perform lookup operations on the
parent directory(ies), and the permissions on those directories may prohibit
you from walking into them to find the files within.  This would normally be
considered sufficient protection on a local filesystem to prohibit users
from accessing those files, however when the filesystem is exported via NFS
an exported file can be accessed whenever the NFS server is presented with
the correct filehandle, which can be guessed or acquired by means other than
LOOKUP.

Filehandles are easy to guess because they are well-formed.  The
open_by_handle_at(2) man page contains an example C program
(t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
an example filehandle from a fairly modern XFS:

# ./t_name_to_handle_at /exports/foo 
57
12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c

          ^---------  filehandle  ----------^
          ^------- inode -------^ ^-- gen --^

This filehandle consists of a 64-bit inode number and 32-bit generation
number.  Because the handle is well-formed, its easy to fabricate
filehandles that match other files within the same filesystem.  You can
simply insert inode numbers and iterate on the generation number.
Eventually you'll be able to access the file using open_by_handle_at(2).
For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
protects against guessing attacks by unprivileged users.

Simple testing confirms that the correct generation number can be found
within ~1200 minutes using open_by_handle_at() over NFS on a local system
and it is estimated that adding network delay with genuine NFS calls may
only increase this to around 24 hours.

In contrast to a local user using open_by_handle(2), the NFS server must
permissively allow remote clients to open by filehandle without being able
to check or trust the remote caller's access. Therefore additional
protection against this attack is needed for NFS case.  We propose to sign
filehandles by appending an 8-byte MAC which is the siphash of the
filehandle from a key set from the nfs-utilities.  NFS server can then
ensure that guessing a valid filehandle+MAC is practically impossible
without knowledge of the MAC's key.  The NFS server performs optional
signing by possessing a key set from userspace and having the "sign_fh"
export option.

Because filehandles are long-lived, and there's no method for expiring them,
the server's key should be set once and not changed.  It also should be
persisted across restarts.  The methods to set the key allow only setting it
once, afterward it cannot be changed.  A separate patchset for nfs-utils
contains the userspace changes required to set the server's key.

I had planned on adding additional work to enable the server to check whether the
8-byte MAC will overflow maximum filehandle length for the protocol at
export time.  There could be some filesystems with 40-byte fileid and
24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
8-byte MAC appended.  The server should refuse to export those filesystems
when "sign_fh" is requested.  However, the way the export caches work (the
server may not even be running when a user sets up the export) its
impossible to do this check at export time.  Instead, the server will refuse
to give out filehandles at mount time and emit a pr_warn().

Thanks for any comments and critique.

Changes from encrypt_fh posting:
https://lore.kernel.org/linux-nfs/510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com
	- sign filehandles instead of encrypt them (Eric Biggers)
	- fix the NFSEXP_ macros, specifically NFSEXP_ALLFLAGS (NeilBrown)
	- rebase onto cel/nfsd-next (Chuck Lever)
	- condensed/clarified problem explantion (thanks Chuck Lever)
	- add nfsctl file "fh_key" for rpc.nfsd to also set the key

Changes from v1 posting:
https://lore.kernel.org/linux-nfs/cover.1768573690.git.bcodding@hammerspace.com
	- remove fh_fileid_offset() (Chuck Lever)
	- fix pr_warns, fix memcmp (Chuck Lever)
	- remove incorrect rootfh comment (NeilBrown)
	- make fh_key setting an optional attr to threads verb (Jeff Layton)
	- drop BIT() EXP_ flag conversion
	- cover-letter tune-ups (NeilBrown, Chuck Lever)
	- fix NFSEXP_ALLFLAGS on 2/3
	- cast fh->fh_size + sizeof(hash) result to int (avoid x86_64 WARNING)
	- move MAC signing into __fh_update() (Chuck Lever)

Changes from v2 posting:
https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
	- more cover-letter detail (NeilBrown)
	- Documentation/filesystems/nfs/exporting.rst section (Jeff Layton)
	- fix key copy (Eric Biggers)
	- use NFSD_A_SERVER_MAX (NeilBrown)
	- remove procfs fh_key interface (Chuck Lever)
	- remove FH_AT_MAC (Chuck Lever)
	- allow fh_key change when server is not running (Chuck/Jeff)
	- accept fh_key as netlink attribute instead of command (Jeff Layton)

Changes from v3 posting:
https://lore.kernel.org/linux-nfs/cover.1770046529.git.bcodding@hammerspace.com
	- /actually/ fix up endianness problems (Eric Biggers)
	- comment typo
	- fix Documentation underline warnings
	- fix possible uninitialized fh_key var

Changes from v4 posting:
https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com
	- again (!!) fix endian copy from userspace (Chuck Lever)
	- fixup protocol return error for MAC verification failure (Chuck Lever)
	- fix filehandle size after MAC verification (Chuck Lever)
	- fix two sparse errors (LKP)

Changes from v5 posting:
https://lore.kernel.org/linux-nfs/cover.1770660136.git.bcodding@hammerspace.com
	- fixup 3/3 commit message to match code return _STALE (Chuck Lever)
	- convert fh sign functions to return bool (Chuck Lever)
	- comment for FILEID_ROOT always unsigned (Chuck Lever)
	- tracepoint error value match return -ESTALE (Chuck Lever)
	- fix a fh data_left bug (Chuck Lever)
	- symbolize size of signing value in words (Chuck Lever)
	- 3/3 add simple rational for choice of hash (Chuck Lever)
	- fix an incorrect error return leak introduced on v5
	- remove a duplicate include (Chuck Lever)
	- inform callers of nfsd_nl_fh_key_set of shutdown req (Chuck Lever)
	- hash key in tracepoint output (Chuck Lever)

Changes from v6 posting:
https://lore.kernel.org/linux-nfs/cover.1770873427.git.bcodding@hammerspace.com
	- rebase onto current cel/nfsd-testing, take maintainer changes
	- move Kconfig "select CRYPTO" from NFSD_V4 to NFSD for crypto_memneq()

Benjamin Coddington (3):
  NFSD: Add a key for signing filehandles
  NFSD/export: Add sign_fh export option
  NFSD: Sign filehandles

 Documentation/filesystems/nfs/exporting.rst |  85 +++++++++++++
 Documentation/netlink/specs/nfsd.yaml       |   6 +
 fs/nfsd/Kconfig                             |   2 +-
 fs/nfsd/export.c                            |   5 +-
 fs/nfsd/netlink.c                           |   5 +-
 fs/nfsd/netns.h                             |   1 +
 fs/nfsd/nfsctl.c                            |  38 +++++-
 fs/nfsd/nfsfh.c                             | 127 +++++++++++++++++++-
 fs/nfsd/trace.h                             |  23 ++++
 include/uapi/linux/nfsd/export.h            |   4 +-
 include/uapi/linux/nfsd_netlink.h           |   1 +
 11 files changed, 285 insertions(+), 12 deletions(-)


base-commit: 74be0455c8fccc56f668c443f3e6c784f1b7dbc5
prerequisite-patch-id: aa7471b70863a8d50f76cbe59a459e2b174b9bde
prerequisite-patch-id: 86c22e04dc3f7e13012f7df35062332662aabeb1
prerequisite-patch-id: 785b66a20e714c68c70b2bc5d04ffecd3f5e8886
prerequisite-patch-id: 0e1bca4703bda3ea8cdc22c4f9aaef8626d412e6
prerequisite-patch-id: e2cadbb6b38006e1ddefc537800d63755e519534
prerequisite-patch-id: 70b31c12fec31e7608ec69e81d0e69ae191eecd8
prerequisite-patch-id: 70e076fbc3d74787f486f6498a43aca06be10a5b
prerequisite-patch-id: 20cd3620f99e8c4f883b7edff4bfebabb449cea0
prerequisite-patch-id: cdea6cd214f376f123ca91075407d47713d502c0
prerequisite-patch-id: ce569f2d71f639ba0de805756b8c562211d02b65
prerequisite-patch-id: 2b9b54ebcf4937f90118efc142f0b34552cb47a8
prerequisite-patch-id: 6e6e2a8341e922efb72f04bab7498451600295f3
prerequisite-patch-id: 833653d35ba03741e6a0181d20941e9f91438ff2
prerequisite-patch-id: 86b33df9b7b7682c118623f5d2714560d9c90c6a
prerequisite-patch-id: 2659cfe2294725cc8038264888fd59a850e70451
prerequisite-patch-id: b8bc9d34cdaf2b215634944621e560acf7cd2f4b
prerequisite-patch-id: 390396f3d28938249168c0bcd140c1c7ebe70b72
prerequisite-patch-id: 13387919d55666c852d129d6fe3f766754c3bae5
prerequisite-patch-id: a8ec6d86976a9858d7614aa0c42de1e8420d02de
prerequisite-patch-id: aab718e5cc8e166f2b7314a20e4d36bb08d3a505
prerequisite-patch-id: 1ddf7fb4dec908557e2f21bbcadb3121d47cb217
prerequisite-patch-id: 7ddf30b5167554d95edb645ee02178a1ae4116a1
prerequisite-patch-id: 5b6b107835b937d683ff314cf259ee37ac3e36e6
prerequisite-patch-id: 3f5805b2cd187262c3c04d0a316a003a61258655
prerequisite-patch-id: 03dcee5b42778363e76d2cc41a5a9a38bef7e6ce
prerequisite-patch-id: 54fee412c1056676539d98531fd5c9cc38f7a452
prerequisite-patch-id: c99d5e206d7c832360fd5e5b87fb452155eee43b
prerequisite-patch-id: 34f61e845328b7f669759988d952a1eee2df51aa
prerequisite-patch-id: 91080c262771e2d108185ba18ee8c4ad62067284
prerequisite-patch-id: a0ecf2b16e4e2729e85bcec7b38140d6690cdf4f
prerequisite-patch-id: aeb1879e01039209c6e1e82f01027126c9caa5f6
prerequisite-patch-id: 5c2ffb43f148547ad3e44411a2150fa9cc1c1317
prerequisite-patch-id: 367a74e761b36c68545db41051e1e7831b1cfb18
prerequisite-patch-id: 0ed88b7a0fbc9ce65f3f7c5110221fe137cdba33
prerequisite-patch-id: dd337779d72bd16340d6addb49f472f816ab0095
prerequisite-patch-id: 9827cb023f9277d52951fb89bf018d400455dfd7
prerequisite-patch-id: 03dfbd11d7665cde9c7f2ab55abe67d81bca00eb
prerequisite-patch-id: df5a4e0d677d46ee7a1f7c24ae0982b6a1dc7479
prerequisite-patch-id: a668a219b466ff8a5f3fdde3c39b807eb4773bc4
prerequisite-patch-id: 7af5afc30a82624160fcb5264334f5aac6af023d
prerequisite-patch-id: 61f6e24aecec981d6e9e86841436191d36a0d66a
-- 
2.53.0


