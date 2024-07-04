Return-Path: <linux-fsdevel+bounces-23161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FE927DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F4AB23313
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE8513D53B;
	Thu,  4 Jul 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EqOqzivI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hg7thp9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95913CFA3;
	Thu,  4 Jul 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121319; cv=fail; b=R7ovNe5SMB0jevrOIqzt42OmvVU42QNb+jY/dsZXzuoe3vu3iBzGbaT6n7W5qk9eiNw9jat0g+3S8RIKP2lFx2AbQYP/BzLb6fxdZj0S1v+e51vjJnCQVGD+l3ChLPbRuoyfQ4DGfAd9eWpG69NIOvaFwHMVH/TuOZcCYbExqPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121319; c=relaxed/simple;
	bh=afRhQNl0AF17YLzNnvWNh1bddXcDBioDZsKvvnOkeR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M6PGrb8565hTe81BswwGSNbOL0bXep8jnuhtaO7EpjCuSVbZY/Sc5VLxkOve000SwgiWEDyxdXaM0l3Ot200AdQo3HcHYJZLCOcMlDiEiEexZrElejaaTboZ958NQmFFKG+x1yPmmejLwtxUdOhgIVrPHC9xj8yrXUMmr3V0AZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EqOqzivI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hg7thp9Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DrVPj025857;
	Thu, 4 Jul 2024 19:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MzhyD6cb3BiXjeh/IjbwiE2Jy8JsxlBCHvbf47q1oBw=; b=
	EqOqzivI4kJ+pB3W6AH/sbxAXPMnxG6Z/fGzCiBuhuIg11FeEUJlh/afNEeWBkrf
	8Futlq4lARYzDrdD+9PFrjYMEJAymr1na9n4qQ6JSAYYAMbvwo2u04qPaLfmFg9M
	M4Z+0DZLoGModRAki44vIePjGjW3ysqkCSmt3Pe/A/LI5uyz+SaHVfWjSGMMi8d1
	W3aHdi9k7NESVeF68B2iiaqhUvlw3SM1av9DFcgEudmK/V4rhraLgrd+vcE1UXT4
	vtUjZsJC0xh9yVsXBZlPI0AjyIH73x2zdh7kpwauDpwjYvu6EftHOEkxb1n53SqZ
	68LniTNVhHK9hr/enou9YA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b2rum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464H3V4Y035692;
	Thu, 4 Jul 2024 19:28:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qadx1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj19tLN54D211VKgK03CgugZyxEzrds36hIllshsXg7WmsiDZ+0zgUpKUizO/9u7z1FjaJ23VG91bTHZuXjCDyU7Jg5x3lkkfGjnXc/IauYjYAX/9O41lDY2j65IB671in6W1CjqAT8ThhXOy5F2FgkzlhoEoJSdHcjAE+bHym4M5uwERqasiev8UmzkpCgR6oVqK78IxKSTJxfQHZ3EzV6Y0jjY0IeZCoYptub0laIz7rjglsLTnD9w1R5vjSWfhyP0zJG4n4RRSmRWlDPawXe3qmRCdTaDt4Vg8NoB6QkZT/wC0Vukajjj8TzjmwwA6aOdyk2a0QkmZrHl8Z/lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzhyD6cb3BiXjeh/IjbwiE2Jy8JsxlBCHvbf47q1oBw=;
 b=US+acXvOtoYUpQbxhb4rHBP00+seAZnhpJiLv424UU2pELtvmhAlx1exQ549boTmrLtMye1T9XL/DaH80ojD/v4jSi8YYu0pjovDJR6iKEd64BrvDAy5DEHGTziNZdYNet5VxH2acbUmAp/9485kZ5zU62hmKLeWfrBzkx7MieRemN2Yv8GO98asqQktw5RGKzy5b3UEM6/Mag6Y5FYJxh6Zfn3hBVIQyn6+ukNj6wUdn6NhcNOtKF7s7f8K5zSwFPYu2//JI59LWarwQY22Kzz/RJCsIgczUg/r/HiYOcpvUGCt43MmKCYdP7b3BrL6elmXpWuvhCWw8oKLBnZRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzhyD6cb3BiXjeh/IjbwiE2Jy8JsxlBCHvbf47q1oBw=;
 b=hg7thp9Q98p6OTgFGEC/SDRFeFKQ70ILQAFBqWabno1Ii/4sSyKcDKi4+YdXSLN1uO0KNxYpk6uplsP9blMGFsEaBEJ4pRc3xwutzbzqSPqppOh95FYOu5PVv7EkcSh7HehCnHpc7vHXZx4cOECND3pNWN3pY4IhqiE59JmQ9hE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:28:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 19:28:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 3/7] mm: move vma_shrink(), vma_expand() to internal header
