Return-Path: <linux-fsdevel+bounces-54145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78401AFB933
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6670F424BF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD040241669;
	Mon,  7 Jul 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dExIopBj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oHchXXXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64523D29B;
	Mon,  7 Jul 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907313; cv=fail; b=o+i95GtHKqOyH1GL+n/2nYeKrjb4jD/yMfKWIgXdHKM2JdAe3twVX+vV2+VskAzGiSh8OZa9UVr0ybBNyTrrQuq5fKyLe0wYf6PkChZAuV9tqGDR8T3pom1O5nUqaQvGPsSSfzUzmwg72pEUrczPgfqjIuhyvwEjo+IOk5imXfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907313; c=relaxed/simple;
	bh=yWexLiDj+QuEXXAP9hGFWZ+08mWrWa4tizVQkcXcvEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bWuYMzqnKVLnAnIlNdLW3aLuvEON7BH65/6pb/MRNb3AX0lV/rda/nKHucnUHQL8JTV3ogjRcrSOuWHWXT3pk6qW0OH4bQ5M9ln+O+N6aSSjfTLkdJMFZKgYrGsZRH8WeODIBxDf68npZGIxZ7C3ZALaEdj/UPL7tsziJYv7tZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dExIopBj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oHchXXXk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567GMMn4000499;
	Mon, 7 Jul 2025 16:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Z691J5g1BrMJLJTABO
	oaFSzExIyEQJoA9lDG/lpBvrk=; b=dExIopBjiuO0bucMQ2dRSdOdPU12RlvsVN
	mWCz51lC2Po2GLTfMHvnc7TjvgBOV4cRwQsF4krygEfunTc+G47z6unYnGFk9EYt
	pOQEwrkhzUR0EFsGuahbZHYYN5pdtOFAb+WKBW8ry4aryzE6vHlc0YVt2WM2b3jw
	B24W28cwsAoVT9tZ691C27tZ7N3xGmLXrwKUAKBtG3I5bmVhn7eEtF9qveaxP33o
	J9DxmNbDqnBm2DZuSWkvPVu+zJA+KQ5r0EAV21hhXVrr2jGiNE4JBCNQqbHPxpSx
	bg7C9T12u0QixOP+4RkPx2vyeo8Vf3PNwXeDJaD7JWctnvkKG0ew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rhpfg1xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 16:54:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567GnIFf040469;
	Mon, 7 Jul 2025 16:54:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8r93b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 16:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BypKaZHUFlzdxeVTZuyJDDiQqiDlp6g36v+aiioCFhMvrQ58gYg02cdrru+g7jleZKhRMjboXnsT476IOEfsgEZ7manOfJ5tXPZOdxWT2CVIltBymZHcosukkkIU2qvygKcsGvERQM9mYJnLOonVk+sP1Ntgm6YWtZcA22ZHL7IW6b7T9QfvxI/bvGPvc2CA9IRlWWI1JIX6zoy5g6Y2gOQAB9UkkXdQoMcL1sHExWRSkK6f3YodTMMd000nWn/k6k7jxLbKKZlawa+h1xanNboZgUFQYCcVwTSHkQNI2tygEFZQKE01HXX44qn3NaC0w3mE8GXChFTC4DyzbzYsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z691J5g1BrMJLJTABOoaFSzExIyEQJoA9lDG/lpBvrk=;
 b=r3QwIoOw7v01d0/WrMQxEXWco1CTkkztGltwK1kn7bIILolW7qzprDvKpZ/seP7U8VNrMr7JOoUiyO82T4sPnwkqP6TwjCZ4wj7bEr0N09L48Dis05Y25KqO2Q9WLc1IrI1k+0v9aHthnTtO09f7uzEOlX2+uuyKtQ6oqoRV4ZuQB1XGYEBgPV3cm8DduB0kNGv8osmreU0SJorIGVi2eFM+lgHxT4JDZEtIPRzUU9BwRoYnLE1CFJeAGvsj4fTm0lfZMACPVP2J9uIApZSdq8iSQkECs4sGdhgU2NzRfFiCo8hhLgLlchbtXN4+ICw5RgHBrhygbPgmtY2TNcw9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z691J5g1BrMJLJTABOoaFSzExIyEQJoA9lDG/lpBvrk=;
 b=oHchXXXkPsO8Og+X0dEHJKPjb7iyoziZsWZ8RGHiBzWm7Ty/GR2Nc/tf/x97T3W8Orbg4VnRqMcip3de+p7o8s5zQKwbotqDFqB6ye5hdBsyOjnRRWQdOr+yQUdJkmbsX22ruMlNUNpE/jpYKn8aPM3Omat7ZTInnWSgmDXWSjw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 16:54:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 16:54:39 +0000
