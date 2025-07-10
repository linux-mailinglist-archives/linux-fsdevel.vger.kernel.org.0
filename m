Return-Path: <linux-fsdevel+bounces-54523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF55B00799
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17A93A823E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2047276021;
	Thu, 10 Jul 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ediy+1R7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qdAHiaiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4713D539;
	Thu, 10 Jul 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162684; cv=fail; b=QO647ZiKPeVYZmobdT2LMcl+8K5oiuazTWnLgj3YdE9o/9Ay0YdLccgMxUmpmFIGRv/PWSI3TDKg1UxCQZPh9hj5OBbyQmxscgjsrCdnJqYwy4aJkHUdEjZ9dpoEEbCsRwDbGUFSHzuYvT42CH1rT6oz5v/1AVC6sxQKMwt7dqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162684; c=relaxed/simple;
	bh=tio57qRE/bmJen19kw7MHu0kDf+qnP3pSr0I42Nkxls=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nv8jXEMXzmvVOtpdXJ2j9BHugWgLw9kM0rpsF3Sbv1SN1wkTeCzFO6K5qGljI5MFP5KiM5G1qXOP4GPwFEmfZ1i1wm9Q2laVncXlFL4N/QJDL77Uf3Z+t+hc9vzerSRqkP1HB46JfjMQOk6tB5i0BtimOjPWtfOrivxYVWpy2oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ediy+1R7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qdAHiaiM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFbL1C007693;
	Thu, 10 Jul 2025 15:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=jqh5YfZH1zvpEnLa
	hWWZYVQSF1UyCgZlvhrfnQijRic=; b=Ediy+1R743lkqWQvCRngQqr6ImRA+fyB
	8O7i0gkrh8Ro/UZCji57lnd/wRS8Aj4KZWag1VXkQHrtt3Ob1e6+RRw5utOa0QaX
	cWbn99Sqq/xxMN6mdbZeOtO/3lA9Pl+gwn+GZEw3v7hOrkXv9XvUoOMZeRBScJqc
	aImlSjY2vl/6qcAiC0mG2Y0508u9xGKwdwJ5OHYxDepRMMzdnvxH2aU72xi0LmQP
	+3bxh9y+6WJLaOvRSlzKUUkE6Hh6oZklwsUUuSBOXzIgvAkgo86jyOErpVn3Tzck
	g6SKQ+8oz92e34Cfou2B8inxKVygWML9vChtds2RSul557G4m7AkIQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tgajr14y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEQWfU027344;
	Thu, 10 Jul 2025 15:50:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgceyws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsicD1EUAJNVlHtPZo4P5vk/iIlU/dQNLuwUKDiK3KVIO4CVqbX2kb9L/Vq6pfwkp2cielVnYBQrlb02raCx1yXjiX+DkPLPUPSWST5r1MCGMOSUaXXHLBmsgo5klDqQdKZVIOfa1tajMRM3imJqlJjICwoYqUrSZuEgDxwMHg5PKaeZXrcEaHeMl3pVJtceXpfXk9X18Nue/MOuxGdgAC8ddAOhnGTRsKFMwQXr65Z/cePLhr2w94G+wxvnUbs11WAyvSzZ5igUi65adSPvzCbCtlRv1sDdGW5fZkU8xhvnpcalKPefl1MfdCEHkQ+KWKrM//09SEDRA0xYfbSgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqh5YfZH1zvpEnLahWWZYVQSF1UyCgZlvhrfnQijRic=;
 b=p5YpbQIWiep+rbQz5w66qUfrEgtbYMZ7MSL1WS2ONCLcN5PAcBagUvY4OIViGN6i/AJtA4xm9GJM1uTN/ZoF3VHSGPSxqLTzi2NMdKcSQgSjDp9ofh0Pwl3nTOnQP49skWhT5+fEAJRxdtRVjBiV8hhDl0NI7o9OPfC8GUJnFPXM3B/Wh8dAYq8PkrgGP9KnQu+35nKSsnEGG8A9yP/XvCeJ/DZR8kc1R0EZFsMicZfIcXoSuSuFVDGTwrxSD3pKi/Hh65B5/1J25Dy52RaGqFLtWLcMlBZOoQKPp+R6lbAiFFrVxOvpNJgFgMwe2WB5T7FXm39MHdAFPdFqZJDDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqh5YfZH1zvpEnLahWWZYVQSF1UyCgZlvhrfnQijRic=;
 b=qdAHiaiMIXvbIzyV9Td+4JGwj+5W8Dkb+3WwHqfVZzOLJXM08al+KmIEZtEFzFeZu0wGHHrg3KNybTtZ8Q3uC1HIW/kWsYgOqbFM2bKsphnykvwfBseSYirmza2jfpaV5WPRhCC7jbuY1eRj50ibB3ThvKZslEwP3YyP1vFpzVU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:50:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 00/10] mm/mremap: permit mremap() move of multiple VMAs
