Return-Path: <linux-fsdevel+bounces-76856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEdBG1lhi2nDUAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:48:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372011D6B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120BE30333D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28931985B;
	Tue, 10 Feb 2026 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Pgiks8Ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021133.outbound.protection.outlook.com [40.93.194.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979E0279792;
	Tue, 10 Feb 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742022; cv=fail; b=mC3bH+ydOCc2rNXlqcnJxv+gWbEtDDEKdy7cmRyomaPVl7u7rstYl+cuYFVTdwE38a+bXDFWUVF+ubZ4Mv+1SC/vB8jmg374jwNKIybX+wV/sasL+WJq1H/Il8XJx8ebQIaM1albWy2hQmyMMlZntEMTKLq+OTQeLbZLlA7lt8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742022; c=relaxed/simple;
	bh=SpT5ObWWgjdA7EfbFyPS3SrEvlfOtd5x7vqqmVU7JKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jyi4Zu/M/2bX6MhNoxDFdg6a2bQoY+rKuqdwTcWJ41rrQ2hwPPIzlvXq3Uipk5xVUfB00oG8ZRBFq8v2Tjv9hbKaRj+xxC5QBp4Q8ff6dxzy6gSCDtrpI96x5jUJOeh89grNGNywT1omzsOuC1WJfk/66AkAgBQ13ISsq8ffG68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Pgiks8Ln; arc=fail smtp.client-ip=40.93.194.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWLq2CGvhsR/b3aLvorRlkyn5xQv4Yfs9o6KIPMSZ3VmtgeQhssodgUSDWlc6voTvgdcmkAILgVue6PWn8QzHsBmVpQ6id88Vktfsioj4GmpGIUpcUPfaXSBTWh6jWPbpdZ1sI+x4HApCcT0mhLdoR8nSsjqsgQi8RfolLcrEvBOd5ZIQw4+lAGHLkZ4hhmlCjH59x/cuPrcpfIDULrhtj30LfExnQmCNobS2Zuv6Iwy2vdS0DLLF/xrD8iQqFpLXDvlh+MBivF3XtR0d3CV+ZQyW0wWDmK7TeoxkFGb4yih9x6kgaoxFf9dQtpCGQx02JqJ/ks8mdOfSwbO0h2NrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BydVjlt2RabsCtwXLcek5X7VFknf90WOBtRTWDUw33c=;
 b=Knw0qpZILTZpwO9knVqJWTPvSZqVJamsoWoXDjeWTpQGQU78P5zWxuftZ/H0SvKNHfEOYODYnaaysAleW2Tohza630kIC0DMGaUjImpwcrPNI+CPOMme/yTc4wj10Uiw0XX5bh81dmCFAqIKxogSvx64p6mAJfy/puEkV7VZyWZ0MMy42rZNLaMs68jLZqONtQ7FhO7UidTYpykrrQrRcHPSZPp7abOloV8S4JAe4wVEtHuMREhMVsPzN8Us13QHnKyoxnof2gPn14vea7ltc5scDlOxwRrvkpKMKhlmqSNHvY+Zql9LN6X1oaw+Jc3iIhouMunQKfpBiDZMgj/qAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BydVjlt2RabsCtwXLcek5X7VFknf90WOBtRTWDUw33c=;
 b=Pgiks8LnDwryH9B3iPBj74Sz8wnyJ2ixceJSLUThQNRSHg1FIn0r7fyGh58Cp3BiRMUqu3pef9y6/HlGzMOYP1GtORrbXDN/XmMiyVVkDyDiDeVCYCl/O2sL0vpzWEybN9ELkpFLPoDmeqxliqijqoCQZe4XJbyKjT8TC0LWPGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH8PR13MB7241.namprd13.prod.outlook.com (2603:10b6:610:2c0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 16:46:57 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 16:46:56 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v5 1/3] NFSD: Add a key for signing filehandles
Date: Tue, 10 Feb 2026 11:46:53 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <D37AD3C9-A137-4E41-B34B-8ADFB1582F23@hammerspace.com>
In-Reply-To: <961be2e7-6149-4777-b324-1470b77f8696@oracle.com>
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <945449ed749872851596a58830d890a7c8b2a9c0.1770660136.git.bcodding@hammerspace.com>
 <961be2e7-6149-4777-b324-1470b77f8696@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::21) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH8PR13MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 677bffa5-2682-4052-b9cd-08de68c40059
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2fVsRu1yJ6/wBgEqhuXs1IEXli1YfsbdWw2mZSYAfyluotZ6pHGWNd9Z6Eu?=
 =?us-ascii?Q?BW4C3vFVOep2beR07j4gYA8/FAezkBqJG0ICXO2bTlqfcbaKwXnG00NFe+Gy?=
 =?us-ascii?Q?DAmEx9smFWYzHph6T/pcT7/3WCcdIS9pqUGOwhD8lndQ8XiDnD2EgChAQgOB?=
 =?us-ascii?Q?rSnpiJLa/VBXzywRYF3SwpxvwetjdYqgKcz6qG1x1zF7uw/d5tGxpqhNG9au?=
 =?us-ascii?Q?iqXOj39wmzwTGMS7reHri5fBsVnJPG84s5gW/bws3k6U4TdKEqEU/h8/Fbgq?=
 =?us-ascii?Q?Ig/offSGvRUGbJl7/CWFUiT2Wa4TX2THthpSAjiInDpNmaiA7sumzB2JtJPg?=
 =?us-ascii?Q?Z0o/6B4ggdIwk0eqHXviG1iLRle1E42oCk1SAM8exsUvEdjdn93pu9KV9/Wh?=
 =?us-ascii?Q?6vkUIoj3Nxo65XupnatYVowLo6LzjMTmWq8t3iq4MJvucek/kHf5pFkXJl1X?=
 =?us-ascii?Q?X1ErWMfOIjOtMLhYPhvpp6l2Fqxg5jYJUnIHDvm/BztdUILyNtTz70z/qYJG?=
 =?us-ascii?Q?SyLVRdnGX2iQ1NbtDEEFW5dW6jSP0y8TTbO5ADEUOjOc7Uy89dN1YighnL0l?=
 =?us-ascii?Q?PJqfhqg0DkCyebtOlgIITXJc69ZkO5VXvRsCkPXUHme6XBj6SGrULVV7VJxO?=
 =?us-ascii?Q?cg09nXr/51yzvcP8qCQXXKi5BqDoNgG1NNCmIDtnY9ANf91CA4MIQcjbq8qy?=
 =?us-ascii?Q?c9nlqU3AT9+ymZgmURcEUcadMsfNGAbMhi3wUTv3zceLKuP9yrzVJNCqPsb4?=
 =?us-ascii?Q?Ki03b3wSesQ437dKAUUCwcE3w+IOQ39UFEkbN5teEUueP3xLDR0AiiU18Ndm?=
 =?us-ascii?Q?ITQGuYl98L3wvnM4M1EASa6oSQ2JXpC4cGLcGCtySVUlXqthh1D79DheDvAd?=
 =?us-ascii?Q?btLF1/Mi0e2lFDl77cCvIdclKH8pc1kWWxnoA+50rOTaoVmLGHvU5RN2Oimh?=
 =?us-ascii?Q?G79rYCSA/jF0B5g7BKsBnuSIqbjRhloIOE+FSPrBrOAVVvgJv91zxXZp8aM9?=
 =?us-ascii?Q?+ZBLBPjLeAGx/M9QzaaKyF4QXWK30O2CmXdJzW/Acw598+Co8XZefECsnFfs?=
 =?us-ascii?Q?eoF0uUXXNV+g8Pb1gFGrmi1t+RJ/0te8l1dExa+OHTy4OgssyCBvMFTFwZ6A?=
 =?us-ascii?Q?QU9dFxm0zKSjLRxa534KanBfev6SNrmxXKxJycv+ObGjFypzea9H1RnBYJSP?=
 =?us-ascii?Q?38rgYTI74wOam8zwbGJrT+1PpunU+SjTPWcf3gdt/eDI6zep7aJo+jgFdthl?=
 =?us-ascii?Q?ISOg72BwVpgAKkq0caXKrIiEJzSRG84nnXIOfXqbyZzNHwwwURuDkOLyTW2U?=
 =?us-ascii?Q?xV+OyhYl3E/7oIcglseMlPMFNW+/ZP6ABa0DOH+t0zz6igvJPKSXMYoeCFeM?=
 =?us-ascii?Q?xO6Mh68w0Ag6UTaLOTKy4RLok37Jixm3WZZDTM8n9oOlk0bLeBuvWHvPMHg7?=
 =?us-ascii?Q?2W29kfB42b1IMoiOHV2O+iqpWK5BiEv9hBgX8SqVFGjAhkdVt61S7zoDr/Zb?=
 =?us-ascii?Q?T5kIAj/jMUqDPj9ARyX5qxaotWxC3G3eYo2aEbB4EwTnWGY/yEqxtfSSuSml?=
 =?us-ascii?Q?y6yF67ll9Pa+Xh6iRxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?icg3hWbHLnzcrz3r15/lJQ2vE2rSLDnapXG81fTMF6YM5e5fXmh4CdA/8q7h?=
 =?us-ascii?Q?aQcWP153Gue5xGHT2wrI3DMMuwmD8SHhaXQ3I1n28bGO6RbzwroJxztDKIEk?=
 =?us-ascii?Q?J4a2JEyHg/g8smAiWKOdCPpUP+AZZ56BAOegYsQ3GGJ3HZCCekwWX17OJd6z?=
 =?us-ascii?Q?KzeO4lL2nq6ogHy+01v30NgDynyu92Jnr6X7bnVbJrxd3ckcnJDqmDFrIKxz?=
 =?us-ascii?Q?HrYwEbqunm9wQ83yOjNhusNOLrLIlni51m13el4MkiN2rqriKgAL1gH40Bqx?=
 =?us-ascii?Q?qqdzewqOXJaqHUGHuGBJ1tJLZmCLVVgzVrZkQ3V+QW1Quu6YnyMEIOQmhS1X?=
 =?us-ascii?Q?yNGKFacJcZNHDnMnaVnsLrYPdICuGpyFUAsFoJPYx7lqk6JHN4bKaWdbNtOu?=
 =?us-ascii?Q?th455VlnalkazRif2BirgVPctLRHu3PancCcq/FuyYHAIk2oS/LO49H3THjm?=
 =?us-ascii?Q?G4C20SUoOIDvjO0DA/jfQxV4GY643Vw9mbycVLV5J+KyryDbOMKYNxthVjCC?=
 =?us-ascii?Q?iJJQ0+7X1NKfUw748E/44ZaETl/E2s1TeaMF/AV3Lge5wa/cBonXKrRVlPNL?=
 =?us-ascii?Q?gnOcIbn2F/TxQ9XP0DneRy5Y2jytJw8dd7r7RiUFYLoxlnpXH6lqjRtlzag2?=
 =?us-ascii?Q?/jCfgDFlJnS6t3g3v3YFtmgIDGoyFRJfr925DUlJnGq5iX1IcEy69WZ1h2K0?=
 =?us-ascii?Q?PK/A0yAGCrA85vqrZ8jdEtugW18WsPe4qGh21IbGN6B0n3hHCn+5uG6DOM1F?=
 =?us-ascii?Q?MRyCOCMY/XdwO5OdkudzuKEbila7leb9cJC8gXnzbaUHpxQvmPUvxZJYyEU2?=
 =?us-ascii?Q?6JHblDJCJcr2fKwb3W1mQqGvKFK4W5w1dm+Ys/fLzzcvhSJgWynKNy4d3Gbe?=
 =?us-ascii?Q?QF/1uEwaznezil0gtnQfbkTeLO6JIlNyQiXXASmj/2Lknm4RsYCu8UJBuKFh?=
 =?us-ascii?Q?DEjhUsSlrAyz9nUBUnfJZAzUiULkRqG9kOVlpfoA1u9wtlFeWoNweijuzF+L?=
 =?us-ascii?Q?QWGnPMKiwMdieoCWHEi9j7XONuKWYMztxlZQzGGHyyRhQ7dBjdMZ/muwtSme?=
 =?us-ascii?Q?yhph/7HF1QSOE1Ltaj2Y7vTo27H7QjF+RZreE2MaZXVhJUmZ1OMrnF+W069E?=
 =?us-ascii?Q?mbcJsehysVg6Kl283ZgSIeglDHLqNFSA/f8xRm+NvcybwBz8XShHFeuiLc9H?=
 =?us-ascii?Q?HO0V0TO+iq7xrFPYL40fOZtp9WC7Q9ZDCv98lJMpq1t96vYFWhvPWnwcQNmh?=
 =?us-ascii?Q?ObPu0P4ti5qd+yvLFuW4Zv4/9JAUM72ruw55D8SX8cq8E5tsaHwrpyRdpDeO?=
 =?us-ascii?Q?NrF33RHbx4EPCt0pmsHIP+MseGPqGw6fEuWrd2PrsInpjg0cysGrNxB4i1ca?=
 =?us-ascii?Q?IxJVA6rSaGpj/dt96AnZTctHQzJQMnbHsc+QPu85rov4VMh2N8EOEhkrbnTr?=
 =?us-ascii?Q?cHGXFQO250P/U9JLVWccUPm4Yv940tujMf9mzfVZhRGSahRgvky+BBHOn4QH?=
 =?us-ascii?Q?uMw78AChsjSBPXGrebSA4I6iha4Zp8KwcsmRy3rXE40Ly+BeoVTrDFYu9Ghk?=
 =?us-ascii?Q?63UKjUS/639d6EynNZIKY9QVPKtYO08q0wNnQye6IXuXdHWfNH1Dhg6uVBV0?=
 =?us-ascii?Q?GoUcDue9bxyFyBCV2yvMa5jLXq0P0e3ShARS5r0kdG9vJzKQbeHvY8qqM137?=
 =?us-ascii?Q?sroQ3EUom3iP8+lfEQHfG+FYnOv4uu8/Q0FX88TxcuOWa/TSfv/Qc1xeA86E?=
 =?us-ascii?Q?DQy/Bb6JXNUK4NJ1YJmDsLRon0p1Y1U=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677bffa5-2682-4052-b9cd-08de68c40059
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 16:46:56.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALqInRvQ4ZVdNfo/gQxuHpTI3L+WTi/rhne/aAK5LXXNpd6jWnvQdIwP1Pez6N2rDzSoFz88Uv6RbAfgDmwknduXkgDubTI54Ysp7o3/l8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR13MB7241
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76856-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2372011D6B8
X-Rspamd-Action: no action

