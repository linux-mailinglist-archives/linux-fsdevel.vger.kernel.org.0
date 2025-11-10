Return-Path: <linux-fsdevel+bounces-67730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9578C4860F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FCFE34A098
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B6A2DC35C;
	Mon, 10 Nov 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HBUV4PYf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PB+i2EuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B92D9EDD;
	Mon, 10 Nov 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796266; cv=fail; b=nGYRz+UI3ATCQ9yQD8/iNLd28EOjH3OGnyJ7Z2+jIosnaZxkFTwRiSP36hIoLR5dZdyc/xtQxVYNtWE+Hv4F4sALxn5kdSMKPhiV5NwtFiCqrWz/hGBnfneW/uiKS8uBxEokkRxAC0Wa7JAycMbp5SNNoNm9y/dHIRvJcs5MzE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796266; c=relaxed/simple;
	bh=AV9ofmWEnxc+ntXUbO/6RXHFlnLAitWXZpMLlIIP/bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ULJXktUPIE79PgsMOkw79IDSWMEmqdfEZeiId8gtHh7w8rnby7gj435CLRh+SXaAgQp6Qfn76+AvKUWZz0M5y8D3hJ+sGLNecWO5FhJXjLEMdga2BOWPqEpz5jszUenFKjQOzrV4ANeC7szjG0tx4auy4ob5OEsfueH4g8Vd6lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HBUV4PYf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PB+i2EuU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHKPB2032331;
	Mon, 10 Nov 2025 17:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=O7tSotWkCYgGsvUNtE
	87ggjcD9BJ93HXMEWPgp/IeIY=; b=HBUV4PYfPbTzxLhEzlLKnNbKSt+Q0unNXW
	P65Om+5+PKfn6yCSasHIQJoplal0esRVAUJ3bFs3ZsbVtWHVvhVjNEifNpwad+6W
	7Tu51tufOzLnfNiCc8zVy5H0ktD/a4c+BFAj6Uq1K1BlZmcnUEoB6oVnCMwdzjYT
	DcBtpY7tPTmV9uXW8Xcr29RhBO/M953tcfd3Fr6y0yK24ERFa91JllfjWMiRUrR5
	8q/+WVsUCHuf3RTMvJLuZZYqYW27qcuHON11/VJtY84SqSVmNRsfAwcv59YyASh9
	/e7UaHsysOJKvoWxvXAkQ9Ui5ghUjysKDtyPUTTuWYX55DdQ2sow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abks7g53n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:36:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGqGaN009996;
	Mon, 10 Nov 2025 17:36:37 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaj79d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:36:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUAZGg0ygbENafN3jbWxD6zYuBM7qifbdCX6kmbQkX+WEJ4gTWb+mzHon1wLKVFjf87mvVumoRX+lfTy8ZvuoQjaJavQdbjCNzBGRlynarNtGetkSHDk4IC7CY/YwRoUY9zGcBU7SU4jvo/84DRxOz+1AiOZfLwtiAd8h3CPj53WLJlPBi1uU5qFY3jXy98Fg3K5mEHirvcgHAxmdBtfy7Biu3ZqnbzPUjaRrwdTZ3gkNg2tY2yldkQG3e+WQXwS0L13e2Ozf43lPQu/ZD9EKtAZ51+u0yafbQvrKq+zqFpV0GCMlKcQGtHz5HgnhCzRGIJx/gpJh/vO2n4uHs18pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7tSotWkCYgGsvUNtE87ggjcD9BJ93HXMEWPgp/IeIY=;
 b=fSBpgN9GfEREMR8tTQm5NxM7ZK2rkln9pEDOXm3lYw4z4/TQjVTqsyceymdrBwVAkftCIqIawhtfsIKTDLzL/5Q+fofKGOQP/iDO5IuRcjdSRRHia2xQyr9HKTffRt/mX0QBpRUuA+rD6KoGRXhwxSQ2kghNw+jvc5debfXcu0PXID+KQgFuTzaBeYBwMfKH1SDg2xXZJjF2kiSWvL09D76j13gpVWpUWvwnN1BOrucc5eCnokg+B8MRWgrMwBUgesPntvGy3jJWxpmRnPr+FBIRnf1WGEe2nrdHDAmkdg5nQAEm2yMi+Qv7P/bR+T7tlLQ8aJjPbQqKHQyS/cH7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7tSotWkCYgGsvUNtE87ggjcD9BJ93HXMEWPgp/IeIY=;
 b=PB+i2EuURZI92SOSjD7hShKqAQPrExwRzkht57Cmrv0CY/nRf+zkPEe5/1G5u6um7yOXO2JWhfdoRjp4vF7m5W8LedAHZGJOHFHsdiO1SWjRZa0OBEAGiIfaOTt72wytGx4Nl0Qi2NEBvGu4iG65lP2tY3n90OytbZ7kM0PvIF8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYYPR10MB7628.namprd10.prod.outlook.com (2603:10b6:930:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:36:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:36:32 +0000
Date: Mon, 10 Nov 2025 17:36:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 2/8] mm: add atomic VMA flags and set VM_MAYBE_GUARD
 as such
