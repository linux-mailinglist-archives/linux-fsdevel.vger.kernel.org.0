Return-Path: <linux-fsdevel+bounces-57518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D8B22C05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1447F503FAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5F30E83A;
	Tue, 12 Aug 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cAZGbHLq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WjL/KqSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DA30AAC0;
	Tue, 12 Aug 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013702; cv=fail; b=GWgPzWFFcVvWjoaw0p50p1Qp93IcOTUkoYZwG9ks2rxuZaICDTmUi24/SiELMfyppAv/MOBBEl9CBSFpb1w475Oury28e5Vbidc1Z0vutgVFs+I7sC/3NbMw/d68BxTqxaAaXWRSsFoXihecKtS6J7+UyrFYvEPX6jYGx9FNbSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013702; c=relaxed/simple;
	bh=NEoIhXNxv6GAtIjIEIunznxdbs5Zidu+m8WxkAl4U7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8p+7aGsgZPhZ/XXMs0kbASTrK0UM0jCCYHpj2qiySSJ8NZPvMheenkLluFHXPMxAZFh5e846FEU88f96xlyHir2UByggzAkB/p9l5LggkW1UhBv57ZxoO9SNpXlaQ8WS6B+zZ6YabRRy+wR6jlhkUhpKi5uEj0L8MukhB2ORjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cAZGbHLq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WjL/KqSh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC76X006416;
	Tue, 12 Aug 2025 15:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=axqt4Jigtq9HdNTBq545zwaHLTgEbnTXiODYZ7GDfg8=; b=
	cAZGbHLqnQZYSSGf5i5gy2Zz96LnMoPkpvX0O6VJUa+wYsXf2gGmzaaCLbTUf23U
	7eGkOsyoNA8x79z7sLGKMRvnqomYtn0yoO0B7PcLU0v2/d9DxWU3PygKaB/AaE1G
	bWCccxjtQH/ze5LQliBsUOLbCrYLzVhbbf7WzuvRm9jxer6gLlKFGUkmMQXMFgM9
	VK43fDu7giEDILze75TTJKGOrrlHo/44yTykrD7BZZkq3b0RG+Afm7JRf2IiOWJl
	+HFqtz1HuU45ZJ+KopV/FOPF4Homt079/xsqrijxZok2UpEla2XXCdTrJUCTzkR3
	T4K0zQPZXMF/IYn560lJZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dmx4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CEYARh030376;
	Tue, 12 Aug 2025 15:47:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa50f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czzlRTcnJhETPdXsZFClSRTUSnawW/KesEc50X90JCKT2LMh8aiFUpPfaEcNhEzVp/Pl4rC54n+JHOsHnHmDv4lQ1cT6GmuTCRCb6ozZw6w4N3VNcqW5dkzbhXQLzQudMI3zQSTEPjxM0lok15sCjNGbcY9fUOruXGg2yuMWk5mQTIz5WTJQdnVArB4O4oamP8UM5CtILCzXsDL81VHKSCPDZgnS0mz90VJ3ItqBeE9F72Bq6/ktrEjo0x0FYu/l2zZV4hsbW3mJ5b3mUaix1z2sk0iKAQBCO4usgNpDR9IW29Ml84Hb+VyHb07CtC5EhXn5FNoqkFw/mFPwdyIw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axqt4Jigtq9HdNTBq545zwaHLTgEbnTXiODYZ7GDfg8=;
 b=KMguumGS0A+5okHj/qJQjKzEqtKNR6hfvEpp9Hq1VWxuaLy8qZHeAZSUUPHdk22fVnKrTJOpPtwrwzqT01Eb68wLpu3KtaxJuhPP41w9d37k3HHt7qxr95wXxvyUR4I/yATmdDE6OBASd9pjDmslQ8A6MmGBfNFcMKmP6Fb3rkv3woEbMgZiWLOqWbYL7cO7+NxBSwQP1w31+9aeV9JY0eArsykSGZt+yuydzjWAcnzxNh5I0dnl0Le7K1vCiXrfmqgEaHe/z3a56ClpmdMsd3SzEno95HeM6wcz4q9dSv7D5N7LtjsNBp6pnGhgf7RnnlJ/PBAuoV4spQu1tkgNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axqt4Jigtq9HdNTBq545zwaHLTgEbnTXiODYZ7GDfg8=;
 b=WjL/KqShuMpkDE7SX0brY7xMzyvstAUW/OOGLd8wlyEQ+yXEnTGLCapRXKJNBI2m1pkY33Dj7OFsTNWgeHDgKSwmo64rRS/zrwCk8N6vIWOUBrlg8AOJnWPNzEjBUw1LpPqPoXUQsec34CCRm7QD8Kt3YFfs/3gilpuRoQ4h1xQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6329.namprd10.prod.outlook.com (2603:10b6:806:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 15:47:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:47:32 +0000
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
Subject: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Date: Tue, 12 Aug 2025 16:44:11 +0100
Message-ID: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 364e8605-3e85-4709-8349-08ddd9b78c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3tD0gmLpP+R5pej+SvibDlElOsSFnEUhXH3zAfWnHZZXzqog1e3ZhIzfcgf?=
 =?us-ascii?Q?66bzNSUD7+RcJA8rD4HLFTNgQEECwclDn0329Mme8NEwJ3XAPGN/HcVt2LWk?=
 =?us-ascii?Q?VJbOXc3qZ3VWNFO01ZG0nIRkHdsTaRqJ5FWGg1pWU/hL4yBt46RJcx8QwDbP?=
 =?us-ascii?Q?hD7aK8JeyYmakoPuQaGsJZoLHMnF9ZW2nLieVi7GUah3IHB47JxBudKRGZhw?=
 =?us-ascii?Q?FvHDMgkN1AcQUcGKpRWmvd7PNLCLhDUXaTo80PlKUPtQVyE2Tsm+/ZKwzrhw?=
 =?us-ascii?Q?T7ttw7xlJyExX7bW+VwDS6n7mzLAcE4tuHAJtTPnIJrcG5R3F7pLCTTJBSp6?=
 =?us-ascii?Q?VWwW/r10XY+33UVarDANshy1nZajDNG3g8gNlcYWKiHgOBXD4tWDuw2n4o5U?=
 =?us-ascii?Q?s+/amK0E4PM0O6Hx7HHwdckGv4doeE5HOwzM+Eofc259xvE3rZvHmUITHMmO?=
 =?us-ascii?Q?Y85V2mWCh3O7RoodQRLNXoBZU+Zk55m+JWfTTpb6yia19AHWT1Sua91O9SQW?=
 =?us-ascii?Q?5qM50uKsLxyFkyZP8OsdS3PyA5bZyF0JAGACCcFaLHGtmrnqg0Qd/NNemU/R?=
 =?us-ascii?Q?Ep/szXltKg9ppHTVmPcq1GGzO4ENrivUf/bHQVv99wiDiFdJPpHV3oNzaWCk?=
 =?us-ascii?Q?bpeM8iQNlXFw1EaGlG9qpsc7lgAjSPvXGoU6T7HFoZ3vpXfE5/3lvX9NceWo?=
 =?us-ascii?Q?0HbXXuqnYMlyKRcG2keI0yFcR55aKigKnhrS9p4WJch5u29nsf0+Zijii2rf?=
 =?us-ascii?Q?F0zk5MGr69chNi6g+YtGqAlG4bSxgjTZKq2tEblxFEr21f8mhNblequ4+LMT?=
 =?us-ascii?Q?ZsHDckeMNl0Mut0PdOpw9q8pYBsUfPAS456EIkNguY/Uk7blcmIWnpebdqAy?=
 =?us-ascii?Q?ErboP+Wm5ARO+nQh12Cdu4KXrF9BTI5rd4j49/cghNKHIz5gCbZWDidPDC0s?=
 =?us-ascii?Q?urQgz0VeexCJkxjwPOoGZvAk57TkbofS+cwSnOqB82qHbr4NNlVeKxDN6SOl?=
 =?us-ascii?Q?kCbphSwZDrA6jiat5ErtAm3/KlkVf8UD3RA6kHKz11JayAljTiFT3W8mW5VB?=
 =?us-ascii?Q?Lh8/uYE37ogrJcX0AAUqsXl8PWOW/RSfoKaLO647IvMgdPsW6968HBcEw1hb?=
 =?us-ascii?Q?p4tT7Prt+l4Hj9ykUhfJt3T//whVPLzKnuGvLGFHxBfPf5QU4ov7Ry5ceQhs?=
 =?us-ascii?Q?1qRmoGKJneB9roaO0L8HxM2lf2H2K4KbvlsmkNqgM901e/Z15w4MgO5ht+Ek?=
 =?us-ascii?Q?mHH9y3luqjbJLQ5e6s3P+5lhs7p+gYY9PaBVPdJnUaK/tKx3gUK//Ggstn3a?=
 =?us-ascii?Q?Y8BY2cUxGpkTkD5ak3bZQbFBQdeYjdYm1856btDSA+PH+MObww54OzxO775M?=
 =?us-ascii?Q?/Sz1Yek6T964rZq8y//OkSLDcuexD1Lr3qf1vutzzblbpVkIzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8loGPCBAALfU3aLIs4PqcuRS2HXC2AlcpSzeq6Fy1Zwx5rtmSwyeB01sxMg5?=
 =?us-ascii?Q?W3hIxJgMGtYp1GpPa9gy4iQrPIe6EJbgWCOd55REzSOrXB40Dm2turg8ofma?=
 =?us-ascii?Q?t6NtEtRNG8SecnddWkNnU6zpdIAjz0fbGMAT7NCjFNhuvgSe9rQrtBf6X846?=
 =?us-ascii?Q?7W7Qa8zROihvXn3TUwIl4U1xkvF3p86rx/NNounjTW2MgMt0l/DMp7Bp5k6M?=
 =?us-ascii?Q?BkGFTSg3fGDtuMMSnnvTvkvObEyA5VwXXsijoKrnHeTuGovCPPT43FrUW9Zr?=
 =?us-ascii?Q?n+HeCG4FcUuNKm5tvUsEhln0MzdrboGCEgJ2EGeHNlISaL3sjfqY53Fd+tPD?=
 =?us-ascii?Q?3KhCuTWmro5Y1K2x6g6+Nm+VdykN55htFvJQjR5MMJxT7beWlyE2J2ULBGuj?=
 =?us-ascii?Q?Ma0PestllIECOMKDbHFY6pqc/958gjuWCDWmtwNmm+vJXsUjwfWKF6lP6lgW?=
 =?us-ascii?Q?tvH+CgrJlnWjzZKA78lvb/6Vj2dlKAf98JbseIJ0BLair0tLlqjIvy8OCdD2?=
 =?us-ascii?Q?VjcxdDv8Fj1XNnTJTakVmV/yoxpXu5MFj1pnzPS+Xd37M1dfdChNUk2TwtIn?=
 =?us-ascii?Q?5IjnSEq92ZYmt4DfuQU25PKX/B5xMuTqoMeddW41AQ6UnKZVRSQ5Vuck/1gW?=
 =?us-ascii?Q?dXS6cOYUf29K7PMMBc1gJ7UIjV+CheaJ3K6k8TNz8I7PoDeaijrVS8zTxDfH?=
 =?us-ascii?Q?S/JlrOTbeo0wOZX59v7Y4X5maL8m39N6lqCsjf35GeZfihbtGr8T8sJ6rNya?=
 =?us-ascii?Q?RihA8AyLWVoTbYDV1bUo3kOe9k9WgJXwJUhsTjIGnrFG4LWxmIWRIe1OUXHg?=
 =?us-ascii?Q?1o4vX+E6nQlV/ub2XuXBCC4+n/gNcbqfsiVy0Z5D8HHhktGuQMumHfwPHlsr?=
 =?us-ascii?Q?x9FM9RnUJxrgcHnugYsBMN8IFXEmFU35eGjZjLnLEp11dfWwYPLJnmSXOCfP?=
 =?us-ascii?Q?lJFZ0CdHbKETMCZMzLnwkQHF0W706fjTtwjqyHhYZAL3m9qI0N2gGfopZTlu?=
 =?us-ascii?Q?b8WmEc8KHmg5vrpKm/w/edvPyOinHfq4lZ5gRdGZLYE4aQW6+YoDENkVTJQE?=
 =?us-ascii?Q?G29XZRQ1JzXpnXynD1YDyf3PGD2Zvc8yBJhLlzuGmsCMAmEnsWmkRgOb3mm/?=
 =?us-ascii?Q?mKuwvYYDfW6RhiDZzeef/BqO9G1qL00+Rhs4QfI1OsqCNTAPLtyv3e3+dL3e?=
 =?us-ascii?Q?mDdzIVnjN/PDHaeNBXyv8gSGO3pygYi9wYRVbTVeKDn+OpLt/vNsiBO4EJK2?=
 =?us-ascii?Q?FGun5jy463gGjfQFotLeEIgbdLlFzSpP9NaBT0DhdfKfBxX8p/iqv4OuoCZL?=
 =?us-ascii?Q?PNR6TSzl1Ai+plrI3HA04l+3/QyI92oPQyVj2kVvfa0JfbVNIVHAejBMgBcf?=
 =?us-ascii?Q?sygDicdKMtbqbKSIAj6M3N0uvUwpE7tOTeKK9/MqUjZ4dgjCkX+DJt17oTD9?=
 =?us-ascii?Q?tdzfS+wmuXEYHxl5XDExHlU1SBRsq8LMBVPrcGIrToWLCWBZo4xmxgUYSe4B?=
 =?us-ascii?Q?7SO7ux96VCFUFy0ETE8SnHlP790M9DM9PLqXJFWnjRqm6sg6aQG3QFlR/OKh?=
 =?us-ascii?Q?nUG9Eg8ty0wnMufIqawwwzyFo//6pBjq3/NAbEdXnQvR7mo7c6I1N3gJ71OA?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7zjoW0XWxjo00C2KU43TmQ6sN08IC69c4w2aRLdsYY4WHZo2hsrNHSdhCf1VOdPoA9pWVvztR507a3pvntujLJ4V3t6YTScmUPSjRxQy3GAECYgFHGVyc3ikIQdlGnP9WJY6eXIafM9zz6Yx7I0/oksrs04xZ104x7H0ra5a2Q0FLpJMmRI7JhibBUCbpLomIpXEnlF59VZBLlDSoT2yLwZNhnsqNi+qFIOTJUbjc/VGOesZaWc1z0QyWAAmq1ZIHfm7+KhoMPoks6ggswoTPmFMa6qaoaN87hA2vvqxWrdK5A6/JcI0N9K7T8L2rcHkXrzQfgZr05pj48Z5K1gIXyalq6B57+RSiDMbgYDYhPp06SLO1fLmtDCxcSFCxy6W1w1FOGDqpHZ+u4kNx7PxoWIZ8QqZZJoyzxRG5qxmVsKXwSzfuJ6ZYHEtOwdT1RaD/pKbtddiZs8mWf97Wxp2LTNfloSjdL1+HhhjCxIT9jjLLBVl0+d8QhhDYJH+doA4c/KIpGMu7BWomk96oyvfS1nVmdcaqJ6dplFat97OzBehFInTaXJQl22nAStOMWFmO58wf3Od1iYnfqKCEhBquL6Pqkh2vdMwnRDzJq5zgzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364e8605-3e85-4709-8349-08ddd9b78c9c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:47:31.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEvMcqdhy+EqXpt9LhrXfYXC2KZrdm8uwidzryRL//6I3HzQfSL4DJ1vP2YlWyccdo63s6a+wdYJ6+wTsPn5bCSOka4oXYtRLmrRG1peSPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120152
X-Proofpoint-ORIG-GUID: 12H9nH2U_juaHB_6SoGLpUiKX2aYr6TM
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689b6218 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=FullupDOrDUTRcva600A:9
X-Proofpoint-GUID: 12H9nH2U_juaHB_6SoGLpUiKX2aYr6TM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfXxzDTgGibox1k
 sTWLU8PXwUmJYm9LsnV14pI+9wEArEWwWp14IwCKcUAZwgC3N6vslCoruu8KmHWm8WGypE0eo2t
 sjmrrf0EBbvXXom+nZIySZbiH00vOLTw5eS/MgO97NLND39MvoUYcg0/K8nlSQQSPPzI7kXwxQh
 YM+LPiGj9TN53ekcYY/0NGyPkfSGYBulpq9+xqqAh0OZMABQTG+ndsfb9MgOkTYn4rpJXToQ3mi
 qC1WG5gu77HDPzNzJuco2nKmTRSx6K5DW3iY6zboMqhPfAp80I9AcwwnFaMU2YyqlsymQTL73iw
 /PCIS8/hM0xJKb42BAPfaRln3iVnaAjfkwC9qJGZIelm3oQvpFjowc6FUD3gU/S5m7m9mAowHKV
 xoYpKTdIIPml6Ae0CNobNdyfjcVToCwnorhyt9NQ+5fM17y0ZpDuQQP6nqfUa0G1Bblvjz6C

As part of the effort to move to mm->flags becoming a bitmap field, convert
existing users to making use of the mm_flags_*() accessors which will, when
the conversion is complete, be the only means of accessing mm_struct flags.

This will result in the debug output being that of a bitmap output, which
will result in a minor change here, but since this is for debug only, this
should have no bearing.

Otherwise, no functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h    |  2 +-
 include/linux/khugepaged.h |  6 ++++--
 include/linux/ksm.h        |  6 +++---
 include/linux/mm.h         |  2 +-
 include/linux/mman.h       |  2 +-
 include/linux/oom.h        |  2 +-
 mm/debug.c                 |  4 ++--
 mm/gup.c                   | 10 +++++-----
 mm/huge_memory.c           |  8 ++++----
 mm/khugepaged.c            | 10 +++++-----
 mm/ksm.c                   | 32 ++++++++++++++++----------------
 mm/mmap.c                  |  8 ++++----
 mm/oom_kill.c              | 26 +++++++++++++-------------
 mm/util.c                  |  6 +++---
 14 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 14d424830fa8..84b7eebe0d68 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -327,7 +327,7 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
 	 * example, s390 kvm.
 	 */
 	return (vm_flags & VM_NOHUGEPAGE) ||
-	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
+	       mm_flags_test(MMF_DISABLE_THP, vma->vm_mm);
 }
 
 static inline bool thp_disabled_by_hw(void)
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index ff6120463745..eb1946a70cff 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_KHUGEPAGED_H
 #define _LINUX_KHUGEPAGED_H
 