On 9 Feb 2026, at 15:29, Chuck Lever wrote:

> On 2/9/26 1:09 PM, Benjamin Coddington wrote:
>> A future patch will enable NFSD to sign filehandles by appending a Mes=
sage
=2E..
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 9fa600602658..c8ed733240a0 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/percpu-refcount.h>
>>  #include <linux/siphash.h>
>>  #include <linux/sunrpc/stats.h>
>> +#include <linux/siphash.h>
>
> The added #include is a duplicate.

Quality.

>>
>>  /* Hash tables for nfs4_clientid state */
>>  #define CLIENT_HASH_BITS                 4
>> @@ -224,6 +225,7 @@ struct nfsd_net {
>>  	spinlock_t              local_clients_lock;
>>  	struct list_head	local_clients;
>>  #endif
>> +	siphash_key_t		*fh_key;
>
> I will make a note-to-self to update the field name of the other
> siphash key in this structure to match its function/purpose.
>
> As a performance note, is this field co-located in the same cache
> line(s) as other fields that are accessed by the FH management
> code?

The only other nfsd_net field is used by a rare error path in
nfsd_stats_fh_stale_inc(), a per-cpu counter.  I could try to re-arrange
things for this, risk is something else gets a bit slower.

Maybe we can optimize if needed later?

>>  };
>>
>>  /* Simple check to find out if a given net was properly initialized *=
/
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index a58eb1adac0f..36e2acf1d18b 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1571,6 +1571,32 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buf=
f *skb,
>>  	return ret;
>>  }
>>
>> +/**
>> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
>> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
>> + * @nn: nfsd_net
>> + *
>> + * Callers should hold nfsd_mutex, returns 0 on success or negative e=
rrno.
>> + */
>
> The sv_nrthreads =3D=3D 0 guard at line 1642 prevents setting the key w=
hile
> the server is running. This not only guards against spurious key
> replacement, but the implementation depends on this to prevent races
> from exposing a torn key to the FH management code. That needs to be
> documented somewhere as part of the API contract.

