Return-Path: <linux-fsdevel+bounces-75058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFx5GQlCcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:28:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D000B68C90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31A01300343B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62F392C49;
	Thu, 22 Jan 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PgwqMDKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020140.outbound.protection.outlook.com [52.101.85.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38EB33CEAF;
	Thu, 22 Jan 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095058; cv=fail; b=r/OR/AMHuHkuTOpGJVofFsC9rGs0s9h6hYXf3J2Kkgz8objRqEFmTyEHwdXPopmuLg1VurYeAGptqAfooQn9JTQRp+BSpc0KlTMUCbakjubbKw3BaECMhNjIxopLj6fFQU/QD7XrFLcJc0lhE6xFVUCtNUbj0QHG/MNXWXYSJDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095058; c=relaxed/simple;
	bh=/6YGpQqNtD9dPvEFcq9RknltG4CssKAp98q1IA1jf48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nlj2TP64tRJGQVOPmoYrdrwKsBJSi3wSSg93OtixtqsYsmHY1LdMnjlkemoo0FfZiPfkiX60jRzNq9aXIejWZIxIdj3uX2LFVWM8Wi5aG+Y4802iN3+6AdybO1pxGe9en+GiCZCwZPUtZ8LDpu+qzW7JFGPA+cSBh/Ikui9kfUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PgwqMDKT; arc=fail smtp.client-ip=52.101.85.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXodP2cH5wfk2xRhNCMRtE3l6ZBJLsNWEGgz6lcHiMNTCQJdoH8mRoGUcJLqHMbVhRQCCUs/x0wBoK86sWH+lIBckI8ClMSCFaqLcGzDMn9AktqrQcHl0dqZSOK2yqXlF95ph0X4gF6ogWfBbI/BUYkAlB4xHiKFpx6Hls+1gDlvhst8Hy08Pa/S/6NOZ8b9HrP96U4kh4aoTvznUAU2gUqNkWNkdRnTKiL6F0whkvRbtQSYkVlbV+iLG2PVBo565XZvtzSITlpgDR5uSUEqCg0cyRV2OJeX5BbxAM0rSVDuNdfvdhW5UVz1Tk3GjBl1McACkECUs9pqVaxJ82pWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se/K99HJ4FR0l+WW8qV+8nAdvnSAtdmTN3Rei2F3BBI=;
 b=LkfLLKcEWRM6LSYJVQoA+hH43LOgEtBYafTzEN1GL/WDXxOTHNV+BkFzCsM+xECyhLhmaJabVTrmo/jmi1yOJ9FoPtXTQaB+Pu+De2Cc3ho4sw8y9UXdzw5O7aW7bHo6eUsE5o6G4zU9Ymrmy67XVrmFBDAgW3CH52VKKA4cd4gR5I/nIAHaOg8XhaxawN6QtLNvb5aF7LFAUZPoBElR01mbARImqkOJgFsOnkFe+YD53rnPeitryqBPp3dGoU0tJD67ajLqzquD1RRUXzJ3tB8Oov1QBs8Huiv5Fyuqp5gIPIXkjsHlOH74BZy9G5FPpPZgHqijHrcUZL/179S7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se/K99HJ4FR0l+WW8qV+8nAdvnSAtdmTN3Rei2F3BBI=;
 b=PgwqMDKTih+/w+Z6eOBP+GleSoUfVgx4LYcNZYC6obTRiuo/cVJDqIxaoDxryGbx9anH18VIVG0Y4baKreNPMnlSE/LWQcz3ByQbOjDC9KgsD0W/A7si3fHIM+5Vo4X38okLtSP6B1wEInbURg/DsvlvFlAPPm5NPpyL5Jy2knE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BL3PR13MB5089.namprd13.prod.outlook.com (2603:10b6:208:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 15:17:29 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 15:17:29 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
Date: Thu, 22 Jan 2026 10:17:25 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <C0C90433-6319-4CB5-9485-A9CA87E09AFC@hammerspace.com>
In-Reply-To: <3080c6d6-4734-41e9-81a6-8ad9fc8a1061@app.fastmail.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
 <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
 <0D5F8EA8-D77E-4F56-9EA6-8D6FC2F2CD37@hammerspace.com>
 <9c5e9e07-b370-4c71-9dd6-8b6a3efe32c7@kernel.org>
 <5EBC1684-ECA5-497A-8892-9317B44186EC@hammerspace.com>
 <29aabe1c-3062-4dff-887d-805d7835912e@kernel.org>
 <DC80A9CE-C98B-4D03-889F-90F477065FB1@hammerspace.com>
 <3080c6d6-4734-41e9-81a6-8ad9fc8a1061@app.fastmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0PR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:510:4::21) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BL3PR13MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: deb7fef2-42af-43c9-4dea-08de59c95ba3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VSMsixLlB2yiBuh0Pw9zUtw0AsJkrSTgabg6HqBKQ+lHV9zBl/dsXsxADXEO?=
 =?us-ascii?Q?E2GSp3mhxitcqrhemLMWuH5vCRZyM+sqO1AHaEpMheSnmv5Os9iuQeLOMonU?=
 =?us-ascii?Q?8NrpzHbpPe6lyhn4zdPjLHkCvPv+uFhWVjtAc93uYPmuCA6JLXr+1YB8NqVT?=
 =?us-ascii?Q?6KD8EPFQf8Ifi7YA9eDf0jbA+DjZNXSuz2xrkf8k1r6IR6Uby9S57DOjSwVQ?=
 =?us-ascii?Q?qOCM4q9pTiH52sD6IKRKi21gZbjgZ9GCYehf6xXLmW9z9AuA7cli8AAfCDMP?=
 =?us-ascii?Q?rW0Aquxk9QWghWBR21rkbbQE615LWoEfRz/27WAKKog5jx0MnOuK1LfQQMkz?=
 =?us-ascii?Q?z+1VSRERh4jdGIDJu0gHj+AuPlpoclYzu6mx9XF9M4fwKwsTyo9hvcUul4om?=
 =?us-ascii?Q?AFL9PeZwTgPEWd5dXbRpgeUYeR2dvxoPqTxxotfCWuvWWOYAOpx6mgbuHEsm?=
 =?us-ascii?Q?VlRtsYkCGz0k0bZgU+75xmVzXPgxv4JtQ35xCmJ56fkydKXXdkkyGIgy7OCD?=
 =?us-ascii?Q?Eyym9A/iS5koVe6VIqgjv3153dcUkZD4hbS02M53McYYM4mdtuwWGP92CsAG?=
 =?us-ascii?Q?Qn38YgytjohF4fLExpLcvQMQmfWfoIxD3hIo7baf+Edt5M5uSGDAkSc85eu1?=
 =?us-ascii?Q?JB7BIvDrzQgCt0ySy3AQDQYjYJfxjeeFW5F5Lu0NfogMJ3zyBbl6T6sWmHOP?=
 =?us-ascii?Q?IV24a9YJKFkkdlq3MnOVTDkPl0O8wCdr/zMtP8kXd9olDKjmL5Zhj+cCrLMH?=
 =?us-ascii?Q?df/daufuMqA3uAX8vOOyTYcVT8J7GhoUgN6ozlMQidNP2r2CYJ43sHwgUQGg?=
 =?us-ascii?Q?SHCRQsKmbKDEgqeBCRDjhtPxCEgvHc4eDtnwx6VQXIwwPEhFZeq1zFxgHioR?=
 =?us-ascii?Q?kVVYkBsCvKG5JIc1oEcCWwsuYJG8FOftaILNH1PZPtRN4gI4AT4JiZFppZAb?=
 =?us-ascii?Q?Jp7sIPoNMp0o9OauYArTs38IiFDOGyGYIf4yWf0jEyKXx9K6GEUNkmE+57uo?=
 =?us-ascii?Q?Xs8gCQVmcaTR/niGOchWIjFOmmcR3JiZ8JKOf5YEjkmEse2x7vwB8cd+wipH?=
 =?us-ascii?Q?X8lBY7xPVtKSiEpGLTRIpuNoKoyybPkN5cTiQA3uHm/Ay1HTs8bJGbPYxoVR?=
 =?us-ascii?Q?OaB/720qgnjuXCOMrZUpi+QP1UINUo6CatMc8d/mBmOpmAAulUnDTNRgyRPq?=
 =?us-ascii?Q?NdRTXgVdZabHAYjUzhk4FgAzfdZvJ/i6OFnSqvKw+cEO9yxhNXcISJRxShKq?=
 =?us-ascii?Q?LBnTNhIL+cFOdaQD9Fxp8lpYJcdITuq2mmhy7XO584fd1+ypEvFowo8NruS2?=
 =?us-ascii?Q?/YNwZl+xfa15V8GYl58pVMFcN4iCbLJccktswSpTr9De5hPeqWMagGW3rWyY?=
 =?us-ascii?Q?J1Dx1BSG6REeP9Krk1mpY91+yvycMTu8jQoVOcTdKNVY8VhU1wjTstsNqWD4?=
 =?us-ascii?Q?cyxvm0kwDsIV585D4FDtBa0OcW2mZj52/8Eig82xCE/prmbFONJXGvw/9hhE?=
 =?us-ascii?Q?n5kV0qB7zMHM3I9KbxjyFJKIP2qXge4XIDAVJ8FGPPVgKH1FHfJ0aUQHUTOi?=
 =?us-ascii?Q?wweEBddmD5eX2jGk7PM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svbeAGZStVddw4GWUvuIniOVQ5jZPvMOUVMRPxurcUoMecmwo0TOjTgXl6uu?=
 =?us-ascii?Q?4i4/G4R5YdFfViu2ckgIxBQQkv+tlajC91v7Xmnsjrp8aWnuPmlmEZ/Mhh8H?=
 =?us-ascii?Q?Popx7Yx1LgaYW1iBBpuv4pnR1JGdXkar5r8AJlu64HDsLRCF+oABTPfc/F6R?=
 =?us-ascii?Q?DZrTtrRh63SuzgKTJhry99sisKQf24YKjdFZyi/292kxeZnwJWUoIJOYbsvS?=
 =?us-ascii?Q?3FdJvTkKj5HSX7WJBPDbNvMMUYK3wkMrVW0kHHZN5GnEe7IGHrUO9tX4bmCI?=
 =?us-ascii?Q?vUROf2vgpiM+lVu4L022EcodwcBdiQ0gMwd0tJiG/YIjDvM1m6jMpJR3DRRo?=
 =?us-ascii?Q?uCl5x+qZdQP/KnY3ZhzeNv4Xb2gxsdRcP6Fe8Wz3ikYLmnzsNYwjJDWRzVHH?=
 =?us-ascii?Q?0/QeOKYDIy3tMw0AKoqe7XuMrfYHZsssVcS3qeHyPYSAM2nPyXzkpHp35UkR?=
 =?us-ascii?Q?8B30huQ6Ea+dFhNyfhl5HLHBvfL1ZkLATG6VJl4eeg3eV0WW4wiaeHN78U6Z?=
 =?us-ascii?Q?SBcRYvRYuRPHU4OlxLV6BBjEHy6gITJJUg+ElfLIKFts4AfsZpYZvhvAW+Jx?=
 =?us-ascii?Q?7Yx3nyZcU+JdvdLSXEEuLI3oyUAalTRA7hJmGJmyXLS/rZKhuL+cIrkWNHCM?=
 =?us-ascii?Q?DBGNBx0TJclWMN3c5ZbHjr82cI4umGV+5onWuV4LiFt5eMZT7L+IlAEOLw36?=
 =?us-ascii?Q?6BZEg0Zn7aQR7qQQuZRQBW9Tni3jVDoehu1ALp1dPXPjNKNnpmkTCyuFKl8e?=
 =?us-ascii?Q?lp0gH9inndzrfW0kq2MjJD0j8Cuj9C+NiPbzWWPh3xosiG56/Lij5fxBJG4g?=
 =?us-ascii?Q?5Rdg8ZmdgzEZFZ5w/x29EnboiBjp+CsRga2CK1ipZNwDOG6CKWkecb2NkX8N?=
 =?us-ascii?Q?aSQU/V9A1JTcCPtecXVog8Qm8WWi9hKoGD94SBU8xkdJl90xqnahG56HWLB9?=
 =?us-ascii?Q?DB4QhTNdkmsUc+jb8idevt5Vd5rCjfE1iAnpZobfYiB5TDiwt3wIbKXtR8Hl?=
 =?us-ascii?Q?paIldBDBRdg/uqGzd90cDqj1BRo3womuUYk9w4H8xC95+y4KjX+O4tgIWE+K?=
 =?us-ascii?Q?PNcOUc5NiQyne7TAD9gNXZYLCH8KgKlvGOElCqRpBh5HqZOYkKJk6xrZV7Ui?=
 =?us-ascii?Q?228VRl1xS1JoymkSyDknQi4jvumR+rbWwhA80hM2F+oEQ9DA+GyPTyvBEnf6?=
 =?us-ascii?Q?4QkqEbLlO5LVdF0wpQNYuk2YhROSp38JD835LjPpUgmorC2kh4Ytgw3AHOD4?=
 =?us-ascii?Q?IeK01wkXDQyRmHLm5rmNOvH/MRhpL9wJgnmmZBXpMJX8SWZZ2vkSSTy7JRDY?=
 =?us-ascii?Q?e/yZ1BrfMWDEmbPKZdjRJD7rUIom0XKxaiNRiPz9Jw1hLwg3mZqvvBH6a+Nz?=
 =?us-ascii?Q?cZvcHCUvQsGgBJHkhxG+qf5iLDPqdGMdTBgQj0avfFLRXvbTPtxLfAXGiLg7?=
 =?us-ascii?Q?pVouaXil38EszP9EjZXTDllLcP4FwnbgS7RASoGHpx8iMTipfvgEdiZTZAji?=
 =?us-ascii?Q?MQLVd86YETFRl4iPvhmMr7W3Sv2r5rd4G4VPVjJkkY0ngx8G8rXRFGGKdL70?=
 =?us-ascii?Q?slrswoAovjil0oJyulOeyO5dnVe/OeMZ+b1D/ebJdfG7MtdMjNKvq+enuWlf?=
 =?us-ascii?Q?iCYI+7yqOGo2rWl6+248WyDiVJgsUQ46c+6HpKKrUDQZKFsXkDrH5wa+AOhF?=
 =?us-ascii?Q?hWDKt+yJ0RTWe7SOkAlOuiTgUu8ern7wfXO72qK5Yge/VGQbdiTYboyWDCdo?=
 =?us-ascii?Q?nAY2lz+hzACJtOs8qDyJpbC/M+nyv+c=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb7fef2-42af-43c9-4dea-08de59c95ba3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:17:29.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjHvhyuA2hCTQw6YDAyun22Y0aU+FxVtE2FN0Z5MR0NPEAfmsY0wKCfOv6OhhsJBG8v02waWX/AFxo3hGxEhjYjsSWNa98P8Z0d1OaUQCm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5089
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
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75058-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D000B68C90
X-Rspamd-Action: no action

On 22 Jan 2026, at 9:49, Chuck Lever wrote:

> On Wed, Jan 21, 2026, at 8:22 PM, Benjamin Coddington wrote:
>> On 21 Jan 2026, at 18:55, Chuck Lever wrote:
>>
>>> On 1/21/26 5:56 PM, Benjamin Coddington wrote:
>>>> On 21 Jan 2026, at 17:17, Chuck Lever wrote:
>>>>
>>>>> On 1/21/26 3:54 PM, Benjamin Coddington wrote:
>>>>>> On 21 Jan 2026, at 15:43, Chuck Lever wrote:
>>>>>>
>>>>>>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>>>>>>>> A future patch will enable NFSD to sign filehandles by appending=
 a Message
>>>>>>>> Authentication Code(MAC).  To do this, NFSD requires a secret 12=
8-bit key
>>>>>>>> that can persist across reboots.  A persisted key allows the ser=
ver to
>>>>>>>> accept filehandles after a restart.  Enable NFSD to be configure=
d with this
>>>>>>>> key via both the netlink and nfsd filesystem interfaces.
>>>>>>>>
>>>>>>>> Since key changes will break existing filehandles, the key can o=
nly be set
>>>>>>>> once.  After it has been set any attempts to set it will return =
-EEXIST.
>>>>>>>>
>>>>>>>> Link:
>>>>>>>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@=
hammerspace.com
>>>>>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>>>>>> ---
>>>>>>>>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>>>>>>>>  fs/nfsd/netlink.c                     |  5 +-
>>>>>>>>  fs/nfsd/netns.h                       |  2 +
>>>>>>>>  fs/nfsd/nfsctl.c                      | 94 ++++++++++++++++++++=
+++++++
>>>>>>>>  fs/nfsd/trace.h                       | 25 +++++++
>>>>>>>>  include/uapi/linux/nfsd_netlink.h     |  1 +
>>>>>>>>  6 files changed, 131 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/netlink/specs/nfsd.yaml
>>>>>>>> b/Documentation/netlink/specs/nfsd.yaml
>>>>>>>> index badb2fe57c98..d348648033d9 100644
>>>>>>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>>>>>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>>>>>>> @@ -81,6 +81,11 @@ attribute-sets:
>>>>>>>>        -
>>>>>>>>          name: min-threads
>>>>>>>>          type: u32
>>>>>>>> +      -
>>>>>>>> +        name: fh-key
>>>>>>>> +        type: binary
>>>>>>>> +        checks:
>>>>>>>> +            exact-len: 16
>>>>>>>>    -
>>>>>>>>      name: version
>>>>>>>>      attributes:
>>>>>>>> @@ -163,6 +168,7 @@ operations:
>>>>>>>>              - leasetime
>>>>>>>>              - scope
>>>>>>>>              - min-threads
>>>>>>>> +            - fh-key
>>>>>>>>      -
>>>>>>>>        name: threads-get
>>>>>>>>        doc: get the number of running threads
>>>>>>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>>>>>>> index 887525964451..81c943345d13 100644
>>>>>>>> --- a/fs/nfsd/netlink.c
>>>>>>>> +++ b/fs/nfsd/netlink.c
>>>>>>>> @@ -24,12 +24,13 @@ const struct nla_policy
>>>>>>>> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] =3D {
>>>>>>>>  };
>>>>>>>>
>>>>>>>>  /* NFSD_CMD_THREADS_SET - do */
>>>>>>>> -static const struct nla_policy
>>>>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] =3D {
>>>>>>>> +static const struct nla_policy
>>>>>>>> nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] =3D {
>>>>>>>>  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
>>>>>>>>  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
>>>>>>>>  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
>>>>>>>>  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
>>>>>>>>  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
>>>>>>>> +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
>>>>>>>>  };
>>>>>>>>
>>>>>>>>  /* NFSD_CMD_VERSION_SET - do */
>>>>>>>> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops=
[] =3D {
>>>>>>>>  		.cmd		=3D NFSD_CMD_THREADS_SET,
>>>>>>>>  		.doit		=3D nfsd_nl_threads_set_doit,
>>>>>>>>  		.policy		=3D nfsd_threads_set_nl_policy,
>>>>>>>> -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
>>>>>>>> +		.maxattr	=3D NFSD_A_SERVER_FH_KEY,
>>>>>>>>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>>>>>  	},
>>>>>>>>  	{
>>>>>>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>>>>>>> index 9fa600602658..c8ed733240a0 100644
>>>>>>>> --- a/fs/nfsd/netns.h
>>>>>>>> +++ b/fs/nfsd/netns.h
>>>>>>>> @@ -16,6 +16,7 @@
>>>>>>>>  #include <linux/percpu-refcount.h>
>>>>>>>>  #include <linux/siphash.h>
>>>>>>>>  #include <linux/sunrpc/stats.h>
>>>>>>>> +#include <linux/siphash.h>
>>>>>>>>
>>>>>>>>  /* Hash tables for nfs4_clientid state */
>>>>>>>>  #define CLIENT_HASH_BITS                 4
>>>>>>>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>>>>>>>  	spinlock_t              local_clients_lock;
>>>>>>>>  	struct list_head	local_clients;
>>>>>>>>  #endif
>>>>>>>> +	siphash_key_t		*fh_key;
>>>>>>>>  };
>>>>>>>>
>>>>>>>>  /* Simple check to find out if a given net was properly initial=
ized */
>>>>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>>>>> index 30caefb2522f..e59639efcf5c 100644
>>>>>>>> --- a/fs/nfsd/nfsctl.c
>>>>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>>>>> @@ -49,6 +49,7 @@ enum {
>>>>>>>>  	NFSD_Ports,
>>>>>>>>  	NFSD_MaxBlkSize,
>>>>>>>>  	NFSD_MinThreads,
>>>>>>>> +	NFSD_Fh_Key,
>>>>>>>>  	NFSD_Filecache,
>>>>>>>>  	NFSD_Leasetime,
>>>>>>>>  	NFSD_Gracetime,
>>>>>>>> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *fil=
e, char
>>>>>>>> *buf, size_t size);
>>>>>>>>  static ssize_t write_ports(struct file *file, char *buf, size_t=
 size);
