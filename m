Return-Path: <linux-fsdevel+bounces-57523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3288B22C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6835250498E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42B2F747A;
	Tue, 12 Aug 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DmMqjwsz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="klx0pzl0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A32F7452;
	Tue, 12 Aug 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013720; cv=fail; b=XzL/LhNqHb4N45kMGqdAxNGtLg0C0nkzww5ajjVRJG0vJ0q/K9EHTYskh62zxQHqI3YL/CzDi/aH5LcpQ24UVEXL0eTZkE1ZZ2QldhDtxTFt5Xy/GWQo7dPO8R8gsZ/bR1hDwJ4ik1ey2BllwKezbqVQVgQFuibxMjyWkpNoBUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013720; c=relaxed/simple;
	bh=Wg/WB6tcG0IKIX2RlDJaXaQhJdOIuNuLF6WFwBVYopo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPtkVdq0aOKdIkJqz1E+HmFWoZOS8zw9wNpQBMEt31KF/4yMTd+3b4+h7Gm3S4bD0KV4NVs33UcYoOXdKtR4HuUbf4c1vmjPTBDqXhJC1bq3X8/f8Pbx7io0vQUWbmNKYRPCTDbjuyG6XZvM+mGjNUDpHSFQpU9jdkzQR7fuDSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DmMqjwsz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=klx0pzl0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC04G021868;
	Tue, 12 Aug 2025 15:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wpMTDBj67IGcrceFB07qs/Qs9DxiWzedQjqpIqKoUFg=; b=
	DmMqjwszgfGTvxbE+KU3tijpgiRHXaAhGoW5W518C5j2eH3+SwVGCS12xgWbbt9X
	mv7kon9Hhpk01c9a3oScdyrEo6PNtFqV+XGJxDGUrq5393A+NrNR9+E4Fa6CvtLj
	d5pHuMUh591x9CbgyKNTfu+KfSDxVc/8NicgbZ9IvF0bwKTJI9dsVF300o/JYtq0
	fuGjVJBfWozAU5DcDQe75H+TOOBLKVuZhti85E0v+dr/9aA8bZuiOSo2rPMjacUT
	U+iSRkvd9BeL9KY5L7gGeZ7EoeM7OzZXwJklm5fTku0xBsfBnIsUFwNDwkH7cKFh
	ZlAAE3sN1dtwkkCRFAuVSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4d1mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CEKIuw038606;
	Tue, 12 Aug 2025 15:47:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgp972-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqLi5pn5ZCOo49TpxM8VBeDvvzr9pXagp0RVlyGbptqBuJ2088o99tyfXcp8qg3kPNDD0V5koNH4rdR4eiyMjkE+F64htkDFbNXAV10BWNkOLFQgWNAE/crd4yc7WJaAy5GEK/8d/5Hio7YZ4ZOSFzA7MEUMSujnUcvNyii98ytGrFSycnwob9SUstoRmPeZ81R940J3pqn+WGGAn5tvBnQqE0b9R6WG+UcBv52TF3W3diofVaidWJB4bGQhlebuvcs1qnyb6rwVY3LoIA8UeGJvRRaq1sWtCCa7d2M+dX9dC/g8a0BhAG1UBU2+IBGP3CtqhydUR4KklmcE9uYrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpMTDBj67IGcrceFB07qs/Qs9DxiWzedQjqpIqKoUFg=;
 b=jyZIC5kePct+HTEXw7z7ZbbNu5yZ3VAlUhrhM7LkQQo2Png39ZY6vycAEIJxaVQdaCCrn1JGC6BG4BT9x2g2RHr9W9pmK1PYXRsYCcRhCvTq8O6+sV5hbu4T011Y5YCCj/f01DeG8lNcZdtsQjiipXujR9lPRuPvJ0utyqhTxkmVLZ4Wh0TMhsmqIheRSFsyg9uiLZKfxAg+V6yK1DKT30XLf1SvGRzaizknU3aqyz7qRwqI4bRf18AArzkwEM/pDylYg5YxxLLV2Srdm1OIu0uZtQvrpeA5YXiESH4/FWn+u79FO2PBNUAtzFJmJ5pkhE0jqaww3jgNF8n220HA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpMTDBj67IGcrceFB07qs/Qs9DxiWzedQjqpIqKoUFg=;
 b=klx0pzl0lM2+5PoduzxGBJ0lq8+X8BnnYyzqQidvxa1+P4BscUerud8nn7lLDKXa7JaYGJ9/6iZCWHviMx8Ja/SM6oF5NcIM2GvU9Qzslcrb+CcXco3A+TD1Q1qhCx5K+YVUYywjpCfWCJym1F6Gw4L4zWfXQ1rkh2T79vEjR4Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:47:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:47:48 +0000
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
Subject: [PATCH 06/10] mm: update coredump logic to correctly use bitmap mm flags
Date: Tue, 12 Aug 2025 16:44:15 +0100
Message-ID: <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 168193fa-7b82-4c83-1a0e-08ddd9b7964e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmSc1FTeRKEQ9iDC8FSBe01v51/+65r39YLq7mCbd4w/DBo9XVCoUA46O1Ad?=
 =?us-ascii?Q?jn6be6/cNTLfqvGIJpUyMx5zqT/jc4JWKoNmH1pQKhAyMLLh4X3PBjVIl9+N?=
 =?us-ascii?Q?MO/Eo+92FU5Pzz2O1cwpmZZoG0EkOfO4Akd18/SMlVriHCIvBrz2v0EzLn1k?=
 =?us-ascii?Q?klJgB0HfuolMatY9aqaSdhfquGa8SQpfYFc60YpfeW7z75+AICG9ilQT2xTi?=
 =?us-ascii?Q?IzCjLM5DVqwnqZHCaODVDLoi+At70j9hpXmHXm9NURIEU3A0FQ3DWsg800Pb?=
 =?us-ascii?Q?a/IAaD5zeQsdo7aPgy4nhM58hCvx3bRU7fCD8Vog+Qm+XX6bwlueYuq9I3uO?=
 =?us-ascii?Q?m2nO12SYlMmkdpIhqv+GfOi9g3RpE2xBJeKE5jmp2QJmpgvTXvT7NfFhHwNS?=
 =?us-ascii?Q?eeZsYZhPyADqboVo2YamLh9jfkaTZ5/FxaxsO9ifqXZ/CzCYRHGiBflUboua?=
 =?us-ascii?Q?hLyQ10Ol95VRvh+7/V3YO/ungykOYB9PcIN1jK1mGPuBg6RIuSJqOOePmkP+?=
 =?us-ascii?Q?O26TZJ4nm2r+sr7ZDJAvhjdNgVK5pVM8/O7n4N258aPuu/frD+31iVnpyJNb?=
 =?us-ascii?Q?jqfUWd9jPB/4Qc6+uxjJXsHUSBFINqV57hTcys9AcXvpVe0OZ7JLl4+bL+8q?=
 =?us-ascii?Q?gQidxESg1smxbsiIHXTIsxYTXq7zdwF5IGNMIY6YbnxRqLBiVWfyMcKKLvP5?=
 =?us-ascii?Q?ZkNcGYHix/BRe4DVwWrifvPPz1tg3aYH5LxequU4p8oB2f3Mj1mRACd5HrQU?=
 =?us-ascii?Q?tmcsXPTwLQzOOq4aYofHHqbcs7DfieVlT6txsx/NMR8lSPNBt/v/ZD4247Z9?=
 =?us-ascii?Q?koKcfhH/I5Fn8XrekXr4EONNGwg7MmbfpAzdTdUFmTtq/7qfWurnp9c3jlDx?=
 =?us-ascii?Q?7rqRgcwejmlxtjCZdznIWzEiL+9L797gCniUExfTIZMtAaLC66W9qYH5UCOn?=
 =?us-ascii?Q?HDbLMiToq8iE/ojuXOklP80buPqnW0X71lbbfG9psW0o7vWURTWROoh+dRay?=
 =?us-ascii?Q?lHfi9xnY5+e/YflNXaNYuTlYXoDNeZYrepnmC690uDAkfmzghO4qGca3qbJ+?=
 =?us-ascii?Q?InQkTPAQ0klq5AcJOscEumCH+CUZmM/UbNqkQA1D0ZVMKcWLDRjCZzi5oP0A?=
 =?us-ascii?Q?eJ0wqI7K83P+WRgYoLGpO2QMGZwRY/0sqlbHTFmfT7hkuIaBX2Vn6ZCezjYR?=
 =?us-ascii?Q?LKDaCFiZISrx9/8ed6rmZUAVgY6q7xRmUK7eHv5FGLuLNpuWWyubQ9MCfZ4i?=
 =?us-ascii?Q?k9DM77fqvVxNOxe3D38mqKgML7mGeJuGTD53D08uIdB27hZJOsfmNcjYzWiN?=
 =?us-ascii?Q?H+LduHjKz72tMqKzccYgr2TCydeqAC1E9w6KfDbg+Di4/TBSfAmP0EZ0X3/2?=
 =?us-ascii?Q?PsAoJNA8KPcbrs4zf2H3B4gzkMAdzt6MDVNkQYDf3W9WJzGk2CQKnpBbKqSw?=
 =?us-ascii?Q?LA11Hy+dwS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8N0Amv14YwKbgsLmG4SwnS0k0ST93LFiueOwCRIkojUn5W26BYHt5BCn69dE?=
 =?us-ascii?Q?91IpxDesiTzAl1fW7PPotwH/sVBORmwjbtblW6hyyBSddkSxyKjIFZQbwf3u?=
 =?us-ascii?Q?YN30X0qM5P9pQQNuIxD/1QfjbCtLYqs2CwjGYXlVoWdGAqp4gl4ZIiku6I/i?=
 =?us-ascii?Q?WRhzdRxSjxmGhceOllDQBJn64MdOMnzfk5KgTUDIoz7DvuD+AAj8TNV6Z8KX?=
 =?us-ascii?Q?HKrfE/Gxc8qzGZ4LG6R94tTI2d9kacZqM6HhTJYyhIaMwW/U0p4Do9rTZQUc?=
 =?us-ascii?Q?nJDzCgGnMCj7CSZ+zlvwQ6laULKEQjnftZJY/8jAwlaJqu3to9K+SrOsuc3b?=
 =?us-ascii?Q?8eSXmDWOZ/e3rPvQHHVCpQHUudF64+DCUV4ZGaKE/p70wA/03lCwOrfe80RM?=
 =?us-ascii?Q?AAn0sv/YoTZhhx9O9UKweYfoKKjT6Vko5LQq6XXQAW9ztstriqh+SgNQ2emS?=
 =?us-ascii?Q?7XWQ2F+GglT8La0uqAVBxcSEHO5Tm1rdc1mP8Sm3NjlR0R6kF1BdPMreI4y2?=
 =?us-ascii?Q?SUw3l8/wVuiBje9KJA1JY6y/vNrshPADG7Y7S4qPu4CRuadAsRvvArgEUlWF?=
 =?us-ascii?Q?lBt3SdNMlujmGGPAZb+iRpXHuCW1EJWr0qEmHfrXf0LeqymazDx4WQ9iwDtS?=
 =?us-ascii?Q?ubfkvsNgNGA1CT6PoDtmlbfSlAmaHayUCQtROIAmnU8nzvzU0PL7NNfrKaGE?=
 =?us-ascii?Q?ILRxTTbyo6zME2NAM8tRT+GZ2i44mws823nYfQuAfxFD0XOYCBKEhGb2Y/qJ?=
 =?us-ascii?Q?f/yy+BMlp5uAVwtpLcqJfgiHJ96cND0eW14c8q/h7Ny8hLR6wHHqb9zMPu0Q?=
 =?us-ascii?Q?tq7cKDD8CYnW56hho6bcWfgcKpL4bs7ObzsYoVVACwlUYkEtngwxeJBguDTR?=
 =?us-ascii?Q?B5SrJITM4M46430VE2u1X567MLqVJQxdfDV0vxyWcFishxrDJBufiCJvtfMn?=
 =?us-ascii?Q?y/YUjwLzloCpfNh6H11acf/J1tZMpln4X1cfPopa1P8oWpxglqVj+WUM7NgB?=
 =?us-ascii?Q?81B//oxKAM8e7a1JNbWpAFf61UR3CvuF/HySwpoDBOqmKYDquA98t5sqzTqH?=
 =?us-ascii?Q?hXeyzIbcrivUFwy4POm3dwbh9OkfdPeqyoANsS6vJElg6iBI813gBvIv/yR3?=
 =?us-ascii?Q?wKK9KZ4gF8Q7pilXGC2glpC70mm12leuGQy/hpUrt4H8jEMRz2tGxrfrb3g4?=
 =?us-ascii?Q?yZ+JDUID3QVUwlPfd+ucYKRYV7hZ9zsuv3Buk7MxASUkvTipR7ilrkX774VU?=
 =?us-ascii?Q?VtuIRA9Tjl2nQzgQlGKbFTKy0Nwnfvf+pA5HFBUTp59t8w9d10Cq0jvKFxau?=
 =?us-ascii?Q?QqZcdbmLtR0K3E4LP/e7wOQxl61mPn5rhHS70b/WFgW8j4eduFR+psCq3vjm?=
 =?us-ascii?Q?miuCF/mCwB0c9DCo8hDHd8q2RBYHNUcvuDkC7Qzwgi6JTbSrFpaYXMwdwJbV?=
 =?us-ascii?Q?iU8L+P0zyfnY2eIV3hKjxFfS5Jnx61NMWNIcMKD9gUYora+c5VP27BPDuE51?=
 =?us-ascii?Q?XIqiiaKyTRwbR855wZbron4zr0VqPabfw9z+oTn8wB5Ytzkc2CxmOC3qMmYb?=
 =?us-ascii?Q?F71IzyEXg7oa49FEaw4is4cnvEMDp9WGkzkscutecIQ2VCTjdu3gHK7hbixs?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UrqSJSGuPofeQS9bI+5MOVtFV3ycKN8NCYJF0V5uwfM98r4WNxEOE4pVucAIDj2CvlpBiG79mleZooa1BSwcss8OxZCVV+oPLLkCzXODoWgzah5vNTxGE6ZZ8tA6jcc/+FQeZ7Eru9QevHLt3PX4hfS7f8ogfnqkFeBS4KJWL75iHzmi99vYpFN4RAA/dlIAbHskPYYzf54dzwnVN+VY49TOI7Lia775+zLQCdUGPXFhAZj46fMDi2gpwT9L5t4pNuA9IeUv5jdYuNqGNhKkizLbBM3jkIrIxhZ0O0p2wfwnMZ4f732B69WeGtH9yX3gy0G9CRRF5OaXlbH66KhWAsqbYjiQexptnPTYXxCDdQKIGw2Q7vwjKQ1hriq0KjJDOr3ebMjCGWdXQ0snBkzEBghQnUUG32gMmjlsQO2jumzNC+Im0LU8Gj4X9hkpTqL43dxRvx+kidxw7wVV5JSHvR4uZuD8cwPRyWlTzJ/41LQoYdyhdrfcu0MfvJdXqtJdnOgApdgNKNq5rPU9NvXgSPKuikz7CH2iQsXt0k7MM9lKUz8kNz2mYzanWi2Wp7EEN4ajPEhL1K2ufaAH/fY+cGuga1/tjD9vAOSaepu9Cp0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168193fa-7b82-4c83-1a0e-08ddd9b7964e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:47:48.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsjPoD3dTNhNwRBwr/OcAcsT6g1HBXKGAxvt5hnnOqnGvvjDkHH876XchGKnEW43lm0WVaJO4Y0dupZ8HQJqkuCaXJV0Tah9JVI1+7O+LoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX7XJtAgG43UKT
 9somc2nmKMxwfyLzmkY/ADAB8waMG8Na5sVan22G3c1BOCssxO1PMYnNv024U+b//uH5WJruAkr
 bqdJ5csjZyi9PbI+67I7ryrLVdZFvOOlnvYI8/yKTb2EAcGWI4RHcsY3KuFDbwl/cu3Mixifsmk
 mYwJheEY3TOHay+rJ5j3miXUi2BP0yqwL2Bsd0Sk0xNAgUEBQTS0fFHios/HBHcBD6Z0Ntd6Gwi
 EM6ekVLeKLNyaDvmBmTvCt/Awrc3wicDDholOi1h47F7lVO8H/rGL63RYZjNeNM4FyGkpv54Uw+
 jphfIAiNRPsAhN5ZvBSSg0FpKN0+qdPIK9rsjNFn1XIWPE82fFuSq/IKdIKkdIcLSE7coAGV2TX
 WEkBZjFbE4xCUxPNwP3RtSyGyZ7nb/LZ/ZhfqKRGfahYbW7VOoHOLedjGheFNM28v63CYYhb
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689b622d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=gS-fvTtYXd3W2WFUJ4AA:9 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: HqDQJJz2n-lCQ92JNMDhIgR-IxT1u8qM
X-Proofpoint-ORIG-GUID: HqDQJJz2n-lCQ92JNMDhIgR-IxT1u8qM

