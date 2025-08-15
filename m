Return-Path: <linux-fsdevel+bounces-58025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A1EB2815F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED33AE8799
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1251EF092;
	Fri, 15 Aug 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="em383JaZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xxZ+jl0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13AC1E5B88;
	Fri, 15 Aug 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267195; cv=fail; b=DhGMg5p3nTB412pgV35hf+AZ994ZMJbBhFQry8J9wYthTpqZno94yL6pPrWXELyJDIDVSgg1VRxm8M67b7BKlY55TGB7IoKSFGNknqH5tyVYxzXoK+wMWawS2oAo62g43YhD5M2LXllLFYHh/MygtPmhnCjF5wvAaenEzQYmEeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267195; c=relaxed/simple;
	bh=/EyTYlPv5brkrm85X0hM+R4UrkBL3HiDowg51Cvrs5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tyZ2BZMNJlXO2ba4VK+0GFHW0Ekq7f0ldoWQoslzzHrSwfeNQpXxN2E8VXBZtdfVXeHmwKIoLkWxsHD0JaRdZH56Bejjmcc9zDHswUuAgPx0fQSsTUoFoxp2z6wIoALEYHTefOq49mztAF3rGFNVddqO+ExCTir3naM6hSACVkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=em383JaZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xxZ+jl0l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDN8nQ017617;
	Fri, 15 Aug 2025 14:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/EyTYlPv5brkrm85X0
	hM+R4UrkBL3HiDowg51Cvrs5w=; b=em383JaZnEe5o/wLVkrgBkqf8w32D9lWtW
	QAHCPNRLZH2sPkI5nis/wL8yoBth7GHl2Sc90hU5KquwBFDrCwkklVnazNS2zo53
	+TZ15uWahtrkOIu+Wfq+GCOwHNTuiUcFWoPh4HogQhVkAe+DQwHo4BfcF00yuKkL
	AJdaZvGgECxei2bS6KwOElL5kuHF6kkOX8N4TGFEA9zOZ43yRbSIAcfD2WGNl4JJ
	ACPS38mHZygEEPCbxsi4VNdJOojvwi+/8c5o6FIXUFvWe+2lCyDfcDhgyumIYQ5h
	SEtohx72Co9BZxeMT491TRD3XumBnrbxJBCO+72DFx/fHLqxQoLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8ekymw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:12:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDvI1b031005;
	Fri, 15 Aug 2025 14:12:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvse0u7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naacqd7/n7rs8sDXw957DkB8AB2m/bmOhAy48q6iL8tTQQRfwzbnueqMhPdHZhdf3EekU8POFZeJCd1e5VD9/8pj8fTkDJhLmhmns7V+YlRAEdS6IHYTCibn0o9XjyWWh222MhZklHouTR529LfmOOnHE2q8XN08gCmhlTG0VTF6kt/yAQPBZ0rAyRS6MPudUO4rvYqlnByd1qRYhrAdABZ3ZXAZPxEl7Pr9wf2QJmY4eU4w+nN8A1PIvbYbhXt0mRi0ebxhMLbQGY4WZtu76TrLpoVPaePo5Ymkkle4SBben7tBCa9U4r46u+3IYXughp8NuS/EHqTZhbLv7W1qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EyTYlPv5brkrm85X0hM+R4UrkBL3HiDowg51Cvrs5w=;
 b=JWBxUvglTiU+/8AhdtmMpA6qHjp0CKF43bT/cuXTqJcy63aEcMQvIF+vL/lgfMLzdFsuwqb4nh5lyT2gETPQegx142jCk/fqrrx3UIjNzMbqulplZtWOd//O95gMe5lAFKWYAIgueY57kBERJbs7/AT3Qql5IukRz902XgETNqsjGKKQSbExR+BGEDQgunbNQ91QYETYalMHN9TPtyKN7CCGbm42UXhbzRh6E0EmVn180hM6kzHSkxuvEtHz2+wv+gV1wQs0R+O0d/Ct1E6tYSyUwSRcZCXp3vFWQc2lz1KDcFlgPfCjCBSry85Kg/F5Sgw0eXs3tH2Z8BA5OXSj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EyTYlPv5brkrm85X0hM+R4UrkBL3HiDowg51Cvrs5w=;
 b=xxZ+jl0lFX1vggxzV+bWJllz0R79SWJWXRHbBWv/8muctcn+9WrPER0gg0FVSXVl8wzkSeWTsFWD7EBjBEuSeNt1m6v/Ami2ksC8YompXs61DtLb7bh8SWRJLJJ4piTSLyoldh7Si41EgyLB6gnLQ+BHQkXQchPgR+lgASKEcY4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFF0E76365E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d57) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 14:12:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 14:12:05 +0000
