Return-Path: <linux-fsdevel+bounces-62121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C3B84ACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7729540030
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF0303CBE;
	Thu, 18 Sep 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H+04e4qU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uYs5XEXu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2331D799D;
	Thu, 18 Sep 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199821; cv=fail; b=p7hWZ5OGS7PqiQC7rs2kiJOr68PodQ4wx3+29saRKToOZo3ItWFDigGTDuQ2LkXY7OtUowxZXA8as8Tun6v7J3tZIdD+1iV2RfnU6+JdnnSM7W4vWDMWL+l59beLyQQWEhRv8WNbcyBBY2vzLOxP7zuBPCE0WkT1bT4UpcceoJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199821; c=relaxed/simple;
	bh=LKF8i+J62XidyaR5GpA3ujesA7OCJH1fNU9kpozzEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnYWIRKGKbfICQg2iDxwtva7FZOmRctt6OOUf9GORwBwhT8Adlv7w7qeyUfnMw0jfXAUJpTGJKIVFGq458XPuLFXy8YG6mGx0/CpLN5ZKAY6AIPH8IdYF5TgwypiIoE0IB2UEqhoCPG+Xgmj5+NZMYQjgS4w6zelp3X01AWQfmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H+04e4qU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uYs5XEXu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7g05Q021313;
	Thu, 18 Sep 2025 12:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RqYIXNX4JcfeunHwKb
	6ocSfL6k1xjZ+9n5tvSSa6nqA=; b=H+04e4qU1DxjdHYrrMZ6euPA8AqRaRnmLy
	41qvVzCT4Xs9QMvUj64Q86s68hk2MK9oxB2nA8AnoMLSAF3+GEmRd/55rrjXzBtn
	VBtSy92RevnYXW6/82bnzbewWnHVlkJ5VVgXfPfELVhbMEu2hHSKISxDlIBOneo+
	tQuDnHrz1ohQ8rEQ130AOhwsvc3fKLTgDWUNTfXnaTIglpKZp8V7VS+OzzJDO8fg
	GYDzb5yVSbgpj3ciBk9aibwxkXzQ9p0IojFxj+Zn4rlDEFHjPltaG3yCP2V1wbdK
	IoBc7G/k7IBxzaWE9TtPB9adGbAasP3f08cPukGEJSctNiPP10Hw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9ue6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 12:49:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBPMqa035161;
	Thu, 18 Sep 2025 12:49:38 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ncms5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 12:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZojarSDKZKWku9u3Fo8a9UhG21SK6bWgNvI1OZeiPcESW6AQzOw91Q9Um2vCfHNEnywo9rsvQOg9A9mqEG66jKR5uyGfq1eZJ3H0EVO3YK8lfCSDAEhYL3hJvLiVupcvhNx8BsoQjmHGkAEdE/Ng0jykxzE8iQeLWciWb/UX9U1Vw0I18u1Ooe6KqLKhM5MYAbzbgtwW6Ho43G8sUPJx6/xEiJqxG0GQ1yF6Q1wwyzCryCTFvuKZVHbDqVBkwpsLMTc1tMcNxN9W8Ud8XHuseLV/VXbv435G916e8CpIad52l7y0Ejm+Lu7yimsmkc3WInteqGLjOJvGQBrofWJI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqYIXNX4JcfeunHwKb6ocSfL6k1xjZ+9n5tvSSa6nqA=;
 b=NMEsg3Ep9eQVQXSTTvgwKq5D3hSexhQ/MfjB7UwaKmZHarUL3W4h0G0jS72ECAZRCeYgczEd40nnw1eb2cv+wKpyiMa2y2vNadlKeOIMsoWgAOpBophpmZITe4KSdGaKW/r77duKx8eoK9YWmc4Ib/rfIu1EPlRIcjSL+5jRtuSBdDh92meo/UOxCLyHvjLHAcnr/dpMDfR2ks3yo/u+fJUTH8cR6c96pBGBY4wq1fZKQmeVXxOdbrirPpCx0+N+uhvNeyP0MzgrvNgKy3nSrqNNusY0zhyiBa0uADqJUZ+BTp9vDjvkdBjwb/M5Povo6mCPLgsYQugi9uaJU5bl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqYIXNX4JcfeunHwKb6ocSfL6k1xjZ+9n5tvSSa6nqA=;
 b=uYs5XEXu/WDgGdkCrRY3Dik7E16BZZwx10wlnjEO17lOFMS4L4PLd+WB+5OUlKhFC4O3hfod38xlVZVV4d1+qf30p7hwtmltUpKMVtVHxqr/0en7Hk6MNwooTULWKmTdnDyz6PSb67zkPLTyz3D/pSTDMUpYNJHHGKHPy9Hd4n4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 12:49:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 12:49:35 +0000
