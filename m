Return-Path: <linux-fsdevel+bounces-74926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLfCAAtGcWn2fgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:32:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B37465E196
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7711C64D580
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C8F421EE6;
	Wed, 21 Jan 2026 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Av/qoU1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022112.outbound.protection.outlook.com [40.93.195.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6A3DA7F2;
	Wed, 21 Jan 2026 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028856; cv=fail; b=t6YPKnpTQx2QnRFLH7RxCKYiB6EDDbmeCFnYrf9tKJHQRgeqdzj6Rwmm+FQAN9bqPWlV4T5/BFUeRO4usyJCV7z999seMV/xpeHE1lkOYdscZaO1Nom2JyBf/PwlIFoT1I1EgQfcQN1Db91Ne1VQLr1go8OaZa3Zjq8pJVbOybw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028856; c=relaxed/simple;
	bh=SGlKwVyIEjIqxZobpKgv8+dJZM8wJ0xDuMM3EfRCBuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QOKY7Vkw9K4BZJEJCtode/sQ+UPLlwxveYQ0eY7jaNRGHWWQHQIPltL8MI9eVbs94Wh5BoqjYQgyDEEjNxvIPiq8e+xsG+vLR509Cb4qQUobNPeBYAUGHDwun10L4FetlckXxXi240/iK11p2wVxdwxJshgZGpHbw9cKoR5G0VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Av/qoU1T; arc=fail smtp.client-ip=40.93.195.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxwbzhEfNqJ7qzHYmQ27zJC6uA0EtjD/S+JNiLDrW5Oc66hf3tU0ymWQNUIsIul7Tgjwc7q3BcOQiaM3Vd7Wh6+d9cLqss/CBgFAD3gJtgYFX+mudihkHa+QFbjPXXqxG37el/n2M7FJmno3o0JP9JQxZNYKTAPLcls7lxph1/ssSMrVDVrKrpYk2YB95pkDTESCp3thb4OcAEm/4ER0LkkN2MwQxw0tuFFDaZIR9JLTd/C/FM7Byi0Pf9NEq1ieBi/k3LzG3fnTPFq7Dz2OpZbjUsr5kfDclq4hZdTCTDwEbKay9f++6Kuc3NsDWXRgm3b892LU1ijmjUOpoXO2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsahCglRhHbZfVqZht+WiUQXazuwEbn5lMOkGHXJXKo=;
 b=W4j7MDitMbMDVLT9+LxOJ+k/X8TKE/Pk3MAlrKJa0xuDJmd6PYKTZuE650/g/D3EFBUWCyugh9yFoBc0guK1yn8dz9SgngvXVft5mqFlqlvf5gMYOt2JUvW37cuc5FuwSjYHE5J7ZpB0nVpknz5Ehlra/jGj50b3mHcpIAm+gSLTCBJ03AjCK/CMqAlWpGXZf+v2Xn3TsPb/aKF34LG4AE02b4qWmPVIaCCkU44+QHuPHEdvLsuTncjaU83eXK8Smj2hbapSguIPalJy60eoTtM+M719ocLOabo+ufMwtzu5nv33cxXdOU5B1CrcJ7c884//GA9Gp5PrlElaZNCU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsahCglRhHbZfVqZht+WiUQXazuwEbn5lMOkGHXJXKo=;
 b=Av/qoU1TvMwIulXNHGy/g1L5DfUrx97pOF3o9CJEB5ZTjNQgMwBILkRG++O5Fp7Sm5TBM2M0+7SNDOgK6DaxJxzHkrF3Ymim9P5NtKxB99nmC3jvh0KrFShHfNi9q8WjDAFII3tqU5IoibnsgbB53iPdNAlyWhiLViuBY7QeErQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS5PR13MB7656.namprd13.prod.outlook.com (2603:10b6:8:33f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 20:54:09 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 20:54:08 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Date: Wed, 21 Jan 2026 15:54:04 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
In-Reply-To: <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:510:324::8) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS5PR13MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 13330976-f4ec-4a47-f30b-08de592f386f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xb4XzQZtS/eyNarvT42nGpPFw55HEAsBjUTVXtcytHktv23e6PrjrOijPFLe?=
 =?us-ascii?Q?X2rPP1Xk11j8bSUgDKr5KhJoPf/gy7YjV/FMfV4BVLlqFFRLiuwzqgYHLX6Q?=
 =?us-ascii?Q?SAGzWo7TiI4ujCODsTxb2oeVozF/djLsl53o1WkxUPRzl5sy87WzSUoUq4H5?=
 =?us-ascii?Q?zE+Nm8FU9mUbDhWoAWo4l1ed4t4lbIXq7Q1Zcv+55bSJk8USjokKn9Ek+NfJ?=
 =?us-ascii?Q?fcXMKnWVRTB5hav9Sr1TyrgMXipIt4ABTAO2GSM/2RbxH9tmaYIC3oFVnI3R?=
 =?us-ascii?Q?0nnajB/fd3mDzhSG9fSuEvF6+9kxURCmjAhLt+YsrSx9kkPgJ4ihbdABi8Fm?=
 =?us-ascii?Q?FM10DoHHHm/hqw1s0nJQF9FM1iy16pD3j3ixLve1WQW6WKJClgHOXywWKWwW?=
 =?us-ascii?Q?/vxtorgoo3X+b726nfUbFav4r0fieWlpRs3xG5mewnqVUG8aPhHZxKVmeIg9?=
 =?us-ascii?Q?J2qUuVfdejXTZLFOm6WuWdMSxlehChzXO5ItbzIG+n+ActOaBd6biWvbxE0b?=
 =?us-ascii?Q?YjlHDVDMfiibWgsIUOK3AV2ZMRC2naGyCUgC8HZDvyP00d3zMVNTdf33STS0?=
 =?us-ascii?Q?baoXat7i5LdGzvhkXwuyIfGZn49EvskSNe6nwU2LbNikHjH2hpulif8NKaBn?=
 =?us-ascii?Q?qq0EamB1VgIhl1S4JGkMtjMOx1P9Aj8xLkzCxLk9F/BEVi0IcQ4t6QvbZiJt?=
 =?us-ascii?Q?7MYodhTmziWzg1eJUKtpSSjHJS3y4iA6zGQgQAo8tm82zsSADT9+4VpC6CiM?=
 =?us-ascii?Q?lYM/VazypX4qlDrerc4ii2h1QQh2wO6WueHya4OC2KLjnYVL9q22MLrtYCIJ?=
 =?us-ascii?Q?ot39Etj/9Pt21a9+e3lvSupeYZKMlqogddnRJb/Rls9dSEs1CxhpcK3F+AC0?=
 =?us-ascii?Q?Ei4JDaBwcEA9XtpoL+5z3R19bxu9AHzlQzxOO4uU36LF/tQvTBi+R4AXyIF/?=
 =?us-ascii?Q?0DL6AZIvJtb36QIKye+/F3JRNrsYmcTiQa3foaeThH0rq1Qr7GXRI4482/2j?=
 =?us-ascii?Q?2omOCxr9EFGEd/K15CrwhVBoaquulN2vCId4FPK5uYnd4i5Z1Z0QRALXE31E?=
 =?us-ascii?Q?DU/hXh0eDev/m577o02IRASPJ9Ux9WE75+MdbeY/nGCIdV/nw/Eyc7BbKB13?=
 =?us-ascii?Q?1f29JCdCklST/k7MltOUGgT/zUkOkXf9n4UQrfK/43TS70srhI3j1YpuvtQP?=
 =?us-ascii?Q?5D73zds4NREKaPfV7+rZ22Hw3mxgQMartDZU5Xtc334GQHWU37090PpT2tXw?=
 =?us-ascii?Q?SFqPcMJPI/NUOZLlF+l9YZuBJ9L/UGw9WSRspgSg+qW/DvOA+naDW31MYhzM?=
 =?us-ascii?Q?Pbd792hr97cQl5R3NoStvLsqQYJgrgDeZytCZg6dAf8qbkflj+zuQDXiqR6G?=
 =?us-ascii?Q?vX1CfDcWG2c1gAw79NJgl+aKODNYV1W2RCNlI2hD5GlG+DydZOww7L1CmwW3?=
 =?us-ascii?Q?NQfMSKk1Xx46BnyiMO2bs7AMyylPy8BA+cgP3VKMk+Y8fJyR/GuU61WmJZZ4?=
 =?us-ascii?Q?D6S6HR66DljpNgKvaqr25UIirS2i+0g/Lbd3Y47mfbptgIpjZ9m4vKR0qzb9?=
 =?us-ascii?Q?dY2qMbqDoCrxnV7T8zM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kCyekz15b6C2CXlYRx6p3HARlBY8SASYtXIrRQI0GZOiEhOeVJpIdh6y1y2C?=
 =?us-ascii?Q?7zSPVAvrNsv1xQ3sHTFyHYitI4PbclV4JZ3Ogy8B/EDDG1VQmh6lULkzdT+u?=
 =?us-ascii?Q?kKUtxr/dBfqvLg+A4DHg+PpLbLhKDSgj2yxcD8itBed2GYwYCsz2BvhB6mRc?=
 =?us-ascii?Q?acJ5O+HkM9dar65Tle5IvtG2FzOiXyBicIxJ/ioYg5Aj1afxKy7V5JOftOGw?=
 =?us-ascii?Q?2oOgghZras/0LZ6ur3A2WjP4/T8rvMD182UmhRMDng6LXuuApZEiA2LCvtKv?=
 =?us-ascii?Q?tMoon9nYAfmthNTMnQ9QIhuGYQ/eVtQPXe5OrLhtZsLU4eL3RroL7pufxoPP?=
 =?us-ascii?Q?FXhw9JJiLRG+JFLILZsUPT9qLxrWVYtZ8Gag09FecWDJgCNU2Obvbk5/JVzu?=
 =?us-ascii?Q?zY55rStSUaJfMS6PG6v+M7l2NicE/W95VFKdemhfgBmWP7hqwGZZ12UM8Ddq?=
 =?us-ascii?Q?K6pfgjv2uoz0XDIiVxd02pOoS1cUfNVhdUp2ytkpDS9r/f5Wh7JfYh3pZSaj?=
 =?us-ascii?Q?YbdFixd9G1q4h+E75UXBDn8Vtwd6ouNfgl0h3QzS7OtfPRSfRrmfdiho1QLO?=
 =?us-ascii?Q?JgQOqzCiI2UBGNbWZlfROF9WjmO9JhOJKs9sCWkKqIb5pnbjFyvN/uFKbnjq?=
 =?us-ascii?Q?VyxQceWg6/WupRy8em5PCqaXYrFb4Ivcj8/f1VRYQfv6LgUD19o6wFkDY3o0?=
 =?us-ascii?Q?RHa3JLaIUDfVb64PV01g2krJvRw+xyoZzpfX1/CWHpcAschyS+rwVRcUo13L?=
 =?us-ascii?Q?dI3YGkKPWynlgaqSAMgh3dSQw1ubVsmWCDkmPorX8H0Vo3rHlXj1wP5oiv8h?=
 =?us-ascii?Q?o7Vd+6rTPAAfwHNGUWQFZj3aJy3bnTwrsvWFuMXbcwWrdKHYMtc0QyUi4VT4?=
 =?us-ascii?Q?8hVIr/hvSTvSxYuZXoGZQyCuCoEAYfhPUg4mHlxdW0eMCl5MmNZ2w1tf/Wk0?=
 =?us-ascii?Q?2pZCFJ1JBQsi3VbmuFVL2u7Q8RzfEpbn9l9AXL+7NzqePB+iAPS7WaqnuNWl?=
 =?us-ascii?Q?seRuns5yfpLn8FmBsvYc7d7RZQOJFSY7eZp0kx5tDk6HqQtkAhB74ic8Pj1k?=
 =?us-ascii?Q?t4gVEvU6BCoRZ9ruJANEQUOcOthPdGCStzHtiTY3nz5RJlc5UNrL9XkvqC87?=
 =?us-ascii?Q?3lYp+ytelFKbDx+htSHvk5EnVVDYr8iJNSIlJxrwTbVbglgvDEsrQTAGO+xe?=
 =?us-ascii?Q?plcGSDkossIKrOdveKiVRE0Eu9IXCpfwDoJGtlfN/kGNS/LBrhzmQru5dGS5?=
 =?us-ascii?Q?Z94Yk91cenjqXyqsHYLTTuuthaR5aFMY+xkW1z5pWDI1a2DDEXiB0KaeIWFG?=
 =?us-ascii?Q?CDENRZ+mIBAQk7TMEUDZhkf6armw7J0/KCwu467pOqADleAUH21oBn1FArgC?=
 =?us-ascii?Q?Ne71UTJX+XdkUE1f58M74Hm0E/4uaVP8Hv/VtZ1I5YjD6YGPhXxXIcCOBM0z?=
 =?us-ascii?Q?6EFlGzVFt4W1inaOrk66IFpeGonIodphC5lX6uyiDmAAIJPToAy8E/xjg6D8?=
 =?us-ascii?Q?UeZlN+Rz0lkTiOaVwInMJQIuMDFs0cU1M7h22Z0FUtBvcl08UMgbq0IkjA9G?=
 =?us-ascii?Q?s61+mhLLIQLB0dZRQH7cIg3j4EWq9P3sVTtxFOxqW6sihu2u5gLyN56PVhFD?=
 =?us-ascii?Q?1DZpImq43aXIEj1+ljnkDDElY8DxoKt2/70DKwTP4YcYuCYXP9pRVM8ZNSd8?=
 =?us-ascii?Q?MfEwGbYo6136uaK18g0bbJE8g0bLUBLxwZXBqMBd24b3NNNzCTaBol2FXdVA?=
 =?us-ascii?Q?wUgN2yFwz/dxsRPWXm3NcG3rwuek9f4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13330976-f4ec-4a47-f30b-08de592f386f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:54:07.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUdhsU29GAiGFPet1Sw77cB303emStmnh7hnHkvdumA07foz+/W+y6aiMI2heoxdofoeBnYDNWcmVrRnWvy5fPgYUnbKZacKxJcu2uS7Y4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR13MB7656
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74926-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: B37465E196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21 Jan 2026, at 15:43, Chuck Lever wrote:

> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>> A future patch will enable NFSD to sign filehandles by appending a Mes=
sage
>> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit =
key
>> that can persist across reboots.  A persisted key allows the server to=

>> accept filehandles after a restart.  Enable NFSD to be configured with=
 this
>> key via both the netlink and nfsd filesystem interfaces.
>>
>> Since key changes will break existing filehandles, the key can only be=
 set
>> once.  After it has been set any attempts to set it will return -EEXIS=
T.
>>
>> Link:
>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammer=
space.com
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>>  fs/nfsd/netlink.c                     |  5 +-
>>  fs/nfsd/netns.h                       |  2 +
>>  fs/nfsd/nfsctl.c                      | 94 ++++++++++++++++++++++++++=
+
>>  fs/nfsd/trace.h                       | 25 +++++++
>>  include/uapi/linux/nfsd_netlink.h     |  1 +
>>  6 files changed, 131 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/nfsd.yaml
>> b/Documentation/netlink/specs/nfsd.yaml
>> index badb2fe57c98..d348648033d9 100644
>> --- a/Documentation/netlink/specs/nfsd.yaml
>> +++ b/Documentation/netlink/specs/nfsd.yaml
>> @@ -81,6 +81,11 @@ attribute-sets:
>>        -
>>          name: min-threads
>>          type: u32
>> +      -
>> +        name: fh-key
>> +        type: binary
>> +        checks:
>> +            exact-len: 16
>>    -
>>      name: version
>>      attributes:
>> @@ -163,6 +168,7 @@ operations:
>>              - leasetime
>>              - scope
>>              - min-threads
>> +            - fh-key
>>      -
>>        name: threads-get
>>        doc: get the number of running threads
>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>> index 887525964451..81c943345d13 100644
>> --- a/fs/nfsd/netlink.c
>> +++ b/fs/nfsd/netlink.c
>> @@ -24,12 +24,13 @@ const struct nla_policy
>> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] =3D {
>>  };
>>
>>  /* NFSD_CMD_THREADS_SET - do */
>> -static const struct nla_policy
>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] =3D {
>> +static const struct nla_policy
>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] =3D {
>>  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
>>  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
>>  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
>>  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
>>  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
>> +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
>>  };
>>
>>  /* NFSD_CMD_VERSION_SET - do */
>> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
>>  		.cmd		=3D NFSD_CMD_THREADS_SET,
>>  		.doit		=3D nfsd_nl_threads_set_doit,
>>  		.policy		=3D nfsd_threads_set_nl_policy,
>> -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
>> +		.maxattr	=3D NFSD_A_SERVER_FH_KEY,
>>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>  	},
>>  	{
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 9fa600602658..c8ed733240a0 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/percpu-refcount.h>
>>  #include <linux/siphash.h>
>>  #include <linux/sunrpc/stats.h>
>> +#include <linux/siphash.h>
>>
>>  /* Hash tables for nfs4_clientid state */
>>  #define CLIENT_HASH_BITS                 4
>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>  	spinlock_t              local_clients_lock;
>>  	struct list_head	local_clients;
>>  #endif
>> +	siphash_key_t		*fh_key;
>>  };
>>
>>  /* Simple check to find out if a given net was properly initialized *=
/
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index 30caefb2522f..e59639efcf5c 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -49,6 +49,7 @@ enum {
>>  	NFSD_Ports,
>>  	NFSD_MaxBlkSize,
>>  	NFSD_MinThreads,
>> +	NFSD_Fh_Key,
>>  	NFSD_Filecache,
>>  	NFSD_Leasetime,
>>  	NFSD_Gracetime,
>> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file, cha=
r
>> *buf, size_t size);
>>  static ssize_t write_ports(struct file *file, char *buf, size_t size)=
;
>>  static ssize_t write_maxblksize(struct file *file, char *buf, size_t
>> size);
>>  static ssize_t write_minthreads(struct file *file, char *buf, size_t
>> size);
>> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size=
);
>>  #ifdef CONFIG_NFSD_V4
>>  static ssize_t write_leasetime(struct file *file, char *buf, size_t
>> size);
>>  static ssize_t write_gracetime(struct file *file, char *buf, size_t
>> size);
>> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *,
>> char *, size_t) =3D {
>>  	[NFSD_Ports] =3D write_ports,
>>  	[NFSD_MaxBlkSize] =3D write_maxblksize,
>>  	[NFSD_MinThreads] =3D write_minthreads,
>> +	[NFSD_Fh_Key] =3D write_fh_key,
>>  #ifdef CONFIG_NFSD_V4
>>  	[NFSD_Leasetime] =3D write_leasetime,
>>  	[NFSD_Gracetime] =3D write_gracetime,
>> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *file=
,
>> char *buf, size_t size)
>>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);=

>>  }
>>
>> +/*
>> + * write_fh_key - Set or report the current NFS filehandle key, the k=
ey
>> + * 		can only be set once, else -EEXIST because changing the key
>> + * 		will break existing filehandles.
>
> Do you really need both a /proc/fs/nfsd API and a netlink API? I
> think one or the other would be sufficient, unless you have
> something else in mind (in which case, please elaborate in the
> patch description).

Yes, some distros use one or the other.  Some try to use both!  Until you=

guys deprecate one of the interfaces I think we're stuck expanding them
both.

> Also "set once" seems to be ambiguous. Is it "set once" per NFSD
> module load, one per system boot epoch, or set once, _ever_ ?

Once per nfsd module load - I can clarify next time.

> While it's good UX safety to prevent reseting the key, there are
> going to be cases where it is both needed and safe to replace the
> FH signing key. Have you considered providing a key rotation
> mechanism or a recipe to do so?

I've considered it, but we do not need it at this point.  The key can
be replaced today by restarting the server, and you really need to know w=
hat
you're doing if you want to replace it.  Writing extra code to help someo=
ne
that knows isn't really going to help them.  If a need appears for this, =
the
work can get done.

Ben