Date: Mon, 7 Jul 2025 17:54:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 8/8] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
Message-ID: <c247d813-68b7-441b-9c90-46599729089c@lucifer.local>
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-9-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704060727.724817-9-surenb@google.com>
X-ClientProxiedBy: LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d821f52-59d0-4f6c-7749-08ddbd76f62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hQhpBtwpFrAOqKOYKXCXNwSTeFKKAp0C01NpLbCcM8IAL9Cz2s/apimfOCp?=
 =?us-ascii?Q?FAJaGaFFiyZuyrG6igNOymIqD/oJmvabj8TDJGITDe98feMAXS6Qjf9t4dCY?=
 =?us-ascii?Q?i8ZZ7o9VQxHJusvqqWE+GKYBvDmKNRrpWl1uWmU5EeN6aLlCe1Dcj786x9i+?=
 =?us-ascii?Q?FdXPrssIeq0TGaKJGUxJpEszjD2AcA2duwbS1Qq3xt5Of6a+HdNqNk6IdPhZ?=
 =?us-ascii?Q?Ru745Y1nj2AT88EiFgC7GFBCB7/MmCKus86Y2pKFC+4nGQhB1gkHyCnXQlmG?=
 =?us-ascii?Q?iPauD5wJW8J3Q4iw4iXK/6u3EF3vijEYR2+7vqGJrfEgUllRp1INyPzbnveF?=
 =?us-ascii?Q?CFpFNB7X8NYCmG4/pQnc5YIWoHpjFg7LEk3j9iAsK5DWl2AebxHUgDn2IxvE?=
 =?us-ascii?Q?fLesqI86yEk5FTWCdLh4ZW3tBzYVmqqGPwqhd8PkLAxJA3vkWdbh03u6o5Om?=
 =?us-ascii?Q?yk4I3mc+G9lZmtW3YLMj877wmuRSbYadWMGdl6GW1X+xTkDw7YONYYTTMg6q?=
 =?us-ascii?Q?wk1dT2ml0TxSMegS3dB8Uw55whFSvSKPqcZkgsa0kjP2tcdM173qb7Yg4jhj?=
 =?us-ascii?Q?V6DdUMQ5gXvizs/LycQ/asAGvtYI51RZ4mn2PWs+v5jufSxVWDbgMeVe759F?=
 =?us-ascii?Q?sI6tuBLW3SxI4ZQb+Hrwwris1nOBtz6K3ft0Ul2Co5JXdcerb6JRG8H7gyEf?=
 =?us-ascii?Q?rcWBpLwO8C4jvmt+Lzu4Qq/D/Fj02x2aVHIyGawfLnQ8tLu0AWMaSxmWP/Hg?=
 =?us-ascii?Q?B1sbysT4Hbzh2xqxZKdnxzcJPy59WdcM/5NmDGsUsXrLlqgk5Bm8DU9wBJnN?=
 =?us-ascii?Q?EJ0ZT4Cj8T/3muWdKfCq7Co67QBb9QorPLMEE5bRSIpS4p66XcBnRJKiYKBr?=
 =?us-ascii?Q?wN4FF9xAjR407qEsokIjtMYvh5oMCG6XvtNYoc7zSY2uGf/EHWbO4VkygNYv?=
 =?us-ascii?Q?C5qY6xGHcahLQ2OIGNnlUAGs4bwiE9M+jJ37FGQn4YdXR5+Y13Nb3YGe1ws1?=
 =?us-ascii?Q?HBhs2mMYq051fxwENClmncDv67uii8c6MtF3mJzsIDGeCs7zV2r6qyxwQx9H?=
 =?us-ascii?Q?RGGK9F5EzFHDO8t1eqsdelnlIRffR18w8sx0T2qaAUYyrMg5yQZBtitL8tzz?=
 =?us-ascii?Q?3OKX3RiNw2hGTunvf71TbT1YuwVYgFanTCdJQFRbEJgzBFY9Yu6e4+BC7Kn+?=
 =?us-ascii?Q?JFOKTV2/V0za6oHqxbO/ZHYk+nAVKHxX8BZZLrdmh8vFmtRfAHTL9ZFrDQbI?=
 =?us-ascii?Q?eXeSgMRBh+QMSin+Oy97fV4qmipbF+cMTnY/1QI7gPDLxziheahyGiMaNvM9?=
 =?us-ascii?Q?zv6wVXkmdzhx+ywOGKcnfHOtxokITb872Okz4DEsLODFQZQ9co2q61A51+u0?=
 =?us-ascii?Q?C14u5h4rHotsmhLUnyyLQ3vn7ANptOOCw1buJq8Cxbxgrt+j/jspr6TYomCm?=
 =?us-ascii?Q?2pSGFveUGpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18ovV7VwfzZGdWndFgUvf9OjwYnMqYI7BJa9CJ4WitvGtUiS7V5jgKyBD0Xk?=
 =?us-ascii?Q?e+JSpqFkKHG6uRDdb0cjarwVuzaHx3k00MHp2Pf/nW+6S9lvYpvLKTU8cQRd?=
 =?us-ascii?Q?wqIQn7tf+Nubk5ENYsM1O1rKWd1ProGCVPMFanpiAWcHWuGOu9D2VHuLUfCE?=
 =?us-ascii?Q?9ZV3P09kp7pXEFysUkPhmpHGvluozWdhQnHjhrzB7oIR4gSxNKxceWVFYNYh?=
 =?us-ascii?Q?pe3iObiUsEYT/p4BWnxseTCxoV7q9xfqhu6TLdeqmK3N2HSMfB5XVuxBNBgb?=
 =?us-ascii?Q?+DHeiGREHwEfKZyMPfv5UDsKb2cn5yPC9/RYxuIt3mH6s0vJUJnqi+QY0lol?=
 =?us-ascii?Q?5AsYZixr5ayp9F1uJTulRBrSYGw46hIHq5kIZo+m4U2EMSyGVlV5jpVIonSy?=
 =?us-ascii?Q?waOMAtNTeMqDdvTefhxQBXe4rUKMqlrjO7Odi07/cKlFzoClfUNE5z2GdrVU?=
 =?us-ascii?Q?cprK3vqfoceN8EYo1WtbgmixY6FNbFSTiR62Zvy5FD9NrHRE+rJ0ULTzB+G0?=
 =?us-ascii?Q?cJqQYVmTJuOnoVAB3mmwXScfIrY0UJZrkAiGfGeRjyxfk4++8ZsY3Oqmqkrz?=
 =?us-ascii?Q?aLURy/iPMJq+azk219gwbRW5ri0R+MK7u8WJlNi7aH+n0R8vOagaGTORpslT?=
 =?us-ascii?Q?wPPiUHPu6d8MrRAvKvyM5PyLER7UXJ++i2iNg2E3KBopWaT5x1Tec0pFs+uy?=
 =?us-ascii?Q?8LBKNEk6JxJ3coaSeDhzYpivT4wLXBd3AcoIlwMI5IsSch4K6bn2VrBcghZ5?=
 =?us-ascii?Q?qCMnoAeUeYzI606d+OKztGLN0Noy86QWCxcrDsFo9JrFBzaQHJBSTpPAd/kk?=
 =?us-ascii?Q?GeeiQTUpd6ant4SO1u3dcpnowz0DhGPORbUd2C68gMbQdRuOUmFL4nh9jBEy?=
 =?us-ascii?Q?h6TFS3ev4urwyXKBne390PdigsrEusBz/mmrgcL8+vvg5uPwOcbty6mVpxCJ?=
 =?us-ascii?Q?qsACEjx6QAjuoHQaF3AxulBELoIH5/rs8fduSRpXNPZ135pC1BeJ2Y9NNp5x?=
 =?us-ascii?Q?/7DLIUJa4uvvtM4ft74pu+HUsGYztEXbMjjychO643GKVXmANyL4NHkc7Jh9?=
 =?us-ascii?Q?mV4S4pC9af/oLgIRxm47cF7OsWGUWn71uu4XV3tOgd52VvLZaejS4yrAnjPr?=
 =?us-ascii?Q?0PHyiDxjpE65YM1nTw4fUXKOhu9C7LNRN8HdGzQlZZHJkNFE3UmEgtNnHis0?=
 =?us-ascii?Q?iAHCwtQzM3YyYpA1XE+JXBpJc7XXcNGSLNEVmh8vPEtT1+iLe3C9RLePXxQz?=
 =?us-ascii?Q?1+TuvXNVhhjd5VY89O93SiG69rwg1tVqhrZuDq9U0ITmoMUa/kaacMj9x6zW?=
 =?us-ascii?Q?soeQXNK3OzeQBoDlWzQ/mMosABozcucqQ/3MbUGJwHibIZJhcightEwdO3yO?=
 =?us-ascii?Q?ZlfE97+toDCqZ8WQFdTU6PVBsTA/L0+tSTr6Q0S2uAQGqXAL0MN2hMTxUhi4?=
 =?us-ascii?Q?htG4nAbdlZ/dKg5QPe0Ytjbti7ynmlbPDm1eLQMgdoXWbgFzCG+R28HVWS0x?=
 =?us-ascii?Q?ASSliZHC4sFX5U4g8nWZeRLa6SNp8snnGUHVG716iS08aB7KvK5flmj+1FvD?=
 =?us-ascii?Q?Gt3HpmoSisYSW3OvfA9fc5QW4htBc5YVoJXJ+xHNAeMtu/8jJhDCIuz0rI1Q?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o/+7bPjXgUe4MB154NoMYvSHXm3xEAQmec4oOkbznpq9tfwmcDM8H9SD2Fi0sS/DLz5zrZ4AaG8S7BVx1jK/muH3bF7kulZOUf9L2n7oVylYuhw7/Tt11FgWuEUGIrI496/uvaKWwK2zh8yFixOJPPEDZXz+Oh/cCcIdcIh+GAtzJF3/lRYoHgyHICsW3Po88ximTtuKRUR/D9xN0qCWueaXJ2VsqklM4Uik5+6do7MMxgNW1KccIibv1ha2V1fATTBsm1V01GQbqbQ0LMBJ9apdf5k14dzFY/PGVEwti1U7x+UcJ890xl5yuf4NhS/sc5zfMPTRDshdg2Csg1KeNr1kHK4zHk7VXw4Nk+151zV8b0ULBx9Uh3+d5qxmeRF6Ec/QT3wQFGE1y2pWW1dZQs/GzzFBIVhdkDYRu8XuX2xgY2+zP9X3IA3M8C3jbnqgI06rbrTwlDZxOIuDZYIgZC1aJPxzK6vZvrwujRUzvosGLgvY4jboWV1PZpGykzs1PBgIQ7+DqqvPNJEsZqg45F5sF/W1O+aQhHhbQRjUaNJ+t4WZnXXiklVTRYTkhJaNwpN1AsVcI/sa7u9AX+6MOSnPCaKu46TEPZlekrmRUag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d821f52-59d0-4f6c-7749-08ddbd76f62b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:54:39.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+DVqMJSaGFufvNIa3nFqcqMGcr821p67U1toIWYRRGeh6cu+fF72iwe0kjoB7zUhUymwV0XHIfuSOPgE5Mug0yv0M1rxXyL77iVGodWwoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEwNiBTYWx0ZWRfXwd8L60I8bEGi VVXsvmzN2bIlgNH3Ml+fl1ae4Rkt7GB2N4oREqce13BRwitfjT1IXfn2hwNIRxGTKDmqjseZ2CO zVZHfjyxeQs+j07Tq3hG3CzvQlCCIZ+GK71dlFd9lSrh3ElQNrMdUPrgqbELmn7S0R1Z6ITXT+F
 sm/8OhTTAnH+3kpe9EmlTa0aoes3meqDQIxu2gmja7rcvf+wR8z0GvRET/IQqIEQAFy2wUidqmF +uXTC1xPwndpWQGF9BF7LtZSatsuuHZZDvYWCfjhzqyLsi0i8zhJe7mjaaVOknwhV7u/MhMpIq5 tTZShOzzqzkcUVaPicqP0BRrMu5DI/vH5b00XsCq8LtrI3lRehEDDgNQ92SwXaGUWISfuQncTNO
 1R0a3JWvjL3a9l17mg+d2S+aThFQ+I4Yol16FPwI6tCKwlduh3J2pMeg/4YJNAN/Tftru8Dl
