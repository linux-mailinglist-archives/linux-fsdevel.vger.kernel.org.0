Return-Path: <linux-fsdevel+bounces-57625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333AAB23F6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F7D7221E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B328C871;
	Wed, 13 Aug 2025 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pN7x/fNf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XVIxr6Oc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5AD1A9F94;
	Wed, 13 Aug 2025 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755058769; cv=fail; b=gBoXuUUexEWQ1dntVXceYT0ipjrr6hnua9VOBYR+r3C0fpJd5+dmt3FXm0onc10Os1BysP2LJ0h+X5OT/iXcxpe5S39AxRLZFt2GNMln9J9chiV0sBv5otFDsUktdaqUSNOwk5hfhbcAkajIA26rVsbEWr7zF6/y/HbGcAjAL3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755058769; c=relaxed/simple;
	bh=/TEAiX4hqOsUNmjHlLjMYLgHNL+7k7gNinaTphfgJPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pv9nnVlUpYWXtE2D0QmAPCvzGzrYFoOPXrDI7l0L2t53vTJ/g9HpRftyeVQu7KJi2fAPasufLmWgcuQtRawa1nRLl/GIZbLhn6uWNYZ9TyS+khw4XzemrslAP6ZwKMEJl6qy6wHUPmG02wNupbS93LY6hH/TnHYSk/OSMw1o8Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pN7x/fNf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XVIxr6Oc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLQqfw025465;
	Wed, 13 Aug 2025 04:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yAFb4O9gCBsZ7O8n+y
	cCAGMnpWOpQVnMKu38kePo8JU=; b=pN7x/fNf2Un+SV0810f39vf2vPRqYkbd2I
	tBubg/0hAG77B63i6wAfGVS3wI7EHYY++qnD7z0oJoS+YTiNo/uoUTVOhloQdsH5
	jb8t4OtYZAjpkeUwFwzIlLcFoKgiXWWx1j0IEZlVQeEDqdRvjGrVtY7f8LjYi6Q8
	evZShkk9B66qEpNNaKXLGiyHrFKeYIGh12us0G2OG07kpHndIVdciPCfyoD9pneE
	uN6q5n9na+Ly2RdgWcjnJe0N0i+gr9vIhdaSQFJaK486d20JwV/5Y0I86AnCd5fe
	OK4CyIRGfSIn43i4aXbTBvELayLbZBcNyQxoyIbGJaKVzAz/NsbA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4ecn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 04:18:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D40mJd016848;
	Wed, 13 Aug 2025 04:18:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsaueh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 04:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6sygIJsTaoS1czWCkxUGBLUAMRkR9zR4fnYrUeWg3YxN1SVaHBy5fdhr2Mc9F+0f5ZTesxl32qUXh+FDwgg/fywP2j3eN2ozxc0scgsNpEBsK8fPH9desmajckA6BG1trkb8IZJLQyIgPs/6qZhgWIM09fhv/tC321D7mtk/BefzeqMxw7Ny0m7njXRRJpUTAQLWlXQJT0A50M8m0kyNt7wLTKS57ghoS0Oww2YxRdY/vmD+coPDAesvnWYDMPsgEnsOlOax/aWHHDrrg5NmBNkonehKHQr0ZTjSJDWYjjvtMuG0B5FR6ySEHQYyJmKE9G9qq+a9NuC/5c7e0q8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAFb4O9gCBsZ7O8n+ycCAGMnpWOpQVnMKu38kePo8JU=;
 b=Ydi65EyVqUfPVH+2CXqKy3E1lnjSTQG52YFxA8Gsj0gPOEgoH6QWoFnChRQTcmu8huAMbS1c+ToTGymjAT+FgA14gmIqPE3OXff4qUlk1lkeIWx4bvM7zxlUId79U1dmGSO+1/Rx6XJyqZR/Qgp96jviwQzgAMaFIYq0Cus8K3TIWz4RLX2OeUSbjsSl8QoareP6EVoogyFOQrWUealBWEbpQYa1qxd1nayBaYAF31wu08+uOWlDUFmJqQ7ciT5Bsa++YOXGjbiUJFImAdmrRnirHierrmXurHThDPN5N20TTBHSD9q8Q9RtD/BQ1vCAL9NWsIJezuHtIZtl/2I2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAFb4O9gCBsZ7O8n+ycCAGMnpWOpQVnMKu38kePo8JU=;
 b=XVIxr6OcFsex9lVtnIm47ybPDY4VxgqbF4UgTzwrEw9QIjVaRIiJk4e4pXBzTA8y5KJ52v1ED8X8LwbTYuo795ydZxS+0pH6nWSi25NbDyrN6BK/9GEcUmuuf3f1jQoGr/QL6rF2NgIcFCOxP+WMpWFjd5TjkSazJzPuT332H+I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4265.namprd10.prod.outlook.com (2603:10b6:5:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 04:18:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 04:18:34 +0000
Date: Wed, 13 Aug 2025 05:18:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
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
Subject: Re: [PATCH 00/10] mm: make mm->flags a bitmap and 64-bit on all
 arches
Message-ID: <af5492d4-f8dc-4270-a4c6-73d76f098942@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <20250812201326.60843-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812201326.60843-1-sj@kernel.org>
X-ClientProxiedBy: AM0PR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 6832ace3-4b8c-415a-1918-08ddda2077aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ftu3FEiNoUMkyrILPbB10HFUlNa46pnvU/0cvdYfg1tC7f9BdoQlaZQtROPH?=
 =?us-ascii?Q?vHWd+rjhJAE0E/yyNnLYqGQc4IEF7c+W6uVZSW6hphCCpjd4MMJFTkDXVvKX?=
 =?us-ascii?Q?B6DP8SUkI3oN/rEbLl+mp38LcZ5ZroTmKnMAuzVRTEMG+m16PpUm7ZcZHNIs?=
 =?us-ascii?Q?9xLzw7/1RVLVFMLa9EXjg6raueBrlhGq5zQod2BJpHwAnF+qpkDaxAz9Vl1Y?=
 =?us-ascii?Q?2vRCga88r+vCkxk7UwUZTPj8+l2mav7H2uKgFwafMwhV1hwyLW/64I/rEDTw?=
 =?us-ascii?Q?aOwZMXDDv6QEdfCiYXPzaO4lsNKaxg0jceZG7sIlPHLugX0o8vKJlJSsA6yJ?=
 =?us-ascii?Q?v2D5HcYP0H9vXsVL6xN9C4O3zDo9r40IOEt7G1n5W7zMibBQs03xB78BAKEf?=
 =?us-ascii?Q?2vA5dn0VdzR/w9Osa0wTjlbhJR0ShWUGuVHPVX1Wnb+QPGzWB1gLn7o4D/bv?=
 =?us-ascii?Q?Y6ymZVygh8jsTTtmpyu6pucnHHB/RgXj9F82tfXXXs/ZEmK3nRx17Ve4b7AX?=
 =?us-ascii?Q?aCbiXFVJnXx2ZdQwD5fJCQm7XsSy4Se1/0lXhhljmlBfaGdNjFriaky6ePPv?=
 =?us-ascii?Q?feCa562c1UQ+GkManWg7xybk/cxYdDYsW63Ld3JtFBjrumAzkb4hsYx7LwcE?=
 =?us-ascii?Q?ZsKzLVnegDI2aedw/ZcCOhRcbU8QuWwFUHNJvYkKb2UMDyf9+K5///kVvZd2?=
 =?us-ascii?Q?Xx30qaYAdzmIqa+vkWmvHSXgXxSQvs+DsSQ7ytwNzU9WcErscO1RK61yT1zm?=
 =?us-ascii?Q?rg6HSvTuqE/YHXWi7AU21kyWzdmueRSlIailY03qAhjY4QprJXBAMQ+Kiq1u?=
 =?us-ascii?Q?Iv+pj5+wWqNZQBQRwkZg5eMX4K9o2Z8YRPnA27X9hOhcpVlNVsI8IuWpWkSI?=
 =?us-ascii?Q?dCfie8Q8PNJnGZoJhI4pLsljx2ex92NNL6S8nWmKG2J5VmTWeLodpA1pxoop?=
 =?us-ascii?Q?PNHzb9CAIvXYBhRQ64gMfIg9fA+7OW/hFLIlVhpdi75wGwYwsG8WArydXwA/?=
 =?us-ascii?Q?cidDnoDEIRctPIhQNj2+0RkiNdnpwyj2Tx8YMtcjWhuntIk1TCv9IoIkLwHy?=
 =?us-ascii?Q?hM2UsQAtK4eW9+0y2xcyyqvf6Jml65EF9846Bv5wHwP2DZJECNssZCaXCURk?=
 =?us-ascii?Q?dMRR+2Ev/Du1pTj3DFcSq4Jlq3rNHY10nWKtcAArkZS7DgijAtqhY6N7qt5P?=
 =?us-ascii?Q?+rYwJBnalwZnkCJaSOGXfKbwGSQxTLRKCYI4AdqAo4z2OGLsKYGoqo/02AI3?=
 =?us-ascii?Q?2awErhjy16kiI9ScKBpePVJtyWAbJv7sXlmbEdQSMmaMUjCzco9l1C1942xL?=
 =?us-ascii?Q?Yhu8c6ueRDLWn9AB1BZVQvaA/+rQq1O0YFppdnR3zjuMgo3Eqc260PWshNLE?=
 =?us-ascii?Q?76oZylg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2Uh6NLuwYoIyTh2V0woH9y5Wcjvbi2nCyecoIWp+zt9LT+8IgDsNnaNDriV?=
 =?us-ascii?Q?+0UvteRCjXquLqYIgGXpXwtOMTS9TwT7GHXFjEuNl6tLbaHGZdww5ime6FA8?=
 =?us-ascii?Q?bJ5ZTz5tInr1CTkjKtqfN7dpqwJcZ+2tIihLHC8GMs7s+K/r59b01JSepiNS?=
 =?us-ascii?Q?LI+dNveZ+aNSOU7Jhkphj9AcI19jLe821wCNkNF67JTOC/l04dj1Bds3jP8s?=
 =?us-ascii?Q?O7NCqZkdJ4G/Fn62B87+DFGVqxIIYgrBpvM+gcZ3TSyJ2GgCBO5dTQS+9+GQ?=
 =?us-ascii?Q?Ok+VwU8QKnPbTRqE4GzAcI3CVRSmKwL2T7BhCXcW6s9jVOdeESwphyDv6Lyb?=
 =?us-ascii?Q?m5OZ/Az30Mc675uWuBUXy178W3fyUL7SZFm4BbyAyTXePxgMdFzi5AhLLSMV?=
 =?us-ascii?Q?bo3D8kur7Hi63XvPOmYsVrcvhq/iF1bpoUMEX8/MRxGH7lx3Fbyul1NG2x2R?=
 =?us-ascii?Q?93i/ZB1Fm1M4gYpC59uxUvWEQK9JJR1VlsXDtkceinAv7wEtEHSBZVSTYjel?=
 =?us-ascii?Q?mDM52wluLLIGlvZdRToxQHjueOR5eXQo1kANF2h21ybFVoRaQ0kkt5928uij?=
 =?us-ascii?Q?4+oNoaDF0Sbm1am1mgMTxshHBl4oz0m6z+bAxXSIbj6HuwvJtlk089Qg8Bns?=
 =?us-ascii?Q?PtHzWcgeYfUnoR0XznOq0nBtnIx4Ox4/IjPUQT2Pz56hZ+e3u3XFngpjqn+y?=
 =?us-ascii?Q?kSsn+2X2dakMEGHEGIt3lONd9NkNTEgmrpIWtAy4iDHu3Dr9asmzWF6OPNfh?=
 =?us-ascii?Q?low/vCQFWmSEHWbXgrxFDCL4Q5tU0tplRyZslumbkG4EFbEp87NiLFRIO7jL?=
 =?us-ascii?Q?dMlDdxmZGCfKTAaq2GiJDZQo97ZlcdPmst9Dd8ny7cADj1k1o46K2PL4pX9Z?=
 =?us-ascii?Q?8b/r9eFPQyXQSzpK24gkBLfThvCDbtt++PVPOLuX91sWkKMRFL/1MqnHYUKw?=
 =?us-ascii?Q?o4amhBXksCrKsM1Gwtex2syGQAmH1XTFXMy6TXS0ISTDIJltbRnJPQ/xKcX4?=
 =?us-ascii?Q?Mpjy3R6EMhb9XqcJrF8HFrnb2Aq9ux4uVFLpMTDcMhln6b2VRsr3qalFpJF6?=
 =?us-ascii?Q?XbipFpgvN9nKpNbP9NZ8XZYMxnAbFDZYC/8Ri/yZ0TMUzXDr+dKrD9sTFDB0?=
 =?us-ascii?Q?nzhXUX0C6eta9OYjQ4y1mduwbAXqE1tDgKyMO4bf+lZBGxqV4QnHIah8NJK5?=
 =?us-ascii?Q?N1m7hBiUBEARRmvBiWfGvApIRDjM66RRt+h99EM3drWWL47UOI3AomSimzOD?=
 =?us-ascii?Q?YKFapTe37Km1Z5ib+UVu4/IkqeB2cRjB31rLQgbx1V1sbwFbLBJBPic/UQXt?=
 =?us-ascii?Q?A/BC51bv3tZJSRMNj5dAbh8/y9eic2Jio7SLuhZlbyL4n7FJ3HQGf2q822V2?=
 =?us-ascii?Q?DCDiJ+e9MnYnjhZ/aSjb6QoEp9JEDbrxh40nFoaNxCtCpGIJ8ghvXZT1s2YO?=
 =?us-ascii?Q?qSF6PHYdp04vxVzD0t7DEEI6+e9IdIGJIePFCKBveyIWC17op8TcGUJ/QKXc?=
 =?us-ascii?Q?/wPKfO0uBeA/OJOBj3NiFcjkSWNQJkAxvEp77FXyUBfLFlf066xab6MG/1dy?=
 =?us-ascii?Q?8T5uKjwWdf89yMQyNOUZVKLw66T3ViDR05BUnybYsqWY5DEWgo2SGhyShLxb?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r31RXHcsoMf+JdfyP+V9hcLj2SfEOPfkKkKq3SP/CY01zBz836wy2Wylz4Os+hZD3r7b5PEJbRluzVE94Sv15Waoc1z3A15kyWrYbTWeiqvbZTO9kNojylVwrIGd5JwGNJzuDUXXaskIRtufETff3muC6LjuQu4YP4qHETlEz31nXSk4C7J73GttVnAgzlZEEPB0la6gaIbJ+XK6grYMYeAlAdURxRVg6IUXQyKbFJVn1+Z2oGWm2X/5EGlNKV+VgFgrX1rCzzJeJcN9dspjUEAXSej4lDQTsb83pYXV64N0djtWtHhgvteH7PzK3KKKGycaVOVcPqQqdWVMxgOkOWeK9giNmwkFr4Rpj6LZm6XRYUfSLOlsSl0maCQ6KcX7u9D/PxqR4aXNA/kLcPqUiQbFFatV21z+jAr7FEAGaYhrrhgZqXePnv3cDxbiGS4BZj143cF7mrbMJKcZuAeJhhATcSFEu9K/sf+54TFFs/0Bkt6FZKzD3Gtr/g9k36ji80jg/d53o0dgFTn1becSYmZUW/YVyWk/YLGLoqsgBVeCYRUw2DOZ0Ey1P0QYlT15Ofzl4Py4mmrgBWxaPJS9KjsdMFZIPwUgVilwtXa/s9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6832ace3-4b8c-415a-1918-08ddda2077aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:18:33.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9wh1EpkDmg3pUcuZ1YZ0JXid/kuOT/CH55Tbv/aC/kwxcN/V8gNLTKIoA44NazUYc9ZPEmNgfyGp1FDHXKOIoaxrwjSRnjNQjcgf7bhuuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=918 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130039
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDAzOSBTYWx0ZWRfXyv5L3+I7kY/g
 RvFSs1E2D+XiPaR7zQvBXPRPKRmnWhJUyOJZhOZNNhaIxDiuJf6FpptVRjslTAd0IZyDH1OShd1
 8k1NwaADvGBG8DsnaYLr5exavg/+DsIYFRibkufeS7CNhyfDsgsk8TCiER4UWZK6duZUjmdQSsh
 oiglK3R9JIMNGPDZrsFQa16bsS3uXKzCdCNh0GOIe+4bORNRk1qnpVa1P4g6pNs9DhjHUK1962I
 ChC00SeqyqiI/yd2nPSKgbup1zNijTxTFFkBMV93lnWU3aADPuMVzuUI3wrrt/EGxrq+7az02Ik
 e85w90o377jrEBaTUyg+w9XmE3xkQtnEhdIop53pQ+y6ww4dA7BU1k/b3F4HByD43mziRn9bYGE
 TRiUdSkEJBZJ4E7MIycwtIn5kHQF9q/6jub5tFhzAknlBd9R7ryukqMbWdozgjEqLCFQW4+x
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689c1222 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=62kRN-2s6hhlVKekPs4A:9 a=CjuIK1q_8ugA:10 a=mDVER0IZTAoA:10
X-Proofpoint-GUID: nSXNLEnfb3uAk47VeQeDgRoMnrHWqEAr
X-Proofpoint-ORIG-GUID: nSXNLEnfb3uAk47VeQeDgRoMnrHWqEAr

On Tue, Aug 12, 2025 at 01:13:26PM -0700, SeongJae Park wrote:
> On Tue, 12 Aug 2025 16:44:09 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > We are currently in the bizarre situation where we are constrained on the
> > number of flags we can set in an mm_struct based on whether this is a
> > 32-bit or 64-bit kernel.
> >
> > This is because mm->flags is an unsigned long field, which is 32-bits on a
> > 32-bit system and 64-bits on a 64-bit system.
> >
> > In order to keep things functional across both architectures, we do not
> > permit mm flag bits to be set above flag 31 (i.e. the 32nd bit).
> >
> > This is a silly situation, especially given how profligate we are in
> > storing metadata in mm_struct, so let's convert mm->flags into a bitmap and
> > allow ourselves as many bits as we like.
>
> I like this conversion.

Thanks!

>
> [...]
> >
> > In order to execute this change, we introduce a new opaque type -
> > mm_flags_t - which wraps a bitmap.
>
> I have no strong opinion here, but I think coding-style.rst[1] has one?  To
> quote,
>
>     Please don't use things like ``vps_t``.
>     It's a **mistake** to use typedef for structures and pointers.

You stopped reading the relevant section in [1] :) Keep going and you see:

	Lots of people think that typedefs help readability. Not so. They
	are useful only for: totally opaque objects (where the typedef is
	actively used to hide what the object is).  Example: pte_t
	etc. opaque objects that you can only access using the proper
	accessor functions.

So this is what this is.

The point is that it's opaque, that is you aren't supposed to know about or
care about what's inside, you use the accessors.

This means we can extend the size of this thing as we like, and can enforce
atomicity through the accessors.

We further highlight the opaqueness through the use of the __private.

>
> checkpatch.pl also complains similarly.
>
> Again, I have no strong opinion, but I think adding a clarification about why
> we use typedef despite of the documented recommendation here might be nice?

I already gave one, I clearly indicate it's opaque.

>
> [...]
> > For mm->flags initialisation on fork, we adjust the logic to ensure all
> > bits are cleared correctly, and then adjust the existing intialisation
>
> Nit.  s/intialisation/initialisation/ ?

Ack thanks!

>
> [...]
>
> [1] https://docs.kernel.org/process/coding-style.html#typedefs
>
>
> Thanks,
> SJ

