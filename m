Return-Path: <linux-fsdevel+bounces-76860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AhMJSlpi2k1UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:21:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD3411DD1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49008304DC98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113833815E1;
	Tue, 10 Feb 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="F+GWvf4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020078.outbound.protection.outlook.com [52.101.201.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053430CDB0;
	Tue, 10 Feb 2026 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744087; cv=fail; b=m3SsH11kAQHlWSp5dmp1qjGp0GssbH8+NIp3P9+rTq5nEeoor4Yv8avKh7ipjOup3itpjNRlHGggm3b2xOxDsdHO5IxR/p1nckMLu0Lvl4+1y+U7hh9OM/yW7gHvATEydMwBREXbLz8wlai3S6ZWBdijNaDbYb7EyEBxchw4Ys8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744087; c=relaxed/simple;
	bh=0pXHSOSeI1M/0I3ic0ZcolXg0KqFj6GEatj2W9kx3MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kLIfGnuvPYa9teANQFHSeGcloZvbbp1zgbQyxHB9hpKQPTap+XiY+5KFd0liHg/R4N9vxgPfzegPDuYqQq/y76nFffCKLyWyRACExWlVyutHXzbQouIun3Pf/gJb7GAriZ/VXDRijG0ZuOQFp6WDiaPmhPLbSCj5/C+YzbaZSQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=F+GWvf4r; arc=fail smtp.client-ip=52.101.201.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLge4wZZ80fJ4qTB/3QDs+0J6XLaAloNidew7kHaV/Ckle+epAd67SgxRWwrBJlh+XrKUhs2yqyxBhW0GuhnFpAPRi+YRGR3Ha950EXlHq44VSgvVu1oLayzAsA869ApxOY5au/DTz9y8zvHcZuqlP+SeZ/M9TX66/s5zZ+XDgIH88HN1k9c/7UfaVac7FZ2gxiMoAxXs9qtpRi9J9YTQQEvboPGB5vGFka7zeXKilWi5Oc9H7Xta9DQmsZt2dmcFRd0a6peA/+OhbYJh+tFIiDU5x7ILR/TIQc0yHI3viK+h5TQ43xXYLaVUcM/46l8fP4Hjg4uhoqnxjOxGTi/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dJDv4l1LKJFjrFDAnA1SxrF1YHTDFXMn+2PFpIqnEg=;
 b=pITTE/jvV/8MCQCTd5z2LEskz95WWUXsNeXTD/q+G5HJ2H+LQuJqTjpyBYgorm34q3FGzOS1GOk0kGX+DGP3UhxwXizgontCyFo807jogPy69YMfMl+jt68K8/pk4+HqexgW45AbD0SFJngWN1QImEMDoBEaXG3XaS5xVFrJ42KEVTbl8BkXTZuIayZmvfWVhywbY8fnyOelsNZD//WrZofGzPs0ajHut49THIvl0s+1YCC3w7Mr35R6KqsL5CDPiiPQjIaQUL0WuZzUr9umMTxzlfm3W5oReXYzWv84A2uGwU9guVnKRNYHoBO+8WN9yOfE4fbMwTHkj25JIRviOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dJDv4l1LKJFjrFDAnA1SxrF1YHTDFXMn+2PFpIqnEg=;
 b=F+GWvf4rz3tskUxdcu0F2KfRnsiGWLc8dMqH3PBwH/SVKS77RnuhavsViDdOHsUVzDNJFANc/23oFEszN1gLw4J3zlSi+Y/468cKswA9+v+SjUJ7Tq4XEQPekwGc8UoJoSC5o+D/BzU3JDsvUTdp0qHuj5+GYx7td5U/dT99JO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM6PR13MB3675.namprd13.prod.outlook.com (2603:10b6:5:1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 17:21:23 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 17:21:23 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v5 1/3] NFSD: Add a key for signing filehandles
