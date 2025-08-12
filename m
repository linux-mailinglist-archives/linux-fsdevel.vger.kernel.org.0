Return-Path: <linux-fsdevel+bounces-57548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EACFB22F35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6F7189EE07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72452FDC2C;
	Tue, 12 Aug 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/4gOJoY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m3DhFqra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A02F83CB;
	Tue, 12 Aug 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020159; cv=fail; b=rirvcjpkgvQuHN9Hyvwe5eHyqewPEgwC1p0M4kxSJ6TxPqiUkj4q/vnIPaB9sZ3oSACcuiNUrWPiAhpkaUyu3nKbkuZ9fTwJE+iX8NZ1Jvn/7jaTf87o8rrRyJjWG79AL2MFdnPYMlZNUrNW8kGD5lE630EqHPLrhyLvd7aQ0RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020159; c=relaxed/simple;
	bh=CEa8gq3K7CiFpGrOc8f7IEvjas5LMXcqQ8mE8l3BZ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IU/stSXVuVUgdAQKmrT6qoybiPo5hsRCmMBrQrBxA9pGxkqEl32KeRFN/kK4qw/UINSTOfp6iH8jNMCq2RqVRgtOcaahDYruYwptISljRgqw3OtLCQLqiYTSYmqyIpQHBTYULm79Sp+sl51RNQtc/F1vkga00OP5CgwKEUf4nCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/4gOJoY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m3DhFqra; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC02V012389;
	Tue, 12 Aug 2025 17:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kpx9lB0Q3vTJQP9OSa
	8rflc9GKFGjz6VdI7bY83fbvs=; b=I/4gOJoYcxtsqS3cLV5RWkGp6iURHUkhNq
	djA9ugQEqGHMXHHIZyv9RPIjJcy9JKQp6gCO7vZWg4/N+57zE53dLvELHuzZCZ8Z
	ACHMd4tCJExBs5jiFPx9KwuvPB/Ao4N31rrMLV6FLqooeKZQGh9XBDp9N3CW1rA4
	7YaGlFyHotdPjCb+/q8ttC+iODUvKwDhCEJJNAxpSJyVCssSReJi3ZaG9KwsJZip
	9pedSfMPkRZCIwDr/ZxIon+Xo49ez7rQywPQXljKFXK1pnxfnPmLWNvGPMwog3Ta
	5MQpPdXTMUHxM1lvc5HuMFVHxrjze1uzFxV8kT6iPSajSbguYlBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44w9ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:33:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGX2x1030162;
	Tue, 12 Aug 2025 17:33:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa9crq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:33:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR7GWw99YwkyyVAmE3B26PrsEyqrTjtweuo6wDPYRcZu5e3qrw1Koi036b4heLRVNAyz4Lk8os8/dYMIdH79nOsLiq+7DTcxsJrlHD47g6l/kd4wP6G7GZF+7gcOaP7/H4hY8SLXk3eQy8wP9WX7LaCadGdfGDlLDh4bvoIhRu4mdpT4dAIENvDgoDYwr+u06jNOl1yYPY0wkoMhITsRQeL8B+n+eMMQ3xVQp2uNPFGXQHNXZmQnRTOZ9eCxYAP04tQHtIv1GBRWyQzt0HtbA5KN+mobO3OJtpELkmyjdRACskGmOwEwwUB2Xt8tMYqOt6E7ISqJayC1U/KL9rf/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpx9lB0Q3vTJQP9OSa8rflc9GKFGjz6VdI7bY83fbvs=;
 b=QAD4lw7vnEukT5osLtD7j99GWNhCdQLPrRK1FQ3FoM6qRHjUvpB/vuowVHL83CF9XzkPgCZhvncLib5nLyQtT5htan+oUimYFg1D9B4XInvq6OBV3V01fkGV5cLPnGry7pAi8m4xJlxlv0Ledge+y95fJA3Cvq+Qg4Jwzb3G/5WNSeZVQJJGu1NCzO2H0ZgbZGKtOPiMqNJ+rSH2zCCKWeE3LSzsAn7aYA5XcDz9aeFsC6GsCfnruS4orkR5gyz2NS+bTlI6Nf873xwP0to5eR6162IKgsMqpUm0Je0wt4146hnzlSxBkpDdbjtzKEzuf1lnz+rgAvBuUBVaW8s4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpx9lB0Q3vTJQP9OSa8rflc9GKFGjz6VdI7bY83fbvs=;
 b=m3DhFqraWtGNSKN8csTS9IBdjI6dcVs1Ibf/uQ7jCxbpOtTno56ehF44yfMYTAIjD8S38x/U0TtPBbU5NgIeHc7p+MtXkk3+aukGX8XfBm6s3EGOWc4NveKc4Xq6YcLrCUiDxrQXmrZxArAgquaAInyLlB0k+2rZN0cyELO9n78=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 17:33:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:33:09 +0000