Date: Thu, 10 Jul 2025 16:50:24 +0100
Message-ID: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0431.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 558ea44c-ea5b-4de3-b6f0-08ddbfc98632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jyYyUApnvuF+tjp8OE2KSOSezeina1+lvJEHo1pfHRI6vi/FS8SVdmezggyi?=
 =?us-ascii?Q?SPfrTuX7jGQrxPhxyX+/1XnS7yNSsryvvbjhJK2SahUSqPd1CpN9bAFUMrXY?=
 =?us-ascii?Q?Q3bu7mQtnvIId2xZIpx+InVKYy0b0PCcxV1nuKfIJmQ7lmFqAVRYXQeZOKXb?=
 =?us-ascii?Q?NQAXHGjX9R0ZEUVhSuHQSyDl0IOqdbJpCaXJgh3F7oecoNkpqifSQQzL8kJ1?=
 =?us-ascii?Q?AXwrA6IJOUK9ZSP4a58x2LGpPbN7+0ugeLUGsbCOmI5s0n2w5ajOekdCvkyH?=
 =?us-ascii?Q?i1jDbMrySz2HfdxetuHVVSFREkzaBTdw2kCRzAWV5RFwNDwYUCyT64C/7ghn?=
 =?us-ascii?Q?698s/c+CaPuItho42T64C+BzEPbvzdowK3oC8Oup/UvsV4rF+NxSAuFVTb1s?=
 =?us-ascii?Q?IkkVkw7c1bo9Bt9Xl3MgOJ182qkEzCjRGwlnuePASx6RE2KZ71Vi0MnSzC7G?=
 =?us-ascii?Q?q6GE/UrTXecOFcPe18iupB9nao+ujtclQE4NSmz6P6VdE+iL72szItoywPHX?=
 =?us-ascii?Q?Eg4xUSq5M30AKjrkhCmJkADt0MUq6wk+N+YHYL7QRf7YmvDCigIcZjcWeIMK?=
 =?us-ascii?Q?vElw7a3gr5Tfvsz5zNbkM0y9Wc4ooWS+GK/5elcYHr6VDFZD+YsCQQbIfocs?=
 =?us-ascii?Q?GTiKJ4mNMeO5qjdKYyKbSwnF2v1NZVAK9Lb3Tv7wMR+phGxpoBcgnED2P204?=
 =?us-ascii?Q?vVEJYD6WPYdA5CHGHAm8vNLw6CW1A73UsftvAdItQLl4eK19jyhyqeLt27+x?=
 =?us-ascii?Q?XthRvpWCnya4Zk2I99MrillhFbjbLuGp7yqnarqveYccGFdKFbEn41MybPVb?=
 =?us-ascii?Q?bPYp2dn4myk9hrl/308VyhYUaR3fNd+ZWEOq2BBfGEdCd9jkHXrzsBUkY6kO?=
 =?us-ascii?Q?BfTf83PGIvjt4+fXTZVVnrqn79UAF/D4FtbItSMejFVXxhnmq2gtcOr+PDqG?=
 =?us-ascii?Q?R/v/Xh/eHUz+2Xs3NbMzWjv+v1KF6jqW2nGF7geMSBZCAhBT/JUtQ2GF7Cmb?=
 =?us-ascii?Q?XU/nAfb9uHjkGUmqAZiY8P1k1AgIzg2QOPwfGsbcG8oGmE25K+61/ONnlnvv?=
 =?us-ascii?Q?pz2FnEVkq8ShzyxRF1qPQ4XahfQIj4EhrHj8CUkdteev5iF/YFqSOPtND+gE?=
 =?us-ascii?Q?PRnr7GaS+FGc2gXu70DjsWueXs7fD4X5Kk7Jfai/FKgB2XqLLgAV51yrrhhS?=
 =?us-ascii?Q?fpN2x4MhPU31fuVPt+CgRbdDI78pFuJYOrPB6+vxnchC6Ucm38nUsDBsbivg?=
 =?us-ascii?Q?JYfNu3cMVzP2fBsdWveGji4t6ktSsnzeG4pcl52FfUUnSbblGVla5BlM97iO?=
 =?us-ascii?Q?lv2hCIZIHCz1fKSQ7v916ZPCewFpmro2by9xo6Yrgn/8oRepVuSijSkGK1EL?=
 =?us-ascii?Q?G3hCjtgfz15nRuyVF2rYTZDDjuiD4gbUpPbw/cuc3m3ZvvfMz9xpSTRMwayF?=
 =?us-ascii?Q?pqhgUnQpZ0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VUpK/T8rci7lXJLm+JIPbKuWL+HEzkDxPBEXSfVkO1qtvGSXE5drREGe93y/?=
 =?us-ascii?Q?cEupmAyzoy4seu0t53jt+pA9LvQQc+rU2RUnL8+PkyH9tOJ4PRQ7h4O5gTgF?=
 =?us-ascii?Q?cPiDqeRnmmHkrzXw4tJc0J+c1ZZOi473Ugc7/zte2yHD249VMoklnoL0AG4D?=
 =?us-ascii?Q?x/6L1usXQJfWD6BoVYs8UbunmhV/vwI3GGJHeTyx8yrTPAvg7ixqALYfbBtD?=
 =?us-ascii?Q?0EmI7WgezDXHfR4Sqm0w5gMrXtd9E+6IN5GETk7jI3qgt7gn3rsV65LYgYp5?=
 =?us-ascii?Q?kXKKi+A9aP5u5kBHD5Zl4lNAs91YaL64uVFlUw+YS6GidN/KOIs2j/hNkPS6?=
 =?us-ascii?Q?1xWKJCCgkP0sFK/BMZdoJfzxlUr/fEouqKcab16O0ouCGaqkameNYePcrWYV?=
 =?us-ascii?Q?zI18fAeyPCv7G7RGbKTdWYj/B2zusbwgU60v81IuWYFr3YF8EHwOTXBOF60C?=
 =?us-ascii?Q?yX/EgNivpwQC5G6M94dfcOSjOD1M+QNNEOwwmOimi1c2TyjLQMlJUlM+JHNU?=
 =?us-ascii?Q?066okQtutRe/LoQ+X9zYYQg124YJXP6S2fdtAdC5y0tfrppe8Ejw8VcbwdLf?=
 =?us-ascii?Q?jh+CRXYewUi1HwBX7ChIg6C7r8OtQFOFk3enLJ+Tqmjrhti3lUbPPLzBC6hm?=
 =?us-ascii?Q?IUeZr1ZeKnBh2z32ktk7XUoPlwUOHfz4Y7PprtOVDPCApEK/7tph8aEYaqZT?=
 =?us-ascii?Q?6dTuja/vqqo3adAZlblgv6hH5207/zMCot5pNLqkfwuu4yIKThw06amR52xj?=
 =?us-ascii?Q?b3asJzbi4Ic5yp9/KoJ2h+CQuJ7y8B9e0yO7zK+gVNF1q6rdUnHKWtyDRviP?=
 =?us-ascii?Q?wzGFQeP2UZ8zrjkbd+pR4/n275il7kR66ZUY/DkIZGK6si3r1vmzMzltw39g?=
 =?us-ascii?Q?MqMwpAj80SwXo/CLmNI7JPRByPuS9dgvv3pR9ll8gMhlAtv0StwozzmPIReR?=
 =?us-ascii?Q?XtQXrM1e/IzYUlHErWDpfDJYMvnoA7oHHWyH2CEuO7/I1oHcsK1L2yd+66I4?=
 =?us-ascii?Q?yTzWjo0Ay3a6kU+JPQVaoyOKBQCyfWCkcZ/jZq0aP9kT+0cluWacXHVTdBw+?=
 =?us-ascii?Q?vL+xlhmvLYqHlQtug2WwVvcwP3AXUhbKdMcjFRhty7HlUaVZfmPOSP0Mg8HC?=
 =?us-ascii?Q?FEUkuJd2C6qHvvuOSt0Uz7h3EvHBsWvAgaZA5OLRsiaJVpAe4wncvDRFYMbS?=
 =?us-ascii?Q?vE/xMuF42XWIYtBeOnJlziFUMBwSUfH8mIEX6b+mggY9RdZLe2cnL+Ran9LE?=
 =?us-ascii?Q?T4ID29mbw67/auxCNpP2+/YcxGXMla/Q+IsC0OwygY1PsWOna/uVXxHSaFwj?=
 =?us-ascii?Q?z32b7Ar8BXmSq7LacfRLTkPP3KemXEUks4qJE3/wFmDa8m55niwvSqh37v5J?=
 =?us-ascii?Q?bphjU3Eu/PTyZBGIhS/SHlZDT4YZhhhYUM0YJtZgLzIVfKcOLVpy0/iL6Cru?=
 =?us-ascii?Q?YvaQtiTyxcPciKL8IPI89eZVbXG4YFwciB9yhhTcPm10WS2Qv/5lKYKxa8v9?=
 =?us-ascii?Q?xphrr3tENcXxnEPdHWifjIsLd6kSPd2avTWx9tAul8cWSqgSXBs8xmGostyP?=
 =?us-ascii?Q?I1mEl3O/3hrFOw7UNHGJpxC6xgCOmR/hLgn2PdrQ18FlYiPRP540nAkjbdd2?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oCVpgxOrsX8NaV07LZpJNnP9O/dA7cYxKMxWpol/PaFZd7vpNRrxBkYeV2tFQLMS8Tx7SBES0VtACBIIKH9wvVa/7FR87wWxFQIhDXRGAiBkR5KBgrej3WmIUoFrPvJntHRWIEmitn9gCGYljaDaxC7lEpORenNGRLhBAkxd/RNpoa5W41p8EfilvdsaMvWenyU19ttG1Df8elxUpK0tvAqEdjILhzIW7FCM5mKv90A39mB6J8cXlCMDCD8Z2TxEu7QM3XrOOafJsWHo/xp46BAaOMEy/Pql9M0XnU43Xhp6i/jmdRQwEsB3M8g8az39HE92555NaSwITQYAGZAMosL0M3KFvUJFeZ2pdYmD9H/YEU5i9vi2yl4K0O/VtXrWu+mGVRNyf2vLSOy494zTTcqXlxjHdnjIzT7ZEUzAK06X37KeKJHNnYgKQi+6H00oJG0Uh+PWcSLozjAapPqERWDJL1ZRaX1UxIf22AtfE7F9DQBy+k5yfSYVn4kxhWbFIDB+2NKW3xTuwfMVKzQPc/XrVHc6pVYyMz6vLj2AjfB3ncJnMQcSrhYj+8CePRLbilQ+A38Cc2RGEngzsWNXmfaicgBUK2mMMC3+m0OQnOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558ea44c-ea5b-4de3-b6f0-08ddbfc98632
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:41.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+xN7TNxzqW4pOOe54uN9ROZFCsadm/8cYi7eDdA/VUl2qZA19o23qchki8Lo7itBnDvOhn6fCzV5ZffUQP5X0bX41/fxhKnAcmUbZEcxEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100136
X-Proofpoint-GUID: bFoQRc9a5rx7lyvTkVMII55nQkpbk0Ql
X-Proofpoint-ORIG-GUID: bFoQRc9a5rx7lyvTkVMII55nQkpbk0Ql
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=686fe156 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=sPQ1Sn4KH3NRjN4fEMgA:9 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX+Kti0cGZUVie kergibfHzJ+KbJqktD59YhYrUwg07qpDAT/NEk5PVIfOmJ7IJuSMTEWe1+hWyp+9PPq4Vzg/R1I z7I2t6o5MfqxR2U3IVhyOO1hMnUkXYQN5UX0AOVpD2Ql0ppehzVfwXpMT1YPKKudPedQ2NyLkaR
 p5VftLnRLBmYgCLHWqJDfjHNpNqVEr44QgayDIagplXmh+Gec07+7NSJdsn9h1qIFkStiw27zdv PsjZZ+jxwDFCqo7X6Ss0JZA3DGexdmL8Ko1rEs/aEov7vOzHxQF4LY+qHzGeQVXhqTEQLR8EWsf rmzr3OCMtfJwDyM+oisgZKRSVWCDsYKBKE4zpClF9CRZA/QGKEy8gJW1Q2/H2YupsAiH9VV08Ua
 LlmZImkOXW3nCueZAIYXY8iKKisqiE/FV89frXGaZDybjnU+b8ETYS7FtzeP5f2miJXv0fE+

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually? Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is faulted,
then moved back and a user fails to observe a merge from otherwise
compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