Date: Thu, 18 Sep 2025 13:49:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>, minchan@kernel.org,
        Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
        kernel-team@android.com, android-mm@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
Message-ID: <7e3de8d3-c064-4ef4-85f8-48294a238336@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
 <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
 <20250916191645.15aae276992acafe7f7e723e@linux-foundation.org>
 <e85d0b14-28dd-418f-872e-57c0127ad572@lucifer.local>
 <20250917163231.b5f7b8012367f033a91e6f9b@linux-foundation.org>
 <cfabded7-442e-40d9-963a-597a42da581e@lucifer.local>
 <0c068e35-0954-43fd-b3b3-20786a6a12fe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c068e35-0954-43fd-b3b3-20786a6a12fe@redhat.com>
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: de8d53f8-0575-4f70-aac8-08ddf6b1d26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KefmNZq9gmCsExCVJ1tEwnSmj2h8Ef3LkuCqa3ggMre4vm/Cp3zYnPZAJv9P?=
 =?us-ascii?Q?oHknzVnmMo7CUoY+NbMBqBRrLbihFvjCBA0QxsxzTlASZWzglyPuv3AzIYU9?=
 =?us-ascii?Q?9H9XFcTEdvkKqLft7rAD1Wj2BqGL9Dy2ygao90AsyS/UW60Ih8MxA2NZ3kYs?=
 =?us-ascii?Q?Wa0Wu2UuPhDZcdlo9QX7OPR3VkPcnkh4a0xhXzTNXrGU4u7FPOYn270c4IRN?=
 =?us-ascii?Q?lZyjDsshaeMuAQNnZfjqIyH4dFyFEVCe0+gL/A7CRo9N4KEpxYgSCCPEuY+g?=
 =?us-ascii?Q?o1pa4brdYai25O0kd/maciC3Y3+atGdC8TpRZ8vZgxnrNvPPHbLN3oY4FFfh?=
 =?us-ascii?Q?8wLM16CGA3v7rzFDMheDO0nCyZpJzoRyQV0D1+ANWjY5G9W27Z95ChjgKWmL?=
 =?us-ascii?Q?LMCz+U38UA7yJ2YzQhLEtkDtv7nOWuGWmEiMJwIoZUZGpXBnQw1Z/pkVHiUD?=
 =?us-ascii?Q?JB67S+ST9PwOv4hyKWzRBsWeuvA/1tXowXNYE+zeSdz+QeSQnGSAjSKlhHSy?=
 =?us-ascii?Q?cNovV34g2we/gmW7gVhUJLTMyStVA/cLhOk3l4HUKqBIiPOSRXZUcvZPoQ6N?=
 =?us-ascii?Q?tRZqvM6gdv9LwC5z2tjhhDbnjYhAtam7BgOJ8itdEnBVZxeBvqTpO6/0CkEb?=
 =?us-ascii?Q?nUT6WDeuyEFXb1Ipt/1Sjz/WbqIMBGJ7q0H0e66jsFyfORlOqGqqsq0mHiO1?=
 =?us-ascii?Q?qUFhu3DTud18DddIlIX7XsIos7pg5E3I3Gan9V1PQt27wdstBovba+zBTZJE?=
 =?us-ascii?Q?14d5eW4TMdpS9D4cCRpfJqJQhGAb8YHfWuzJt3QI4Ng3moH69JM/Fr9KzsX5?=
 =?us-ascii?Q?s+91bYLCiaBxcGsgBObyYAPqlHFducj1prgZw+vAMRluyuzvbFVMZgfYf1Kn?=
 =?us-ascii?Q?EjB1gLyFkmlWSJfUQuFpd2PafHXm08xYEWWkdh6m46hcnleY4t9ISwyVy/aM?=
 =?us-ascii?Q?Nsv3y8rtIhGTZvIEeNV2N+LcW/t8e51vUW6Ls9JNh+U683a+5B0ENT80OAtv?=
 =?us-ascii?Q?UGBCCsQlcJc2sYMVGzyJl/IQXzHhetb9F6MQCWCWVFubwvTy/SoqcN2LVimg?=
 =?us-ascii?Q?MS+2jW3L1NzYcllW8Z8vYfF3ika3pfgI8zDDo+2AZ47ttHjkarH5H2inZ5BR?=
 =?us-ascii?Q?sxX3LCOFtit3Q5ijBvddrjKYls2+NhYu9d4cXf6GQlX0Pz0bOFoe1nVYOZ6F?=
 =?us-ascii?Q?k0dXwqnpb+F5KY3Ewhteyu+Mm396pDRnblt+Sw12aQKbP6jQzVGTRdecWyv4?=
 =?us-ascii?Q?CNB1ZHN2XI1ae4/fka29TUFpLIzf1NLQpnrgO+JVrBz8TTVbcaKABjk1GFd6?=
 =?us-ascii?Q?M0Lg9oHFdCAucpXga7KLh+ey/jSsS2Dws8QPu+uX+TUJPSkAUFXHlcra7jh6?=
 =?us-ascii?Q?wuvWNRM1IdyD63FP/8zHDTcq0v8JMJYfGjJwvryLEtmscLpeLFMW+O2aIfig?=
 =?us-ascii?Q?8XY76hDA1h8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iFNXG+brXAZm00UX0XhEpZ8LTifVPmyuE2HgcYm3zUxuj6W06W+UtzZZPTSX?=
 =?us-ascii?Q?N1Euilgjch48Tdv/vu2+d67wkI2LVm+R/ctEL4pHx5zxZoIIyNBrMrQZSxGp?=
 =?us-ascii?Q?2emMhyWY/7GYTPqlvXytNhRIerlgmLBG75D8e0Xy4LtveVGs/ChcuWW4ev7D?=
 =?us-ascii?Q?fmMHxGaYgu541E9if0SkMggTDGwZbpW1nd2ujLGbD+59ZW6brs48NQLTzX+/?=
 =?us-ascii?Q?EZAjf7XuK2pg1IVTC/Q77vBLW0ZmAXnopgDsZ1V70Ay/v7eyBnQ3JKdP/jDJ?=
 =?us-ascii?Q?/tBA9QXlBoxBxQrAfoRjpmS9/8l8K5wW/YmXtP1dOWXoiqtcdCRj5htT8Qji?=
 =?us-ascii?Q?TM/rULzX428rB76eaLRJ/ed4ZL8YYjqr/DgRGJ8CXVxDsJDVyLDfPExU4Klk?=
 =?us-ascii?Q?8RBT4nKqkWyE1BcRommb1iqrBdU2s1GDkUJpYPjxpuRCtvh9bJ8m0ABJq7c8?=
 =?us-ascii?Q?cDvGVIyi11K/MiFehRX21AZwP3hifste/uf9AWTMm51QxL5K2AGYI3K/Yr9g?=
 =?us-ascii?Q?VBhELrwdpI0cVa5MLuUDj2a7dW9+1lGa3qsVeooPreoKTiTC/B+kk7QlWvh8?=
 =?us-ascii?Q?Y5DI4h2gELEp77eCQIN/H+pBrh6tD0AetlW6XFKXa6bJS3TCHz7DB+HhN2ml?=
 =?us-ascii?Q?1z2sW9S74H5qgT/o1PiABS/c/1lohqdsOc3BBDcJLksf3eMC0TeVcU4uChuS?=
 =?us-ascii?Q?GZYppdQPFn6fMA2zS6S1u+zpFOtSo9TR2CkkuU4tj3nxm+kux1F97Qq3QmDl?=
 =?us-ascii?Q?EW89+rCt3ttRA0KKVEZcU51zNaBgoL9plR6gKbhjBK5IfLZu8L593BHD4zsO?=
 =?us-ascii?Q?5wYBj/cTyYaWdMLMyx9M0FOu4U/jkW4VOTUqUd4U8WshfgHH+if8JwSuaHhc?=
 =?us-ascii?Q?LL+rbaK6NPbZrHTaVuNhy/hHh7qR9tvLHgxs0EKvsdGT1ot/a5wk7bA9kehE?=
 =?us-ascii?Q?IfdLI4oTCJOFEL90Go/ZWcrKKku1WvE7e2sL/tEyHPBxXy8ckHv/B125x0qz?=
 =?us-ascii?Q?gIx0g+hS2PRxjExCukdVN8u9qfVOnveS6DvOsiT7lDsLHA+Sla9XFWoFHe+8?=
 =?us-ascii?Q?1Ntu8t67Qy+P3ZDaWX7IoYELsmq3RwahUWUTVt7axgg7XINKtAoBXyIMUNto?=
 =?us-ascii?Q?ptCTTvk7odch5O1TJ9RnvI7FTLu2IBvgRIU2CBKt/2U2Zc/ys8jPvMHRwOav?=
 =?us-ascii?Q?pSzAEAlkjMHvzErUjCnYG+HSOv2tc2/2Oxq3zhXeBpJhBp9OriHCtl9Vw4dp?=
 =?us-ascii?Q?todIf2nPgE9U8sUf5RyhY1KLHztDR8knQ4gmQnEaMyG6HESbxT01GWtXEeZa?=
 =?us-ascii?Q?kVeIMqpAR/WVqrP1lliJsqzPmc7Ua6USlew2X3AhBqUse9ijVdGaPQ7IXcmT?=
 =?us-ascii?Q?l6G53WRgDof1VSmWBhtJ/T+qVOvi83SkrQ5M75UenO4ic1ZhsrEplyAcRB3H?=
 =?us-ascii?Q?3vpvkAjNZoe5zgafFhLWmJYpvS8mqDpypygEXI++CnKInorF9IJApxjSBZZ4?=
 =?us-ascii?Q?8KzYJzBnjRsU7fKR1PJWcMtlN9zlVpeTOGwAPADRv2xA/9mIwurrQVgXMUGM?=
 =?us-ascii?Q?AQSDtGkPhDpSoSDxdAPlrA/2jXR2N/rIcp+jyelBtmJsmwfORicSkWxztRlS?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2lb1DRO+zH4jQcZYwn/PV0QKAiiagP5mrY3gQutDwkkqFgxLqIl6rKvKuvNvM0IWpRM4I4lzygX8L9NSoQcQVX8KjBAyzkEiZKPrBQ1iCe7zgd3a4/2g8PLYIg8p+USfx+8afZrb5ONbmXcMJUE48MGBv9B4oXbitPocZ9Ka6xjZhyMmpKKxArWeb+eKKqCqifz/S0pb4JBfGjg/HvZtV7z5iYhGdVNIUbHXcPcyvYXfc6RoSOw+SJpb+LLkoz25hpIg9RPo5qvwFQWLtc7Vl6aogIW6uySce7yozIE0q0R9BvY1VZL1X4ynm+PZJAp2xDmszsqI/ZthYVIJ6im7M8gKPKlvBAd+vIBX+7Anmt5dsncLIKESSNGcUK/tVDJTuMRnducyV00LlCLuJzQneARxYRjRWWnIqdqVi3IXFzCldsXxNTOQkVsj0rRK3vXWSUICzCNmkCl6z08QT51667PFGdPMgo3DEKbNp3NbcUo36cGzbVO0gBl3oTxSy08LD9zZlJa/E65fhrhcSKnE/51m2zopIcRpLsBKzgSYa6Y3wgmiPBqd/4wxlfElwmkp6mmg6BRLth9kF1/CfWCakZDXh1V8lk6/SNQVjHsLNQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8d53f8-0575-4f70-aac8-08ddf6b1d26c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:49:35.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUOGMXpl3Y/DRRmUWI2vkkP9xYRD3MCtIHqYwn++ZUbPq3/IIuvSk3OCMTOSKVUs2O+yxYZ/oeF0kKqHffJw7Sik2oeW1PZ5Px96foOovJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=891 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180119
