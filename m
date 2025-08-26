Return-Path: <linux-fsdevel+bounces-59215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2404DB3681E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6300D980CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682C350D6A;
	Tue, 26 Aug 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="neojCg+B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vkG+X90m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A38341AA6;
	Tue, 26 Aug 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216829; cv=fail; b=KduLq/jgDmV7marZ7Q0pimgrQKGvITXUoDGEr7TVcGPmlTmPjpgW+17jq9Br/ljs8JtQUkiL0l8X+fjy9Yp/dauh4vBqk6aqerfCv1L+AXckmJ1xIxmmFCMP3uI7DReZoZHVPUdwkWGXTs7uXHpRSzwKm2syJ72P5vgv7wp9y3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216829; c=relaxed/simple;
	bh=wACkQcvg530bzA9+eiAs+1oW6a9K5xHKZBMR9Q7+xWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RwXdbSje3Tv5mtDbzLJmYkxD34BlOxhxr3qa4aG2+HMVWKNPNqx6pp1DP+ZkmQlc0xjUxbyypWsrAN7VrPpg6rrefiVVzEkPx1uDEKRfH0kJNB3GkBV++R7XzuSK8SILW6deYLelZN+qInKGiDuEQSdAum+LGVGMhYitjRQk/no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=neojCg+B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vkG+X90m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCGpw1028522;
	Tue, 26 Aug 2025 13:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wACkQcvg530bzA9+ei
	As+1oW6a9K5xHKZBMR9Q7+xWI=; b=neojCg+B9HQB/bLV7G7+EmxmHAdstrLk0O
	8Q3TU+imLFTfJUe4jkgo/Ubslp8gLqnEK0V69KnKGv1JXIePGRXW4IgA2lx0D79D
	nhQh7RWA+fhmFE7ug3L80sWE814iff8zLP1xVVMGF6KmNOywL4YF+c67GyJVxBCn
	7TG0uYsRhdKClBjQfWZfMhGbQguXlWQ9w30+h9OyTTzGwAQbAU6VN7o7xwcc6wff
	BKUI23vprWynygsQhIenw4/7QXwt07/TM5MvcXLJscoJdZ9h2m00+N9jANvxjZpa
	0loOuF/guJjO3Z28GpK0T5EwKDp7ehUblZLU1Es5+VubiMrVno6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48emhvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 13:59:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCL4h7005065;
	Tue, 26 Aug 2025 13:59:36 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11013010.outbound.protection.outlook.com [52.101.54.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439rdnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 13:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtQWu7zX51fTZjasmHU/sD53K/QEky6ULB1ahD34wAPeqppBWOp0apipfIu8YQYmRGyBvCK7B8zQt3t/TsjpCnoO6wGULhmjSmaOgVW1K+Ed8LroBeLPANb4oeqk1VGhS/s8NaZ2EL3XlFff8UywtbjdeEGWZ6d26XoAyRmrbvzNsTjL3ntrrEI1PmFW1Dc5HEm+7Lq6w8S6zjFYIO/rsUXuAa47voFArb7H9N1fMMakcK9aHoP71rfORD74EbffDBEcRuc7HovluDQ8C/VNhRQmFa+ZpHFx/FNWYT19a2BDSupKJKkCUE85ejXCF9TdtHpzKgW3J5ZU5pmdRymgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wACkQcvg530bzA9+eiAs+1oW6a9K5xHKZBMR9Q7+xWI=;
 b=C7ehG5UBM6wN/8kO1mrjj3/W2U5r6mR2iuwCRGjGJ1b+yw+lXYQpSulmKd1c0HdbDITSzviFFFIWVwaEMwor3NvS+UObaSdzqCvoWgIiqQhmrMVG22AIo5AtPQa/2yUeSujN3cf/IDFntHs+P8OJWiyd1lcGm8eqiF80fL+rnHwZTRmn5rkXwhWunI2vuGYts3dtQuUUZW7RRyLCPMtSMkTG98F1sCptZTu8ZkZsfuUYJppG/ibSMjSV9po5dxHmHIfjW51b3xNs6avHvLK0w0Sw/oh+LxLEiIaxQisUovfwCid+xrKlXHoW+Lkyjc8fnoAKcZVaDGqnk42yYK4T+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wACkQcvg530bzA9+eiAs+1oW6a9K5xHKZBMR9Q7+xWI=;
 b=vkG+X90mJcpW8aUT5EQanG9laZJa/AbzKzDAToTYutTSxh5067tMcjMlUrESrJjWNwp9EGot9W2tN1kZkGrpR0IaUa39FnTT0Jap26ABnWrsWD6U/BtiUOCCn906g+eDusfVGZz9Rl5+VmNAPobWKUQ9mkhGIodc2DiNwG+o3QQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF545856187.namprd10.prod.outlook.com (2603:10b6:f:fc00::c27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 13:59:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:59:30 +0000
Date: Tue, 26 Aug 2025 14:59:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
        Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Subject: Re: [PATCH 07/10] mm: correct sign-extension issue in MMF_* flag
 masks
Message-ID: <2a5bd51a-869b-406c-9ff6-5c9799fdd4c6@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
 <f77fd9af-5824-4f5d-ba97-54d70bbd1935@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77fd9af-5824-4f5d-ba97-54d70bbd1935@redhat.com>
X-ClientProxiedBy: LO4P123CA0610.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF545856187:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b157cc-2df5-475a-5236-08dde4a8c731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YLkX9v+5E/jzON6TA9C0rdxgkUBIej/t3pjjAtTLBVKCgkXSUKtRreXSvan4?=
 =?us-ascii?Q?JrR5X4Adhp39Kgr1zATa0puov3ADBlaNwbX9QMriC1ehcx3Tp7i4udVyGEuH?=
 =?us-ascii?Q?6Fs2KSCNDHd15WIqQxxYk0autxJOHiTNuGR/OuTSzgetQFJXPpnuOWNRNz8R?=
 =?us-ascii?Q?jNunLgZ9R1vn0j6oCIGdZ+DxtrLxZ0C/hXv3ZaijdwXEB+GL/1YlySc+3kEW?=
 =?us-ascii?Q?LzixI0Hej/PcSI1Jt3SiJdMntfxYL3p1j9V7YLeclnc4Iup3FQYw4877df3b?=
 =?us-ascii?Q?9MnmWxaCQmKZcYnINzl3D3Dr993bumkz/SjxTw5quH9S3vQAXNGk3gPlhZP2?=
 =?us-ascii?Q?n93ce98o28se2sSAUTnIkE2D3MjNEzWoQd4f9ekyLHIuaBQZzdGELRIXy6iG?=
 =?us-ascii?Q?A6u5MoUttQGLKGe2Y+jhncKiExhyk4tHN//x8hOV5bVcbTNGcHX5fmhvSB1c?=
 =?us-ascii?Q?uDiLDQ/toGG7EWBXotslGzoQo7L0+tRnoOXhNDli2PL9PvumUrm4AFMRLjqG?=
 =?us-ascii?Q?GQ/zD+1EDCGXptvDNZ/WuBTizg1bWRX4JkOCh9cn8yTVWwk4xe4x7XG6gK+n?=
 =?us-ascii?Q?vG33kobXTA7Fk0H6gvYWtW9A+ST/rArH0e0sMbNR/ZlLwlz7FMIhFNiJXk1E?=
 =?us-ascii?Q?VsXRm1ZQhrLILHDqf2EHnaCbyxuGbvKWFGe2ZkvLI4ypZvY9KmlOjwRUXlKm?=
 =?us-ascii?Q?Ep8A6JFPdYGvwylOmB62t6DXTqNX8RHe0W5uSyiyb0kd36qepUUSdnsnZJaV?=
 =?us-ascii?Q?6z0XX3XhueCWyMHvDuyhJtyOYPHxeXFiiF9aIu1scOKx7xzZ07yqEatcGeAx?=
 =?us-ascii?Q?eNxmdqjUMLQ36YEso0MfRmwSe5TcIUc3n6HRa9PPccRoQxZ3Px0IHXpREQJk?=
 =?us-ascii?Q?C3esED9gHedSP3d7SjA124Dcj978Oh1sBNZko4jnIHM7uNJxR3ZCTPbOtZ3I?=
 =?us-ascii?Q?cTXkXsP0w92i1ZI7ToNbDXLfHksx0MO9YrUa5proWYmg82NzaX9SYy3EcDDW?=
 =?us-ascii?Q?e72vAEenJrrHuZPKrdgxx+Ryqpu//Agz4sRpvmI+NTjL9sd9Au19ppj8Owxy?=
 =?us-ascii?Q?VcTtscLwxBAmkwBgFE9aPpSqfboqpGuEwWPeysK9+mIEJxgDWrZdhsFvQIhc?=
 =?us-ascii?Q?DLZ7Lw6dA7fjUS8OoA3tTpwIgBWtTKs8sD9SzJIhkESTSSOW86+18OXwtAib?=
 =?us-ascii?Q?+jwcrIXlWbpNt7qZcqwErihF391ZFgOEbw4yz1C6/KoQzMloLpXTvGb94asN?=
 =?us-ascii?Q?7p2EkwiYPHE+EWJ1XzKJ7/xfjXnMZR4AnXykjcIx/lY+p6JBQlLn5KNgf5zs?=
 =?us-ascii?Q?S+FjeU58+/a8IQd808/bDsu3TeqSq2GN8chReu+S0lBZFZ/ICWmE9OKNS/74?=
 =?us-ascii?Q?O1hxdZmm/AtgY3UMdPiAk/t1JEn6yuZkbtExQMFTcVW6u8RJU3mERNNbe9bY?=
 =?us-ascii?Q?HI/xHbH7ASo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbgsqKEJgrN35VDicaqUIGjkGyyEhXvEcoN4PTDHk4DJoY4rWT2ILRbZxz2B?=
 =?us-ascii?Q?VZ2uS5eYft4zfusTjPfpl4uZSyWoojL83eiT0QuT4zq7euF1U8RgWbb62sC+?=
 =?us-ascii?Q?k7BopCDlaPXjCBMJh3MceDTboFEpskiRH3f78Im33OHvqzLbZp9i6TmeN2p9?=
 =?us-ascii?Q?4Wx/PFyHxcZNw/bq7CTCb9bzudGcawQJP7Yi29kzoscAvwLrxPISqR3TMUR0?=
 =?us-ascii?Q?ULfh3PLgeaaJthMm5LSyzbUUCXEN69xedFeACXbTlmnlOM4A8HD95fj1fdzd?=
 =?us-ascii?Q?r2O9aIu2Ga+2xGRrjk2SMzh97cfcdR9q/Y9v+zzDPrBcjypNuyF7FRpRfsZA?=
 =?us-ascii?Q?CIYs5KezieKivH7m3PQs6EtDU6iBKgFFT5N1DoEFdd5b1lOYAes7vb+FTilQ?=
 =?us-ascii?Q?mfWPR8/zG2XidzMccJTwkWIDiJRs2sdDByeey0pLbbe1chx/+SZvfP533NV9?=
 =?us-ascii?Q?w9+22fAw66zky7+4vabbyj9s16i+XCuahs+0LZcrJaBxfOJlmB8pbHiKapjt?=
 =?us-ascii?Q?YJzkkbq19nLcUXDZVnb4x6PhI+/BwEqSJTk45SULZSQw5H4pyFhqBsWzdbSZ?=
 =?us-ascii?Q?cPix9nSLFGN+SETWVMM8eNgJd5LgEyxUzwot6kVdauMn/XjRXwfr7CvTX8gq?=
 =?us-ascii?Q?XT3XPoHKXdlAdQjxGtTqiU1iehOEk7NHyqufnr0DdZXy0fecAysWg7zSMz1L?=
 =?us-ascii?Q?WpzQPWXdt3DuhH/UfAHDbtSBMm85xId1vUXK1L/qp9LXDD7adXYbJ7EBeTzk?=
 =?us-ascii?Q?uamZba95CegSOW6TNIl5C7DooiX1eDwqfTK0PLtGPFFrW/yICHDkSCl3NaQQ?=
 =?us-ascii?Q?JJZnJw+FBkkHJQ+LnOMfahySpG+DcNQhIreZYG5nYc5jzrhNkKeRh/wzdYdq?=
 =?us-ascii?Q?isXgTm235Q330o1eCdYDUjpBfOc144T/JxveriimoIUVM1aCYCegUyRq/jiH?=
 =?us-ascii?Q?CJ8gnKG6+YFId+1tVTzamcv1UreaMAzODIFiTmPVl95/zn2YXRvhTaTYqANP?=
 =?us-ascii?Q?kTK/d43sIUxhlBZyRIpsx5hvLS/UeoFLnlrQSxh6UY0Yce4I/mmm/+SjewKM?=
 =?us-ascii?Q?lHQLJBZ7J2Yi23TNIZ8lwJgT70gPPNuj3caUkoudqTZH4aymDk9dlQ2yPYVM?=
 =?us-ascii?Q?rJm8LwnVl9iEKZweXoN0uFN7EdvWjeRBqA2LmcgXgAmtbTyIqDhz9vKWIWKm?=
 =?us-ascii?Q?cqMh13sk348mfrIsEVH1tPqI/LmNrN2Xp5Jdx07cqREsib6nhYLUPqGyy1H3?=
 =?us-ascii?Q?eRSAIAPLLiCmdyx0gvy2+0Set1s1ssWymQtuoKRSPseAteV2laekHHz+1kOv?=
 =?us-ascii?Q?GwSft9xxyRXB/MVAyk97BRn+J4QxvOA3edgcuUnaXeTeFCk/sJGNXAu7QmTq?=
 =?us-ascii?Q?qGr/BdmuM5Y4691mrEbu4hwCrVmM9ml9P4DcpN85c/Oei0hG+zgQm6OC+keG?=
 =?us-ascii?Q?U8caA2BoGw2km9EI04c4lH1Nqu/zfeqNr6Lo35T4uv5A0W2HWp5OGwHre4Bu?=
 =?us-ascii?Q?LmslneGvGdzRzUyJEfvGeaGpDZqIqvHKel7jjpju72un3PyEQUC9QLFut+BI?=
 =?us-ascii?Q?atlqzssDxlh7fcHpXakNu3yCXsH2FL5f42zxeiIBEBxio1IFpGsnOzG6s8Ct?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/eiXmfTy3cIr3KeB2xouRaA1zp72VWQHQzk/pcSF0/eg7Co0DF2OIuorwpXCgvfpUurc57IBTDBljNuFu3/UxV28wwIVD2mJv6O/3ldXje4qyi7DMwCGqIVmaVRHCsdnZEDalrPFWRa6xkOvFki5+N8KkDJISaTquQegmW4MqZxg05WJV+jpY+Xt6mqWI39yFN0mBVXoI6isYpAd1u4w8fJv/B3t7FrcSCsPQl1u9zMu3aKe1db1cpcdzF6RNE+puyiwLg/O53m2nw95IMBFEvxk1FPsWBczsQggclXVEEqIUO/HTPTE9MXAMhnU+kx6DbMAYzYrtXFhgN1n73AGNA7MLsNRSp5OaZV3QDL3tAruIjouIPo/Xyk8fvXO59ei3gjmcLOsbQfWIXYX4Vi/vAF2sZCo73S2r584bfz9e7oCe0aGCWPx27I7+l0uIxk7oK6DxPiOVdutsXAQqugsNUbDzznlc3jlut7tHBzLCWTsm8A990GKxyszEooY3vjpcaCwQDO1PZEfcBfGLFWx21RdWE2bzEKFvEV2dqDCHKj8x1vtzYjAA8qLJsPQ+i/34+K+CPMBIMTDguwH4C9bW35J67vnZvkHcG9JsMHFidI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b157cc-2df5-475a-5236-08dde4a8c731
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:59:30.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqJCaq0cgvLDerKJprdM3gojKi8HiB0YzJVwYo7upIUBm+vyR8wCmaP1+Nbw4kN7l6vxLHiRBnjydnLljL5x9sPm3iHrnpajXglEei5avAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF545856187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=897 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260122
X-Proofpoint-GUID: 2on69QWa2k4oCyGQVufdfWgWfCmSIKGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX9a4HiYREImEb
 xCH6cWy9dHqdI+UtAfsn/W317Iep0LQ17o5CMCJbp6KHiM8aqc2kB/gpiGBqDJvxilPi+h4sWaD
 4haHIsnsuCykzXEcgdHcAp9MMd/US8Lwv4wziVEnLY43kgwJDbrw0MizSGfDcyXkx98SfaBFwNO
 nxcrKNvSg5uQE16VFlXCe+5FgX2N77MN3H3RX60Zgth/JcWj3W2ivkRwQGLEN8cX8lsSReXOukk
 3W2BBLyfE0XV2CON6B0w6hVGU74/9e0Qq+4XbYMjNYyQZNuTwcsy44SOJF+I5+atj6z2y/MDMUq
 p/mGAc/zXQR9cDeyIqgPNrAVjvJ0gTTE/G2Q58PsMGjxdWX4+sZpE/WOCOPyJlCKudA1BvRmEec
 A4M7k5BP
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68adbdc9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JQTSjhKJAz_8l_SivT4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 2on69QWa2k4oCyGQVufdfWgWfCmSIKGP

On Tue, Aug 26, 2025 at 03:05:27PM +0200, David Hildenbrand wrote:
> On 12.08.25 17:44, Lorenzo Stoakes wrote:
> > There is an issue with the mask declarations in linux/mm_types.h, which
> > naively do (1 << bit) operations. Unfortunately this results in the 1 being
> > defaulted as a signed (32-bit) integer.
> >
> > When the compiler expands the MMF_INIT_MASK bitmask it comes up with:
> >
> > (((1 << 2) - 1) | (((1 << 9) - 1) << 2) | (1 << 24) | (1 << 28) | (1 << 30)
> > | (1 << 31))
> >
> > Which overflows the signed integer to -788,527,105. Implicitly casting this
> > to an unsigned integer results in sign-expansion, and thus this value
> > becomes 0xffffffffd10007ff, rather than the intended 0xd10007ff.
> >
> > While we're limited to a maximum of 32 bits in mm->flags, this isn't an
> > issue as the remaining bits being masked will always be zero.
> >
> > However, now we are moving towards having more bits in this flag, this
> > becomes an issue.
> >
> > Simply resolve this by using the _BITUL() helper to cast the shifted value
> > to an unsigned long.
>
> Hmm, I thought BIT() should be used and would just fine?

Sure.