The coredump logic is slightly different from other users in that it both
stores mm flags and additionally sets and gets using masks.

Since the MMF_DUMPABLE_* flags must remain as they are for uABI reasons,
and of course these are within the first 32-bits of the flags, it is
reasonable to provide access to these in the same fashion so this logic can
all still keep working as it has been.

Therefore, introduce coredump-specific helpers __mm_flags_get_dumpable()
and __mm_flags_set_mask_dumpable() for this purpose, and update all core
dump users of mm flags to use these.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/coredump.c                  |  4 +++-
 fs/exec.c                      |  2 +-
 fs/pidfs.c                     |  7 +++++--
 fs/proc/base.c                 |  8 +++++---
 include/linux/sched/coredump.h | 21 ++++++++++++++++++++-
 5 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index fedbead956ed..e5d9d6276990 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1103,8 +1103,10 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 		 * We must use the same mm->flags while dumping core to avoid
 		 * inconsistency of bit flags, since this flag is not protected
 		 * by any locks.
+		 *
+		 * Note that we only care about MMF_DUMP* flags.
 		 */
-		.mm_flags = mm->flags,
+		.mm_flags = __mm_flags_get_dumpable(mm),
 		.vma_meta = NULL,
 		.cpu = raw_smp_processor_id(),
 	};
