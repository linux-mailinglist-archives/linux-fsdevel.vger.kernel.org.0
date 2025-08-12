Return-Path: <linux-fsdevel+bounces-57528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C344B22D62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C75B188A8AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4582F83DB;
	Tue, 12 Aug 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLgkf/X7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="brnuPIpA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048F23D7D4;
	Tue, 12 Aug 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015681; cv=fail; b=CmlJbu6VOkG0SWUHSJp05ebiBNu6uQmc0x1osqphXZH+ZXk4cqktAFhEXdnxeegH2F4VUpPqYV2EFsU9+yBsw3KjFEZOyqccHNe10nGaTREc+Zgi+ZPcBhhXyfA5269B2bsVburdU17ET4mueJZuxVQ0u1KTS5ksa6LCKC4DqP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015681; c=relaxed/simple;
	bh=A3+8jHEoEgpus5WKWiQwWtY6/iSEpHKHJJzJ5chdhN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJKoUdkLaDWvvhhqYbjYc5DyWNFlx0fWTwSx1v9L8nhZnxYhv75OIb5ad4u0Jy1GS64tyNUSNRx+SveR0SHTi6ZVnzys4hdfwnTHX8FiQcT52wQVMfsiNGfXqGIPH+Fzl9bXzoXI8RXvbjJlct+t+T4yzaCQv1MFiGaWDNEMNi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hLgkf/X7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=brnuPIpA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC2Ui007903;
	Tue, 12 Aug 2025 16:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/d9hoIGBFdc5WgKjrY
	Kw8FUFaAAIf8MKWF33Rg0wTWs=; b=hLgkf/X7mIotPzsUNWb3K2Z3vEPizgRtWE
	vw0gbJ/504kBISkNgSiS2sQF7xnkogXAW4KTyzf5DoT9O/UiuZPi27Onq/uvO1Ar
	PBNafbyz2VLVchhPckptyUERrJQ9HNIGAKoIrdQu563tyTZnJfxLLhXrXLj5Pteu
	0CbiJv3dm94yqOdkfWnj1UgCeeHhgpQdJFcEsLBCDpPrDQOzajATP0Xt6gSKvju0
	CtLWB9qi75TSh9uGCVz8y0fLMN459HxaIPKRsSv2hpld7kknJ9Ne92Pd7EM0HtVG
	DC9Cy7zh7xeXHx62f8BecHAnjbXP8xYOcxO4bkXSKalke5OXFCiQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvww0g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:20:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFvanG030016;
	Tue, 12 Aug 2025 16:20:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa6hkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpTNPTGYLABWSlo5wJ929v9hLXvb0GMTp8GHcvdkYY1I8uxy2pi5xjukgeUTvSA08TI4JiwKpyi7Hfd3D66dHlXYvwigaOvW9FsuHrpzxu0eRcxABG987dASyG3osWKyzPT07HOtoMjhanPXOFGygBpwyuDPs8dVucRdV3GFaDqWtmMyAOQdvyemr3UOWVG0DYt5p/64Or2l27mXdEJaDR/V3qHP+5cmWOnZqA1M2JW6LbN4hTCKyr0JOojgntmwzEg4oRfYtsxjxoHjomucmE22tLiIUP8qLk9Wx5zMDw4DUATbxlmYxsHJ3/ECCuQW2AyL6LZHbonTJqcZsOTYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d9hoIGBFdc5WgKjrYKw8FUFaAAIf8MKWF33Rg0wTWs=;
 b=Fwig3h2B52RbLgwPMwzEKCdrD6iY2B5PmpThamTnDxTnZpwB+F+I6DYL1fNfs7GXzFpl25cZcjtFWaSvr+GUAxOiyZiO/JO+EQ1QHXinPP7U0pq+uMoNssl+Xh5s3/RRhwZY+7prjhIlQbse9WsgJ6oDSYRixCtf2OE7/8SLhDaWpjaxnmQUQOQFFm2n2LNwDw6aVhOGXfIwRMyccoNyjhCbhObap2pKD9vnvcjJvvnHUrdw4YnRXbPscsmCuzC4Y6v+tLs/TXLO2cYrDXUmf50N++OEsxwdppbOInqMS4hgbVGv5FRtr/GRi23kebaXj+PhCpD19ujvzjB40SCagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d9hoIGBFdc5WgKjrYKw8FUFaAAIf8MKWF33Rg0wTWs=;
 b=brnuPIpAh12Db2NgjDFOsaROjn0kT5TtPDwkb3zmb7P/iaSpV5qhqmPlrcFXi+++JoQjr5CkYSk0lOYrWvIvev5QgWgsq1i0bH3D7EgozFs1igkwGuRI+qIzAn0UWVs1soqm9ILU/5vy/Wx3E9UUQHkoDVawZGttai04N9+fZ7o=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO6PR10MB5556.namprd10.prod.outlook.com (2603:10b6:303:143::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 16:20:26 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:20:26 +0000
Date: Tue, 12 Aug 2025 12:20:15 -0400
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
Subject: Re: [PATCH 01/10] mm: add bitmap mm->flags field
Message-ID: <sukrlmrtkx4cc6jgwqgysjekl266hgkwvxxknt2lykcfd2ifgb@p27adyukistx>
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
 <9de8dfd9de8c95cd31622d6e52051ba0d1848f5a.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de8dfd9de8c95cd31622d6e52051ba0d1848f5a.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR0101CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::23) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO6PR10MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 14420e43-81fc-4edb-3a17-08ddd9bc24ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhtEuNTPjPCHPbsrj2pQFNTskWFFzhYCFlEigxvN+YgRb1p5d97o93VPuLEM?=
 =?us-ascii?Q?PhxIt4xrCkib8qqrs8iYgdM3Du3Q7jwKV1uwa9Ulxm3bhv2oobISSEdviBJu?=
 =?us-ascii?Q?UEIOkgCbMaiFFMToTRAWz3WHvMBbVOMahcgTvE6B70jJoqIGoDg+mWdJXtFH?=
 =?us-ascii?Q?WgQ1O0YiGhdW75WBocKJcUlOqYr5nnTnh0cDbx71Iig8622mw7rd1SVcxRhU?=
 =?us-ascii?Q?7zfKXJh6t+QkqsMgZNfYlTL9mjXnhwBe+AcJ3sSNZ4wtfvz5R3+gEnEFPX5q?=
 =?us-ascii?Q?k1viAUz3N+U9Q/vfdX1vYUhWxERGd5p/3Y4MGS/WVjLing8S25fD3ALsMm3O?=
 =?us-ascii?Q?1OPLnCr90XAapyKMHsIx/fFRCXxNrPvEGgpRL047MWtwJrMBVM/QEWxhCwaj?=
 =?us-ascii?Q?Si20Ki1PEF0UbierszJA1mVv2QH+9VC+Bn0HmCGEDXuMTwHQQCZdjbLXxR3R?=
 =?us-ascii?Q?Dg3fDCvGHWPYngBICFbdtm0CvEvj2A72xkj1HXxW32CyWpqly60gS3LCSKt1?=
 =?us-ascii?Q?tfBPGoSnFCUthzj398xaoOw6vB6MTBodYq1A9tujtxMWz8oqxWmFQ3ANIbpA?=
 =?us-ascii?Q?vPUWCzQsQESFUle2usWl3NvNRztyLSv9GhOhWBvMeofnKljt0ZxKGUivVCB8?=
 =?us-ascii?Q?qOiaXhsNNwkbz49HNFWwEHvAlvk3NZ5Rg88YxHjewAL3+ouEl8KaF6uzve2a?=
 =?us-ascii?Q?ExcdZg4iEWi/obfghvbs32BVZb4RDa/JaUMuLm69/pUXrFuaPyrpfBMmWL2F?=
 =?us-ascii?Q?Ot7MIwAFmq/OZ+awpEUIc+GY22+3kdU+lE7TyzdoFGI6/9xcaShAtabALp85?=
 =?us-ascii?Q?vO9kz228sVrxMBiB1k7YdPpVdQrcMqggdExTKXqkuelNJfVQAuHHqHOeSA2K?=
 =?us-ascii?Q?OVSTqX1AcVaPFiBSXcTHjCUCbrchheelRJCuGzAHSzRo1wnGLtDm7wT7/D2v?=
 =?us-ascii?Q?dH77zbOAHwhjxI0EI6ftnQizcwHLqMpQJkcPRNl8uBsT4Cd9VxIplVNAPHRU?=
 =?us-ascii?Q?u0rTkP2rlDvrTK05YdruSEAHMWhuB5LpQV+eL9zIDEN9nviaTGL9Gs5ucaGe?=
 =?us-ascii?Q?n7VHjNRmigfRDwdgiO+VcN1Sg8+xBWFxsTigfHkh3sUnuuqWPkvall254svA?=
 =?us-ascii?Q?0zfvg/YmWr4R7MXJ0r3+4oXq1ohGHQFdgdjXa29WMgo/+NRgZg1NedggfI7j?=
 =?us-ascii?Q?6u9frZHgiGHC6QdWl3+NiriEjsbQfSwQcNIE9umRjaMUH+aWNaobfMcMMDzb?=
 =?us-ascii?Q?/easqB8wZG4fNfRskReNrBg3Axj5QR5afqcchZ3YzRPCDO6SptCDiEPNifrv?=
 =?us-ascii?Q?Ai5mUycDoJxVG3dQlTjfi2JO8gtWqvALuibBkqvyZKSkOwxxvvQ+6BIzNIXz?=
 =?us-ascii?Q?7LtWiWNZrDlFgg1fK2MZbiwb7Z147IM51NrhGae36PqG+SJeeM+gBg9TZD05?=
 =?us-ascii?Q?1VSp+PA6E0Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSnEVSkY0kLykN8UgtYMO/L0YoH5dVv4mcJcZ0icuzjeTF07CqeOB+SnJiR2?=
 =?us-ascii?Q?q19CsDgE355NQW5fHK5rPsMLFGV1bo7fqKYVa8kRGmnIyqOsoInVrZRLrre7?=
 =?us-ascii?Q?ju2Q/+WoCzNbMTbfyxapdKYPPWFNA0cFWTeVZ1VLlUJCPxiDSoTy6cC9Eh0y?=
 =?us-ascii?Q?iKqEhDi/Z+DkgObxSLEp+RU9vYM08aqpZ3MLC+SzAAYpPHDt6nTX5GH0sotM?=
 =?us-ascii?Q?Zv2M5k/SkY8ghI2KIqb0jcFjLMdImPrrZKbvyvrHq7T7uWjX5yhXNEHiv1na?=
 =?us-ascii?Q?GKZL3cu+XjT8O0Jxn0rg7UpQsLPPum2oUpu+5qyguRJ9eIriDHFJxzAtt/I4?=
 =?us-ascii?Q?IjbJe0xWKFhWHh8895M7uHDVwJ959p6xt1MUcJqmseyA4vAm3+xvk+pHVLGR?=
 =?us-ascii?Q?B8rpP9ZQv7ONjnNxFhLl4CTGC2fQQVc+OnIaRYK7y4l5+UT3XlB/ZNuAtDbP?=
 =?us-ascii?Q?szh6OSQ4ZNTYhdKmD7A0UwgbR8Kt0G/+HSjEGfbIHLAiv0AgqWd5RWss2O6x?=
 =?us-ascii?Q?BH3rWFmmq5mDeu9+piFYY6EYJEtDmNVzTROndrafTKip9pJZR0AreUTL9Zct?=
 =?us-ascii?Q?jkeiRgjox2ndliMiO+vQP8I1enp4v4uVnyOcEOGeXG1nLc6zEkmiO5lIOP0r?=
 =?us-ascii?Q?et9wxmI4xMsgDsgIFFXhuDuM9rqnu8+nLpx9/ZPU4SglDt84EXUU/GRQSujS?=
 =?us-ascii?Q?23BoXez7cfTR9Wobbila+/TKtjwfAAJegcOAKk28Yyfey0Yk+/lsmDbndTOx?=
 =?us-ascii?Q?qQKF68ndEy+bpgxukHldovh7pPxAemh2fMBwz+ZtHWYmANRf53N1/cax7XUK?=
 =?us-ascii?Q?Mrqjtl3e9ZJHeEG4bU98W95yjMT2Fo5VHDj/oDCsE2l6y99QjxE8pVIIdxKV?=
 =?us-ascii?Q?KwnKZO6Us8kBqrcsKdPUHVRaF+/inYaa5ezc5sBP1GQKyABsr9iwIbKFed13?=
 =?us-ascii?Q?gYxJ5htI5ccBMf9vQMRYHEGnbQYC8O9fXWkE8Ycz+KgxtIHCw18fXz6IlL/Q?=
 =?us-ascii?Q?WbrzZqoTv+2it2YccOHSXtRIM2B9/bRlZpAy5VIUkwAQDVVNM+04DfqmY7EF?=
 =?us-ascii?Q?lY6bRewaQLRvYpX/Uchn/jpXttkP6FYvuV6nlXibYQxGYr0KQd0YpgiOtE7p?=
 =?us-ascii?Q?4MgbKj2PKdBFn2R9PVQWuDNp1kC2rmbg+/wadJOJaRZX6Je3uIvAsyqPZtHE?=
 =?us-ascii?Q?wIsdOgQB05Wo2Of8qfrHZRm5JZkaVKQugiugK88dH+TjaM1cbCX+EaAJ9WNJ?=
 =?us-ascii?Q?4Y3uUbnjj90sIC0ZPSnOqXwHBZnwYFKg6Km9tFAnV1RZ06wtYIQKw4NqWYl2?=
 =?us-ascii?Q?ciPU9B1KZMSguO7r5rQrutqygvRH7XjFUL+yD/dYcjpw14WHuyKbWe+55eot?=
 =?us-ascii?Q?s31YPhVQplWorrYB/Tqt/j5VqN9tCaQt3tYY8KX1UrguHnMp/Fv4Bi+n+kCV?=
 =?us-ascii?Q?XGn3cohFEa+rinx/j7KStVA43EZ1WtCif2ma3XQuCfjxe/d+dKz6GR0ye9Z8?=
 =?us-ascii?Q?IcrxJU8onGnRFOxz7KCItnbN7gJrqnsLswWNQ88vCNOkl3c9LW00KvsxNXay?=
 =?us-ascii?Q?rJkD2KhAaqbn3Ac0RDjkHQcLJ/gu9+r+c4/VY1J2Gc61EvmYS2U/V1vwrjAj?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PGGMd020ust3fZ1rzqi/Nk7Wn41lxb2LYihrf85vXRneAawLNvbbNa436PL3pkd28CLQZbRiIwSGveAYU/PaMFLRspkNGjBm8tYptF/PreyAi2GyjvsbkcL3ken+4OmM0UYQnQrWi7UU8qjbdZl4cUrMPHdXbfGQLlMf/OnLeNMCliS9tvu/JBOXx75gz0ocNm4JUPbieMpPx2XWIuF9KGkhDVd8v2fB8DFGjB+MBsyg3FvxS70cFMFUhi6oXAoYJ+DyJWcUOHFI5V0PohuolONO3M1tZtAGh1Omsilkio9Kn8tiryYKLg9Hbi5uPlLq/pHwVSZM5hPCt2QbCXvqyHokFC0fxRARcc9lMw3BkibC7o13qVcC9RRbiNgV2CaVMSY42y7s3vFrfHK+/RKsLZ4XR+P9YCGEUVML6QA1y1ryYlQCE4g3h8Tq9vLoggV8qMbqAu+238vMNVcDLlGgWcJEKZBgeq78dK+gnuZ+l/jlLUBq2Dg56eAtVY4tDsIYkpgIoRMx+pI/Ydi2/wyvk2phOd8k644EX8unH1mqKJdwXoNHwSdDWLlvcLHgByIB/86ced6KHv2zfK6EyJHk4ulMmmgChyJf8pakXIbpcDc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14420e43-81fc-4edb-3a17-08ddd9bc24ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:20:25.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqDY1UzXPhprkQs2fsFfvrGlVREQtr9rfXC1+EthXHhBVtGDLm/1WolAxTryK0iR9dVA1ZqEaDdAvPHwF+Oj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=566 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120156
