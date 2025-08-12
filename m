Return-Path: <linux-fsdevel+bounces-57525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F63BB22C25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795E33A8E93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386342F8BFE;
	Tue, 12 Aug 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P/W5/XPH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HHfUOi1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC802F8BE9;
	Tue, 12 Aug 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013728; cv=fail; b=pz7OduNy9FBf+k0Vwc7KgwhFcNSXKcZOTOboso8I4+ox+6VI2EAGKnThU0iJuvwuhSefWJ6O75rcsBAvsRdcoOwrhXb1uVYfGir0flzwvHnzs38Vef2N2y9Gjc8cde1kTIt8h8GrZSWYPVLwZ33JbJssEn3ppg3q9AoMnJQHCJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013728; c=relaxed/simple;
	bh=aMags+nGUKy3j7VASY5vq5Nf6vaQHE80uZQGS5J2QXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qO//d1+nvtXKZYmV+moAtpqhcOdMX3MjPG8TdDY7KAvGoixxunt9pZFsz7/HJ+qev6HxmXfGpu9z0xH7jHscAN+NH0D5x1Q5NFnUoYltkAaoKpIU3ISh2heap/StnEMCdXD37+ybmOBvcNwoS/JnHmBgJWwIdV7NSgadsl+e7kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P/W5/XPH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HHfUOi1L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBx2u002271;
	Tue, 12 Aug 2025 15:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B2aS6BDl/QFPmni7CBmM43BqGZ2pwQ8wQmhHEe2pv/A=; b=
	P/W5/XPHh2H8rgXdvb5QtCm3rnhZtKiK4WQ9hCrB4jrhsR+u5+oqy1uPpcYZUow+
	pvVFP2m2TgvJsoQ4MNQ2h5UfI/0A4HdH1FfRez4PjOePLYf3BSNBj5rTjZ7MeU/1
	5k9SQZuJ/bHcBByaUxknwfPKTXyDBCUzHw6OMrXoZp0GJra8pqg+gkIZOByeiKhE
	paqXo1kGmhNcvY2wPtlzlpDQZ7gcg6rj6S+JDvctYyyQk9f/8iCzYJ79ckDTKtlC
	IOibKE/dLT6tKnGoSWDVoK4Nh3w7yr97YBCF2kEtZxRomA6bPF21leC+wzmBitqR
	ZV4vdNvcti7WDApjgvcS2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfw1my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:48:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CEQu2o030118;
	Tue, 12 Aug 2025 15:48:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa515e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw0sviBedHRUPjygN+Oh5AwsZpf76vUEESC8Ay+5WxS+YQnMPUKvL+x8G9wzElyvFMK7Q/DG5QMDlpLmwE4TQNq5uTJCWvHjWsnwLrS0amZeTUc9cTXYqHgtlUdIPqegVX6z+wBWlPnOVfmCJThQ+jK5a5t1xXwHKlS819r25YSJb/Py0n/eI79tETELmGXtdVzZfewnHmP+k7Qi5jJTdlZE+KNhTTgBsdrGxTEK85zC+6FsFvoMXbtZPut2UH5xTOiyX2YAA1vpPmSkHtq3m27oM3cTBav88fVxMoh/qJ3YkbQSH8Uixry2Lo7xB2QAU7NltTVaNu11Jil0oqWU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2aS6BDl/QFPmni7CBmM43BqGZ2pwQ8wQmhHEe2pv/A=;
 b=J1akrVV3jT74KKUo7rxpAuoYuRjNDfQOmBG1Dyd9bH3At+rjgZUZqLwFV2C4ZdU09nFWhG5ThGF1ldBmZtndNLP1GujwJAU115JqrGrYPG8AR1M0pftWOrkwLKKbCG02JVW1TYUn0bOOFscDviCx7eNNHPXIG00uejJb/9zZxRGU9AGCIaDNaAuBwOh0FI5UvqJtGE7y2OfbDqvJnSk907kUFqvXofrUtOhkjjZ+69NPERR9SdYshX1ehE3toXdGU3UCTEL5zEiq/gh6uzuyTPjb9SKjrkPa+RdzyjpHN/rIqAvGEhTXo9hS11U7deQjydXgb1CvIssv+H6mRbutNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2aS6BDl/QFPmni7CBmM43BqGZ2pwQ8wQmhHEe2pv/A=;
 b=HHfUOi1LVrrlIsGFJui/AjFyzv4iRYpN3rtK/jrsVXzu0DBMB6FWme98jA8BYNX3X+AiJ+D2SPaxMzy1Qlq7T51TYX18RK+3vCG9veEmxf27zq279yQ2s4fjUVXY5isQHCXRLlroPaqWvBEDR3FeL2tUKolSyJ56hPs87RubzQ8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:48:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:48:04 +0000
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
Subject: [PATCH 10/10] mm: replace mm->flags with bitmap entirely and set to 64 bits
Date: Tue, 12 Aug 2025 16:44:19 +0100
Message-ID: <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0000756B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c574ed-4ce1-4b37-4f4b-08ddd9b79ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FE3fa0s9JdaUEkx4jovNwPs6th6kTBEdweMn/hz4BBilA3k5Bio4UUMjOIr9?=
 =?us-ascii?Q?aoxPbyj1KwuPQlyOUFu5tAfp3DA5Peg5XH3Eqd+I/BTSZ/FgV0DXJ8xD8JM+?=
 =?us-ascii?Q?AbDiTV3RksN0vWskvXcN3LS56d2YFFk8U4hgZ/wID+DhdsBNWDBClyMQa1x7?=
 =?us-ascii?Q?1b01S/03YysbA0C58LIAKyvPVEJFJQaU+E0lZTcr3O6AoXmkEcwbqR8Czju5?=
 =?us-ascii?Q?2LGxpdFERycYFocniDRJriishZUjlhHO/nv9nP4bsgLRfplwdpn7Z5e35UQp?=
 =?us-ascii?Q?wF3bdA5U38qUEo01VYpHmU9pt4eEvdsR0yoiMl2cb8ujK9pfFuF2h3OeGT2o?=
 =?us-ascii?Q?5FN1xflGvQ40nUodAZufFm84t++CyAt36zdzwZcl3TW0a2AxjvVLudKEbjZ0?=
 =?us-ascii?Q?TpLKFbi0e2U39YFP70ffzzqbi7PDRPwd3NfNgyuSchsakEbKvWCAQumfp6+u?=
 =?us-ascii?Q?Wum2ntrL3yVO5npE1Zprybi5XbrkXKkQDe6PplbtXrBs+zJ94bOFyZ7RjJdE?=
 =?us-ascii?Q?5l0qvMQLkl7stOyGffjz/XpxwiGoAXFlXMH5VRloSWq3GLsh6bI96FhM8O1X?=
 =?us-ascii?Q?wA6yeYTYuwjMHLiNBKMCdshYFiPrwAE2iBggSZF25mm73PrhS0Zh3S8qcW//?=
 =?us-ascii?Q?Np4/5idesYSFkb1zZR+vT+kwsoxPMcTTlDdqppMPG0QSfOQNWy35FcG6hSVI?=
 =?us-ascii?Q?t9sYMFSzZef/zo6M384Zycfaxab5ahsS+yQYlYZhnhrn626o+eMHeDxGEqOr?=
 =?us-ascii?Q?ABH/7TCLwj7yZn1K7cZLpJPPoJSPDBdgEBkpho7TbLuyq8AEolaVMVWrUH9Q?=
 =?us-ascii?Q?AtBZZpBBbmvFEO3MRe6PtT5krMjYfpKnAuBBwcjFGQo82ENu8TW0zE2cgRuy?=
 =?us-ascii?Q?pddLqMidnaRHEvIsb82sANQVixQxj3yFbvCYullAucAXzmKTQOLWx+lF9LWO?=
 =?us-ascii?Q?TD/o6W5KiDUcJVkDtenmM/logUsMyM/lcvveeTWAiG/N4vmr1q3HgSOMsP4O?=
 =?us-ascii?Q?39XgGNDMA3B12jUsDffujADLwH4RnIrwRCW+S6EeyzDUhPWAgmv7f8mU/dYK?=
 =?us-ascii?Q?PJcBTyknjmndMjILG3JRWl7+hEikYVmoTQUviKXn3EIbtDNBOsaW7/e9g74u?=
 =?us-ascii?Q?5T8WtDOs43k4epSryb60/4ldRjjtzYQE9tcFnPeGLBlc+49XumcvCJWzjb9R?=
 =?us-ascii?Q?rWFgAobIpgxWPn8HF5M+s4noT+J+gu4jLPJ2MQ/JtFVYd47BHqGKXtrBaexW?=
 =?us-ascii?Q?+b8Ngfo4aeOaTZflTyfO3OrmznoosVNtqWqLe6HZCwmTnvvbj/97v1E6ZhiU?=
 =?us-ascii?Q?wbNCPNtgIATR2cmk8cnLzN7ihiEoodnscCMGSmRjRVCesb5XHKbJXGGmmZTn?=
 =?us-ascii?Q?t1c5gpfZXmrnDWUZnj5MSU0fKa0hIDolfEqku+BfWiY8g2fn/LEIixj2Yn6U?=
 =?us-ascii?Q?d5kIfwQOIU4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ffR8MNhC+UHq/zcM5ukbznhozjAO3Y8C9nem5bA10xes3qJgnX7wVaHrgBIz?=
 =?us-ascii?Q?t/hA0apiE35PiDa9ENVXZHLpD7PqItF37FaznRkVKmV0qeuKOulqyOAp8xez?=
 =?us-ascii?Q?faUqJ465mS7AlL/RC2Os5TNdGFxY/gIahXQribWULb6533bGjEPudzge2k0B?=
 =?us-ascii?Q?VmjNB6XgAra6yyOKQfrWC4fw41366YGAGjolp3Wx2O5bRF01F50/eVE44DO+?=
 =?us-ascii?Q?21yBR3NOlg2KUmAuQDgnsxxlaASTAKDMdckUrSdnpMMAUItUnVpGx7w8/zhh?=
 =?us-ascii?Q?1roFBqSwMkIBVP2rjgKWGG5kFBDWvi5FLRCnWYe8daZbTl97Y8lLyy8IK1R7?=
 =?us-ascii?Q?T22+UjqKXa2B/FmvgNI0WySCP0+aPL0PNVQlSCqialKvcVtRG86fVnMKHMOQ?=
 =?us-ascii?Q?BVMcdmo9ntngHLEbtJ2JXqOmvZCUFdHgnuM/vBxLIdSBVYj0N8ni4tDAUG4X?=
 =?us-ascii?Q?8dl48rx8p2gyGVp3U2zOIIKCn7j+OJSRnjw4tjtRV9DJ3bt58cvM+7h3MuxS?=
 =?us-ascii?Q?SQe+gaa30Iv7euHVoRAhNGiu2V3qb9B9i39PVBmUPOyq2/jIw+oaYVVWpQaL?=
 =?us-ascii?Q?4nWfmF/6glOgJBPugkd/A0dXW3nEQiE/yNkIrXXr6ItIh47IZpeCARGyT/CT?=
 =?us-ascii?Q?+dhx2V+y1CzU7/v9M68VdpvmliZf1uMlpZpmwnCXwkJ2wPoCNzQwwhANfvNV?=
 =?us-ascii?Q?zku2oPqEuVqnurBDjaZzpmLyFuRZHvADhSnn1Oi6sXyNmrxfQCjvfmWqqgdE?=
 =?us-ascii?Q?TKUyv05E0iab0LV1gLydjLHyco4IkqiYnBfYx5iA7wvgrb8OURVO/PunoON1?=
 =?us-ascii?Q?azYCYAqKcYgzO7uiWUX+9Hnu82jgcEtl5DXtgiQt2xk6KF35ZAAEZdmMwrmK?=
 =?us-ascii?Q?sCDMNQ9+ORpzQ2RTHUikWIT8J6PueaKq9aCMsLLYzg9W0jeyXfTa8SJvyIwH?=
 =?us-ascii?Q?S/S+4fDUt9DLlu6MJNjEgm/P7yEZfAL1PgWr2tJ/Sz6FCcZgmw5qJDaXwDBw?=
 =?us-ascii?Q?PHZg2+d3Tn/j/IN2atwIorG8LRRkr1lqEObQuPjWO/j9CjRdR0KMgShwNfav?=
 =?us-ascii?Q?IzTW/Y7lfiChn1FnEwJvowDN1pv/8YSe06z4rFq2aj1BD/EenNrqcyrMMU43?=
 =?us-ascii?Q?PIb5HcCsp9kR2U9nHqza1IyL7t2Je0cWP8Njp780odC0OLiGKnK5jmGZslAg?=
 =?us-ascii?Q?cEJSWWPS+oLgc1MLfJEQCgSHJ8GOg9mFRONPbjFcEPYEKtsIi5OjOd516zGq?=
 =?us-ascii?Q?FPYCPblhuNupTXubIjIjpKZ6MdkSziWznQp3gFTcoXyTlBBHUvteB3sJ7WWF?=
 =?us-ascii?Q?6m05UrlDEcTH90vsuNdnQBApeFt0trfNgnmdNF4bsYsy0aUDqB986b73L4l/?=
 =?us-ascii?Q?l8uCcT0Vz6I6zk4bLgPjr2RWjG8ryxlz2cfWvDn//VVfco4DSS5Mt89/8eaV?=
 =?us-ascii?Q?ZvyFfa22Kvq2kJ1E/iMra0VPf9Pztk6UGGpQxSWVWVCzvWq6RbWCwQ+KjvBz?=
 =?us-ascii?Q?lB8sGOZfhhyTr8vr9ow/RvuEkpaiyEsB6FNK6yV/CISChCaAkZApB8O3/KMn?=
 =?us-ascii?Q?KTnBlRJzoFph+G7snDTuwq8BmGXygKubYeXKnQhBd0H5exCcGCz6Hjf6z0zy?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vhM0WLuzqjgPeWresNDowUPFy9C78S3OuU+LckjNSSWGCqZseRGkyAz1f6DapNQivxHpOX44/2bnK0l41wAqB8XQnKF4uILBuctzKIY2nogTdvB+DqED9NLtNl9PdLSRZB6iT+jmD0Kn9vjoZksyB5oHm8rbOItpFrwHVRyrRqPYn3sA6P3/l6//FdVUmJoEEZ22W+INXLQqP0c4Rcshr1iBG5OQR6BxZacKI285SBhPMDqNjrbE55poFY2SQkQ0MTtorh5PcsHhfpO3Eakc1WMUGYFYXUB617Ipd0eue7TpsqMpd7ZRUHIBka/mcV0dfg1/A8P6LrT4LzQEkiSmDu/z3vv1UA5l7TJXiNWkLahW+5M9UaCRknQvyRNdOMmXoQp81IlUy6KOwtZdvbWWcWACrA5FkwDwC/fCcVFmpSYr8T1EJ792dpiBnfaFJwZKdyxWxsz2YG1N2eoanrI5umvsaqQaXmefTUQM4tRhGSNObURdVV0WD76wMWPd1U3jPLYp5Tq2hAcEkVnatXOYgBHr9Ik7Tk9hd3yek+PwUS8YBB7p/AHgCS5FL8UevjDeHfrFHeJjNbJ+Rwz8jij3s8hvfFuHrVCn7vGlZx3mpqg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c574ed-4ce1-4b37-4f4b-08ddd9b79ff5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:48:04.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fax5G7ZjwF52ACdH4S0E7DShD/dtE0LQEQkrZKonhUN40lbV5cXzJINrr4Jwr3NZxIX6CkKP7G0iBJsnAzg95WkgErLKBEzfXLC08TSbh5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120152
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689b6238 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=HEFxLipkG5v1IfcSOxQA:9
X-Proofpoint-ORIG-GUID: SSDk9o-HNJM6qbTY5FCS92usSTuMdn9d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfXwBIM6TOeMvdc
 Zqc8dMzHtbbQPA46OXNOhSjU6B9CZAO8qbwLFZ9aJPZbR7On21/rhC21FqWCaAOTCj1xkmAMPvR
 IfsojzxQ0v2xzHnug5stAysbEY/kdvbfmauYqw3EfLDnK9vuwjlbYgQxkuJ3Oi5MCatSZPku89r
 6dUruWvfEniw+ercT17Q/sSOm8mAtyh7dwj5Q/T2EMZkAKrl7fxUcg0KHMMZj97DbovO9zUz4pL
 Q7eBriwGMoNPMRpwaSaERKXN1NP0YgzxCDKzZP0/XrmavCeI5gwGo0AP9YCyILO147Pw2fTvPy4
 AV90qgWfjyWyS2LTbnjL0hRuNxeCuL3g/NH2RuEZtltky7EVo7VG6yhF1zop/h+mc2IK21ur8oK
 SrEv4d4ki4/y98J2z0t8yNnkHCSKHL8o/m2CWq1JF6kVKzemZdjtYsKMAsPBcqjS10fwdYmM