>>>>>>>>  static ssize_t write_maxblksize(struct file *file, char *buf, s=
ize_t
>>>>>>>> size);
>>>>>>>>  static ssize_t write_minthreads(struct file *file, char *buf, s=
ize_t
>>>>>>>> size);
>>>>>>>> +static ssize_t write_fh_key(struct file *file, char *buf, size_=
t size);
>>>>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>>>>  static ssize_t write_leasetime(struct file *file, char *buf, si=
ze_t
>>>>>>>> size);
>>>>>>>>  static ssize_t write_gracetime(struct file *file, char *buf, si=
ze_t
>>>>>>>> size);
>>>>>>>> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file=
 *,
>>>>>>>> char *, size_t) =3D {
>>>>>>>>  	[NFSD_Ports] =3D write_ports,
>>>>>>>>  	[NFSD_MaxBlkSize] =3D write_maxblksize,
>>>>>>>>  	[NFSD_MinThreads] =3D write_minthreads,
>>>>>>>> +	[NFSD_Fh_Key] =3D write_fh_key,
>>>>>>>>  #ifdef CONFIG_NFSD_V4
>>>>>>>>  	[NFSD_Leasetime] =3D write_leasetime,
>>>>>>>>  	[NFSD_Gracetime] =3D write_gracetime,
>>>>>>>> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file=
 *file,
>>>>>>>> char *buf, size_t size)
>>>>>>>>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthr=
eads);
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * write_fh_key - Set or report the current NFS filehandle key,=
 the key