X-Proofpoint-GUID: vS0GnpEK91m1wMiAJyWI34RLB533ML2e
X-Proofpoint-ORIG-GUID: vS0GnpEK91m1wMiAJyWI34RLB533ML2e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1NiBTYWx0ZWRfXwhK/bjyH56S/
 RXUM3L65vNeodtFwf43rt8t4jXoY0gD/NsK66SdOP5FCccNIP9Can/KUCHX/VmdEm0IXeL6k7Xt
 H901PoM9DT7y+fA5xNM19YUoixopcCbyRbM6G3YGKLITImxV942n47g8HxZKcIJUwJskMcyCBCv
 bgPdRQiSoMZXPpQn+xSrFFCJOyBNfS+fmH3RJ1drKqiJIKANsD6smesghd9yxVUO3lcHJ/CE72F
 flgUdMdIneFJKo/zAKEOJguhwxIujIG43FEXxVg7duavimwNZ814/jk445/YJdAg/BXnQMjtepo
 tLyET2ccf6p8eh1s8L4DFI7cCxMYC1PVMrTKXNRMHpCzZWfiZmhrW1QdORX6A91MGKcgKuwzotD
 oxeSH7AsctiCZqKk48DMd1f77z/LhxhMMjtWK2Q0h1UVgflbmD2N6CPv+uya/0LvIXY+m2YZ
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689b69d1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=b2A2CqdJF_LT2Yjdk88A:9
 a=CjuIK1q_8ugA:10

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:47]:
> We are currently in the bizarre situation where we are constrained on the
> number of flags we can set in an mm_struct based on whether this is a
> 32-bit or 64-bit kernel.
> 
> This is because mm->flags is an unsigned long field, which is 32-bits on a
> 32-bit system and 64-bits on a 64-bit system.
> 
> In order to keep things functional across both architectures, we do not
> permit mm flag bits to be set above flag 31 (i.e. the 32nd bit).
> 
> This is a silly situation, especially given how profligate we are in
> storing metadata in mm_struct, so let's convert mm->flags into a bitmap and
> allow ourselves as many bits as we like.
> 
> To keep things manageable, firstly we introduce the bitmap at a system word
> system as a new field mm->_flags, in union.
> 
> This means the new bitmap mm->_flags is bitwise exactly identical to the
> existing mm->flags field.
> 
> We have an opportunity to also introduce some type safety here, so let's
> wrap the mm flags field as a struct and declare it as an mm_flags_t typedef
> to keep it consistent with vm_flags_t for VMAs.
> 
> We make the internal field privately accessible, in order to force the use
> of helper functions so we can enforce that accesses are bitwise as
> required.
> 
> We therefore introduce accessors prefixed with mm_flags_*() for callers to
> use. We place the bit parameter first so as to match the parameter ordering
> of the *_bit() functions.
> 
> Having this temporary union arrangement allows us to incrementally swap
> over users of mm->flags patch-by-patch rather than having to do everything
> in one fell swoop.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h       | 32 ++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h | 39 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3868ca1a25f9..4ed4a0b9dad6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -34,6 +34,8 @@
>  #include <linux/slab.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/rcuwait.h>
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
>  
>  struct mempolicy;
>  struct anon_vma;
> @@ -720,6 +722,36 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>  }
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
> +static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
> +{
> +	return test_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +}
> +
> +static inline bool mm_flags_test_and_set(int flag, struct mm_struct *mm)
> +{
> +	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +}
> +
> +static inline bool mm_flags_test_and_clear(int flag, struct mm_struct *mm)
> +{
> +	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +}
> +
> +static inline void mm_flags_set(int flag, struct mm_struct *mm)
> +{
> +	set_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +}
> +
> +static inline void mm_flags_clear(int flag, struct mm_struct *mm)
> +{
> +	clear_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +}
> +
> +static inline void mm_flags_clear_all(struct mm_struct *mm)
> +{
> +	bitmap_zero(ACCESS_PRIVATE(&mm->_flags, __mm_flags), NUM_MM_FLAG_BITS);
> +}
> +
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
>  
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index cf94df4955c7..46d3fb8935c7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -20,6 +20,7 @@
>  #include <linux/seqlock.h>
>  #include <linux/percpu_counter.h>
>  #include <linux/types.h>
> +#include <linux/bitmap.h>
>  
>  #include <asm/mmu.h>
>  
> @@ -927,6 +928,15 @@ struct mm_cid {
>  };
>  #endif
>  
> +/*
> + * Opaque type representing current mm_struct flag state. Must be accessed via
> + * mm_flags_xxx() helper functions.
> + */
> +#define NUM_MM_FLAG_BITS BITS_PER_LONG
> +typedef struct {
> +	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
> +} mm_flags_t;
> +
>  struct kioctx_table;
>  struct iommu_mm_data;
>  struct mm_struct {
> @@ -1109,7 +1119,11 @@ struct mm_struct {
>  		/* Architecture-specific MM context */
>  		mm_context_t context;
>  
> -		unsigned long flags; /* Must use atomic bitops to access */
> +		/* Temporary union while we convert users to mm_flags_t. */
> +		union {
> +			unsigned long flags; /* Must use atomic bitops to access */
> +			mm_flags_t _flags;   /* Must use mm_flags_* helpers to access */
> +		};
>  
>  #ifdef CONFIG_AIO
>  		spinlock_t			ioctx_lock;
> @@ -1219,6 +1233,29 @@ struct mm_struct {
>  	unsigned long cpu_bitmap[];
>  };
>  
> +/* Read the first system word of mm flags, non-atomically. */
> +static inline unsigned long __mm_flags_get_word(struct mm_struct *mm)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +
> +	return bitmap_read(bitmap, 0, BITS_PER_LONG);
> +}
> +
> +/* Set the first system word of mm flags, non-atomically. */
> +static inline void __mm_flags_set_word(struct mm_struct *mm,
> +				       unsigned long value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +
> +	bitmap_copy(bitmap, &value, BITS_PER_LONG);
> +}
> +
> +/* Obtain a read-only view of the bitmap. */
> +static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct *mm)
> +{
> +	return (const unsigned long *)ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +}
> +
>  #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
>  			 MT_FLAGS_USE_RCU)
>  extern struct mm_struct init_mm;
> -- 
> 2.50.1
> 

