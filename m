Return-Path: <linux-fsdevel+bounces-54372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B1AFEEBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179FF1884507
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79A2E972B;
	Wed,  9 Jul 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dey9N+74";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ujO73sNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A062DA743;
	Wed,  9 Jul 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077556; cv=fail; b=ErjhF1bzgE2mfZQ11Cii4bpcOcJJtkx+DG4iL2IOgy6ManQ6OrmSJaHoJDxFek+TayRGegQxqWOUMlewWlxzaj+hAGWqq/GPpvLwaNVo71G5P0y6s9yHMqgAzQrW/nWToJCfmT23OkMVvkwZ2As0xD7DKKEClW3G1f3aZnPU1Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077556; c=relaxed/simple;
	bh=HU30BBddSSY3v/LMS1FGSY68kleW8DLlCgVnfRlfkiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTMcNZmwwTTUoLTjWvqihlHsxyIpyZ4b9XFsvemNXMSqouPQ1dHwVwo8/+JKe3ibx9eNQAQVsCU3FRwlcSAMRzOs0iU10nCXd3SAECThSU2FNGT825RCr3c3vdJkRDbzZKV/RC1vOTS2mAtddiog6TSf0Ix6ov/x01dpCdNNe2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dey9N+74; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ujO73sNM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569FqbfF011226;
	Wed, 9 Jul 2025 16:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=akQ1fvHE7I2eYQLqpD8B7YP3Y8JOWmRSwzDrFQbi8lc=; b=
	Dey9N+74TXPrGiBjeVqAq5DE+pJVhkV2CXlSgk3VheZMXI7QqebFQ8SIJFKpXxlT
	AowfGa3nKd9stOUmVLeZ6VMjnCbzeS3TwWg5DUm1hoPuSRgojJ94JpLgXHmUVmV1
	Op+Jv4+V8A6THPCXw7zJqG0S81PNCANMa8v60OGH7OXSiLeJ1I/N1/mONOkPM8gk
	sG4k2pkuD+LjC819rvp7CtZHQzFiCsFrbUeJWciZXyMpwervdLIPEW2ORl+oBaHh
	q8vJUaQLeqMV7qYGwRM+ulZxFkXijFu3s/mU19MglxzQfFqcJYSmti5rLPRvO+ZV
	C/TbdS3xG92C2QwB2wFpcg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47suek01ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 16:11:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569F0hC1021391;
	Wed, 9 Jul 2025 16:11:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgb58ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 16:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+TzFiDSS4okZgREd1e7NDkDoN4z4R9XB4B3VQ3YkTSiEH7Vmf7dD5XRs9Rmnk49wRFME97aTGjs04E+cBEC7ofjyn4o3ugs1Tzj4yk9Y+5lRphVURfKH5pUpxuytTAKGopBqVjOkXVzpCVHPJ+BAQbvFiq+K9Vp+yPCctpdS/K7VOnEw6IFBW7Hza1obtAjhFUumqZ0j7b/QCG3Hssy2Bk+gENPhaoLY+DHxPOl19mjxbDBcZbFu0U7Yb4c/Lr0tt4omUh5bbM8Bo/gvktZ2i2lkJwMTM++j33jy2tKY2Q3ZK69NeyN38j9AH5bbL5Lsqi/5ciMDkYVpGsbaLpftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akQ1fvHE7I2eYQLqpD8B7YP3Y8JOWmRSwzDrFQbi8lc=;
 b=paC0xJl0Woo8SM7fyluv/KnYafdtb8sOtdkDxyz/j/G8DKh5Rl4f8HNSoWFhHvbEJuYU899wzGwfjMi3Cm3/dEDEzGRaSrGTFfSr/9S/n0BnYc2NH3zSzyWvgtFRrr2g1stviFvCGfkcriWiMUvwcigJ4HMY1mpa7/B+t/RfKgRiJEdsNet1Au88PEBnCGVqGzruXz3AjBegmKsHziGvxUHzQ3UQTmeJ5EjTJBlak6/9qNIfjmnRcknfTdCrbJfWo9BPMf2WS7uHY6lepyvRn1T/Njx7aQzofPe8Spo26JIpwCGvMQzh+qMO2GzVw6OrgCgNYwHdt6zALikftlocFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akQ1fvHE7I2eYQLqpD8B7YP3Y8JOWmRSwzDrFQbi8lc=;
 b=ujO73sNMVDFRWke1Gu1AnsAI9FZGBkWy8RwQAdqmf+DmEmpCnuOjY1iBSWzxRoXj+cdirGI9KE6sEKGmOtHtSyOuOTP0fwYn52XVGMDkTbkYY1E4495OvOYfCsZhDE9Ng48re0hzx5QYuhWS+ONhzHtkfnG6mzHOe3KDwuejAHg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7320.namprd10.prod.outlook.com (2603:10b6:8:fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.24; Wed, 9 Jul 2025 16:11:50 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Wed, 9 Jul 2025
 16:11:50 +0000
Date: Wed, 9 Jul 2025 12:11:45 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        akpm@linux-foundation.org, david@redhat.com, peterx@redhat.com,
        jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
        paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
        brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
        linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
        andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under
 per-vma lock
Message-ID: <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com, 
	yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-8-surenb@google.com>
 <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local>
 <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
 <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
 <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT1PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f281cc-6b3a-4cd1-b263-08ddbf034f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnlzUFlJSEJRb1BRZDVKeUNzdkNYakM5eURxb2Z2UXN0dnd6ZmQyeUtkK2tx?=
 =?utf-8?B?MUVlWGFXV2wrd0dGdzEwLzRtRVAzYVJNd0puMVh4aW0zQ0JnYm4rcWdNdzNS?=
 =?utf-8?B?aDM4MFZKbFY1aFR2NWRHNENiaks1Tk10ZEFTUU5GcnNYdW5veEZkK3Q3Y3pV?=
 =?utf-8?B?M3FTeE5GWWxERVJaVWhGU05WSStlUE1nUmxRK1llVXVIQ1dIcWVjTkdZUDJP?=
 =?utf-8?B?T1FwQy9udlB1QmJ0YjE1TEsvUTBPb293SVM5OGgvUldoelJVTk5hcFpDZzha?=
 =?utf-8?B?Vkc5aEpSbHBwT1QzOU1EenBBRndrNXNmc2s1Q0luMWhldFRIem13bmtyaS9k?=
 =?utf-8?B?ZFFWaEpCVnRpVmFFbEdNUnQ1K2FISFR1SkUweGVMUTJQa1VTdDNvZzJvbDZN?=
 =?utf-8?B?SElTcTcxTm4ya3p0S2ZaR1pGUDMxekRQdEk4TjdjRllqMkxvNWd0YUwxa0g5?=
 =?utf-8?B?Z0RlWUdkYlZTR2ErWk5ienFvUE5sOC9mdWxFd29aRUVVWXY5TG8zMUpFSnFS?=
 =?utf-8?B?aW9hT21CTmlldElsQXZOZmd1VmxCTlRPc2tVWmpUU1BRSWpLRDM3MlY1MG5S?=
 =?utf-8?B?ZmlGVGxUdmwvaTBxMzBoUXREdEhNRXc5L2hid21zM1pXVlorYTJYS0wxOWQ2?=
 =?utf-8?B?c2MxMk9BY3d2Vm5BeDJ0aDRJdy8ybmhwb0dFSDc0QVdtKy91aFAwN09MNCsv?=
 =?utf-8?B?K1RUSjJQUURsR0U3RTQweG53Sk1IM3B6MjErYklsRGVSNE1NVSs3aUVRMUJt?=
 =?utf-8?B?WjBCV1FLenV5OE41aUROZkFIQ1BIMXVnaDlOVlM1TFhvYUpKdm5xZjNPcDdV?=
 =?utf-8?B?QzlxL2J4SSsrd0gvTVl5R3NXdkNOVmExZXd1Uk9vZVg4UE9LdVJPOW1TU24x?=
 =?utf-8?B?TXNYRWpyQWYxcDBPdkxGYVNucXAxQ1ROd1lHNDNldmhlQXo2SHhaRjJyRmZw?=
 =?utf-8?B?OVhKbjZqK1MwaTA5OXcxUWdNL0ozcjZ5UDd3L084K05kL0Jic2QwYS82eTNq?=
 =?utf-8?B?ZmVzSlNlaVhmNUR3Vk1LNmI1SkwxejQxcy9SUng5T2NFZ1ZES3h0OGNxR211?=
 =?utf-8?B?TTFFQUJSZWJqbzlRS2t0WGtvZG85RDFFV3B5RWNXU2lzczhYdmlaVUxESDZ3?=
 =?utf-8?B?UzVkT25GUVA1TFdQWGhZRWp3cmlpSzg0Q2NiaEZzOHBqdGUyYUVHRnZvdERs?=
 =?utf-8?B?b3JZMTdoMWF4U3VCRkpxVyt0TmRKeDQ4ZmVldXArUkhwK0l6RVF6TGhvRGQw?=
 =?utf-8?B?OVpOTUNDbEdKTTNucmhVbXFyYko4ZVgrZ2NZeDBlRW9qeTlBTE5vZHliZmZv?=
 =?utf-8?B?R2g5eUMwekx6TmZsRlRUTjNPanRROTFCVEpkOGp2bWpFcXROVTBNRU95ZHNo?=
 =?utf-8?B?VEdqYnJ1VGpGT1g4RmpyTk15eE1XYmRHRWVqR0FyT2ZIN1ZJYmF6Uk54Qi9w?=
 =?utf-8?B?WHBMdWJwVVhFOUlmU3dRZ1ZXQkR3QjRKQW8wNkJ0MUt4S2Y2ZzNqMlZkTTdq?=
 =?utf-8?B?cXNSaXJ2QWtmQ0Q5WnJVcG82b0YzdkRsb2VJUE1Rd1ZYUW1QeVF3aG5hMHZ3?=
 =?utf-8?B?eTVVUjg3WTFGVmMvSmFkcUtrNXRxN0xpTHY0dzNhbkRXL0dhZmEvTy8vQmdk?=
 =?utf-8?B?MnQ5VFE0bkw2eHFDS2tSRzhiNjVJemV1Tm5DRjZIQ2U2bUt1MXhNMm9rcmNr?=
 =?utf-8?B?dHZ6TXlVaklaZUgzNW5iSHZxbWpVSWtlVU1UVEtzSDgvRVZObGxGNklIQmo1?=
 =?utf-8?B?cVl4RSt4YjlJcjM5Z3JiNU1kQVg3aG1LQXBSRTBxaVE0R2dMN1BBQ2FYN0Rj?=
 =?utf-8?B?bjJSWVM0RDBwNlpSMFJia0t6dElRT2lIcW9CVWlvNDJCTlQ1S3l4bVBIWEM1?=
 =?utf-8?B?V2lWUGVPQnBPNlNKVFlnNGxoVXdJeHZ2ekFwK09tOHV6L1B4NlJpTk8zMXd5?=
 =?utf-8?Q?mGYzTVNjpLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFE2dkZEekJtMkJZeUwzbTlSVlpmS0RJZHRVNEFFaVpmV3dUSnhvY0wwdHAx?=
 =?utf-8?B?c3FkTlVLSjFKdnkraEF0TndBanpNa3lhdStUWG5qM3hRaE1ZOGlVQXBhazgw?=
 =?utf-8?B?ZExrM00vYWI1Y3FDTjlWZ0NuZ0E5SHg1dEVYcmx4SHFCcllRaE4wSEFsS3Q0?=
 =?utf-8?B?cFZ6UWRiYkV1T203ZnJIUE9RRGQ5NUZBWDUxcEYzODV0ZkVDcVAybU1GTzhE?=
 =?utf-8?B?aDhPeU9Ra0xmbDFtTWhSMTNpUzdadVEvNHJUYW5PYjR1dDZySmE1TzJ1VUpT?=
 =?utf-8?B?NGFDOGczMHdNV2Ntb3BqUkV4QTNsV3NrcWhCRi9vTmJrQ3dza05QYWNKOVZM?=
 =?utf-8?B?SFdza29Va1g3SmZKR0pGUWpPelpzczUxK0hmWmdXM05aSURxUWJrVHJuWWQ4?=
 =?utf-8?B?K0hJeDR2U05iYWJHUmg1VDV4RXZmTkJJcU9ndFFmdEZKUHhTalpVRmhkMWdD?=
 =?utf-8?B?a0hQRlBiT3MyalVGWm9wR1RYTFlRVUJTMnRFazYxUzgvSmwzRFhwRVRLVmxw?=
 =?utf-8?B?NGRlUDFJekFERG5lY2xNNS9ZWDhQMWY2TjIvcG5LSm9vSEdmUGhUOWdCeWsz?=
 =?utf-8?B?QWJKZ2NvV1pXdkNHbkM3ZjJHU0w5WkgrTVlHaXVoOTladHVoVnl6VkwxMmxM?=
 =?utf-8?B?QWlvUlAzZm5jY0lnTjV4bGphU3FTV29Ta2x2Zko0Y2xtOWExRHl3d2FDQ0lW?=
 =?utf-8?B?ZkdXTGVmZnJwM2toOHFPdEYrQ2QwclRjbG1iOGxaTUg4K0VHeE0wek1QWUZR?=
 =?utf-8?B?WFA1Ump6bjBXbjlQZFg1WkpHOHErdnl1V2ZMOWdxNHNuT1hXTDdoYVRXOTBS?=
 =?utf-8?B?Y09SUWhpWER6RUZHM1V1ZTFjZjNVMGcyMHczN3pnbFAySFB1ZS9POUxyanU2?=
 =?utf-8?B?V3ZmVGVoMUEzNG5QZmF5SjI1SGg2MmJDTUdLQk9Ld0JsVVpSR0ZlQ0VTOVVK?=
 =?utf-8?B?MjJZam11T3hoS2hiTUVPSi9EWTZjQVRkZWtHUlE4RWVuZHFweXNJN3ZSSitS?=
 =?utf-8?B?aEk2VDFMWUJTZm00Q2pZeW8yTUpQSnU4R0I5WDZoam9NclNwT1BZN083UmVB?=
 =?utf-8?B?a1AxVGI0T05LZ1RXdCtZNlYrRyt3Z2FMZ0hoM2ZMbGFsSVZqNHlyT2ZDdUN3?=
 =?utf-8?B?TGwxVXp1UXJaWDEwSHYrcEwydUxremFoMU5jS3BZM0tqOFlGVU82aTZ2U1lK?=
 =?utf-8?B?dmNyS0lXVitEcnZjU1IzOVRkS3BIa2U5VG5acVJETDk2aWh3emZLbVRBOW50?=
 =?utf-8?B?MkpsTDRCUDJQMlhqcXQ1ZVBGUkhRRytzN0QxczNXVmdPeDFXalNpZld3d3Zp?=
 =?utf-8?B?ZERra09LejBxWE5xRlRRMS9WNk84R3c3S20zbDdQeFA1T3J1Zlh4dWpjSHNa?=
 =?utf-8?B?ZFZZQVdhQkNqYW1wanN4UXVkMmt2S0RBNFNaQWwwdEVUbjJUWjYvT2s3bjV5?=
 =?utf-8?B?WlovZ1oyUGF0ZEZIWGdPcWFDM091ZDVCTFJWRHBuV2VVL0VBNmNUTlNFdGRG?=
 =?utf-8?B?ODJSLzdiRk1ZVi9yeHNLam5lUjE3a0MxRGVqRmdwVTdYUjZsZnlVVFY3QXNK?=
 =?utf-8?B?aTRqQmJROHFyaThpUXl4a1NNemhPQkVlK0FGWW9qb3dBdGR2ck5ySHlER2RE?=
 =?utf-8?B?Z2Z3OG9iSC9IN1RqOHBqZFBPcW5MK3B1cWNva0JCaWl4aEtqNVViZmFaUjNl?=
 =?utf-8?B?QjUxYWtPcVE0WU5zQnkwUDVNZEkxa0FBUHNjOHFTRkZXbldQc0xRS25uWjdH?=
 =?utf-8?B?RzdzQXNUUlYveWRWaklnV2V0OUpYVFdpakdYZVZRN01lamNZOUxQMS96STdK?=
 =?utf-8?B?WGZmSklGRWE1OXlwZG5JWTJJOGNjMTE1cUcvQlpKV1lsWS8vbW5qUVhWRUhx?=
 =?utf-8?B?Z2o5WS9Xc3NpSis2MFFtejBaYjkvMmxLUEUxRi9uUFoydURxWGZSR3FNTUdE?=
 =?utf-8?B?Y2ZzKzUyZjlueXVQWSsxOEY3b2x6bVAyanJXTkpQWi8xeVVJdzArME11WkFz?=
 =?utf-8?B?ZlI3UEI2MWljSGpDMnZNTnMyUThzS2cybnk1d1pyTXJiVC9senRpb1MrejZH?=
 =?utf-8?B?MU9FaDhqN2pDOFRtOHRid0FRSTF4aFV1a3BnZ2loWitaRTM5U0hRUEFOanFN?=
 =?utf-8?Q?qO9z+RsTNTEK2ig5C2bdbFvTb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rq7pivEyE/rKiFZaX4wiEIaTlPJPXk69aYe8en4XfvTTFhy+jbpUdDWiZFDuCziY5TmBgG1p0P/vr4ZDPiyPngUU0po7SRsI0mtcjPtjvPa+vZ7PzQ+zMzNoncR8d7Szg/soRe4YsAv+qWHUzCqXP4xfc1De1W+5yISdYgP3K/Lf9QtTjRJTjnFJ+DPq0JwoHtIoZEU7hwKkO5lFXk7DSXX9G0vqGtQqUMOu8mEuzz6rzr8aNSCWpqtt9Uu3NKEO43g2yxtRAaJdFmS6Ebt5u/tnD/mPe0GiX6re9mQl72+F6IvlyU1EDnbaVloB9MYlUKMtKkeMrZJpiai1dTAutcJU7pXX5KmMc0i7JxILYK/ESUWH1xDpknRfOFKhTFzWJIDDw8y8xwiCXZuqcNoBnXRkJEJCCuLfPJxUO4V9PAMNt3hE605omQNzI5sPN3Zh+rj1OvxfGUf7trnVLSmHxWVLS54PLVnAHHjzo2DEWpMYMMD0M4myYp2EzciEIZRR3ypy8pWhPvrV4Khk0OiJgVDTnlxJxE0jQyxqDEDxy2VpCQh7VXC+iix9O0zShg8IJlp7fHhZVTLn3enTOKAUAAeYUJOYFIm7bDUUApjfldc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f281cc-6b3a-4cd1-b263-08ddbf034f94
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:11:50.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQSIJxRSfz12Cm1hVLh4mfGnpYn2u0teCP9wGA3E32yrYhUpwRqUiXDqVRloXuLJKxd2gnigewMVnX0wfw50FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE0NiBTYWx0ZWRfXxPxCdVEchdii IS8ed2XAS0S4BOWYX4+3Matc5jQfYnhZNOgYh7Cku6KTjCOLAxh4P9St4PpQf4Np/cP9aH/Kiv2 OpCmYWhRtwkX9PNDZo9B04Y2s6SdPCsBCRMZPCt+W2q6DrfdDMKkc+t81euPNLiResb0wq3knAc
 mRxPbAqX1AaP5dG/qOBCRXcxz7z3A0PlzUsQvYf5uvh0E3/a08B0bJzD77wCC6C5SOBuxVuDdg4 UJacEzXMxk3IekaO8vHUofT8uiUr2OD1aVgb5lqpGu0ioHUtd5GGj/CBsqPF0QhAxJKcig/xNmn nz9qnpLifySrRIwciCSLDSdynYRFKzbS4Sv16dZw6BxbS1kO7kPrR0Sw3JYBT4Y+FJ99cTbOeEv
 8nP7LEkBd+O1NiDnYjVzcjqZMVoMC11xFzPOwksfj60Hucj3PruKbfrR1Glzd0SnkVCv7Aqd
X-Authority-Analysis: v=2.4 cv=ZLvXmW7b c=1 sm=1 tr=0 ts=686e94ca cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=U69l-bc0htRqziZ3G_gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dVV5l5ON7Z2hMuqLH2ScEhTMEHbZgE2U
X-Proofpoint-GUID: dVV5l5ON7Z2hMuqLH2ScEhTMEHbZgE2U

* Suren Baghdasaryan <surenb@google.com> [250709 11:06]:
> On Wed, Jul 9, 2025 at 3:03=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> >
> > On 7/9/25 16:43, Suren Baghdasaryan wrote:
> > > On Wed, Jul 9, 2025 at 1:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> > >>
> > >> On 7/8/25 01:10, Suren Baghdasaryan wrote:
> > >> >>> +     rcu_read_unlock();
> > >> >>> +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> > >> >>> +     rcu_read_lock();
> > >> >> OK I guess we hold the RCU lock the whole time as we traverse exc=
ept when
> > >> >> we lock under mmap lock.
> > >> > Correct.
> > >>
> > >> I wonder if it's really necessary? Can't it be done just inside
> > >> lock_next_vma()? It would also avoid the unlock/lock dance quoted ab=
ove.
> > >>
> > >> Even if we later manage to extend this approach to smaps and employ =
rcu
> > >> locking to traverse the page tables, I'd think it's best to separate=
 and
> > >> fine-grain the rcu lock usage for vma iterator and page tables, if o=
nly to
> > >> avoid too long time under the lock.
> > >
> > > I thought we would need to be in the same rcu read section while
> > > traversing the maple tree using vma_next() but now looking at it,
> > > maybe we can indeed enter only while finding and locking the next
> > > vma...
> > > Liam, would that work? I see struct ma_state containing a node field.
> > > Can it be freed from under us if we find a vma, exit rcu read section
> > > then re-enter rcu and use the same iterator to find the next vma?
> >
> > If the rcu protection needs to be contigous, and patch 8 avoids the iss=
ue by
> > always doing vma_iter_init() after rcu_read_lock() (but does it really =
avoid
> > the issue or is it why we see the syzbot reports?) then I guess in the =
code
> > quoted above we also need a vma_iter_init() after the rcu_read_lock(),
> > because although the iterator was used briefly under mmap_lock protecti=
on,
> > that was then unlocked and there can be a race before the rcu_read_lock=
().
>=20
> Quite true. So, let's wait for Liam's confirmation and based on his
> answer I'll change the patch by either reducing the rcu read section
> or adding the missing vma_iter_init() after we switch to mmap_lock.

You need to either be under rcu or mmap lock to ensure the node in the
maple state hasn't been freed (and potentially, reallocated).

So in this case, in the higher level, we can hold the rcu read lock for
a series of walks and avoid re-walking the tree then the performance
would be better.

When we return to userspace, then we should drop the rcu read lock and
will need to vma_iter_set()/vma_iter_invalidate() on return.  I thought
this was being done (through vma_iter_init()), but syzbot seems to
indicate a path that was missed?

This is the same thing that needed to be done previously with the mmap
lock, but now under the rcu lock.

I'm not sure how to mitigate the issue with the page table, maybe we
guess on the number of vmas that we were doing for 4k blocks of output
and just drop/reacquire then.  Probably a problem for another day
anyways.

Also, I think you can also change the vma_iter_init() to vma_iter_set(),
which is slightly less code under the hood.  Vlastimil asked about this
and it's probably a better choice.

Thanks,
Liam