>>>>>>>> + * 		can only be set once, else -EEXIST because changing the ke=
y
>>>>>>>> + * 		will break existing filehandles.
>>>>>>>
>>>>>>> Do you really need both a /proc/fs/nfsd API and a netlink API? I
>>>>>>> think one or the other would be sufficient, unless you have
>>>>>>> something else in mind (in which case, please elaborate in the
>>>>>>> patch description).
>>>>>>
>>>>>> Yes, some distros use one or the other.  Some try to use both!  Un=
til you
>>>>>> guys deprecate one of the interfaces I think we're stuck expanding=
 them
>>>>>> both.
>>>>>
>>>>> Neil has said he wants to keep /proc/fs/nfsd rather indefinitely, a=
nd
>>>>> we have publicly stated we will add only to netlink unless it's
>>>>> unavoidable. I prefer not growing the legacy API.
>>>>
>>>> Having both is more complete, and doesn't introduce any conflicts or=

>>>> problems.
>>>
>>> That doesn't tell me why you need it. It just says you want things to=

>>> be "tidy".
>>>
>>>
>>>>> We generally don't backport new features like this one to stable
>>>>> kernels, so IMO tucking this into only netlink is defensible.
>>>>
>>>> Why only netlink for this one besides your preference?
>>>
>>> You might be channeling one of your kids there.
>>
>> That's unnecessary.
>
> Is it? There's no point in asking that question other than as the
> kind of jab a kid makes when trying to catch a parent in a
> contradiction (which is exactly what you continue with below).