Date: Tue, 10 Feb 2026 12:21:20 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <8C8698B2-B07B-4191-A9ED-8D3E64742D70@hammerspace.com>
In-Reply-To: <51ecc417-2f97-4939-a1fb-af7d23d44640@app.fastmail.com>
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <945449ed749872851596a58830d890a7c8b2a9c0.1770660136.git.bcodding@hammerspace.com>
 <961be2e7-6149-4777-b324-1470b77f8696@oracle.com>
 <D37AD3C9-A137-4E41-B34B-8ADFB1582F23@hammerspace.com>
 <51ecc417-2f97-4939-a1fb-af7d23d44640@app.fastmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:36e::13) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM6PR13MB3675:EE_
X-MS-Office365-Filtering-Correlation-Id: 94189cfa-00f9-438f-0a89-08de68c8d061
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yVFAbyG5Isrm83zwNZCPutXYi5iGfQe1dYCLGKq/W3EyFIRGOfb9jvza6dlk?=
 =?us-ascii?Q?SEI3UB5GurZqDhiRCcyGzkMgUgRflz5Gk42RiTWt11v3+PD02LKSA4r3GV+S?=
 =?us-ascii?Q?1ykG5h2rA4ImMS873EKcGqooTyPAyz7xXfbDDp4XOS6gIeKvlHeF0+rdpunK?=
 =?us-ascii?Q?/Yi5Y9Ye8G6lNqJJbCz5f164AbJco453EUH63IZ8uW+LRi0pQ9ANAiu2JKT9?=
 =?us-ascii?Q?0jtW8BCs+qFEL3CXkR1sQ9ImHf5coUpwTRkloRMFT0AfqXD+orMDhUvu6jgq?=
 =?us-ascii?Q?vvuIHwunGuIfdIYuWm5QGax1Lpn+9YW3P68WRirGEzr8dCfnU+Bqidy3WPXk?=
 =?us-ascii?Q?EQuzt8NSkPpRJw2/TiDBFMFSUK2nxH/k2lyRWOee7EYJa7GuNhJxmGm35ZnM?=
 =?us-ascii?Q?9qwnpc3sleM40UTF5pyjFVTIHZzbjZjGOzou5AHuc+ZvfOpDqMkXdWpraVAf?=
 =?us-ascii?Q?Ie6hEQ2B50V0fSH8sLDQDgQ5yfORco7n/Ut7Anj9UVAubpBKJkHnVeajY9q+?=
 =?us-ascii?Q?rGBdzmlr3kxkKt82Gb2iJfun6FE+PkK04vskx/D/iMqHdhqbYidLHEuCqhaV?=
 =?us-ascii?Q?Mmirr44u0d/Z4WS6gZXIniqO99TwpKPTYCX18+avvqzigwJTzQBHN9jYpmfM?=
 =?us-ascii?Q?LiDX6db9F5npYqHxlBNB6T3AXdDat9yRsRUZSrwtEaSni2qlklkRsxn0CbDx?=
 =?us-ascii?Q?M7Jz7Wq9cySooZy2Dbj7BByLIKqXHoqu1RTZSmWdsuakjqNcuPplnBObYZq0?=
 =?us-ascii?Q?Q4XoWypYY9uok4KGA6zRtdf1OLOTPAG+3/3UwPThm83YwvgAYzbBcP167B0J?=
 =?us-ascii?Q?MacVy6d7G++Sf6KPpXRd4DCjLcx5/5+OUK6KuihbfSTQurFdqbmEhvhTaPZx?=
 =?us-ascii?Q?5RrqKzDnPkwudKImTdmr0WC0F345hkXe5hsfnBoItgvd0o9HHJs4CW9RCrmw?=
 =?us-ascii?Q?jyze18Bd2De9HdPeedkZtVNsBF8QeZQQS5uYSEAjQkeBuU4qOUCWkdsDP4Rz?=
 =?us-ascii?Q?l1VQhe0/g8k+cJa0tNvSaBesRb3Nz1/sAOE2CWEZrghWMQOhvXn7lM6kjVr4?=
 =?us-ascii?Q?KUd5w5dFJisY15qMPjGt19faS43bp6qoagNYDmT/wuWVo9bmfCXLKiccJRQq?=
 =?us-ascii?Q?feauDUgmtSjKRi6ff9DNCqtqDFAJpVIiDL1IfZDs1lCFQFW6gP3C0QYflzqg?=
 =?us-ascii?Q?DlLKdxTvrQGnppuwYWgTLnr5txhSmknAhTeRJQKNpwVj6OdhqTV9XY/FSrTZ?=
 =?us-ascii?Q?PBf8kEmdhFT7ke+2DE/SXNQk49CHippSiFrMa2z5/+6EBP+lCSiRtsd3AxDU?=
 =?us-ascii?Q?w0xjoNBf7eA4Hbnn/pprqda2xeb0zJhBv2u9riNq0sUT7BLt7AcZDaNZ++XP?=
 =?us-ascii?Q?3dp/eeSOFAjloTx/NUTatGzWgtDofgt3JltMI0N5Lu5B2rKtVRY1juw0WKuK?=
 =?us-ascii?Q?UxHOVcVO3MXZiJNYknnFdI9USf1U+Tl3rMtyw5aL7nWU7OICBvzAkqP1pnQK?=
 =?us-ascii?Q?bkGzgqI21kKoL2CSEQtwWDSn/x2SM6swax4NsP7BfqHe4Fgmf16HqgzQeMpg?=
 =?us-ascii?Q?mYWmDH/Q/3c7Gs0tTbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j1XAPk3ILYxJOwKrQPZBEhRUNCIr3ZDuUSCcIPFSVdn84HJQ1+Ho30Kkm7D1?=
 =?us-ascii?Q?M0IJfwbXO90lOIkLJ1T2ME+yAuSUtv6GLjSwI3qQDQTOhYkiAskiF0raDXxE?=
 =?us-ascii?Q?bnWHkZaXNpS8SVtLter+jr2e72Tfg+7dOFFMfqaj8/Do3FuH1a4i6z4WI2Pe?=
 =?us-ascii?Q?++jmsyU5TF8xYgpZkuCVbp2oPQfdunVBJYmtCzpzEkM0wON1lr1Qd6MS6lmM?=
 =?us-ascii?Q?+9j3P/Bz+g06+LOiAMbC9dQh6wbayDdYCAcHpK6GJ8j6v3Y2mdsSoe6HSIRs?=
 =?us-ascii?Q?J4Y98gKZGBpjUsP94XgXnyg3dfqpevRjLzSKbW1vZD4/6WhT3X50zeNWjonz?=
 =?us-ascii?Q?JzqEfz+QCUtL9xCGDR8R+9AMK78yoBfbnIlRTJ/qM7GfSfDbZO4BSN2qoeE4?=
 =?us-ascii?Q?e18tvQfKH86j6J5kfiAeqZoXcbbjIGHo0Vod7G2U9Pe/zsB8eUEAWWVh5kLj?=
 =?us-ascii?Q?I7wK9G6s6ArKrMIsJ6+1Z41TBIXdhwPfMwPvFTO/Msh2QL3D/ciR7903RbLW?=
 =?us-ascii?Q?yZsICfXQavOMg1lMMXpHKmpuW2QxBVm/YPf1AQceOjtrRbkr6mJA8IehBojf?=
 =?us-ascii?Q?2fodlLJiSThuSttdTghoRGg4N5KkdGlf+wkYioZKrd8+58Al7jVUTBXiCcIp?=
 =?us-ascii?Q?m1/lEBIZNknICERGngF4Tdly2G4Lbw6S8LRTGA2pLDLGLtIfiOK4/rZhtG2z?=
 =?us-ascii?Q?/yzUc/M+J/fSWRYPYpDH742eBDnUjjg8Al36GMOsNDIO6PPZG+hXukSIUsHr?=
 =?us-ascii?Q?05R3KgLg3gWvYY3YYjMDbN96PVXMWoAwOr4H5/GlGO7dAelqjDoxP1a8y3zP?=
 =?us-ascii?Q?58BsLHhMbK2K5ebDly2NKbqevymZqajn8prF/AYsXVoM2LCyAlCmTHb2ogM5?=
 =?us-ascii?Q?0tJ7fDbXnxurJ6TDpQ1tXuXNFuFsGQj1GlpZiwaeiY8PEsJgb36UYQmMEsSQ?=
 =?us-ascii?Q?B8WuyKyM4Z4De39JGQBgdi6lTwE/OgYI2wHDEy2w7ikccz4vxmtV5/RTxTOC?=
 =?us-ascii?Q?1/+FafdcvFrtzioncg3x2e4hYYnivNDcspPpJlPPN/jmYEc1M2BenCedHIS3?=
 =?us-ascii?Q?K+fZ45k82XUnR0Z7B2x7w/nYfohGPLP1ZB2VDoHPGXlS526wKjMoERVMG96E?=
 =?us-ascii?Q?ySdw4pPluwcqB/fLbrZjliihMwSR32fckgrvtAIbqtkoOEB6KI50umw/mAeN?=
 =?us-ascii?Q?KFhGmn+7RSVQZGe/TZq1CcMFhIpGN6qiggqWTjAkcDwtQ6Uga3G2l9Ng7XAZ?=
 =?us-ascii?Q?2dJ1Pmyf/1ejtocNzO1MZ6rjWAPOHJF/Ewl4SnXFgemyxQjoe8/Ndu0RuEnk?=
 =?us-ascii?Q?l7cHuY63BYgJM6vACYP97sRmDnYMLuhqJ6EArF+fkaTxMlm1odewjQR/QD70?=
 =?us-ascii?Q?MiWONkUSdJC+UKDw/pZAv3kglcoAP2hvk5J4f6KaOjBaiAyN8BToEYZ9kESM?=
 =?us-ascii?Q?dCcDcnqws46YZCglxkevJ0NNBNYmenhISe/qEVgFITgX6M8F+VJ/VBps0waw?=
 =?us-ascii?Q?tZw55kSBIceV+3ao4rRvD8Mf9XtYoZ2uZ+SIgwo4VI+vylAyWAoD2vw/Ht88?=
 =?us-ascii?Q?yavIIYAKQLkw7d7N30taRk3pyBcH0+6fR2atQiJoUDy59tzxyw00vtClxdvB?=
 =?us-ascii?Q?qH6mt2kIFzQUPJY52y3MVk++9fZA54YrJRVEMnvrp4eL/O1iyOkjnWNAITKc?=
 =?us-ascii?Q?PnhHruwKLORGxV2RbVv8er7yz31O8v+JBMpWWecuLFPhiOPVsBwzMbWMh1/0?=
 =?us-ascii?Q?Ezjchs7mREAb5c8Y7TsXJ+fy0q+uK0Y=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94189cfa-00f9-438f-0a89-08de68c8d061
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:21:23.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NHtmO8o1tBObPnPd0JwQpWGgy0aYHrhPzxK3oOlnngneseXZJnPdT+D3PkH2NPhkKpVKl76joVNcS0ipIRfz1rHHwH688syp0Tw/0BmHlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3675
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
	TAGGED_FROM(0.00)[bounces-76860-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DD3411DD1C
X-Rspamd-Action: no action

On 10 Feb 2026, at 12:03, Chuck Lever wrote:

> On Tue, Feb 10, 2026, at 11:46 AM, Benjamin Coddington wrote:
>> On 9 Feb 2026, at 15:29, Chuck Lever wrote:
>>
>
>> Let me know what you want to see here, we can hash the key again (like we do
>> with pointer hashing), or just remove it altogether.
>
> Yeah, I was thinking of hashing it for display, but then that
> loses the ability to confirm the key's actual value. Another
> option is to leave the trace point in for the initial merge,
> but add a comment that says "to be removed" so that when we
> have confidence key setting is working reliably, it can be
> made more secure by removing the key from the trace record.

Could just redact half of it too..  that could serve both purposes until we
pull the whole tracepoint.

Ben