Message-ID: <00f05e58-b10b-4a66-bd6e-41dfa60ec364@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <cda9d4c073d773ef6c2cf2939d66cf80544cff40.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda9d4c073d773ef6c2cf2939d66cf80544cff40.1762531708.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0299.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYYPR10MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca53a2d-c53c-4f22-559f-08de207fb062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GRG7Z2oJwyz4d9+Td/p8K94dIkIw4ARwgEFLIDxUjATQu3S88IPgE3Cc2dfe?=
 =?us-ascii?Q?1Ax1I56dsW+PKniM3bx26Ve40OzCY4sGIVL+ks1MrxdxKnCTuiJ5jcB+vZu0?=
 =?us-ascii?Q?lULE85xJY8FZ+BWrUJXuQ2HN9eE2FI1jotfn8ytAyClfOPGLFK/Wmig7U8C3?=
 =?us-ascii?Q?ROk0aVrlVyebTMjNVrH1lE1E9Gt1aDUCP+moH6Dnk9JZt5VTg9pbe03XXGEN?=
 =?us-ascii?Q?bINn0Uco1Q6qe+kB9T5ehTkunoKYKP0iurPHZEcpuHR1zFKljMD3cfSkAu0g?=
 =?us-ascii?Q?r/gJ0MjOxPx484hxQRlTiivwVLt9pey5PR4K+HwJb5vXgqTTAZuyyDWAPUCy?=
 =?us-ascii?Q?dmiAbMr3i3jyPW+RJb929tUg7xKuY8thuxICj9MPyqBsy3laNejcnbDBFN9y?=
 =?us-ascii?Q?wVOpsJFeUiOlMkdiR8OpXRmr3/NRs7rDihAqyx6fwcVmKFd3nhfgmHsGpgVK?=
 =?us-ascii?Q?QEUNNJVgSNdIyxwJUhmMmc6BhwNa4LB/Zf5qmbo3genMjuyITmHfzVBBA5WX?=
 =?us-ascii?Q?ZfavZfu1r/sucenMGMvKICMeuEWJVcGltPqYMi0LZ0IcTm03NgWrUgQ1S4xI?=
 =?us-ascii?Q?LErk6bH33tu1cbW2oXB8+sLP9G40Q++igmIupT0iQh9/08ne+rbPvTzAZht8?=
 =?us-ascii?Q?t4pzkwDFcmrLUe//xRabxnlvEXqlMZsNAr3ich6wMuvnZdVUJky/+LJUvQKP?=
 =?us-ascii?Q?YBmHWsF617EGek4SXy5JX0ya5yVGSJdwQAI0N5D6bMXMjFoBlvvzt+cTQ1Nn?=
 =?us-ascii?Q?dqZkZ+HulEomkxvXKvrDWB1YvHYbQnZiZfGS7hwt+v/aWvyqCiU9GsA8I1oN?=
 =?us-ascii?Q?vIA+18CtcU+8xlqGnzICMRxeuAzEgu6U9EAqk/YDds1JdjdezgY1H97iwCtm?=
 =?us-ascii?Q?3jh3bbb52CgmwhZcI1qmHW/ffwF029X/kSsMbONXjf34AEHkX7ZB6QvFUVp2?=
 =?us-ascii?Q?sZTXURC5vCitc1RNG8ddPyhAxgrZW4acc4ddT7PyhX034uXm6QI4e9QDmrtu?=
 =?us-ascii?Q?WL4PylYlFnW+nAhJXJdJY70qAULrtHP6sPAB389+A/orIh/2cRS2Nols7Ve7?=
 =?us-ascii?Q?GqwmdlYSUF66M9zFpIInF8sJCpc9Gby+rqfyjNvRYJJZ/a3QH/WqcOS8xYqb?=
 =?us-ascii?Q?SYcp03B5uPHxIUPwi6kb8eHKho7NGIXgl6OO8TLPpNECKWh/gIBYmplgc1nh?=
 =?us-ascii?Q?AHfOrJbdtFwztmclMJlbZmtEbDklulxYBbR36OSvtR/FPC/s/1pWK6d1bc4G?=
 =?us-ascii?Q?CSjmGieg1KMeCyfodk5eS1BgaesL+ln+iCwEioxC7LWOjgQtMHMG39rVLob8?=
 =?us-ascii?Q?unwjxLUh0wCQ5HH1PQwcK6P8yH0tP+nYgIavD01rwuzdCNPyE+pRn+tMw6zX?=
 =?us-ascii?Q?9c+WNckPHw6Jm0ifrm32XbXa7Xu5OexwusMKXIUgsxzQmc7McmdZqHfdpczz?=
 =?us-ascii?Q?C4HLidhPQW2zCeVKbcNPBDyCHo3hO6JA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBAd7+MAaAxrgNfbmM50ua89s46RyCvBbESty/20VZJpRXiUwx6Qx7uQCQlQ?=
 =?us-ascii?Q?WuLx6M9UjROqZNutoa923kGzTW5wWJ+T7CV5rewXCN/8f4OU5LiTIsKQ6Flm?=
 =?us-ascii?Q?8sVK4IpeZt0I1vO3tw+W3EZTuXRSDMQjVGHFj2f/Gkel6A6vRDR2+uEVob3o?=
 =?us-ascii?Q?T6EO2atn3IK5pyluPgioQtvC/9tFtsXnWUBcX9GMelmRbw6KqECYiUSWvbkB?=
 =?us-ascii?Q?cFYhYag2e9pCkRdzXsyepldwuSgdFbsx3QIYxRKvpD9NpTUYq0wslZ+rWDd0?=
 =?us-ascii?Q?cG31Yr3Qp8Deg+EdT4XLoQ5OYzcM3xbwkWHYG/tWZE1/TG7OFeyTBAyZnzqq?=
 =?us-ascii?Q?zMxtMkQnZFB+ZDPSU75D09vV3hSS7HUFuiCp5fwFUhBfDIFaFgyHhfVCg/Xq?=
 =?us-ascii?Q?SvK7mhHax/+4MmC/uS9+8NLUBWqN66rByhuu/lOWuq/ANv1y5kefR+BJxngq?=
 =?us-ascii?Q?sC+Qt1IpsYMc6GFr5pz5IuyYXzfBOtGoMlllyy0Xx5cUEWagki/T4487lu/B?=
 =?us-ascii?Q?U5tQXTeisgaVzdZEyFqCmULkf8H0D4gml/BxeRMw0SjvjUmC8G3sQ/NOlQCu?=
 =?us-ascii?Q?79XKGj8Y3i1iNmR3w5tJsATwnIOCdN8f7TdEECozVQ7ry+sbSDfGi3jZm3EX?=
 =?us-ascii?Q?uoqOhlZ3fuINsqxpSdek5kZ+VcePdOyeLSmLypjkAa5/jIhGrLT4SA1iTbh5?=
 =?us-ascii?Q?ZfjS0PabPsGcMRBMevjDpg/Jj86Y6NT0rErxXgdYXD9JmFyiRJHa5l0z4cvj?=
 =?us-ascii?Q?OB/mlDHZq2ULde0YTNTtik65gCQswqNMEuExjcTN00qY0PBv1o6U9noRKncJ?=
 =?us-ascii?Q?VFqCOv2ml0fUE55pQ8IZJw6McWGmYHIa7mT2YDn8f67RrIhHy1mRzsjwqx1X?=
 =?us-ascii?Q?cCaW8itnNit2aNFQWInq4KqmXGd0OhszRSzGAvjt+6sPx2CHOSmlouLlhNfe?=
 =?us-ascii?Q?YrdsItwjdEFhFT5rllZBs6H7tCkJ3liTvFOwK7Qe88tYkJQ33YrWH2IiyYP2?=
 =?us-ascii?Q?VvscTDolCdMAcALpjQ3sXYvM4YEADzp4/RAyD2WFw30hAkzkDlYgZg3vKmVR?=
 =?us-ascii?Q?mbLsfK9tBiXaOeToNlYvmupPDDDyhk3TV5J8kLR7vbTl2SExT+4H48bdryXJ?=
 =?us-ascii?Q?VCFupTLqa1Yi1OCiaAwOEkmSjG3gjSR4wiQmUHjL7SqkCoYkuU/15VJOYNty?=
 =?us-ascii?Q?6WW/wnfq0yQKAhA5IuDSINZ0HvHXgiyS9cpQGj1vT+k22jxHH0YhT3qPsrn5?=
 =?us-ascii?Q?PRMoYDM69KbURYUm97+Tqh/nGDkKicZj6nhSDr/5yyemUbAlMwIHPu1KnaDW?=
 =?us-ascii?Q?CE8fgxoakef+1DA/Df/PAUWcW41Itkv6jX5bz3/BbC1n/+EP/WjA3/6u+QC+?=
 =?us-ascii?Q?EG9lFGvnznltlEDtWbVg/+jv0Sn9H8Nn+HWEtoc6eDwUiWchPCzsirY14aj6?=
 =?us-ascii?Q?F4SIX3cYOhX0fLHKGmqBLDWhY1j1gNAEyWfB3ZHwDVDuKkDvqfU5TPEOVpNw?=
 =?us-ascii?Q?+ZDO9pzE8RfyNW6RaB/xVC8RNwYv0AOrE92r+S+jXeE3FhX5+4eFkr13dnH5?=
 =?us-ascii?Q?Nvs3MEt64FrTA8YDFMn4unmtnsGaBzRdUSVFynP3cPJfxM3qikYYip2UCfmR?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7FWoQoFKiyf3fNa9P62gVXB8Vn7+jcaXrv9F2F836QH4Ifuy7h65Q92f5MKvN/n8InCKIKIMsygZbI8agaFe6LztwUqk5GzlTRqUbReb931NPJLRBcy6YN6qTWJFJZJq+c5MOZr7lUIpNuUUmUc1q5vQMO000XJyu6df+4BGPxqYn4/gXjLPLbVKxabCRcHcCa58wb6UBBxj2c+USITV1kxtx2eQN9921wvT6rR0KVrIhADH9GIjCW01fBBw7z36puwQj4PARF2kfNpWwapAVm9zEwbc33/RAjARg4PpjbdqFTBQD9sntv5dVq+mSrfxCabt2qPvGMcFlTXxCfbj8DpffrQOk+kxp2RVL6AqFHJo6QFHPiL0F9o19fXfN6cQbygRvv17Xs1cMC5lS6bdiTNNfL46sgDkUNFTZhpu+AdbtUNMPB6v+b07nUm8SvQkUsIN0zIi/zGSpfzGrJTYSmasKKTOx5u2KISP24q2wFUEeIow7kPCvjz6H+Mk5MpDVGGFUX08wVjNTouYE1AL1Vdru6AFNyBQ21OpP14OwDnVvuG3/RWcikzR36KZe2p8NFE+KAwbPqDi4+UQVmcv6+Mlxp2O9HNCZGQYlNhQHUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca53a2d-c53c-4f22-559f-08de207fb062
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:36:32.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICNM4K9uYAIh7F5ri1W7wztZbajO0k0a2WiZstpKCHHi7PQA6wrlFQ6CTUulLzk6ZlyY+5H9IiPx4YLsJ6F9uPh1vdQsd3JpfsjVFlOmTac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100149
X-Proofpoint-GUID: LlB635QRVt1UWFFa3gaYQIvWn7i64vwK
X-Authority-Analysis: v=2.4 cv=L7cQguT8 c=1 sm=1 tr=0 ts=691222a7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=79OMsJgxcdRaD7QnqNoA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MSBTYWx0ZWRfXywrKZWORZMvM
 FZi0g4/cKvrDCCeq+JylZFpuTlZY29C6WyvngR25/Q366xLZk9FDCU7N39KSzaZzcZ+SX+eyyKG
 chWAZPnYC06oV3+5yqEiQm+nyX0gjlcUooTkDjAnFLOhPkF7iiqBGQ5RnGBvv+JHfcUDuYvYkXR
 oTUuQQ+lLUVW6RNIb4LLR1drQntTkpX9wWoOpxVh9YXzdIYu/POwuFCEjEpdQlq9HPvpgAh0tmQ
 iHWTsIgEygWgp+NL+rmreR60M1mK9RWQAn02AqhZlDbCWiH/vQF39UgjMWzBSNnLJnVOxe5QOSG
 4LHSjMhJTreFwFkAOlqaftj9ptzcSIdcdly2Vd4zecuwBftTmJbaTwy7Ts6w6YJ8JBPkxyTZIA9
 p47PUuncFU1WmUcx/Va1dIuOCgap0BQGTuwfLI0bjdjqj7ncFwI=
X-Proofpoint-ORIG-GUID: LlB635QRVt1UWFFa3gaYQIvWn7i64vwK

Hi Andrew,

Please apply this trivial fix-patch.

Thanks, Lorenzo

----8<----

From e73da6d99f6e32c959c7a852a90f03c9c76816c6 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 10 Nov 2025 17:35:11 +0000
Subject: [PATCH] fixup

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 699566c21ff7..e94005f2b985 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -900,6 +900,8 @@ static inline bool vma_flag_test_atomic(struct vm_area_struct *vma, int bit)
 {
 	if (__vma_flag_atomic_valid(vma, bit))
 		return test_bit(bit, &vma->__vm_flags);
+
+	return false;
 }

 static inline void vma_set_anonymous(struct vm_area_struct *vma)
--
2.51.0

