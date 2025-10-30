Return-Path: <linux-fsdevel+bounces-66521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641BC22006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 20:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75C91A25F88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782830215C;
	Thu, 30 Oct 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qbYRMz3a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F54Yn4NL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7181482F2;
	Thu, 30 Oct 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853154; cv=fail; b=XDqJ8gYIMchgNMao74eAqb2/rk3ibsxA8sHSAeCwBaubumxqrYrWaGgplhe9wE+J5yOBq/yDM/CJa6V6ei7vmUIX2KCuWeyNs1ta9WJ4TLSnFtnX6YjCMy6m8/pdj61rxdLVbBROtqJ3ECS7jNZO1cqxxE0Zir0QChL9UkPUK8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853154; c=relaxed/simple;
	bh=Ji6HzeYRD24Fj3TNkBTOQbbe4zU7xIsTulkYePhstsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UG++7JlpJqbkP8t6Cyzq6xPQ+tfIo0pOy+FBZKD7O12dG3MSIBCuWL523oL/vna/zBmd7hVcFwNytm/1qG4bVThN6h4l2U3uD2P2TWddHAqSe71BRg8VGylq7wateRF5FTsFUyo02w8/rd52LSn9OL/TM1tLFZ5NCWje79ijFjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qbYRMz3a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F54Yn4NL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UIK1ml025280;
	Thu, 30 Oct 2025 19:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ji6HzeYRD24Fj3TNkB
	TOQbbe4zU7xIsTulkYePhstsk=; b=qbYRMz3atOu16KHKYgmifBdAlgencn8M1E
	Qm7sCUiwGd+JlR9M4HJFTBw5mPGBVNCDXhD13tZtYv3gFKKxw9uVjMDjf1Q/bAt/
	Sv/EU6VDjKdwxzXAvi5OAizCr5HgJnnkJmtGSDad/0hkHBTbpOEREwRKWay0x21I
	z/q0KnRFu5P2szGpOJhxuQHku0Re9R40W8wEigepxfiwhr6KUHXhg7eelKemy1fw
	MnmEgI1Az2T0kE1FGiy0k7Kcof6fcUFkCmAVrdN7NyU9tf7jYj0gp9xkc3Bzob7x
	q4rf8EDSrwcRtCgcrHkmwva09rB0SgY6awubpwvci8GnJy1rqaMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4d6q069u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 19:38:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UIE6jR007817;
	Thu, 30 Oct 2025 19:38:20 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359vrpjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 19:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDoh3sU0LSMQB+PwPxYw2BJMbT/aqGU8olhoTb611+jYZWpAa+YOTv/AbhYG0FjjbTtjxH71FHg0qI8EuvV7RK0ns8TnLqipzv+Epakolxn8+Fnk6tIYrUpMunraph0KQ43NU+4LJsPeFoOcWN0Ar9rKeqJyBTGhy9gzNtPPlI94J0Ciy/XhHqpYuRXhOwhifa06sa1e0QpPY+Nphw+nyFtsqVrPLIbEobPCrknMz/D2sgbxjxEM7f4Qhf1MzAAf+SnHTryY3AzRQOC3l58ncOdlr8XW75aZRQYfsuK8Il3EsPgTZhKzHhofsnO9l+vqJp9pW5c4MNmYeH97sioXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji6HzeYRD24Fj3TNkBTOQbbe4zU7xIsTulkYePhstsk=;
 b=KQ80QQkRtBRhfcm1qlap2DdvlbAVo77tXynTOgOC02zRP12+pzUguM7PmJ2z5o80JrohjZL/wrGgW0M/t3wOI3G3HeLDd7Mn9AEHfqcYJWjMJ+SfuhQK9c0lPZ0YtEAgjNp1aL+XBbHrw7aNMnaXHWUPfI3ckoB8hxjMrsO5yeRU+3eUKsBO93bjJ/q0D5363zxgA5THDE7dkBfKKRprMY3cJIR91DkTQsWA98i2bI6wKca5Gb7qRuxqLhQTH/9jIZ6t90Yi/VSyCq301LmC3O449OCSINqaJOtJNyIEs5ejsEjM6c+DGEm5I8Ek7yxTXB5a9OqdB3PtPXJPj67t1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji6HzeYRD24Fj3TNkBTOQbbe4zU7xIsTulkYePhstsk=;
 b=F54Yn4NLSAn8jIj40SVv4dGx7vPKozf/QDGypZDDMvL2HhvLWykmyboqQ9Kyb16r/4CgW2Kv5nmA+ZFhonIcYPnXpdAOoOveHuFTL4qJiYSVc4N3ekzw/RI4xP7YieLZYfsX1avqJGSm0UYsEydTLZZwz1LDzE0pzPI7vmc+WJg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 19:37:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 19:37:57 +0000
