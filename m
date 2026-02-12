Return-Path: <linux-fsdevel+bounces-77032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WERbCB0IjmkT+wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:04:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B4012FC8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885D53027110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E52E7635;
	Thu, 12 Feb 2026 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EZzDMEil"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020103.outbound.protection.outlook.com [52.101.46.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84C3B19F;
	Thu, 12 Feb 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915847; cv=fail; b=k5CWls078VqCP8M5vyHD3nIEZ4tF44lCakfqNwHRp8rPCaQOV98vM4nEtYAwsQ83hz/1fNM/jPAn49BwLNfdUO78pwZiHyUvbYErdeRXkTHgvyFuj6Jc83DKb+1e62dCOOgmNStNglgIIwJnZKxUyzJ+CU+MCfomf8PAi9gWH10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915847; c=relaxed/simple;
	bh=L+WDjpsnT0Ol/35+RiSgoqjp9CGUioMwrNZPo0HQ+CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzNNInM7EuhrQFKg7Q87ybJqUtPIOTsZsRzFjZZYZAoFydMZMFy/eaICWiGC1Bs2NWKM3AqwQU+wUxpcBtH2zzFZPDHth9VPpsXc0M9qaKK5E/jXHu0RW0EF0UKYSGAyFXr8jkrtZB3NOPbCf345e7fZaZ33qApzz7JyhUV5TS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EZzDMEil; arc=fail smtp.client-ip=52.101.46.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGoVhHBxWf1q3jEM9x/Tozw+n/EdMn8VnF8zdB3oN5ANNAfR10gkzFyYkpwvCUax7CyXT1Xc1cwiP9TY2GYvMPGMz5MGXF0xNHeJQEiLDxikYKqXyZfKO5HxXkvI8mwyhq228wJuNZSWzs+48JmxuIHA0v9HhR7iJSu/2x6kYMqxUTkw9g0F2AH+sHlJIPXE1PogQGGgvFYyMMn9dSL914eUiodiD7tUZunFOBgr/M4MfKodcc+BCpJgdhOPDNfSuBJPejGj4wqXCz5RNKP2FaN4+Bc8Bu8cucqL/X5BTrE+H5xRcAYT9NW8WP5tKvpWLFonQNOCUpAZohurMCcvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbLRA3NbX3uaF+A1BqpMB2eHsUrU6gSFS48NyiGQaZY=;
 b=rIZ6HR+Ev38of3HWWOknBPTa6de9VoHu7cMG+KmuMzD/m5aOqD8TektMVp5i8LcfCbnSRH0UIw6nKhkX8FwLVgaZ68HoX7jN6xxdOOgkLRpi9R969fO//+CAWYGZYIj/wnCFUtvxCDu36qQ0CTzzBkJLyJ7ztLQ+HMze5i3I3vP3xMV+KxMaNFJkHNlaiJg/OgvVaxbfWnc7PcXB+VGrFfjtcsAyg/tG7gFMrpUXuiQGDqiv7n1MDwrQmi350KHVEdJ+z5L1erPitHrLKkiCrhhQcfuE2JkBtbo/0aJQWdF3Jvu+lRJXIKAZYIda+F12PnFfyNQ+6CY3YQprncBH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbLRA3NbX3uaF+A1BqpMB2eHsUrU6gSFS48NyiGQaZY=;
 b=EZzDMEilJJMffybjkm5IhO/9LxtMKAbEsQhIrUczz6OUHSvfKQxjMMhCxuuZBqDLgctTGZDoce7KYumTu70SkgLXdj1OgBNrwr+9PMD8WIEbe4ddM99jSQowdHIC/0vuq+WwhxiNWnuITp5/bmqhpTc/civybf/pzcf5VruMyu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SJ0PR13MB6074.namprd13.prod.outlook.com (2603:10b6:a03:4d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 17:04:02 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:04:02 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH RESEND v6 0/3] kNFSD Signed Filehandles