Date: Fri, 15 Aug 2025 15:12:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
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
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
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
Subject: Re: [PATCH 06/10] mm: update coredump logic to correctly use bitmap
 mm flags
Message-ID: <9ea82e7a-9eea-4bb5-b57a-f5c4714bc732@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>
 <20250815-neuzugang-gegessen-ff4c08a08ec0@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-neuzugang-gegessen-ff4c08a08ec0@brauner>
X-ClientProxiedBy: MM0P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFF0E76365E:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4ac942-23a7-4e37-eef2-08dddc05b670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tJJOtZdkzBXgxB2jkgwatR+rAZnBBKDLTpjfaZG4fQYaNB94dZauaKbsiJ9X?=
 =?us-ascii?Q?MQFI8HdOJU8wbqap4KfciVZiphGhhFALsgcwMNvIgxWC3WIrgKmYUvjNRtZI?=
 =?us-ascii?Q?gts7oboyVk9YSGW3/6zivjAoAyYO8RTD1sUFe7LBhiDcT2YJkIo/makddP4a?=
 =?us-ascii?Q?QG5ohiu3/IWTYyw/2ENeQuvhNKkD2F245ZlXGMNYaYmIi65V9+4yWS320g2U?=
 =?us-ascii?Q?frhWc4QR2UxFPXGvFl/jg+iMTEoi8x/Um4er5QGqN7+PoEqJQ95icpN71VGL?=
 =?us-ascii?Q?Lz6hPNvJuXY6jHXUVFmQH6gtrpiglusF7SldVFQovFeNxE3n7HYdGdAf816C?=
 =?us-ascii?Q?zsEN4zFsAUPPVY0fQRuj1qlslOiPke7EaH5YPqg+V3QbWhaSJMs8snZ+4VhZ?=
 =?us-ascii?Q?MlpRwJgo80xTVBQ+OM01rs8xBb3xqtu5MzBqcMtnKMvaTIS16QgU1O+zGaiK?=
 =?us-ascii?Q?GMFVAQu9aoMbIL297qmiZC9gvFB1kZPw802oZ+UMMOdsgP6X1iJP3+RkV2Ah?=
 =?us-ascii?Q?NgG3RrOCccDm4FOcwu9pxEpqizWpL3Kv7qPDepSsxdkoRL0ZjmzPkmKz0l7w?=
 =?us-ascii?Q?NY1W+7VzkyWYf5q5ldnX6/UmrWJmtktRiyv7UMxZ4Koo4C9321p37zO58oQT?=
 =?us-ascii?Q?s01cvr91+jJP+JNRqKChu7l5gwx+Ri/FyTUbbcafrDgZlENEJNvIqI+D3XW+?=
 =?us-ascii?Q?YeN+nlUHl8qY+R8Xs+Li6DyAzteH272sHL6kZW8t22CXAiR4xndmTRfiaQOF?=
 =?us-ascii?Q?Ao3n7jL3mthNd1pHdSSBAZ/CNOByTuRV6yqTG/0ZfVDGIkOBkNFth7tRGFbn?=
 =?us-ascii?Q?Zayod++nrrKbKp7TZMlf2ntJgdnNeG2cPZEdBqaDHMv6x0LwNSnyaxhNdtPp?=
 =?us-ascii?Q?zqr2H/MSV7Yl7PS8DMMRo9reyOk2pjzQcql2DgDY9QVkI4w0Rcf3QvD1WSMk?=
 =?us-ascii?Q?SSvk/35wFXpjc4ReV5C2g4jmbBQfy0lf1QQHDfFmpOFc3A9Pf/5gYfCls9LC?=
 =?us-ascii?Q?p5agVapbDh3XOIb2ZJTk3eYcIENKuOBhQf+j2gAL0W/ogKuy5vR919d8YZWc?=
 =?us-ascii?Q?K4ovR3xeWyhMRaPoDxaomz9rgQAZDHu1HDn2NvpFUR0Hvx+4n4HirE5tG+a1?=
 =?us-ascii?Q?UNlCCs3HqaNT24VbOZWwbwQq6lv6MrwwupA3gAerfwpdArWtFSBpKIpdXL/z?=
 =?us-ascii?Q?kPA8yots5DhwJbf5NN3gKwHXRhpB8DI/6xPQOzEgFyit1R0WKDAgexv6rDxE?=
 =?us-ascii?Q?68TlhbhaYfVwFqjF66ZHjzhwuBcBdn+QYhDSRXQkgW6TDu4zi3JIg5Z1bGjM?=
 =?us-ascii?Q?KyxVcZ6E3PDBHOSF1je3Q8Ie5CNeGP4hMuClhzwzM1VxkADGaDVz+DJ1+Olz?=
 =?us-ascii?Q?2H7dKxp8dUOg9PWn1iAy1ggNjoklvzmCz7Jk3wenkXyH8723GhX9+gXXXq6D?=
 =?us-ascii?Q?RmDX65yJMaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yKSMBe8/NIrvbYS7rKKLtiN059tMpbTvcyOL/aZ6n6VUHIvsZnGbN5iipVY+?=
 =?us-ascii?Q?azXu6/JxqRBz/tCqUwPge2wS163r7Btw2KbgL0DRh93yERnpJ+/TCAxFwVBw?=
 =?us-ascii?Q?D+rkdIE6ISZy63/tjI4dDzAOH/trMIOUAUXkcbg2EjjKNyOzEivALSPfZe1g?=
 =?us-ascii?Q?f0cUJ3dVTs7Wj2k9G/WEN9Gtbnc6AarYjUAjN8euYuyckHdknKW5sQ5CozhO?=
 =?us-ascii?Q?xvPjjEjLgFSzGs+ARe+9kcae9aqqtypG8J697cpHHXH9dT532WYCIPH8J4cb?=
 =?us-ascii?Q?R26DXBdbDys7SeqChf16u82+MoQFI1DRH2GVeJ5iypb9z1TiO/TeuVNHkhkJ?=
 =?us-ascii?Q?0IVUVsz37/bQGqgpEnM3DG1Mz/LtsOHfeNHFiETzNydc0FuGUTMR8srahJAB?=
 =?us-ascii?Q?1g19Gg4nm7lFp0E7gfkMAoZaSsVdsfwvdiG3Asqq588ZLddxCXRpe5mmDdbj?=
 =?us-ascii?Q?txs0Oi5D0olq6bnxv5E6HUYA0deWPyjI7Hk3/fhtFFbQIbRT1M8OoSzrBHKz?=
 =?us-ascii?Q?ot9chd6vlHAq0n1B3MuFTWSaqxIaPj/yiw7StnBjwidSVSiyqVtKqxNdaaLl?=
 =?us-ascii?Q?d4ibXRMErF8lxyJkWmXx0dTi3Xfa1eCrrzTQyF8gRWIfXrJoFJkni/tCv+V7?=
 =?us-ascii?Q?9pf3bBQpYz4Z7bpMByvYBynjcxzSL+BB/Fn/wCillgqz9Y7k05x8THTAMuvB?=
 =?us-ascii?Q?nWc0UtkHyE/G/azhK3G2nw7qJcFmvbjn6gqZ+eI6Jcf/ujjnbAHLKIvWeZMD?=
 =?us-ascii?Q?BQC9q/UZSFGjhwucyckHSPrnUezWrumGY1Y2J5pG8uPLw4iuYyTCy/6YT57m?=
 =?us-ascii?Q?E4PianhaCHTVmYkFuR/Rp+LpFcdn5CzhjJ4NwZI7ZNcsXpDg/Hzmxjr3gHpT?=
 =?us-ascii?Q?ZlgiBpe69yMCqJdYp7S/BZQDYc30UtUbwVQoYPPi8E18TTdox7Id1Vrojq1Y?=
 =?us-ascii?Q?PGbGLjc4CYk7xqQ963LSCLFs0RK/YjuKji9bqNW87Q/frUEUed4cdbtUox3M?=
 =?us-ascii?Q?daoqwiP0dPElHaGC4V8EVBRNpa+RYbfYM6B4Pt/lF40gPMef2no8b0TEZ64o?=
 =?us-ascii?Q?KFXSTt/L0dVy4CVxG+eVX9ZB0Nqy7b52lgWMIV/Gm6j7WknnA8M7YDI2u+4U?=
 =?us-ascii?Q?DU8kbkmMC7jwB3LbUOpN0L2pmTG2p+/SWvCCY1vp6gf2FDgnQQiXbY3g4zQm?=
 =?us-ascii?Q?zrwxn6iAcITCXwc24pGW3OgJiHEBU1PGX3ZjG2iAB4AX6NiXPyGuIozg9n9k?=
 =?us-ascii?Q?GDmzB8eFdxuY1FE0sSMX0oovAyIo9X+hxSEV5+KDwHfqgi2PvdKE6vGUHjYV?=
 =?us-ascii?Q?uNcH3Fv8fFxnjlrcNdbjZPRhsT2KW94qJwhuAqJRi6Yi3T8pZfua+L6wdjUG?=
 =?us-ascii?Q?CQHPovhcNtOG6or92L2TXAIS1uWuBgvz82Zt6Jd+nwjjm3mZj8PbAqFnKQLc?=
 =?us-ascii?Q?FF0aT070fYLBtArCZNKlP8RW3CnCP68jx8Kf5d5NYPzB+4CIOLM2fE72FJ4h?=
 =?us-ascii?Q?OIVkGPdD4ZJs2Ga5PDEBWIC0uWCE5opwHPZZosevZDa12spCXVPvW2jbHstj?=
 =?us-ascii?Q?DV8cI7oS09ujduRpPTTXlMsStHUtHZOjd+xck5uwJCtG35FxterjzVi3PZsl?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SIFz2Ft2JeOgUc+LFkGQT7qAIEcDDPq8bM3YqWDFzmDQLnzEiPQPeiPK7L2C3+W5ow9sdn48or1x0GQk/0b8whnX2vnA66envulFySVCatk9P8NOuVt2c+zbzomqGyteovsQiMXvnF9I/n80vcEUkPgPlnMIBdL4evEBQPp58CTV0a3XVFS4jvrqf54WwasJ/t/FZ9sWbkUE7QZV62HnG+j1YJ+QeS/D9W4u14kdkNOH5iMvQ9kyAcfVqyCAHbX7RRlyM6Fv/fzadiQqeOhkCDjrFY9Y4fGb2pyJbrsaunUuoJJqoUiulyVfy6Tw2NfU9lwgnPhBSnK9eBoWtzjXknye3y0Oi36hGRC1YaiDYHR9/N/1ibZgpeYpskM8wRX8q/h9LwSiprvhVCEEPkeZxanf3XNZlfTmkz2UGe2coMX75/fnktgtgPcf8P1jlq3YQydiXFeMC96s+rXgqcOvME/v3yPf0kcAIhuOCVBcKs23PF5uYcjoAKBp5mNyKBRL0Ehj4Qy+J3paugNDH4SgsUMhzNnHzo3KDppg3Tv9B4Z4TH3C3Ei5nlKU3oacqeNC2s5jHlRPpcGaTwEO1+eWXX+8Cfw6nHqCgc4UTMXb6Lw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4ac942-23a7-4e37-eef2-08dddc05b670
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 14:12:05.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3EjBfQtSZOByTMom42douLYQFO7r2SNVDuccjh7wL2c/R44k7nOfsyqNvI80MK0CtWlsrVnM1C7AZqkdCtohl0IjOzRzGg3mOlnfmuGc88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF0E76365E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=778
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150117
X-Proofpoint-GUID: P9YAbpLZvfp-SB3PEL1L3lERDRu-xUQu
X-Proofpoint-ORIG-GUID: P9YAbpLZvfp-SB3PEL1L3lERDRu-xUQu
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689f403a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Waf-W1oraUNjDhrhqNgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDExNyBTYWx0ZWRfX5G8G4vhGiCsu
 /+iWE0zOSD/LRMVyOtSGEcrWL6GXOZra/UYD3HzxZPkovQWuFLJkCgfGXAqQXQQt/sJY5f2h+rv
 eQIj4olrRinnoWCYCewweN1MLdIdhtN1eMbzQs/7uPNip0lKn5We8Rtzz1FwE8iRT2BpMluoNua
 LXyAu2nj4p2CB696awuqgugAmnVHjw3r7tQfm/wPvLuALSyqTj03tclMwujkSFHv+BrYDTSX8w9
 ugPM8mAfjlQMOtNOHg9nAHxMPQyaxY0DGeiTss9GZje7TTKj4dL+EzxziBioPBOeKjfPENHWHn7
 YruEjELw3p/NbwH78AUnUGESoF2fIEfEEMxtPg5gOucnNhTFbaIHPy71R1h/PDCYRan4eroK+UZ
 KnxROn7CzBd5EUAjmwlYvIghVJY4EbJAD8+808LrB/Tm9JKLs5t5vCKiRshI0KNr75EC9WKF

On Fri, Aug 15, 2025 at 03:52:38PM +0200, Christian Brauner wrote:
> On Tue, Aug 12, 2025 at 04:44:15PM +0100, Lorenzo Stoakes wrote:
> > The coredump logic is slightly different from other users in that it both
> > stores mm flags and additionally sets and gets using masks.
> >
> > Since the MMF_DUMPABLE_* flags must remain as they are for uABI reasons,
> > and of course these are within the first 32-bits of the flags, it is
> > reasonable to provide access to these in the same fashion so this logic can
> > all still keep working as it has been.
> >
> > Therefore, introduce coredump-specific helpers __mm_flags_get_dumpable()
> > and __mm_flags_set_mask_dumpable() for this purpose, and update all core
>
> Why the double underscore here? Just looks a bit ugly so if we can avoid
> it I would but if not:
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks!

The double underscore is to fit the bitops convention of bitop() is atomic,
__bitop() is non-atomic. Obviously these operations were and are non-atomic
so this is where this came from.

I do that because the vast majority of operations on mm flags were atomic
bitops before so it is in keeping with.