In order to do this, this series performs a large amount of refactoring,
most pertinently - grouping sanity checks together, separately those that
check input parameters and those relating to VMAs.

we also simplify the post-mmap lock drop processing for uffd and mlock()'d
VMAs.

With this done, we can then fairly straightforwardly implement this
functionality.

This works exclusively for mremap() invocations which specify
MREMAP_FIXED. It is not compatible with VMAs which use userfaultfd, as the
notification of the userland fault handler would require us to drop the
mmap lock.

The input and output addresses ranges must not overlap. We carefully
account for moves which would result in VMA merges or would otherwise
result in VMA iterator invalidation.


v2:
* Squashed uffd stub fix into series.
* Propagated tags, thanks!
* Fixed param naming in patch 4 as per Vlastimil.
* Renamed vma_reset to vmi_needs_reset + dropped reset on unmap as per
  Liam.
* Correctly return -EFAULT if no VMAs in input range.
* Account for get_unmapped_area() disregarding MAP_FIXED and returning an
  altered address.
* Added additional explanatatory comment to the remap_move() function.

v1:
https://lore.kernel.org/all/cover.1751865330.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (10):
  mm/mremap: perform some simple cleanups
  mm/mremap: refactor initial parameter sanity checks
  mm/mremap: put VMA check and prep logic into helper function
  mm/mremap: cleanup post-processing stage of mremap
  mm/mremap: use an explicit uffd failure path for mremap
  mm/mremap: check remap conditions earlier
  mm/mremap: move remap_is_valid() into check_prep_vma()
  mm/mremap: clean up mlock populate behaviour
  mm/mremap: permit mremap() move of multiple VMAs
  tools/testing/selftests: extend mremap_test to test multi-VMA mremap

 fs/userfaultfd.c                         |  15 +-
 include/linux/userfaultfd_k.h            |   5 +
 mm/mremap.c                              | 528 ++++++++++++++---------
 tools/testing/selftests/mm/mremap_test.c | 145 ++++++-
 4 files changed, 492 insertions(+), 201 deletions(-)

--
2.50.0