Date: Thu, 30 Oct 2025 19:37:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <8f4ad5bf-cd5a-4b93-8332-bc8b306d0e77@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
 <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
 <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local>
 <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
 <6334993b-ead7-472f-bb82-bb7d6f15f3ef@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6334993b-ead7-472f-bb82-bb7d6f15f3ef@lucifer.local>
X-ClientProxiedBy: LO4P123CA0553.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: e011c7ed-3ba1-490b-dc0d-08de17ebd427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8HSUxw7Hudeg4UwgWZliF0IlcggVyLdb57nyAUDnsoq9ePFlrgdf0Dd6w/wC?=
 =?us-ascii?Q?lextZsIex0TyrfsQObmPSrR8viM8HFa7P25TMlM1uUd0ygznEkdmjL/G5voJ?=
 =?us-ascii?Q?jowLwowlA6p/hfPWO1XWcE9cZ7v2sBNK01HNULBdA4754iJJHiV4dx/iaW85?=
 =?us-ascii?Q?7N26HUwNLS6Jf3VjAhD4rv/OYFPOmy5GwVEYcczy+S8fVaVZhLgNF48boN8g?=
 =?us-ascii?Q?pmclv+RTl5j2ccvSDmcuOhBswhyaXpqSszsZW8j139imbEj81RKVC1LSPdgK?=
 =?us-ascii?Q?N+yyIzRym+H9xVyNPsCFUc/RQgjpNE8aJxagJaKqpmmLXpY+5mAKSbOg8+pp?=
 =?us-ascii?Q?B76l4OnttdfVtJLevSYfWxMzqBcA+2+hmWWM1KzZ4rx9s+awNWE/g3rW7m9s?=
 =?us-ascii?Q?1xnQR25/G0jwxaw0Djw7uoIfJqsrqr/dmoR1drGK8iEe1suOa/PfDMaYmwE8?=
 =?us-ascii?Q?eziroU3tS9WdhOYSQSwl9S9/KWHfwVeDZchnzbqc6MxMVZtjBQDL/XSjDslN?=
 =?us-ascii?Q?3wR9t9zya3MvXzVX2xrYOeuIPA5p/fQZjMWhPnO8/5LMz1OUfWNn7kXl9f8o?=
 =?us-ascii?Q?fDfn+RH/dn6brombE0VqSnxQjvHC9wPh9R8XV7n/VhG4xm4epPNUUtYtqy46?=
 =?us-ascii?Q?zDdZwLl1T72zJaOynOnNaoFqgbVWfJllipnEANxv05nLU3RKnx26a3FdT1ym?=
 =?us-ascii?Q?zpyPjopzar+PozznBBZH8mPHYU04e5jh/sz3JzO5uB8rY0X7UrC9+ErVJROG?=
 =?us-ascii?Q?1phch8EM5Fw0Ok5WpBNzpFk8OIZ3XWE25gYH3SdTBJmQcVUb0p3vXY8Eoi3Q?=
 =?us-ascii?Q?1wmJLhmdlOR3Uz3ikNkAyCLpxv9dd7aE0/0Fa9/l68mpvcnNiVYrFANnk1R8?=
 =?us-ascii?Q?9gj4VvdOHUW5qI4+Sz0OgIgKAxH+6KRz8EsXXBca2xddSGXUTe48Uj0HW/Z6?=
 =?us-ascii?Q?nbgwlYpBdUR1hOt58WuW8MIkx0nVDcMI57e/uL2C8wZHdZWNqJUo4WS+jPot?=
 =?us-ascii?Q?SmjAB+G39RgeE5/Pi8mPfT6bqjsIQaw4uB03iDIDHWP6r1DtXTDgh5yS9AtJ?=
 =?us-ascii?Q?jThZm6hWFtraHaYx1mPQsyg81JQAtmsl4aCCSq+8i8RO8AgcUaXRXRs0DeMw?=
 =?us-ascii?Q?dgN1g/NahE2ARFufWR4rpWcquIiaKZHptJgGXcRWFu5MxQ2roPS3h0W3HyZN?=
 =?us-ascii?Q?Z2XUcex+8hfWCfXGCDD6GSf+qbs4pSnPQG1kMM2gm5byW+0ZGNouALHB7/k9?=
 =?us-ascii?Q?/NlZsd2Nl3vPFpecvpexxod+1Tdg199vLm9eOk7WveIr4OEXQH3obzwqjJ3q?=
 =?us-ascii?Q?aIkXhMdtgccRgHZaNdPKeF/zN58exzg65KvVUja2l28GMIgPOVCLNqupBDX4?=
 =?us-ascii?Q?fw8cKmCXNlDi0YPFCxvKVv8LPG1Ei9JFm1Eyd/zpyzsXvSVQmiBr5nKNcsLk?=
 =?us-ascii?Q?k7Nfv/9a/kmKTRH5q3AlppQskt3+8cZk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IRslQZNQe+LCG0GJgBjV4h4nSTcAxdDhiFLdfimmulHOCchOd0LpY5T9suDO?=
 =?us-ascii?Q?zJa6R+uvVtp0VwKYLfrWYcCNjZ9BsQk3rJP5Wjaqzf3QKlwGRZSnPWzf9q1n?=
 =?us-ascii?Q?KAySgTlpnRfgFTKGv+rMNwTh4i8Eph7R3lIjadWh61pJC8+2CAhtR76SUskD?=
 =?us-ascii?Q?b4E8bFkM/qMpxbKqTAX66quHv1ioYMdAoLv3RHAOKk4wILo1TmmjBjTfifXy?=
 =?us-ascii?Q?UygVc5y4FNA9R64/UptfXHMo4LLe6izFlZKP73EFZv+pZ9H5S2yDVs39gKAp?=
 =?us-ascii?Q?YWMag/JE6LEOeiyrw5ae8RqMJuQDHLoDsW+eNP8Rfw5NXQ2StRpZAiqYby6/?=
 =?us-ascii?Q?KuzY3HV3XwmtwzCGpB+ZErooSPF5hHtjXAK+QkImLvduswAzqsZBM1Pe+3fT?=
 =?us-ascii?Q?SzeUY4qbzukIMOCsNB6zXFXF/EI1NrU1aDYiEXg9MllU2BUynx4blLGgOvFo?=
 =?us-ascii?Q?dXdy4Cf7oSoyEwx8kkEsN8oS4vrH12pgvt6z8a2TRDRoAnPVGhcAt0C6RzpS?=
 =?us-ascii?Q?kJ5OtiZRdPoLDogHCrFnyvDjkOeY2bEtQ/46KtwfR3fT0Mbtvym1fmV7q+L3?=
 =?us-ascii?Q?qc70D0ORDGy54TlZhoXhkoVOh0gi/iTTEd7Zqc9cPVXGemQB56D6S08dG0FN?=
 =?us-ascii?Q?6/T1x6iXjE+RdeWGEUDXcoGxA2hsPjcHlHv6y2ec8PQu3TD3QOIySDucKbm3?=
 =?us-ascii?Q?r4FhDte4PZhSpDyBzc1yiq//7fTTNRh0OclF6eudiLVJcmg/Wnd/YgP0gQcH?=
 =?us-ascii?Q?+2QJzghkCWvc9jK6YKVSvllOUPQu7rt4ISzHRGdn608gNtWlPW0Tg9H60c7Z?=
 =?us-ascii?Q?Yv+tChFoyE/leEm0thQn9YVSFh2mgsf9L5FHHWAG0vEh3DmFjbRU6uL8/ORe?=
 =?us-ascii?Q?gqKY4sSa2zSqAeep++o3+C+l/7zrtc/1u2l5PH0/cqkvK/CSV3O59y4hT98T?=
 =?us-ascii?Q?B7ypPAlVCCRJmJxQmK44WPCU6v2AGsvJNuUyk5mLVdR4UsFTW3wPSCLFMl6A?=
 =?us-ascii?Q?ObSsfdK8OJ3d+XpQpGqj883Eci7IVYsL+uAhAV7kcr5rhWzNLk9xTC4zwDF9?=
 =?us-ascii?Q?f6qw2EKtPohXYE8Touea9ZzqjDrdUGRVj+FR0o2jenE79K8Bp9X+Q8NHze3R?=
 =?us-ascii?Q?0FH3025b3ZvA8CxyA9c1MWxIoA2k2DHfvyoDv/f2Sm0KbA9LO2m/oMDJFK+Y?=
 =?us-ascii?Q?FY2U1PewYrvAcgEbmmuAOGRBK2IQXAys7LOG4c4t9um+KHuthaFSyCO00LOW?=
 =?us-ascii?Q?1vmit8B8gGrN6/qscXLVV2SltIoc98TkUwQs2um3fn31N8xEBrNUFXC/f9Of?=
 =?us-ascii?Q?RnbIOlfl0RHulWChgp2X1JBg+h5BByMUaF49DRVvC02hdtDxgoMUZ73kTodD?=
 =?us-ascii?Q?dyGcKqroMPutndPn8SKpJwDt6OyO+giOCUs6OnJ1yDPu+wmnTJuctXsUsfRZ?=
 =?us-ascii?Q?lOz08yxNFfjL0cI/DcKrkRCB8Qla1mFkIns92y1waqOWzyHXnTYhH+P10UWB?=
 =?us-ascii?Q?XrLxW+xzYjbUpPmNPuTHw2pZsxItnWVLexIWEWCokpndFp2T31ftxObHVtew?=
 =?us-ascii?Q?qIGs17Du/lYM4VQAK6nNa3q2YqkgZu26/S0jRWXHcx2SxLvFnoscN4lVqR2I?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bAQwNmoKFn1pYvi9MwvnfOZ9ZNTcd64QJKNzYQqvtQVNa7Y9g8y5GEWyjS17TtS8QOJY6//POxAGzmMcyjxdiJNSEcmcX+3A5cPl1uSPt3Ywfhnywz4dQxm3Uybk4ajB0mtRlE5BCQGJDod5hNZB9Tz8VVFThjZsVHyStjExhdWbkUR11r7jp56kTk3qDQXkcXqtT8ofxrHLGKtC3UxwcM1MKlpRwAoqCvcMU8OQLAuQEBpFFlduEEvx6WPU6BhF8grqgm+8qUym2qVTtkd1MPOgbbhdXWD63zfeij4xR1mNbifyBaFBvjTP1e+F4EUIEeqPUutERSfdIZXePl1QGxo96FXeRh+QVYSzv56MKmQwZQ7x9Yr5yGaZuJ7QbJJEiDf804kk7TjujzwVAWhtkDVDABvRuQM4kfURM+llTKaa5IBglqEZUEuqRpxCYINImFMxWCrtx/Qp+jGDK4JK5SvJ3RdCBm0EmNlTrpN4MQ2pKYrDj7aX7OI0Sh9zodHzRy8DqfpaLwfHELpd9ZRXG4Yeb2dmPDq+GrpwnPenYyWCbOXwn2VGH56NGR9eq23AokIfJvyn6E4vrn2+8AX3CvLjYEticaYtLZBcqgFP0YU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e011c7ed-3ba1-490b-dc0d-08de17ebd427
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:37:57.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKby9rGHLXysZczw6NounK+icgSwMgfsj+fA9Rc/RUZ3h/QS7QPRvlLm92O6VUgJMr1uJh78+vLQK7zGn9MmNIzgFI8hCMJ8bnThdocWhTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510300165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MiBTYWx0ZWRfX38trBPTx6HcB
 61MPap1D7RUcWQPg12UUhMO1oQaUfF5LU7E0FWRZdUSciY6IloRE0W3WD/CkcWw8AG0AjQJFBtv
 d6CDGWEBedYlC8k7fCacFem1fZxaQ5vQuo9tgckEBKbPWozsbc6OPkgCCstHHAYk493xhuwGd7t
 szBhhwA8q12EvcDcPPOhhAFchPU/9WHI/VD3AP2DTzqWju0dcrWfVhbPz+uD0T8/RLGYL2mqOA9
 jTTz+pZ1Hbhvuea+4Df/N122k6d86Im4f82ogiA2T9YSk0TwfTxIfHV+vSamiiY1zpA/5P8VELL
 Up26LENbex+aIi3sLQJ43SjSu/rrNUJoUOrtsNus67Hu6ou+hioXc+NBDY/Tbssjnd/xMnN1Dcg
 LzrBFSOkBnwa8SZOI8V6wvMsbHkdFXbzAueejhZxpxxM5WTYSac=
