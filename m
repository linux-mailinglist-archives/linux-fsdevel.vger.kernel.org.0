Return-Path: <linux-fsdevel+bounces-56227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD61B14792
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92167A6D22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 05:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582CC235345;
	Tue, 29 Jul 2025 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gUXpn/l1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QJDeA8Gw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A72147E5;
	Tue, 29 Jul 2025 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766885; cv=fail; b=Hggud8sP9JIyiwChC/ORWd8qwKEoilC7cBzuH2ZTXWsuxFDpokzspi5FQOlQhChB9eT9LiCshlEAZnRqh5uvpwD1+kr0aXTEZ4Vqx3vqRf2NH6JS0gI+CAPd842+heaIUK5thF3eRKMltkHw1KGtU+h/sUnU/vcqSKdidHyfxJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766885; c=relaxed/simple;
	bh=WAUG8i3UCyGKQmDLoqcOx1KKhuTqbZ18W/JKQaM+5JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s9o8cJ2UqQ6h5DJpMzLpfP/0GklyR8/il84355mu9PLa9kqzyP45ybZgjAYsB1jSZqDoXOOPr5UiphYbHWk66tw8F3GJEHbsvPdTo4ll18KOB8dJtFcTS/AOFoWRnUsvlKfcQaC/Inah95/HzYwGEtuLbo03y1vNzEN/B0r/3zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gUXpn/l1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QJDeA8Gw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLfqZj012558;
	Tue, 29 Jul 2025 05:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WAUG8i3UCyGKQmDLoq
	cOx1KKhuTqbZ18W/JKQaM+5JA=; b=gUXpn/l10hyEurvpEnVDZJL4aSyxspk9pN
	ra3tYQWuKEStTSYxYHynLeuV/fZ6xbHE1rKOFUcivI8+GyKm7m5oJeuRuKKHWYeK
	lCUbpoFNViYzj4BzuZAZnOQ75jAGZzK1JH/ZSr0C5BXqy0+JZGOZpb9YxG5cELy9
	haeGeu0fqb9LlthxV/dtdGYTmB3FkETdA5aT3cZt3kbJl9Agy8KEv5D4DdjV46m7
	YhQI9MvTE29z2hSyXuko5z74ppTggbtR6/Yydck7PgtyFScM7uqDhAODO9RytEGd
	OcrETCa6o08SW4EGiEcz91KujSoyLJNuQQN6fXKSF4T0mJOB5s1g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2dy1k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 05:25:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56T2Lpnh003459;
	Tue, 29 Jul 2025 05:25:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9fydd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 05:25:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozpLmqGHiKqXK0qGkj46LQerPZaPRZ8XV/ZJpQdnNbe5G7IxdpPm7Bu/FISF9tGZ+x6/idy66qq2jdwH+ezHlfUy14OzlpYFegyFbDZuhuVfQDe7aY58PDAIUIE6V+TE0W/IpeBIrV4sQSdUNSBqivGFlh9+AuNcYXrEgjdjZB+/6H4CCSdpWwLs18vKyEPTD3HFnjpF42SxoWCq7cWF6ezr8WmAPIYFwr4ya0W9MTd5knWhiG3OHlW5/0iMUJTzm/3zMuuBSDmRXYP4dkOUIk9rrWqfg24bAhOKI47PO1zRg++zA4gZw0EVJgLddN/p30T+3MS3BSeJNfljp/ggWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAUG8i3UCyGKQmDLoqcOx1KKhuTqbZ18W/JKQaM+5JA=;
 b=NXiNfCq5uRCMr8L8yqMuWaIS8M67IwUFKV24F3mRlGAliJcfYALjwoB4pFfzeE992GRjFDuo3y/M9eHg4FmzMImL7H5OOFw6VXGRb1M8sYMDTMXbLctS38EpBZ9dQ/LlVzCIXRBzkUFbtY6nQmn0K27Sx+6IVF+7eSxd0DAUPY7XbnSOASJHSWlb+om1djB9aoQIPhIOcLLUkxdOI0rwaCj1WDTJyir5F/E4bomq4p0RGm9EWwD3GSJZvxIgTH034RkCzZFtsfvY+otTTXzqwg/GFqDYjPV1Mp+7dsStRyptIbAtxEeTvelJ36t1nb/kNoGCmlPI5xgLbaUss9fWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAUG8i3UCyGKQmDLoqcOx1KKhuTqbZ18W/JKQaM+5JA=;
 b=QJDeA8GwfNuw9ayQXo5tItaXsYWEJ2hW47SpaLMNytBIOB5UYgU8lVjHMWaCsoqLfcCAAGvZC7St0EZzap5LHQPpdNAmlp52wU6tCrAXBel6nPSlxmj+y6q1y9/pngcYzZo1P4i1UBUVuD3YdSXot+rQnXRuqKSvXXXJ9NSla2A=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM6PR10MB4316.namprd10.prod.outlook.com (2603:10b6:5:21d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 05:25:45 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 05:25:45 +0000
Date: Tue, 29 Jul 2025 06:25:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
Message-ID: <73764aaa-2186-4c8e-8523-55705018d842@lucifer.local>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
 <aIgSpAnU8EaIcqd9@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIgSpAnU8EaIcqd9@hyeyoo>
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM6PR10MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a6acab-8912-4f3f-b2c2-08ddce605e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSmR+bH71HgKgtUyRe3Dbrs80SB/7HnteEMPunUeRsp/fgjzbykZWee6xIUm?=
 =?us-ascii?Q?Z3C+E94bsP0syk+gLC5RTabXMVeIWPvT3HwG45YCUOo/GgRrUq5dj+qU9FVn?=
 =?us-ascii?Q?spvW6OxFEgpWbLbaVPGDUZ24GKDR43qzYBTku/vlwd2OyuK4oaZ1iAT1EdC7?=
 =?us-ascii?Q?pBh1vy+CRCsXLkfwHO+HQdTPEvRIicf08eW0ssR9M31aUE19fXDVG3p2+NJy?=
 =?us-ascii?Q?Jop8BQ0McqAmDemwKMwWUVRY0/NTwE4VMLxHM5ye5onA9qTRfi+WKHyp7893?=
 =?us-ascii?Q?8aJ8g3jz6oGHc2+4boAKLQbl+7rQ4At5DPvrnsLz2j2ZyU3tcrBOKeBYGVRa?=
 =?us-ascii?Q?frM/8cVzEHe0YiJ09P4fPUP3vMZnKk7jRanWLXSepInDRJ6eTu836gzQTtN3?=
 =?us-ascii?Q?BPi+N/v6eODRKY+jhOofoHBubhU7DcHWMHByboU63gvR8crcbuHtcUJ6j6My?=
 =?us-ascii?Q?QAa+yEG8Q5NcFrw3RF9QuK3OCyXlmzF/b5XLksdo+4niqcUkysgb5NYt5tBW?=
 =?us-ascii?Q?qdXRZOV1x8UUNaRLa+FBfft2yP4vBzgQTDSEHm/YXMd9LmeMCUSm+ResuNVd?=
 =?us-ascii?Q?NbdcaXrTUm4DKbNH8RH0L6wtUGRMWMAknJ02+4AiDMvFZChgG9isfEZCCPDr?=
 =?us-ascii?Q?rUVpT5CQule2xLtKvgrTUrcNC/wZHqmBxsvrWnE1PiTohMOtmxAxnSUGRmRN?=
 =?us-ascii?Q?26vJuMHcyc+/PcqrjGff1b7wf6YXF1UHpP2IwmcdcSgrlQFKTpRD7Me12whL?=
 =?us-ascii?Q?16g3wvlULmfmdwjZviMhFYwRKEU3uEyBWzUZOdqLzOY9LOKZVEo9eGUt3oej?=
 =?us-ascii?Q?IA0j+aUsmHMPxh7Hig6tNCISQ2yhjlCyx+SJkwbcktVp7g8zfeksPHwR3EkI?=
 =?us-ascii?Q?u6XM1CzSefxiRxRfd3oCLF4jnSs3rqtNQ8v6UPkuUREWuOA2JOx4iumi+zlW?=
 =?us-ascii?Q?0xTIEm/fwxXQa3laanG3Ez08AH9N84I6xjFTgFI7Rg5D0iGgwQQkiuc42cjz?=
 =?us-ascii?Q?17PEaPp0Q4jzsZQ/DUJQMzk2ff7WA9PEpL8pZgtBg3W7UOw/oMgPIK3ime7Z?=
 =?us-ascii?Q?tkWr/IeKR9AndCLjAiD9SUjS/QJEsC2SdrreGl5udk6Puv+PrFdK9lGD4UMU?=
 =?us-ascii?Q?xiUkuY17atws189a/iqXWlB+PsU0vMWY8IsKFiytcC6MzkFgRAfuyv3cm9TN?=
 =?us-ascii?Q?a8izFIUJkGkxm48X2E2WV9crv5zdM6qxuATX4fc+2O0H/+rk3m20lBCvapi0?=
 =?us-ascii?Q?orn3dO8TohJ8O0co8GvLLQJDCQxpHBwzW8rf3jAE+yhnDUgw2wbW81hWsbXg?=
 =?us-ascii?Q?MmP41qXmv3+W7jvuFsZ3oPC1UUQ5MgBSAzEmbYxuvHat+SnXOdEMKPKQDfXN?=
 =?us-ascii?Q?vHTE6zMow24PApPGEiLnc0Fr6hxZ89jZIqINS7+9hNcti3DIuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EtBJMRh8a/6WVvIzIklelKEVxtXDSiymzANid0IfQLgbmCI9nfCtHPZbaUbE?=
 =?us-ascii?Q?1i3YYWapO7Sg8lpoiHb4PprsDi/XbCZ8BtcyAMBWFm7EBV16rQRJYuP96YU1?=
 =?us-ascii?Q?7il9gNg27LzFIL9GTHcvDK9KZY1zz4qJ1CeH0ABdckLNO22PU1MPsK8GL/SA?=
 =?us-ascii?Q?I9Mgeltjrc33HddagpvQdwVloZeA6KZMueJXDD9qf5wztyWUjlvpot8Lkuv7?=
 =?us-ascii?Q?ljkdc6e1e55fS5P0geXvfR4SvfFAdP2JllUXfJqTqD6gB3wmznGJLBRjSlcD?=
 =?us-ascii?Q?hgK6hmoBTYFeegtRaUtrK35f6ptcvAz5FYpYF+Mtw3dyZX1alnHKqGaGJ31x?=
 =?us-ascii?Q?E0OeUHvHsu77xdRbJqXG959RlQ+iBe2mw+AAdB0rSru0hLu8ZaIYelnpBh0B?=
 =?us-ascii?Q?hu6XnDkRFAWFV52LHwZrDp0I0D1ewpffiX3CuTxM/9JyMpKY1YX6aX2OMYfi?=
 =?us-ascii?Q?1acaUq+qlkaZLTwQgP3k73B/g6gQp3uIjG8fcsznQoXOaDmqrIte2oqmgd6R?=
 =?us-ascii?Q?Ao00/RH0pc+UlG1JdlLcYD2BonVDH/X02wTvBJZRssmcVDf5lvmTGVdutBdX?=
 =?us-ascii?Q?ouPmIIR0h8832bsn5vP/YTh+CFK/y9N+c0OaLXKtspkzjYX5YluZfRZQbwu/?=
 =?us-ascii?Q?pJ5wqI7z92AVedp/A0RWdGjON+JmThOFStt4iAOfZ2LgG5faqtF9dqD6iADL?=
 =?us-ascii?Q?BAT9QdU7y7WpSp/eFMcuOHf92UDd8OU2yeVMyzn5yf5j4uXjQypCEQGlplj8?=
 =?us-ascii?Q?+dniiZu0XNSX57WQMMdcAcZVweiGILPk0wEHXiNerheb3R5jHJCO0RRY1rSB?=
 =?us-ascii?Q?PV5GnL0oHbkqrV9MItGuctSpTfijw04+b+JcEBO9DaqEi4VJdxZW6XgtorHQ?=
 =?us-ascii?Q?4m2NSPZoa8rMioFyAeKiayNgz6k7yXCCSCE8dW8ClX1n7SgUXQlqUMfN+/vQ?=
 =?us-ascii?Q?ws8+cbb2EciZYItHDExFZr14FT/XQnDy3HaLnF6RFvCMhqlk9nWf4dv8nfLg?=
 =?us-ascii?Q?EkYilFu9xX/0SKHJA/jcTEONxwleBVEk1faYQYqOgsMz4Wh59/oxl8BHadbg?=
 =?us-ascii?Q?NRRzCZDU/09KbsESiQTr6TMSoSBb9431EExfuKMvy9kr8ZIfhH+NTP7fx1Y9?=
 =?us-ascii?Q?me23WIiMm0gWA7vbirIK4WN5QIcbbsvPCLULVPlSIDF8vB6heqEv/qsFnRKK?=
 =?us-ascii?Q?qJcaX7ZDxkBRz/Ddz1RzCIXczf0HL/L+lSuFdirFJV8bpZA3DwiRH0Y125OS?=
 =?us-ascii?Q?JBTL1MAt+GnVBVotZOvMcBifrael/Yb75zrw0b/rYQb32J6J09aB0uQ5D1jY?=
 =?us-ascii?Q?1nbPmQWQAzueYskiBOGNGHh/N6llIZlUOt7d/JanffBVzq5ooyefSrxGtpw4?=
 =?us-ascii?Q?zB6MREoh6a9W5/WBdaJ1gzO1FD9cKM77Qg1pHaL8U5xtSe/wnkepCUGCqx5f?=
 =?us-ascii?Q?e0gCRGgFT/taiPOQDOekWnhCqsduaSngXOXVc6uN3NCjKMVPcu5SSnvWo4rX?=
 =?us-ascii?Q?b2+14Vd23G1xHPHXQ2K434C4gW8Oachh3Btw2XfFcZ7AT8QIj6PSVmlQQ9WE?=
 =?us-ascii?Q?FGOEbVbq3fJK8wa0UATSEGj+fK7ecVarrN3KVdE9lkGawqQwpG5uY9bjsf9s?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fNKzoO4EhxhLQr5J1OTL47g5Hqs9bKCPV2AR20GikhNfyXsZ6da/oi0IoGPOTITMBEdaI4mWiUs9XdS4X6NMKrhlBKSW9HNKkr/D1yUYKdYCksk1P+PtBZQaoqW/uped0p56r+vHhBJV49LLg/zWcPuN76Bg4FXZgCkzvebBG4xCTmuqFxXgZojL9QgwxnbsycHHuEfVyIdN9GwpQE1OJbcEQ4SxItEwOgSiSr6VH71dAJM4VG4WSrJRQUHT4sqM6S9YnaYtoVpZ+aSvPx5QoprEww+a35xA6jCtN8qKNB41jhBW5ea5wV78GipepUEJ3T1VskiJ6tS+k3ROnqeDB1O31drltZF71fmdLyootsQuXDmUFT8iEdhHg0e8P9wR8kmTKNWxKCpplAP2pws/2K8S/t9UJG9l53sASUFNyedTukTGPVrXAjcnsGbwdaD+0yG+XjH+yW7RSPw4VZOnF4r443PUII1FtGYbCT7rHgqS8W0j1zbf7QCQOCsSTtVMeUyTAGPBB5AehI8TL9Dkpreo9nvrdwlex59ydHW4nu7A/Ys0EJFPjGm1L8M6+eEhTAmpczPM/d+/LWx4K4M/5FOGTgLHxVc3+bpaNNoiZUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a6acab-8912-4f3f-b2c2-08ddce605e66
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 05:25:45.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PI0lplI6F1nrk1n71frnlwmFemPajYQLgRxCrt0LpeiARN5QCliNsqZFePW3R2k39KiIqmCFYHnAoek5kxrrZ6iZvQSFspc1Xc7xy1qlScg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290039
X-Proofpoint-GUID: carvk8Lt_r2yfPgcc-g-a8k0OQhh5TTo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOSBTYWx0ZWRfX4KmzYoM43bMw
 F00Pf1mJJFG7PWc1Dsztwm0uBvnXeQzTZs0NQm7vJyARJbh4U2Hnn3KlfhL1xJQ9xE7n6bbecoI
 OYs/gQGEAF79CV8VSZQF13/886EC9+HYsGbMbE+4YANJKCTfzjVxdIph6tD8zvdcf95Uzi9Ed1N
 CFkGAJbwHDsDpE9JfE/uIyUUe3VeBPRNUymngqtI+rMX1TKGNSSYINzcBj/IvG/gYEcaSzYH5rd
 9dVCnsyzv2f68+fWcFAyxA1nr/whWCJG6deJh+1hsQEs3yRMXAtBwJ+aSfc6bt8s0q/JLJT4tZY
 LL31j2V/xpcxarIDq61lFoFkmui7Wf5/Nsw7kYP2p1xtbIqWZvEexyHFbNWCGswN8cGiNSsfVAR
 19CoBhOMTW++QJi7nDVDlNE4ebSehTglWxbnVCOOlTa1Div7LIFGWLZzrakXA+yYqRM4PbH8
X-Proofpoint-ORIG-GUID: carvk8Lt_r2yfPgcc-g-a8k0OQhh5TTo
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=68885b64 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=crXGLkoKcYGB5ZtWUxQA:9
 a=CjuIK1q_8ugA:10

Andrew - FYI there's nothing to worry about here, the type remains
precisely the same, and I'll send a patch to fix this trivial issue so when
later this type changes vmalloc will be uaffected.

On Tue, Jul 29, 2025 at 09:15:51AM +0900, Harry Yoo wrote:
> [Adding Uladzislau to Cc]

Ulad - could we PLEASE get rid of 'vm_flags' in vmalloc? It's the precise
same name and (currently) type as vma->vm_flags and is already the source
of confusion.

>
> Hi Lorenzo, just wanted to clarify one thing.
>
> You know, many people acked and reviewed it, which makes me wonder if
> I'm misunderstanding something... but it wouldn't hurt to check, right?

Thanks for report.

Yes this is a mistake, the naming caught my mechanical changes, I tried to
check everything but given scope of the change and unfortunate vmalloc
naming I made a mistake.

Net result currently is _absolutely no delta_ due to vm_flags_t == unsigned
long. So there's nothing urgent here. But will send a patch to fix so it
doesn't get caught in the 'part 2' changes I plan for this in 6.18.

Fact others didn't notice underlines the fact this naming needs fixing in
vmalloc.

Thanks, Lorenzo