Date: Thu, 12 Feb 2026 12:04:00 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <A5C8AD73-A8B8-4EC5-AD03-5CD16E6F2242@hammerspace.com>
In-Reply-To: <177091459809.39395.17906159035130936914.b4-ty@oracle.com>
References: <cover.1770873427.git.bcodding@hammerspace.com>
 <177091459809.39395.17906159035130936914.b4-ty@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::19) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SJ0PR13MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ff1e23-3ea8-4f85-fe7f-08de6a58b8cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8YfJtvU0aE1p/mtvcSyI83Ybn1BxzkzUoZRAB7nxab9afPkZX2OAslvUlvq?=
 =?us-ascii?Q?tYDh5w3NCAws55IQfJ0LYEDmRv5LXkGGDPoXOVV0qSChSXyhVKc0H+hW99rF?=
 =?us-ascii?Q?KFWFxthjthClMkRS+VFaG2JSlgltXeV6i01RuCQ26GacmKaB7aXDA1TMNdIG?=
 =?us-ascii?Q?sjLWFUa/lnbTH8x/boEGHTtPFBQj5tphY+dMHYRK6GmzTc3C0xplBiY+ywk7?=
 =?us-ascii?Q?Pa9JUQfYfBYieiRcOxhzk1+wUrEmsGKMeIK0UUODWfkxhPR0sHRzVjYi+jEc?=
 =?us-ascii?Q?h5HiXTuUmYhYtoBkvZhMPRiYB5gkN5T5lI7WEL9fGKgPwikerNXrvbSWeisS?=
 =?us-ascii?Q?E3HxYQWJAEehg3so3sosCsXIoV+ZWqEuSdF1byWYu+Rqw6XVFWBzyc2XtSLP?=
 =?us-ascii?Q?2+vuQ0tEiXW3c3LeavDZ6v2k6cXnv9r6tDahiUd+VW/ZU4hfAwr418NWvQSc?=
 =?us-ascii?Q?mHVeP/pPn7Y+zb1rhHL+IKavm+F6kNKMJw1WWz0y+FPZtkxTwgRasy5c5VpD?=
 =?us-ascii?Q?OulpymEUR7OdTq8pibyJxS0tDM/XBtgqNacaIiQd+z/kjOQh1S29TScxWSht?=
 =?us-ascii?Q?z4Qp40bqayAcuZydM8A/RWpc4z8UAMGxcTI0WJHZ5UuhN+HgR6GoSsvLYD+K?=
 =?us-ascii?Q?ad3EFC7WVxwPrX1i+lNty9scUg1rPt50LK+PsDsoj0UrCxWR/WMylkdXhodr?=
 =?us-ascii?Q?kibNbXF8FXyxHGiwXx5783ItO9SZMxMiT2RX36fndGnGJsM76vwh9K42nV66?=
 =?us-ascii?Q?teTXSc8QGDsGZoVU6X3n6ZMuV+1wAP8aIQ8gFHp1Y6m841aH0BBYTUpZZjl2?=
 =?us-ascii?Q?NeLa0UURPfMFSlHo2y3/AnXiMU/jVq25qeRiC2eEm9b/T6vJjakbd2GAcDDw?=
 =?us-ascii?Q?c9/PZUirqSuk9fsQba9VlA9KUzwWdq07z1jvebJZLLyjtQ+57rPf/hDjpnOG?=
 =?us-ascii?Q?H6jhs0MEhTMVhg+B7gytQkuncERFC6yKxIN/UNDBUuH0orsTZzsCv8Xg1Dw8?=
 =?us-ascii?Q?HHqUZYXQAxANj0Sufsy0NPdfovOOwKw9AwbNRe+Li1VTc4WRqjPj5xrClp05?=
 =?us-ascii?Q?Sr26tILNlfbEMdr322k6xV1gra+Cx1KfkdCbx80BQMRNX72O0X4KmSjArBSi?=
 =?us-ascii?Q?/yg0kanNMWsxfO9K7H8S2sF4E5+FJ2LA7twUniz4UCh48OnMsI1/MRxvvfuJ?=
 =?us-ascii?Q?pkfuuzPXlrwXESck4V+QjUfBATq5EVM3rP+9mx38WVjIAkHExvcLCyNTPbMq?=
 =?us-ascii?Q?6tfS83jMJLnRgv5ubdBFwdbB1OiagtAl0oBNIvf9WlTIhXgRE2x75AkPagQq?=
 =?us-ascii?Q?AfBmLyL5Xj1SIOI5yEDPd3jBjEwe4bTqPB35MmmEznx7AQ8UdIpunDuAbDUn?=
 =?us-ascii?Q?T+7Yg9HeGUQDErTWRhNY2m16ODlRkSc0X9CA4Gl3BZPdqU3TGnvqAaE8yHY6?=
 =?us-ascii?Q?rNjdSJ+z3bfz8wx3dCFunESQcyAaE55Dwtv+B8Ctm0povOvHS9z44aBWi2T9?=
 =?us-ascii?Q?Kx0HNT5QlYFkY9aphi7ZhqRRaObdO/X/UKRvyM4A5ih8OkKhCF2pkndOh65V?=
 =?us-ascii?Q?rseyjirA6pnWscu3Y1k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WJTjqRnnUDPvcykZk6eWX494JAQ4CA2kIzOwNkxAUl0ihz1N6VCq3Icyz5VB?=
 =?us-ascii?Q?H43ccxacS95ZXKJlc6ETwc2vlymx81Q08rmX8sDnnxuoebyF5hD7Y4sxIYY3?=
 =?us-ascii?Q?NkVsZKCeilbbUoqOd2nUDVPmT+BHuKaj6DGgQWa9dwKpyHOFrDyWoCOQwZA0?=
 =?us-ascii?Q?q0UzCTpDD1u2bUFfxg6Cjvpi3nzaXG1azPgfMjnu6QLCKDANnwdr+c/6etID?=
 =?us-ascii?Q?N0sLoeDwSH9Za75CAkVjXfFVXAYOc2aWCMC0o8mbqPx+voxvHv1gGmytX4Kh?=
 =?us-ascii?Q?uUqSqCHWbFlL4ED3uJvsNXNVCmZzh4+R/+XjcWdR0+A5GCTVVW9FZyiJNwKt?=
 =?us-ascii?Q?2CuqreaNiPe0ZFpUexcVVAJEdy8V+QZK00nFtJ4On0mM3bZkUYPUXNc/XvvX?=
 =?us-ascii?Q?HHarkUzDiFREaWUydQ2ftCy1J1dVB/hGB0UnnjxxNMKCvyO7Nibx1NhE/Teu?=
 =?us-ascii?Q?4GIabBqRwj4SGtE5SZVrFFbvR9Okrm4rhJ/AAyH5CTlICZ67piGVNZmbmHJ9?=
 =?us-ascii?Q?7iSa8ieP231DOpuxSzi/hm7WsIr1ohNLnMomWb29RRVMmlgWFgz4zVxV7Bwm?=
 =?us-ascii?Q?zSt3VrwBYoRG+wQEjhig5V8oFKpri6LT5ziIXnUlFbGmHrAItOpHMv9oEAnf?=
 =?us-ascii?Q?O+e7ODWPuzPvlpJe9ScE0ASOl2+nkbFyZCklx0nAB7JqVVAH1e9mYhHtQH/Z?=
 =?us-ascii?Q?EGrDHdp91/PXfAvs/fywPMWtxo/JKsGWOly3UTr7bIFRXnw1F8CkkaC347an?=
 =?us-ascii?Q?dkwu61NVQzOM+Sd5oMbZusEAzBYF3C9JF9FRaaQCx3C2Htgy3+eS1gr9x9v2?=
 =?us-ascii?Q?PMhQpzTjNDOpzHfdazytwT059jlvg1j4RSGM+j7qPPqp26EarGAjYV0XKs8Q?=
 =?us-ascii?Q?NzHLw1gXVTtFLsqVcO6llaH5giVVpxOPhV67i+A1Cr5Fm8moiqXkqTHf0cif?=
 =?us-ascii?Q?3uYFmbAMc/GL88siqy++YiAu2jigl1VTDUQrI9Jfb1d98klyp995Y2/7lscp?=
 =?us-ascii?Q?g/N1371z2WFUDDQFLSwM1Sm1392JjxouUuDGN+PSVQWJe9bWfsLh3obuZd+P?=
 =?us-ascii?Q?bl1azvfopVhnd72K+qvvXA1sFYbTP3We+c/tSZgm3GV92XlpT+E+c+HVdSQH?=
 =?us-ascii?Q?LPeGNx5SNERlD4ifp3H0ncuuQ3EkqIFC93SLBISIKJS3hjp5tbMk4MewARz/?=
 =?us-ascii?Q?KSWJf275Kfd72Y5skhUGSJgdMJIIeDUoh2pDu7eSwgAJzTonnmBpdUa4uRTP?=
 =?us-ascii?Q?BauzDQEH30cdMkyylejBlGn/oCtjJyTzYdDPTSg3nT54TNeOCVhbAbxCpNW2?=
 =?us-ascii?Q?TKR8jJSct5aD+OO99Kua/TBYLWhDyl8PLSnYfz4msMuY80GPdvgHr3qYVInQ?=
 =?us-ascii?Q?U8p59u9dkW1gUkon7JqsmSW22N/NYcO1n+ZbytmKsj+xksUzVvsRqW9ImReo?=
 =?us-ascii?Q?u4ls49ig0wc1qBos7lJIfmYUP1PcknBFhs8nwvDNGgK9ETiCkghTg2h1TTLm?=
 =?us-ascii?Q?GhhYnyPKz7knRDEH532XGvYrd9d7jE1BYUHMhMGFdWr0L3I8nsR5B1OM3v6x?=
 =?us-ascii?Q?mjwci9sdYuWdAJeL0oCyJajx4sgRPIh7hVWN475Se+LGmnJCwxtdHa13mA/d?=
 =?us-ascii?Q?SmYt79jH2eD2elzV4KQKKuUw4u7fZAQAvL6T2JAjUj7ifZ/ulGCq0sg2gSRF?=
 =?us-ascii?Q?OhW2lcRRR1iUN1lAeXkLPElkgthBhZWImrfuNDuPyvA1Vf95GglkNv/XgvxM?=
 =?us-ascii?Q?y78+vh9k+gi4s8kb/YPWdA3IBSQfbJM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ff1e23-3ea8-4f85-fe7f-08de6a58b8cc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:04:02.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h400E3g7w7rjf+dqo/3IRNRLLmL2CiUesO1C/Ra7W8SBezJc9qLZydk0n3VpH0VlOkLnUoQlWjxA2XFNHqQWNp0Q3nYFIl6biPcbabId/zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,gmail.com,oracle.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77032-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 76B4012FC8C
X-Rspamd-Action: no action

On 12 Feb 2026, at 11:44, Chuck Lever wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> On Thu, 12 Feb 2026 00:25:13 -0500, Benjamin Coddington wrote:
>> The following series enables the linux NFS server to add a Message
>> Authentication Code (MAC) to the filehandles it gives to clients.  This
>> provides additional protection to the exported filesystem against filehandle
>> guessing attacks.
>>
>> Filesystems generate their own filehandles through the export_operation
>> "encode_fh" and a filehandle provides sufficient access to open a file
>> without needing to perform a lookup.  A trusted NFS client holding a valid
>> filehandle can remotely access the corresponding file without reference to
>> access-path restrictions that might be imposed by the ancestor directories
>> or the server exports.
>>
>> [...]
>
> Applied to nfsd-testing, thanks!
>
> Cosmetic changes were made. Please review the patches in branch.

Looks good - you even noticed NLA_POLICY_EXACT_LEN(16) and trimmed out the

if (nla_len(attr) != sizeof(siphash_key_t))

Thanks for all the time you took helping this get trimmed up.

Best,
Ben

