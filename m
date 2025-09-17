Return-Path: <linux-fsdevel+bounces-61874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F89B7D74D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448C77A8363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 05:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10992853E9;
	Wed, 17 Sep 2025 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kZRT9z/2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bRM1VDbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F2266B40;
	Wed, 17 Sep 2025 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086092; cv=fail; b=Ntn5ghEa9RJso6pHWtL+ErRcApABZf9PPcudvOpJcr/oDVDG8tbwIET/X+HZbw3TJYW540ihUZHZnWFsu3W0KgtT0ouR+VAKid+/drRtGWAWUGtJYsLPrBChGDw+/7JCOIR74sZZawN0nII5RtTyJNLgsB17Z/sKN6Pv3lfqhyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086092; c=relaxed/simple;
	bh=CMD55vADr6Dx1HSoHwP9bk4FYqfO13d1OydUXM4jpyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S9PkU00LJzrE/aHC/rYu4reiqZBO+kDopj5bUorax2AHZp+G2MlsvnriZxjvj5mjVq5xBpJwnhNyeRROMJREO0nFjkLCiZzoyG2kUjiRf65MLYnxP7TdjHsa3tZJAsedtCgCugEUn664rYpFF3cygB/JFM7eE5wYzJT8smI0rpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kZRT9z/2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bRM1VDbA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLZ2e4032127;
	Wed, 17 Sep 2025 05:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aRe3WYoW17/EGf1SIZ
	7rnkoDlJJhqP7TcMpjbQzmsqs=; b=kZRT9z/26SIP7ODS4JSh6BThTZY22lQeli
	+f+cN4XQwZiczlg4Mekh07x/leL/IaitnweUmor6pIB2THdlK6HXl08ked88+t4i
	siq8H1X3t7vNTuRkQNOOFYV3iNnjigcmLXvL4gjSthhYROzhqob8URYstbhgwLmn
	c9kbJWCyhd56vZ0qs3zJgGmpPvLJUtiyfsahZl/PC4wcQTI0tihJjLc7vrIN+P+E
	w8iUlCb68LeFLhbh4Dj9Sni8LH5CVbzz8PiDUpcUck0fxrr2uxtMLrUZY6GYFTui
	OatFVeYvV5N1tl6yTzYxC5K9FzvhPbyFTulXaanhLhVL2dzjYwzQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb0dkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 05:14:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58H3E2ug035088;
	Wed, 17 Sep 2025 05:13:54 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2kk14h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 05:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOKG4mDXKFslDm1xQhAQSPX+VidgftMKMzUaPy8wFfZVpx/sR6RdPer1UIESgU2dC2Hove6lLgcUwTYo8FuLVdZ9xGsO8NDDyvtdUIJXflHHKvlCy/zI/L38pRCtq3zIQW74OyoBiGqGfmgPO9hUaPjeQNUvxpomqMg2hWKJPBPuKqxw1UIW8iH1eTqpdh6iSOqKHNMNGBuz//3Zma7VeQNmrNF9Ox7bGhXNZSiQb50ZaYiDucERgsFiZbG1TIMFnprRnpRqsuw8eRVcHPLqvgkMHVW43i0JJ1YIdP0EwP5JrOM3M2llIwZfmk4OW+8wlczntAdlix5lXZicSyKIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRe3WYoW17/EGf1SIZ7rnkoDlJJhqP7TcMpjbQzmsqs=;
 b=yM4XAll6L33Vg3Rq3EErd0uHSXLaaM0bC+cWeiKwGmrD8iOcYTPo5beIM5LZch47sZLTrTSrqqhLjcS+zPJQOOk+ZYwlxDZWiRAk7ouifT5o9Txz9Bo699kPCKOfvrgyX+Ey35CNrpwwFGi0PAWt+5AORtrNYi2ARj7RrFF3+D/5R0RMRrRSA7NZZU0Gi3ZjOzPZ82JmiWrku1wuFV8GoHTaehXWn6nPMEf6WQ9zJbuixGRDyXfd0HHw8ZU39+3Yd1yV+RYzkyRZpbMjB81kHEqzwAEzTJ8xf9kZO2nqxIqCDqNt+5vUVnU4aTbjANWusab20tiqEqMaFLGiqQ9pAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRe3WYoW17/EGf1SIZ7rnkoDlJJhqP7TcMpjbQzmsqs=;
 b=bRM1VDbAKIRcGbufFwG8ZzRDRMZ6AQutAWQ+uJ8XCJi4uPpvim46DoeqqGWE+ndfbOZdAIGz4f/rmP2TbckdVmmqxbVPOPTW34ma+fXrjr5avupwFY8S2KAywBb6rQmnAFeAH2FGf41La5Om/2QktZB9d0+afZwG0wnbrkHkr+E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6358.namprd10.prod.outlook.com (2603:10b6:510:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 05:13:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 05:13:44 +0000
Date: Wed, 17 Sep 2025 06:13:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Message-ID: <c2e28e27-d84b-4671-8784-de5fe0d14f41@lucifer.local>
References: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
 <20250916194915.1395712-1-clm@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916194915.1395712-1-clm@meta.com>
X-ClientProxiedBy: LO2P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aadf544-712b-416b-0de7-08ddf5a8f950
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Q9dQXLMwh8pdGUE9QF9jDJH9P36pcRb8aqBvCp24HfKHmGAJiMgpqFpgGztm?=
 =?us-ascii?Q?wxBqe1VF0fB5v1fEBEWVPVHaesMO7L7ix3NSaa5su2CVI/kq9lukzmSlyelB?=
 =?us-ascii?Q?kdf2UaA0UeTYLzcgir9oTmDEtGvyu/JtNGjM7yoBIxLwKPoG23ZjRVz3nYTc?=
 =?us-ascii?Q?uVTXwRBlocd16kE6HwvoDYPUGK+6K553oJoRS/5D4QR8K6uCfDUJi+N2gQzZ?=
 =?us-ascii?Q?Wx4DNxSGgs865moCYYK0PTHhMSwjEzvw4etd4WvmCTKrBwB0NQGgFEhK1mfk?=
 =?us-ascii?Q?YeIh6V+03iXu10KiCDaiTJhXoCQhUSiICRLGIhGPznk2SaZA35QLkKWCpn3C?=
 =?us-ascii?Q?DCQZ6dE4t3VahNy83YtYIAZ9DgVWnOz/rDMQJXHi9+3sN2+j9SEM7xmMHrzn?=
 =?us-ascii?Q?dPmNqCW9l2IU8XEkp2rkt2MaKf4LCNT9YDRqbWKH4r10ADJVHSyGbM1VCU+N?=
 =?us-ascii?Q?JeRjmNHXdVHpXnc4JUkEPswjit4ne30kuAuOTqzBO/wxCVgYzoiGN+mCes0B?=
 =?us-ascii?Q?PHtWwU46LeQbZTlzsoVNYSxf3PAfpoWxohyI7Z6bTYL++ceEA/tx49kVbKd2?=
 =?us-ascii?Q?z04VzQ4snPciX+TMpZhKwZoze+alCvuIab547va4gvaPw2AhsW9hSaCaUdht?=
 =?us-ascii?Q?hpMgaEdMINmjjwiVowgoNBseBq3/kHYG9Ezrm5OW5IAG09pBlLAn4FFVnV9z?=
 =?us-ascii?Q?sb3vUir7s3AbnyQ4sZkX25ECmzr5nVSE1fWNePif2O7I1FjMlc5okggWnE7M?=
 =?us-ascii?Q?cNrjcRdGJjIRrEL2nk8j0SNteVYb5XptFzG2iJabcnbWcEZVqcv6yCT3lcTE?=
 =?us-ascii?Q?C9kxG0q8ti8K7H94NJUTF9mww5bAh2LcU/aPx47gELyN9N0avzKr8bpNx8LI?=
 =?us-ascii?Q?+nOB99AsYXhx4sFii1MUPfinFTSskhoTGTi9I4J7zf61H2/od7g1w78C0Qam?=
 =?us-ascii?Q?txZwyKmAuXkeA0Ttrm1K3sNGHM4oqK7UBLdQ/XtR308+iAuZSxWVLdCXpG0E?=
 =?us-ascii?Q?n/9yWZyIFOqtMqke9/4tMBs6Ku/m+NUDI/WK3U5x4szhp2GiHo2X2DTuMwij?=
 =?us-ascii?Q?3V7gy7oM+R60DyOVn2vyk8C5IzD5/ftkwvV2VLjcTjfHtFNTtdPDyrq+yzCJ?=
 =?us-ascii?Q?eE30lq76NA99yAQK2xWfC9cV+7vOEb+8kCeo6QC6rsjI2KZ5UcJ4UxTD8Tpr?=
 =?us-ascii?Q?BiAF2+tfDvDzJicDfoSUV/h810krUWTqyWW0l6XgSGwNlLXDdmlkNTYXvx7W?=
 =?us-ascii?Q?wT2dtcNJsDbrQbZh1KxuDkud0iHRrlTuajJtGGMrN8zA4pKFHy1NmCrv5PIj?=
 =?us-ascii?Q?3OPtouPz3E/6Cef9pHzdYpiWaroHS7e7/4fGCixiLrm/hP0DHS7ZOb1AHTK1?=
 =?us-ascii?Q?jvL+U3bbC27i+PdSjgF0UgT7OT/mwzc3udT1ruWqqlC+qaIEH985KQY36eH3?=
 =?us-ascii?Q?xJx7lte1004=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?wPIDqcgo3g8qCeIRBpPcnYu3DOdtMuMxdbievyQLCBWkjlBFvCraa/r1WV1N?=
 =?us-ascii?Q?60xr9smny7w/9uI9qfU1P9ATQnV+/00DUsCrWKqCvwjIHjWUedecv1RKTCf2?=
 =?us-ascii?Q?8gBiOZ+3L+Seu1Bj8pujj3gVfcP9ZMP3q86uOsDadz0lw7W78VuGe20yg7x1?=
 =?us-ascii?Q?X3ErXmi4KrAhvbyOaGzhSwkaGKIZ6s1lODEGEUUT0g3NAxetZvmU0fim48Z4?=
 =?us-ascii?Q?z+tKNl5FXTDnw1cHbu5eLTiVYraI+up+S1dvDMVo2mpJsAiSjBFeu5/oA9/V?=
 =?us-ascii?Q?HVGt2HtbdhCm/FJoq5Qja3WtHyBWOhfiecdnd9PHhK5EIPEnd0bmM9F2Ada4?=
 =?us-ascii?Q?12HXq4xpLeQKYUC7mj6WTdVY02Jq/Wt9ulcQutYHblgYdtyY1AyvNIho7AVc?=
 =?us-ascii?Q?DV2uyDAFKQ6moTkiTslW61Q5sNh/72HVYBDpP88a4/vSjeyVmpp6/m1IoZ9W?=
 =?us-ascii?Q?bg1S/I1Hy+pil57VwACEB8KHxxPxiUeee4Txf+tOAGd8rjsVhUGJCuRlUKxN?=
 =?us-ascii?Q?0hOoNf8EPXni7aNuDH7qet0kl2S7GbkC5AQatTbwMNUZe8DhzQ4GmfixRxrK?=
 =?us-ascii?Q?d79yO99FytNO4lAHU2fQQxJoK5dC7slwl+AqtBhc9WltX3d38OaIt9mu3IZy?=
 =?us-ascii?Q?I8mYXQg5r2ug1Acuk1PWnxsbmERnzgUFXOkprfjU2as/RvDBnEVbqjas8z7f?=
 =?us-ascii?Q?NIccqvIyH1+ZiqxmJ/f7N1PtvwWq4cLF+GfDZoPhzs3nJs6nHELlhhBObqSF?=
 =?us-ascii?Q?XZdARC4O3pXXTYjFWG7RZa6YrwmwJw8rP2pCxwUTvBZPV11MTEyNFlr7UQkT?=
 =?us-ascii?Q?fAHJupXni8tVNEpONiT6+LsNqkfKaXfGJGRLFszJx6F2hpDYSfRXHUmD5wDV?=
 =?us-ascii?Q?63bFgNO00QozdGmmtthou7eAcEuFszJt20+JWlStfFChGdVhZkueF06KzA4z?=
 =?us-ascii?Q?LaqB0SMFg/HbokXUJtvBzMD9E1yKSy5MRGZ96lmzJ/ZMDazzryVkNdJUcYIB?=
 =?us-ascii?Q?BjyjCETACjFBJVFrOLlsNweJXIPSXmRgjjW8HM7sIYR8OD3CWrXXRw931Sqp?=
 =?us-ascii?Q?QAWsSrr9zZa7BzttNlBOO2oR2Ry+c6H7PHViuxuYiHji2gI6U96X5fWYbwKX?=
 =?us-ascii?Q?PDqETzsx8lWQfMrHXfJoQCD9IsEZgLAVdD+kCAENq2Zck0y9NBlrp7wdnAt5?=
 =?us-ascii?Q?nqXgJbDS5BVr2odbnyN/YjJG2VqsJREcPm0eAZCfwSd9o+WyLXJ9FBouYws1?=
 =?us-ascii?Q?Wv4Lf9aveUFELDWu5Q6YclNVonCuJZsyxwMGHHReFfm3/tRgUnuft4XJG6te?=
 =?us-ascii?Q?oP3NWDiq8zG8wwB1pwOUMV3nEl5UWqRbj/x77KKayCmdS4xgjXIr9sIj8Kp9?=
 =?us-ascii?Q?Unq8oV95DnmJG2TBpVK4u60k+brsHW1Bi7ze8vA90BlOo3WMsIjBoFKy+1La?=
 =?us-ascii?Q?bjgNXz2lFq0625usoj5TVRyta0aLbHSdCSWx5pJgZQbVZmdWDyWXk/h6kUyH?=
 =?us-ascii?Q?bgWswKRdsNWwvKGGe2SGw5WR2RQ6/u1vb6acsu/v9rjRZt3uwHGHSubyU4UQ?=
 =?us-ascii?Q?HMmSirMUk5CA1mSnSpZVJlK7SvQ0SekAZMoAqCpZ9gB8T1vXxMOAjs+kThJh?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mNdps2RaE7NLjDd3/avrJlmTtZB8kxIuzsLBNgFGuP46EW80KE38S1xp3H1COnxRZvNiU5kpRZBviwB9lsFuyU3QfSp4iYcAobCAnl77PdSqxm7U6+aDpjN+iG/9QibS5M+bWbfPxxi9W2HXOhoSOr7MfUZfHzrPZlpJeedjDoVMcTQTNC6DLDpdFQsqyJInZ0NFCE3ylww8ylxaLKn9gTMXG9rqkCtglwEn+M/rkrbH1+W884y7KrqQWFIYDK8YNclj80vC35lfpzy1cneR+yUK+ZMHIpukR6Pk3JpPzaBIw3cprhBdsa8AuBIROFqrn1foi22Nxz0+R8dmTlvI1y0yTV2Pxf/CeZsfO3+TLRhNDviNMj10+uYBXeGfNVKXCi0v4v03XwfAfBwJAi2w2NWPBokAjoPxtawfduXo72wZF/wjLAfhilVqqdW0CbAoHz6knP2V4D6NKfTx+ipfp01NfsEXw/hc3FfH3egBKi783OxDtPrLl2uHE6oG7uu9I9wQAKIFOyxQ6LhHa6ISif09XrBQO7vi5SdolGl4Tx+DF7zPCBqLwa/uhUENYgCL65RGDUES7cHLvGHbhr01oCYMNcvoX3bUWvG9AYu0+LI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aadf544-712b-416b-0de7-08ddf5a8f950
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 05:13:44.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82VzTqd0JuYP3SwnFj/YTPHt3h/Huo2SacBOeIKFUyJCAeaYTn4mWgdJn8vtpF7vyJ7XGzTxs+7S0eXw1zEtuVUoH8XhASEMXKiOAMpG/Rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170049
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyn1rugTe563l
 cUFYqrCmmv7yviKU09eXwI7LhFYZOeLXXFA2rujU5ox/L2YmKWRky/zT7CcdkGyNEv0F/UG+FjA
 SEHTV5NLDUaq4G/CIgP1duSCyXTJ1x++65apCI+iz22o3rVycHEUeEHyW5GbL5/Jxb/LxRNq3T2
 So6FBhGELY2ES9yf+dfIUnfQE92mK1X5818hkdf733eknCuMoV6XqAdqox4vJ5QoruXzfcmXKTJ
 5rU33fRi+h65vck2drnSeg7TkEb23FgyDofi4PB5RpqLsPpFVakVgQeYTXaMuFl5d4AqFo7MvzI
 2Xz+QWmFuwBKFt+3cju1RvY4j4R+kT5nkphPMtSiAc9atMgdhdAKa/+tdkYtNficshQI5OihZNA
 Rc70arD9X2+sYW7n/J0vXTUiOyN3tg==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68ca439b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CEiIWBH6ALmlvMpQfLIA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: yMFq4wYUwx6v6hvA21I7bAMO8oyPTe6V
X-Proofpoint-ORIG-GUID: yMFq4wYUwx6v6hvA21I7bAMO8oyPTe6V

On Tue, Sep 16, 2025 at 12:49:13PM -0700, Chris Mason wrote:
> On Tue, 12 Aug 2025 16:44:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > As part of the effort to move to mm->flags becoming a bitmap field, convert
> > existing users to making use of the mm_flags_*() accessors which will, when
> > the conversion is complete, be the only means of accessing mm_struct flags.
> >
> > This will result in the debug output being that of a bitmap output, which
> > will result in a minor change here, but since this is for debug only, this
> > should have no bearing.
> >
> > Otherwise, no functional changes intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> [ ... ]
>
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 25923cfec9c6..17650f0b516e 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
>
> [ ... ]
>
> > @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> >  	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
> >  	 * possible change in exit_mmap is seen
> >  	 */
> > -	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> > +	if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
> >  		ret = -EAGAIN;
> >  	mmap_read_unlock(mm);
> >
>
> Hi Lorzeno, I think we lost a ! here.
>
> claude found enough inverted logic in moved code that I did a new run with
> a more explicit prompt for it, but this was the only new hit.

Thanks, my bad, will send a fix-patch.

Kind of remarkable/interesting nothing hit this though... but not necessarily a
good thing :)

>
> -chris
>

Cheers, Lorenzo

