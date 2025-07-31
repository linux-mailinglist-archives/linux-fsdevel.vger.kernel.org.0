Return-Path: <linux-fsdevel+bounces-56372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39510B16D8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC658350F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE3229E108;
	Thu, 31 Jul 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oF5tW8Cy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="biKrnuFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB02957AD;
	Thu, 31 Jul 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950617; cv=fail; b=HLWJr6amAn0RQLP0GyycLk8KJN9F0Rd5DvszJzPzsipKWQJS3Z+BVKaj1xZFDCRNDmI4A3P8m74eSUfRyZhqh0LEF0Q3aw0J9yKH4/gLftqp0F0ZpvWUMVRmgPC6FvE3U6QpPahigTA7v0tBHNrkwlXUbwoqBjkAMBAm6Y0saHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950617; c=relaxed/simple;
	bh=0C0lTo0wQTuAgJN0LH/7ClHF8DQrh9QJMqz9y/5Q88g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NtbgQpRzFLu6LlgXLDyH9feW0B0gUB486FgGw/HZsSXzSq43AmCsfX8vJ4GctTXk5wyRXZ67dNl3aBzMAM8ExOZBUaRfKJ/Dh4DQE8Jgfc7UbENUcaKcYzijWkoXE8t/ctjtzIlt3Y/qHYANrInevHvPz645Jb62RoU/25SEJnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oF5tW8Cy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=biKrnuFv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V7C3nU009868;
	Thu, 31 Jul 2025 08:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xoeYKEl+Uh5PoYVMGE
	K/2dqD8XU1Ns8VqpAX2ayCbTs=; b=oF5tW8CyG1U6eLHfTbQoaTB/JfKA+sTt9X
	U7NOPF7LfAjzT/7Q1cYZji3Lwwkz7Njisun8yPvGgivRnUqlbWIU8lBpnXC1aukX
	+Sq6M/HqbPBtvmkpNycIxAUMTdRygwDHV1Lwv3Da70FS3hsnSXMbBDwarWv4+4GB
	k6opaoEcFTs3MfkVTHei+1jUwGBFJdOPjJBqKdsh+swp7X/JFMYE0CqaBNfbQD2d
	4aNt2vC1ArO5/xvCMrfYLhIHYqMGYe4+5puTNKbxcZ8Yw0sFL/wdlMsXJaGwnR69
	EBsmr3Jpi4njEmpZ0plaxHJtnxPuwY6N+kO25PVniJ8W6c5QerlQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p0fwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 08:29:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V6qk2O020347;
	Thu, 31 Jul 2025 08:29:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfjh7e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 08:29:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJISW/hfiC00gNbARRIh90Fj2X51ix00rB8AGRLVjerHmmQgPGL6t4DRQAMLqQYJksKEFiMdAIL8cd0MwtQbWgij4hiVXOZEF8nnmbG4PlvR1Un79efOSSdQjeeXQPJ3dDaNMSVYX3YVEufY9gWO+cgTiI2G8AB5N2c66G62ZRiGA8rLqyRnGdS7H8l9VS0PN93JXI7ZvjYE70BIoDXWkykfPsIgIPJNQtYwjcZHWkbQrYlYzOljQVRUuC760QyUtDOBZxHxzneJHBEunmnWt9R5XIwSnHhYCXa/zVOiD3J9ZReTmI1lKphl+XmICQu5qHblLgRWeydCnIT8nt1f3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoeYKEl+Uh5PoYVMGEK/2dqD8XU1Ns8VqpAX2ayCbTs=;
 b=QwJFRDigZ/2Z7JHen8Odv6YeHwI/sNa7xtVlxTWdR60scEnsYgNpSF8zyRhGImC5326QSRUDuangsz1ye2reWAd4ykpXsqdOZd6J/CtwDBmYKyNjOMK3KKle37rmaoFjypEluw0oStUJ2AS2Ym/VKZJwljtl6VrUXjSA2pmVxmPxPe4iI9CxsqW3zZ68lRs6OpwuhoP7Dp2Fn8RULgPa5QVhv+XJjgnw/eQfNCv/wbBIB71RokmteMWWgYw4zIeR2XunRdn8vxHpWyuEBLGt9INUAqfOCYYvFKWUdeLlWBbOMLU/6roSiOdoMiEbHAbxZAUuX23Nobqf3qry8Cb/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoeYKEl+Uh5PoYVMGEK/2dqD8XU1Ns8VqpAX2ayCbTs=;
 b=biKrnuFvdJGs6x3KzdicF8rwzturc8rwA/b+Ni1W0a57Wyi4jSlA9AO+TQhseu8y5UCeIxvImIV2Yy6btXioMkdh7M8s491TCodKSkhs7yb7kjpgPx1LCFEWITm8SCIBoztDjPtXiv2be5csoEkoIi7HWgcQVSvlURiQifBOXlw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYXPR10MB7923.namprd10.prod.outlook.com (2603:10b6:930:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 08:29:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 08:29:16 +0000
Date: Thu, 31 Jul 2025 09:29:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
Message-ID: <41d8154f-7646-4cca-8b65-218827c1e7e4@lucifer.local>
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-2-usamaarif642@gmail.com>
 <8c5d607d-498e-4a34-a781-faafb3a5fdef@lucifer.local>
 <6eab6447-d9cb-4bad-aecc-cc5a5cd192bb@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eab6447-d9cb-4bad-aecc-cc5a5cd192bb@gmail.com>
X-ClientProxiedBy: AM0PR06CA0125.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYXPR10MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 40da8210-d7dd-44e5-7bdc-08ddd00c5650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtPs9Ex6i4Xdi+C7GClURGck3rgDJPFbh00d7sFo488AmCQv3fsGM1Wy4bIT?=
 =?us-ascii?Q?2wTipDNvZ4asa7FOXVckyenvEDiQewzzPRUEj/hhWKbcfEyRhYpx6m0L8yqJ?=
 =?us-ascii?Q?R3Zt7GxczTluIMncgmPMqRLpVwRMdqQXQ1LCHa2ifLjmqfMr9Ne2ShxPtIpQ?=
 =?us-ascii?Q?WHM3bH0QMYlz6KWIIYGSb2M7pEzwUzxEmyYXS9yW77ylZ3GvrZDFhdbRWaMC?=
 =?us-ascii?Q?9uA4ve0ZaR7E7A7aZ5R0It4IvMb/8fpGivHQWChGtZ+kmdLgBUUgPSOfJCsf?=
 =?us-ascii?Q?iXDiAxkq2juJYf1lGhHpB3HW8umNB+haeQ4m3hR+eiVr0rOpUgUvZroF/WMP?=
 =?us-ascii?Q?vj1Q11VC7YCwIR4f37at7lKfiAJ0ztvkqIZn2V8u6RwnR8kIQ9Jv9A8ulmJj?=
 =?us-ascii?Q?Ot3Y3cwQYdwDHwXNEfi0+BE/FQaj6Iaq2zDVUqm/S3xmPAEGhxDtrpA5gNel?=
 =?us-ascii?Q?urctloCarEyjkBXzm8Z8IrAQLMHv8Q4PcZ/1BMNaZByt5SRRVOUT/XyN50Sk?=
 =?us-ascii?Q?aQO4uvjtAsyWSSzsW2X28sI8Q14Kkhtc6WC3Rg9UiDN18P087ShaDNZt8/w5?=
 =?us-ascii?Q?o7RaYrds1zMOTceEMTo+R1H6hylfCvoBT+hjynnt8LLdAuoK7uq8Z/HqYTB+?=
 =?us-ascii?Q?0UV95Jwcyfcl7/ZyxW2uXEaHb//brnK2FYxEC4WqZw9AF4wMw7GevjCqBojo?=
 =?us-ascii?Q?mnSvNpCOL38uuGFbyYmWuGI4h62vRKv9DWJJev6Hms0nozIZ0NK5xZnkv4aX?=
 =?us-ascii?Q?EE+4K5z5msKWRJ2i0knkGB80uCO7dF73t+uoaYnENZR/MtyHoblaVBph+hdU?=
 =?us-ascii?Q?GWwucKrAP3aqU7qsUdhS+XbQianG/bBmX/QNfsPnT3h6KscbibujWQOMBgOx?=
 =?us-ascii?Q?99+TXVOHGo633QDMtJWrOwbhkRr9eTiv8pr5zPT5djdWPJuMkSIi5OzhF+2c?=
 =?us-ascii?Q?JgX/LuJewCPR8+WagBh8TL+pya6D9O2dROMLxN37UQhdiaaHHx4j3iB2VCjl?=
 =?us-ascii?Q?la9n2hByyO1mSHpbw1FjCNKXywhvPWm49JeqHNDoVjd6zBjpfu5t6DibOq0U?=
 =?us-ascii?Q?0+0diyKf4TMzpLRGIo83cy6jXKCaIxPVzI0hdhzl2LlzPDfQhtMYBzw78vUY?=
 =?us-ascii?Q?eaDemNhK7yWI2Fi7z10ByOV0aBJc9v69CjTU0joUdpmbezZjxSI5veDUKHHl?=
 =?us-ascii?Q?YfUx/167j5MYkdJdIDGHKOrK6W+kKWUmNQ0KGEtTd9V+47ntGyhB6B+rxgKb?=
 =?us-ascii?Q?XXrSe3hSmuOnjOL3wwo0ZoP3ZsNNjOsD3X073z9S8yuP0vbDJ+xje3o69llP?=
 =?us-ascii?Q?mrQ331cjtSaqOy9MghiTsGzesOgXl3fNWaEBDkFyYHuglGzsLIcCGovpJCUc?=
 =?us-ascii?Q?Ce7snsR2Mv/Rju2mWDdSEiWO0uHmnchvRocBVn5Y5cwkAtgyMgdZiSD1Sg1S?=
 =?us-ascii?Q?x0NMBaS1kis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?psDBmyiRxiudi4TOGr1C2arW/MioM+YFf62bCEZmW0Mwmmf7/C36WU9Wb0Xj?=
 =?us-ascii?Q?tF76RV7WDUlV5PyiSSOl8mz3gRehmg/o7XLA3fUf17cCXsQIMVS6zI1bVtHP?=
 =?us-ascii?Q?CMEAkr00gJuRiIfzoVfTd2s2hz8icWlUw9txkXvfos0l/x9q3BL2AlWWUQIz?=
 =?us-ascii?Q?Q9OsLWXaq88mviAyjD5xXBiSnnmu6eslLDzRSlb/u55mqFRLFZOVAOPramEY?=
 =?us-ascii?Q?fZufd+rgkPb8+GCBEN+FuRhKTyeiOMWPp7S/RVvmuzwzGk74WaZ/I/4lgcXT?=
 =?us-ascii?Q?92kx7D+qR96VTFyg8ulAZkk6FG4uqs52tXExAwrfLwmPOUcdEs+Q0Wy9m9Yj?=
 =?us-ascii?Q?WiTFpjUQNyr6oa6o9MebcVBXcZ8wQgGrhCDuQ3HZOBTq2S7vV4LI4CIlcY+w?=
 =?us-ascii?Q?i7eYhK8zkmw+y7F+X2Wgg5iTGpe0oeoeF5jsbHJ13hGXQ0ywoJPr0ELfJ1AY?=
 =?us-ascii?Q?yi2JXytkgWbWen+DHW1RvTVpyf91+DJZDnSHAzCT4zd31me4mIfc3XtDbWuj?=
 =?us-ascii?Q?qwfECmX/VShDokPqdCrJfEj1P1U9YCnPMZ8QFtY6btN3UZ1pvfkdokI5jHKA?=
 =?us-ascii?Q?dyNAfEsNWc9ANkWmOJfIikuwE+ijVP1jsPu/3+vuDcC5XYsM4+XAfJd4P7N2?=
 =?us-ascii?Q?WCOTSexEuISWGZygdH3Fmj844s2JFwx9h1oC6UY/XlQS1fl4kkvz/sCwxJkc?=
 =?us-ascii?Q?n4LTjKAz89TuBJnXIbmjcajK0Zl9mOwu24uonUhKFruW6SBiqrVvUkzxWIiH?=
 =?us-ascii?Q?0dj5nybGJXnXKGvKIJhZKcv+Jo4FbF2wZJ8bQcpmyuG9o6tS498RQc5WC31W?=
 =?us-ascii?Q?gRwtcAan7optQwQTyQ8HuE6pk5o1Q6iGCYvTIxmV35vlQsMNc5Lfyo3uGY9B?=
 =?us-ascii?Q?1eHrIb+E7jFbwH52U+tWjzhHgTybYzX/P1NjG6ufdpOzpKGBsEA7Jjm/b6lO?=
 =?us-ascii?Q?nQQwuBnTHRErA95n3669SMnxxUtM6AZnojWXfVGBlUZ5AWOmvDz3XN04POnw?=
 =?us-ascii?Q?EtGtLDI7XtTTgsRAzXg888HOQemhabIwAYey+nBbYcdbF4fv2Pgwqk23Abvq?=
 =?us-ascii?Q?EsYPd2C3UQ/rPWIqY0Q67nn7OHRTCtfpFwnlzgI3LL0SrhzuE6uiBl/8kb84?=
 =?us-ascii?Q?K0G81IzLYnbOj2CHWsLF8KUzqq32wQqLoxO691H3U/klKsWRdtq3HBqPsOJQ?=
 =?us-ascii?Q?2UBV7UMneUGoEzMLmdrRo+uuSUD6c0L+942WZ3N4KYrNtI9VP1Sw1A7HMpV+?=
 =?us-ascii?Q?Alp7Mcme332ggEJLul65LbMV3r+bTKFYJ2PM9S01RN1EABIY9HwgqYtt05n8?=
 =?us-ascii?Q?dVz177cYqE6001feO5OJKRz42JMA3YscEl5WSCzeidHnKDDZHQQebrg3zUS6?=
 =?us-ascii?Q?l0ECqpUtKCH2+taa2pTBaMrJ4MAYpzmgW6aCs71K4bmONZFicoQjYd4TvOHz?=
 =?us-ascii?Q?2JbYjHy3P+j4O1RG1/h91ku9MQ8LVNIsNNJDYcnugFYEzzmiRZ/TdoHISa/G?=
 =?us-ascii?Q?KZRPakXNUSshNAr6enyG+oKeLKCxlajkbsuOyCoXxAn+uaDnS6Vr/JfxFfPr?=
 =?us-ascii?Q?cfpX5beaHxQheyWx/gUnhMSYqs4MdeVOY10JmJVkZq9JqzNe+dfKlWgGzWW7?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uT7MsZGxSZsNBiqipp+fX5DPjbXViH3tVKhcFeL5oqRPpSh8qDsK2nxHKTTsjzfVBoDaSHBbsTjNfmun/oV5XljXTlJOmp7+kQw/zaCTlYbLSiyYog+V5PTMGOGDNDgHD7JwUXvL6IwqE9x57zI9Epu+gz4KxFT5I3cpZMpPDV7LrJU/1L/NomZ+jauMBJ7QNJPw7lTCF5IUGJIr89B/DaZoTjz9b2cdTFC4TMvG71QSmsxbM1nRVkhXadhP9Xkpa3rjVLHBR0XL0r1c+ecEcAw+h41sT7dZ580V090p75hfjel7jyLbIn1QGuaScpT68NlcnPovKhL5xaW7X5MYCOjKKfDETf+HOyhW/QMgUInJCkis3i4Gsy+s8jQT/0FvCfsfvKyCMfkMRfBLb8N94ZFncqeqt8wO2hG1vOkTgQtyN4h5nzAjMvSWzf7sjmBNPqOHIU4VqsRHu+aYtEDWiw94qNdZG6bx3PekMrSbucLkpK0GB+7hgG2YxM3hb7XPiCE1u3xEUaBqjkpGL9OheB+eUeEyodyvxS+yOtHRUYvMi9er7ybFo25wAuZ4d02vhQUyFGPVBHFf61sBDieK6qYdkZrjv66vzVTSICAV9eI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40da8210-d7dd-44e5-7bdc-08ddd00c5650
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 08:29:16.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bd8hiCc/9I/S5bH1MH8+8/uHJFWQyzwP8BS9JLRiMCPAc15MzeZUUxqTTB4abQCKguNqjz95ful28NNtBr/46XNGOuLKr89PguLdxpuwQn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310058
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688b2962 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=9t6k1dWA5BB_nFc6OMgA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12071
X-Proofpoint-ORIG-GUID: JsiCfdE5k5lBoYffx4TqkK-xC04M5z1O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA1OCBTYWx0ZWRfXxhhkSwibK09y
 ZwBL4J7Hm+PlKmz+Hxxv5W2t4xnvNhae2P+ildTpaLL4U9aKfzj6S44lsbgLMf+f6AWa2fX9Ja9
 0FLxEd9BDgvBC48oxTizv7ZdGuYxL0UdmGECqkKep31OZ5EbMomIfGfQBJ8fdaSyopVXKFkZY2y
 oWmWjQS0pKRiwYr885tBDWVfnt+ZkQJ5uiPAJa8T8vH7bl0TVkUTZ7nU5aStdTFZBelnsABR7iE
 3iW+IL3GfoFEXvCkMzFx20TXXaHVt5UmrBY5J80dHcRYWE8NE+i4avvXEYtqy+DCl4W0FEuKYb+
 RvSXrUr7sykjSOnuq8KdjES6reiC6jteDahC6ecv4+hEpw7uOlSRlodGUUK0ew2EQ/7IO3hXpuh
 5m00qSOkt173Rl+N/QM2npnxqKOCopIfK40hkiN3f3MrG+IuQ9+5R7JXZrs2LLo8ypRcMR9m
X-Proofpoint-GUID: JsiCfdE5k5lBoYffx4TqkK-xC04M5z1O

Just a ping on the man page stuff - you will do that right? :>)