Date: Tue, 12 Aug 2025 13:32:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Subject: Re: [PATCH 09/10] mm: convert remaining users to mm_flags_*()
 accessors
Message-ID: <fjksegcfatzwxu6kc4v2kry5mzmrppghmkumvgnw6lthtogg6f@fa64y5cospq5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <cc67a56f9a8746a8ec7d9791853dc892c1c33e0b.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc67a56f9a8746a8ec7d9791853dc892c1c33e0b.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d69c8de-6731-4f39-b11b-08ddd9c64e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6q7m5Z/CbbnlA5GFLGfjoN0dtoxH/BvTfaRFBgQ2+OXI9JpJb9nzxtGcLg9r?=
 =?us-ascii?Q?9e6xNqd0P6ArZIpySNbCbS5fQdiv5R2tQ3tU3zAWAZRbKkftEBXGOTJw7tVl?=
 =?us-ascii?Q?C5//o+Kd42XyhjhjCpncDb4ILUnd+4NOc06239n37jEPLMi3B/4MZRCK123U?=
 =?us-ascii?Q?EVqBw2WCfHFUIA5fU+WHEQW6SLYWzkYwiPVt4uVFBIc8Usy8aut7EG6bIHsF?=
 =?us-ascii?Q?xVQLd53Yd0E4+75mSVMKY+lUHh7yIVprO1R85LVAggeSyWCuYE6XMJ/R87dm?=
 =?us-ascii?Q?AqtY/EhmmgDo+EirKLibR4PvPAW6ZPgk5PRsgsLgL84/+MxyxY5g14o8WIEX?=
 =?us-ascii?Q?iy+oebQ+z2S/zSitgJUSa07kjsIh2BV9IlHrSSlO5lcJGQ2zbqtiZoS8Ofuk?=
 =?us-ascii?Q?06uIHRcJ4HpNEZbwDRDFDyQ1DdPaKCo6I2VmqyjRO7+PPZgBSno3c2xCAeys?=
 =?us-ascii?Q?Xg/vxEdQpYDbBV3o92LGpFK5LO0jG1hjRsHxidisToZfxhqijIqv+q4i10Y9?=
 =?us-ascii?Q?kkWH3TPJVKZwggtY3aWtr5zYBFlteOhNgaKdroNnnJ3GiAkLSBX8P2qTn4SO?=
 =?us-ascii?Q?t92fQf94wKL6hX60UYS3TMw215qoJEUvHzWhloDfiHCF6MxvcfUnkq2rjzLC?=
 =?us-ascii?Q?mc6WOsVZ/2YS54iuBfCH8TSy9BW+Xg8CXQWtWP1rS1xtwERjcOo3jMFmhHEi?=
 =?us-ascii?Q?krLW+2rh3E0QIaQ+JKyGLxYDlKsSzOg3mKbqvxeLel+i8ZIC122OHVRYpEPg?=
 =?us-ascii?Q?OELZsXXOGoSFUsfKdNy2auKJhNfdNlNkMy78Wb3KjX2RZnQ96Il6uOCMCFjW?=
 =?us-ascii?Q?k5DTiTr/6O8PReFRq2S9VscArZvqM13FK7s8clU4jWuhhSVUvMUhXCUorEFE?=
 =?us-ascii?Q?0jZ3XL4jUpGNrfSfFC+L0zs8ukvbe8j5/j9bASpjVGesBAntcCmFVEoM8hdh?=
 =?us-ascii?Q?3/xoYYouYKeYbjWS0WfngfAQsy8N5DFdocuQgH/rDQ+n/DBqvPtqUaDVllA/?=
 =?us-ascii?Q?0f1wng9f3xrwp82xET+4F9MEOM0IW6Sx0Tk9hOAYG70XX+ZOnP/Jhug3AuQr?=
 =?us-ascii?Q?x5nvJIj2sMVnqiHbiRyWqZegqP05JoTlkZCdxsDmieWjT/GR7sMXwAMQ5sOg?=
 =?us-ascii?Q?37O+Zu/MuGwCwyfb1UublhYzvAtVr2Ykdg0sWD87Y7e43ZvkwI0uxq5R+6cD?=
 =?us-ascii?Q?txqnES89zltlbS7w+2GY+YuPfsLeN6eG1hYLSKfXy9Ve2yvejzc0xJjOrwEg?=
 =?us-ascii?Q?8Zw9LMlc8QHV4w2Uv/Me7ZSaORjv/NFTzyD1w8dthA1/BB15ngJlL23owpdf?=
 =?us-ascii?Q?om8FgxDPIo0oq6kudUdJupMgmIa9Fe+BSMaQweRZQvCoL/whVn/Le4sOUUNa?=
 =?us-ascii?Q?vnJtgtoNXNPcVKtzenPht/JzsBHrR+0yen+bUUfprQfVc+P/mbojoWZyLz1N?=
 =?us-ascii?Q?eQ8p/pbievE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B3nLrckcPASHCDbtRkAgdxGJVn6MKd9RuEIwtIbSI5qzZY502HQfIfuNmh+j?=
 =?us-ascii?Q?57id4yXtlrREQO6aMTPFi7Oj8zyEqLHrTidYj5lwb7nidhPx/Rc6ADOi9vvh?=
 =?us-ascii?Q?k+H+/QUu/2ITSfqAlWvllUYpVBn8p59c+2l3DAylAyAkgdl25sNrBQMwi9cY?=
 =?us-ascii?Q?S/mOKnjuRwMCVGLRZZE0gg7zSPV5sw2B8OjZfkvcsEFj5fDejD8OJRx9/4tO?=
 =?us-ascii?Q?UCaghh423ViKOlr8ctvtSDmQ8o+ZsPESTAT8+6iKVypBrkf6JXNhF4z4opY1?=
 =?us-ascii?Q?UbjA66oH3eXHJKGzCXq6jw36RCBVZP/REMqoPMrDlAhABYBIvHL0E3Oc/1Ds?=
 =?us-ascii?Q?yvTfjqkLKdCJJrmNirehZ6drp9WcoJyOxgXe3umQZDDvjpW+Ktdp6s6wvgod?=
 =?us-ascii?Q?AEns2Ym16wVoM8NEBgjAQpQu/2rl2Plmd9d/5KfJ/JMFmArlX7EGTX/6uHzd?=
 =?us-ascii?Q?8njtOh5gUsBeOUx8XasWQFIurXneZBEHKvFCsr0w51Pgfmu+aq0+Bq9vXWWf?=
 =?us-ascii?Q?viom2J7yUuldSJC8pGZmh0RcJBs1lngAJGtfo6qsuHVo7oa26NvI6rQqZwvZ?=
 =?us-ascii?Q?YWW18KdrERzj+HhtRs++2jb/AZkFawDX2Ledrkmw6nwqBLmSzqCBXDDpXhQO?=
 =?us-ascii?Q?AXHIacHTebvDop+k6TOZHnkIwuUpuqj/ecG9TY8k9BhPR0lcR17Pv28MZROu?=
 =?us-ascii?Q?Li1yvmEjotOHr1FNn1/INoVtrdWv/KyBZmTP2fR8Qyp20fl0OEIOAfRF3loN?=
 =?us-ascii?Q?SiF4MOVOy8jueseer59nZtJ9PUgMrQFOHUgxtSiWmm0OI8w07drFVW1K3PgT?=
 =?us-ascii?Q?z1upsCDJHIGaLsm8XAIZF1i49OC1elH1hnXYDgLmzoGAZGUQaHBFCDDwWR3F?=
 =?us-ascii?Q?pxwPoi+H0w36ANLKiqamvjziQO7nKX3PTkCMBKLA/hifwugwspeDOgh866ye?=
 =?us-ascii?Q?g40kPwDTvwiRbgCzhFByiv+iWuo9X0FzAWL+vRTyJ1Ioje8C/PXOoiCW4gtX?=
 =?us-ascii?Q?Nx5SHugzc68jZpxiqAkoss2osvftXZDyw7D7XVELi7lvmPCwiMHCrvDsN7JH?=
 =?us-ascii?Q?7h4q7Onm40B702FwRkMGo3YI8VTJVeUQQruUGLVz6xEIhOQPI6fvqQY5ReYs?=
 =?us-ascii?Q?gPgm/6kUYbBFuzjoL90WJzpadcRLBny2bzLfp3yslq2WbMTZ1G469ZzFmoqi?=
 =?us-ascii?Q?uAsDGs3GGo6JKDL9sdgSalVUKE6Cic36GK1f1nOzAeu46pjlGBND4X0VEIRe?=
 =?us-ascii?Q?A9/oAbhd2P3lAKnG5Upy37T3xRmP0LZHFXzwwb68dwxcmfdFginpDSqUlVqC?=
 =?us-ascii?Q?auDHRoC3P4ENRdGVeCs2RsY9w/I9i1iS2N0xLKkUaPDzVKKTatQdUbP8eX/S?=
 =?us-ascii?Q?sHIxOXBsiLef3K/rb/Wfkl+QixD1gcXAW4oC6XwxoHPU5KLrXko9CgFwnWb5?=
 =?us-ascii?Q?SUnjFUtnw80zjnyTnFbOhb4oDzd47yyXPK7il1DMPS9ZMdjJ2SpxXGpHhnAm?=
 =?us-ascii?Q?2tgOEjUo7z8IwsUUjqjxyT5Ovw9cjUI0TtZtMuX4gM6FE8MyHiRtq/+gVrpa?=
 =?us-ascii?Q?Fpkvj5Fq/8+0ZMjF6iGBQomoJ6K4rrdwU/2MQxyF9Gd3+82okJVERsez+iTj?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BFbc9zaf50PSj6Rdu8o8A4e/7LpbbxkBbLlXL5NThjtuYTwF2gE6K+ggwpou97CxrbYB5lG+anMtCrh69W8AD3pI+Usc2pa6nwOkVJ14qr6JPAg5RCsEmrVOa4LaH6ovD+kI6K+FP7socIGQ2HbrPd01JiH9mWgNXP4zX8w/jSIlK/CV51TIJ4Xn9c/Ls7H8koS4/NMkNqtcfUzdzAS4WGSHu4kgumJQsB4d57IAOwiQeViHp2d5e7LdjGYvBqrKti52xs46eNfwFAXQNij2pq3EceCC6oqVE38DsCN4uE+mykDnOoKe1tfpYQHo2O38zu9i9CdyVIJAOtEQLACYgsdX7HiJP5PaC3GLn3k5HjiA6v9Tnw7bQgfg5Peua++vWxyjQFMrnEWvQu0h7KY10AzEK0kcUMplG7lD6yn00Xw9iQ9VGkjwfQX6ICoBuVYeZix5JuxDfzDhJ2xEMi3F+PcpHNbci49WCe41tECOaWbvaCvqnbqoe0Bek9kw9Lr6yZi4f3YZvaFH5/Rjyi0wdiISp3EIM62Ru5w5dygmsIrtRUcU86IzFChf9FRjY8jlqGNm4a8u80oWTH1C5MEVX6nDbX/hrlBrbR9r3Pacl6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d69c8de-6731-4f39-b11b-08ddd9c64e48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:33:09.8048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AISN6jqtPhyUxfCkpYlowrGL7Ymqk4M0MUugaUZEWTnyhkagoOplOYHhlQy4l05VRUAhjRM8jQLUVL0AkVqHjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120168
