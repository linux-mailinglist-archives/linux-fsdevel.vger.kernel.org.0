Return-Path: <linux-fsdevel+bounces-57546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED6B22F2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D56807ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6BC2ED17F;
	Tue, 12 Aug 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VgCwdkwj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QCF46kmu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F82D29A9;
	Tue, 12 Aug 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019969; cv=fail; b=M6whEEgLfDIfXRxAyromgjfv3qBGA7JbvD0h5BoWya4w6SECPkcV6XMfSs4+NCx/XDZ1hrbWRGowCPX5FLkqA+z4qtdexJDchg1vXjYCg0OHz5lApbcbiy6Mx5qHnqIoam3RtQe1ykrpYSW7BLAvza3NpfImGcsY2T3evU/+y/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019969; c=relaxed/simple;
	bh=uLk6cyIcGbCe/IE8z8jlMyne8XCnGdX+8eu4kXM62Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hCsO7Ll8PcN9HRRWMrAdD4G3I0NWKaSwhsK+neE73W2qVK4H3rMrmm3oJysyEVbM3VKhCjArpNZKwRwbmXtR/xWg/xxYeg2LfYQLKX8H1jKII9+UAq5e1skdVvdddIS+V0u+bA//ELzGOHSs005Z8O8XXvWpfbGvdxXzlE+Er3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VgCwdkwj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QCF46kmu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC0IZ021868;
	Tue, 12 Aug 2025 17:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/o1ZEJJAxxggij6O/q
	UVlPcji9vQ4O8hW8fTrRBWpgs=; b=VgCwdkwj1vVs5N1haNLUAyG2Yi3fLqhyo1
	anpw7WAqrxSs5fOydkGBH8HsQRs8/y28zQM+a+9meGedXx3321KVCASolULVVnuJ
	xk76x9zxmQyXKowu+MJicCv4HUhPIzjj6Cj2BdJiG5Nr7yY0vW5mJFIncSvOZ5ET
	tPh9N149BmBnuqaAbU9FElUp4e71cuibtXE7lnivqagIRfMRAd3yxcRzTdV57cWi
	xIh3951+PU5VY3W28hpRKlNJt4y7Z1SzItGxAmGNTTsYkl/WaC/Fgb4KjzKgZWYf
	dM+mFHOj161OPH2+O9gLobAJ4fdaPe9RcWJTKyImVF206Un+4rbQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4d8sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:32:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGV8pS038595;
	Tue, 12 Aug 2025 17:32:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgtg1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiGy7CzhYBKb/UExUTnSeaxhkkMXdN78rJiHHJlk27nx0fEHUl1SjOu/KhaqBI9iQu1NClrVeDkYQr2IwbPe+yyqKQ8erfjh7n95UgcH+U6UJiCgjJQxmtUyKZJNvrkKWVKZ+w3UbNhabV0zPMJ4tXALlR4NCxvm5X0cn3vq8pXpEVnCd/uF40lnBqQC/ZUDXr82g0TeO3FFVvl6ZRgCx8+9PvGD9O+jAvoShh+zy1j+APMUjETBCmVlttlWgtY5XQrrThpMDCY7yhJia1L+8FosvXZekqKGLPitPFpvNqcvRpPpr5z0+2hAkdW48+6gyWlYHfkUnVFDQA7wB5LEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o1ZEJJAxxggij6O/qUVlPcji9vQ4O8hW8fTrRBWpgs=;
 b=LYgXh5d8J4rSU1CcJAT1kvKxX73dGMs7CMpkbUApGClSLuLR6Nb8vVFn2u+Eu4k10xzfP1uS2gr89ukA/zfgz+bK+a0LhlDaiCUizchmwRL+n8+PndbK8d0gMoTZ8emwPULGSmklV6CX8iproO5MQgvMUrfYHfIolIyuyZu6AgrUJW/epqpezTsvxxaRQxzOXvCRbkjM1cWzU5423/54TdS1ZE6gTIW77B4ddcP0Ns+n+xQvxbT6yNVbub079D5JIi5A2bQR1KXJqS8uJzBxFKH1pXtvYiwe0sa+Aawbwh95k54liFw2fGEcVoVzoT8rwamP/aPMsttuO1JwChaSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o1ZEJJAxxggij6O/qUVlPcji9vQ4O8hW8fTrRBWpgs=;
 b=QCF46kmuNrNc2VIRmTv76yuPsjfDFDXYW4NMV+OgcWoBrQKVpPRkA6taONRytJfH9aEPwrKjNHO5NjRwqthkWesykiQRtuAWBK8u7XIaZsnG4BVvXG7glTmTe5y6MoDY4nbfPTK3chr5cmSDz89hWJUfn8l7QSCBvqgvm8TnBn0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 17:31:57 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:31:57 +0000