Wow, yes.  It's personal, and unprofessional. It has nothing to do with t=
he
merits of the argument at hand.

I'm not trying to catch you in a contradiction Chuck.  You stated it was
your preference, and your reasons had (IMO) a valid counter-argument.

> It doesn't make a difference whether it's my preference or not, and
> frankly, as a contributor, it's not your role to decide whether an
> interface goes in procfs or not.

It does make a difference, because this is community software.

I'm not trying to decide, I'm responding to your words and actions.  I wa=
s
having trouble resolving your desire to make sure the server is never
started w/o a key, while you also ask to remove an interface that can cre=
ate
exactly that situation.

> Don't argue with me.

Got it - I'm really sad to read this.

> Just answer my questions. All I'm asking here is why are you adding it.=


You got it, I'm trying to do that.  Let's take it down a notch.

>>> As I stated before: we have said we don't want to continue adding
>>> new APIs to procfs. It's not just NFSD that prefers this, it's a long=

>>> term project across the kernel. If you have a clear technical reason
>>> that a new procfs API is needed, let's hear it.
>>
>> You've just added one to your nfsd-testing branch two weeks ago that y=
ou
>> asked me to rebase onto.
>
> Sorry for being human. Sometimes I don't notice things. That one doesn'=
t
> belong there either. But each one of these is decided on a case-by-case=

