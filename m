Return-Path: <linux-fsdevel+bounces-66501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFD0C2141E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE37E4EFF41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658E2EBBAA;
	Thu, 30 Oct 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C/iV3khu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xTk80kAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2F25EFBE;
	Thu, 30 Oct 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842373; cv=fail; b=dsVCIqGfv/UpDG+AEska/UC5XOyMHY7ZAjyXbQNrcBLHBqb6n0M+lik9npup6gUIGl5XP6vmvwIk53/nf9c5czlTObJkgLvYdT3U8B6l7jRNSZlXIGbPwkTsRrcvuPxmeGco9EPIHFwEK/al3l4PGIiStPGY3MvLUMfWEUbW0Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842373; c=relaxed/simple;
	bh=tGDtgzlgZFcFFHt6xZrmZKAKw6acMhHUXJs+qwz+v/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O8/4QO4/iDT0BSua8wzhRS569sMZ40HBilZScqdSGvlmV5os+ep+4Zjl5Rs01OAtnoPCZ5+8L0T5eTZ+7xLEc9I1dqAJc/gCe+jXrYmk2EM7Tn0pgAsk0nw+0GYvqO6F9/4Olg549koASa4o3+/h5CVINVonIhN8cf0zAyuvaCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C/iV3khu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xTk80kAY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UFlv7a005746;
	Thu, 30 Oct 2025 16:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tGDtgzlgZFcFFHt6xZ
	rmZKAKw6acMhHUXJs+qwz+v/A=; b=C/iV3khu0fZ2dIUg0eWIdAkR2lkZGHSRWU
	HT89ZD5AXkiUCzRRqyTk3jYHViS2UgdXnD++EZPESYVkCup+ROcYx8sdvtIxgc47
	v13vBoukTtvDJdqy/564NwgtlfaBJlRxgEcHk5MoPXn3kLhfF5IlCzbIRuzqGI3a
	plPq+Kf4SvZkDBPXfLPJeVTlzC+NxFyuxWJSEqyvUOAe/c1jp/XlzX73MgZvOahX
	Nwta2sMRUjOgn5VbPdVhAgrKAsEFIEq17aJAqfPDfy1SiU+6W8dxZNsmLbD78whl
	eIbaxcA9ziAjLE8e0rrEGG3iftommDheShR1DP/AERoBKyiXe67g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a49hjgcx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 16:39:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UGVoo2023363;
	Thu, 30 Oct 2025 16:34:10 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vyv4g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 16:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhAZ7QFMnOXmhfEaKnaV7dTSzsRXTC1m/SXsYw+K70VPCfllFQTYErd30OCoPue0WuNOf7MtINbT+H0rNpNgBsFnZmqyoSl/CfDYHNjYwGV8IJDCfOdagchF+V8dooDzRKXAvKrWRkd0GP3FMg+hw1DYJdtgmkeFUQcLDGPJh0ld6DZSkynbXlemYj6jEFulS53XsbrW9sthFkVzHHbUrsDuYv/Nl6kvCyA2HGeoZzMtokgJYw+Lstf4+TTfR7e41XqqlAiLGL2RdReEukfZs5bgZUzkvm96P3HftfaCLTDTbGvmpx0aP5Fu9QnwTxs86YYTUy1rql5qPIAWYOfszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGDtgzlgZFcFFHt6xZrmZKAKw6acMhHUXJs+qwz+v/A=;
 b=ZNiz0JlV2FlMx7L4Ayxr31DTp7zkftXMHHUhOZLWGWT/IqqACvPSFilAppAgcbgF9YN99DrCEioZCN7H63Rpntogqwm4+pHgiHTBAwIc6N3WLPgqe/yPhVKIDnsTKqr3oPLUXrK3XF/rQQzfZQ1KtFtnGast67xD7FMqUVd390M4emdD4LSg8mbmX4SK5FFc9xf4cToTN9x/kx+n5djqMzJxf7TPUf1/UtRGM4fXDXb2ktTS3f1pJ6R+5gZHYTCQPOR7GlBz+XjYcY94rKFiAUMZZljMbFKfE6JptgK7+lKibAG34GYEXHTuqR6z2nyLLbNhqJYV04zPUsjDWAr2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGDtgzlgZFcFFHt6xZrmZKAKw6acMhHUXJs+qwz+v/A=;
 b=xTk80kAY4iOn9csERGOfc+yWp5RSWqPKJSd7cs+s+XT7P02oZmNJK3ofxVJ6IVN3VrMsGSQ8JXmiTEbbQy8VpcO27FZvWXhM0L4Z/71TK4EZqItBKh/TkxQhDQPoAHiyy10ZoV/g27zpjlJ5fNccQnGxZHv3Qk7T18ucCb+C86k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4640.namprd10.prod.outlook.com (2603:10b6:a03:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 16:34:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 16:34:07 +0000
Date: Thu, 30 Oct 2025 16:34:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/3] mm: implement sticky, copy on fork VMA flags
Message-ID: <47913147-90b1-4016-ade3-e56cd63f8f5a@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <ec71238fd1f735ca6e4970ccdc0abfbb60967596.1761756437.git.lorenzo.stoakes@oracle.com>
 <jmyrkglrrdxtdkcnovmkcxbk64zgfpp6r3e33bquixkvoxl45r@zcnwp3v2ucbp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jmyrkglrrdxtdkcnovmkcxbk64zgfpp6r3e33bquixkvoxl45r@zcnwp3v2ucbp>
