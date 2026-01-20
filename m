Return-Path: <linux-fsdevel+bounces-74632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Oz6C1CHcGkEYQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:59:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3A353268
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCCC76C1C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0588942847E;
	Tue, 20 Jan 2026 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Ytyl40OE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021090.outbound.protection.outlook.com [40.93.194.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F1426D1E;
	Tue, 20 Jan 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913789; cv=fail; b=Ci9uEWhh6D2U8+jMdMlXBnvQ+eQFChp5BQezSwpBoJwkqWB4v41sS/Jze4mTkaoIApOCfPb0NS4DH1iV9tlArjkX9VUAc83FzQEvGNR1zCuDxPcWLPzIIFW4LJb+Ub/s5te9aJFLs6MGmICmPeUQeHFZ5g8d54UCTSRPPblYkOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913789; c=relaxed/simple;
	bh=brrOwLZpOQDvMWmsfTA9JCQLgIHyxIL2XAh7vIZnqU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTol2XfZ+iRHBzyFHcCu4k48W91wSkjy9VPnuIU6iZYBxRqLx3HRTRaf0XNClcTeoR9ge0TeAWXHuI/bRjjzVJNzGXe+nABfp5FTWN8Kpnzi/TuowLdgCfqkT4FLbwmngH1DazobMMgB8lZifK5s2V4OHfqwimfFoM0BaVb9PIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Ytyl40OE; arc=fail smtp.client-ip=40.93.194.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8cx+sLc4Ia4gqmBiQHMueNGYw9Cu7snucB5grqnKx4psN1Iom2Oj/P8WkPw77WxnlArOfJH9U9EUnVAM8X1msrq7eECKUcPLNrCe9eJy/uiLjbk0PgvGeoQZws1QQDlwqMR/U1rK76PnzyugpBWYxzMZiT3JUD1Wy13M1Dk6kkgSxTjDumnZO63GYhryg9pJTsbd6EQfRJUiGtDmVS7LZbj/mq5L8LFKhK5u8D31xfaMD3xBCVyvKnMpcK3hBTBeUu4ITJRf8HyTwe4GUNqLpjW0oXqcPXQGvXYdnI8B2B9AP78QxqrMieQYCqJE16QPTByc3aDvw9k6PegUW0dZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGJM4znxahSq8bT0tC3YfDFHRAqEDCPOzQcHGLfJU2Y=;
 b=K8aEEaMfsyebf+dRDI1GwbNVsN59c4jQOA11lbPYdC3xp9UCYzvqI7fhCFyOKIMZodYT5UIPv2cn4ok8/Y6RigYBf0rFlVtGmVioHB64S/ouXWEkVYsY5GnaUNgErARax+VJPcMBcfaC/mlBXHyCKRBtlmrpHSim/lbY1bfbcN5CFI6YDF+FZtM5TxgtOfTqpu8E39wg3VeRe/HYGOxEaS2tPvcra7AKhjm3d81kbGy6z6ABv498JemizWh7Y6PVxyfiYPj8xR8U4tDCIyF2qiP+Eib0ALq4Z5YMIwKZaoCq+e0YMQ57KuTKbVX+Lrma39/eonEoPUK6EZAYzcspUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGJM4znxahSq8bT0tC3YfDFHRAqEDCPOzQcHGLfJU2Y=;
 b=Ytyl40OEICQXVXRuf93CbMdJkVQ6Xwzw2FcAUyXo3G9H8MXBg/L3KmCKHrAWm1T+S8YcurNravAghoPNxR8ozVXSD4dhjOsKJBlq8fsX0F8FXnL9LrxkkJt3tYvGYJRWqnlHfVq6Gg+B0QzQ51deh3pgq43eE1ht/qWM6PMVQEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA0PR13MB3952.namprd13.prod.outlook.com (2603:10b6:806:72::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Tue, 20 Jan 2026 12:56:24 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 12:56:24 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Date: Tue, 20 Jan 2026 07:56:18 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <36C9CBEF-1ADF-47F6-ADDB-85E7C297BD0D@hammerspace.com>
In-Reply-To: <176890400475.16766.10882526298387036216@noble.neil.brown.name>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <176890400475.16766.10882526298387036216@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::29) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA0PR13MB3952:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b61183-e7c4-48b7-048d-08de582350d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eO6SBOd4ny1dZC5lT8+3Hcec4bcU1p4VisigTXZ9Ky82HkH4o1PYNaXsrjP8?=
 =?us-ascii?Q?rWmfdgU3L+PgOwrMLNfaY1lVKUZQ2WVCt1wAtekyQDxDivybBrgvXqhRvqXz?=
 =?us-ascii?Q?Hd0SK7wvmDETetC4Bs4rBIChUpi0HOJe5fn7dkJN7HXvULNnAgY3K0+LqYNx?=
 =?us-ascii?Q?CJEr/yKWnT3R+c7NToHXUKkOoXDNAMF+MigIbpqbQJNbE5i4si+83Wvoph3T?=
 =?us-ascii?Q?qLxpwisTIXQjSE0qqBsBuIjGUHQKzcxFwY0KSiu9094iG/NB67E8qX4SinXP?=
 =?us-ascii?Q?n7kYGKQT7JnvMSepwZV+NOprWwBC15mtm2L09M9nMnNNuWtDBSQgsbwcRR81?=
 =?us-ascii?Q?ETYk8/4ZvXLqPs28+Y75DSTS6Zxgw0KFxOdPzuEtPcYDiGDydL23fK3d/IQC?=
 =?us-ascii?Q?u7FKWUBxthe6S7cUVOfrkzMi1+9JIQ3Lgc+r2EVqAxNHhtwcuewlTEhc/ZJM?=
 =?us-ascii?Q?suGoN/CfmNsCKmUUdLQ0oTk3ZiO5jJr6FeuF0RnQU2X2Ml64bCuOSTgot1nr?=
 =?us-ascii?Q?8gYMB4Glabw2aK1oiObIuLmq3me1M9X1+tA3iAJk3NU+/i+0U63387Iez4FT?=
 =?us-ascii?Q?iD+rDYHTfG5xghJ8zKXsao5V/pI5W0UUcG8YP/S31qfEqzFq6QHqTR6VBWUA?=
 =?us-ascii?Q?oqoo1dp4xfxfwB4sogcBLN/9FTg/eeig8BTdof3Mhihl5LbOFYqfnzoYqQVa?=
 =?us-ascii?Q?TrST1aw2gmljORDHofnWOKaiRc+EXqOYcB/9Wr58QNSHbFnv80A4Qb+x8Plu?=
 =?us-ascii?Q?wYiuPPj7ntEcTthqrCLLqCHP2eoXHVWVEW+98Uj4ozXtDKTkXAnt/mvQWAIL?=
 =?us-ascii?Q?s4cNjz+LLUkh4G0f+sDdIFP7o9KwR4SD8AcPaI0QBAPSihwta4FmvVelGhxD?=
 =?us-ascii?Q?VV9BxXwmrWoj9Hpmbv1wLNeUxNis6UqPSenuthgAromgk3ELAQTQOPFk50/K?=
 =?us-ascii?Q?9AaPXAw19ieBMVFdsIjwgEO8vkZQ9kNxA5B8B+skyCjEE8V6ApYNcjNJW4ol?=
 =?us-ascii?Q?ibdQFhAPzXvR133tOqftSU/JC2dgV8c7aP49KreoWqwvK+Toear9WV1aiskj?=
 =?us-ascii?Q?Y4x8HMr615YiK6kvGvdjMnpjAjw/xU2cKhW/UwYOaOjgI/sS2UUTfuM1Ac/w?=
 =?us-ascii?Q?inm8ABbMDoewIZ8o77XzYyd42hxqyR4O5OjS+xKeF0lrlPt0xFcGQWHlBkMZ?=
 =?us-ascii?Q?n21EkxV4KN31LWHRpa9YZLJpxM/MFWgD14JAPqxM2SPsOTN3OpnYUpWNBvQR?=
 =?us-ascii?Q?5wh/8VBSCEt+W+ZdEfjwfjiv5UWGx4iRMa55Goe+qVLA9rcFtYULl8XouTfM?=
 =?us-ascii?Q?JuppVuZVe+q2SFTNtycUmEIjT+Skvsx4k1G6oKVja/AV5UPjxN9+2lnCOEpE?=
 =?us-ascii?Q?UYrZXSx7I1O/kFIXNbTkKaEyQZyWkMxyiLBWq7EcR8lS4LTv4gFQyqT3tn1N?=
 =?us-ascii?Q?Ki5MWr+uwH0w4aQJWMErv9uQnxWSIq5kLm10q/dprvtKw47p7x6iernmgieo?=
 =?us-ascii?Q?/UV92Fg79VZJt4MBj5Bdn23mMvzViREPaYptTOGI3kWH5eHW60R8cl2tU7Wy?=
 =?us-ascii?Q?29eVEKOfFeQKDb66z+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mag5IzWdXh0B/3zRrHd1jmnnZqrh/geXub/mWZ9KGbsk5LU52CVvlmfcfHQG?=
 =?us-ascii?Q?FU14v/R11/Y4HHREOnZ5XQJXKN7zmZeUSWwimIWSuWx0+PcN/aqfgmWxJyfj?=
 =?us-ascii?Q?4fxevfLTRqIIfyAr/cwVmNLgkeu/7WGFLckzTPhMeFdbbuGRTqV8orrGHEJ1?=
 =?us-ascii?Q?+AdvZgevbYk/THVEhRRwzacE2E2oB3QMbNyOmfUkt7LtsCChN2jKBO07hWRx?=
 =?us-ascii?Q?GYwKnl+odpDv0KrpFoy8Abyrjg5ASg1wDKDtQ+W6rvkHLNDu7sJGk5jvKkS6?=
 =?us-ascii?Q?QaWymGF+LZSAXTqlSnu71L1t+IGnvYwiqXAN6C1J7JcPrnoH2O0Cjc8AReOh?=
 =?us-ascii?Q?c7Kekp//x0UO9oOW7ibrjITmRQQDbcWxktmdunysQATOZ4eNWyWl/qRQCzCh?=
 =?us-ascii?Q?Cnjnw39YaRWqcHiAob9In5QlJriShzO8f093gXFn/VAksNMej/OxrSpEWgUD?=
 =?us-ascii?Q?y3s+MnBrhrjJ0YRlugJwxPINADj1rHYHXPirFy6ZzJ4y32x1m4wp4lhYm2z6?=
 =?us-ascii?Q?aFuXA0bcdWePAzyXG/GEaK1igbvZ47ZuWY+uQZAYleq/uFgMHoIVBOgs9HdP?=
 =?us-ascii?Q?G0QapXMOhbA/6DFwQHMLjm6lmZzy5If2DD3JEvYAtVW7I6QlWPokjWv7OadN?=
 =?us-ascii?Q?Ru6rqQ4deQb5IpwXV+ThSewIDbDfKvmjtp1FJgaPZA/CGUk1qzC5Noid23mk?=
 =?us-ascii?Q?2GKyWho2FqKX9Hl4vPBvHb7bXXWUKhl7ouIoV2K/xCjfzlli9bE0WN0rYHqQ?=
 =?us-ascii?Q?nD5t53c0ieHhmilYEwyUOFIgz2wQhc5/1+6YXS43w4ItmWfWnLJK2bQT6iVN?=
 =?us-ascii?Q?O+BDzUjnyquz7TN+p3fW1mSARjIoZtdZ+yRw+VcanmKo2CPsDYd24dCSQKel?=
 =?us-ascii?Q?H4U0qic+C3ukPc6NpTFe/ym/zP3gzNGxY16xWgtGE+XGbl7pCvz1FuAHaqU4?=
 =?us-ascii?Q?eSDuSvpxrmQJXDegZhRw570biBUnoCCwyR+9FoM7qI4RFgV/JzIxA1I0VkWL?=
 =?us-ascii?Q?WPNQdsJcl5tSR3PViqqnsCUdgMhokwD98mg7m4Iw9tOR01gY90QWH2IcQcW2?=
 =?us-ascii?Q?V9oGUqSe/eZK3LUTjPs01usb7F2LEeoNAZyE0UkTVPX8pNGTsjcxHq1P4UB8?=
 =?us-ascii?Q?PoRkhbAcH31Qx1MXHS6CFSn6bvVvTbTMq2z6O526MUhxecyexNJRajR9Gmd6?=
 =?us-ascii?Q?hLMqBKJlAZc3Bat8qklluGe1sX4NPEZY+EEa+ChhVHONquDEvI8iHmXXzFYG?=
 =?us-ascii?Q?Bs7O6P0qctIxash5RKofBDinq1wjHvjlMwiXMUSRSs+przSZQIqzjK8kGOnD?=
 =?us-ascii?Q?aZnT8NSddNK73QGCx8iEK5yKpnWPGCy2+kJJuoyCLAxGPACT4cE3y7VlxkV2?=
 =?us-ascii?Q?n1lfAHEbd/eDnb6gTu9VIaS9YoYUsRGwaTCTBYKbg6AY3ze1C+3gVGgZHgEU?=
 =?us-ascii?Q?S08CFGpb7Vr8sLZd14sv7SpTZiP/z1S+OeU/Isb6DWTGryOPHjZqpnQiWday?=
 =?us-ascii?Q?A/RdOZJDhPqvcF4SuKrAtc0B0DTgKDtiehCYXjwYOEevJSpZAvp7CMsl2zL4?=
 =?us-ascii?Q?QDIFxtJ2Adzqc/Pc3Rn2egb3vgpPWszDemR7UuElDF2GGoz1Ns9HZ42HXrg1?=
 =?us-ascii?Q?ZHY748fSOKvWuBRiGC9p4nrY2deV51S0ROhVH8lUwXfzc7JeazQAWjemTiSy?=
 =?us-ascii?Q?DLsD2eBEw4WOdf/abAwQMQam3ENTyLbbnCZvGUOcZJEVW7BvPo/ikSv12e/j?=
 =?us-ascii?Q?cZgLi5WRse3d3Gp//z4lBjtBz/JskF8=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b61183-e7c4-48b7-048d-08de582350d4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 12:56:24.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgRIM8FzIL1JxlLSf1oQ1kwCn7opL1WbOhBrIZkmHY4s5QtGcXzB/e5w8420RfUPGhBq9ewrw+L0daWCLorFRKC3v8v8aGHtYsDaulIzTWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3952
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74632-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,gmail.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CC3A353268
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20 Jan 2026, at 5:13, NeilBrown wrote:

> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>> The following series enables the linux NFS server to add a Message
>> Authentication Code (MAC) to the filehandles it gives to clients.  This
>> provides additional protection to the exported filesystem against filehandle
>> guessing attacks.
>
> I've pondering this some more and I think we can get the same result
> without any API change, though it would require internal changes to each
> filesystem of interest.
>
> The problem can be rephrased as saying that 32 bits is too small for a
> generation number as it allows guessing in a modest time.  A 64bit
> generation number would provide sufficient protection (though admittedly
> not quite as much as a 32bit gen number with a 64 bit MAC).
>
> If a filesystem had 64 bits or more of random bits in the superblock
> which are stable and not visible over NFS, it could combine those with
> the 32bit gen number stored in the inode and present a 64 bit generation
> number in the filehandle which would, in practice, be unguessable.
>
> ext4 has s_journal_uuid which is stable and (I think) is not visible.
> xfs has sb_meta_uuid which seems to fill a vaguely similar role.
> I haven't looked further afield but it is credible that filesystems
> either have some suitable bits, or could add them.
>
> We could add a generic_encode_ino32_gen64_fh() which takes a uuid or
> similar, and some corresponding support for verifying the gen64 on
> decode.
>
> This would remove the need to change nfs-utils at all.

If so, it would be nice to find a way to unify setting/changing the per-fs
unique value because cloning and "golden image" approaches are often used in
deployments.  I think there are steps taken to "uniquify" cloned systems,
and setting/resetting this key would need to be one of those.

> This would mean the file handles change when you upgrade to a new kernel
> (though a CONFIG option would could give distros control of when to make
> the change), but nfsd it able to handle that if we are careful.
> Lookups from an "old" style filehandle will always produce an "old"
> style filehandle.  But when the client remounts they get a new style for
> everything.
>
> This is a lot more work in the kernel and requires buy-in from each
> relevant fs maintainer, but saves us any API change and so is largely
> transparent.
>
> Is it worth it?  I don't know.

Good pondering, I'm hoping this discussion continues a bit and we can figure
it out - I'll still iterate on this design in the meantime.

Ben