diff --git a/fs/exec.c b/fs/exec.c
index 2a1e5e4042a1..dbac0e84cc3e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1999,7 +1999,7 @@ void set_dumpable(struct mm_struct *mm, int value)
 	if (WARN_ON((unsigned)value > SUID_DUMP_ROOT))
 		return;
 
-	set_mask_bits(&mm->flags, MMF_DUMPABLE_MASK, value);
+	__mm_flags_set_mask_dumpable(mm, value);
 }
 
 SYSCALL_DEFINE3(execve,
diff --git a/fs/pidfs.c b/fs/pidfs.c
index edc35522d75c..5148b7646b7f 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -357,8 +357,11 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 
 	if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
 		task_lock(task);
-		if (task->mm)
-			kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
+		if (task->mm) {
+			unsigned long flags = __mm_flags_get_dumpable(task->mm);
+
+			kinfo.coredump_mask = pidfs_coredump_mask(flags);
+		}
 		task_unlock(task);
 	}
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 62d35631ba8c..f0c093c58aaf 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2962,8 +2962,10 @@ static ssize_t proc_coredump_filter_read(struct file *file, char __user *buf,
 	ret = 0;
 	mm = get_task_mm(task);
 	if (mm) {
+		unsigned long flags = __mm_flags_get_dumpable(mm);
+
 		len = snprintf(buffer, sizeof(buffer), "%08lx\n",
-			       ((mm->flags & MMF_DUMP_FILTER_MASK) >>
+			       ((flags & MMF_DUMP_FILTER_MASK) >>
 				MMF_DUMP_FILTER_SHIFT));
 		mmput(mm);
 		ret = simple_read_from_buffer(buf, count, ppos, buffer, len);
@@ -3002,9 +3004,9 @@ static ssize_t proc_coredump_filter_write(struct file *file,
 
 	for (i = 0, mask = 1; i < MMF_DUMP_FILTER_BITS; i++, mask <<= 1) {
 		if (val & mask)
-			set_bit(i + MMF_DUMP_FILTER_SHIFT, &mm->flags);
+			mm_flags_set(i + MMF_DUMP_FILTER_SHIFT, mm);
 		else
-			clear_bit(i + MMF_DUMP_FILTER_SHIFT, &mm->flags);
+			mm_flags_clear(i + MMF_DUMP_FILTER_SHIFT, mm);
 	}
 
 	mmput(mm);
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 6eb65ceed213..19ecfcceb27a 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -2,12 +2,29 @@
 #ifndef _LINUX_SCHED_COREDUMP_H
 #define _LINUX_SCHED_COREDUMP_H
 
+#include <linux/compiler_types.h>
 #include <linux/mm_types.h>
 
 #define SUID_DUMP_DISABLE	0	/* No setuid dumping */
 #define SUID_DUMP_USER		1	/* Dump as user of process */
 #define SUID_DUMP_ROOT		2	/* Dump as root */
 
+static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)
+{
+	/*
+	 * By convention, dumpable bits are contained in first 32 bits of the
+	 * bitmap, so we can simply access this first unsigned long directly.
+	 */
+	return __mm_flags_get_word(mm);
+}
+
+static inline void __mm_flags_set_mask_dumpable(struct mm_struct *mm, int value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
+
+	set_mask_bits(bitmap, MMF_DUMPABLE_MASK, value);
+}
+
 extern void set_dumpable(struct mm_struct *mm, int value);
 /*
  * This returns the actual value of the suid_dumpable flag. For things
@@ -22,7 +39,9 @@ static inline int __get_dumpable(unsigned long mm_flags)
 
 static inline int get_dumpable(struct mm_struct *mm)
 {
-	return __get_dumpable(mm->flags);
+	unsigned long flags = __mm_flags_get_dumpable(mm);
+
+	return __get_dumpable(flags);
 }
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
-- 
2.50.1