X-ClientProxiedBy: LO4P123CA0341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: 3859cb84-bb25-4c52-ed10-08de17d22591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+sFoThF8QzNe5Hy5e80h8isoYcwcMnz1Dno98OMyhmjDIeOkB8TQRfHDV17p?=
 =?us-ascii?Q?/xafa+HcB9ndGImjMxXRH4+0/oJVpfoGYj5X5fOz7b4L0feStQifVLcZSj1E?=
 =?us-ascii?Q?hKcQlm9WaRhQonHNIPwb7IdhTQHcvYeu8iVfbvFrSYRiih8I1mIO7g4qQHcR?=
 =?us-ascii?Q?oEc+PG5xzWDK095vSvlS9CcqQxiAzNfrjb47/KYs9Ml0uPS57gs7fwOLNqcY?=
 =?us-ascii?Q?dtV2QcI+wRS39VGGaCcmcSCCMUweFlk4gAqBItM/M/sitQuhv8BPVAHduIW5?=
 =?us-ascii?Q?pzCfL/i8HTQF4IAzpw7Eh6ja48pTbTLBOMyyukX9CSy3W5dLthQ5pcUZ425g?=
 =?us-ascii?Q?87clab/xYjz60k4f065JhDNY6mWBoMS9LEjUSPOsBCMc2rK1HBFTeRzYVUgi?=
 =?us-ascii?Q?GDEq+J//bK7TsWyPY8YshVIw+r7vVn0Z78AT/4bHd57fr7vsjAFfcLGPC6lV?=
 =?us-ascii?Q?TlZkhBCnzrx333eMSvBSYqwWmqdh6lcolNjM8+AkCqtuFPvfN/3bbaK5UnEm?=
 =?us-ascii?Q?241ckooY0Xuo2MhNuGADzH9E+XC8AgNaorJ6o2BqANHwKNtbUy6vobKlGBlz?=
 =?us-ascii?Q?J9k+6fCN/cAwN7y/6mz0RMueHumZFA+6uXbGZu8TpTrjVfIneboKOGlifKMU?=
 =?us-ascii?Q?gQ0ekD41I+J28cNBolUxakrELXCfYzotrMjr3g8FPz8aLlHsacNNX+DQo+u4?=
 =?us-ascii?Q?Qa9oNrYverkyGbsn66fEDXwGPSC5aw5/Fn4vA3PAKOjYNpKsqkJg4RYUvvsl?=
 =?us-ascii?Q?ccBYJYkSEmmOPIGxRVagpSy58/H8EaN7Mp2qtb/W/RtAyxjbGDCgzY5Xn6if?=
 =?us-ascii?Q?fWcoGp2HvsWF/ClcUR6v3K1rswdM2/OTPpsTTbc3BF5RMUz42SiyopG/FNVn?=
 =?us-ascii?Q?/UoNVyb7cvYNvQ4UHSpXtgjuXD+7y7NrpLYT2M0/+ocuVeIUQT+Wlt5H5fBr?=
 =?us-ascii?Q?ePfADIAv95c+0QrmZvVf692EViYdhR3OxASpElwgtagoV2iOS/FF97ortTnB?=
 =?us-ascii?Q?E3E/y3kDIaoocBhTtryWkeXyhGgoQyf9/7YmHLkmeTcjQsf00UqRafLbE9N7?=
 =?us-ascii?Q?jxlQ5IXzZSIsFcXLSPZPjWcDVqphonz69vjFpw2cB1PbtDXYyRw1HroKeEv/?=
 =?us-ascii?Q?tEO0LmkTxOH4s10sj9h5BtNhaoGHohWQIFjlGNca10FKwMZKGmZCHeLxev1X?=
 =?us-ascii?Q?uPXwClu6JGA98PS2wr548EcliWdxVKZhsno36qmIkGRbxZCvfK41Ha0oDZS5?=
 =?us-ascii?Q?hkV3NiHiiR6ny3aegB29il5IP9LkiHHtligSD8eRyqhQDPbJS0fjynMr4WBU?=
 =?us-ascii?Q?ujlFbb6OEV8k2gZzgOjvtgnxhJi5OXirJrlRCuteN9VHFUqDDMAFe//pDSPs?=
 =?us-ascii?Q?9a313xByBLZVKoxPL1agEfDb9aiMMWu3pI1jY2EGKPPuJ2Z9CU9dVIqiUVIo?=
 =?us-ascii?Q?DBsQTQU7y7rKx7N2+N43TKS7sDjp00ML?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vkVyeZloxYWJKoLM9ZKiP4bCjmQD84vbBTcYaU970i+gfMIEpmRcp1Gs6wY6?=
 =?us-ascii?Q?+ZdU7N63v6B+RnRK1vbkzs7G0MD1uHC4zn2Ue7ZPwJMBg2cIoudrWrGj1Ngv?=
 =?us-ascii?Q?9EHsr0nmGeWC+m42rOcHBSKbuU8OeCr9tPzGey3F8SmX5dOW3OL1btrENEo6?=
 =?us-ascii?Q?TFexydITt5X65sCNGbQz/ELBzdMrSPPl/EEO6tN3YGgK7gOdAclmDtoqJwQ5?=
 =?us-ascii?Q?7paUIMSVAakn84AMijBoeUnwV5S9inAWQXFxKm16BkBwrxZwvQgB1y7EBBDy?=
 =?us-ascii?Q?flGFVFEPrxoew3ysRUS51pYp4RCbGbGqWFPGBYUa6fJA4FXDpO/Nfqbte2eM?=
 =?us-ascii?Q?ZtMhuhX4BcIEEGb4qDbLXMKWkilu/h+VVKjgBjqZwncDkmMDqD/RknaU7okS?=
 =?us-ascii?Q?t0Da/qmzFfNw9/Tu2pMubOFCcaA68FrUIOwG+aVIPHZ6u+oQDzD4d/VuSWmk?=
 =?us-ascii?Q?go+ReKmpLHCTkBN5hcCh+81xKs9NyLR4JbRTbdbIJELZb6HKQVRzcLlLkrZG?=
 =?us-ascii?Q?dKEK+uD80RPBz/JzK+Wqw0lW5q9hjZ/nNEh8UdYLWAbRL2XEkVgV/Ie7Qown?=
 =?us-ascii?Q?sMnAARwZXHMLM/TyZXYjjygu1xyBWsSf9tkY3oIpB/8G/+YfFYz396pc8wvu?=
 =?us-ascii?Q?GyOFTHxFGVy9gJkIR4PZqnmVDAgZ9XFL9mQrzom7iRBy9ORZyfLtI5jY5zt2?=
 =?us-ascii?Q?IOEcuLptkC7z2o2BEJt5sAoJ5IofyS27p09B9gB3M1HvMN9JGVUrsUspT8Se?=
 =?us-ascii?Q?aIBJPbUWBSiaeP4g5VEhhQNaNeAcPtf1V3+p+bIJdvZSYUU6esdKTcEQAYX9?=
 =?us-ascii?Q?8NaMe7VhcV9dr/mku5vTMpGeZOCKJR8XYiTUUS7nQP56BMNKSbkFRt31PXyP?=
 =?us-ascii?Q?tt0eZVG8Z2MbePLxGDaShtAIYwHTg17d3wx0UiQ3PmIo8BFVOgWLDoNhH/qb?=
 =?us-ascii?Q?opW8UE01QD4GTOv8b6ojtaQAKTitdFcZSOQAhv7bVOQi5nxH4qD5RwpqDkGT?=
 =?us-ascii?Q?nodDRuVBSS8t3HAId1y8i/+FU7gFyzcpV67WdJ8NcZRosOoacjZ/ru2olCy+?=
 =?us-ascii?Q?a7glwIgb1ji201kZmhocqoK7Gan9pJBOs/fXveTB4yukq88aWyjpLHJHOITg?=
 =?us-ascii?Q?SMkDqbuxGlO7Nzo5Y0z/dyOgiV4KTqHuWeuC8Xhx2Un3jLsx9kNi3cZG7VaJ?=
 =?us-ascii?Q?btlwKiyr+CRrQ40WhaicXjOQRZOfW9C6mMd3TlE7UUje64d8r8w4PkE2kXkH?=
 =?us-ascii?Q?hjWaz8DKhNpSP48o9bY1T7KYw+HvI5y3/MfJE9bl5S6WALrObwY1heNORUUR?=
 =?us-ascii?Q?02PVMZK5rVSxUbGJ5O0nmL3aI4Re/gjbj6c7VVE9yHhvKdymoVWDYE1B2GU7?=
 =?us-ascii?Q?oUnYSr9c8qLNaNUZiS918gj4Vjug7Qqy107fsfhQc/LWrN/GJjbGzwjMBkgA?=
 =?us-ascii?Q?9DLVGCE3CuBSn6tLoSf5U4i+9UB2FZfp8hrDw4l9dcN2jy5S4nAqeG1kP1dI?=
 =?us-ascii?Q?kSYx47RAn5/a70Rh70JK255u07Mlzv+fXnAuZrqqvpLcvgeMatWuYsltVIYv?=
 =?us-ascii?Q?v1VMQAcSKcE7BeEXgXiR+X5b1wnLuSalGi/3uX0GBVFnpq6O3sToryfezr/L?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kMBMixUyYk8+uBfKlzVAKOqESlWqciO926rXMIISILacNKh7XlvBPHiOQkjUqCW2ak4mqUYuoNkRKaSzzcPQ3K/o0U9EyjD7fMKV5dtt/3+w9a6VNTxcKr6FHQcp887pgoeBUUrxxlwaL6Evn05ghwR6Ntazz+goaK0Hioxtrp+q/lF4AONsZt45mJ+Yw8DRWYnQIHXaMVJn7GWPhHWqS0fK9ne3pq614CDDtn0+Q48TO1JC4EHz4jOZZh/PxorPd/iQzMw2HPHAiyWsiwI/G68b5TBcB1jEjcKEMFUeSZcBrrygaCb2TpJZG7DFr342SZ8kPgb/CZj8InJtdURkQCWWlTGCuBnF8M26V0cJl/PHcHS0krzRxA8pv0ymduOwuxppOvgi09Rz1KOzXCBL6JyZrxY2QTtzPCKoILDvxMAzP4Xh0a1spf4tvPdrAP6ddHlklIHSaoaRb6uMxHCtlWnxpUO1gQCJ39w38y4VIZTKxfcLr6drchkkY5MRchRkK5rWKZ9mYrhxHxoLCmXVAH4mP3xmrPMrOdWD6iyZZfNgjppWCKR2l6V0q6FlbGoDjVkwjoSr7zO8FXYbQrjdfmitOxrNdBjP+YTWgjKLCDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3859cb84-bb25-4c52-ed10-08de17d22591
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:34:07.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWIqGGDEGlVVoMHnbWdqOTIYJMsy5TTkBRdnsCVqE4t+bNyVZX+pgUC/5awwyStcF1HFqjZiwbRPR0QpxBrpBSL7X8Mypn4+Nx3ePjWzNBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=880
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300136
X-Proofpoint-ORIG-GUID: 3BMfg1_RgTmXTYYQN2y9_SJrxvVBAAYk
X-Authority-Analysis: v=2.4 cv=cMXtc1eN c=1 sm=1 tr=0 ts=690394af b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oqcU3GVfJyNA89iC2WoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 3BMfg1_RgTmXTYYQN2y9_SJrxvVBAAYk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDExNSBTYWx0ZWRfXwbAn5wsCdxbu
 1MDLvCZgkS6bnJEqeeF+YHHi3xtICsgMO3czn7PSCLWeKcIOAzy0DslNPpyIl8wmgXtn5rua9VN
 tEDqR0C9YJlIaQ8zeYyFhJ76aCVmDOsWD3/0PKYJ9IVaCQlKQW6+8WqXbZDrTJQYuMx6kNpGc6b
 gamnWdnwnYtFYTi/h9DPZqcRjEeZisdU0uZvW+IFUXyIiH0nrYim5OEenKDpRfyGQ7hiV3KcLvu
 tGgVNmXbsIiDQlnpCPE6cMDyPFx+6a74MIFXOjxMJrC6g7X3Ir32zeMKINW1JpPQQMgth1bvu/O
 ebgV9pXRRVG/nvmrj5pERxxtLUn/P2uDdzr8bLwWw3r81npXKJ95SnTsxVgKtLyt7ApKCq4PMvc
 gUb/1IzeHKeKobwE89+ciLb1cqH/HA==

