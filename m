Return-Path: <linux-fsdevel+bounces-24432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAC93F47D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A43B1C2184B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54797145FFC;
	Mon, 29 Jul 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KAWAr9rn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uquj+Lxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E877101;
	Mon, 29 Jul 2024 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253885; cv=fail; b=CZe2DpaVzoHi75uT91lTNBxp8m429ghObL1JednIIp8z5Xz834nzmGCnHD3eeY91RJcPpKLe3Zw00qycdjt5TV/zyLHJlWqiqk/J3NXfa9zF1g8NNApm7s0r6G/rbVu1RyZh0G3kvWTz6rPqoMq55x9qPaT1iwDkmtf8zImGCZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253885; c=relaxed/simple;
	bh=2pjHq9cWa6lBGtEBMFTpkD2g/TWqB/42Lwd4a1F7U+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=my1y+sAZwYS0Igj/LOI4G/+BmmszNfNeJE7rqmytQ2m6A9b/Kb3Xrw9g0HZNOfl/HVctnXsuzeHcrElkNINMa9+I4tSWyx+CixGWbByVGY535jrOEFw8e2mfORpgD4IkBTSEsPC+HyWi3nc5V6ocjACkML5zEf8tTA2T/UsIqC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KAWAr9rn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uquj+Lxv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MWeC006551;
	Mon, 29 Jul 2024 11:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=3+ijfn2lZ5feZObkE1krecjkm9yAh32cwU0beDZ++3A=; b=
	KAWAr9rnx9lc0xlJD9skr/zcNRJDIL+v6fOo1H8Uo5qHkfUgP0SkmxT7aLSL9MLF
	KGznOJ01HLo3jCrtiZsdEcq0YIftcZ3htX6H91ODquBIHuwDaEeLCZgsboGH5GG5
	Y8+iKetiuZfN1mPxu3ONv0vfsyY9Tm3ndC72RchlRkZ6s1/34/UZlHr/eplPNXcP
	1FfcrCa7dbjBJmghipHvyP3xG5VZv23WUIMTtaiTdGL2Zvj38bMWOIwu//SMzqEc
	9XuSmKC/y4j2iQbQv/fV5aPTWQXdcj9etH335XHMGWoBulo9vXAw7JiSMpFrw09Z
	Vvw6vVwg2R5lbYIcPnaFsA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp1tcpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TBdmcl003780;
	Mon, 29 Jul 2024 11:51:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4bxm1q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poeYmszhHmk5tpVmWbNlYogxKXKnfLLKDFaIntJSYNYgIbABu6vVDLov6XC9R+DDUluD3BWA3fmkoAEhw3J8+dYdQ8hJR9vM0k4ZzCPldIhbWHk9wAq0asQZW6vUrLhOsgN4h+gZbImYg34gz3o8K819petWPOsf2JIwqdXtxi/ypw9DDmDLujZCkXVwZZHGrplCP/jeKAX9JZ6bLcvDPU9QLa16NZv6hVyI3TVfUdw9xjKGbOibcDa0wn+bxqdOtoIw8UjBJVaE+BXAbDaiF9TcQybpWSlrt8PzwfRhOSZyxFLe7cl84xUcuIBGN1DAxBH8GMveB8nafvRJrnRzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+ijfn2lZ5feZObkE1krecjkm9yAh32cwU0beDZ++3A=;
 b=rwxZRdX/RKsZ2WXXUW5iY04KHH10NBhZNNYUd7N33j1d03XXMDZ7JHFTYeHlaq1i3bEhtFdveMTmmblxreFgzVGEHC1fnnP4zTeE959IYRWOYl2NNmcNMLW0uV7wO6DAC/0q9pRE/wc+i7lLyaa9QS520U52JxmmSVuc6QsYWRWjJ7labAekCFMfOMPwhVniFL5MNytnlUtzzr+XsU+ORZTk+FzqjKnhIPYSZg0S2OG8v7E6TpvCmBSJwTf7wvmohRx4maWxvcHPb0iPaW2oxftH2/1wqmL6WwjeuxZv6B7OWW1AOb7MCcTCO9VgyUor7yj+m1PQzUWHS5etgK7t6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+ijfn2lZ5feZObkE1krecjkm9yAh32cwU0beDZ++3A=;
 b=Uquj+Lxv0GVzvvbw4Zij55OxqpzULwmsvcka1hav7oPLc2GhglbbsnxInjIgT0hgOiEaw5VYG6HzrPthFH03xg3m8g1PtJ+jASI8tiewPo0zuPkjWmF4C6TqjSFUnOmEA8LILTHgUps0G4vNC1Vxc2JqXqGzJtq3ETr3nRgWMtc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 11:51:02 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 11:51:02 +0000
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
Subject: [PATCH v4 3/7] mm: move vma_shrink(), vma_expand() to internal header
Date: Mon, 29 Jul 2024 12:50:37 +0100
Message-ID: <3cfcd9ec433e032a85f636fdc0d7d98fafbd19c5.1722251717.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c32d8b9-fee9-4368-4755-08dcafc4b87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p09bJ9FPMMfZADgs/36pWvBaotmeK2jmCv30toLMr+anl21KHlsmHj+Rfm6v?=
 =?us-ascii?Q?aYia0hwr0yAb8eH2DQOaf6Tee/LuM1x8eFhwoP5XlNWIm0jCezVdZ1eMRHNE?=
 =?us-ascii?Q?+pQMbePudzvGAdMhh3jhnBkAoW3+SEWjIDCtQ6xIWmvrzEAsRa3zZrBXMnuG?=
 =?us-ascii?Q?05gWhElkTUBoNhKQ//eEl9N0a/4V9qamgK8O2xjmW1ftWcTqB44QBIFjufb9?=
 =?us-ascii?Q?rKXG4yvIM9pGTU6oD7CFXta3VXrm0DujQD/1cCzxNM0a2oodD7oyyBi5C8cu?=
 =?us-ascii?Q?sLonkQFsNEUc7m+MOSzc2o0OUZlEZodqzzTO/ILvr+HZyt1EZWFtxxucuTKw?=
 =?us-ascii?Q?Up9S7Q5pSIs9UOIvFTCAVZBvtFHhi+q6pAJzgw9aJ9Tyz7KjyAYVxTEp2JPY?=
 =?us-ascii?Q?0nvwNd6RZ9zcZ8/4JdhYYmUnL9Z73j70iTF6MvrqevBEo2Jtkb3KlpKDta+g?=
 =?us-ascii?Q?/cwF1cIH7wmrkKNCRgNkxp/5SHKUhe90xwM3cORwfcxvPv/Eur4rLMKesfW4?=
 =?us-ascii?Q?dZlt8o5W+Bp4zBzj9k+Bi3u/V2loF+saj4oKErguf46A5K/G6Y+Aue6+sO6i?=
 =?us-ascii?Q?nfsmmc7HF88ftscDivNljNxl4gM/0uwlbATinOU8Rx4y2gsgV4HqIAngAXiB?=
 =?us-ascii?Q?ql7V6WhdK0ivTKZYQXkTqqQYVgQE85gyBb8hcn1A26lQRFKQ5Bcg8Zbaqfvj?=
 =?us-ascii?Q?4x/JZcJfhXJ1z5ZseVuzBGB60tPq8zgt42bUvnMfGVj1Db/vxOVDL/6rtBH6?=
 =?us-ascii?Q?PH4hp/AeoLbuJb4mDETahMmX4XVhOM3MpSKCFhwv/qvmrMv4+vAUd926m72v?=
 =?us-ascii?Q?eS51T9WUYdgmzJGsKtSQKhyfdHlLuGwoyBoDpzwMhQ2N2fKaQfpuga4I9kEL?=
 =?us-ascii?Q?IadUvaDy71SUf+NRHgSFN4K84uH2RDkZ3C/QXiVeaLl+Aem8P2ZzRMszMS2p?=
 =?us-ascii?Q?qYprecdcACEtP9WiwrJdXx/xsAh+lwm/s8b89cZU8kzgPHyvc0tNSEIpbPAr?=
 =?us-ascii?Q?Lil67UNr/DQZZkR3RhNemLEHVDqtWKlN7SMtpRIqLtpdXFyyDdQBXfdjU0kq?=
 =?us-ascii?Q?HMc7Ohmib80BQfy154rlQnvciqf7f/5dj4ZovjEb2poEYjZ3Yy2A7E6J68To?=
 =?us-ascii?Q?7pQnmzibXQPb8RXS8NQw3H3RWUG9Fl2koYQu9MR/wAmNsr8rt4A1ju9isJxx?=
 =?us-ascii?Q?qI3ZQE2xLZ7ja4lsLInLiOW3gosDWCl/TNJ723Fh+A4xITIq2R8qeU5IkIW9?=
 =?us-ascii?Q?Qin9wOqpwLtqGpYD9qsSbsVdFDNe/trvHjqX3TeeTehVwAqTEdD7mmov4Fnr?=
 =?us-ascii?Q?uFQc6fnhCIlWV/lgGmmOlE/iAbNk+P0c1iFfE9oOmQGY9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fhznoqBrnehuPj6fFX178fmV4xyr+3IpKTHRwUEyaZYobDXaAjT9wAZkQ7+X?=
 =?us-ascii?Q?LrAHx7IBKa6rwBzfml9coNyNMeoQpgBK/Jb4jYTTvKm6UHgMvl6Mne1fxz6t?=
 =?us-ascii?Q?/IJs1zg3sWtuO8olf3qpENHpk2PYF55EwJdLreuIh3uDDfcCXIzuURey4g12?=
 =?us-ascii?Q?a04BM5NSN5J5CQj0yCHcdCUEblVdj94PdijoAoOcrzb7p3NGbSBmKrQxct1h?=
 =?us-ascii?Q?qa8jAqrEoqDLUzYU1ZwhEgYMi3fmAzvMr3l8YJyS6i5uyMMyq9o++r7Ukg2s?=
 =?us-ascii?Q?mCzdS3SLyMq+QE8HSbu4Pfxi+iFuGoqQ7P54TNSzb6vNJpbY9dQQ1VlZZLy9?=
 =?us-ascii?Q?Xpu41sKGXX8q6yloAXXZaG1dp7SjGMw9nBKIuxoW3dFpidyfspJVD0vHYMLV?=
 =?us-ascii?Q?ZWIlqJOQBwte4vBrmsM5X6Dhv38tZwOVnv7vfmDYJWYpuak5tJxjMvETw5Wk?=
 =?us-ascii?Q?L4LOoZIz82CkqV96iCCWYqbXSAdkuxiAPkB9371d/aBZWGodHJPZ+7lIUAsD?=
 =?us-ascii?Q?AEuMfNaMKdhx5T/+CJzzRcDiskQVxiIr/bywajPVB+4dC6+okZULs+tKejjj?=
 =?us-ascii?Q?kpHUArp8YpaCciCcduQ3Qx1K1bMw2Ad1/MMtrogp2MFEzwlbfb4v2T59qWjf?=
 =?us-ascii?Q?TPnxUwN9dlU2QTx0zSDBwlIjHvvcJKjLjgNqFSMbGyG/1Kjlq2WG4D/Yr/Ox?=
 =?us-ascii?Q?xyaFJvIN2LTYz8c6HdOntq8caHGWd9Afh5UT+hFW+qp/TWghn9I5eBjNqFTZ?=
 =?us-ascii?Q?hNDibRRnOOnUO+nYeN5xf+3tPRPBZIHLU55bfddQn6TEcKevncKPwjHehUMl?=
 =?us-ascii?Q?UD2lotychGqY5nsa+WPtTk6/QqxqhMLAHepwq3r9lxOFsmNuIJwjPJYwzaLT?=
 =?us-ascii?Q?VNITOgxvqU991xXEqFNZhE75Zfe1gYT8pZVufaqi8FxRglHJpXj99izpOGch?=
 =?us-ascii?Q?iCSFJ5VhnQjfvP2SzWC/74VId6OQLMF6kNSErr5zq8WjThpbpBM3oy67loCz?=
 =?us-ascii?Q?nejyK/tCjH2On9aXgZJVMCO8o2eO7/LPDL97G9Bn5NIw+P3GGm2A3gipuRzi?=
 =?us-ascii?Q?VTzkR/7DqggdIrHAbIyBCpRcr0YEhuimPDpqBrER/Ku5iYpCjmU6Xwk9HBp7?=
 =?us-ascii?Q?Sg1sMmpXQFVW2IULSLIbIxJlObSIj41IMrJZfqWyIZO+FYYdN0vBQlX7o+cn?=
 =?us-ascii?Q?4W32iHRpm2DA4aGdxsbF4GKz8Rps6zdZ3F7l+tQkE6qtTIiGMZAY2bEf3WTR?=
 =?us-ascii?Q?9IA09mVI+iTcFLKx1zoK6Wn3tdBzfsb+K1eWsX5U820/D2mOlN6jJpUp0198?=
 =?us-ascii?Q?UNoM32wU42EsC8vbNtE5LDyghIs6L5FlGZdmyZswtOyi+REFT/41nnCCawkD?=
 =?us-ascii?Q?uTGT9YtMSPudFtr/anZzua/u4cxWloWLB/kMQIYKazZqNDzC46ZRHHgbq3n8?=
 =?us-ascii?Q?Vwm2FFPwr6hMrtsqAlEtiJwKhQ6lj4BZsxUtKGrl/sXr8498V/NGrFautq9S?=
 =?us-ascii?Q?uY3ST2hxZklLvDc/OemEfad4LaRjZEhcYzxe0ZsVvmviuSBzZly3kLMHPjz+?=
 =?us-ascii?Q?2jBZDblBtFwMlHR0I3bUVOy8etR7nm+Y3scE/NXOcKafQkMBI1mMt2Y00gN9?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jH20qeV1D/9FoHiC2PD4tkQIZAskYWc/twXG2zSk28T/pzqZPKjrpr4D4+BAOfrisi+BrK4np7rlINxTpCFfbbKhZ+bXh6KRWdL5+ABv+HwUy7I2K3v8wVujU79hWLC7chRmDHS3gU7/OQvv/yaZQQOtkxl+eHmHc09flRw4wjP27PypEeov3rnXwadMMHZh2rqhrCEMlTw7Rk5J5KwrrnKCDC7xW/rnK+pgVq1bLgHrpScLoaZz/M0TSuyI7FssPlbfwZMdcxJlSUv/MIVJZqnqU5H4aU1bGmk7EQPOhDl3cDenNV8K7Kobwb+NAZMGXDpkqccXwRyzFPq63dIxMsogRpyaK4885ebyO4hLUs8Ui34J/puL1WLCRHjY0HH6clBUwQRhAbCVIRgNJx1uVghbizK7aIArynx3vXsi+sYeV/Nf9ppVf5wpC5YXxfIVrR8uQLDzDHpqGzAMGXdjTBis3+sMrvsyDgkPGzT0pSTckn05WTp8EY+10M41R+dyWiyfdKWVansnusDdUle24zrYpmsNIvySNOU8T1OKIWogk/EN+5gZB1+KJlhdWUmcZO/m/a5uKS1X3/4R7sSEUNMjdHMH8ni1LxmAt/adivc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c32d8b9-fee9-4368-4755-08dcafc4b87b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 11:51:02.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Rj0LkupUMAx6tPteE5EdJg8DSRPJvhROjrFhJGwMA1cUrzj89w7s/mJl/eHTYkXhKv2xQaOji/6Z6+Eg1MEG8wIdNn7KAqNgtFJZvUSZFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290080
