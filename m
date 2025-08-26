Return-Path: <linux-fsdevel+bounces-59188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F4BB35CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3427C4C19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7E31B139;
	Tue, 26 Aug 2025 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vpvbu5u7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vYN1K9/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620762135B8;
	Tue, 26 Aug 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208069; cv=fail; b=fMPYXl8wKAZg4pCeqQC/PIO8thkKWxkiwSq7gFJ1POpQchLBdseFxeP0rCLge/sD3yZg8siDYFYPyFut2VkpmZK/QD5sliU6W3ijS8GZJMT/s2qfTM0utADD7GQ7QCZJVd6yj3DIM+Lp8MQiw7dGlr8sRLmegd4tDwW1PH/ymNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208069; c=relaxed/simple;
	bh=BBj3fM7lQxxhyK5MZAzY0qAxfcZcN7Te7xCBgpu8b2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=laWRxS3snQClwnCQpl5a+4L4/lEmU1I27zdCq2Z8Pwebz5psb54iUZoCrCv+T6bxIWCmpW+uW/bVJLPEI6enKdgxIgzOvP/FaFwLEQvBEgvKx1xHkOvqWz09yLf8ugwSNBoiw5qpcyQL4A//K8vz0qHYy01kRVxX+GBn23gWESM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vpvbu5u7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vYN1K9/t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8mOkB006124;
	Tue, 26 Aug 2025 11:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RKB5AFIuTiPSD4h6Ul
	FvkcWrakdPc2CN8gQsUSnMmHQ=; b=Vpvbu5u7aC6pb0n/GNmO/4l8ZmKG0QR1gQ
	ra794EidMp1lijYlIe9VvElDE05xL/NmYAZ3kCzPkYVeQnZlgj9EduhwkfeymiVd
	gJNhd6KyVbPQJk77VZbgm26Zo1cpc4MbhcVCotLRa5Syj9N7BSrVAag+BL/NZbsE
	x4L7Wg4wc2JYZ4ZB+pFexbhDkCiCucjwkda9hntl1jZNlwWXPPRJ7ZKY1lnBPIs1
	b6n+27qzz/Eu+4ovCSbnKKfw0lqaK+KZ7q/NQktvDIl6vG5i+jIpJwiEW9mn10V1
	cDiUzIN59XtnNmk8p+trrMdCH/mTMyRaS2nnxZ7lefRuq8wR3LQg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t42td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 11:33:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QAYFQX005002;
	Tue, 26 Aug 2025 11:33:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj89nyqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 11:33:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVCXA+9wHtiRdqXR0Z9JHae0vRCj6DJAt9OaC7RF+maAWnE2b5iDwAvV+/6KNf6GZDkTCL25lw3/2i/OunK+DhpheOajx/tiu0ydqz2TZ0qD96ArNwbXJ/C7VMZh6P7CkOnFEWiupAIZCOXTpDd9fU9jibSNlSsoP6Jw5DIOBVx1m3zwRDnSqXFZo4d0JDJ5O4kv+XyWn8ptXQoVsZKYOic31YRPiHrT4WjsqdxUrKXv+Mnnd+RyJCiw+C37gNTaP0Nbfm90uBIVk5ecO2RzhHrmqiX0UWxjYEmlxlzU8Ay0lviEMu91Hy01QjZFPdMppcnpuPdHl56x25xQa+g+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKB5AFIuTiPSD4h6UlFvkcWrakdPc2CN8gQsUSnMmHQ=;
 b=vnPp15UuLohRRXNKnWhZnV/E/XDZte+bPw3APa+d6PM4Tc3wDC6Q6pJHAV8sNDSRhQsY29G1PMqaA3+v28xyhOq4lpYFjx0iJ4r73rhPDZFffoUw+CNYHsPlNUY2OZNhPu/2YuamNvz1dV3Bi0LTZZtDBaK4ErP9QskDD8XmEI6+kzx0F2xx0xZYNCwxAdaqaaVO31xj5b33WXKcyXO3XOH61sDsaGFc9SMWiawhEKSm5G8UJyyqyeXQSXS1OhevQL+A6TMyc2ht3zqjpjPBDiU2UeorlumFuf8kacFvB1dlo7qIchM7M10+TaWYyl2wPw4lPpkpsUn578jXl0wKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKB5AFIuTiPSD4h6UlFvkcWrakdPc2CN8gQsUSnMmHQ=;
 b=vYN1K9/tvb9FNU97v5B6IclPXolPq90NHS5nEEGy0FSqjfWkq58QWlyi5vi35GHKie89n8g/uCtXzQm/5KdITTzfmXLwYaU9UDV6eeHz2bPiwD0l1Sk+3rKjDjMyjQu9n51DSabe4OlCQ/A+nvge5v9bE6RGHSPmkBo4AOylTAk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5172.namprd10.prod.outlook.com (2603:10b6:208:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 11:33:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 11:33:07 +0000
Date: Tue, 26 Aug 2025 12:33:05 +0100
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
Subject: Re: [PATCH 06/10] mm: update coredump logic to correctly use bitmap
 mm flags
Message-ID: <0e7ad263-1ff7-446d-81fe-97cff9c0e7ed@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: MM0P280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe45cb2-e183-444e-4f0c-08dde4945443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ziXSGVLr8OTUANEziA0Fth/w8XdGedajfIve2fUCMU2TfRm0CQKCoe2c52UN?=
 =?us-ascii?Q?AoV++FTE+iZIbKsXSOcT5LuAfeNu+t6bbeb4kh7kUqp//lNCTsb1JQmziUGC?=
 =?us-ascii?Q?HwpAQ5Oi0j0FUTA5k74vWhnPEHV+aAQ0z1idOJ4Qeqm4Fa2bhS6a8Fe18WgH?=
 =?us-ascii?Q?M8yogY6xVT9LBYfjH6+uzi1EVo7G4j7I9TaywAs/BU4MKta02rUiyOQNasjs?=
 =?us-ascii?Q?4gSyYaxXQQxQ8MiIYdbnb++7qx+cskReGl9SfjJkAQTfETvJiDI1y1ZLtTzk?=
 =?us-ascii?Q?ilbrPCvuAfFztS+4BfsAi2/XOUTZv1xbzDGcQTA33eujGnPf5JOyxMJG21xw?=
 =?us-ascii?Q?yRqnC9yzsvOUvilsY6NWFnXro/98lGhyx+VGRAWJFnC1LOSwCzdxe8u0O28U?=
 =?us-ascii?Q?FOLi9snCKPs8Lm+0w5gB0enNbAmfnGuc2Kj0Y2FfF1OKsaO5h/2X36VDSEJ2?=
 =?us-ascii?Q?qnicfKDiULCtVKU/Ik507wveCLzYuJSkBX40aF2aMixGgwkbof2zml0NyeK4?=
 =?us-ascii?Q?ss/qwPEqTpa+72msAjulyrSaj3g37jWKQEE+DohpOARebViDMjuIrp0c12A9?=
 =?us-ascii?Q?7FGq2bszysBCV0U07/GDq2sJqmlV5TQgY/HnQiwCI+Ru2981yF6vh6ow92p5?=
 =?us-ascii?Q?CbFxnp2Z5ltknHtaFtFo2EQb0o85G91gnXjQQ4x+OpA/71k/lWFXByX/W3qx?=
 =?us-ascii?Q?nCgc8joO4+3UECynMxKMZu8rm964ijut8hRcXG4+70+EpDJMsP0pbUe98cDr?=
 =?us-ascii?Q?BqxatSPZljndOjAEBdawysUzsvdNwyc0CeGDXEyeyeEMmeP8MUgozhA0lySN?=
 =?us-ascii?Q?ArqHXWUmUiqBvysGNi5SCRhNO5hMgjqlEZB6t4JjhLrgSl/uOoO/Ho0GcA2o?=
 =?us-ascii?Q?kG2Ap/+2Ms+Mqt3LycpDPF4T5xUgSRMc6h8VsNlVUtz3fkjVxbIOQ0ve0+Ti?=
 =?us-ascii?Q?5ACpAuOfpTl3ZCba5rbmKvYw2MI5HnHkbuYqB995trZCu7shhcCGbeNzllJY?=
 =?us-ascii?Q?pKgsHqlNks3VI9trXnntRasL60XTrHz29/Z/CUgA81McHQzZOq62LOC2hIX1?=
 =?us-ascii?Q?sa4e+YVyCmJU8xkIT2dYWHrZhNA6RwtJmPv1r6JFtlSPCAQuAgurfBXJjtUD?=
 =?us-ascii?Q?5vY8YhTTDlN5vH4RPzpBIQmF4tjRLTDdcDTN7hZ0qQ54AgEt+KZFaXQ85EIc?=
 =?us-ascii?Q?BX3yVWYtofMDLwgfeYzydbh5MHAwO3efrQc2jZ4ZEPKBMNl9YT8pFaIUwkRu?=
 =?us-ascii?Q?PtwdRTB17W1CQ76IXcrvG6upUBzssxexmUxBHRiVTW5ifIvVLFXzUF8iW4rT?=
 =?us-ascii?Q?Z8ibIVZ/x0FDlZ22unWuCwI6+0QmDUcp2mCenDNgt1FCvBqNHJrRwu740wXF?=
 =?us-ascii?Q?7XX7r8qnoLChlA12FY3Z3glUAm5O3QXMgPdmfc3hXK4rH6Sq/NDl33tGQHuJ?=
 =?us-ascii?Q?XY1ngDSebYI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPjCL0OY3Fh0b9X8gt9mH+vueipWqT/J5IfOHZRpFQekNmg2bdSjlMCxMAwe?=
 =?us-ascii?Q?ZLdQXqKJfVPsg36TKAfpX/H7eG42F2W6PbZmeM/okHT1HccWcgAilpuDoZWE?=
 =?us-ascii?Q?zO9wHZKBv39F8P7mZgkgEIoRHtdxR8KznyuWETcEAYdKDjFC3stXgrgMlf8I?=
 =?us-ascii?Q?GVkc62DM1JDB6AibfJkrRYbDaMAqOVp/HbZhZs660pzfl/WcPOEMYnfEXRVl?=
 =?us-ascii?Q?mtoP1XJBDBNkO6d2xN5xViChpDqqZ952L1XcgKVFJEA5tw99DIFCFvnQHv9N?=
 =?us-ascii?Q?B+DQ361gAoAqPS0lfLO+/vZbFG3B4ZSjmmJbkbIKf7BOloOWFD1ZVERcKECK?=
 =?us-ascii?Q?VxbPe9rSiaCJxQxLLOD96THQrIljxjwDm57RVaJJ7V6DUVZsKv2aUfYmhsFP?=
 =?us-ascii?Q?S0ELAcBSbmZoZQusuW+vrnl/hZwI8beT+07X55C8LL7bTPfyZRboXN0ChgiE?=
 =?us-ascii?Q?Dz8NzT6ie9kO2EDQlMF8SwqqSn2Xe86Wj+Um+sH5XgnISd2H8wH08tY9FEJj?=
 =?us-ascii?Q?7WlTzJjYwXe16sXyBzDVsWU7X/ydMpb+/FnJ7gMWzzwNGpnGnApCiPvtEa0+?=
 =?us-ascii?Q?kn7x/SqSeJynI2RJcHaB60Y7SMbZKZ5HZpo1FTttipeZG+nighI1Os39xeKW?=
 =?us-ascii?Q?JmHB+9Ep+2ddntx6YiphQFxqKlibTy8lwPk1tWFn0RXUFO1NTxr6EqQJodsN?=
 =?us-ascii?Q?AAuoKVaqZXcsBFUjiFwGSx/0Ge1JN+Pq6nRKryS2zGhoPB8hIPF7RzJZLkrb?=
 =?us-ascii?Q?5ZHmTpuklky7076RMTpPJAoCDpCeVlQygqgv/GxLUCMZXJwbdWZdKijSYj5s?=
 =?us-ascii?Q?LP/iHq4oW86OHj91Pr+VMShj38VmCQZeidDAFpGXYrLNS6E4wi9BYInJ4RSw?=
 =?us-ascii?Q?Wglfi4JJIM22K2/OgWuBBOW2B/7SEjnHyiYS2V/znsbBRpX7tgNPqzsR35Uv?=
 =?us-ascii?Q?4pcDIwX/78+LUusKWO2Jz8umAHnAmaepRCgXMaKr4N2WOWHWcNfrI60BHD+l?=
 =?us-ascii?Q?Crp5jj1955+vy0WxJt0I4RxYcmAxcYChjfpdu6vDVqOV35Dyb8Hbs1omtsNA?=
 =?us-ascii?Q?rwOcxASdr4ut8y515U3jPlwOVls2VDCll6jk9CIFKehwz13eh5K412ALe98C?=
 =?us-ascii?Q?QtN9pFXwAMgEckQchGcpmSQzutpuRHbIuwU9ME/mNutLEo6QkG60+cXSE1po?=
 =?us-ascii?Q?ijqxoWwebTthRxHGePNUNuW5ltXrBE8RmMz9/xHjurcgnSOASDqOVx2nEFdj?=
 =?us-ascii?Q?5VQD36Bx3i9wKEBDh3IfG4YAlZby8RCPtpcajcQCy+YEuvuXZAL1P8fniSwY?=
 =?us-ascii?Q?XK43c53yzZHEoahfHujHodtKjlS9prRHAXVI/bH5N6QOu0B4kAaeOPQ/34VJ?=
 =?us-ascii?Q?eUv7AkHdgbJC6ERo3uwjNDlF0vRd2Evsf2kIQzndf4xdxC7HifAr604AX5y6?=
 =?us-ascii?Q?gS7bsUKquUFMswoz2831nR9fI/3h7LR6SI55h4iue+Ka90gRFi+xumm1aDl2?=
 =?us-ascii?Q?BARa8GCN4dWgEzfY9HcBw5vYWg2DlBvquigr34cQbu8jvhOJD78GPuqYLLEI?=
 =?us-ascii?Q?z4rZd9FJNlVy9IatznuTSIgo+iSefKgwNfzJ/SVlwbGF7X2g6bcTOWTY65xq?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WaQ+tZi+FswTILul9LIDfABF1Bfub20uXAdbUUKXrOFiC8pGUIBGf6F+wG/h78f6546knF0aHuIIvaBHXccwcI+lbL0G2qEARO82ppX7sJTwlzKBiYwSIIqOnHABu5iTjjo+9Hk5govK8TTIbXbVV6/GguptgHSn0eObJO3tUrftv33HuG+JqOTeo3wokdPY7CdOo72HXKXVc5dCVfAOy0g3orgiQEUQcSQ+W/Zj1K8iZwprCqvuIj5Qb+lEkN2h3080KMKiO3R1o2/Qp8nbtUxuENpBnihIdDJzIFVH9Fh+2oE0aFv9cgW+SvGSXS5qixex6wBQcUML45hwjumHZ9+icYVNbUhqEtzyWXOz9W9zPzJfJIRYRG7L86YQzG5ieLq39KWNgpm9SpdxmJCwM8fbQCb4V6sN75z2/a6UppGXxpD5l0ACXJfTs7VzXfeeSPVjDBUK2VkQ9ZI24X2L+1KmD1ySMgnUxI+YxF/gJaQBxgh04YAybzdWJz/4yw3wWzG+m61dRZOJI6OBHpUVJpbJkKPMXEdKZnL9Kj4RjupraESurrYRCTKwPDmeKsXQeMdXAtmm67PHGXPeTCnoIZKNenQqT70Hn7cd2sMfog8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe45cb2-e183-444e-4f0c-08dde4945443
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:33:07.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sCNC+tSNMIn+o9ARn8tyHshvRxxbj2nGcNFmoUbBJWp3qV8o1OPeHFdxV9JshpXKy87oLKzW7Ae9yu8AYTUWjczPrW8S9S5UQxiAVOjwJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX3J/1b/r7VBFl
 HXoEQAtwGOx0pghr5SHBiJQ8GkH1ZJwEsNMkZietQ81wfyXlFfZnrPR8D6ygjmqHmWGRSYoP3IR
 E8KPAgvTgxeiGFNhJ8h1peg+Dl7KMLv2fbFDWdRw8t0r0A1FcxF7xpFs4qFVXrgLG0iykhmVq5S
 7T5uZ9w3Sg+8Wt+l7LjkqZ2j/xPi4xaVHPxZAP65Jh0N/bsguTkb2RBJ/MvIRaqAwPv/4vshI9F
 uK9y0k6O/SOUn5/3TMoeH6zeHD8j2Vi727yq96Phi0ad00SrA4cG1/OMpPnITtGsuyBzZVTJhtI
 IeMiGQ5c7mdD/9A3rYH4Ynsr3Qat5gawSxXXM4b6LJtGNeOTAJLSg2oRKhRmmiBViIASSI29+ml
 CFPdyEZfxaQuXR3jq9CFzw7DbTqzzA==
X-Proofpoint-ORIG-GUID: r_w5-GovoIYBrcLsRbtUL3K7r8Hp1j_r
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68ad9b8a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=CzMtLqbvvQqJMkn9l3cA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12068
X-Proofpoint-GUID: r_w5-GovoIYBrcLsRbtUL3K7r8Hp1j_r

Hi Andrew,

The arc architecture with a specific randconfig does not like this, so I enclose
a fix-patch to satisfy this case.

From 04c8084551dbbac3cd1716164e5a19a367be652e Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 26 Aug 2025 12:25:16 +0100
Subject: [PATCH] mm: abstract set_mask_bits() invocation to mm_types.h to
 satisfy ARC

There's some horrible recursive header issue for ARCH whereby you can't
even apparently include very fundamental headers like compiler_types.h in
linux/sched/coredump.h.

So work around this by putting the thing that needs this (use of
ACCESS_PRIVATE()) into mm_types.h which presumably in some fashion avoids
this issue.

This also makes it consistent with __mm_flags_get_dumpable() so is a good
change to make things more consistent and neat anyway.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508240502.frw1Krzo-lkp@intel.com/
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_types.h       | 12 ++++++++++++
 include/linux/sched/coredump.h |  5 +----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0e001dbad455..205ec614171f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1255,6 +1255,18 @@ static inline unsigned long __mm_flags_get_word(const struct mm_struct *mm)
 	return bitmap_read(bitmap, 0, BITS_PER_LONG);
 }

+/*
+ * Update the first system word of mm flags ONLY, applying the specified mask to
+ * it, then setting all flags specified by bits.
+ */
+static inline void __mm_flags_set_mask_bits_word(struct mm_struct *mm,
+		unsigned long mask, unsigned long bits)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
+
+	set_mask_bits(bitmap, mask, bits);
+}
+
 #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
 			 MT_FLAGS_USE_RCU)
 extern struct mm_struct init_mm;
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 19ecfcceb27a..b7fafe999073 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_SCHED_COREDUMP_H
 #define _LINUX_SCHED_COREDUMP_H

-#include <linux/compiler_types.h>
 #include <linux/mm_types.h>

 #define SUID_DUMP_DISABLE	0	/* No setuid dumping */
@@ -20,9 +19,7 @@ static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)

 static inline void __mm_flags_set_mask_dumpable(struct mm_struct *mm, int value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
-
-	set_mask_bits(bitmap, MMF_DUMPABLE_MASK, value);
+	__mm_flags_set_mask_bits_word(mm, MMF_DUMPABLE_MASK, value);
 }

 extern void set_dumpable(struct mm_struct *mm, int value);
--
2.50.1