On Thu, Oct 30, 2025 at 04:25:54PM +0000, Pedro Falcato wrote:
> On Wed, Oct 29, 2025 at 04:50:32PM +0000, Lorenzo Stoakes wrote:
> > It's useful to be able to force a VMA to be copied on fork outside of the
> > parameters specified by vma_needs_copy(), which otherwise only copies page
> > tables if:
> >
> > * The destination VMA has VM_UFFD_WP set
> > * The mapping is a PFN or mixed map
> > * The mapping is anonymous and forked in (i.e. vma->anon_vma is non-NULL)
> >
> > Setting this flag implies that the page tables mapping the VMA are such
> > that simply re-faulting the VMA will not re-establish them in identical
> > form.
> >
> > We introduce VM_COPY_ON_FORK to clearly identify which flags require this
> > behaviour, which currently is only VM_MAYBE_GUARD.
>
> Do we want this to be sticky though? If you're looking for more granularity

Yes?

> with this flag, the best option might be to stop merges from happening there.

No?

That'd entirely break VMA merging for any VMA you are installing guard regions
into.

That'd be a regression, as the property of guard regions belongs to the page
tables which can propagate across split/merge.

Also, a key purpose of this flag is to be able to correctly propagate page
tables on fork for file-backed VMAs.

Without this we have to install an anon_vma in file-backed VMAs (what we do
now), which has all the same drawbacks.

> If not, I can imagine a VMA that merges with other VMAs far past the original
> guarded range, and thus you get no granularity (possibly, not even useful).

Err? What? It gets you VMA granularity. You are always going to do better than
'anywhere in the entire mm'. Of course you can imagine scenarios where one VMA
somehow dominates everything, or guard regions are removed etc. but in most
cases you're not going to encounter that.

Also again, the _more important_ purpose here is correct behaviour on fork.

>
> If you're _not_ looking for granularity, then maybe using a per-mm flag for
> guard ranges or some other solution would be superior?

I'm not sure what solution you think would be superior that wouldn't involve
significant overhead in having to look up guard regions on split/merge.

This is a property that belongs to the page tables that we're relating to VMAs
which may or may not contain page tables which have this property.

mm granularity would be utterly pointless and leave us with the same anon_vma
hack.

>
> The rest of the patch (superficially) looks good to me, though.

Well there's that at least :)

>
> --
> Pedro

Thanks, Lorenzo