X-Proofpoint-ORIG-GUID: GTiSMrfrp7u_D5RmB1k6Rz2QZ1BFG3XO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8DgZ9Qexov8L
 FQVVUM8fNK4yqWdCKeHW1R7LjYJpgCGFWz+3CUXpHSCGFEpNK4aFMl9uQDF34TeUnf15Ts0/AT1
 5ecRk4G/4i2XBk8bkiP20F54rXhwgt0Yp9a73hnGryI4+fewlPD+aXIbzX7MQxeK844EsHt3Wnf
 nD5jIYnlNaD7x/dbwsKg5Rnu058OKId0BUjhpNFtbdw1Xnt9RLRPIE2iMgG+84ZftTHVVZbUjdr
 OjIihm4SqpacaVIsJ4MFCKq1ooJbuNxBKv/MS3bdfHqqZwVd8lTh+SLt9SZS9Pwj7uCsKQk3c0v
 oKyNX5mvEA4Fs/k86fuS4xhj0e7BBD44Pf1jK+8LkiHsWSRP9n0r4zcA8SInkuKSd6Nv7JxXEHE
 P7occWELVtLYxrqpSgw6hxqAPxbnpw==
X-Proofpoint-GUID: GTiSMrfrp7u_D5RmB1k6Rz2QZ1BFG3XO
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cbffe4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GLR_7Sl-ljeOgxV9bYIA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614

