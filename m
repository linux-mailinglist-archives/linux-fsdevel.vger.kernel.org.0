Return-Path: <linux-fsdevel+bounces-41060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFEAA2A751
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332DC188A15E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5492147E4;
	Thu,  6 Feb 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vh65X7np";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YZdv8pUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EF46BF;
	Thu,  6 Feb 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738840904; cv=fail; b=mv9rSQ6g6yLKxD6zrTZixHFeDXdl0gDwlb7K4BeTnbDTFS2K1Iq/3NDc0mkjgLSbaOAns/I9PTTq+TQ0/j1aAkoyvGbGRpHTRL3fyE25V7c/swxZfZf1sRl6z6D31Bbpsj0FvXSjcUUxpLPdJM9sT6EE1T7Z2txaUalCb0jGVJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738840904; c=relaxed/simple;
	bh=cmNWq95VuOEY+gZHS6VVOciOp4fD+NnmOB53de0TQe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ENr/OIJLSg/9awz8jUAIQoHk+LV0/rSWUIKRZZITpsYyC/SVfB4YMtRP4DHbo3dEZF9P8X6fKuXOD8BYesSPYuZ6nrdn2zEVF3ohC3B7X3K5R1djscl/Q4xOv7IGrjbWjZ+oyIha29Ip4eR2ZCdDZAppdkvLft0RGd4AnpmRkS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vh65X7np; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YZdv8pUz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161gLhH025971;
	Thu, 6 Feb 2025 11:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PN8/izZ4gTc5vsquAC4eyahCGIV5FeDP7USoUeUpl4U=; b=
	Vh65X7npaW0QOVHAmY6oAkk33+JN/H05Mkqt3QyEpwcuSvZx4iu61iioWZuVj/ZA
	vijLDFusw9nxHkP2MASDnzxsQQ+KNNjM6mQit1M5mw/sqBGf44E8qu97E18K6dTJ
	XCz0liDYLbGxhSO2/jZMIvpsVvPWjSZLuR7mgyYiYagH++FJMbtNQBWYj7d8hNkH
	cCpGZRV6f9hQ0GRerVowE5jOhk+28JIQT7i1FV7FjBsR1q2hmzmhPkDuewn1wOcm
	s2rsrac/mBzafVsNI4wVbTaKtr5+3VtCdmBRG/J1lb2pvRBUGzIs3u93wDlQJnf2
	B5NiPHIzkOlwymZhxppY3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbth57m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 11:21:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5169esCd027932;
	Thu, 6 Feb 2025 11:21:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p5pq8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 11:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFNMwEUE6dCf//DZQQ1Nw/F1brGo25Ci9spIF/O2EwSkqbIH2x8Oz6jfkRR/SJ8Ytt+iBp62uKXUQ9o1n690vlXNqqgmdr6sW0WbSRA8rg7sGBUQlMOOwXYc2EE30tBVsCKHysl8QahGS99S9ZVQvMf8k9K8xEyU8FvI7CRpyW/P3qISC/YhvERThQXAEBPM1Skx9t4w1PPk0wO6E0ueM/67oqc9CeVTOdyZgO7Podi6gau5RA6jmqmb2EqyF7HDRAGQLukNoMeSErS6UeYuRE2epXAkh/5PVxOXCc4eZIq7Ptd7VIWoMQ0bdzSaLu3UixHbLvrAYIbBux4t3N/4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN8/izZ4gTc5vsquAC4eyahCGIV5FeDP7USoUeUpl4U=;
 b=dBhQ6fErSzI7kOA3dDGirxDg0WHPWTG5Fj8SkX6rp7TwCQsuKOn2LXl84C+sMlnZ0Uhbi81lI56K3yWdBsdPrsBpkmjvFPH6FQcYdNKN87sUr/doDFCETmA6WsZZfkP3DkIZIiijISkRq74NCH+NaEYQUQtRaplwhYzu6a5DcnzkRZrQaFQMCh/jQa1j9lMRmOmn+uojL+p4MxwCbnPcKh8nt9gkx7IcFndBdZ4DC0y1nS02oi7Z/o97V7mMUm9/Twgb2m4vj2AmN5baLdVLob36Fgz3p1GtBgSAgOdsjXOm8LCc5n6l89rXW3kXcO/1JLyU1+oJn5rZ82oHnNTVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN8/izZ4gTc5vsquAC4eyahCGIV5FeDP7USoUeUpl4U=;
 b=YZdv8pUzJg+o+eaIhPVIeFuoE7KLLxW2oqfjOB/zBAz4DhqgM3kF+75tdJcxpJM8z8sI7j/GLBJ7w4AXSFivCxZ7ozLcZI8g9PuRqrFFzLnZd3iK7T6oVBiSV0MHzICKSePt9ZflvE3aQ08iAbNyJC0GbFmSYEk9C6AFpR9TN1U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5596.namprd10.prod.outlook.com (2603:10b6:510:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 11:21:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 11:21:18 +0000
Message-ID: <6ad6f42a-e3e0-4c13-859c-07f5e7bd5ec8@oracle.com>
Date: Thu, 6 Feb 2025 11:21:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/10] iomap: Support CoW-based atomic writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-4-john.g.garry@oracle.com>
 <20250205201107.GA21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250205201107.GA21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: b7144d5b-53ea-4301-3267-08dd46a06028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzhndHA4L3pGQnUvVjJpYThyWEhBbkZCU041RytVYVV5aWJNRjltNUgrMlFS?=
 =?utf-8?B?bStuNDIrYVpYSDZ6M1N0REFVZ0s3Zll3NFVHdlNzVElEVmcwVWJDWU5NQWlW?=
 =?utf-8?B?aWRDZFVtd01QUmlUcjlWWVJKalNlNWFILytjeW9xck9nQTM2SE1VbklFa2NV?=
 =?utf-8?B?ZnJzUkhQcUJRTGNxR1VVaVoyN082bmxWMStETkI5QkJiMXVtQ2VuSHc3SXR0?=
 =?utf-8?B?a0hjMEdNOGxaNDdtMHdZS0tyaGJzN3l0elYxeTlncFZ5WFpaY1pEOVpMSnUx?=
 =?utf-8?B?S0l5RFNIT2JkTnI3bjY5NCtzcWl6cVl5c2ZveFl5dU5KcTVxLzRNckdhNGpi?=
 =?utf-8?B?UGxZVWpOWG1INEhLRnpZUUl3Z05NcXVPRURwOFladjJKQ1k5bDhsWjJwL0dR?=
 =?utf-8?B?NzZ2RXN5ZEZtS3hnNDVyVUIvZDdmQWpaMGREUFJBVXhYeGpvbHZ4MURlc2xZ?=
 =?utf-8?B?YnhrcldKOFhtbk5aOTcyM0cxY1dnM2RNUlJaWHdVeDhYcXVScFBIT0FvSmxV?=
 =?utf-8?B?dnRJTGs2NXdsRXpsNDEzQnNoUXFQZWx4NXU1MGQ1Ly9GRkwwUG5wNHY4RW0r?=
 =?utf-8?B?N296ZTR1cmNBMFRhL1FYWTZoenk3RkNYRGdPZHhnWlQ0eHN1c2hpMDVReEUx?=
 =?utf-8?B?S0dERHJRKzJDT21XM29PVGM0UDRLbEFjL1p4MUJ5NHljcW1uQVdFMlFsMGFh?=
 =?utf-8?B?Qm1uZGVuTERucWdnYmxmT3JaejRJMUxOaWNqaEIxSmRnSFE4dWI0UXJ2YzFU?=
 =?utf-8?B?dlBuU3hjUklEMFVtc090R2U3WFB1V3l0UFBOcThsRmVlM1pGYThkbFFuSUxi?=
 =?utf-8?B?R0p4OGcwVGxCUmNpa21oTmdGb0hFR2VuTUU3WHpPenRycFFFVkMrUlM5Tm8r?=
 =?utf-8?B?dUY0YzFwSXFtQmVDL2RaOWxXNitqMTdxdVJCZ2VFYlRVNVdrUzNRNDZyZHBY?=
 =?utf-8?B?Z0d2bDRrR1JjVVR1U2NoQVFscEpnR0FlODd6MUdOa1dhMDlNSHluKzhmcUlv?=
 =?utf-8?B?OVA4SEd3Rkx6ekgxOE5IdklidGxTTk1OU2JGRVB4STRUYm41N2FCS0lVbW41?=
 =?utf-8?B?MkhXcU1kMEx0Y25LOEZXUy9pTkNGdUVNZUg3TTlJdUJoeUlYcU5OTGVkeDhw?=
 =?utf-8?B?Vng2TU91T1RrN0xUai9QWDNybWZGYStCSms2NVVKRWRJTEZmcmRmUHhRay9W?=
 =?utf-8?B?UFQzLyszTGh4SGhKMm5obUJTZWRORjgrdFc4SGJ6SFhneGhoNGhrYXllYUpW?=
 =?utf-8?B?WXFMRkJDWFZvbWFyd0tTTFZUUmpYNzF0UGppQWsycThGYUorZXJud2psY0xB?=
 =?utf-8?B?OUdSWWZLNnVNN0JvMUlHbE9xSEFqOElGSjg3ZVZtUi95TFc1WjlBenlwRXhJ?=
 =?utf-8?B?SWNKQXljZWV1Q21vZk5VSGUxeFJKNTFLdzlMTUV6ai9qbVg0RDJsSGVIQWVs?=
 =?utf-8?B?T1ZUT0NGenhGTTQxL3Mydm5ScVRSU0dJOWFzdGpucXJCU1Vtc213OVVzK2xF?=
 =?utf-8?B?ckcvRW11SnZSbFQwQWo2ZkJmemxnNjd4eEFhSUZqa05tYVlGTXlpWTQ4dlMy?=
 =?utf-8?B?ZE83MngvYVpOZFdBRnJlRmhNczJEMVZINkQ0RlFtaitWWWFGMld0K0hkVE8z?=
 =?utf-8?B?Mm5YaGVOT2l1VEpObjVVSFlSLzgvZFY4R1FHSWZ4MWNIb0FaZ2FYNXVZRm16?=
 =?utf-8?B?MjZYN1ZVb0FxWXNBdXZQQUwrWFBGNVNzMlRGc3FZWHM5S0lIOEgwNWQ0MTdn?=
 =?utf-8?B?NGR1QmY3WEx3MVhvbEdsczlQd0lhVzMvaDdBR3NGZnYzSW9xODZVWmxTRFRt?=
 =?utf-8?B?eHJvNHpCQzJ1S0MxeitYTDl6eU5ycjhNMldycWhKRUF5c0VXSVhpWjVqcVk5?=
 =?utf-8?Q?ch/Bw+KQ0Ud72?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVl5WStFSk5FNTVueGo2ZFlZRzk3Q3lCZlIza0h5cytabU9mM3NlVXZUektT?=
 =?utf-8?B?d0NObHg0VjBYNmNwZVEvQ2IyVGZ2QTNYZFVsTHRwd24xWmRERTlxSUtraGFx?=
 =?utf-8?B?UWNZRjJCdytNMEM1NWJrVnRpc0JxVHhVQUNGWm0rRDNlVi9ZclhUMldpWFJk?=
 =?utf-8?B?NmhtWEtXZ2lkL3h3OStYY043Tk5mVEhEUmJ4aFV4QjE2NEFNVzRoTTBWVHM2?=
 =?utf-8?B?VDJWSjZuMjZXVExkSk1SQllndU5Zanljc3BZZHYxSng4bTduR2VXaFpnUFN0?=
 =?utf-8?B?emRUc0ozbkhtcit3ai9qZ1RrQWlZWSt1RFB0LzVFTTlYcnNPMUw0OGlqMXdW?=
 =?utf-8?B?bG9LajhrbU9lWXZCUkxBaElNajNuQ09ZNDVmQjZCWXhBVEpQaytZRnBIdzF1?=
 =?utf-8?B?d2hCT1Q4aW94L2Q4RmZTMUZuek5IcllxRUFjNHRNcUJveGFyZmN1bml2aXJY?=
 =?utf-8?B?MUdmQjdZcWdMMmE3RzZ3ZEFIM3REOEtkWFdFaHJUZWo5L0JiYzVJTFpjQk4x?=
 =?utf-8?B?NnE5dzlxN2o3RTd5bUZoTDRjbWkrNllOaHhZOEZBSlFPUXFZL0hGQ0liaERk?=
 =?utf-8?B?dHFlbVN6a2ZKb0t2c25YYkpGdm91MlVmSStRQU9oUEtCTHQ2UmVpMUYxVHhv?=
 =?utf-8?B?dzdxWFo3OGMzcEtRZ3pwZlowc202NFNsNFY2UG5rMTc1QWpxdVZEbHYrQnJQ?=
 =?utf-8?B?L3lRQStpcmpxQUxnOElKaU9wK3VIVlBPSU4vTWVRMm9Ka0F1eGE5WDhla1lR?=
 =?utf-8?B?d1ZwZEZJUGJqK2hhN1JHczg3L1p3N0VxMDNNdGZmWUFET1hzRWpuREQ2TXZ6?=
 =?utf-8?B?MzNGRk5TNFVwT2JLTU5hYzF5YTB6Q293V01HNjN4aXVZc0ZNeFJtcmdOa1N3?=
 =?utf-8?B?WTBBemROamVaVVd1RFpXSWY5bnkzbW9DSERHSC9xdTlxNlVxYll5bXl4cHVp?=
 =?utf-8?B?WHJ4UStIc1h2cXovTVM5ZGZjNmpZOGJLYXpKR2dyVzNzUmNYWndYdzVmbVRG?=
 =?utf-8?B?QzEzMXgzYVBhVnN3V1liazFJR25VUGFMMXBvd0ViMWlqRXRkT3hKTExxSDJE?=
 =?utf-8?B?WDJMU1g1L0g1NURyRkhiemF3VUwxaG16MVRqQi9ONDdUWU1CM0dia2xKUUdw?=
 =?utf-8?B?NXhINGphOEVLYm1pVCtJZGFMNWljaDU3Z1ozeUVCdDJCL1QrS05iVFFFOUZ6?=
 =?utf-8?B?NTZpYTFqY3lhNWZ5bnJsaW4wcmJ0OGl0ckxvL2kxYmJwa2RtcG1Ea1RERFdw?=
 =?utf-8?B?UWhoVnlOdkVzdzF6VzdoVHRzZVQ4WTdOL3hlUDRtWmFFVnpqQmg4MUNxUGdo?=
 =?utf-8?B?NlNVckZ4U1p1VDY2WXk2dVNyOUl6cHdXc1hScldvRTcyZUg1eHQ2UEU4UFlP?=
 =?utf-8?B?VTVtL1dESE1DNHkxMWhmNTBNRWxqdHNDZkxHRXdvdFhRZU1UTTdjcUpiRHpw?=
 =?utf-8?B?UTBSVHNmTTFvOFUxSTlqWjlWSVBLNXZCc2VqQXByWk5jNHF5S0pkZ0dqZGxP?=
 =?utf-8?B?Vnd6eENnc1lDWVdsdmNBQ3NiNVR1UnR3WnI0OFNjZHUweStlQldUbTBaT25z?=
 =?utf-8?B?WlQzVmtBZzBFZU5leHV1STl0WVJzNjl1aW9VeW9QNmtpTkp5djZ6UFRzcEdK?=
 =?utf-8?B?Wmx1Tm0wYm81alp6NEk0cFI0aExUUlNVN0VhUFhjTkhJYjlXY0JTeVJoYVc3?=
 =?utf-8?B?Mmp5Uzh6VDlwL2FhT2tHQmdWeWlFS2pwWEV6U2d0OFZ2MU1lYkNDZnZrOUJh?=
 =?utf-8?B?OGxJbFpJSlNOdG9VTEQzcjltYm5tYmh2ZHBCN1VUQVFtVjdpaitwTHNzUHhY?=
 =?utf-8?B?SzhaS0cybDlqRWd0a0d1cFQrMVpzQ0RPZENoWGlUNXp2YXY5d0NJaFRJWTdo?=
 =?utf-8?B?Z1JCYUNpVWcxTzU1elJzM0s5TFBjU2cyaHE0K1UycWt6SzBTWkF3Y2hESU8v?=
 =?utf-8?B?U2FVcGRUK0ZpVTg0Y1BpeEtnVExKSEdQc0JaRXJINFFiUm9lVUxpSzVpQ3Jw?=
 =?utf-8?B?UFRmQnJPVmN6VkE4OGg2MHdpbjZPMkYweEdDZlg3QnZzdlc1cHpYQm5pd3Bq?=
 =?utf-8?B?ZGRQSVUvb29PKzQ4d2QzL3BWMzBGem9wZ2ZObFkrL3lCdHhqeElZdGkzNnhp?=
 =?utf-8?B?MEpPWUN0R1ZKVUdSUUNkOGZQZlIrRUQwa2tYRnUxaUgrSUJVV0xjV2wwQ0U3?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T9E+c3kd24BBHAibMFo0ZSaxasTOUShr4TjHas8bHp1Xm+lNf1iD7s7f30LUe4pb8R8m7/1vW7rC5aVaH91GkpYFo7jXMocUe2B4bVwyj7N7/ONhUkmKm9WL4DFDLWzwjzpdLJNaWRyk4gy1ij5eiJOGXz56t9AtNIw9rFxN9UBrbiAA7w3td487T7mRHyIzzOHSp/nS2xl4b4OZrhG5NPWOC+sZ9xbRHPOYvBA84ed7Gjghu5dlqLdEjt0T2R7dXx+19lAwEP5F1riohmhiriZkPl/9UvmGMZQw+ecbaSLnE5zDq694K75BNWYwdKmqglJGUuvWZdiH1OzoG7g08BUH8H/Gn/MsNw//bE2G8DjOp/an2BhuGjKJkY1yYw7mok96RYsxoDPWOMG1wwFNGF5S9LlMhk/WWdQ9YKsD8onhX4xJmFfQ+aMvFFIlgMnNOX1H7eKcwO7TCb+QVg53/RN2236qq6S5BJUHgoINc6IBA0zFGN6JOtW9chIVe8KTII9c453+kbmFRPS3skne0GSUvsDHTcu/nwLS/ymP8T/B3TSS7lIux12d3Ju4osxXqYkMw33bkhgUWGrRRTyTlrPVbAyPmsjDuaNVBacfCes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7144d5b-53ea-4301-3267-08dd46a06028
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 11:21:18.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMQzv5q0ccvdcxNkUgsm8rr+JOJdNoCXlXX5Bdo/552b6nyDvuzJhgQzPoEgeqMtwvirmkwfRvUxc0ZHXAAB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060093
X-Proofpoint-GUID: 1KpqKVmqPyEzk4U2Fwq-e81DSA2x6sul
X-Proofpoint-ORIG-GUID: 1KpqKVmqPyEzk4U2Fwq-e81DSA2x6sul