Date: Thu,  4 Jul 2024 20:27:58 +0100
Message-ID: <2182710009e222ee0a57ad975ed560edf965f5ee.1720121068.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b4cc9a-373b-403e-ecf7-08dc9c5f775c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?efSsypHDqT8urJAdaPTGp4qKbJ+Ho6pVylrvu+u2s2XTbL7wiNBPW8nN5U1k?=
 =?us-ascii?Q?qN66yd2J7Z9/H+hD4zda/AcPM2pGi+qxzFJX2yh3Yl37KSSvUSOTPvfLCKfp?=
 =?us-ascii?Q?M3WmvC21vKjlzL21/epE6yVJMMWR7SowmgSBjKPf2NRiODHtPBioI4TqAyz4?=
 =?us-ascii?Q?YDDdZpvZdQa9dmkANoOC6v0+qVRqbmqB7QNygR2iNkKLJGKtXx4aH0+ekaEM?=
 =?us-ascii?Q?blc3zN5mxOORnS7k3kalBkwb6IQ6rpfpWPj2picoHrMysofeWYrI44bzncoq?=
 =?us-ascii?Q?l/uM/R4HBZ+FOKc5LN7TLoQ9ZZVO8rzZannBjpFogt4GXnbe6y3XdOpWUOTr?=
 =?us-ascii?Q?hWnnZYyInN0Zu2IILmkORpzSVq55mYhHOoAYJLY/5wxi+HrplX/4jE7dFtJW?=
 =?us-ascii?Q?tedsV2E2J8NRwbdUndn3qdzWiLJXG7vdal5VeZWx147dxy+vehLSMkxBEp/Y?=
 =?us-ascii?Q?BZv8FFAL3EYB43JpR7ZCuFwivLhb/w2VYS51b6wyqsaoAWUT495emcLUARcS?=
 =?us-ascii?Q?HlXLoPqAq4hic79BaBIFEvqq1ubxpDpBkZk3cFqTquomEdGly3R9egHijBk1?=
 =?us-ascii?Q?0haAeOsLdNrVZ5yJDKCO4r0sFRpE+XcpvPdCwcLLe+QUoZXWMfI1MDem8kHL?=
 =?us-ascii?Q?J8wLUvqt3aqptXUyt1dOxNwOXZ6iqnAWl+/DotJrRKCEGVRV8PgQnlF7FKhU?=
 =?us-ascii?Q?jswKCF6DqON+ooA/IRxVSrollspkCi8o+2TaWRCtglrGR0RS5T6AUxc+wtBt?=
 =?us-ascii?Q?WRboQ6qax9XRfnR/WGK2G8+VJsQVFoGktc8yPbuGi5PLB8Q6Fy11U4G5LkH4?=
 =?us-ascii?Q?fuKOTy24hPVGPDvGuHyPhYi0RTdW0zHkkGwGlLax1PTzeOV9MiJqdGFgHvqh?=
 =?us-ascii?Q?3kjfccpkXDRTyQuPGlTrMlHFdeDcqcZ7uFN70evjYFV48YsWXSGWd2LHVlEy?=
 =?us-ascii?Q?jviCPWfh/Safo477zGCTkBuOGSWvdT/tJsIdX6xSGaHHqPwu9tPG022IxKo4?=
 =?us-ascii?Q?9bi9EKN19ufEJklNGJFyodndreZGSlNLflyIRa3j6TEAZpbkcHLLuaAr2NTA?=
 =?us-ascii?Q?U14GCvc3NI0O1Nws4+bnkgKeHb+7IopWxSHT7nhjhtHrJVWCh4eqBK2Cqqza?=
 =?us-ascii?Q?7KwJabe8DWbg/pI5twUPivxQrPGK8k4lLkY95bFB5bpLGSMwhU8qu0xtZzhC?=
 =?us-ascii?Q?ElFFBMmCl8LTFkklXjHpQg2WMkjzNAADHpdhbsMfHGSOQ24/NT3lTTe1VdhB?=
 =?us-ascii?Q?p1smvWOAMmnSeiemsagvrkrEdSt22BDkIThfPiLgZ534I+Zj2ImDly1m1v0l?=
 =?us-ascii?Q?/ksuEqZpvXGTkPG+DfIFMRu/UDTau8z3nTaR1yrWs+CfZQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9rh9Y0HZ2IbGasnAWbx3USLqnrqSp45SpqtMrjQP7GT2fKSTukHtPbgGSzwY?=
 =?us-ascii?Q?WoJCJTLuJG78ptgULsDdoW3X7FOydHmAtlGhmjjvA14F3prYnu55AonVQz53?=
 =?us-ascii?Q?qs80ZUobARCSQvPn1G6dsW3ggp55elv6T/jazCrE27ILrbnJmSLhLK6WDAyd?=
 =?us-ascii?Q?dM9AAEfjy+as9CfBJDY3xRwwHWpVzMagFetqL+RsebG5w+jejaHjyiQMLx2o?=
 =?us-ascii?Q?x/B44BysW1bxzmSAsyx4UdrcU03nGC+DOZ6JhVjN2tZc298q9dIRKPm1KnkT?=
 =?us-ascii?Q?JQgETMJfFVw8RVjkYk9pHjyWIqJUa/wG89W3yjSquA8b3Uhv4Mlpn6M2IgYR?=
 =?us-ascii?Q?ScZnIh44a6zkGxpbXV26nz9PE7g85Zg7IwDzXjKRMGA7m3BxpSSoElMXUipN?=
 =?us-ascii?Q?deljTn4houzRId43/wxsfKGvL+nfAwKA2gXoonwPpqSC4P5ZdH96CV55hyNr?=
 =?us-ascii?Q?vSXc2h8rywefh4TELzuGq3xI09Tb4BptjRJHhxYrNd9vHl1t+gq70riL4Tgx?=
 =?us-ascii?Q?KECOt8EQxN5kc9DbP8vI8EQNLySQ871Z18HvdsLPi3xJv8Ja3eAsN3RRVYeI?=
 =?us-ascii?Q?LDHBefFcWtr4QfKpv7iuC9AUVNtpaMmRf4t9dkoIL5vBD3yOcQJzZt8H9scZ?=
 =?us-ascii?Q?6ilU7F8IbBsOsaEizS1dCkrstUQSnEqaHGc09+mz9GyD/gzhYY0Y7FLSbzS6?=
 =?us-ascii?Q?lon/w+k5KPKYXNK6XYK7eReOHfI/HSENQ+JGKATLou87whXELT2JGTljfJgK?=
 =?us-ascii?Q?+YYQcSxpFLKW2F3s1Z4brPwIdpoT6cOHDwR1JXWgQ9mdwjbQL8e1MGdzst7S?=
 =?us-ascii?Q?USyAi5fGNvWqgbmeNhA1haOm+X38EzwYxh14jD2AaUDw2wcwBgPVmHNVgG/6?=
 =?us-ascii?Q?1Et7KpQoDfxQ09I3t/kd2AxcaJUxFyfgifNPncwZi/zt92jAgDkF35j6h6fh?=
 =?us-ascii?Q?AWiv3b802PHoVQJXEj3YBsXKZ0310p4AcYE93jHzzNXGnjLszmDbjIPuP8KU?=
 =?us-ascii?Q?z99f9m5pJ5fOKVMl4pLJtpQKS9ThrlQDK6uCS5OVkbtIOvlafHRLIl6Qm//I?=
 =?us-ascii?Q?gVYZZvlcclkSVjFfQNCwoScYvnD+B0/u60FDVidApUEYGWiF9e/jfong0RJn?=
 =?us-ascii?Q?WUwlFRo52B1Sg5mqFvePtduzrorRl2SsGcH+UvbPlzkSoCMZHVuf5l4q0un1?=
 =?us-ascii?Q?IMXwylanl7YP5wU/aUAN3cD8XVmYNWjyPXInP0O9drpIyjhPWe06xy6TEPqw?=
 =?us-ascii?Q?olXlmaTF4jX7hJI/iDaXuDDUmt7Gu3998Wd2BGq4LKV1/yFi9brWDp8Lm6R5?=
 =?us-ascii?Q?wgVsioUyLI7ec8kX0g4cUm5Tn432wH2zfvx7wj5io/oT3rthWxjyagaEJtob?=
 =?us-ascii?Q?0ZEJoGzaQx7CXJKrqFtJK8u1Gqj/JqKhJ6GgQlz+gvc0MCNRLOICQt/Ti1U8?=
 =?us-ascii?Q?aRNbKyooI8qwi4AcoG7+OZVETdMLTxJAG/ZcD9tc5eRck/SXz6KjVB3jFGxW?=
 =?us-ascii?Q?4ZQ6hCbZOqBTXpigqA/EdAUIlwdVzRVK0xcP/WGfbfKpw6Qm21ngBel4ZNjy?=
 =?us-ascii?Q?bdkuYhE4F++55+hIiCaQp1zlz6sATh7BBarNwYZA21kjx9NXingFGsob5YED?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UCnqmueekXC3ENZTtumLzlgw9X0MR1MUjRCI6cBZeldMz7joMpxgo6z1cIVwoEv0k6EBlkyPFN+pYLEp7/IynMuaI0a4zmYch7kW+HOxfs4QVRg+UlU4FZO9qUbqMnzSsJEXos6mUnUd5RgM2UmOnDZbS61c6iDCiM83QnTLP4/rH3F0vIOgBXzvKKiFuz8oOaw5GBx/DNdFULSnX1H7zYpCv0lztGxMN/mw6KEArGHw2O0gr1gZjPuY8Mt+X+l/5WGbHXoAP0ENWf45+HsUTvCLdAjkqlIc5YuqxGBfXWS6O9now6g/tAB6QyJNVsO2ocu52kRO58SgTbdKT4WX2XuGTEgHXRYO7YGNxkAkw2rrGfTGHD8He1HQBF1/60/aSkWWysnyoUhOUDayyfZaVuUQrO/ZhjEGSjQEfuYvxllIXi+IgG4YjwueNtLxfMQGHyCyHkqZMhuAo1wWbWWOk+H60EolY8ugjDPWnM0Ed5obRZj2ao3QB0lyoUFJO3icfJ2CVMbsVJ7U0nSNaDp7xQ6ou9IiZaNFC51SyRilScpMAVTNZuAJWQL37C3AjzHLZHTQZ2eVv8lrgXE6LJVeiaF4NIQg0oF5B6honAnXwWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b4cc9a-373b-403e-ecf7-08dc9c5f775c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 19:28:22.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FIQo5q//sNNJTT07juMfqCRQNTuZ4PNqeG9stECZytj4aP/Jlruc6/Rc78tOjrIbQ7knblswgDkEB/gvQ/l0ENo2ZXgePmX6ZCxy0iOVaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040140
