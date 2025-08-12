Return-Path: <linux-fsdevel+bounces-57520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5B7B22C11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C866211A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1B23D7EB;
	Tue, 12 Aug 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iwHEKhDe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gdEK1Sqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388A23D7CB;
	Tue, 12 Aug 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013708; cv=fail; b=PZx8/m7zMI2YIf+fVzEqXrHC6Ih+8f+Nc81iYShMb0Vpp7cygAcxzcRUZLqLdbcEHcXQunMVx6lPSd4MHjqDElKYxmN0X1c7eM1X8u628Fv6iUbkr4GOFA/wXr+IXiuleScLHSNLbkaz0zqi5VKmwsEyb59zb8azRxzyc6sk0rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013708; c=relaxed/simple;
	bh=jKOy5/Gx1zb09cbsjz4MCPUFiXjXlxNsej/4/XzXa54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tVmP3R9GhwOkFnLM6mmAR9J//5K2ipJVuaEvS1ngUocxLcSnkg7ILr6jDVztCwzd+8cLN+VXZmkpTK6lsWjcyFXZM91TUi5Y/NRoH6FSoWpezj0JlHruByBYe8K+2y3JQlI0ZLcstgtBKOHK5bK/cp7NvJ+s1YhhaFlY+z3lNZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iwHEKhDe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gdEK1Sqw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBwIs012373;
	Tue, 12 Aug 2025 15:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p4WrW+v3s50+o12gso1QihZZVzhU+GSopk9B80MDx9E=; b=
	iwHEKhDenoU/uXX2Z/Fmj/IzS/ioi9o5wYHGRcDpjNnyw0buuumeMYXpB6KmYFFM
	Y/FjMY2Pmv3o02kVbV3JE433knwsl1bDdhcViyZ9wE9g/H4May3cCPW4Pbymt6VM
	pSU/WBONbEkjWF2zsavCo2XWWYUHaeX203iom+kAL/W0qL0dtcaJG6iNeb12C+mL
	VFmgU1Fmhp3JphwYHkHPVpjiLPbgVqXJT+mEjBW+lGvXFsltmjYGgWSr3BpLdbZY
	x342mRN2lTLyHFWfIuuq9k9vRRuDJL+3zNcLrZ3dF92xg3W6PJxN/+vJ++X9FAYz
	/WOsL/wv9ajhYMt6SeXJ7g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44w2um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CF3CwW038739;
	Tue, 12 Aug 2025 15:47:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgp95a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMkfGoE95bR9a8W5FTtZNspMFy2W4almV2zwQedGMdvWlcvWqZ3fTrqkoIFpgkyOFYFfnzdv4mmW9EnKDUiIo0/9Ox3OfDW++q9YTLVaC8uoNSHDUe8QbuSkaD+1EqyKbgOFFdizU7Jf+eB+46Ujf/xOEi1pFoq5U1IpHZNKsKYgw9rFR78gRyTFBiHPKgmRzoIWYc8AbBEj3u38u2ItQrScuRzVE2+1y3lUlfwab3XRWyLJcCBTbbVVXhNFnz8rkzsZrakbBbwjAonJ9XCMX9uIbJGEBkmbXbFap83fChYVOfcAKdnUpyHGOzCcip+8fYE6QqVhzV3U9Uhnr75C/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4WrW+v3s50+o12gso1QihZZVzhU+GSopk9B80MDx9E=;
 b=Buv50QqeD6xMrjkuCqJiRW9rsu7MeEpR4a/GfG3uQOfYcgNbJjcRNztqtZir1wzbsjsDwh5NovKIP0jFRxPxh+X6ZmrCD2bWJBDhkXkFzcGOHbt6JM7rfi/Ql+AkDEgoYAI3DbH6gyTFmNbyirVLqOFJ5TwKmrVDIb0ucshJRHX4f9vvBdrIh4FvLApb/K8xOxpJmK0rl273953+D9kpV7sOCCEAYZYddud/wFCB9k4J4d1zM8E0OZ3ImS3Okezp73jnAbbff6onXuPTzAuy7IfwdFyMyXI/r2PYKbHTjLzQ5AMRhleO8AN9Dmr5IYOu8VgX10OMWmASdBhZeTZu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4WrW+v3s50+o12gso1QihZZVzhU+GSopk9B80MDx9E=;
 b=gdEK1Sqw0f4ZsULN948OFEZTspASP38bsU91wLGvm9tTqXszv+IPhF96HOaw9wHJ9HRn1VQ6Q9NW3Zzf+9oaiGYPnniLzFCK/LoNEs1R5j3I7hqsNA+/H91gpbafdGYqNyOxxZGuvwDKzCSWi7RzJAMX+yi6QWMuIvuVbD8ePug=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:47:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:47:44 +0000
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
Subject: [PATCH 05/10] mm: convert uprobes to mm_flags_*() accessors
Date: Tue, 12 Aug 2025 16:44:14 +0100
Message-ID: <1d4fe5963904cc0c707da1f53fbfe6471d3eff10.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 509df06e-6089-4fb9-e724-08ddd9b79402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXM8+g64K/mRmjl6V2sN5wGsg9UPOwTucy2XYi5lI4x1hXqnxkzFB3QhJeMp?=
 =?us-ascii?Q?ddyszIlY7FLp9a9O3GV2efH2tXHXEfTvAiPfouwFKQ4l7Y+s+gghFbNGXVkv?=
 =?us-ascii?Q?fK5NTJEIyGQxFeBSzBa8D6mTunNoeN12+8FfQWNYokAczCkLNwvkKljnFZrD?=
 =?us-ascii?Q?zG3slyOhiHCbNJrmzu6ROt0msGOjZS14Y8ttpCshGHOvRcKm5ksH0kPXEOGa?=
 =?us-ascii?Q?jfas5Gd9W0E03+dwlWf0WPLkl1KYP/4/1rCBLLPehml3P/dJMJrfc35euBMK?=
 =?us-ascii?Q?gjyOMVaUJ2j5CQM7V94G/qhgKIgu6UphR1i1Cot5hVrbtMPfLiM7o816kMDe?=
 =?us-ascii?Q?wIrfS9eHEpOA6kLVjBIr4Lw4PfFw+dIu5XaXzEXcHQEGh57COasY1BDtwdfV?=
 =?us-ascii?Q?g+pjtinNUSXh+KVtuou1ymSyMxUzCDNbAyjdAD5AaJINcTLNjgfrL8r6EM+e?=
 =?us-ascii?Q?g9/ekD+rWib9obFAbuHhvgZkbt5b6f8CZm6YAwLat7KtqeNOlZHXIBNqc3RZ?=
 =?us-ascii?Q?5ApPpz60PjMltbbJtuAePCSZjIdSj3iayYgWxhb85xUqEGkVzFjYAcOD9Nnf?=
 =?us-ascii?Q?aExv/iftD2BLa+JZr8il8egMqFHLay45STBv2SNhNOOpxGPLHgPffJKVvVHt?=
 =?us-ascii?Q?KMvRAUd7h2YBHEE88Knvh6G7N81t9FPxvm/KwyJtL2PctddKuQic0RXHoGVx?=
 =?us-ascii?Q?rZsBIDX+UJWu+MGMGz6LzYIYwpQ5hMTfPZD7LCjK/8QQGeB8sEIvQy5vSEvM?=
 =?us-ascii?Q?0MUxCgz2dG3Q425G3SQEcxVnTMDR8jydCO0cvGzX+JEu1Wg/SdEBgQZHatxa?=
 =?us-ascii?Q?7g7xbZCNOLl9z6hdoTkQbBJKB2teYUFDfJEJOy/odpQ5C39parGZQov242ZD?=
 =?us-ascii?Q?dDVmkXUhI4Bm02z8G6Z8qJEBbFs62gqv22MIQsMYj/tU3DuLApyAhpx2mf8X?=
 =?us-ascii?Q?LEIbBBUOraTT+6go2Lenr9zavhx2/O1gAci37I55iB7tbs/JnKfgSKSVracw?=
 =?us-ascii?Q?JEBxx4+zw+A/TZA8o0VAri87GiEcqS6C2IqlVYH3oPOZrFmJkkvoDqPhkuKD?=
 =?us-ascii?Q?BXWObAgTIAw576QDRi+WSgWbhlyGHFi+XfG57pT+jA99CAAS9gDSF5h1/cTt?=
 =?us-ascii?Q?mIweeLHUcu+ZHQkMzD5XwnVJD1HaTTNSmpfxK5gZj4QcQxxU22wh5Uc/jAAS?=
 =?us-ascii?Q?BlOVKCBJGdiDz7FnNH5mDCjO/kFrQjEvHuIGqrZOl/5nrMPNfA/g1xf4jys+?=
 =?us-ascii?Q?XahBB8N645yf2u2SnXcBwLhpmvNnAd96RTUUoPutwrZGF+E2Yj9MJ9z7Ejr7?=
 =?us-ascii?Q?Rcc4Vx6Dzwo48a72B4bdqdG53Qx5oAazPvoeQRGbOd52Blsgt6aArRs1Rdpk?=
 =?us-ascii?Q?jFMjknJiSbv52qO8FYWjGWzbT15a7Z3pn7+szvBZmGJcWFC1JVJVTml7pIE/?=
 =?us-ascii?Q?jKb7DrPW/Pk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/sRh3lCpY6zlzufN0sZAeXPGTAUpYBbBkezF+LtZFOLADhWcu/+jPKni+OI?=
 =?us-ascii?Q?iUBaErnplGJ40KTktLwPly/0/PNmngTPHOzfPM4Dgwdd9jhaUiyrSeNB105U?=
 =?us-ascii?Q?6hpr6xtudiF3BSZNXa7Zdal4wcLMItWtyXASqsbRnnJyWUtm/s/D4s+/K+b1?=
 =?us-ascii?Q?6+AzE+qKBUMISO/YDfVs52hiMML6UWtoOgVltOsMdvaLwXSKTcgyFsyXvDGl?=
 =?us-ascii?Q?eFy1eiqqf0JLK7G8REKNdyvJaLgCYxDF34R2+a8IHgG2r+86XjSHwOwNhkAb?=
 =?us-ascii?Q?qmfJtuVcE/R5rjovjwoac4mT+7wJ4W9sVRgSgcjurc2qMF1tKgTZRZd0/Ot9?=
 =?us-ascii?Q?XlU6ZdDQQMdt/yAAy/Jp3eoUnThFGmdZFBJc8lt+qIC4WwLxmxGFvgBJ2Mcs?=
 =?us-ascii?Q?P8ha7H1lmJhKTmEAdK9Kw1StiLOZPYmfMJvb0ASxCCp9Mv0aWQQ0FFgCgp9U?=
 =?us-ascii?Q?H118Ul0CMpqRF4c2wWCiwjEJ66ua9ZYbgmfgnSi8jI0LMcrbCt/HVbGnkNnM?=
 =?us-ascii?Q?PAsP8f3BVlVyyNot28lluBmhzywI+bXvlIUPJQaTtjBzE54HYnIoO9XtOg9L?=
 =?us-ascii?Q?Cp2jKHgpEerPImXMuM4VGzv2gN4+fs3vhlfCLHatNJ3T+vNqvr00/TBWxSOA?=
 =?us-ascii?Q?9ytqrEAdkdjV5p8MFEBUs9Z5g0ENFR/w7wuQDoBeejx4jFfM/TriWHqbndDn?=
 =?us-ascii?Q?t3jJBMsUT3N+wyRPS/7Og4KZjSyKf9LbLTctXNf6r3wgPoMV+CUqe22wQR0U?=
 =?us-ascii?Q?fT8tqkNOKgVKlOGOHCAMj2YNp5aJngzzbi5zNdK+P+/kRSv3owKVRR5G/tiN?=
 =?us-ascii?Q?HUgc4sKRHiJPqzNMW//hHfbbRzPCLvAzJidOMPcAXaY1wt+UYrtJc7rW4TzH?=
 =?us-ascii?Q?jdAQ+CoWQ0s+UVMRkqIb+RaWRLGCpX2YhF2RGP9Qjl6YpUlScMXFUVSDb+uB?=
 =?us-ascii?Q?v22z7zWtW+4OMwCavlcRj55+tXb9W73uz3BSriwFURK21cDDc/rPAVw2O1Ud?=
 =?us-ascii?Q?x4Ib2pn+PJNph3SICB9LU+86vrfbC0+gc2hk3vR/HQTte8AJULNedLL1m6A+?=
 =?us-ascii?Q?uTx3gIXoTOvw8pBE+JQq5WBW6I/e6qVGFSsUgJc/R6neCjc8HKkfGXvo+ZwV?=
 =?us-ascii?Q?9dib3kQAVttKKIpsbkPAV+iHKQzUvTLtbAt5oolii6mqyVswspwB39SlKCle?=
 =?us-ascii?Q?mFfyNhqNiAdOfKtk+Sm2wgKx9YemiII+Xqk0jMawFDt1Meu66TQY/C/kAjIR?=
 =?us-ascii?Q?7XxSjpYi1Nl+MoKJDYO0MQgxJnl7ZYielgrWp/aE0uUQHTLRqgAkqakjdHWJ?=
 =?us-ascii?Q?GeTExkqBr5T7BAX38Vt77EjWq9pz+MGmg3b/70blaQmRPAws4P2TAhndf1Sh?=
 =?us-ascii?Q?Ha87xJg7pOjK1YK7bUlXeO0DKprh+pxUnEBuhhhBAo5P/ZcJGkLWwNppDC8V?=
 =?us-ascii?Q?86b1PtyEJ+8jYV4D0esLOxZpCJ4EthOc+UzGzjKctHHDPN2J3gO6T9CtNb74?=
 =?us-ascii?Q?ww9ODgc2uU50jqJUHHllqxnBzTJiUZNGXqfSx/09fT05DALhJvC+/1pRXXZ0?=
 =?us-ascii?Q?uatTJkNAAV+PD7JatnVSE3ge48Am2XIo+FIebmAgIU3nyA2x2AtS0lyNEfXz?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nh/2KJ93hN9jbtWHt35lAVxYR7emY5/lwhmZL4GSP0GgDEvRkQklfDZxuEDt/1ar38Tp2sadzEvexDqvgmQGH7Rxb7EYCBGT9KrPuuTCGPHMF785CPgouffBWELLSBx26+dCzqLdzIElDn9CHFvnj3UZM2F4VNaOxZx3MBKai2+7jfZUuNvyJ0Qo1XAure+sTIqhVzzKkF8HU4s6f9Ne478GTfJrzHTr+xcLbYsngaoVQ74d12wPpmRsOINan9TVh6OeTkFjIiBs9KGbTKgDqHL4rnBByUHmbyzveFmNM5v85MjhBWlP0R9g+70XNaITsTrpQvWqe1Ux1cvUuNwur54WkwBtdyien4yg4IKZxiev6f0v58tSPFDXrSMBAMulJjXnW8EtTApduZaNDVywfSKceMXaTvOup2Atkbe2pt4tP1CTP7MZ+ZGXaLyH15ts4hGdHTc4OQIQ7HLB1NstQGInVNPLB2I3WITgm1gmNBEECGqbcCqB2j3+M8FreyK6H+4FpVT5a/K426tJfT+iZliM4/jNj9Qm7MqkMHz7aVPMbU+tt+A1E1+Y2Pa/VKC/tCkEz/zpJvOStp80kQLhCh4M5mBIjMUDgiQiTZ8b+R4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509df06e-6089-4fb9-e724-08ddd9b79402
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:47:44.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3dBsR3ewrMfXy80EC6RjS9fizEuxXea7TvrFKES3mqoNJMOO3ae+/doxHnTgmtswmmadNwWXN8u2mx7WyEXuxQifTHDYWN6xoTbrZWepew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120152
X-Proofpoint-ORIG-GUID: YBNnHr4N9GnYNowe9gLGzfB2JhDlAPAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX9wnRKQ6ooeCK
 fhLN/io0QuFetlbZKbCCLuA6VmbRlWi0p38Rg8Z+9LoEwL4GyPCjY6ViUmgyi52DHCRwjRE5F+l
 6bkTfyjK1xfGBNCIuxIMgiFjsZp0PiF7hchWwGCbH6Qx4exGFvduWJgxLrZClYbmkOUAztVoCDW
 s6u2OoOoEvexzCjpZHVM+qeqWG+H0H+wS1BXdpKNJbjjyTIOyISdak+klylOeUxf6XHcN0K873e
 Y6KTs4DV8NbTlhMR2XGK9FMnTCl/zXpCr70dBTmMANRnozfwIE/HSSAXwdfmPAMxRcWELWjoQZ+
 x3Hs3tGaybCcxjm9cjo8NI902HJH+fD5yVxrhk44ZaZrKIbSt3V4c5M6InwAu/mv1H8QyzugY0s
 cDexnWdnoaToioh7AY2MDuYrWPJeeqpoyJc+ZsZk5to0jxZlmikxMcYvw3EdK2IjqCEhOHIh
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689b6225 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=2hV2yruqUzzz4P05FaUA:9 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: YBNnHr4N9GnYNowe9gLGzfB2JhDlAPAJ