+#include <linux/mm.h>
+
 extern unsigned int khugepaged_max_ptes_none __read_mostly;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern struct attribute_group khugepaged_attr_group;
@@ -20,13 +22,13 @@ extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
+	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
 		__khugepaged_enter(mm);
 }
 
 static inline void khugepaged_exit(struct mm_struct *mm)
 {
-	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
+	if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
 		__khugepaged_exit(mm);
 }
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index c17b955e7b0b..22e67ca7cba3 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -56,13 +56,13 @@ static inline long mm_ksm_zero_pages(struct mm_struct *mm)
 static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	/* Adding mm to ksm is best effort on fork. */
-	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
+	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
 		__ksm_enter(mm);
 }
 
 static inline int ksm_execve(struct mm_struct *mm)
 {
-	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
 		return __ksm_enter(mm);
 
 	return 0;
@@ -70,7 +70,7 @@ static inline int ksm_execve(struct mm_struct *mm)
 
 static inline void ksm_exit(struct mm_struct *mm)
 {
-	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
+	if (mm_flags_test(MMF_VM_MERGEABLE, mm))
 		__ksm_exit(mm);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4ed4a0b9dad6..34311ebe62cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1949,7 +1949,7 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
 {
 	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
 
-	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
+	if (!mm_flags_test(MMF_HAS_PINNED, vma->vm_mm))
 		return false;
 
 	return folio_maybe_dma_pinned(folio);
diff --git a/include/linux/mman.h b/include/linux/mman.h
index de9e8e6229a4..0ba8a7e8b90a 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -201,7 +201,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
 static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
 	/* If MDWE is disabled, we have nothing to deny. */
-	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
+	if (!mm_flags_test(MMF_HAS_MDWE, current->mm))
 		return false;
 
 	/* If the new VMA is not executable, we have nothing to deny. */
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 1e0fc6931ce9..7b02bc1d0a7e 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -91,7 +91,7 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
  */
 static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 {
-	if (unlikely(test_bit(MMF_UNSTABLE, &mm->flags)))
+	if (unlikely(mm_flags_test(MMF_UNSTABLE, mm)))
 		return VM_FAULT_SIGBUS;
 	return 0;
 }
diff --git a/mm/debug.c b/mm/debug.c
index b4388f4dcd4d..64ddb0c4b4be 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -182,7 +182,7 @@ void dump_mm(const struct mm_struct *mm)
 		"start_code %lx end_code %lx start_data %lx end_data %lx\n"
 		"start_brk %lx brk %lx start_stack %lx\n"
 		"arg_start %lx arg_end %lx env_start %lx env_end %lx\n"
-		"binfmt %px flags %lx\n"
+		"binfmt %px flags %*pb\n"
 #ifdef CONFIG_AIO
 		"ioctx_table %px\n"
 #endif
@@ -211,7 +211,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->start_code, mm->end_code, mm->start_data, mm->end_data,
 		mm->start_brk, mm->brk, mm->start_stack,
 		mm->arg_start, mm->arg_end, mm->env_start, mm->env_end,
-		mm->binfmt, mm->flags,
+		mm->binfmt, NUM_MM_FLAG_BITS, __mm_flags_get_bitmap(mm),
 #ifdef CONFIG_AIO
 		mm->ioctx_table,
 #endif
diff --git a/mm/gup.c b/mm/gup.c
index adffe663594d..331d22bf7b2d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -475,10 +475,10 @@ EXPORT_SYMBOL_GPL(unpin_folios);
  * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
  * cache bouncing on large SMP machines for concurrent pinned gups.
  */
-static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
+static inline void mm_set_has_pinned_flag(struct mm_struct *mm)
 {
-	if (!test_bit(MMF_HAS_PINNED, mm_flags))
-		set_bit(MMF_HAS_PINNED, mm_flags);
+	if (!mm_flags_test(MMF_HAS_PINNED, mm))
+		mm_flags_set(MMF_HAS_PINNED, mm);
 }
 
 #ifdef CONFIG_MMU
@@ -1693,7 +1693,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		mmap_assert_locked(mm);
 
 	if (flags & FOLL_PIN)
-		mm_set_has_pinned_flag(&mm->flags);
+		mm_set_has_pinned_flag(mm);
 
 	/*
 	 * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
@@ -3210,7 +3210,7 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
-		mm_set_has_pinned_flag(&current->mm->flags);
+		mm_set_has_pinned_flag(current->mm);
 
 	if (!(gup_flags & FOLL_FAST_ONLY))
 		might_lock_read(&current->mm->mmap_lock);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b8bb078a1a34..a2f476e7419a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -251,13 +251,13 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
 	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
 		return huge_zero_folio;
 
-	if (test_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
+	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
 		return READ_ONCE(huge_zero_folio);
 
 	if (!get_huge_zero_folio())
 		return NULL;
 
-	if (test_and_set_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
+	if (mm_flags_test_and_set(MMF_HUGE_ZERO_FOLIO, mm))
 		put_huge_zero_folio();
 
 	return READ_ONCE(huge_zero_folio);
@@ -268,7 +268,7 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
 	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
 		return;
 
-	if (test_bit(MMF_HUGE_ZERO_FOLIO, &mm->flags))
+	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
 		put_huge_zero_folio();
 }
 
@@ -1145,7 +1145,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 
 	off_sub = (off - ret) & (size - 1);
 
-	if (test_bit(MMF_TOPDOWN, &current->mm->flags) && !off_sub)
+	if (mm_flags_test(MMF_TOPDOWN, current->mm) && !off_sub)
 		return ret + size;
 
 	ret += off_sub;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b40bdfd224c..6470e7e26c8d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -410,7 +410,7 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
 static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 {
 	return hpage_collapse_test_exit(mm) ||
-	       test_bit(MMF_DISABLE_THP, &mm->flags);
+		mm_flags_test(MMF_DISABLE_THP, mm);
 }
 
 static bool hugepage_pmd_enabled(void)
@@ -445,7 +445,7 @@ void __khugepaged_enter(struct mm_struct *mm)
 
 	/* __khugepaged_exit() must not run from under us */
 	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
-	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
+	if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
 		return;
 
 	mm_slot = mm_slot_alloc(mm_slot_cache);
@@ -472,7 +472,7 @@ void __khugepaged_enter(struct mm_struct *mm)
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
-	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
+	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
 	    hugepage_pmd_enabled()) {
 		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
 					    PMD_ORDER))
@@ -497,7 +497,7 @@ void __khugepaged_exit(struct mm_struct *mm)
 	spin_unlock(&khugepaged_mm_lock);
 
 	if (free) {
-		clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
+		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
 		mm_slot_free(mm_slot_cache, mm_slot);
 		mmdrop(mm);
 	} else if (mm_slot) {
@@ -1459,7 +1459,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 		/*
 		 * Not strictly needed because the mm exited already.
 		 *
-		 * clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
+		 * mm_clear(mm, MMF_VM_HUGEPAGE);
 		 */
 
 		/* khugepaged_mm_lock actually not necessary for the below */
diff --git a/mm/ksm.c b/mm/ksm.c
index 160787bb121c..2ef29802a49b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1217,8 +1217,8 @@ static int unmerge_and_remove_all_rmap_items(void)
 			spin_unlock(&ksm_mmlist_lock);
 
 			mm_slot_free(mm_slot_cache, mm_slot);
-			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
-			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
+			mm_flags_clear(MMF_VM_MERGEABLE, mm);
+			mm_flags_clear(MMF_VM_MERGE_ANY, mm);
 			mmdrop(mm);
 		} else
 			spin_unlock(&ksm_mmlist_lock);
@@ -2620,8 +2620,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		spin_unlock(&ksm_mmlist_lock);
 
 		mm_slot_free(mm_slot_cache, mm_slot);
-		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
-		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
+		mm_flags_clear(MMF_VM_MERGEABLE, mm);
+		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
@@ -2742,7 +2742,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
 			 vm_flags_t vm_flags)
 {
-	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
+	if (mm_flags_test(MMF_VM_MERGE_ANY, mm) &&
 	    __ksm_should_add_vma(file, vm_flags))
 		vm_flags |= VM_MERGEABLE;
 
@@ -2784,16 +2784,16 @@ int ksm_enable_merge_any(struct mm_struct *mm)
 {
 	int err;
 
-	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
 		return 0;
 
-	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
+	if (!mm_flags_test(MMF_VM_MERGEABLE, mm)) {
 		err = __ksm_enter(mm);
 		if (err)
 			return err;
 	}
 
-	set_bit(MMF_VM_MERGE_ANY, &mm->flags);
+	mm_flags_set(MMF_VM_MERGE_ANY, mm);
 	ksm_add_vmas(mm);
 
 	return 0;
@@ -2815,7 +2815,7 @@ int ksm_disable_merge_any(struct mm_struct *mm)
 {
 	int err;
 
-	if (!test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+	if (!mm_flags_test(MMF_VM_MERGE_ANY, mm))
 		return 0;
 
 	err = ksm_del_vmas(mm);
@@ -2824,7 +2824,7 @@ int ksm_disable_merge_any(struct mm_struct *mm)
 		return err;
 	}
 
-	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
+	mm_flags_clear(MMF_VM_MERGE_ANY, mm);
 	return 0;
 }
 
@@ -2832,9 +2832,9 @@ int ksm_disable(struct mm_struct *mm)
 {
 	mmap_assert_write_locked(mm);
 
-	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
+	if (!mm_flags_test(MMF_VM_MERGEABLE, mm))
 		return 0;
-	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+	if (mm_flags_test(MMF_VM_MERGE_ANY, mm))
 		return ksm_disable_merge_any(mm);
 	return ksm_del_vmas(mm);
 }
@@ -2852,7 +2852,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		if (!vma_ksm_compatible(vma))
 			return 0;
 
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
+		if (!mm_flags_test(MMF_VM_MERGEABLE, mm)) {
 			err = __ksm_enter(mm);
 			if (err)
 				return err;
@@ -2912,7 +2912,7 @@ int __ksm_enter(struct mm_struct *mm)
 		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
 	spin_unlock(&ksm_mmlist_lock);
 
-	set_bit(MMF_VM_MERGEABLE, &mm->flags);
+	mm_flags_set(MMF_VM_MERGEABLE, mm);
 	mmgrab(mm);
 
 	if (needs_wakeup)
@@ -2954,8 +2954,8 @@ void __ksm_exit(struct mm_struct *mm)
 
 	if (easy_to_free) {
 		mm_slot_free(mm_slot_cache, mm_slot);
-		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
-		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
+		mm_flags_clear(MMF_VM_MERGEABLE, mm);
 		mmdrop(mm);
 	} else if (mm_slot) {
 		mmap_write_lock(mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 7306253cc3b5..7a057e0e8da9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -802,7 +802,7 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *fi
 					   unsigned long pgoff, unsigned long flags,
 					   vm_flags_t vm_flags)
 {
-	if (test_bit(MMF_TOPDOWN, &mm->flags))
+	if (mm_flags_test(MMF_TOPDOWN, mm))
 		return arch_get_unmapped_area_topdown(filp, addr, len, pgoff,
 						      flags, vm_flags);
 	return arch_get_unmapped_area(filp, addr, len, pgoff, flags, vm_flags);
@@ -1284,7 +1284,7 @@ void exit_mmap(struct mm_struct *mm)
 	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
 	 * because the memory has been already freed.
 	 */
-	set_bit(MMF_OOM_SKIP, &mm->flags);
+	mm_flags_set(MMF_OOM_SKIP, mm);
 	mmap_write_lock(mm);
 	mt_clear_in_rcu(&mm->mm_mt);
 	vma_iter_set(&vmi, vma->vm_end);
@@ -1859,14 +1859,14 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
 			mas_store(&vmi.mas, XA_ZERO_ENTRY);
 			/* Avoid OOM iterating a broken tree */
-			set_bit(MMF_OOM_SKIP, &mm->flags);
+			mm_flags_set(MMF_OOM_SKIP, mm);
 		}
 		/*
 		 * The mm_struct is going to exit, but the locks will be dropped
 		 * first.  Set the mm_struct as unstable is advisable as it is
 		 * not fully initialised.
 		 */
-		set_bit(MMF_UNSTABLE, &mm->flags);
+		mm_flags_set(MMF_UNSTABLE, mm);
 	}
 out:
 	mmap_write_unlock(mm);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..17650f0b516e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  *  linux/mm/oom_kill.c
- * 
+ *
  *  Copyright (C)  1998,2000  Rik van Riel
  *	Thanks go out to Claus Fischer for some serious inspiration and
  *	for goading me into coding this file...
@@ -218,7 +218,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	 */
 	adj = (long)p->signal->oom_score_adj;
 	if (adj == OOM_SCORE_ADJ_MIN ||
-			test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
+			mm_flags_test(MMF_OOM_SKIP, p->mm) ||
 			in_vfork(p)) {
 		task_unlock(p);
 		return LONG_MIN;
@@ -325,7 +325,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	 * any memory is quite low.
 	 */
 	if (!is_sysrq_oom(oc) && tsk_is_oom_victim(task)) {
-		if (test_bit(MMF_OOM_SKIP, &task->signal->oom_mm->flags))
+		if (mm_flags_test(MMF_OOM_SKIP, task->signal->oom_mm))
 			goto next;
 		goto abort;
 	}
@@ -524,7 +524,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	 * should imply barriers already and the reader would hit a page fault
 	 * if it stumbled over a reaped memory.
 	 */
-	set_bit(MMF_UNSTABLE, &mm->flags);
+	mm_flags_set(MMF_UNSTABLE, mm);
 
 	for_each_vma(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
@@ -583,7 +583,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	 * under mmap_lock for reading because it serializes against the
 	 * mmap_write_lock();mmap_write_unlock() cycle in exit_mmap().
 	 */
-	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
+	if (mm_flags_test(MMF_OOM_SKIP, mm)) {
 		trace_skip_task_reaping(tsk->pid);
 		goto out_unlock;
 	}
@@ -619,7 +619,7 @@ static void oom_reap_task(struct task_struct *tsk)
 		schedule_timeout_idle(HZ/10);
 
 	if (attempts <= MAX_OOM_REAP_RETRIES ||
-	    test_bit(MMF_OOM_SKIP, &mm->flags))
+	    mm_flags_test(MMF_OOM_SKIP, mm))
 		goto done;
 
 	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
@@ -634,7 +634,7 @@ static void oom_reap_task(struct task_struct *tsk)
 	 * Hide this mm from OOM killer because it has been either reaped or
 	 * somebody can't call mmap_write_unlock(mm).
 	 */
-	set_bit(MMF_OOM_SKIP, &mm->flags);
+	mm_flags_set(MMF_OOM_SKIP, mm);
 
 	/* Drop a reference taken by queue_oom_reaper */
 	put_task_struct(tsk);
@@ -670,7 +670,7 @@ static void wake_oom_reaper(struct timer_list *timer)
 	unsigned long flags;
 
 	/* The victim managed to terminate on its own - see exit_mmap */
-	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
+	if (mm_flags_test(MMF_OOM_SKIP, mm)) {
 		put_task_struct(tsk);
 		return;
 	}
@@ -695,7 +695,7 @@ static void wake_oom_reaper(struct timer_list *timer)
 static void queue_oom_reaper(struct task_struct *tsk)
 {
 	/* mm is already queued? */
-	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
+	if (mm_flags_test_and_set(MMF_OOM_REAP_QUEUED, tsk->signal->oom_mm))
 		return;
 
 	get_task_struct(tsk);
@@ -892,7 +892,7 @@ static bool task_will_free_mem(struct task_struct *task)
 	 * This task has already been drained by the oom reaper so there are
 	 * only small chances it will free some more
 	 */
-	if (test_bit(MMF_OOM_SKIP, &mm->flags))
+	if (mm_flags_test(MMF_OOM_SKIP, mm))
 		return false;
 
 	if (atomic_read(&mm->mm_users) <= 1)
@@ -977,7 +977,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 			continue;
 		if (is_global_init(p)) {
 			can_oom_reap = false;
-			set_bit(MMF_OOM_SKIP, &mm->flags);
+			mm_flags_set(MMF_OOM_SKIP, mm);
 			pr_info("oom killer %d (%s) has mm pinned by %d (%s)\n",
 					task_pid_nr(victim), victim->comm,
 					task_pid_nr(p), p->comm);
@@ -1235,7 +1235,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		reap = true;
 	else {
 		/* Error only if the work has not been done already */
-		if (!test_bit(MMF_OOM_SKIP, &mm->flags))
+		if (!mm_flags_test(MMF_OOM_SKIP, mm))
 			ret = -EINVAL;
 	}
 	task_unlock(p);
@@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
 	 * possible change in exit_mmap is seen
 	 */
-	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
+	if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
 		ret = -EAGAIN;
 	mmap_read_unlock(mm);
 
diff --git a/mm/util.c b/mm/util.c
index f814e6a59ab1..d235b74f7aff 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -471,17 +471,17 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 
 	if (mmap_is_legacy(rlim_stack)) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-		clear_bit(MMF_TOPDOWN, &mm->flags);
+		mm_flags_clear(MMF_TOPDOWN, mm);
 	} else {
 		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		set_bit(MMF_TOPDOWN, &mm->flags);
+		mm_flags_set(MMF_TOPDOWN, mm);
 	}
 }
 #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
 	mm->mmap_base = TASK_UNMAPPED_BASE;
-	clear_bit(MMF_TOPDOWN, &mm->flags);
+	mm_flags_clear(MMF_TOPDOWN, mm);
 }
 #endif
 #ifdef CONFIG_MMU
-- 
2.50.1