X-Proofpoint-GUID: lVWFlOYOAwZZr73fJ7L3p3ABk0YFVV38
X-Proofpoint-ORIG-GUID: lVWFlOYOAwZZr73fJ7L3p3ABk0YFVV38
X-Authority-Analysis: v=2.4 cv=etXfzppX c=1 sm=1 tr=0 ts=686bfbd3 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=fNb60Y3t3af3kvMo44EA:9 a=CjuIK1q_8ugA:10

On Thu, Jul 03, 2025 at 11:07:26PM -0700, Suren Baghdasaryan wrote:
> Utilize per-vma locks to stabilize vma after lookup without taking
> mmap_lock during PROCMAP_QUERY ioctl execution. While we might take
> mmap_lock for reading during contention, we do that momentarily only
> to lock the vma.
> This change is designed to reduce mmap_lock contention and prevent
> PROCMAP_QUERY ioctl calls from blocking address space updates.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

This LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  fs/proc/task_mmu.c | 60 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 12 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ff3fe488ce51..0496d5969a51 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -487,28 +487,64 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  		PROCMAP_QUERY_VMA_FLAGS				\
>  )
>
> -static int query_vma_setup(struct mm_struct *mm)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static int query_vma_setup(struct proc_maps_private *priv)
>  {
> -	return mmap_read_lock_killable(mm);
> +	priv->locked_vma = NULL;
> +	priv->mmap_locked = false;
> +
> +	return 0;
>  }
>
> -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
> +static void query_vma_teardown(struct proc_maps_private *priv)
>  {
> -	mmap_read_unlock(mm);
> +	unlock_vma(priv);
> +}
> +
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
> +						     unsigned long addr)
> +{
> +	struct vm_area_struct *vma;
> +
> +	rcu_read_lock();
> +	vma_iter_init(&priv->iter, priv->mm, addr);
> +	vma = get_next_vma(priv, addr);
> +	rcu_read_unlock();
> +
> +	return vma;
>  }
>
> -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
> +#else /* CONFIG_PER_VMA_LOCK */
> +
> +static int query_vma_setup(struct proc_maps_private *priv)
>  {
> -	return find_vma(mm, addr);
> +	return mmap_read_lock_killable(priv->mm);
>  }
>
> -static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> +static void query_vma_teardown(struct proc_maps_private *priv)
> +{
> +	mmap_read_unlock(priv->mm);
> +}
> +
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_private *priv,
> +						     unsigned long addr)
> +{
> +	return find_vma(priv->mm, addr);
> +}
> +
> +#endif  /* CONFIG_PER_VMA_LOCK */
> +
> +static struct vm_area_struct *query_matching_vma(struct proc_maps_private *priv,
>  						 unsigned long addr, u32 flags)
>  {
>  	struct vm_area_struct *vma;
>
>  next_vma:
> -	vma = query_vma_find_by_addr(mm, addr);
> +	vma = query_vma_find_by_addr(priv, addr);
> +	if (IS_ERR(vma))
> +		return vma;
> +
>  	if (!vma)
>  		goto no_vma;
>
> @@ -584,13 +620,13 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	if (!mm || !mmget_not_zero(mm))
>  		return -ESRCH;
>
> -	err = query_vma_setup(mm);
> +	err = query_vma_setup(priv);
>  	if (err) {
>  		mmput(mm);
>  		return err;
>  	}
>
> -	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
> +	vma = query_matching_vma(priv, karg.query_addr, karg.query_flags);
>  	if (IS_ERR(vma)) {
>  		err = PTR_ERR(vma);
>  		vma = NULL;
> @@ -675,7 +711,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	}
>
>  	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
> -	query_vma_teardown(mm, vma);
> +	query_vma_teardown(priv);
>  	mmput(mm);
>
>  	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
> @@ -695,7 +731,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	return 0;
>
>  out:
> -	query_vma_teardown(mm, vma);
> +	query_vma_teardown(priv);
>  	mmput(mm);
>  	kfree(name_buf);
>  	return err;
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

