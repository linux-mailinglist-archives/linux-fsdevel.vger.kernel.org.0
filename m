Return-Path: <linux-fsdevel+bounces-74923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJh9AFo9cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:55:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3E45DAA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5D2BB2BD99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19372407561;
	Wed, 21 Jan 2026 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="SthR+TRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023128.outbound.protection.outlook.com [40.93.196.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1A3EFD33;
	Wed, 21 Jan 2026 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027072; cv=fail; b=XopUC/EMJA/JSNZZvpz0Xi6UU0BD2+oyJn9oRC9/hnGiOQ+dP0iwV3keW8RoLlsSg1CBTcVFY4XKYvVQCE8SGrXEU7rD9ab9V1NYjGZq4H7SqxoEKNBqsFKQsnCFeoQmlSaBDewtjmEExgnRt4khv/E90LgpxLQo4GpXMTTvvxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027072; c=relaxed/simple;
	bh=Y9wsCt+XPaUBWf6Us5x/igQYd1KPz2pQTaWGTnNroBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTghkKSU84W4Z2AGZacNntAB6NfjBUz+IjuI258Wlm+9fv4EXIVt19C+L7sYNg8k6MlVosmS+DrlABh4x6EXWohylFQqvv7BSvsdEfETtVlUn3tDsUAtdBayv8YRdPrfqfiz2e1ogqZl/bL/nTj5xR+hNa7Ay24dkhIj1IHVmZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=SthR+TRl; arc=fail smtp.client-ip=40.93.196.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQzzy/I3YHClRD9xJVIXqifx6pRazwp2ag40rwhQ6jS5d+nhGtG8/kc9RsGPndDDqj1FdmjSv7uFK5HdXG2Y7LQMyGdwA9zf5DsnsyYJBIFfxsAITFSxaw2ReoM48FWCZsmCLMUaevbtTQgzrDPqbevFZXl/5YLWzW5canIOoO0eT25RGkld+fWEIO+VeZoFbZEgrtX2y4l0nI24R1lCk0tuZ6xeJfbTcV6zaMcyH0tgSf1Wf5SiX9GmwOEec8oEQ6zcgwEjw0aBEoSXB6ABqWCBx9eX0XRMmWTwajv4XAfOJcibv5PTPcERJiJk3tHHvMW8sinJBbl6P3CdB+7TQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF2vDiIJ2UXsi4ESz8GXqlabRIgMDX9LMMoVntxZVJI=;
 b=bQ3xk4xi8CJDxAVtpZ/TUwIEsk7s9kT2MVd+0eskT2/3HchNEuuhyh+Kyk/y4V/WRMCdMcqYau7rR0N8SDZciZCUVbkP8P58KFNMnBIit9gQ6q2wJIZ1+wd1XghkTuyTtamDALp1PZ8dRxYd+P8ctH+RPFValuVbCZS9gn1eBZ9yI6ox4WuwgI3q5dudpZ2OLXhcYTNdgrLdGMpwvtnhRWqMfOM122cjynf1PKa8EuzODkAFaUexrViRRjVIcKrmDnEpoJI0EfofT8aWKUj54yCPzZ/u24Cfq1BibeJVn7ipBNBAxwnxfSTODRqzivaeE4nvQqbmE9v9xPO5p6dkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF2vDiIJ2UXsi4ESz8GXqlabRIgMDX9LMMoVntxZVJI=;
 b=SthR+TRl0tEk59Vjj0qRdaLtPE/p/IqnJfj4R4BQuUlto3AeRX6R1eb/EX+EB4YB+uGH0klmdZ6uCzBkDFLwPbRh3maWpshtuAynP6xUb5sWriqnknhG/+GBkXqncsLqbEZYQRE1BtnxSfjocY6VA1uBgSQovxZ6tSK4JumC4GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BL0PR13MB4514.namprd13.prod.outlook.com (2603:10b6:208:1c3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Wed, 21 Jan 2026 20:24:26 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 20:24:26 +0000
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
Subject: [PATCH v2 2/3] NFSD/export: Add sign_fh export option
Date: Wed, 21 Jan 2026 15:24:17 -0500
Message-ID: <7202a379d564fc1be6d2bfbf4da85c40418d9b07.1769026777.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769026777.git.bcodding@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013317.namprd07.prod.outlook.com
 (2603:10b6:518:1::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BL0PR13MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 78751f2e-85cf-4dd3-0816-08de592b1282
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3vENpFL3Qxp/3edJ6HRbHdXNTvCWbSRvjeF+5H1SDA5CuFKIOMX0it126fa?=
 =?us-ascii?Q?DxTBy3diZ1ifpvQWpWWBnZxzVxesdUGmsbu8GJjjwzVb5/WfOR7ln+wzGXTZ?=
 =?us-ascii?Q?dMdOuDZAvjjaKONtfjCh+E6Ygqh81wfsUGVRsT9GaRNo8pDo9I6BMm35ONhZ?=
 =?us-ascii?Q?VtZroEVbaKEjVHWyTITPjLAbOS9n2PITOpgfvG92eG7OcYNgXrzdCg+mWa+h?=
 =?us-ascii?Q?RK1RNoJjCW4kqkBo+eu+Im6eSQ+PPh0O+JZP5Jk/1Y5S7+RdCKUfHolQGyfK?=
 =?us-ascii?Q?o5CzgGH6TyzZ96189pECAuvAayxSydZ46oZDb/6Af2vEvnSH0zmWoJRN6wDD?=
 =?us-ascii?Q?yfb9yiBHFY4rdJ40oBX66xAOWpPwjC/hmn+SiLDYV/1KgpX0WQmWNPefYFg0?=
 =?us-ascii?Q?nFDnqqhOSME24+foLUEkyNk3j3LWJw8POkje1WQg3Sfc0ryKATLszkJNqn/R?=
 =?us-ascii?Q?YAfMnoyPFoZuTcE04iqYWl0HWM7XdinGZOS8TrtafgCMNgUwqt9Slh6tFa0L?=
 =?us-ascii?Q?XKpvADEb2yZmFMJSfj673kD9Y5a0A32WQeMgQFElrKpWGIzcRqeqOhmXUqEq?=
 =?us-ascii?Q?49Ls4c0LpjU9IwlFFEDUA7HUwOYI8ATBD7ZvH2AFVaSl0J+XcUsOzFsH5Yvo?=
 =?us-ascii?Q?xeTJTHY/h1Fm9jlFaXarEndKrVpQNKMNRhz76uftFuAislQ1dUItZy9yR6jN?=
 =?us-ascii?Q?wSho1cvqgdHwwk8g8yKVQZL1WEc7oGv5FTpth/+uelEU8kSgvT+Zxr+9tL8o?=
 =?us-ascii?Q?dnBXx2bA4DWSOseDgFAgUUB9MFRfFh4smGj11qRRFTiAH7LXqy4Pj/I9IIoC?=
 =?us-ascii?Q?eR4lBN47gXNQ0qi114nbb6UITpDzjk4LZlvloPO7TbllmnHQmMV3BrgsMYGk?=
 =?us-ascii?Q?a3TONj1wvRZCqijs/jZ9inEUIP4Ytxu+bn1+8zGGzalqxdR90PB8LTKnZoC4?=
 =?us-ascii?Q?5w0MWmAi7gx7QkSo5hJkmQjI4O9vsIYrbVb1d5GhDHGJfZLDTbfeV8CH79PE?=
 =?us-ascii?Q?NjVPxQ0Pq1kVyilq2Hy21RXC+xYqqrkYnDMZGLXfZ9LruZN0VQqDqFBmZ5be?=
 =?us-ascii?Q?bQ2iIuKvbTPqo77j+8uQnxcK4TWoKip5RtaLbnM2KpKyHVuuSdm6rJBGLLlP?=
 =?us-ascii?Q?NcVvnRQhHbQs9WvijssKNIdxuT/wJW4EUQ/59+xr6Muupyomiv5m+/pkQOR/?=
 =?us-ascii?Q?BVloNhQNWRQ/5kQVpy7Tc8MeiNTZFpPSJpYe3zoSJ7A9/w8FdYd+CX0kZiBN?=
 =?us-ascii?Q?G6xscz1L/70qEIjfpZ/UXOPWFNmDjfJ0sqoIX0wMyOtxCnVDZDaXXudyPktl?=
 =?us-ascii?Q?/fd9+wx7l9hhOYlciC57+7wrDlTZ/My1GJE2qDydsKUWYRuPG1AGdQ6KZROm?=
 =?us-ascii?Q?vbRCeHa9RDzWsrBg04fYuA+Gfl3HNLApaA7yDYA5Toc+1ypSnQYveecK2GXb?=
 =?us-ascii?Q?3wWCH1KG5eHSqBvwPwqQQ/ymjw6ecyvzl2LvOLcQfbB35ev0V6mn/NQHPmim?=
 =?us-ascii?Q?j2WBWgP/snuTF7h1M14d6tUn2pzTXi8yIK+mSNqVRthwRJyPUQA4YKbl+Db2?=
 =?us-ascii?Q?qekpiK9ay+rCtF9zUsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xm5KZnCNBGjCzRgRRy6aKuHFFZgwvlYiLnJYg2gsldlPfk8Ij4dKUf/l2ulq?=
 =?us-ascii?Q?W1T8zow7dWX9EuO7ANq4WL9xkuzxQVBF1aa9V4TLask6zI37abjVN+igbovy?=
 =?us-ascii?Q?TPN8BQ55lpx/W41A3y4i6UnXCQP9ZQ60uyL7sDU4ta4V500Wnl6HAp4/DPEx?=
 =?us-ascii?Q?NjzDncpKvlj2hLuSFhVpp3Fk0o5plsVxrme0NKJzl1uEFDL71w7uQIsBcqu0?=
 =?us-ascii?Q?sxxyKaoRGT5MhrieA/ATQMrG3ikWC/aAocSZvn1f3tEFIQXQpSewqzaHI5jw?=
 =?us-ascii?Q?xopcRoMVplp+baJaxFSBVg2HbHewaQ7LCn3wtQiVyxka9j8UeO9d+6JEWSB+?=
 =?us-ascii?Q?Q95Y3XYXoomAxAWhsWBLSrKr0WiWPboTxWWLx1jOMRBnD/yKhW97ocRYn90f?=
 =?us-ascii?Q?WZldluUbkN6GphaMJArsyQcZkpYLfB0wICelUrnqWBXrdDZmRha3Eopz7Rpy?=
 =?us-ascii?Q?ZggBM62P4dQIxwWapNuW52lLvQfDfT9TaaV8snkffJc94Bk5JrkdwyxdtJt+?=
 =?us-ascii?Q?QiCEDIXXoXK592+rDC9mmsHMKsKolzKHY4+689/mu4LEmgrI1wo3uy9zd3Mm?=
 =?us-ascii?Q?9AzA4cqgwxt3tKRrwI/E5rsrqZLoRU1C6jQBATc6VydXovfFT3dmGTRWHb3B?=
 =?us-ascii?Q?6lhiWRpBTv5cBXPAUuO/XD3zty98YpAWz59Upkb6UoyGiBVSXWNK4QP8AxT5?=
 =?us-ascii?Q?jfrEq9KV28OTVUq2x0QXoxJEKED6q0jWH/4l8UsUYMezOsqavNW5Zv6GCwXR?=
 =?us-ascii?Q?bLe8K3+hmsRhHZCgI4Xtv6/IcHvq8Dwz+VGQvME67LUpCI+iN5cCaLUPKFj5?=
 =?us-ascii?Q?n/1rbMqLeJTiISajdO83Xmd+Wmnueet76mw14eqIykMxA+5Li2JXbkXpyfeJ?=
 =?us-ascii?Q?2iaO6FUjbXaXUSNH/9QMrL63eyynBOyx6EZihpdQRfFmMy+ogZWCU1n4Fbm4?=
 =?us-ascii?Q?78OxcclPlphRfiwO+gJGGPSSpX8i4Y98E0x6tolY6GlCt2VB1bWWQE4hGa4r?=
 =?us-ascii?Q?RdVg9nsXFGXOHjapOpMLpYOE6bFvJykfdVCZgIqU7r0parmmoCGx0FK1/d46?=
 =?us-ascii?Q?wburLth5pCWozohn35m/PONUEMto1vw5quwl4zy9T/yqwWT2K3H5p80k3XKP?=
 =?us-ascii?Q?aVVbn92+85uce3LOQ1wgkKbElA4qa1HwZMlZbNT/Pd+nHtA+lfwZbMaPKFXy?=
 =?us-ascii?Q?hN0F4FBBT4PptRyAxBTfqadk+HIqZ+IJz3yiyizTVtND/c39yeouWO6oDdAM?=
 =?us-ascii?Q?XyAuZOL0T41rh+/PVVpp57B2chb5rAPCFug5AyUTCkW449ttj7c6QgL4fle5?=
 =?us-ascii?Q?PxeJ04Sn30cw7WBcOH2rsJU6JGr4XPRvYtS46xMINsQag/AWL1tTD52hVDxS?=
 =?us-ascii?Q?CDrICtHvJA6hXlSgJlWGEk5sg44WfkXjoOY0PKalSdHYbdQiWbLnLp4bUqML?=
 =?us-ascii?Q?Wki6r77k1j4KUIkv+y/DYFp7jHwX1ip57oZPu0ZMfpgctliR1BvFNdRq5Ooh?=
 =?us-ascii?Q?TmHknExSjou3xOsNnysfuSdXIogqVV1I6BlLfkATQaxHc1mzsr3lOP1+rwWu?=
 =?us-ascii?Q?lDQSQ9kFmIkV0qDVRQ2TWTllvMz+tU8By+xFIRftWV6IE1myXDELW3fahdwD?=
 =?us-ascii?Q?7gxp6IckwHsAyxGgLvNds8xNtJwABo1/jh4xROwwHP7nWbmPjiYVSCHZaRlF?=
 =?us-ascii?Q?hfZig3Q4evpJh1/k2laLQ+9jT3Ra72Fxz1yYMRafyafXBnq+471UYsSyk+5K?=
 =?us-ascii?Q?ykxXApqrJdGHYCICjYZMoySDwwOa6GQ=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78751f2e-85cf-4dd3-0816-08de592b1282
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:24:26.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQR1uHCEB+qW3xJG70+FXznEJY95xRLo7Mr0A2vCAfUD8RYu+yjuV/yoDi48CMTMacrsoRT5G1Uh5MYDnZP4z16r/OHmCUzPmoFhX0fA6vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4514
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74923-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[hammerspace.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8F3E45DAA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad19..19c7a91c5373 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1349,13 +1349,14 @@ static struct flags {
 	{ NFSEXP_ASYNC, {"async", "sync"}},
 	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
 	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
+	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
 	{ NFSEXP_NOHIDE, {"nohide", ""}},
-	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
+	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
-	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..de647cf166c3 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -34,7 +34,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS    0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 currently unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
@@ -55,7 +55,7 @@
 #define NFSEXP_PNFS		0x20000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS		0x3FFFF
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.50.1


