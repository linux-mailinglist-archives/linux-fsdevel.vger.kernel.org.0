Return-Path: <linux-fsdevel+bounces-76597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAueGXUUhmk1JgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:19:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E56100290
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEED83042279
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F833311C3B;
	Fri,  6 Feb 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ONEWq8tQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022095.outbound.protection.outlook.com [52.101.53.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF129A309;
	Fri,  6 Feb 2026 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394447; cv=fail; b=hhTbdKxKPR8ug3SnBHUe5UplL4MnzolmqFs8m7v5WP3X2UtRQMffFAqK5wTn/SEvEjw6oOWP1Iwx2Q1HOKblzTP31L1oNWxryt9zdqG6/U7N29zis8XBmbpFY/LamuaypjC5CabBrMaU+W7aVuLrrxA22QVu2Z7EtP1QKzbq9nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394447; c=relaxed/simple;
	bh=6aQ6j5vG/9sC9jGYwacrHN7kAmJsIsJpIGqDRX9dp/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7IEB5mQnuau3uhFkw0ft/GHR/L9V+/jbx6m3vrY59jdusPnSSWRTyURwbjGEh36JHCK8WD3DpjMVUc/rVwv871FVxouUs0HC4t9s+ZEBOve4V/sFhk2dZUGPnADCZJ85krz9JVRS24EyGmsh+1iuH0kf6+sHXJX2QcUlygeRgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ONEWq8tQ; arc=fail smtp.client-ip=52.101.53.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ht+suTnuOc95OgLBGrGT20stztxKWCXpzvpUFi1aZyK4O1cBS/FYwktOp/4lwcmqaiOX+5u7rhcft92QtcTPeUnwFE6XsWaOi5DOfnehn+zmsQJ7Ve1Rx+qM0Uwyf3lxP9l2ZgSsMtLcHIfIAVgUresCDlfxh6f4REe6h/5wkzequbei/mego9QRheEUaNTkCTKl+UWLkQ2Vnc97FBTv1a6ilyC6VbMbLpgXVSgHdK2Dx6/T8EG8wDCwyZNIvtksSFX/t8903OLUQPLoUz99NisvOaFEaZ0mP88WgcqZnaaePqrYXW9/bL0pD6oHcQyZIkRpvaAyBkEf75AraTx0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JilrliX07AMmaSDz8gxFR/tG0/4r64PJpBF+M7Y9FE=;
 b=xUu056jZILBWMpLnWR3Ki1MFoTi4jCkxpjOOqVkd/14jlPeldf+fkLyUXnWJXaOM3D8GtVD2Zlj3GjNJ1JLmw6Fq2/yg119bWvtgMOZoMm+nVFENrUAaowhsFtB1lnmD4BLYK4MgN7n8mK9fRZ5TfFa5HyeecrQ4YzD9i9YpzUY9F1xm+R7vz3ql+uPKu6dDJIeHvENIMZ1TKq6ByxpXx/zikju8+7sfQHUprExGDnQzy6t+0LMI97VQd4UJMTLB53DpJOiPFwLARUcI3yPuwMbnGOgInOggXb97M5tqSP/rYG7ETjB18inPhKA69aibAWCWIPWFezODBHaGmxGKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JilrliX07AMmaSDz8gxFR/tG0/4r64PJpBF+M7Y9FE=;
 b=ONEWq8tQPiAEnCOw/28PtreatvRc8UaDYM53IF8OldmMexRjCcl2R6sVp5/EpxU9Nsgz10fbVGhBvVtGcsZN1IeQFGJzROJbXm9EE2OZs+w4272SN0G/IlRm4vre5GpgfMqOU+cnqCnwQhewg8EP3eJfmEEMS3xvrzWxMmBtJkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BY3PR13MB4961.namprd13.prod.outlook.com (2603:10b6:a03:36d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 16:14:03 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 16:14:03 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>,
 Benjamin Coddington <bcodding@hammerspace.com>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>
Cc: <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] NFSD: Add a key for signing filehandles
Date: Fri, 06 Feb 2026 11:13:59 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <5CA11182-7225-4DFC-986D-70710E1A19F2@hammerspace.com>
In-Reply-To: <09698b80d78c7c0a8709967f0f3cf103b3ddad9d.1770390036.git.bcodding@hammerspace.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
 <09698b80d78c7c0a8709967f0f3cf103b3ddad9d.1770390036.git.bcodding@hammerspace.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::6) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BY3PR13MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8576f7-299e-4967-08cf-08de659abeeb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nr11+9jffmqC0S2jlWq2PSMJSQYVtuHdMPjSdqj8IcyY6/S3gi+8ie4LumPX?=
 =?us-ascii?Q?hM9lt1T9FP1EPUlbJIagvyA+DQ4buJ8ePcg20PeqjkZOTGhLSujAstdbGPIG?=
 =?us-ascii?Q?WatlK53y1r0YYY4fZfTmCx6rmUgTjr1si9p0mRtgO+yd16HKVHplFtPUvs9i?=
 =?us-ascii?Q?/odTQyjJWzVF+Um/daLvZO98OmdimDEjxrJMblxSx3r3GNa+IrBvgUr1z5TX?=
 =?us-ascii?Q?SZwbzM7idBS/NkLc0sjXb9tX5FkzTjyrykEf/thklKby1keYvOujPZTayJAd?=
 =?us-ascii?Q?rQsGpjpMtbmEzCUT07OtdFzFYivDmaswSUBPD3IdnvyEo03q3x+O/ZyUUCQ/?=
 =?us-ascii?Q?o+u5/BXk3QULMPhz5TI3gqoLDIyF90t6LNIr8WrGn9dptnzdUsiFNF/nZYm6?=
 =?us-ascii?Q?de04HaY2qe0PhdPAXY0FwY4r5ykASOBA3o0uRfWQTjWP79e/bTbIrQkqypx1?=
 =?us-ascii?Q?JbhTVSWXJpVo2vhMwP/CrN5tfSEbobkSPZ0KvrQnR2uKJid/lQdPkYS9DP8k?=
 =?us-ascii?Q?WU6zzm2IIGdb9FApjRffo+qpkYN4Yhq8025+vtND6VRyjbxd9IoyysL+cbUQ?=
 =?us-ascii?Q?GK7UY5uWznYOmhhMHvg5KCx5s1uJGVp6he5/r8NrmUkBcmEzLcVi4WONPINN?=
 =?us-ascii?Q?InWY5w7n9RWQ0BYdIjR3Z1ahZ0wTMx02OWR8cbRMfgeuZV5Lj0ook/yPpe/z?=
 =?us-ascii?Q?ymc2muyGUtgLz1zL1Adcgy6FObrLoGF60Gf4gPjhynXoKXQfZPEv5L5Mpl76?=
 =?us-ascii?Q?BA/3ILctzWfBoEtMaSGkHYAXiZKtMu+WnecIC/28m/HUsm4RZhnf++TJVoVF?=
 =?us-ascii?Q?pVCjw+EtyOaaVbxkZvIMsMdrFKKbIcvo2YThf/QOgMKWyCTkQNMJGqY0Lvtp?=
 =?us-ascii?Q?ErSz+rGKkKwc7FS5rmNzVqPk5cYXD0oAPCfLORlmQVhdMRz7NsTuFEa5NUL2?=
 =?us-ascii?Q?mkudjpOA65/4YQzw9mz6+KW/9W37X45X885UZO2FMPeyQUMP4RuI0WOJjFSz?=
 =?us-ascii?Q?PzgxJoFR0vzCn2i/2+4WxWKSGLvF1gAepUK14hryj9h4Pt2uS49uXL8QLNEO?=
 =?us-ascii?Q?1plgCBVQJmznTHotTOjdi6/hoquPoZ3rNmZqdgRFNbHUFeaxPqW90270fmZC?=
 =?us-ascii?Q?x51xeBTdYzMsXZfKMvwdHEy+5wXacQwdeUmc690bDvTHYhl/TcIisbJa/8Dh?=
 =?us-ascii?Q?+pg+GAE/rbkorHMQ32OX0DwBvWgGrqSmfK9cjuMbcXyP+oIfSssxHkFIHrqR?=
 =?us-ascii?Q?VQ4m9n2/rgiLS4YL0N5E+arIQrsDKEyFOG2RcAoMe7LWun43Y4CuhZx8BbdN?=
 =?us-ascii?Q?lsj+q73oiIES00WdaG6AOEZ8HYSCjOsAP8T18Uksl5nzp4oWRhDgyJbARbG6?=
 =?us-ascii?Q?7FjdpayZfgMv11v6bWGUZ2qAAVL/hMSAp/Gs8jc1x0xCWnz8ujYcs77VBpbJ?=
 =?us-ascii?Q?irk86I8hVZlKbIYLfvxsg89ThSeVFkmQgQg1LWne/DyQNDfdxwhkU/QcOmxX?=
 =?us-ascii?Q?+LILiIIOqTdsfRpM9K1ssPaIlfsEEIWlvYXjcF+7FbfrPfzFK6uowDfwo+Zx?=
 =?us-ascii?Q?xJrKKVO7iIV9KLiuJiyKaQlaND/RT/Ek95KIpnlT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFo63m8kcGtsOC8hZKC5jW+jhWsMFb/vSZaIqJ7Z0rSxhTVO1rzD417vYfIH?=
 =?us-ascii?Q?nztt35GfMYESDWBsk/VVKVsdAmhFbdCaJ5alCsr9AfE0u0qJd19JIIl1SxJA?=
 =?us-ascii?Q?LHr1LN9yq+7w0HtJxx+8OmrnC/SpxXAQi8/FbaoJm04Y8eUx7E4mJuIn2u/K?=
 =?us-ascii?Q?uLECGca1ROMNbBWuZi2cI5OmPv8Jlp9RNaTZdBo9Onak0G13dCh6faBZtxy7?=
 =?us-ascii?Q?5BXCIWmq3EyGvHjS70r9U42NR7pkC9nfwCU1LOeb+df7slIhdwJLohhkgL39?=
 =?us-ascii?Q?aK27+2J5hgOwTdvfGH9cIVA8PhO8kkg4HPmtVS6nGWfp+qvj/w8cUETEwJQ6?=
 =?us-ascii?Q?XDuWCOkC3TsmI3ohTgYIkWMIqIZTHnxBO3s967m6p8xtA0SIqM94ryaeE1/3?=
 =?us-ascii?Q?+v8Qn/WyHd0Al/Mf0LJ+RsJwHq9c4J3Yv3jyINlO+zGYlnw52+SleF0hg72s?=
 =?us-ascii?Q?PQmJ2Og1n+BMZr4jfz7ViTq84O75FH9Cx/f8HKFLSKqJGLCPKpBkqn8UZ/SS?=
 =?us-ascii?Q?TWf3DrzZeHELN7A5rpzhgevX7eA1ODHR/RAmIUFS3Y6ENA4oXaiGSCAQ95UX?=
 =?us-ascii?Q?szSYkFfsb9GVVgJahUJor8j/p/hj9NbL1PQsG8MrfC1FsBrwG3ocf48SOs5H?=
 =?us-ascii?Q?1kZQvD6AniKAfP9dvwai++OQSqqhaWMAYLaGO4mQx263ANC8YlL+nHP2Gksz?=
 =?us-ascii?Q?O4rqcV/OUrjuUTAkreACN86N/pg+8kLuiArYCOkdYUGsWqCzJOIzr5bkGIWl?=
 =?us-ascii?Q?/pjlcxteajIlJEqz+wnyO/QYQJmgUzuv8H4mQIKyzI50dQbcsgRixUK0BG9i?=
 =?us-ascii?Q?zfh/kVhJNrClUDcVYWmRq3Uw3AfBi/u+WoPxoDsT4X8Q1Qaoz+Ofd1uNIKdO?=
 =?us-ascii?Q?tfAh0a1SsSszNUrnU3nwnNKj9PQu7aoGgN0OACSps/7coLq+4FV2to0FWkvq?=
 =?us-ascii?Q?cd1l5xPVsG4SK+uWjvDncx7IdCyuvbDAazyslT9ivmtGCYGaBcvpIlLipLlS?=
 =?us-ascii?Q?hBIQCPz8FdsW4RRCwmjH0MFiBjwG8hPeRX9QATAWeGlsGoaLZOfa/sLq40j4?=
 =?us-ascii?Q?Cn5p30W74omtH2k65MIMt/NalZbGrhygrDIRccSw/Ww5oLKOUDUMOd6yXvQk?=
 =?us-ascii?Q?HutE1NBEnpPcc0PvNlFN6t4lKoyde8QN1cZrIogeRbFJO5Af5IR4KfueO394?=
 =?us-ascii?Q?4O6ZFK1vPYTAGAFHszpF3kW2emMr0/Tle9V93MvUzUuODxw4Mt24WVAu78rN?=
 =?us-ascii?Q?Yash30BrHEiES+M2Y0qQl6dzxYweolMGWaIKsDGdqmPZcWGtzaTCNNTp44C6?=
 =?us-ascii?Q?rT7jhZMjceyWv3abOD/fbUgu3Q4SE+s76dw6LYk84u1NZiCDts0HE58LHgaA?=
 =?us-ascii?Q?H/lniB25hS0Hjg/8ZOfhiOhOgTwP+D5lK0emNuiS3QbbwIqNX4C+9LYBqf2h?=
 =?us-ascii?Q?vwSpWC24AqIX+j04mhyGGxmwYs8AAQkAahsuUKRkIq6qb/a7i+AWG2iQC9B4?=
 =?us-ascii?Q?50HEWhKURcsi7h2uOPnDFIczz42my7KCvX3Au6JAmTs9sl/ZufLT6BI0pH7Q?=
 =?us-ascii?Q?Nmr6JwCO5BorKf5BzZMrm2OV/JmN3+AFwd+4BpdNJuqFCFGfY4lZe9yAUMnj?=
 =?us-ascii?Q?Nb1YJNU/nFVJEZn2pWNbUs1qep+d1BD7unrM/qdn8pvaZ2S61TvnufMxofXp?=
 =?us-ascii?Q?61HN36zx1ty0cy+MIlCwxUZf4gHTlb6LqHxyU5Ojhdf2eL36TByhLudkqVLC?=
 =?us-ascii?Q?mARlsXDHAhD/IsidTf3W1tmHUv3fX8g=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8576f7-299e-4967-08cf-08de659abeeb
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 16:14:03.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVacqRil+52NDCUAZxrsaPJUgLNbUA8zxVJFNTzCORQLj2qpbwko0lNK7YAICi6JpKRwfW3sSMSK6FQFHHCoo4+N3bNXusT17CXH9lxBO+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4961
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76597-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3E56100290
X-Rspamd-Action: no action