X-Proofpoint-ORIG-GUID: VKliCbX_UCpVYC7Z4_0M3RqyafbxM0eB
X-Proofpoint-GUID: VKliCbX_UCpVYC7Z4_0M3RqyafbxM0eB

The vma_shrink() and vma_expand() functions are internal VMA manipulation
functions which we ought to abstract for use outside of memory management
code.

To achieve this, we replace shift_arg_pages() in fs/exec.c with an
invocation of a new relocate_vma_down() function implemented in mm/mmap.c,
which enables us to also move move_page_tables() and vma_iter_prev_range()
to internal.h.

The purpose of doing this is to isolate key VMA manipulation functions in
order that we can both abstract them and later render them easily testable.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/exec.c          | 81 ++++------------------------------------------
 include/linux/mm.h | 17 +---------
 mm/internal.h      | 18 +++++++++++
 mm/mmap.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 91 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a126e3d1cacb..e55efc761947 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -711,80 +711,6 @@ static int copy_strings_kernel(int argc, const char *const *argv,
 
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
@@ -877,7 +803,12 @@ int setup_arg_pages(struct linux_binprm *bprm,
 
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
index 2d519975e9b6..86c9d53657f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1005,12 +1005,6 @@ static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
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
@@ -2530,11 +2524,6 @@ int set_page_dirty_lock(struct page *page);
 
 int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 
-extern unsigned long move_page_tables(struct vm_area_struct *vma,
-		unsigned long old_addr, struct vm_area_struct *new_vma,
-		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks, bool for_stack);
-
 /*
  * Flags used by change_protection().  For now we make it a bitmap so
  * that we can pass in multiple flags just like parameters.  However
@@ -3266,11 +3255,6 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 
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
@@ -3278,6 +3262,7 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
+int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 
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
index d0dfc85b209b..211148ba2831 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -4088,3 +4088,84 @@ static int __meminit init_reserve_notifier(void)
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