> basis. It's not appropriate for you to compare your procfs addition to
> any other as a basis for "permission to add the API".

No need to apologize, it's just confusing.  I have a right to point it ou=
t.

> Again, this is argumentative, not constructive. You're not answering
> a direct question from a reviewer/maintainer. What is the reason you
> need this API?

Sorry - I am making a best effort trying to do that.  When I see you writ=
e
"I prefer not growing the legacy API" right after you grew the legacy API=
 it
creates dissonance, so I'm pointing it out.  Which is good apparently,
because now you'll have more of what you want.

>>>> There's a very good reason for both interfaces - there's been no wor=
k to
>>>> deprecate the old interface or co-ordination with distros to ensure =
they
>>>> have fully adopted the netlink interface.  Up until now new features=
 have
>>>> been added to both interfaces.
>>>
>>> I'm not seeing how this is a strong and specific argument for includi=
ng
>>> a procfs version of this specific interface. It's still saying "tidy"=
 to
>>> me and not explaining why we must have the extra clutter.
>>>
>>> An example of a strong technical reason would be "We have legacy user=

>>> space applications that expect to find this API in procfs."
>>
>> The systemd startup for the nfs-server in RHEL falls back to rpc.nfsd =
on
>> nfsdctl failure.  Without the additional interface you can have system=
s that
>> start the nfs-server via rpc.nfsd without setting the key - exactly th=
e
>> situation you're so adamant should never happen in your below argument=
=2E.
>
> If your intention is to get distributions to backport signed FHs
> to kernels that do not have the NFSD netlink interface, you need
> to have stated that up front. That is the rationale I'm looking
> for here, and I really should not have to work this hard getting
> that answer from you.

I'm doing my best, I understand you're unhappy with me.

> I might have deleted this while editing my reply yesterday, but
> as a policy, LTS kernels do not get new features like this. So
> it was never my intention to plan to target upstream backports
> for this feature.
>
> If this is part of your vision for this feature, you will need
> to make a similar case to the stable@ folks.

We'll probably work with what we can from what you've decided you want.

As I've already let Jeff know - I'll remove that interface on the next
posting.

Ben

