Return-Path: <linux-fsdevel+bounces-68925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0CC68CD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B29E4EA5BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61B34678D;
	Tue, 18 Nov 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iolQeH65";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rOBd96s8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15D33F8B2;
	Tue, 18 Nov 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461181; cv=fail; b=XFWmPzq7fudgsG31DqB408fgeH6RDMkZLEqxlZEyBLAFF3uEcfZiz48zns4tO1Ox13ApssKotC0s0izHKmDY+gN9218aro+e+dIOZAOIAfzZg/GLS5SMg3rT9G742wlM9pR7TrwFocJA0m4pyQ1L7vhvOAZyaK8pBONR5+NXCIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461181; c=relaxed/simple;
	bh=geLtrW22BvPJKsPgl4hHg6rdSomU1hs68hzuj7mVgOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4pJWXx8INk0+biNKQBSrdSdkrbOXoDj60k8qWab8A4xKx/enbXIflCskS3Pr70ECiYJ++7sozM1xe1ZjqFRc21whoDNIDyaYDbqijEHZS8zDVQwzs5Zr0CX50yDUqvmPt8NBhviz5K1TPj0Vrhyo9CDapKNRd+asSYI0aY1AWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iolQeH65; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rOBd96s8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9D0Zv027166;
	Tue, 18 Nov 2025 10:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dhN0cw2MkNAa5NhIo6p0CINErscRVjVYz/rtyQaDjwI=; b=
	iolQeH6513Ro4RYNNcMk4dm2ANvWod53QcceD68EtGxe6SgcD8jmV/SlkAc+ePLA
	4XJvAW0n8NrhsUvnlo46emKzP140PitvD3Szu7mRoGCTNEacJm94OR+rh+4fb/1S
	HszqfJ96m5m8gkGptSSprcSsuWMR//PZ8RDt8XRphzGTL2M4SPVNVrsMKw37lcSW
	uCRjF1ei3OYLqK0zwjMLcrxttWiuasg2lLfaUiJJ6sLJlkJzy0GQAyN/nwa+0wPI
	d84sw4j1KZodArEXyIiJ6GOw5xTRmZeaDl9P2VqcBDzinNsI/aGK9uxjRKEYXlGT
	RqQvKOJORygHAh14LkBDig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1cgcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9NsrW040040;
	Tue, 18 Nov 2025 10:18:39 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyk8qpj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4THUG1iLpfvb/me6J/DKHmhR7T69IzE/yPZsjQkGik0EgZqRPUrnObVsU946K06FaFSFJVWcjyBbJGg3TaBnN1QH9FKr8jdgeqmG+V0EYFHvnai9dSDn91Nk8bl0k+r8IHBIOEJASY8Gbkhfn9L2OoXfeSzFBOFMslSI2rRVgwW5lMLa0oiwWvlaUTkcCxgbR98qcEoueezXujPCR4QW+5Qu9ocTRFB3djSbvVXjrBWxlrgC+7UeAcGCej5rzucP5h8GK4Ov2WV0tRTt8fklbupeLHYVNv5fwB06MD4K828f1OyOBGEprFv87Okx37XxWp+FDjsUyCAhJsRovBmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhN0cw2MkNAa5NhIo6p0CINErscRVjVYz/rtyQaDjwI=;
 b=NsxtbWc/lqEaS/T48+rARPnU4NihezG3ALbyWg/k+KSM81LFlVm7UhrtpJgdjJQ8imRskzfJahTm0eTXgfxVCXx+re9zXzupFjVefUaB6hD5W0XPMCMIr+yk135KcnjShJN5tRzoVD4jBguBk/XeiglPNrdrBjdl0fMJr8PT6TrQekuqILO/J83LzAM6QlJlMlXn4cGwEHKdyZyPTyu7PO2WkTjbJKr1vNDlBQl7yIf3iOK/NUg7t5T9GKx2/SNwfXgqkkSRwMtnqgq+N9daTqkV2U7SrEQr5CrvnIY0VSBkRYW4XnKujO4q9b0bW+RVHlrjIB3OlnZ09OIj5xJ8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhN0cw2MkNAa5NhIo6p0CINErscRVjVYz/rtyQaDjwI=;
 b=rOBd96s8YXXJpbdcfHFQ+FCxSdi2beXQJPmhgdcUbnRPR/0pnfmOHTDrBMbsPkXoT9wXK9bzxg1SIEF4ZHR2QuyAMFLt/9HR1/FDXqUPAW5bOE1Z8uoFehqE4oHSSZt7olzZF4Ldq1btu2wggDuVyAm/LCKiYcS92WxmQc+16nk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8756.namprd10.prod.outlook.com (2603:10b6:208:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:18:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:18:29 +0000
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
Subject: [PATCH v4 4/9] mm: implement sticky VMA flags
Date: Tue, 18 Nov 2025 10:17:46 +0000
Message-ID: <22ad5269f7669d62afb42ce0c79bad70b994c58d.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: cfde6300-7dd0-4e88-7b36-08de268bd174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?++gKAVomyLQplW9BZKidDFAz+4Axt/u0JwY5AQUZCflC9N27X9Rw1PLUiZo5?=
 =?us-ascii?Q?bSb/FzHQCttXKfg+ll4Pc9Hszi+kCq/bdvnuORDFYYTjtOY+E7q9NgATwXIA?=
 =?us-ascii?Q?Jhp048l44MRMLzZMcYKOSA34X7e3WPCWCIGnPcGAVvLSQiKyNhxWVPom6NkB?=
 =?us-ascii?Q?s4uaWexCXUX+JGblbI1lc89jpTdxrLRpTIqBUjdwaqPMgKxBwNxt0LCJKmQv?=
 =?us-ascii?Q?kgviU64R6LmMqm2YWvoqQLthiK/o1dxvsWcHjq7ywZjSBW5fsX91bMXocqBk?=
 =?us-ascii?Q?VOKRDbylaF7bERnUEO9BRhLgtJz+XI9YsGwCfJmK+9eFCWO1lBWQ0CxNHRRe?=
 =?us-ascii?Q?pZRW6uFMsLfRkCcREBtTXZ4lzDpwk4uFWhJXcEbfWkBQ2t5wv3dZ1B2wygch?=
 =?us-ascii?Q?O8uxfNn/JGLk1SmuL0o7Wrgzaa22qxyUqUJQOWp7jKzhUATLlpSgRFYZQy2/?=
 =?us-ascii?Q?3CNTCrID6hFQ5hW0rdQXd9NbJn9+G1UKzO7MJSzHUzirnrd8qjJqgCmIVZFd?=
 =?us-ascii?Q?LibixOu6k3yDZ7wdNRQF8GhXV7Axt2NoM+h2XDiClVMhAJ3fblBLAZETWzgf?=
 =?us-ascii?Q?u/FqCUGZK9NBV/iMuuqFOPcVorhTAbv19G8Rs93eOEHpstQsz/54zclV/SE5?=
 =?us-ascii?Q?E1MqonCvXCsFTFP2A6fsyZYX2VEYMAiJQb7CY4xjYmb/ZglhdhVkW/opaGzj?=
 =?us-ascii?Q?lzt/fJXdtrsz/nGaU663K/jO96w+Lqg2My8iA2j1oxT4jjMOgxce6hAMWy3g?=
 =?us-ascii?Q?1LQd0H2zoMEJoDliQVyyxWvDBLmmLNk/ApvMLuNB4BfU4pu9OAKRI2pQcO7L?=
 =?us-ascii?Q?CeheJdntLPxSR7ePY9FwAjL/R4mobN+sKcCR6w3+aFvSa5VWgoth7F6dPD5s?=
 =?us-ascii?Q?tu2L3EJHXIugwFu8+JzTRgVRPWWcp9gtCF+Hg1gWeQuL1NUuUZdqVmhTuboS?=
 =?us-ascii?Q?7RtQMgST3q2Wqsa7qwqHmLDArIvLE9j0k86InB4YaLKOwUE5ncXZTqVygrOF?=
 =?us-ascii?Q?sC6egabbre+lbUPu708XxAQJxT7XTsb2WY6TOlFeTVSe/5/lB1RQEWWnQHvr?=
 =?us-ascii?Q?s9qXL0SkBj8Gl56+fUG4ExvEVqTzCkis14SjrHPgnIqWg6y7fPfH+WGOIgc6?=
 =?us-ascii?Q?8maC9k6suCkrXq79rdAYPbuYfTeX1iXAf97c/uH+YoilxT5KFDfmPWYaetxa?=
 =?us-ascii?Q?oTVMf25Zqe7kSj5XaRdZGO68wErX24IQxQ2vf4ElECk6foJ/kcIEH3pIJ28t?=
 =?us-ascii?Q?q0Aapc0To4bHgMpGBXYQf7DulmH3vxhOdynLYCRMN1hpcHH9BYdbAllvv9n+?=
 =?us-ascii?Q?nkporlYSSEJ+vFtR+UmsGx8tDVze4UakpDR0CgoULa454+QdPBstr3z2i9+R?=
 =?us-ascii?Q?b9dWyanbV2UYsN/DehQv1ny86JwDJMTI7dkzgaIPPa4Uhhy16Y/vIG1UbE7q?=
 =?us-ascii?Q?C78PA6scCGK82GVOkNAW3i2kXEtJKEp4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5uWJsLKVoC/f7lCkTAxskj2IhlsfkbVUeJDrkvTZ+y3OeEAc6icpv0zcliFN?=
 =?us-ascii?Q?vLYa21hWLPvxlFSumozHdGIrbSyEE5oQrdOMg30DfUY3p8fyfpXG4vCi2KrO?=
 =?us-ascii?Q?ZIyYan0LJxS7GTPlDZZAQ0z6NNAOUxaUO33b+as+v63SdA6jaSDzxIOA+Umr?=
 =?us-ascii?Q?T0yVFyduIHoCB/xlVk6KQLVGmEZZM8tzWO+QyJPHPPEB1V/67HR7l8WIEmiU?=
 =?us-ascii?Q?EzkKufa2X1C8M5unHbvEg/FRCik2u5HptpoiEgpgYP7/N5cO+OOTxVftOFTx?=
 =?us-ascii?Q?Pcf2qf6Kg5VT87mgcZlrle67sFQm+9cHtZB+wBjblNLm2XpsuMJRoAuVhXEH?=
 =?us-ascii?Q?yB3VVCZaTUdmWOfSAnf4IrcULnXY2mbSc0A1g1cA/ssawi9qgmDmDY8Jinac?=
 =?us-ascii?Q?syeBlXe+edP6Duhs7TXI1v52taTNjnBzfiLllLC9XokQydcZ6PHiUirKpg4W?=
 =?us-ascii?Q?d6uMoFfF2ReeeBaKwTorv/ULPmzhqiHYT3f1W5RWhXYizC3BCJ9YNCHjTBXL?=
 =?us-ascii?Q?KZxy5F+zZIonM5jQb2+/gLFPOTMFMkoo8NwQuUa9C2OwcX40GYcunUjEhJf6?=
 =?us-ascii?Q?8ifuhlz+xdYjvv6p0QIT0d0olCuGLTvTGLUMb81jbQle1P+wG2QOQMjHNSM0?=
 =?us-ascii?Q?IWmgNcRId88PGRjNi1PJa81d0I4DwokVMzdQ4SkEJ5nrZaI9qhVC/sYtBAxY?=
 =?us-ascii?Q?Lu+U+AVZjaqtmJsERBwmxVyiBn5YsgDiO3FVoir9TSXX7MrH10fdjkyzoX9e?=
 =?us-ascii?Q?ebIHWEEO85tsx5etjJSz0/rjV2ErQ3ynfVQyLO0fWTMGK8Xvno/jmgp9hMFm?=
 =?us-ascii?Q?F//RgwqcOVKF7Qa8GeuOleVvef48aW8eZp6LtI1cALaow3GpduZICoet3ZlU?=
 =?us-ascii?Q?T9WHoPMboGcgxjVgsPXj21MMoTVqHlYd70A4TZxOXGq6R9MTRYKlIuKo7Mut?=
 =?us-ascii?Q?2WXwha2z/pQSf87nScGEd2G8zakkOLXUFnOR7u+BJPLeHAYNWJjYPvLUVpMy?=
 =?us-ascii?Q?MzVzWp9ILDLMv1xDX+p7Kc5EipEF9LdsSfEW5R5jOQ6kivRc7qRnF6anZQzo?=
 =?us-ascii?Q?bPWD2iiQ3X2ykjGPg8NRQzZ1LeWt5ucYfPWdE1u2bwT/aNjLOO4B3DUYZyVC?=
 =?us-ascii?Q?43O3FCmhaT6CjGwxklPPEf+8khQlzLoV5HAv0c+7HhRR0vULWBQ6vrV3bKl8?=
 =?us-ascii?Q?DdGMKMcjvkelpL4KbofSf21u07i03YHEXcyYF/WmkEDAO6WGhuwTW060G3Pm?=
 =?us-ascii?Q?6591tsahHyd//2HChu9tMplW4vOdn0S7PqYYzubfrjpZ4ASl8LBD1Z4q46Nz?=
 =?us-ascii?Q?W8c+m2CetsdGQXauMo65jnHpGhIYwWWQ9eVZNZGE2qPD6TFTJ7bWE4/qiqby?=
 =?us-ascii?Q?8K+bKS9klOfiWQCa4OWBMHNSJyDmrgjfj2Je3EngkyoWWFt2QdXxiHl4Y3ki?=
 =?us-ascii?Q?kkTK+RovK0RLSzgFx2K6q/ClsDK/rh4r7W+K+BUfzlD97AFK1WE+e329HUSX?=
 =?us-ascii?Q?E1GJtBojJ85ZRkkeaA5dEb03rZKk8XLIf/PFqR9jACwHYSztdOA7L7ufqcfC?=
 =?us-ascii?Q?fbY+8Z910mFFU7gy419Dc74IKW3iN+i8CcARFjBI6qkVlBom6ROfc6k8gdJS?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Aur4fs4HLaCAdO5TAIdjUOAX3FhNSH3UBBbCrwbHF0scl3iTFcRKPfl4YLsx6PmZSzDflroeUWlSQ/ESYsscHfTCimrgeE1VpdshPENtp5DdcksEkLt1bZIgOOr8uwSRqkC50yyU7YtBLpMUqmaY69s6AsBJs6PE/7TH4+1pI6tXOxaMi+XunrxAyCS4BwsUsvwP9TMRhQ8EU0oK/80R6TjkMHOCIIBlM+fGqSYQQk5LzOIC7hnCHe4DGdnJrsQrIOlUoVJOdPXhpAadFtcEGnXrLsEQXFSzB28NBFjkl8T0WrIsgmRA2I2xkAe9Q4uc+37dumKvZXye9WAsfaWYa7kKUboRcpPLLJMSyk3AyW+fBk3hjUfr/q9RY1RDpeTMF8B1qJB8/P1A7kipLGDQNqYpJwwGIPxFxi5ChnBV26FmeEVYGEvAreLU5GmVeY5a/lNA6WoSRQ6Lbw3qOps6wP2BxyEQ50doFt1ld6WL2FD19x38M7AwSo+0kc6Q/Vy15IlZ1NpABr1XZSn474h9iRngI7s5hzQKBLYse/7vbku5kG+XdfE/bdLlcTEBspqPjg7KfnjLOkWBvyYCKHvjGdg2/zUtrC1TA0D9QXFwL1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfde6300-7dd0-4e88-7b36-08de268bd174
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:18:29.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzsfRo8KPO7AMnVw9KPKFMd8ePLh8vTfL9lTKErmVFg6e34qVcHvJQp8z6dUSEYuIc6rQyzKDbeRpT+YExqarARRxxasxKA7KXLYR0n2OI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511180082
X-Proofpoint-GUID: DNFPtyyyJptgHjogJZKm6_LXqzolR-Xe
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691c4801 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=rpsWnT2a9RKTKGOQHl4A:9 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX7cyRBhWNbkwJ
 vBEXyOYRMMj5bYR4wBGef5q4k8btaT/sphA8OKjIWvNrF+Io/z504VdgPO1bkAit+hDT1arzGA4
 /gUb1xODwaU8hE30qs4WBCiBa4pJGC0QcyJtz4y469u2vqfYz3sE7gQb5TUe0O5tmZPvXUDdFUm
 y9fKbpTNvb1SHBOszjqMo6z/Byad1wb5jZ5Kau9TMMRXQGcY8jSu68bNPqgmwDinZ0qpWkODrWt
 LyXL9B9uUxmh46cfqoYWJX26rPqyQhUsE5pflxqiE4PZCAeQKPAu/VgX2QY7mJo75UkBt9lsq8o
 DK8O/AyN0slAE0u77zn+DkPNzc+dKUBeTO5VRfBYYakB/2IX8iG3jlUG/CkdKqmAnUqw/7weghO
 MILGPOpW41lb3i94lw/vfZmOHff0pmKTJ7vSISxwNjdXN9dhMeg=
X-Proofpoint-ORIG-GUID: DNFPtyyyJptgHjogJZKm6_LXqzolR-Xe

It is useful to be able to designate that certain flags are 'sticky', that
is, if two VMAs are merged one with a flag of this nature and one without,
the merged VMA sets this flag.

As a result we ignore these flags for the purposes of determining VMA flag
differences between VMAs being considered for merge.

This patch therefore updates the VMA merge logic to perform this action,
with flags possessing this property being described in the VM_STICKY
bitmap.

Those flags which ought to be ignored for the purposes of VMA merge are
described in the VM_IGNORE_MERGE bitmap, which the VMA merge logic is also
updated to use.

As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
already had this behaviour, alongside VM_STICKY as sticky flags by
implication must not disallow merge.

Ultimately it seems that we should make VM_SOFTDIRTY a sticky flag in its
own right, but this change is out of scope for this series.

The only sticky flag designated as such is VM_MAYBE_GUARD, so as a result
of this change, once the VMA flag is set upon guard region installation,
VMAs with guard ranges will now not have their merge behaviour impacted as
a result and can be freely merged with other VMAs without VM_MAYBE_GUARD
set.

Also update the comments for vma_modify_flags() to directly reference
sticky flags now we have established the concept.

We also update the VMA userland tests to account for the changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h               | 28 ++++++++++++++++++++++++++++
 mm/vma.c                         | 28 +++++++++++++++-------------
 mm/vma.h                         | 10 ++++------
 tools/testing/vma/vma_internal.h | 28 ++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 03776aab3837..fea113d1d723 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -527,6 +527,34 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
+/*
+ * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
+ * possesses it but the other does not, the merged VMA should nonetheless have
+ * applied to it:
+ *
+ * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
+ *                  mapped page tables may contain metadata not described by the
+ *                  VMA and thus any merged VMA may also contain this metadata,
+ *                  and thus we must make this flag sticky.
+ */
+#define VM_STICKY VM_MAYBE_GUARD
+
+/*
+ * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
+ * of these flags and the other not does not preclude a merge.
+ *
+ * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
+ *                dirty bit -- the caller should mark merged VMA as dirty. If
+ *                dirty bit won't be excluded from comparison, we increase
+ *                pressure on the memory system forcing the kernel to generate
+ *                new VMAs when old one could be extended instead.
+ *
+ *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
+ *                'sticky'. If any sticky flags exist in either VMA, we simply
+ *                set all of them on the merged VMA.
+ */
+#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff --git a/mm/vma.c b/mm/vma.c
index 47469c036a72..4e21c988054d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -89,15 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 
 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
-	/*
-	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
-	 * match the flags but dirty bit -- the caller should mark
-	 * merged VMA as dirty. If dirty bit won't be excluded from
-	 * comparison, we increase pressure on the memory system forcing
-	 * the kernel to generate new VMAs when old one could be
-	 * extended instead.
-	 */
-	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
+	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
@@ -808,6 +800,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
+	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -900,11 +893,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (merge_right) {
 		vma_start_write(next);
 		vmg->target = next;
+		sticky_flags |= (next->vm_flags & VM_STICKY);
 	}
 
 	if (merge_left) {
 		vma_start_write(prev);
 		vmg->target = prev;
+		sticky_flags |= (prev->vm_flags & VM_STICKY);
 	}
 
 	if (merge_both) {
@@ -974,6 +969,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
+	vm_flags_set(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1124,6 +1120,10 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
+	vm_flags_t sticky_flags;
+
+	sticky_flags = vmg->vm_flags & VM_STICKY;
+	sticky_flags |= target->vm_flags & VM_STICKY;
 
 	VM_WARN_ON_VMG(!target, vmg);
 
@@ -1133,6 +1133,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (next && (target != next) && (vmg->end == next->vm_end)) {
 		int ret;
 
+		sticky_flags |= next->vm_flags & VM_STICKY;
 		remove_next = true;
 		/* This should already have been checked by this point. */
 		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
@@ -1159,6 +1160,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (commit_merge(vmg))
 		goto nomem;
 
+	vm_flags_set(target, sticky_flags);
 	return 0;
 
 nomem:
@@ -1654,9 +1656,9 @@ struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
 		return ret;
 
 	/*
-	 * For a merge to succeed, the flags must match those requested. For
-	 * flags which do not obey typical merge rules (i.e. do not need to
-	 * match), we must let the caller know about them.
+	 * For a merge to succeed, the flags must match those
+	 * requested. However, sticky flags may have been retained, so propagate
+	 * them to the caller.
 	 */
 	if (vmg.state == VMA_MERGE_SUCCESS)
 		*vm_flags_ptr = ret->vm_flags;
@@ -1906,7 +1908,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 	return a->vm_end == b->vm_start &&
 		mpol_equal(vma_policy(a), vma_policy(b)) &&
 		a->vm_file == b->vm_file &&
-		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
+		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
 		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
 }
 
diff --git a/mm/vma.h b/mm/vma.h
index 75f1d9c7204b..abada6a64c4e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -273,17 +273,15 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
  * @start: The start of the range to update. May be offset within @vma.
  * @end: The exclusive end of the range to update, may be offset within @vma.
  * @vm_flags_ptr: A pointer to the VMA flags that the @start to @end range is
- * about to be set to. On merge, this will be updated to include any additional
- * flags which remain in place.
+ * about to be set to. On merge, this will be updated to include sticky flags.
  *
  * IMPORTANT: The actual modification being requested here is NOT applied,
  * rather the VMA is perhaps split, perhaps merged to accommodate the change,
  * and the caller is expected to perform the actual modification.
  *
- * In order to account for VMA flags which may persist (e.g. soft-dirty), the
- * @vm_flags_ptr parameter points to the requested flags which are then updated
- * so the caller, should they overwrite any existing flags, correctly retains
- * these.
+ * In order to account for sticky VMA flags, the @vm_flags_ptr parameter points
+ * to the requested flags which are then updated so the caller, should they
+ * overwrite any existing flags, correctly retains these.
  *
  * Returns: A VMA which contains the range @start to @end ready to have its
  * flags altered to *@vm_flags.
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 46acb4df45de..73c2025777e6 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -117,6 +117,34 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_SEALED	VM_NONE
 #endif
 
+/*
+ * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
+ * possesses it but the other does not, the merged VMA should nonetheless have
+ * applied to it:
+ *
+ * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
+ *                  mapped page tables may contain metadata not described by the
+ *                  VMA and thus any merged VMA may also contain this metadata,
+ *                  and thus we must make this flag sticky.
+ */
+#define VM_STICKY VM_MAYBE_GUARD
+
+/*
+ * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
+ * of these flags and the other not does not preclude a merge.
+ *
+ * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
+ *                dirty bit -- the caller should mark merged VMA as dirty. If
+ *                dirty bit won't be excluded from comparison, we increase
+ *                pressure on the memory system forcing the kernel to generate
+ *                new VMAs when old one could be extended instead.
+ *
+ *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
+ *                'sticky'. If any sticky flags exist in either VMA, we simply
+ *                set all of them on the merged VMA.
+ */
+#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL
 
-- 
2.51.2