X-Proofpoint-GUID: SSDk9o-HNJM6qbTY5FCS92usSTuMdn9d

Now we have updated all users of mm->flags to use the bitmap accessors,
repalce it with the bitmap version entirely.

We are then able to move to having 64 bits of mm->flags on both 32-bit and
64-bit architectures.

We also update the VMA userland tests to ensure that everything remains
functional there.

No functional changes intended, other than there now being 64 bits of
available mm_struct flags.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 12 ++++++------
 include/linux/mm_types.h         | 14 +++++---------
 include/linux/sched/coredump.h   |  2 +-
 tools/testing/vma/vma_internal.h | 19 +++++++++++++++++--
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 34311ebe62cc..b61e2d4858cf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -724,32 +724,32 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
-	return test_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
+	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
 static inline bool mm_flags_test_and_set(int flag, struct mm_struct *mm)
 {
-	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
+	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
 static inline bool mm_flags_test_and_clear(int flag, struct mm_struct *mm)
 {
-	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
+	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
 static inline void mm_flags_set(int flag, struct mm_struct *mm)
 {
-	set_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
+	set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
 static inline void mm_flags_clear(int flag, struct mm_struct *mm)
 {
-	clear_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
+	clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
 static inline void mm_flags_clear_all(struct mm_struct *mm)
 {
-	bitmap_zero(ACCESS_PRIVATE(&mm->_flags, __mm_flags), NUM_MM_FLAG_BITS);
+	bitmap_zero(ACCESS_PRIVATE(&mm->flags, __mm_flags), NUM_MM_FLAG_BITS);
 }
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 25577ab39094..47d2e4598acd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -932,7 +932,7 @@ struct mm_cid {
  * Opaque type representing current mm_struct flag state. Must be accessed via
  * mm_flags_xxx() helper functions.
  */
-#define NUM_MM_FLAG_BITS BITS_PER_LONG
+#define NUM_MM_FLAG_BITS (64)
 typedef struct {
 	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
 } mm_flags_t;
@@ -1119,11 +1119,7 @@ struct mm_struct {
 		/* Architecture-specific MM context */
 		mm_context_t context;
 
-		/* Temporary union while we convert users to mm_flags_t. */
-		union {
-			unsigned long flags; /* Must use atomic bitops to access */
-			mm_flags_t _flags;   /* Must use mm_flags_* helpers to access */
-		};
+		mm_flags_t flags; /* Must use mm_flags_* hlpers to access */
 
 #ifdef CONFIG_AIO
 		spinlock_t			ioctx_lock;
@@ -1236,7 +1232,7 @@ struct mm_struct {
 /* Read the first system word of mm flags, non-atomically. */
 static inline unsigned long __mm_flags_get_word(struct mm_struct *mm)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
+	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
 
 	return bitmap_read(bitmap, 0, BITS_PER_LONG);
 }
@@ -1245,7 +1241,7 @@ static inline unsigned long __mm_flags_get_word(struct mm_struct *mm)
 static inline void __mm_flags_set_word(struct mm_struct *mm,
 				       unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
+	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
 
 	bitmap_copy(bitmap, &value, BITS_PER_LONG);
 }
@@ -1253,7 +1249,7 @@ static inline void __mm_flags_set_word(struct mm_struct *mm,
 /* Obtain a read-only view of the bitmap. */
 static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct *mm)
 {
-	return (const unsigned long *)ACCESS_PRIVATE(&mm->_flags, __mm_flags);
+	return (const unsigned long *)ACCESS_PRIVATE(&mm->flags, __mm_flags);
 }
 
 #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 19ecfcceb27a..079ae5a97480 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -20,7 +20,7 @@ static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)
 
 static inline void __mm_flags_set_mask_dumpable(struct mm_struct *mm, int value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
+	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
 
 	set_mask_bits(bitmap, MMF_DUMPABLE_MASK, value);
 }
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index cb1c2a8afe26..f13354bf0a1e 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -249,6 +249,14 @@ struct mutex {};
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname = {}
 
+#define DECLARE_BITMAP(name, bits) \
+	unsigned long name[BITS_TO_LONGS(bits)]
+
+#define NUM_MM_FLAG_BITS (64)
+typedef struct {
+	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
+} mm_flags_t;
+
 struct mm_struct {
 	struct maple_tree mm_mt;
 	int map_count;			/* number of VMAs */
@@ -260,7 +268,7 @@ struct mm_struct {
 
 	unsigned long def_flags;
 
-	unsigned long flags; /* Must use atomic bitops to access */
+	mm_flags_t flags; /* Must use mm_flags_* helpers to access */
 };
 
 struct vm_area_struct;
@@ -1333,6 +1341,13 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
+# define ACCESS_PRIVATE(p, member) ((p)->member)
+
+static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
+{
+	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
 /*
  * Denies creating a writable executable mapping or gaining executable permissions.
  *
@@ -1363,7 +1378,7 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
 	/* If MDWE is disabled, we have nothing to deny. */
-	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
+	if (mm_flags_test(MMF_HAS_MDWE, current->mm))
 		return false;
 
 	/* If the new VMA is not executable, we have nothing to deny. */
-- 
2.50.1