Ok - I'll document it right there on the function.

>> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_=
net *nn)
>> +{
>> +	siphash_key_t *fh_key =3D nn->fh_key;
>> +
>> +	if (nla_len(attr) !=3D sizeof(siphash_key_t))
>> +		return -EINVAL;
>> +
>> +	if (!fh_key) {
>> +		fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
>> +		if (!fh_key)
>> +			return -ENOMEM;
>> +		nn->fh_key =3D fh_key;
>> +	}
>> +
>> +	fh_key->key[0] =3D get_unaligned_le64(nla_data(attr));
>> +	fh_key->key[1] =3D get_unaligned_le64(nla_data(attr) + 8);
>> +	return 0;
>> +}
>> +
>>  /**
>>   * nfsd_nl_threads_set_doit - set the number of running threads
>>   * @skb: reply buffer
>> @@ -1612,7 +1638,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb=
, struct genl_info *info)
>>
>>  	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
>>  	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
>> -	    info->attrs[NFSD_A_SERVER_SCOPE]) {
>> +	    info->attrs[NFSD_A_SERVER_SCOPE] ||
>> +	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
>>  		ret =3D -EBUSY;
>>  		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
>>  			goto out_unlock;
>> @@ -1641,6 +1668,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *sk=
b, struct genl_info *info)
>>  		attr =3D info->attrs[NFSD_A_SERVER_SCOPE];
>>  		if (attr)
>>  			scope =3D nla_data(attr);
>> +
>> +		attr =3D info->attrs[NFSD_A_SERVER_FH_KEY];
>> +		if (attr) {
>> +			ret =3D nfsd_nl_fh_key_set(attr, nn);
>> +			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
>> +			if (ret)
>> +				goto out_unlock;
>> +		}
>>  	}
>>
>>  	attr =3D info->attrs[NFSD_A_SERVER_MIN_THREADS];
>> @@ -2240,6 +2275,7 @@ static __net_exit void nfsd_net_exit(struct net =
*net)
>>  {
>>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>>
>> +	kfree_sensitive(nn->fh_key);
>>  	nfsd_proc_stat_shutdown(net);
>>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>>  	nfsd_idmap_shutdown(net);
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index d1d0b0dd0545..c1a5f2fa44ab 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -2240,6 +2240,31 @@ TRACE_EVENT(nfsd_end_grace,
>>  	)
>>  );
>>
>> +TRACE_EVENT(nfsd_ctl_fh_key_set,
>> +	TP_PROTO(
>> +		const char *key,
>> +		int result
>> +	),
>> +	TP_ARGS(key, result),
>> +	TP_STRUCT__entry(
>> +		__array(unsigned char, key, 16)
>> +		__field(unsigned long, result)
>
> If the trace infrastructure isn't passing "result" to print_symbolic()
> or its brethren, then let's match its type to the "result" argument
> above: int.

Ok.

>
> But see below:
>
>
>> +		__field(bool, key_set)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->key_set =3D true;
>> +		if (!key)
>> +			__entry->key_set =3D false;
>> +		else
>> +			memcpy(__entry->key, key, 16);
>> +		__entry->result =3D result;
>> +	),
>> +	TP_printk("key=3D%s result=3D%ld",
>> +		__entry->key_set ? __print_hex_str(__entry->key, 16) : "(null)",
>> +		__entry->result
>> +	)
>> +);
>
> Not sure how I missed this before...
>
> We need to discuss the security implications of writing sensitive
> material like the server FH key to the trace log. AFAICT, no other NFSD=

> tracepoint logs cryptographic material.

I thought this could come up: consider only root can view these tracepoin=
ts,
many vulnerabilities can be exposed by tracepoint data.  The reason for i=
t:
sysadmin can absolutely verify that the key is getting set correctly to a=

expected value.  There's not a lot of other visibility in our tooling for=

this one point.

In development, its been essential to prove that userspace is doing the
hashing, that keys are changing properly when key file changes.

Let me know what you want to see here, we can hash the key again (like we=
 do
with pointer hashing), or just remove it altogether.

Ben