On 6 Feb 2026, at 10:09, Benjamin Coddington wrote:

> A future patch will enable NFSD to sign filehandles by appending a Mess=
age
> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit k=
ey
> that can persist across reboots.  A persisted key allows the server to
> accept filehandles after a restart.  Enable NFSD to be configured with =
this
> key the netlink interface.
>
> Link: https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@h=
ammerspace.com
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  6 +++++
>  fs/nfsd/netlink.c                     |  5 ++--
>  fs/nfsd/netns.h                       |  2 ++
>  fs/nfsd/nfsctl.c                      | 37 ++++++++++++++++++++++++++-=

>  fs/nfsd/trace.h                       | 25 ++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  1 +
>  6 files changed, 73 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
> index f87b5a05e5e9..8ab43c8253b2 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -81,6 +81,11 @@ attribute-sets:
>        -
>          name: min-threads
>          type: u32
> +      -
> +        name: fh-key
> +        type: binary
> +        checks:
> +            exact-len: 16
>    -
>      name: version
>      attributes:
> @@ -163,6 +168,7 @@ operations:
>              - leasetime
>              - scope
>              - min-threads
> +            - fh-key
>      -
>        name: threads-get
>        doc: get the maximum number of running threads
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 887525964451..4e08c1a6b394 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD=
_A_VERSION_ENABLED + 1] =3D {
>  };
>
>  /* NFSD_CMD_THREADS_SET - do */
> -static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_MIN_THREADS + 1] =3D {
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_FH_KEY + 1] =3D {
>  	[NFSD_A_SERVER_THREADS] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_GRACETIME] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_LEASETIME] =3D { .type =3D NLA_U32, },
>  	[NFSD_A_SERVER_SCOPE] =3D { .type =3D NLA_NUL_STRING, },
>  	[NFSD_A_SERVER_MIN_THREADS] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_SERVER_FH_KEY] =3D NLA_POLICY_EXACT_LEN(16),
>  };
>
>  /* NFSD_CMD_VERSION_SET - do */
> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D =
{
>  		.cmd		=3D NFSD_CMD_THREADS_SET,
>  		.doit		=3D nfsd_nl_threads_set_doit,
>  		.policy		=3D nfsd_threads_set_nl_policy,
> -		.maxattr	=3D NFSD_A_SERVER_MIN_THREADS,
> +		.maxattr	=3D NFSD_A_SERVER_MAX,
>  		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 9fa600602658..c8ed733240a0 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -16,6 +16,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
> +#include <linux/siphash.h>
>
>  /* Hash tables for nfs4_clientid state */
>  #define CLIENT_HASH_BITS                 4
> @@ -224,6 +225,7 @@ struct nfsd_net {
>  	spinlock_t              local_clients_lock;
>  	struct list_head	local_clients;
>  #endif
> +	siphash_key_t		*fh_key;
>  };
>
>  /* Simple check to find out if a given net was properly initialized */=

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index a58eb1adac0f..55af3e403750 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff=
 *skb,
>  	return ret;
>  }
>
> +/**
> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
> + * @nn: nfsd_net
> + *
> + * Callers should hold nfsd_mutex, returns 0 on success or negative er=
rno.
> + */
> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_n=
et *nn)
> +{
> +	siphash_key_t *fh_key =3D nn->fh_key;
> +
> +	if (nla_len(attr) !=3D sizeof(siphash_key_t))
> +		return -EINVAL;
> +
> +	if (!fh_key) {
> +		fh_key =3D kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +		if (!fh_key)
> +			return -ENOMEM;
> +		nn->fh_key =3D fh_key;
> +	}
> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));

Another error here ^^, I somehow failed :wq to increment to the next u64.=

I will send the fix in a much shorter timeframe.

Ben