Probably best at end of 6.18 cycle when this is about to go to Linus.

I can give you some details on how that all works if it'd be helpful.

On Wed, Jul 30, 2025 at 08:42:04PM +0100, Usama Arif wrote:
> >> Acked-by: Usama Arif <usamaarif642@gmail.com>
> >> Tested-by: Usama Arif <usamaarif642@gmail.com>
[snip]
> >> Signed-off-by: David Hildenbrand <david@redhat.com>

All looks good aside from nits, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> >> +/*
> >> + * Check whether THPs are explicitly disabled for this VMA, for example,
> >> + * through madvise or prctl.
> >> + */
> >>  static inline bool vma_thp_disabled(struct vm_area_struct *vma,
> >>  		vm_flags_t vm_flags)
> >>  {
> >> +	/* Are THPs disabled for this VMA? */
> >> +	if (vm_flags & VM_NOHUGEPAGE)
> >> +		return true;
>
> VM_NOHUGEPAGE will cause the THP being disabled here.
>
> >> +	/* Are THPs disabled for all VMAs in the whole process? */
> >> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
> >> +		return true;
> >>  	/*
> >> -	 * Explicitly disabled through madvise or prctl, or some
> >> -	 * architectures may disable THP for some mappings, for
> >> -	 * example, s390 kvm.
> >> +	 * Are THPs disabled only for VMAs where we didn't get an explicit
> >> +	 * advise to use them?
> >>  	 */
> >> -	return (vm_flags & VM_NOHUGEPAGE) ||
> >> -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
> >> +	if (vm_flags & VM_HUGEPAGE)
> >> +		return false;
> >
> > Hm is this correct? This means that VM_NOHUGEPAGE no longer results in THP being
> > disabled here no?
>
> Lorenzo, pointed to VM_NOHUGEPAGE case above.>

Haha doh! OK cool, obviously I did this review a little too late in the day
when Mr. Brain was not on best form :P

All good, thanks!

And of course this now enforces the 'except advised' logic below it.

> >> +/*
> >> + * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
> >> + * VM_HUGEPAGE).
> >> + */
> >> +# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
> >
> > NO space after # please.
> >
>
> I think this is following the file convention, the space is there in other flags
> all over this file. I dont like the space as well.

Yeah yuck. It's not a big deal, but ideally I'd prefer us to be sane even
if the rest of the header is less so here.

>
> >>  #define PR_GET_THP_DISABLE	42
> >>
> >>  /*
> >> diff --git a/kernel/sys.c b/kernel/sys.c
> >> index b153fb345ada..b87d0acaab0b 100644
> >> --- a/kernel/sys.c
> >> +++ b/kernel/sys.c
> >> @@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
> >>  	return sizeof(mm->saved_auxv);
> >>  }
> >>
> >> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
> >> +				 unsigned long arg4, unsigned long arg5)
> >> +{
> >> +	unsigned long *mm_flags = &current->mm->flags;
> >> +
> >> +	if (arg2 || arg3 || arg4 || arg5)
> >> +		return -EINVAL;
> >> +
> >
> > Can we have a comment here about what we're doing below re: the return
> > value?
> >
>
> Do you mean add returning 1 for MMF_DISABLE_THP_COMPLETELY and 3 for MMF_DISABLE_THP_EXCEPT_ADVISED?

Well more so something about we return essentially flags indicating what is
enabled or not, if bit 0 is set then it's disabled, if bit 1 is set then
it's that with the exception of VM_HUGEPAGE VMAs.

>
> I will add it in next revision.

Thanks!

