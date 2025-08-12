Return-Path: <linux-fsdevel+bounces-57543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C3B22F04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12851A25CC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C602FDC22;
	Tue, 12 Aug 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bjq9iJz/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XB6Rd4FC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEB2FD1B7;
	Tue, 12 Aug 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019651; cv=fail; b=awnqnoCZ9VQelROGsI67tbApUIK6ST4lNOqanA1fWd2r6RmSssmsZ8+QOTS9JGAYhzRtCRDNRKlSHDDrqNnbaZx5BPSdzp2pOvJhHd2O2oSD6b0Fa/fdgARpncSrrFpRmVKKuaGrl9jqKjZ8sxphRVlevm/Oxj33KbaV+0stj9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019651; c=relaxed/simple;
	bh=F3HnVMCvvDU8NC5m8PG7+duVHJvKdbpsJmpPBgRPkrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NUFCYEW6z2eVx9dl4G1rukRsj5nz5WG1uWqIWFeMvMNqVfunLvLWCxFpOHxNRxe49n0Qhh9cv9f4kPs/c7LB9d4EScuzlMOPvr7L1ZrJPf1BpfeDOJQR31Cb/Yf6JHnZMBSGtjHvj10rd4T8r5OiVc+qK1xx+HRCVWiFVd4EKyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bjq9iJz/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XB6Rd4FC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC6vw006392;
	Tue, 12 Aug 2025 17:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Y8GhmpN6luQwTgzYZR
	jH9SxVaCA3hXDv8/p1ggptNbA=; b=Bjq9iJz/TmIpY54t1oHNOQ7ahcCOVU1jMF
	5bhV5ZpXr7yNikyeIZ9ImmjbL2uespGXiIU0PugYhD2YXw2K+u8oIxQx5QpVOdSl
	g33Q/1M6/Qxhzkhs2cdBG0Vg6YEXSOJQdslfXajxp0rPmfhCeqAcaZr6HC/CbNb+
	SlhEcs+8mmJ7xiiAJP7RWSLIASRqubN5ziu/xuM7Twy11OHVheClw5b+U++37ZKN
	AzL228V3y0Fplsp/Z9CUVA+5afZGZAkyV5gM3X8ozx9xvV1jIrDg2hlb/7354qh6
	6iMBp7GFc7+dIJlfs3FvnSKKapzoCAl4cxh2Goz4fabTisVVZlJQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dn4wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:26:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CHAjtC017414;
	Tue, 12 Aug 2025 17:26:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa8xu9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2Ea4k0SvukEU3H2EJGaFFsyqRJ75UjF7t4hSRgyBe1lpNEFTzoH6Wr3kpE9xGEEJL50mRFXXE1tfjaP0uYq62mFLTokAic5YNDhIytOe3VVjUdxXw7KzPAtJSkG2QGKUC0Q3ThvYDl249hPXPLwf1f9VkHenHQFHnMGngCsV01W/dLTC2BGtZXCDdv/ojnczMe68ihcOc/CAfVzjZVbX3H2EO+ordEzgDhPxMSTOIvO6pYROUf624hDz2oBl7ckgzIzderAWhd6YCFNhLeiEqCi195TlmIiY3BD5uTjd/u0Vbp/BzIE6xRevjiiYokYXPx8tnexEkA20L4hKtErFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8GhmpN6luQwTgzYZRjH9SxVaCA3hXDv8/p1ggptNbA=;
 b=XFuZJfD+Za6IWtxiQrbVK78DN2T3e8jo/FQx+u8HxOhpcGDsLp7ED+0PxenzJYSajC3MYzJkIgo7He8bNhIF8pQ1NElTRAFo/pqETnMS2XFJxsZVYaSKhF41Z+JuTNUYDJlGl2r+Os+T+q6eoVjw4tdVktWmNMHQbbL0BMdcNdXaKMujdLaO+BpTVHbADWvV0fHr9ZSZdeeT5YVQWYERlP4Nzzpv0RKL5uDCJVQvPBDSlPm6rgmYnr9g1xuulvoQp0FDbL231BhIJdvpd+01AGQyo6ppbW2pzEvIEstlX330cubQdgCo9UJHQfx2dQxxs73S1JBqJXoFoeV+Y7Asaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8GhmpN6luQwTgzYZRjH9SxVaCA3hXDv8/p1ggptNbA=;
 b=XB6Rd4FCH+u0/tIr6y22EUfsQUNOZAoUVFOznRVNZUnxfUY2dS3n3ttffbooF6wDAa04dfNhcdH2JG2zbqPHlzHV2BtKkg1qwDd2FmXMgq35cezs/cWuB5a2pU5j9KTYygvL5GYzLRTkcuHfa70j9t77fK0N8CeeT6fzZrVQC8M=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH8PR10MB6314.namprd10.prod.outlook.com (2603:10b6:510:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 17:26:44 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:26:43 +0000
Date: Tue, 12 Aug 2025 13:26:35 -0400
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
Subject: Re: [PATCH 06/10] mm: update coredump logic to correctly use bitmap
 mm flags
Message-ID: <7wjaerxsmtdsdzy5vfrzts7un2cuwo3nbf7khxzaetypu6tdkr@thz4i7e5shrz>
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
 <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YTBP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH8PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: c294d2b5-5ebe-4749-50a1-08ddd9c56832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mG0zp+/TWeFX8daBxQR6wU7nNcs3ORoimlc3G0fo6xJAyDLFWApTyOmZC248?=
 =?us-ascii?Q?fK2VAsW6+MmZ0HgU8T5ufPM0ypfczI58G4JI11akW0UmEpMiTkn3RoAexKw/?=
 =?us-ascii?Q?sB5Nns/qy2/eu3FK9aL0OA02bQL9S/8pY8xw6OhY84gbA2q9PN4EqXZqvrhe?=
 =?us-ascii?Q?vmRdiiZVEBqdOnrAslsCTp21faj+jZ62obetkzKckdcrOJ0vOVJO6dw3ysA2?=
 =?us-ascii?Q?Ka6AO1+L9w+Vt1CMQYK3v/OGIrwm+qatenhsBbS/HFx2FXAxwsRugBVm37yy?=
 =?us-ascii?Q?ggnU+QwOXfjn0No8zh6KtoNZCCBZ65gqDsniW8K9XthWEGmqRffa1Q5XKD7K?=
 =?us-ascii?Q?H/V+ywzvNnhh52IW1kA26GGvDDYeSNChulG24lGHJkxIMo+66Tqda0OqCp9X?=
 =?us-ascii?Q?hNw/SluRXiJDmqINjnoB/OIQSLx6RPqbFFS4WW3xQv4+3pqVpJ3EtZ6XzGaV?=
 =?us-ascii?Q?5QREgeUAxUKGrfLsqPtEQEFH9ICXvETGYxJGJfsLNBdQxBVWHAvbgTNLHs6O?=
 =?us-ascii?Q?0ezN7ZCS0OSM/q/YHLeUw7M8K7hXL2MROeUHQbW9nmqg7nGo1Ue6CAF0s0qd?=
 =?us-ascii?Q?ZoNcgpweOBya32XfSJV2A0baSuxBV7SLIIkY9hZAg6AVH1JYtussKT+GlV0B?=
 =?us-ascii?Q?zv+Bw2hMtIKoDeuc//jp7/iJmkKgPGal7bkuMjpHkxG7wR2fOP/ZYlp2oegD?=
 =?us-ascii?Q?eIswoTN4HQaaBRiQuU0vLbcH7J1jQh1gMnpvor7jKQZrmYh2HSgB5JnnOUJA?=
 =?us-ascii?Q?PuNffe7qCkWlWUAGaLxPyfi+Z+wukhTqXO8ka9K+2QEKLmPv+zZcBhp6Cdxp?=
 =?us-ascii?Q?RkSNZyHcZubMzOkqACWY+hz2uYEGZztNGnDQOojDyWGq1gyooUSFOhTpVZKE?=
 =?us-ascii?Q?BfnUrMoRDK8ZIJsAVL5zo06fFTb4TJwZDkAHtder/PWdGdy3B2GyFCklCtUx?=
 =?us-ascii?Q?x2XZHqS7J6HA9zMN5GcuVlnmq9UvoLLiYmGpn/Lop1X0NvfF+/w9tAv5VJMB?=
 =?us-ascii?Q?tjWXV6uRefgUFoEdkvBo8zqhl2PkhPD1+sp/QjpPDrCXgwfEyXMmpvK2kZZb?=
 =?us-ascii?Q?D157gDYHSIhfw6sghnG+/8cm6pzD9w9pzpOoDDdzACbVZb6wf/ay8mOkPJjW?=
 =?us-ascii?Q?GhswBU3gN01keB8cOPzo58KHzqFYz9bkKg0dnn5K3R8ay4BiURloBpjhNwJi?=
 =?us-ascii?Q?thbPKy13wIag4D5VIraEvbUV6PVexQ+i3/uHk//oEtYoxf+8xx4SIqhk6TR+?=
 =?us-ascii?Q?cX0gX6bolQ4L6JiW9w3JAQE2D0rW8oLE8VecjGdGGAKbAOVvXUURCnwmQK3k?=
 =?us-ascii?Q?8Nx3Sezlvl/skvcIX39vRsm+at3a9ukvHHJi6lKTXJ93MJ7OITmo8NG826M/?=
 =?us-ascii?Q?ULqKicrpDLy5Xnlp8DlpzOdJjlF9JJrTWniOSWK5qyplYBXBLKSWsIB3/lHY?=
 =?us-ascii?Q?JWuVjhfVjpE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22xYH4gc7w7i8PSpY5yIXZKKRE4LqeeZp2rxxVpIzxGMOVYabBSq9o+Aj6HF?=
 =?us-ascii?Q?HBokb7X+xyQgKhQ/Q3OekSOojbi/W4yAVAgc7TbebvJ4Y2a13LewU9q2SQ6+?=
 =?us-ascii?Q?6MZtuh8dcWfBCiRh1RaL0M4k2LCNw6ivaFtzafxrfi7ZvKqgZfeZA1sJDXJW?=
 =?us-ascii?Q?76OE5my046JeQgCA21Fv7vKz/SF22gK+FGkqOcrYKs9lPR/vn+KIsGVRsnyP?=
 =?us-ascii?Q?YHupwnX+VON7mNC1k22QxpL0BvmHSyzP6JCPn3l6tsjL2zB7ngIaMr3QlODW?=
 =?us-ascii?Q?Q2FApUn4oH87IdZsKkO4gzyJvXugD9aqkQKOwryszNLfpVxyPI25HUEJvx3g?=
 =?us-ascii?Q?A9UU7qe3w7j7sN8YBdHlEs3O5O4um1CdPg7sNjWxEflwKFd8dt9rdjzLI4eU?=
 =?us-ascii?Q?QSdkaAIuhfvTkTkz7qmSRO+Cdm9E8+Sc0b+xq4yrStYpgK9HNuPIdZQesyGA?=
 =?us-ascii?Q?W9uJgxuT7X3LeKUqYE7RZKBvetwTKXKPPio5eJHtn5H5xawPTaymyJ4dIAAr?=
 =?us-ascii?Q?wWVQxGDkVqkNWsDDRU0FUWpthtH7/PtlqEAcNb7sQ6zAcACN5BehxmJzqpHw?=
 =?us-ascii?Q?aYbuRRVUMSt7zGjpRjot7qigzMjmhGzVp0LJdcGtYLB+VrE+whbStsXCmMUL?=
 =?us-ascii?Q?PnBI36b47jGdFnQ+tiaCh/SzBOYfam9r/fZMtcDyqmcZP23LCKztEvoK02Eb?=
 =?us-ascii?Q?X0a+IcLaI5BCCKlty3VEZ2Bsgove48JflXFnLMD5J3T7uIOteNOQq8jFfSd9?=
 =?us-ascii?Q?YpA7LpBUSwX9KHn2DLdjxjbDl9r6Fid8RzYqg4RbseASfks+kyWIJI7558d8?=
 =?us-ascii?Q?9+7TcNm7kNNVSxmpuPma37zA/lovHOYu6Yh/2i3EPuitPPm4++NeoPNK+s7L?=
 =?us-ascii?Q?leH0EQMysykRUG5BCeSA8vFYFcEcI7oI7dAz9HNaZGcTU4lOWsixRYpD6PG8?=
 =?us-ascii?Q?xXvHJPa0OEeZxjBZlx8teH5bxZOn9vBUbw/oxac7gyZRSu4v65s6zvmySuFi?=
 =?us-ascii?Q?r4/uaZ2pkBGgIYDu30XirhkLd4Kc21pV638AFJk02fEfgjjvsadTJh7BCa+C?=
 =?us-ascii?Q?sb0k8r3XZaxeqgyBItUYFC4VB/lZdZsUcu3afEeEYpb4V/TPtTrADgR1ceaG?=
 =?us-ascii?Q?4qem/8yKfWM9iKvBd+IZGEetxYcCqB/EV0GSjETTHUqvywOgG9SbK+z2Rm4l?=
 =?us-ascii?Q?WYLC4Nu5v2kHMlt/AX8DKuwd2uhut9wuNmv+mHUTFDJKCasJi7P903Gu9D90?=
 =?us-ascii?Q?tYrei8SbXcgqvddaplbRBGp95fmDvUppHECLstsKWSUzE69cBGcwC0v2aKMG?=
 =?us-ascii?Q?J1GIhq7lWbKu0LFWmttesXAf3yPJ5122MKzOw6DQbZXiMbcVXQC3aAZ2Zgpw?=
 =?us-ascii?Q?nJw3FMJQ0hhwbPqAORXsRuRr1ETzEILOcQG540PB84FzheyC/MLdnFrFftrV?=
 =?us-ascii?Q?9IKd46kRPXD+4p6ZfCYuvnA9LaPFdfzU7RsnROl38mQs3cdmXq3L5to5Yjkr?=
 =?us-ascii?Q?iEKn1dkwl3EaebNCl5mt5Z7TVki/Y1duliY5xWQBmgb7pbWMvfwMVdWa54mg?=
 =?us-ascii?Q?mlpADX6CLo9CEUBYigUXcH94dkEKbi0+s1POo1KY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a2Bh4W6U5QxuTBHDUjN04mRVW+knFj3UmCivB6iKm+4sIYdEeoKCqM4YGRFlVHznwsFzic+hIFu2L4g/uOoDYDNU6WhaTyzN5LNuw68Wab7USXp01YfqC8RPYomNoQRw6vav8gxm/Aq7InlGB0/301VvsD4s07/9cYTIt34XUichv42JNXMJAluf9e4Fe9481Q1Wvzc0JJ3Yx3GK6wJIGIhAZmomOgyMySYfxAKl4jRX50k9AaUGbsUqGqfx+0nrblizTDZM1+caSH0p21aAoZIgJF05ah43wQ+Ge15kvEpKa4/+/xJTEoZTFw6rLux/KjYorUHMtdUQY2VMbhfDEolvlP/UHeB+P3K+KZhlpU42/RBnY0tZYZnmu7CR9y7ICzZhiFNWdpMuHpjh0Pv83DtzAaM6DpISgM2L19ZV4FatfbUqTsHtj/OpiaJ3LNsDOkSPqrydFW2mZLjf173DhqUjz9hth4PQucRl9iGSyXcZvryEpbynW9MgHsB5jPtaxki22CDtxgBDHQsjSQD2KQxVQW+2a8mwcuzymBcUqp2uCrpvq1jFkyP7jAjqz1u9AfgA+HkCeS/oEiaAk5jn0rmgJFkb2UmglRuKsi2fG5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c294d2b5-5ebe-4749-50a1-08ddd9c56832
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:26:43.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezJqd/f0WLwCv+yFb4pcbz5S+Qf5RRzlXERAiDAKt9ZwdG2cGSuPnFIITHMd7eWLsnxozqnT2SPiSHoVu3+xuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120167
X-Proofpoint-ORIG-GUID: bp_CJlTaYtY9X6GTcsD6dm4teaIeh77F
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689b7958 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lSnMXvXUbzvyXhDl-4AA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: bp_CJlTaYtY9X6GTcsD6dm4teaIeh77F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NyBTYWx0ZWRfX7bU/gAes5BBL
 zRaaGKfNZP0ueeJGeMz6Y2lLrEn3XunCexws03BNaf9uD6xdZybKR9esrzYH+M7G4nwRK1Qk82j
 N1bk4FD1IAOC7Zd2cYvrOsTtDSdre0MbwinGf5WmBJWqNX+LFCtrkpFfRwwOFfQCb3GevUPKWjD
 xUbUMpyBd89SRB18536C0KD/NAHuPqG7dxAIvObc3QsyntLRILMpcJQQIqPrELVVQL1b6GoKz4L
 HsM2x4XfHPSCSVzhVJVJf0eywvnGVSrw+e6ACYRjyIru2t55d22acWnAN6wa4riBINkaSBrhtjZ
 wcaE8hf2SSM3q2cy5vT7Pm2AzwI29YqQv5RSYIKjVF9XTAX768eVXPZw9Z/095W2edjtlSxWPtS
 7vhSClcZ7X+DR+3oN81p+ZK8343U4oEDTUdG2/JVSf80zYMub0PN/b3BSAbn6VCHLaASBcvA

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:47]:
> The coredump logic is slightly different from other users in that it both
> stores mm flags and additionally sets and gets using masks.
> 
> Since the MMF_DUMPABLE_* flags must remain as they are for uABI reasons,
> and of course these are within the first 32-bits of the flags, it is
> reasonable to provide access to these in the same fashion so this logic can
> all still keep working as it has been.
> 
> Therefore, introduce coredump-specific helpers __mm_flags_get_dumpable()
> and __mm_flags_set_mask_dumpable() for this purpose, and update all core
> dump users of mm flags to use these.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  fs/coredump.c                  |  4 +++-
>  fs/exec.c                      |  2 +-
>  fs/pidfs.c                     |  7 +++++--
>  fs/proc/base.c                 |  8 +++++---
>  include/linux/sched/coredump.h | 21 ++++++++++++++++++++-
>  5 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index fedbead956ed..e5d9d6276990 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1103,8 +1103,10 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
>  		 * We must use the same mm->flags while dumping core to avoid
>  		 * inconsistency of bit flags, since this flag is not protected
>  		 * by any locks.
> +		 *
> +		 * Note that we only care about MMF_DUMP* flags.
>  		 */
> -		.mm_flags = mm->flags,
> +		.mm_flags = __mm_flags_get_dumpable(mm),
>  		.vma_meta = NULL,
>  		.cpu = raw_smp_processor_id(),
>  	};
> diff --git a/fs/exec.c b/fs/exec.c
> index 2a1e5e4042a1..dbac0e84cc3e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1999,7 +1999,7 @@ void set_dumpable(struct mm_struct *mm, int value)
>  	if (WARN_ON((unsigned)value > SUID_DUMP_ROOT))
>  		return;
>  
> -	set_mask_bits(&mm->flags, MMF_DUMPABLE_MASK, value);
> +	__mm_flags_set_mask_dumpable(mm, value);
>  }
>  
>  SYSCALL_DEFINE3(execve,
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index edc35522d75c..5148b7646b7f 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -357,8 +357,11 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  	if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
>  		task_lock(task);
> -		if (task->mm)
> -			kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
> +		if (task->mm) {
> +			unsigned long flags = __mm_flags_get_dumpable(task->mm);
> +
> +			kinfo.coredump_mask = pidfs_coredump_mask(flags);
> +		}
>  		task_unlock(task);
>  	}
>  
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 62d35631ba8c..f0c093c58aaf 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2962,8 +2962,10 @@ static ssize_t proc_coredump_filter_read(struct file *file, char __user *buf,
>  	ret = 0;
>  	mm = get_task_mm(task);
>  	if (mm) {
> +		unsigned long flags = __mm_flags_get_dumpable(mm);
> +
>  		len = snprintf(buffer, sizeof(buffer), "%08lx\n",
> -			       ((mm->flags & MMF_DUMP_FILTER_MASK) >>
> +			       ((flags & MMF_DUMP_FILTER_MASK) >>
>  				MMF_DUMP_FILTER_SHIFT));
>  		mmput(mm);
>  		ret = simple_read_from_buffer(buf, count, ppos, buffer, len);
> @@ -3002,9 +3004,9 @@ static ssize_t proc_coredump_filter_write(struct file *file,
>  
>  	for (i = 0, mask = 1; i < MMF_DUMP_FILTER_BITS; i++, mask <<= 1) {
>  		if (val & mask)
> -			set_bit(i + MMF_DUMP_FILTER_SHIFT, &mm->flags);
> +			mm_flags_set(i + MMF_DUMP_FILTER_SHIFT, mm);
>  		else
> -			clear_bit(i + MMF_DUMP_FILTER_SHIFT, &mm->flags);
> +			mm_flags_clear(i + MMF_DUMP_FILTER_SHIFT, mm);
>  	}
>  
>  	mmput(mm);
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 6eb65ceed213..19ecfcceb27a 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -2,12 +2,29 @@
>  #ifndef _LINUX_SCHED_COREDUMP_H
>  #define _LINUX_SCHED_COREDUMP_H
>  
> +#include <linux/compiler_types.h>
>  #include <linux/mm_types.h>
>  
>  #define SUID_DUMP_DISABLE	0	/* No setuid dumping */
>  #define SUID_DUMP_USER		1	/* Dump as user of process */
>  #define SUID_DUMP_ROOT		2	/* Dump as root */
>  
> +static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)
> +{
> +	/*
> +	 * By convention, dumpable bits are contained in first 32 bits of the
> +	 * bitmap, so we can simply access this first unsigned long directly.
> +	 */
> +	return __mm_flags_get_word(mm);
> +}
> +
> +static inline void __mm_flags_set_mask_dumpable(struct mm_struct *mm, int value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +
> +	set_mask_bits(bitmap, MMF_DUMPABLE_MASK, value);
> +}
> +
>  extern void set_dumpable(struct mm_struct *mm, int value);
>  /*
>   * This returns the actual value of the suid_dumpable flag. For things
> @@ -22,7 +39,9 @@ static inline int __get_dumpable(unsigned long mm_flags)
>  
>  static inline int get_dumpable(struct mm_struct *mm)
>  {
> -	return __get_dumpable(mm->flags);
> +	unsigned long flags = __mm_flags_get_dumpable(mm);
> +
> +	return __get_dumpable(flags);
>  }
>  
>  #endif /* _LINUX_SCHED_COREDUMP_H */
> -- 
> 2.50.1
> 