X-Proofpoint-GUID: GYiJ6mrE6X-k3ncgGL7hWgAYjMLL4W6S
X-Proofpoint-ORIG-GUID: GYiJ6mrE6X-k3ncgGL7hWgAYjMLL4W6S

The vma_shrink() and vma_expand() functions are internal VMA manipulation
functions which we ought to abstract for use outside of memory management
code.

To achieve this, we replace shift_arg_pages() in fs/exec.c with an
invocation of a new relocate_vma_down() function implemented in mm/mmap.c,
which enables us to also move move_page_tables() and vma_iter_prev_range()
to internal.h.

The purpose of doing this is to isolate key VMA manipulation functions in
order that we can both abstract them and later render them easily testable.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/exec.c          | 81 ++++------------------------------------------
 include/linux/mm.h | 17 +---------
 mm/internal.h      | 18 +++++++++++
 mm/mmap.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 91 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..8596d325250c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -680,80 +680,6 @@ static int copy_strings_kernel(int argc, const char *const *argv,
 
 #ifdef CONFIG_MMU
 
-/*
- * During bprm_mm_init(), we create a temporary stack at STACK_TOP_MAX.  Once
- * the binfmt code determines where the new stack should reside, we shift it to
- * its final location.  The process proceeds as follows:
- *
- * 1) Use shift to calculate the new vma endpoints.
- * 2) Extend vma to cover both the old and new ranges.  This ensures the
- *    arguments passed to subsequent functions are consistent.
- * 3) Move vma's page tables to the new range.
- * 4) Free up any cleared pgd range.
- * 5) Shrink the vma to cover only the new range.
- */
-static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long old_start = vma->vm_start;
-	unsigned long old_end = vma->vm_end;
-	unsigned long length = old_end - old_start;
-	unsigned long new_start = old_start - shift;
-	unsigned long new_end = old_end - shift;
-	VMA_ITERATOR(vmi, mm, new_start);
-	struct vm_area_struct *next;
-	struct mmu_gather tlb;
-
-	BUG_ON(new_start > new_end);
-
-	/*
-	 * ensure there are no vmas between where we want to go
-	 * and where we are
-	 */
-	if (vma != vma_next(&vmi))
-		return -EFAULT;
-
-	vma_iter_prev_range(&vmi);
-	/*
-	 * cover the whole range: [new_start, old_end)
-	 */
-	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
-		return -ENOMEM;
-
-	/*
-	 * move the page tables downwards, on failure we rely on
-	 * process cleanup to remove whatever mess we made.
-	 */
-	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false, true))
-		return -ENOMEM;
-
-	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
-	next = vma_next(&vmi);
-	if (new_end > old_start) {
-		/*
-		 * when the old and new regions overlap clear from new_end.
-		 */
-		free_pgd_range(&tlb, new_end, old_end, new_end,
-			next ? next->vm_start : USER_PGTABLES_CEILING);
-	} else {
-		/*
-		 * otherwise, clean from old_start; this is done to not touch
-		 * the address space in [new_end, old_start) some architectures
-		 * have constraints on va-space that make this illegal (IA64) -
-		 * for the others its just a little faster.
-		 */
-		free_pgd_range(&tlb, old_start, old_end, new_end,
-			next ? next->vm_start : USER_PGTABLES_CEILING);
-	}
-	tlb_finish_mmu(&tlb);
-
-	vma_prev(&vmi);
-	/* Shrink the vma to just the new range */
-	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
-}
-
 /*
  * Finalizes the stack vm_area_struct. The flags and permissions are updated,
  * the stack is optionally relocated, and some extra space is added.
@@ -846,7 +772,12 @@ int setup_arg_pages(struct linux_binprm *bprm,
 
 	/* Move stack pages down in memory. */
 	if (stack_shift) {
-		ret = shift_arg_pages(vma, stack_shift);
+		/*
+		 * During bprm_mm_init(), we create a temporary stack at STACK_TOP_MAX.  Once
+		 * the binfmt code determines where the new stack should reside, we shift it to
+		 * its final location.
+		 */
+		ret = relocate_vma_down(vma, stack_shift);
 		if (ret)
 			goto out_unlock;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d2b5538925b..418aca7e37a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -998,12 +998,6 @@ static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
 	return mas_prev(&vmi->mas, 0);
 }
 