X-Proofpoint-ORIG-GUID: qyVHr-X0IxDahhhcQDucdbYEfEyntOKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NyBTYWx0ZWRfX2kohoVRu+3Sl
 sr23gXFLxkggEPuEnpEfjo9mevFz5nsbE3gy6tmzFCBZF5ngfilQjYhAZVZf+hnNiVUADDhWbHS
 pRIlhuQDT41IxPrmPRGNfWnSiAULqBlFMQpMm/JFqq0pM7vHBvhsCjvn9dCXP+bVtHRD8x7slgB
 kHQHi00uvj/4XEUnXd7fjOcnFg9dhxsGQxokrc6+DdTzdniLb7r9nR2en3oEDrb/m2+sqv6/l2S
 fCXX8b0ror8HdxOhHuhyWHv97r9DpRkRJPu3K+AUc5dM73ECHRhJU4YAubDERc1tWxZ2SEMBm4S
 VKtPrYcDw7EpEr3hT4D8K4M4IVNWlKJ+Cm0iPQrAJDU9B1Mcql2WvLIWro3K9H5x19tZkt2q6ow
 KOOR8HGF0O3yV8Un4JA1+bLkXxbfwEUU1SvXK1uehCxTMj4BEF8FdSrT1TsnEBEGmYpUOPFI
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689b7adb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=xnbhwwWAUB6mJk75OKsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: qyVHr-X0IxDahhhcQDucdbYEfEyntOKy

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:48]:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  fs/proc/array.c    | 2 +-
>  fs/proc/base.c     | 4 ++--
>  fs/proc/task_mmu.c | 2 +-
>  kernel/fork.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index d6a0369caa93..c286dc12325e 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>  	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
>  
>  	if (thp_enabled)
> -		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
> +		thp_enabled = !mm_flags_test(MMF_DISABLE_THP, mm);
>  	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>  }
>  
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index f0c093c58aaf..b997ceef9135 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1163,7 +1163,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  		struct task_struct *p = find_lock_task_mm(task);
>  
>  		if (p) {
> -			if (test_bit(MMF_MULTIPROCESS, &p->mm->flags)) {
> +			if (mm_flags_test(MMF_MULTIPROCESS, p->mm)) {
>  				mm = p->mm;
>  				mmgrab(mm);
>  			}
> @@ -3276,7 +3276,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>  		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>  		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>  		seq_printf(m, "ksm_merge_any: %s\n",
> -				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
> +				mm_flags_test(MMF_VM_MERGE_ANY, mm) ? "yes" : "no");
>  		ret = mmap_read_lock_killable(mm);
>  		if (ret) {
>  			mmput(mm);
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e64cf40ce9c4..e8e7bef34531 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1592,7 +1592,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
>  		return false;
>  	if (!is_cow_mapping(vma->vm_flags))
>  		return false;
> -	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
> +	if (likely(!mm_flags_test(MMF_HAS_PINNED, vma->vm_mm)))
>  		return false;
>  	folio = vm_normal_folio(vma, addr, pte);
>  	if (!folio)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b311caec6419..68c81539193d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1887,7 +1887,7 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
>  
>  	/* We need to synchronize with __set_oom_adj */
>  	mutex_lock(&oom_adj_mutex);
> -	set_bit(MMF_MULTIPROCESS, &tsk->mm->flags);
> +	mm_flags_set(MMF_MULTIPROCESS, tsk->mm);
>  	/* Update the values in case they were changed after copy_signal */
>  	tsk->signal->oom_score_adj = current->signal->oom_score_adj;
>  	tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> -- 
> 2.50.1
> 