As part of the effort to move to mm->flags becoming a bitmap field, convert
existing users to making use of the mm_flags_*() accessors which will, when
the conversion is complete, be the only means of accessing mm_struct flags.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/events/uprobes.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7ca1940607bd..31a12b60055f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1153,15 +1153,15 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	 * set MMF_HAS_UPROBES in advance for uprobe_pre_sstep_notifier(),
 	 * the task can hit this breakpoint right after __replace_page().
 	 */
-	first_uprobe = !test_bit(MMF_HAS_UPROBES, &mm->flags);
+	first_uprobe = !mm_flags_test(MMF_HAS_UPROBES, mm);
 	if (first_uprobe)
-		set_bit(MMF_HAS_UPROBES, &mm->flags);
+		mm_flags_set(MMF_HAS_UPROBES, mm);
 
 	ret = set_swbp(&uprobe->arch, vma, vaddr);
 	if (!ret)
-		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
+		mm_flags_clear(MMF_RECALC_UPROBES, mm);
 	else if (first_uprobe)
-		clear_bit(MMF_HAS_UPROBES, &mm->flags);
+		mm_flags_clear(MMF_HAS_UPROBES, mm);
 
 	return ret;
 }
@@ -1171,7 +1171,7 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	set_bit(MMF_RECALC_UPROBES, &mm->flags);
+	mm_flags_set(MMF_RECALC_UPROBES, mm);
 	return set_orig_insn(&uprobe->arch, vma, vaddr);
 }
 