-static inline
-struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
-{
-	return mas_prev_range(&vmi->mas, 0);
-}
-
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
 {
 	return vmi->mas.index;
@@ -2523,11 +2517,6 @@ int set_page_dirty_lock(struct page *page);
 
 int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 
-extern unsigned long move_page_tables(struct vm_area_struct *vma,
-		unsigned long old_addr, struct vm_area_struct *new_vma,
-		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks, bool for_stack);
-
 /*
  * Flags used by change_protection().  For now we make it a bitmap so
  * that we can pass in multiple flags just like parameters.  However
@@ -3273,11 +3262,6 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
-extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next);
-extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end, pgoff_t pgoff);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
@@ -3285,6 +3269,7 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
+extern int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/internal.h b/mm/internal.h
index 81564ce0f9e2..a4d0e98ccb97 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1305,6 +1305,12 @@ static inline struct vm_area_struct
 			  vma_policy(vma), new_ctx, anon_vma_name(vma));
 }
 
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long start, unsigned long end, pgoff_t pgoff,
+	      struct vm_area_struct *next);
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff);
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
@@ -1528,6 +1534,12 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
+static inline
+struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
+{
+	return mas_prev_range(&vmi->mas, 0);
+}
+
 /*
  * VMA lock generalization
  */
@@ -1639,4 +1651,10 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
 void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
 
+/* mremap.c */
+unsigned long move_page_tables(struct vm_area_struct *vma,
+	unsigned long old_addr, struct vm_area_struct *new_vma,
+	unsigned long new_addr, unsigned long len,
+	bool need_rmap_locks, bool for_stack);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index e42d89f98071..c1567b8b2a0a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -4058,3 +4058,84 @@ static int __meminit init_reserve_notifier(void)
 	return 0;
 }
 subsys_initcall(init_reserve_notifier);