On Thu, Sep 18, 2025 at 02:07:09PM +0200, David Hildenbrand wrote:
> On 18.09.25 12:29, Lorenzo Stoakes wrote:
> > On Wed, Sep 17, 2025 at 04:32:31PM -0700, Andrew Morton wrote:
> > > On Wed, 17 Sep 2025 06:36:34 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > > >
> > > > > > Perhaps being less accepting of patches during merge window is one aspect,
> > > > > > as the merge window leading up to this cycle was almost the same review
> > > > > > load as when the cycle started.
> > > > >
> > > > > I'm having trouble understanding what you said here?
> > > >
> > > > Sorry, what I mean to say is that in mm we're pretty open to taking stuff in the
> > > > merge window, esp. now we have mm-new.
> > > >
> > > > And last merge window my review load felt similar to during a cycle, which
> > > > was kind of crazy.
> > > >
> > > > So I wonder if we should be less accommodating and simply say 'sorry it's
> > > > the merge window, no submissions accepted'?
> > >
> > > hm, I always have a lot of emails piled up by the time mm-stable gets
> > > merged upstream.  That ~1 week between "we merged" and "-rc1" is a nice
> > > time to go through that material and add it to mm-new.  I think it
> > > smooths things out.  I mean, this is peak time for people to be
> > > considering the new material?
> >
> > I'm confused, why is the merge window a good time to consider new material?
> >
> > People have the entirety of the cycle to submit new material, and they do
> > so.
>
> My view is that if you are sending a cleanup/feature during the merge window
> you cannot expect a fast reply, and you should not keep sending new versions
> in that timeframe expecting that all people you CCed that should have a look
> actually did have a look.

Yes exactly.

The problem is all the conversations and respins and etc. _do_ carry on as
normal, and often land in mm-new, queued up for mm-unstable etc. unless we
happen to notice them.

So it makes it impossible for us to just ignore until the next cycle (or need to
go through every thread that happened afterwards).

And people know that, so just keep on submitting as normal. That was _really_
palpable last merge window.

I mean I'm cheating by going on vacation for this merge window ;) but obviously
means I'll have 2 weeks of review to check when I get back + 1st week of cycle
to go too.

I think in some subsystems new series/respins are actively unwelcome during the
merge window. I wonder if we should be the same?

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