@@ -1303,7 +1303,7 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 			/* consult only the "caller", new consumer. */
 			if (consumer_filter(new, mm))
 				err = install_breakpoint(uprobe, vma, info->vaddr);
-		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
+		} else if (mm_flags_test(MMF_HAS_UPROBES, mm)) {
 			if (!filter_chain(uprobe, mm))
 				err |= remove_breakpoint(uprobe, vma, info->vaddr);
 		}
@@ -1595,7 +1595,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 
 	if (vma->vm_file &&
 	    (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
-	    test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
+	    mm_flags_test(MMF_HAS_UPROBES, vma->vm_mm))
 		delayed_ref_ctr_inc(vma);
 
 	if (!valid_vma(vma, true))
@@ -1655,12 +1655,12 @@ void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned lon
 	if (!atomic_read(&vma->vm_mm->mm_users)) /* called by mmput() ? */
 		return;
 
-	if (!test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags) ||
-	     test_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags))
+	if (!mm_flags_test(MMF_HAS_UPROBES, vma->vm_mm) ||
+	     mm_flags_test(MMF_RECALC_UPROBES, vma->vm_mm))
 		return;
 
 	if (vma_has_uprobes(vma, start, end))
-		set_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags);
+		mm_flags_set(MMF_RECALC_UPROBES, vma->vm_mm);
 }
 
 static vm_fault_t xol_fault(const struct vm_special_mapping *sm,
@@ -1823,10 +1823,10 @@ void uprobe_end_dup_mmap(void)
 
 void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
 {
-	if (test_bit(MMF_HAS_UPROBES, &oldmm->flags)) {
-		set_bit(MMF_HAS_UPROBES, &newmm->flags);
+	if (mm_flags_test(MMF_HAS_UPROBES, oldmm)) {
+		mm_flags_set(MMF_HAS_UPROBES, newmm);
 		/* unconditionally, dup_mmap() skips VM_DONTCOPY vmas */
-		set_bit(MMF_RECALC_UPROBES, &newmm->flags);
+		mm_flags_set(MMF_RECALC_UPROBES, newmm);
 	}
 }
 
@@ -2370,7 +2370,7 @@ static void mmf_recalc_uprobes(struct mm_struct *mm)
 			return;
 	}
 
-	clear_bit(MMF_HAS_UPROBES, &mm->flags);
+	mm_flags_clear(MMF_HAS_UPROBES, mm);
 }
 
 static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
@@ -2468,7 +2468,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 		*is_swbp = -EFAULT;
 	}
 
-	if (!uprobe && test_and_clear_bit(MMF_RECALC_UPROBES, &mm->flags))
+	if (!uprobe && mm_flags_test_and_clear(MMF_RECALC_UPROBES, mm))
 		mmf_recalc_uprobes(mm);
 	mmap_read_unlock(mm);
 
@@ -2818,7 +2818,7 @@ int uprobe_pre_sstep_notifier(struct pt_regs *regs)
 	if (!current->mm)
 		return 0;
 
-	if (!test_bit(MMF_HAS_UPROBES, &current->mm->flags) &&
+	if (!mm_flags_test(MMF_HAS_UPROBES, current->mm) &&
 	    (!current->utask || !current->utask->return_instances))
 		return 0;
 
-- 
2.50.1