Date: Tue, 12 Aug 2025 13:31:50 -0400
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
Subject: Re: [PATCH 08/10] mm: update fork mm->flags initialisation to use
 bitmap
Message-ID: <zvoxt7bjp2niffmnxjki7tcfspvwb4mcxkw5ab5huwnnsh3hev@qbwtyxdg53uf>
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
 <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT1P288CA0014.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::27)
 To PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 766c668c-668a-47b8-07a0-08ddd9c62328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5QktSXi1Y7FB0KlWZlDb5mbX7IOl8X7cVBcXYkyV5fIUX+fAXEjlJoce6S9J?=
 =?us-ascii?Q?JRWYRjWq7GHlxPt+qX7+qXInOyHKOGgrhA1KNAXcsh7rytoq+75Z52kKdbNg?=
 =?us-ascii?Q?pun+9Cm7vsQ7+o4EwZUK/eKMY+rUiTRvkGrHSb+ISzcpsXmZiWmQAN6rRO+M?=
 =?us-ascii?Q?BL49GxPTB+WukZGIFYeaBu+wnRmzr9aPEp7ISYyuz8RmK1SXvjuRfmkS2SOx?=
 =?us-ascii?Q?+/z2GvEqKNm7IrafxDu3+9PTXpp6PrDlQ5SRBLGtvAg/KT8NqLcHM0Ic/Kbq?=
 =?us-ascii?Q?fEOjD7B3jB2mC6tN6kItslZ+y79BQp+WPdkZNA/0JiqEM0LbClbFGLqKYrSI?=
 =?us-ascii?Q?OivoVOVyRIEop9gLJtojuBwHpwoVtq6wtLotjEq/P1/jgzER2m9rYCsK/1YP?=
 =?us-ascii?Q?il2QnKEpIcxSE4p+v90ibHsckrM/sr806jrw7WY+iiyKdtzpXVjF3lPIzgE6?=
 =?us-ascii?Q?6zJmTddCrYY7AoY6r18ZUPfzK8MEk+MUZXthmLCMvFaLZ+gCX09+spVX99XI?=
 =?us-ascii?Q?U5t6fFYW3i6qFUMkvNhJrRR1XQVuuM8J87xjH+SBzGe6eKeyCCxdWc25cYMF?=
 =?us-ascii?Q?DAJS0Z2b+hlMRd/eC32TOfrwWpBFtAiFXe0sKe1LNpWpUKA8Q9pgtZXmaZ0A?=
 =?us-ascii?Q?zESEmw+9QkKPph2ZcF4i6tMDcGah6Zm1lh13zg3+Bvn/yFJo+yWrfrxssG+5?=
 =?us-ascii?Q?GxiYfpO6PGbAo0p/uQRYfEp2ru5SWHtkCHRz8oRWav8Qzl9RplDr4avJ2xPA?=
 =?us-ascii?Q?wk4/qY4EHGLDvLkYAUIVTYN8mW6oXXOXJf2AhD9+RAc/MYUlXWs7HnjuaryL?=
 =?us-ascii?Q?LWUwf+eAb94UdNMnQK7NOhqC6HdVx2pbP17OtHiXcgI4JX2biisLYtK5udS2?=
 =?us-ascii?Q?gjcf+tGjNSyR5hlmrW/qYC/ypndyeyLbMwdjm/5IFjjXjNJMyw5AhACt5it5?=
 =?us-ascii?Q?frpiIoSPwHu6PPpZQJa4ZesRAMr094lES6OxjZ8O8OLAGddv57EMVcvWjcLl?=
 =?us-ascii?Q?bUax1PjVP6uh/y3INISas0cUtFcd7yRcsc7/XEylj6ZliVvwPFsdLPQykJf1?=
 =?us-ascii?Q?OZrGMTtS0PkS6X4zVLQ9ypTJya4FZGNXBg4be9Kq63Hi2A2myhtBt+zzGav5?=
 =?us-ascii?Q?n08hmBneM5j1ThWIOK/KfaPYDL0McRhf1haxHDupA1wajNliqK37kyDxqGU1?=
 =?us-ascii?Q?elvn6VFYH1rfqBtjsSt2Um/GkISiimycZjsGeAa7lMfDzostGap9x1xyLEl+?=
 =?us-ascii?Q?42FJ9vyGedeIMS3xigdTf+3wm52HaUZPRFlyy4QRFPYmvzZj6yKvQSOWam1r?=
 =?us-ascii?Q?ecfQQs8sPQgiUnrmeAOWYldbiHoswXuLED/s0rGfOS4PUqHtOUxLloORcVi+?=
 =?us-ascii?Q?AhFNYmVSIOVPQUZS5gSlPmG5lNw6cQgR1KPLr2kccM+GgyjxB6+1yrdkeOkv?=
 =?us-ascii?Q?eBn7EEvq5LI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+LEUnWR5DDzX4MjapnPirKH+YXO4xpoDUyW43MSW8IGJxdQgj2wiLOygwGO?=
 =?us-ascii?Q?MFq187sfdwaz6lYcRD2MBC+B2+z8Vv2Oo0Vmz6KCBccbczTUlyu1MMWLfXRs?=
 =?us-ascii?Q?YEPhnxxeAM5OcsRfH5WSqCcBCWGji0jEjNtqFLAoPghM/iYETwaR45Nob2pm?=
 =?us-ascii?Q?Tadu4dEjGF39R2bWPrqvL6z40VlD5oHjEGoyChWllKAP3CxmXzV4o19Bnbyq?=
 =?us-ascii?Q?T8jvEqDlzpM9x9rq/wPp4w1UMr720xIT+c/AwpnCw6FsF1mokPwoyV7lPAPZ?=
 =?us-ascii?Q?byVkZqjjm365v6okDRto+v0BIjEigDHEI/XhOu/dOM0WgHLdikN7ZRDzLp21?=
 =?us-ascii?Q?J5JAePDfqj645kHKnRSctu4EB94A0rDBOOG7A/tFP8a3mswak1ZP1XwnqJfi?=
 =?us-ascii?Q?/zQlmcoCWqctSjkeGgZf+aRDpurYHif9471LMSZZwNRBCh7AaIuXAscOLUKg?=
 =?us-ascii?Q?qk6O+H/3XECmMXLiG4CG2Ynmo0pGm5EmUQWAgLB4ofeChEwspz0dJT9u48Qc?=
 =?us-ascii?Q?9iMdWwyyi7Fa9W+GhcFm3fSSU4wOgnoyptbEqEj2EbmfUs+H0D3AWcnc98Ui?=
 =?us-ascii?Q?4S+4hLjdi/rIcZEtNhdqNMiEBvJweXNn5Tnc5iyKOPJbXJrjb/Ft9M0Lll6h?=
 =?us-ascii?Q?R10ay5R2PjPD4dpUACIYN7SSxZGjo0OLmjJANqo2rQrVG90UUxVyBoDc92sz?=
 =?us-ascii?Q?melzH/4Uken/RKTiKqF+6Yyj0G2W5X+AdST4L53wFmRQQSS/2rGV6Jux7MlT?=
 =?us-ascii?Q?HRkuGe2pX3qKIzxgEO4QFhZvFEtGJ68YPzbD6jxoeT7b1Ymt2QOyAfGldDE4?=
 =?us-ascii?Q?xDJ8DTyg5nr/MBtaKnfrLf7VpqR6FyNcen6vp5Kd/NyrtA0kIZbsQXbeDwAs?=
 =?us-ascii?Q?UvPj9Y5WAcIR69cbifeDoKA5b+Qa1nA5PMcimfSuKzFGme7HvQtMatAeGwU4?=
 =?us-ascii?Q?82gqxxctWMqqHlDfXWWpw/xPYanxZCKOqAx7cxWRGERWfkyABbdZa4h9VAGw?=
 =?us-ascii?Q?LzcDfTHzjpPCNj7mf7x6pmBGGrroK4gGdYtjyZpxxBFl7grAWgcqAgNL9O7d?=
 =?us-ascii?Q?cIE06KYOjS2D6eINpMqBD6fC5zt9rl9pfnSFVNELz11STEWsHuEm1ehDXZfh?=
 =?us-ascii?Q?FDGuAZ6+Vzhu+klKanxtTMQCmcsSS5c8Sd7oMtA7fHg4ik3Qk43x46fO7Sju?=
 =?us-ascii?Q?O90qEmwJ7ECTC2zOZeE5yopL0h4y2xBY5p36FepCci/93+z+s+W8yPCFHLXC?=
 =?us-ascii?Q?4CzNlPsTBRtpprL9XBqQQXFhVLoc4vgglV7yeUnoon6hNrfTaDMDkB0NgDab?=
 =?us-ascii?Q?cWoyblpYfiNDi1Cjrbl9deqw6HIe3HBLz3yueQtLrQ7oI3za21X6/C/8AioW?=
 =?us-ascii?Q?TaGVnGfq8KUdlqQFwxIxvG566sQV2u4JuN3NVEbkUkFrdqhlvx0K4Y8SqhLv?=
 =?us-ascii?Q?hlgh3C565oxJ8Jk4aDWqNUDcrZAg5CsQ1avVNh1CqJBWnXzndiZ4esbhE1eA?=
 =?us-ascii?Q?sG7/l/W0tObDI7Afs0VLF3IN0pabH8pQ/+onw3881zN4xiqxPKnK3fD4oC5S?=
 =?us-ascii?Q?+yEmO4LIVLObm+aTk4Dqxfss7HorYvX14/kpyRUi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P9wL+VTWlLbzXE5R8Pr1pdqpY27WnOzsvnMfo/TegfboRUjUDK55gi636j7g6EUtMfll+jHlPClu4XK6qBvvFt2esJaWKnbWQbSAAsNI6DWrvoS7q48r8pT5WMlcpJAoo9w+cxWn5Q/doFpyzR4C2AH+dohYu8a1wZaf3ufrjjCNT9S4J7DGusT1ksrJEZ2D3KtTk2ux8ZSTkFCAhzXP/ENYCZg9PIguklGuJ/4qMIEPDQfbXxLSlQRlKLHNMP4AjN4PqV7WQkXAwUsZwv7f9rgvGnNJwMyyp/ysr6ZIwKyG1oSZsit0fecdoZW4gemkYwSjo0uL4vK3DzUF0fkX4VeoeSD/av5i0j5M3U/1v5QhydfqOkZIEEn2OSAOzioY3XeXA+KjsfiEPIs0sux3oNdmxs1mIu2llT1bxaLGV9ux9Uu0wBaSjyzKKxwH8Ghi0npmlnuE2+3tfeenQnRgv7yZeZ/KcrXgq8IFjroj3cJQjeg+1VNWob8Gh7gglz7hDZPsZLR3Q4OmDzG0Boqi72DUZITGYwYqWgTAzGrZQOQSt30qsD6tWvL44I2RNgtZwLgEvkCHKsFNuxO3TL/jQWkHNFLt/P1RnsoZBONqh1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766c668c-668a-47b8-07a0-08ddd9c62328
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:31:57.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MSpBD+TKYCmd0D3tW+ITGcuvSVz73rI3u7kBTsTkpA/6ihX7fhvQgye8IQUVcxj3YhjR0iJnP8tSm9UblIGgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2OCBTYWx0ZWRfX12d+MYH9tJns
 lh79++aROC9uaNKNaADaNsGw4RWqsxV81qVjJj/EcN2VQja35e6c2k1hwiGhwlIxKNUNioazjoJ
 MvMFF41M8wfXZI5N+gkG9mzA0v5kddmpG0jPaxwMhpX3ZKrRJV7n9+w4bD+iWqmifydr1ei+xo9
 BdlMdI/pLz74QpF3Kk+bP7bBp3soGQ2sjYQgrjemBspa4v954KL7ksBOUyNaNIYvVuf+oUHr4NN
 EVgE/G5syg8+nZdpq3um5gbL7Hed8zVlMhELyK1pnHyMXYqrR5zxGaPT/b3xnb7Sh7AEffuoA5x
 R6eSw0QzhchjErYADBIg8caaBlp52oSIRiuZSiDUwIO1zhI3mvvckvFKgvp64wkoL4KE4gkCRGG
 8ibnZQLg4XUF8COpQ/SpLSnZV9NsOeVPOfr/LER8J84vBJihCu0srnP7SZzZoCGqdwTEBdqB
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689b7a92 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_DyhGWQx9tc7Uwkf4PgA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: p74kbEvLkDAqxs7ukZNS2soP4_8CkPl8
X-Proofpoint-ORIG-GUID: p74kbEvLkDAqxs7ukZNS2soP4_8CkPl8

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:47]:
> We now need to account for flag initialisation on fork. We retain the
> existing logic as much as we can, but dub the existing flag mask legacy.
> 
> These flags are therefore required to fit in the first 32-bits of the flags
> field.
> 
> However, further flag propagation upon fork can be implemented in mm_init()
> on a per-flag basis.
> 
> We ensure we clear the entire bitmap prior to setting it, and use
> __mm_flags_get_word() and __mm_flags_set_word() to manipulate these legacy
> fields efficiently.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm_types.h | 13 ++++++++++---
>  kernel/fork.c            |  7 +++++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 38b3fa927997..25577ab39094 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1820,16 +1820,23 @@ enum {
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
>  #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
>  
> -#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> +#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>  				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
>  
> -static inline unsigned long mmf_init_flags(unsigned long flags)
> +/* Legacy flags must fit within 32 bits. */
> +static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
> +
> +/*
> + * Initialise legacy flags according to masks, propagating selected flags on
> + * fork. Further flag manipulation can be performed by the caller.
> + */
> +static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
>  {
>  	if (flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))
>  		flags &= ~((1UL << MMF_HAS_MDWE) |
>  			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
> -	return flags & MMF_INIT_MASK;
> +	return flags & MMF_INIT_LEGACY_MASK;
>  }
>  
>  #endif /* _LINUX_MM_TYPES_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c4ada32598bd..b311caec6419 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1056,11 +1056,14 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm_init_uprobes_state(mm);
>  	hugetlb_count_init(mm);
>  
> +	mm_flags_clear_all(mm);
>  	if (current->mm) {
> -		mm->flags = mmf_init_flags(current->mm->flags);
> +		unsigned long flags = __mm_flags_get_word(current->mm);
> +
> +		__mm_flags_set_word(mm, mmf_init_legacy_flags(flags));
>  		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
>  	} else {
> -		mm->flags = default_dump_filter;
> +		__mm_flags_set_word(mm, default_dump_filter);
>  		mm->def_flags = 0;
>  	}
>  
> -- 
> 2.50.1
> 