+
+/*
+ * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
+ * this VMA and its relocated range, which will now reside at [vma->vm_start -
+ * shift, vma->vm_end - shift).
+ *
+ * This function is almost certainly NOT what you want for anything other than
+ * early executable temporary stack relocation.
+ */
+int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
+{
+	/*
+	 * The process proceeds as follows:
+	 *
+	 * 1) Use shift to calculate the new vma endpoints.
+	 * 2) Extend vma to cover both the old and new ranges.  This ensures the
+	 *    arguments passed to subsequent functions are consistent.
+	 * 3) Move vma's page tables to the new range.
+	 * 4) Free up any cleared pgd range.
+	 * 5) Shrink the vma to cover only the new range.
+	 */
+
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
+	unsigned long length = old_end - old_start;
+	unsigned long new_start = old_start - shift;
+	unsigned long new_end = old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
+	struct mmu_gather tlb;
+
+	BUG_ON(new_start > new_end);
+
+	/*
+	 * ensure there are no vmas between where we want to go
+	 * and where we are
+	 */
+	if (vma != vma_next(&vmi))
+		return -EFAULT;
+
+	vma_iter_prev_range(&vmi);
+	/*
+	 * cover the whole range: [new_start, old_end)
+	 */
+	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+		return -ENOMEM;
+
+	/*
+	 * move the page tables downwards, on failure we rely on
+	 * process cleanup to remove whatever mess we made.
+	 */
+	if (length != move_page_tables(vma, old_start,
+				       vma, new_start, length, false, true))
+		return -ENOMEM;
+
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, mm);
+	next = vma_next(&vmi);
+	if (new_end > old_start) {
+		/*
+		 * when the old and new regions overlap clear from new_end.
+		 */
+		free_pgd_range(&tlb, new_end, old_end, new_end,
+			next ? next->vm_start : USER_PGTABLES_CEILING);
+	} else {
+		/*
+		 * otherwise, clean from old_start; this is done to not touch
+		 * the address space in [new_end, old_start) some architectures
+		 * have constraints on va-space that make this illegal (IA64) -
+		 * for the others its just a little faster.
+		 */
+		free_pgd_range(&tlb, old_start, old_end, new_end,
+			next ? next->vm_start : USER_PGTABLES_CEILING);
+	}
+	tlb_finish_mmu(&tlb);
+
+	vma_prev(&vmi);
+	/* Shrink the vma to just the new range */
+	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+}
-- 
2.45.2