X-Proofpoint-GUID: vlko4x7sh_Uis-Egc8R7UyFrnytyOYqV
X-Authority-Analysis: v=2.4 cv=bLob4f+Z c=1 sm=1 tr=0 ts=6903bead b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oa5kyBmxqvc82pAFaiUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: vlko4x7sh_Uis-Egc8R7UyFrnytyOYqV

On Thu, Oct 30, 2025 at 07:16:56PM +0000, Lorenzo Stoakes wrote:
> On Thu, Oct 30, 2025 at 07:31:26PM +0100, Vlastimil Babka wrote:
> > On 10/30/25 17:43, Lorenzo Stoakes wrote:
> > > On Thu, Oct 30, 2025 at 04:31:56PM +0000, Pedro Falcato wrote:
> > >> On Thu, Oct 30, 2025 at 04:23:58PM +0000, Lorenzo Stoakes wrote:
> > >> > On Thu, Oct 30, 2025 at 04:16:20PM +0000, Pedro Falcato wrote:
> > >> > > On Wed, Oct 29, 2025 at 04:50:31PM +0000, Lorenzo Stoakes wrote:
> > >> > > > Currently, if a user needs to determine if guard regions are present in a
> > >> > > > range, they have to scan all VMAs (or have knowledge of which ones might
> > >> > > > have guard regions).
> > >> > > >
> > >> > > > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> > >> > > > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> > >> > > > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> > >> > > > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> > >> > > > operation at a virtual address level.
> > >> > > >
> > >> > > > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> > >> > > > that guard regions exist in ranges.
> > >> > > >
> > >> > > > This patch remedies the situation by establishing a new VMA flag,
> > >> > > > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> > >> > > > uncertain because we cannot reasonably determine whether a
> > >> > > > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> > >> > > > additionally VMAs may change across merge/split).
> > >> > > >
> > >> > > > We utilise 0x800 for this flag which makes it available to 32-bit
> > >> > > > architectures also, a flag that was previously used by VM_DENYWRITE, which
> > >> > > > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> > >> > > > bee reused yet.
> > >> > > >
> > >> > > > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> > >> > > > lock (and also VMA write lock) whereas previously it did not, but this
> > >> > > > seems a reasonable overhead.
> > >> > >
> > >> > > Do you though? Could it be possible to simply atomically set the flag with
> > >> > > the read lock held? This would make it so we can't split the VMA (and tightly
> > >> >
> > >> > VMA flags are not accessed atomically so no I don't think we can do that in any
> > >> > workable way.
> > >> >
> > >>
> > >> FWIW I think you could work it as an atomic flag and treat those races as benign
> > >> (this one, at least).
> > >
> > > It's not benign as we need to ensure that page tables are correctly propagated
> > > on fork.
> >
> > Could we use MADVISE_VMA_READ_LOCK mode (would be actually an improvement
> > over the current MADVISE_MMAP_READ_LOCK), together with the atomic flag
> > setting? I think the places that could race with us to cause RMW use vma
>
> I mean, I just spoke about why I didn't think introducing an entirely new
> (afaik) one-sided atomic VMA flag write, so maybe deal with that first before
> proposing something new...

On the other hand, it's going to be difficult to get compelling data either
way as will always be workload dependent etc.

So since you and Pedro both bring this up, and it'd be a pity to establish more
stringent locking requirements here, let me look into an atomic write situation.

We'll need to tread carefully here but if we can achieve that it would obviously
be entirely preferable to requiring write lock.

I'll dig into it some :)

BTW I do think a VMA read lock is entirely possible here as-is, so we should try
to shift to that if we can make atomic VMA flag write here work.

Thanks, Lorenzo