>>   			if (iomi.pos >= dio->i_size ||
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 75bf54e76f3b..0a0b6798f517 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -56,6 +56,8 @@ struct vm_fault;
>>    *
>>    * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
>>    * never be merged with the mapping before it.
>> + *
>> + * IOMAP_F_ATOMIC_COW indicates that we require atomic CoW end IO handling.
> 
> It more indicates that the filesystem is using copy on write to handle
> an untorn write, and will provide the ioend support necessary to commit
> the remapping atomically, right?

yes, correct

> 
>>    */
>>   #define IOMAP_F_NEW		(1U << 0)
>>   #define IOMAP_F_DIRTY		(1U << 1)
>> @@ -68,6 +70,7 @@ struct vm_fault;
>>   #endif /* CONFIG_BUFFER_HEAD */
>>   #define IOMAP_F_XATTR		(1U << 5)
>>   #define IOMAP_F_BOUNDARY	(1U << 6)
>> +#define IOMAP_F_ATOMIC_COW	(1U << 7)
>>   
>>   /*
>>    * Flags set by the core iomap code during operations:
>> @@ -183,6 +186,7 @@ struct iomap_folio_ops {
>>   #define IOMAP_DAX		0
>>   #endif /* CONFIG_FS_DAX */
>>   #define IOMAP_ATOMIC		(1 << 9)
>> +#define IOMAP_ATOMIC_COW	(1 << 10)
> 
> What does IOMAP_ATOMIC_COW do?  There's no description for it (or for
> IOMAP_ATOMIC). 

I'll add a description for both.

> Can you have IOMAP_ATOMIC and IOMAP_ATOMIC_COW both set?

Yes

> Or are they mutually exclusive?

I am not thinking that it might be neater to have a distinct flag for 
IOMAP_ATOMIC when we want to try an atomic bio - maybe IOMAP_ATOMIC_HW 
or IOMAP_ATOMIC_BIO? And then also IOMAP_DIO_ATOMIC_BIO (in addition to 
IOMAP_DIO_ATOMIC_COW).

> 
> I'm guessing from the code that ATOMIC_COW requires ATOMIC to be set,
> but I wonder why because there's no documentation update in the header
> files or in Documentation/filesystems/iomap/.

Will do.

Thanks,
John

