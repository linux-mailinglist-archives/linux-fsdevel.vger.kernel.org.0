Return-Path: <linux-fsdevel+bounces-57622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0AB23F53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C3E7AECE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8A2BE03B;
	Wed, 13 Aug 2025 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rdGwLtFu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vVFoTMHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC42110E;
	Wed, 13 Aug 2025 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755058368; cv=fail; b=IfehUYS+8mVr3p2sK7w2wh/aEIvPSZn3R3LYbwSEoGIdWdS3CuCiNToi4nRuhMdGmGAbxHC9IfsYIixb+j/v9vqYwoZUv1lN40izIOMN/lyPIxVwdik9dqxhZrw9au+suV4LtwqMKvJqXx5oLJ613Jn8+59+llBRihHc8qIR3J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755058368; c=relaxed/simple;
	bh=LN5knO3NVhKGiJppgUKBqAKzwOatBr4tXCgMydCQ0ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N9UuWozMumlb0Mf3Xoum4Q1C/IpnQdTTn2eeRMxp1YJbyYXeTYoX1N9fz4nrxB69OuHsNPB9PgqTtTk6fGT9niyf46NZZpgOFZyJPW8QNR7nS6Pr7UZz8/01zHDGuRO8Y6Y5cGLF9XMRgzxpHLBw9QvlK5C1fZYMMvqq07GGwBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rdGwLtFu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vVFoTMHC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLQr4k010614;
	Wed, 13 Aug 2025 04:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HkMEYM6sSP1X/57NjH
	pRLl4tUNUTzYgkHBOss1++7KM=; b=rdGwLtFuWVCGBoHPKQ6zCcTnJJR/O/r3iL
	OPiBBIm02CJb1FP8Rak1tkNIYejRcoQlnG+ZcQ7JqVZXfTR/UyDoeHip83dZJy31
	H0o6SJiX/4K3vHeLIAIyhjjGkNRLEnb5V05PJ3wWdk4grqp0mH32N125/kaCcAXx
	3inyfQcXrtB0RIJdZmsjOwPdsBeGiyVH8ANrJa7ZFA+xYfhvI2iLsOTM3XApsahT
	+JaxuSLt1Tp+b6d6/Pgvu78XNZpfc7QAokB2IJJlrOUuI5k8zq63ErJIvcJi06sh
	GquATFBUTSa3mTuoj4blGtcyw800d7U7wQKF7wNvNWAWwEV5+uTQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dp89c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 04:11:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D2FDr9030129;
	Wed, 13 Aug 2025 04:11:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsauj92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 04:11:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMzPsA57feD6ijd9qeyH9CuhoeH6juburjDX0xH5nOPuZF5JWgmS4l7kD4cRGhc/iO9iIoex9WU6yxZj9A3HkrkSEjmfAItmtdcHpayepo0XSI0eG35koZvwyIVKevr3lnFLuiZov1QR1jmkLQsKRZ2f3Q7AfWSsmkKwjalbX5mt3bB288R/k/E4Ehs1VQwznklFFI5KRO+wJUqUSR80hn/fFnThb46TxKv39RitFj6BngHBmbgEVPGWtO27EGci9i2/KocGS3LczZcAZwRmNKPfhgNp4/PeqW3fmDh48iHLlc5WPGAbzvEpiHr9DVOQaR4L/2NDNXNnfNF59ETN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkMEYM6sSP1X/57NjHpRLl4tUNUTzYgkHBOss1++7KM=;
 b=zGPnuMyzN+AoapjuAuGEBjlLReYDKZAZ+VCFtAHj7RE+XXsRoNSQZx8iZCnW2iALzAEcRdHG1AmAwMch7J0AKPTuesCF6ItTSmS0C7XEQn8RuGWnqCk8GzJdvtOWysc3bqBNR84XGHasl5DHCMBs8b1CpeLvx686MvPGhK9YygKpfX5ofz5bRac2ApHKgrf9uhgcVrpy6OFfMva8kfXflNwykRAoXc7GBoZV9h+pVfvRGPxNE0DWsYO1GQuiLcBJgqZpW50cttO1n0kXFum0uOOxJqQMHS77rRoCsCgvtccQb0E5Qu6GE6YNCkpHLovc3EgOyFasJ4GYEoBiEaJSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkMEYM6sSP1X/57NjHpRLl4tUNUTzYgkHBOss1++7KM=;
 b=vVFoTMHCAAn+b/ETCunvT4jwXv7rRhCA1UpnVTmQyi9epmpvX4C5SBsGFzrfpx+vVPmaRAz0foL+rsEK2Luvv/4ZhDmSMNOBsi6i25j15mS/Zyk+s6sGJqcolGa6fM+J0YSfcLBkJBX1HGsC4edivR9aO9AfZmp+4u8Yl5w46Xg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5683.namprd10.prod.outlook.com (2603:10b6:510:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 13 Aug
 2025 04:11:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 04:11:20 +0000
Date: Wed, 13 Aug 2025 05:11:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
Message-ID: <8092b7e7-935d-438d-be16-28ffcd8bb7f7@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
 <20250812155230.f955c6470db223bb371ac683@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812155230.f955c6470db223bb371ac683@linux-foundation.org>
X-ClientProxiedBy: AM8P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: d6235dc3-07c1-446f-325c-08ddda1f7583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d4dEtTL17ElIQNRfYbKSUt6qutJGuim7b/cB02IDrT0IuhTwAT30EH0LnCeB?=
 =?us-ascii?Q?nMvVqlD0mkkPI+rJbXDJIIib6D2p3vVlX3QCwmYvP7cpwEkhgP0THgPykUZt?=
 =?us-ascii?Q?KUs4pTbyrsT0xvDscXNYO3W0uUxBMX2pDmcuo8Npmb+VORY1M23eeVmyZGpK?=
 =?us-ascii?Q?j3gkxgF9J8LAmUqCO6AehokXfXmt2PZ+9PYK771RKfrCr2oFdwFhPKmIs2y1?=
 =?us-ascii?Q?wYrhYiqXj+ynztTMuXhahTDwothOlJ0cpV0nidCXj7/Fb8c6pdQ7VFBvmI1D?=
 =?us-ascii?Q?8yhQs0ZfW7P20IxuhN9/zMCGWJjrtvUcjH7lR6QpEHhRSsZmAcDwtMG50vwV?=
 =?us-ascii?Q?CteQgw6LNQnazMj/QyTLIZySoK+4e9tLCdk+3rROFDG92edJJEf6kOcKu4sZ?=
 =?us-ascii?Q?Ff1Lucw2j2RwiLFY/qPcMBB4bg685KvTc+rzLXaJZLWgJaVoX04N5hGeuK99?=
 =?us-ascii?Q?8y+wJ4B9L2v6SmO+xI5RPqJWmY5tzuPkCW0X3tlc7nZ5jP2xDpz7NArVRBLn?=
 =?us-ascii?Q?tiHs9Be3Cm3lvpsLHZsFAYG/Na9sXUF5G7jkZpRiClgKmBV7udnUZ1lbWjyK?=
 =?us-ascii?Q?KYhE7zVnoCiVrmwvVASYKP++UjAaeaIo8wqaaAf8sFtiz8pW3ocHHH3ScH4W?=
 =?us-ascii?Q?DW4L2LK6dRiM3uQ2n73u0MVUTZI62eI/cIERLCglF4XJ3csdk4kPTETvvVlL?=
 =?us-ascii?Q?KLR9PW6VBupekH12r1ffs4gUAG+jZabUGz/1fj+LCmTdkST/YDQUkkjCDAug?=
 =?us-ascii?Q?2P75OWgSU/gr9CuKms2BnGHnZo/bFHIDBvJ8zicoj9mwpPBZcWwQDQWALimQ?=
 =?us-ascii?Q?N9a+u8D0CrCbhIrHXE9cj91tOXiByWDgZgCKkGX3W0zz/K/rsf2zaYE17NTP?=
 =?us-ascii?Q?dGw25SHqHzyUK0gbBs4wUDTJDlk0zXD4qe1dhMySjtzVnWkG1YsY6a/G6/3j?=
 =?us-ascii?Q?xVzq4p/bPaPLpuI4wEOAV7xJvN3Gsq6/sfSyBuux9fB0+J6N1yEc6Ojo/xoq?=
 =?us-ascii?Q?Z9zmHRFxajoiRQJJyGAj9pSm5xHxXFd0dfg7cGu99TNHpyiZiTqjTFMCCwGV?=
 =?us-ascii?Q?+bkgmgbK04N1SAomz87UzCxD9SGb4cq5kUWeeZayV1drNvoZOF+II10CgG4d?=
 =?us-ascii?Q?sYmHwnKahFKTwAHSr7Vby8sNLD5NZPUSRcSgw0J/7ncWbo+6K8ihpkZ//tDA?=
 =?us-ascii?Q?uuhChNgH+kS6cJqjj8Mqvl4AlI+9qC1ixPnRGGYLGt3s9XShbs2dXFlvEJT6?=
 =?us-ascii?Q?XmoX9No0yU1zWafSdYpKmtRiWzchXha8xkYgVqK4cmrGUHemjPzsW/3htpLr?=
 =?us-ascii?Q?pbniBD74qGETgJEIhB1k0O3hqkfa5mafzZkxDqJJI6oYhJHY5KDqWoOoskDl?=
 =?us-ascii?Q?T/6SkPgFA7ee2vaDmGX+WlVRDxjNTkl8qiia7I7DktndY9HEEh9eXA6FnhBC?=
 =?us-ascii?Q?E123OwcRBUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C1USAd/9Gw+eOYKaKbJNSQEdVpKcwNNEh2d3Q1yKAX7GOs+ikzdiIPzR/Kxo?=
 =?us-ascii?Q?FT+0wtZZH6dDjwoe+jMfIaBCkTPynO5dasTy53MJ/02j2bZ4XDECzBu+425z?=
 =?us-ascii?Q?/ZWgBBUv63tCzDLvRdpCLw0SyZ+0mzrAsTLVMNO+NewsUdC5ohF6ykYv7LkH?=
 =?us-ascii?Q?ue8vb4FHBs45g3cu33VixM3A8FTIB68Lfnvs8UgCA69OfeXizQPe0IEFeXEG?=
 =?us-ascii?Q?RgsXVHqDpavRBEhXFhbr3sfPkg3ObX4hqdoA9XXgZx+EK6zxBlUK4kRyhc8R?=
 =?us-ascii?Q?NCT/jDmzS8Y4ZPylnv0dRo68Rp1nzy27DR2HMbd+3eq3AtmM74jWqLPr0Ejb?=
 =?us-ascii?Q?AH78AfH+nM/mumFl+BKv5RGogViwyiWC64ZHFRQRPJv4PK0wIRBPmu9eAm6a?=
 =?us-ascii?Q?BVcfnRxaJdoGSoHs3zoKKrnUjRQPlkTbxwVbN31x9QhsL3aMBB4c6BI3XD0p?=
 =?us-ascii?Q?GCbJvvCBBn1ls8F+x7GpGQawROcXNh4xHEmyl4CFTaYJ564IP9+tH/8QqUJU?=
 =?us-ascii?Q?kkSkMUMUgiL3LMSHOZBFANhZkD62eKHYMPXtdO8UpBQSWFo0AGgzSm2lHok5?=
 =?us-ascii?Q?f0iYeFrRnDI1iuG8bvdTTXR39lwGFrpLObk4/frogbT08veseiy7mtY5Eq3z?=
 =?us-ascii?Q?JbuGycvPiDOS3YaxMURYxhfTrs6lLM54Gm+AGNwTguSE0HZvlyjIdxQkNxxt?=
 =?us-ascii?Q?oxZxqfmqK3N953pAwhPwnqPWh1/ucDGzgfS4ewpavm4F51gy1jbczuRLLY5s?=
 =?us-ascii?Q?pPyabLUxqjvj/GilfsxKBk3zBvd86gNXvU1+XG2Q0x36eL/ewd7SDtKzm8yH?=
 =?us-ascii?Q?pzpdazRbBUf4vGFP5POv44llMMrUTZaXkYR/XYGMuLK92QWa5qL1CNUXAFNq?=
 =?us-ascii?Q?4ugMV3iMhIigUW3umgzHLGB3QTd1nRdpjdGCn1A1eRBRnuRk9AleskHeAG8a?=
 =?us-ascii?Q?RoyiHMA1VcxlmpDhrqn6ElOr8K7vrsV3IKLYakiCr0U6d5mzcTXFMXsIwB0O?=
 =?us-ascii?Q?zE6iJCJ57SRVBIH6Y3c15yuQS0IdSD2D+fl3E01xxepFBIAAK+uH6BIXtD64?=
 =?us-ascii?Q?dZQDoHd2I27Pvpl7PTz143qehTHlBplNaqA/lsYskztPhVorGzRef8hb19TD?=
 =?us-ascii?Q?j+zG5j9kYOlYCbAjNPsLSn79nLo6xYS0HgibitBXdhZJHG2i4JpfN1zS+641?=
 =?us-ascii?Q?mUyg+1CYOEQTmjmW2s7IiIl/iK/4FQ1gJa9bbzsYrV69EXMwwbhl6ls82R8I?=
 =?us-ascii?Q?z0WjpOmoTEpgbbo9+DawC4oCtsk6GvBFmRihTh3mMlEE0EnyX6PH9naXUIqW?=
 =?us-ascii?Q?LVHR4OmIq7K4JwM1vax54A1jhoBIevdOWJIn/synNcTJolNAWmN2q23w+0md?=
 =?us-ascii?Q?ais76sYgpdvSsR4h6Xmc3+b6G5QIb2dfNJO9J0vMYC2GAD0jmseba0xJ205m?=
 =?us-ascii?Q?A81VWFJqz4+br4XkBrACb6d7Cj3zVn6HvIAZB9hCCATuz6xMiZjTYay7sRFP?=
 =?us-ascii?Q?3TH9bjqfuDck+iRu5B9gajXiL5Pbx9ldskB3MiUD0DaxWK9G2itQA7Vef5ww?=
 =?us-ascii?Q?Jv0/9zEd3LWSIM2kpw64RFZUIPqCgEPL1uPN5Cn6E8RvgsOdFCH2mjkjcmB2?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TzZdW3y8uPpLtSNxnIDfdc1HVABQczHa29uMYC/h2C5wuruVvl9OiZ57cbrrQDnKv0eEbvbC00tZY8+lqbg/pH7DWfZawxrYJXI+G7Xr7pk5taI1GbgEGcbFjjSvGRqLmttgdBj5V017YDeeXLbZZYST9PBapXpjVfSnhI8ru9nWT6WCyGgbgEFjZCow+GvBVzGorpj/K2xHtwQuldgbHtNcMWBFkK4aiBVKnF+q0WJD0KUWOhRahJcJd5eMlBix0aA7ifZkNYwg4ebWVxGIrFS0ohDuit3s9JHEWImfwl5Lhe9sao0h8opVtdA0HbHfWWL2d/VkrzBvM32TSQNOjc+o9Eumonqkuzhxa4+mlbN9b6jOXyxs2qokKJqLxT84U6L0vdGvHopk1iURRzpVsPUWofL4tE6jkclBrTr+GmIyYwuFKAr7NcGYuvA3HnNLbQFGmurHpqJpuVdV7AINzojnetiJDg1QOPccos1aoN8Kekcz5N0483wj3DSQPgAteUVEryhajE+zGGgLQTqA8n7SKiNyXrEicYHV5EgYhdG52lfKNEpZ/8DWBy2gIZy1NfWzZsJA+CjkYoFZhVW8AyHBTqEeOg9wmNG02iwvUMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6235dc3-07c1-446f-325c-08ddda1f7583
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:11:20.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJCRKKU8ro0tNENyx5/dt2mGV6RodZiC8JOajd1QRIfOZLGj/2frvI93iLhhUCZ8IPJxbCXDw417zS1nl9+hgkB2iejyeV4ZAPd0n5UO3Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130037
X-Proofpoint-ORIG-GUID: VKObPKXF8haQZx83apBuXBbVsm26YroH
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689c106e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7pqJGh_XjRyNoKhQkiwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: VKObPKXF8haQZx83apBuXBbVsm26YroH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDAzOCBTYWx0ZWRfXwP9OAXmZ/zoc
 wRfUPoydtqTOFf5ztySDUFlKjeZk5WUOkRueMThiahjCAWNtdtVHDnsQpfxscNXbDjMPhhR77Co
 Cekhq/bk1ZfvJwPLw3BJlM8UF0vvXenAJrUdiXkBzMVy5KDscgHMePeIMExTuq7iu9W+bxUON+t
 UBsrZzUhYwt27PCuvYxWnK/sNRTf5M2xFTcC7AD6RAuhArS5Swp2u1x9hk06ZCDM7XSqxJSjUxC
 wadP8Q9ApeQEiAe52/Prq7++HkrUOer4k8cJPdGqzxPryzqJmDyDSUxSYnJzDUQuZPk65A2OV+5
 Mm0XWCpB7u4szJKSZzDu7Kny5zvaE6GrmlJSSsj9ycw9JEvdGxOYx+NOhhV4FLA0dlsHgj54mh3
 PRS331s7UXmKdrCV1DurSTSOh1dvwfMXwV1HLva7oB9fARrfi1eKphCX0LCn0qR5naFAaPBG

On Tue, Aug 12, 2025 at 03:52:30PM -0700, Andrew Morton wrote:
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
>
> Code is obviously buggy - you cannot possibly have tested it.
>
> --- a/mm/khugepaged.c~mm-convert-core-mm-to-mm_flags_-accessors-fix
> +++ a/mm/khugepaged.c
> @@ -1459,7 +1459,7 @@ static void collect_mm_slot(struct khuge
>  		/*
>  		 * Not strictly needed because the mm exited already.
>  		 *
> -		 * mm_clear(mm, MMF_VM_HUGEPAGE);
> +		 * mm_flags_clear(MMF_VM_HUGEPAGE, mm);
>  		 */
>
>  		/* khugepaged_mm_lock actually not necessary for the below */
>
> there, fixed.

Haha thanks!

>
> I applied the series to mm-new, thanks.  Emails were suppressed out of
> kindness.
>

Yes, probably for the best :)

Cheers, Lorenzo

